Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D8C4954EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377452AbiATTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:36:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:23710 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377431AbiATTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:36:17 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220120193615epoutp029aeda124204c756167f0413b795f9453~MEaeJlStW1051010510epoutp02i
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 19:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220120193615epoutp029aeda124204c756167f0413b795f9453~MEaeJlStW1051010510epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642707375;
        bh=Qtn7upv8GZjDoLwHPDOTqVpHTQyLHTy5KXPqN6blMZI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ufoClSASShMge2QL7C+vbMR8eycWev2iAtB1f+/2CoiNXASaUhQRxvx6+vAkVTPQ3
         5dkylfiiZkCTQzkPw5GGL9acy8vRjTglaiuRdgmyNKnqgfmo9602Vhj9dBPIkX2i4R
         yNoxRWMGYU3nQMrTv4vfLmbA7GAk02ZN45opFhHc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220120193614epcas5p2aa24bcbf2e6e0be2260b9432f7336ab3~MEadSR0st0131201312epcas5p20;
        Thu, 20 Jan 2022 19:36:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jft6K5w2vz4x9Pw; Thu, 20 Jan
        2022 19:36:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.AE.06423.9A9B9E16; Fri, 21 Jan 2022 04:36:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220120193608epcas5p466c73dfdcc7eb5cdcd52516a635fca79~MEaX5wPYa1027310273epcas5p4t;
        Thu, 20 Jan 2022 19:36:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220120193608epsmtrp25bbbdf5bd2072fd24e0044219a07a790~MEaX45_8V1490214902epsmtrp2q;
        Thu, 20 Jan 2022 19:36:08 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-60-61e9b9a903d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.83.29871.8A9B9E16; Fri, 21 Jan 2022 04:36:08 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220120193606epsmtip2d837dd6dae9e8bff1606ead45f23784e~MEaWLVRXh1544215442epsmtip2C;
        Thu, 20 Jan 2022 19:36:06 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 0/3] Add FSD SPI support
