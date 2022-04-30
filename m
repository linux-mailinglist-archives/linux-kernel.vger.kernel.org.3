Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2923515EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382941AbiD3PfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiD3PfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D872E0F;
        Sat, 30 Apr 2022 08:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A28D60FBA;
        Sat, 30 Apr 2022 15:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D99C385A7;
        Sat, 30 Apr 2022 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651332715;
        bh=bkpBO54CETXc5ylwdi1D95/G1qzBSfIfrcbSVBsBCnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njsW+DT2YHfa253qra7yMjmBIRNhanVX0itFO8no9EiasQNnrkvWPZ+KSoaOJrraX
         zrbro2QFN1GMpr2qNI7EdpLZ7Z8hPIizc2sXh0ak6v6w3mmuDRDbm+YaMwfdVKOWre
         I5gx7vdQFk3N71Zv+t96vXOBXMeFruXHFtOYN8TWUID0wW1CWK6KmmvViSlY9qTPQV
         49ea+sjgyf4X5zYRrbJElfFrEzECKM1vAvbLLjUWU2+Yqfb50z2b8pm845j/y6hb2x
         JL4sR4PcQK3IZlBAPkW4UlcPpeyghVso6JUdjdkhou0BQH3b46Bp5sy8ZVRyu1fn6o
         9i6i9/f9URy3g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 773A3400B1; Sat, 30 Apr 2022 12:31:53 -0300 (-03)
Date:   Sat, 30 Apr 2022 12:31:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: make util/data.h self-contained
Message-ID: <Ym1WaannQyQ+Fn3C@kernel.org>
References: <20220429090539.212448-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429090539.212448-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 29, 2022 at 05:05:39PM +0800, Yang Jihong escreveu:
> struct perf_data in util/data.h uses "u64" data type, which is defined in
> "linux/types.h". If only include util/data.h, following compilation error
> occur:
> 
> util/data.h:38:3: error: unknown type name ‘u64’
>    u64    version;
>    ^~~
> 
> Solution: include "linux/types.h." to resolve self-contained issues

Thanks, applied.

- Arnaldo

 
> Fixes: 258031c017c35 (perf header: Add DIR_FORMAT feature to describe directory data)
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/util/data.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index c9de82af5584..1402d9657ef2 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -4,6 +4,7 @@
>  
>  #include <stdio.h>
>  #include <stdbool.h>
> +#include <linux/types.h>
>  
>  enum perf_data_mode {
>  	PERF_DATA_MODE_WRITE,
> -- 
> 2.30.GIT

-- 

- Arnaldo
