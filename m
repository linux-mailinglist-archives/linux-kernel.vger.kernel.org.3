Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624D5787A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiGRQnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbiGRQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F552983B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:43:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r64-20020a254443000000b006707b7c2baeso438163yba.16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fYofINTij03DPcWKIxfbrAT4JPb3siK7exyNeIlcD5U=;
        b=N9uFsdwVL4V6pYvk4JsZwo6gVJAaVtZJfYKCVfqCJfXQFkY8VZVetp4CafnFw5m+wI
         USuc1jejc8950fmeG47w8DiTaJSwr67wd4asubiCo5lKObX4peLeAQXThc4q9fHZJNvy
         hSoRQF/ZkSlSJXiOaVb6PJKs0YkOX7I2KBcTTqzWZosQnTtu8rb94cO+T9SbAFDnclcZ
         qxip1nZk09WCKtqTNuPQkKQ6tWyiljVJHqEHYUfP2JWJSA20KUsx93M3+XqrX8L28ZAo
         R/nJJUN1hq3VoffKVxs0NXsHCW7bJTRugFvQ484nb9lJf6Z0Lhtu5kkznEIN/jlBGCuo
         QwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fYofINTij03DPcWKIxfbrAT4JPb3siK7exyNeIlcD5U=;
        b=w3u8XpY+zMc32dmgL3F+nM5xY7U9rsIhGlijCGkVWrYmdit42IIuBntloS6/B+BLKV
         oI3GiTChi9noOnVVXv2CMLk1/YgGhZtNrB+M4OfA7PScz05bshIsahLmP4Rf63PWDke+
         xvmSPYISohqski6VDtq29P0cl72T10IBFqWQH0JoKSpL2nhORthO4uMikENfFSZH3p1F
         pYNlLexc4PR0LWuTP4tHPEQvCF0arI/n71tfr6WETRtikrTTjXKyQOJbA4tDmA1wv6E1
         Nc7u5KIYMFQZ/txVnBqWAh/yzclFk6XQPGo6Ti4J06XgnT0gEUCRVb9r5Ds2JHlAPtEG
         2dvw==
X-Gm-Message-State: AJIora+LwRX+eg/pCRTu17hZY2nQp6n6ynAr8cnXykN4Xhm/atiJ6eB7
        a/AAipzcT1e8+RgUZ9A10G5cqXcAoLUM
X-Google-Smtp-Source: AGRyM1sui6frsIcA/wQFW2UecSes/L71+RdmIY8GslmayyTv5uj7L8ODJtUI90YevaRH7Sf96QjfVgdmN8fV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr10216544ybp.380.1658162597250; Mon, 18
 Jul 2022 09:43:17 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:09 -0700
Message-Id: <20220718164312.3994191-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 0/3] Add arch TSC frequency information
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds the #system_tsc_freq literal to expr.c and
computes it via cpuid. The second patches adds support for "older"
processors by computing the value via /proc/cpuinfo. The third patch
adds a test then the computation looks somewhat sensible.

Such a literal is useful to calculate things like the average
frequency [1]. The TSC frequency isn't exposed by sysfs although some
experimental drivers look to add it [2].

[1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
[2] https://github.com/trailofbits/tsc_freq_khz

v4. Modified the patch order and separated out the test.
v3. Added the cpuid approach from Kan Liang.
v2. Adds warnings to make clear if things have changed/broken on future
    Intel platforms. It also adds caching and an Intel specific that a
    value is computed.

Ian Rogers (2):
  perf tsc: Add cpuinfo fall back for arch_get_tsc_freq
  perf test: Add test for #system_tsc_freq in metrics

Kan Liang (1):
  perf tsc: Add arch TSC frequency information

 tools/perf/arch/x86/util/cpuid.h  | 34 ++++++++++++++
 tools/perf/arch/x86/util/header.c | 27 +++++------
 tools/perf/arch/x86/util/tsc.c    | 77 +++++++++++++++++++++++++++++++
 tools/perf/tests/expr.c           | 13 ++++++
 tools/perf/util/expr.c            | 13 ++++++
 tools/perf/util/tsc.h             |  1 +
 6 files changed, 149 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/cpuid.h

-- 
2.37.0.170.g444d1eabd0-goog

