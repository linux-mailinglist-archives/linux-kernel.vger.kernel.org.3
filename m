Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B1565EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiGDVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiGDVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358510FE1;
        Mon,  4 Jul 2022 14:24:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o25so18554813ejm.3;
        Mon, 04 Jul 2022 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=eDfKHqF7WgMDLnMzwKT9v+qjyy7+6NXb0LduS9SI6XJFpxmCnK4VDAfp+a5Ki9YyX2
         DZuSwtyd6EKS0YOWkDO3rD+Gbz3LqeMSdch8YKUYJmzMWPjf8QBD9XkUz/uPhmQdj+IV
         C1ehkacW68jylA5X/K0jEvK6F2q9MRaNqM4RMw60BjBpUa1J93KzIQAmJVwvWE3QenUg
         ZB0CALBFFJoKzr88aHUOOmJYz9C9zTmE1S6yLIUh3xPLHMkf7tbo66ry9pkaSY/wbQ4S
         0KmnVF+tJRvvnrDnZNSs8tcnnbrPekSPSf0/h1WKCfbPzFQh2+pgKJlgwKGanVl4eJUj
         eTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=Uy3ho7iAqpk0uUzgRVjgwIBI1fEVKxQCzDQqlR7nh92E9EQ81EuYpvAvurqPydzxdI
         iyMjHs+96jJH6MaNkW5RDB3w20V+bWfuKx56+yymYUsNPb8/GHvkq7sQ+kxAcInc8/vq
         T/YzyAHTHw9X360Rv/R3ujwe4XbtEpa+7TCg+qQddfs3f4mnqrvO4d6y8MVjjtU5gKKp
         2KyQEMkOTga3bkH2n8FL3jBbjllt1lV8G6fYH2wZ7EOHzag6J1ryjnLXqX4HSXngBwJ7
         iuxo7O40w0tLkYBswA5c3P1ITr+wR6gtJA4Cw977QovbnHbbcbM6CpD0mqrhVy4s3Acb
         UCAA==
X-Gm-Message-State: AJIora+LdIxFqYCsf6BLQ93oeQZ30hS1QORDLUch5O+p8hrmTfXVd5O/
        c1IORQJeA53eKS27UpyLU44=
X-Google-Smtp-Source: AGRyM1uA8oVogKLtZbQYNp2tti8JJkbZ6Q0JKYCXcnMCO7CVL66lqNTCM1pSUHOHnMxnqeCuPNigRQ==
X-Received: by 2002:a17:906:4fc9:b0:726:f4e4:88e8 with SMTP id i9-20020a1709064fc900b00726f4e488e8mr29857071ejw.57.1656969849150;
        Mon, 04 Jul 2022 14:24:09 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 04/12] regulator: qcom_spmi: add support for HT_P150
Date:   Mon,  4 Jul 2022 23:23:54 +0200
Message-Id: <20220704212402.1715182-4-robimarko@gmail.com>
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

HT_P150 is a LDO PMOS regulator based on LV P150 using HFS430 layout
found in PMP8074 and PMS405 PMIC-s.

Both PMP8074 and PMS405 define the programmable range as 1.616V to 3.304V
but the actual MAX output voltage depends on the exact LDO in each of
the PMIC-s.

It has a max current of 150mA, voltage step of 8mV.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 02bfce981150..38bbc70241ae 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -164,6 +164,7 @@ enum spmi_regulator_subtype {
 	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL3	= 0x0f,
 	SPMI_REGULATOR_SUBTYPE_ULT_HF_CTL4	= 0x10,
 	SPMI_REGULATOR_SUBTYPE_HFS430		= 0x0a,
+	SPMI_REGULATOR_SUBTYPE_HT_P150		= 0x35,
 };
 
 enum spmi_common_regulator_registers {
@@ -544,6 +545,10 @@ static struct spmi_voltage_range hfs430_ranges[] = {
 	SPMI_VOLTAGE_RANGE(0, 320000, 320000, 2040000, 2040000, 8000),
 };
 
+static struct spmi_voltage_range ht_p150_ranges[] = {
+	SPMI_VOLTAGE_RANGE(0, 1616000, 1616000, 3304000, 3304000, 8000),
+};
+
 static DEFINE_SPMI_SET_POINTS(pldo);
 static DEFINE_SPMI_SET_POINTS(nldo1);
 static DEFINE_SPMI_SET_POINTS(nldo2);
@@ -564,6 +569,7 @@ static DEFINE_SPMI_SET_POINTS(nldo660);
 static DEFINE_SPMI_SET_POINTS(ht_lvpldo);
 static DEFINE_SPMI_SET_POINTS(ht_nldo);
 static DEFINE_SPMI_SET_POINTS(hfs430);
+static DEFINE_SPMI_SET_POINTS(ht_p150);
 
 static inline int spmi_vreg_read(struct spmi_regulator *vreg, u16 addr, u8 *buf,
 				 int len)
@@ -1458,6 +1464,7 @@ static const struct regulator_ops spmi_hfs430_ops = {
 
 static const struct spmi_regulator_mapping supported_regulators[] = {
 	/*           type subtype dig_min dig_max ltype ops setpoints hpm_min */
+	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
 	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
 	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
 	SPMI_VREG(LDO,   N300,     0, INF, LDO,    ldo,    nldo1,   10000),
-- 
2.36.1

