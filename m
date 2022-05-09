Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA252002D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbiEIOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiEIOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:47:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 515482108AA;
        Mon,  9 May 2022 07:43:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32FF153B;
        Mon,  9 May 2022 07:43:50 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.4.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2BD03F73D;
        Mon,  9 May 2022 07:43:48 -0700 (PDT)
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
Subject: [PATCH v1 5/6] perf tools: arm64: Decouple Libunwind register names from Perf
Date:   Mon,  9 May 2022 15:42:53 +0100
Message-Id: <20220509144257.1623063-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220509144257.1623063-1-james.clark@arm.com>
References: <20220509144257.1623063-1-james.clark@arm.com>
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

Dwarf register numbers and real register numbers on aarch64 are
equivalent. Remove the references to the register names from
Libunwind so that new registers are supported without having to
add build time feature checks for each new register.

The unwinder won't ask for a register that it doesn't know about
and Perf will already report an error for an unknown or unrecorded
register in the perf_reg_value() function so extra validation
isn't needed.

After this change the new VG register can be read by libunwind.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/unwind-libunwind.c | 73 +------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 5aecf88e3de6..871af5992298 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -10,77 +10,8 @@
 
 int LIBUNWIND__ARCH_REG_ID(int regnum)
 {
-	switch (regnum) {
-	case UNW_AARCH64_X0:
-		return PERF_REG_ARM64_X0;
-	case UNW_AARCH64_X1:
-		return PERF_REG_ARM64_X1;
-	case UNW_AARCH64_X2:
-		return PERF_REG_ARM64_X2;
-	case UNW_AARCH64_X3:
-		return PERF_REG_ARM64_X3;
-	case UNW_AARCH64_X4:
-		return PERF_REG_ARM64_X4;
-	case UNW_AARCH64_X5:
-		return PERF_REG_ARM64_X5;
-	case UNW_AARCH64_X6:
-		return PERF_REG_ARM64_X6;
-	case UNW_AARCH64_X7:
-		return PERF_REG_ARM64_X7;
-	case UNW_AARCH64_X8:
-		return PERF_REG_ARM64_X8;
-	case UNW_AARCH64_X9:
-		return PERF_REG_ARM64_X9;
-	case UNW_AARCH64_X10:
-		return PERF_REG_ARM64_X10;
-	case UNW_AARCH64_X11:
-		return PERF_REG_ARM64_X11;
-	case UNW_AARCH64_X12:
-		return PERF_REG_ARM64_X12;
-	case UNW_AARCH64_X13:
-		return PERF_REG_ARM64_X13;
-	case UNW_AARCH64_X14:
-		return PERF_REG_ARM64_X14;
-	case UNW_AARCH64_X15:
-		return PERF_REG_ARM64_X15;
-	case UNW_AARCH64_X16:
-		return PERF_REG_ARM64_X16;
-	case UNW_AARCH64_X17:
-		return PERF_REG_ARM64_X17;
-	case UNW_AARCH64_X18:
-		return PERF_REG_ARM64_X18;
-	case UNW_AARCH64_X19:
-		return PERF_REG_ARM64_X19;
-	case UNW_AARCH64_X20:
-		return PERF_REG_ARM64_X20;
-	case UNW_AARCH64_X21:
-		return PERF_REG_ARM64_X21;
-	case UNW_AARCH64_X22:
-		return PERF_REG_ARM64_X22;
-	case UNW_AARCH64_X23:
-		return PERF_REG_ARM64_X23;
-	case UNW_AARCH64_X24:
-		return PERF_REG_ARM64_X24;
-	case UNW_AARCH64_X25:
-		return PERF_REG_ARM64_X25;
-	case UNW_AARCH64_X26:
-		return PERF_REG_ARM64_X26;
-	case UNW_AARCH64_X27:
-		return PERF_REG_ARM64_X27;
-	case UNW_AARCH64_X28:
-		return PERF_REG_ARM64_X28;
-	case UNW_AARCH64_X29:
-		return PERF_REG_ARM64_X29;
-	case UNW_AARCH64_X30:
-		return PERF_REG_ARM64_LR;
-	case UNW_AARCH64_SP:
-		return PERF_REG_ARM64_SP;
-	case UNW_AARCH64_PC:
-		return PERF_REG_ARM64_PC;
-	default:
-		pr_err("unwind: invalid reg id %d\n", regnum);
+	if (regnum < 0 || regnum >= PERF_REG_ARM64_EXTENDED_MAX)
 		return -EINVAL;
-	}
 
-	return -EINVAL;
+	return regnum;
 }
-- 
2.28.0

