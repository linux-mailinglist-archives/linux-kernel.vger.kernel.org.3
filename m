Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE05642E0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGBVh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGBVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:37:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B11BC16
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:37:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so1224608eda.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
        b=N6w5oPvPqSon53fXnJZtzHnqdoTIeYCV6XuIzoHbJZvZSPSWEzPKieCj19s19eJcwL
         RcIaTUHdUUNr9nkU6I8AoMl8MYOb93MYMUeA0voFGALhae/V7epsJgesAM52ZRW0dX2Y
         4yxMLoOi6DW/mQkOXwh0GbnbaVTBgbdxWiAiCbpqEsBEKg6pEaxcBiNh8KoKto2CQ+5k
         VSW2p4QdgRIqPwEEj8mBNKB9BzfGyNCD8VAk1JR6fgYaS+Xp/nbzdZvzdg3/YaSn/Kpz
         IQD+4eisIUTicjTxgNLfA7Ka4wWJVD1nwiy7AQb07DRuKpbj8Tux5G3x0Zq9odNjaYHP
         u+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
        b=ynejy7ki6t1BwWpgLg+AD3y4wGV04wpybj0KEkrBYKPONpJGtSuYb+yzg5dipCEZMs
         bBDROo4ZWGoorIhnImqppwQpCWHThBXDlAbG41abmxvrvsPc/D6S0eSXbPnHyeV8uluy
         05RVcnH5dXjXTRR3fxUGtKOSMfbFcTO4erZ9BTGOEtbrdN3+5EZzHdJuvXn891EJT6z+
         ItyGzPB5zcjZOd1KYj5qQe1rs6L8vb+8Q2PsFPlJepWyKzhEY3DfXASXN+nSx1iV653w
         Uqn6qj7JlgKAhhE4ZUNWshgq9A9xBF3af5IURtQHeNFhaqJb5sllwlXeb+vrZ6pNPZvO
         MnpQ==
X-Gm-Message-State: AJIora8qJJCg9hxb/UX8/e7S654tesmN62Rq4q8jCEIlx07AsHwp9cGT
        bqJtF2MHrqTlzVY1UdcRsfaOWooP8f+79bz6
X-Google-Smtp-Source: AGRyM1tKUcbvm7Pv5J7R8O4WaT3he1b97HxgOQBsVTrAmlhI7zbpEK0Cj+SrJSn0blV18Pjxg6AVHA==
X-Received: by 2002:aa7:cd91:0:b0:438:33a1:d5aa with SMTP id x17-20020aa7cd91000000b0043833a1d5aamr22690535edv.157.1656797845428;
        Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m7-20020a056402050700b004356c0d7436sm17483107edv.42.2022.07.02.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
Date:   Sun,  3 Jul 2022 00:37:20 +0300
Message-Id: <20220702213724.3949-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing exynos-iommu driver only supports SysMMU versions up to v5. But
it's pretty much ready for basic usage with SysMMU v7, only small
changes have to be done. As SysMMU version is tested dynamically (by
reading the corresponding register), there is no need to introduce new
compatible string.

One major change is that SysMMU v7 can have different register layouts:
  - with Virtual Machine support
  - without Virtual Machine support

That can be checked by reading the capability registers. In case the
SysMMU IP-core is VM-capable, the VM registers have to be used, and some
additional initialization is needed. That is the case on E850-96 board,
which non-secure SysMMU (v7.4) implements VM-capable register set.

The patch series was tested on E850-96 board. Because at the moment
there are no SysMMU users for that board, the testing was done using so
called "Emulated Translation" registers available on SysMMU v7. That
allows one to initiate the translation from CPU, by writing to those
registers, and then reading the corresponding TLB registers to find out
the translation result. The testing driver can be found in [1] tree.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Sam Protsenko (4):
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Check if SysMMU v7 has VM registers
  iommu/exynos: Use lookup based approach to access v7 registers
  iommu/exynos: Add minimal support for SysMMU v7 with VM registers

 drivers/iommu/exynos-iommu.c | 112 ++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 8 deletions(-)

-- 
2.30.2

