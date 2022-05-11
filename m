Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10CC52346C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiEKNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEKNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:38:42 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11C31AD58D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:38:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id AAB45C80099;
        Wed, 11 May 2022 15:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1652276314; x=1654090715; bh=MYL1LmTlRpJ0WAPUXcs7LtIL
        FO4VLHwdu72ZeSokLGo=; b=U9MgXW3u7fhkbJ7cVgT/X0f3iNEOQ+YzVSHb2FWU
        WgvoEjFzp70Ttz8gZIFCH0+3gKcFaJBVji0xdZ7GYaLpX/6vC3kY2XyU0dN25Lv7
        kv0T94UvOWYUVJjaGtIS4DyqABVywBteCEiNygR5keh9gUqqu1yTPrIEK1iO3Mfb
        EfU=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id hdpoaOfmz9Hs; Wed, 11 May 2022 15:38:34 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id B639FC80090;
        Wed, 11 May 2022 15:38:33 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, imre.deak@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/intel: Add quirk for TongFang devices with pop noise
Date:   Wed, 11 May 2022 15:38:28 +0200
Message-Id: <20220511133828.13724-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When audio stops playing and sometimes when it starts playing, there is an
audible "pop" noise when using headphones on most Tongfang GMxMxxx,
GKxNxxx, GMxZxxx, GMxTxxx, and GMxAxxx devices.

Disabling power saving for the Realtek codec fixes this noise. Presumably
it is triggered on some power event in the audio circuit.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 sound/pci/hda/hda_intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0a83eb6b88b1f..8a1088e057ec0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2201,6 +2201,13 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* Several TongFang barebones making popping sounds */
+	SND_PCI_QUIRK(0x1d05, 0x1096, "TongFang GMxMxxx", 0),
+	SND_PCI_QUIRK(0x1d05, 0x1100, "TongFang GKxNxxx", 0),
+	SND_PCI_QUIRK(0x1d05, 0x1111, "TongFang GMxZxxx", 0),
+	SND_PCI_QUIRK(0x1d05, 0x1129, "TongFang GMxZxxx", 0),
+	SND_PCI_QUIRK(0x1d05, 0x1147, "TongFang GMxTxxx", 0),
+	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAxxx", 0),
 	{}
 };
 #endif /* CONFIG_PM */
-- 
2.25.1

