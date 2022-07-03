Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E45644C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGCEfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGCEfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:35:21 -0400
X-Greylist: delayed 767 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Jul 2022 21:35:20 PDT
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A83D265F2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:35:20 -0700 (PDT)
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
        by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 2634MI5g014737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 3 Jul 2022 00:22:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lancer.cnet.absolutedigital.net (8.17.1/8.17.1) with ESMTPS id 2634MIq1005330
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 3 Jul 2022 00:22:18 -0400
Date:   Sun, 3 Jul 2022 00:22:18 -0400 (EDT)
From:   Cal Peake <cp@absolutedigital.net>
To:     Kernel Mailing List <linux-kernel@vger.kernel.org>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [RFC] vgaarb: Add a module parm to use the first VGA device for
 boot
Message-ID: <5e3f182f-7b6e-5c7f-d9a9-7cd1417cc38d@absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual GPU system with the GPU in the first CPU PCIe slot for the 
host and the GPU in the second CPU PCIe slot being passed through to a 
virtual machine.

Currently, the VGA arbiter enumerates through all VGA devices in the order 
that they appear in on the bus with the last one ultimately getting the 
assignment for boot device.

This is a problem because once the VFIO PCI driver claims the second GPU, 
all display output is lost -- just empty black screens on both cards.

Setting VGA_ARB_MAX_GPUS to 1 helps a little: the X server will initialize 
on the first GPU like it should, but there's no VTs to be found (i.e. 
Alt-F1/F2/etc), just more black screens.

Below is an attempt at a fix by creating a kernel param to have the VGA 
arbiter use the first VGA device it finds for the boot device and then 
subsequently ignore the rest for this task.

-- 
Cal Peake

--- ./drivers/pci/vgaarb.c	2022-07-02 10:44:56.000000000 -0400
+++ ./drivers/pci/vgaarb.c	2022-07-02 22:55:24.291822548 -0400
@@ -35,6 +35,10 @@
 
 #include <linux/vgaarb.h>
 
+static bool use_first;
+module_param(use_first, bool, 0);
+MODULE_PARM_DESC(force, "Set to one to use the first VGA device for boot");
+
 static void vga_arbiter_notify_clients(void);
 /*
  * We keep a list of all vga devices in the system to speed
@@ -815,7 +819,8 @@ static bool vga_arbiter_add_pci_device(s
 		bus = bus->parent;
 	}
 
-	if (vga_is_boot_device(vgadev)) {
+	if (vga_is_boot_device(vgadev) &&
+	    (!use_first || (use_first && !vga_default_device()))) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
 			    vga_default_device() ?
 			    " (overriding previous)" : "");
