Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B92595902
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiHPKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiHPKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:54:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C233356;
        Tue, 16 Aug 2022 03:21:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q19so8959480pfg.8;
        Tue, 16 Aug 2022 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gk5spmMleYDB5E6yzSXkYXDq0W9ZxoMNmm79ibU/KLs=;
        b=ooUezOaJ7bL3Vrcz7k/onDIrSEwngP/K2dpLWayA1Y4TePLMi14ak10c89vlV6R4CP
         dtKM4IdLCu2oot4iEbtUF1d8hzXt5uTYtzcN2zCoRpYZ3oOeFiIffuquuLSPI7JVhwu9
         TX2NPbW9Tjak+H77euKPhwAffRszTQZ/4xZVUOR1PnqQs5AaMWu1AKZWE555ddu+SdHh
         naS9ShgvLtR2wQ2Pi4iA6r3p2BgIAVLxUdfixg0mkY7dAKhLOHkGEM6ygG6EPHLnr3n5
         jMU/J7k5w2hv71mywkRjwEEqiL/GkgpiMnzFHVZMm6MxneXLZCg+Ih0sVSJ1wXC7iQdU
         Ob8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gk5spmMleYDB5E6yzSXkYXDq0W9ZxoMNmm79ibU/KLs=;
        b=e+x8vCtnKMIC7MYmAgTdAdHDB1eneWoawrZgr6f0vwVIzNzawpChqKsN/y26DtNYHs
         h0YtfMLa+vhosVjLcFoXDuNQrMEwaKctCWiqnL2VIU0FEVNYpM2ldtHm+Z+xMCrQ8GaD
         qlkn4Pi0iDnTefNMo+oCA+z2nBFHtQClIM0JM8+S6Mw3eP/vMnR/BixCFoTxqkjZnYfU
         ICfdgjcQpzfn4pQCohsOsLMnRLj00uupPgr31QFBRWKiPfce1p+8CG1+LRuH8lZAgOkj
         BpQMJJIthMJRmuE/Bsp0sEGsneGn839tCgA/ZfcxFsKGE048oT+50xA/dgg4TY4uC1rx
         wTiQ==
X-Gm-Message-State: ACgBeo05+iSYjDgbuY6Mc71yQnpqRoQ+fT3Yy9EGBtm+KbcnYhs9YuvE
        XydNwcQNyKFXUPru+l8Bx5w=
X-Google-Smtp-Source: AA6agR7uyINHbIv1zyIDimnsWbzI1puM5XJvr2Ubu7kDjkIgc56i296ZU2t2ADuN3Fdkx2wZ0ObygQ==
X-Received: by 2002:a63:80c8:0:b0:41c:62c7:abd7 with SMTP id j191-20020a6380c8000000b0041c62c7abd7mr17611213pgd.570.1660645296906;
        Tue, 16 Aug 2022 03:21:36 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id 22-20020a621516000000b0052ceaba7411sm8065181pfv.125.2022.08.16.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:21:36 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] AMD_SFH: Add a DMI quirk entry for Chromebooks
Date:   Tue, 16 Aug 2022 19:21:20 +0900
Message-Id: <20220816102120.6131-1-akihiko.odaki@gmail.com>
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

