Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BC4BE072
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiBURer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:34:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiBURek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:34:40 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B321B799
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:34:14 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220221173409epoutp02bd3f98d043aa0721d18497993afc4d3e~V3Y-6uZDe3142831428epoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:34:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220221173409epoutp02bd3f98d043aa0721d18497993afc4d3e~V3Y-6uZDe3142831428epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645464849;
        bh=8QoAWANia+LWatCrvDo7c2KtZTARPPnVpiok40+vh4Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Pil936/uh1MGuQRTIDs31keIymPZaEoGCDjuOqwI2CWBs5WaCMCZkwfNQAqax7LFX
         WPYrEmnF6kfWYhph6Z7biMQpHooonCY8AZZP+sV9SNfS52kpKMWTMqBOh6WJpLAwj2
         T0Zi1uXowwM42kIih1k1cwjPsORjY8pArIaUWDss=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220221173408epcas5p10ae318bb1443a7bdadecd43456ae8f41~V3Y_25q0b0912709127epcas5p10;
        Mon, 21 Feb 2022 17:34:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K2Ttg1wzpz4x9Pr; Mon, 21 Feb
        2022 17:34:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.A0.06423.A0DC3126; Tue, 22 Feb 2022 02:34:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220221173402epcas5p3f85b10debc38c7ec1e1bd607055672d8~V3Y5ZinoD0424704247epcas5p3V;
        Mon, 21 Feb 2022 17:34:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220221173402epsmtrp1e821ef541eff55cdedae510a4853e1b3~V3Y5YuyW-2875828758epsmtrp16;
        Mon, 21 Feb 2022 17:34:02 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-aa-6213cd0aad21
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.DA.29871.A0DC3126; Tue, 22 Feb 2022 02:34:02 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220221173400epsmtip262b43f76e966b435aacb3b28e52979b4~V3Y4HTTGA0830808308epsmtip2R;
        Mon, 21 Feb 2022 17:34:00 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 1/3] clocksource/drivers/exynos_mct: Remove mct interrupt
 index enum
Date:   Mon, 21 Feb 2022 23:15:45 +0530
Message-Id: <20220221174547.26176-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmli7XWeEkg7m7zS0ezNvGZjHvs6zF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZrD1yl91i0dYv7BabN01lduD0mNXQy+Zx59oeNo93586x
        e2xeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjOWbO5iKbjCVdE04zF7A+N9ji5GTg4JAROJX8e+sHYxcnEICexm
        lJiz+BsjhPOJUeLi6jNQmW+MEi9mzGWDaZk0eSdU1V5GiXuP+qCcFiaJSy9WMIFUsQloS9yd
        vgXMFhFwk7jR2MEEUsQscI1R4s/EQ4wgCWGBSInO7jesIDaLgKrEza4vYCt4BWwkzrSsYoRY
        Jy+xesMBZpBmCYFD7BLTJj1jgUi4SHxZu54JwhaWeHV8CzuELSXxsr8NyOYAsrMlenYZQ4Rr
        JJbOOwbVai9x4MocFpASZgFNifW79EHCzAJ8Er2/nzBBdPJKdLQJQVSrSjS/uwrVKS0xsbub
        FcL2kDi5dxqYLSQQK3F49TGmCYwysxCGLmBkXMUomVpQnJueWmxaYJiXWg6PnOT83E2M4OSl
        5bmD8e6DD3qHGJk4GA8xSnAwK4nw3mEXThLiTUmsrEotyo8vKs1JLT7EaAoMpYnMUqLJ+cD0
        mVcSb2hiaWBiZmZmYmlsZqgkzns6fUOikEB6YklqdmpqQWoRTB8TB6dUA5PMvfrXi9cl9U89
        NJeRJf9+nMfCrSK3p6mbnZxxdMOtwx+nTflea/j8q2u0VSNjkvDRc/LxK28yNhbFXTR9/Oo0
        58KqnXpnL35kL47sOCo2d4qDfOaTbzl83wKutU1/+cPX2kgt5BHDpevyT184ST3asuBKxFrW
        vQeYZ820qVw0ZcHlmd8YflxaNO+FYqMyN+8aSa32h6c7pZdVHNvu+/EG07qW55vnR03KKF51
        +arVhbOCbyTf115yYRRQ+f6ZdWPIg6CQ/87371zO7tScUnPiiOG8y4Udd2xlq9Zs2up6ys1m
        VtBbZoGarRqGjbNCn35xS6naEpS2IuWza9yHP0F3GFZMeD1HZcq5RYeWL/G2u6nEUpyRaKjF
        XFScCAB2614i5wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJXpfrrHCSwcY+QYsH87axWcz7LGux
        8e0PJotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYtPULu8XmTVOZHTg9ZjX0snncubaHzePduXPs
        HpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxpLNXSwFV7gqmmY8Zm9gvM/RxcjJISFg
        IjFp8k7GLkYuDiGB3YwSpy+cZYNISEtc3ziBHcIWllj57zk7RFETk8SmA1MZQRJsAtoSd6dv
        YQKxRQQ8JNr+3WMGKWIWuMco8btlGliRsEC4xOqPn8EmsQioStzs+gK2gVfARuJMyypGiA3y
        Eqs3HGCewMizgJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcIhpae5g3L7qg94h
        RiYOxkOMEhzMSiK8d9iFk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQ
        WgSTZeLglGpgMlVI+JonrXPUmnXVeQOZB5tbfs0tTpv/V3RCvgv/x9qK/MNO9e8ltbJf5WYu
        vF0RGXU/4mLJ0YmJl46FvEx8ciRpftTv9L13czi6F2f81Hzbvs14s0hizJGT55qOZ+2WrTnR
        a/T4VDc71+x2ox0N/8uN55zufypU9uYe47TVrzeWOXHMitqiaMzE9qj01z6VXW82Fp95kl34
        qGCLwinNJ5eeGTTfV1ueV3jDV9cruFX1oZ3IK6eYiQkRh8R2+OqF/wrXXyl3eN7GIw+m/Az3
        vbuXQWE640mLn0KnONbtNDz7o2GmuMWJuZrPSy3mdpqLcnLpNW1szehZ5fORQWTSD+Xv/gsf
        HIlXZZ6Tr8D2W4mlOCPRUIu5qDgRAEiWLAagAgAA
X-CMS-MailID: 20220221173402epcas5p3f85b10debc38c7ec1e1bd607055672d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220221173402epcas5p3f85b10debc38c7ec1e1bd607055672d8
References: <CGME20220221173402epcas5p3f85b10debc38c7ec1e1bd607055672d8@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCT driver define an enum which list global and local timer's
irq index. Most of them are not used but MCT_G0_IRQ and
MCT_L0_IRQ and these two are at a fixed offset/index.
Get rid of this enum and use a #define for the used irq index.

No functional changes expected.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 6db3d5511b0f..b3f3d27a837b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -60,27 +60,17 @@
 #define MCT_CLKEVENTS_RATING		350
 #endif
 
+/* There are four Global timers starting with 0 offset */
+#define MCT_G0_IRQ	0
+/* Local timers count starts after global timer count */
+#define MCT_L0_IRQ	4
+#define MCT_NR_IRQS	12
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
-- 
2.25.1

