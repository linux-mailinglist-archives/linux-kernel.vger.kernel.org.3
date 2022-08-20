Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFF59AE71
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347149AbiHTNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiHTNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:14:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAC54CB3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:14:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl27so13397094ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YBNlUIC+sWQFPC4NY75KdykV7TqvJkq6httY7o/FFCU=;
        b=YXygqzcUxy6G5iv/8Jj1acxv+Yag3z484H0UEBkQ5ZnB3zr/3vPkVU+YPsS2/BDmlZ
         w3Wb0axy1dLnrJ2EUc7XiW5ircG/QK77LQaBU/7p/Z0OtTcMWiSGnzh7wJhv2cr/mLDF
         XIKtKIbX+J1EspBPFBIW7s1v5qUqyOEN56vyg7Xb9V4w25/taWEW4/FzEiX/mHDvPdUM
         OPPwb/qfB3TJHPaQKwwnWGch3yVHUuqL+KzPtbaLjDqHkn72QAt8vxpWUt6yhu4G3w9x
         0HF0Bj0Tu2+PtDR7AH6Qp4RIZRwpaP6vCH1CM9vnZsnLDQQlh9tbRONGCcJhYE3iRKoA
         GlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YBNlUIC+sWQFPC4NY75KdykV7TqvJkq6httY7o/FFCU=;
        b=xgtYaMm9MDVRMNCtz254dCEI9oKIvT7kk7nNkIqxfT6G+gi55iv1o2huzev3c4w9rA
         JYhVcB3K502oFkQZMHveu/52Kf23aghEZ7K18H7gp1Ae2j8bQJhzbtWvRguGxTMXBiEk
         v9MII8KZMQPJImJ2ukzbm3QfoCDo7tTGA5PFhzQwz4JpFKYkgtmjb0H9q8EhaWLoMMSC
         BnbGTXkQZwg1QIrv7LlaSzKzOEz06yImBhtrAIKCSaTCb5p3nrTsYEipzliEDPYfF3SQ
         QbjkjPzktW5wC4le9ci2fu1Cf7APku0aEwnO1dDbdM95z7P9A0WXH1oe0IUJSAF9FVFA
         TsEg==
X-Gm-Message-State: ACgBeo0o2lHnDaUbNwARM8G+0q8qHNU8ishkyBKdwia9icpTzja7KpLp
        oWAxU3ZdL1PpIauj3gEB8evOSA==
X-Google-Smtp-Source: AA6agR4V8B7jvvtMJIdGhS0iIFCUntHtBbUpD8A5OUud1aH/on/obS100gWDeDx1HJF5sLXsm7NljQ==
X-Received: by 2002:a17:907:1b1b:b0:72f:4445:3c11 with SMTP id mp27-20020a1709071b1b00b0072f44453c11mr7710486ejc.714.1661001279182;
        Sat, 20 Aug 2022 06:14:39 -0700 (PDT)
Received: from p330.kohl.home (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b007373afafa41sm3593836ejy.188.2022.08.20.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 06:14:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20Kohlschu=CC=88tter?= 
        <christian@kohlschutter.com>
To:     christian@kohlschutter.com
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mka@chromium.org
Subject: [PATCH v2] regulator: core: Remove "ramp_delay not set" debug message
Date:   Sat, 20 Aug 2022 13:14:21 +0000
Message-Id: <20220820131420.16608-1-christian@kohlschutter.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20220820122453.13071-1-christian@kohlschutter.com>
References: <20220820122453.13071-1-christian@kohlschutter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message shows up occasionally but in bursts (seen up to 30 times
per second on my ODROID N2+).

According to Matthias Kaehlcke's comment in 'regulator: core: silence
warning: "VDD1: ramp_delay not set"', this message should have been
removed after restructuring previous code that assumed that ramp_delay
being zero in that function was an error.

Link: https://lore.kernel.org/lkml/625675256c0d75805f088b4be17a3308dc1b7ea4.1477571498.git.hns@goldelico.com/T/
Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a5033c6ba01..18fa9206ec2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3497,10 +3497,8 @@ static int _regulator_set_voltage_time(struct regulator_dev *rdev,
 		 (new_uV < old_uV))
 		return rdev->constraints->settling_time_down;
 
-	if (ramp_delay == 0) {
-		rdev_dbg(rdev, "ramp_delay not set\n");
+	if (ramp_delay == 0)
 		return 0;
-	}
 
 	return DIV_ROUND_UP(abs(new_uV - old_uV), ramp_delay);
 }
-- 
2.36.2

