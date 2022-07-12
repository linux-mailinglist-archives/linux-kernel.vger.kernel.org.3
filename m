Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102E25715BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiGLJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiGLJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:30:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D99CE2A;
        Tue, 12 Jul 2022 02:30:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b2so6768221plx.7;
        Tue, 12 Jul 2022 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogaV0SYnrdX6FcjsOyjMMkS0LUdBefdv3VdWOCo6cxw=;
        b=fZte5SOlOznJUDLkQ6hulO2D8dqJY6/fRaRa5Eo3RhJbZ/H9WzZiZA0gCzMyc9hKrs
         TW6486xwTqvHniUKUCRwKMB81AmjPOkrvDE9UOGpHmiEPgPrtmL2BxHQkd+BxVBSHSEM
         8FfR89fkydTW3QGirPQN9hp6wZqSijVeXjy83Vn7GSUs/so47r3lMpzfVL8kY79fRMqh
         fwTuRfO0VDPLoEOiTdzYMSJtN2MSN95Acrtt/jfQE5hbt4wdRV1vKYNf2S6WQjQY6Vkq
         j5/qS80Y4LaX4uTrHuoqHTbC+W1vUy+FjCmKdjSxW/Yq/vn2T6tV3KzKUaYJX/YGeMf2
         d/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogaV0SYnrdX6FcjsOyjMMkS0LUdBefdv3VdWOCo6cxw=;
        b=saMAg07K9+7TCky74nnn2bRm4AdzYNTUwGK01Z2SbuEdfJbCz+7JX0aom9OGwP5Zpr
         74bNQD5XRmjJPKBqTgUQIYoj+19+9UfnIU5yICSG3P9trJqm1BVn8FoK/HEx3HI1YiyO
         aXa+xTDaPqhF2tc2fkkVddpGqz4lVB7FZE3iDq2pxTtM+Q0zMCpCKX4POnx0WjPhArCM
         tKQBXrC8UnRnyDXXQ+t/Qe7BNNPgNY9Q6mjzowNktLFYls1O9HJnd6gvINZUYdVzHWdb
         NFvAK0Pgj39X8J3XMTtaUWId247tjvrbgJSP5vt7nARsl/muNEoMowPMWywGN0/iIJDU
         ZnkA==
X-Gm-Message-State: AJIora+tZIAGP3boFIhM5QJnWGuh18InY6ljs3ERnM2WKql/hoom0Cue
        AH+dHu/4A1Mujcyj0HTa+4k=
X-Google-Smtp-Source: AGRyM1vQcBeLg1mqQLb8HAGKTgppY9Auvl7T5br0Ioaq//7gU4WFIVXXGe9OGZXrkwWc4kY59Hx1kQ==
X-Received: by 2002:a17:902:b186:b0:16b:d762:6d81 with SMTP id s6-20020a170902b18600b0016bd7626d81mr23175273plr.88.1657618204997;
        Tue, 12 Jul 2022 02:30:04 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-9.three.co.id. [180.214.233.9])
        by smtp.gmail.com with ESMTPSA id s6-20020a63f046000000b003fba1a97c49sm5535236pgj.61.2022.07.12.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:30:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 77E341038FF; Tue, 12 Jul 2022 16:29:58 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next 2/3] Documentation: qat: rewrite description
Date:   Tue, 12 Jul 2022 16:29:53 +0700
Message-Id: <20220712092954.142027-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712092954.142027-1-bagasdotme@gmail.com>
References: <20220712092954.142027-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs description contains redundancy on returned and allowed values
list, due to the described sysfs is read-write. Rewrite.

Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc: Fiona Trahe <fiona.trahe@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 34 +++++++---------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index 43e081ec22cc4a..be6c200abd783c 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -2,18 +2,14 @@ What:		/sys/bus/pci/devices/<BDF>/qat/state
 Date:		June 2022
 KernelVersion:	5.20
 Contact:	qat-linux@intel.com
-Description:	Reports the current state of the QAT device and allows to
-		change it.
+Description:	(RW) Reports the current state of the QAT device. Write to
+		the file to initalize and start the device or to stop it.
 
-		This attribute is RW.
+		The values are:
 
-		Returned values:
-			up: the device is up and running
-			down: the device is down
+		* up: the device is up and running
+		* down: the device is down
 
-		Allowed values:
-			up: initialize and start the device
-			down: stop the device and bring it down
 
 		It is possible to transition the device from up to down only
 		if the device is up and vice versa.
@@ -24,22 +20,14 @@ What:		/sys/bus/pci/devices/<BDF>/qat/cfg_services
 Date:		June 2022
 KernelVersion:	5.20
 Contact:	qat-linux@intel.com
-Description:	Reports the current configuration of the QAT device and allows
-		to change it.
+Description:	(RW) Reports the current configuration of the QAT device.
+		Write to the file to change the configured services.
 
-		This attribute is RW.
+		The values are:
 
-		Returned values:
-			sym;asym:	the device is configured for running
-					crypto services
-			dc:		the device is configured for running
-					compression services
-
-		Allowed values:
-			sym;asym:	configure the device for running
-					crypto services
-			dc:		configure the device for running
-					compression services
+		* sym;asym: the device is configured for running crypto
+		  services
+		* dc: the device is configured for running compression services
 
 		It is possible to set the configuration only if the device
 		is in the `down` state (see /sys/bus/pci/devices/<BDF>/qat/state)
-- 
An old man doll... just what I always wanted! - Clara

