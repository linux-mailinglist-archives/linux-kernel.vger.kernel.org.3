Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA64DA06E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiCOQv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCOQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF8517D0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA33F614FC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 16:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10159C340EE;
        Tue, 15 Mar 2022 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647363043;
        bh=PaV7AwkshyvE4Lfti1SblNPa211DHEWxqbXO7sKsCRk=;
        h=From:To:Cc:Subject:Date:From;
        b=Og1X89vk27Mfhrr5wPHnFa2yJZw+LqMN8tyrR5EpVCePstR88m2Uf/v1pjWOS2AFK
         mQLx9ZeDeMh5aoa1soFBR0fdbVBAC8BF0dCBQNEiNK4ZqCh7+SR0cIHxvc4w2p6sme
         2e8/hF26CBZYtFVk8M62y+hAF8ZSDDZIpiIo12jlPWc4BbmboxEIa0SIaNJkn8RZwv
         cHZFGHL9L3xPebhS42Y+NuxNX7cTDo9U7Vyf2nzeTv3VjC1O9DyO9qs731mWHH/BPy
         wV9gsEHUdA64QN33gBjPa7RDvL6cWLeOt6siUbcY1T5tXDWh5d1P/HxTneGC1vw68U
         /ICo9PT7mwZ5Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUANc-00EhkO-P2; Tue, 15 Mar 2022 16:50:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH 0/3] irqchip/gic-v3: Assorted fixes and improvements
Date:   Tue, 15 Mar 2022 16:50:31 +0000
Message-Id: <20220315165034.794482-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small series that happens on the back of [1], which
implements additional features in KVM's vgic.

The first patch fixes a pretty embarrassing bug, which is fortunately
unlikely to cause any issue in real life. The next two patches are
performance optimisations.

Thanks,

        M.

[1] https://lore.kernel.org/r/20220314164044.772709-1-maz@kernel.org

Marc Zyngier (3):
  irqchip/gic-v3: Fix GICR_CTLR.RWP polling
  irqchip/gic-v3: Detect LPI invalidation MMIO registers
  irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP

 drivers/irqchip/irq-gic-v3.c       | 51 +++++++++++++++---------------
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.34.1

