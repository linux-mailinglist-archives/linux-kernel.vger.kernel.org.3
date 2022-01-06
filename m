Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55223485CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbiAFAHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:07:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41578 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbiAFAHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:07:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A3061987;
        Thu,  6 Jan 2022 00:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA7C36AE9;
        Thu,  6 Jan 2022 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427634;
        bh=K0y7QggNHlzbzB8D6oSqovym2Z+AebEc1LqQytG+NKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPJltldSQV1luY4tZPLwFyFKmDwk/dGZma6fTZ8EaszahfFDvJv2v2Z666/XNLHSi
         TIWCrQvwTx6IZ6lRT7E9EfviNxVp2+9KYAIyGEIctlE37Vvqkoxf1QBx84pMP+8Idt
         MWgN1I571Xmv0d9K6Lox4/BGriQk7Vw0/uO/uBTQu0K1hwI+i1I2gJRMZdEZlh8fqq
         P5pkvSAXxiynATy/mb7UePFT54T5lB4UA1zNsrCAuFS9CtmwgP9es+yCUL5e58sqHN
         Hs/KaYJUSXEOxTgN1+pXplNnVTHC10xztiPq+83qR8Bk9CKsYgLVqmzuKNrixIJ7vP
         WhTtmJe67ZKdA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 01/10] vgaarb: Move vga_arb_integrated_gpu() earlier in file
Date:   Wed,  5 Jan 2022 18:06:49 -0600
Message-Id: <20220106000658.243509-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

Move vga_arb_integrated_gpu() earlier in file to prepare for future patch.
No functional change intended.

[bhelgaas: pull #ifdefs inside function]
Link: https://lore.kernel.org/r/20211015061512.2941859-3-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 569930552957..ef5ad4c432f5 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -565,6 +565,17 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 }
 EXPORT_SYMBOL(vga_put);
 
+static bool vga_arb_integrated_gpu(struct device *dev)
+{
+#if defined(CONFIG_ACPI)
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
+#else
+	return false;
+#endif
+}
+
 /*
  * Rules for using a bridge to control a VGA descendant decoding: if a bridge
  * has only one VGA descendant then it can be used to control the VGA routing
@@ -1430,20 +1441,6 @@ static struct miscdevice vga_arb_device = {
 	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
 };
 
-#if defined(CONFIG_ACPI)
-static bool vga_arb_integrated_gpu(struct device *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	return adev && !strcmp(acpi_device_hid(adev), ACPI_VIDEO_HID);
-}
-#else
-static bool vga_arb_integrated_gpu(struct device *dev)
-{
-	return false;
-}
-#endif
-
 static void __init vga_arb_select_default_device(void)
 {
 	struct pci_dev *pdev, *found = NULL;
-- 
2.25.1

