Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDA574132
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiGNCDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiGNCDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:03:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA1BBC36;
        Wed, 13 Jul 2022 19:03:50 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d10so578233pfd.9;
        Wed, 13 Jul 2022 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8xyMNAQAMH3dB784aVpeEcj3aQzHocuPU4wVMMpJ6Q=;
        b=d4rOOUSZiipBq/BDH0r4CmgTwGh9cgOjb8JEnDjh45dymPaVcsge8LF8qAO/WizEGj
         NBGkyo2TNgAVIXYs0A2akgs7cfvUWXiu6eKuIYQtvLlfDeYJroIJb2AGhplFNeh17kMG
         hsKtftI8EA1fnJacwLFsoNCy0jgh2C4szjBdfJ0RbP42h5r9sVNnDbTzvMdwAe0l8A/B
         Vr+V9G/+f/v7phBoClB8MrjMAkuSdY23ao6Q1zPfK1YzcBA+A5jPpFNlJX+KnY7CJBUx
         ZmJTs8USACLpfeOxrc8RfG58JYHqziaLlwzUVks5GTIPP2wzPQIZT0l2LpyeiCX8OB4C
         UJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8xyMNAQAMH3dB784aVpeEcj3aQzHocuPU4wVMMpJ6Q=;
        b=uo6ZWe3axYoEehVCe46AaRJCNngUEMtDAqwbkdKGizru2xc6lS3vY2JquyTRojflSy
         aJR1uU189hkzF+Y6BUYtRHko7CYbjOi0asF2OoXj6x/Y3lm8LCr5M+EXb4jQ5rx/v/jD
         OOzj6y3L4Ml4OOl4kTL/JPOWisYnHbQYP9z14peXS6SnonYIR2gzrg+dYrCX7qxSBNC7
         0uGh5XbmF90JtakXR+5QmlOdoRExWUFMTYudAx+dFBFcvLbMPdg1bX2LEX+w2L3tTYXz
         0JFreucPB4IbVIQv24S654qUxxUhqqb7mNEUyBgHd+fKP4jU9jqfEpHVzjO4P62Ohypz
         8zqQ==
X-Gm-Message-State: AJIora9ff+8KUdcnPkzDloW5/f4IpDpqb8epPiONVRVoRQfAb/fHvhFD
        iLUGAigdq+DQHtWcOsjesS8vJTbsZBs=
X-Google-Smtp-Source: AGRyM1vq4JVqL88Py4pPgg2Yg8K7hyc1Yf5ujqS/sJiVnJOM/veU7WzKi15WuVQs30QRD1f8quu2fA==
X-Received: by 2002:a65:5381:0:b0:415:f0ec:ac70 with SMTP id x1-20020a655381000000b00415f0ecac70mr5517289pgq.473.1657764229416;
        Wed, 13 Jul 2022 19:03:49 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:03:48 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 1/6] gpiolib: cdev: simplify linereq_free
Date:   Thu, 14 Jul 2022 10:03:14 +0800
Message-Id: <20220714020319.72952-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714020319.72952-1-warthog618@gmail.com>
References: <20220714020319.72952-1-warthog618@gmail.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
2.37.1

