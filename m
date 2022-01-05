Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF21484E73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiAEGnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiAEGmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:42:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA1C061761;
        Tue,  4 Jan 2022 22:42:55 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1641364971;
        bh=ckkVZqRjU2EG/o/oxR6lOZ29zluSjUxYnya2PFcqtoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaCeujnF19+xdvQAqh8xdm7sZx4unyLe+552x0V5QlSJmoaEXAZ0dfNS8gu5EfdHt
         xS5fPZ6zRY1R1u8gWqP4kjP8qwlRxMGJfrv1oTWliT9ugMM8dT6vCU/2b3qUIVVGWI
         rW12PRVykMEaswY+3MStJsb4cGW8J/0lYaJ2ewh4=
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: fix charge_behaviour attribute initialization
Date:   Wed,  5 Jan 2022 07:42:38 +0100
Message-Id: <20220105064239.2689-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1641364918; l=1122; s=20211113; h=from:subject; bh=ckkVZqRjU2EG/o/oxR6lOZ29zluSjUxYnya2PFcqtoY=; b=xCxKEVj/QMBfnfYLlEen2qQsAhWPv9jlsOgU/EVaRaWJQFeOU6yeo5ToQkUzEcsaeWf7SMJLF4gq FbMxqnHoCfdckmTSpZ1VhimCxDrZtmEtWMDF14eCK6u4Cn2lV9Z9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All properties have to be added to power_supply_attrs which was missed
before.

Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5e3b8c15ddbe..491ffec7bf47 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -178,6 +178,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
 	POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
+	POWER_SUPPLY_ENUM_ATTR(CHARGE_BEHAVIOUR),
 	POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
 	POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),

base-commit: 998e7ea8c641fc6bbca1acd478c6824733ac9851
-- 
2.34.1

