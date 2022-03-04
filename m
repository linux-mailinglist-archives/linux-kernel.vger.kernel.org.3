Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F3A4CCDB8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiCDGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiCDGa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:30:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F11187E20
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:30:09 -0800 (PST)
Received: from epcas3p2.samsung.com (unknown [182.195.41.20])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220304063004epoutp02cb9de270a8fcc600efea7d15c491f91b~ZGbUn0FMx0867208672epoutp02t
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:30:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220304063004epoutp02cb9de270a8fcc600efea7d15c491f91b~ZGbUn0FMx0867208672epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646375404;
        bh=t16gVV9oSQaljRySboqrBl6RazZm32K+h93uwF0rvx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf3z2CPaiPXMsWBLD7qMf3+68ws13l0ZiUCupiICqOt11Li4vt/OLPvmUyWxpK+Ol
         HZlCxhBGXJNEPM8KXLqpbNqXn+udDkMfMqetbAHYnTr0KmEoVEnYwfuBl8+hHC4DcX
         2Lrp0T5KQd7MAnMHYUFS4knl2Xp1IPE1F73l1q1k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220304063003epcas3p18edac2709d3bb605e50bf2413a757682~ZGbUCCo1x2721227212epcas3p1n;
        Fri,  4 Mar 2022 06:30:03 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4K8ydR6q2Lz4x9Px; Fri,  4 Mar 2022 06:30:03 +0000
        (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220304062617epcas2p1ccc051a6d931d4151a7c9e2bb545bd47~ZGYBjXU7N1392713927epcas2p1X;
        Fri,  4 Mar 2022 06:26:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220304062617epsmtrp1b45eca2a481a613393a8970de57fb3e7~ZGYBiaugu1455714557epsmtrp1L;
        Fri,  4 Mar 2022 06:26:17 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-4b-6221b1096024
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.B3.29871.901B1226; Fri,  4 Mar 2022 15:26:17 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220304062617epsmtip2941d034ecd4dd9128568de9efdb0fc17~ZGYBXMRaE1747117471epsmtip2y;
        Fri,  4 Mar 2022 06:26:17 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v1 3/4] usb: host: add some to xhci overrides for USB
 offload
Date:   Fri,  4 Mar 2022 15:23:57 +0900
Message-Id: <252651381.41646375403959.JavaMail.epsvc@epcpadp3>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvC7nRsUkg+kfzSxWHJ7HaPHykKbF
        5odX2CzuLJjGZPHkyCJ2i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lpli667
        NxgdeD0u9/UyeSzYVOqxeM9LJo/9c9ewe7Sc3M/i0bdlFaPH501yAexRXDYpqTmZZalF+nYJ
        XBkvFjxiLbgrWHHi/GfWBsb/fF2MnBwSAiYS6+fOYO1i5OIQEtjNKHFl2RYmiISkxNK5N9gh
        bGGJ+y1HoIq+MUo0b7nB3MXIwcEmoCXxfSEjSI2IQJzEist7WEBqmAX6mSU2NN9iBakRFvCV
        OHVYBaSGRUBV4vSU18wgNq+Aq8TGzt/MEPPlJG6e6wSzOQXcJLbcP8IGYgsB1TxofcQ4gZFv
        ASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4PDV0tzBuH3VB71DjEwcjIcYJTiY
        lUR4LTUVkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        ypWVjb82wcFXUeeu9B6Fm22lLxWif9fx7EipYXYuWL954WZ7nzcKk5rbGu7GiC5Jt/1de+BL
        TeEhub1FO9IT5wmza7yW01r79FfNdt25b5/nNKUlv4iZ84jVqc389kPr6/sC7679/DNcI33V
        /cKF2ypfFMcfDc6VeGj9yL3b9s6Vr5xFUb+3Zm+VC/HQ8V0Utkm5cfsSe6O2dYvVORe6Waub
        XbycNXsad3jJmeNzbmm4XnGyvHdk87GLf//6Rfecn9B+pidRroyT5TmDVBr79QV1not7tOo3
        7Tm+39L/oOZVcS+Fr0+kv+2rsfzk/nNHj5iEpd63/5/LNuyfttc21T5Vxtt+AtsDZc4spgdt
        SizFGYmGWsxFxYkAboDB+84CAAA=
X-CMS-MailID: 20220304062617epcas2p1ccc051a6d931d4151a7c9e2bb545bd47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CMS-RootMailID: 20220304062617epcas2p1ccc051a6d931d4151a7c9e2bb545bd47
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062617epcas2p1ccc051a6d931d4151a7c9e2bb545bd47@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-processor needs some information about connected usb device.
It's proper to pass information after usb device gets address when
getting "Set Address" command. It supports vendors to implement it
using xhci overrides. There're several power scenarios depending
on vendors. It gives vendors flexibilty to meet their power requirement.
They can override suspend and resume of root hub.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/xhci.c | 6 ++++++
 drivers/usb/host/xhci.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 10d5e20b710d..7789bf277c8e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5557,6 +5557,12 @@ void xhci_init_driver(struct hc_driver *drv,
 			drv->check_bandwidth = over->check_bandwidth;
 		if (over->reset_bandwidth)
 			drv->reset_bandwidth = over->reset_bandwidth;
+		if (over->address_device)
+			drv->address_device = over->address_device;
+		if (over->bus_suspend)
+			drv->bus_suspend = over->bus_suspend;
+		if (over->bus_resume)
+			drv->bus_resume = over->bus_resume;
 	}
 }
 EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 2efe8ddaab5f..2c7d0e403424 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1944,6 +1944,9 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*address_device)(struct usb_hcd *hcd, struct usb_device *udev);
+	int (*bus_suspend)(struct usb_hcd *hcd);
+	int (*bus_resume)(struct usb_hcd *hcd);
 };
 
 #define	XHCI_CFC_DELAY		10
@@ -2100,6 +2103,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		       struct usb_host_endpoint *ep);
 int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
-- 
2.31.1


