Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42054BC9AA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbiBSR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:59:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBSR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:58:59 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BC5F8E0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:58:39 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220219175838epoutp017bbb423593392884eb95bebe56e537a2~VQbzL1BrM1395513955epoutp014
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:58:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220219175838epoutp017bbb423593392884eb95bebe56e537a2~VQbzL1BrM1395513955epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645293518;
        bh=nKq37BTRxnF03xFJIUPe/WlXxpClF9Q74HD9ufgg0os=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ecmAC4N2MO59Y6/B6WLY6PzQZB/P69ZemTnMYVRrrlFgaA59411I75LHXKxODuK3p
         +CJ6Brdehp/GpIDIWUWY6VqzIeYZ4uiM1OOXqSvMuqyEHBm6chEoT5fMj4o9xj2TEv
         6+wqnlu5ySkHGP7P/x7Izt5nicd+9U3X/OK557/Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220219175836epcas5p24eb86f410d5ad077d8b5a3e8794fa15f~VQbyOuqQ31199511995epcas5p2K;
        Sat, 19 Feb 2022 17:58:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K1GWt1b9qz4x9Pt; Sat, 19 Feb
        2022 17:58:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.5A.06423.ACF21126; Sun, 20 Feb 2022 02:58:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220219175832epcas5p399b652e6da610ada233376651694b42c~VQbuXSUAY2260922609epcas5p3W;
        Sat, 19 Feb 2022 17:58:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220219175832epsmtrp17e62247e5c927b264d7b9a67830d481d~VQbuTNXzR0051400514epsmtrp1K;
        Sat, 19 Feb 2022 17:58:32 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-6b-62112fca7380
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.5A.08738.8CF21126; Sun, 20 Feb 2022 02:58:32 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220219175831epsmtip274243b7cab6651563f7fed2052505bb6~VQbs93vgE1832918329epsmtip2a;
        Sat, 19 Feb 2022 17:58:31 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] clocksource/drivers/exynos_mct: Remove mct interrupt index
 enum
