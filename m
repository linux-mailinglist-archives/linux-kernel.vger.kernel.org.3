Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA14A308C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiA2Q1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352606AbiA2Q1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:27:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216CC061714;
        Sat, 29 Jan 2022 08:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F0F7B827E8;
        Sat, 29 Jan 2022 16:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F416C340E5;
        Sat, 29 Jan 2022 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643473666;
        bh=2CUI7v17Gn0PeGtAaam7tRsozO1B4m6uZjQPozMQ8TI=;
        h=From:To:Cc:Subject:Date:From;
        b=STYxvf2qohRXhpB8jgGZMqyAa8A/+BsfwZzT7cjiDmMvj0/mnwLfgKV5GSX40SQjR
         /lyZsgsvhjdV3X2Bz75kbpT8dsId+rSAjFuXAAvyNZVL6/xiq8NSHIcvTip4VmXuni
         KcYQB7G5lWbvnyjZb4NRfcuZYY9uZRvLWBXyUSxG5BuLluplhmv78x2pbhn6NIokHH
         DaclL2dqT3KzrK4pIJJMDV61y0CNaN59KL8zP+JqMmVxKsv3NDbONRLUH1TaTdJpfe
         tWMcFZEnY/wl6y5usrJ4UfW/x2xf0I+KxyGSaVWnpgiy9gGNcO9bMtfP6bDLmJrN8L
         m3yK4WGf2afOg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V6 0/2] Add thead,c900-plic support
Date:   Sun, 30 Jan 2022 00:27:24 +0800
Message-Id: <20220129162726.1154501-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

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
  irqchip/sifive-plic: Fixup thead,c900-plic dt parse in opensbi

 .../sifive,plic-1.0.0.yaml                    | 21 +++++++++++-----
 drivers/irqchip/irq-sifive-plic.c             | 25 +++++++++++++++++--
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.25.1

