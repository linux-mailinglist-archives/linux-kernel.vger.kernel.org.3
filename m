Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58786581AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiGZUHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiGZUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:07:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6A32469
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so27825772eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl21jvm8/i18W+G2Dp96sq2YT7qNueybJU+4cdncXPw=;
        b=U13mmqGzcmzWb0EKUrA4kB7s7tMzu6q+l4RblJKQ00zPQ4+7m3FwXyVCE87ry6V1kZ
         sKORedh3MR+G+I1H9tP6E1N3O/zdxTv9nlsw1+icTnVo3sqzJQE5fZkatjiL7z7s/Enu
         4qKcAW0kCJmyl/EzsrTTTKeRrA5/ol04PhdMrRVzXyJ3a3hGL4HjdTyQqibP6x7u25en
         U3ncncw/T9cB6a41bBVzvYy3ZlJAFzYPtlCe3U9JoIzuk6VrrPyq3SktT1U8gfCOFhY7
         bWzrISlmDVhU1ejCZkQF9TQeletEngxIXgbinFJ9VNRM2nGdlOzpk0U8obPc6axsTuiK
         vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl21jvm8/i18W+G2Dp96sq2YT7qNueybJU+4cdncXPw=;
        b=A60WSiq8wsYjrRQkpQ/ca4NrEuaNg83rvNIYfEdjc3Q6bArI1zSNEdNWOkm280gl2M
         ZbqAifyFG3wa54zsT+dLpAEGdoXJ/nEcUYpKmTJD6nV0drCTn9Ru1FPrsRi6g4jw6Vzv
         wO+elOEyKdDwWGKxIi8QkAYm1ka4j0jVgeWy4+xx96bz5McFLldQCe82Wg+jdQzhAAEQ
         ks5sKS2RNen5ihL3QRP2UEw9Wj1Rmws3cLP1V9SnLBbHqiMc6DXZ3yL0YXWmHbn+uHMt
         1a2WErs/KaB5h8SJboDyIU81anrcMGR2HPfq2nff1YpZm9RnRfZmb0ORIbA39GauFLEF
         IgVg==
X-Gm-Message-State: AJIora+bNNWtppWccJHi/40v8KkSA77MlPFMxdPQFQuZK8Pk3a/0HdIT
        /oWzXzRKUQv4dm1lTkg1ZANjSw==
X-Google-Smtp-Source: AGRyM1t5Wt6O9sdWkph8CILpfneT+aE9nPQuJidjIxem+m7LXnzboEHCUJeiqep+kJlkPyV5eK5lXg==
X-Received: by 2002:a17:907:6087:b0:72f:36ff:7fa2 with SMTP id ht7-20020a170907608700b0072f36ff7fa2mr15123309ejc.162.1658866060598;
        Tue, 26 Jul 2022 13:07:40 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id kz20-20020a17090777d400b00722e203633esm6829623ejc.122.2022.07.26.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:07:40 -0700 (PDT)
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
Subject: [PATCH 0/2] iommu/exynos: Add fault handling on SysMMU v7
Date:   Tue, 26 Jul 2022 23:07:37 +0300
Message-Id: <20220726200739.30017-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos IOMMU driver implements fault handling for SysMMU v1..v5. But the
abstraction currently used is not suited for SysMMU v7, as it has quite
different fault related register set.

This patch series reworks the mentioned fault handling abstraction and
adds fault handling support for SysMMU v7.

Sam Protsenko (2):
  iommu/exynos: Abstract getting the fault info
  iommu/exynos: Implement fault handling on SysMMU v7

 drivers/iommu/exynos-iommu.c | 208 ++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 65 deletions(-)

-- 
2.30.2

