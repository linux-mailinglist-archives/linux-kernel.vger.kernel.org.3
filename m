Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3A520024
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiEIOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiEIOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:47:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 230F41C83DE;
        Mon,  9 May 2022 07:43:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8F21480;
        Mon,  9 May 2022 07:43:34 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.4.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F3353F73D;
        Mon,  9 May 2022 07:43:32 -0700 (PDT)
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
Subject: [PATCH v1 2/6] arm64/sve: Add Perf extensions documentation
Date:   Mon,  9 May 2022 15:42:50 +0100
Message-Id: <20220509144257.1623063-3-james.clark@arm.com>
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

Document that the VG register is available in Perf samples

Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/arm64/sve.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
index 9d9a4de5bc34..67e65bf66883 100644
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -402,6 +402,24 @@ The regset data starts with struct user_sve_header, containing:
 * Modifying the system default vector length does not affect the vector length
   of any existing process or thread that does not make an execve() call.
 
+10.  Perf extensions
+--------------------------------
+
+* The arm64 specific DWARF standard [5] added the VG (Vector Granule) register
+  at index 46. This register is used for DWARF unwinding when variable length
+  SVE registers are pushed onto the stack.
+
+* Its value is equivalent to the current vector length (VL) in bits divided by
+  64.
+
+* The value is included in Perf samples in the regs[46] field if
+  PERF_SAMPLE_REGS_USER is set and the sample_regs_user mask has bit 46 set.
+
+* The value is the current value at the time the sample was taken, and it can
+  change over time.
+
+* If the system doesn't support SVE when perf_event_open is called with these
+  settings, the event will fail to open.
 
 Appendix A.  SVE programmer's model (informative)
 =================================================
@@ -543,3 +561,5 @@ References
     http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055c/IHI0055C_beta_aapcs64.pdf
     http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
     Procedure Call Standard for the ARM 64-bit Architecture (AArch64)
+
+[5] https://github.com/ARM-software/abi-aa/blob/main/aadwarf64/aadwarf64.rst
-- 
2.28.0

