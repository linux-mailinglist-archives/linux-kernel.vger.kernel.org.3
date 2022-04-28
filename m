Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3138D512FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiD1Jtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348046AbiD1Jg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:36:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6235295486;
        Thu, 28 Apr 2022 02:33:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h1so3750585pfv.12;
        Thu, 28 Apr 2022 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jx2sI9U4OCn+w0obbX5GiL9CUWZWFJnR6/XlVL4TXok=;
        b=bFBvSiqIfUxsZ8Ums18LxH6niAvg0Lz5mTnbjPoz6e7cc3W40d5Td4P9r4NmpzYzlG
         pb2pvd/fXNxKbXjjuxJTRfqemXZc5KxQbMZ5Wuk+EUVJrFkJk3ha3u/vUTc8gcDH2ZH4
         DYNBWeJ8rGROjMMEZ74Ps4VHWwPSQWgFFGQhUW73O+VsGZpTH8xrRumYjdv5aVujDovW
         zKdYJPsJ3gw/4mCZrUbNmmJy/mzwVjz8dWSQRaGHn6VmDpfh03IlvxgWESyWPR4FK9Lp
         317ZFqDKgDGgi8ciEAnbSuQhGJ9IijVs0u6OI4FyqXw6w9ULSoYT0tsHNkCckiPlaBBO
         ED6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jx2sI9U4OCn+w0obbX5GiL9CUWZWFJnR6/XlVL4TXok=;
        b=e8gKlB2dPfpSgNar1Y9xaVGk1U1AdwgcRIbWx1Ga4crInXKBmS85/nnLTpCrLjzUn7
         Pj+4ezEPRWCnrzdl5o6kLluM1MUQ/2a4DoxBv8bO3PrCwnAemMR5gr9Du6ZA1/Db2Pyc
         KEE5EmKnVzKG3CCCluquLTev581lnLmBoTs87/kJ9m4tzZZHl0oCpBy2XSOqa7jWbqY9
         NrkwMAGytNZPTY81teBee0j8cVbY15TAACxL3Y+mvZUCRvq+QP6eyItMPgRu4JwoFjJQ
         sRaZ8krIEZZpfx/txDZa+FfzFL6S5EL/Pvb0M8fiEaZCafyPHGB6EUn8SwMHCeY20F1Q
         qAIQ==
X-Gm-Message-State: AOAM532zVH4R9E/Qtm0r7DTHXdQZtcGX7oEP7nl3L2ezn/314tH5ZGuU
        x15lCgVxuucvB7MpXjIssBc=
X-Google-Smtp-Source: ABdhPJzT2s4BUbfVF0ibXJZuFaWAvgA8sAUtMX0axqPQQcd8lpcMQU7X+4fWs802ydw8Yj9CznwA5g==
X-Received: by 2002:a63:8943:0:b0:3aa:f1ce:4f24 with SMTP id v64-20020a638943000000b003aaf1ce4f24mr22369940pgd.34.1651138393834;
        Thu, 28 Apr 2022 02:33:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:2b1f:d169:337e:6359:8ff7])
        by smtp.gmail.com with ESMTPSA id i66-20020a628745000000b0050d36a5fe70sm15457932pfe.127.2022.04.28.02.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:33:12 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, jacek.anaszewski@gmail.com,
        gene_chen@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] leds: flash: mt6360: Fix the wrong enable_reg in multicolor brightness set
Date:   Thu, 28 Apr 2022 17:32:42 +0800
Message-Id: <1651138365-17362-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix the wrong enable_reg in multicolor brightness set.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/leds/flash/leds-mt6360.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
index e1066a5..712cd46 100644
--- a/drivers/leds/flash/leds-mt6360.c
+++ b/drivers/leds/flash/leds-mt6360.c
@@ -115,7 +115,8 @@ static int mt6360_mc_brightness_set(struct led_classdev *lcdev,
 		struct mc_subled *subled = mccdev->subled_info + i;
 
 		real_bright = min(lcdev->max_brightness, subled->brightness);
-		ret = regmap_update_bits(priv->regmap, MT6360_REG_ISNK(i),
+		ret = regmap_update_bits(priv->regmap,
+					 MT6360_REG_ISNK(subled->channel),
 					 MT6360_ISNK_MASK, real_bright);
 		if (ret)
 			goto out;
-- 
2.7.4

