Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5A4EFFCE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353914AbiDBIxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353915AbiDBIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:53:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048014966C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:51:10 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j83so5069947oih.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I03BMhkhj8iUIyy6XKaip4rxh8dASQlWGBFPFtcJdU=;
        b=FTQnQB4RlP3zZc8B3BA+1eM/3K0wyc2lKQ8spNFzXfOuhkw+LPAo3EenZqAm3VsLNG
         O6MYIFrLuWy/9kEp8Fx5FPl4IJyWLlWRnaRJIR4xYrBPv21tH9G8DR6tIYqxLf5ohudb
         4VOxLKrfGtiCogxWe5huTcVVtFWVLWJ9gWyxAbPm0Hvb6Cc1JA2BzYyv1GDxzTgN6cR5
         snTCDBmZN1gTH9c9pkUFjpWEJNg6Qj0R2FK8XjwXQN7wb4l1gES6PkoQhqWpJq92rSK8
         eWJdudwWL3Bvpsx33/QU0sW6fLMdy+3SUGV8C0jJGZ1ROd/nYZiLdBCHHu+FhkdZdg3R
         pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I03BMhkhj8iUIyy6XKaip4rxh8dASQlWGBFPFtcJdU=;
        b=e8CZ8x+IYJQBSWv/6B1gCq5GTv4yzz1vUrqjFKacUiBLhAIRwQWgsPY0Mb5QOpgV0L
         QebzI6mVlEDTyIMGtn7ZXCvZ9hJ8wQYCn3eb7cbhbuZf5ycDCjAp4hP8TUEXjvufpC7n
         AssKiQN3lcDECeZoQPGGK4Al8ckV4z7TCJPu/CXKX/ela48fTVS4b0ktGiL5evAnsvjR
         R+6ljUYDXLv9Y1BrjAl5i0uKHgoYzsfDZkP/dux7+CEVMQ+f7YaBLdtD1JhbsBmLUf63
         4IGfdYbJpsqcUpc/BEbKuicYG4vNOh6LxgrHqoN4ThU+3wed+8c15Itqj7sdAjpQSg2E
         z1uQ==
X-Gm-Message-State: AOAM533tDBqaOLf8BLijVnFF8Xy7IczvrvY1VPL9Qts8KPQ38EH6bdVS
        nH8FNxeroKsWzIDeU6ITaY15vYxfUe3OTA==
X-Google-Smtp-Source: ABdhPJxcoDXIsrCQCP2NXq0IjEK+agNI7HeBDOb9L7IomsnximUZErN4osvarEdwaze5cYmP7ka5bw==
X-Received: by 2002:a05:6808:9ae:b0:2d9:a01a:4bf4 with SMTP id e14-20020a05680809ae00b002d9a01a4bf4mr6201939oig.283.1648889470205;
        Sat, 02 Apr 2022 01:51:10 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id o18-20020a9d7652000000b005cbf6f5d7c5sm2146637otl.21.2022.04.02.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:51:09 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: place constants on the right side of tests
Date:   Sat,  2 Apr 2022 03:50:43 -0500
Message-Id: <0f3db3586b3668d6d784e075bc52ffd88b0920d2.1648888461.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1648888461.git.remckee0@gmail.com>
References: <cover.1648888461.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4fda2fe07ecc..3b282c387282 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -189,7 +189,7 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	cmd_obj->padapter = padapter;
 
 	res = rtw_cmd_filter(pcmdpriv, cmd_obj);
-	if (_FAIL == res) {
+	if (res == _FAIL) {
 		rtw_free_cmd_obj(cmd_obj);
 		goto exit;
 	}
@@ -260,7 +260,7 @@ int rtw_cmd_thread(void *context)
 		if (!pcmd)
 			continue;
 
-		if (_FAIL == rtw_cmd_filter(pcmdpriv, pcmd)) {
+		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
 			pcmd->res = H2C_DROPPED;
 			goto post_process;
 		}
@@ -613,7 +613,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 		res = rtw_enqueue_cmd(cmdpriv, cmdobj);
 	} else {
 		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
-		if (H2C_SUCCESS != disconnect_hdl(padapter, (u8 *)param))
+		if (disconnect_hdl(padapter, (u8 *)param) != H2C_SUCCESS)
 			res = _FAIL;
 		kfree(param);
 	}
-- 
2.32.0

