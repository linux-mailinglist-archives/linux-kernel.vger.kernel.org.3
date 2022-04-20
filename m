Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8750888F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378653AbiDTM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378647AbiDTM5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:57:37 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FD110D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:54:49 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:54:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650459287;
        bh=+8+1bERFEDfD5DtGG4zF7lQrC6F4hcnI/ewNHOmoNj0=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=YyvXWSC85ziVaPQu9qzlDAZ35WqHJsiHTHMHdIgtN2rLAnHp1XP44of/2L04KCi1v
         sEAp5fAX0TN9p9Di02WpohaHw/R2G4Jti+95BADe5Im7jBwfv9tIJWN/WAlmxFW7L9
         Bpx9yoNgqNbrp4PS7Ui9/xHwVYGyX/7SniYSvQzJmNW9Y7rO0Xf3oAKzSTB1PpA6pP
         A3MFsuAdZzdte2zrLQDXfo/czWUMeRjJyNEd3HHyyWzV09kmygrxYuW6//4Ai9CGJ6
         oIiLAopF3FCkoYGycJP1LpKwNKqfH8WPKAdrGMpYg/ZT74sBDEJ6FbeeFMqIjsgrQc
         A9ho+bfoOFGIQ==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Message-ID: <20220420125421.415716-1-dev_public@wujek.eu>
In-Reply-To: <d2d09fe1-dada-e844-cafa-da48424855a4@roeck-us.net>
References: <20220419205228.303952-1-dev_public@wujek.eu> <d2d09fe1-dada-e844-cafa-da48424855a4@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly disable PEC when the client does not support it.
The problematic scenario is the following. A device with enabled PEC
support is up and running, a kernel driver loaded.
Then the driver is unloaded (or device unbound), the HW device
is reconfigured externally (e.g. by i2cset) to advertise itself as not
supporting PEC. Without a new code, at the second load of the driver
(or bind) the "flags" variable is not updated to avoid PEC usage. As a
consequence the further communication with the device is done with
the PEC enabled, which is wrong.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index b2618b1d529e..0af7a3d74f47 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2334,7 +2334,8 @@ static int pmbus_init_common(struct i2c_client *clien=
t, struct pmbus_data *data,
 =09=09=09=09client->flags |=3D I2C_CLIENT_PEC;
 =09=09=09}
 =09=09}
-=09}
+=09} else
+=09=09client->flags &=3D ~I2C_CLIENT_PEC;

 =09/*
 =09 * Check if the chip is write protected. If it is, we can not clear
--
2.25.1


