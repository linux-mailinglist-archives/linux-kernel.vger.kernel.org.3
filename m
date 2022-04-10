Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3A4FB0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiDJWJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbiDJWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:09:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF504F47D;
        Sun, 10 Apr 2022 15:07:07 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id p8so11903180qvv.5;
        Sun, 10 Apr 2022 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR0xVHqHdbQUb+iGPJt6PwEd5Z6tp6DNOoS3GUblF6k=;
        b=AiFrLw/Wa+EhA+gjW+n0QFsvk8ReDL+AkeKJ+uB/FJhacehCxJqq2ihhm2WYW/9sAu
         Ivckgdz13+Chxz8JZSIFe9cpbHKL+SSWwvmdH11/O4vGLXIi1lAYv00awDhTznkQgFkt
         WZE0Cdm0j9mqXaOKo2Ag7/MtjEN40C3+4fiMod9ATzXzxrcXDALlH+kEBUcJqCvrtWy+
         saPdsAPlnktGn39icg8RegMPttlu6Chdnf3mMzgUJgkwvXtI9N/i1HnRdd3YNNPhhAnN
         BTPtoANxPuIsCVPMlFw1w/V4E8TrG4etllPLQ9THin654VT8B0Xjge6maPZig3tUnbqn
         iDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JR0xVHqHdbQUb+iGPJt6PwEd5Z6tp6DNOoS3GUblF6k=;
        b=Eus52jobfytK7yf2TwpccyMxgHmU9RCJ/k6pJp+rKrgsfI+qNF34P90KNynj4iuFxO
         w9AInSM8rKm5drC61oITsfPuqZCuUUNmQ4FaxviOIrlG5sXXnRrhDrFb21fNT6bhSopQ
         bbZs3x+4WUEo/L81UO9f2LRJdAVR/BoxJDan33quDfmtUBhYtzh5RzcSy7L5ykDTbLJf
         zX914aACPaMI70URfEm0zHNYJ87DNLS4S7ApCA6AEufxEfruR5N/ndhHf3/Mlt7gBHGM
         HtyZMEYMWNp6T6V/lhIMsPSg0INVi1p1n+v5NZ7sh5jvi2Xpw2N0FyBWbDqJKfkEbCe0
         i6vg==
X-Gm-Message-State: AOAM533D9TbdbrypSse8EMxrHEeS5b9nDByz1BvwYasoFtm4JuFy6vtc
        NB9h1EQlWz9sv1jlTrd0gA==
X-Google-Smtp-Source: ABdhPJxVPMRHq0w4uY7YWfj1Psknqr1kqsC8TIZg/L70IL+CzN1oESbaSW/YnTXu4pqsAlN+8aDmpQ==
X-Received: by 2002:a05:6214:1cc4:b0:431:4cbc:1d91 with SMTP id g4-20020a0562141cc400b004314cbc1d91mr24977694qvd.64.1649628426859;
        Sun, 10 Apr 2022 15:07:06 -0700 (PDT)
Received: from arch.. ([2607:fb90:966:1288:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id b40-20020a05620a272800b0069c10f8825asm1844532qkp.130.2022.04.10.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:07:06 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH 3/4] input: xpad: Implement trigger rumble for Xbox One controllers
Date:   Sun, 10 Apr 2022 17:07:01 -0500
Message-Id: <20220410220701.5279-1-dbdaniel42@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
---
 drivers/input/joystick/xpad.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 18190b529bca..0ac59ce03e58 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1251,6 +1251,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	struct xpad_output_packet *packet = &xpad->out_packets[XPAD_OUT_FF_IDX];
 	__u16 strong;
 	__u16 weak;
+	__u16 trigger_left;
+	__u16 trigger_right;
 	int retval;
 	unsigned long flags;
 
@@ -1259,6 +1261,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 
 	strong = effect->u.rumble.strong_magnitude;
 	weak = effect->u.rumble.weak_magnitude;
+	trigger_left = effect->u.rumble.trigger_left;
+	trigger_right = effect->u.rumble.trigger_right;
 
 	spin_lock_irqsave(&xpad->odata_lock, flags);
 
@@ -1311,8 +1315,8 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		packet->data[3] = 0x09;
 		packet->data[4] = 0x00;
 		packet->data[5] = 0x0F;
-		packet->data[6] = 0x00;
-		packet->data[7] = 0x00;
+		packet->data[6] = trigger_left / 512;
+		packet->data[7] = trigger_right / 512;
 		packet->data[8] = strong / 512;	/* left actuator */
 		packet->data[9] = weak / 512;	/* right actuator */
 		packet->data[10] = 0xFF; /* on period */
-- 
2.35.1

