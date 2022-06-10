Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF2546477
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348512AbiFJKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbiFJKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:47:18 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9482149ED
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:43:47 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220610104343epoutp011c75a1713e65e164928feaee9b9d4525~3PGxI2AMY1568715687epoutp01p
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:43:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220610104343epoutp011c75a1713e65e164928feaee9b9d4525~3PGxI2AMY1568715687epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654857823;
        bh=hZydefGMCXXwJQLGPq6/KgCxy9AqlRGtqjW7pmdoKH4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fTceMiu0FZPTKYSwS0vVOCgH3su889maoKY9ZfomZBveAUeD11OWMbw14N38J9Qps
         POB7V+HmQ1YXEWv/5fjiiXeMVgNrH+6iFvN0i+3BkY9O+ag/d5SN5ltRcDHTLNAq10
         eCXXx/Q6wtfTkIfnAf/Fz4fAjkTQ5pLVcmBCwr4g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220610104343epcas5p2705f3fe5701edcbc6cc4f15d8850efc5~3PGwoxVhb1105611056epcas5p2E;
        Fri, 10 Jun 2022 10:43:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LKHcr42GHz4x9Pp; Fri, 10 Jun
        2022 10:43:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.6A.09762.C5023A26; Fri, 10 Jun 2022 19:43:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863~3PGtjz07z0424004240epcas5p1q;
        Fri, 10 Jun 2022 10:43:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610104339epsmtrp114e7b0ec0528601f0ca731b699451577~3PGtizm7u1337313373epsmtrp1J;
        Fri, 10 Jun 2022 10:43:39 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-b2-62a3205c993d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.B0.11276.B5023A26; Fri, 10 Jun 2022 19:43:39 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220610104337epsmtip1b8444ff1d5df918c359b3d34762459f1~3PGrrJWs91361013610epsmtip1F;
        Fri, 10 Jun 2022 10:43:37 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v4 0/6] Add support for UFS controller found in FSD SoC
