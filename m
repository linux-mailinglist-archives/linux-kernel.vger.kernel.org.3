Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC134CFC19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiCGK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiCGK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:43 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430A1B7BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:18:56 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220307101853epoutp048196fc28861ef3dda4ae780ede389e83~aEe9e9hYx0483004830epoutp04Y
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:18:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220307101853epoutp048196fc28861ef3dda4ae780ede389e83~aEe9e9hYx0483004830epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646648333;
        bh=nOL78EeZvY56W86LiCbJQkDn6FkIKedKHBVrPoVlUfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhzA+FzBBx/pspLFYbcSOfaejL7cXLynJE6UJcxHyAnunH2nADS95s7S2aiVp4svg
         E88ExrlJ+8uSlpKFKr5F9Bo6LnPAYtNgDPbEYo2Cr+mTqsGI94i6LWJ6tVpO2/DuJy
         Nis2COn/rzb9FV/i7s5gfRHEdg3GygKGZ45lFutE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220307101853epcas2p4cea31e31a86bb76d46916ff772ff1ec6~aEe9BvMiN1482714827epcas2p4q;
        Mon,  7 Mar 2022 10:18:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KBvZ34drTz4x9Px; Mon,  7 Mar
        2022 10:18:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.E4.33036.B69D5226; Mon,  7 Mar 2022 19:07:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220307101851epcas2p4c26eaf8ed7f940db8c42cb3b63ff5331~aEe7X08Zm2631426314epcas2p4R;
        Mon,  7 Mar 2022 10:18:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220307101851epsmtrp1e463743ccd3e3bf691a9e98c7d3bc4f6~aEe7W4R523178231782epsmtrp1T;
        Mon,  7 Mar 2022 10:18:51 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-4f-6225d96bbcbe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.81.29871.B0CD5226; Mon,  7 Mar 2022 19:18:51 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220307101851epsmtip249f473340074eaed7fb864fea79209ce~aEe7LFP2g0474804748epsmtip2a;
        Mon,  7 Mar 2022 10:18:51 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: [PATCH v2 3/4] usb: host: add some to xhci overrides for USB
 offload
Date:   Mon,  7 Mar 2022 19:17:35 +0900
Message-Id: <1646648256-105214-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTTDf7pmqSwd8uaYuXhzQtNj+8wmZx
        Z8E0JosnRxaxWzQvXs9mcf3Pe0aL9ucX2Cwu75rDZrFoWSuzRfOmKawWM9cqW3TdvcHowONx
        ua+XyWPBplKPxXteMnnsn7uG3aNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fY
        KqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6w/vIe14K5gRdeCzcwNjP/5uhg5OSQE
        TCRuXrnO2MXIxSEksINRYkHjN1aQhJDAJ0aJ1hvKEIlvjBK/l69lh+k4/GUuC0RiL6PE3U3P
        2CCcH4wS+y43AzkcHGwCWhLfFzKCNIgIxEks7bzEBFLDLHCVSWLJhmNgk4QF/CXajk9nA7FZ
        BFQlTh9fxgRi8wq4SUycfYUZYpucxM1znWA2p4C7xLcpvWCDJATeskv83NnMCFHkInF82iGo
        BmGJV8e3QJ0qJfGyvw3KLpbY9akVqrmBUaLxwQmoBmOJWc/aGUGuZhbQlFi/Sx/ElBBQljhy
        iwWigleiYeNvsDHMAnwSHYf/skOU8Ep0tAlBlChLTL88gRXClpQ4+Poc1HAPifeH/jBBwmcW
        o8TcxbPZJzDKz0JYtoCRcRWjWGpBcW56arFRgQk89pLzczcxglOjlscOxtlvP+gdYmTiYDzE
        KMHBrCTCe/+8SpIQb0piZVVqUX58UWlOavEhRlNgQE5klhJNzgcm57ySeEMTSwMTMzNDcyNT
        A3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUzRIUzVylv88r7eCM85J5le/c2tW81VZeZ3
        99o17uXSC3Vrstd1xLxNr9ee5Bbj0V7wzOZ945eSf9ts1VY/rA9zd91T+sLhBqvr4cs7mf2e
        HJDSj31ZLcVduMnKksfpVNODbds3iVWYz0tmvS8tfkbAv2hzWNjtKKWjnffOXV54Uai8a/Pa
        Jh4fec4msa6Qfcq909qTZ3uqt92Zlij+d9azQ3Y+nBw3ezMext9IOX12tfGuvk2LZF203ult
        fHbT7vyaZd4lS6wezHaXe6L9SqzzlZLssXJ7jivCHolrT16/y6zBUFK/bPo/E/Wq6jnPe2bO
        f3Jvx8Q5a0+9FbywaRHDTMbUey9bUn2Uj/9jOKnEUpyRaKjFXFScCADe6munFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvC73HdUkgw3/uSxeHtK02PzwCpvF
        nQXTmCyeHFnEbtG8eD2bxfU/7xkt2p9fYLO4vGsOm8WiZa3MFs2bprBazFyrbNF19wajA4/H
        5b5eJo8Fm0o9Fu95yeSxf+4ado++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKWH94D2vBXcGK
        rgWbmRsY//N1MXJySAiYSBz+Mpeli5GLQ0hgN6PEiY4z7BAJSYmlc29A2cIS91uOsEIUfWOU
        2PX8AVAHBwebgJbE94WMIDUiAnESKy7vARvELHCfSeL8u++sIAlhAV+JrotLwYpYBFQlTh9f
        xgRi8wq4SUycfYUZYoGcxM1znWA2p4C7xLcpvWA1QkA1F09cZZrAyLeAkWEVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZwsGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrz3z6skCfGmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBksTH4pMHjeR0mM262
        /Ht0RSwxgNFgmnhITtC5lODUZ9+yXM5ohn+SZjzE0a3HY1xzgct0Jc8xq4WvH6WXWWc+jv41
        fUJXUWSOv5n2/tMln6OvNP370tOglRDdrFreFuyRkHX/x9eXD2fMPFd+Puuef/C60h2nt4Yy
        ZESujTbdMGvi707h1Yxf6kVsD3TJ8lXtcP9Q+i/CncWB8X+dmUipiqtEl8yC8pcLTa+v3XbL
        9Irj87kXxI8s2PJQKk9Gzskv9fDPOrn3d4641vMKqfzjcDsSkF7J1Gkk+YHVyWHXq8mX6xht
        GrL9dIRKp3dqlJ+P7VoRn/R9l0Vu14Q10lePuL8Nap3qa7bysH7qXSWW4oxEQy3mouJEABi5
        NRHFAgAA
X-CMS-MailID: 20220307101851epcas2p4c26eaf8ed7f940db8c42cb3b63ff5331
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307101851epcas2p4c26eaf8ed7f940db8c42cb3b63ff5331
References: <1646648256-105214-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220307101851epcas2p4c26eaf8ed7f940db8c42cb3b63ff5331@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
index 3f82df2c5be1..38a030d04851 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5558,6 +5558,12 @@ void xhci_init_driver(struct hc_driver *drv,
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
index e2ed4f88ae4b..e6fd53e36889 100644
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

