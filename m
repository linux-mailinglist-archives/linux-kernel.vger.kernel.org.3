Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9817850F96F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345054AbiDZKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347976AbiDZKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:01:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638F32057
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:20:28 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220426092027epoutp04ef16ecef39198fd08b3814500f35d36e~pZ8NXSvmi0276902769epoutp04Z
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220426092027epoutp04ef16ecef39198fd08b3814500f35d36e~pZ8NXSvmi0276902769epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650964827;
        bh=E9R23DAe1jJ/y4QYxJ8o32xCpnMFRt1+5PhLzGs6fDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpYG+yn1iGM839G8R+WDip2gPg459hhhorKwV+yjOZjGBrJhW8ZT6TOAN8JIW2xo5
         gtikY9c1VVccbY+A5VdWSI8jY6vfHXL4qxF23WpBGP63ObDWbXYiMqrvgnsUfWBlHZ
         YaRJkNzz9o5a58vRQZhvta5zutGjezPz1oIF9rrs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220426092026epcas2p4ceb674ff1a822d94998c6027eb6a1452~pZ8M0t7LD2651026510epcas2p4U;
        Tue, 26 Apr 2022 09:20:26 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KnbvV5FtFz4x9Pw; Tue, 26 Apr
        2022 09:20:22 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.30.09764.659B7626; Tue, 26 Apr 2022 18:20:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092022epcas2p2da47c0c20feba6c96037e125289475f9~pZ8I3rmK42824028240epcas2p26;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426092022epsmtrp26bfca5b948cda1b1ea502c6b75730361~pZ8I2zjo01198711987epsmtrp2B;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-e5-6267b956dce8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.63.08853.659B7626; Tue, 26 Apr 2022 18:20:22 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092022epsmtip267f5b1767f4ea10aac4e0f5c6baf0836~pZ8Iu8jeM2696726967epsmtip2_;
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
Subject: [PATCH v4 3/5] usb: host: xhci-plat: support override of hc driver
Date:   Tue, 26 Apr 2022 18:18:46 +0900
Message-Id: <1650964728-175347-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmqW7YzvQkg3vbtCzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Y33+YseA6d8W5p91sDYxzuboYOTkk
        BEwkzm/5ydjFyMUhJLCDUaKp8xcrSEJI4BOjxPa9thCJb4wSH6fuZobpeNCxHKpjL6NEV+dx
        JgjnB6PEjOcHgdo5ONgEtCS+L2QEaRARiJNY2nkJrIZZ4AmTxI53t5hAEsIC3hL963vA6lkE
        VCXWTvIECfMKuElMOXacBWKZnMTNc51gizkF3CVe9CxiB5kjIfCRXaLz5hR2iCIXie0PXjFC
        2MISr45vgYpLSXx+t5cNwi6W2PWplQmiuYFRovHBCah3jCVmPWtnBDmCWUBTYv0ufRBTQkBZ
        4sgtsBuYBfgkOg7/ZYcI80p0tAlBNCpLTL88gRXClpQ4+Poc1EAPiVnv9zJDgmQWo8S/389Y
        JzDKzUJYsICRcRWjWGpBcW56arFRgRE8wpLzczcxglOgltsOxilvP+gdYmTiYDzEKMHBrCTC
        O1U1LUmINyWxsiq1KD++qDQntfgQoykw7CYyS4km5wOTcF5JvKGJpYGJmZmhuZGpgbmSOK9X
        yoZEIYH0xJLU7NTUgtQimD4mDk6pBqairizWri8nOXc9u+kYG5gYtI5j7uaSgM8vp22d89ay
        eVXLW87y3PPlYc9u86ks/1tczzQvXVrK//c3d0Zfd81bipvEjC9+vpm++8FRrR86R0wnc7aq
        MUnwn8/5/StoXTa78rw35m4Fky6IG7kalV/9KrnT/cRUjSXnQ0KepvwUN9W6VNLFn7TjbWWh
        hVD+5WM+ye1tTDsd16oeMXh1aan7JY9nU5/85+oMLBJ4bXrL/GJ/W5X6jNYTml6T1hwN3GLC
        c6r8+fOtT8Jv/+SKCBNa6scfa876KCiRoSujqmRZzMry9bf62f02dP4SrN/1n3E9p+rvIhvF
        LWU3rEoFuF7mqbfbZzNVPPB+eEPsjRJLcUaioRZzUXEiAGmoSrEKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvG7YzvQkg7v/eCzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZazvP8xYcJ27
        4tzTbrYGxrlcXYycHBICJhIPOpYzdjFycQgJ7GaUaHt9nxEiISmxdO4NdghbWOJ+yxFWiKJv
        jBLrZ/9l7mLk4GAT0JL4vhCsXkQgTmLF5T0sIDazwBsmiau7k0BsYQFvif71Pawg5SwCqhJr
        J3mChHkF3CSmHDvOAjFeTuLmuU5mEJtTwF3iRc8isLVCQDWTV1xnmsDIt4CRYRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnCoamnuYNy+6oPeIUYmDsZDjBIczEoivFNV05KEeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYEqW4A6cvK/ipbZ4
        /9TuvKMB8UveON8WuysSaL9Bd5VL/nFefus/vd0PvXe31K9Xadve7cfqLPI76uGFFd2OCbMX
        rd0/996TC3uF3Zqb9jBvK3Surd7W+nzTDecbbdUnvxy4osOo5nUyYv7rnXbRaratfC28ExIP
        25jf42it05lYEfmKq++N2dLz0gp1ByyY+Iu6YyS/bzyg4XG4XsRA4O7cCbujimsucc5N6c4T
        4OncnbV9pUaFGFvjUitJpz2ma3qnKesmyocYXdPMe975Pastnr9f79k7nn/+lZ98fjA7u+eu
        Xrug5qfAAmfeV+1Hjrxt/7f3bu/S2i/yD21WfElYJKqx0oSzeHJOtu90JZbijERDLeai4kQA
        FTyvYcQCAAA=
X-CMS-MailID: 20220426092022epcas2p2da47c0c20feba6c96037e125289475f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092022epcas2p2da47c0c20feba6c96037e125289475f9
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092022epcas2p2da47c0c20feba6c96037e125289475f9@epcas2p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps xhci-plat driver increase usability. Vendors could use functions
in xhci-plat mostly and use some overrides to do what they wants without
modifying xhci-plat driver.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 drivers/usb/host/xhci-plat.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a5881ff945a6..6efa3169bf69 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,6 +173,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_vendor_overrides)
+{
+	xhci_init_driver(&xhci_plat_hc_driver, xhci_vendor_overrides);
+}
+EXPORT_SYMBOL(xhci_plat_override_driver);
+
 static struct xhci_plat_priv_overwrite xhci_plat_vendor_overwrite;
 
 int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 8c204f3234d8..455e0018d5e6 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -28,5 +28,6 @@ struct xhci_plat_priv_overwrite {
 };
 
 int xhci_plat_register_vendor_ops(struct xhci_vendor_ops *vendor_ops);
+void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_vendor_overrides);
 
 #endif	/* _XHCI_PLAT_H */
-- 
2.31.1

