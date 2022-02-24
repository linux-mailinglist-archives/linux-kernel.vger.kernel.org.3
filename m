Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B84C390F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiBXWs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiBXWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:48:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A06114CC93;
        Thu, 24 Feb 2022 14:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 244F061B8D;
        Thu, 24 Feb 2022 22:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EB4C340F1;
        Thu, 24 Feb 2022 22:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742896;
        bh=Ff3IUUwoIObttBwWLMVgQzpTBcZO2rFbOCa2sCguBGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qS4sH7wBPQeTNttTMIj0rRA1e8nOYYrf0I1Mhvhzo0I+cc27Kd5uVT6wpVD4jjdwE
         Na6UZS6Qbt/tWJSEaLITFUwUO+ssqwVjnXU6CJnWuk8vaKoN+X2is9Tr1C3ynCzj6e
         T/6sCQP74N0m356+ACVz6O8UupyzWBWC6KpgPQ589GbOP7jNYN+z2quyHfGbDXFxqQ
         Xe8DhfpD6EauA4QgrCe1udcDtcn2G0a3kimTK5lOOCSNW9TySc54uP8QMro+GYPSe9
         YASTi0ak5qXmoSn/OGbhuVv/xlVbGIhPeN6kuneROrIxxBLelywTJTW4ST9jnrivB0
         cAymdXIrBqMGg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Axtens <dja@axtens.net>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v9 06/11] PCI/VGA: Move non-legacy VGA detection to ADD_DEVICE path
Date:   Thu, 24 Feb 2022 16:47:48 -0600
Message-Id: <20220224224753.297579-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224224753.297579-1-helgaas@kernel.org>
References: <20220224224753.297579-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

a37c0f48950b ("vgaarb: Select a default VGA device even if there's no
legacy VGA") extended the vga_arb_device_init() subsys_initcall so it could
select a non-legacy VGA device as the default.

That failed to consider that PCI devices may be enumerated after
vga_arb_device_init(), e.g., hot-added devices or non-ACPI systems that do
PCI enumeration in pcibios_init().  Devices found then could never be
selected as the default.

One system where this is a problem is the MIPS-based Loongson where an
ASpeed AST2500 VGA device is behind a bridge that doesn't implement the VGA
Enable bit, so legacy resources are not routed to the VGA device. [1]

Fix this by moving the non-legacy VGA device selection from
vga_arb_select_default_device() to vga_arbiter_add_pci_device(), which is
called after every PCI device is enumerated, either by the
vga_arb_device_init() subsys_initcall or as an ADD_DEVICE notifier.

[1] https://lore.kernel.org/r/20210514080025.1828197-6-chenhuacai@loongson.cn

[bhelgaas: commit log, restructure]
Link: https://lore.kernel.org/r/20211015061512.2941859-5-chenhuacai@loongson.cn
Link: https://lore.kernel.org/r/20211015061512.2941859-7-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/vgaarb.c | 54 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c3323ab4f98e..e36ccbfdbd89 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -624,6 +624,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 {
 	struct vga_device *boot_vga = vgadev_find(vga_default_device());
 	struct pci_dev *pdev = vgadev->pdev;
+	u16 cmd, boot_cmd;
 
 	/*
 	 * We select the default VGA device in this order:
@@ -661,6 +662,37 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
 		return true;
 
+	/*
+	 * If we haven't found a legacy VGA device, accept a non-legacy
+	 * device.  It may have either IO or MEM enabled, and bridges may
+	 * not have PCI_BRIDGE_CTL_VGA enabled, so it may not be able to
+	 * use legacy VGA resources.  Prefer an integrated GPU over others.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+
+		/*
+		 * An integrated GPU overrides a previous non-legacy
+		 * device.  We expect only a single integrated GPU, but if
+		 * there are more, we use the *last* because that was the
+		 * previous behavior.
+		 */
+		if (vga_arb_integrated_gpu(&pdev->dev))
+			return true;
+
+		/*
+		 * We prefer the first non-legacy discrete device we find.
+		 * If we already found one, vgadev is no better.
+		 */
+		if (boot_vga) {
+			pci_read_config_word(boot_vga->pdev, PCI_COMMAND,
+					     &boot_cmd);
+			if (boot_cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
+				return false;
+		}
+		return true;
+	}
+
 	return false;
 }
 
@@ -1529,30 +1561,8 @@ static struct miscdevice vga_arb_device = {
 
 static void __init vga_arb_select_default_device(void)
 {
-	struct pci_dev *pdev, *found = NULL;
 	struct vga_device *vgadev;
 
-	if (!vga_default_device()) {
-		list_for_each_entry_reverse(vgadev, &vga_list, list) {
-			struct device *dev = &vgadev->pdev->dev;
-			u16 cmd;
-
-			pdev = vgadev->pdev;
-			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-				found = pdev;
-				if (vga_arb_integrated_gpu(dev))
-					break;
-			}
-		}
-	}
-
-	if (found) {
-		vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
-		vga_set_default_device(found);
-		return;
-	}
-
 	if (!vga_default_device()) {
 		vgadev = list_first_entry_or_null(&vga_list,
 						  struct vga_device, list);
-- 
2.25.1

