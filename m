Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AB5009B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiDNJ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbiDNJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:28:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959148302;
        Thu, 14 Apr 2022 02:26:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u29so648379pfg.7;
        Thu, 14 Apr 2022 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv2u67VUTHgcQVHVUxKlQUfo3twOkOyQTpWpLFs+HfU=;
        b=mntMiy3fQByvKw7rwF6+IdJXrfqFIr7hYdeBVWaVVkmYC7pJrqx7jAv891elodFmoc
         5fk4ZTDvSJ5thBiGtT1Ksm8SKuNjqS3NC9WWUZCgpvpcMUzu27WS+cEkJRvHsZAFZYBk
         xZf3sPc5nU9AcaXZq35+2cMRgKJO2hZBn+/T8vidZf4TjjBKL0pjaIMYEBzyaxAODGh0
         onnLxYO6efQRyZd1Xz9arcJXGd2RqIslpXc6ydqAZnY2l8IZJHWs9Kzk1lNBrzYSWUGZ
         Aq6raXAY8qSKGc97cmKQx/kcPJcGJqnHKWdfPCUd7tGL+NawkjlKu3yVbQktP00OIprd
         9fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv2u67VUTHgcQVHVUxKlQUfo3twOkOyQTpWpLFs+HfU=;
        b=Fu6KG5D/Eu3GuNAOLEVBfsYgVSTo9YWDmZUvgC8y6r7EzakmFV3Lbs2cf6U0azIW0U
         8anNmTZy3lC2utjzqIZJEAcJQUs2hwXOa9wIEzHP9btmogRCPea0657APMsGVvO9+dPd
         q2V7VbQzUYnTteqaNrR1AwpEUfuZ1bC0NOrEt9m+jbViQ4iwv3wFBcPJVYh2H9aO4uA9
         qjy6hJI5EHWW6uAI9qYv1XFFoRH89OMNziY2Gha4ynkE0F74EbKdUa7sJqOIMtdU1EyR
         YXSjhXU9Odg593cRbDi9dgzfPVvtxREWIeWZ2O62e0Eeh136Tejy6HVXd2WTWcvDRTI8
         8Iwg==
X-Gm-Message-State: AOAM5310g/pzKEER4FOg7C0a4L0X+MXivrbpMNMPJtTVkcjHq4X6EbPt
        MZWb93coMhw54z2z41QT11Y=
X-Google-Smtp-Source: ABdhPJzYM4dvLOcTka6nYDCt2/mSB/TJn7kMvQYOy4aBuEn8m2V96zC1Bc5VE7dM6sZrauLYfffC1g==
X-Received: by 2002:a63:6e49:0:b0:385:fb1c:f432 with SMTP id j70-20020a636e49000000b00385fb1cf432mr1515386pgc.207.1649928376049;
        Thu, 14 Apr 2022 02:26:16 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t184-20020a625fc1000000b004fa3bd9bef0sm1586765pfb.110.2022.04.14.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:26:15 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        SeanHY.Chen@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: A workaround to allow GL9755 enter ASPM L1.2
Date:   Thu, 14 Apr 2022 17:26:12 +0800
Message-Id: <20220414092612.456730-1-benchuanggli@gmail.com>
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

When GL9755 enters ASPM L1 sub-states, it will stay at L1.1 and will not
enter L1.2. The workaround is to toggle PM state to allow GL9755 to enter
ASPM L1.2.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 97035d77c18c..52230857388f 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -137,6 +137,9 @@
 #define PCI_GLI_9755_SerDes  0x70
 #define PCI_GLI_9755_SCP_DIS   BIT(19)
 
+#define PCI_GLI_9755_PM_CTRL     0xFC
+#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -597,6 +600,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 			    GLI_9755_CFG2_L1DLY_VALUE);
 	pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
 
+	/* toggle PM state to allow GL9755 to enter ASPM L1.2 */
+	pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
+	value |= PCI_GLI_9755_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
+	value &= ~PCI_GLI_9755_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
+
 	gl9755_wt_off(pdev);
 }
 
-- 
2.35.1

