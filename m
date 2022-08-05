Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686358A487
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiHEBjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiHEBjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:39:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812271BEB
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:39:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4b76446aso10714557b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=7+EYB1pk4IZO2mzflNAQJXsnyqSSlRrvUF2/Jl/U4Cs=;
        b=X/XIJN+F3QDx4daRHdc5rBM6aQ+E+E8TId0C/sWiu5GqnrEzKUVZlVa1QmRreZtg9O
         a4q7LBMC2huIkNgsiyCwNlJZJIQpo4WVPltZsFM6wsal0/v6ufa1KySYfRAslTwduc8h
         gy8ISFZ1/otBuyqJLojF0Jq4mOntCqKt3zDZYzjf+x25vQDv+H58c0a97lIcdnbiGklh
         jDDF103ctVoopq9ur/AlZbvd6b7Ln9UmiqdKBcZWH3kwR0Cx2KeTB667TFzwu/uROeR1
         2jSLKqf/zijQqn/iByQcvYDBAOKWYIIdN40Tv39kK5L2SMQ6AoWL49wI2ND7un438FHM
         AHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=7+EYB1pk4IZO2mzflNAQJXsnyqSSlRrvUF2/Jl/U4Cs=;
        b=InuCcqmqP3PpAsSm+Lt8EDu2p0Jgu1Fmi7bWQJ8rG1Ktw/iZJgDtp+1trI0JvMUYvY
         kkV8JFoDb15fRjv7Zf6A+CxnDBwVn2BuqD0yMu9t59j819Yp90cJ9xFJIg+zyzF7nGO8
         jLuRHisUdaGMPCx4o3SXQPNKRCIREVQOKoEUSBU5Hg9fFLNMp4Xt4KMCpv6+AXyK+E6q
         zB3xxN/y6tDXIU+DxVuE8Cm2/4s8N7KgP0jLfEKE47HqQ9yxS+y2cxApxMCvZH7Aq3sT
         0QqgtljfTFGJ7Rosv7xr/OBAkCwj+951eaUUdQiDA9JdCUycQRCD+QRVIbqdagz9nmzM
         bxzg==
X-Gm-Message-State: ACgBeo2DJrByrMDP0lLUqnue3OuhOxupc/RYadm0+Xkv2eZAW1mLUf+z
        yhYZ4eGsDdAfCeZiDjJCzQMpSeG1HwHr
X-Google-Smtp-Source: AA6agR5pZ0812bin//wLqKa0nyC+jILL3NkiM8EBcuLLPhcwJPe0Q9vcYF7WwkHc+OsirDKlYjx/gUEeuw0u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:814f:0:b0:66f:9fbc:87ff with SMTP id
 j15-20020a25814f000000b0066f9fbc87ffmr3633735ybm.12.1659663545301; Thu, 04
 Aug 2022 18:39:05 -0700 (PDT)
Date:   Thu,  4 Aug 2022 18:38:53 -0700
Message-Id: <20220805013856.1842878-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 0/3] Remove bad uncore filter/events
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event converter scripts at:
https://github.com/intel/event-converter-for-linux-perf
passes Filter values from data on 01.org that is bogus in a perf command
line and can cause perf to infinitely recurse in parse events. Remove
such events or filter using the updated patch:
https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/afd779df99ee41aac646eae1ae5ae651cda3394d

v3. Removed filters rather than events in some cases as Suggested-by:
    Liang, Kan <kan.liang@linux.intel.com>
v2. Manually fixed a broken \\Inbound\\ ivytown event.

Ian Rogers (3):
  perf vendor events: Remove bad broadwellde uncore events
  perf vendor events: Remove bad ivytown uncore events
  perf vendor events: Remove bad jaketown uncore events

 .../arch/x86/broadwellde/uncore-cache.json    | 97 -------------------
 .../arch/x86/broadwellde/uncore-other.json    | 13 ---
 .../arch/x86/ivytown/uncore-cache.json        | 90 -----------------
 .../arch/x86/ivytown/uncore-interconnect.json |  1 -
 .../arch/x86/ivytown/uncore-other.json        | 13 ---
 .../arch/x86/ivytown/uncore-power.json        | 19 ----
 .../arch/x86/jaketown/uncore-cache.json       | 30 ------
 .../arch/x86/jaketown/uncore-other.json       | 13 ---
 .../arch/x86/jaketown/uncore-power.json       | 11 ---
 9 files changed, 287 deletions(-)

-- 
2.37.1.559.g78731f0fdb-goog

