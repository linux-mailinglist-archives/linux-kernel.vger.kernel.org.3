Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9850B5890A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiHCQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiHCQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:40:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2BB1DC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:40:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o22so6725256edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEbeV4OUpZWR/RMps+1B9ugXkfGh+UmPMJhS6NYk2ds=;
        b=iTQLsQyrVlJvV4kz1DXLEuJDkKqnmFAsG85k2/+sz8Nij834Sp0Dkm/2zK0mlDi6Cc
         Nfw2YdUCtVmQAsVEys9Qhau2GdKE+goGut8vyt6+45+2LXu7m5yS6uPaILQg1w5wHW7f
         ij3juJ7pHyV7XPwyXvL3MFBjH3JNIovN2nshutItkoPjMN7Ey1A8YlBU/Fi1A2wS5j+8
         DeN47iA+0yEdlL3xvDte7/S40wrq1Siic1bp6jq0p60fJ0xPy+uzk1eBxqhEVcaraVSV
         Jbywxu+IwlumPMfFhcrb+gdLgztpmGCW3wGY4gqRtefwFn86m+PlMekInjlD6CVOPqns
         8N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KEbeV4OUpZWR/RMps+1B9ugXkfGh+UmPMJhS6NYk2ds=;
        b=Aq0BkoEZHiWrzX/NUYWrcc9T0ZqY7TqgGeR2Dog7+3RtJ/jQBVYs4+PoaFBS9zb1Z6
         wLiURjukfS82ao/5oFv4hfXN6libslWxSvJj9aM6qnLgZLz5oj209zZDjYUT/MgLTtH1
         erfi0ssX2M8ot6FOdEbul8Jygv7HQVDtiH9jNZwuKX7BFfGErIQUGJluLTbJ/she9McM
         H2FsG+A1E4up8bTPj9J6Ga9DEXA7htlTp/l/ADilbSy5zaY/+TT8lj6VBWJARMmrWR4U
         dEGp4L0MAPvfJTAmyTmXajJaTbXjRgWTo4DZBAKYXWfs+vLX821tgtq0PkAwseXhQ9BL
         ua3g==
X-Gm-Message-State: ACgBeo0dTEBzsCmvkIxbwGw9kqDN1MxoJL6B5kzfWOUCCOS9bgRXLO7y
        4V66WBhK9J8CtPSNtfp1/iA=
X-Google-Smtp-Source: AA6agR4mnj3cIl/ZowGRVGE7a3UvEnVHL/i/iyJJCDAW1fTvYCfEfo4eFVNVM2ePlqypc1ZG/yV6ng==
X-Received: by 2002:a05:6402:95c:b0:43d:6297:f241 with SMTP id h28-20020a056402095c00b0043d6297f241mr20049333edz.373.1659544804580;
        Wed, 03 Aug 2022 09:40:04 -0700 (PDT)
Received: from x360.fritz.box ([2001:9e8:a511:4e00:667:64a6:5f64:1055])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906769a00b007304924d07asm1508032ejm.172.2022.08.03.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:40:04 -0700 (PDT)
From:   Ivan Hasenkampf <ivan.hasenkampf@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Ivan Hasenkampf <ivan.hasenkampf@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Spectre x360 15-eb0xxx
Date:   Wed,  3 Aug 2022 18:40:01 +0200
Message-Id: <20220803164001.290394-1-ivan.hasenkampf@gmail.com>
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

