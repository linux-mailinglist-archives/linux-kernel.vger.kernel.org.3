Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FD565EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiGDVYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGDVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CE10FE3;
        Mon,  4 Jul 2022 14:24:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fi2so18513377ejb.9;
        Mon, 04 Jul 2022 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+4K6FS88GjWRG2vNTzrV4fX3yhY0zamHKZ1oi+4NJA=;
        b=UcNupKVE/BgJZhTDjB1BayRPSArdq+tq58bYK/NxpM1FjQvGIAQpcHxEp1TadSMglF
         b7QeNTZNB3tVcoozfEVRqtqZYKHPpwhMLFKxfcsbGoSxrL0VNzGGXlOBrG1VtDgSibkU
         s+JRyYixVTrz8WTJ/2wk08YNSQSl3yMIeBl7+2pV6gMWNCfRtj/j46JnfUs4yBM/tOX5
         9OWZi9UAAH0gIhOBau+FQVhKDinXDova9a/79pGwb25YsNqXo5sG3O2uOUaoAXY5wM65
         uguKWF0QEJFbym1JOWNW2yP+vS5GBunc37DtFDQvgv77OkJyenhfew3cCX7yEFmp90UN
         qsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+4K6FS88GjWRG2vNTzrV4fX3yhY0zamHKZ1oi+4NJA=;
        b=J982aUtrDUG12QITYLBMxX848ggghe/Jb7U4FgYJqoUxRvwpdDdmo7q2vv2XNLd1Om
         JMJvv+w11gwdOskc13SAjqnFA0lS9lWRnag171i/xuQ+l6SVZKQe3t3Qec9d0PLaeVux
         8jd9ua+Km1hh1TTz6ipiuLRXCfnibWCSdDBMR2uKrw6f7iFktTlkeLIYjaGZyvW86Vkv
         nv8xvrlY/HVT1Pdx0YG96JMeHR/KGlVVp7SkxXbzq1ubsSuiLCw/4LXDjFtRXnIwdK6h
         iCU637ON5AQM55OXJC41H3JCeiyL0IBxGxhSAV6N3yO3efKZk9WjP74GgqVMnAZ+QCkD
         q8XA==
X-Gm-Message-State: AJIora+GLV14tCZ6kT3Tm5H2ipoHBhH03y1v1nJKIRupZDjXyTjxk+w7
        Y+HmsLudVdT/FYsKCwAxn17zzzwBPnpFJQ==
X-Google-Smtp-Source: AGRyM1vvujxbLUAyHmDHtU/L5L9BdISJJVTcRoGxA1SYv1leKWG7HqHCFRGd5nrc6DVrHr5MFaK1Sg==
X-Received: by 2002:a17:906:844d:b0:72a:932b:b467 with SMTP id e13-20020a170906844d00b0072a932bb467mr17537368ejy.250.1656969846726;
        Mon, 04 Jul 2022 14:24:06 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:06 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 02/12] mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Mon,  4 Jul 2022 23:23:52 +0200
Message-Id: <20220704212402.1715182-2-robimarko@gmail.com>
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

Add support for PMP8074 PMIC which is a companion PMIC for the Qualcomm
IPQ8074 SoC-s.

It shares the same subtype identifier as PM8901.

Signed-off-by: Robert Marko <robimarko@gmail.com>
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

