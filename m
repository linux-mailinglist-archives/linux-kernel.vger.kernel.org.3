Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489BA570042
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGKLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537E2C6;
        Mon, 11 Jul 2022 03:47:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3227523wma.2;
        Mon, 11 Jul 2022 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5sGBWR3FcOu4ndXXLV8wh7OA3cFA3qO4dsqfXS0h5I=;
        b=VnYosmynBfWs9+TJPlHzLVo72GL81mwWTvIHpkPGK3PuW5FAGZmSZNt23w93R4VlTC
         75yGRWWB1tGI5SXEHh5wpX3Hd4gFI57qAjCg5lPdl0bWcYCAkrlPQDu3DcsJ6lftmedE
         PgA7rZnqnZ7r33a1fHZ9IquVzgPgNs2allHECbsMSjv9FYSYFrPvot8jY6rdDx8oK5xg
         AmwgOvcYrW9iM2iwFg1YdcBUbvrQJg5ymwY3AD/zzd9b1cz6HgjVnVjdoOVpiwQ0dQCl
         MWAfvYqIdllSlaphVYgDS0ly9WNgCKneMnj9sboAoBnvzFeH2FJYuTM+/qlN719BKCLV
         qntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5sGBWR3FcOu4ndXXLV8wh7OA3cFA3qO4dsqfXS0h5I=;
        b=eCq1l8LnMcmkTcROtACTnVd6hqhV8GR7JiBI5bbd/bSQFjKBR4Kv6Uxj61dtLIhfjc
         1/wAYEKmaVoqxXzjFKw8D2wcO/Dh4Pm1peAvmkUfHT/8aYVBlV2CdhIlDTKkssNyLind
         DrEgoM3sd6E8V/g9OzWU91Snla8hpW9e3HhINUpBzxzphu2tfDKN9HiFFtLvUeKJqTDc
         4yESrZyvp93CmHM27cjaaOF0CsPhbZhqLbcfSS8kJZjXYWhdceEPlKgucE7sFeyXgSvc
         sXUr45J3AgF/cFYDeTWG8bdwwkKWHzvwqIf5VTJH7XSKVVhNXmtfsibz5EeLdkkb6ePM
         iYaQ==
X-Gm-Message-State: AJIora8XlpOsol1EcH2wFA9K8DE2lm5Im/Q3PK7xiGOJFuo5atKgT2MX
        DaWMQIC0qQFb55MKV/NUfx4=
X-Google-Smtp-Source: AGRyM1uNSae1ihMNFCVWStempFNQyfK+UljgmR1EQz26ytx0ZKRpwy9lhteRL/+81izNWyEwztoRTw==
X-Received: by 2002:a05:600c:40d5:b0:3a1:8d0f:db47 with SMTP id m21-20020a05600c40d500b003a18d0fdb47mr15314533wmh.138.1657536448283;
        Mon, 11 Jul 2022 03:47:28 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:28 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/6] clk: qcom: apss-ipq6018: add MODULE_ALIAS
Date:   Mon, 11 Jul 2022 12:47:17 +0200
Message-Id: <20220711104719.40939-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
References: <20220711104719.40939-1-robimarko@gmail.com>
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

Add MODULE_ALIAS so that driver will be autoloaded if built as a module.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq6018.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index f2f502e2d5a4..963c69f2c0c2 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -101,5 +101,6 @@ static struct platform_driver apss_ipq6018_driver = {
 
 module_platform_driver(apss_ipq6018_driver);
 
+MODULE_ALIAS("platform:qcom,apss-ipq6018-clk");
 MODULE_DESCRIPTION("QCOM APSS IPQ 6018 CLK Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.36.1

