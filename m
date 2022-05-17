Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C30529EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbiEQKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbiEQKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:10:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D6664B428;
        Tue, 17 May 2022 03:09:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 209131042;
        Tue, 17 May 2022 03:09:01 -0700 (PDT)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.33.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB6603F66F;
        Tue, 17 May 2022 03:08:58 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] perf: arm64: Kernel support for Dwarf unwinding through SVE functions
Date:   Tue, 17 May 2022 11:07:41 +0100
Message-Id: <20220517100743.3020667-1-james.clark@arm.com>
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

Changes since v1:

  * Add Mark's review tag
  * Clarify in docs that it's the SVE register length
  * Split patchset into kernel side and Perf tool changes

When SVE registers are pushed onto the stack the VG register is required to
unwind because the stack offsets would vary by the SVE register width at the
time when the sample was taken.

These first two patches add support for sampling the VG register to the kernel
and the docs. There is another patchset to add support to userspace perf.

A small change is also required to libunwind or libdw depending on which
unwinder is used, and these will be published later. Without these changes Perf
continues to work with both libraries, although the VG register is still not
used for unwinding. 

Thanks
James

James Clark (2):
  perf: arm64: Add SVE vector granule register to user regs
  arm64/sve: Add Perf extensions documentation

 Documentation/arm64/sve.rst             | 20 +++++++++++++++++
 arch/arm64/include/uapi/asm/perf_regs.h |  7 +++++-
 arch/arm64/kernel/perf_regs.c           | 30 +++++++++++++++++++++++--
 drivers/perf/arm_pmu.c                  |  2 +-
 4 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.28.0

