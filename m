Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA1E58B53F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiHFLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiHFLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:42:47 -0400
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 04:42:46 PDT
Received: from mailgate.osadl.org (mailgate.osadl.org [IPv6:2001:a60:9266:ffff:62:245:132:113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551313E16
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:42:46 -0700 (PDT)
Received: from localmail.osadl.org (localmail.osadl.org [192.168.115.248])
        by mailgate.osadl.org (Postfix) with ESMTP id C008F3004F5;
        Sat,  6 Aug 2022 13:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osadl.org; s=default;
        t=1659785617; bh=UNSI5Zv8IYk9zXalyAjR3a28uCoXKKLaxxdoIkJSAy8=;
        h=Date:From:To:Cc:Subject:References:From;
        b=kB/VkATX+fpPK2a2WcRqh2IufPziHU6Fps5io58oW54TGkbVHe7LBIHDA9/WnMCSS
         m7jMBxvXkvMeSZR4t+3HrIXB3cRHuIzMnUMKAeOzYmHyWGJQX0PX+tS9FL/r//lkxm
         CAJXOZQo9CyGLeDBovf05sbQbuoMZB2GGnQ2AncM=
Received: from localhost (localhost [127.0.0.1])
        by localmail.osadl.org (Postfix) with ESMTP id 879FB8BBBF5;
        Sat,  6 Aug 2022 13:33:34 +0200 (CEST)
Received: from localmail.osadl.org ([127.0.0.1])
        by localhost (localmail.osadl.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T6rYvVQpa_nN; Sat,  6 Aug 2022 13:33:33 +0200 (CEST)
Received: from rack0slot6s.osadl.org (rack0slot6s.osadl.org [192.168.114.6])
        by localmail.osadl.org (Postfix) with ESMTP id 468B38C2D74;
        Sat,  6 Aug 2022 13:33:33 +0200 (CEST)
Received: from rack0slot6s.osadl.org (localhost [127.0.0.1])
        by rack0slot6s.osadl.org (8.17.1/8.15.2) with ESMTP id 276BXYGD4095551;
        Sat, 6 Aug 2022 13:33:34 +0200
Received: (from root@localhost)
        by rack0slot6s.osadl.org (8.17.1/8.17.1/Submit) id 276BXY5s4095550;
        Sat, 6 Aug 2022 13:33:34 +0200
Message-ID: <20220806113334.264598686@osadl.org>
User-Agent: quilt/0.66
Date:   Sat, 06 Aug 2022 13:31:25 +0200
From:   Alexander Baehr <abaehr@osadl.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Add parport support for Netmos device 9900
References: <20220806113124.608017725@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Virus-Scanned: clamav-milter 0.103.6 at mailgate
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Netmos parallel port 9901 was already supported but the device 9900 was
not. This patch adds the required settings for it and was successfully 
tested with the Netmos device 9900.

Signed-off-by: Alexander Baehr <abaehr@osadl.org>
---
 drivers/parport/parport_pc.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-5.19.0-rt7/drivers/parport/parport_pc.c
===================================================================
--- linux-5.19.0-rt7.orig/drivers/parport/parport_pc.c
+++ linux-5.19.0-rt7/drivers/parport/parport_pc.c
@@ -2604,6 +2604,7 @@ enum parport_pc_pci_cards {
 	oxsemi_pcie_pport,
 	aks_0100,
 	mobility_pp,
+	netmos_9900,
 	netmos_9705,
 	netmos_9715,
 	netmos_9755,
@@ -2665,6 +2666,7 @@ static struct parport_pc_pci {
 	/* oxsemi_pcie_pport */		{ 1, { { 0, 1 }, } },
 	/* aks_0100 */                  { 1, { { 0, -1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
+	/* netmos_9900 */		{ 1, { { 0, -1 }, } },
 
 	/* The netmos entries below are untested */
 	/* netmos_9705 */               { 1, { { 0, -1 }, } },
@@ -2746,6 +2748,8 @@ static const struct pci_device_id parpor
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, aks_0100 },
 	{ 0x14f2, 0x0121, PCI_ANY_ID, PCI_ANY_ID, 0, 0, mobility_pp },
 	/* NetMos communication controllers */
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
+	  0xA000, 0x2000, 0, 0, netmos_9900 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,

