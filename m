Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5044764E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLOVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:50:05 -0500
Received: from mxwww.masterlogin.de ([95.129.51.170]:42604 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhLOVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:50:03 -0500
Received: from mxout1.routing.net (unknown [192.168.10.81])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id F008D2C446
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:33:14 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 99A783FEAE;
        Wed, 15 Dec 2021 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1639603991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eal7IPsnWFVb9A22/KxrcFo3bDHrlVGVXDoTWYopCYw=;
        b=npXPobUbYecSU4L/mYExWqcd9jqPS3TmAtD2StksKS9G3tTW9PYzlu9Q7F3LEHJNBfLUzi
        +pvVNTUBXGyfoWUamqt9aNwxOCbl4Q4+bi8SAlJJm1hxIzpezwvdY2iG8LAZVxCAHKhBF/
        1pLB+CJgZpeX6WMAVQHRNGmzG+6CVDA=
Received: from localhost.localdomain (fttx-pool-80.245.79.169.bambit.de [80.245.79.169])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 01AFC4023F;
        Wed, 15 Dec 2021 21:33:10 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 2/2] mfd: rk808: Add poweroff and reboot support for rk809 pmic
Date:   Wed, 15 Dec 2021 22:33:00 +0100
Message-Id: <20211215213300.4778-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215213300.4778-1-linux@fw-web.de>
References: <20211215213300.4778-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 43c0ee09-672c-4d6b-94c3-1cde6f35e318
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add support for reset/poweroff rk809. It uses same Register and Values
like rk817 so just add the Chip_id.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/mfd/rk808.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index afbd7e01df50..2353caa81aa2 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -545,6 +545,7 @@ static void rk808_pm_power_off(void)
 		reg = RK808_DEVCTRL_REG,
 		bit = DEV_OFF_RST;
 		break;
+	case RK809_ID:
 	case RK817_ID:
 		reg = RK817_SYS_CFG(3);
 		bit = DEV_OFF;
@@ -577,6 +578,7 @@ static int rk808_restart_notify(struct notifier_block *this, unsigned long mode,
 		reg = RK808_DEVCTRL_REG,
 		bit = DEV_OFF;
 		break;
+	case RK809_ID:
 	case RK817_ID:
 		reg = RK817_SYS_CFG(3);
 		bit = DEV_RST;
-- 
2.25.1

