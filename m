Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14549A018
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1843428AbiAXXD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:03:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578136AbiAXWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:01:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 00A691F438FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643061705;
        bh=NKf8TvwzU0j7IGKB6x0vL0tnEezd/yNb8Y6+kHqjC5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnObaf8yIubXRT8EWRCozHf1frnWUj1CvdgrSl+UVhQ0Fws4oJAJlz9/U24/v2C8z
         UElVzD64if7lhfUNI4TnEQcimOoyvR7h3qLEWEqbgfmdrLIczdPbkgrBN9zP6Pv/K3
         1av1cZdI+NN/bjs3ZUbovXOly5dU5eUbWrdXZWuGKobufO0CZLG3/Y/qBAmkugBNyp
         hfFQG3EDqVrKiASVd/YplS2IHkNYUEO/6BIqRxyKcd+gjXr3DfWLzq1Pvl8uYIRqf9
         SYPF1gafP9FCfSAnAMAU7bcYNkg93vPSPpxlVF1I+O3BNK8zPqiUAaFJV+G0GB+65C
         3XjM8TU6ZlWoQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 8/9] regulator/rpi-panel-attiny: Use the regmap cache
Date:   Mon, 24 Jan 2022 17:01:28 -0500
Message-Id: <20220124220129.158891-9-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124220129.158891-1-detlev.casanova@collabora.com>
References: <20220124220129.158891-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The I2C to the Atmel is very fussy, and locks up easily on
Pi0-3 particularly on reads.

The LCD power status is controlled solely by this driver, so
rather than reading it back from the Atmel, use the regmap cache
to avoid reading values.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 8090b9a485b5..6e408a4b2c21 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -76,7 +76,7 @@ static const struct regmap_config attiny_regmap_config = {
 	.val_bits = 8,
 	.disable_locking = 1,
 	.max_register = REG_WRITE_DATA_L,
-	.cache_type = REGCACHE_NONE,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int attiny_set_port_state(struct attiny_lcd *state, int reg, u8 val)
-- 
2.34.1

