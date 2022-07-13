Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1935731B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiGMI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGMI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:57:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7213CEE1DA;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so9673033pfd.9;
        Wed, 13 Jul 2022 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TceMcUV+/l4WL/aDjeSG/t8FqTVXmRKi59JDreDyO4Y=;
        b=YR/UIXngdQpbtO47p/B49pkTwIduq8++/5exxY/5NLK1C4BARqLnsubk4tY1++NqEO
         ls+3wm0B21K6RIKR0/nBtyN7pGpL8T3LT2DmDuR/R6VkoZpEDwUQSv9qkAgqZ9APiIBI
         /87jaCS63a2eQ//jGmiUocWT2cNVEIowHg/FJCYc+pG1HtrDp9MHC5vB972LJPz1eWds
         2pbgGZVKV8kmpZ40Oq0/2oEn3h+eeiYMenyrh4upNTZJiYYAA2oSJQvuxG3l0QmfsmIs
         vH4aNPePyNgeBAfTLT2rnKtcGb5evoKbMTWbJx8fnQM/p/9YVjkROnIg3tZaxalurIQx
         3DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TceMcUV+/l4WL/aDjeSG/t8FqTVXmRKi59JDreDyO4Y=;
        b=LwuIsgw2sq1zISF7Tw83Obhe7tmfmSp8H1xyvSFxm1RIDBxQgGjybVPTBglcau67HR
         G3nTnU0D+ooXYfhm8Fc38VoIL3sxQr5M7fkPPvj/EfDPH1Kwa100IhWiBJtwxhivrIfT
         FJOwRyTIIenZ82pv+ygM5gsKKKe7YLf1Yv34pwUqYBG+o5NxghGvU5hG7IEYJ5reGYfb
         eqGIA+MhMYfVfqRlzauKAx6pCnguydBusNf8qY5HND+SiMMMigIQcqJPCzg4Fndw7Ujl
         KOdjXxriS19uELGAWddB4EzosOAe9+hElZr5RwaKZr6aGcM537n7auyuKuqHU15zhIUv
         gpcw==
X-Gm-Message-State: AJIora9uOALxWbtB6rFe/+d3mY8sdFWazUaF1Y+/9azDo0p9Em4b08j3
        ikgAT0EeyzHfVkMF3EBR68Ywb/8lmor8Qg==
X-Google-Smtp-Source: AGRyM1tsu1SxBk9EPNd+2+dGJgv7KO2elKPTAjyLJ2yuTvRLc4nOy0gSj01drJXgpzr9DvVr6YOkkw==
X-Received: by 2002:a63:1a4c:0:b0:416:1821:733d with SMTP id a12-20020a631a4c000000b004161821733dmr2088509pgm.444.1657702634761;
        Wed, 13 Jul 2022 01:57:14 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902e3c200b0016c0eb202a5sm8202527ple.225.2022.07.13.01.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:57:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8A5DC103975; Wed, 13 Jul 2022 15:57:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/2] Documentation: qat: rewrite description
Date:   Wed, 13 Jul 2022 15:56:28 +0700
Message-Id: <20220713085627.175604-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713085627.175604-1-bagasdotme@gmail.com>
References: <20220713085627.175604-1-bagasdotme@gmail.com>
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

