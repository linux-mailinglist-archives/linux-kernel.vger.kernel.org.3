Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4914C4514
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiBYM5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBYM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:57:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA561AD92;
        Fri, 25 Feb 2022 04:56:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u16so4589964pfg.12;
        Fri, 25 Feb 2022 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1LY+l/NhS0rChpc29wsrXNSMavIR38WPUl22nfsuvU=;
        b=Q8ZCobSxyCZV0r4UV8bGTLo7sV2CxiV6G/eLc6DB0ZhfQQ76MFVHFensMok1LwVLV6
         GoijSrV5mJCeCa74dWnhEfN0S4/XLlWNJqggx7rpERt/T7bqh6iTCOWCCm9v2r9w7U0d
         vbf6R2oqriln62nbxRFI0smE7tvje7RpUKMJ4rEfMwaFOSr/tQ+wOTXeT2VyQhuuqvHi
         BG0CDMKjxKtXs0clDRR+O7OzMgRkBog5IQDzduySVw1MlQVr/4q1vLuKIb0zW7qpnXSk
         fIRODV3LgiOiYQ2KWSxTNmQ4NsenegpHhCxKAWlp3oBnyDcMe1TYSEOD3CxULXi0d+VC
         rHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1LY+l/NhS0rChpc29wsrXNSMavIR38WPUl22nfsuvU=;
        b=ySyzECVkM3po1ZWmbEDX8jUWKEu+CFte02IvLggcQ4xfv4Jd/koIuTw0t2RUpGg2tf
         Fj5KEN5XksT/+bKxGSUjskkWEMwsxtvbs4JPokN83WARhU8iJW4Pe3vTnUOMMFPxeojX
         5zwjqzbAS9Mwq6k8gZ81wwv3iY1qNRepPOw1QF5K1LWHw1zMu0rItD8EOkhArbOGvL/A
         YJt4Vq3CHRvtoW3+E3wUR0fRKpkrSZCX9W+a7XVut00B9G8O3eGg6lPTCQsUFFFfLEwn
         Q/difBABZTyu1EDFhnonCqu62bttIBYAZ0CFB/HZ7JoT5qw13kFLCpAj8lgseuHifhOx
         REQA==
X-Gm-Message-State: AOAM53399mIqF2vHya1t1i4Ewf88zzrj2vtxNzi6b0WnrI3MENB1sCkY
        f4ZBX3Ya+X/gaez5hgZ95Yo=
X-Google-Smtp-Source: ABdhPJz2FHOtgTXQRyEO/C1MJGjAUxyNf8zsQubMNGWR/75ZbnhnxbaWn5+W2LEZRY/6jTB4ReHPjg==
X-Received: by 2002:a63:9351:0:b0:375:8d1a:4766 with SMTP id w17-20020a639351000000b003758d1a4766mr5343059pgm.102.1645793804114;
        Fri, 25 Feb 2022 04:56:44 -0800 (PST)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm2994660pfe.186.2022.02.25.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:56:43 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
Date:   Fri, 25 Feb 2022 20:55:53 +0800
Message-Id: <20220225125553.1185108-2-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225125553.1185108-1-benchuanggli@gmail.com>
References: <20220225125553.1185108-1-benchuanggli@gmail.com>
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

