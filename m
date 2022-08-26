Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD45A2394
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbiHZIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiHZIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:52:53 -0400
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F9D5DF7;
        Fri, 26 Aug 2022 01:52:52 -0700 (PDT)
Received: by mail-pj1-f68.google.com with SMTP id e19so1033838pju.1;
        Fri, 26 Aug 2022 01:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=UvnkUHp7fvjOchXOHcZW1sP5sxYcVssJ0Jnc0XrW4HI=;
        b=xd7IvQPvwPRrdZfaCpgqnp25bM79RR1OCRbXR7U+BgmdbfjhM83rZqt6+mXlLrMSL9
         s3qd/7qDAR2xDvVlD5whFQ8BgZMtCTYpIPkWdImpsLHCeuhkLRXxirhXWRjty8G6MPZA
         GhbJcg4uWTWakE1NmJxCCGkG6H2lJEQuK9mBQv8SPJuzM2Nbn7B8GWBq1dHOgzNlTNXQ
         Odng61kju9tHmIk6SpcZvamW2BoFfqfV1cb1nbMjWxkFeYUwrNNWulPzkV2OhXDP/DJn
         e+nm68qW+PkFhPSItfM+w0Jzqjvt+BXmWqIXNzbRCaVRLBoKsPJgMB/i8N7veFBwLIVB
         871g==
X-Gm-Message-State: ACgBeo3Hw9uCb9n5Chu+zk2yWs2rd3pAOmgj5u+Zf6kM3/1R/xF0pf68
        5oL3a/re+uA4+S4MWikVKg==
X-Google-Smtp-Source: AA6agR5v/MVYK7xa9wxbV8ZfXKmK4q3bQyLalN93d3IHhCjBSIMe4D2NwSmK8Q1wVuammwtaM/HEtw==
X-Received: by 2002:a17:90b:4ad2:b0:1fa:f9d3:df64 with SMTP id mh18-20020a17090b4ad200b001faf9d3df64mr3270863pjb.19.1661503972112;
        Fri, 26 Aug 2022 01:52:52 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b00172ea8ff334sm1023067plk.7.2022.08.26.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:52:51 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     wim@linux-watchdog.org, arnd@arndb.de
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH RESEND] watchdog: sa1100: make variable sa1100dog_driver static
Date:   Fri, 26 Aug 2022 16:52:43 +0800
Message-Id: <20220826085243.95997-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of sa1100_wdt.c, so marks it static.

Fixes the following warning:

>> drivers/watchdog/sa1100_wdt.c:241:24: sparse: sparse: symbol 'sa1100dog_driver'
was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sa1100_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 2d0a06a158a8..82ac5d19f519 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -238,7 +238,7 @@ static int sa1100dog_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct platform_driver sa1100dog_driver = {
+static struct platform_driver sa1100dog_driver = {
 	.driver.name = "sa1100_wdt",
 	.probe	  = sa1100dog_probe,
 	.remove	  = sa1100dog_remove,
-- 
2.25.1

