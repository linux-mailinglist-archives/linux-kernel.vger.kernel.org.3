Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F464D0DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiCHBxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbiCHBxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0EA33D49D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646704323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YigIe8c8hOAKKacESi+Zjw0uljbvggEbAvpckywstDg=;
        b=XD6Vcz1BRv0K3AARSaAPNDalz/439VHwqdi5NUFO6ywZ7U1GkWz26bKqvVRBofA52TFh5W
        5UPydltfuOxtK59BgaZtSUDfg0MKjMqcPbQKshMR27ZfTkIkagJuiDHulyn2WK8vUGBfQe
        7Y3frG1m1QqPC85z/WNofbwd6eQ/U/s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-sioJkvY0PqGhpy1wUQ2M6A-1; Mon, 07 Mar 2022 20:52:02 -0500
X-MC-Unique: sioJkvY0PqGhpy1wUQ2M6A-1
Received: by mail-oo1-f72.google.com with SMTP id j3-20020a4a92c3000000b00319481d8795so12885396ooh.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YigIe8c8hOAKKacESi+Zjw0uljbvggEbAvpckywstDg=;
        b=GnGjviw30w1K1kVrxbcErWUxZ8gf2TnljIMIxtbJfITgrTvXV/RY1O5LK0zD6iRn5b
         oW081pVyjA0+q5sl3VtbqRQFnU8b+qrQSnGn7+VlipFd/bCYgurV2jpdIdCAE7TjyqCh
         V2laafq6eqHfa/z0BI1I3RcZmjtJm38K6o3AQSrkUnnXQLBNNnBsNC+Nbz41n/TS5ilq
         93lZ1CX7vxW4edI1hMygoVm5+mMT6iC/m8O2a63kuUIchpqMKNUzMT+SZDBoA1V23HIX
         d33ek6BPFyt7btq/Jodb3og0BJF+FXnH4ne2yeh/cGMGcqMBEP6fVe+YYXpwPh81ioyr
         KbYQ==
X-Gm-Message-State: AOAM5306hwutS+U+1KmfcDK3arm4WHVMwFew24nnjRLnSWuDWEKYhCQe
        D5gS+2B3zvJgra3Eub1I3Pv8xIweQsBgTA7pOrsXSTuEijK+oER8/9ONf5lTmw+3R8lEyfiKimJ
        k/Q/011lCw3BPUAIDVqRxiOe4
X-Received: by 2002:a05:6870:339f:b0:da:b3f:2b19 with SMTP id w31-20020a056870339f00b000da0b3f2b19mr1126253oae.184.1646704321771;
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrMmwqQe+R36LQN0jd/vWIKxh3lTAUPdo6YjsPlvXNKtxY4xyc9myjGWqQMMSKayQXrzOAuQ==
X-Received: by 2002:a05:6870:339f:b0:da:b3f:2b19 with SMTP id w31-20020a056870339f00b000da0b3f2b19mr1126244oae.184.1646704321573;
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id ds3-20020a0568705b0300b000d9c70e5275sm5183853oab.54.2022.03.07.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:52:01 -0800 (PST)
From:   trix@redhat.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] perf/x86: cleanup comments
Date:   Mon,  7 Mar 2022 17:51:48 -0800
Message-Id: <20220308015148.924521-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

For spdx, // for *.c

Replacements
certan to certain
fecthes to fetches
funning to running
dont to don't

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/x86/events/amd/core.c               | 2 +-
 arch/x86/events/core.c                   | 2 +-
 arch/x86/events/intel/p4.c               | 2 +-
 arch/x86/events/intel/uncore.c           | 2 +-
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c5..aec3a6134f745 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -81,7 +81,7 @@ static __initconst const u64 amd_hw_cache_event_ids
  },
  [ C(ITLB) ] = {
 	[ C(OP_READ) ] = {
-		[ C(RESULT_ACCESS) ] = 0x0080, /* Instruction fecthes        */
+		[ C(RESULT_ACCESS) ] = 0x0080, /* Instruction fetches        */
 		[ C(RESULT_MISS)   ] = 0x0385, /* L1_ITLB_AND_L2_ITLB_MISS.ALL */
 	},
 	[ C(OP_WRITE) ] = {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d3..0b05317d3fc91 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1416,7 +1416,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 		wrmsrl(x86_pmu_event_addr(idx + 1), 0xffff);
 
 	/*
-	 * Due to erratum on certan cpu we need
+	 * Due to erratum on certain cpu we need
 	 * a second write to be sure the register
 	 * is updated properly
 	 */
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 7951a5dc73b63..e21c7e1684933 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -960,7 +960,7 @@ static void __p4_pmu_enable_event(struct perf_event *event)
 	escr_addr = bind->escr_msr[thread];
 
 	/*
-	 * - we dont support cascaded counters yet
+	 * - we don't support cascaded counters yet
 	 * - and counter 1 is broken (erratum)
 	 */
 	WARN_ON_ONCE(p4_is_event_cascaded(hwc->config));
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9bf4270..79bfc87f2939e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -573,7 +573,7 @@ int uncore_pmu_event_add(struct perf_event *event, int flags)
 		return -ENODEV;
 
 	/*
-	 * The free funning counter is assigned in event_init().
+	 * The free running counter is assigned in event_init().
 	 * The free running counter event and free running counter
 	 * are 1:1 mapped. It doesn't need to be tracked in event_list.
 	 */
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 5fd72d4b8bbb0..955d5a48554da 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Support Intel uncore PerfMon discovery mechanism.
  * Copyright(c) 2021 Intel Corporation.
-- 
2.26.3

