Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00D523F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348120AbiEKVPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiEKVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:15:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D8229FCE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:15:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8398e99dcso28942327b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p1OX+w7IK0mnK9F3eqD3DEeM7lTBarWyy9w79QDENKE=;
        b=Z77/MrRscep7wi8r0u2J4XNJRQ1GVhi3UCpPx51CXGtrZe3fzGclMOhwDeeHZSeLhC
         dzT7fDj0zuNJ6J6wpmlewf1YSw2KszgkzKCZufih5CYo84rpmkorbxZlvLywSaW+JsNl
         4Uj0BH4MfLLMlV5JE/Vhn+r/b1U4aefs3YZm3huREDZGio40m64GHLH0E6uMkH1swKGT
         Ll6YnvgU+PTi+RHksKTUj43U8441cfrFPd4iEgLH8wSMCoW28TiMszOLyDxEyDA90aKu
         USFnMeJOWgx3de2Ul1TFk4G3MTkDEnDnL0q1uOI5uRuZE4SquApS0npVKd0MNAyMuazC
         Rd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p1OX+w7IK0mnK9F3eqD3DEeM7lTBarWyy9w79QDENKE=;
        b=B0tlZc87qTnKNn5h/8GsYsUe5OoOlRLLpcXXpLFyce+Dbk2+z59eKGREaZmWB395os
         igTbDVY2/+y6R16etLfz0NPbFJC2MN1ZUozJzO8nWZfdMBwXQnSo5KgXIR1BwoOKQ/Pw
         g4odcPQDESmbfkEc87CWDcDdhEY9Y5ulzm+ef6+hbRPjYI6bhEVLTCekw+uWquMSlHb+
         jvcqnVG2KrfweTxRIQsIsyzMyq1NXL2136TSaUXfX1XMnvazy/Cza9jiuxB1JIwmJp1f
         gDpDVLAaK1YYa5C0x+81sir8I1x1EJiR+Qh/mFfQnXUDzomCJzQ0kD+wVVKE6khsLR6z
         USgg==
X-Gm-Message-State: AOAM532fm5guRXimhqaihFcPputkPplSb/DKePKfkikt9lBOn1QHPBpo
        LG0YiNbcdnmJ7lp4BCG+WJYaSTNp6+yr
X-Google-Smtp-Source: ABdhPJw+qLmV+II+Tc0pughV5McaAk3MMWRjKfTzVJEQYX4owu0rChRMUeGTYo7x5r9nerTLL3R20ZODN5sZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a25:8c9:0:b0:64b:428a:69e2 with SMTP id
 192-20020a2508c9000000b0064b428a69e2mr3445263ybi.88.1652303734998; Wed, 11
 May 2022 14:15:34 -0700 (PDT)
Date:   Wed, 11 May 2022 14:15:21 -0700
In-Reply-To: <20220511211526.1021908-1-irogers@google.com>
Message-Id: <20220511211526.1021908-3-irogers@google.com>
Mime-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 2/7] perf vendor events: Fix Alderlake metric groups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Remove unnecessary empty groups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 4d172687f936..6b24958737b5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -477,224 +477,192 @@
     {
         "BriefDescription": "",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": " ",
         "MetricName": "CLKS",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
-        "MetricGroup": " ",
         "MetricName": "CLKS_P",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "",
         "MetricExpr": "5 * CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": " ",
         "MetricName": "SLOTS",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions Per Cycle",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": " ",
         "MetricName": "IPC",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Cycles Per Instruction",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
-        "MetricGroup": " ",
         "MetricName": "CPI",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
-        "MetricGroup": " ",
         "MetricName": "UPI",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads with a store forward or unknown store address block",
         "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": "",
         "MetricName": "Store_Fwd_Blocks",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads with a address aliasing block",
         "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": "",
         "MetricName": "Address_Alias_Blocks",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads that are splits",
         "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": "",
         "MetricName": "Load_Splits",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
         "MetricName": "IpBranch",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricGroup": " ",
         "MetricName": "IpCall",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Load",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricGroup": " ",
         "MetricName": "IpLoad",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Store",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricGroup": " ",
         "MetricName": "IpStore",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
         "MetricName": "IpMispredict",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Instructions per Far Branch",
         "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
-        "MetricGroup": " ",
         "MetricName": "IpFarBranch",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Ratio of all branches which mispredict",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricGroup": " ",
         "MetricName": "Branch_Mispredict_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Ratio between Mispredicted branches and unknown branches",
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricGroup": " ",
         "MetricName": "Branch_Mispredict_to_Unknown_Branch_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are ucode ops",
         "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
         "MetricName": "Microcode_Uop_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are FPDiv uops",
         "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
         "MetricName": "FPDiv_Uop_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are IDiv uops",
         "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
         "MetricName": "IDiv_Uop_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percentage of all uops which are x87 uops",
         "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
-        "MetricGroup": " ",
         "MetricName": "X87_Uop_Ratio",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": " ",
         "MetricName": "Turbo_Utilization",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE:k / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": " ",
         "MetricName": "Kernel_Utilization",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
-        "MetricGroup": " ",
         "MetricName": "CPU_Utilization",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Estimated Pause cost. In percent",
         "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / ( 5 * CPU_CLK_UNHALTED.CORE )",
-        "MetricGroup": " ",
         "MetricName": "Estimated_Pause_Cost",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Cycle cost per L2 hit",
         "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "MetricGroup": " ",
         "MetricName": "Cycles_per_Demand_Load_L2_Hit",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Cycle cost per LLC hit",
         "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "MetricGroup": " ",
         "MetricName": "Cycles_per_Demand_Load_L3_Hit",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Cycle cost per DRAM hit",
         "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "MetricGroup": " ",
         "MetricName": "Cycles_per_Demand_Load_DRAM_Hit",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / ( MEM_BOUND_STALLS.IFETCH )",
-        "MetricGroup": " ",
         "MetricName": "Inst_Miss_Cost_L2Hit_Percent",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / ( MEM_BOUND_STALLS.IFETCH )",
-        "MetricGroup": " ",
         "MetricName": "Inst_Miss_Cost_L3Hit_Percent",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Percent of instruction miss cost that hit in DRAM",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / ( MEM_BOUND_STALLS.IFETCH )",
-        "MetricGroup": " ",
         "MetricName": "Inst_Miss_Cost_DRAMHit_Percent",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "load ops retired per 1000 instruction",
         "MetricExpr": "1000 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
-        "MetricGroup": " ",
         "MetricName": "MemLoadPKI",
         "Unit": "cpu_atom"
     },
-- 
2.36.0.512.ge40c2bad7a-goog

