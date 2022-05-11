Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E2522CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbiEKHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiEKHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:01:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B65BE44
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7c322f770so9622197b3.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=N8/Nldd50lgxa4UFpEziOLqimjwZJwjurqH31n9cYdBOi0RBAipty9Ako1bpqKqpEX
         3nmNb18S9Yvbq34OwG5EVj4isGDRt9nu75YwPVXb6E93b2xCV2jcGXqvojKpN/yDfW4l
         pyhnuj95b3Uy9b1rmrLuzFSNGLjx2PXdQGAY+YQCZ4pAVLCCAFaOns1U4IQ+lnfALzoy
         zltNPdjfV05fmlZV2Tv8Q8V4A5xGNr8tNXDi1NoMTLYG2sbBXe3nyRgTxdI9FOz4Mzup
         yq6Mq2rzn+6NrVKeJ/hJ8wRD9FFimIeUb39l3UgOke6JB8FMseM1/8VdxYv0gf2HIjvD
         ZuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xLzWp+VN8d56IUKCn+oZgvctc6ILOg/P6G2GbPqdKc=;
        b=GW+X/B6UxZU5n4Lw1UWKrIN7OXxiChAlUvm3AK0ut0KApyeQ39QdktmKyJocyKYfYb
         f7OlSo/rU3VYuu9lm1tRNyOva9rtY+f8XDW2GgJLeKEWU4xNIA1UiMqOF9lfTFk7FMOA
         nQIvWHnck+OtRGN2mN/8Ez152nn2+TQ6VBhzQt+OIajyFvLBf9RUlgTcxRWeu68bNsbX
         GEmH28/LDSw7HNyowcm9URBLYwa05qiORLbUYif0FmzLrQ3knCtr7lLa9xrC1qhSriIX
         p+AvktkFs3u6xd3X3m/c4GEe8++BfUdH3TXNVE5WsCC8AsrjBz7BKpdzMF8/T8yIKA8N
         u1XQ==
X-Gm-Message-State: AOAM533hVmTkO+DlUbWwPboGNDzOYBBCjmUev/Cdw3bREMawVg6b4P8o
        yk48apsdfDvdVq0z6+VM8H8PVv7SqDg3
X-Google-Smtp-Source: ABdhPJyU0JGtkMiuWLcINboT3dByokO5rmHxkLIAGVtLVFu/F1k0AkML7xNFVmashRWlC6SkWWWwsV2ym4Mf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a0d:df48:0:b0:2fb:3658:38b0 with SMTP id
 i69-20020a0ddf48000000b002fb365838b0mr22872026ywe.508.1652252504258; Wed, 11
 May 2022 00:01:44 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:29 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-4-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 3/7] perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
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

The event had two umasks with the umask of 3 being correct.
Note: this change wasn't automatically generated as there is no CSV for
Ivytown uncore events at:
https://github.com/intel/event-converter-for-linux-perf

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index df4b43294fa0..e8917cb59566 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -5,8 +5,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x1",
-        "Umask": "0x3",
+        "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-- 
2.36.0.512.ge40c2bad7a-goog

