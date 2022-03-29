Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06774EA6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiC2FIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiC2FId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:08:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA237A1E;
        Mon, 28 Mar 2022 22:06:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u22so14860278pfg.6;
        Mon, 28 Mar 2022 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ug7xh6O8foNkDi2F/h1nDzCVh5DsfwpNCl7/FMQGMdI=;
        b=PhvGsFof5s9XMF4BKtGxl7XnLWR2fgdwcr56h022PW1WSskSAeeIrej+ZUV67w7lPu
         T/PTaU94Rwybq2M+5UjJgyfVjv0JE8JfQY9hi4ju8KJqARQ+tjsqt9+U8SWjqGl8tbAy
         GMYOX+6qHZmMeZGFnU1dJ1uCociosQeQOqjf1RNpx7Vgwh/wlmHUIwh0tKod37krydiA
         KFgsuAJoQxlw6654UdV79ZjR8BVxOrEIzO0EFgpjQkT+ulm3/gP/aZRM+lsnf+Tm7SIh
         DSPqWypdrth6QShV1gl01IPeoygk4XUpwvsHNdO4bXt6/OjfrqHL9bvUiCQ65hbJ8mOP
         bmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ug7xh6O8foNkDi2F/h1nDzCVh5DsfwpNCl7/FMQGMdI=;
        b=xHbRqfsulvJESP4EJ1Qz8qpq5YHxdSPkUvUlRRpIaDr0VD5aDSwpyq8pxi7+pL2RSQ
         Tk3/6CKGZ+JWmU8tX0ag8045ec9a2YSp/VWP+6C69fY6wnREn/IBUJ2JRojdG+IkM3Fs
         VTfNm4TLkqlTTnoAwejC0sgbTzlGxwwpVqIf/4jmTHQCTNPnqw94jrIrG6Oz8yCWnMo8
         qRGgy7AQwA0Gutt65Y10qVLM83hqVYTkfGD8kkZruVN52xRTC8Ry6WjPtgD9vnCzzm9F
         sKNWc8JO5BjQaCD6mpztuKQgje0OFsbQ7lfXnZWUsb4FaGH2vmtz4xuaqh+I1G6A9C/U
         H/MQ==
X-Gm-Message-State: AOAM531i9R2+1DJR9gjRcAmTbwcqtcqttkg1sHcbKn9DgFibR+RWPy89
        4DnnPo9C4aF3lVfA4BwxZi5bXqnX7SdbQg==
X-Google-Smtp-Source: ABdhPJxlLcVO4PIfZ6y/kGdZDtAkpumJoFs+qSGMcriZ9YMgp7lYdvafdOHRGpSmErQy8hADTZsHMQ==
X-Received: by 2002:a65:4c82:0:b0:380:3aee:6948 with SMTP id m2-20020a654c82000000b003803aee6948mr697213pgt.527.1648530410381;
        Mon, 28 Mar 2022 22:06:50 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm2377048pjl.3.2022.03.28.22.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 22:06:49 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     laurent.pinchart@ideasonboard.com, chehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] uvc: fix incorrect uses of list iterator
Date:   Tue, 29 Mar 2022 13:06:37 +0800
Message-Id: <20220329050637.15187-1-xiam0nd.tong@gmail.com>
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

The bug is here:
	pin = iterm->id;

The list iterator 'iterm' will point to a bogus position containing
HEAD if the list is empty or the element is not found after running
previous list_for_each_entry. As a result, iterm->id will lead to a
invalid memory access, and the check iterm->id != pin lately will
always be bypassed.

In addition, the list iterator 'iterm' will *always* be set and non-NULL
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

And remove the unneeded 'pin'.

Fixes: d5e90b7a6cd1c ("[media] uvcvideo: Move to video_ioctl2")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---

changes since v1:
 - remove the unneeded 'pin'. (Laurent Pinchart)

v1:https://lore.kernel.org/all/20220319102222.3079-1-xiam0nd.tong@gmail.com/

---
 drivers/media/usb/uvc/uvc_v4l2.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 711556d13d03..2ca43ce814c9 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -871,29 +871,31 @@ static int uvc_ioctl_enum_input(struct file *file, void *fh,
 	struct uvc_video_chain *chain = handle->chain;
 	const struct uvc_entity *selector = chain->selector;
 	struct uvc_entity *iterm = NULL;
+	struct uvc_entity *it;
 	u32 index = input->index;
-	int pin = 0;
 
 	if (selector == NULL ||
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
 	} else if (index < selector->bNrInPins) {
-		pin = selector->baSourceID[index];
-		list_for_each_entry(iterm, &chain->entities, chain) {
-			if (!UVC_ENTITY_IS_ITERM(iterm))
+		list_for_each_entry(it, &chain->entities, chain) {
+			if (!UVC_ENTITY_IS_ITERM(it))
 				continue;
-			if (iterm->id == pin)
+			if (it->id == selector->baSourceID[index];) {
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

