Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C879D53D868
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbiFDTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiFDTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:34:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68473515B2;
        Sat,  4 Jun 2022 12:33:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v25so14002169eda.6;
        Sat, 04 Jun 2022 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxKcUIQwb5z9dv1oVEQrVZOBlfuJnhpz8hZ/k9iF5G4=;
        b=RUkawpieX2giKpETRhUFUtrwfwddVt81cvpKoiD7n0vafRc2vU839f2+qW4eXQkusS
         BB7Gz5uSBLKcKdIzrlbqcKjGKaldBKbCaBHeIpCJmPTdqrCzPZRSSIdSwRaGCew61YVu
         e5vDU+JOloXKGci6Hib7fZDpowgDe6z16ymJtWV+iy7l50aAH147DTFlNEbvmxOpnR2k
         7XOzyqcLgeaOFQ+77kEibkk1q3l0xH+Wgi/EOTiKmZ2OhyORZpPnp2ZUnqQ8N2f1udtA
         7XFel9R0kYVP8P6D7UHqXX7IO/4SG1pA2Jcqcg5ayHhYmatXjgFv8Zt1V5fDta0+XBlk
         IoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxKcUIQwb5z9dv1oVEQrVZOBlfuJnhpz8hZ/k9iF5G4=;
        b=43KASJ2DXCKLQrxf7Nuz1uOUlsD/O2oOje0uxybxtTi3uYDhtszFCBqV8uKESi1kAB
         QaMqhWorHxicwt0qhWxgPz5wksvNF7sa8E2v4/t0dNg/kIAGqpWuMX60Zbr6YSYfjA0H
         ao6Fm6KxYoR9Qss9bcLezRki15a8yFC2nI3uLva1V1QUVuOjMCjhF0kXcdDGwpY2BX66
         bGs/X5qlidaPzCNFamPpajjtIKW3mbDkYg4JHPkdBSx5zFPyLuOadTQna+Hc53/+AMLT
         CjU3mHzgiOt0283BnwheD8UWXWuxrLR1mHmrRpwn4FlQpJzkZONyF2d8qRBIqxNPzUZR
         RU/Q==
X-Gm-Message-State: AOAM532m8z43bn/BFdeKfV2aHSviJegRra6zw/0bUg5x3t7LJyTMRPdV
        z/c9e/hlOMHolS0PxTnB0Wea373qUEgBfw==
X-Google-Smtp-Source: ABdhPJw+cz0ALmzikKXwM7MmQi1zQ+anjfcso0JLAyz5teJkI3dlw2NTkVSJXNHmstsydbZvHcTzwg==
X-Received: by 2002:a05:6402:13d9:b0:42d:c97e:f9cf with SMTP id a25-20020a05640213d900b0042dc97ef9cfmr17406055edx.271.1654371183842;
        Sat, 04 Jun 2022 12:33:03 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id fi26-20020a170906da1a00b00707d11fd421sm4133802ejb.107.2022.06.04.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:33:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] regulator: qcom_smd: correct MP5496 ranges
Date:   Sat,  4 Jun 2022 21:33:00 +0200
Message-Id: <20220604193300.125758-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604193300.125758-1-robimarko@gmail.com>
References: <20220604193300.125758-1-robimarko@gmail.com>
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

Currently set MP5496 Buck and LDO ranges dont match its datasheet[1].
According to the datasheet:
Buck range is 0.6-2.1875V with a 12.5mV step
LDO range is 0.8-3.975V with a 25mV step.

So, correct the ranges according to the datasheet[1].

[1] https://www.monolithicpower.com/en/documentview/productdocument/index/version/2/document_type/Datasheet/lang/en/sku/MP5496GR/document_id/6906/

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_smd-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 5ec68250e79d..6c69359b3ef2 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -724,19 +724,19 @@ static const struct regulator_desc pms405_pldo600 = {
 
 static const struct regulator_desc mp5496_smpa2 = {
 	.linear_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(725000, 0, 27, 12500),
+		REGULATOR_LINEAR_RANGE(600000, 0, 127, 12500),
 	},
 	.n_linear_ranges = 1,
-	.n_voltages = 28,
+	.n_voltages = 128,
 	.ops = &rpm_mp5496_ops,
 };
 
 static const struct regulator_desc mp5496_ldoa2 = {
 	.linear_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(1800000, 0, 60, 25000),
+		REGULATOR_LINEAR_RANGE(800000, 0, 127, 25000),
 	},
 	.n_linear_ranges = 1,
-	.n_voltages = 61,
+	.n_voltages = 128,
 	.ops = &rpm_mp5496_ops,
 };
 
-- 
2.36.1

