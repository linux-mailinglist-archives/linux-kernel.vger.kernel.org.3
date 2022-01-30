Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB94A368D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354952AbiA3N5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354919AbiA3N5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:57:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29324C061741;
        Sun, 30 Jan 2022 05:57:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7E33B82947;
        Sun, 30 Jan 2022 13:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED348C340F1;
        Sun, 30 Jan 2022 13:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643551017;
        bh=d2YKiYzP01A3mCNJHUZ74cocdKYQgHlJs70hqz+NyK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPfx8A43HO5Np1lZuZnuLPq4FCXdBUZQb23c26v5DJbWOcuusw2mR+LTjUuZTGPYO
         7pbjmL57V8uGn7o1HZjAFImDlAOxZeEeDfBPXCjv7GQ43pgiecsjcpFaHJBMDRtW0h
         sfoC6Np5LVCuZBeU8NNAYzQQGgtqoM2JkUjNl2WGCxJdlpAMQQM/+fqMjQL9sdGPdm
         2hwYbafbVYQbbkOsgzx6ot2Yv5MV2P7LJmDpug6D1pjR3D/+JmcAC+W13DeWitpmKX
         EQgnvajcUUZuGjsXVPvIrDkKDyz2q1G7HWMpwSCQ5oS5iDrTq9FJgCWxx4QTk0W1EB
         uqY1M2Okquq4w==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V7 2/2] irqchip/sifive-plic: Fixup thead,c900-plic DT parse missing
Date:   Sun, 30 Jan 2022 21:56:34 +0800
Message-Id: <20220130135634.1213301-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130135634.1213301-1-guoren@kernel.org>
References: <20220130135634.1213301-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The thead,c900-plic has been used in opensbi to distinguish
PLIC [1]. Although PLICs have the same behaviors in Linux,
they are different hardware with some custom initializing in
firmware(opensbi).

Qute opensbi patch commit-msg by Samuel:

  The T-HEAD PLIC implementation requires setting a delegation bit
  to allow access from S-mode. Now that the T-HEAD PLIC has its own
  compatible string, set this bit automatically from the PLIC driver,
  instead of reaching into the PLIC's MMIO space from another driver.

[1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-sifive-plic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 259065d271ef..09cc98266d30 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -398,3 +398,4 @@ static int __init plic_init(struct device_node *node,
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
-- 
2.25.1

