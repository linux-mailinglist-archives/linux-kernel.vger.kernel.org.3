Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDC5A17EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiHYRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiHYRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:23:57 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EDB8A77
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:23:54 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220825172352epoutp02078eafb33301103832f33ff0ef10b59f~Opl1qLKgk1241212412epoutp02w
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:23:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220825172352epoutp02078eafb33301103832f33ff0ef10b59f~Opl1qLKgk1241212412epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661448232;
        bh=+iq854JY5Rl+gEgILI4k8JciYQAIHHt8VT0JAgZB+rE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=m39lTo8JGLIYNEQA9FoiS40f5uCVMcUUKwa0bN0OVAvvd3eCyWC1YQ4BqZgC3p/01
         dEFoEYQB9NEDedlA87CC4b8Ns3VaglJIkLnMscNoZnJWzI1FY07CLQ8B0Gvc8Qel1q
         1jrQZrVyig/j1WIbxiZTDuhxbInjDcwCxpK72+YA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220825172351epcas5p226cbbcf5f9d756abc6632490706d8b96~Opl0Qwzmz1687816878epcas5p2U;
        Thu, 25 Aug 2022 17:23:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MD8vT3mtJz4x9Pp; Thu, 25 Aug
        2022 17:23:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.86.53458.520B7036; Fri, 26 Aug 2022 02:23:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220825172348epcas5p19d6b4703b2355b0db52e2bc2f0cd8e8a~Oplx_NC2q3212832128epcas5p1m;
        Thu, 25 Aug 2022 17:23:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220825172348epsmtrp1117412528eaa997878282152927931af~Oplx9Q1OK1972919729epsmtrp1V;
        Thu, 25 Aug 2022 17:23:48 +0000 (GMT)
X-AuditID: b6c32a4a-a5bff7000000d0d2-66-6307b0257004
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.D5.18644.420B7036; Fri, 26 Aug 2022 02:23:48 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220825172345epsmtip2c897af43570cdfe4a99e863bce82163d~OplvR98dQ1221812218epsmtip2R;
        Thu, 25 Aug 2022 17:23:45 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Ard Biesheuvel'" <ardb@kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Alan Stern'" <stern@rowland.harvard.edu>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Nicolas Ferre'" <nicolas.ferre@microchip.com>,
        "'Alexandre Belloni'" <alexandre.belloni@bootlin.com>,
        "'Claudiu Beznea'" <claudiu.beznea@microchip.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Avi Fishman'" <avifishman70@gmail.com>,
        "'Tomer Maimon'" <tmaimon77@gmail.com>,
        "'Tali Perry'" <tali.perry1@gmail.com>,
        "'Patrick Venture'" <venture@google.com>,
        "'Nancy Yuen'" <yuenn@google.com>,
        "'Benjamin Fair'" <benjaminfair@google.com>,
        "'Patrice Chotard'" <patrice.chotard@foss.st.com>,
        "'Vladimir Zapolskiy'" <vz@mleia.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-omap@vger.kernel.org>
