Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E6472FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhLMPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhLMPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:01:53 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF759C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:01:52 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso3952350wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T7ZsL74YHfrK4rku8LRlqTa6ouyF11q8KOjqIGzbLUg=;
        b=Xpf41EfT0t5rN6abRKDGUJC8e1FeR3ypM3sEkxaAzW1QQ7rEzsKsDTPSCAzoULSwuU
         YkQ8q8TgxxwCnj0CptNrdov46KhMh/GypUzU3OuCj7frhMIB6xaB5H9vVlRb9MCcqwYl
         bAAJJ6OuLPHpeXe4F6ancZOReWQHmPMfufUHrh9aVhpljSnupm5+y6ErQXq419XWJln6
         JkTgaGsOZgGfem9Dgt14m+Qsud+/yFkQBShzajdJ7aRvYxFuENsASHGh0wmAf9lnR8y3
         CPFt2sUMXwmMYB6BI6Vt5rWpCu53u+8ficB2N5vO5GSobiY0fXEyto6HTSLq+aQlYvWV
         btbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T7ZsL74YHfrK4rku8LRlqTa6ouyF11q8KOjqIGzbLUg=;
        b=1zOhWs2BhkK4ptPIi0lyD38t+ViocrT/aG4PmfKEfkNobXYoMl/Cw8NBx9NWt307ow
         2HdPpHeO2rKiU72JxmEqM9pO7BaSOEjjZWs418uIiQvgwXD78pmsqEqXHwuBoSdk4jKv
         9D02jN0ocwdOWv5zhHfSeQppFq2Dqv77//foUJ/IsNELnH5b+yUFwLFHAvG0M4Wc+9WJ
         Npvhv9xUZ7sZCxydTSNMT+zpRIUAI7Ip7Cnxnl5dcwQEAwY5KNr5CYudvX5rPKh1Ajlc
         2CRXFtCj7P9VS2xDKZVINBPHbw1/6UbKmdq/WpigMAqCDsvLreqym2DpeF94tWW+M3a/
         DOvg==
X-Gm-Message-State: AOAM531hDAP434hD+JIRGS1bKbvqQC3K602kyR6FEm9TSYyh1l+QaW5h
        y58kengsF60qQRC9qjxF3uJXn3rXSAo=
X-Google-Smtp-Source: ABdhPJxyjj1Z9/q85KUVIZ0KP3MTYl53m1c0NKGgRJxJF50ylGFX6fTWvt+JoPlyNVxRTNl89t21TZeJpfw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:b44d:3c17:9f9b:c6b1])
 (user=glider job=sendgmr) by 2002:a1c:4e17:: with SMTP id g23mr40036711wmh.158.1639407711022;
 Mon, 13 Dec 2021 07:01:51 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:01:46 +0100
Message-Id: <20211213150146.4000441-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] Input: psmouse: check the result of ps2_command() when
 detecting devices
From:   Alexander Potapenko <glider@google.com>
To:     dmitry.torokhov@gmail.com
Cc:     dvyukov@google.com, elver@google.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Execution of ps2_command() may fail, leaving the device in inconsistent
state. If the command was supposed to write into @param buffer, that one
may remain uninitialized.

Ensure that ps2_command() failure in device detection functions also
results in them returning an error.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 - add checking to PSMOUSE_CMD_SET* functions
---
 drivers/input/mouse/psmouse-base.c | 73 ++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 0b4a3039f312f..9dde7fd818136 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -546,13 +546,24 @@ static int genius_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4];
+	int error;
 
 	param[0] = 3;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
+	if (error)
+		return error;
 
 	if (param[0] != 0x00 || param[1] != 0x33 || param[2] != 0x55)
 		return -ENODEV;
@@ -578,14 +589,23 @@ static int intellimouse_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[2];
+	int error;
 
 	param[0] = 200;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 	param[0] = 100;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 	param[0] =  80;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	if (error)
+		return error;
 
 	if (param[0] != 3)
 		return -ENODEV;
@@ -611,16 +631,25 @@ static int im_explorer_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[2];
+	int error;
 
 	intellimouse_detect(psmouse, 0);
 
 	param[0] = 200;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 	param[0] = 200;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 	param[0] =  80;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	if (error)
+		return error;
 
 	if (param[0] != 4)
 		return -ENODEV;
@@ -658,17 +687,25 @@ static int thinking_detect(struct psmouse *psmouse, bool set_properties)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[2];
 	static const u8 seq[] = { 20, 60, 40, 20, 20, 60, 40, 20, 20 };
-	int i;
+	int error, i;
 
 	param[0] = 10;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+	if (error)
+		return error;
 	param[0] = 0;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	if (error)
+		return error;
 	for (i = 0; i < ARRAY_SIZE(seq); i++) {
 		param[0] = seq[i];
-		ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+		error = ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
+		if (error)
+			return error;
 	}
-	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	error = ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
+	if (error)
+		return error;
 
 	if (param[0] != 2)
 		return -ENODEV;
-- 
2.34.1.173.g76aa8bc2d0-goog

