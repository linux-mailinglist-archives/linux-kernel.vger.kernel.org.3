Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696C59CD14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiHWAQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiHWAQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:16:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEA1AE;
        Mon, 22 Aug 2022 17:16:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p13so3431pld.6;
        Mon, 22 Aug 2022 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=p1/Bx0oP8nfnziMM2cHICkhjDAldqcEDoIF6YYzpP1o=;
        b=NJsqi8t9JuDzgLorWS8OUEYtWroALCU5iEBR/k94kjGD/goNE/LwojsVJXeyEu2k6w
         PfQ5F3B/jdDVhkO62gzKB4qaEX8PfmYue/W654KE2Ieb+snr5nNYQxozb5O2zmdkVt0G
         v4GvAUq5PIux/9e5b3fTHx5qH0gtF/OnAWANFsQMgiCKrgMGIUh42lXkTayvYDunBi6E
         YtrRRCT8Ac/ur+g1mInow7eAPzKIEgfsokJ+BCtLE0lBM4+BqbUzYn0wvQlJMPEbaWf/
         Y04M2Wa1bl0sSQU0EB+SjGmJrlZMyIDmiTLNjLhx6gNz/ygCoYCOvhqF4i5kMkyqjKWS
         D8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=p1/Bx0oP8nfnziMM2cHICkhjDAldqcEDoIF6YYzpP1o=;
        b=GEMFnvhBtisG5U5JHjM6ai0+JaoEKfVAv5wCEW1zqkl8qTqatDi2OQtYGcCQI5v11V
         N44e7u7bp6UvJ/c466UW6HaC/H70ck/GSq3PwlUQOhkAbCMchW7reXVJD9tXExNQpUAc
         optpQwRXyiprRwItKQvo6a8EKckf2qcsi6RCNsowFDFPTMiGs8btd6GfQi3STkNsMql5
         0CJu59iNk3QmmLekEQuPDyftJ9amAtDzgTAhUvcI/+CMPhcvvT105kw2JCuQ0rL9QkqE
         MfdwudMOqAqWq+s9vZSw5aSjEy/5q27es3lZ5ag6yIFYOwtrPDuBaz7WCx/J00yVfv/2
         /vGQ==
X-Gm-Message-State: ACgBeo0FmbKFoylLhgi5hvlWGX/PM2ghJHTnP0HCC1LfDGg99qlSy35J
        tSfVTEoFRheHmICtFVP8Fc8=
X-Google-Smtp-Source: AA6agR7i1SuMRSIVdkZ0AMbM7HprFkT8aUzTOpkc/abCrzIOvPUZZuH+UuGXP1VVtsO7BAGimBjGCg==
X-Received: by 2002:a17:903:228a:b0:172:ea8f:f2fd with SMTP id b10-20020a170903228a00b00172ea8ff2fdmr7101197plh.33.1661213798265;
        Mon, 22 Aug 2022 17:16:38 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016d785ef6d2sm8903695plb.223.2022.08.22.17.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 17:16:37 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v4] HID: amd_sfh: Add a DMI quirk entry for Chromebooks
Date:   Tue, 23 Aug 2022 09:16:30 +0900
Message-Id: <20220823001630.3973-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Google Chromebooks use Chrome OS Embedded Controller Sensor Hub instead
of Sensor Hub Fusion and leaves MP2 uninitialized, which disables all
functionalities, even including the registers necessary for feature
detections.

The behavior was observed with Lenovo ThinkPad C13 Yoga.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b90c86ee5f8..47774b9ab3de 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -288,11 +288,29 @@ int amd_sfh_irq_init(struct amd_mp2_dev *privdata)
 	return 0;
 }
 
+static const struct dmi_system_id dmi_nodevs[] = {
+	{
+		/*
+		 * Google Chromebooks use Chrome OS Embedded Controller Sensor
+		 * Hub instead of Sensor Hub Fusion and leaves MP2
+		 * uninitialized, which disables all functionalities, even
+		 * including the registers necessary for feature detections.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+		},
+	},
+	{ }
+};
+
 static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct amd_mp2_dev *privdata;
 	int rc;
 
+	if (dmi_first_match(dmi_nodevs))
+		return -ENODEV;
+
 	privdata = devm_kzalloc(&pdev->dev, sizeof(*privdata), GFP_KERNEL);
 	if (!privdata)
 		return -ENOMEM;
-- 
2.37.2

