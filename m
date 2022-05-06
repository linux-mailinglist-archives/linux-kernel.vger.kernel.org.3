Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3146A51D17C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357017AbiEFGhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352104AbiEFGh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A66765D31
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:44 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220506063342epoutp0384c22ed333d5e19a38d8a7b840276ba1~scHeb_yF80874608746epoutp03D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220506063342epoutp0384c22ed333d5e19a38d8a7b840276ba1~scHeb_yF80874608746epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818822;
        bh=boZqsu5x83x4yZ3yCA0TfzOorlYh1KIsxJqlRVWoJB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=le7o0FoHyUHtbdvAS7zuFeeqsNyeTa9NjE066mGsvEFFNu/WPAXebr3hLE+vjPskr
         wpphZBaVNr2ddlTkDo0ZSpQteWCYwRe8pvJ/hzlmvb9lZs8ukd+QBVr0L1gAhzv4gL
         GWuGMYWxjcXVqJ43gLfEOx67qt4YmlN20/zX6URY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220506063341epcas2p350432dd532c831e3b10dcc8cbaeb61ba~scHd0fdPb0340303403epcas2p3A;
        Fri,  6 May 2022 06:33:41 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KvgkX1Zgbz4x9Q0; Fri,  6 May
        2022 06:33:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.23.09694.441C4726; Fri,  6 May 2022 15:33:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220506063339epcas2p1b94e823ab8b7974ac88fec9ea9c17109~scHbtJqjd2814728147epcas2p1B;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506063339epsmtrp2d04be5075eb7648780f76c29e97a3dec~scHbrbqOL0488604886epsmtrp2G;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-c3-6274c144b08e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.ED.08924.341C4726; Fri,  6 May 2022 15:33:39 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063339epsmtip289f88b7ce43971313c3e51b3a8fdee9a~scHbalUYJ0767807678epsmtip2K;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
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
Subject: [PATCH v5 4/6] usb: host: add some to xhci overrides for
 xhci-exynos
