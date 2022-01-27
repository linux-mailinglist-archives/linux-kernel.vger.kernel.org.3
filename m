Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372A549D76D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiA0BUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiA0BUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:20:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:20:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l5so1529292edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=elzTyLMca2pvBYgTWQkNCYxxJD3xd3Z07gwcpc0mZtg=;
        b=KhzTbfhlLCq7WoRZGIlVP2DWwdbNn8huwiVIEymR5ot3XAei7DWDavfibE2uqvBynt
         VwAblbIyC1TAAY7NNPiWWIswT6tpHI/p20XwfTFb2NSk2X9tCFKTbmCA/9jiRAJsDSpx
         5noVlLG5D3zSE6TuKW2YgDDm2p+WK2gn3rYd4wyl6X1byv8HT8noGwmQXStOFfusghyC
         Mi5I9Hsgasbhq4ryOk5ZP1+blHerBXCGMirm5iFwV/a928QkHwhXs+JZ1nBwH7bZMKy8
         aGLMwVG30fPujmctdeq1UblZKed22fC42zl5bdDVA9cT0bXqS0sEYLgFOIJ67LzBBEcS
         rXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=elzTyLMca2pvBYgTWQkNCYxxJD3xd3Z07gwcpc0mZtg=;
        b=GX4QDiHld5f3leJMSzRCESrhPttOWTHN4CD96sGdm7THo5FRGVp7LadsWYtR7qQmT5
         DL9AFkeLHlJehElIuaGrX9wo24wAKxLwpWtX6/pR7SfWb/2r85P8hQghTkLXCstRSWYf
         XuZODYzh2274zETrzDn5iaTu8Ywijd5NTNDJFQ1oxMl6QwhLBWTIUeKUTynqvEH8CUxG
         b6Qc2s0DCjB75hJVpuK0g6UGacUVJTrqNO7jZz6Z2+4nvjVdv1SB3vyMiQDnqbCJaSfw
         AICfQ3WExs14OSlXE9nBZ5vcuStB7F0Iv3Hxo6HDpVJAwuqDRKY7KDRktGNMG0Mtj2VC
         FjFA==
X-Gm-Message-State: AOAM530PAK2Q84sUbpkHkt0AR5pFFIyn96wuc6EDG/heyR6tLfRYCCd3
        8iwh0VQa958eagZ1a8Mty44=
X-Google-Smtp-Source: ABdhPJxei5y/VVo7zaV2Lm4x0kqN1JeLqWTk6B3KNkWX512WC3+wql8dOVc78jaL5emQGyaPdU5ZBQ==
X-Received: by 2002:a05:6402:11c7:: with SMTP id j7mr1485069edw.139.1643246435430;
        Wed, 26 Jan 2022 17:20:35 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id by22sm8057957ejb.84.2022.01.26.17.20.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jan 2022 17:20:35 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Date:   Thu, 27 Jan 2022 01:20:23 +0000
Message-Id: <20220127012023.18095-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During memory hotplug, when online/offline a zone, we need to rebuild
the zonelist for all node. There are two checks to decide whether a zone
would be added to zonelist:

  * one in online_pages/offline_pages to decide necessity
  * one in build_zonerefs_node to do real add

Currently we use different criteria at these two places, which is
different from the original behavior.

Originally during memory hotplug, zonelist is re-built when zone hasn't
been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
wait_table and zonelist initializing for memory hotadd: update zonelists")'.
And at that moment, build_zonelists_node() also use populated_zone() to
decide whether the zone should be added to zonelist.

While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
from zones with pages managed by the buddy allocator")',
build_zonelists_node() changed to use managed_zone() to add zonelist.
But we still use populated_zone() to decide the necessity.

This patch restore the original behavior by using the same criteria to
add a zone in zonelist during memory hotplug.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
CC: Mel Gorman <mgorman@techsingularity.net>
---
 mm/memory_hotplug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a9627dc784c..8f1906b33937 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1102,11 +1102,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/*
-	 * If this zone is not populated, then it is not in zonelist.
+	 * If this zone is not managed, then it is not in zonelist.
 	 * This means the page allocator ignores this zone.
 	 * So, zonelist must be updated after online.
 	 */
-	if (!populated_zone(zone)) {
+	if (!managed_zone(zone)) {
 		need_zonelists_rebuild = 1;
 		setup_zone_pageset(zone);
 	}
@@ -1985,7 +1985,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	if (!populated_zone(zone)) {
+	if (!managed_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	}
-- 
2.33.1

