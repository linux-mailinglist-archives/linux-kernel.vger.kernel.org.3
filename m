Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE40496367
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382007AbiAUQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379858AbiAUQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:49 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6995C061769
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:55:36 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso12495062otj.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaU4VG8N9CoVLuyvuF8eKASeQ+KGlO318g0VjIU083s=;
        b=h5ng4rGJAP8Dw2GzBBkwMcUMgwOH/C0MM674tyPWcagZpg5a5cPerPWSPK9gZ/q+SZ
         aGijwYdlRIUg87bxdAGcJFIiMjPJf5at0voT815CKdmYzHDrr1qrsq9nqLlP/evlL3o0
         e++guAbfsQxsxNK5JbI+IvV65L7FGZUv9HJOOXckrW9NyOZhC6k6Zw/GDczbvSxKGkLJ
         D5QMucQtMB28DMsAvGJduBLGkw4fHUcbACqPG0NvBVFU8hqNEp9mtfGdznqUX+cyRAHh
         lj5cW9oSn6tQweYPwYEqO3NRL3UzaW5LVqKul2TTano8i6rbANy18HV2wayUJxPdgJDZ
         /sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaU4VG8N9CoVLuyvuF8eKASeQ+KGlO318g0VjIU083s=;
        b=6m87ARSMT5/eA7Ogg/IKVgQCVJwZL8ZFKaKoO+INF/V+IiZfDpBTIY+i62LrIrWl3a
         a4jQChRVkSYp8zvFYkrqdGdV/e/Tm9Qy/hLuZkoMioEuNULI+Fx4LxcZMBCmMm7+FaIc
         LZq8FNvnpnFZ7n47a7kuGDPpvobnoYXqLwQxtyle+4SbkE0Ys7T/Q0DU2z+btZiZrEHX
         RhsRuzAePkiYdftGMq8zVnI3h5MhckyJqoKxKUB2EdQD4JGAJF2TcLd8iKebOs5Bk+w7
         xyNYBTPH5Sd3LHWu+wL1sYk75cxnIW7HmPIav3REwCEdk4iIU8NePJ7E1CAwhyVFgShW
         Ez8A==
X-Gm-Message-State: AOAM531QzGQiIprCdePlIxQW5DDoRpXi2PKfPPBsZM36The79xtR+v8t
        yMosOrS1wN4cvsCxoVfsKTX7bPBd/lY=
X-Google-Smtp-Source: ABdhPJxB6j58CX46EprCZsW8G6PeZqqSZ6IOoAEGrPdGDyJdeI4cHRGDwsx4dFfMPggbz9WNz7820Q==
X-Received: by 2002:a05:6830:1ad9:: with SMTP id r25mr3397494otc.31.1642784136254;
        Fri, 21 Jan 2022 08:55:36 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:35 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH 22/31] tty: vt: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:27 -0300
Message-Id: <20220121165436.30956-23-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/tty/vt/keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index be8313cdbac3..33bad1973180 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1035,7 +1035,7 @@ static int kbd_led_trigger_activate(struct led_classdev *cdev)
 	if (ledstate != -1U)
 		led_trigger_event(&trigger->trigger,
 				  ledstate & trigger->mask ?
-					LED_FULL : LED_OFF);
+					255 : 0);
 	tasklet_enable(&keyboard_tasklet);
 
 	return 0;
@@ -1081,7 +1081,7 @@ static void kbd_propagate_led_state(unsigned int old_state,
 		if (changed & trigger->mask)
 			led_trigger_event(&trigger->trigger,
 					  new_state & trigger->mask ?
-						LED_FULL : LED_OFF);
+						255 : 0);
 	}
 }
 
-- 
2.34.1

