Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9769F565F10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiGDVYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiGDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9A1181F;
        Mon,  4 Jul 2022 14:24:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c65so13049307edf.4;
        Mon, 04 Jul 2022 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIa9uRxXfloP6LkJCYKSY6LlyEe4ZLWO3jSm59Xwpnk=;
        b=F1QSNH79dLgNP/6WYXYGY8G160qYTl/vmjKH6G/1Pywa1xCc5rTpMpq/b+TuToOiPo
         po5pRf0PG1DN2RWWUo9gH3YcSaayJZ0PMc1klbYCNgzmTuUcURxl/TrVmKVCBWtZG6GA
         aqI6EXVZVx9duGvCBhMMwt9lUxvx3aaVCwFwXVMPKE3HfnH/g/btm7z9ijKWUeY3+ngz
         NIixMpYnPcoId96a5t3pPfCzU4yTHmJuugT8AWKBJjemtDX/edBjr4IkokyurvQYDFCd
         MfYde3sXUST4d558xAOyxAlEPBVBdpogr5yOvoowqVoGyi+R+MYUJ42Bj0KGarT27nST
         ITjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIa9uRxXfloP6LkJCYKSY6LlyEe4ZLWO3jSm59Xwpnk=;
        b=OxVqdIDjY4k+ZRQo6DF1knooN7GqPXW/raUewuga6lq2lKAXZJhpZfj3luy+96dYcW
         ZSHmdTlVM3zQJ1PM02Ye8BsEXn47k0lMzx/CTDE5edVTn6E53Vz9vH8TLxdCAIWH/sAI
         d21u9LtVOb91RL5P9i7TEFhAYUC1uWlJZExHDyBbf0G/CooeDvbFqHMmVEzU6GQd95FU
         Wx/8sWYKMIWnmhkfC5uXLNN1UDxKSJ4xMIIIpLv52SE0yiBeqm30w6gEWDxUDbc95Bsk
         EiWBOc8CZltn6Jm6rwqWRY3QGkCPCGd2nRgU21SclPdRp5IUurmrJ/u+c08XMjut3b5l
         N++g==
X-Gm-Message-State: AJIora+eNXRvEj/PivDOiKIA39ME95Gxii0UUKMYVtf+CcyYHdQ250wX
        tHWMS2puqs4UqQNtAhnfiOY=
X-Google-Smtp-Source: AGRyM1uHkDPLNtow7mlHuT3vEsm6WqDkMh7IiFO6vjhr1yvn1SGYHeKxZBdSgzpbEMCUnq/V5KUNhg==
X-Received: by 2002:a05:6402:40c3:b0:439:6b72:483e with SMTP id z3-20020a05640240c300b004396b72483emr29020472edb.154.1656969855036;
        Mon, 04 Jul 2022 14:24:15 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:14 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 09/12] pinctrl: qcom-pmic-gpio: add support for PMP8074
Date:   Mon,  4 Jul 2022 23:23:59 +0200
Message-Id: <20220704212402.1715182-9-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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
index fd5fff9adff0..c3255b0bece4 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1178,6 +1178,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
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

