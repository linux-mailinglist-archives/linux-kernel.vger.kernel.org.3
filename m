Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B7468801
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbhLDWGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:06:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLDWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:06:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E7A60F38;
        Sat,  4 Dec 2021 22:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B32DC341C0;
        Sat,  4 Dec 2021 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638655375;
        bh=N+VlrsEr9aiqHPnnvtl2aMDzbtaf9aBfb7J7GIVJvYc=;
        h=From:To:Cc:Subject:Date:From;
        b=MQlsaFk2Yz9w8F/ow/TDwbNpXynefUCUqcMBiOShR/YvcciaPI/kVw3GGFGISK+3L
         bJ9ZgDDxHAoxo69VaePdO65LCcqNSA1QGvhgF2yv27OuUCJ6tfnifJAWWgEpBC/tVT
         AV8Fw18TrsLOLP9q4xHuiEOnFAHeJPgqkbDdbinasDWS0hSqR/Qcf2BBtxT13hMk42
         wIAl1m/RkRuAtDrJdmOmPBq/3R9qBQeLqdHlh/Ye+c67uPeZ7vFAcDlSn1quC8O0b+
         SLAjXG6WPd4QZ1Az4BLuW1P6Oyy7A/WVYwanXpOisIOSVQJ95wUkLoFqL1AFmpmsq0
         CMuv2NwwAYrXw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?q?Ren=C3=A9=20Moll?= <Rene.Moll@xsens.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] power: reset: ltc2952: fix float conversion error
Date:   Sat,  4 Dec 2021 23:01:49 +0100
Message-Id: <20211204220249.591482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-14 does not like the way this driver converts a 'long double'
to an integer when the target architecture disables floating point
support:

drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux' does not support it
        data->wde_interval = 300L * 1E6L;
                                  ^

Turn this into pure integer math and make it more readable at the
same time using the NSEC_PER_MSEC macro instead.

Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/ltc2952-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fbb344353fe4..9fc88a9f244c 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
 
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 {
-	data->wde_interval = 300L * 1E6L;
-	data->trigger_delay = ktime_set(2, 500L*1E6L);
+	data->wde_interval = 300 * NSEC_PER_MSEC;
+	data->trigger_delay = ktime_set(2, 500 * NSEC_PER_MSEC);
 
 	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
-- 
2.29.2

