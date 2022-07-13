Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648035734E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiGMLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbiGMLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:04:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA4BE21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m16so13585981edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNYP8B1ME9KY0a8jTfTcqgXcyXU8mAW2KwCYvewBtYU=;
        b=T7znwU0n1MdPtajzmK7Z6fMAwbtfuwSIUu8mM8O7VeRVr6QGzfWysCMZQH344Csi9c
         oQUSSw9tGF1UgDTtRcN25QkNoCMaCjWOdTCpNLch2HOtVv/s7tTtWr+jl1IFdPF+4ejd
         HLSUotBKqnR24kDe/koZBTZfQ2emZ/kEiJGWPsu9IvsS1Iv/4Oo+kb8vJzCEMPz/3lVr
         VJ1NePYiwRaxCsoT1JiFExVvi/AVaCsVC3j2G8iNQWL15KYNBkKzAgol826nOzx/igsX
         RRgOE+MTu16LEhyaaVlKs59KVkekV6gQ1mqdPcoUYrtPYEhlpXtP9lc7Iy2qZVDWb2NV
         yN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNYP8B1ME9KY0a8jTfTcqgXcyXU8mAW2KwCYvewBtYU=;
        b=I8ZTzcLhimd6zSvw23Sr5iFv+vi0QVPYvgPBHCenFQPtQMjVy5gCTbsekojtsNIdYu
         JizZs3oRVNrX93qFX6YGeI/h5wpBGA66edjI/51laqnsyt31Cj9egXAIJk6EwMZoFLjK
         fQBWGWPs3+xd6guwU0+MlbzgcDhnjPRlr5Sr/x9XcHp2LMbFeBC+LhSV+DTU64uxHGlk
         1O6RNwmds6HWk8hd4/cuqSnTWPxAps3q/S+ibTPuGSJXYfcTSpISlEFN3+4LmKhRqWmB
         GgMnxAvdzWhS6PQb1bwcoFtJA7FTL1M+P0zDgaTfEx9bJ7b+iY7gCbGD3G/tMCSzMQE+
         d5iA==
X-Gm-Message-State: AJIora+zTYQusyWPy5I40PZJVImBkS/RrFvBNCBwYqTgL26tsdY2NK2c
        TLplGVzZDCYOp7++0y7QmS88Iw==
X-Google-Smtp-Source: AGRyM1s2KBHAmTAhxDYhWdtvoYkDXjG3eS3gnOPmKV32f9vYdsQr7ybH+7neovTiTcbxD3KuTYNi2A==
X-Received: by 2002:a05:6402:3219:b0:43b:6f3:8ccb with SMTP id g25-20020a056402321900b0043b06f38ccbmr4050107eda.345.1657710267815;
        Wed, 13 Jul 2022 04:04:27 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0043a75f62155sm7801152edr.86.2022.07.13.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:04:27 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 1/2] venus: kconfig: Fix compile-testing on x86 platforms
Date:   Wed, 13 Jul 2022 14:03:50 +0300
Message-Id: <20220713110351.827446-2-stanimir.varbanov@linaro.org>
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

Fix Venus driver COMPILE_TEST compilation on x86 platform by
adding a dependacy on V4L_PLATFORM_DRIVERS and select QCOM_SMEM
instead of depending on it.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
index bfd50e8f3421..95814b175c3e 100644
--- a/drivers/media/platform/qcom/venus/Kconfig
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -1,12 +1,14 @@
 config VIDEO_QCOM_VENUS
 	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && QCOM_SMEM
+	depends on VIDEO_DEV
 	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select QCOM_SCM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
+	select QCOM_SMEM
 	help
 	  This is a V4L2 driver for Qualcomm Venus video accelerator
 	  hardware. It accelerates encoding and decoding operations
-- 
2.25.1

