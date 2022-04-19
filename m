Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0920D507C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358089AbiDSVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiDSVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:55:02 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74143B01B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:52:17 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650405135;
        bh=ZCGA+da2eKfzdh/6+bASkS3nDbrqU7QzyvwVPI4RhN4=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=Hh28cAfvCNUARCszokwDrJ7izoNxpP7R9RyTFqSCnOcCiRO2PbZiq2fCjO+lskFD3
         zrxHNwbWqla9QV7iFUN/7LFKFQ9WQ/IuRSA8xVwdOdYjt3Qe4qsGbA3Fqpf2YA0pqp
         +0cgakeNg5TSYtnEhn9VYVfLkuHBsL1y9FQ2ToyxNlpcTAU0pLISbu0f3onAH7HFqq
         08Vkxrwl7Jxw3OSDBcRbL4TY81DjkkkGdMhETXct2JxkVzJCzxWRjYW9l4s/S5yrVL
         I462HVlpOQMiZyYc2O8D4BuAmKYN1QQn2xzL8KYSzTA5QAlj2di5ZF9P/KmaJxdUWV
         DcStHqqLDTutw==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] hwmon: (pmbus) allow to use a custom read_byte_data function for PMBUS_CAPABILITY
Message-ID: <20220419215149.309760-1-dev_public@wujek.eu>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices returns a wrong value in PMBUS_CAPABILITY register.
Allow the use of read_byte_data function defined in a driver for
a specific device.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index f8ca36759b0a..ef9989be8f89 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2011,7 +2011,7 @@ static int pmbus_init_common(struct i2c_client *clien=
t, struct pmbus_data *data,
 =09}

 =09/* Enable PEC if the controller supports it */
-=09ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+=09ret =3D _pmbus_read_byte_data(client, -1, PMBUS_CAPABILITY);
 =09if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 =09=09client->flags |=3D I2C_CLIENT_PEC;
 =09else
--
2.17.1


