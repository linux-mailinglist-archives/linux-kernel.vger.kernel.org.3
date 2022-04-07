Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6024F7978
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbiDGIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiDGIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966E63FE;
        Thu,  7 Apr 2022 01:22:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so4274700plo.0;
        Thu, 07 Apr 2022 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ppw2tMYVqzC7HvzO7c5PpdbVPimtICEALn1UbsNULqg=;
        b=UkREiCEgwbAb6ttVHBkZGMxo2xO21MYpX0FPrk50ugvYwk7wktXoKL14KUP/3OGvJW
         Fcu7WtbSOydY/7TBThaw0zWLlIqArK18Uo9uvdshGzzswPf0fXJ90ZxchXusgCspENIV
         i22NC3kbxJciikqaCXu1es+Y5zH0JGoGiZmFQj/EjJ9HBi3/5S1yh6gEcO0+xGKzlsFU
         itarMtEfkHwC7u7zKSpePU5RoFO50KWLAUIQDCsT/lY265uSN8f1Mv+0c0FwmP2Rv8XY
         mXu+eNEY2AoL9vwszX66ulb1Z7YqXbsErNx2cKrjc7JjyOm1SEZh5yqWo+UOvhLwH9Yz
         nfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ppw2tMYVqzC7HvzO7c5PpdbVPimtICEALn1UbsNULqg=;
        b=lHQY3MeAoMvVrTnpA3ku6ce2GTcZ1zW954Q8fLDN4X6gcM2j3L2aKQ1KfqTKRkFrzQ
         DRVna5CMxAHoNqdQ5FgU7i3/JkR/ibe6WQc/J0fjA6H8AjxsG/TyuXCu+HebTrNXhdbW
         bxgbb2hJdNUoIX9k3g9R200i955/5tw8K7e+6S4L12zt/+7Vo4nqb/g9uYMAbH/3WyGZ
         k1CMQse5WRqztu6h5XvfSvYCUD3ggjnRfjEcdkaicukA+boWFRdUsD0VykGcY3+ARRAU
         J6g9wVuUfWlnDilyvCndi6HnJyjFGjsvGzcZMe3ejeVjbEFNYAKRWH+3IYJYlM79o7v8
         qJwg==
X-Gm-Message-State: AOAM531COCBo7H4u2ThTFT/kN5GAibEfb/PibG/spulNY2FDOAtpY8XQ
        uNFDkJdLg6612JlN7ln1Uy4=
X-Google-Smtp-Source: ABdhPJxoZCtWfB7qKoZDzOT4xHLSORB7ZyZ63FKx8hSgW3GMKhtn5laAB4mZ/WFalFPr7T5DYZrcvg==
X-Received: by 2002:a17:902:d884:b0:153:ce8e:66fe with SMTP id b4-20020a170902d88400b00153ce8e66femr12840592plz.157.1649319735589;
        Thu, 07 Apr 2022 01:22:15 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:15 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/7] iio: adc: sc27xx: fix read big scale voltage not right
Date:   Thu,  7 Apr 2022 16:21:43 +0800
Message-Id: <20220407082148.571442-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407082148.571442-1-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
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

