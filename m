Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D556D1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGJXGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGJXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3394011C27
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p4so2149091wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nPSylhn+MlXQwMJ3vmZOIwjj2PtaM6NrgjfZcN53+0=;
        b=CWRIoXAEBDxrC9bGiRj/zi0DuboIft9UCUJ6qcWP0RVbGkX7Y5SwMT2aY+dZ0UhR1Y
         go5ObEyQjNAMrvff2gfgj2ZrVRsxpO61Oylg+EjuHaGeyqyFBPeU2Lds0h4LE/5WyJKW
         +V1MNAq/XY3lzTsRSTUlschbddDtj5ImuWtiEtVYeupQr1Kg3CLGQzmu8X/b/xv70QQo
         9nQg5wr8aAkt14BvuWmEN2REp9cu8yfBTrbFu7E0VqD1eANxZ1+lZENpsSNvRkxh7WCY
         82MTXJZ5r/hf3LK4YWCo4gfxegYLDmauOwxHlD5MWzc9Mpbs7byI3GBIYgj48vFWLH0q
         bzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nPSylhn+MlXQwMJ3vmZOIwjj2PtaM6NrgjfZcN53+0=;
        b=HJ8B8bOeZjjWyB3gZReTaBc0Q1AqZ/IqRjahEfSa6B13jHos8s3nZSCowGCdDUa6Qd
         IzOFr2/P2aITNE9lJaQpq4icAonTNnr7tIiVMYM+e9G7wz+EZKQBmQx7DnBpBn8k8frD
         krVhWXVXaPyYtuab7CWciH2zTmyBmz1v6oDTT8cIf0uezjAIxpSrRPJGgcha/tgZuOAl
         t5KlBlFf96pDexjadhkrNEtDlUbcDbHcDaSD9LO8bCT1qgtPAxJLaNf8YzhabV+mDs8f
         HVcxDi0g3PaupnvV/Uuu59JixY3BcTICZRvh0V2rPSTHXQNX36/8GDomPPvhHLFo9Xbd
         J1hw==
X-Gm-Message-State: AJIora8cD1xIpFENC+XgG5r4m7sEb1sUGQq6gqQ+LFu5Lobm/EpKkrBH
        zg2t3AeYnZ3wCN/fHioxojFpfA==
X-Google-Smtp-Source: AGRyM1srekra2VL2j8jif81CwmQn3XpY1r37W6j6+iJVlQaoKvaJeqI5+ah5MAAvaw+ScSAyLOyKdw==
X-Received: by 2002:a05:600c:190b:b0:3a0:ac8a:7c2d with SMTP id j11-20020a05600c190b00b003a0ac8a7c2dmr12650759wmq.205.1657494364733;
        Sun, 10 Jul 2022 16:06:04 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id i15-20020adfefcf000000b0021d82a6095bsm4423810wrp.95.2022.07.10.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:04 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] iommu/exynos: Add basic support for SysMMU v7
Date:   Mon, 11 Jul 2022 02:05:56 +0300
Message-Id: <20220710230603.13526-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal viable support for SysMMU v7.x, which can be found in modern
Exynos chips (like Exynos850 or Google's GS101). SysMMU v7.x may
implement VM register set, and those registers should be initialized
properly if present. Usually 8 translation domains are supported via VM
registers (0..7), but only n=0 (default) is used for now.

Existing exynos-iommu driver only supports SysMMU versions up to v5. But
it's pretty much ready for basic usage with SysMMU v7, only small
changes have to be done. As SysMMU version is tested dynamically (by
reading the corresponding register), there is no need to introduce new
compatible string.

The only major change is that SysMMU v7 can have different register
layouts:
  - with Virtual Machine support
  - without Virtual Machine support

That can be checked by reading the capability registers. In the case if
SysMMU IP-core is VM-capable, the VM registers have to be used, and some
additional initialization is needed. That is the case on E850-96 board,
which non-secure SysMMU (v7.4) implements VM-capable register set.

Another required change to make SysMMU v7 functional (at least the one
that have VM registers), is to enable default VM instance. That should
be added to the code enabling MMU itself. Insights for that change were
taken by comparing the I/O dump (writel() / readl() operations) for the
vendor driver and this upstream driver.

The patch series was tested on E850-96 board. Because at the moment
there are no SysMMU users for that board, the testing was done using so
called "Emulated Translation" registers available on SysMMU v7. That
allows one to initiate the translation from CPU, by writing to those
registers, and then reading the corresponding TLB registers to find out
the translation result. The testing driver can be found in [1] tree.

Thanks to Marek, who did let me know it only takes a slight change of
registers to make this driver work with v7.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Changes in v2:
  - Addressed all comments on review
  - Reworked commit messages correspondingly
  - Added new patch: "iommu/exynos: Handle failed registration properly"
  - Added new patch: "iommu/exynos: Add SysMMU v7 register sets"
  - Added new patch: "iommu/exynos: Reuse SysMMU constants for page size
    and order"

Sam Protsenko (7):
  iommu/exynos: Reuse SysMMU constants for page size and order
  iommu/exynos: Handle failed IOMMU device registration properly
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Use lookup based approach to access registers
  iommu/exynos: Check if SysMMU v7 has VM registers
  iommu/exynos: Add SysMMU v7 register sets
  iommu/exynos: Enable default VM instance on SysMMU v7

 drivers/iommu/exynos-iommu.c | 219 ++++++++++++++++++++++++++---------
 1 file changed, 166 insertions(+), 53 deletions(-)

-- 
2.30.2

