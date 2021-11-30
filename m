Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4F462ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhK3DE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:04:29 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:61923 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhK3DE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:04:28 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AU2YsZf037032;
        Tue, 30 Nov 2021 10:34:54 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Nov
 2021 10:59:24 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <b.zolnierkie@samsung.com>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <u.kleine-koenig@pengutronix.de>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH] hwmon: (pwm-fan) Let ctx->pwm_value be assigned only in __set_pwm
Date:   Tue, 30 Nov 2021 11:00:46 +0800
Message-ID: <20211130030046.3920-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AU2YsZf037032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to fix the bug when pwm_fan_probe the pwm_value will
be out of sync with the PWM hardware drivers.

Fixes: 86585c61972f ("hwmon: (pwm-fan) stop using legacy PWM functions and some cleanups")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/pwm-fan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 17518b4cab1b..f12b9a28a232 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -336,8 +336,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ctx->pwm_value = MAX_PWM;
-
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
 
 	/*
-- 
2.25.1

