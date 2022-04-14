Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897FD500A68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiDNJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiDNJwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:52:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0A633E;
        Thu, 14 Apr 2022 02:49:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so4221568plg.5;
        Thu, 14 Apr 2022 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv2u67VUTHgcQVHVUxKlQUfo3twOkOyQTpWpLFs+HfU=;
        b=DWsmfMcZlwH7OSGkV7auWZsBJ/al3HnlfUVbLDkx+CAbb8C2lgpDoYfb1hqkMKJ8e1
         xddujm1TdFy7l3hTsAtteOEJLma1hOthjc9OMUcSFsGT1rcivIIP5ozAb8kWm7/eMwHo
         /0B2bIGulLpcwlsmcjas/pkYXrsYt4wrgqoWGOeqF35Cf8xgBa/dLhwxd2f2vg2jo8a0
         DvoftHC/zaOLAWn5ugjI07A61v8QK7Vl7+h8ranhPiFr8Nh+ft6D4NQ55GhI/SIq9w7N
         62BZrB0vxBB+eJlhRtCqUH1a45xHhmAZa1vMVkze+PU3jga1Z6px7pmGwgJWj7uOjNKB
         4ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zv2u67VUTHgcQVHVUxKlQUfo3twOkOyQTpWpLFs+HfU=;
        b=Tupe6kxS9VvFy4xee6Q9/leS7QWXhofYZ8kJmafWg17pEY2Jl7gy1Y96VaoUXtPWHT
         ZmtIqKD4UK8DLgx1bQwvkhFa3Cw/tmIc3vDZosbPzMhpbgWMNv/+p2qyXPTmZsvZGXXn
         9v7mlQbbCzEDSCNZ/OkWeQ5NdIZdQQyV9jb4AinRp9WDdLJnG4e551ZCBiYb8yjvQ6Kn
         UTMeNKilIw/9tQxYjFYk6WquFDJ5r0g26wnOXXeU37NRbssvDnMpvrE40T6KWZBAnBMJ
         1zvdxgEzr+d7iWiosW+Z1qDLFkcX5rV8DWrmfENZ8VtwmafMj1SPVM0KnKSEkrMe/Tkx
         Qb9g==
X-Gm-Message-State: AOAM5306uVaAv5GYdkVgLi3iJu1F78JSfkUzfSigFAFf5uERmzTsiYuA
        sAVegZfPaHG8Uyi66j+ci5M=
X-Google-Smtp-Source: ABdhPJwJy2f/l6+cNztO4ckNzXYQUX//84LV4uu5q5oD91OvxnTFIalckRWTVTcqhgMLoicLdeIqWQ==
X-Received: by 2002:a17:90a:e7cf:b0:1cd:3eb9:ce79 with SMTP id kb15-20020a17090ae7cf00b001cd3eb9ce79mr3371550pjb.88.1649929787809;
        Thu, 14 Apr 2022 02:49:47 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm1799753pfj.79.2022.04.14.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:49:47 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     SeanHY.Chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ben Chuang <benchuanggli@gmail.com>
Subject: [RESEND, PATCH] mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2
Date:   Thu, 14 Apr 2022 17:49:45 +0800
Message-Id: <20220414094945.457500-1-benchuanggli@gmail.com>
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

