Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E353CC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245677AbiFCPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiFCPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:48:56 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6104A506C6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:48:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603154849epoutp026beee000557b359b7f199be4139043a2~1JwKGjkKS1535315353epoutp02v
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603154849epoutp026beee000557b359b7f199be4139043a2~1JwKGjkKS1535315353epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271329;
        bh=sWWYrw8VuDqq0QJl4Hk/RiH6NmDQDCjSyYfztasWBHg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cNKhGOOiBVesRNzVFAgZlk361F2KS8KE/ELmCThwKpuX4bM9dEAmgfQu9W7EEo/3i
         4sHZAiuNG/teVUASZQ5AlrewtKrW5vJeGjZBp2xqQZ3Xp9hI8QcmX0UvdqVOkYKxuk
         f1YAMXP8k3mDWC03fagu9z5vCOgoHAWDCHDbhf/U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220603154848epcas5p3fed8acf433e416fbf58724035fb37585~1JwIvjFdL1875418754epcas5p3a;
        Fri,  3 Jun 2022 15:48:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LF6k60MFLz4x9Pp; Fri,  3 Jun
        2022 15:48:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.A8.10063.D5D2A926; Sat,  4 Jun 2022 00:48:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154845epcas5p1b3eaea1ae6bc67e3d4c22d235102a6a8~1JwF1uals1285712857epcas5p1M;
        Fri,  3 Jun 2022 15:48:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603154845epsmtrp18f7ec9b783423038d6157dcd70616069~1JwF0ziba2840728407epsmtrp1O;
        Fri,  3 Jun 2022 15:48:45 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-2f-629a2d5dcd61
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.6C.11276.D5D2A926; Sat,  4 Jun 2022 00:48:45 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154842epsmtip1c73f572840caa46a8a536637525cf71d~1JwCuMgLa1990619906epsmtip1h;
        Fri,  3 Jun 2022 15:48:41 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 0/7] Add support for UFS controller found in FSD SoC
Date:   Fri,  3 Jun 2022 21:17:07 +0530
Message-Id: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmlm6s7qwkg2U/zSwezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjPe
        HUgqeMRTsfjVH8YGxiecXYycHBICJhLbH61l7GLk4hAS2M0o8ev+N2YI5xOjxI51r1ggnG+M
        ElPmnGSBaVm++DcbRGIvo8ShS29ZQRJCAi1MEvsmeYPYbALaEnenb2ECKRIRaGaUONixC8xh
        Fuhjklhy+zZYh7CAu8S/Iw1ACzk4WARUJdbMZgYJ8wrYSKx8uogJYpu8xOoNB8BukhD4yS5x
        bc1DVoiEi8TR1iZmCFtY4tXxLewQtpTEy/42dpCZEgIeEov+SEGEMyTeLl/PCGHbSxy4MocF
        pIRZQFNi/S59kDCzAJ9E7+8nTBCdvBIdbUIQ1aoSze+uQv0uLTGxuxvqAA+J3pnnmSFej5XY
        POcI4wRGmVkIQxcwMq5ilEwtKM5NTy02LTDMSy2HR01yfu4mRnDy0/LcwXj3wQe9Q4xMHIyH
        GCU4mJVEeMvmzUwS4k1JrKxKLcqPLyrNSS0+xGgKDKSJzFKiyfnA9JtXEm9oYmlgYmZmZmJp
        bGaoJM4r8L8xSUggPbEkNTs1tSC1CKaPiYNTqoGp7nOUXaxh4e2pMg+FklQbUlYaS6YlKvmz
        qSWfXVbY83R3cNsJUYfJeW7NH+yLn7hPbGqZZdZryfrQWfCtkIH0/aUCFWdn/c9sia05Jlnv
        W/g/jVfc295KcVrvhaofiQ/ywlwqMr+aSbnP9ef8M13viEdQaMW3xUGTTkSw3g3J/BuivTK4
        skN+xu0NHxqmtwZc0gu4I+b43r9rO/sMgT0CvskX1fR27F33ZBOXeGBK3erpjgsdJhV7HzdZ
        P9X48v3sKQu/Toq5EKTkVKKf6pux/rhxzscdL0w0GsJlao2DMvakBk5wXGWwa5LJ/dutC85F
        +r8UX2nOveXc/sbJ/fyX2Q1dnllv9jQxveugosRSnJFoqMVcVJwIAL/cWcMHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnG6s7qwkgwNP+SwezNvGZvHy51U2
        i2kffjJbXN6vbTH/yDlWi74XD5ktNj2+xmpxedccNosJq76xWHRf38Fmsfz4PyaLRVu/sFu0
        7j3CbrHzzglmBz6Py1e8PTat6mTzuHNtD5vH5iX1Hh+f3mLx6NuyitHj8yY5j/YD3UwBHFFc
        NimpOZllqUX6dglcGe8OJBU84qlY/OoPYwPjE84uRk4OCQETieWLf7N1MXJxCAnsZpS40bqF
        DSIhLXF94wR2CFtYYuW/5+wQRU1MErs/LGQFSbAJaEvcnb6FCcQWEWhnlLi/HWwSs8AsJon3
        k54wgiSEBdwl/h1pYO5i5OBgEVCVWDObGSTMK2AjsfLpIiaIBfISqzccYJ7AyLOAkWEVo2Rq
        QXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwiGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrxl82Ym
        CfGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBkM+0Sg1fQ
        y5lanK5OZx4s4IjSKz1Skvqt1bbQZtL+UyrbGxYmucWHHTZgPijpbKH7cJpJtOg2RsOZG79U
        b0qq3WjYWaPWYTlrrtnDaHbz/1bfUlemhWrEsD2Pnhb7827pxudT05Z61iha8JiKiS19tj9E
        aHmcj0HL5P0i/z994f9RJJZkNvXu6e8N3r81XN/OvW1cr7mPrfem38/ZF12KH6lvL9h/jnPG
        7CWx7YKV1ka8dROzHz4vPf36vcmU/bq/96Ux3bHw2PKA2X6J289DfzOaxD8Znf7e13RX45t2
        y46t9yXdSqwvyG2YHzC/RGLt9Z5pi8wOSWb/tb2tLZdeHvfjya2V/HfWac+dKvJNiaU4I9FQ
        i7moOBEAyqhF2MACAAA=
