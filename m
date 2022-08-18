Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85233597E33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbiHRFq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiHRFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:46:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F223182867
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:46:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33580e26058so11055117b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=FqHrexOcC+gfHSPyDulU6tO7Ix4yfoB2lhcVRcSb+yA=;
        b=FS/fxQo4O03RF0/0Pz2SiuIDzDnGfAhjJ+Ht3871yIRkFoqYkgcjglXdB8szfZgmf6
         dZzheOtR9aSehZsoqPuUdNADBPTKJXeMmDuDzy2ghA+q6V0OBy5wrlRTcBV+JvWuaKKM
         gHolL9KEqjAytpLKWLxEdA8PompbQchmqiFq9tK/41ySD2l+dpLU1Yg5nM/egFgO9GGc
         hRyF+FWNP6i5xZX0nFsNXtqeMk5UI/uwZVJujGrJ/ZzjD3cT1+vky7JuSr34n1+DIeXi
         pSxV7tQnb3WGlR4EN2OwEXfb+N04sc0YInzx1uCtdrPdXyCF2OBSCeIouuy/XORNab6K
         WooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=FqHrexOcC+gfHSPyDulU6tO7Ix4yfoB2lhcVRcSb+yA=;
        b=l9BdjT2eTSSLzh8SDgW5kArqSVFroiPAzWgvZ6XhYpijAgGeA2a0X7GNEZYeDlV+d9
         MJaslxmgsbh8ApaZYO/oceQLScFPr6k1BlWwYLDjRzCMzVQB1Dt7K1X7pWP4hlNimt9U
         mCUFMXZLUPUM6hxQhYemSZQ9qgrvtOhgawMajz/53CHQPPFZM3jTO9FqXGiQfbL7C0pC
         jG8axzqTxsw14LIwYJD7Bu8nkzTV+DHMCp/LmvkHa1fXuQf4XjaR8AXbt4DuGrH8r4OX
         kQVKCCZDFD1patZuIaR8lHg9heP5q7FuzZ22YEyJTxSn6cvpf0FM+lFFdpZQUxNRwtBS
         rhGg==
X-Gm-Message-State: ACgBeo30NImyMaHJvnkd398TS25Hstdp8GXBIl4L+77mzYTQWgzsNwNW
        8zpo/BM0eNFDEWHIdGvPvaDzFm3eC8S3Ft8dYbmhfL7T/UcZsksF7vP7bceMdyAjI1RxXQ+TtL8
        14WMXiylxQd6pjtN/bmAsn3z8GEaPYvDmbScJNK55CkBnSpbHrDOvghSMJXd1LIGqcFCLMTCG
X-Google-Smtp-Source: AA6agR6Jky9aZFZxK9tOjb8bv9Lz1KU7h7qvKJ1ji/q8hfuTQ5FOCREQH9HTr9t7/2H8hhW8E/6Y+DTnTcZd
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2d4:203:6d6c:33e1:a81b:4500])
 (user=eranian job=sendgmr) by 2002:a25:b094:0:b0:67c:38f2:2360 with SMTP id
 f20-20020a25b094000000b0067c38f22360mr1422631ybj.637.1660801583185; Wed, 17
 Aug 2022 22:46:23 -0700 (PDT)
Date:   Wed, 17 Aug 2022 22:46:13 -0700
Message-Id: <20220818054613.1548130-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] perf/x86/intel/ds: fix precise store latency handling
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

With the existing code in store_latency_data(), the memory operation (mem_op)
returned to the user is always OP_LOAD where in fact, it should be OP_STORE.
This comes from the fact that the function is simply grabbing the information
from a data source map which covers only load accesses. Intel 12th gen CPU
offers precise store sampling that captures both the data source and latency.
Therefore it can use the data source mapping table but must override the
memory operation to reflect stores instead of loads.

Fixes: 61b985e3e775 ("perf/x86/intel: Add perf core PMU support for Sapphire Rapids")

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/ds.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427caa6d..189fc6e9ea65 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -291,6 +291,7 @@ static u64 load_latency_data(struct perf_event *event, u64 status)
 static u64 store_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
 	u64 val;
 
 	dse.val = status;
@@ -304,7 +305,14 @@ static u64 store_latency_data(struct perf_event *event, u64 status)
 
 	val |= P(BLK, NA);
 
-	return val;
+	/*
+	 * the pebs_data_source table is only for loads
+	 * so override the mem_op to say STORE instead
+	 */
+	src.val = val;
+	src.mem_op = P(OP,STORE);
+
+	return src.val;
 }
 
 struct pebs_record_core {
-- 
2.37.1.595.g718a3a8f04-goog

