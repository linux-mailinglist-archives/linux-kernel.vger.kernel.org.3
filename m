Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F184870A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbiAGCk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:40:26 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:13523 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345530AbiAGCkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:40:24 -0500
Received: from droid10-sz.amlogic.com (10.28.8.20) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 7 Jan 2022
 10:40:20 +0800
From:   Zelong Dong <zelong.dong@amlogic.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <khilman@baylibre.com>, <narmstrong@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 3/3] reset: reset-meson: add support for the Meson-S4 SoC Reset Controller
Date:   Fri, 7 Jan 2022 10:39:31 +0800
Message-ID: <20220107023931.13251-4-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107023931.13251-1-zelong.dong@amlogic.com>
References: <20220107023931.13251-1-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.20]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to the A1 SoCs the number of RESET registers is different
and the offset for the level registers is the same. Add a new
compatible string and struct meson_reset_param to add support for the
reset controller on the S4 SoC.

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
---
 drivers/reset/reset-meson.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index c9bc325ad65a..26dc54778615 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -98,11 +98,17 @@ static const struct meson_reset_param meson_a1_param = {
 	.level_offset	= 0x40,
 };
 
+static const struct meson_reset_param meson_s4_param = {
+	.reg_count	= 6,
+	.level_offset	= 0x40,
+};
+
 static const struct of_device_id meson_reset_dt_ids[] = {
 	 { .compatible = "amlogic,meson8b-reset",    .data = &meson8b_param},
 	 { .compatible = "amlogic,meson-gxbb-reset", .data = &meson8b_param},
 	 { .compatible = "amlogic,meson-axg-reset",  .data = &meson8b_param},
 	 { .compatible = "amlogic,meson-a1-reset",   .data = &meson_a1_param},
+	 { .compatible = "amlogic,meson-s4-reset",   .data = &meson_s4_param},
 	 { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
-- 
2.34.1

