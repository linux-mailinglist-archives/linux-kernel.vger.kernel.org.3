Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CD4D7E90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiCNJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiCNJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B13527A;
        Mon, 14 Mar 2022 02:28:22 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsZXj1i0gVfeGzHaAYAGqiS4zC0iqUJz74PBWog4ReA=;
        b=K2oGzTp109rycMpdzih1LlJs9tgIkJIE4D92HZopMRPZAM24kf7ZbuPsiPTtTQpb+81qJ0
        6XZGWwnOxjwO3ieWQJXjN4mfmGsD6HjxsQasC5I02u+W1wC0OKCrfWs/R1DhWbqw5cMuLt
        EedwLpByozENtQnyfhvA7/smVdIj6UaqqxFpy9Ft8EwidkahlqNkJLCdqcvZE2C1aVBnv3
        gUHMvc4nYTEus6Ooet3aB//LZQogI3I6wWbF4RBk8UD2Nb9y5YEUl4p1gDpey7qhXsfpKE
        chnq7By22BgHd7Kr6AdtnMEpA4WLXs/QtlkwWlTX7FnzCvr0PmUGAEJqK8lHkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsZXj1i0gVfeGzHaAYAGqiS4zC0iqUJz74PBWog4ReA=;
        b=JZpdZVUsSb79xU7zxMhnK58/Pjc+f+Hbrb99ObyuTiNZGe5q1NAnx7wBm5GnhZdyX9yxKj
        t1aF+9kcGCczZ0Bw==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Use notrace
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220304133601.2404086-3-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <164725010037.16921.9970306478525402477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ff10ee97cb203262e88d9c8bc87369cbd4004a0c
Gitweb:        https://git.kernel.org/tip/ff10ee97cb203262e88d9c8bc87369cbd4004a0c
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Fri, 04 Mar 2022 15:35:57 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:28 +01:00

clocksource/drivers/timer-microchip-pit64b: Use notrace

Use notrace for mchp_pit64b_sched_read_clk() to avoid recursive call of
prepare_ftrace_return() when issuing:
echo function_graph > /sys/kernel/debug/tracing/current_tracer

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220304133601.2404086-3-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-microchip-pit64b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index cfa4ec7..790d2c9 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -165,7 +165,7 @@ static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
-static u64 mchp_pit64b_sched_read_clk(void)
+static u64 notrace mchp_pit64b_sched_read_clk(void)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
