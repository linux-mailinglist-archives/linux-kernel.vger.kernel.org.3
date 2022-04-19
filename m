Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D7507B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357802AbiDSU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357792AbiDSUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:55:59 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AC3EF2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:53:13 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:53:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650401589;
        bh=n6zmsaqdCt4kKxEu/G00u+G6nFOZOq6snSec48Ro65U=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=vgZv9S6G4tHoUPR7I65J+UFMD+91LA2wstHK3xACdttBTl+8ENujETD3iuZHOx+w2
         bF+TMwz0LSJeKgNbpm3uX11fcKQz+8auSj85YqQ7+Jf+/F3CUJioC52fz5QiAlsUMM
         tK68ORZe0Q+gPfA8LpsTQVzGydwiyXFIUnuZuCC21JNOk/CprTktgGLIZtfhApJNSS
         iUvoK8fkjNcCmtNZK+EUUZL9zzfsCAI08vZCznNM2fEFs4NHxjYJldt2EZllQTAtRv
         26WXE56f1sECE0jeSSNs3MID++1DWeH1oV83ngOlHs42or2fioiLBfU5iH9jhJZ6uo
         HiSY8gQyixY8w==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Message-ID: <20220419205228.303952-1-dev_public@wujek.eu>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly disable PEC when the client does not support it.
Without the explicit disable, when the device with the PEC support is remov=
ed
later when a device without PEC support is inserted into the same address,
the driver uses the old value of client->flags which contains the I2C_CLIEN=
T_PEC
flag. As a consequence the PEC is used when it should not.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 82c3754e21e3..f8ca36759b0a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2014,6 +2014,8 @@ static int pmbus_init_common(struct i2c_client *clien=
t, struct pmbus_data *data,
 =09ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
 =09if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
 =09=09client->flags |=3D I2C_CLIENT_PEC;
+=09else
+=09=09client->flags &=3D ~I2C_CLIENT_PEC;

 =09pmbus_clear_faults(client);

--
2.17.1


