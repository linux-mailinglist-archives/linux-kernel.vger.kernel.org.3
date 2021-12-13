Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221B247349E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbhLMTDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:03:44 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10457 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240093AbhLMTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:03:43 -0500
X-IronPort-AV: E=Sophos;i="5.88,203,1635174000"; 
   d="scan'208";a="103339454"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2021 04:03:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB5A14000C7E;
        Tue, 14 Dec 2021 04:03:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] leds: ktd2692: Drop calling dev_of_node() in ktd2692_parse_dt
Date:   Mon, 13 Dec 2021 19:03:31 +0000
Message-Id: <20211213190331.5531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

output of dev_of_node() is already assigned to "np" variable in
ktd2692_parse_dt(). Use "np" variable to check if OF node is NULL
instead of calling dev_of_node() again.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/leds/flash/leds-ktd2692.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index f341da1503a4..ed1f20a58bf6 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -274,7 +274,7 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 	struct device_node *child_node;
 	int ret;
 
-	if (!dev_of_node(dev))
+	if (!np)
 		return -ENXIO;
 
 	led->ctrl_gpio = devm_gpiod_get(dev, "ctrl", GPIOD_ASIS);
-- 
2.17.1

