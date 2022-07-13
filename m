Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4469B572B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiGMC1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGMC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:27:39 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA68C8E95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:27:37 -0700 (PDT)
Received: from localhost (36-226-173-138.dynamic-ip.hinet.net [36.226.173.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B2D6B3F1AC;
        Wed, 13 Jul 2022 02:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657679255;
        bh=6wuZ+KJ616kYQkmRxbOA3+CCdrb1zXoGEni8dF7l4O4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=mL8hyRcyidq5YODYmV9SELRw2Ols5ehCwaQVqqTX2IAQQxTdlLPd0X/MXU9R9W9CG
         R+qeenl11EtvGBCmJam59OkCsJtZCambyMUPn1DOOJbJ/6W3u9RhZ9p3ynm2SsQofm
         K4TYb2JNDhT3zPtXOI+1sLI6UjJY5DOutrn4OcOHLpu+rruKnOaAOvdWZkKELFkCBb
         53WOx0V7wxfB3kTNNVhDmgcJ40yP98szoI/O+WE7VvsL2FqmoWrgh14g7mjz61n6Kn
         WWzaw7wPNI71Fr9Bl0J6JlyMWGa+OiiAUlD8Ve0x1Z2oZGNwggIEWxY3qAKVxyvy+O
         cSMOpyiBCwAew==
From:   Jeremy Szu <jeremy.szu@canonical.com>
To:     tiwai@suse.com
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Tim Crawford <tcrawford@system76.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Yong Wu <yong.wu@mediatek.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP machines
Date:   Wed, 13 Jul 2022 10:27:04 +0800
Message-Id: <20220713022706.22892-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 * The HP ProBook 440/450 G9 and EliteBook 640/650 G9 have multiple
 motherboard design and they are using different subsystem ID of audio
 codec. Add the same quirk for other MBs.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 007dd8b5e1f2..483c5f49af5d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9096,6 +9096,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.25.1

