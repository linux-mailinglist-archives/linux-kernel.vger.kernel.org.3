Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC64568200
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiGFIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiGFIp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:45:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3913DEC;
        Wed,  6 Jul 2022 01:45:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so7547843pgb.4;
        Wed, 06 Jul 2022 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWOY57xu2SoD0zR4WSIqSHfux9YG0e74Om7jN92FA/8=;
        b=cdMztD5sxSb6SYvpAE8vKXkawS2vwtXDgPj8lmlQEUPZ/2fO6/JvlFZTjky1+u3ySP
         6piYv60hghLFJBhZzs7yjDBy4KcOY3MGs0DAZf9C3n9wDrIr6QoML/hWgjabf0iEwlqz
         lddORsLaJgUldUmi4+ciO6IZtP1aqKEWoV68/KMjkKXBoDihxhQhH1jWaoViqVz8poKQ
         itzXoOfMiXXSTRayvtSAwsV2jo76KY0RCk8sdAZmhymOHASUUL8ySEaWl4bZNTysNkac
         sLVghn1a2I65y8lCd7QbZnJA1hTdX33lAHfh0hNJaE+eWti5sJu7aiOINYKtuBuxYhbx
         betQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWOY57xu2SoD0zR4WSIqSHfux9YG0e74Om7jN92FA/8=;
        b=a15M9I9W+LkWFyzCDuOPJxa2iFcJQv72mpIeXOYFTBZsVbI0EVJCCiqE+RITXN7MD3
         cQklngj2l5ZKDf5R0VEzye9BAVASIXGP0QCpTMA+WcaYttMRnVujATJRsoBlUfkPvIjp
         p/qwQiwyE5D6Ouw2ePmZ4zcvm8wDxQ11AvieIhJfAKiBNFUIEbJZ+B3ncQ8YimxfM3x1
         QSPdZ66Z5xz4X6RYr3bB6sLE8Vb4qZqWy0M79YD/oFqsd+ZIY8Rr3d0AkQKetPdwfKhV
         gZffVtsKRuMQI5wEl+6l3ziF79xTwLXxtCbJOIsl6RW4hKybKHSqYjijSPH4M7IfMhvf
         Jpeg==
X-Gm-Message-State: AJIora92cG25IUSvWQ3uVbeDIaqPBBNZBXh8gD9x5XG64IMZgXojCyRu
        wY8lHFaOZBCOeLBAyef4M881ixFRRYA=
X-Google-Smtp-Source: AGRyM1t9ZHzoWgg6r2Hh4FW79rUHgoyhCkLJYxNVgO1N9xbWM53BzX0G2Oqz/1HU18Z5P4nQI52NRA==
X-Received: by 2002:a65:42cc:0:b0:3a9:f71f:33f9 with SMTP id l12-20020a6542cc000000b003a9f71f33f9mr33373789pgp.391.1657097155878;
        Wed, 06 Jul 2022 01:45:55 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b0016bfaee8244sm1807231plh.14.2022.07.06.01.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:45:55 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpiolib: cdev: fix null pointer dereference in linereq_free()
Date:   Wed,  6 Jul 2022 16:45:07 +0800
Message-Id: <20220706084507.2259415-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.0
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

This patch fixes a kernel NULL pointer dereference that is reported by
gpio kselftests.

linereq_free() can be called as part of the cleanup of a failed request,
at which time the desc for a line may not have been determined, so it
is unsafe to dereference without a check.

Add a check prior to dereferencing the line desc.

Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

I suspect the edge_detector_stop() and gpiod_free() could also be moved
inside the same desc check but, as we are late in the rc cycle, I don't
want to push my luck and have kept to the minimum change required to
address the bug.

 drivers/gpio/gpiolib-cdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f5aa5f93342a..0c9a63becfef 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1460,11 +1460,12 @@ static ssize_t linereq_read(struct file *file,
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
-	bool hte;
+	bool hte = false;
 
 	for (i = 0; i < lr->num_lines; i++) {
-		hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
-				 &lr->lines[i].desc->flags);
+		if (lr->lines[i].desc)
+			hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
+					 &lr->lines[i].desc->flags);
 		edge_detector_stop(&lr->lines[i], hte);
 		if (lr->lines[i].desc)
 			gpiod_free(lr->lines[i].desc);
-- 
2.37.0