X-CMS-MailID: 20220603154845epcas5p1b3eaea1ae6bc67e3d4c22d235102a6a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154845epcas5p1b3eaea1ae6bc67e3d4c22d235102a6a8
References: <CGME20220603154845epcas5p1b3eaea1ae6bc67e3d4c22d235102a6a8@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for UFS controller found in FSD SoC.
The HCI is almost same as found on other Exynos SoCs with minor
differences. This also adds the required UFS-PHY driver changes.

Patch 2/7: common change to handle different CDR offsets

*Changes since v1:
- Addressed review comments from Bart, Krzysztof, Chanho
- collected Ack-by tags
- rebased on next-20220602

Alim Akhtar (7):
  dt-bindings: phy: Add FSD UFS PHY bindings
  phy: samsung-ufs: move cdr offset to drvdata
  phy: samsung-ufs: add support for FSD ufs phy driver
  dt-bindings: ufs: exynos-ufs: add fsd compatible
  ufs: ufs-exynos:  add mphy apb clock mask
  ufs: host: ufs-exynos: add support for fsd ufs hci
  arm64: dts: fsd: add ufs device node

 .../bindings/phy/samsung,ufs-phy.yaml         |   1 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |   1 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   4 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  14 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  29 ++++
 drivers/phy/samsung/Makefile                  |   1 +
 drivers/phy/samsung/phy-exynos7-ufs.c         |   3 +
 drivers/phy/samsung/phy-exynosautov9-ufs.c    |   2 +
 drivers/phy/samsung/phy-fsd-ufs.c             |  58 +++++++
 drivers/phy/samsung/phy-samsung-ufs.c         |   6 +-
 drivers/phy/samsung/phy-samsung-ufs.h         |   3 +-
 drivers/ufs/host/ufs-exynos.c                 | 141 +++++++++++++++++-
 12 files changed, 260 insertions(+), 3 deletions(-)
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c


base-commit: 2e776ccffa840ce53ee1c21bde54cbe4bc102c3b
-- 
2.25.1

