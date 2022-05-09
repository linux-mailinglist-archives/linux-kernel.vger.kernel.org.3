Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3753520018
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiEIOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiEIOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:47:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E10101B3B97;
        Mon,  9 May 2022 07:43:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B65B01480;
        Mon,  9 May 2022 07:43:24 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.4.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65AD53F73D;
        Mon,  9 May 2022 07:43:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org
Cc:     german.gomez@arm.com, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v1 0/6] perf: arm64: Support for Dwarf unwinding through SVE functions
Date:   Mon,  9 May 2022 15:42:48 +0100
Message-Id: <20220509144257.1623063-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SVE registers are pushed onto the stack the VG register is required to
unwind because the stack offsets would vary by the SVE register width at the
time when the sample was taken.

The first two patches add support for sampling the VG register to the kernel and
the docs. The remaining patches add the support to userspace perf.

A small change is also required to libunwind or libdw depending on which
unwinder is used, and these will be published later. Without these changes Perf
continues to work with both libraries, although the VG register is still not
used for unwinding. 

James Clark (6):
  perf: arm64: Add SVE vector granule register to user regs
  arm64/sve: Add Perf extensions documentation
  perf tools: arm64: Copy perf_regs.h from the kernel
  perf tools: Use dynamic register set for Dwarf unwind
  perf tools: arm64: Decouple Libunwind register names from Perf
  perf tools: arm64: Add support for VG register

 Documentation/arm64/sve.rst                   | 20 +++++
 arch/arm64/include/uapi/asm/perf_regs.h       |  7 +-
 arch/arm64/kernel/perf_regs.c                 | 30 +++++++-
 drivers/perf/arm_pmu.c                        |  2 +-
 tools/arch/arm64/include/uapi/asm/perf_regs.h |  7 +-
 tools/perf/arch/arm64/util/perf_regs.c        | 34 +++++++++
 tools/perf/arch/arm64/util/unwind-libunwind.c | 73 +------------------
 tools/perf/util/evsel.c                       |  2 +-
 tools/perf/util/perf_regs.c                   |  2 +
 9 files changed, 100 insertions(+), 77 deletions(-)

-- 
2.28.0

