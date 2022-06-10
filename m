Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFD546483
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiFJKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347242AbiFJKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26BE2D56F7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:44:06 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610104405epoutp014d08825ec9ea59b90e5528443b081d27~3PHFON9MN1533515335epoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:44:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610104405epoutp014d08825ec9ea59b90e5528443b081d27~3PHFON9MN1533515335epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857845;
        bh=mzLAmWqCxZhs1S6BV/xNsG1aAfxb0YUHxD4qs10oM1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5VJZobK/7rITCARZg2OgpOfChue4sfj+wcQ1NqyhKeXFJbevhUXBE9iAjXrDsbeq
         z+lKA5x8nEBy/2N959y+Skobg4wSa4AInJ/D6tfytRYpODGaz2xAmbRCoxUmVJsPrb
         6IzExwZRGMskDLnOAMT1xjxi3e3+N+RH/R0aCLvY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220610104404epcas5p1e522b006fdee5c85f380dd3fc3086a90~3PHEtc-8Z0424004240epcas5p1N;
        Fri, 10 Jun 2022 10:44:04 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LKHdD44fgz4x9Pv; Fri, 10 Jun
        2022 10:44:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.7E.10063.D6023A26; Fri, 10 Jun 2022 19:43:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220610104356epcas5p4343acd45f6677723a1b44534fcc4e289~3PG9AsCo02785727857epcas5p4C;
        Fri, 10 Jun 2022 10:43:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104356epsmtrp13d7de3a8e9de5c8d82d775322e5c0224~3PG865RcI1337313373epsmtrp1T;
        Fri, 10 Jun 2022 10:43:56 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-01-62a3206d8874
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.4D.08924.C6023A26; Fri, 10 Jun 2022 19:43:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104354epsmtip1036d2cbc6dcefc32a22d4b7441cbb51f~3PG7CBmks1361013610epsmtip1I;
        Fri, 10 Jun 2022 10:43:54 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 5/6] ufs: host: ufs-exynos: add mphy apb clock mask
Date:   Fri, 10 Jun 2022 16:11:18 +0530
Message-Id: <20220610104119.66401-6-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmpm6uwuIkg/sP+CwezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMa
        PvYyFVzlqGhdOpu1gXEFexcjJ4eEgInEtWWTGEFsIYHdjBIfT4t3MXIB2Z8YJd61b2aCcD4z
        ShztWcTcxcgB1rH/QyhEfBejRMe01SwQ3S1MEp86ckFsNgFtibvTt4A1iwg0M0oc7NgF5jAL
        9DFJLLl9mxVkkrCAm8SxddYgDSwCqhJzXy5lBbF5BWwkend/YIQ4T15i9YYDzCA2p4CtxLP1
        l1lB5kgITOSQePKnhwWiyEXiybfbrBC2sMSr41ugfpOSeNnfxg5xtYfEoj9SEOEMibfL10PN
        t5c4cGUOC0gJs4CmxPpd+iBhZgE+id7fT5ggOnklOtqEIKpVJZrfXYVaKi0xsbsbaqmHxO9H
        N6HBMIFRYtJKqQmMsrMQhi5gZFzFKJlaUJybnlpsWmCYl1oOj6Xk/NxNjOCUqOW5g/Hugw96
        hxiZOBgPMUpwMCuJ8AbcXpQkxJuSWFmVWpQfX1Sak1p8iNEUGGITmaVEk/OBSTmvJN7QxNLA
        xMzMzMTS2MxQSZxX4H9jkpBAemJJanZqakFqEUwfEwenVAPT+g1Jxzet5OH/0xsQxn45/LXX
        s/NNH+cKdH02sGU3n8e5PnM3h5GV2cWn+X/lL6fUi3FUbgixW93rx+NzqUDu1pWyBV2xE4wi
        GB//1/ozwW8WfwjPV0fPKXsNV9/716V9ruLNlHO8Rts08xY39z4RD9+85/vcKS/E526ecna5
        Z9PpsG/5tx6d0fr3rbPzypLWu48+L2q1aLcwnpJ/Zs7hrWk91eoCaoJRp9exM4osMjO7qRi1
        /t2//Rnm3snZ9+b/evrI9sLnGRIXXfPmJK7eeGJG2YvXLsFl1tv+cxhfOLlhofrLBc8Ns46c
        ri/0btGqYdXznP5V+YeSuor2m9le0QrOKT56WV/9d88TWrKpQYmlOCPRUIu5qDgRADoZdMMS
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG6OwuIkg+sfxS0ezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFFc
        NimpOZllqUX6dglcGQ0fe5kKrnJUtC6dzdrAuIK9i5GDQ0LARGL/h9AuRi4OIYEdjBLznp1g
        62LkBIpLS1zfOIEdwhaWWPnvOTtEUROTxIULV5hAEmwC2hJ3p28Bs0UE2hkl7m9nAyliFpjF
        JPF+0hNGkA3CAm4Sx9ZZg9SwCKhKzH25lBXE5hWwkejd/YERYoG8xOoNB5hBbE4BW4ln6y+D
        1QgB1SzuOMc8gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4JDW0trBuGfV
        B71DjEwcjIcYJTiYlUR4A24vShLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2
        ampBahFMlomDU6qBKU2kz+G2em/5y8NbdttIfn1mEP9mlkGqcq3+owmrbnet++Tit6/qXfRv
        pdzGmeuuLn928HzYAcFtHEwJOi6in/mypweF2e/++UbwueiMm1WMDzyuP+JeXXdb4+p0hcs3
        M6e9f2EScrlC5qsl/987pZ6LPMuyzokGXmFNeWNS8Dcv1C3rDJOB45WAt/Hr5V9peZyNDX03
        LU7B0mqhA2fcE/3vXuIdj6PdK5Z9/9CZe2p/JzPLilptY6Vo2bO1jC/tbGa+45XqX1s413th
        UHCS9cP9YdtLZj5dX6f06M6ki6tjQ6fotno+n2xx0fO1ZvGDD8etPsz/xsU8+aQ798WYnzdX
        355/VV11qmePfHvaBiWW4oxEQy3mouJEANvUOpvYAgAA
X-CMS-MailID: 20220610104356epcas5p4343acd45f6677723a1b44534fcc4e289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104356epcas5p4343acd45f6677723a1b44534fcc4e289
References: <20220610104119.66401-1-alim.akhtar@samsung.com>
        <CGME20220610104356epcas5p4343acd45f6677723a1b44534fcc4e289@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit[3] of HCI_CLKSTOP_CTRL register is for enabling/disabling MPHY APB
clock. Lets add it to CLK_STOP_MASK, so that the same can be controlled
during clock masking/unmasking.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index a81d8cbd542f..cc128aff8871 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -52,11 +52,12 @@
 #define HCI_ERR_EN_DME_LAYER	0x88
 #define HCI_CLKSTOP_CTRL	0xB0
 #define REFCLKOUT_STOP		BIT(4)
+#define MPHY_APBCLK_STOP	BIT(3)
 #define REFCLK_STOP		BIT(2)
 #define UNIPRO_MCLK_STOP	BIT(1)
 #define UNIPRO_PCLK_STOP	BIT(0)
 #define CLK_STOP_MASK		(REFCLKOUT_STOP | REFCLK_STOP |\
-				 UNIPRO_MCLK_STOP |\
+				 UNIPRO_MCLK_STOP | MPHY_APBCLK_STOP|\
 				 UNIPRO_PCLK_STOP)
 #define HCI_MISC		0xB4
 #define REFCLK_CTRL_EN		BIT(7)
-- 
2.25.1

