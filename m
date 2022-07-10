Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B058956CDB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:16:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE811816;
        Sun, 10 Jul 2022 01:15:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so5643935pjl.5;
        Sun, 10 Jul 2022 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uB33o1I70+FsA4di+MxL+HE0Wl1Mfr1zYKDikSzqCkM=;
        b=cS2mM90Jze7n7/9wYlcxb2dP2mUDEFV9l8aMlD0bcYG+cSnu3LZnJ3pjqWiKfTZLkX
         iotJ9c1PQqneBEBwd0jxdPVtbKca4kvylW0deWnYCvRfTUMSXuXPAb175maSZBWJbjPH
         dYQkIkZBEV48tDGPgfGp+48BCAljMf9waD/1FEOsB69L8EcPvkDWkDgoBdrV83Cg22iY
         4l/ERTWoOS3FQ3Z/3/u6ZRikFlNdGmVSEp40gXuR59r8jCutjTxn7DbX9J7i6pthC9em
         zEO+32JJ+2nNYkhDqXQfC/fm7zqiMu4Kn1jBl1QIzxEMjny21jZeawbWg1VmMLGC/MTa
         2ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uB33o1I70+FsA4di+MxL+HE0Wl1Mfr1zYKDikSzqCkM=;
        b=T06wkWjWDVndxu0F9xoS9jmhQQ8oEpb6j6ueyQJQC1qsE4pBXC6RkCHjm3E3U6viFf
         80rVkmDiYCTpzocVVhadO3RcBMbjivpL1jZyo6ZN7Rn/SyiIbilKqRy2D20V4c0OzGWY
         G6Mkw+gwT8p52g+Dh0M8eN0QmgmzUyHR6IWVWDmtzu5smnALUVV0tTwYDPwJs5iLWbbT
         W4EJPzQwvA7FHVNFpo7nfkHgYynzMHOxIvwfyyKnVOXoLx35YigwzxnHPojk4X046ikp
         KRKrm5EYFTyI22n3ZkrIIuN/fdtIe0izca25U13rE/iProbxN2DhAfAwNlOyGgOjoeQy
         ghfw==
X-Gm-Message-State: AJIora8wz/+XCmbaYHKG9Gv2hO28qaKXz+JR9B/vh5nrAYRthoDCSGXa
        lME1uvFIKBkU8ocQPHWz+As=
X-Google-Smtp-Source: AGRyM1sCfZTsYhpidCOmAko/nyB19AWNvchwlqVMdh/xwDJ+5jJAnbqMyh8Dc2DkndQWOouh6BcwyA==
X-Received: by 2002:a17:902:e54b:b0:16c:38e5:a9b7 with SMTP id n11-20020a170902e54b00b0016c38e5a9b7mr4514822plf.66.1657440958942;
        Sun, 10 Jul 2022 01:15:58 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016be6e954e8sm2355236pll.68.2022.07.10.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 01:15:58 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] AMD_SFH: Add a DMI quirk entry for Chromebooks
Date:   Sun, 10 Jul 2022 17:15:47 +0900
Message-Id: <20220710081547.3553-1-akihiko.odaki@gmail.com>
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

