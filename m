Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54E4BDDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiBURel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:34:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiBURek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:34:40 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88F1B796
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:34:15 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220221173414epoutp0275184a81704c770b0093c1503b4fed34~V3ZEej72u3193331933epoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220221173414epoutp0275184a81704c770b0093c1503b4fed34~V3ZEej72u3193331933epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645464854;
        bh=RvDLmLSxETfO6A5wae6RmRdbn5NU2PIo7D5FXAXzYck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ory4sB6Bd/USFfMxOgPLwaZ5wazcy150+NhpiA8CwtENEO1jX1iq9ZJRQK0ke6n07
         V56CdmNXsuw8/5/cIAYYXQFtTEXY7yJ5rlGHUlHusOlZ6l025nL0cWbtVzbwK579li
         CSjzyEgteycp4WlNjlY1xpJa4MolRPoDwcN31LOM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220221173413epcas5p4af911cfa40837b326059a3f4d8cde9ef~V3ZDaibs22548525485epcas5p4A;
        Mon, 21 Feb 2022 17:34:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K2Ttl62m0z4x9Pp; Mon, 21 Feb
        2022 17:34:07 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.C5.05590.F0DC3126; Tue, 22 Feb 2022 02:34:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220221173407epcas5p117620b55b5f5a94d6a525342374efa51~V3Y_LKgYD1540215402epcas5p1v;
        Mon, 21 Feb 2022 17:34:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220221173407epsmtrp1b6970963b6f323bc47e6fc4dae9a3cb8~V3Y_KMsuh2875828758epsmtrp18;
        Mon, 21 Feb 2022 17:34:07 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-20-6213cd0f83fa
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.DA.29871.F0DC3126; Tue, 22 Feb 2022 02:34:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220221173406epsmtip25119c73c59b09bc7191cb6505e9d3dcf~V3Y84V9yL0069900699epsmtip2P;
        Mon, 21 Feb 2022 17:34:05 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, pankaj.dubey@samsung.com,
        m.szyprowski@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 3/3] clocksource/drivers/exynos_mct: increase the size of
 name array
Date:   Mon, 21 Feb 2022 23:15:47 +0530
Message-Id: <20220221174547.26176-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221174547.26176-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmpi7/WeEkg00fDSwezNvGZjHvs6zF
        xrc/mCw2Pb7GanF51xw2ixnn9zFZrD1yl91i0dYv7BabN01lduD0mNXQy+Zx59oeNo93586x
        e2xeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjP2z7zMXrCEo+LE5nWMDYwv2boYOTkkBEwkbr2YyNzFyMUhJLCb
        UWL+zn1QzidGifW/vzJCON8YJZ7N/s8I09K1qwuqai+jRNex3VBVLUwSFx/8ZQWpYhPQlrg7
        fQsTiC0i4CZxo7GDCaSIWeAao8SfiYfARgkLREpcWPAbzGYRUJXYMfki0FgODl4BG4kLOwoh
        tslLrN5wgBnE5hSwlTgxoR9smYTALXaJg6/us0MUuUj8+HQO6jxhiVfHt0DFpSRe9rexg8yU
        EMiW6NllDBGukVg67xgLhG0vceDKHBaQEmYBTYn1u/RBwswCfBK9v58wQXTySnS0CUFUq0o0
        v7sK1SktMbG7mxXC9pA4vesWNEwmMErM+fiHdQKj7CyEqQsYGVcxSqYWFOempxabFhjnpZbD
        Iyo5P3cTIzipaXnvYHz04IPeIUYmDsZDjBIczEoivHfYhZOEeFMSK6tSi/Lji0pzUosPMZoC
        Q2wis5Rocj4wreaVxBuaWBqYmJmZmVgamxkqifOeSt+QKCSQnliSmp2aWpBaBNPHxMEp1cB0
        ZueKW5Exyss+HA+f9o17VbGO0t+ALQG7ZmiuE37f5GgQlpv34+DmN99uvi47sGhxpd3hIGa1
        lpKFtWuLXir8mzbXP6aV4f8Ubu679iLzXbTrJVyeC04Ry5fr3eqa4s7p9Fjwh0KIr7bmpH53
        /Sx7mSPKtbYnhIO3nOFzldDzexV2xjqTfe0qs9j7JnLGU7ydla/pXu1X3qB+88X09JNdy4T5
        eEsnNcbf/3yl+ul6k5W71S4Ivk+QVGDcJh2tpVZdWGd85YjhtKtywpeLS/tzPngyJm28kTrL
        5cyPPbtTo+yMqryrbNNPH9PUrYh/k2J5Z+d9j/8GFc/WbdE4cfOayVVmfcOUFRdyojhWr1Ni
        Kc5INNRiLipOBABhrXk98wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvC7/WeEkg88t4hYP5m1js5j3WdZi
        49sfTBabHl9jtbi8aw6bxYzz+5gs1h65y26xaOsXdovNm6YyO3B6zGroZfO4c20Pm8e7c+fY
        PTYvqffo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujP0zL7MXLOGoOLF5HWMD40u2LkZODgkB
        E4muXV3MXYxcHEICuxkl1p+9zQSRkJa4vnECO4QtLLHy33N2iKImJolj654wgyTYBLQl7k7f
        AtYgIuAh0fbvHtgkZoF7jBK/W6YxgiSEBcIlJuy9DzaJRUBVYsfki0BFHBy8AjYSF3YUQiyQ
        l1i94QDYTE4BW4kTE/oZQUqEgEpOt+lMYORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9d
        Lzk/dxMjOBy1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeO+zCSUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwTd/l/9Yt994yZc337t5eH4X9L65cuF2rkFnV
        2/iNvVHaW9NagZ5F+lF77z117pK8fHGj45FZLZt2Hjhh1Pbdlu3Qgotl+kXvmX7K/81o4k+2
        vpv2ykRhZoGpX9isWT6vyrd9XXBYai67bl3Bju7JLX/aN+UePPLOcp3JFcNFPKc47n5hrJxo
        +5vFZt3H9nV7JTc8Wmop2igmsmNHuIzgqa4WvhrDh1w7mL4G32lawe7bL+1Wf/Cd1E6W0wVl
        LxSW7rtWy/btn+SVUOb7recn96lk7q1WVFG4f8ZA7dfS9V82l0pWX6hQ2nOYceayzxvE8qb1
        lBzTeNDx66ek8M6uRYrbtrhLBN7+puYa4nO9UYmlOCPRUIu5qDgRAK+I6m62AgAA
X-CMS-MailID: 20220221173407epcas5p117620b55b5f5a94d6a525342374efa51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220221173407epcas5p117620b55b5f5a94d6a525342374efa51
References: <20220221174547.26176-1-alim.akhtar@samsung.com>
        <CGME20220221173407epcas5p117620b55b5f5a94d6a525342374efa51@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable _name_ hold mct_tick number per cpu and it is currently
limited to 10. Which restrict the scalability of the MCT driver for
the SoC which has more local timers interrupts (>= 12).
Increase the length of it to make mct_tick printed correctly for
each local timer interrupts per CPU.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 0c7931f7f99a..b6de352b703d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -80,7 +80,11 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	/**
+	 *  The length of the name must be adjusted if number of
+	 *  local timer interrupts grow over two digits
+	 */
+	char name[11];
 };
 
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
-- 
2.25.1

