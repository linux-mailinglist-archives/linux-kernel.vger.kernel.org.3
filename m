Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560952B502
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiERIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiERIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:35:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E121B6;
        Wed, 18 May 2022 01:35:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so1168107plg.0;
        Wed, 18 May 2022 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52HaqZnxqEFZl0mBHB2v3BcWYzu7uKOK1XP7MLEWZGM=;
        b=OskJzqc7DFoaQBN3wQNU/Rgv3wgpkZtE8EVUg5Gz0W1IUWNzWJ8uOnTUXcLJCjNfJd
         Adt7UAlnb7NFW5aw0G3ZKfH3doW23qkmZrGWldDyyipotz/Ucdph+dIaf+LFlN/fe2/9
         6FF9D9i2CboRvxntVyMDavLtATVu7CtUBuVqnHpuEO6BnMJ3T9VyG8VnRX2ZUvpQJv0w
         LLJD3ulje4xTubyScFeGFKXedefPAIsdxffmXhhhTeihwkcSSs/rC1zndrGMy6xwUflt
         MhhBwDNSxBbgrsS9y3XbHtnhrKHxg7mrfcfPjNsHrBzXe9TqRa8iweqhShgzxL08sX6f
         pGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52HaqZnxqEFZl0mBHB2v3BcWYzu7uKOK1XP7MLEWZGM=;
        b=rx6+sJMx27TuF4RxLBYm3i6WHvWmQSWcF6sgeYkmcaMJhNwqdUe4Lm1y2Oe6riRepC
         8cMEvuzkRkesmiggKa/DOEyktdKvMV+1DbEd0sfU0zJl6gdnfZZLUCXoX7kWLiacbbo9
         T4E7PWM+23I9uMnwHhYg1x7c0L062LVk7MJbVnxan0UNTBoNJSMkLxSwHqc6uBnmF0Pg
         DpCYLQJHaNo/kGfFZF/3aE9Q9KFOltriL1hbs5ySg97xqhaePr9GIfr1SpIvFwrBSGd9
         2ID1WdA/xIRLBwpLpaAo3sohYoreoHszOsKKTTYQ4++v8h2hcy01e6BGR6XaOBUXmgF+
         1IlA==
X-Gm-Message-State: AOAM533bhtbC7MnGBMuZauzf/ExIioZGLqOkr+ZsTvDX/jXFzs0BWNvA
        xT2vOjU74qb8kPJRf3GkILUtAxc4wRI=
X-Google-Smtp-Source: ABdhPJxmXCpwaNpmxoOz6LgG0rYaHuhDDfcSCka60LMli9PCEZVkZ94NRP5GDkXw/aq2T7IGYbsooA==
X-Received: by 2002:a17:90b:3ec2:b0:1dc:db97:9424 with SMTP id rm2-20020a17090b3ec200b001dcdb979424mr40276096pjb.153.1652862943210;
        Wed, 18 May 2022 01:35:43 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001df313f6628sm3029837pjb.21.2022.05.18.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:35:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v2 1/2] platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs ABI
Date:   Wed, 18 May 2022 15:35:23 +0700
Message-Id: <20220518083524.37380-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220518083524.37380-1-bagasdotme@gmail.com>
References: <20220518083524.37380-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warning when merging chrome-platform
tree:

Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpected indentation.

The warning is due to missing blank line separator surrounding values
lists.

Instead of using lists, use tables to be consistent with rest of sysfs
ABI documentation.

Link: https://lore.kernel.org/linux-next/20220516213832.19127535@canb.auug.org.au/
Fixes: 0a4cad9c11ad46 ("platform/chrome: Add ChromeOS ACPI device
driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benson Leung <bleung@google.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../ABI/testing/sysfs-driver-chromeos-acpi    | 52 ++++++++++++-------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
index 5b59ef9d7b371c..cce45395170079 100644
--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -4,8 +4,11 @@ KernelVersion:	5.19
 Description:
 		This file shows information about the current boot of
 		the active EC firmware.
-		  * 0 - Read only (recovery) firmware.
-		  * 1 - Rewritable firmware.
+
+		== ===============================
+		0  Read only (recovery) firmware.
+		1  Rewritable firmware.
+		== ===============================
 
 What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
 Date:		May 2022
@@ -13,23 +16,28 @@ KernelVersion:	5.19
 Description:
 		This file shows information about the current boot of
 		the active main	firmware type.
-		  * 0 - Recovery.
-		  * 1 - Normal.
-		  * 2 - Developer.
-		  * 3 - Netboot (factory installation only).
+
+		== =====================================
+		0  Recovery.
+		1  Normal.
+		2  Developer.
+		3  Netboot (factory installation only).
+		== =====================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/CHSW
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		This file shows the switch position for the Chrome OS specific
-		hardware switches.
-		  * 0   - No changes.
-		  * 2   - Recovery button was pressed when firmware booted.
-		  * 4   - Recovery button was pressed when EC firmware booted.
-		  * 32  - Developer switch was enabled when firmware booted.
-		  * 512 - Firmware write protection was disabled when firmware
-			  booted.
+		hardware switches when the firmware is booted.
+
+		==== ===========================================
+		0    No changes.
+		2    Recovery button was pressed.
+		4    Recovery button was pressed (EC firmware).
+		32   Developer switch was enabled.
+		512  Firmware write protection was disabled.
+		==== ===========================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/FMAP
 Date:		May 2022
@@ -58,18 +66,24 @@ KernelVersion:	5.19
 Description:
 		This file shows the type of the GPIO signal for the Chrome OS
 		specific GPIO assignments.
-		  * 1   - Recovery button.
-		  * 2   - Developer mode switch.
-		  * 3   - Firmware write protection switch.
-		  * 256 to 511 - Debug header GPIO 0 to GPIO 255.
+
+		=========== ==================================
+		1           Recovery button.
+		2           Developer mode switch.
+		3           Firmware write protection switch.
+		256 to 511  Debug header GPIO 0 to GPIO 255.
+		=========== ==================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		This file shows the signal attributes of the GPIO signal.
-		  * 0 - Signal is active low.
-		  * 1 - Signal is active high.
+
+		== =======================
+		0  Signal is active low.
+		1  Signal is active high.
+		== =======================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
 Date:		May 2022
-- 
An old man doll... just what I always wanted! - Clara

