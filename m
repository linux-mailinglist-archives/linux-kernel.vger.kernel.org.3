Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238675734E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiGMLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiGMLEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:04:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AB255AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m16so13586074edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DU5XuSW/046mOOm+NLcLZp7tRfHbjzmrVG2d7moN73o=;
        b=TfwpHdjd3WTm7+Q1rz1BBJtUZDY36nJHU4SwbysADFTmD8X2vkgPfHAu1cL5imoXjo
         aC5qceDOX2HhpYWLd8Dog+yLL7CHJiFAkMF0xR+7ColcILO/beGrIuPLKWtHk8EarT4n
         01ct3IkgVRX0Dn2p5Gwck4nvsvMAyq2Ksi7ROAP1GZiujf3wCdSfjSB6bZRoMRp6PBzP
         MFbrOLhJnc++ddD6X/PXb9Xff9fvIQ2sVUltx3KcNO/2dgWVUceJwbDILWJTnCu1kQxv
         IbXx19TEvYQO9lZeflifdo7o/gab97aNsL1SRGC82cHS1GhHmlb+JsCtDy08smhoEHeG
         ZSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DU5XuSW/046mOOm+NLcLZp7tRfHbjzmrVG2d7moN73o=;
        b=Gs6vCKglZWR4dTbiXfIg2AzLUEKRYervwppptjLTgN+RCD+V7lArjQq5G+X6V4e/5u
         T51jV8F6VnE2OuiIzqEn5zLfkDgt5G9PEih8U8baTVYyN/k3l1/CXr31H7WyX9EnTv6t
         k4XIfpg3ZzAWap90ttEL6MeSyQvcISRSqGl9LtHIQ2f6Jcmour2JXwDACiMti4j/r/KM
         z0zC1+xFvVhlQIAYYatUMODxv6z2ZRBquLYbfRyRmznT/OFEZY1DaNC+YwAoTzXhDDoe
         Lr0etrl5QcTSa6B2aJRbC2zs7d8/njSRX6UjIJJaWK+sm94zHipBquc84wKdF+98XsVE
         SD6g==
X-Gm-Message-State: AJIora8nn5UVg+i4qoQFxqqenJC9hk3EFqLv3jHjCKWiRbF2hGrUxuHn
        B3xOYHHLGdggbKlzeip+BXzaKQ==
X-Google-Smtp-Source: AGRyM1sF3/3nzpdNyUiYD97PSTi6VVNkfmFxs8ONGJPQV8pikiV9P9XJvw2wvdvABIFiNmMi1ffSAw==
X-Received: by 2002:a05:6402:1e92:b0:43a:7cd0:6bed with SMTP id f18-20020a0564021e9200b0043a7cd06bedmr4079253edf.423.1657710269651;
        Wed, 13 Jul 2022 04:04:29 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0043a75f62155sm7801152edr.86.2022.07.13.04.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:04:28 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 2/2] soc: qcom: smem: Fix compile-testing on dependent drivers
Date:   Wed, 13 Jul 2022 14:03:51 +0300
Message-Id: <20220713110351.827446-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713110351.827446-1-stanimir.varbanov@linaro.org>
References: <20220713110351.827446-1-stanimir.varbanov@linaro.org>
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

Fix following unmet dependencies seen when compile-testing
Venus driver:

WARNING: unmet direct dependencies detected for QCOM_SMEM
  Depends on [n]: (ARCH_QCOM || COMPILE_TEST [=y]) && HWSPINLOCK [=n]
  Selected by [m]:
  - VIDEO_QCOM_VENUS [=m] && MEDIA_SUPPORT [=m] &&
    MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] &&
    V4L_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=y] &&
    VIDEO_DEV [=m] && (ARCH_QCOM && IOMMU_DMA [=y] || COMPILE_TEST [=y])

by select HWSPINLOCK instead of depend on it.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..68f29452e5fa 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -139,7 +139,7 @@ config QCOM_RPMPD
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM || COMPILE_TEST
-	depends on HWSPINLOCK
+	select  HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
 	  The driver provides an interface to items in a heap shared among all
-- 
2.25.1

