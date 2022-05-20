Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0152E702
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbiETILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346833AbiETILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:11:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DC57B03;
        Fri, 20 May 2022 01:11:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v11so7153525pff.6;
        Fri, 20 May 2022 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D6j8CG4wAttV/yAKAZ15WeKE5ykR2+FoJ/c9XSjWvY=;
        b=UwoIWhyCGRR+ITUai34luAHOCkbCRrMxfoq5DZWqZPVv77ojBE9pno6+Wv/vMEA7eF
         v69KyubsrRnMswOrJ4eAX+PjjarNipZwL19uQrifqqz6L2a+lI/xk7W2/fYKdWCEZEGA
         g1tUy+PRquT3oDWe4fxYJAr/HJmapzDun7DeZRp0UVGwMspZr7YPYlijvQRxK4MaWukl
         Yc23DLAcSMf8zTupRi0txPyTmAbC+KwOlFwsjWdFyYzsAJzaJkMQJN/QdKoY1lne+cHQ
         pTAgrgJTwaVyufWsIpX3akaB5H1/Yrvrwl2a0fiEuHeJM8hUrP7LCw3lUPkxa5a8Isb5
         8mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D6j8CG4wAttV/yAKAZ15WeKE5ykR2+FoJ/c9XSjWvY=;
        b=sdbuvOoMPxdwseyyFsc4D3fuigZfBiBrx6lPVNcVTDRtiN5OSwqguMhN0slXvhsuD4
         8NgyjHS/KZdGebxESibEszfwBcXJVABS2uuVxADsrossADxrjTmw2PVv+Hdg/ZwvhkDX
         NpjLSZbfvY1HHTCM8s/AhdngNiik3VIxwkyGfj3CZbvZ1WBCqljZZXKIIhYQLvVDyulg
         i5/tQBYOx/fSEt6/SE2A+Z+NJ9e9cU1AkRtAg+O8Bg5Pad16ZyyFoe/pDNpNsiPPmLdG
         66E6aqkNZIJSVsNGZwEhZvx9POmwKmVpUVEzGjuzN1CPirq/ujbK1BJnIsawfQauMOah
         C/mw==
X-Gm-Message-State: AOAM532q/BRSfOwFF4NWSbtELe+4fIap+XghaQOjbOMLxrMu7mAt/4Cw
        18pj0czcj8+qGf8oEAHIEtw=
X-Google-Smtp-Source: ABdhPJz8tD9PSGaThd46JCD3oJZtBhfEh6uYSkECowQnsl/6K8z6H4dnzDmBtgDQiI2O5ZzdGSUw7Q==
X-Received: by 2002:a62:8206:0:b0:518:3c6a:21ba with SMTP id w6-20020a628206000000b005183c6a21bamr8203596pfd.63.1653034298762;
        Fri, 20 May 2022 01:11:38 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090a3e4900b001d960eaed66sm1161908pjm.42.2022.05.20.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:11:38 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     andrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw,
        kana.chen@intel.corp-partner.google.com,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Fix GL9763E runtime PM when the system resumes from suspend
Date:   Fri, 20 May 2022 16:11:20 +0800
Message-Id: <20220520081120.143927-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.36.0
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

When the system resumes from suspend (S3 or S4), the power mode is
MMC_POWER_OFF. In this status, gl9763e_runtime_resume() should not enable
PLL. Add a condition to this function to enable PLL only when the power
mode is MMC_POWER_ON.

Fixes: d607667bb8fa (mmc: sdhci-pci-gli: Add runtime PM for GL9763E)
Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d09728c37d03..d81e5dc90e15 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -972,6 +972,9 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 	struct sdhci_host *host = slot->host;
 	u16 clock;
 
+	if (host->mmc->ios.power_mode != MMC_POWER_ON)
+		return 0;
+
 	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 
 	clock |= SDHCI_CLOCK_PLL_EN;
-- 
2.36.0

