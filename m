Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC71572BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiGMDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiGMDEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:04:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9014426ACA;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso2622322pjb.1;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TceMcUV+/l4WL/aDjeSG/t8FqTVXmRKi59JDreDyO4Y=;
        b=LgwCqeVcRYkCGf4XTCEuyfhdt+DypSM7nZPaxNKHD/63Y6XZ3h802i7v6BFOlbTEcX
         cqc4Wuq3jhys/RSbVU3FzEitLPAOLrHnL6oUTWlMcXWEQCs+I5w8ZU/Y0prsig8sJXg3
         1BGTuGsd9S/ZUSViw2qIK+NsfMrDZE7PV5Y0LqAF5z2IfV9OPviN1NyMj8w0pJlov8x7
         JALigW7v+06Qk+BiK4Hg6Eihv9INXN6JVuz78ASq/P/QZGLINnvn65oaK/RkUX8OlKwk
         Fm8Cm0D6lBzgYTbG3kwhwmM07WislvSilTbsY57wRZPAXlgErXjOePXzmPq67/zewXKp
         qUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TceMcUV+/l4WL/aDjeSG/t8FqTVXmRKi59JDreDyO4Y=;
        b=OuZmALjGwFlCpiFKwzYzD8fiIUMxgOajJMJp4y9V7i9xpdbR3wEah9A1Z3gpFj0ePp
         /9dUyz1LW7CFsjmcJl9f4Nogl9RK8e0lWPzv3vVEfJfCw8BD3BVjYnkCBcWwjJ2SErhg
         r/JeJVJZ4I3y/KEDFGDpnU5eevGePGxJNCGRo+Fe9C+oTjSTs6pGdF9LcC2iFHd4hJNN
         /3ap+JFFT79oFd4zvO3GYYxxW/j8tkL+f34iIlFUqadSOAY29e/FLCQauoJX7sG6fJF/
         l+U0SkNHJ2SGcsIsItrVON2cujzwKPE+O01QQYNzjxyMxHO8DmFLbaqmWaYh+6bBzNF0
         03fw==
X-Gm-Message-State: AJIora9Xl/CgzZgm7y+fD+RczuQQgMCs5qEYFL3KgAAhKoJ8uNHSfOYS
        BtpozYXYo4hn3Gs9iqicFXAg9yJmXQoy4w==
X-Google-Smtp-Source: AGRyM1s/8vU43pwgJyeE2uZ33X0EfSLycxmaVf9MwR6348/GdgjdSlV7qRI5QkUGPhqsz86dDcxxJg==
X-Received: by 2002:a17:902:d4c2:b0:16b:ffc5:9705 with SMTP id o2-20020a170902d4c200b0016bffc59705mr1137459plg.142.1657681433925;
        Tue, 12 Jul 2022 20:03:53 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0015e8d4eb24fsm7486570plg.153.2022.07.12.20.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:03:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2F2AD103950; Wed, 13 Jul 2022 10:03:47 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: qat: rewrite description
Date:   Wed, 13 Jul 2022 10:03:33 +0700
Message-Id: <20220713030332.158525-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713030332.158525-1-bagasdotme@gmail.com>
References: <20220713030332.158525-1-bagasdotme@gmail.com>
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

Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
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
index 43e081ec22cc4a..185f81a2aab360 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -2,18 +2,14 @@ What:		/sys/bus/pci/devices/<BDF>/qat/state
 Date:		June 2022
 KernelVersion:	5.20
 Contact:	qat-linux@intel.com
-Description:	Reports the current state of the QAT device and allows to
-		change it.
+Description:	(RW) Reports the current state of the QAT device. Write to
+		the file to start or stop the device.
 
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

