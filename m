Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F872535E62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiE0Kfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiE0Kf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:35:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA21078BA;
        Fri, 27 May 2022 03:35:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CD621F8B5;
        Fri, 27 May 2022 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653647727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5FSJoV8fyODoIeus7C+ZOqbM6V+rdyM5MW/EB0jGZhg=;
        b=lZ4R+09BI7oCUROykElkZtExU3MC2o5/GA4qjwqbfJRif0pw+SFgCoaFWOMplVJRTW1ZId
        /PKDZY87B/Xa6gqeHA1h6GjAvgcOdDndJcjO+sGvX+7eQs9KgrhIP83w6rWD37t+6+HSq4
        18R21vZzmYyc2mMtDRp+sLU1pXdhqIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653647727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5FSJoV8fyODoIeus7C+ZOqbM6V+rdyM5MW/EB0jGZhg=;
        b=m0AVBa177TUk1M+dEEB3xnUQW0JFaICGQzEjpFN0I3LCXaYi39kc4XS3Q3Z2CnrD3h9xeR
        rkdV/zmWQ0P7J3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3448A13A84;
        Fri, 27 May 2022 10:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g0zaC2+pkGKOcAAAMHmgww
        (envelope-from <iivanov@suse.de>); Fri, 27 May 2022 10:35:27 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     "Ivan T. Ivanov" <iivanov@suse.de>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3] clk: bcm2835: Round UART input clock up
Date:   Fri, 27 May 2022 13:29:00 +0300
Message-Id: <20220527102900.144894-1-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that RPi3[1] and RPi Zero 2W boards have issues with
the Bluetooth. It turns out that when switching from initial to
operation speed host and device no longer can talk each other because
host uses incorrect UART baud rate.

The UART driver used in this case is amba-pl011. Original fix, see
below Github link[2], was inside pl011 module, but somehow it didn't
look as the right place to fix. Beside that this original rounding
function is not exactly perfect for all possible clock values. So I
deiced to move the hack to the platform which actually need it.

The UART clock is initialised to be as close to the requested
frequency as possible without exceeding it. Now that there is a
clock manager that returns the actual frequencies, an expected
48MHz clock is reported as 47999625. If the requested baud rate
== requested clock/16, there is no headroom and the slight
reduction in actual clock rate results in failure.

If increasing a clock by less than 0.1% changes it from ..999..
to ..000.., round it up.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
[2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7

Cc: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---

Changes since v2
* Added more information in commit message
* Changed hand crafted round function with the one form math.h

Changes since v1
Make bcm2835_clock_round() static to fix following warning
when compiling for riscv:
drivers/clk/bcm/clk-bcm2835.c:997:15: warning: no previous prototype for 'bcm2835_clock_round' [-Wmissing-prototypes]
Reported-by: kernel test robot <lkp@intel.com>

 drivers/clk/bcm/clk-bcm2835.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 48a1eb9f2d55..cee59990a57b 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -30,6 +30,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -502,6 +503,8 @@ struct bcm2835_clock_data {
 	bool low_jitter;
 
 	u32 tcnt_mux;
+
+	bool round_up;
 };
 
 struct bcm2835_gate_data {
@@ -993,12 +996,31 @@ static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
 	return temp;
 }
 
+static unsigned long bcm2835_clock_round(unsigned long clk)
+{
+	unsigned long scaler;
+
+	scaler = 1;
+	while (scaler * 100000 < clk)
+		scaler *= 10;
+
+	/*
+	 * If increasing a clock by less than 0.1% changes it
+	 * from ..999.. to ..000.., round up.
+	 */
+	if ((clk + scaler - 1) / scaler % 1000 == 0)
+		clk = roundup(clk, scaler);
+
+	return clk;
+}
+
 static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
+	unsigned long rate;
 	u32 div;
 
 	if (data->int_bits == 0 && data->frac_bits == 0)
@@ -1006,7 +1028,12 @@ static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
 
 	div = cprman_read(cprman, data->div_reg);
 
-	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
+	rate = bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
+
+	if (data->round_up)
+		rate = bcm2835_clock_round(rate);
+
+	return rate;
 }
 
 static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
@@ -2143,7 +2170,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_UARTDIV,
 		.int_bits = 10,
 		.frac_bits = 12,
-		.tcnt_mux = 28),
+		.tcnt_mux = 28,
+		.round_up = true),
 
 	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
 	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
-- 
2.35.3

