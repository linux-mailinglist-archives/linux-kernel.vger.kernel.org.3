Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAC583C46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiG1Kol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiG1KoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3A61734;
        Thu, 28 Jul 2022 03:44:11 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJ1DApqneF13tsbEEaINLn03d6wJ0yyVFK64mpJmNjY=;
        b=phrOkml7GVl5iRc/lKmy8Y+bR47Dg0DAo3Imw+rCC1pY7a1P/WxTNLnek6FKCbugt4GXK4
        YkXRL+m8JcTQFFNWnRlQXlEI30M1tV1KGWxN4A/1NLZLGTSfjqGZeiSlMrItXCmeuqIlG9
        bguH0oFzBk+pcvwACey7M2A9ehoEFxro83sjkPaEH1icj/+U2gXKL5kqe2GHHxYQcVIAgu
        LEspHs+MQD+mG5PIcZe8Zup852ApWyen2ZW7GME9Xme43YW+lDWOsxwrnJerQbmiwCNOm3
        mj30ca5dpZ5MN+SIhZNaC7zX64ZUB86eIEbQawovuwItv02IxD6tGFmS9KSdug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJ1DApqneF13tsbEEaINLn03d6wJ0yyVFK64mpJmNjY=;
        b=3yJB741BN3pCFmGZBYH32Pnn9A1gPSxFT7lSEWNNSk7R/H8GCllDOoOY/4Z4SWUkIS6ZyQ
        OPebANZFVcRkkeCg==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Add R-Car Gen4 support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713100603.3391-4-wsa+renesas@sang-engineering.com>
References: <20220713100603.3391-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165900504842.15455.1659581738834019739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aa84506ea644d0952a75136dee7386cc54b234b0
Gitweb:        https://git.kernel.org/tip/aa84506ea644d0952a75136dee7386cc54b234b0
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Wed, 13 Jul 2022 12:06:03 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 18 Jul 2022 22:55:14 +02:00

clocksource/drivers/sh_cmt: Add R-Car Gen4 support

Add support for the R-Car Gen4 CMT types 0/1 which are the same as in
the previous two generations.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20220713100603.3391-4-wsa+renesas@sang-engineering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index dd0956a..64dcb08 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -981,6 +981,14 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,rcar-gen3-cmt1",
 		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
 	},
+	{
+		.compatible = "renesas,rcar-gen4-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen4-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