In-Reply-To: <20220825170327.674446-1-ardb@kernel.org>
Subject: RE: [RFC PATCH] usb: reduce kernel log spam on driver registration
Date:   Thu, 25 Aug 2022 22:53:44 +0530
Message-ID: <065601d8b8a7$6fee5850$4fcb08f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE+q3nSdIaCERkMHuLgOUMV1aT/lQIBke/SruPps0A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbVRjd7Xu8V8iqbwXkWtThiwTBlFGk3YOMMePiXpwYIiMm6oRSni1C
        f6SvdTBNVqy0/Iij0zpnxwyUFXTCWMsY0A1ENkEMAeZ0BoUFMqYCGzB+LBSI2vKY8t/5zj3f
        d75zby4fEfowET9fY2D0GnkhiYWgl67GxoijL+CKhHaHiLLO1uOUb2kOUL7Pj/OoU53jCDXU
        tY5T5rpmjOqcacUpz+2bQdQNbzVGnT5bhVKnhrp4lLO+FKHaWmoRytc/h1O2tWGM8naX4NTq
        xWlAdXa7UeqfVTNCWVbrsX1h9JeN79N3qlpxusMxhtM1HiPtOVeO0aM3r2D0t2cacbrl7DF6
        dMUF6L9r7Sh9emwF0IuepzK2v1GwR8XI8xh9FKNRaPPyNcpU8mBm9ovZUlmCRCxJpnaTURq5
        mkkl97+SIX4pv9Cfk4x6T15o9FMZcpYld+3do9caDUyUSssaUklGl1eoS9LFs3I1a9Qo4zWM
        IUWSkJAo9QtzClTXqi7wdHcNRcvrdtwE+pgKEMyHRBIsL/2dVwFC+ELiMoCDV9Y2iwUAHwy3
        IFyxCGBT+VjQw5bzsx/h3IEXQKt9aFM1BaCtYxIJqDBCDNvrLFgAhxE09JR8hwYwQtRj0HdZ
        HMDBhAzODNf5J/H5ocRB2PZXUYBGiWhoca5u0AIiGdoXhQFaQOyA/V9Mbk7ZCdvuVSPcPlHQ
        d6c+iHNKgW1TgQQBTQSc+v7axp6QaAiGfXedGNewH/aO21AOh8Lpvos4h0Vwqsqy4Qv9KzvX
        RRytgvcamgGH02D3z9VoQIIQsbDZu4uzegR+vDbJ4zoFsMwi5NTR0Dz7y6ZRJDxRWbl5g/7h
        tVbcBp52bAnm2BLMsSWA43+zGoCeA48zOlatZFipLlHDHPnvtRVatQds/IG4l9vBxPh8fA/g
        8UEPgHyEDBOk9KIKoSBPXnyU0Wuz9cZChu0BUv9ln0BE4Qqt/xNpDNmSpOSEJJlMlpT8vExC
        RgjszwGFkFDKDUwBw+gY/cM+Hj9YZOJJipum46+H1ky0OqMfHXSlPBGytvDn/aLDV7efzHX5
        zA0jmQdsI205VX9cOt51aD4ro2Vl30TtAjU/aj4wsEgWLz8oK51RN7gipz+zfmB0u7Hh3TeY
        /prcOeWxH9O1OWnW1iX34Ftv/3a+dL+ypyFOWa4XD6Ykm9Nd9GiW9MMV6QA7kPjp6/DMs6av
        wcDSjhfqYo7cX67IH8m8vv6OO8MUeyvC7nLLKvM12q9mYtKeDJ/YViJ5hhfeXCb6xrBoOInn
        2g6/WkSYbqcfHdz2U+3OguIxrwHp3UtGtuTOv2t5rMNUlHULx3xv/qBq+sRT+at1otd3aCVT
        FNKY+VqiM1zt9JIoq5JL4hA9K/8XkAKKl4wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSvK7KBvZkgy8TFS3a3y1jt/j55T2j
        xc/pfUwWM/Y+YLY4v+8Pu0Xz4vVsFntfb2W32PT4GqvF5V1z2CxmL+lnsZhxfh+TxaJlrcwW
        2zcvZLb4efI9u8WE3xfYLHYdaGS3+LXlFaPF3gMbWSz+/2pmtmj7tYzNQcRj3ppqj6f9W9k9
        ds66y+6xYFOpx6ZVnWwed67tYfPYP3cNu8fmJfUed34sZfT4t3AKi8fsuz8YPT5vkgvgieKy
        SUnNySxLLdK3S+DKONK/gangTUnF1z9T2BsYj6d2MXJySAiYSKx718LexcjFISSwg1Hi6+ep
        jBAJaYnrGyewQ9jCEiv/PYcqes4ocenMNWaQBJuArsSOxW1sILaIgJfE1+tPWECKmAU2sEls
        edQK1dHOKHFuz3ywDk4BM4nXFxYDJTg4hAW8Jba/qAAJswioSrQt+gUW5hWwlJjyWQgkzCsg
        KHFyJshMDqCZehJtG8FuYxaQl9j+dg4zxG0KEj+fLmOFOMFKYvvL30wQNeISL48eYZ/AKDwL
        yaRZCJNmIZk0C0nHAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwclAS2sH455V
        H/QOMTJxMB5ilOBgVhLhtTrGkizEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs
        1NSC1CKYLBMHp1QD08rQ5zuNBa8vt0x6klOQ9eikyHWn9EVHLbnui/ULTzDSOmMgbxjxZ0bW
        t7eiyasqbh77d/66zeVNGXkxSdz3s/W+myTWLQwoVPSKf7I088suWYnaZ8EPXs07IxccyVMj
        GNuXsO7I0SIFlXlvqkte8AssmbjLeX7qvYCa/D4HfdbkHUeeCFpp9ql+uCjg3C91dtvVzAdv
        z7luyLvYP+kPw/9VDf2/P3GcixN40ad0NUjlsfTHnI/zjikHzzhyfdHPfg+/6YdZee9xr9VK
        PnLD1clYeU/oXsY3j2MP97VcvNv0idtyftjVtpV3SnkUrtTf/hFps3PL2cumi17v7L4ictVo
        kUSCrWdf4Hp1gXulrEosxRmJhlrMRcWJAE+4L6p1AwAA
