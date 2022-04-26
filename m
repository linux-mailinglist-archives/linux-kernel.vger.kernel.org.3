Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091DF50F969
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiDZKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346935AbiDZKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:01:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36916326D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:20:28 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220426092025epoutp04b5d7c001761d0c060e66574503ba36cf~pZ8MG7o9G0515205152epoutp043
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220426092025epoutp04b5d7c001761d0c060e66574503ba36cf~pZ8MG7o9G0515205152epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650964825;
        bh=gtJAxLOQgrMmX0jWzFakONkF7P6sHoAQWH61J9RzsI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgu5Bgf4OyBF4N0aJBlcQfpYZiB0YEXsu9hVZwunyIvZc0i+E3Zx/r1RqK5VmoMNa
         jeVIqiLrRGJftWceNMStCc1Yk6zkTsl8eizQe2f2U/KVvvtpcfKf/u3egblj0jM8Ak
         HLtsUM+BttcvHf/i2QCSjd1vFpCuDthllX8Qx5mU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220426092025epcas2p3d14f3e24838f8a8d88c8bf0acfe656df~pZ8Lg1Q3S0586405864epcas2p3D;
        Tue, 26 Apr 2022 09:20:25 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KnbvW100Sz4x9Q1; Tue, 26 Apr
        2022 09:20:23 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.27.10028.659B7626; Tue, 26 Apr 2022 18:20:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0~pZ8JPwIwa1542715427epcas2p2g;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426092022epsmtrp2b8129b54ca939ed0c966fdb4b2b8809f~pZ8JOcLlR1198711987epsmtrp2E;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-61-6267b956c9f2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.63.08853.659B7626; Tue, 26 Apr 2022 18:20:22 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092022epsmtip2bc7ea80debbb111994c4354b8e3a6851~pZ8JFUHWS2696726967epsmtip2A;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 4/5] usb: host: add some to xhci overrides for
 xhci-exynos
Date:   Tue, 26 Apr 2022 18:18:47 +0900
Message-Id: <1650964728-175347-5-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmmW74zvQkg4O7mCzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54/qKVveCuYMXxObtYGxj/83UxcnJI
        CJhI7Dt4hbmLkYtDSGAHo8Tlgx8YIZxPjBLzH/6Hcr4xSvxf1coO03L3xFsWiMReRonZn16y
        Qzg/GCWOLjwN1MLBwSagJfF9ISNIg4hAnMTSzktMIDXMAk+YJHa8u8UEkhAW8Jf42DeLFaSe
        RUBV4ttKW5Awr4CbxIwZj9gglslJ3DzXyQxicwq4S7zoWQS2S0LgK7vEtv9zoC5ykWh6uJ4J
        whaWeHV8C1RcSuLzu71Qg4oldn1qZYJobmCUaHxwghkiYSwx61k72NHMApoS63fpg5gSAsoS
        R26xgFQwC/BJdBz+yw4R5pXoaBOCaFSWmH55AiuELSlx8PU5qIEeEge/T4IG3CxGifYJF1gn
        MMrNQliwgJFxFaNYakFxbnpqsVGBMTzGkvNzNzGCk6CW+w7GGW8/6B1iZOJgPMQowcGsJMI7
        VTUtSYg3JbGyKrUoP76oNCe1+BCjKTDsJjJLiSbnA9NwXkm8oYmlgYmZmaG5kamBuZI4r1fK
        hkQhgfTEktTs1NSC1CKYPiYOTqkGpq1e5rNvua6QOlt/6fLUd4H3Z3/wa1BK8TXO+f1F9EV5
        8KI5kx1fr027u2zy4Q8PP+q+3rH007ZyPs2wwrNdFmmy7I9Yz3l+bFtRnnsjU+mAR8HyIxpM
        ynJZUtYryvutNZkXbGC/InJfNcNXckLnjZVrGxfKiIdkrZ8Uyn1RQVir//GBzN/Za0qmXT50
        7+gs3xlx2x5Uf9n3JETJOD2XMcLkz95aI3lWf5E/ogHcFsf+8GaUfXMtevxxZ+hZhfpPLIzn
        761Sj5DtmWfloXowpjDl8Q9OSQGeefcfJx69vs9mb82K3zu/rZTZ8Sfo5qJ3fVtOWCyN2rXc
        97KxptKTJo/lfyeKulz4efQp68L5b/cosRRnJBpqMRcVJwIA8rkpfAsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvG7YzvQkg4nnlS3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZTx/0cpecFew
        4vicXawNjP/5uhg5OSQETCTunnjLAmILCexmlJj+pAAiLimxdO4NdghbWOJ+yxHWLkYuoJpv
        jBIvv58BSnBwsAloSXxfyAhSIyIQJ7Hi8h6wOcwCb5gkru5OArGFBXwl/pzazApSziKgKvFt
        pS1ImFfATWLGjEdsEOPlJG6e62QGsTkF3CVe9CxihzjHTWLyiutMExj5FjAyrGKUTC0ozk3P
        LTYsMMxLLdcrTswtLs1L10vOz93ECA5ULc0djNtXfdA7xMjEwXiIUYKDWUmEd6pqWpIQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTFHv25MMz6+4M11f
        Iv47U3f2KblPwo3uL+d29RlZ2ib0nznVtHC7+k/e8G0pHy6bHuaqUBa2MHjGeahCzk2UO/bS
        qwIt/6PscpNKul8yKZ/cFyx97tD8bZwxhu0rlyx/qPKJ9yWbzjX5x8fLftt8Vb+ZJhj0TG3v
        Sa6TRvxMjw5P37J1JuOCeu7eu1+L/9bpTPnTsvjtD79NlzhfTV8scOrc4s2bLfYxyxz68Mwk
        6K//pbmT2w+65AsVJhqv6Zrd1cNhkL4s74tixFmui1YvT3080v7liMOPl9lCoaxusfYCge+Z
        V6xtsEm6mBW0Osdk15uyOxabAs7rZWVuEM8OW+nfPSuZ5ewZv+DfZzfMKlZiKc5INNRiLipO
        BADwruL+wwIAAA==
X-CMS-MailID: 20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 5ccf1bbe8732..8b3df1302650 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5555,6 +5555,12 @@ void xhci_init_driver(struct hc_driver *drv,
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
index 3a414a2f41f0..5bc621e77762 100644
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