Date:   Fri, 21 Jan 2022 00:54:35 +0530
Message-Id: <20220120192438.25555-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmpu7KnS8TDSZvMLZ4MG8bm8XiH8+Z
        LKY+fMJmMf/IOVaLjW9/MFlM+bOcyWLT42usFpd3zWGzmHF+H5NF48eb7BaLtn5ht2jde4Td
        gcdjVkMvm8f1JZ+YPTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AelW2TkZqYklqkkJqXnJ+S
        mZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SokkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y1ZPfcETtoofV/4yNjAu
        Ze1i5OSQEDCR+PRyGlsXIxeHkMBuRokLM5cxQjifGCVez9wK5XxjlFi88x1cy6mfr9khEnsZ
        JfrenmSGcFqYJM7u+80GUsUmoC1xd/oWJhBbRMBN4kZjBxNIEbPAHCaJzavfM4MkhIGK1l85
        xg5iswioSqxt2QjWzCtgI/Fx4hFmiHXyEqs3HADbICFwj13i8oEtbBAJF4lrsxawQ9jCEq+O
        b4GypSQ+v9sLVMMBZGdL9OwyhgjXSCydd4wFwraXOHBlDgtICbOApsT6XfogYWYBPone30+Y
        IDp5JTrahCCqVSWa312F6pSWmNjdDQ0ID4k3Mx+AvSgkECtx50MT6wRGmVkIQxcwMq5ilEwt
        KM5NTy02LTDMSy2Hx01yfu4mRnCS0/LcwXj3wQe9Q4xMHIyHGCU4mJVEeKXqnyUK8aYkVlal
        FuXHF5XmpBYfYjQFhtJEZinR5Hxgms0riTc0sTQwMTMzM7E0NjNUEuc9nb4hUUggPbEkNTs1
        tSC1CKaPiYNTqoHJb+a0XYKfr8VdOp54MbXI8s7ppUEmtxfp7VuyYav85g2PH/hIq98t0ZmR
        dOyA8CkRnzOHSmt7u1PjbW2XLn8zz+uNwwn3tV9P2BjM9JvfUVT/xCr065n2SO9Lv2fxqGso
        v7ivMfnP/e7FFmsdRZXjF/qslqmSniwi+mCOzRbxEKPpWpGqu5Nn8H04yq3QdMnLe9PtfO7Z
        VpxHrhZGfth0Su+2iXOC5Wm5PUd3Lv90efGOX9pPlmyM4HbMShaRO2+Ufz6dc+/K8vdmZ7x3
        H6o62aCjOE+Mm7Vzw9EpvmsqvtoZuVWtnXEwwidIebUd5+3Sdz8KP+nc6D3vsrBw2sL3ftG7
        1C1qf57v09y34cPqLUosxRmJhlrMRcWJAIg5A+b7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvO6KnS8TDZZck7V4MG8bm8XiH8+Z
        LKY+fMJmMf/IOVaLjW9/MFlM+bOcyWLT42usFpd3zWGzmHF+H5NF48eb7BaLtn5ht2jde4Td
        gcdjVkMvm8f1JZ+YPTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJUx
        q6e+4AlbxY8rfxkbGJeydjFyckgImEic+vmavYuRi0NIYDejxIKLN1kgEtIS1zdOYIewhSVW
        /nsOVdTEJNH4azZYN5uAtsTd6VuYQGwRAQ+Jtn/3mEGKmAWWMUls33cCbJIwUNH6K8fAJrEI
        qEqsbdnIBmLzCthIfJx4hBlig7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCYl1quV5yYW1ya
        l66XnJ+7iREcilqaOxi3r/qgd4iRiYPxEKMEB7OSCK9U/bNEId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiOX/gnkaLBlpElucnTe6rzc5EC8T1r92h+
        ZK77s+HR2u+sz87xcu7ccqH1+unlsmKH1fRDIzaWmh+58/RDf+iZi7yLIs/eqa/bqrRDrUUt
        Zl6K91x/u1Vu7iFyn0yy1t9xKZmpxtv2n+X/kzKZksw9f/55Lk2RnBjJdelJkMA8h9KPr1tr
        YqJifM9y/y+q6mua+uP7kQSd/xGsLFZfTyql8elqTNkp+zTw2jLdB0y+b0QbTgeuv/n3xcV3
        h/Z0s9yU2Zb7LUz02fkTMxZfbT6mt0NB+EX6J8HIp955N5615+8ymzPxYY3sqRLfknuqstPE
        ywsPav77XrtwVs+JtRu55l6Xyq6fUu/E3HvbVodbiaU4I9FQi7moOBEAmxxRhrQCAAA=
X-CMS-MailID: 20220120193608epcas5p466c73dfdcc7eb5cdcd52516a635fca79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220120193608epcas5p466c73dfdcc7eb5cdcd52516a635fca79
References: <CGME20220120193608epcas5p466c73dfdcc7eb5cdcd52516a635fca79@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for SPI controller found in Tesla FSD SoC

-Changes since v1
* Splited SPI changes from a larger inital patch set
* Rebased on Krzysztof's latest (v5) SPI schema changes
* Added tag

Note: This series is depended on [1] patches which adds
support of FSD SoC and on Krzysztof's v5 [2] of spi schema changes

[1] https://lkml.org/lkml/2022/1/18/498
[2] https://www.spinics.net/lists/kernel/msg4211991.html

Alim Akhtar (2):
  spi: dt-bindings: samsung: Add fsd spi compatible
  spi: s3c64xx: Add spi port configuration for Tesla FSD SoC

Aswani Reddy (1):
  arm64: dts: fsd: Add SPI device nodes

 .../devicetree/bindings/spi/samsung,spi.yaml  |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 57 +++++++++++++++++++
 drivers/spi/spi-s3c64xx.c                     | 13 +++++
 3 files changed, 71 insertions(+)

-- 
2.25.1

