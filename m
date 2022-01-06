Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6664864BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiAFNAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbiAFNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC6C0611FD;
        Thu,  6 Jan 2022 05:00:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id oa15so1569953pjb.4;
        Thu, 06 Jan 2022 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwFTwOwK4XLgtlRpafJGgCNv/2nOPaZHwrCqeJXNvns=;
        b=Y4+xPTsiDCwE7fPDR2U42nzIXs82BE5+1r7+MHJEoLXhNxjlkSn1H1YS9hKD8E62Sd
         pbbhor8UBt9NlEQTQkJKPjsil938MXEcOVY9MRBKmb7fUJOEYmndi+aKcD98HeDin2rD
         MtYhIAeHed0GkyaAIk0nAjBb00eUllT/bQB/eCoVKGT/YrGPt8438uWszeVugxW/cJ1j
         7HEWMng/4EZ7e87MnLk/yzwtJ+q5xZqHIKXX7pgqw1mYPfsFm0jD56ifxS/EB3cI9VCY
         mUBx1qnl/G6YB5wptc+YzAGFQ9GeYTQMHaYP1zJdhmD26nwskZdzuMYWwHrx1YCRP62N
         3Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwFTwOwK4XLgtlRpafJGgCNv/2nOPaZHwrCqeJXNvns=;
        b=qOxrWNod3fseMeKm5rnlo12W2lAHmgU081KgNeG1JP5IDGehqyW3WGYo1z268YVVQs
         xLmeG4Gl/hEH0rNJK+D+JwT+wIENbjBdGw71x1C7KszyrWiLdRUoFqv5AeG0SBljUt8X
         osvXDC67AiI7KiUUmBeP33HZOsRxEnG5Au5ChDUxvAHHJfXK1i73s/vHiQ1XF6UhW9IE
         VbsvDOUycLqJpE0xAPirTq9ElvpnR+2VKF5GrMnIOcW1a6KeHRffxNCIiNNSfc7XoaGd
         +kjXCTo6BVZPCSuL0zri/8nFaAQhLCoOS/2uHWdeA4Ar7KUQCDk4Qi4cKpSOSKpudnLu
         OgFw==
X-Gm-Message-State: AOAM530QpB8drhyp5ZswjrjY9SEnZ8J9r4IVyt+WORW2NqvSPSfh8HDZ
        QcmovP9cY+Sp01wpfPOP3/Q=
X-Google-Smtp-Source: ABdhPJxs0hL1s4WPEqWxUvjcgoZTOUQAio2fEiO3xBcJ1jiILL9nxd+jyyzPWMv85ImG8Xs+cvdGBw==
X-Received: by 2002:a17:90a:7e81:: with SMTP id j1mr6940295pjl.14.1641474018168;
        Thu, 06 Jan 2022 05:00:18 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:17 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iio: adc: sc27xx: fix read big scale voltage not right
Date:   Thu,  6 Jan 2022 20:59:42 +0800
Message-Id: <20220106125947.139523-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
SC27XX_ADC_SCALE_SHIFT by spec documetation.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
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

