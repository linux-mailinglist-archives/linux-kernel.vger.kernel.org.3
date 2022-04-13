Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001714FF5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiDMLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiDMLke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:40:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D558822
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v15so1970100edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RsCT0+H3Evp2pw/6AUGDU0mA0FIE163HBKTFYOpVTk=;
        b=YTex7apl5fRj0QTFhN8XZ8gjLXHbYSuxxG7QpUKzu4EszwI1I3vWKugOKEdiJMCruP
         JWEylSK18hobJ8LloQXX4j57PRR8cPz+Ess9N4XGVzXowMulwyjet20sWAefzXLsNOnh
         ECVn/umamp/CZtpvx428GuQcW7vEypQTJAM0kJXunmq9Zq2b2V7TJeQavZEi/pZXEpON
         LI6uAexxMTE6OH1p27vqtofgDgPTRt2yQplrBeT1TbskkPQKbptcgVAiDMEJsNHzvzF5
         F4UcelCOK+buy8ikGKdccsqH+1y1WXqxXMmL31eEphLu2Yy/XzSShlKOWEJ9/eD7PH2Z
         iz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RsCT0+H3Evp2pw/6AUGDU0mA0FIE163HBKTFYOpVTk=;
        b=l/2V2LT9C1383g82WgmuHfQOhxb+dm3FB0nV5UvulSKliC3uCF0ZBqiw3RJnUJcFg3
         APrgQTb2ADn3fFgm8X5sJoJHdcBg4Dv6xn2nTGZFD19gIOEkrVbZkRCQJPVQqDjLMxzO
         YZA9BnWQoeTUD+2erz0+IQ4jihq1801j+KM03i4y9Yj09U7uiTybFu7S1KndmB49DvQK
         fU8p3Ici/vKwDUX6HR10L/lMxp+Xdbjn1CPaIPFfXmsBdS4eja6Gp3ccokrOtLp6uI//
         HntrNvQhgF8f6/m72xmki6KzOGRTe83bg/7rHnNf0idm3F/OXURT64zTSbbHvGUvdwFR
         +RvA==
X-Gm-Message-State: AOAM533iR05Q9prMTqhES27KPf32oWRD9hNGADn6SLG4ExlDQbWDMxcD
        XhPLwT+UuBOOhXuvXj50/osXXg==
X-Google-Smtp-Source: ABdhPJxLfttImPqo0xPL/hs3UL57c21Q1w0uozJT+/KDO77ktTP2llbqZc/OLp7dpzYCA1xJRX9ZMw==
X-Received: by 2002:a05:6402:3489:b0:419:88f0:4bcd with SMTP id v9-20020a056402348900b0041988f04bcdmr43677265edc.401.1649849892211;
        Wed, 13 Apr 2022 04:38:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b006e87e5f9c4asm4452783ejb.140.2022.04.13.04.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:38:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 1/3] nvmem: bcm-ocotp: mark ACPI device ID table as maybe unused
Date:   Wed, 13 Apr 2022 13:38:07 +0200
Message-Id: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

"bcm_otpc_acpi_ids" is used with ACPI_PTR, so a build with !CONFIG_ACPI
has a warning:

  drivers/nvmem/bcm-ocotp.c:247:36: error:
    ‘bcm_otpc_acpi_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/bcm-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a8097511582a..dfea96c52463 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -244,7 +244,7 @@ static const struct of_device_id bcm_otpc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
 
-static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
+static const struct acpi_device_id bcm_otpc_acpi_ids[] __maybe_unused = {
 	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
 	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
 	{ /* sentinel */ }
-- 
2.32.0

