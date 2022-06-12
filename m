Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137A654797C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiFLJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiFLJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:05:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094619D;
        Sun, 12 Jun 2022 02:05:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so5687843ejg.13;
        Sun, 12 Jun 2022 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUOlWIxQiOg7kBTKt6fHp2ojMo1J1FWT8vKkXq6OhaI=;
        b=mmXn+bGOYLkL2y0A3ELZ2gA97uEjiYwL2v9I8ibCTyYVZIs4+X1NWXXPpJM+NYi1do
         ien8zbKagbgUmxKHA3F3CcMvPQeNTJVCoN5zL9R6XV00fsmBdX+5WD2fJ1xRwgnumr3f
         9+WAziVmvxlBRl6ANBntPH882A/nMHYqwnYBetO+nEuYeNOWtqRXVmelfyrcxqlVjUBE
         cXm7/eycCPzmbSHNcCSkdXpFsJKGtAqNq8HllzNmGAgK8Rw0NLxAa2nMHbnoPJbRB7OO
         hXfFOd5O0qGeXTCREiCfbgnIIHbuoUdtQbzTO98J3E8VfqKsjm07zZQ4btxz5UNxeu5T
         jlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUOlWIxQiOg7kBTKt6fHp2ojMo1J1FWT8vKkXq6OhaI=;
        b=JsmByGxOTvHRt8A0S3zh6qCeeaIe+Co81TLbcgTw7g3Tjru/WxTVDhq9D7FYuLj8VN
         9uF0jRrb66NkFJ9wRnznhw4NPgcnlLd9bu2zOrX/Nspp+W6Sdcij7jZkQdIrdZaxYYgW
         EyDVfbi1AwvrpdxlYJQ0ydj8GfmNVHQ5Dt5inWO9BUrRkxV5+rNlK500VgAsXM+HBreC
         Q1Kg5sZmYqDmM837wc4B/c3gNkrKp+o0L34kUWLnTo0PfsRCFEtMH6t8rkEpoASibYAt
         hiyT1fR/aAcre+8s790caqVy4DOpsSR3wih8zJGdoSANP0PnidgYRu9ZAsZYcgyFxbLO
         rABA==
X-Gm-Message-State: AOAM5317qZgsBEwaXqBzsVHA1L0+QLOCS+rmB6CKI6BokvoUlCBIzMLp
        Wcejm1uTgd9fXb/NvZv9UYY=
X-Google-Smtp-Source: ABdhPJw8/uBxI1gqB5aFdCRUTYC+d/c2PQEx3+X27+AsyOtXmWuxKAuLDl0b5r5N+kMhvtVlPOeSew==
X-Received: by 2002:a17:907:2d8b:b0:711:f167:c818 with SMTP id gt11-20020a1709072d8b00b00711f167c818mr20408003ejc.318.1655024752592;
        Sun, 12 Jun 2022 02:05:52 -0700 (PDT)
Received: from strolchi.home.s3e.de (p3ee2bf2d.dip0.t-ipconnect.de. [62.226.191.45])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7c7d2000000b004335e08d6c9sm2860075eds.33.2022.06.12.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 02:05:52 -0700 (PDT)
From:   stefan.seyfried@googlemail.com
To:     kenneth.t.chan@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 1/2] platform/x86: panasonic-laptop: de-obfuscate button codes
Date:   Sun, 12 Jun 2022 11:05:06 +0200
Message-Id: <20220612090507.20648-2-stefan.seyfried@googlemail.com>
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

In the definition of panasonic_keymap[] the key codes are given in
decimal, later checks are done with hexadecimal values, which does
not help in understanding the code.
Additionally use two helper variables to shorten the code and make
the logic more obvious.

Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
---
 drivers/platform/x86/panasonic-laptop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 37850d07987d..ca6137f4000f 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -762,6 +762,8 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	struct input_dev *hotk_input_dev = pcc->input_dev;
 	int rc;
 	unsigned long long result;
+	unsigned int key;
+	unsigned int updown;
 
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
@@ -770,18 +772,22 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 		return;
 	}
 
+	key = result & 0xf;
+	updown = result & 0x80; /* 0x80 == key down; 0x00 = key up */
+
 	/* hack: some firmware sends no key down for sleep / hibernate */
-	if ((result & 0xf) == 0x7 || (result & 0xf) == 0xa) {
-		if (result & 0x80)
+	if (key == 7 || key == 10) {
+		if (updown)
 			sleep_keydown_seen = 1;
 		if (!sleep_keydown_seen)
 			sparse_keymap_report_event(hotk_input_dev,
-					result & 0xf, 0x80, false);
+					key, 0x80, false);
 	}
 
-	if ((result & 0xf) == 0x7 || (result & 0xf) == 0x9 || (result & 0xf) == 0xa) {
+	/* for the magic values, see panasonic_keymap[] above */
+	if (key == 7 || key == 9 || key == 10) {
 		if (!sparse_keymap_report_event(hotk_input_dev,
-						result & 0xf, result & 0x80, false))
+						key, updown, false))
 			pr_err("Unknown hotkey event: 0x%04llx\n", result);
 	}
 }
-- 
2.36.1

