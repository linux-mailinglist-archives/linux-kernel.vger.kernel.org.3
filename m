Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CFA4D57AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbiCKB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiCKB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:56:11 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841019D751
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:55:06 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220311015502epoutp01a55513eb756a82ce1490679d474b7ce1~bMMMKkKUF1567915679epoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:55:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220311015502epoutp01a55513eb756a82ce1490679d474b7ce1~bMMMKkKUF1567915679epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646963703;
        bh=6GflsjQ7Mm9rWX70uL0WTVJxcMEIPkbVymAImoVej2k=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=XjUMfnv+nqDUGiSrwtrcOGuNbK3/YyLoSZGGQgo7B+ADHvVR9uv/kQVdTpLP2iIO1
         pgfA9gVlDXgHjKmCWtgcvL42c+0881sK2f1k/FnL9tpeYU5+euEp1tcnDobjT6Ho8L
         tlr0kNCipbiM8fySK5anWrjiUQehQoNasxWHRd98=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220311015502epcas5p231e246c27d8107bff45663d5f7832314~bMMLcQaKv2663926639epcas5p2O;
        Fri, 11 Mar 2022 01:55:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KF8Bn1s61z4x9Q9; Fri, 11 Mar
        2022 01:54:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.AA.06423.1FBAA226; Fri, 11 Mar 2022 10:54:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220311015456epcas5p4d04741216c82091cbe6fca83cbfa832f~bMMGD7J011309313093epcas5p4u;
        Fri, 11 Mar 2022 01:54:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220311015456epsmtrp2c3ca1a96a2d94019102fd9fbcfdf74bc~bMMGDM7wS0776207762epsmtrp2A;
        Fri, 11 Mar 2022 01:54:56 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-94-622aabf10b0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.E8.29871.0FBAA226; Fri, 11 Mar 2022 10:54:56 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220311015455epsmtip2ed8a4286ea5368676ab69081f5dda2c7~bMMEyZdMU0664006640epsmtip2h;
        Fri, 11 Mar 2022 01:54:54 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Vinod Koul'" <vkoul@kernel.org>,
        "'Miaoqian Lin'" <linmq006@gmail.com>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH] phy: samsung: exynos5250-sata: fix missing device put
 in probe error paths
Date:   Fri, 11 Mar 2022 07:24:53 +0530
Message-ID: <018501d834eb$01e62ad0$05b28070$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFk9GdFcluxqBuuM3cfs7kS0OZnrAJRu4lfrY1fA0A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmlu7H1VpJBg9fs1tceNrDZrHx7Q8m
        i+cfG5ktNj2+xmpxedccNosJq76xWMw4v4/JYuedE8wOHB6zGnrZPHbOusvusWlVJ5vH5iX1
        HsdvbGfy+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+geJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5e
        aomVoYGBkSlQYUJ2xuf7jgWzxCt+/elgaWB8I9zFyMkhIWAicfbLbbYuRi4OIYHdjBLzpy9h
        hnA+MUr8fzmDFcL5xigxd+ptdpiW8wuuQlXtZZT48fc/E4TzklGir/UnK0gVm4CuxI7FbWCD
        RQROM0ksn3+TCSTBKeAucercCrAiYYFEia57x8HGsgioSvy7foaxi5GDg1fAUqLruSFImFdA
        UOLkzCcsIDazgLzE9rdzmCGuUJD4+XQZ2BgRASuJ2befs0HUiEu8PHqEHWSvhMBCDolH/16w
        QjS4SBzveAVlC0u8Or4F6h0pic/v9rKB7JUQyJbo2WUMEa6RWDrvGAuEbS9x4MocFpASZgFN
        ifW79CFW8Un0/n7CBNHJK9HRJgRRrSrR/O4qVKe0xMTubqilHhIX+2+wQ4JqFqPE2YNTGScw
        KsxC8uUsJF/OQvLNLITNCxhZVjFKphYU56anFpsWGOallsPjOzk/dxMjOLVqee5gvPvgg94h
        RiYOxkOMEhzMSiK8TaEaSUK8KYmVValF+fFFpTmpxYcYTYEhP5FZSjQ5H5jc80riDU0sDUzM
        zMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYNKQl7GZazS1dOGt0vNZJ5bxpQm8
        OHyn3fnXnmlGM+5VGy2dFfx+tet2j/fu7OtaIs5tkLXqW28v9mX72c+cZ0/NPDjj9J+Hr53W
        HXTQCE896csqulO9/eXS4LXWalUfzO/94vllL5Yu3Fm9aNaHne1BM/e+r24pzf36KamSoayv
        XSHj+1YWDTfnno2f51/1r0tWjroWH1e2cuOlMLnbv2e4asg3Zvb5pixJ7Jn4nUlyMbfpgtl3
        +NZxHF33fpfyn2qGdxqTfdv4GN8fWJEly2NvlbZr3tUzn7x0VRPXOxsW2WWeaT4poK5+80gd
        +3T+qR763Wv00kpTWefvWMi4IlPb19GjvGC5Z8s7Rbm9E5VYijMSDbWYi4oTAdrtTLA2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvO6H1VpJBpvPCFhceNrDZrHx7Q8m
        i+cfG5ktNj2+xmpxedccNosJq76xWMw4v4/JYuedE8wOHB6zGnrZPHbOusvusWlVJ5vH5iX1
        HsdvbGfy+LxJLoAtissmJTUnsyy1SN8ugSvj833HglniFb/+dLA0ML4R7mLk5JAQMJE4v+Aq
        cxcjF4eQwG5GifULb7BAJKQlrm+cwA5hC0us/PcczBYSeM4ocfB8FIjNJqArsWNxGxtIs4jA
        RSaJ+49nskJMmsEosW7rBSaQKk4Bd4lT51awgtjCAvES2w40MILYLAKqEv+unwGyOTh4BSwl
        up4bgoR5BQQlTs58wgISZhbQk2jbCFbNLCAvsf3tHGaIexQkfj5dBjZRRMBKYvbt52wQNeIS
        L48eYZ/AKDQLyaRZCJNmIZk0C0nHAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsY
        wTGkpbmDcfuqD3qHGJk4GA8xSnAwK4nwNoVqJAnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1
        Ml5IID2xJDU7NbUgtQgmy8TBKdXAZDo9byf/bfnVvidnuvQe+7Pg27s/+iV9s7qeh9wu/Dx7
        QsOP40uuyh7489FDyibcfMEcf44dfaWmJvKGYdrGZ3canJnuXdsXcFZE7GfQNvuX7pcW/HS6
        /qY7XPPiikMzzi57PnOX+Nslux027Pz85diGnYv+Tpxo377sCgOb8N4HRjVKX12717wXibv5
        U3zPe0u+uZWGaVVu4YpPxXIDJ+42+5XRbVP/pFNsxRy1yMPM2hv1NVt6v+gyid5cXOZUppDX
        +bpoyZ7oa3PTRKuXTwyw9NRhSo/6dXSJ2Uw7//Z500Wd/9m9O1QyVf/5q2smugdWislXhy0q
        2jXbY5fApNCdua2dn0vmfNtkpfYwL1OJpTgj0VCLuag4EQB7HhT0EAMAAA==
