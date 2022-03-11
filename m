Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3294D5EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCKJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiCKJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:40:20 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513901BE11D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:39:13 -0800 (PST)
X-QQ-mid: bizesmtp81t1646991522tb6643rv
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Mar 2022 17:38:40 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: ke64Y+R1JM0aRKmhfsATp+SpcW+C3sJEpa+9URKRwGCpAxHHze9JKVhTICDV/
        MyElnTQUgPve11JsBaJGkjfPYeVWoy+ZRt7Nnf2A3MMbAcx22x6uBIt4y1vPAnTf1f8XhoT
        jmqzadsc4qYt3XKgojg60+exdq9BNk6jK4cZuyDEpkZhBh/HwGMDQYt+cpwSgsajSRH1TCA
        2KeoSMZBqTXR2iJeIeHCN44lmmAzn/GhOAUXfMnTnyM0HanrwUQ308aWzZrCKwY28vEOmrf
        lC6qOxJ8bhJnAD92B3hWs3/co136Cdlo0fuzGeSura+CPHNP5qH2mrb/2Qt6KyndQYRmzar
        9XYNqXNMeO6rttvxJc=
X-QQ-GoodBg: 2
From:   huangwenhui <huangwenhuia@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     jeremy.szu@canonical.com, hui.wang@canonical.com,
        wse@tuxedocomputers.com, cam@neo-zeon.de, kailang@realtek.com,
        tanureal@opensource.cirrus.com, sami@loone.fi,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        huangwenhui <huangwenhuia@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc671
Date:   Fri, 11 Mar 2022 17:38:36 +0800
Message-Id: <20220311093836.20754-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a HP 288 Pro G8, the front mic could not be detected.In order to
get it working, the pin configuration needs to be set correctly, and
the ALC671_FIXUP_HP_HEADSET_MIC2 fixup needs to be applied.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a42457984e9..e9c9b1d1bf0d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11067,6 +11067,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
-- 
2.20.1



