Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFA57A6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiGSSuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiGSSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:50:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A42AD6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:50:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os14so28939944ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYY3tyKw9W6VjPIyH/jbNB/HQ0+4A3S5F1kVg6d7zKo=;
        b=k4offj5mDZeBIXNN1F9tpWytUxBTMf0LwLaXu0VcqzJw4BLSqdFx9AKW5mNqWPrOA8
         wwui0eBp/pdKkEc8ByiDopArT2i2fIxrzbVfJn6BzXscQ1+IQIVQPexb2XFmUPw8aZyn
         47NOE7rXeGDeolP3/1ujnTu+K/R8vL3OzboS613lZIH2pEvct7EEKOWOgOO7PkQQFl6a
         +8G88aHaOq8OaREadVzDxLpB1JyJKnz3fUzz50C6s8/iX3I6UkmT5XNUGepcX30NmYOy
         1vEWz7ZifWEsBgDmoLBqH7a2h53vwy0z3x+m6mpNjmIaez6VC6PVPYfhQyekSTZjirUe
         6Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYY3tyKw9W6VjPIyH/jbNB/HQ0+4A3S5F1kVg6d7zKo=;
        b=YeGFCESpmHLcBU4mGSi7pHpzIcPnQZtBuus/ioQiqOo+MhFcN9cHKXJfRoXnoD1f7u
         /jkcUQWOXhDlOi9lmYqyJNvSq8DGwHeyZ4ZmFvH6DxHacIejm7Wx4gFCS86TU9p93L1V
         pfEHJBpqSi60q9hIyMgJVQRDT/I7bOh6y5RqOucHmn/Sys80Xp1+LPDKqdOimP7MmKgv
         KQQ2yQRCfNNqxOiXqVvAFdVEQ+8y5YUhR3vw4MwKAY1OdQ4dqdf4+UsSxE2VAnGNI4yX
         dbG4QgkfTFmoqDciWaO9SpiDB/Ak8YtL9npwM5xoJv+10peJu+y14gIKAoE+2lf97ApD
         T+ZQ==
X-Gm-Message-State: AJIora+tzm+ZTAretoeH/4AWYU04KXLkN9G2TFTCq//0H9rwLoFIKla1
        WunzEyUMRqy+olAJ/ilX2bPv5g==
X-Google-Smtp-Source: AGRyM1sy1Dt3Pcdvm59/cWwFbr0uB0UA6+fPEvUbD2shef4RGDJFSFXZnpFW/tJsjkG5JepDRu5nBQ==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr30212587ejf.561.1658256604383;
        Tue, 19 Jul 2022 11:50:04 -0700 (PDT)
Received: from p330.fritz.box (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id i8-20020a50fd08000000b0043a554818afsm11062780eds.42.2022.07.19.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:50:03 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>, linux-kernel@vger.kernel.org
Subject: [PATCH REBASE] regulator: core: Fix off-on-delay-us for always-on/boot-on regulators
Date:   Tue, 19 Jul 2022 18:49:44 +0000
Message-Id: <20220719184943.1566-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <Yta/zrJxQOfYmN4C@sirena.org.uk>
References: <Yta/zrJxQOfYmN4C@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators marked with "regulator-always-on" or "regulator-boot-on"
as well as an "off-on-delay-us", may run into cycling issues that are
hard to detect.

This is caused by the "last_off" state not being initialized in this
case.

Fix the "last_off" initialization by setting it to the current kernel
time upon initialization, regardless of always_on/boot_on state.

Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f2c..398c8d6afd4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1565,6 +1565,9 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			rdev->constraints->always_on = true;
 	}
 
+	if (rdev->desc->off_on_delay)
+		rdev->last_off = ktime_get();
+
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
 	 */
@@ -1592,8 +1595,6 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
-	} else if (rdev->desc->off_on_delay) {
-		rdev->last_off = ktime_get();
 	}
 
 	print_constraints(rdev);
-- 
2.36.2

