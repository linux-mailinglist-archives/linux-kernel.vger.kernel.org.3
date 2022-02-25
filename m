Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3E4C45CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiBYNRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiBYNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:17:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2F10529C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so1707281wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XTcx6NA+RQ7MrRz6erOyIo9MPO/gFX50RVxH9xCKjl0=;
        b=TilwzgfHDxKOx/pX82iJYs6OJLFY4UDPTF+ZYP5IKGPFUaMDON+xOE0825j7T9YE8X
         a2R9Uxm1yhjJl5IG/6s0fvarQFcsIb4HW5dhmafsqg/OuXWuKy5X5xNiLWUIoe3kBHDx
         eVDb8sXoTuqdkn3fdcgNtHrvjBTXJq6+YNK8RHzhi8bRYJkNguNTDu6n7TO4pPQ0JyIL
         uMbw2Tijh0n2PvZqsZFkxG3Byg1nQpSdBkH5DlKN2sbGMyOgfjCU5v94XL5DDM9kgeJR
         y6H1M4dqSGcHjiIE4fSO9NiZakN559mhIgmE98QRnZtf6F77dQ/ubEYHDsWurek925wt
         FZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XTcx6NA+RQ7MrRz6erOyIo9MPO/gFX50RVxH9xCKjl0=;
        b=wdd8ALcDjVK8x1bJ3PDAFnfHct51xyvNzY9cD3EB3fFEZVYvurMDa0/RbvEyEsZ0vt
         YyNa4DKDta2id1cffoWuKsChDlE1TKjE6vWZS10R3BvIm9/Updz/D1ERYNJJjYu6dUbA
         /vR3RxXeeIevlMURQkGndG9QtCXUCDM5uEgJR9hHnFDE/ct0XMPcPaiwS6hVAi4DbENH
         bP28LfY8mVV1R4tqt3ATFXXYtbY1d4rMvA/SLFjx9LGrCMg/sPDu95a7GAF7hP80HQkq
         QTC4H40GfZFqlub6Pb5z0zjNcG8UqjeGrvVD//GItJrkHbtbOk6q/2YL9SkKqRHa3Hy8
         6pSw==
X-Gm-Message-State: AOAM5320VOOSD9RCMmBomujYMHRWD4QsVSDHvJ5W14d83RzDlVWYnL1+
        pKH+dDQ1vIuWpAhQaVqn1aw=
X-Google-Smtp-Source: ABdhPJxAYkjJ40G8FdiQzxsRqYdXyS40BfhXptDhQECQEq3ENt/7NSjM/te1yvnNMfubRDVpAY9fPA==
X-Received: by 2002:a7b:cd96:0:b0:381:201e:ba06 with SMTP id y22-20020a7bcd96000000b00381201eba06mr2739917wmj.78.1645795027288;
        Fri, 25 Feb 2022 05:17:07 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm2399355wmc.47.2022.02.25.05.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:17:06 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, AjitKumar.Pandey@amd.com,
        vsujithkumar.reddy@amd.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: acp: check the return value of devm_kzalloc() in acp_legacy_dai_links_create()
Date:   Fri, 25 Feb 2022 05:16:45 -0800
Message-Id: <20220225131645.27556-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_kzalloc() in acp_legacy_dai_links_create() can fail,
so its return value should be checked.

Fixes: d4c750f2c7d4 ("ASoC: amd: acp: Add generic machine driver support for ACP cards")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index cd05ee2802c9..5247015e8b31 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -556,6 +556,8 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		num_links++;
 
 	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_links, GFP_KERNEL);
+	if (!links)
+		return -ENOMEM;
 
 	if (drv_data->hs_cpu_id == I2S_SP) {
 		links[i].name = "acp-headset-codec";
-- 
2.17.1