Date:   Fri,  6 May 2022 15:31:17 +0900
Message-Id: <1651818679-10594-5-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe1BUZRTvu3e5u5hL112ozx1nw+tYuQns0rJcE4zJTa+QRjmV4zhDV7g8
        Zp/u3RVyKlACBCdCRgUWNV4igxiyrsRrY3htQIYmRqGAEExkBBlMiBDW7l6s/37nzO8x55zv
        E6CiekwiSNKbGZOe1hLYKl59x6bQAHWb+aD851ZvcvR8PUYu5zv5pDNzgk8OlZxByN6LpQiZ
        Xl6LkWcHg8nhsQUe6Zi6xidt4wNeZH/TWYwsvPE1QpZVZqDkp11ZPDLddsqLnLsyDsic4Z8A
        md/mR7bejowQU0uL+YCa/yufRxWnfc+jGq3DfKq85T5C2aqzMWpooAWjWs/V8KmrFalUrr0a
        ULX2H3jUnE0avXq/JiyRoeMYkz+jjzXEJekTwomovTHbY0JUckWAYgsZSvjraR0TTqjfjA7Y
        kaR1TUj4H6a1FlcrmmZZImhbmMlgMTP+iQbWHE4wxjitMdQYyNI61qJPCNQz5lcVcnlwiIv4
        gSbxi2aZMcsnpaxtDEkDM0/nAG8BxJVwbKQcywGrBCK8AcDqod+9uGIWwAt3vlwp5gA892MX
        +kTSay/G3FiENwHY4dzNkRYAvN5010USCDBcBh+WAnffFy9AYU/NZ54MFO9BYX9LGd+tFuNv
        wUsPJj2Yh2+E90uXEDcW4m/A+s5HfC5NCgf7sj3J3vgOeOu03eMK8ZsC2PhtBXCnQVwNF217
        OL4Y/vaNfUUrgXMzDozDLGyazUA4bRqAR0e7V8Z5BVp/yfL4oPgmWNsUxFlugJ13eG4GivvA
        4x3LfK4thMczRZxwAyzoz/Pi8FrYNtW3YkjB+t5lwO2kCEDr9QWvPCC1/h9QAkA1eJYxsroE
        hg02Kv87WKxBZwOeByyjGkDx9IPAdoAIQDuAApTwFYqt5oMiYRz94RHGZIgxWbQM2w5CXLs7
        iUr8Yg2uH6A3xyiUW+RKlUoRGhwiDyWeE0bGXaFFeAJtZjQMY2RMT3SIwFuShnQHPdWoG3j0
        92FDwT3J/pPx7DHhvs+j/cB0TO5GYdihypmubsf5PodWXdl5+T1r6oTCvnn65ZCly2viLxWq
        H45v1qjI0RHbTLpl36/0UOx3b482l57e3hPo95XvR/mDKtO7vMyMT0aCTqyvem3bgYj13SMB
        jzsmkasZu05dKBHf+HP2yJ75uttRW5MtJ2RsUUOrsqtI+r7zgCy+IyVC98LR3XVR4sc7F6zr
        kiN3Pp96Zt3dY11VKQER0ol3mgueeX3toT61T16PpqT8Ws2LBX+MF/fL7u0FrdPJ0tzgwoqX
        pv5pGx+Y77uV7UxGGz+WL9bWaCaVq8VVdWtuXiS27nJEoionrid4bCKtkKEmlv4XgbR3HUkE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvK7zwZIkg623+S0ezNvGZvF30jF2
        i2NtT9gt7iyYxmRxavlCJovmxevZLObcNLK4+/AHi8Xe11vZLTY9vsZqcXnXHDaLGef3MVks
        WtbKbNFytJ3FonnTFFaLzxseM1p03b3BaDHpoKjF/iteDsIev39NYvT49nUSi8fshossHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCeKC6blNSczLLU
        In27BK6M+bu1Ctr5KhYdfMjUwPiOu4uRk0NCwETi1JbZbF2MXBxCAjsYJSZdOs0IkZCUWDr3
        BjuELSxxv+UIK0TRN0aJK58vAjkcHGwCWhLfF4LViwjMZZbYurUIpIZZ4CyzxJ+nq9lAEsIC
        vhIXXy8CG8QioCrxcuFvJhCbV8BVYtuRn1AL5CRunutkBrE5BdwkLk3dAjZUCKhm4Z/vzBMY
        +RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOFS2tHYx7Vn3QO8TIxMF4iFGC
        g1lJhFd4VkmSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxS
        DUw12lfPbTCYJbpdxKRc1Oe1BQPvk9Mva8uPWQb9vtT04uXn71zCE6ZPWOkxSVbwXci0Rgaj
        Y1MuMFhqrTZ17NMvrpKeVa7e9G+F784XNzdkLZH77Lih+c8svuZpoXNMpucfWexWK1Z6iHdv
        0reiumnC+asu7SkVMdx7OGza8auP170sv1pgJRNmWrHllfG04v8fgqJ89Nbcv5v59M/h+0Fv
        zddvfSj6L+QkY2/8TMMNS9u95+sLXI5TPFwZ7VD97fGm6cmTMjRXJ65uWzu5smzSzXk2bcvu
        uyRk8Gv5WWxKPDkht7OvOj5VfecF/pW9boKaaTcPzgsXvVGamrV89URRBpZWE6dQlv9C2ksa
        2D4qsRRnJBpqMRcVJwIABvTKHAQDAAA=
X-CMS-MailID: 20220506063339epcas2p1b94e823ab8b7974ac88fec9ea9c17109
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063339epcas2p1b94e823ab8b7974ac88fec9ea9c17109
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063339epcas2p1b94e823ab8b7974ac88fec9ea9c17109@epcas2p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 drivers/usb/host/xhci.h | 3 +++
 2 files changed, 9 insertions(+)

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
index 5d356f40c2b9..ab74b24a13b3 100644
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
-- 
2.31.1

