Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2F473E08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhLNIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhLNIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:09:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21837C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:09:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p18so13609840wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LFEFM4m/FM6B9UttvZC8dTAVnvNE7qpOruBGH+MXc8=;
        b=WnRU34YNEMQLKuLu8RNrRX3ShARN+K+hdOjh7cOeFGjukVYBQgwFlM0E++ykW0coL6
         LhHb6wZLfWmviZAvWEmeaWGC8EmGlpKCNswfJ9yHrMf74Vht8Q3306+70zsxQ4swEDGm
         jWJZmdnI9BjZETW+chaNFp8ofSvXswnwaLHX4I7ufDR4ZkmSRJ+xYk+FP1rrGBiBZ6lb
         YcnsdNsm0ab5p6lTaCHho8rQfhfZzuQ8d8ni6/XeRF9ql+STKaAlYOK0mYoJ4k+t8dpC
         dMq1FTW1mHLStFpL8VGGvn51TfV8kel6H2dlgCm2jn3z5xq/hx89U649kzaW1Zp78Fk8
         SE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LFEFM4m/FM6B9UttvZC8dTAVnvNE7qpOruBGH+MXc8=;
        b=MTO+4XjVLHzU3Hq7mS5wySKvucfioptxPq501eAw8vnhoxn/Qmb3yaJQAESCgx8pFN
         UtY/twJlazfpAX1/nBfxICSDjoWTR8kxizpcZsSBqj/qQbi95pwxhvEy/HFh5O6AHaCB
         iPacY3uE4YscMXl2fhT0BLuoTFqjmupEo61+fwMr+Y55eICXp788PDUJ1gTAEdvGhUn+
         bqXxGFkOR91whtGobUqDHu7b5cxx1pbAoaEkhDxEwqUFGE/aFiySqiqpjCvuA5LSPmcF
         aB3354laaa9BEBLlEbwj72eVjynp4Aq4v51Z6QqZUARbZL77zurVw6Ly/vMlh1AFCEcF
         jqDQ==
X-Gm-Message-State: AOAM531yYSVCepc85+ZKHq1+43lqsQjjWRtWy1QdFe+qCW+nvx+BJMdU
        u8DlMwSFSG3U5TZHrgk5MD48Z5DCvIQTOA==
X-Google-Smtp-Source: ABdhPJxGcWRTUD0o5dQo8U+dhNCH6feVXNtrDmCvYgAM1AKnR6fWm10Ohj+SmjdkDcPEtXomI96S9Q==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr43354633wmj.156.1639469360692;
        Tue, 14 Dec 2021 00:09:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id n184sm1378761wme.2.2021.12.14.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 00:09:20 -0800 (PST)
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
Subject: [PATCH -next] selftests: gpio: gpio-sim: avoid forking test twice
Date:   Tue, 14 Dec 2021 09:09:19 +0100
Message-Id: <20211214080919.22616-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '-o' within [] in order to avoid spawning two processes for test.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 tools/testing/selftests/gpio/gpio-sim.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index c913d5aec768..341e3de00896 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -23,7 +23,7 @@ remove_chip() {
 
 	for FILE in $CONFIGFS_DIR/$CHIP/*; do
 		BANK=`basename $FILE`
-		if [ "$BANK" = "live" ] || [ "$BANK" = "dev_name" ]; then
+		if [ "$BANK" = "live" -o "$BANK" = "dev_name" ]; then
 			continue
 		fi
 
-- 
2.30.1

