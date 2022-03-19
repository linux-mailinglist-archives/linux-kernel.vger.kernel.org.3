Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF61D4DE76E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbiCSKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiCSKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:23:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBF7B123;
        Sat, 19 Mar 2022 03:22:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so664160pjb.3;
        Sat, 19 Mar 2022 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=GLhF8DmIYKowj6xMrjeMsZUzUdhEYASC8MN5wXTnkRk=;
        b=DvbOItb4RfSJTcx97gtTP9TPRSGCaL6Ne2ZcFfkz9NNIYWzYu2uX0OxgIWT6ltxevU
         h3ztebFOKts09nfSqH8N7pODAC5OuQD+ORDjRphBU8t5y6tOQMTbzvx9qdE2sOpScK+M
         SH9xOsMNpITCwV3ClrT46Qegb7PU6G5O77PZVC1zBwHxR+ODiFGSAA+Dov2UhPdiyv/L
         ExehesMcqsCcZEWfBy/7aepcNsO/A5SMKdIIwANLal90AJwevdOzegxsEIFG2v6Qt40m
         1z8YJ2FicTzB9c55k/7IDKUr3034H3HVIu/NI/01XwvErawmSky4HEHbcNDTqrIBppTe
         LRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GLhF8DmIYKowj6xMrjeMsZUzUdhEYASC8MN5wXTnkRk=;
        b=V0HVTgmcwQUA74LEmyMN8NRlBNYQgtx5Ck2IBFemlnortJ9WpfvbC6JOm0AbJbbOf9
         rn0Mxg8DggPwpryzDMactX7vEGU9oFfEyaedVSbaoBRoJOkEywYE08WxMLeLxkgdyJs0
         Wc2kLRqTFVhHukX9hnxXjq9F73WdIsCcTmXJn6pKEFEpLld5igyVIFtodC9PpkEhPCf7
         4utChNTDsYoDINl3Czu8c0iMnrAGW2VXVRwO632zanM0UrMb/eXzgey5sFVa0vAhBckf
         Mj7ziepZirCFxfaPnXrg3WzrOuIXEf1OlYsnSGGr+mfMJ3uqvgsVQnZgs8PvE2lmEuol
         q3zQ==
X-Gm-Message-State: AOAM530yCx+1IAeMRHPCj8OlLT+Lw7XQnXfl7dGDjInSrOAmv8XohsRJ
        Vx8Gmeu+xnuTps2VtXZSCHg=
X-Google-Smtp-Source: ABdhPJxItdBeuZ986BhxfqVGuHimajxvXr1aVKDHILFU77ZEcHVA9vH1hpJMLIRPP+o1qnAab8Gfrw==
X-Received: by 2002:a17:90b:228a:b0:1bc:7ca4:efaf with SMTP id kx10-20020a17090b228a00b001bc7ca4efafmr15751133pjb.245.1647685350822;
        Sat, 19 Mar 2022 03:22:30 -0700 (PDT)
Received: from localhost.localdomain ([183.157.215.81])
        by smtp.googlemail.com with ESMTPSA id b25-20020a637159000000b00381fda49d15sm7277646pgn.39.2022.03.19.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 03:22:30 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] uvc: fix missing check to determine if element is found in list
Date:   Sat, 19 Mar 2022 18:22:22 +0800
Message-Id: <20220319102222.3079-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list iterator will point to a bogus position containing HEAD if
the list is empty or the element is not found in list. This case
should be checked before any use of the iterator, otherwise it will
lead to a invalid memory access. The missing check here is before
"pin = iterm->id;", just add check here to fix the security bug.

In addition, the list iterator value will *always* be set and non-NULL
by list_for_each_entry(), so it is incorrect to assume that the iterator
value will be NULL if the element is not found in list, considering
the (mis)use here: "if (iterm == NULL".

Use a new value 'it' as the list iterator, while use the old value
'iterm' as a dedicated pointer to point to the found element, which
1. can fix this bug, due to 'iterm' is NULL only if it's not found.
2. do not need to change all the uses of 'iterm' after the loop.
3. can also limit the scope of the list iterator 'it' *only inside*
   the traversal loop by simply declaring 'it' inside the loop in the
   future, as usage of the iterator outside of the list_for_each_entry
   is considered harmful. https://lkml.org/lkml/2022/2/17/1032

Fixes: d5e90b7a6cd1c ("[media] uvcvideo: Move to video_ioctl2")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 711556d13d03..e7cdc01ad277 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -871,6 +871,7 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
 	struct uvc_video_chain *chain = handle->chain;
 	const struct uvc_entity *selector = chain->selector;
 	struct uvc_entity *iterm = NULL;
+	struct uvc_entity *it;
 	u32 index = input->index;
 	int pin = 0;
 
@@ -878,22 +879,27 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
 	    (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
 		if (index != 0)
 			return -EINVAL;
-		list_for_each_entry(iterm, &chain->entities, chain) {
-			if (UVC_ENTITY_IS_ITERM(iterm))
+		list_for_each_entry(it, &chain->entities, chain) {
+			if (UVC_ENTITY_IS_ITERM(it)) {
+				iterm = it;
 				break;
+			}
 		}
-		pin = iterm->id;
+		if (iterm)
+			pin = iterm->id;
 	} else if (index < selector->bNrInPins) {
 		pin = selector->baSourceID[index];
-		list_for_each_entry(iterm, &chain->entities, chain) {
-			if (!UVC_ENTITY_IS_ITERM(iterm))
+		list_for_each_entry(it, &chain->entities, chain) {
+			if (!UVC_ENTITY_IS_ITERM(it))
 				continue;
-			if (iterm->id == pin)
+			if (it->id == pin) {
+				iterm = it;
 				break;
+			}
 		}
 	}
 
-	if (iterm == NULL || iterm->id != pin)
+	if (iterm == NULL)
 		return -EINVAL;
 
 	memset(input, 0, sizeof(*input));
-- 
2.17.1

