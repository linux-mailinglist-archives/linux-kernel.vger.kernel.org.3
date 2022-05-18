Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1552B4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiERIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiERIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:35:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A126257;
        Wed, 18 May 2022 01:35:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so1938172pjb.0;
        Wed, 18 May 2022 01:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ppoMSrki7vTgR8buo+eu8ZqwsgOb0nzv0Nzh6/tvLE=;
        b=MUXls19MCfOtDr+YslsnhSlPzk3rA03NjMVYwF3yeblofrGCWUZS9YyenKZn2HlBbz
         FlaaL8RJ588WElHK2XvmaAcMjlU5b3nWJniNcd/CQh6611m5FFBQkky8HmcdGlT9cnSc
         L/P1NZ8GNWlBAQTyzYCME7kIcy5QCZ7MFfym8wJOSUzOZrKJlUJyMveXSv+9nZfNXfu8
         meS57mi1+QHkbctqOdpwvlBNAChzifYZoYLc7Gqu7BcF+cgEmuUnOsaOK8C9OlEbavic
         eC3hzcNy7acYTmXA/GzvVH7Hdn2Br3m9w69Jz/3vEwSJCmoVd2A5zPpd/VG4S9+Tpeds
         6mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ppoMSrki7vTgR8buo+eu8ZqwsgOb0nzv0Nzh6/tvLE=;
        b=mcM1uHeK9LBhYcxOlVs3NgytKDu3PYm8fzjUMBzf1hfkWjH2Wp4jqFnrCnxv5JJdB1
         KiH3ohW7sfrNmcpxN+FKBTUnX3WKHVa7SB5iWJpqGpBZaf/r4gqmMlT+J+jRNYbsYOiz
         k7QHaqvE1MvwCElViXFWWsjsBh+PpBH+rZXObsCKFk1zqI1CmCSg1bbDgE7Q32C2gK4M
         eKeUDutNBm715fLzsGkNGFQO2YOdd2niCkHKS6SqlELytATPrgX9qeewm1pTcMP/ufmQ
         /CxLNoOXt52Aoc93ZCtNWy1XXsJuav5uuACkD00tap7tYRMs3mF7GTB0+jLhpEv1JeGt
         8c4w==
X-Gm-Message-State: AOAM5325eWSkTvVlCXWUdspwTOoERn6zLteTCgwzWIubujICL61PvoJB
        pScieOflNk7CQ+JTQQ0gKS14gvDQoRE=
X-Google-Smtp-Source: ABdhPJx5Soze/0Y1QQTiKDEf+v4AxiQoBfUuzFyA3qMbnRfr3bWNvjCY0L2/Wfg8QLANpeUFB3pV0Q==
X-Received: by 2002:a17:902:e989:b0:15f:1545:326d with SMTP id f9-20020a170902e98900b0015f1545326dmr26485856plb.119.1652862947607;
        Wed, 18 May 2022 01:35:47 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id gc10-20020a17090b310a00b001df313f6628sm3029837pjb.21.2022.05.18.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:35:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
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
Subject: [PATCH v2 2/2] platform/chrome: Use imperative mood for ChromeOS ACPI sysfs ABI descriptions
Date:   Wed, 18 May 2022 15:35:24 +0700
Message-Id: <20220518083524.37380-3-bagasdotme@gmail.com>
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

The current descriptions all begin with ("This file shows something")
clause, which is incorrect wording since these mean return value from
sysfs.

Use imperative mood ("Returns something") instead, in line with
corresponding ACPI documentation at firmware-guide/.

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
 .../ABI/testing/sysfs-driver-chromeos-acpi    | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
index cce45395170079..c308926e1568a7 100644
--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -2,8 +2,7 @@ What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows information about the current boot of
-		the active EC firmware.
+		Returns active EC firmware of current boot (boolean).
 
 		== ===============================
 		0  Read only (recovery) firmware.
