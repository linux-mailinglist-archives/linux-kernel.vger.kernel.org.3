Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFC753D86B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiFDTek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbiFDTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:34:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025C5133D;
        Sat,  4 Jun 2022 12:33:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so13961278edf.11;
        Sat, 04 Jun 2022 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yvG1yU1Izerfn366VcPnkn//qEws7ZJJNVpImxvz2c=;
        b=RAyzoTeC6BHPdQhVeOefnDlmy+whZ8+lNtIcpNxX8Eb8CsGIhgDDNkNr7NZs9oaf2p
         9LWlNLAT5AOpNcoFlwqnSY9YRGPFF8uENtrfru4kF9CuJTkE/dLdlSQWaN33g1A+OZPi
         9ZReGxqpDpj2XpRZqAuolAPGu8yxR0aZ3PE0O2pyqO4AT4djpe+0QDAGnsZTq6V8BmIO
         TzqXUHfi/qV+LeRr6cf3n1eAmJdVwIdA67vPdhpCmKfvY0kgDTmInP90ut9VwS8PPBfP
         C95gCVJ6y57YodW2W5DLqGYeGwEcSxeI/DKvwFOsyUldEIjJHZga+tZZIkaY3LUDdqKG
         y2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yvG1yU1Izerfn366VcPnkn//qEws7ZJJNVpImxvz2c=;
        b=jeOwKYxaFB0i2o6zsx4NJNiIkG40is5jVa8DBnOiOCn1jIDzaY6sdRxv02uZwTmRNk
         xOJS0YJaXvD4HxNFCtUPqfslZuFR6VfQoUrLl9cqZZuunhBrw9/rJIl9Ae/IFZBnW2lb
         e4EUxSTqvEljZTVSPVip3/Xeqd3jWwCAOypM/yCblzJw49iFwpJbQiEEx6NIDqdXJTX5
         6T6Qm4uNw54EuvOQKaIU9kg1e9Vh7keD+JC8Pn0vQMDHxzKerDu063WzWq7aIWG8frWc
         uLa69dm1WINuA01CBJNmW8ZwIIui36KqLTGm4EbC8cLL196U6+Sc2nQypkdGbf335+Qg
         3vhw==
X-Gm-Message-State: AOAM5305Ho8FDC/ppW1hzmOYYDZ4d7I4/Tdqg5+IgspO59VpCzRqpmZB
        mRVOH/LbJUNA3s9eYlN8T74=
X-Google-Smtp-Source: ABdhPJyeXTH8n96aCRQW1Vq7dQP+rgJhpE9nfCLlEtGyAXv8J8sQFhG2HeeBQZ5KQKUw2UghdfPSOA==
X-Received: by 2002:aa7:da06:0:b0:42d:ca38:84ad with SMTP id r6-20020aa7da06000000b0042dca3884admr17886825eds.125.1654371182785;
        Sat, 04 Jun 2022 12:33:02 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id fi26-20020a170906da1a00b00707d11fd421sm4133802ejb.107.2022.06.04.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:33:02 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] regulator: qcom_smd: add get_voltage to MP5496
Date:   Sat,  4 Jun 2022 21:32:59 +0200
Message-Id: <20220604193300.125758-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add the get_voltage OP to MP5496 ops using the generic rpm_reg_get_voltage.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_smd-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 8490aa8eecb1..5ec68250e79d 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -205,6 +205,7 @@ static const struct regulator_ops rpm_mp5496_ops = {
 	.is_enabled = rpm_reg_is_enabled,
 	.list_voltage = regulator_list_voltage_linear_range,
 
+	.get_voltage = rpm_reg_get_voltage,
 	.set_voltage = rpm_reg_set_voltage,
 };
 
-- 
2.36.1

