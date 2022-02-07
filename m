Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533594ACB42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiBGV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiBGV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:27:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86AC06173B;
        Mon,  7 Feb 2022 13:27:41 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id o12so45963995eju.13;
        Mon, 07 Feb 2022 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyoX70viWcISJKTm1q/6fX8AdMTRX67Z6K886m2paA4=;
        b=bxZD76ydAG36dw8EHhlZJK0pOS8dKpyktaZj7qpkYRim7yRlyjbKy9aqNygVZ+pJIp
         8rMJM6w2STI6yyA9rdM+du/pypvNUOJc9ObmqwMc6+8AQlOfjTSpHjwCsBqKEu4z2qTG
         9IoKVn/TwWyPfF7BDPor8RmpNXE85SoBMy6F1lpOTN1onRH+tBRGZDSQ6Aj3BWIz79JU
         QDgb5WEt1fpeNnizIHM/QDxB0R9F2NugskJfVFskrmLQmu9MFhyrE7+Jd2EFjNIWi5iA
         gVLaSDlllAtRab6ELriV3pnpYpFHAw/rWgcba9xuaIeSokCxTJBbyXHACYGQ/ucSRpq0
         dP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyoX70viWcISJKTm1q/6fX8AdMTRX67Z6K886m2paA4=;
        b=MMiOOYG+oE9r0IwPZSg3ygAIOhHyNtHLlbzg2h56cTNUuRpGo0BzYRgdIVzAGzLIEz
         Lme2AD4AzGoUMKe2bzN1RvTPD7kQVU0BesGwiy+a6UnZUm5fzU6RGY01jeOVXMaBQK5F
         NyS/P1O6ADMyRewI68KGIwrs0LdowW97+hdExEQlIgJ5+b7e+S8qwO9T/tBRrmy387IQ
         C9GxkZnzQBzf20neY59tzjmK2m/Gj1J6PZRG86trHgX5sj4Km0r4yZbmS1nGNXrtRa0F
         yvJy+BRAQp3yq0N/3s29yGVUVs7jKDyehH7qs1IUUIo0i52ieTudgBisU2/YNomtJk0G
         5EaA==
X-Gm-Message-State: AOAM530FpPYZSzhuddkoie/SbVvn3IdFpSRtpb/zA0wrg14BBWl0cQZV
        LXjPCVU6kE0gtdgicfOFCJ0=
X-Google-Smtp-Source: ABdhPJyRjBcXCnHm986FOfpo04veZN5uaGA9kjkDf7xRhASkRNj08RR2GTpAn9kg/KEwJZ2t3/AI7g==
X-Received: by 2002:a17:906:cede:: with SMTP id si30mr1233209ejb.669.1644269259720;
        Mon, 07 Feb 2022 13:27:39 -0800 (PST)
Received: from localhost.localdomain ([178.94.5.59])
        by smtp.gmail.com with ESMTPSA id c20sm3968086edy.41.2022.02.07.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:27:39 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, eugene.shalygin@gmail.com,
        Per Melin <kernel@melin.net>,
        Jaap de Haan <jaap.dehaan@freenet.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6775) add ASUS ROG STRIX Z390/Z490/X570-* / PRIME X570-P
Date:   Mon,  7 Feb 2022 23:27:28 +0200
Message-Id: <20220207212728.9749-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boards such as
* PRIME X570-P,
* ROG STRIX X570-E GAMING,
* ROG STRIX Z390-F GAMING,
* ROG STRIX Z390-H GAMING,
* ROG STRIX Z390-I GAMING,
* ROG STRIX Z490-A GAMING,
* ROG STRIX Z490-E GAMING,
* ROG STRIX Z490-F GAMING,
* ROG STRIX Z490-G GAMING,
* ROG STRIX Z490-G GAMING (WI-FI),
* ROG STRIX Z490-H GAMING
boards have got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

This commit adds such boards to the WMI monitoring list.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Per Melin <kernel@melin.net>
Tested-by: Jaap de Haan <jaap.dehaan@freenet.de>

---

I have rechecked all the boards by extracting[1] all DSDT files from UEFI 
CAP files that can be downloaded from asus.com site. And all boards have
fully same WMI methods implementation. I have saved dumps to [2].

[1]: https://github.com/theopolis/uefi-firmware-parser
[2]: https://github.com/asus-wmi-boards-sensors/asus-board-dsdt

PRIME X570-P and ROG STRIX Z390-F GAMING are checked with real boards.

---
 drivers/hwmon/nct6775.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index fbf6266c7ba7..1d63ad363658 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -5109,6 +5109,7 @@ static const char * const asus_wmi_boards[] = {
 	"PRIME B550-PLUS",
 	"PRIME B550M-A",
 	"PRIME B550M-A (WI-FI)",
+	"PRIME X570-P",
 	"PRIME X570-PRO",
 	"ROG CROSSHAIR VIII DARK HERO",
 	"ROG CROSSHAIR VIII FORMULA",
@@ -5119,9 +5120,19 @@ static const char * const asus_wmi_boards[] = {
 	"ROG STRIX B550-F GAMING",
 	"ROG STRIX B550-F GAMING (WI-FI)",
 	"ROG STRIX B550-I GAMING",
+	"ROG STRIX X570-E GAMING",
 	"ROG STRIX X570-F GAMING",
 	"ROG STRIX X570-I GAMING",
 	"ROG STRIX Z390-E GAMING",
+	"ROG STRIX Z390-F GAMING",
+	"ROG STRIX Z390-H GAMING",
+	"ROG STRIX Z390-I GAMING",
+	"ROG STRIX Z490-A GAMING",
+	"ROG STRIX Z490-E GAMING",
+	"ROG STRIX Z490-F GAMING",
+	"ROG STRIX Z490-G GAMING",
+	"ROG STRIX Z490-G GAMING (WI-FI)",
+	"ROG STRIX Z490-H GAMING",
 	"ROG STRIX Z490-I GAMING",
 	"TUF GAMING B550M-PLUS",
 	"TUF GAMING B550M-PLUS (WI-FI)",

base-commit: 74fa97c35a74d62a34e120343520e74c50329372
-- 
2.34.1

