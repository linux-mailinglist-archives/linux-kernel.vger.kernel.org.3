Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4B465BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 02:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbhLBBsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 20:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbhLBBsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 20:48:45 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B18C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:45:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u80so26440752pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 17:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68/oH6xjuwodIMQV/2NyC8ioNzzWw3TJyy8AFCRkIZE=;
        b=XERpWANUrTZ5nk5hIJg10Wqf9OjzhJ7Ex6etIV2TOkg9gKEA++LlxovgNLynIJRYCx
         lP9E/u1tFKakQfMLeHhiSJbD9HJDjJBmcIwZhtY2Rzfgs8lOUBk0g/uAe6hrV4GxEXVa
         ujCJptO3BEc9pd5cGu39DWkF46H7SUpK66AJqbT3b5yhKPn0dZ2yIghl7LieP5zIj7MR
         KglfPwcJdsuFYHuwg0QIxn49LYOrMZeZVkg3xMDobHWPs1iDxH0sjMyAVBXPwdpJsQht
         3rN55jrBFywsqCFo/2m0dAjW/MG/U0n3fzD5FmHIWY1BbTC7WmwFP6iH7Ch1ZeEdaC7F
         4yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68/oH6xjuwodIMQV/2NyC8ioNzzWw3TJyy8AFCRkIZE=;
        b=naMQHPe8jbkHNlDjLzTwW6WZCWEY16nij8dc5G12AvaeGTX8L46UrRFqU18rGCqhRd
         XB8JqIJTSp6JFBZtSYnykOOd8NF4vUnGop7lFHOaRWWnKaP2uxaskxTHOl5pYheZrnvW
         V4/YT8wrej7T1EzLRS5Ehc+74i9pcGDCkloTmF2MZ9MNG7tnzrneFh4vCtccanvuerNx
         aDs4xEaSAXoCaIUOJE6eK54GNJxU0uP5KyxZIYuT8WWMDx5tS6khReyTCDX3zzOvRE8Z
         T6VQoL2+YWcPUO3NQ/Y+SmoJkbIScoY2uPiq4uA8FQcuHJ3UETuHjFzK51so6QZK90LI
         dyAQ==
X-Gm-Message-State: AOAM531uv8XjVQkns9a2vS6bo1gQL2SZKo8g75bE3oUI1DCKqtZiMwPi
        F6Tioh3AWmElaR28nfIev0leRKdsOFZ0yecu
X-Google-Smtp-Source: ABdhPJwGstttWJ5CsaCuJR7g2FdaLJR/G0YB7syEw0Xhm4Gx3nLjReVKodWo2epzds9na2OaSxDqaA==
X-Received: by 2002:a63:90c8:: with SMTP id a191mr7234885pge.482.1638409522860;
        Wed, 01 Dec 2021 17:45:22 -0800 (PST)
Received: from fedora.ba.rivosinc.com (99-13-229-45.lightspeed.snjsca.sbcglobal.net. [99.13.229.45])
        by smtp.gmail.com with ESMTPSA id s16sm1069082pfu.109.2021.12.01.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 17:45:22 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Atish Patra <atishp@rivosinc.com>, anup.patel@wdc.com
Subject: [PATCH v4] lib: pmu: support the event ID encoded by a bitmap.
Date:   Wed,  1 Dec 2021 17:45:17 -0800
Message-Id: <20211202014517.1888248-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

RISC-V privilege specification does not specify how to encode the event ID.
Therefore, each platform is allowed to customize its own encoding rule.
The common encoding methods are as follow, directly assigning a number to an
event, or every bit in the mphmevent CSR controls one specified event or
mixes the above two methods.

To enable OpenSBI to support the above three encoding methods simultaneously,
this patch repurpose the dt property "riscv,raw-event-to-mhpmcounters". The
"riscv,raw-event-to-mhpmcounters" will describes the one or multiple raw
events that could be counted by a set of counters. But, the column number
of "riscv,raw-event-to-mhpmcounters" is extended from 2 to 3. The 1st column
(64bit) is the ID of the raw events. The 2nd column (64bit) represents a
select_mask now to represent the bits used for event ID encoding.
If a platform directly encodes each raw PMU event as a unique ID,
the value of select_mask will be 0xffffffff_ffffffff.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Atish Patra<atishp@rivosinc.com>
---
Changes from v3->v4:
1. Fixed few instances of pmu prefix.
2. Improved the DT property description.
3. Simplified *find_hw implementation by just masking the selector_mask to
   event_data and comparing it with the select value.
4. Dropped the reviewed by recieved in PATCH 3 as the selector/mask scheme
   is changed in this patch.

Changes from v2->v3:
1. Rebased on top of the master which changed the dt property prefix to riscv.
2. Fixed typos.
---
---
 docs/pmu_support.md     | 24 ++++++++++++++++--------
 include/sbi/sbi_pmu.h   |  2 +-
 lib/sbi/sbi_pmu.c       | 35 ++++++++++++++++++++++++-----------
 lib/utils/fdt/fdt_pmu.c | 16 +++++++++-------
 4 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/docs/pmu_support.md b/docs/pmu_support.md
