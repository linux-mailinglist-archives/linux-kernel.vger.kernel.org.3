Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5C57A198
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiGSOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiGSOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:32:01 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8B1F2DE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:21:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 146933F0E1;
        Tue, 19 Jul 2022 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658240466;
        bh=oqR8gt4EpFXEUR6Nrtb1vkomwi6qpF5cqH893IhWTiE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JAzgWUHk9v5Jk4oTCG/XLItqUEcbufztroYZU1etNuCApOxbbygCjzhVdTh/qOA9h
         FBVxk+98rBVEpzn7r4btBdmdhPRbBPDv4Q1UVzBXRvzziHpvK3zAyV3H0RxATV3gvD
         hJ9pMqiNzBloceYHoUVYbzc/0rLUofbFumcWlGoUUtsByem5bPPe1OQXm1WATvTDhE
         aVBzkxmWH07rJBi/bmtRpgS+lzvLnrCeNMzOyDZp93suqcV2J2/wMLNtgFvG0ODZz4
         k9BWFx6W+klZ1cnfa90sX+7HuQANwjdHzhUNl63WzuxAynC5IqtTeXKE0dIOiot2dS
         rwwf70yu+L8hg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Tim Crawford <tcrawford@system76.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable speaker and mute LEDs for HP laptops
Date:   Tue, 19 Jul 2022 22:20:14 +0800
Message-Id: <20220719142015.244426-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two more HP laptops that use cs35l41 AMP for speaker and GPIO for mute
LEDs.

So use the existing quirk to enable them accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f55bc43bfa9c..cdbee71e83216 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9109,6 +9109,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89c3, "Zbook Studio G9", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.36.1

