Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136DD4FA148
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbiDIB3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiDIB3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03817E7282
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:27:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bq8so20391579ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V20ogy15QSuxdpuKVHUkoJksm5vVNKi7GT1C1mjhHXY=;
        b=PMKYe/MXNHQ+p5OXztmFPRWaEC1Yh/8Z7y/lFaauLXrJHr0SJsxzwqHu53EnbrQdEN
         pHP535YndBGM5B+L/tv/Sd58GLIZCxRx1a946l3Xf2hKP6MAf9g5zZ65C4pLkp2UFDGo
         J/SEV7vPj/lOggS4oKQd+Z3iTdn/jd0JyMWogLMw/LsaJ9zt3DF620uKA6C4W10cLMfA
         bpd3PH8Cv5sdALTQIRoS1GDhVZJwYzAGzbVzTzRU3yoZnMqDYvUT9bVEKrOhaTud3iKt
         Pc2WV/vxhE8E9ac2HFtuVR+FBsxuL2Xxq+Ifv9EgdhlefQLznkKQZ2A0CU1oPkJBT0WL
         Xgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V20ogy15QSuxdpuKVHUkoJksm5vVNKi7GT1C1mjhHXY=;
        b=1mhgM7CI+1ylLWDNLpUGIHE+mIdZrNrlAadpd8HvtF3C/kWjUhl+gqdox3/fGCZ76A
         fc2C/V7X7AHaO1mEG9nlkr6yaCknNA+RBgrgfCbf6Q0Hlilv/7RbZfzyuiOPWTEmswZO
         KHunNJXF2V1dUH+5lKpsTSCWACcpYIQn9LjTiYPaV2t7PqsadBi5LVEqhiAxqYsHpwLe
         tzBXhATco9j8oHGo2mj8H3x8x7nNx4w2nqAvaK5qU7j0OlJxo8PR0ncHmOkOq3zTz1Xm
         ZfkfiscBwdmO0osFw9DoseJVCUegJgkh6LXgVhX2gjFgSqwtyHyrn+/X4HMUXh5JSUqG
         6q/Q==
X-Gm-Message-State: AOAM532HrxCrZedBXXuw/DKCxLCTieBMhYey52kqhBxspXW0jMBa5dQ6
        KahNVLxRrti3sMku0Rka30k=
X-Google-Smtp-Source: ABdhPJzsD4wz47pVoeaUipKgKPbfrsRcc0CT1jwMVHwGIO0R9c+9JHElm5k88QKuJ26PxFEhx0l7Rw==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr21001267ejc.424.1649467619145;
        Fri, 08 Apr 2022 18:26:59 -0700 (PDT)
Received: from localhost.localdomain (host-87-4-4-217.retail.telecomitalia.it. [87.4.4.217])
        by smtp.gmail.com with ESMTPSA id hr38-20020a1709073fa600b006e0280f3bbdsm9265487ejc.110.2022.04.08.18.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 18:26:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
Subject: [PATCH] ALSA: pcm: Test for "silence" field in struct "pcm_format_data"
Date:   Sat,  9 Apr 2022 03:26:55 +0200
Message-Id: <20220409012655.9399-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Syzbot reports "KASAN: null-ptr-deref Write in
snd_pcm_format_set_silence".[1]

It is due to missing validation of the "silence" field of struct
"pcm_format_data" in "pcm_formats" array.

Add a test for valid "pat" and, if it is not so, return -EINVAL.

[1] https://lore.kernel.org/lkml/000000000000d188ef05dc2c7279@google.com/

Reported-and-tested-by: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I wasn't able to figure out the commit for the "Fixes:" tag. If this patch
is good, can someone please help with providing this missing information?

 sound/core/pcm_misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 4866aed97aac..5588b6a1ee8b 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -433,7 +433,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		return 0;
 	width = pcm_formats[(INT)format].phys; /* physical width */
 	pat = pcm_formats[(INT)format].silence;
-	if (! width)
+	if (!width || !pat)
 		return -EINVAL;
 	/* signed or 1 byte data */
 	if (pcm_formats[(INT)format].signd == 1 || width <= 8) {
-- 
2.34.1

