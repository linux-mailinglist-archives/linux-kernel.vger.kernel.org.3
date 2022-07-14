Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA457449C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiGNFiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiGNFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:38:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EC22B08;
        Wed, 13 Jul 2022 22:38:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1691560pjo.0;
        Wed, 13 Jul 2022 22:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYTIDfJ9CTPntddkM4o61xxVIDzdsIEr5Pg/XtUXnjY=;
        b=cMPziWUD9Cfguc8aD8iHHsqy1MJTi+grGGpTHvCXEf5vGGugdhdKWn8PHezuv0OhmE
         FJ5NRarZtcGfB5qlUbwTwDoA4Ef7d0H9Ad0OFBy6U6ls8xq++LTRNyRSN05Bon6vRpVK
         7onQMUcIs8hPCKtx8dyCOlW2b1w47OSmHcaQyXH3QEfPc0H/9WmSQbDcI+SxNxKlHjeQ
         pznW7HAkdFGxkRwG/lh1Hpf1C8NbYT6OCPqzdkwMbeoAlHzM3PTmfPiSQ+l5jJHsJ2P+
         1PBnG9ulLucsDQ78Q0dYWOrK5RVXeIKR81fR/YV4G1vj19CwREDTm2k3wjNVAJBdN7/b
         o1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GYTIDfJ9CTPntddkM4o61xxVIDzdsIEr5Pg/XtUXnjY=;
        b=JpNT9ZqJ6PlxOg7+Wqaw9yeGRjdHwilRBqn1UbZKe5V3mAvOGg8U6W5SuFupQCHiF4
         5dzq/6RcmRZxUmbN+L99ovWMNBjb/vdRKC9Wg+MbLZevuXhyh88KX0u10D2CnJTWlebK
         StdDcea9vATERudWMFnJs9c8PSNzaGXhSHnKY0QLL3nYS+daOBkaQr0q+9tjFqvh3m7l
         69rZ2cj5KnosCVTZ6J3oKajGiOrGKCXpWp9yPzNq7SGtco8Hqft13QfBpx99ygMdfF/O
         Ha9uDtDUeaE2WK0xzzcsoFnm37HzlJ0BZZxGq8zPGrORZ9j1+JYVXixYDOt5GasqdZ62
         shqQ==
X-Gm-Message-State: AJIora+aKJSrjuqcjsVnl7byVnrjxZsQoLdm1HggXD770QRCieI7u8Nq
        R9cabYI/pMFEUTnc25HOD5c=
X-Google-Smtp-Source: AGRyM1vmWRfUIu4zqmb40XgIcl7V20oFXgFowpLxMiDSKFUt+IMKH6vhM6DX2zsHIJF3AzFIYKpQPw==
X-Received: by 2002:a17:90b:1b0d:b0:1f0:50bd:885 with SMTP id nu13-20020a17090b1b0d00b001f050bd0885mr14355865pjb.234.1657777095117;
        Wed, 13 Jul 2022 22:38:15 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0016a111c83cdsm434402plg.119.2022.07.13.22.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 22:38:14 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] AMD_SFH: Add a DMI quirk entry for Chromebooks
Date:   Thu, 14 Jul 2022 14:37:52 +0900
Message-Id: <20220714053752.5124-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.36.1
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
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index dadc491bbf6b..b91e1c95e543 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -197,6 +197,18 @@ static const struct dmi_system_id dmi_sensor_mask_overrides[] = {
 		},
 		.driver_data = (void *)(ACEL_EN | MAGNO_EN),
 	},
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
+		.driver_data = (void *)0,
+	},
 	{ }
 };
 
-- 
2.36.1