Date:   Sat, 19 Feb 2022 23:40:03 +0530
Message-Id: <20220219181003.12739-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmpu4pfcEkgzl3WCwezNvGZjHvs6zF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZrD1yl91i0dYv7BabN01lduD0mNXQy+Zx59oeNo93586x
        e2xeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjPanv1iLTjCVzF5SV4D4wvuLkZODgkBE4mPrycydzFycQgJ7GaU
        OLfgJiOE84lRYtb06awQzmdGick979hgWtYePgbVsotRYtfRpywQTguTxPFNV5hAqtgEtCXu
        Tt8CZosIuEncaOxgAiliFrjGKPFn4iFGkISwQJDEsc/dzCA2i4CqxLK2JywgNq+AjcSz2wdY
        IdbJS6zecABsnYTAPnaJpkunoBIuEo++n2GCsIUlXh3fwg5hS0m87G8DsjmA7GyJnl3GEOEa
        iaXzjrFA2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkTRCevREebEES1qkTzu6tQndISE7u7
        oQ7wkLi74QY4UIQEYiXOt3SyTWCUmYUwdAEj4ypGydSC4tz01GLTAsO81HJ43CTn525iBKcu
        Lc8djHcffNA7xMjEwXiIUYKDWUmE98NB3iQh3pTEyqrUovz4otKc1OJDjKbAUJrILCWanA9M
        nnkl8YYmlgYmZmZmJpbGZoZK4ryn0zckCgmkJ5akZqemFqQWwfQxcXBKNTCtldZ0TO16XKrh
        /KxEiUkxfOUsp4S4uRLbl9utPcI177ZOcCufBMOh7qo7DJZ3TLnv6RsGHdpaP+tRQ2+WvAWb
        zv4l38L97GKuX3INmyV+ZbfoHelZLO+la7mPzb/3MrV7i6cc95TD7OYrq25qxiimLZnIc0CR
        85pOQfHWy0IGYgsesbrwWMhIPJv2N2iH99+w7cpRN44wGtgEOvAbRRp/da/P2SHoOTv+7ILX
        O5d5Vs+T37bsl9UUwzNX0+rsVkW1nG1srtg275zwno+c/o03q9bfbs5ffSd84ZoKyxLfyOoA
        dce/elwavJYMGyYve7SWXa3O+onU05jglKPBKVd/ameYrPeO7jX9/mzxPyWW4oxEQy3mouJE
        AODbRwfmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXveEvmCSwbTHahYP5m1js5j3WdZi
        49sfTBabHl9jtbi8aw6bxYzz+5gs1h65y26xaOsXdovNm6YyO3B6zGroZfO4c20Pm8e7c+fY
        PTYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujLZnv1gLjvBVTF6S18D4gruLkZNDQsBE
        Yu3hY8xdjFwcQgI7GCXWbOtkg0hIS1zfOIEdwhaWWPnvOTtEUROTRHP7EyaQBJuAtsTd6VvA
        bBEBD4m2f/fAJjEL3GOU+N0yjREkISwQIHHozxawSSwCqhLL2p6wgNi8AjYSz24fYIXYIC+x
        esMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgQHmJbWDsY9qz7oHWJk
        4mA8xCjBwawkwvvhIG+SEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
        YLJMHJxSDUyHTsR6Hu3Ytnre1UvvslWjHE7tqzhzMOVpvth9vXMSqt+TLe4slYvlm2dc6Fl6
        +Ed4sa6rzf6Ti5/N0n2g+DTPtewKw+11sldF8k+08+8qNE9Y/SvgwYbJTyeULb/5X4Et6k5t
        gdSPxT85OA3dFv/UrgplP7DQ7c45xdf62VpJBRnzH5obq6Q88jpRxvc7XYP7m1fHowPsrfZs
        mvO9+CPCnnXF+/PI7dDMiGTbN7OSebvbrFVWmpdNdc9OXZDDHtUd19fMreXC/Yn/2s7FMVf8
        V/jNy9izvlX/wNfSwilp7dPf2bDZn2Ivd3twPIpl+5Wo38mV/v5cXxrb3U5Kz8yM3s+6UL1q
        9bz1+7nZY5VYijMSDbWYi4oTAe5LUZOfAgAA
X-CMS-MailID: 20220219175832epcas5p399b652e6da610ada233376651694b42c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220219175832epcas5p399b652e6da610ada233376651694b42c
References: <CGME20220219175832epcas5p399b652e6da610ada233376651694b42c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCT driver define an enum which list global and local timer's
irq index. Most of them are not used but MCT_G0_IRQ and
MCT_L0_IRQ and these two are at a fixed offset/index.
Get rid of this enum and use a #define for the used irq index.

While at it, bump-up maximum number of MCT IRQ to match the
binding documentation. And also change the name variable to be
more generic.

No functional changes expected.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

- currently tested on exynos7 platform, appreciate testing on
 exynos-{3,4,5} platforms

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d5511b0f..4aea9cd3f7ba 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -60,27 +60,18 @@
 #define MCT_CLKEVENTS_RATING		350
 #endif
 
+/* There are four Global timers starting with 0 offset */
+#define MCT_G0_IRQ	0
+/* Local timers count starts after global timer count */
+#define MCT_L0_IRQ	4
+/* Max number of MCT IRQ as per binding document */
+#define MCT_NR_IRQS	20
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
 
-enum {
-	MCT_G0_IRQ,
-	MCT_G1_IRQ,
-	MCT_G2_IRQ,
-	MCT_G3_IRQ,
-	MCT_L0_IRQ,
-	MCT_L1_IRQ,
-	MCT_L2_IRQ,
-	MCT_L3_IRQ,
-	MCT_L4_IRQ,
-	MCT_L5_IRQ,
-	MCT_L6_IRQ,
-	MCT_L7_IRQ,
-	MCT_NR_IRQS,
-};
-
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
@@ -89,7 +80,7 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	char name[MCT_NR_IRQS - 1];
 };
 
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
-- 
2.25.1

