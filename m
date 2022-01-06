Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED964486251
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiAFJq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:46:56 -0500
Received: from outbound-smtp59.blacknight.com ([46.22.136.243]:52611 "EHLO
        outbound-smtp59.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237370AbiAFJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:46:53 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp59.blacknight.com (Postfix) with ESMTPS id 9DFB1FABFE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:46:51 +0000 (GMT)
Received: (qmail 11001 invoked from network); 6 Jan 2022 09:46:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jan 2022 09:46:51 -0000
Date:   Thu, 6 Jan 2022 09:46:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     skseofh@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: no need to double-check if free pages are
 under high-watermark
Message-ID: <20220106094650.GX3366@techsingularity.net>
References: <20220102033129.12913-1-skseofh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220102033129.12913-1-skseofh@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 12:31:29PM +0900, skseofh@gmail.com wrote:
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
> 
> Signed-off-by: Daero Lee <skseofh@gmail.com>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 700434db5735..1217ecec5bbb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4331,7 +4331,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	/*
>  	 * Return the order kswapd stopped reclaiming at as
>  	 * prepare_kswapd_sleep() takes it into account. If another caller
> -	 * entered the allocator slow path while kswapd was awake, order will
> +	 * entered the allqocator slow path while kswapd was awake, order will
>  	 * remain at the higher level.
>  	 */
>  	return sc.order;

This hunk just adds a typo, drop it.

> @@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
>  static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
>  				unsigned int highest_zoneidx)
>  {
> -	long remaining = 0;
> +	long remaining = ~0;
>  	DEFINE_WAIT(wait);
>  
>  	if (freezing(current) || kthread_should_stop())

While this does avoid calling prepare_kswapd_sleep() twice if the pgdat
is balanced on the first try, it then does not restore the vmstat
thresholds and doesn't call schedul() for kswapd to go to sleep.

I think you did spot a problem but I suspect you want something like
the following untested patch

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 700434db5735..40784693c840 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4355,7 +4355,8 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
 				unsigned int highest_zoneidx)
 {
-	long remaining = 0;
+	long remaining;
+	bool balanced;
 	DEFINE_WAIT(wait);
 
 	if (freezing(current) || kthread_should_stop())
@@ -4370,7 +4371,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	 * eligible zone balanced that it's also unlikely that compaction will
 	 * succeed.
 	 */
-	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	balanced = prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx);
+	if (balanced) {
 		/*
 		 * Compaction records what page blocks it recently failed to
 		 * isolate pages from and skips them in the future scanning.
@@ -4387,6 +4389,10 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 
 		remaining = schedule_timeout(HZ/10);
 
+		/* Is pgdat balanced after a short sleep? */
+		balanced = prepare_kswapd_sleep(pgdat, reclaim_order,
+							highest_zoneidx);
+
 		/*
 		 * If woken prematurely then reset kswapd_highest_zoneidx and
 		 * order. The values will either be from a wakeup request or
@@ -4406,11 +4412,11 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 	}
 
 	/*
-	 * After a short sleep, check if it was a premature sleep. If not, then
-	 * go fully to sleep until explicitly woken up.
+	 * If balanced to the high watermark, restore vmstat thresholds and
+	 * kswapd goes to sleep. If kswapd remains awake, account whether
+	 * the low or high watermark was hit quickly.
 	 */
-	if (!remaining &&
-	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
+	if (balanced) {
 		trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
 
 		/*
