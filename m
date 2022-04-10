Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2337B4FB0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbiDJWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiDJWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:09:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7453B45;
        Sun, 10 Apr 2022 15:06:54 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s6so471818qta.1;
        Sun, 10 Apr 2022 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekLghVlZfgJwOBvVk0WUfBdIri575Qvb/4XkzJn/Y4Q=;
        b=KojYOOba95CBmF32aU1+Yn/XxtV9YXQvuXlu53ilpVUMqT/Wg/ELWkiE4IRqB25ENg
         alX4kHDkPTI3CAHSv/iajtLe4IZkaODbc+8vOFaTVyDeTmFGLc51IqeILQAzXh5p40qZ
         Dicu9tqdy5uOC5Ythd/zjPeOpcvbNCmyp8ih8RIZkmSRMcvpux0jaaPJ3sxZeHqw9tVw
         z3TDyEvbGnBLtQrZkvijiX4m6jFPZOk6OtqNgdspXOxCzyqFQp3PQEi2uYbSsYtSiaNt
         x/1E9S14oP2zkaaFGUgwmox1GB8cGbN+a7H6CaVLBVIsealCfIAVqR4aD5r8CTzEb6QA
         4vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekLghVlZfgJwOBvVk0WUfBdIri575Qvb/4XkzJn/Y4Q=;
        b=sHRZsnYwy1KMPQy1Y3Mlrl1kQjdRBlQE1q7qRGFTQm8f/IbuXZR0t/0JKeLLWWAMec
         lG1ArxP1vTcoLh3B9WMEewiRDKc+5/chhovm9Ty/cSfAxD9uzk4W9g3KWLI03PPk4zwy
         bXY90bjl2I3RWsTdqHImEd+DGt/Ze/DNXSSpVixVvIZo7A1i2DSQsCcO9ljHYtCHyTkD
         lsK0Yumhkiqknul+cdnti32BMo7ZhfUWsn5yYoTthwjbtUYFVB+rhfF2eoXcCtHO3o/6
         S6nbPiNNzegKCwjbiZD+aDqGOa+1JfvhcSCOrwwh5yMjfZIyHHroJ95IE70ijU5+EG5E
         CXXw==
X-Gm-Message-State: AOAM530iOV6p86JidgGrajOFHsP3UwN6ISR9D8/99I7SEblDBFKid9F5
        L76e/y3VAmQCPEO1P2HcHQ==
X-Google-Smtp-Source: ABdhPJwBvvj2ofTwK3pUAoE58FHs8U7MZkuQFd+lL+72CF/Q7B0LrpYNnNCsSWvjTY4yjNG/4LhQkA==
X-Received: by 2002:ac8:7090:0:b0:2ed:ca4:f08c with SMTP id y16-20020ac87090000000b002ed0ca4f08cmr8879694qto.57.1649628413190;
        Sun, 10 Apr 2022 15:06:53 -0700 (PDT)
Received: from arch.. ([2607:fb90:966:1288:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id v67-20020a379346000000b0069bdb3bb132sm5343639qkd.37.2022.04.10.15.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:06:52 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH 2/4] input: ff-memless: Add trigger left/right in ml_combine_effects
Date:   Sun, 10 Apr 2022 17:06:49 -0500
Message-Id: <20220410220649.5258-1-dbdaniel42@gmail.com>
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
 drivers/input/ff-memless.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index 8229a9006917..7f3a19970608 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -245,7 +245,7 @@ static void ml_combine_effects(struct ff_effect *effect,
 			       int gain)
 {
 	struct ff_effect *new = state->effect;
-	unsigned int strong, weak, i;
+	unsigned int strong, weak, trigger_left, trigger_right, i;
 	int x, y;
 	s16 level;
 
@@ -271,6 +271,8 @@ static void ml_combine_effects(struct ff_effect *effect,
 	case FF_RUMBLE:
 		strong = (u32)new->u.rumble.strong_magnitude * gain / 0xffff;
 		weak = (u32)new->u.rumble.weak_magnitude * gain / 0xffff;
+		trigger_left = (u32)new->u.rumble.trigger_left * gain / 0xffff;
+		trigger_right = (u32)new->u.rumble.trigger_right * gain / 0xffff;
 
 		if (effect->u.rumble.strong_magnitude + strong)
 			effect->direction = ml_calculate_direction(
@@ -289,6 +291,10 @@ static void ml_combine_effects(struct ff_effect *effect,
 			    0xffffU);
 		effect->u.rumble.weak_magnitude =
 			min(weak + effect->u.rumble.weak_magnitude, 0xffffU);
+		effect->u.rumble.trigger_left =
+			min(trigger_left + effect->u.rumble.trigger_left, 0xffffU);
+		effect->u.rumble.trigger_right =
+			min(trigger_right + effect->u.rumble.trigger_right, 0xffffU);
 		break;
 
 	case FF_PERIODIC:
-- 
2.35.1

