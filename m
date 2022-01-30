Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6E4A3689
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354913AbiA3N4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:56:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354884AbiA3N4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:56:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E11CD611B7;
        Sun, 30 Jan 2022 13:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740B9C340E4;
        Sun, 30 Jan 2022 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551010;
        bh=1sPl3NSM08VjPi9+rS/IUYV3N8w8NQxRz2BnPpJHYRc=;
        h=From:To:Cc:Subject:Date:From;
        b=Fa19yYcmL2D6j0iZ1MqkcwSu6GVV8dCMFIjWd1467v45ZZiL5vnTB1YOY2BP43lkb
         MTxpLJe9h4JNpzMa7NXZg/BmHitqI9tE7hXQlncpnCbUfWi0lsS/AxPhP8tw7QC2hM
         x4AlaWTk1cBjaryuJ/iydpBOrNtQwqwr40Yzyhsleq1bkIJIhCRREsCoItQDrmW1Ff
         cCLOXTmyHhfZZs7/qb2ZePatuHCgzyYgZHuTBCAmRDRRAhF1rp83N136qSUtzVxntr
         bhVqbyIiISGCr70/rdLa3oa7s7R66f4k/HW2DOQK3MjYkHwT4wMG9oq+DLl10yHYD4
         7EtatdJupPAYw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V7 0/2] Add thead,c900-plic support
Date:   Sun, 30 Jan 2022 21:56:32 +0800
Message-Id: <20220130135634.1213301-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Changes since V7:
 - Remove /proc/interrupts display part modification

Changes since V6:
 - Modify sifive,plic-1.0.0.yaml comment
 - Remove vendor-prefixes patch which has been merged
 - Only put dt naming distinguish in sifive-plic.c

Changes since V5:
 - Move back to mask/unmask
 - Fixup the problem in eoi callback
 - Remove allwinner,sun20i-d1 IRQCHIP_DECLARE
 - Rewrite comment log
 - Add DT list
 - Fixup compatible string
 - Remove allwinner-d1 compatible
 - make dt_binding_check
 - Add T-head vendor-prefixes

Changes since V4:
 - Update description in errata style
 - Update enum suggested by Anup, Heiko, Samuel
 - Update comment by Anup
 - Add cover-letter

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add thead,c900-plic in the description section
 - Add sifive_plic_chip and thead_plic_chip for difference

Changes since V2:
 - Add a separate compatible string "thead,c9xx-plic"
 - set irq_mask/unmask of "plic_chip" to NULL and point
   irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
 - Add a detailed comment block in plic_init() about the
   differences in Claim/Completion process of RISC-V PLIC and C9xx
   PLIC.

Guo Ren (2):
  dt-bindings: update riscv plic compatible string
  irqchip/sifive-plic: Fixup thead,c900-plic DT parse missing

 .../sifive,plic-1.0.0.yaml                    | 21 +++++++++++++------
 drivers/irqchip/irq-sifive-plic.c             |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.25.1

