Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0F52AD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353059AbiEQUx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349048AbiEQUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649AA52525;
        Tue, 17 May 2022 13:53:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id en5so497547edb.1;
        Tue, 17 May 2022 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=dnfV2lEMAJvt9PTHFMClEM3ysANSw0wmI3otp5dX9UE6IDvmwVuL6Um0pomrixk9pu
         4+Gpx09w7mj40CkxZzPgc4BSmJZOTxTIv24mO6DYDPMBN62BieOS6mAf2yUFxR/uz6HE
         kmUiOWDSEV7VrgGW+mjjkW1SRG/N3XuOZjRdoCjSxv0MuDl68XrOFm3ygBMz8XdV48vn
         sIZKvJ9kU71FbMO3t/SLYPkbvrzBbMH+raenZ2HFSj5ZD+u93oQXXQA5qYI5AusDg//B
         gz4oa+FzWJZ/CMFjBHf9wRG/Bp3BR4LN6i9DWyZr3zxrMgN9t8RYqlJPVthF+Sqf69jL
         qH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIDUTK5KnimKV7JPutWUmQpjQBhC0JH0W89/0KDYnjU=;
        b=x5qlD/O3NF/bQrZp4SyNR5mozOk1KeNbwU5euWOMNw9Ldt/K+dE9f0um9YdzMRskAv
         sInEkJci2BoNAd8BKGwsB3oGVuGwyaRsVYDs8OlYypovShnaaVEjmA7s6VqXIWGtSDVD
         iE67Y1pOunLUVy8q7CMke/tSl7pK8AgpTmjwrgLbH3jfDTmHbFlhFyhA9v1zOK3IC19K
         Avb6eRKM0Y7wjF0pZwS7yHAOADVlGKzmAJiWBCmR5QcQXOiFJahJuU87dE5aQmAV1eY3
         95vpl3L0GbU0Wl294RWVMIfKcETKzjfuaGVvEqgcrhdGYDPKfv3JXf/Xu39UXIjgTyG5
         dAuA==
X-Gm-Message-State: AOAM532t8a69o8ohEB1Wtt5j7JMw1/96888GsywpfkNJKp489/zIhOGI
        l+ysJfbjg5QtuFj0ztSxM54=
X-Google-Smtp-Source: ABdhPJwSU25nMkZvKYNpJMBeL918OVrbpKUFyyYPBgHWoEGWrLBnTtQFq2fi7hyN1XwiX7Du2H02Tw==
X-Received: by 2002:a05:6402:3291:b0:42a:aa4e:fd71 with SMTP id f17-20020a056402329100b0042aaa4efd71mr16276143eda.74.1652820826895;
        Tue, 17 May 2022 13:53:46 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090651d600b006f3ef214e10sm120907ejk.118.2022.05.17.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:46 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/6] regulator: qcom_spmi: add support for HT_P150
Date:   Tue, 17 May 2022 22:53:37 +0200
Message-Id: <20220517205341.536587-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517205341.536587-1-robimarko@gmail.com>
References: <20220517205341.536587-1-robimarko@gmail.com>
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

