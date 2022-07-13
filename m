Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59831572AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiGMBhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGMBhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:37:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46012D1EF4;
        Tue, 12 Jul 2022 18:37:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so8961296pfp.5;
        Tue, 12 Jul 2022 18:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uot9cU87HuacvPBFiE8dXPlbd9JuhZ9FCEJ9FLr6cHs=;
        b=KFmhI38wnldTSnDUX5DcZvc4m1Ap/NJcvAfNJe/CAolAZN21g2fdndC3Obi0ofY46Q
         tgDgqSr5TqFYKSwHbXI7PU8ZVm3wtBSA4JpntfYdJqu1qZyj0CAbzw0zyum8QFkMjF6A
         XSxlIxkFwq0HjoAC4rys8SksKpHX4rk41KNnlXU3cHfKYQJq4d0WjgIfDaJNnF/vEvyz
         7J07XedEXMN4U0Qw/5QUEaWaOBJlNzwWNUq95ciYVzUVa6LT1u0W5JRcamzxtYFyO3Ft
         dDIKd66isdwecVu3nocsTgEkDz2KCdMV5mCCh9aKJ5sG4YU+lTrq67tn1CNFQQd0uKHl
         hXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uot9cU87HuacvPBFiE8dXPlbd9JuhZ9FCEJ9FLr6cHs=;
        b=wyHp+F/j8PMLd8u/KASqrdJuLiJenbgvEiPEl8k6ubMn7MlWxMBy8cXdO9PlMzgKYx
         KVD+SnbvWmL+y+6B112n1qc7S+ddUTb8gc3GdUG228PnRoA4My2uP7lGuPsA3+7zCSah
         zoEW8TPnRe4GEC37L7c79TF3dAVRtST9I8jGbPWsOVEQ3PmRYuKIjKOCgeF2H/orsBOk
         FWzCCgRrqjkVghtch83tNGbXIop8Jq+ZE0aDpQ8Co6DvxDCfz8llvWP8EsvSikHK/xAJ
         udscTH+IKtR6dpJy8AeaOiA8lVF+zT/DnSLHmOXzNQVyUtoruXs4AXegLWGgjkMytb7z
         XLHQ==
X-Gm-Message-State: AJIora9DvTcO22V9Nh1cHL3ysIGe/tKdESSMoEbDkUmNjF8QxJuvGgGz
        vlKl9EP+/7BZ7f/Krn0Uql6uq5X3ZY0=
X-Google-Smtp-Source: AGRyM1uJwR3zAT5IVNadQzUk6gI5jR9hKyZmdax1bg7G2irqJSobCuo1VoMInQeFvaaQ0wHupUNFHw==
X-Received: by 2002:a63:de10:0:b0:411:9f90:b91f with SMTP id f16-20020a63de10000000b004119f90b91fmr968437pgg.412.1657676267480;
        Tue, 12 Jul 2022 18:37:47 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:37:47 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 1/6] gpiolib: cdev: simplify linereq_free
Date:   Wed, 13 Jul 2022 09:37:16 +0800
Message-Id: <20220713013721.68879-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713013721.68879-1-warthog618@gmail.com>
References: <20220713013721.68879-1-warthog618@gmail.com>
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

The edge detector is only ever started after the line desc has been
determined, so move edge_detector_stop() inside the line desc check,
and merge the two checked regions into one.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0c9a63becfef..b44526e3630e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1460,15 +1460,15 @@ static ssize_t linereq_read(struct file *file,
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
-	bool hte = false;
+	bool hte;
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc)
+		if (lr->lines[i].desc) {
 			hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
 					 &lr->lines[i].desc->flags);
-		edge_detector_stop(&lr->lines[i], hte);
-		if (lr->lines[i].desc)
+			edge_detector_stop(&lr->lines[i], hte);
 			gpiod_free(lr->lines[i].desc);
+		}
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
-- 
2.37.0

