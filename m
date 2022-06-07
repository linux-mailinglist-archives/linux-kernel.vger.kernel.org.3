Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4453F4B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiFGDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiFGDoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784ADF6D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 918236147B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C245BC385A5;
        Tue,  7 Jun 2022 03:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573441;
        bh=vUzLjtPwzoaP7TRsqSkjtMaIqR3JAQ19EInCEB4H5wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT2KwESoUkjCiboXWNDXhrHi/8cT1Ko5ETNckzxpuQ5Af11/nQfBRgzIkfXUeEFu7
         FUvHr6B8f4tpRT9KLSjhtobDzXE12IQKW5ylmoVnk+sHRGRUmTheH0C+GXeFAxAtOD
         aXf9S7B1vriqEw2MX2w15EOnFjjwRpWtiTGRHrPVy7q0ss/Nyv9N/0g4kGzj3wCNPy
         FUoG2vF1K9J4brGsjkBRgTosWhcUe6xT8taLUr/BhqFQ2PlkR3u0+rzZJXkWviFdz0
         9b9AaaZ3thlJzn5mhSdb9ffdqnekmfe8nn9Uy2lpcKHGr2OUragNlQrEh7cjrOiqXN
         EhPX9Lp3QDdjA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-pm@vger.org,
        linux-pci@vger.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] agp/amd-k7: Convert to generic power management
Date:   Mon,  6 Jun 2022 22:43:38 -0500
Message-Id: <20220607034340.307318-4-helgaas@kernel.org>
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

Convert agpgart-amdk7 from legacy PCI power management to the generic power
management framework.

Previously agpgart-amdk7 used legacy PCI power management, and
agp_amdk7_suspend() and agp_amdk7_resume() were responsible for both
device-specific things and generic PCI things like saving and restoring
config space and managing power state:

  agp_amdk7_suspend
    pci_save_state                         <-- generic PCI
    pci_set_power_state                    <-- generic PCI

  agp_amdk7_resume
    pci_set_power_state(PCI_D0)            <-- generic PCI
    pci_restore_state                      <-- generic PCI
    amd_irongate_driver.configure          <-- device-specific

Convert to generic power management where the PCI bus PM methods do the
generic PCI things, and the driver needs only the device-specific part,
i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                       # PCI bus .suspend() method
        agp_amdk7_suspend                  <-- not needed at all; removed
    suspend_enter
      dpm_suspend_noirq(PMSG_SUSPEND)
        pci_pm_suspend_noirq               # PCI bus .suspend_noirq() method
          pci_save_state                   <-- generic PCI
          pci_prepare_to_sleep             <-- generic PCI
            pci_set_power_state
    ...
    dpm_resume_end(PMSG_RESUME)
      pci_pm_resume                        # PCI bus .resume() method
        pci_restore_standard_config
          pci_set_power_state(PCI_D0)      <-- generic PCI
          pci_restore_state                <-- generic PCI
        agp_amdk7_resume                   # driver->pm->resume
          amd_irongate_driver.configure    <-- device-specific

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/amd-k7-agp.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 2b2095542816..cf8023e57acd 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -488,26 +488,11 @@ static void agp_amdk7_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-
-static int agp_amdk7_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_amdk7_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_amdk7_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	return amd_irongate_driver.configure();
 }
 
-#endif /* CONFIG_PM */
-
 /* must be the same order as name table above */
 static const struct pci_device_id agp_amdk7_pci_table[] = {
 	{
@@ -539,15 +524,14 @@ static const struct pci_device_id agp_amdk7_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_amdk7_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_amdk7_pm_ops, NULL, agp_amdk7_resume);
+
 static struct pci_driver agp_amdk7_pci_driver = {
 	.name		= "agpgart-amdk7",
 	.id_table	= agp_amdk7_pci_table,
 	.probe		= agp_amdk7_probe,
 	.remove		= agp_amdk7_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_amdk7_suspend,
-	.resume		= agp_amdk7_resume,
-#endif
+	.driver.pm	= &agp_amdk7_pm_ops,
 };
 
 static int __init agp_amdk7_init(void)
-- 
2.25.1

