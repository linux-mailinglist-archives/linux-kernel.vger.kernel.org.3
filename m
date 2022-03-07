Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417B4CF42B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiCGJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiCGJBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:01:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D81C60CFB;
        Mon,  7 Mar 2022 01:00:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso15993946pjj.2;
        Mon, 07 Mar 2022 01:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuFL9uyQNAriGpCD2xLghLhBAOHEFGsgHrDh4RbTasA=;
        b=ZzeHWjwIaLjKsIEZ4QMsy1kuD3HrAsBrDCnWrcwZ2oqTafI6oShTU9AKAUeJ/hK2sU
         QoJLXuDw+6vzkSqqpzylNl1VHxlPCD0/bEezuEDgEpaRbPbm7q61jzB4g4VxmrjYAdVz
         nIpNzrokm5D0iynm2xjip5CzSVQIQzCaCdvoe5ONDGKxbaFdmJarW4XOYihRZrYCyPlW
         X2BVI+/sHj4IUgNLJsA65RpHLa9GCxJ9caxONNQ+VyuPZjngLuXzxHYrIeWtrfKt6KgK
         rn+W2cZO87kQi/Mi1O4JPbxQVUomsfRfoAcd78XXNMJENI62WzyN6bZjJFSGYwIe1LYf
         Co8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuFL9uyQNAriGpCD2xLghLhBAOHEFGsgHrDh4RbTasA=;
        b=v6bvcwELteOiQgoOiWC9ZCINJznoZP84dwtWaakqhhVQr9NMHTr5xAT3D0KhjgQiCY
         wR02rWgKcVtjMiXiXTvbWFEBDI3uPFl5EzQmPO8PPQtpTr9yoY0e9W48a5U14OzSo7SW
         duxPZnBostptxprErINiVfvFv+Fac3yik3EFl7gx7PKW6TX6N0HGU2wNabRc91LbmDWK
         UwF8Fh14maGGwNWITjfxXc38b8YmcfuhwHPw41/xhsV0QEqCQqEx1JefaTsa20kDMLGO
         Lvq5AeOkDV65o1kxiwGtfI6/yXUJ47PK4N3mmaKpsz+Zs4WqoI20z2NETLXz+ngIYfz/
         f3iQ==
X-Gm-Message-State: AOAM533XklZ8+4ZSWsSb6BKoCAGPTbOYmlJlap2xJwfaeqph1WrddEVY
        cxDg5PuNVXupp9sFayTD9g+IYLd5u7E=
X-Google-Smtp-Source: ABdhPJyPbv0WV5jxysEeKV5zDfDKHAqcALuZc09O/FfmMHAGIOFJcb8LidS157pEeKWugq6cvJgPYw==
X-Received: by 2002:a17:902:8c8c:b0:150:739b:8ab1 with SMTP id t12-20020a1709028c8c00b00150739b8ab1mr10747897plo.3.1646643612702;
        Mon, 07 Mar 2022 01:00:12 -0800 (PST)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id c30-20020a63725e000000b0037c8bf5b630sm8981840pgn.12.2022.03.07.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:00:11 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, hl.liu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Subject: [PATCH V2] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
Date:   Mon,  7 Mar 2022 17:00:09 +0800
Message-Id: <20220307090009.1386876-1-benchuanggli@gmail.com>
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
gated of upstream port can be enabled. GL9763E has an auxiliary power
so it keep states in runtime suspend. In runtime resume, PLL is enabled
and waits for it to stabilize.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>
---
Changes in v2:
* modify commit messages
* Use read_poll_timeout() instead of while loop
---
 drivers/mmc/host/sdhci-pci-gli.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 97035d77c18c..c854c8db32e4 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -13,6 +13,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/iopoll.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
@@ -873,6 +874,47 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
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
+	u16 clock;
+
+	clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clock |= SDHCI_CLOCK_PLL_EN;
+	clock &= ~SDHCI_CLOCK_INT_STABLE;
+	sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 150 ms */
+	if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
+			      1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: PLL clock never stabilised.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+	}
+
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
@@ -982,6 +1024,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
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

