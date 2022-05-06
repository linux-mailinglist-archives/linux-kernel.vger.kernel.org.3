Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08851D17A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiEFGhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355564AbiEFGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:31 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98D66208
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:48 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220506063346epoutp04ed771ff66395f3e114dfda4697d9f82e~scHiFtijZ2011620116epoutp04S
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220506063346epoutp04ed771ff66395f3e114dfda4697d9f82e~scHiFtijZ2011620116epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818826;
        bh=a4Ha8wEr3wq1zSlLNuAyl1253SWX0FU94jcVWiTwflM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyIxckSjT3QDkDuUVthcZjfp43rZ17kRDyX/9WuwUiylymt5YTJTmjYO4YJ8F29pJ
         A6qVyzKDnyh40wOe1vAjqP+W1EgkMyxpSukdbj+3EOo9FbfiA+aKVleDkJ0PqBRLdJ
         s7JEnLdOVh/Dc1TWsaINqAgfEz1lALt5/hb8ZJds=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220506063345epcas2p221a69de6758e82525668975853da6cf8~scHhh1sU_1423714237epcas2p2H;
        Fri,  6 May 2022 06:33:45 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KvgkY08TBz4x9Px; Fri,  6 May
        2022 06:33:41 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.41.10069.441C4726; Fri,  6 May 2022 15:33:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da~scHcnp9i71119911199epcas2p4j;
        Fri,  6 May 2022 06:33:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506063340epsmtrp28eaa0984bb745a087836f8a1472067ba~scHcmjYem0438604386epsmtrp2Y;
        Fri,  6 May 2022 06:33:40 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-62-6274c144fcf0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.55.11276.441C4726; Fri,  6 May 2022 15:33:40 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063340epsmtip2baa6570955d62dfa934b8183334829ba~scHcZxRzm0642406424epsmtip2D;
        Fri,  6 May 2022 06:33:40 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com, Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH RFC v5 6/6] usb: dwc3: dwc3-exynos: add host init
Date:   Fri,  6 May 2022 15:31:19 +0900
Message-Id: <1651818679-10594-7-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmma7LwZIkg76ZVhYP5m1js/g76Ri7
        xbG2J+wWdxZMY7I4tXwhk0Xz4vVsFnNuGlncffiDxWLv663sFpseX2O1uLxrDpvFjPP7mCwW
        LWtltmg52s5i0bxpCqvF5w2PGS267t5gtJh0UNRi/xUvB2GP378mMXp8+zqJxWN2w0UWj52z
        7rJ7LN7zkslj06pONo871/aweeyfu4bdY/OSeo++LasYPdZvucri8XmTXABPVLZNRmpiSmqR
        Qmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCHSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjKari9kLWpQq
        XlxuYW9gbJLpYuTkkBAwkeg51sTYxcjFISSwg1Hi2ukjzBDOJ0aJXbs3soNUCQl8Y5R49b0Q
        puPohpssEEV7GSVWXfrBCuH8YJRYP+UZWxcjBwebgJbE94VgY0UEpjNLnFzTywbiMAucZJa4
        vGcRO0iRsICjxPKNvCBTWQRUJaa0bmUCsXkFXCXen2xnh9gmJ3HzXCcziM0p4CZxaeoWsKES
        Ahc4JJbdvcUKUeQi0fFkDhOELSzx6vgWqGYpic/v9rJB2MUSuz61MkE0NzBKND44wQyRMJaY
        9aydEeQgZgFNifW79EFMCQFliSO3WEAqmAX4JDoO/2WHCPNKdLQJQTQqS0y/PAHqAkmJg6/P
        QQ30kPj2aCs0SGcySiz/uYJ9AqPcLIQFCxgZVzGKpRYU56anFhsVGMJjLDk/dxMjOAVrue5g
        nPz2g94hRiYOxkOMEhzMSiK8wrNKkoR4UxIrq1KL8uOLSnNSiw8xmgIDbyKzlGhyPjAL5JXE
        G5pYGpiYmRmaG5kamCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYBK37CjYEJDjN9UtaNfC
        L/FaqyImbisK7xLuyZ+vfcf7e/EZkxzF/BOBrm/qzZw+f9t8OUSZ3+6P5zbGL2e09N/rTDs2
        08dp5TwVaaXpGqcLBEImfi6webYm8eGMNDWjp5of3gtPWTvnPUtqWb290axt81fXmWxaflfw
        z+TXa+ZX8rtP+Wb+1MLrw5o2Tl4j+ZulqklJXAvPv+t8Pstd5eD/ldacX2+vvTpjduaD5GyV
        kl1NfltWrUjPqL7/Uj49xjFPzCvyXe/eP02TLpfxG3gsvyoWeaFkA7/4vEvR/artpxzEFes0
        G3tPqq4zc70qxc1fLbdnzyVN9V3lW+Zc5cs+w8P+dr3h5809vflf/ZVYijMSDbWYi4oTAWfq
        8rdKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvK7LwZIkgwtfBC0ezNvGZvF30jF2
        i2NtT9gt7iyYxmRxavlCJovmxevZLObcNLK4+/AHi8Xe11vZLTY9vsZqcXnXHDaLGef3MVks
        WtbKbNFytJ3FonnTFFaLzxseM1p03b3BaDHpoKjF/iteDsIev39NYvT49nUSi8fshossHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCeKC6blNSczLLU
        In27BK6MpquL2QtalCpeXG5hb2Bskuli5OSQEDCROLrhJksXIxeHkMBuRoknU5+yQCQkJZbO
        vcEOYQtL3G85wgpR9I1RouPvXbYuRg4ONgEtie8LGUFqRATmMkts3VoEUsMscJZZ4s/T1WA1
        wgKOEss38oLUsAioSkxp3coEYvMKuEq8P9kONV9O4ua5TmYQm1PATeLS1C1gM4WAahb++c48
        gZFvASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4FjR0tzBuH3VB71DjEwcjIcY
        JTiYlUR4hWeVJAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXAdDrL8UagtMslFsYdm/6vmWSealDhGrDSoTBxhpfix79Tn+6Y88xrnla0k/T3A+8lvwXI
        letd3Rpy7UiZh3S6nsbpql+Wv7lTT23xm+gcyCAxIX3dxW3bwq5ldnxISVV7vX3+kdlLu8q3
        bfpb8LmuyzKuz02ugLd8umBmco11wLyrr+Q15u9xzq7XbEnX9s9e0Wn3YodBdtfCmmmxJ162
        L6tw/tqWNbnn56tDa5OD/FcIBt0vCrbx2f3xSFEem3+W2rSMj9tnCqzev6QtdOUK8Y+zGvcx
        FP91qT1n6TRB2/yn78azdcsWbZRace1foljkAdepk07KRqtxe1du0dyRvl3rb4PEwVN9B9iY
        H6b8UGIpzkg01GIuKk4EACDKll8EAwAA
