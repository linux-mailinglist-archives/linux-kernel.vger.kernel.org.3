Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17871477B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbhLPSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhLPSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:35:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E082C061574;
        Thu, 16 Dec 2021 10:35:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so45769702wrw.10;
        Thu, 16 Dec 2021 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA2I16uBx9Eu2vEtDTI57f3ZQuky11P1wkK9HuUCNn4=;
        b=AEcbSmvNLncrre80HCJ0vVyl3yH8BkmF6TVx5m/+nRGdWhTUA9H8q+3vr5aN2YWi0o
         jvk32UdxUd2bQQAmQxDNBWcV6D8OsXN/TvcdRYGycGnaPUEiX6yWBatWU5OG33SCznNe
         kyAiPa7J9R+tBVnsQY35qzOBv/Hw7+zQg4teq+TJMSCRR4wGr2Qu85JDsXILVtT8lMWG
         f1Y0Tb5CwtJsE9gKo21yT//h6yzOefInltNQY6PIBpeHJH8iQyVS5FZb15Sz5BEeuozp
         rwm3cM+sAzZGxaWdJFyoes26AOJm6bLZV+uTTQOMNUlhbk1Nd9ZRyn+xI53Tgv3Ei4p+
         8Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UA2I16uBx9Eu2vEtDTI57f3ZQuky11P1wkK9HuUCNn4=;
        b=WNvYn0UflXnndOobVvXMjnOFqgcP6ylkAaxIemV3Gsc6Lj1rEuqetqGiulzD/mD/ZP
         f/pYsNqC4hP8QE3d+Kgb64dQToSLx2U6Z3QzDes9Pf4x8KcwSVwnaLyei3dppF3oclb7
         UQx4O6x/XLqj0EPF9MSf2JGD3tZUFXng6YGHq3KFD/NzdbTZA6hohAPYdTb4LJB8G8PK
         I8m6b5BOQVGh98gU7w/aLmSbwVj7QypV1WcNTaWWu9Ob6BRrtwYlJxGKRj6Fho3jzPmf
         rgL4+kbViKViv2xlOXMhGlDpF1GtnYB2t1sm/o5dmUM9c1Rin8OI3ordgZg5NJC4Wk4x
         xTWw==
X-Gm-Message-State: AOAM532rcVK69zSYSy/AGOF2DrcMQY9fLR2g09B27iZdg8hK9OMzZUji
        aA/HMBt0Coqjjxao181yqoc=
X-Google-Smtp-Source: ABdhPJzlApK0mypQmbR8hWx+v4iLf0LmjazQblBG8uxluMdsgvy4Pm4+5a5BTZ2c3rQqIMxFNEb3XQ==
X-Received: by 2002:a5d:6daa:: with SMTP id u10mr10174451wrs.641.1639679709067;
        Thu, 16 Dec 2021 10:35:09 -0800 (PST)
Received: from localhost.localdomain ([87.75.41.141])
        by smtp.googlemail.com with ESMTPSA id y3sm3281945wrq.12.2021.12.16.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:35:08 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Thu, 16 Dec 2021 18:34:33 +0000
Message-Id: <20211216183506.2247510-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iain Hunter <iain@hunterembedded.co.uk>

Commit cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
introduced a regression in the ina2xx driver.
In ina2xx_capture_thread() a timespec64 structure is used to calculate
the delta time until the next sample time. This delta can be negative if
the next sample time was in the past which is common in ina2xx driver. 
In the negative case timespec64_to_ns() now clamps the negative time 
to KTIME_MAX. This essentially puts ina2xx thread to sleep forever.
Proposed patch is to:
a) change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove 
non-standard timespec64 calls.
b) split the functionality in the loop into two parts:
 - do while loop only does the test to see if the next sample time is in the
future or in the past. If in the past and the next sample time will be 
incremented until it is in the future. This test is done with a simple 
signed comparison as we are only interested in the sign being positive or 
negative.
 - after do while loop we know that next is later than now and so delay is
positive and ksub_sub() can be used to get the delay which is positive.

Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>

Fixes: cb47755725da("time: Prevent undef$
---
 drivers/iio/adc/ina2xx-adc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0..17f702772 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *data)
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	int sampling_us = SAMPLING_PERIOD(chip);
 	int ret;
-	struct timespec64 next, now, delta;
+	ktime_t next, now;
 	s64 delay_us;
 
 	/*
@@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *data)
 	if (!chip->allow_async_readout)
 		sampling_us -= 200;
 
-	ktime_get_ts64(&next);
+	next = ktime_get();
 
 	do {
 		while (!chip->allow_async_readout) {
@@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *data)
 			 * reset the reference timestamp.
 			 */
 			if (ret == 0)
-				ktime_get_ts64(&next);
+				next = ktime_get();
 			else
 				break;
 		}
@@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *data)
 		if (ret < 0)
 			return ret;
 
-		ktime_get_ts64(&now);
+		now = ktime_get();
 
 		/*
 		 * Advance the timestamp for the next poll by one sampling
@@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *data)
 		 * multiple times, i.e. samples are dropped.
 		 */
 		do {
-			timespec64_add_ns(&next, 1000 * sampling_us);
-			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
-		} while (delay_us <= 0);
+			next = ktime_add_us(next, sampling_us);
+		} while (next <= now);
 
+		delay_us = ktime_to_us(ktime_sub(next, now));
 		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
-- 
2.17.1

