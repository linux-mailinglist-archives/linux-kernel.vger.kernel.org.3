Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E751D176
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357444AbiEFGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351678AbiEFGh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DB65D1C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:45 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220506063343epoutp0309d3daed1742bfe2434a591d852b91da~scHf2a-_k0578505785epoutp03g
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220506063343epoutp0309d3daed1742bfe2434a591d852b91da~scHf2a-_k0578505785epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818823;
        bh=hb34QOx+LRjNhP9A+ykl7khL8yUaFNzKHpIrai9d5jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiXjyc+754tPUWn+IBUApeuDc1gjSuCiX/5h0DPqU1vE2BOLkp+qFFdp7NMSSnveG
         VXVoRhvAIXzMUwStVPX20KfQULtRXvALXSsnDANdN3I9LMd46uC5ssexQasrRsKduo
         ru2DartwulNp06iUV/Oe7Lo5+fGcALrkCWEKExBM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220506063343epcas2p2d7fcb3dfed8e6cb9d1fe24ec053f83de~scHfOVRTD0727807278epcas2p2a;
        Fri,  6 May 2022 06:33:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KvgkX2kLqz4x9Q8; Fri,  6 May
        2022 06:33:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.41.10069.341C4726; Fri,  6 May 2022 15:33:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220506063338epcas2p37d0e07d937624e56cb2114d9f75fdd42~scHbIUDWW3067030670epcas2p3M;
        Fri,  6 May 2022 06:33:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506063338epsmtrp10560356314e0a7dab5e7ce4a4e6df0b9~scHbHaR_83174031740epsmtrp1Z;
        Fri,  6 May 2022 06:33:38 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-5f-6274c1434af8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.DD.08924.241C4726; Fri,  6 May 2022 15:33:38 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063338epsmtip293b3f0f1c983e4ae0d9d2546e576bbc4~scHa6qxU50766207662epsmtip2M;
        Fri,  6 May 2022 06:33:38 +0000 (GMT)
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
Subject: [PATCH v5 3/6] usb: host: xhci-plat: support override of hc driver
Date:   Fri,  6 May 2022 15:31:16 +0900
Message-Id: <1651818679-10594-4-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0wUVxTGc2eGmeXVTBeoF5ogGdOkEh67lGUvDdg2iJ1CsaS1xpC0dIDJ
        Qtmd3ewsQk1aMSCPFVu6RZGnu2hteLTQFakgVkGRh8hDHoEKAgHaUl9EIlLQtLC7tv/97jnn
        +869594rwaWtpI8kTTDweoFTM6QL0XJtpzIwqsOQJGu6/jKarW4h0XPTDQrdyFug0JT5JIb6
        frBgKOdMI4kqJ0PQ9NwagS7fu0Ah6/y4ExppqyTRqcFfMVRz7iiOcrvyCZRjLXFCK03zABmn
        JwAydXihK6Mxb3uwG+smwK4+MRFsRfYwwbaWT1PsmfYljLXWFZLs1Hg7yV6paqDY82cPs183
        1wG2sXmMYFesvvFuCekRqTyXwuv9eCFZm5ImqCKZ2I8SoxIVYTJ5oDwcKRk/gdPwkczu9+MD
        96SpN0/I+B3k1BmboXhOFJngXRF6bYaB90vVioZIhtelqHVKXZDIacQMQRUk8IY35TJZiGKz
        8LP01LFbPZTujmtW86MWKhtYXIzAWQLpUGgd63IyAheJlL4I4GR+IbAvHgNoutXgyKwAePVE
        DvlCsrE8SNoTbQCW3Lc6JGsAzi72YkYgkZC0P3xqscU96VIc9jYctylwuheHI+011JaVBx0L
        x0YqbLYE/RpsyVuxsTsdDRtnShztfOHkQCG+xc70Hnj7RLPNFdJDElj1JNdRtBtWmqcJO3vA
        v7qbKTv7wKVv8hwswrbHRzG7OBvAI7M9uD3xBiz/PR9sbRund8LGtuAthPQOeP03myVOvwQL
        rj2n7GF3WJAntQt3wNKRYic7e8OOewMOQxaOt+Vi9qGUAdj0ZwUoBr7l/zcwA1AHXuF1okbF
        iyE6+X93lqzVWIHtDftHXwTfPVgO6gSYBHQCKMEZT3ePckOS1D2F++IQr9cm6jPUvNgJFJvD
        +xb38UrWbn4CwZAoDw2XhYaFyZUhCpmS2eYek9LESWkVZ+DTeV7H61/oMImzTzbWelZdVNFz
        /A8z8V71pZmJp+uXaw2l7VWfTMd8eOdhQwDZn5MXTn4/HKvWmLzedTN/eUzVGPXwLu36KOLZ
        vhjtKqxVRxdMHbg5VhHXPXrwrqVkv1/Lz64TmsF9CxPKSte/eW9qNG75QGjNxu16+pdjBSM9
        qpnuS7K57fV7y6jUhvWB8E8ZRZdujkpQtH4s1gkJCR/k+grFn/ct3DwSOLirD01mzddvnA44
        96zajVzfLp398XDYEBQoy6ltaatqkPmV5/kA/vWsPuz+q95Dw0WaAvNijiXxHc/0tx4YfyLS
        M5sOxRmzFsjWtSXd1TJmP150AdbmRi26JfUzmUH9wf+sMYSYysn9cb3I/Qs8yXxNTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK7TwZIkg75L2hYP5m1js/g76Ri7
        xbG2J+wWdxZMY7I4tXwhk0Xz4vVsFnNuGlncffiDxWLv663sFpseX2O1uLxrDpvFjPP7mCwW
        LWtltmg52s5i0bxpCqvF5w2PGS267t5gtJh0UNRi/xUvB2GP378mMXp8+zqJxWN2w0UWj52z
        7rJ7LN7zkslj06pONo871/aweeyfu4bdY/OSeo++LasYPdZvucri8XmTXABPFJdNSmpOZllq
        kb5dAlfG1bMn2Atuc1dseb+NvYFxIVcXIyeHhICJxO8P59m6GLk4hAR2MErcvHOXESIhKbF0
        7g12CFtY4n7LEVaIom+MEhcWPWLpYuTgYBPQkvi+EKxeRGAus8TWrUUgNcwCZ5kl/jxdzQaS
        EBbwlrh6eTaYzSKgKrGt7TOYzSvgKrH+/hQ2iAVyEjfPdTKD2JwCbhKXpm4BGyoEVLPwz3fm
        CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBEeLltYOxj2rPugdYmTiYDzE
        KMHBrCTCKzyrJEmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYO
        TqkGpg0i9ozyqg9Xf5h61yjX7sLr1kl1EUaP0g6q/sgokzlqMLd0u5mhhlcYc/GUsJvOJ6xn
        mdvN1T+e1mA/KYF/bd2JCut5kuZd8kEF6lF8uTPdORni1JsUPf+dOylUdmTheasfH277PIpR
        6L2WF5JpyRolemSNWXRdf2eLhOKVY+kn8pd8eK5iynVsTcoar5OOsSfYHbeeelR35eSrvewF
        /24Wxn9R7/i/0C95GWPPNPbirpbHs8M/L/sxz3p3WXZLr0DCWb1dS8+KWvxc6CTfauBwUe39
        tXOqE89+3mm9+Xhewm7fJc3fVmx1PvVJ5/q2Qu8dTsb7eGrzl57eGXrT/vmL3YIBzw84ezYo
        xswwVmIpzkg01GIuKk4EAHNcid0FAwAA
X-CMS-MailID: 20220506063338epcas2p37d0e07d937624e56cb2114d9f75fdd42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063338epcas2p37d0e07d937624e56cb2114d9f75fdd42
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063338epcas2p37d0e07d937624e56cb2114d9f75fdd42@epcas2p3.samsung.com>
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

It helps xhci-plat driver increase usability. Vendors could use functions
in xhci-plat mostly and use some overrides to do what they wants without
modifying xhci-plat driver.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 drivers/usb/host/xhci-plat.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a5881ff945a6..a340e14ce9a6 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,6 +173,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_vendor_overrides)
+{
+	xhci_init_driver(&xhci_plat_hc_driver, xhci_vendor_overrides);
+}
+EXPORT_SYMBOL_GPL(xhci_plat_override_driver);
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

