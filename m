Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9004B3638
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiBLQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:08:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiBLQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:08:46 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59102B9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:08:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 10so7078759plj.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSwK6RRjbzNVQwnKp+oBVZXI61a/08VcvKS7heKKV2g=;
        b=h4s6bzXK6jbFajR4totZLL3pGpcCvcfAE6ZFjnDxX32rMVRNiTHHrN3NVPPDdkDO99
         c8F5916Ew+HMqgaiykKrPCrkKHlS5OeDOet9tOcKJIGygAsXO+7TxhJ+V7aWGJBOpIpU
         /eSBLJdJ4Iv8HuGliSUFqbxkBsB/G+GcKLZBpKDti6gZHS+29Pcb7ih9M2quzjySoRkr
         m0bZyu3sedQ4MoeRtefZPOgKu4N2nsC6t+s/4kJqgBcJLC5RBZEbqZTRamoYVyqHWsrk
         rkGmbqOK2zxvssv5twJjuUAa0uR0oX+KOORP3PkveepcrfDUlYSGhpCzeP6KMUl7b+I+
         b3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSwK6RRjbzNVQwnKp+oBVZXI61a/08VcvKS7heKKV2g=;
        b=0LnuzyzLkJv9gUu8PqUEAskWcPdbTQebbEhRSbXfvjwmwQ1y2iaiIz/Lx06c0H4heR
         xDV79deStmdzwBuHsVrYHpWPE935FXEYTJDW+REyWF+2cpqKipo3RQjGB13OA7AQcVKz
         NYpitirVZnBb0le4RFI6MS0GrYVZexRzf8nqaJr4mC3ALa0bVOuzSdSHDnfI7gQtKrAf
         mCUkzt/IZhNEhihBmX+MQSW4B+iwQDoE6005ptjrEsX42hO1Myx0u6SNfV6oD9N+qOza
         g/T4uOTARhmFf91GPv95PHeBedFW6djVipfMlljpLT9ia7v0Qsqa4W5XkeECdRh0c75w
         sVuw==
X-Gm-Message-State: AOAM530euUUG9Sdzq9sfaMdSzbYbzoVKCtRNpn8VxO/GEN6qD8AT6KhK
        +WbL6tPO+ZaMTYkDsFOyRVE=
X-Google-Smtp-Source: ABdhPJxeUu1OamV4npdmAvvs1z4UWQFLFmo8u9WTAH2gEzB0pzwxk3PQzb64+K9XOfPAl42K1fMsgQ==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr5838778pjq.140.1644682122847;
        Sat, 12 Feb 2022 08:08:42 -0800 (PST)
Received: from localhost.localdomain ([212.107.28.166])
        by smtp.gmail.com with ESMTPSA id x23sm31170280pfh.216.2022.02.12.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 08:08:42 -0800 (PST)
From:   Yu Huang <diwang90@gmail.com>
To:     perex@perex.cz
Cc:     diwang90@gmail.com, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Sami Loone <sami@loone.fi>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2019
Date:   Sun, 13 Feb 2022 00:08:33 +0800
Message-Id: <20220212160835.165065-1-diwang90@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legion Y9000X 2019 has the same speaker with Y9000X 2020,
but with a different quirk address. Add one quirk entry
to make the speaker work on Y9000X 2019 too.

Signed-off-by: Yu Huang <diwang90@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8315bf7d4c38..9473fb76ff19 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9170,6 +9170,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
-- 
2.34.1