index a60b75cf9efa..b9803f643593 100644
--- a/docs/pmu_support.md
+++ b/docs/pmu_support.md
@@ -50,12 +50,20 @@ event-to-mhpmevent is present. Otherwise, it can be omitted. This property
 shouldn't encode any raw event.
 
 * **riscv,raw-event-to-mhpmcounters**(Optional) - It represents an ONE-to-MANY
-mapping between a raw event and all the MHPMCOUNTERx in a bitmap format that can
-be used to monitor that raw event. The information is encoded in a table format
-where each raw represent a specific raw event. The first column stores the
-expected event selector value that should be encoded in the expected value to be
-written in MHPMEVENTx. The second column stores a bitmap of all the MHPMCOUNTERx
-that can be used for monitoring the specified event.
+or MANY-to-MANY mapping between the raw event(s) and all the MHPMCOUNTERx in
+a bitmap format that can be used to monitor that raw event, which depends on
+how the platform encodes the monitor events. Currently, only the following three
+encoding methods are supported, encoding each event as a number, using a bitmap
+to encode monitor events, and mixing the previous two methods. The information
+is encoded in a table format where each row represent the specific raw event(s).
+The first column represents a 64-bit selector value which can indicate an
+monitor event ID (encoded by a number) or an event set (encoded by a bitmap).
+In case of the latter, the lower bits used to encode a set of events should be
+set to zero. The second column is a 64-bit selector mask where any bits used
+for event encoding will be cleared. If a platform directly encodes each raw PMU
+event as a unique ID, the value of select_mask will be 0xffffffff_ffffffff. 
+The third column represent a bitmap of all the MHPMCOUNTERx that can be used for
+monitoring the specified event(s).
 
 *Note:* A platform may choose to provide the mapping between event & counters
 via platform hooks rather than the device tree.
