Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF664A7E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349085AbiBCDAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22589 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349116AbiBCDAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:14 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220203030013epoutp01eea158e683346700450598ce4973787e~QJ2z9AEk70955109551epoutp01k
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:00:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220203030013epoutp01eea158e683346700450598ce4973787e~QJ2z9AEk70955109551epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643857213;
        bh=t16gVV9oSQaljRySboqrBl6RazZm32K+h93uwF0rvx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBvVTrpqwPnm+3AOSBNbHr5SegOa5WKGlQLwYWQc36yONrwwtRD3Z1jdR2ytfdQLf
         Xq372LTg66vumHlbheCS7+BsWT+WcrznLr3DmlRaexGVZOzmJo9nTYrJwyKN47HFMS
         C7qMkhZ4fzRIYb1Mw8GKNHFgQPhOV15Pb6KV6OAU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220203030012epcas2p1fd39ce49606e7a3863ba0beafb39061d~QJ2zcn2561004810048epcas2p1L;
        Thu,  3 Feb 2022 03:00:12 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jq3Lf4W1Sz4x9Q3; Thu,  3 Feb
        2022 03:00:10 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.6D.10014.6424BF16; Thu,  3 Feb 2022 11:47:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220203030008epcas2p396fb4fd6967a8b7f185e736e3eb15762~QJ2vi019p1765117651epcas2p3z;
        Thu,  3 Feb 2022 03:00:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220203030008epsmtrp2847a2cda2801b082b7773e839a909c43~QJ2viCT060540605406epsmtrp2E;
        Thu,  3 Feb 2022 03:00:08 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-4f-61fb4246fae4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.B7.29871.8354BF16; Thu,  3 Feb 2022 12:00:08 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220203030008epsmtip2f1c05a011cf1986dee9e5b2d04fcad7b~QJ2vXxYsJ0211302113epsmtip2W;
        Thu,  3 Feb 2022 03:00:08 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH 3/3] usb: host: add some to xhci overrides for USB offload
Date:   Thu,  3 Feb 2022 11:57:34 +0900
Message-Id: <1643857054-112415-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmma6b0+9Eg9Zb6hZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yA6fH5b5eJo8Fm0o9Fu95yeSx
        f+4ado++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1ya
        l66Xl1piZWhgYGQKVJiQnfFiwSPWgruCFSfOf2ZtYPzP18XIySEhYCKx8uliJhBbSGAHo8T8
        RisI+xOjxMVlwV2MXED2N0aJ76d6WGAabp5tZoJI7GWU2PW3gRHC+cEo8ezEG/YuRg4ONgEt
        ie8LGUEaRATiJJZ2XgJrYBaYyiTRMese2CRhAS+J+/2HwIpYBFQl/n/czwZi8wq4SXz43MUG
        sU1O4ua5TmYQm1PAXeLIlBuMEPFb7BKPbpVD2C4Sq7sPsELYwhKvjm9hh7ClJD6/2ws1p1hi
        16dWsCMkBBoYJRofnGCGSBhLzHrWzghyNLOApsT6XfogpoSAssSRW2BnMgvwSXQc/ssOEeaV
        6GgTgmhUlph+eQLUVkmJg6/PMUOUeEj8XpYOCZFZjBLT1s5gnMAoNwth/gJGxlWMYqkFxbnp
        qcVGBcbw6ErOz93ECE5wWu47GGe8/aB3iJGJg/EQowQHs5II796F3xOFeFMSK6tSi/Lji0pz
        UosPMZoCg24is5Rocj4wxeaVxBuaWBqYmJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj
        4uCUamCaeEU86Fu+QVZI/0qNG9MmhMzbMOdQjNe/K/fc5re4JKzhbrG+wVVbXmQTs/qAyPkl
        LmbrurabCXz0M/5Zy/r6IJfT9ByOVZ4a3UwTitZYiFRHvS1/bH19bn7Ey5VN1rnRl1Uevymv
        iTHUdndcEy6ts2+S//ejt8qT0p58ErKe8VBnklq8WrtweQRff0n9zNK+YKF9Dw2kbsSvz5pw
        6uaRC8fYLH+9O2icG3Nc3nc1Rxmf2pYHk20k3N/96pqXlm3x2SXBUUjuYEjIwv/3c+4wXA5g
        0Tmo69kqbcT2T6Vsy7PpV188C+IJmMOsFcLzzebllpDMWTcjPvRf/748kd3m844UhUVZcwWN
        Dza8mqHEUpyRaKjFXFScCADvN2Hv+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvK6F6+9Eg08neS3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XlXXPYLBYta2W2aN40hdVi5lplB06Py329TB4LNpV6LN7zkslj
        /9w17B59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8WLBI9aCu4IVJ85/Zm1g/M/XxcjJISFg
        InHzbDNTFyMXh5DAbkaJM//2skMkJCWWzr0BZQtL3G85wgpR9I1R4sSWJqAODg42AS2J7wsZ
        QWpEBOIkVlzewwJSwywwm0li8/HrYAlhAS+J+/2HwGwWAVWJ/x/3s4HYvAJuEh8+d7FBLJCT
        uHmukxnE5hRwlzgy5QZYvRBQzeqrfYwTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQIDkgtzR2M21d90DvEyMTBeIhRgoNZSYR378LviUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwLVt1Xydr014F7fKlpRuOLYtmevd4tdP0Or8X
        jvVzxH19JXpM5Sfs+pJdGhIkFO0Y4Xvc7HPBX6H5QQvjFjJra87cHtY6bcnS1VvWHNAvPFbz
        98l0plXvQzjCtx8SDHVdtKnY4Eqfhtm33fUJL61vKmu2RyrZvS1fOc+l8m/NvFVsTfPuGJfJ
        V/2+rx/Au7OnaeavWVsEDK/nPWo6lvZnAjN/r9zf6Vmr7htXbV2g4XX6fa78tJJ8rmeRB3UY
        lAvVWY5xNzTNVW3I+HQvZ84rnerIdwesOsXvp6eoHjkgIjWnsWhXnMNSNhOulsYiNfXdqsdZ
        3NViuw/wWZ32edH/JTXu0XSPAyviDgimhrgqsRRnJBpqMRcVJwIA2bq6+LcCAAA=
X-CMS-MailID: 20220203030008epcas2p396fb4fd6967a8b7f185e736e3eb15762
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220203030008epcas2p396fb4fd6967a8b7f185e736e3eb15762
References: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220203030008epcas2p396fb4fd6967a8b7f185e736e3eb15762@epcas2p3.samsung.com>
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

