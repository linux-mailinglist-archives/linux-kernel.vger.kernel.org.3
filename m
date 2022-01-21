Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A82496352
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380551AbiAUQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380405AbiAUQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:58 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4CC06177A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:56:00 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso12545890otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPhrE44c4X8EiRps7ZyTdjyC/DhZv0Ym7BaWgxIimP4=;
        b=P+o+RNbzvnvNZw8S93pq9pgBsfdPWaqUB/OAudqOSe9NOlR3YP4b+RsIyZanHpa4FA
         DPxznSbqJcND87IBpj0udvG60BW2fqsIH7xiHOwBMm2/yNJEA/3sv3B+ClO28zVLlyfT
         Gyq/v/1lDk/iv8tCDRKQmMjYSC9CyEYo1BavdreIiWR21N/KDYDW2H4p9mHMBcy3Q2fs
         cxj/O9hAzSnuXFCc05MShi+3F8F0majPBKW3G1hVGFNYPdO7HEQekJz5m0MVgdm86fgj
         9YTOmo+ecrfdy4UggOG/2IXM+kC9erCkAMdNCCebhMr1IqtUzzZO2xs2MCjGg2Crdqsb
         dpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPhrE44c4X8EiRps7ZyTdjyC/DhZv0Ym7BaWgxIimP4=;
        b=WSJBYnS3VtgiT/hFQGq4ef/c14aYZbT7YocBzEylTwcpDDlYX6rC6Q54Z14/L6X/TI
         PwksDiaaHrAVHnMKWcxb5dFlNTnUk6500S9dIh2+EwFOcwFCM6ugIKPMuWuv5etNDeVx
         MtJmC2ssCv4JNF7UrNeWHI6lJ3+fGkrWvbux7uYOKaU3jY4T4mBs0NZF1ZTvFbSJn4N4
         608vbzm1duuGEbDH0uMBo6roRiORKn+8tz/6Df5Zz8iyxqLaLNG2ElSVagd2na1FDoU/
         +As8stGle5QHL7DBTqEtRW0RycQFfUDZ5OKvzUMqQqc/aYQmYEITZJOXw+rEf7DnpkCc
         Ai3Q==
X-Gm-Message-State: AOAM5318N1wTpOtwL7LZE8gEI+DgpHtTsXi/s0bQgeocnj0A0pKgM/Tf
        gwTjheEKes5tRslfWsTqCbw=
X-Google-Smtp-Source: ABdhPJyHMKAh1594d9L9b4cHpehF1tSuCMmjKBl93/j+Ribj0RM1jbdudMygzgJ8Aqvl8jZjcB1NDg==
X-Received: by 2002:a05:6830:905:: with SMTP id v5mr3330424ott.143.1642784160014;
        Fri, 21 Jan 2022 08:56:00 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:59 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 30/31] sound: core: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:35 -0300
Message-Id: <20220121165436.30956-31-sampaio.ime@gmail.com>
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
 sound/core/control_led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control_led.c b/sound/core/control_led.c
index 207828f30983..ddfac2f5f59e 100644
--- a/sound/core/control_led.c
+++ b/sound/core/control_led.c
@@ -177,7 +177,7 @@ static void snd_ctl_led_set_state(struct snd_card *card, unsigned int access,
 	case MODE_FOLLOW_MUTE:	/* noop */ break;
 	}
 	if (route >= 0)
-		ledtrig_audio_set(led->trigger_type, route ? LED_OFF : LED_ON);
+		ledtrig_audio_set(led->trigger_type, route ? 0 : 1);
 }
 
 static struct snd_ctl_led_ctl *snd_ctl_led_find(struct snd_kcontrol *kctl, unsigned int ioff)
-- 
2.34.1