X-CMS-MailID: 20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063340epcas2p4c9d88670f9be952f3637e3a545a7d1da@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for xHCI Host Controller driver on Exynos SOC.
It registers vendor ops before loading xhci platform driver.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 100 ++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 0ecf20eeceee..c22ea5cd6ab0 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -17,6 +17,12 @@
 #include <linux/of_platform.h>
 #include <linux/regulator/consumer.h>
 
+#include "core.h"
+
+#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
+int xhci_exynos_register_vendor_ops(void);
+#endif
+
 #define DWC3_EXYNOS_MAX_CLOCKS	4
 
 struct dwc3_exynos_driverdata {
@@ -27,6 +33,7 @@ struct dwc3_exynos_driverdata {
 
 struct dwc3_exynos {
 	struct device		*dev;
+	struct dwc3		*dwc;
 
 	const char		**clk_names;
 	struct clk		*clks[DWC3_EXYNOS_MAX_CLOCKS];
@@ -46,12 +53,81 @@ static int dwc3_exynos_remove_child(struct device *dev, void *unused)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
+static int dwc3_exynos_host_init(struct dwc3_exynos *exynos)
+{
+	struct dwc3		*dwc = exynos->dwc;
+	struct device		*dev = exynos->dev;
+	struct platform_device	*xhci;
+	struct resource		*res;
+	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
+	int			ret = 0;
+
+	/* Configuration xhci resources */
+	xhci_exynos_register_vendor_ops();
+
+	res = platform_get_resource(dwc3_pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing memory resource\n");
+		return -ENODEV;
+	}
+	dwc->xhci_resources[0].start = res->start;
+	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
+					DWC3_XHCI_REGS_END;
+	dwc->xhci_resources[0].flags = res->flags;
+	dwc->xhci_resources[0].name = res->name;
+
+	res = platform_get_resource(dwc3_pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "missing irq resource\n");
+		return -ENODEV;
+	}
+
+	dwc->xhci_resources[1].start = dwc->irq_gadget;
+	dwc->xhci_resources[1].end = dwc->irq_gadget;
+	dwc->xhci_resources[1].flags = res->flags;
+	dwc->xhci_resources[1].name = res->name;
+
+	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
+	if (!xhci) {
+		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
+		return -ENOMEM;
+	}
+
+	xhci->dev.parent	= dwc->dev;
+	ret = dma_set_mask_and_coherent(&xhci->dev, DMA_BIT_MASK(36));
+	if (ret) {
+		pr_err("xhci dma set mask ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_device_add_resources(xhci, dwc->xhci_resources,
+						DWC3_XHCI_RESOURCES_NUM);
+	if (ret) {
+		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
+		goto err;
+	}
+
+	ret = platform_device_add(xhci);
+	if (ret) {
+		dev_err(dwc->dev, "couldn't add xHCI device\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	platform_device_put(xhci);
+	return ret;
+}
+#endif
+
 static int dwc3_exynos_probe(struct platform_device *pdev)
 {
 	struct dwc3_exynos	*exynos;
 	struct device		*dev = &pdev->dev;
-	struct device_node	*node = dev->of_node;
+	struct device_node	*node = dev->of_node, *dwc3_np;
 	const struct dwc3_exynos_driverdata *driver_data;
+	struct platform_device *dwc3_pdev;
 	int			i, ret;
 
 	exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
@@ -109,6 +185,12 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto vdd10_err;
 	}
 
+	dwc3_np = of_get_compatible_child(node, "snps,dwc3");
+	if (!dwc3_np) {
+		dev_err(dev, "failed to find dwc3 core child!\n");
+		goto vdd33_err;
+	}
+
 	if (node) {
 		ret = of_platform_populate(node, NULL, NULL, dev);
 		if (ret) {
@@ -121,6 +203,22 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
 		goto populate_err;
 	}
 
+	dwc3_pdev = of_find_device_by_node(dwc3_np);
+	exynos->dwc = platform_get_drvdata(dwc3_pdev);
+	if (!exynos->dwc) {
+		ret = -EPROBE_DEFER;
+		dev_err(dev, "failed to get dwc3 core node!\n");
+		goto populate_err;
+	}
+
+#if IS_ENABLED(CONFIG_USB_XHCI_EXYNOS)
+	/* USB host initialization. */
+	ret = dwc3_exynos_host_init(exynos);
+	if (ret) {
+		dev_err(dev, "USB host pre-initialization fail!\n");
+		goto populate_err;
+	}
+#endif
 	return 0;
 
 populate_err:
-- 
2.31.1

