Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8073253F4B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbiFGDox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiFGDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9E915FDD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1203C61478
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECCDC385A5;
        Tue,  7 Jun 2022 03:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573445;
        bh=3OMGL+yTwFPdMPpm7sJOFqe0eX9H9gVe0RUbQa9rSWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMq/WN9eKmOK/EdjuyyGqFGJ0KfUUOEmOusaPcsqMLvpyOqTYzU9iQqbyDO3lgKI1
         FBUyQyHxzgaeVndFN9f1kh3l2lLHbStWNbh8LThuN/Uj4VDEg9cDXowFc3FgFdETHX
         vf4rvRCSJRJncN1otflIpmJByxrf0m/mlWTD25jmmTSIQa3VbGoeT0qCSmSFlCRfi9
         G+WmKDKDVdrU3A3ebwvXzFlNlDJ+JnVwrqIJlkQS7vAxtQCIaKxzbSDlqzJLFfrGI6
         rWIE3RKob0pZYsgwWBR42tKrV4NNZmO3HIg8gIPrjzWgEtigHRGFLaXWZNMpJEKi/0
         jtbxKNAWkre4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-pm@vger.org,
        linux-pci@vger.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] agp/nvidia: Convert to generic power management
Date:   Mon,  6 Jun 2022 22:43:40 -0500
Message-Id: <20220607034340.307318-6-helgaas@kernel.org>
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

Convert agpgart-nvidia from legacy PCI power management to the generic
power management framework.

Previously agpgart-nvidia used legacy PCI power management, and
agp_nvidia_suspend() and agp_nvidia_resume() were responsible for both
device-specific things and generic PCI things:

  agp_nvidia_suspend
    pci_save_state                         <-- generic PCI
    pci_set_power_state(PCI_D3hot)         <-- generic PCI

  agp_nvidia_resume
    pci_set_power_state(PCI_D0)            <-- generic PCI
    pci_restore_state                      <-- generic PCI
    nvidia_configure                       <-- device-specific

Convert to generic power management where the PCI bus PM methods do the
generic PCI things, and the driver needs only the device-specific part,
i.e.,

  suspend_devices_and_enter
    dpm_suspend_start(PMSG_SUSPEND)
      pci_pm_suspend                       # PCI bus .suspend() method
        agp_nvidia_suspend                 <-- not needed at all; removed
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
        agp_nvidia_resume                  # driver->pm->resume
          nvidia_configure                 <-- device-specific

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/nvidia-agp.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 826dbd06f6bb..d63e90410d23 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -404,28 +404,13 @@ static void agp_nvidia_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-static int agp_nvidia_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_nvidia_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
-
-	return 0;
-}
-
-static int agp_nvidia_resume(struct pci_dev *pdev)
-{
-	/* set power state 0 and restore PCI space */
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	/* reconfigure AGP hardware again */
 	nvidia_configure();
 
 	return 0;
 }
-#endif
-
 
 static const struct pci_device_id agp_nvidia_pci_table[] = {
 	{
@@ -449,15 +434,14 @@ static const struct pci_device_id agp_nvidia_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_nvidia_pm_ops, NULL, agp_nvidia_resume);
+
 static struct pci_driver agp_nvidia_pci_driver = {
 	.name		= "agpgart-nvidia",
 	.id_table	= agp_nvidia_pci_table,
 	.probe		= agp_nvidia_probe,
 	.remove		= agp_nvidia_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_nvidia_suspend,
-	.resume		= agp_nvidia_resume,
-#endif
+	.driver.pm	= &agp_nvidia_pm_ops,
 };
 
 static int __init agp_nvidia_init(void)
-- 
2.25.1

