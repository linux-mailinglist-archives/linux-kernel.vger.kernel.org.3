Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D44DD08F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiCQWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCQWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:13:43 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBB29C94A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:12:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7191141922;
        Thu, 17 Mar 2022 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647555144;
        bh=GSGY9xvV7/cHW9kKHfcQPWbJ+8pjDmIgHHQ0jRgjQco=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JScbuvNgfJZNPo1B66r4RAkRLKVBcNqKt8K4fDEm256jiBV082ldnIN/HDpvk2GIV
         N7O3WsfUQcAVJ7jJwWA975ldgqNiVzKcAeErTDsZEstxTSlhct9YAH/PW/daDLrqMo
         vGkcqHXLdcCo47/L+tqPFYIWinaIGxEVLmYN/vbIi8i3qikGyAyLo9wkLWZdFaWSia
         6F9xztHCbQJexrIDqWJhWeoFV/7V0a1ThciivQDsLCRI+F0psxRvpyJdfLygp+iUSq
         Rs5V+lutFWF8KMwavhUCsR9zO6WIVAOayqVUwomxFsleeIRQ8IbCU9rLtoxmNa1WZ9
         lErm8GMbgnLKg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Hans de Goede <hdegoede@redhat.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix LED on Zbook Studio G9
Date:   Fri, 18 Mar 2022 06:11:33 +0800
Message-Id: <20220317221134.566358-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 07bcab93946c ("ALSA: hda/realtek: Add support for HP Laptops")
breaks mute and micmute LEDs because it changed the LED quirk from
ALC285_FIXUP_HP_GPIO_LED to ALC245_FIXUP_HP_GPIO_LED, so change it back
here.

Also reorder the chain of quirks to ensure LED quirk is the last one
being applied.

Fixes: 07bcab93946c ("ALSA: hda/realtek: Add support for HP Laptops")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4650ef9110d62..1d14be4ee31d8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8773,9 +8773,9 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc245_fixup_hp_gpio_led,
+		.v.func = cs35l41_fixup_spi_four,
 		.chained = true,
-		.chain_id = ALC245_FIXUP_CS35L41_SPI_4,
+		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
 	},
 	[ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED] = {
 		.type = HDA_FIXUP_VERBS,
-- 
2.34.1

