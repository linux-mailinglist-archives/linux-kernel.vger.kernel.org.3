Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA95739E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiGMPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiGMPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:20:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990463C8CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:19:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so615514wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6cQzIVXOIBGsoXiuif7G7saQrxwRpZyrgHwFA3owXw=;
        b=UbfTqu9UK6HYMNNZQE81zT8rSE22hs7tx/XmkR6naxIYHSRGj6AEx6AltM1hsmzR4F
         4bXiETy55+RlwNvk1IjEOCCbrBKWjYwh8FJes5Nj5Gtm0KJ0htpOIJcD7Hqwk2zDs7Iq
         TdthzJ+MRMfxWgMott1HwM2DG2cj/Ltjf6j/wAqI5snSDTfKrvkC9XrwI0qTjTRcvv+c
         5LWJTTUyjFR99MZfzZv0TGCrJP0PiIujZlTZZ4o1r1cfo8P2cE8WuqC3pSDEs4JlOAeL
         YWJ0AJHbxRcc0zRWjx++Lf/SLw0q11YGW/x+ml0SCKTD9TzAh2NljacWhysNuOeW9n9o
         irzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6cQzIVXOIBGsoXiuif7G7saQrxwRpZyrgHwFA3owXw=;
        b=CdQ2BS2aTu60nOrAp+/36gAAe3F/BdoWJjdkwHrsEWyTOpegBXejP1L78JsXKLsVSJ
         x4s65oWPBx1wE2DbtaCDBawT49CnLCq22a28mXKnsthlhHAjCITPrHWkuiH1z9PcxLmS
         5mnxER8YlAoW46c4vEF5MwBQtthXy+tPkXvVu/68xrz1vsjtWJoNFWyLCrTDoYCBcMjB
         5HXYzoJ0L1kR1/WIXmV3soB61LzRF8Ch9cvgJlTIHU9SQq80HrtX+XiIfXyz3n4vAJGt
         QUiV+izIYjKFrl0ycwvf65maIBgFm0XjFz26n08TY7LqtzXO+TRV5v60lWdq3BTwaxFr
         I/Bw==
X-Gm-Message-State: AJIora8w8tGbXpdAA1ZkhWn88A49FSEWevdQKF7uTUG00W+rpIkKEa9s
        1OQonsTR0cinZ3SyydqheqI=
X-Google-Smtp-Source: AGRyM1vdjvXKJQAC8aIpaLRCPxjr+/igY107IqJbiR9fjfmShIfWeDr52ubwhRVrPyxEKfoziD1OXw==
X-Received: by 2002:a05:600c:1e20:b0:3a2:e540:17ad with SMTP id ay32-20020a05600c1e2000b003a2e54017admr4151536wmb.205.1657725598094;
        Wed, 13 Jul 2022 08:19:58 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c355000b003a2f88b2559sm2329150wmq.44.2022.07.13.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:19:57 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Use atomic_try_cmpxchg in ep_state_update
Date:   Wed, 13 Jul 2022 17:19:46 +0200
Message-Id: <20220713151946.4743-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old in
ep_state_update. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index f9c921683948..0d7b73bf7945 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -133,7 +133,7 @@ static inline bool ep_state_running(struct snd_usb_endpoint *ep)
 
 static inline bool ep_state_update(struct snd_usb_endpoint *ep, int old, int new)
 {
-	return atomic_cmpxchg(&ep->state, old, new) == old;
+	return atomic_try_cmpxchg(&ep->state, &old, new);
 }
 
 /**
-- 
2.35.3

