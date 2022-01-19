Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5244935EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbiASHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352224AbiASHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:53:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E99BC06161C;
        Tue, 18 Jan 2022 23:53:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n8so1411497plc.3;
        Tue, 18 Jan 2022 23:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGTV7k/9KlsGlhJhC3+qf1SZQHZ1AgQDlHwtlaXEH4k=;
        b=MOH7hW71ZmpeZx9L9svAVUI39Zxb9ee4StrNsd8l1x8bkaT3nmmBAByKwhgUXDhMvE
         5txZWDZwHUxWtxj+TD7gCdj09wF2NGzlTZ1h40+6op+ShNYeEehc/yvcHy8WFpCq5uR6
         Jj4ywji08dMAZXfTD5Ufiuv257MxqILe9niXkJjIf64Dc0bniBIYSf0Z2v6Du5rihJKM
         o/rGkDOFSbtrrQMxXm9IX5Uu2OKL/8fLxlwDjYXg7QkhN0+97jgLMsUxJBJpz7BUg7GG
         uL0UWRHXnLAp0uVSJyJ2iukqNKm2RMQzMVcfAc9YAJupIlwymmRPm8556u5xK7VMo5GO
         P81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eGTV7k/9KlsGlhJhC3+qf1SZQHZ1AgQDlHwtlaXEH4k=;
        b=yywep1Wilc8P+Krm3EmmHlg3ARGytsrC7CJaKlcPLbNopXxSZnMoQySoilFqd7jmOO
         oYvBoRXRhB9f3ZO6IU2n2cWYWVuQxwwLlN7tLcQleZoYGY3VMK6aalosyBB3Gv4lxS7x
         4f47/0rWg3Br0frkwIvxCwq1DAVn5/1eEfVYgTLnxNSHszZ/D129f9P6N/RiYZHVX7pI
         NLsYJFVdVqyHn7O1dej7hVIlfqAQF1EaS3o+AoYbwTpaxPM4UDWgLM9piCqLdd+9OpPO
         WumsZm4sfYt7CBqXIcE8Edtf8uYoFfdOMwmDyMskMkY3P9DdPJ+9K8ivgNcPJqaMaJ+V
         c6Eg==
X-Gm-Message-State: AOAM532J7XT8IW36gClgeSDMcY/8FkK8d77rRVtL99ubEeDjvsGHvf6N
        PGYRp7e04YnjAihH+QZRQ8Y=
X-Google-Smtp-Source: ABdhPJyxQtgfpxyIC0tT0W/yuJqQobYoafYdL7wHxyxwLZoeDG5Cob3T8qA2YtoxuTsFGwYeH+xx8A==
X-Received: by 2002:a17:903:247:b0:149:b6f1:3c8b with SMTP id j7-20020a170903024700b00149b6f13c8bmr31984839plh.83.1642578837606;
        Tue, 18 Jan 2022 23:53:57 -0800 (PST)
Received: from localhost.localdomain (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 5sm5378530pjf.34.2022.01.18.23.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:53:57 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH 2/3] mmc: sdhci-pci-gli: Enable SSC at 50MHz and 100MHz for GL9750 and GL9755
Date:   Wed, 19 Jan 2022 15:53:39 +0800
Message-Id: <20220119075339.36281-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Enable SSC function at 50MHz and 100MHz for GL9750 and GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 9ead32d73447..9de3d91283af 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -394,6 +394,20 @@ static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
 	gl9750_set_pll(host, 0x1, 0x246, 0x0);
 }
 
+static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
+{
+	/* set pll to 100MHz and enable ssc */
+	gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
+	gl9750_set_pll(host, 0x1, 0x244, 0x1);
+}
+
+static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
+{
+	/* set pll to 50MHz and enable ssc */
+	gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
+	gl9750_set_pll(host, 0x1, 0x244, 0x3);
+}
+
 static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct mmc_ios *ios = &host->mmc->ios;
@@ -411,6 +425,10 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
 		host->mmc->actual_clock = 205000000;
 		gl9750_set_ssc_pll_205mhz(host);
+	} else if (clock == 100000000) {
+		gl9750_set_ssc_pll_100mhz(host);
+	} else if (clock == 50000000) {
+		gl9750_set_ssc_pll_50mhz(host);
 	}
 
 	sdhci_enable_clk(host, clk);
@@ -537,6 +555,20 @@ static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
 	gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
 }
 
+static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
+{
+	/* set pll to 100MHz and enable ssc */
+	gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
+	gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
+}
+
+static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
+{
+	/* set pll to 50MHz and enable ssc */
+	gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
+	gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
+}
+
 static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
@@ -557,6 +589,10 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
 		host->mmc->actual_clock = 205000000;
 		gl9755_set_ssc_pll_205mhz(pdev);
+	} else if (clock == 100000000) {
+		gl9755_set_ssc_pll_100mhz(pdev);
+	} else if (clock == 50000000) {
+		gl9755_set_ssc_pll_50mhz(pdev);
 	}
 
 	sdhci_enable_clk(host, clk);
-- 
2.34.1

