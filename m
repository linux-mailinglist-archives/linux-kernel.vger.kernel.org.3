Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C783D4F4F90
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453336AbiDFAyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573268AbiDESlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F620BE2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABDE8618C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6BC385A0;
        Tue,  5 Apr 2022 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649183944;
        bh=GxkC3BM8itKuAYCG/H+2rgsrkkvvKBJ+L8trZN5gEs4=;
        h=From:To:Cc:Subject:Date:From;
        b=FiSlqTWJ3wivFbufxEnkH6e9T1Qi6WBzkvWLBME6e35Bzo3e5WYf14X/JGesI3tJS
         LISJ+4cBmzKsRUWdo04LCry22HjfsK4T0B4sK7a96BAzEnRj5LNn2Rrwo5WJPVrbjK
         TkqQCwlTxcjRxTj94Rx63tdYup5ntjRRI12JQiHJ4vVF+Lwczg6/o5krkuBg5E6uxQ
         PxXMVuxlHL2JGfVMMXXjFlMzsxhfKDbIkjMKQyc7olusQKfOrsF2lqVtmrUlzQkgjK
         U+Pp+YhT4W1XeQm7SQAUqCpHeF64Nv7dzPNYqjHEgekv9RvXi0YLBncWajAXgmUXg1
         dVAMPQ/efJi+w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbo50-001tkq-2E; Tue, 05 Apr 2022 19:39:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 0/3] irqchip/gic-v3: Assorted improvements
Date:   Tue,  5 Apr 2022 19:38:54 +0100
Message-Id: <20220405183857.205960-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, eric.auger@redhat.com
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

This is a small series that happens on the back of [0] (implementing
additional features in KVM's vgic) and allows for a couple of
performance optimisations.

Thanks,

        M.

* From v1 [1]:
  - Moved the RWP polling fix to -fixes, to be merged independently
  - Fixed bit numbers for CES and IR
  - Added some comments about the respective relations between
    DirectLPIs, RVPEID and IR.
  - Some cosmetic changes
  - Rebased on 5.18-rc1

[0] https://lore.kernel.org/r/20220405182327.205520-1-maz@kernel.org
[1] https://lore.kernel.org/r/20220315165034.794482-1-maz@kernel.org

Marc Zyngier (3):
  irqchip/gic-v3: Exposes bit values for GICR_CTLR.{IR,CES}
  irqchip/gic-v3: Detect LPI invalidation MMIO registers
  irqchip/gic-v3: Relax polling of GIC{R,D}_CTLR.RWP

 drivers/irqchip/irq-gic-v3.c       | 58 +++++++++++++++++-------------
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 2 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.34.1

