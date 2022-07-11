Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA6570C03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiGKUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiGKUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8B4D83E;
        Mon, 11 Jul 2022 13:34:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so10743642ejj.12;
        Mon, 11 Jul 2022 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzY2lLT1/+M7Tlebg6E3uD74NSlb4eEU7B73WZsDdYs=;
        b=ons8OxekqDhdDCLGvUmxYhlsPKpZ2xzlsGd/U6KZDW7QF8CYcQ6LNKfScfclewtkPR
         FbMkzYjucVH6W8WORTrQOQLaah1tl0Tf1C9xyMI91hyQGS26p/A3JXROd6mSvnRP9d2N
         +VQ/oSaE+ZrNobUQgeBIE5yVoSJEVOL25b19TABP3e9mpyeOsL8hUTtBj6hKOkG+U53x
         CqBcFD5TUTzyTbbIgIvJUCBkTyCRvXUuEq7cGKgj1WOPX4rPWqtzHHX/kUImsjm4vzWa
         nT0/TvlSw4AW1mlYjc9piGgEqpFz84avEfKIIfeLPnoJczwtSseo7aeEvY8zJ9rSmVCV
         HKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzY2lLT1/+M7Tlebg6E3uD74NSlb4eEU7B73WZsDdYs=;
        b=NN/nA0+VkE+02L3nzboSilEl/opuBTbfS8UxwhZbp/BCdKlfCkds78e6WPnr1dV1+p
         Qdr/E2RCc13CJYayPFUnKSJJMp7ngGq17E9U3ErCvAW725/qMLWjVB7VC/dXCTs0Nz/U
         OZ/3rigcGgmHj9oPTk0BiFTWw/YVTRRQjbk454ei87rcYAZhVihPRXL3Dkg97+bJE1Sl
         x6HW5O5s3WW8NeASRaE6LlTOe0DKhkUFR/I/FbfNdkV1eoCaj8AjYRLFVzIGYvJ0xCyU
         nkLNpm/USZeM5rW7/Ib1coC715/mCFNVfkj17UyoCWrhIzRNhMeROhB4IBVoRN9zfeAQ
         h1sw==
X-Gm-Message-State: AJIora+D9dKqz9vWjpUb15rLYkvCmWYlHy+Or9kEfF72mjYiYHBnB5ts
        BWSQxn6yVgki+/9Jegu3tV+958rzlAYjIg==
X-Google-Smtp-Source: AGRyM1s7ke9v5iAiiAH8yzp/kqP4tFX/5B8qaAQnDhxKuu92KvXyxHAzvYeX47dFIwIgmUevCWl5Og==
X-Received: by 2002:a17:907:7811:b0:6ef:a896:b407 with SMTP id la17-20020a170907781100b006efa896b407mr20602627ejc.645.1657571655765;
        Mon, 11 Jul 2022 13:34:15 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:15 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 4/7] pinctrl: qcom-pmic-gpio: add support for PMP8074
Date:   Mon, 11 Jul 2022 22:34:05 +0200
Message-Id: <20220711203408.2949888-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711203408.2949888-1-robimarko@gmail.com>
References: <20220711203408.2949888-1-robimarko@gmail.com>
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

PMP8074 has 12 GPIO-s with holes on GPIO1 and GPIO12.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 6f04186ebd09..406ee0933d0b 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1180,6 +1180,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
 	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },
+	/* pmp8074 has 12 GPIOs with holes on 1 and 12 */
+	{ .compatible = "qcom,pmp8074-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pmr735a-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmr735b-gpio", .data = (void *) 4 },
 	/* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
-- 
2.36.1

