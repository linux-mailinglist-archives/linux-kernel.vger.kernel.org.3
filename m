Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32548522CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiEKHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbiEKHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:01:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122545E74C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d188-20020a25cdc5000000b00648429e5ab9so1093719ybf.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p1OX+w7IK0mnK9F3eqD3DEeM7lTBarWyy9w79QDENKE=;
        b=FIO2yZvt1EnPVeydYIqjeebHVBci+Re90bjDH3fQ09Xb/6mSaO0ILtM7ELgkMB+eGK
         djqQCD/4SHfkPvwCvyouKotO5ghRj3BBtt2IeRIVETFqgQjmfZ5wTUl/WmCgOn96jm4C
         BSHeD7pY2bL8an1cH3ZzX7fuvlSL81HruwA9MhYXIWwkUv8lxrfiib5xyEKak+kNridm
         M0ytdE7SWmqVd4ukmqOONHSqrEp9uVryzpGzasL8oT8GpxDQfACNIF3ZWAHeWM810Dyf
         yso2qirh1NT8M7MYIfWg5AqcJpfvxlMMPc0x0cXd+9eIf0etskK/7l2WfMUKSBPDZqdN
         Gprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p1OX+w7IK0mnK9F3eqD3DEeM7lTBarWyy9w79QDENKE=;
        b=sWq2nuwf1qqPDcHcpn6bogr2M/Nm3uTVnPhTsgtZOLT12TeTtzYv0k/RPzmKHt42C8
         4BdaxnOOhUhJ+x9ZF9zn4HYSU6O+DxRQZ8++dSpvfhFYbHWxfXFR72CCGW06PVCEHDZQ
         T+fzl81W0EUp2zHMVRHN4apFz/a5aJ2umsXwVvss3AJ72ufhiH/Vfe5nvfdoN1F31iM3
         lZ/2WQu5/Tivr+U/lrYmiCrBal6coPIlQoh/vnQ6jHwFsFAlI1i2II1mx194t4r9LkeR
         qF9vuTiawU+8mlbKFIF68AyCu8niFAax3T2hjygrgOxMaMVRR6I2X0LjcPO6CQNkRCpo
         wCQw==
X-Gm-Message-State: AOAM531eKRq2dBiAdIkANF6LWDung5Swczh0vKxrU8ZSydF9BrQClMdB
        UNkQJGk7EY//3Hvp/phHedOAFKf5tgUp
X-Google-Smtp-Source: ABdhPJxpapPDx4GvGXc5S+8qppcE3wrnnn+RrBiK6n6ApsanFrFANYx/sXkYOA9dYCH65NvEOFC5nVmuJ5Tw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a25:47c1:0:b0:64a:9f13:61c7 with SMTP id
 u184-20020a2547c1000000b0064a9f1361c7mr18383514yba.464.1652252501992; Wed, 11
 May 2022 00:01:41 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:28 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-3-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/7] perf vendor events: Fix Alderlake metric groups
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

