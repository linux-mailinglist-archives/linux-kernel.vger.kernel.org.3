Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE3484E72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiAEGm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:42:57 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:41247 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbiAEGmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:42:55 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1641364971;
        bh=Dq3BHuCbeArfebh5gWrRObPgO7rpTfM1CntbrUioOgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3LGG4logHlSDHooFM9bvmBY4Yg4NkGRxZKbfsjKpWRvg4qvHvSX+s14V3/wjCnZS
         HP/T9UKPaXkInSnovq7Un1X7JqUwV2AGrP4ioGdpoDmsdUfpLB4vszycblHgSuaDFf
         Xxmyx1uiCvP5wLili+KHE2St5wIU6vrdNMe/0Nl0=
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: validate size of power_supply_attrs at compiletime
Date:   Wed,  5 Jan 2022 07:42:39 +0100
Message-Id: <20220105064239.2689-2-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
References: <52cedbd4-7db2-7d81-f6c6-e6f6b7436545@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1641364918; l=1340; s=20211113; h=from:subject; bh=Dq3BHuCbeArfebh5gWrRObPgO7rpTfM1CntbrUioOgY=; b=iPHtX2pwqf8rgip2aL0uLNjIsBufKsFp4xuH7kdLPtpddXf1fDdOMxWUJkqdGPdqZupejU0IKW3/ HXw4KbdVCRihWNbMp61HmSQDqgeLI5RUVN97DzxZDIpE48d+E7d2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each member of enum power_supply_property a matching entry in
power_supply_attrs is needed.
Add a basic test at compiletime to validate this in addition to the
existing runtime testing.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_sysfs.c | 2 ++
 include/linux/power_supply.h              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 491ffec7bf47..2565052a7a8c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -403,6 +403,8 @@ void power_supply_init_attrs(struct device_type *dev_type)
 {
 	int i;
 
+	BUILD_BUG_ON(ARRAY_SIZE(power_supply_attrs) != __POWER_SUPPLY_PROP_CNT);
+
 	dev_type->groups = power_supply_attr_groups;
 
 	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 71f0379c2af8..60853f26e25f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -172,6 +172,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+
+	__POWER_SUPPLY_PROP_CNT
 };
 
 enum power_supply_type {
-- 
2.34.1

