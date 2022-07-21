Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688B457D3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiGUTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiGUTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216287F7C;
        Thu, 21 Jul 2022 12:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E3196205F;
        Thu, 21 Jul 2022 19:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A91C3411E;
        Thu, 21 Jul 2022 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658430585;
        bh=YF/PF6Ter5l5o1g58BKuMC8G0ycP/xLQJAJPqr4aaKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pxdh8fS3/+I/EFbny6MsRattmw+KCcBjvoLGr80FU5tsDqtv3I5ypyVvE6wpjVrYn
         En4Y2AI9Zr8iQCRorgZuabPsySyEwocQlRp+qYta8bmQRqvelcjIWZvtcuRBqv7IPf
         /dzFBsFdpnp6KOijU5MRlVTpfwrj/U12BouRbccwoPtwdUXSFU6BTo3rSzxRpUb/xL
         9GWnpbslxd6HA05lTOIiQZwnWIhloE2B+22UbL8PswBwlaAcDGuNPVDboDhltTleVI
         +UZaZU2FZgzQ19kuzBRyeX3QpUVFjkz/FakYK2oL+TBkJK5QRdB2OIimd4Px3mBCMh
         Cx4jaQuZK2Dfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 44E3040374; Thu, 21 Jul 2022 16:09:43 -0300 (-03)
Date:   Thu, 21 Jul 2022 16:09:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/6] perf lock: Fix a copy-n-paste bug
Message-ID: <Ytmkd8uAwS7WqfGn@kernel.org>
References: <20220721043644.153718-1-namhyung@kernel.org>
 <20220721043644.153718-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721043644.153718-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 20, 2022 at 09:36:39PM -0700, Namhyung Kim escreveu:
> It should be lock_text_end instead of _start.
> 
> Fixes: 0d2997f750d1 ("perf lock: Look up callchain for the contended locks")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Got this first one procesed, pushed out toa acme/perf/core, please take
a look at the other patches.

- Arnaldo

> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index c5ca34741561..0aae88fdf93a 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -892,7 +892,7 @@ static bool is_lock_function(u64 addr)
>  		sym = machine__find_kernel_symbol_by_name(machine,
>  							  "__lock_text_end",
>  							  &kmap);
> -		lock_text_start = kmap->unmap_ip(kmap, sym->start);
> +		lock_text_end = kmap->unmap_ip(kmap, sym->start);
>  	}
>  
>  	/* failed to get kernel symbols */
> -- 
> 2.37.0.170.g444d1eabd0-goog

-- 

- Arnaldo
