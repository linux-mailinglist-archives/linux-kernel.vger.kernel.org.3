Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC251D7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391967AbiEFMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392044AbiEFMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:32:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423E6A40F;
        Fri,  6 May 2022 05:27:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dk23so14167318ejb.8;
        Fri, 06 May 2022 05:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqUNvjWc6qfxPvZnmvjPbtp1QQWguZNI9GetenDDpAw=;
        b=cqi4Xo5Zc3oZLNL2p8Mjafx627DEi8TsXDj8MW0s/XP1VJzr2PYmlG978syo4B3A5z
         GWO9R+8yzfg6/0kAZc4VkX5v9s2vyB1HqhKBRREQCZ/YCwZYxJb3HUgei+NJpTljzsh6
         M+0PKWPSBJodsRdD+bheM3mIEPfH0vGNL8SYiWI0mKRZ9+TXPX5UW6LmBOSupzs3wTtg
         by9huPz4nC3HgVFcWFguIfKBd3FTz1g0RfXT3i3nIDizbIIl4LL4M7ZkPiiSzuypbdm/
         ejvmAoLuYxOSelkXtpttvtNPxDPZFPYIZnX7YDX/lkKNrJ5V9Xjxzz7osSEoJ4HJA42c
         yXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqUNvjWc6qfxPvZnmvjPbtp1QQWguZNI9GetenDDpAw=;
        b=VuGur058yFE3K7x1I0ZuL00x2hRBmEyLwXiLzvH2fYSt/FHWo63dxtSC6qU9Y3PQCR
         hp+eQerhpmgdXfWz84Mik/kuC0wYjqv2tEIUEIK9g8xlN8U9Go6RW1uMOZy+4ro429aD
         EVjQgbVK8UKyoQwgIx6Ke6Zb6dweEU3ruAEXokFS+kOJ1443FPE/FwaHUc7IdT5dz6XY
         +3+djmI70XkkgZWAgwCVyFkPcurvy1EGT3xm3AFn7XSVbs4FGoPCGvHxtrQNgKumwe9w
         1auh2KwjUyIWYreeCzLmHNHBWkwqIHojWTC0CiTgm1U2esD7qnnVPSHlrdJBoqzBMMRp
         mwnA==
X-Gm-Message-State: AOAM533YY1PkYWVOYj6x608cqEjMKQxvT/6AS+x7vCIcautgK0SCR/FQ
        LHam3av32Zr300jv8gMqp1w=
X-Google-Smtp-Source: ABdhPJy/R4dOpJZb6mQlM7G3KWqJpA2yIywFotO5FYj8OsBWpXnpklBoQcREQGziCOwgACLdlPIobw==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr2728871ejc.730.1651840064344;
        Fri, 06 May 2022 05:27:44 -0700 (PDT)
Received: from luca020400-fedora.lan (93-51-1-159.ip298.fastwebnet.it. [93.51.1.159])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm2178829edv.13.2022.05.06.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 05:27:43 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        acpi4asus-user@lists.sourceforge.net (open list:ASUS NOTEBOOKS AND
        EEEPC ACPI/WMI EXTRAS DRIVERS),
        platform-driver-x86@vger.kernel.org (open list:ASUS NOTEBOOKS AND EEEPC
        ACPI/WMI EXTRAS DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] platform/x86: asus-nb-wmi: Add keymap for MyASUS key
Date:   Fri,  6 May 2022 14:25:36 +0200
Message-Id: <20220506122536.113566-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506122536.113566-1-luca.stefani.ge1@gmail.com>
References: <20220506122536.113566-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event is triggered by pressing Fn+F12 on
ASUS Zenbook UX425JA

Map it to KEY_PROG1 to allow userspace to
configure it

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index a81dc4b191b7..57a07db659cb 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -553,6 +553,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
 	{ KE_KEY, 0x82, { KEY_CAMERA } },
+	{ KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
 	{ KE_KEY, 0x88, { KEY_RFKILL  } }, /* Radio Toggle Key */
 	{ KE_KEY, 0x8A, { KEY_PROG1 } }, /* Color enhancement mode */
 	{ KE_KEY, 0x8C, { KEY_SWITCHVIDEOMODE } }, /* SDSP DVI only */
-- 
2.35.1

