Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3358EF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiHJP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiHJP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:27:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C96F571
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:27:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f30so13641580pfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dQ01aEhZNYaH2ZhVRRlO0MExQVXwpOhIKdTs5cP1++I=;
        b=QU0ALuzhQccpKzg5h9xW+3C67U6cZP7AmH8MJtSw3G9rRWRINBmo+z5WMt7HVlpG32
         OVBmJvD29gJyx8+1G2mPhUbP1960uhhZaWTUodTf1MxurLQhlY82aCMQGlxNChXz7J2i
         UzopJnD/+nEzuScKTkG3ARlNRBWPxuCbnjFs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dQ01aEhZNYaH2ZhVRRlO0MExQVXwpOhIKdTs5cP1++I=;
        b=wK0h+WpRq9FxZAkc+TGdG348qa0ttiMHYoHamhdXMTKSTal7H2KH2Er9M0BS+rJ0GF
         Neca2oBIWgGYasRW+Da3WUd00BslRxtLFffjl8wplVSBuCkM3qMubvWTc72A/YRrQTwX
         zpRKdxszYT3kF+KnsbPRR+TajMeiACb4u80BKe71GiRbVsq2iu1t+H3jNNM8e8va++Xe
         5Aqf2xIo6oV/MdK6Y8XSNmDNZ8lnkNw/gY/QRkfNeVbkqZJn2rJACQpB9jPXNqNxLo2v
         ZhpDkwbEZCNLPT3w9X+HisifyujgeH0PLvoNKvwh4c16Bp6A5gUyUlx6W32aGLIbH6XT
         4sjw==
X-Gm-Message-State: ACgBeo2ulRNcNJVLlcRDaWhX6IUZ1i/FEmNSSSfDoZieKxs2VUMiG20l
        HBwVKAHB1LSgHPBUh1PVtaQjO9LJ6abYn44/
X-Google-Smtp-Source: AA6agR6rNWJJ/UIpT2gl//wtCYsECa4lf534iajVWoCxuILkQfw/V1Tw05+Gd3s3l89osKDR+IF+Hg==
X-Received: by 2002:a62:18ce:0:b0:52d:3137:d854 with SMTP id 197-20020a6218ce000000b0052d3137d854mr27750426pfy.16.1660145247536;
        Wed, 10 Aug 2022 08:27:27 -0700 (PDT)
Received: from ballway1.c.googlers.com.com (97.173.125.34.bc.googleusercontent.com. [34.125.173.97])
        by smtp.gmail.com with ESMTPSA id f20-20020a635554000000b0041a716cec9esm9685576pgm.62.2022.08.10.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:27:27 -0700 (PDT)
From:   Allen Ballway <ballway@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Allen Ballway <ballway@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/cirrus - support for iMac 12,1 model
Date:   Wed, 10 Aug 2022 15:27:22 +0000
Message-Id: <20220810152701.1.I902c2e591bbf8de9acb649d1322fa1f291849266@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 12,1 model requires the same configuration as the 12,2 model
to enable headphones but has a different codec SSID. Adds
12,1 SSID for matching quirk.

Signed-off-by: Allen Ballway <ballway@chromium.org>
---

 sound/pci/hda/patch_cirrus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 678fbcaf2a3b..e1055d7d9be6 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -396,6 +396,7 @@ static const struct snd_pci_quirk cs420x_fixup_tbl[] = {
 	/* codec SSID */
 	SND_PCI_QUIRK(0x106b, 0x0600, "iMac 14,1", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x1c00, "MacBookPro 8,1", CS420X_MBP81),
+	SND_PCI_QUIRK(0x106b, 0x0900, "iMac 12,1", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x2000, "iMac 12,2", CS420X_IMAC27_122),
 	SND_PCI_QUIRK(0x106b, 0x2800, "MacBookPro 10,1", CS420X_MBP101),
 	SND_PCI_QUIRK(0x106b, 0x5600, "MacBookAir 5,2", CS420X_MBP81),
--
2.37.1.559.g78731f0fdb-goog

