Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23F53F4B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiFGDoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiFGDoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:44:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886D140FC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24789B81C9D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28A2C341CD;
        Tue,  7 Jun 2022 03:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573434;
        bh=b9BcifJmuM9hpypmBa0Q+6nLkqSLsHoLg75vHPP8dyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AptQUv1XrPWPKEqClascNcqUNXqJy/5kYO4t7H6/yqvGGrU6m1k04fAcuyWasUdl3
         jKuYPKMY89VjQo/vmJ//qE6yVVmW9YehuNaPtdnjOht6TdiSGm4wVtE/NiIXoLz8he
         VpSRvt7wxFL8xGpINJVCONq8ed5mxmtMcLspmcvfIqxzkU2EaeVW6ohjjqCUVOUtMX
         aTmBmU6D+zbMlOyLdR68ixenOeBvYwo+0/vSlcL2wiS82sf15PbS6zs8VP1vS5ZkTq
         ry5iUFB0ODQLkTTxED7zA4NaESgGlooKCfaaXRE+MPaWgYbDYBFoBYfzEAyLrOzB7p
         eQxKhKwNK3N9g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-pm@vger.org,
        linux-pci@vger.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] agp/efficeon: Convert to generic power management
Date:   Mon,  6 Jun 2022 22:43:36 -0500
Message-Id: <20220607034340.307318-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607034340.307318-1-helgaas@kernel.org>
References: <20220607034340.307318-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Convert agpgart-efficeon from legacy PCI power management to the generic
power management framework.

Previously agpgart-efficeon used legacy PCI power management, which means
agp_efficeon_suspend() and agp_efficeon_resume() were responsible for both
device-specific things and generic PCI things like saving and restoring
config space and managing power state.

In this case, agp_efficeon_suspend() was empty, and agp_efficeon_resume()
already did only device-specific things, so the conversion is trivial.

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/efficeon-agp.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index c53f0f9ef5b0..7cf2c9b0bb02 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -412,18 +412,11 @@ static void agp_efficeon_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	return 0;
-}
-
-static int agp_efficeon_resume(struct pci_dev *pdev)
+static int __maybe_unused agp_efficeon_resume(struct device *dev)
 {
 	printk(KERN_DEBUG PFX "agp_efficeon_resume()\n");
 	return efficeon_configure();
 }
-#endif
 
 static const struct pci_device_id agp_efficeon_pci_table[] = {
 	{
@@ -437,6 +430,8 @@ static const struct pci_device_id agp_efficeon_pci_table[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(agp_efficeon_pm_ops, NULL, agp_efficeon_resume);
+
 MODULE_DEVICE_TABLE(pci, agp_efficeon_pci_table);
 
 static struct pci_driver agp_efficeon_pci_driver = {
@@ -444,10 +439,7 @@ static struct pci_driver agp_efficeon_pci_driver = {
 	.id_table	= agp_efficeon_pci_table,
 	.probe		= agp_efficeon_probe,
 	.remove		= agp_efficeon_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_efficeon_suspend,
-	.resume		= agp_efficeon_resume,
-#endif
+	.driver.pm	= &agp_efficeon_pm_ops,
 };
 
 static int __init agp_efficeon_init(void)
-- 
2.25.1

