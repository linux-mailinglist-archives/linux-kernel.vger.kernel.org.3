Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B5B4FA692
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiDIJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDIJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E082E3BA45
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CD860F0B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAE8C385A0;
        Sat,  9 Apr 2022 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649497356;
        bh=z/VQ7UBPEEz1ClVwweMM7AeDdYXV0a8DdIT6eAZDtxg=;
        h=From:To:Cc:Subject:Date:From;
        b=d2/z83hlnDS7YQrDomzn3kn6JRBGeHYP4u9/wTJwEOxr3elnaffi9Na7lPcOt0cjJ
         MwTqci6f0+JyDWFQ/HyNOr/rUcIa2L5nw1AuoDP/n+ZL7Qlh4EIY8D1RL5UbGAFmjc
         BPeoc9zofSxljYqNYBXme2rEKsGMFmLunifkHTmteR6XrSk20FLdALklFQwCxXfDMU
         DZMOF+iw/grLxz1+0kstRMA3Pil3Sh0wF4Iln1M6X5OYvqlZN8VAGK4kyZGGpc9ozN
         PC7vN8iPg9NEZHG7n5rb6SkR0tw2DqGmdSMqIdLDMCoAdoX+5UDf8UvNMHjR1weexj
         JYbYkZW5YKJXQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nd7c2-002y4g-BZ; Sat, 09 Apr 2022 10:42:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Hulk Robot <hulkci@huawei.com>,
        Jingyi Wang <wangjingyi11@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.18, take #1
Date:   Sat,  9 Apr 2022 10:42:29 +0100
Message-Id: <20220409094229.267649-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, andre.przywara@arm.com, hulkci@huawei.com, wangjingyi11@huawei.com, lorenzo.pieralisi@arm.com, tangnianyao@huawei.com, shawn.guo@linaro.org, yangyingliang@huawei.com, yuehaibing@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

Here's a handful of fixes from the irqchip department. Most of them
are affecting the various GICs one way or another, with a pretty
embarrassing one that took no less than 8 years to spot... I'll take
the blame on that one.

Please pull,

	M.

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.18-1

for you to fetch changes up to 544808f7e21cb9ccdb8f3aa7de594c05b1419061:

  irqchip/gic, gic-v3: Prevent GSI to SGI translations (2022-04-05 16:33:47 +0100)

----------------------------------------------------------------
irqchip fixes for 5.18, take #1

- Fix GICv3 polling for RWP in redistributors

- Reject ACPI attempts to use SGIs on GIC/GICv3

- Fix unpredictible behaviour when making a VPE non-resident
  with GICv4

- A couple of fixes for the newly merged qcom-mpm driver

----------------------------------------------------------------
Andre Przywara (1):
      irqchip/gic, gic-v3: Prevent GSI to SGI translations

Marc Zyngier (2):
      irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear before descheduling
      irqchip/gic-v3: Fix GICR_CTLR.RWP polling

Yang Yingliang (1):
      irqchip/irq-qcom-mpm: fix return value check in qcom_mpm_init()

YueHaibing (1):
      irq/qcom-mpm: Fix build error without MAILBOX

 drivers/irqchip/Kconfig          |  1 +
 drivers/irqchip/irq-gic-v3-its.c | 28 +++++++++++++++++++---------
 drivers/irqchip/irq-gic-v3.c     | 14 ++++++++++----
 drivers/irqchip/irq-gic.c        |  6 ++++++
 drivers/irqchip/irq-qcom-mpm.c   |  2 +-
 5 files changed, 37 insertions(+), 14 deletions(-)
