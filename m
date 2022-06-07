Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37753F4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiFGDoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiFGDoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA815FF9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD05661478
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD303C34114;
        Tue,  7 Jun 2022 03:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573438;
        bh=o+mFO5g+IXKydzYGhKxfnzuJL40a+zREWNuXK3fQqeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUkHQdpulvdh0tT7MexVrnvKa5d8SXzJoXCVmogL/l87TEoOx9vFcchISEVSeYn+n
         37iKPy8jaosqKCoZjwdFOMEAEjbxuT0emfA1I1lJnnPrY6VKZmjK2ocN0Oq/5CoZXB
         EZmVPqD8JFyQ/I27/6Zgc5Dq1rkB80k7nE0qOyzTyuY+uBriOAoyIheuQKNqmpDg5a
         KrHDX4/mj8S/Jy9Qk8EASKE94kZKYYYmr2hPTer2UZWAwYNQgalXPdgpaCOs8vUz/W
         2Ms7TYOuhX3s6QYrcKFR7UvC+EmeXtAZuYx5Fltwy+I/gfNc5Vls+hDYisF5zz7KMC
         TNHd9QnA1jKyw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-pm@vger.org,
        linux-pci@vger.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/5] agp/intel: Convert to generic power management
Date:   Mon,  6 Jun 2022 22:43:37 -0500
Message-Id: <20220607034340.307318-3-helgaas@kernel.org>
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

Convert agpgart-intel from legacy PCI power management to the generic power
management framework.

Previously agpgart-intel used legacy PCI power management, and
agp_intel_resume() was responsible for both device-specific things and
generic PCI things like saving and restoring config space and managing
power state.

In this case, agp_intel_suspend() was empty, and agp_intel_resume() already
did only device-specific things, so the conversion is trivial.

Based on 0aeddbd0cb07 ("via-agp: convert to generic power management") by
Vaibhav Gupta <vaibhavgupta40@gmail.com>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/intel-agp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 9e4f27a6cb5a..dbb209a6c62e 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -817,16 +817,15 @@ static void agp_intel_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
-static int agp_intel_resume(struct pci_dev *pdev)
+static int __maybe_unused agp_intel_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
 	bridge->driver->configure();
 
 	return 0;
 }
-#endif
 
 static const struct pci_device_id agp_intel_pci_table[] = {
 #define ID(x)						\
@@ -895,14 +894,14 @@ static const struct pci_device_id agp_intel_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_intel_pm_ops, NULL, agp_intel_resume);
+
 static struct pci_driver agp_intel_pci_driver = {
 	.name		= "agpgart-intel",
 	.id_table	= agp_intel_pci_table,
 	.probe		= agp_intel_probe,
 	.remove		= agp_intel_remove,
-#ifdef CONFIG_PM
-	.resume		= agp_intel_resume,
-#endif
+	.driver.pm	= &agp_intel_pm_ops,
 };
 
 static int __init agp_intel_init(void)
-- 
2.25.1

