Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACF5A98DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiIANcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiIANbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:31:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1304D1054A;
        Thu,  1 Sep 2022 06:27:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBAE7D6E;
        Thu,  1 Sep 2022 06:27:32 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.16.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11CB83F7B4;
        Thu,  1 Sep 2022 06:27:52 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, leo.yan@linaro.org,
        john.garry@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding through SVE functions
Date:   Thu,  1 Sep 2022 14:26:56 +0100
Message-Id: <20220901132658.1024635-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm resubmitting this with a few of the changes suggested by Will on V2.

I haven't made any changes regarding the open questions about the
discoverability or saving the new reg and passing to output_sample()
because I think it's best to be consistent with the implementations on
other platforms first. I have explained in more detail on v2 [1].

[1]: https://lore.kernel.org/lkml/5fcf1a6f-c8fb-c296-992e-18aae8874095@arm.com/

=======

Changes since v2:

  * Add definition for PERF_REG_EXTENDED_MASK which is needed for
    PERF_PMU_CAP_EXTENDED_REGS to work properly

  * Simplify changes to enum perf_event_arm_regs

Changes since v1:

  * Add Mark's review tag
  * Clarify in docs that it's the SVE register length
  * Split patchset into kernel side and Perf tool changes

=======

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
 arch/arm64/include/uapi/asm/perf_regs.h |  7 ++++++
 arch/arm64/kernel/perf_regs.c           | 30 +++++++++++++++++++++++--
 drivers/perf/arm_pmu.c                  |  2 +-
 4 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.28.0

