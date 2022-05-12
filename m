Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5F52547B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357499AbiELSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357486AbiELSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:10:03 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148326FA46
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:10:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id B7584C800A0;
        Thu, 12 May 2022 20:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1652378999; x=1654193400; bh=lnzILpdh2K8lGWVaQPF3fcRF
        vtUVSxBJPnRKUuK178o=; b=V9vBq+2AoWAORWo09hcDuIxXZ2KL8nvT/vS28wQ1
        gbqzm5HsslAad7b7vFdOySu/UK/LrRBOkWi1EIID+Rk6wsJZ9lZgt77deuD5dOsA
        jXIKjag/acvjqqnIpagdDJeYR8qURO3+DawvndbSD9L0p10zjac5a2V1xs+g332B
        hbw=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id njhnehTx8C5h; Thu, 12 May 2022 20:09:59 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 1615BC8009E;
        Thu, 12 May 2022 20:09:59 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, imre.deak@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for TongFang devices with pop noise
Date:   Thu, 12 May 2022 20:09:56 +0200
Message-Id: <20220512180956.281804-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When audio stops playing there is an audible "pop"-noise when using
headphones on the TongFang GMxMRxx, GKxNRxx, GMxZGxx, GMxTGxx and GMxAGxx.

This quirk fixes this mostly.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cf531c1efa132..8003bf7441d6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9290,6 +9290,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
 	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_SET_COEF_DEFAULTS),
+	SND_PCI_QUIRK(0x1d05, 0x1096, "TongFang GMxMRxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1100, "TongFang GKxNRxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1111, "TongFang GMxZGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1119, "TongFang GMxZGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1129, "TongFang GMxZGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x1147, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.25.1

