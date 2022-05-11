Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74555233E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbiEKNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiEKNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:18:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE8E19B1BC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:17:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABECED1;
        Wed, 11 May 2022 06:17:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 495953F66F;
        Wed, 11 May 2022 06:17:45 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH 0/2] arm64: fix lockdep in NMI context
Date:   Wed, 11 May 2022 14:17:31 +0100
Message-Id: <20220511131733.4074499-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
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

For lockdep to function correctly in NMI context, architectures need to
correctly save/restore lockdep state at NMI entry/exit time, correctly
manage lockdep state within the NMI context, and need to select
TRACE_IRQFLAGS_NMI_SUPPORT.

Currently arm64 falls short of this merely by failing to select
TRACE_IRQFLAGS_NMI_SUPPORT, and this can result in spurious lockdep
splats with GICv3 Pseudo-NMIs are in use. Patch 2 has an example.

Patch 1 makes TRACE_IRQFLAGS_NMI_SUPPORT a generically selectable
kconfig symbol (as it is currently defined under arch/x86). Patch 2
selects this on arm64 (providing the behaviour we'd intended when
reworking our entry code).

For anyone testing, beware that there are some other latent issues with
GICv3 Pseudo-NMIs. I'm currently working to fix those whcih I am aware
of, but as this is orthogonal I'd like to get it out the way on its own.

Thanks,
Mark.

Mark Rutland (2):
  arch: make TRACE_IRQFLAGS_NMI_SUPPORT generic
  arm64: select TRACE_IRQFLAGS_NMI_SUPPORT

 arch/Kconfig           | 3 +++
 arch/arm64/Kconfig     | 1 +
 arch/x86/Kconfig       | 1 +
 arch/x86/Kconfig.debug | 3 ---
 4 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.30.2

