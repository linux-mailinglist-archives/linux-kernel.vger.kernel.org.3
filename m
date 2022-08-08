Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF2858C513
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiHHIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHHIxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:53:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AC8CE12
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43FFAB80E2B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43F5C433C1;
        Mon,  8 Aug 2022 08:53:34 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] irqchip: Select downstream irqchip drivers for LoongArch CPU
Date:   Mon,  8 Aug 2022 16:53:19 +0800
Message-Id: <20220808085319.3350111-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch irqchips have a fixed hierarchy which currently can't be
described by ACPI tables, so upstream irqchip drivers call downstream
irqchip drivers' initialization directly. As a result, the top level
(CPU-level) irqchip driver should explicitly select downstream drivers
to avoid build errors.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 66b9fa408bf2..2549daa859d6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -561,6 +561,11 @@ config IRQ_LOONGARCH_CPU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select LOONGSON_LIOINTC
+	select LOONGSON_EIOINTC
+	select LOONGSON_PCH_PIC
+	select LOONGSON_PCH_MSI
+	select LOONGSON_PCH_LPC
 	help
 	  Support for the LoongArch CPU Interrupt Controller. For details of
 	  irq chip hierarchy on LoongArch platforms please read the document
-- 
2.31.1

