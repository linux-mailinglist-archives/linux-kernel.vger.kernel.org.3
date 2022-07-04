Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B0564F68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiGDIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGDILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755A39FFC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so12325182wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AUqFD9KYdiQpL3NUshToL5IaGhlRIXojEKi2n0eKo4A=;
        b=dB8izlzIQitU7ejWk9cue1Pu3HXTjLn0Md5bmX/ho2giI2ydA3svpBRa2RG47MNicb
         OHWa/daLcHdVR71nh/tj8UzDqcIM4LiVf0jxtQXx5v46JhwIof04UIXBFmc37BXn/3ik
         SgDaRbV3C/r1oZIqe2j458hBF+kY3FdWkFM8Mr6L2qccWAR8B0F+/YP0M05NbqUNROgt
         IfpC5s4YoX5UTW6Dh27gSKPqI008T4FfuEKSeckjTSI236HMrXGJW2VWMXt+AMW8jFZ/
         IyXipe6RuG4ICqHS3dlhub+iJ+kdDcnUpkJTvUfcwW9ojwrlSPTiPqVJGoEd/8tlx43+
         b0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AUqFD9KYdiQpL3NUshToL5IaGhlRIXojEKi2n0eKo4A=;
        b=sQ/wovNOkBcjGXev4OCpNkH0tmjg9w6fANLsfxf3jc/DHIDaC+LDz4XuAAZdbs7rZz
         DCvLQGEbZnp4TLTVEVArvgllajTl1+Jl/zD+WPKjUGn5Qxq8uutAMa+sNQM9Ai7MZoYl
         bNv0ZF2D65A5sVpgYYtpmoS25ptCFbKMja9u9oSMRA0qbkjq4F8lmjsmLR1Ig6IuMOqc
         acjVbxfVJFX36xF3GEZeCWJkdXk8KPMmCb068hCDdc3/ysMeGvyObOkJeWHOJ+Oxq7Mk
         CY+MAW8cDn+510hxqb4kzbjYv7VnrzzVwKleG5TA8kvkNF5T5NTpyg+ZU5MuoOaC3srz
         5pcw==
X-Gm-Message-State: AJIora+0ThLUO9DiyPC4EbwNW4Ta1Vl+l2dIyFVZvOjRHaluN7Njsvj9
        TDYMh1MfsdSWuX6qY2judfbHMA==
X-Google-Smtp-Source: AGRyM1uP/WLujNhFdsV0YO4ORJCZugnYr/SZIxlxb4LrrM+QOFw59S510K5XJ/Ja1tWRgCtYXK8ERg==
X-Received: by 2002:a5d:6d0e:0:b0:21d:6d4c:e0e4 with SMTP id e14-20020a5d6d0e000000b0021d6d4ce0e4mr1667662wrq.355.1656922312014;
        Mon, 04 Jul 2022 01:11:52 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:51 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 00/13] coresight: Add new API to allocate trace source ID values
Date:   Mon,  4 Jul 2022 09:11:36 +0100
Message-Id: <20220704081149.16797-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current method for allocating trace source ID values to sources is
to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
The STM is allocated ID 0x1.

This fixed algorithm is used in both the CoreSight driver code, and by
perf when writing the trace metadata in the AUXTRACE_INFO record.

The method needs replacing as currently:-
1. It is inefficient in using available IDs.
2. Does not scale to larger systems with many cores and the algorithm
has no limits so will generate invalid trace IDs for cpu number > 44.

Additionally requirements to allocate additional system IDs on some
systems have been seen.

This patch set  introduces an API that allows the allocation of trace IDs
in a dynamic manner.

Architecturally reserved IDs are never allocated, and the system is
limited to allocating only valid IDs.

Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
the new API.

For the ETMx.x devices IDs are allocated on certain events
a) When using sysfs, an ID will be allocated on hardware enable, or a read of
sysfs TRCTRACEID register and freed when the sysfs reset is written.

b) When using perf, ID is allocated on hardware enable, and freed on
hardware disable. IDs are communicated using the AUX_OUTPUT_HW_ID packet.
The ID allocator is notified when perf sessions start and stop
so CPU based IDs are kept constant throughout any perf session.


Note: This patchset breaks backward compatibility for perf record and
perf report.

Because the method for generating the AUXTRACE_INFO meta data has
changed, using an older perf record will result in metadata that
does not match the trace IDs used in the recorded trace data.
This mismatch will cause subsequent decode to fail.

The version of the AUXTRACE_INFO has been updated to reflect the fact that
the trace source IDs are no longer present in the metadata. This will
mean older versions of perf report cannot decode the file.

Applies to coresight/next [c06475910b52]
Tested on DB410c

Changes since v1:
(after feedback & discussion with Mathieu & Suzuki).

1) API has changed. The global trace ID map is managed internally, so it
is no longer passed in to the API functions.

2) perf record does not use sysfs to find the trace IDs. These are now
output as AUX_OUTPUT_HW_ID events. The drivers, perf record, and perf report
have been updated accordingly to generate and handle these events.

Mike Leach (13):
  coresight: trace-id: Add API to dynamically assign Trace ID values
  coresight: trace-id: update CoreSight core to use Trace ID API
  coresight: stm: Update STM driver to use Trace ID API
  coresight: etm4x: Update ETM4 driver to use Trace ID API
  coresight: etm3x: Update ETM3 driver to use Trace ID API
  coresight: etmX.X: stm: Remove unused legacy source Trace ID ops
  coresight: perf: traceid: Add perf notifiers for Trace ID
  perf: cs-etm: Move mapping of Trace ID and cpu into helper function
  perf: cs-etm: Update record event to use new Trace ID protocol
  kernel: events: Export perf_report_aux_output_id()
  perf: cs-etm: Handle PERF_RECORD_AUX_OUTPUT_HW_ID packet
  coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID
  coresight: trace-id: Add debug & test macros to Trace ID allocation

 drivers/hwtracing/coresight/Makefile          |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |  49 +---
 .../hwtracing/coresight/coresight-etm-perf.c  |  17 ++
 drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
 .../coresight/coresight-etm3x-core.c          |  85 +++---
 .../coresight/coresight-etm3x-sysfs.c         |  28 +-
 .../coresight/coresight-etm4x-core.c          |  65 ++++-
 .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
 drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
 drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
 .../hwtracing/coresight/coresight-trace-id.c  | 263 ++++++++++++++++++
 .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
 include/linux/coresight-pmu.h                 |  31 ++-
 include/linux/coresight.h                     |   3 -
 kernel/events/core.c                          |   1 +
 tools/include/linux/coresight-pmu.h           |  31 ++-
 tools/perf/arch/arm/util/cs-etm.c             |  21 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   9 +
 tools/perf/util/cs-etm.c                      | 220 +++++++++++++--
 tools/perf/util/cs-etm.h                      |  14 +-
 20 files changed, 784 insertions(+), 207 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h

-- 
2.17.1

