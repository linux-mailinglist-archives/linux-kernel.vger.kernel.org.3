Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C5D5702FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiGKMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiGKMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:30 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275243C8DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657542496; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=d9jlwf2JduepAUH0sP5MVHxLsoRxqYD2zVBYKAyqOCrDGaIgIww8ZN60Ke5MlhVsrzfUaQ2eIIxKEk12xqZvw3+xwABssGIZS/XbfnFQt4TCJGWGWYbNNkvPYn0wolsnVKnqygo1CZ2KUFr1gNUmsVBoGII4AGDGQ7h/iH/HwbU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657542496; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nNMEZ/IULIqFkQZN/oBrcmZXnBPShQJWnrZceFIU7hk=; 
        b=gA37RdDjMuGem70uRtqv1PDGFxctWfJodDZlIWpRWTJeFO9OkNhb3Gd4PeYqTdNUSlZ3q/f2uuIwvijb1BbEQekeqU1iLVnrKg67QDYGqop69TywVMtKVzqDyIMWmzcEFlntGgG8RXJEhitDFlYg53IVFY3bNn8ap2PUJuucakc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657542496;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=nNMEZ/IULIqFkQZN/oBrcmZXnBPShQJWnrZceFIU7hk=;
        b=KrYo66Fvw84KWCAXvugb8MTWVK3cvnzI/YA9ujEKbC98ESaZwaOvHO0GXEbOMRiA
        BpF3GRKM/9dGBv3L14VlJ6NOF4KdgKbBkWVC8OvJdNV1wvSH1XcuuAicOHqR8lK8TlG
        PCzKIOnsOEY45R6iD7bsj0wBT8ORA5vXRpvmRxNA=
Received: from sh-lchen.ambarella.net (180.169.129.130 [180.169.129.130]) by mx.zohomail.com
        with SMTPS id 1657542495481198.279413668139; Mon, 11 Jul 2022 05:28:15 -0700 (PDT)
From:   Li Chen <me@linux.beauty>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/4] mm/sparse: skip no-map memblock check when fill_subsection_map
Date:   Mon, 11 Jul 2022 20:24:52 +0800
Message-Id: <20220711122459.13773-3-me@linux.beauty>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711122459.13773-1-me@linux.beauty>
References: <20220711122459.13773-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

When mhp use sparse_add_section, don't check no-map region,
so that to allow no-map reserved memory to get struct page
support.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: I0d2673cec1b66adf695251037a00c240976b226f
---
 mm/sparse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 120bc8ea5293..a29cd1e7014f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -690,7 +690,9 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
 	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
 		rc = -EINVAL;
-	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
+	else if (memblock_is_map_memory(PFN_PHYS(pfn)) &&
+		 bitmap_intersects(map, subsection_map,
+				   SUBSECTIONS_PER_SECTION))
 		rc = -EEXIST;
 	else
 		bitmap_or(subsection_map, map, subsection_map,
-- 
2.25.1

