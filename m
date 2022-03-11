Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DF4D66B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350469AbiCKQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350592AbiCKQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:48:05 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4DF1CCB0F;
        Fri, 11 Mar 2022 08:47:02 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e6so7906588pgn.2;
        Fri, 11 Mar 2022 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwkiZETRBq3BOGrziBS3p6YkBIMmayx2E7dE2DKPdxI=;
        b=SW/HZd2gxUZwi8/iY5E15EicrVHB9I8/EUMcftk+9iMq5qpvFVNsfl9KUYeuw4ecc1
         9dREvre5igACEo/yrn3GgxCK34yN3LWRzkRgfBaX/oFxyOhaH9SBLqreiIEv19QyNb/q
         biJnSOO0cVZLrRDtzMD7/gWNwvVNxiq+YWA8jtoHrAoysEcfVup5c1M01OEGIhjIrE9E
         O+ehb1JtQEHnmcKTAQwC+cW7g1PMaGIRosuQlJfE4hkNCrD6AfrnO43Bt13by1IwiFxp
         phepKEfxfMR6qT0Nzt49OCBVokKYQK9/Q7c8IZh77mnIJ86bz+i5OR66OJcx63zojRWz
         AJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwkiZETRBq3BOGrziBS3p6YkBIMmayx2E7dE2DKPdxI=;
        b=fQCh6I5smSQ5PuGGBDCjQw8j/DvZLE64KV5ry4Ys9N1YX06ccTL3DWRKcfLNjmWhy6
         BsmKUs43zOGj43lIMr16zAr/PXJbqp1UQ3BK8eqsOmoFPtfF13FPDAeTBasDsAKDMtl2
         6JiimoFrUE1dJ5IQSKjB3Vc0nOCig9XWZ06kMu10fr2mwLNLrp4rvdpxzJ+XrzZYNMHw
         RDalLGgkcyKa/W8vUX/Kp80rmW/1f+8cnVxCJU1aW7k6IEceAngJvwTLkA8vp81FCsgS
         nDcK7fg5Xu0QuLTsTtzSevdFnLNhudr95k8q2hnTYTVjQI1g0FmdRS8OejiRgwQE+fJ4
         X5Iw==
X-Gm-Message-State: AOAM530yWcqz8VH55eroDY0mN5piXl5I4kfwTnk2Rwwd/ukqRITVRdp6
        ypWmLKpbSYK3PFYCbeHNInM=
X-Google-Smtp-Source: ABdhPJzBlqICFB1UxNnLh5f9dwHuGUhoakgRzBoEgyp3XxtA9UhpVPWM2avhI9rK/jrpmlwpiyzWgw==
X-Received: by 2002:a63:f055:0:b0:380:f88a:9e2d with SMTP id s21-20020a63f055000000b00380f88a9e2dmr6026868pgj.596.1647017221803;
        Fri, 11 Mar 2022 08:47:01 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:47:01 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/7] iio: adc: sc27xx: fix read big scale voltage not right
Date:   Sat, 12 Mar 2022 00:46:23 +0800
Message-Id: <20220311164628.378849-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311164628.378849-1-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
SC27XX_ADC_SCALE_SHIFT by spec documetation.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/iio/adc/sc27xx_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 00098caf6d9e..aee076c8e2b1 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -36,8 +36,8 @@
 
 /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
 #define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
-#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 8)
-#define SC27XX_ADC_SCALE_SHIFT		8
+#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 9)
+#define SC27XX_ADC_SCALE_SHIFT		9
 
 /* Bits definitions for SC27XX_ADC_INT_EN registers */
 #define SC27XX_ADC_IRQ_EN		BIT(0)
-- 
2.25.1

