Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5259ED65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiHWUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiHWUff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:35:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041266347
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:16:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r22so13210803pgm.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SgKlxc/q4tGu/aOFprmVwiuG2cAvB2MjF52MJkBruE4=;
        b=R6NUwoC1uqFd7oUHLbjAB0FuZjHJhdPmHASeX6lrqfwQvj17+S27TCDMQOhDd5u6wr
         wZynKaGAxbhZZpJiSPYX9kCrtqBHQEtFluFe8vbcG54cHbuSQ9aM18Nz/NtA2yMduTD8
         r2qderaGRMFn+c+VVB4Bn62d1/4Nia5/EEmvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SgKlxc/q4tGu/aOFprmVwiuG2cAvB2MjF52MJkBruE4=;
        b=2/hJjRn2sZH8eLZ7sVfjClOmwbAU9t0eJCSwmluKIr0atRJl5LFDhsQN3xK/g6tCBi
         NLyH10b79KfuCLljzD/nurpZcI+oW4vgGhAHORlyUGh2oVEvOzCHipuJIFBdIQUZo9lj
         EqOd4WshnJMwK7ltCcOsM6PrVdaNZF/5X7O/j4fluDFqhRg5U/8L6a1jrLkktiv2ZC5N
         2/FFhuqTM7v6QFyqbCHDXAGkHsHxv3b5vx4zQoBSifWCXAu7k50zwO0C8J3CklWjxpHj
         FSNj7Xdox5ERvC4LSubxgsGBezz+Exdy0SCBKSo4B7XT7amdgrf/rMVxT9HHQsbJxBu/
         Ztgw==
X-Gm-Message-State: ACgBeo3/o+xMqGE0BePYqLSHgw0ER7qvYkb7Fq0BY+7PmGrxWRpQbfIv
        dAuuQR0GhRbtA7HFGQa9g+LQOA==
X-Google-Smtp-Source: AA6agR5R1ODtDba1SbJou8mhFJIVNykqB+C3maNIP6rLvNXvzA3SF3Z5JVQYtityF1+XvkwcpY9PHQ==
X-Received: by 2002:a05:6a00:3691:b0:535:d465:45c5 with SMTP id dw17-20020a056a00369100b00535d46545c5mr25554467pfb.30.1661285819415;
        Tue, 23 Aug 2022 13:16:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:a210:bcce:a0f1:160e])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b0016ecc7d5297sm4030015plt.292.2022.08.23.13.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:16:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFT PATCH] regulator: core: Require regulator drivers to check uV for get_optimum_mode()
Date:   Tue, 23 Aug 2022 13:16:34 -0700
Message-Id: <20220823131629.RFT.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_optimum_mode() for regulator drivers is passed the input
voltage and output voltage as well as the current. This is because, in
theory, the optimum mode can depend on all three things.

It turns out that for all regulator drivers in mainline only the
current is looked at when implementing get_optimum_mode(). None of the
drivers take the input or output voltage into account. Despite the
fact that none of the drivers take the input or output voltage into
account, though, the regulator framework will error out before calling
into get_optimum_mode() if it doesn't know the input or output
voltage.

The above behavior turned out to be a probelm for some boards when we
landed commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
get_optimum_mode(), not set_load()"). Before that change we'd have no
problems running drms_uA_update() for RPMH regulators even if a
regulator's input or output voltage was unknown. After that change
drms_uA_update() started to fail. This is because typically boards
using RPMH regulators don't model the input supplies of RPMH
regulators. Input supplies for RPMH regulators nearly always come from
the output of other RPMH regulators (or always-on regulators) and RPMH
firmware is initialized with this knowledge and handles enabling (and
adjusting the voltage of) input supplies. While we could model the
parent/child relationship of the regulators in Linux, many boards
don't bother since it adds extra overhead.

Let's change the regulator core to make things work again. Now if we
fail to get the input or output voltage we'll still call into
get_optimum_mode() and we'll just pass error codes in for input_uV
and/or output_uV parameters.

Since no existing regulator drivers even look at input_uV and
output_uV we don't need to add this error handling anywhere right
now. We'll add some comments in the core so that it's obvious that (if
regulator drivers care) it's up to them to add the checks.

Reported-by: Andrew Halaney <ahalaney@redhat.com>
Fixes: efb0cb50c427 ("regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5b5da14976c2..0bc4b9b0a885 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -979,10 +979,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	} else {
 		/* get output voltage */
 		output_uV = regulator_get_voltage_rdev(rdev);
-		if (output_uV <= 0) {
-			rdev_err(rdev, "invalid output voltage found\n");
-			return -EINVAL;
-		}
+
+		/*
+		 * Don't return an error; if regulator driver cares about
+		 * output_uV then it's up to the driver to validate.
+		 */
+		if (output_uV <= 0)
+			rdev_dbg(rdev, "invalid output voltage found\n");
 
 		/* get input voltage */
 		input_uV = 0;
@@ -990,10 +993,13 @@ static int drms_uA_update(struct regulator_dev *rdev)
 			input_uV = regulator_get_voltage(rdev->supply);
 		if (input_uV <= 0)
 			input_uV = rdev->constraints->input_uV;
-		if (input_uV <= 0) {
-			rdev_err(rdev, "invalid input voltage found\n");
-			return -EINVAL;
-		}
+
+		/*
+		 * Don't return an error; if regulator driver cares about
+		 * input_uV then it's up to the driver to validate.
+		 */
+		if (input_uV <= 0)
+			rdev_dbg(rdev, "invalid input voltage found\n");
 
 		/* now get the optimum mode for our new total regulator load */
 		mode = rdev->desc->ops->get_optimum_mode(rdev, input_uV,
-- 
2.37.2.609.g9ff673ca1a-goog

