Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5384E508803
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378484AbiDTMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378483AbiDTMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:24:59 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3198326D3;
        Wed, 20 Apr 2022 05:22:11 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650457329;
        bh=p6I6CaMuJvEVxeeTXUn/5XsBaToXtFoR2rBvye6MGoc=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=p1j3UbJoz29cA12hveiAIL9VN/rY7XRa1XprLdBD7KxdaLWXFcBePOIlwJkcKBZqq
         PYQ4Zf62uGdihNBoHU/xslHAKNE/ap68GF6GeQVM1XCJIgQahST3MKQgptcDkU44Wf
         HNF8CCHjs1OiNsErj3KMQQcONS66dK9V6dKWGGRibvZzDjVzoLpdaQLu6KlU6IatEx
         jEIZqx2C/cSOEyksSUMTV6By0u3E2eWZhZWrqvFy5KgO9i7aN8WKun3LmMij2boMAO
         VbAdL2YHbP6wPakrLBwYmA1uM4gcIGy7dpa9XqefAxhn0n3oTZOnfcH32sCFVsDl+B
         +7AxHBSd9F0pw==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <20220420122128.411757-1-dev_public@wujek.eu>
In-Reply-To: <20220419215326.309991-1-dev_public@wujek.eu>
References: <20220419215326.309991-1-dev_public@wujek.eu>
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

Add registers to debugfs:
PMBUS_MFR_ID
PMBUS_MFR_MODEL
PMBUS_MFR_REVISION
PMBUS_MFR_LOCATION
PMBUS_MFR_DATE
PMBUS_MFR_SERIAL

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 0af7a3d74f47..1dc186780ccf 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *data, u64 =
*val)
 DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_statu=
s,
 =09=09=09 NULL, "0x%04llx\n");

+static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
+=09=09=09=09       size_t count, loff_t *ppos)
+{
+=09int rc;
+=09struct pmbus_debugfs_entry *entry =3D file->private_data;
+=09char data[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };
+
+=09rc =3D i2c_smbus_read_block_data(entry->client, entry->reg, data);
+=09if (rc < 0)
+=09=09return rc;
+
+=09data[rc] =3D '\n';
+=09rc +=3D 2;
+
+=09return simple_read_from_buffer(buf, count, ppos, data, rc);
+}
+
+static const struct file_operations pmbus_debugfs_ops_mfr =3D {
+=09.llseek =3D noop_llseek,
+=09.read =3D pmbus_debugfs_mfr_read,
+=09.write =3D NULL,
+=09.open =3D simple_open,
+};
+
 static int pmbus_debugfs_get_pec(void *data, u64 *val)
 {
 =09struct i2c_client *client =3D data;
@@ -2801,6 +2825,66 @@ static int pmbus_init_debugfs(struct i2c_client *cli=
ent,
 =09=09=09=09=09    &entries[idx++],
 =09=09=09=09=09    &pmbus_debugfs_ops);
 =09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_ID;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_id", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_MODEL)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_MODEL;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_model", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_REVISION)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_REVISION;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_revision", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_LOCATION)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_LOCATION;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_location", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_DATE)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_DATE;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_date", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
+
+=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_SERIAL)) {
+=09=09=09entries[idx].client =3D client;
+=09=09=09entries[idx].page =3D i;
+=09=09=09entries[idx].reg =3D PMBUS_MFR_SERIAL;
+=09=09=09scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_serial", i);
+=09=09=09debugfs_create_file(name, 0444, data->debugfs,
+=09=09=09=09=09    &entries[idx++],
+=09=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09=09}
 =09}

 =09return devm_add_action_or_reset(data->dev,
--
2.25.1


