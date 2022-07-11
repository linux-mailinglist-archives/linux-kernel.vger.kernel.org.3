Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B8570C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiGKUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiGKUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593E564C0;
        Mon, 11 Jul 2022 13:34:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k30so7676657edk.8;
        Mon, 11 Jul 2022 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqiavdIdz0WglHiL0//S+IRPa684ukWZUSuGgmCMvLw=;
        b=RbPfgeXyJ8IJUjU2gjJTYA7IHBKa/nsqtIoP93fgCsWscMMVmNDxmpaULjGjTvCvae
         gTbJTymQ5RHvGFO5vytE79c5jSut+vihkWHVNVGCZgP3oN5hR3W1r6V6HTqbs9CGi71i
         yFS51TNASy4SqYBbeHe4hge+6iXHqRT2Uh/ALRQxgSYT7TooACuzA+9F5BgaMyuFVbjO
         OXg45jB7xl9yqT9oLtiPLb+LD4VIE6T5uHRGSC0ulcNVY4u58ImE28xXBSAUM8wSVHj9
         Dz+Y1ab9ErP1hHEU/+PPgRyOCzgH1pTYaUF6221BlLnKxFYpGGqZpqaLIffRs6/8feT9
         vM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqiavdIdz0WglHiL0//S+IRPa684ukWZUSuGgmCMvLw=;
        b=cV76JFqzjeH37mu6cODnQNcxCtZ72X4G1v+IyYnrPcooBbnBlOnpXmCAp/MIaRpc4Y
         0zgMKnjeVEAnC+Z1O31N/T0lJ2Igt2A7/FBDPvHcAdGgeZkwotisADQdqeE4T0xHmdBE
         DK1pF5pTeKffkoktyiNw9T46q6eYm8yRynOgbsRz+HXZL9tFXjY6GQ+A8GchJQdawzi2
         nE4Ie6nHWhxZc/Gjr2N9c9Q4osickQ6PpFzbPRDzQ8AfUI1hKBNJgOZWKQZ7BqBGt+hE
         Bjs/YbKLeVIbagmYKLmttP2uWoEYXXSyjDwzuGvzCy/Fuwj5Y+0yB0DAkf6gPWKh+JxF
         ea7w==
X-Gm-Message-State: AJIora8GOe7eRygLZmWcPXsklyqCRtXag1LK+6QRkLBR77JKTV41d8WO
        kloHSQwrhDSVaSMYKe0eOBw=
X-Google-Smtp-Source: AGRyM1s4exHJYG3Lt97GJZk1g8XzSyyonjo0Hrk5gA+G6ozpUANsD860h8VaGEJNWbOwMYOr+DtT1Q==
X-Received: by 2002:a05:6402:40d6:b0:43a:cc69:1db9 with SMTP id z22-20020a05640240d600b0043acc691db9mr13048073edb.380.1657571653240;
        Mon, 11 Jul 2022 13:34:13 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:12 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 2/7] mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Mon, 11 Jul 2022 22:34:03 +0200
Message-Id: <20220711203408.2949888-2-robimarko@gmail.com>
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

Add support for PMP8074 PMIC which is a companion PMIC for the Qualcomm
IPQ8074 SoC-s.

It shares the same subtype identifier as PM8901.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 00003a868d28..7e2cd79d17eb 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -60,6 +60,7 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,pmi8994", .data = N_USIDS(2) },
 	{ .compatible = "qcom,pmi8998", .data = N_USIDS(2) },
 	{ .compatible = "qcom,pmk8002", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmp8074", .data = N_USIDS(2) },
 	{ .compatible = "qcom,smb2351", .data = N_USIDS(2) },
 	{ .compatible = "qcom,spmi-pmic", .data = N_USIDS(1) },
 	{ }
-- 
2.36.1

