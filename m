Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED64731AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhLMQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbhLMQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:26:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C7C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:26:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so11986627wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AzvuCR6Z7F8eWXwnKYsYP5qAfi0qAAwDYxmJxh11GA=;
        b=kP0MdMHDZOVdBWXvz8yFlKiVvcY55bWueHxr6gc1O5yBHS0FvggzvJ7ccXwQkp9wY+
         Kf4Yi6V/a/z1GiyIBA7Or/rmDjb8k6pvo0WFUEajMQIzEAbH5hccB042iybhOngB3ssa
         hax12ybb/fQLi+THkLJewf03772zKqtH7M4ASN5BjZiacAu8duaYqn1icM3sZ6OSRSKs
         uj7ihi3hqrvxN/Xs3qQfrPkIMpD6Ra9/5g4otyyORENEAshYi/Ay55mzNzK60Hecfofi
         vZ66gQ8cWC0YMmsJ0w5WQx5s/DJCVDd7R5cCHGS5LrxwyG/Xn1+ToA5G6BGuZuPhvxCF
         VfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AzvuCR6Z7F8eWXwnKYsYP5qAfi0qAAwDYxmJxh11GA=;
        b=s7sKvYA7HOHG/Hms9zD+d1kWJMELuxH5RhrZM16QiMv3fO2sUeaJx3aYOHBNXdGR1I
         qRpPn6BrnKTlq71L9fE6smVMrmhxAJ1/+wIXEFERAyIGyJTJxeei0BzokzUvjXc4WYDe
         NGZdmTSlA+EgAo8joNMG3JvYuCo0VHkt23e3OqyaeZn6hSvGhsRCvG9cwsmExAWeLNJP
         V7OFz4xRT3/E6ZwaDazFzYzXTz1Dm8mnscicjD49Hs6T9nS1L+mUWTzlvIAJStECqMcM
         2jZV2ymUuObevJcuXw7GDWwbpppAoBlVfizxet9ETkSj+HAF/z5481WrrmbBJqH9Q2qq
         COBA==
X-Gm-Message-State: AOAM533AsH5Uy6HzIeYuJecSEjZZsBWJU1Gx5sd9k9IpL6K6CLT/DXv8
        Ti+Frpk43sMvMMhGQRV6L9BtjQ==
X-Google-Smtp-Source: ABdhPJxQmDBJHKFiivMEItpeQKi5UEquLrsRjPIhOf8fp4Du6AOuUbLldxE2uMtO9/E5ff9cK/6apg==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr39961494wmg.20.1639412787495;
        Mon, 13 Dec 2021 08:26:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id j17sm9958789wmq.41.2021.12.13.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:26:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH -next] selftests: gpio: gpio-sim: remove bashisms
Date:   Mon, 13 Dec 2021 17:26:25 +0100
Message-Id: <20211213162625.18081-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'==' is a bashisms and not understood by POSIX shell. Drop it from
gpio-sim selftests.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
I ran the newly applied patches on a different system and noticed the
tests now fail. I missed '==' operators for string comparison I used in
some places.

 tools/testing/selftests/gpio/gpio-sim.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index d335a975890c..c913d5aec768 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -23,12 +23,12 @@ remove_chip() {
 
 	for FILE in $CONFIGFS_DIR/$CHIP/*; do
 		BANK=`basename $FILE`
-		if [ "$BANK" == "live" ] || [ "$BANK" == "dev_name" ]; then
+		if [ "$BANK" = "live" ] || [ "$BANK" = "dev_name" ]; then
 			continue
 		fi
 
 		LINES=`ls $CONFIGFS_DIR/$CHIP/$BANK/ | egrep ^line`
-		if [ "$?" == 0 ]; then
+		if [ "$?" = 0 ]; then
 			for LINE in $LINES; do
 				if [ -e $CONFIGFS_DIR/$CHIP/$BANK/$LINE/hog ]; then
 					rmdir $CONFIGFS_DIR/$CHIP/$BANK/$LINE/hog || \
-- 
2.30.1

