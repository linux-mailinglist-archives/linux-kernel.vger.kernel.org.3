Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0846ED04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhLIQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:29:31 -0500
Received: from outbound-smtp58.blacknight.com ([46.22.136.242]:42265 "EHLO
        outbound-smtp58.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232776AbhLIQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:29:30 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 5F96AFAC36
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:25:56 +0000 (GMT)
Received: (qmail 14075 invoked from network); 9 Dec 2021 16:25:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2021 16:25:56 -0000
Date:   Thu, 9 Dec 2021 16:25:54 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+dcea9eda277e1090b35f@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task can't die in reclaim_throttle
Message-ID: <20211209162554.GO3366@techsingularity.net>
References: <00000000000050185105d2ac05d2@google.com>
 <d0a2acda-c939-73fa-477c-58a2d6bb28f7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d0a2acda-c939-73fa-477c-58a2d6bb28f7@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:51:00PM +0100, Vlastimil Babka wrote:
> On 12/9/21 01:52, syzbot wrote:
> > Hello,
> 
> + CC Mel
> 

Should be fixed shortly in mmotm. Full diff as it stands is

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..936dc0b6c226 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -277,6 +277,7 @@ enum vmscan_throttle_state {
 	VMSCAN_THROTTLE_WRITEBACK,
 	VMSCAN_THROTTLE_ISOLATED,
 	VMSCAN_THROTTLE_NOPROGRESS,
+	VMSCAN_THROTTLE_CONGESTED,
 	NR_VMSCAN_THROTTLE,
 };
 
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index f25a6149d3ba..ca2e9009a651 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -30,12 +30,14 @@
 #define _VMSCAN_THROTTLE_WRITEBACK	(1 << VMSCAN_THROTTLE_WRITEBACK)
 #define _VMSCAN_THROTTLE_ISOLATED	(1 << VMSCAN_THROTTLE_ISOLATED)
 #define _VMSCAN_THROTTLE_NOPROGRESS	(1 << VMSCAN_THROTTLE_NOPROGRESS)
+#define _VMSCAN_THROTTLE_CONGESTED	(1 << VMSCAN_THROTTLE_CONGESTED)
 
 #define show_throttle_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",					\
 		{_VMSCAN_THROTTLE_WRITEBACK,	"VMSCAN_THROTTLE_WRITEBACK"},	\
 		{_VMSCAN_THROTTLE_ISOLATED,	"VMSCAN_THROTTLE_ISOLATED"},	\
-		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"}	\
+		{_VMSCAN_THROTTLE_NOPROGRESS,	"VMSCAN_THROTTLE_NOPROGRESS"},	\
+		{_VMSCAN_THROTTLE_CONGESTED,	"VMSCAN_THROTTLE_CONGESTED"}	\
 		) : "VMSCAN_THROTTLE_NONE"
 
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..700434db5735 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1021,6 +1021,39 @@ static void handle_write_error(struct address_space *mapping,
 	unlock_page(page);
 }
 
+static bool skip_throttle_noprogress(pg_data_t *pgdat)
+{
+	int reclaimable = 0, write_pending = 0;
+	int i;
+
+	/*
+	 * If kswapd is disabled, reschedule if necessary but do not
+	 * throttle as the system is likely near OOM.
+	 */
+	if (pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES)
+		return true;
+
+	/*
+	 * If there are a lot of dirty/writeback pages then do not
+	 * throttle as throttling will occur when the pages cycle
+	 * towards the end of the LRU if still under writeback.
+	 */
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		struct zone *zone = pgdat->node_zones + i;
+
+		if (!populated_zone(zone))
+			continue;
+
+		reclaimable += zone_reclaimable_pages(zone);
+		write_pending += zone_page_state_snapshot(zone,
+						  NR_ZONE_WRITE_PENDING);
+	}
+	if (2 * write_pending <= reclaimable)
+		return true;
+
+	return false;
+}
+
 void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 {
 	wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
@@ -1056,8 +1089,16 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 		}
 
 		break;
+	case VMSCAN_THROTTLE_CONGESTED:
+		fallthrough;
 	case VMSCAN_THROTTLE_NOPROGRESS:
-		timeout = HZ/2;
+		if (skip_throttle_noprogress(pgdat)) {
+			cond_resched();
+			return;
+		}
+
+		timeout = 1;
+
 		break;
 	case VMSCAN_THROTTLE_ISOLATED:
 		timeout = HZ/50;
@@ -3321,7 +3362,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
 	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
-		reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
 
 	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
 				    sc))
@@ -3386,16 +3427,16 @@ static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
 	}
 
 	/*
-	 * Do not throttle kswapd on NOPROGRESS as it will throttle on
-	 * VMSCAN_THROTTLE_WRITEBACK if there are too many pages under
-	 * writeback and marked for immediate reclaim at the tail of
-	 * the LRU.
+	 * Do not throttle kswapd or cgroup reclaim on NOPROGRESS as it will
+	 * throttle on VMSCAN_THROTTLE_WRITEBACK if there are too many pages
+	 * under writeback and marked for immediate reclaim at the tail of the
+	 * LRU.
 	 */
-	if (current_is_kswapd())
+	if (current_is_kswapd() || cgroup_reclaim(sc))
 		return;
 
 	/* Throttle if making no progress at high prioities. */
-	if (sc->priority < DEF_PRIORITY - 2)
+	if (sc->priority == 1 && !sc->nr_reclaimed)
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_NOPROGRESS);
 }
 
@@ -3415,6 +3456,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 	unsigned long nr_soft_scanned;
 	gfp_t orig_mask;
 	pg_data_t *last_pgdat = NULL;
+	pg_data_t *first_pgdat = NULL;
 
 	/*
 	 * If the number of buffer_heads in the machine exceeds the maximum
@@ -3478,14 +3520,19 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 			/* need some check for avoid more shrink_zone() */
 		}
 
+		if (!first_pgdat)
+			first_pgdat = zone->zone_pgdat;
+
 		/* See comment about same check for global reclaim above */
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
 		shrink_node(zone->zone_pgdat, sc);
-		consider_reclaim_throttle(zone->zone_pgdat, sc);
 	}
 
+	if (first_pgdat)
+		consider_reclaim_throttle(first_pgdat, sc);
+
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
 	 * promoted it to __GFP_HIGHMEM.