X-CMS-MailID: 20220825172348epcas5p19d6b4703b2355b0db52e2bc2f0cd8e8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56
References: <CGME20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56@epcas5p2.samsung.com>
        <20220825170327.674446-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Ard Biesheuvel [mailto:ardb@kernel.org]
>Sent: Thursday, August 25, 2022 10:33 PM
>To: linux-kernel@vger.kernel.org
>Cc: Ard Biesheuvel <ardb@kernel.org>; Alan Stern
><stern@rowland.harvard.edu>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Nicolas Ferre
><nicolas.ferre@microchip.com>; Alexandre Belloni
><alexandre.belloni@bootlin.com>; Claudiu Beznea
><claudiu.beznea@microchip.com>; Krzysztof Kozlowski
><krzysztof.kozlowski@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>Avi Fishman <avifishman70@gmail.com>; Tomer Maimon
><tmaimon77@gmail.com>; Tali Perry <tali.perry1@gmail.com>; Patrick
>Venture <venture@google.com>; Nancy Yuen <yuenn@google.com>;
>Benjamin Fair <benjaminfair@google.com>; Patrice Chotard
><patrice.chotard@foss.st.com>; Vladimir Zapolskiy <vz@mleia.com>; linux-
>usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-
>soc@vger.kernel.org; linux-omap@vger.kernel.org
>Subject: [RFC PATCH] usb: reduce kernel log spam on driver registration
>
>Drivers are typically supposed to be quiet unless they are actually probed,
but
>for some reason, USB host controllers seem to be exempt from this rule, and
>happily broadcast their existence into the kernel log at boot even if the
>hardware in question is nowhere to be found.
>
>Let's fix that, and remove these pr_info() calls.
>
How about just change pr_info() to pr_debug() instead? 

