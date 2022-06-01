Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15351539AC2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiFABdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiFABdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:33:16 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FB5B3F9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:33:12 -0700 (PDT)
Date:   Wed, 01 Jun 2022 01:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1654047190; x=1654306390;
        bh=amAPMCCPEklP8iHgRbF8DRtIbafxa6zl2AqTwOTE1cg=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=x4DgxkyTsma2V6g67DRZDm+SkE6aDg4HARNg5WsTJI4Vlv1Z9xyn1BipdS3g766w9
         lFe6VrFQ1JFQZsvHQH8cMyznB+5dPn1W+V9a9dIud4Cqzus8/3YFXjXAYDolx+Xfc8
         om4bgtnag/dvqDwMo9E9v21XryCrNYn83CVsvisA/Yhi5PlLI+k+wasWQUljvr35rL
         hqybqNPYl/2NPU+7AIP22ZJwRNZfoVV1ziwRy+5QPq8uiVW1ZaJ4VBQskPtXcubdGw
         bbJVk3yJoEHNB3Ooofb0db2zalyIWgjtCwkkbqmPE46XO8sV2LGdB+AomdaKwRIoxX
         SgW18fa1grvig==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH v3 1/2] hwmon: (pmbus) add a function to check the presence of a block register
Message-ID: <20220601013232.801133-1-dev_public@wujek.eu>
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

Other functions (like pmbus_check_byte_register) cannot be used to check
the presence of a block register, because it will generate error when PEC
is used.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
Notes:
  Changes in v2:
    - Use Phase 0xff when setting the page
  Changes in v3:
    - remove not needed initialization of a buffer
    - add checking the flag PMBUS_READ_STATUS_AFTER_FAILED_CHECK

 drivers/hwmon/pmbus/pmbus_core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index acf78d0829d9..a1c70877ae68 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -421,6 +421,18 @@ static int _pmbus_read_byte_data(struct i2c_client *cl=
ient, int page, int reg)
 =09return pmbus_read_byte_data(client, page, reg);
 }

+static int pmbus_read_block_data(struct i2c_client *client, int page, u8 r=
eg,
+=09=09=09=09 char *data_buf)
+{
+=09int rv;
+
+=09rv =3D pmbus_set_page(client, page, 0xff);
+=09if (rv < 0)
+=09=09return rv;
+
+=09return i2c_smbus_read_block_data(client, reg, data_buf);
+}
+
 static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, int=
 page,
 =09=09=09=09=09      int reg)
 {
@@ -558,6 +570,22 @@ bool pmbus_check_word_register(struct i2c_client *clie=
nt, int page, int reg)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);

+static bool pmbus_check_block_register(struct i2c_client *client, int page=
,
+=09=09=09=09       int reg)
+{
+=09int rv;
+=09struct pmbus_data *data =3D i2c_get_clientdata(client);
+=09char data_buf[I2C_SMBUS_BLOCK_MAX + 2];
+
+=09rv =3D pmbus_read_block_data(client, page, reg, data_buf);
+=09if (rv >=3D 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
+=09=09rv =3D pmbus_check_status_cml(client);
+=09if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
+=09=09data->read_status(client, -1);
+=09pmbus_clear_fault_page(client, -1);
+=09return rv >=3D 0;
+}
+
 const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *c=
lient)
 {
 =09struct pmbus_data *data =3D i2c_get_clientdata(client);
--
2.17.1


