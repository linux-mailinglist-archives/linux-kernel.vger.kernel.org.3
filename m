Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9213058F756
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiHKFmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiHKFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:42:41 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573147B7B2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:42:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1168e046c85so10619463fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iG0nOOpF2Z5RqOhLd2ctmnmkQyGCdgfQ7bZHipU5ucI=;
        b=I/bs1JX1+0jOC+oX0CvGnAnDEGPKujmWsfv/0CDuQZ27MJ1fVMTZ5yV1OSOQ44lldh
         PCbXO91rn+xLFU+rgaMrSnbz7RfJytR7PD/vhEohe5AbLwmESuxbZgKZneXlkM8uuiIz
         wma25pKPjsrK/PQbuCArTIIz1EksStTU8PWQRUGfDme1mPKLWDoqS9x/baowIyCbUbhp
         Smp/OGcE3Xlm0RpswGMt2RfhE5uKPTTLg9G7t9jiRfIJQVvUu+sfni2T436w+eijURsG
         FEVG1K2i0Lpiu681TbvrbvXv4FzmvSfj6fEe4uPJDLtPGl5SLPSFkxojoownqsHtLReY
         F25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iG0nOOpF2Z5RqOhLd2ctmnmkQyGCdgfQ7bZHipU5ucI=;
        b=c+gykv8uVYKy75YE8kuNuFaw1kaZmMmzmRX3rl8bB0McDseYvU667fXVnJdOkR/uOT
         9enCVgykSnI5+fqN4uJGGQ3mDKWfB/t1Tgzmbnf2I1eHHEUuP/NYwozP75ylZaLMJUVr
         35ct0h+OmXL5jUSy6lSbJxpJyzO8I3Jv+ifDVQIfXddaaD6xe60vZt/EqcPAizjKVGNJ
         VFbSVslRNSmgSNDckRPXXpWnSAdbgh1ariQzBJWRKz6NRBoAvyuBzwGAICXhv7Mm5ELv
         YJmAtfqDQJD2SCq/vm4IXLgyJQYrpcoqgPx+vpBYqdKceYh9cqPC8XJVBd6KhhIO1lzB
         hSLQ==
X-Gm-Message-State: ACgBeo26voAFr8X74GdwnJD3qU2rrVV+j+YQJ6x4aKQPAvSIM3Mj+CA5
        f6AP9TmLTpsMr053PEqPjH5ITVDvIhLRvQ==
X-Google-Smtp-Source: AA6agR4XhzBEMxHZ2O/SDGGjuv4fswxMHBrrIBqNLUNSOJZgYQI+jxvGosxcIVf3o8LuwG9jqsVyUA==
X-Received: by 2002:a05:6870:15c9:b0:101:e18b:d12d with SMTP id k9-20020a05687015c900b00101e18bd12dmr3009132oad.51.1660196559688;
        Wed, 10 Aug 2022 22:42:39 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::37])
        by smtp.gmail.com with ESMTPSA id x51-20020a056830247300b0061c82e055fdsm1021346otr.14.2022.08.10.22.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 22:42:39 -0700 (PDT)
From:   Fae <faenkhauser@gmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Cc:     Fae <faenkhauser@gmail.com>
Subject: [PATCH] Sound: pci/hda: Add quirk for HP Envy x360 ey0xxx
Date:   Thu, 11 Aug 2022 00:39:51 -0500
Message-Id: <20220811053950.11810-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.37.1
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

This patch fixes speaker output on the HP Envy x360 ey0xxx
The mic/speaker mute LEDs are still non-functional but they aren't required for basic funtionality

Also the quirk is labeled ALC287_FIXUP_CS35L41_I2C_2 however it does not only apply to ALC287
Its function is the generic cs35l41 fixup telling the driver that there's 2 i2c speakers. It isn't actually specific to ALC287

I did have a bit of luck getting the mic mute LED to work but it was to finicky to submit ( I used the ALC245_FIXUP_HP_GPIO_LED quirk )
I had no luck getting the speaker mute LED to work

Signed-off-by: Fae <faenkhauser@gmail.com>
---
 sound/pci/hda/cs35l41_hda.c   | 3 ++-
 sound/pci/hda/patch_realtek.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 129bffb431c22..21d8c2de128ff 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1156,7 +1156,8 @@ static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physd
 	hw_cfg->valid = true;
 	put_device(physdev);
 
-	if (strncmp(hid, "CLSA0100", 8) == 0) {
+	if ((strncmp(hid, "CLSA0100", 8) == 0) ||
+	    (strncmp(hid, "CSC3551", 7) == 0)) {
 		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
 	} else if (strncmp(hid, "CLSA0101", 8) == 0) {
 		hw_cfg->bst_type = CS35L41_EXT_BOOST;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8a57636f622e9..e7053cbc6bb6e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9179,6 +9179,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x8a31, "HP ENVY x360 2-in-1 Laptop 15-ey0xxx", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
-- 
2.37.1

