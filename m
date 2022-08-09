Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9E058DF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbiHISmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbiHISlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:41:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CA46DB5;
        Tue,  9 Aug 2022 11:15:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so6690568wmn.4;
        Tue, 09 Aug 2022 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qeKkefaI8rAn6PdLcG/BjASCBCjakKAMrlqG8PzJfoA=;
        b=RwC/xY4OulFkweCDNYiIDHC75IPHlmscyLW0IFNZlASwaL1YDJssP6ge2AAidgxRkZ
         n2ipv+eiO4y4YB9hMs9YkZTAO7Uv4qHxO+GHHQZb+uWnRcvBBiLf9PzTjr/cPaX6OdeI
         9LEAKdypsqmb1z7l0YfE9L9HTn4YJ76MRWkrD4eBTteqn3Yii+6wK+DWFDmqsjvyR04O
         1ySxFpK/0mHEjHd3o6gpf4IKAa9NSlFbCLKIRz0G+2RrsyI89SmbmP9TE5nmvekfCZ1f
         a2bX2X4NIwEgNJT9erGmmlaxEw7Ysr2rHuZcfLMcxmth+9cAfSJ/8vlmFCw0O0pAqtwZ
         jWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qeKkefaI8rAn6PdLcG/BjASCBCjakKAMrlqG8PzJfoA=;
        b=ZSIeDk2Vxzk/KCvuPjQ16UOQudPneDKFaxFfw6FTCZR1ndUexuVaVt7TdDrchssXzK
         CfDkw3w5yDEaZQrXnvZSK19bovmMX9sJN7ZDz3KXeXYb780woXtIOLdExPGrGH++VyFn
         5xxqxMMnvF/NmCVmeUzxSshRpQXfMvtFkmJ1HFPa48pUZJfrg6o0ZZagF5/eIEWVvshu
         KhJTDiRaw8uMpZCrx9zNpoaPMF1fFWlcJaAA8ly8AlUw5rHIA7UFk4pZeZG5a4Il/4tU
         sZXg3aVK5wu9W7LxzNx+zLJQn7hYlAQUCZh2gVI+NgaKtE656lYn8HKjqccz8sUlYsR/
         CfMQ==
X-Gm-Message-State: ACgBeo0JHntogmAIUaplzJSH1iih18NJATYz/rnQPIObCzIj1IXgltdQ
        njqY1xK+S/XgYyRyFBpFj3Y=
X-Google-Smtp-Source: AA6agR6tWoLJjD3AvKZPvfi984GJjILsxOkx4GUwcfw9X+CWLNACfY6ZAkRPNXFxZEZYAxxvJp/WGg==
X-Received: by 2002:a05:600c:1e83:b0:3a3:3ecb:52a0 with SMTP id be3-20020a05600c1e8300b003a33ecb52a0mr21965836wmb.44.1660068946370;
        Tue, 09 Aug 2022 11:15:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0021ea1bcc300sm14272737wru.56.2022.08.09.11.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:15:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: make read-only array marker static const
Date:   Tue,  9 Aug 2022 19:15:44 +0100
Message-Id: <20220809181544.3046429-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array marker on the stack but instead make
it static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e692ae04436a..d45d1d7e6664 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1269,7 +1269,7 @@ static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
 	unsigned int wrap = subs->buffer_bytes;
 	u8 *dst = urb->transfer_buffer;
 	u8 *src = runtime->dma_area;
-	u8 marker[] = { 0x05, 0xfa };
+	static const u8 marker[] = { 0x05, 0xfa };
 	unsigned int queued = 0;
 
 	/*
-- 
2.35.3

