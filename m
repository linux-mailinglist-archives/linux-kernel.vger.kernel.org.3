Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A10B595B05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiHPL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiHPL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:58:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB67463FA;
        Tue, 16 Aug 2022 04:41:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o3so8965054ple.5;
        Tue, 16 Aug 2022 04:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=le3D/RH71t/xaxQ2Z6ZJvv8lT0hPbLZVdlFrqGmRQGg=;
        b=YnZbjN1RZaXqUIf35wPu+I84CN3S2qMtNQp+qYVDDPJi+hiHZsKhpi+8DNbLIpYQ/U
         iLZqr4qOGXIbRx3clw5Sz3lRSPDZeVpmRlOw7r6Ps7hEZ9NKJi0bKUFpJEKHp6qiVb49
         axzMSn1yjFTyTBkOdc2+UVTk5Gz92mWCnld/YL5u4vKyzYtkRVPNhNr9UzUkvIN7Ycqq
         ISDPd3H5PRH73JD8rYVifp3jUwMwynp4EatOiyPX92/eU03i+3sLgPA8OcVQNgEgxJAO
         DeaKhYiE4vodkvHYnokp/nd2fgG2yJ5+0q+AxLEyKWCMeoAvbJQ9slN5Y8y9mtniDfML
         1fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=le3D/RH71t/xaxQ2Z6ZJvv8lT0hPbLZVdlFrqGmRQGg=;
        b=lIGP3t18wIpv0otvTutwHMHL/CaV9RmswPgxThz8vCnQrPKUL4RLUVUReglRryIN4M
         efZNmIHANycfzJqR6v8tfHJejsk9qqkf8bNrFDRYr60sh9dOyxh89JXz+ubf90vorBsn
         cNC4vdfgYdVNUtbWO8xHF3O2nfIX8KGIV7+ul+ORl/HR3pBhsFrLmztg8IJZUAj7hrP4
         IUwi3v+3Co/9Ht99WtGVN/5fozEsAEt+SpSKKP5+vRQAeQRIjwkc/lD3wO2Czm6kGbxg
         vWH3PQyLF59xTtPcUctI0Nat4mmHnShUx3A27hQPc9OCHdV7w7zL3YoQAlv/NWS+pFBv
         nDDQ==
X-Gm-Message-State: ACgBeo3YcptmC/p3GY7TL1057S84vo6S/2frR1DjcFi5JW7x7hQUQ7k5
        ZUm3DZFf48mDlKmnp8vk6hg=
X-Google-Smtp-Source: AA6agR4CDVeIyuKHv7tHJzl91RfqSAn9IDnoWiEbo2XkapmFReGZW1dm49IDKOe1xagDOwPpCAgruw==
X-Received: by 2002:a17:903:18a:b0:16f:e43:efdf with SMTP id z10-20020a170903018a00b0016f0e43efdfmr21243764plg.157.1660650085312;
        Tue, 16 Aug 2022 04:41:25 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id im9-20020a170902bb0900b001725a63746dsm6648688plb.186.2022.08.16.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 04:41:24 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/core: Set pebs_capable and PMU_FL_PEBS_ALL for the Baseline
Date:   Tue, 16 Aug 2022 19:40:57 +0800
Message-Id: <20220816114057.51307-1-likexu@tencent.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The SDM explicitly states that PEBS Baseline implies Extended PEBS.
For cpu model forward compatibility (e.g. on ICX, SPR, ADL), it's
safe to stop doing FMS table thing such as setting pebs_capable and
PMU_FL_PEBS_ALL since it's already set in the intel_ds_init().

The Goldmont Plus is the only platform which supports extended PEBS
but doesn't have Baseline. Keep the status quo.

Cc: Kan Liang <kan.liang@linux.intel.com>
Reported-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/intel/core.c | 4 ----
 arch/x86/events/intel/ds.c   | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db93498ff71..cb98a05ee743 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6291,10 +6291,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 
@@ -6337,10 +6335,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427caa6d..ac6dd4c96dbc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2262,6 +2262,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_BRANCH_STACK |
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
+				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
-- 
2.37.2

