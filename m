Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB358FFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiHKPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiHKPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:32:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FE97D57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:31:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w197so8755506oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7DrcmAf9Cs9YQAf7id7R52Yp/mcVnx55k0vZxgZh1Uw=;
        b=Rw4iLOLh+LaT7yhFHWhvYNd9mq2StwwLxRBqGi/7Ds5ITmJkjPTTnp9H1/rQwMxfPd
         vk3AuHrWhNu4tvUbrcuBxPmQ4Z1YgdYZPFNjb2iUH1vUTicenuebBmVvtsA8jwGb3vnp
         qmZq+2s4xNzARka6ovk9o2eLfbHdP1VLJILO14qC+/xbSNYF4HW2mOvbQz3yve+pd5E4
         RcHpNCpwXjawlcf3x5kVKr1aUo3Z5RYn2oYlkYEHUFCM8uQwu7fADBx7FQvDhnlyePi+
         FlHs0M4pxjjfeXt4Y1a7Y6IeIwwMMRjJUq/Lz/l7jPd7awQfp4VSm7NV2dI8lqMPzQUR
         fmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7DrcmAf9Cs9YQAf7id7R52Yp/mcVnx55k0vZxgZh1Uw=;
        b=yci2KgcwNa46TadnJuYplT4sua4W/s2o4p0N7c6Rs0gzCR8s4HOu24aJmd5dR6nzD+
         MheIJEdsItb+vt3IYlqZ9Ve555KmafxZV/DEL2Lcqw772t7wZd6S36GwEBxcoOnlQjKB
         ueT+RkalHyy44P5PDQhWFnf7686i90AqXTx3raoh/dpeTF80W+v1iLuR+bEmgSYSo0w9
         aPmoA34qMVQ3nqHw5BWExgQYJPzltY0eHTuw189O/qleQbpd+Iq51epCWC3eNFV0rHGy
         Y+RSTjyj+FAZBK9CUeBEKRz6ilAr1HTGJQ3bLh1HATit6Pr7cvPEavwEGYNvDdosumsP
         pdGg==
X-Gm-Message-State: ACgBeo03ji7+lP0OEFMWW5njzqrhfqRX0f9w0h6+Bae7EaePNnRpQKs8
        6G+PDXvE8bLr41JDfDoHuj8=
X-Google-Smtp-Source: AA6agR6yp1Ne41XGFgWnopYd04fjJH6BITIgPT75nqhbRjKeRsuC9t4fHGyB0rHVv05RlLpzODHwvg==
X-Received: by 2002:a05:6808:302c:b0:339:ee90:94df with SMTP id ay44-20020a056808302c00b00339ee9094dfmr3712525oib.193.1660231891790;
        Thu, 11 Aug 2022 08:31:31 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::49])
        by smtp.gmail.com with ESMTPSA id r10-20020a05683001ca00b006370b948974sm1187015ota.32.2022.08.11.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:31:31 -0700 (PDT)
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
Date:   Thu, 11 Aug 2022 10:29:24 -0500
Message-Id: <20220811152923.10143-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811053950.11810-1-faenkhauser@gmail.com>
References: <20220811053950.11810-1-faenkhauser@gmail.com>
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

There's at least 1 more device that doesn't use ACPI/BIOS config for the CSC3551
https://lore.kernel.org/lkml/20220703053225.2203-1-xw897002528@gmail.com/T/

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

