Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654CE530234
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiEVJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243196AbiEVJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:54:24 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920783B3D4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:54:20 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220522095413epoutp027b6bbe2062b9afaf478acd1790977063~xZLHdHjqu2796127961epoutp02T
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:54:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220522095413epoutp027b6bbe2062b9afaf478acd1790977063~xZLHdHjqu2796127961epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653213253;
        bh=wgE16UmZMNhGofOTzqynT0HP+Vygf2XdPtbyaeKSY1k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BV8dMVwCSaUh3vSbAdL9Ze0xMgqhvdJtbDaEw8YkVH0Y053yPNF1rt9vQIZZRHdhx
         GVFbFYEYANGWkG7G1H/WPHI0Qbe1Jbx/OPAlEgR1VwGh4pkSSGlnwFritGhmXTX9FX
         kiXqcbvayMD6lHCQFhXzaOSj82pauUoYPF0UscAo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220522095412epcas5p22c6bf3bf0f0500d0ae3a266d55c9024b~xZLGjAX2V3217932179epcas5p2E;
        Sun, 22 May 2022 09:54:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L5bQS3H7gz4x9Pr; Sun, 22 May
        2022 09:54:08 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.EF.09762.0480A826; Sun, 22 May 2022 18:54:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520145757epcas5p145e5546f71fe836ad6d6a5f1b40459ec~w2Bvsl7i32239322393epcas5p1S;
        Fri, 20 May 2022 14:57:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520145757epsmtrp1eced6d6614a7a913a6477cb231a26245~w2BvrvLyZ2886928869epsmtrp1y;
        Fri, 20 May 2022 14:57:57 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-25-628a08406270
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.3F.08924.57CA7826; Fri, 20 May 2022 23:57:57 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520145755epsmtip123eaf73d2beaa1164bf995c1357e2402~w2Bttv13o3190931909epsmtip1C;
        Fri, 20 May 2022 14:57:55 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2 0/3] Adds support of ADC for FSD SoC
Date:   Fri, 20 May 2022 20:28:17 +0530
Message-Id: <20220520145820.67667-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmlq4DR1eSQfccEYsH87axWcw/co7V
        4tmtvUwWD5pWMVm8nHWPzWLJ5PmsFpseX2O1ePgq3GLekXcsFpd3zWGzmHF+H5PF3dbF7Bb9
        iy+xWLTuPcLuwOex+lI7m8emVZ1sHocOdzB6bF5S77HkzSFWj74tqxg9/jXNZff4vEkugCMq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GwlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        hpO2BedYK47MaWFrYFzK0sXIySEhYCLxt/0ycxcjF4eQwG5GidXnHjBBOJ8YJVat3ghWJSTw
        mVFiUpMeTMe+jY9ZIYp2MUrsXvaBDcJpYZL48WUX0CwODjYBTYnj57lBTBEBf4nOvy4gJcwC
        y5kkTq+bxgYySFjAXGLh5B52EJtFQFVic9d9FpB6XgELiVW/4iF2yUus3nCAGcL+yi6x6IEk
        hO0icXv/azYIW1ji1fEt7BC2lMTL/jYoO11i7sNeJgi7QGLZru9QcXuJA1fmgK1iBrpy/S59
        iLCsxNRT68DKmQX4JHp/P4Fq5ZXYMQ/GVpT4v7sfaoy4xLsVU1ghbA+JPf+vMUKCKlbizp0t
        bBMYZWchbFjAyLiKUTK1oDg3PbXYtMA4L7UcHknJ+bmbGMEpUct7B+OjBx/0DjEycTAeYpTg
        YFYS4d2e2JEkxJuSWFmVWpQfX1Sak1p8iNEUGGITmaVEk/OBSTmvJN7QxNLAxMzMzMTS2MxQ
        SZxX4H9jkpBAemJJanZqakFqEUwfEwenVAOTOsvkQs5JOa1mH44nvOBX6T69dUWzxJ8J3hnb
        Wb+9fiQdKCWssjRg8pMLd/PjXrztlTbkFb7H9/fzwYtzIoqu25/sf2sXVS/bllFetkng+Fd5
        TqNbp7fsahY5sNj52qQrrx+tuee7dWOP7y1m2bdbWive7FyllPv3hOru359urw7dMOdk2dyI
        lWLT1c7Vnu9M+Bfl9jGvO3wS95OGCfm+bif/qCbvSmM8M6t5n/PiaV9kT3c4fa7ctiu4Sktq
        mvSP/kVK/73PTQudsHbays08XDfWrltpkZf6r5Ff+FFDzvNH21N3cB5N/n2YV/P//rx/eUsD
        /Ret17S/9HufhZg3i4299JeWjvR1a1Wv6F/3/KzEUpyRaKjFXFScCABWcuy/EgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnG7pmvYkg+n9KhYP5m1js5h/5Byr
        xbNbe5ksHjStYrJ4Oesem8WSyfNZLTY9vsZq8fBVuMW8I+9YLC7vmsNmMeP8PiaLu62L2S36
        F19isWjde4Tdgc9j9aV2No9NqzrZPA4d7mD02Lyk3mPJm0OsHn1bVjF6/Guay+7xeZNcAEcU
        l01Kak5mWWqRvl0CV8aGk7YF51grjsxpYWtgXMrSxcjJISFgIrFv42PWLkYuDiGBHYwST2bv
        Z4dIiEtM+7WfEcIWllj57zk7RFETk8TeK0eBOjg42AQ0JY6f5wapEREIllh86DAzSA2zwEYm
        if+7u1hBEsIC5hILJ/eADWURUJXY3HWfBaSXV8BCYtWveIj58hKrNxxgnsDIs4CRYRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnCIamntYNyz6oPeIUYmDsZDjBIczEoivIy5LUlC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MHWxH8pvnWbU
        WMJ5Qyb5kP7qOrME0WcXPn5P59/7uffkjr4jhnHBVT/SNY6t2x2ZMmlZ0XNZnX2hhx4/+Gtj
        UTvH9qZx63PbiJfKWx2yW+O6vli3f0r+4v6qxrLFMMrr8O6/95qb+y9/+OPl3SrwKKXffkvn
        n9s793usP6b15kqjwbG9655Fij/qaHT5eCVJ9ojbFCYfzd/n1xkyTy47c6LBc/k8gTcHitlf
        zPq5aLO7YNbWh53VF60dnvL/uCXC2bZN2jm8s1L0U1MNxxGXro7bmlpMZpoaa2qnC1m7cF8W
        v5W9oLt71Zd64786O7/uv1whd8Zh4op0xWz+rR4K4ivyrQKOTba80CN85emJYiWW4oxEQy3m
        ouJEAEDXmgnAAgAA
X-CMS-MailID: 20220520145757epcas5p145e5546f71fe836ad6d6a5f1b40459ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145757epcas5p145e5546f71fe836ad6d6a5f1b40459ec
References: <CGME20220520145757epcas5p145e5546f71fe836ad6d6a5f1b40459ec@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of 3 patches adds support to ADC driver for
FSD SoC, and also adds nodes in device tree. These patches
were a part of large set of patches related to FSD SoC, but
these are posted now separately as per review comments received.

M Tamseel Shams (3):
  dt-bindings: iio: adc: Add FSD-HW variant
  iio: adc: exynos-adc: Add support for ADC FSD-HW controller
  arm64: dts: fsd: Add ADC device tree node

 .../bindings/iio/adc/samsung,exynos-adc.yaml  |  1 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |  4 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 11 ++++
 drivers/iio/adc/exynos_adc.c                  | 55 +++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.17.1

