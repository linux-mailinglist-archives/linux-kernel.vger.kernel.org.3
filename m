Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F424A7D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiBCCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiBCCAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:00:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A927C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 18:00:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jx6so3410381ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 18:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lxWBwGKgTWaFZT5siy9MmYF0wpXs3bDIfO+VSmkVhOs=;
        b=VrvDepaPiHZBFur4A33iJd7uY8YvKRz8K13whFn26G2dh3BG1TB1GYdcf4fivbkGM+
         FhAZ9/s8ZI3gSAug+BEPoRid87hyp1BFgDfwqFASb80T9nG180nndYiQ/JsQ8f7ThMlf
         2EOuSaRUI1q/wqV5PFXKWQnyt9NfSRvM8YuSzzgM/xrXsAi4WQqWmUxHXrmmsHBqimJ9
         GzGQfT7B4m1bfBCuXYu9Q4VApQ7mRu5gXgbwvKEjT7X4CXLavN0xx7f1LKqYaWaFtWGz
         KpSiNQKz2MoVBo9+81J5QxFkLHOnPvKMHZL5hoh336V5VfvFwt2cEPdKBspMsQ9fVhux
         XYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lxWBwGKgTWaFZT5siy9MmYF0wpXs3bDIfO+VSmkVhOs=;
        b=HbaNoGfxSpZmY1k2SW7sOJByQr3ZsN36El/VV2s1cfVc9Mzgq5gzHpQT8n8Qjppcl8
         i3qkF6b0pzYyPdz4fBg1ddoE4Po1OAM4/vk3Kl8xIi0yzYPtWx5A29/1BjTpk2GcWLDH
         njQkaSOH3pSFv/PASHT0S38g4rGMKvCAR/6fzlLqpJWbSb2c2HSfkWUlIiQKxAjcD7Xe
         p1Va+e4FWvTmMG0qR1SD4dvR0WezCjQSYHevveASdRq2N5cW2H/mfpLpZxPHy4H6mT6A
         F27ul2qqvmsGKsxWBbYJYnWqfDI3qy9baEMQUkleM+Qp1ijRVoEDmR9JWGqNlQ7rhes6
         R1dw==
X-Gm-Message-State: AOAM531Awu5MTyInh+JgxDMNz1NE6g4aFisXUDrl9lCOKFrJl7InMrAD
        Zkeuc1W0/mM+/O09rqduQ1c=
X-Google-Smtp-Source: ABdhPJzvG6IRe7QL1vHJcF2neabtJs69d92CVoL8a7zGs/RBvP33L1IALDJyeVmzuBgEl4AeTKEn+Q==
X-Received: by 2002:a17:907:c20:: with SMTP id ga32mr27273669ejc.638.1643853630831;
        Wed, 02 Feb 2022 18:00:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id rv28sm15884487ejb.71.2022.02.02.18.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Feb 2022 18:00:30 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, mhocko@suse.com,
        mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/page_alloc: add zone to zonelist if populated
Date:   Thu,  3 Feb 2022 02:00:22 +0000
Message-Id: <20220203020022.3044-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During memory hotplug, when online/offline a zone, we need to rebuild
the zonelist for all nodes. Current behavior would lose a valid zone in
zonelist since only pick up managed_zone.

There are two cases for a zone with memory but still !managed.

  * all pages were allocated via memblock
  * all pages were taken by ballooning / virtio-mem

This state maybe temporary, since both of them may release some memory.
Then it end up with a managed zone not in zonelist.

This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
and reclaim from zones with pages managed by the buddy allocator")'.
This patch restore the behavior.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mel Gorman <mgorman@techsingularity.net>
CC: David Hildenbrand <david@redhat.com>
Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index de15021a2887..b433a57ee76f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6092,7 +6092,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
 	do {
 		zone_type--;
 		zone = pgdat->node_zones + zone_type;
-		if (managed_zone(zone)) {
+		if (populated_zone(zone)) {
 			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
 			check_highest_zone(zone_type);
 		}
-- 
2.33.1