@@ -72,8 +80,8 @@ pmu {
 						  <0x00002 0x00002 0x00000004>,
 						  <0x00003 0x0000A 0x00000ff8>,
 						  <0x10000 0x10033 0x000ff000>,
-	riscv,raw-event-to-mhpmcounters 	= <0x0000 0x0002 0x00000f8>,
-					  <0x0000 0x0003 0x00000ff0>,
+	riscv,raw-event-to-mhpmcounters = <0x0000     0x0002 0xffffffff 0xffffffff 0x00000f8>,
+					  <0xffffffff 0xfffffff0 0xffffffff 0xfffffff0 0x00000ff0>,
 };
 
 ```
diff --git a/include/sbi/sbi_pmu.h b/include/sbi/sbi_pmu.h
index f0185566cd6d..6a1c62ccfbef 100644
--- a/include/sbi/sbi_pmu.h
+++ b/include/sbi/sbi_pmu.h
@@ -51,7 +51,7 @@ int sbi_pmu_add_hw_event_counter_map(u32 eidx_start, u32 eidx_end, u32 cmap);
  * @return 0 on success, error otherwise.
  */
 
-int sbi_pmu_add_raw_event_counter_map(uint64_t select, u32 cmap);
+int sbi_pmu_add_raw_event_counter_map(uint64_t select, uint64_t select_mask, u32 cmap);
 
 int sbi_pmu_ctr_read(uint32_t cidx, unsigned long *cval);
 
diff --git a/lib/sbi/sbi_pmu.c b/lib/sbi/sbi_pmu.c
index 5950a2001637..10668a358cb2 100644
--- a/lib/sbi/sbi_pmu.c
+++ b/lib/sbi/sbi_pmu.c
@@ -21,8 +21,16 @@ struct sbi_pmu_hw_event {
 	uint32_t counters;
 	uint32_t start_idx;
 	uint32_t end_idx;
-	/* Event selector value used only for raw events */
+	/* Event selector value used only for raw events. The event select value
+	 * can be a even id or a selector value for set of events encoded in few
+	 * bits. In case latter, the bits used for encoding of the events should
+	 * be zeroed out in the select value.
+	 */
 	uint64_t select;
+	 /**
+	  * The select_mask indicates which bits are encoded for the event(s).
+	  */
+	uint64_t select_mask;
 };
 
 /** Representation of a firmware event */
@@ -91,9 +99,9 @@ static bool pmu_event_range_overlap(struct sbi_pmu_hw_event *evtA,
 }
 
 static bool pmu_event_select_overlap(struct sbi_pmu_hw_event *evt,
-				     uint64_t select_val)
+				     uint64_t select_val, uint64_t select_mask)
 {
-	if (evt->select == select_val)
+	if ((evt->select == select_val) && (evt->select_mask == select_mask))
 		return TRUE;
 
 	return FALSE;
@@ -168,7 +176,7 @@ int sbi_pmu_ctr_read(uint32_t cidx, unsigned long *cval)
 }
 
 static int pmu_add_hw_event_map(u32 eidx_start, u32 eidx_end, u32 cmap,
-				uint64_t select)
+				uint64_t select, uint64_t select_mask)
 {
 	int i = 0;
 	bool is_overlap;
@@ -191,13 +199,15 @@ static int pmu_add_hw_event_map(u32 eidx_start, u32 eidx_end, u32 cmap,
 	for (i = 0; i < num_hw_events; i++) {
 		if (eidx_start == SBI_PMU_EVENT_RAW_IDX)
 		/* All raw events have same event idx. Just do sanity check on select */
-			is_overlap = pmu_event_select_overlap(&hw_event_map[i], select);
+			is_overlap = pmu_event_select_overlap(&hw_event_map[i],
+							      select, select_mask);
 		else
 			is_overlap = pmu_event_range_overlap(&hw_event_map[i], event);
 		if (is_overlap)
 			goto reset_event;
 	}
 
+	event->select_mask = select_mask;
 	event->counters = cmap;
 	event->select = select;
 	num_hw_events++;
@@ -221,13 +231,13 @@ int sbi_pmu_add_hw_event_counter_map(u32 eidx_start, u32 eidx_end, u32 cmap)
 	     eidx_end == SBI_PMU_EVENT_RAW_IDX)
 		return SBI_EINVAL;
 
-	return pmu_add_hw_event_map(eidx_start, eidx_end, cmap, 0);
+	return pmu_add_hw_event_map(eidx_start, eidx_end, cmap, 0, 0);
 }
 
-int sbi_pmu_add_raw_event_counter_map(uint64_t select, u32 cmap)
+int sbi_pmu_add_raw_event_counter_map(uint64_t select, uint64_t select_mask, u32 cmap)
 {
 	return pmu_add_hw_event_map(SBI_PMU_EVENT_RAW_IDX,
-				    SBI_PMU_EVENT_RAW_IDX, cmap, select);
+				    SBI_PMU_EVENT_RAW_IDX, cmap, select, select_mask);
 }
 
 static int pmu_ctr_enable_irq_hw(int ctr_idx)
@@ -514,9 +524,13 @@ static int pmu_ctr_find_hw(unsigned long cbase, unsigned long cmask, unsigned lo
 			continue;
 
 		/* For raw events, event data is used as the select value */
-		if ((event_idx == SBI_PMU_EVENT_RAW_IDX) && temp->select != data)
-			continue;
+		if (event_idx == SBI_PMU_EVENT_RAW_IDX) {
+			uint64_t select_mask = temp->select_mask;
 
+			/* The non-event map bits of data should match the selector */
+			if (temp->select != (data & select_mask))
+				continue;
+		}
 		/* Fixed counters should not be part of the search */
 		ctr_mask = temp->counters & (cmask << cbase) &
 			   (~SBI_PMU_FIXED_CTR_MASK);
@@ -546,7 +560,6 @@ static int pmu_ctr_find_hw(unsigned long cbase, unsigned long cmask, unsigned lo
 		else
 			return SBI_EFAIL;
 	}
-
 	ret = pmu_update_hw_mhpmevent(temp, ctr_idx, flags, event_idx, data);
 
 	if (!ret)
diff --git a/lib/utils/fdt/fdt_pmu.c b/lib/utils/fdt/fdt_pmu.c
index 529ee420554f..a2b048f0ab29 100644
--- a/lib/utils/fdt/fdt_pmu.c
+++ b/lib/utils/fdt/fdt_pmu.c
@@ -65,7 +65,7 @@ int fdt_pmu_setup(void *fdt)
 	const u32 *event_val;
 	const u32 *event_ctr_map;
 	struct fdt_pmu_hw_event_select *event;
-	uint64_t raw_selector;
+	uint64_t raw_selector, select_mask;
 	u32 event_idx_start, event_idx_end, ctr_map;
 
 	if (!fdt)
@@ -99,14 +99,16 @@ int fdt_pmu_setup(void *fdt)
 	}
 
 	event_val = fdt_getprop(fdt, pmu_offset, "riscv,raw-event-to-mhpmcounters", &len);
-	if (!event_val || len < 8)
+	if (!event_val || len < 20)
 		return SBI_EFAIL;
-	len = len / (sizeof(u32) * 3);
+	len = len / (sizeof(u32) * 5);
 	for (i = 0; i < len; i++) {
-		raw_selector = fdt32_to_cpu(event_val[3 * i]);
-		raw_selector = (raw_selector << 32) | fdt32_to_cpu(event_val[3 * i + 1]);
-		ctr_map = fdt32_to_cpu(event_val[3 * i + 2]);
-		result = sbi_pmu_add_raw_event_counter_map(raw_selector, ctr_map);
+		raw_selector = fdt32_to_cpu(event_val[5 * i]);
+		raw_selector = (raw_selector << 32) | fdt32_to_cpu(event_val[5 * i + 1]);
+		select_mask = fdt32_to_cpu(event_val[5 * i + 2]);
+		select_mask = (select_mask  << 32) | fdt32_to_cpu(event_val[5 * i + 3]);
+		ctr_map = fdt32_to_cpu(event_val[5 * i + 4]);
+		result = sbi_pmu_add_raw_event_counter_map(raw_selector, select_mask, ctr_map);
 		if (!result)
 			hw_event_count++;
 	}
-- 
2.33.1

