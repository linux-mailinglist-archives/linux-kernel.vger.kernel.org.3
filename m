Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B656454B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiGCFdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGCFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:33:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6073A6447
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 22:33:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso6857pjc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BsiPX2KtJdPnGqWVYZ5PsoFOkPFG/BSZesutbERBSQ0=;
        b=pHB2278yWNvovHSqE8wCj33lriFx16XfuVkuvvOfGzCj6h0ok8qbczqPmJbcUz3Ha5
         FVOtYLqd9+B4fwmk+UhUI7jF34NHb2o7xfYYVUBOPm+eZ6A9uCZtWM/XEDax9q/j+6vY
         so6bwmMEKZq1K2lNI0r8cdfumxLVn4hCnrI+2hR/xuj2FtIW4+112sAEiSQC1PqTaiYh
         D3HUYIdk5wNJjmpzSBCohTYapB714bZtQBE+EhMRWdl65LFcoOVxixJquIYVxXfN+nhO
         Nx/tKMZG4bFSxhfqLqqAHClnalmqHT0kpC+UDLRSqUc9rAwvnvFWqkco08sNutXEhfeP
         IpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BsiPX2KtJdPnGqWVYZ5PsoFOkPFG/BSZesutbERBSQ0=;
        b=asCceJHpQVS6WMMv1dqlX9tImtsmWSV8U454E5MjjI/JHINk4A31ATyOi3z00Wx0P4
         22G6x3fkgosUKpa3TTZt7ZSWYan9zmRmVP57QtWIVkfokVr/qbm1ls7i8+yWHCXd99qd
         jhjugxo0x5K8XrPHR7hn3jHYXz81STs18eXimmhRv9bxNBzwhaQWLGuQED5lEigAXXDQ
         DjBacvMo46yjtnusXUJjUVFk0R6BxCPILZ7TH7EEGk3HMu/xrH8A2YXO05YO0iEcXlz+
         HVTZMwvStLDIlyKZEgq8mOKQEaePtl6DtYP46j1TzHzAq65DjfjL5G+GpzS3rldouQqx
         cEAQ==
X-Gm-Message-State: AJIora/4Bw1TILcdXclKjnyGrEUdC/TjAiTVkRfzA97o/yykAbTzpqqH
        J45fTEYXMzjTrOEzuyyw/6o=
X-Google-Smtp-Source: AGRyM1vC3FjdkteKWfObrEzsO7RZCoKas+zX8IhpUVBdVRBxojZ5RAS3o5pKL7UZ293S7TDTvpRFfw==
X-Received: by 2002:a17:903:2443:b0:16a:29ac:27c2 with SMTP id l3-20020a170903244300b0016a29ac27c2mr28024083pls.46.1656826380197;
        Sat, 02 Jul 2022 22:33:00 -0700 (PDT)
Received: from ZEN.. ([23.225.169.79])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170902784900b001636d95fe59sm18384354pln.172.2022.07.02.22.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 22:32:59 -0700 (PDT)
From:   xhe <xw897002528@gmail.com>
Cc:     xw897002528@gmail.com, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tim Crawford <tcrawford@system76.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: add CSC3551 support for UM5302TA
Date:   Sun,  3 Jul 2022 13:32:23 +0800
Message-Id: <20220703053225.2203-1-xw897002528@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Wang <xw897002528@gmail.com>

ASUS UM5302TA are using csc3551, or cs35l41, which is connected to the
laptop by I2C bus. This patch adds quirk for the sound card, and avoid
ACPI DSD things for i2c-multi-instantiate cases like CLSA0100.

Patch is made by XiaoYan Li. It is tested by us on ASUS UM5302TA.

Signed-off-by: He Wang <xw897002528@gmail.com>
Signed-off-by: Xiaoyan Li <lxy.lixiaoyan@gmail.com>
---
 sound/pci/hda/cs35l41_hda.c   | 2 +-
 sound/pci/hda/patch_realtek.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index cce27a86267f..7374565ecf15 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -420,7 +420,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	 * And devm functions expect that the device requesting the resource has the correct
 	 * fwnode.
 	 */
-	if (strncmp(hid, "CLSA0100", 8) != 0)
+	if (strncmp(hid, "CLSA0100", 8) != 0 && strncmp(hid, "CSC3551", 7) != 0)
 		return -EINVAL;
 
 	/* check I2C address to assign the index */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cee69fa7e246..49c27d948582 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9138,6 +9138,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302TA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
-- 
2.33.0

