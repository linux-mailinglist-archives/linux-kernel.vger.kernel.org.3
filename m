Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E9658F3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHJVHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:07:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8B7D1D7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:07:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so134504477b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=ifL9GPwmfZ+gd+ojudcdhsOCIJjlClPiJepJsorw/R0=;
        b=PtApeZmeo4UlCbGZspx1zBpgh+DZDmb+pdg2WFI8RiUnX5Zcdbe2hfnJRFbx5PTEod
         w3CfATViQB0rMmbRzJDa4XRNf/5ORzQL0iQs+MecMLiPbB3y+yRKFb/27vrRKk+aUbNV
         X16cgj/x6WBtOpez3yWPFoAwdIyYS9JnXTec8eQdid3sYKUqizVLNmZuhEF+LdeB55iT
         GS4+4PyxHprFFxRb7rDG+8LjILhQruF/ehqilk7WM5npv1MvAIOYNi+eeQxMDsJY0b35
         VRjGUtHQSWadLzHttD9u4EI++1NYeDDPmR4XZrk0ZTAILzvjnqfEG2JhVTfaQ7mdSciT
         Mndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=ifL9GPwmfZ+gd+ojudcdhsOCIJjlClPiJepJsorw/R0=;
        b=w0dYW+aeqZSrhsyiDzjBOzvVdtUP3hxLwC2MsJOACsUIgIayECkHKlHU1bK/RlZ6ka
         DpN97nHJ27EdZ8iHPoblMps+9xUKwk52yiesPOsLSc9hKRcTsyz/ZAGaXabZPMxfPCsO
         iYz+zVbecqtmAzhhPYIR4c1rtAg6Ul+n/3xNcHOAzLL7RmTMxS3/73a4OLN/mUEsaoQD
         2G9yA8bdIicbIF5PI4fCxpCsg6/i4bF0CJTRd98XrLKFAyWYQG62ZtYtYubMXoRXyZKk
         iQMdU5AzbZpWNMgSHnRYyzFJagQhGtSUrEvpFPfPtnloGwvVnd7l9aOESzCoURoQclu2
         tBZA==
X-Gm-Message-State: ACgBeo1eFQnZW4tIv5PNf4h0XJJzO90wI5qgMhlRTx3cpHKymGaJL33k
        AO9Ro1sRawCq00qb60P2apWK5ApZV7KNzLDCQXJ8Kh/65MmOc+BIlVJzPfi1ERexzu3aZtP0rby
        5TXxQ1oKHuXldezoA7RMDXl95w4betRe/loS5t30AOiU4gULP30eBpqUCLeBwjxyovYWxkFYe
X-Google-Smtp-Source: AA6agR6MDKwJ6s0NKo5oIg+L/UKqajJPxvkDm9g1nIDm4rABUXXQTg07LTUgQzXiL+UHdZ1DssTdRhXhKTrl
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:cb0e:2b65:2f16:1db1])
 (user=eranian job=sendgmr) by 2002:a05:6902:701:b0:678:9bcc:e8c6 with SMTP id
 k1-20020a056902070100b006789bcce8c6mr27278511ybt.120.1660165630693; Wed, 10
 Aug 2022 14:07:10 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:06:56 -0700
Message-Id: <20220810210656.2799243-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] perf/x86/intel/lbr: fix branch type encoding
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        acme@redhat.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With architected LBR, the procesosr can record the type of each sampled taken
branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.

The branch type must then extracted and saved in the perf_branch_entry in the
perf_events sampling buffer. With the current code, the raw Intel encoding of
the branch is exported to user tools. Yet tools, such as perf, expected the
branch type to be encoded using perf_events branch type enum
(see tools/perf/util/branch.c). As a result of the discrepancy, the output of
perf report -D shows bogus branch types.

Fix the problem by converting the Intel raw encoding into the perf_events
branch type enum values. With that in place and with no changes to the tools,
the branch types are now reported properly.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4f70fb6c2c1e..ef63d4d46b50 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
 
-static __always_inline int get_lbr_br_type(u64 info)
+/*
+ * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
+ * as per Intel SDM Vol3b Branch Types section
+ */
+static const int arch_lbr_type_map[]={
+	[0] = PERF_BR_COND,
+	[1] = PERF_BR_IND,
+	[2] = PERF_BR_UNCOND,
+	[3] = PERF_BR_IND_CALL,
+	[4] = PERF_BR_CALL,
+	[5] = PERF_BR_RET,
+};
+#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
+
+static __always_inline u16 get_lbr_br_type(u64 info)
 {
-	int type = 0;
+	u16 type = 0;
 
 	if (static_branch_likely(&x86_lbr_type))
 		type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
@@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
 	return type;
 }
 
+/*
+ * The kernel cannot expose raw Intel branch type encodings because they are
+ * not generic. Instead, the function below  maps the encoding to the
+ * perf_events user visible branch types.
+ */
+static __always_inline int get_lbr_br_type_mapping(u64 info)
+{
+	if (static_branch_likely(&x86_lbr_type)) {
+		u16 raw_type = get_lbr_br_type(info);
+		if (raw_type < ARCH_LBR_TYPE_COUNT)
+			return arch_lbr_type_map[raw_type];
+	}
+	return PERF_BR_UNKNOWN;
+}
+
 static __always_inline bool get_lbr_mispred(u64 info)
 {
 	bool mispred = 0;
@@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->in_tx	= !!(info & LBR_INFO_IN_TX);
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
-		e->type		= get_lbr_br_type(info);
+		e->type		= get_lbr_br_type_mapping(info);
 	}
 
 	cpuc->lbr_stack.nr = i;
-- 
2.37.1.559.g78731f0fdb-goog

