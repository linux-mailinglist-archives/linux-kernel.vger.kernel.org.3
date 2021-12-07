Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537F846AFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354712AbhLGB1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:27:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54256 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352037AbhLGB1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:27:14 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB854CE198F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 01:23:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6DC460E09;
        Tue,  7 Dec 2021 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638840222;
        bh=jG8jLRpDxgN2xvF5ecWxhh9KjD9YifxAcaT6H/zTPVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WS8/GJmkzTqLpQGK3js6E3UYS/N8YQexO2PLCCaYPNV/CFkfl1KfYuyNW2O+wUfTV
         /Fe+Ivf2yUuv6lBlMyRowe7/Fo3c+6H+YKDaI3ihT3RbX1SDQ2/ozPsJp9cPRySRjA
         +b0bulQdTuqHmt2azMFxCfTM7BND10cTuMlt0G/4=
Date:   Mon, 6 Dec 2021 17:23:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] mm: mask DIRECT_RECLAIM in kswapd
Message-Id: <20211206172340.fded3873aed7e853b54ab276@linux-foundation.org>
In-Reply-To: <1638760762-27239-1-git-send-email-huangzhaoyang@gmail.com>
References: <1638760762-27239-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Dec 2021 11:19:22 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> As the eg bellowing, using GFP_KERNEL could confuse the registered .releasepage
> or .shrinker functions when called in kswapd and have them acting wrongly.Mask
> __GFP_DIRECT_RECLAIM in kswapd.
> 
> eg,
> kswapd
>   shrink_page_list
>     try_to_release_page
>       __fscache_maybe_release_page
> 	...
>          if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
>                  fscache_stat(&fscache_n_store_vmscan_busy);
>                  return false;
>          }

Well, we have thus far been permitting kswapd's memory allocations to
enter direct reclaim.  Forbidding that kernel-wide might be the right
thing to do, or might not be.  But disabling it kernel-wide because of
a peculiar hack in fscache is not good justification.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4083,7 +4083,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	bool boosted;
>  	struct zone *zone;
>  	struct scan_control sc = {
> -		.gfp_mask = GFP_KERNEL,
> +		.gfp_mask = GFP_KERNEL & ~__GFP_DIRECT_RECLAIM,
>  		.order = order,
>  		.may_unmap = 1,
>  	};

Maybe hack the hack like this?

--- a/fs/fscache/page.c~a
+++ a/fs/fscache/page.c
@@ -126,8 +126,10 @@ page_busy:
 	 * sleeping on memory allocation, so we may need to impose a timeout
 	 * too. */
 	if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS)) {
-		fscache_stat(&fscache_n_store_vmscan_busy);
-		return false;
+		if (!current_is_kswapd()) {
+			fscache_stat(&fscache_n_store_vmscan_busy);
+			return false;
+		}
 	}
 
 	fscache_stat(&fscache_n_store_vmscan_wait);
_

But please, do cc the fscache mailing list and maintainer when mucking
with these things.
