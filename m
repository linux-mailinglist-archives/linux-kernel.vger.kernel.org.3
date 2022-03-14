Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FB4D7C08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiCNHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiCNHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:36:54 -0400
X-Greylist: delayed 613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 00:35:44 PDT
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [203.148.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BC40E55;
        Mon, 14 Mar 2022 00:35:44 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 14 Mar
 2022 15:35:42 +0800
Received: from [192.168.43.174] (124.64.16.6) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 14 Mar
 2022 15:35:39 +0800
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in zhaoxin
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
Message-ID: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
Date:   Mon, 14 Mar 2022 15:35:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.64.16.6]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zhaoxin platform, some ehci projects will latch a wakeup signal
internal when plug in a device on port during system S0. This wakeup
signal will turn on when ehci runtime suspend, which will trigger a
system control interrupt that will resume ehci back to D0. As no
device connect, ehci will be set to runtime suspend and turn on the
internal latched wakeup signal again. It will cause a suspend-resume
loop and generate system control interrupt continuously.

Fixed this issue by clear wakeup signal latched in ehci internal when
ehci resume callback is called.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
  drivers/usb/host/ehci-hcd.c | 26 ++++++++++++++++++++++++++
  drivers/usb/host/ehci-pci.c |  4 ++++
  drivers/usb/host/ehci.h     |  1 +
  3 files changed, 31 insertions(+)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 3d82e0b..e4840ef 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1103,6 +1103,30 @@ static void ehci_remove_device(struct usb_hcd 
*hcd, struct usb_device *udev)

  #ifdef CONFIG_PM

+/* Clear wakeup signal locked in zhaoxin platform when device plug in. */
+static void ehci_zx_wakeup_clear(struct ehci_hcd *ehci)
+{
+       u32 __iomem     *reg = &ehci->regs->port_status[4];
+       u32     t1 = ehci_readl(ehci, reg);
+
+       t1 &= (u32)~0xf0000;
+       t1 |= PORT_TEST_FORCE;
+       ehci_writel(ehci, t1, reg);
+       t1 = ehci_readl(ehci, reg);
+       msleep(1);
+       t1 &= (u32)~0xf0000;
+       ehci_writel(ehci, t1, reg);
+       ehci_readl(ehci, reg);
+       msleep(1);
+       t1 = ehci_readl(ehci, reg);
+       ehci_writel(ehci, t1 | PORT_CSC, reg);
+       ehci_readl(ehci, reg);
+       udelay(500);
+       t1 = ehci_readl(ehci, &ehci->regs->status);
+       ehci_writel(ehci, t1 & STS_PCD, &ehci->regs->status);
+       ehci_readl(ehci, &ehci->regs->status);
+}
+
  /* suspend/resume, section 4.3 */

  /* These routines handle the generic parts of controller suspend/resume */
@@ -1154,6 +1178,8 @@ int ehci_resume(struct usb_hcd *hcd, bool force_reset)
         if (ehci->shutdown)
                 return 0;               /* Controller is dead */

+       if (ehci->zx_wakeup_clear == 1)
+               ehci_zx_wakeup_clear(ehci);
         /*
          * If CF is still set and reset isn't forced
          * then we maintained suspend power.
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index e87cf3a..a5e27de 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -222,6 +222,10 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
                         ehci->has_synopsys_hc_bug = 1;
                 }
                 break;
+       case PCI_VENDOR_ID_ZHAOXIN:
+               if (pdev->device == 0x3104 && (pdev->revision & 0xf0) == 
0x90)
+                       ehci->zx_wakeup_clear = 1;
+               break;
         }

         /* optional debug port, normally in the first BAR */
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fdd073c..712fdd0 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -220,6 +220,7 @@ struct ehci_hcd {                   /* one per 
controller */
         unsigned                imx28_write_fix:1; /* For Freescale 
i.MX28 */
         unsigned                spurious_oc:1;
         unsigned                is_aspeed:1;
+       unsigned                zx_wakeup_clear:1;

         /* required for usb32 quirk */
         #define OHCI_CTRL_HCFS          (3 << 6)
-- 
2.7.4