@@ -14,8 +13,7 @@ What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows information about the current boot of
-		the active main	firmware type.
+		Returns main firmware type for current boot (integer).
 
 		== =====================================
 		0  Recovery.
@@ -28,8 +26,8 @@ What:		/sys/bus/platform/devices/GGL0001:*/CHSW
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the switch position for the Chrome OS specific
-		hardware switches when the firmware is booted.
+		Returns switch position for Chrome OS specific hardware
+		switches when the firmware is booted (integer).
 
 		==== ===========================================
 		0    No changes.
@@ -43,29 +41,29 @@ What:		/sys/bus/platform/devices/GGL0001:*/FMAP
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the physical memory address of the start of
-		the main processor firmware flashmap.
+		Returns physical memory address of the start of the main
+		processor firmware flashmap.
 
 What:		/sys/bus/platform/devices/GGL0001:*/FRID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the firmware version for the read-only portion
-		of the main processor firmware.
+		Returns firmware version for the read-only portion of the
+		main processor firmware.
 
 What:		/sys/bus/platform/devices/GGL0001:*/FWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the firmware version for the rewritable portion
-		of the main processor firmware.
+		Returns firmware version for the rewritable portion of the
+		main processor firmware.
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the type of the GPIO signal for the Chrome OS
-		specific GPIO assignments.
+		Returns type of the GPIO signal for the Chrome OS specific
+		GPIO assignments (integer).
 
 		=========== ==================================
 		1           Recovery button.
@@ -78,7 +76,7 @@ What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the signal attributes of the GPIO signal.
+		Returns signal attributes of the GPIO signal (integer bitfield).
 
 		== =======================
 		0  Signal is active low.
@@ -89,52 +87,51 @@ What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the GPIO number on the specified GPIO
+		Returns the GPIO number on the specified GPIO
 		controller.
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the name of the GPIO controller.
+		Returns name of the GPIO controller.
 
 What:		/sys/bus/platform/devices/GGL0001:*/HWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the hardware ID for the Chromebook.
+		Returns hardware ID for the Chromebook.
 
 What:		/sys/bus/platform/devices/GGL0001:*/MECK
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This binary file returns the SHA-1 or SHA-256 hash that is
-		read out of the Management Engine extended registers during
-		boot. The hash is exported vi ACPI so the OS can verify that
-		the Management Engine firmware has not changed. If Management
-		Engine is not present, or if the firmware was unable to read the
-		extended registers, this buffer size can be zero.
+		Returns the SHA-1 or SHA-256 hash that is read out of the
+		Management Engine extended registers during boot. The hash
+		is exported via ACPI so the OS can verify that the Management
+		Engine firmware has not changed. If Management Engine is not
+		present, or if the firmware was unable to read the extended registers, this buffer size can be zero.
 
 What:		/sys/bus/platform/devices/GGL0001:*/VBNV.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the offset in CMOS bank 0 of the verified boot
-		non-volatile storage block, counting from the first writable
-		CMOS byte (that is, 'offset = 0' is the byte following the 14
-		bytes of clock data).
+		Returns offset in CMOS bank 0 of the verified boot non-volatile
+		storage block, counting from the first writable CMOS byte
+		(that is, 'offset = 0' is the byte following the 14 bytes of
+		clock data).
 
 What:		/sys/bus/platform/devices/GGL0001:*/VBNV.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This file shows the size in bytes of the verified boot
-		non-volatile storage block.
+		Return the size in bytes of the verified boot non-volatile
+		storage block.
 
 What:		/sys/bus/platform/devices/GGL0001:*/VDAT
 Date:		May 2022
 KernelVersion:	5.19
 Description:
-		This binary file returns the verified boot data block shared
-		between the firmware verification step and the kernel
-		verification step.
+		Returns the verified boot data block shared between the
+		firmware verification step and the kernel verification step
+		(binary).
-- 
An old man doll... just what I always wanted! - Clara

