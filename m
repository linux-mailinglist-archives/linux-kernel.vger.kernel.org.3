Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71F4C4509
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiBYM4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBYM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:56:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630518E3EC;
        Fri, 25 Feb 2022 04:56:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m22so4734871pja.0;
        Fri, 25 Feb 2022 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1LY+l/NhS0rChpc29wsrXNSMavIR38WPUl22nfsuvU=;
        b=FBB5YaQVsr71kHT0ENiNVfU6OGDF9TnfU/WMi99/CQy2hlG2Dt3C5HYlCbJayyf8pN
         31R0d+ffI7YqRmEuza3CVfzYWXXUviswU+cTgIOzoacn54iyWfrS9wPls3WgehdztAFD
         lT8JTA27ZfsRluDBwHoeCWgbk4/3RVqmz6sQx0Ldzoap0XzaaqINL/h+mzM98O4TOp1U
         7WcC1dj0PYaeY5kYQ8pDr3xv4emVha3Z7penypSX8o5QKnZw1YHtc4cIepLXDoG2kYs0
         X4KA/PwvK3Gz/inZ9ewz8dH3zb1Pd6eCfywRXdJKlyw3dhPxRaHuKwHP74jtiQLtM+WW
         NtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1LY+l/NhS0rChpc29wsrXNSMavIR38WPUl22nfsuvU=;
        b=pjUwk7ELEMzfnYs0XxqezQFep+CyaO14DCw6/FpDIQNC/laWzz3dRIiYysR1uCcI+C
         AX3kLGWdunF4xVzPW8BP/DVWejDzohPNSJr/3+JDhtE0jYYe4w5+pVP0viSL/KtvNZZZ
         xqyFziyUkekn5J80riAPJXGxQe0lpkq+u7Dq/YbEVUtj6sXuXmjKrdtgkh9I3Pesb6+S
         gzWw5omb5+C2cb5t5ZsBwJ3qi/QnW1Wvsmv/pI5EI36WHjeOx8cNkY+2bRrje1ArC8m7
         CFNDqMfQ/wlx4wadaZptu+St7A3QbrfME7l5kQ0Uy+0wrHNPRdgSL95j9G4FlUwrhk+W
         Ojng==
X-Gm-Message-State: AOAM530hxhM+XpFjD3xD2jOF5YUmRTFPSLda50F7kFx85nc1/MZLNdaV
        +nnOcFKmAB9mgK+Kcx3ePsDFvd3ZJV8=
X-Google-Smtp-Source: ABdhPJyUW+a6X5XbT5h4hQJEf0D/i83NGP8nBDY3RWNGq06Z/4zWqK37bO5KcYC4lhf/oIbYMsKGjQ==
X-Received: by 2002:a17:90a:6c8f:b0:1bc:f040:632c with SMTP id y15-20020a17090a6c8f00b001bcf040632cmr2791249pjj.215.1645793768428;
        Fri, 25 Feb 2022 04:56:08 -0800 (PST)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm2994660pfe.186.2022.02.25.04.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:56:08 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
Date:   Fri, 25 Feb 2022 20:55:52 +0800
Message-Id: <20220225125553.1185108-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
gated of upstream port can be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 97035d77c18c..cf99b6af792d 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -873,6 +873,55 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
+#ifdef CONFIG_PM
+static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	struct sdhci_host *host = slot->host;
+	u16 clock;
+
+	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
+	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	struct sdhci_host *host = slot->host;
+	ktime_t timeout;
+	u16 clock;
+
+	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clock |= SDHCI_CLOCK_PLL_EN;
+	clock &= ~SDHCI_CLOCK_INT_STABLE;
+	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
+
+	timeout = ktime_add_ms(ktime_get(), 150);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clock & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: PLL clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			break;
+		}
+		udelay(10);
+	}
+	clock |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+#endif
+
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -982,6 +1031,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 #ifdef CONFIG_PM_SLEEP
 	.resume		= sdhci_cqhci_gli_resume,
 	.suspend	= sdhci_cqhci_gli_suspend,
+#endif
+#ifdef CONFIG_PM
+	.runtime_suspend = gl9763e_runtime_suspend,
+	.runtime_resume  = gl9763e_runtime_resume,
+	.allow_runtime_pm = true,
 #endif
 	.add_host       = gl9763e_add_host,
 };
-- 
2.35.1

