Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68494970B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiAWJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiAWJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:17:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B642C06173B;
        Sun, 23 Jan 2022 01:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23EB760920;
        Sun, 23 Jan 2022 09:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED734C340E2;
        Sun, 23 Jan 2022 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642929436;
        bh=T5B5ekyVJC+CZ64ohYULuUfaqWzSUcjA8KoiSEczAm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wr5iCOtaj1gdnpElkHT3Kfncf7cXEpvQsxYanq9Egt+3Agh92wRlrBu33JC4ddm4z
         cwbj4Aygtz05BIKOdXXLjAfQLMFX2xKKY2kXewv1RzAVVbwshc54b2zLfN9TioCrYJ
         kDbv54jnmng3FzcUUYM6bGEhR066ZxtUsBeOkciMS20yKYcI1up0A3jeDxWGja8nMd
         avOhliGtcC3Olkc25YE5lD1KNMSWOqkE7r+c/SXnl9I1V3Bfa1lhCdT4JQ1GNgMVf3
         B7LAYh8n1X7RKyPETk49a1v9yZyLX9B8CTev9tQEFG+qu4ywcg2hJNUGXlMNuNY7kP
         n6zpejDMLcpYQ==
Date:   Sun, 23 Jan 2022 17:09:36 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH 1/1] sysctl: Fix 'one_thousand' defined but not used
 warning
Message-ID: <Ye0bUGBJWRp+abEF@xhacker>
References: <20220117012317.21168-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220117012317.21168-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 05:23:17PM -0800, Suren Baghdasaryan wrote:
> Fix the following warning issued when CONFIG_PERF_EVENTS is not
> defined:
> 
> kernel/sysctl.c:125:12: warning: 'one_thousand' defined but not used [-Wunused-variable]
> 
> Fixes: 39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  kernel/sysctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ef77be575d87..81a6f2d47f77 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -122,7 +122,9 @@ static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
>  static int one_hundred = 100;
>  static int two_hundred = 200;
> +#ifdef CONFIG_PERF_EVENTS
>  static int one_thousand = 1000;

what about moving one_thousand definition below to group it with
six_hundred_forty_kb var together, so that we can avoid one
#ifdef CONFIG_PERF_EVENTS ... #endif

> +#endif
>  static int three_thousand = 3000;
>  #ifdef CONFIG_PRINTK
>  static int ten_thousand = 10000;
> -- 
> 2.34.1.703.g22d0c6ccf7-goog
> 