X-CMS-MailID: 20220311015456epcas5p4d04741216c82091cbe6fca83cbfa832f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220309170036epcas5p2e6ee56f4c38761868ad9408616c03203
References: <CGME20220309170036epcas5p2e6ee56f4c38761868ad9408616c03203@epcas5p2.samsung.com>
        <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Wednesday, March 9, 2022 10:30 PM
>To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
><vkoul@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Miaoqian Lin <linmq006@gmail.com>; linux-
>phy@lists.infradead.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH] phy: samsung: exynos5250-sata: fix missing device put in
>probe error paths
>
>The actions of of_find_i2c_device_by_node() in probe function should be
>reversed in error paths by putting the reference to obtained device.
>
>Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
Thanks for fixing this.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>---
>
>Rebased on top of (although it is independent, no conflicts):
>https://lore.kernel.org/linux-samsung-soc/20220309124856.32632-1-
>linmq006@gmail.com/T/#u
>---
> drivers/phy/samsung/phy-exynos5250-sata.c | 20 ++++++++++++++------
> 1 file changed, 14 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c
>b/drivers/phy/samsung/phy-exynos5250-sata.c
>index 6c305a3fe187..595adba5fb8f 100644
>--- a/drivers/phy/samsung/phy-exynos5250-sata.c
>+++ b/drivers/phy/samsung/phy-exynos5250-sata.c
>@@ -196,20 +196,21 @@ static int exynos_sata_phy_probe(struct
>platform_device *pdev)
> 	sata_phy->phyclk = devm_clk_get(dev, "sata_phyctrl");
> 	if (IS_ERR(sata_phy->phyclk)) {
> 		dev_err(dev, "failed to get clk for PHY\n");
>-		return PTR_ERR(sata_phy->phyclk);
>+		ret = PTR_ERR(sata_phy->phyclk);
>+		goto put_dev;
> 	}
>
> 	ret = clk_prepare_enable(sata_phy->phyclk);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to enable source clk\n");
>-		return ret;
>+		goto put_dev;
> 	}
>
> 	sata_phy->phy = devm_phy_create(dev, NULL,
>&exynos_sata_phy_ops);
> 	if (IS_ERR(sata_phy->phy)) {
>-		clk_disable_unprepare(sata_phy->phyclk);
> 		dev_err(dev, "failed to create PHY\n");
>-		return PTR_ERR(sata_phy->phy);
>+		ret = PTR_ERR(sata_phy->phy);
>+		goto clk_disable;
> 	}
>
> 	phy_set_drvdata(sata_phy->phy, sata_phy); @@ -217,11 +218,18
>@@ static int exynos_sata_phy_probe(struct platform_device *pdev)
> 	phy_provider = devm_of_phy_provider_register(dev,
> 					of_phy_simple_xlate);
> 	if (IS_ERR(phy_provider)) {
>-		clk_disable_unprepare(sata_phy->phyclk);
>-		return PTR_ERR(phy_provider);
>+		ret = PTR_ERR(phy_provider);
>+		goto clk_disable;
> 	}
>
> 	return 0;
>+
>+clk_disable:
>+	clk_disable_unprepare(sata_phy->phyclk);
>+put_dev:
>+	put_device(&sata_phy->client->dev);
>+
>+	return ret;
> }
>
> static const struct of_device_id exynos_sata_phy_of_match[] = {
>--
>2.32.0


