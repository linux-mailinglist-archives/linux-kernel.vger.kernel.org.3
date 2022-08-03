Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8558909B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiHCQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiHCQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:37:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D87B1DC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:37:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i14so13709410ejg.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEbeV4OUpZWR/RMps+1B9ugXkfGh+UmPMJhS6NYk2ds=;
        b=Uom8+hi1qOe6jYYwuRozgSx+/4RerfyNdpMqKLynKe7W6Pg3e0BkhAJDHPEqnoaH1M
         Om6A6yZ+45SMFX96Nnzfqnrx7ocnw1W1aPn41gwlBxcJ9D5z+r8vDXhTbCGLdipJ5cnI
         7Wm+6A6tDdmzpymtAkAthgcofIHMRr2lWj7cl6VBRWn3LxBtGWqeYFJiii/I01+gPKZL
         OpfLznoud6Ag8kA2N/Jr8WKUANbTCqIqWjnFwfdrg+MAwITUBBGgrUXnG4/gKjrchrhI
         +0t+1b9Xxq3DLPkOpXbxXwPCQPvfdMVtXzJc2obzfc9xWHf2Asg2Vjr4CpYgQycWGOb7
         arzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEbeV4OUpZWR/RMps+1B9ugXkfGh+UmPMJhS6NYk2ds=;
        b=ULr5WZBCkccU1AcglgsnIEmwXkDYyQMtQMQ1hUVr/lTti6Ev5IhId5b3zlJuTiMYWu
         Dij7W7q0ss01eIxoRs6IaJPOin6H+nLc1Ri5CpRxoIg9cNP91s0r+EdMbdXMrpWYDIAB
         K209uoJyLSfCpuIeSwYA1Gef/jSUCMzScgKnFzRica1I/a5IQlMG8pVyHZeO7wmw2xlP
         Ax6fZuxu6YaD7EKP8LW4nyd2xmdpOePadAbfz0JenWCIrenG6jj7JSb89g6OGB5VjEmz
         suQXV9hkf8VrqoCAwL4nmpl2NMLZ/wTECdHcd4nWLQqc+3dbYz1fO02BabIL5AyPLUCw
         v11g==
X-Gm-Message-State: AJIora8m2Ddkz41koPPLHaJ5kb8faJVCiRg6ayL8KCR67qh4Fj/KUieY
        7wyNwnzGlZXSRrP2QaOEQf4=
X-Google-Smtp-Source: AGRyM1tIanl7ZiGLSMnNLyLyjbGXKMujp6YV8c9FQtgIXaxCoMiYdQ8GUxeLX0rVHZAoX+O3H8jnIQ==
X-Received: by 2002:a17:907:9493:b0:72f:40ca:fe79 with SMTP id dm19-20020a170907949300b0072f40cafe79mr20805812ejc.511.1659544634816;
        Wed, 03 Aug 2022 09:37:14 -0700 (PDT)
Received: from x360.fritz.box ([2001:9e8:a511:4e00:667:64a6:5f64:1055])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7c54a000000b0043d1eff72b3sm8361027edr.74.2022.08.03.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:37:14 -0700 (PDT)
From:   Ivan Hasenkampf <ivan.hasenkampf@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Ivan Hasenkampf <ivan.hasenkampf@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Spectre x360 15-eb0xxx
Date:   Wed,  3 Aug 2022 18:37:11 +0200
Message-Id: <20220803163711.290011-1-ivan.hasenkampf@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes speaker output on HP Spectre x360 15-eb0xxx

Signed-off-by: Ivan Hasenkampf <ivan.hasenkampf@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2f55bc43bfa9..fe43e5807b8c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9072,6 +9072,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8811, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8812, "HP Spectre x360 15-eb1xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x8846, "HP EliteBook 850 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
-- 
2.37.0

