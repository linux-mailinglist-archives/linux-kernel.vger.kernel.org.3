Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F9515804
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381333AbiD2WMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381317AbiD2WMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD58DC9B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p6so8212995pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/QIllet2sO5ytIOTpz7N/MbZoymNASzVzoHgwQd9ds=;
        b=WBnS6Imed8MhrDDQe17uOQPPjeD98ZW536sowUSPN2g8mkV7OJudTNICWQL0VoJgyF
         5VGtjG29qgJkdlt34PTo8v2bQnfqXV/ir/a2n51WLugm5Cv3IfZAS8I2pvoueQl9kzu5
         ZFvepRX7DJbxL3yWZKHbCJuc11GX5SFJZjdLNxDSY6Ml/+EONCpmOh3AtY/O272JVG0W
         ylXceMzSa0K6grbwu1kVnV+0vPaqNGmilY0W4YihHPtvxWAxLINBllEh2VekD8MJsL7r
         jAuJ3AFwdoRt/buFmtR+95tcKwcTz2ViaZ9MDYVr3ah7E9yx12lB8ckZ2Gb6HdJ4jvUM
         xzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/QIllet2sO5ytIOTpz7N/MbZoymNASzVzoHgwQd9ds=;
        b=veiUCPJFQtECRGCmkRq2vh77ICrzuZXzsrb3HVYkfZ9QFk2th02SjS3ERsbPOpfmcH
         ad9j1/HD8QGAXBfj/0LQhBZK4QaYBNsUFhPnICPXEiuRKuHSE673M4gVR/Gs4UTB/BDJ
         qrbaJ9Y8wFuBwOFmp+WTX3betmjb1TfFQLB2kUR9fw8LAMmL7ecEUItVqfjREN+YN3ce
         bzLZ8//RCmso6qoYH0fCXhXCOCGOnTOX3MSba2lQRXvE5hbSAMFP6V/lFPY06Azmdo6m
         R+UeCzaAz68U+ZjmZmKqGZtWXPsoJ8CRyhBHwUTRgdJpzJksAIQF9tG2ADmqP/VdO8Tx
         zK7g==
X-Gm-Message-State: AOAM532VWgx6t2mfqIoinIxS55YSLArVYB6P2gB+QsWo7upOYBxh52cV
        WGE9dTr3sT2A16A3NBpw1aCspA==
X-Google-Smtp-Source: ABdhPJx4L3grTpOzugZga8zMWulJpZrYlaCRwuLFI5+l3xNV5xWp+cHtfQ2McKzBWNGazJXnmOc0BQ==
X-Received: by 2002:a17:903:4093:b0:15c:e5eb:9545 with SMTP id z19-20020a170903409300b0015ce5eb9545mr1416763plc.62.1651270144084;
        Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:09:03 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 4/4] mmc: host/sdhci-msm: Add compatible string check for sm8150
Date:   Sat, 30 Apr 2022 03:38:33 +0530
Message-Id: <20220429220833.873672-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sm8150 SoC specific compatible string check inside qcom
'sdhci-msm' controller driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2de8d115a37a..fd8b4a9079ab 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2456,6 +2456,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm8150-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm8250-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sc7280-sdhci", .data = &sdhci_msm_v5_var},
 	/* Add entries where soc specific handling is required, here */
-- 
2.35.1

