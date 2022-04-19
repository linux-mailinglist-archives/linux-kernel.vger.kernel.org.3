Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D805507045
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353291AbiDSO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353479AbiDSO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514A36345;
        Tue, 19 Apr 2022 07:25:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s17so5074290plg.9;
        Tue, 19 Apr 2022 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ko/RssBDPm1apKVmyb31rJH5PtKu0iktDyD8GjzienE=;
        b=AT2LD2z4usldjQEHGaIpPjWPfjU9OZMRl09tD0hS0EaToAraJXPQua9Haqj0VoMo17
         vXioYK5qeLGVdpsdqNR+Di4KC8QhGFTvzCf1gBPbboMcemT9cwbyllpsDdUVVjnCyFhA
         E52vTt1jFJNJc/GG4DxYIgIwt7J0dL4jVrWz/JI/y4v/S0prJu/P8KxEVQUzk38ztV9z
         qxsXxvY6K7ptmYJXgzb/dUEQHxN9/hjz3oqLn2aiaQ6473Y86JUkHXl/hYcn50+6wkKa
         U4yCWD1xftl2lTANYLUC3y4JSZ0DLh4x/kuL3AipfKvcNGfUnVU5HgliTP34zkBQEN4T
         gatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ko/RssBDPm1apKVmyb31rJH5PtKu0iktDyD8GjzienE=;
        b=S8tXXNoKIEOkAKr2OE6OCP5Y856wMw+56WfY3VISJRGKrnRo0bRjDsKDJ2zM45oKWK
         z61iNMjK6Tin5u62SZhnh9UJZDh2l1ZLDJ41JzAn/icEFCGqhA6y6Ojnl3LJevKY02hD
         VApjumFEUZlTucDyQwQ7dW30f0XNjHbIdSaHYodIUcl3ZzO3gkUTGY4HJI0nNLd9OZ7K
         JlhP+9l6fMsatjM1P2hOvz6f28NUaj6taoiaByDGbZHCBHFHROO9n2m2tIp5nANYOhPI
         oqiY+lAM/7vh8AWCoVjmBuDxKMlHwq59URT/hiorDRQSOWpM+SimAkawiJyc+SEbI9q2
         uCpQ==
X-Gm-Message-State: AOAM531HAJPDyD1sfHaIarMh4dU0ubRKYNQWjZrUVwZWLyzV+VQ0Ac80
        VsLqrVg8G6l480+cLWjcvV4=
X-Google-Smtp-Source: ABdhPJx3KnWme64jL4M8cSukpB6sV7smnMw5GpIQzO+Er8bsgY/GODLnxMENZ9W1UtDjW5lVXdJb+A==
X-Received: by 2002:a17:902:bb94:b0:157:2ce:fac1 with SMTP id m20-20020a170902bb9400b0015702cefac1mr15999688pls.25.1650378322949;
        Tue, 19 Apr 2022 07:25:22 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:22 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/7] iio: adc: sc27xx: fix read big scale voltage not right
Date:   Tue, 19 Apr 2022 22:24:53 +0800
Message-Id: <20220419142458.884933-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
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
Fixes: 5df362a6cf49c (iio: adc: Add Spreadtrum SC27XX PMICs ADC support)

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

