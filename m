Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D85505F25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347952AbiDRVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiDRVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:15:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F522CCA7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:12:51 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j71so7573827pge.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bFlDtoHqXrD/bV3CCVWd42azNRMgyWRb3PBwzvLmRA=;
        b=XicyQjyUvi05/iutniPuMM7K/ZIg7rOgo0edexrYUl6iATTuzsKgLxN4MgE7us9tVL
         Kc84lk2VAuMxMY3tRRT5g1hR5Fo6zT7g+bYA66lcPAccx74mJu7h6Lq0A7hxuDcrkcCC
         jptHBs4budj0AjcghfUZplUrvNjzrNfPiiPXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bFlDtoHqXrD/bV3CCVWd42azNRMgyWRb3PBwzvLmRA=;
        b=4VLsURDed3MhKmKy0HpNO7vAAgd6TDbd/luAjEA51d62ml3WfN6GCH1qN0C6Irq+ai
         cJi9ONGYmKLqsQ5hVkejsRK+nlDHpbIM6JtNJT+yA15M+FblsALOvKlkXU/hFkPD3EV/
         391xs/EV6jrJCJnhkbXEbws7skLaM3AhSH/9j1WnlWm+jBgLBkT8Ssx2SQoMP70mAR2j
         G7zYmFmbA5R3l5Bb96mwIj+oVcaGKr41+BeiNK05IlG3c0QBHVpZGEfKbC2vt7fKzn0w
         eB3/4uQr2zXPrbMeIZCH9cpG2GbhEDkgW4E6HdppMju35UzchUg3tA0HthhtuX6cAsrv
         p8bQ==
X-Gm-Message-State: AOAM530G7Utax0eHyS39yuQktsjomY7+npKVu7YwL3J1QtuIBhrlBhO/
        wHr4ie5VLyn8AP/PdJV/fh2lxQ==
X-Google-Smtp-Source: ABdhPJwrYHeGOnJwgq4wGhg5dmnlQSmaL04C4Vv+9n0R6rXc2quAneGNNy9zwwhYG0KmKbDITMTIdw==
X-Received: by 2002:a62:7bc9:0:b0:508:2e2a:c36c with SMTP id w192-20020a627bc9000000b005082e2ac36cmr14235811pfc.67.1650316371335;
        Mon, 18 Apr 2022 14:12:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c240:3b46:d799:c833])
        by smtp.gmail.com with UTF8SMTPSA id x39-20020a056a0018a700b004fa7e6ceafesm14282202pfh.169.2022.04.18.14.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:12:50 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] regulator: core: Sleep (not delay) in set_voltage()
Date:   Mon, 18 Apr 2022 14:12:39 -0700
Message-Id: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These delays can be relatively large (e.g., hundreds of microseconds on
RK3399 Gru systems). Per Documentation/timers/timers-howto.rst, that
should usually use a sleeping delay. Let's use fsleep() to handle both
large and small delays appropriately. This avoids burning a bunch of CPU
time and hurting scheduling latencies when hitting regulators a lot
(e.g., during cpufreq).

The sleep vs. delay issue choice has been made differently over time --
early versions of RK3399 Gru PWM-regulator support used usleep_range()
in pwm-regulator.c. More of this got moved into the regulator core,
in commits like:

73e705bf81ce regulator: core: Add set_voltage_time op

At the same time, the sleep turned into a delay.

It's OK to sleep here, as we aren't in an atomic contexts. (All our
callers grab various mutexes already.)

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/regulator/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d2553970a67b..223c6d71a2b2 100644
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
+	fsleep(delay);
 
 	if (best_val >= 0) {
 		unsigned long data = best_val;
-- 
2.36.0.rc0.470.gd361397f0d-goog

