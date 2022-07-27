Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C154D58208E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiG0G6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0G6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:58:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C23237DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so25627505lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6OBpVubEd30yI1EJvsw5Dq0IIyE9tteEyC6j1bS9sk=;
        b=gpLQVzZIdUVGSAFX/iGLrK15e1SDYBtZnE2lJi3ajbA8CzKRIxBgQl5xCEYh5kE/Cy
         Ol009Kj6qvynSKl4nHXkAiwk3XTSUIUgb9KYKLcK4casnDpB52Qp8FIzH9pDMs2SRNNM
         Mv0Pa1PUtkvsNfwen5y9I/BVS/qmjH/Fyy52rBiqRVckghIoDUo9WrKwmvaJNDsmJ3BJ
         VsIUj181PKowFtAQueanVgDr2Q9GtG79loeDxgLy3CPJ+wZa46bvdPZ8OvTR4MA6yNgz
         cZO/O1o5iy4tvuU0g3bcX2jDRRHusvP0mlXg9ZQDyrQE6GO+n/50Ls8EZD6IGHmnukGW
         5ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d6OBpVubEd30yI1EJvsw5Dq0IIyE9tteEyC6j1bS9sk=;
        b=ZohvaD/WRCd0pyKGNAVlWHyW0gIdH+YFRcyC1YecVw5dWpvUjJVY7jtMye+y0FwhOf
         g8s+9dVvLchR3QzLlATTJubpJEyJmwvYS2s8DBCQOkdRUD4JKAZKzwA3dtQmwuGmDgf0
         tbirfkbcTDB9O8qqTe0/AqzUKBxadiOfLRYgMWBqZh5O8hV1dWgjUwt9vLXRdefvXssH
         hdY6ZorlwJyPRtx0vQmCSwMDCs7jwyx5d8x0RMutHeZlvyuYnkltSISjVydU+CE2OY3P
         Emp69unkCRljiUkj4+7iRsmWRmMev+xKKnFKh8mCCOPPrBjTsGH+eNMUJbysJy2zagUe
         u6tw==
X-Gm-Message-State: AJIora8m65nqRBW9Py1N96K//bFf00ipF6Fh2bO9jjWifL/QwLsQKBH0
        nFjsUy57W6zWmMY++uAA7jvZ7g==
X-Google-Smtp-Source: AGRyM1t62/gziz5KZwIvg2PR9Bs5pkOyLVBiWS6PL6fhlndY5ib0zz+WlPF9yJliyiZCL4GMfWC//g==
X-Received: by 2002:a05:6512:3d10:b0:48a:a72d:d5fd with SMTP id d16-20020a0565123d1000b0048aa72dd5fdmr2364057lfv.556.1658905113315;
        Tue, 26 Jul 2022 23:58:33 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w29-20020a197b1d000000b0047f647414efsm3623827lfc.190.2022.07.26.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:58:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/5] ARM: qcom: defconfig: socinfo + cleanup
Date:   Wed, 27 Jul 2022 08:58:25 +0200
Message-Id: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v1 from June [1] did not hit Qualcomm patchwork due to missing maintainers
entry.

Changes in v4
=============
1. Patch 1: enable sleep stats driver (Dmitry).
2. Add Rb tag.
3. Patch 5: resending although recently Arnd posted global rework.

Changes in v3
=============
1. Three new patches for qcom, multi_v7 and arm64 defconfigs.
2. Add Rb tag.
3. Patch 5: resending although recently Arnd posted global rework.

Changes in v2
=============
Patch 1: no changes
Patch 2: new patch
Patch 3: resending although recently Arnd posted global rework.

[1] https://lore.kernel.org/all/20220623110535.177326-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  ARM: qcom_defconfig: enable more Qualcomm drivers
  ARM: multi_v7_defconfig: enable more Qualcomm drivers
  arm64: defconfig: enable more Qualcomm drivers
  ARM: qcom: include defconfig in MAINTAINERS
  ARM: qcom_defconfig: order items with savedefconfig

 MAINTAINERS                         |  1 +
 arch/arm/configs/multi_v7_defconfig |  4 ++
 arch/arm/configs/qcom_defconfig     | 60 +++++++++++++++--------------
 arch/arm64/configs/defconfig        |  3 ++
 4 files changed, 40 insertions(+), 28 deletions(-)

-- 
2.34.1

