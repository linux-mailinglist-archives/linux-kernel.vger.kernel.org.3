Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1C485D02
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiAFARL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:17:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46810 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbiAFARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:17:09 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F192061990
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:17:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3524E60E9C;
        Thu,  6 Jan 2022 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641428228;
        bh=bBatHOpdNSaaESTIT2TeqAUEVF3cTHVp4THfZpdxJVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UkjF2UpuXgFhRDP86iYGb0F4DACratLWx4P7peG5mDqn/7kqwqQQMd6XP7E0vfzKl
         3w6/tfI+GDWJ4h1wqexP5aKHF/su0wv+x4FjyuRWCZ5uMoAGjZFdZjt9i5mwEIEunG
         IKG6vWaMVOO3CEOjh365P3jbKgLaUR6pzSe4/lf4=
Date:   Wed, 5 Jan 2022 16:17:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     skseofh@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
Message-Id: <20220105161706.625b7b58d79eddaf38567568@linux-foundation.org>
In-Reply-To: <20220102033129.12913-1-skseofh@gmail.com>
References: <20220102033129.12913-1-skseofh@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Jan 2022 12:31:29 +0900 skseofh@gmail.com wrote:

> From: Daero Lee <skseofh@gmail.com>
> 
> In kswapd_try_to_sleep function, to check whether kswapd can sleep,
> the prepare_kswapd_sleep function is called twice.
> 
> If free pages are below high-watermark in the first call,
> the @remaining variable is not updated at 0 and the
> prepare_kswapd_sleep function is called for the second time.
> 
> I think it is necessary to set the initial value of the
> @remaining to a non-zero value to prevent consecutive calls
> to the same function.

Seems right.  Mel & Joonsoo, could you please check?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4331,7 +4331,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	/*
>  	 * Return the order kswapd stopped reclaiming at as
>  	 * prepare_kswapd_sleep() takes it into account. If another caller
> -	 * entered the allocator slow path while kswapd was awake, order will
> +	 * entered the allqocator slow path while kswapd was awake, order will

whoops.

>  	 * remain at the higher level.
>  	 */
>  	return sc.order;
> @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
>  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
>  				unsigned int highest_zoneidx)
>  {
> -	long remaining = 0;
> +	long remaining = ~0;
>  	DEFINE_WAIT(wait);
>  
>  	if (freezing(current) || kthread_should_stop())

