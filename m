Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF024E22D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiCUJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbiCUJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:40 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508D8EB7B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:02:11 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220321090208epoutp022879eec1b8e86185629a2052f5e68ded~eWd8j3OC21316413164epoutp02W
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220321090208epoutp022879eec1b8e86185629a2052f5e68ded~eWd8j3OC21316413164epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647853328;
        bh=jkqJCU4+aVDJS7yOCCdF4ZZs3P9ETXU7EF57rPAUAM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erkwhH2lf4GzwhlMB0Gtrcwg0wgVbju1o01DzIkPXsn0lGf0nsjbKKdfeAKBcUGqg
         rt5SP3b/8qRgSfIv3mYTd5eHRkEjGKNgeevCvva3DckMQH2xPRO1FQRv6kj1mdUGLc
         OSGvO89SsGdm95hBabVLwvaK3m0ZtLfQ4WcIvLyY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220321090208epcas2p2d2768e0c3a1c1447ad04eb4161ac8f60~eWd8GCMv83058430584epcas2p2c;
        Mon, 21 Mar 2022 09:02:08 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KMTC15rCrz4x9QM; Mon, 21 Mar
        2022 09:02:05 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.C7.33036.D0F38326; Mon, 21 Mar 2022 18:02:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220321090205epcas2p4f3698a0aa49d251c0a8f008e85d968ba~eWd5i-KTd0252402524epcas2p4b;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321090205epsmtrp1324d4e15cd89a97cdac910ade2dd33a2~eWd5hy0uF2591125911epsmtrp1b;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-95-62383f0dff75
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.3E.29871.D0F38326; Mon, 21 Mar 2022 18:02:05 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321090205epsmtip2b9eb2f9c109f6f1fe94ed3429fac1de3~eWd5SjMw81528315283epsmtip27;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: [PATCH v3 3/4] usb: host: add some to xhci overrides for USB
 offload
Date:   Mon, 21 Mar 2022 17:59:53 +0900
Message-Id: <1647853194-62147-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmuS6vvUWSwexWLYs7C6YxWTw5sojd
        onnxejaL63/eM1q0P7/AZnF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWP/3DXsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA3SYkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE743vTY/aCu4IVzV83Mjcw/ufrYuTkkBAwkVh47RhzFyMX
        h5DADkaJ3VsOMUE4nxgljk8/yALhfGOUaJ74mr2LkQOsZedaNoj4XkaJs4eWQrX/YJTY0Hae
        GaSITUBL4vtCRpAVIgJxEks7L4FNZRZYzSTx/uNFNpCEsIC/xMlzV8CKWARUJbb/2cAMYvMK
        uEq0zf/OCHGfnMTNc51gcU4BN4m1NxvBLpIQeMQusXvKejaIIheJtvv7WSBsYYlXx7ewQ9hS
        Ei/726DsYoldn1qZIJobGCUaH5xghkgYS8x61s4IcjWzgKbE+l36EF8qSxy5BTaSWYBPouPw
        X6jneSU62oQgGpUlpl+ewAphS0ocfH2OGaLEQ2L7A2i4zWSUODD5LPsERrlZCPMXMDKuYhRL
        LSjOTU8tNiowgUdYcn7uJkZwutPy2ME4++0HvUOMTByMhxglOJiVRHgXfzBPEuJNSaysSi3K
        jy8qzUktPsRoCgy7icxSosn5wISbVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUg
        tQimj4mDU6qBKXCfpJSr+6uX9UtbA/6cYnPZqh0QfTFz4XpNtglr/a67tAlucj/45WNp0qP6
        rg8uSreKdGvnPnP9cuKR/OX4HF+VdYcmXI85uXyG0YFW9bbvHxcfWzk/O+3Oi3+nb/5+Xyyt
        PlU+McSycMm5D26+jP+3Lf30Os3h26mdVw673LO6Xfrw99PaeZL+/G7H7my9euh4gug5A7OP
        seZG01WUQ+84n10SLjNBtV/r+QzZlJzlz4LE9xzd5qYhc1vwzrnemVuMm3w5p3B+szmtu1/i
        Zcxzxg0xi4O2yGXct5l/4L245PaPm1X/rLK71JhQfJll8w7fV1GWjxMmVnxZFHZi8gO2loul
        to/tXr2KOqApsfCREktxRqKhFnNRcSIAehl6SwAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvC6vvUWSwa2DXBZ3FkxjsnhyZBG7
        RfPi9WwW1/+8Z7Rof36BzeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8f+uWvYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvje9Nj9oK7ghXNXzcyNzD+5+ti
        5OCQEDCR2LmWrYuRi0NIYDejxIf7Txi7GDmB4pISS+feYIewhSXutxxhhSj6xijROLGXEaSZ
        TUBL4vtCsHoRgTiJFZf3sIDUMAtsZJKY9OASC0hCWMBX4t3vPUwgNouAqsT2PxuYQWxeAVeJ
        tvnfoZbJSdw81wkW5xRwk1h7sxGsVwioZuukGawTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytO
        zC0uzUvXS87P3cQIDkwtzR2M21d90DvEyMTBeIhRgoNZSYR38QfzJCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYeFySL+TUKf3rf7+WOe8j/zT9JjnG
        uAvfJ8w3k30pf3/79k8NIdsbUv8vmPM99PCCnd/9Ul1WTJ+24nDkGqnCHw82fy6yzz3beHbb
        vIgsy0cZ7+/+2N3pcFGj9UbNrire3TILPj9e9mDqE9clfl9vV/7ZKOE7M2yJc/bZkIvbY3Ji
        3Kp4DXM4tgquq60SOfUoWDBhW+ciRp1LYTWavBdWsbAdD312WLx8oZ2dLpfe7MySf1tMH2Vs
        1XojaW73jvtf92uW6B/n+S+K+eixvfgR0VFS55ZwOv2py+krB570z0xlNLip+nnJzq0NWUVe
        eaIL9nuXzxet/VOakrYuRdO69IGAjydzAws3y+Vl9v+/KLEUZyQaajEXFScCAMHWax27AgAA
X-CMS-MailID: 20220321090205epcas2p4f3698a0aa49d251c0a8f008e85d968ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p4f3698a0aa49d251c0a8f008e85d968ba
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p4f3698a0aa49d251c0a8f008e85d968ba@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 4e4fcf97ba42..d3c3d57c89f9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5544,6 +5544,12 @@ void xhci_init_driver(struct hc_driver *drv,
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
index f690a5dc9eb3..de37d72847f2 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1947,6 +1947,9 @@ struct xhci_driver_overrides {
 			     struct usb_host_endpoint *ep);
 	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
+	int (*address_device)(struct usb_hcd *hcd, struct usb_device *udev);
+	int (*bus_suspend)(struct usb_hcd *hcd);
+	int (*bus_resume)(struct usb_hcd *hcd);
 };
 
 #define	XHCI_CFC_DELAY		10
@@ -2103,6 +2106,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		       struct usb_host_endpoint *ep);
 int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
+int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
-- 
2.31.1

