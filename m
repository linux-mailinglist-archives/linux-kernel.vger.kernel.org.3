Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85B52E098
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiESXeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiESXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:34:11 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D7111BAA;
        Thu, 19 May 2022 16:34:10 -0700 (PDT)
Date:   Thu, 19 May 2022 23:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1653003248; x=1653262448;
        bh=LyRrYUAfnrOlxEV8oP2sHMBTRL2yGmI3LgV/g5hKsu8=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=BQFniW+okpJQpTrAkOEd0e0zhN2cK2O27PSxKOCRKV+q2e3MKReFAcsgHJkGDB97h
         nXB+dYoaeRnc6WBq6XJp3FeEZjqEyTIMdQJIr/V0kzee/FsfOSHbddYXWAABS1UmGO
         lALsYbL5JATJSrfkkr3o+skIRaVFFrTpoYzjhnpjSVA+TiKekSp76nHHuPHZtHSvSI
         emq+2bP/Ho/9RPEVuDZiferPRf1rSc6bCe7yMZvmQi3QwODFU+AnLEvXfPd/HDV8pN
         gB9QLL3b+et/IfQ5ocfTi0YelTDnhrhKYSIsbN3SzUMDHrqq6J6vKi0PtQoN+X0Q8F
         n6IWXvKx2XOhQ==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] hwmon: (pmbus) Check PEC support before reading other registers
Message-ID: <20220519233334.438621-1-dev_public@wujek.eu>
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

Make sure that the support of PEC is determined before the read of other
registers. Otherwise the validation of PEC can trigger an error on the read
of STATUS_BYTE or STATUS_WORD registers.

The problematic scenario is the following. A device with enabled PEC
support is up and running and a kernel driver is loaded.
Then the driver is unloaded (or device unbound), the HW device
is reconfigured externally (e.g. by i2cset) to advertise itself as not
supporting PEC. Without the move of the code, at the second load of
the driver (or bind) the STATUS_BYTE or STATUS_WORD register is always
read with PEC enabled, which is likely to cause a read error resulting
with fail of a driver load (or bind).

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
Notes:
- This commit extends the fix implemented in the commit:
  75d2b2b06bd8 hwmon: (pmbus) disable PEC if not enabled
- The move of the only line:
  client->flags &=3D ~I2C_CLIENT_PEC;
  would make the read of STATUS_BYTE and STATUS_WORD registers that follow
  always without PEC

 drivers/hwmon/pmbus/pmbus_core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index e82af82fe4ca..55153a71c170 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2308,6 +2308,23 @@ static int pmbus_init_common(struct i2c_client *clie=
nt, struct pmbus_data *data,
 =09struct device *dev =3D &client->dev;
 =09int page, ret;

+=09/*
+=09 * Figure out if PEC is enabled before accessing any other register.
+=09 * Make sure PEC is disabled, will be enabled later if needed.
+=09 */
+=09client->flags &=3D ~I2C_CLIENT_PEC;
+
+=09/* Enable PEC if the controller and bus supports it */
+=09if (!(data->flags & PMBUS_NO_CAPABILITY)) {
+=09=09ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+=09=09if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
+=09=09=09if (i2c_check_functionality(client->adapter,
+=09=09=09=09=09=09    I2C_FUNC_SMBUS_PEC)) {
+=09=09=09=09client->flags |=3D I2C_CLIENT_PEC;
+=09=09=09}
+=09=09}
+=09}
+
 =09/*
 =09 * Some PMBus chips don't support PMBUS_STATUS_WORD, so try
 =09 * to use PMBUS_STATUS_BYTE instead if that is the case.
@@ -2326,19 +2343,6 @@ static int pmbus_init_common(struct i2c_client *clie=
nt, struct pmbus_data *data,
 =09=09data->has_status_word =3D true;
 =09}

-=09/* Make sure PEC is disabled, will be enabled later if needed */
-=09client->flags &=3D ~I2C_CLIENT_PEC;
-
-=09/* Enable PEC if the controller and bus supports it */
-=09if (!(data->flags & PMBUS_NO_CAPABILITY)) {
-=09=09ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
-=09=09if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK)) {
-=09=09=09if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC))=
 {
-=09=09=09=09client->flags |=3D I2C_CLIENT_PEC;
-=09=09=09}
-=09=09}
-=09}
-
 =09/*
 =09 * Check if the chip is write protected. If it is, we can not clear
 =09 * faults, and we should not try it. Also, in that case, writes into
--
2.17.1


