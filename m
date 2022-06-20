Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB074552630
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345611AbiFTU6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345410AbiFTU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:58:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D11C10C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B41EFB8125A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 20:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18636C3411B;
        Mon, 20 Jun 2022 20:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655758634;
        bh=amNL5hBu8sn0n7Z8DhQo6sxJAIQnP534hLZirq8gRKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+O3zRcSPsojWgjqiFhkA/C+HOp2t4+5MtZS5LPaVjmFIMmHfR/nIVBTxmCXTrtv0
         cmD5ffkav7K/4o8skUTn6aefi6fgJp9Eq/uyog3dLaop2ACc78Au3DFwhAJsjM+d2Y
         QSWiYd4aMJBwW0lyhuodTu0loLxMKtQUiRxcV3Ivc2GN+NsyVkb+b+BrHnEO0njya7
         qpbLFC/b7iZFdxkH9f18GhN9uyPaYKd1doAA3iQhb/hrj370OP9CM9PmKjHVYhxW8R
         mSyivxqMMOa8TCQYf3pZP0p5YpDGhh5lZ6bcMzl0r8qTmI8YOCXt5ghRXhOmGy0Fxh
         Q1RutzfTDtc7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D4974096F; Mon, 20 Jun 2022 17:57:11 -0300 (-03)
Date:   Mon, 20 Jun 2022 17:57:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Fix missing free in copy_kcore_dir()
Message-ID: <YrDfJyV4Ycki9WdO@kernel.org>
References: <20220620103904.7960-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620103904.7960-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 20, 2022 at 01:39:04PM +0300, Adrian Hunter escreveu:
> Free string allocated by asprintf().
> 
> Fixes: d8fc08550929bb ("perf inject: Keep a copy of kcore_dir")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/builtin-inject.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 42e2918fd1cc..fee9da14afc6 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -891,7 +891,9 @@ static int copy_kcore_dir(struct perf_inject *inject)
>  	if (ret < 0)
>  		return ret;
>  	pr_debug("%s\n", cmd);
> -	return system(cmd);
> +	ret = system(cmd);
> +	free(cmd);
> +	return ret;
>  }
>  
>  static int output_fd(struct perf_inject *inject)
> -- 
> 2.25.1

-- 

- Arnaldo