Date:   Fri, 10 Jun 2022 16:11:13 +0530
Message-Id: <20220610104119.66401-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmum6MwuIkg/U/pSwezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjN+
        zt3NXDCXt2LCnX6WBsbJXF2MnBwSAiYSndtXMYPYQgK7GSXmbsvqYuQCsj8B2TdPskM43xgl
        Xi24xwjTse3QVxaIxF5GiQvvd0BVtTBJPJ3wmAWkik1AW+Lu9C1MIAkRgWZGiYMdu8AcZoE+
        Joklt2+zglQJC7hL7Pr8D6yDRUBV4lRbK9AODg5eARuJQ8udINbJS6zecIAZpFdC4Ce7xK6W
        Z8wQCReJiTP/QdnCEq+Ob2GHsKUkXva3sYPMkRDwkFj0RwoinCHxdvl6qBfsJQ5cmcMCUsIs
        oCmxfpc+SJhZgE+i9/cTJohOXomONiGIalWJ5ndXWSBsaYmJ3d2sELaHxM+vyxkhQRcr0fFi
        AdsERplZCEMXMDKuYpRMLSjOTU8tNi0wzksth8dNcn7uJkZw+tPy3sH46MEHvUOMTByMhxgl
        OJiVRHgDbi9KEuJNSaysSi3Kjy8qzUktPsRoCgykicxSosn5wAScVxJvaGJpYGJmZmZiaWxm
        qCTOK/C/MUlIID2xJDU7NbUgtQimj4mDU6qBiXe6gcvfzw+T11yrO3lmq3vSZFWTDbdt3BUj
        Ty8w7b/RbitpUX5J5NoVZoN/kUfCdPNEf2XP2lY+23nizisRbg9izXQFvx/uj3f2K/uidPzy
        8Rmb8+f/25m4+tfqynsGRxVMp8p/uMmV0WK9q3+rtqWwbfDzpJQJvTkZ71IOCHo9a+VzbNws
        H5f6cE1r8/8M318CCiZFqqocOhk3L36+p5u9cM2PzWWth03OPLTYqqZ165G2QOzrpF0nT7zY
        sumXekr+lHm3ZvQe4nq+wSSY873isbdxs2JkUk1ZPUUZAsJOaX4p8r564u+fsntrphgWXWDV
        2+BiuvzS2Y0fez7wi1icecG2aN+Fzyc7b7vzqSixFGckGmoxFxUnAgDkF8zJCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnG60wuIkg33zzS0ezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFFc
        NimpOZllqUX6dglcGT/n7mYumMtbMeFOP0sD42SuLkZODgkBE4lth76ydDFycQgJ7GaUmNd1
        lB0iIS1xfeMEKFtYYuW/52C2kEATk8SHg4EgNpuAtsTd6VuYQGwRgXZGifvb2UAGMQvMYpJ4
        P+kJI0hCWMBdYtfnfywgNouAqsSptlagOAcHr4CNxKHlThDz5SVWbzjAPIGRZwEjwypGydSC
        4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAQ1dLcwbh91Qe9Q4xMHIyHGCU4mJVEeANuL0oS
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgenwqd6DsvfS
        39c2qZa2Lbw6s99ultGPQubldz1qStVOfDgQ5Xy/dPYSuXcxfspCKlUvVjZn7KzSODDD+GGz
        Kv+cB3MybC4VSG78VfFwi9DUkpylkxJ2V825tEuGZ0qSgOftk8kW57cdlt/YspL501fW7VLR
        urMYXG8yKPEcCQtx4vy4NOx2plaO866152UtzXYITwszVfXUe5YYM1Otbwf3hiPHtWx+8xzU
        l9N9sD4y3Xz3hOpAmeeuU9kjN8+9Wl6qFhD89LPnjZn3KxyYz3KX7OuzUpBuq7gbdYevZg3j
        qgNWQuI/p6w5XfTJOio1bwPX4YVnm0Iz5gcVrrzcfvuoYqjinpv9Rer+mb/vFiuxFGckGmox
        FxUnAgAU8W1DwAIAAA==
X-CMS-MailID: 20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863
References: <CGME20220610104340epcas5p1d6cee31aba4dc2952ef09003c9e67863@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds support for UFS controller found in FSD SoC.
The HCI is almost same as found on other Exynos SoCs with minor
differences. This also adds the required UFS-PHY driver changes.

Patch 2/6: common change to handle different CDR offsets

*Changes since v3:
- Addressed review comments on patch 6/6 from Chanho

*Changes since v2:
- Addressed review comments from Chanho
- collected reviewed-by, tested-by tags
- rebased on next-20220609

*Changes since v1:
- Addressed review comments from Bart, Krzysztof, Chanho
- collected Ack-by tags
- rebased on next-20220602


Alim Akhtar (6):
  dt-bindings: phy: Add FSD UFS PHY bindings
  phy: samsung-ufs: move cdr offset to drvdata
  phy: samsung-ufs: add support for FSD ufs phy driver
  dt-bindings: ufs: exynos-ufs: add fsd compatible
  ufs: host: ufs-exynos: add mphy apb clock mask
  ufs: host: ufs-exynos: add support for fsd ufs hci

 .../bindings/phy/samsung,ufs-phy.yaml         |   1 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |   1 +
 drivers/phy/samsung/Makefile                  |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.c         |   3 +
 drivers/phy/samsung/phy-exynosautov9-ufs.c    |   2 +
 drivers/phy/samsung/phy-fsd-ufs.c             |  58 +++++++
 drivers/phy/samsung/phy-samsung-ufs.c         |   7 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/ufs/host/ufs-exynos.c                 | 143 +++++++++++++++++-
 drivers/ufs/host/ufs-exynos.h                 |   1 +
 10 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c


base-commit: ff539ac73ea559a8c146d99ab14bfcaddd30547a
-- 
2.25.1

