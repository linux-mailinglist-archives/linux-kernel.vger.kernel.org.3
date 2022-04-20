Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FF509203
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382482AbiDTVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382470AbiDTVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:25:14 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FD4831B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:22:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so3121939pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NkGKQjbsTB4bNp9Z4zXod1/h33OJ7SkFwEKJXBo9i8=;
        b=Ni1oKrGvg5dONJOSqp5WqU5AE7KFB8+W2rNYd2Wn3FIO6Tv8vyoIOccdqcgIfLl7Fx
         j/kbpsRk8l5WW4f/t0/yeEQNPOu/Q+i16VjwBYraT+BQfs8JEsoUiKCmZrYizH8YEc7y
         O4DYN7/AIeTKHkt0SuFyuseqCilAOPuohhFKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NkGKQjbsTB4bNp9Z4zXod1/h33OJ7SkFwEKJXBo9i8=;
        b=DGFA71CXfuu8+RDheiK0UrOVMovQKZHRIGj+dXPM1scFzj0o7sVqWo1jr+feGQWFtX
         tyARi6RM1DoAfI4hpnhllNj69Bb3r/kIJiBoE0HpStZ3YFA3JE0e8mu4eCmLrCUVNS5h
         jM6/2aU4nMkZkpHuNFN6qj8w9E3qXY/Ptc57C4aO0+69c7ruOBaQDjDRus+dfHVLfJX8
         K2z9o2/5nd3TigSia7AEDAWcLbivVz8y1HwRhhk2wmeep5BSioKYnBIAUpy71lbaRKpP
         bZrJv3y84U6edj2ETyc1+oQg3QsORkOQ3bH+s77dAVZ4zfUHStMn/FrBRp1kYCOLWTPJ
         Ar5g==
X-Gm-Message-State: AOAM532NnxzlIgKtzoDIuuL3rMRKJdmb70HMSevKBd60CYCpKWKvctHj
        tsTYvYzEVoW32GhMHZwQ1O5PHECuI0Lbwg==
X-Google-Smtp-Source: ABdhPJzEm6l0BDFcyDo8p839zrwVorQpOKdIuQcDMwAsz8HvjbeWxFJyBZPkuH/oEm6N5WAmlc7XUA==
X-Received: by 2002:a05:6a00:23d5:b0:50a:93e9:965e with SMTP id g21-20020a056a0023d500b0050a93e9965emr11319969pfc.10.1650489746749;
        Wed, 20 Apr 2022 14:22:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:22df:200c:2f31:fe5])
        by smtp.gmail.com with UTF8SMTPSA id d20-20020a056a00199400b005060849909esm24211935pfl.176.2022.04.20.14.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 14:22:26 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/2] regulator: core: Sleep (not delay) in set_voltage()
Date:   Wed, 20 Apr 2022 14:22:13 -0700
Message-Id: <20220420141511.v2.2.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220420141511.v2.1.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
References: <20220420141511.v2.1.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These delays can be relatively large (e.g., hundreds of microseconds to
several milliseconds on RK3399 Gru systems). Per
Documentation/timers/timers-howto.rst, that should usually use a
sleeping delay. Let's use the existing regulator delay helper to handle
both large and small delays appropriately. This avoids burning a bunch
of CPU time and hurting scheduling latencies when hitting regulators a
lot (e.g., during cpufreq).

The sleep vs. delay issue choice has been made differently over time --
early versions of RK3399 Gru PWM-regulator support used usleep_range()
in pwm-regulator.c. More of this got moved into the regulator core,
in commits like:

73e705bf81ce regulator: core: Add set_voltage_time op

At the same time, the sleep turned into a delay.

It's OK to sleep in _regulator_do_set_voltage(), as we aren't in an
atomic context. (All our callers grab various mutexes already.)

I avoid using fsleep() because it uses a usleep_range() of [N to N*2],
and usleep_range() very commonly biases to the high end of the range. We
don't want to double the expected delay, especially for long delays.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
 * Add Matthias's "Reviewed-by"
 * Use regulator helper instead of fsleep()
 * Reorder patch 1&2

 drivers/regulator/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8b188e56fd0b..0279ff687e1d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3548,12 +3548,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	}
 
 	/* Insert any necessary delays */
-	if (delay >= 1000) {
-		mdelay(delay / 1000);
-		udelay(delay % 1000);
-	} else if (delay) {
-		udelay(delay);
-	}
+	_regulator_delay_helper(delay);
 
 	if (best_val >= 0) {
 		unsigned long data = best_val;
-- 
2.36.0.rc0.470.gd361397f0d-goog

