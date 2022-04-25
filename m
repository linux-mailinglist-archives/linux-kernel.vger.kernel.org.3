Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D858450E190
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiDYN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiDYN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:27:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B733631A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:24:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b15so14781074pfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6Cw8WLv8pPzmwJB6ygB6tlYYVQgUWawXrnLvdPRcis=;
        b=L6z844Bay+7EaVhBAiJc7wExBB0yzLgN3gny+sKbwmZhQKLfEx+WuxQXjn/M1RUSJp
         Mu0CJRdCzM2eZ9rftNqU4uV2MYIbY89u/djlvSrD5bRtTqLYlkvfUa6QLwGd/wkbEsun
         jtbcwgADhqgVFcfooJ0oVxawCX/w7InUAUY0YotKn2W2wxFAwJlmB10zECLPgtyUaigH
         5nxHrPM8eIGNTVU5D23JR2FJSi0eEihp4XFOVdhZRJe2cm9M/dhXhT0JFkrr9/MOwDhw
         XCg6SA10JEdyyrFKTCUbyaVj14doIkSUOTOPXZbc0NwhaZG2LjoISSh1JzfzgF0Wwaac
         GXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6Cw8WLv8pPzmwJB6ygB6tlYYVQgUWawXrnLvdPRcis=;
        b=YeKmmkJqkRHLL2Vm2AyIVU9f0AzLHssmSx85IBOI32BhueHL/1dW+bYL6ghZo8iQip
         IGd8fZrvQ6ITxpZZnchMKfyEBC+BoBVuv+NJES4GePUUdRXvt/sM94AmmlG9TSFwwcrU
         Cec7lVqszXTbwqbU49K+S2GEYwz0z5klYbuPrzXpVvE2nlYNAU6cqIhMP5Zb046PRlqT
         6yuXzgtHftJ1Uuzu62Jah0QnlK3PMAYg2UcA2xujacJZ/+AkJAnwDy6RITURoxxsVi/e
         zKYcw2n2+LQyZaJ27KCcl0u009wv+OdEsXLJCj0yZ82AtG6nRWEaFKMiiZlqRlCjkNgV
         zJ2Q==
X-Gm-Message-State: AOAM531qr7/Tyhf15ZRHGAz7hScMgXiWDK8G39gQLhZd4b8U4fVttXHT
        Ujn1+XhYETwlOoD74CQ1N3w=
X-Google-Smtp-Source: ABdhPJybK5fNYDFZLUGNMHVa4hBMs7rAHzlb1R4XZoSClrLWZqUDbJYctm709zWL3zhmdhdRS1payg==
X-Received: by 2002:a63:8841:0:b0:3ab:3dd0:1947 with SMTP id l62-20020a638841000000b003ab3dd01947mr4594787pgd.498.1650893060819;
        Mon, 25 Apr 2022 06:24:20 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090ae39700b001cd4989ff61sm11381928pjz.40.2022.04.25.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:24:20 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee.jones@linaro.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sprd: Add SC2730 PMIC to SPI device ID table
Date:   Mon, 25 Apr 2022 21:24:10 +0800
Message-Id: <20220425132410.2708304-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Add the SC2730 PMIC support for module autoloading
through SPI modalises.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 55d2c31bdfb2..cf4f89114ae4 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -248,6 +248,7 @@ MODULE_DEVICE_TABLE(of, sprd_pmic_match);
 
 static const struct spi_device_id sprd_pmic_spi_ids[] = {
 	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
+	{ .name = "sc2730", .driver_data = (unsigned long)&sc2730_data },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
-- 
2.25.1

