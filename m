Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC351EECD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiEHQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiEHQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6027101CF;
        Sun,  8 May 2022 09:02:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k2so16356514wrd.5;
        Sun, 08 May 2022 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2y3LCh0oX8KUwg7+Vl+Q7bdw1QHYwjY+0MMTIBBHFTM=;
        b=LLX6arJrsbU5eZTfLW24DKsL5gOBGjHbXSQa47ZJ2eCHZtlZ3LcV+e7mTt+hYlDvrx
         UVZFnhPov+1zPKFCKE5fIuhsPcS424o/LTg497T+2RL/w3ssd48XZmfXgQtCjXzUicUt
         +gGa16+GpCjNtRI0+eUEARHxSdcEzIbjNNDrtu8qaN/VdKNlfg3saaRsgGkCN/PlrHAi
         eeLGZ3gTW56vxBtAd6r8TOP3TUoqazhzkBSRFVttHqDiNN2MJ7v4Tdk9yV7pnKVB/bYU
         Y2OxEJD1Ln6/bL67ZN+mcU24YBmhvK4WUgye+BYBaflEtp6KDNPmu8Eksce6bh1u/rpl
         3d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2y3LCh0oX8KUwg7+Vl+Q7bdw1QHYwjY+0MMTIBBHFTM=;
        b=T4ql0tfZ//ikpO4tFd3n+YbVih01jrtPN7m0QocGEIuhvjiKHZ9kSGe6spiS+n+4Ml
         TYqmThqigb776RqmiDA3GFtK+toB3WhDtKE/KsKihcI7p9r4ORTwMKjvGdEybj7sf+BI
         4WOgdsXc7fvUJx/XSEIdqNP2HsfRf+Z0R+k0PpY3+w45rKP4Bswo/Xw6BzNy9vTPDCwr
         Q1xRXyXj+myEJAm2wFbW3LUVkz8zCOxnmtkFK5ZZ/IyJI0kFIfS+PANbcjWhuYZKK14g
         DS/dW5jlK6Ab4bHgdvLtB07+RQzqHvUwFxjf/4qU79T5QJzJ9kmxeuy3V1ATzTPdNBjM
         VzHQ==
X-Gm-Message-State: AOAM533UvKqGuedJwuSg6vUxhRf7l0KYeLZHmerRnaYl83ijOPBb6JOw
        /eENYbNj4/1JjT6eAfsqQY8=
X-Google-Smtp-Source: ABdhPJy7AywzsZHP6NrH4mCLtxsynVY9tMzipWWeYqQMKXl2mW42cBlSpc7Z07DIh33SjnZo44mzGg==
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id o10-20020a5d47ca000000b0020c72c9d3bemr10300446wrc.114.1652025736200;
        Sun, 08 May 2022 09:02:16 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:15 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 4/7] HID: uclogic: Always shift touch reports to zero
Date:   Sun,  8 May 2022 18:01:43 +0200
Message-Id: <20220508160146.13004-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nikolai Kondrashov <spbnick@gmail.com>

Always decrement touch report values to have the range start with zero,
regardless if flipped or not. This fixes the future non-flipped touch
strip reports.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 15 ++++++++-------
 drivers/hid/hid-uclogic-params.c |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index cc53625ed1f7..c4ab94d58a0f 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -386,15 +386,16 @@ static int uclogic_raw_event_frame(
 	}
 
 	/* If need to, and can, transform the touch ring reports */
-	if (frame->touch_byte > 0 && frame->touch_byte < size &&
-	    frame->touch_flip_at != 0) {
+	if (frame->touch_byte > 0 && frame->touch_byte < size) {
 		__s8 value = data[frame->touch_byte];
-		if (value != 0) {
-			value = frame->touch_flip_at - value;
-			if (value < 0)
-				value = frame->touch_max + value;
 
-			data[frame->touch_byte] = value;
+		if (value != 0) {
+			if (frame->touch_flip_at != 0) {
+				value = frame->touch_flip_at - value;
+				if (value <= 0)
+					value = frame->touch_max + value;
+			}
+			data[frame->touch_byte] = value - 1;
 		}
 	}
 
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 459f15288ccc..163efd026881 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -889,7 +889,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE;
 			p.frame_list[1].touch_byte = 5;
 			p.frame_list[1].touch_max = 12;
-			p.frame_list[1].touch_flip_at = 6;
+			p.frame_list[1].touch_flip_at = 7;
 
 			/* Create v2 frame dial parameters */
 			rc = uclogic_params_frame_init_with_desc(
-- 
2.25.1

