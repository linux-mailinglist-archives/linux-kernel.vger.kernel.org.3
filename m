Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752EE54797A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiFLJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiFLJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:05:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DFA517C1;
        Sun, 12 Jun 2022 02:05:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so5729526eja.8;
        Sun, 12 Jun 2022 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vu64RzOJf4/VV9twaNb7oWG1XNBPJ9un68Ks7Bwxb2o=;
        b=W8r7qgMsMG8np/sP2HU6tzocZ4b6xTTFF2Fgh2QyIRC6HLiAyNTX17FswpDu1bzEPk
         uXJigNkboNhsvXUK21u8ZaL09uTw4NGI3+GnV18zgByA1pEToT7B8ZM596GJgit8TmYT
         S4+VtWRuRrXt/p0g6pGQOPW4cMzFuWITSrbY3NlGrA9JTBPTkHXicnZMcs5KMjPUnCjX
         0S5UjJ7ggLfLTThPGSfbiI6OdakNuXRmUMR7r6b3EAdVNZcZvjh72BmiH1gjo1CfzKIy
         IqVdXPuEeNJl8Euj5xPiAOjbq6QrlafDkNT0V/f+/wg7SOJlxJL7R1vZzneq5SR5zGZt
         5T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vu64RzOJf4/VV9twaNb7oWG1XNBPJ9un68Ks7Bwxb2o=;
        b=Uopu3u+Yh+I/gXZKiZi634tWlRaEld2/q0L2crkMUqgmoIfmf6DCn3olvHBLitmvkw
         i8Q7T4Z9G0U+UWhRAXf6C3aILlBGaD+KAElmzO7XcjQpAHKSEIhEQrerweNJqIV7kzef
         PdqLU6/6CkyF1+vf5d1gUnmr+eWvxc3MteBVqZga+H34GT3uhyk7Av1hYl6AsoBjQ37k
         5agjKG9Xr8fFY113Ylzo71zBrsh3wznQhHJwE0lBwjUcrKrXspiyPm+Fzc3SXsBLPdVL
         K8kxEaysOQe82z4iD70Y6dmtRUTpZpjWrENiJ9IwnbKlISvlAcPN517DHd0WKYvDhoM+
         TAXQ==
X-Gm-Message-State: AOAM531vXgqYTl1lWwWY1M7O2SjWh4ZmlxulKPD6rD1cLICB99wqtFmE
        L2/hqSXW5yIeSb/p7IP5goI=
X-Google-Smtp-Source: ABdhPJzfgdClY3PJtaOhWy1MXte40sNGkDjeFo0u2FxCME4MaEM6mWM9WjV42fx21PZlD4KO2AP6Xw==
X-Received: by 2002:a17:906:2cc3:b0:70d:b6c8:f83b with SMTP id r3-20020a1709062cc300b0070db6c8f83bmr44230739ejr.770.1655024754991;
        Sun, 12 Jun 2022 02:05:54 -0700 (PDT)
Received: from strolchi.home.s3e.de (p3ee2bf2d.dip0.t-ipconnect.de. [62.226.191.45])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7c7d2000000b004335e08d6c9sm2860075eds.33.2022.06.12.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 02:05:54 -0700 (PDT)
From:   stefan.seyfried@googlemail.com
To:     kenneth.t.chan@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
Date:   Sun, 12 Jun 2022 11:05:07 +0200
Message-Id: <20220612090507.20648-3-stefan.seyfried@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612090507.20648-1-stefan.seyfried@googlemail.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
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

From: Stefan Seyfried <seife+kernel@b1-systems.com>

commit ed83c9171829 broke the hotkeys on my Toughbook CF-51.
I'm questioning the general validity of that commit, but as I only
have a single machine to test, add a module parameter to allow making
it work at runtime.

Fixes: ed83c9171829 platform/x86: panasonic-laptop: Resolve hotkey double trigger bug
Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
---
 drivers/platform/x86/panasonic-laptop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index ca6137f4000f..83acae75aee2 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -141,6 +141,9 @@ MODULE_AUTHOR("Martin Lucina <mato@kotelna.sk>");
 MODULE_AUTHOR("Kenneth Chan <kenneth.t.chan@gmail.com>");
 MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Let's Note laptops");
 MODULE_LICENSE("GPL");
+static bool hotkey_input;
+module_param(hotkey_input, bool, 0644);
+MODULE_PARM_DESC(hotkey_input, "Send all hotkeys to the input subsystem");
 
 #define LOGPREFIX "pcc_acpi: "
 
@@ -785,7 +788,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	}
 
 	/* for the magic values, see panasonic_keymap[] above */
-	if (key == 7 || key == 9 || key == 10) {
+	if (hotkey_input || key == 7 || key == 9 || key == 10) {
 		if (!sparse_keymap_report_event(hotk_input_dev,
 						key, updown, false))
 			pr_err("Unknown hotkey event: 0x%04llx\n", result);
-- 
2.36.1

