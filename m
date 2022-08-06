Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6A58B540
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiHFLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiHFLms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:42:48 -0400
Received: from mailgate.osadl.org (mailgate.osadl.org [IPv6:2001:a60:9266:ffff:62:245:132:113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8539913E15
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:42:46 -0700 (PDT)
Received: from localmail.osadl.org (localmail.osadl.org [192.168.115.248])
        by mailgate.osadl.org (Postfix) with ESMTP id DC2D7300C5A;
        Sat,  6 Aug 2022 13:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osadl.org; s=default;
        t=1659785619; bh=QWnGpkn0KjPYyzuZJV5wYqLgFxdPZTLFrmKe2mahP3E=;
        h=Date:From:To:Cc:Subject:References:From;
        b=Aax0HAlsRqLaUzhaIjZvVkcaA0QQCdAEbu2HPQ7wt1Dx3cAWRN2jGmNOl4tQlnYO8
         HXMMpqn75TokctR44dnifnuY+61Y3SMiV/GKnHYhOcDllwSm4GG6Tv2anHAV4VQuvE
         G54un5STu0Z595/HAON31gAw+55V9r5LgdyDYtAU=
Received: from localhost (localhost [127.0.0.1])
        by localmail.osadl.org (Postfix) with ESMTP id A91DD8C2D74;
        Sat,  6 Aug 2022 13:33:35 +0200 (CEST)
Received: from localmail.osadl.org ([127.0.0.1])
        by localhost (localmail.osadl.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id d12xIJorxhyZ; Sat,  6 Aug 2022 13:33:34 +0200 (CEST)
Received: from rack0slot6s.osadl.org (rack0slot6s.osadl.org [192.168.114.6])
        by localmail.osadl.org (Postfix) with ESMTP id 559B49CC7DF;
        Sat,  6 Aug 2022 13:33:33 +0200 (CEST)
Received: from rack0slot6s.osadl.org (localhost [127.0.0.1])
        by rack0slot6s.osadl.org (8.17.1/8.15.2) with ESMTP id 276BXYle4095582;
        Sat, 6 Aug 2022 13:33:34 +0200
Received: (from root@localhost)
        by rack0slot6s.osadl.org (8.17.1/8.17.1/Submit) id 276BXYgW4095581;
        Sat, 6 Aug 2022 13:33:34 +0200
Message-ID: <20220806113334.349537884@osadl.org>
User-Agent: quilt/0.66
Date:   Sat, 06 Aug 2022 13:31:26 +0200
From:   Alexander Baehr <abaehr@osadl.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Add parport support for Asix device 99100
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

For some reason, Asix decided to produce a parallel port that is fully
compatible with Netmos device 9900, but named it 99100. It obviously has
another vendor ID, but the device ID is the same. This patch adds the 
required settings and was successfully tested with the Asix device. 

Signed-off-by: Alexander Baehr <abaehr@osadl.org>
---
 drivers/parport/parport_pc.c |    4 ++++
 include/linux/pci_ids.h      |    3 +++
 2 files changed, 7 insertions(+)

Index: linux/drivers/parport/parport_pc.c
===================================================================
--- linux.orig/drivers/parport/parport_pc.c
+++ linux/drivers/parport/parport_pc.c
@@ -2612,6 +2612,7 @@ enum parport_pc_pci_cards {
 	netmos_9815,
 	netmos_9901,
 	netmos_9865,
+	asix_ax99100,
 	quatech_sppxp100,
 	wch_ch382l,
 };
@@ -2766,6 +2767,9 @@ static const struct pci_device_id parpor
 	  0xA000, 0x1000, 0, 0, netmos_9865 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 	  0xA000, 0x2000, 0, 0, netmos_9865 },
+	/* Asix AX99100 Parallel port PCIExpressCard */
+	{ PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_AX99100,
+	  0xA000, 0x2000, 0, 0, netmos_9900 },
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
Index: linux/include/linux/pci_ids.h
===================================================================
--- linux.orig/include/linux/pci_ids.h
+++ linux/include/linux/pci_ids.h
@@ -3108,4 +3108,7 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_ASIX		0x125b
+#define PCI_DEVICE_ID_AX99100		0x9100
+
 #endif /* _LINUX_PCI_IDS_H */

