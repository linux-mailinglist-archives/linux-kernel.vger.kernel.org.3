Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD7522B90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiEKFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiEKFQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:16:36 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EB9441638;
        Tue, 10 May 2022 22:16:32 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CF3621E80D6B;
        Wed, 11 May 2022 13:11:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hdh699IbcE_1; Wed, 11 May 2022 13:11:05 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0C5031E80D08;
        Wed, 11 May 2022 13:11:05 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: The return type of the function could be void
Date:   Wed, 11 May 2022 13:16:05 +0800
Message-Id: <20220511051605.103574-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perhaps the return value of the function is not used.
it may be possible to optimize the execution instructions.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/kernel/acpi/boot.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0d01e7f5078c..7e32e33d52fa 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -375,7 +375,7 @@ static void __init mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
 	isa_irq_to_gsi[bus_irq] = gsi;
 }
 
-static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
+static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 			int polarity)
 {
 #ifdef CONFIG_X86_MPPARSE
@@ -387,9 +387,9 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	u8 pin;
 
 	if (!acpi_ioapic)
-		return 0;
+		return;
 	if (!dev || !dev_is_pci(dev))
-		return 0;
+		return;
 
 	pdev = to_pci_dev(dev);
 	number = pdev->bus->number;
@@ -408,7 +408,6 @@ static int mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 
 	mp_save_irq(&mp_irq);
 #endif
-	return 0;
 }
 
 static int __init mp_register_ioapic_irq(u8 bus_irq, u8 polarity,
-- 
2.18.2