>Cc: Alan Stern <stern@rowland.harvard.edu>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Cc: Alim Akhtar <alim.akhtar@samsung.com>
>Cc: Avi Fishman <avifishman70@gmail.com>
>Cc: Tomer Maimon <tmaimon77@gmail.com>
>Cc: Tali Perry <tali.perry1@gmail.com>
>Cc: Patrick Venture <venture@google.com>
>Cc: Nancy Yuen <yuenn@google.com>
>Cc: Benjamin Fair <benjaminfair@google.com>
>Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>Cc: Vladimir Zapolskiy <vz@mleia.com>
>Cc: linux-usb@vger.kernel.org
>Cc: linux-arm-kernel@lists.infradead.org
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-samsung-soc@vger.kernel.org
>Cc: linux-omap@vger.kernel.org
>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
> drivers/usb/host/ehci-atmel.c    | 1 -
> drivers/usb/host/ehci-exynos.c   | 1 -
> drivers/usb/host/ehci-fsl.c      | 2 --
> drivers/usb/host/ehci-hcd.c      | 1 -
> drivers/usb/host/ehci-npcm7xx.c  | 2 --
> drivers/usb/host/ehci-omap.c     | 2 --
> drivers/usb/host/ehci-orion.c    | 2 --
> drivers/usb/host/ehci-pci.c      | 2 --
> drivers/usb/host/ehci-platform.c | 2 --
> drivers/usb/host/ehci-spear.c    | 2 --
> drivers/usb/host/ehci-st.c       | 2 --
> drivers/usb/host/fotg210-hcd.c   | 1 -
> drivers/usb/host/ohci-at91.c     | 1 -
> drivers/usb/host/ohci-da8xx.c    | 1 -
> drivers/usb/host/ohci-exynos.c   | 1 -
> drivers/usb/host/ohci-hcd.c      | 1 -
> drivers/usb/host/ohci-nxp.c      | 2 --
> drivers/usb/host/ohci-omap.c     | 2 --
> drivers/usb/host/ohci-pci.c      | 2 --
> drivers/usb/host/ohci-platform.c | 2 --
> drivers/usb/host/ohci-pxa27x.c   | 2 --
> drivers/usb/host/ohci-s3c2410.c  | 1 -
> drivers/usb/host/ohci-spear.c    | 2 --
> drivers/usb/host/ohci-st.c       | 2 --
> 24 files changed, 39 deletions(-)
>
>diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
>index 05d41fd65f25..0e995019c1df 100644
>--- a/drivers/usb/host/ehci-atmel.c
>+++ b/drivers/usb/host/ehci-atmel.c
>@@ -239,7 +239,6 @@ static int __init ehci_atmel_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	ehci_init_driver(&ehci_atmel_hc_driver,
>&ehci_atmel_drv_overrides);
> 	return platform_driver_register(&ehci_atmel_driver);
> }
>diff --git a/drivers/usb/host/ehci-exynos.c
b/drivers/usb/host/ehci-exynos.c
>index 1a9b7572e17f..a65e365e3a04 100644
>--- a/drivers/usb/host/ehci-exynos.c
>+++ b/drivers/usb/host/ehci-exynos.c
>@@ -347,7 +347,6 @@ static int __init ehci_exynos_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	ehci_init_driver(&exynos_ehci_hc_driver, &exynos_overrides);
> 	return platform_driver_register(&exynos_ehci_driver);
> }
>diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index
>896c0d107f72..9cea785934e5 100644
>--- a/drivers/usb/host/ehci-fsl.c
>+++ b/drivers/usb/host/ehci-fsl.c
>@@ -722,8 +722,6 @@ static int __init ehci_fsl_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info(DRV_NAME ": " DRIVER_DESC "\n");
>-
> 	ehci_init_driver(&fsl_ehci_hc_driver, &ehci_fsl_overrides);
>
> 	fsl_ehci_hc_driver.product_desc =
>diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index
>684164fa9716..a1930db0da1c 100644
>--- a/drivers/usb/host/ehci-hcd.c
>+++ b/drivers/usb/host/ehci-hcd.c
>@@ -1351,7 +1351,6 @@ static int __init ehci_hcd_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	printk(KERN_INFO "%s: " DRIVER_DESC "\n", hcd_name);
> 	set_bit(USB_EHCI_LOADED, &usb_hcds_loaded);
> 	if (test_bit(USB_UHCI_LOADED, &usb_hcds_loaded) ||
> 			test_bit(USB_OHCI_LOADED, &usb_hcds_loaded))
>diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-
>npcm7xx.c index 6b5a7a873e01..4321ac6b11cc 100644
>--- a/drivers/usb/host/ehci-npcm7xx.c
>+++ b/drivers/usb/host/ehci-npcm7xx.c
>@@ -191,8 +191,6 @@ static int __init ehci_npcm7xx_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_npcm7xx_hc_driver, NULL);
> 	return platform_driver_register(&npcm7xx_ehci_hcd_driver);
> }
>diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>index 8c45bc17a580..7dd984722a7f 100644
>--- a/drivers/usb/host/ehci-omap.c
>+++ b/drivers/usb/host/ehci-omap.c
>@@ -284,8 +284,6 @@ static int __init ehci_omap_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_omap_hc_driver, &ehci_omap_overrides);
> 	return platform_driver_register(&ehci_hcd_omap_driver);
> }
>diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
>index 3626758b3e2a..2c8b1e6f1fff 100644
>--- a/drivers/usb/host/ehci-orion.c
>+++ b/drivers/usb/host/ehci-orion.c
>@@ -361,8 +361,6 @@ static int __init ehci_orion_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_orion_hc_driver, &orion_overrides);
> 	return platform_driver_register(&ehci_orion_driver);
> }
>diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index
>9937c5a7efc2..9581952d999a 100644
>--- a/drivers/usb/host/ehci-pci.c
>+++ b/drivers/usb/host/ehci-pci.c
>@@ -423,8 +423,6 @@ static int __init ehci_pci_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_pci_hc_driver, &pci_overrides);
>
> 	/* Entries for the PCI suspend/resume callbacks are special */ diff
--git
>a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>index 6924f0316e9a..50491eea9409 100644
>--- a/drivers/usb/host/ehci-platform.c
>+++ b/drivers/usb/host/ehci-platform.c
>@@ -529,8 +529,6 @@ static int __init ehci_platform_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
> 	return platform_driver_register(&ehci_platform_driver);
> }
>diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
>index 3694e450a11a..13369289d9cc 100644
>--- a/drivers/usb/host/ehci-spear.c
>+++ b/drivers/usb/host/ehci-spear.c
>@@ -167,8 +167,6 @@ static int __init ehci_spear_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_spear_hc_driver, &spear_overrides);
> 	return platform_driver_register(&spear_ehci_hcd_driver);
> }
>diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c index
>f74433aac948..1086078133f8 100644
>--- a/drivers/usb/host/ehci-st.c
>+++ b/drivers/usb/host/ehci-st.c
>@@ -346,8 +346,6 @@ static int __init ehci_platform_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
> 	return platform_driver_register(&ehci_platform_driver);
> }
>diff --git a/drivers/usb/host/fotg210-hcd.c
b/drivers/usb/host/fotg210-hcd.c
>index f8c111e08a0d..3d1dbcf4c073 100644
>--- a/drivers/usb/host/fotg210-hcd.c
>+++ b/drivers/usb/host/fotg210-hcd.c
>@@ -5692,7 +5692,6 @@ static int __init fotg210_hcd_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	set_bit(USB_EHCI_LOADED, &usb_hcds_loaded);
> 	if (test_bit(USB_UHCI_LOADED, &usb_hcds_loaded) ||
> 			test_bit(USB_OHCI_LOADED, &usb_hcds_loaded))
>diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index
>98326465e2dc..adf0998f0299 100644
>--- a/drivers/usb/host/ohci-at91.c
>+++ b/drivers/usb/host/ohci-at91.c
>@@ -699,7 +699,6 @@ static int __init ohci_at91_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	ohci_init_driver(&ohci_at91_hc_driver, &ohci_at91_drv_overrides);
>
> 	/*
>diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
>index 1371b0c249ec..d4818e8d652b 100644
>--- a/drivers/usb/host/ohci-da8xx.c
>+++ b/drivers/usb/host/ohci-da8xx.c
>@@ -551,7 +551,6 @@ static int __init ohci_da8xx_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", DRV_NAME);
> 	ohci_init_driver(&ohci_da8xx_hc_driver, &da8xx_overrides);
>
> 	/*
>diff --git a/drivers/usb/host/ohci-exynos.c
b/drivers/usb/host/ohci-exynos.c
>index 5f5e8a64c8e2..a060be6ae274 100644
>--- a/drivers/usb/host/ohci-exynos.c
>+++ b/drivers/usb/host/ohci-exynos.c
>@@ -310,7 +310,6 @@ static int __init ohci_exynos_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	ohci_init_driver(&exynos_ohci_hc_driver, &exynos_overrides);
> 	return platform_driver_register(&exynos_ohci_driver);
> }
>diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index
>c4c821c2288c..0457dd9f6c19 100644
>--- a/drivers/usb/host/ohci-hcd.c
>+++ b/drivers/usb/host/ohci-hcd.c
>@@ -1276,7 +1276,6 @@ static int __init ohci_hcd_mod_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	printk(KERN_INFO "%s: " DRIVER_DESC "\n", hcd_name);
> 	pr_debug ("%s: block sizes: ed %zd td %zd\n", hcd_name,
> 		sizeof (struct ed), sizeof (struct td));
> 	set_bit(USB_OHCI_LOADED, &usb_hcds_loaded); diff --git
>a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c index
>106a6bcefb08..5b32e683e367 100644
>--- a/drivers/usb/host/ohci-nxp.c
>+++ b/drivers/usb/host/ohci-nxp.c
>@@ -275,8 +275,6 @@ static int __init ohci_nxp_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_nxp_hc_driver, NULL);
> 	return platform_driver_register(&ohci_hcd_nxp_driver);
> }
>diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
>index f5bc9c8bdc9a..cb29701df911 100644
>--- a/drivers/usb/host/ohci-omap.c
>+++ b/drivers/usb/host/ohci-omap.c
>@@ -423,8 +423,6 @@ static int __init ohci_omap_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
> 	return platform_driver_register(&ohci_hcd_omap_driver);
> }
>diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index
>41efe927d8f3..a146b2d3ef0b 100644
>--- a/drivers/usb/host/ohci-pci.c
>+++ b/drivers/usb/host/ohci-pci.c
>@@ -306,8 +306,6 @@ static int __init ohci_pci_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_pci_hc_driver, &pci_overrides);
>
> #ifdef	CONFIG_PM
>diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-
>platform.c
>index 0adae6265127..6d56b52966c7 100644
>--- a/drivers/usb/host/ohci-platform.c
>+++ b/drivers/usb/host/ohci-platform.c
>@@ -346,8 +346,6 @@ static int __init ohci_platform_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
> 	return platform_driver_register(&ohci_platform_driver);
> }
>diff --git a/drivers/usb/host/ohci-pxa27x.c
b/drivers/usb/host/ohci-pxa27x.c
>index ab4f610a0140..f2504b884e92 100644
>--- a/drivers/usb/host/ohci-pxa27x.c
>+++ b/drivers/usb/host/ohci-pxa27x.c
>@@ -608,8 +608,6 @@ static int __init ohci_pxa27x_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_pxa27x_hc_driver, &pxa27x_overrides);
> 	ohci_pxa27x_hc_driver.hub_control = pxa27x_ohci_hub_control;
>
>diff --git a/drivers/usb/host/ohci-s3c2410.c
b/drivers/usb/host/ohci-s3c2410.c
>index 12264c048601..7207c7a3cf49 100644
>--- a/drivers/usb/host/ohci-s3c2410.c
>+++ b/drivers/usb/host/ohci-s3c2410.c
>@@ -474,7 +474,6 @@ static int __init ohci_s3c2410_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> 	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
>
> 	/*
>diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
>index 9b81f420656d..71a3f18fe1be 100644
>--- a/drivers/usb/host/ohci-spear.c
>+++ b/drivers/usb/host/ohci-spear.c
>@@ -179,8 +179,6 @@ static int __init ohci_spear_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_spear_hc_driver, &spear_overrides);
> 	return platform_driver_register(&spear_ohci_hcd_driver);
> }
>diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c index
>ac796ccd93ef..2e542a344aae 100644
>--- a/drivers/usb/host/ohci-st.c
>+++ b/drivers/usb/host/ohci-st.c
>@@ -324,8 +324,6 @@ static int __init ohci_platform_init(void)
> 	if (usb_disabled())
> 		return -ENODEV;
>
>-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
>-
> 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
> 	return platform_driver_register(&ohci_platform_driver);
> }
>--
>2.35.1


