Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11505545406
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiFISVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344091AbiFISVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:21:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD83D489
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:21:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so20877514plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sohamsen-me.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9RF4GfJpLOSChLP69/9v/27AKPLXtsI2HPRFnCkmaU=;
        b=tdBT48G+TG4Dn6DuFoq587bfuOUoUSpyOGgjX4mp9zgApFfRSu8l0nI5/Wfvz14Ey7
         FUqAmZXE2OzN9JrSsWhlm20HOVjBcq3VgbGZMaM6IptI4VSZCfPOsV160m4cdk/XM70p
         mXZAqXRJgZELUwYt/KO1PYR1eFEXMIIGfH28O/rMMSuKyOIlcdpvkP2G5PmI5YCCDDoF
         47Mxfy+dcWUVtRfdeavAplqTxhS3AFfA4eAFp3DJme8+9vFI9/OADdaKATBlmHfTi2CP
         fpNdE49qL7SghMpKLbVD8Ge5cEkSrz31yw1MK9QLqiTTjSZSnLZyvv2oOfn5b3LIumAc
         nJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9RF4GfJpLOSChLP69/9v/27AKPLXtsI2HPRFnCkmaU=;
        b=O9Re8O4qgGuIQm/ysWcWOlEBNQP6hAA5TmAEYY6jJdaJdVmwETTw9Nfq042gdPXScG
         Y1IkG7vze16mv93MhBjAiWgO5+mu0uwTz0kmItxd7NmfsreSu+mU3lHFGJhE+UuJz8iY
         +93gDKCsj/+DSZl2wwsr8OUKY4rq/rgwVOkqdLtKwpZlyxCZlgmMQHRMpFFmo8EiXuaC
         S3ZnVJfbmNgN6McNUdJVjWzNM00fFUlpkbL/zKPIZovtNZwfTIAYro0gsPcae4qvO8ba
         Mn4cN4u42nVBrfhsc6E0c9IWSo2GL/IbjKLud5uJhPb8JGab5JCc9EPyqX16qak/Qd/p
         Tbzg==
X-Gm-Message-State: AOAM532jBNXEi+bTTpxj+Qg7QpM3XwRlXQWqtzRLpEVIfUod8n+tA28q
        AP8xsypjSvsmxXh26stzI5iHlA==
X-Google-Smtp-Source: ABdhPJzrWPmA6aBJOj5hl9GBv4dVZQHWUYcE1nNAoieI6W6+s2CO85bmOAeu91zcppNDITHvs79ZQw==
X-Received: by 2002:a17:90a:7349:b0:1dc:9314:8699 with SMTP id j9-20020a17090a734900b001dc93148699mr4674464pjs.184.1654798867227;
        Thu, 09 Jun 2022 11:21:07 -0700 (PDT)
Received: from localhost.localdomain ([202.173.126.209])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b00168adae4eb2sm1497646plb.262.2022.06.09.11.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:21:06 -0700 (PDT)
From:   contact@sohamsen.me
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Soham Sen <contact@sohamsen.me>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Omen laptop
Date:   Thu,  9 Jun 2022 23:49:20 +0530
Message-Id: <20220609181919.45535-1-contact@sohamsen.me>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Soham Sen <contact@sohamsen.me>

The HP Omen 15 laptop needs a quirk to toggle the mute LED. It already is implemented for a different variant of the HP Omen laptop so a fixup entry is needed for this variant.

Signed-off-by: Soham Sen <contact@sohamsen.me>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f3ad454b3..495b919bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9010,6 +9010,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8783, "HP ZBook Fury 15 G7 Mobile Workstation",
 		      ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.36.1

