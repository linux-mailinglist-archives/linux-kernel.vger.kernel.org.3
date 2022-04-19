Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749D5507C33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358100AbiDSV4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357069AbiDSV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:56:39 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2C23DA70
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:53:54 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650405231;
        bh=YnTtRLrMceiJAjr17Kev+jb0+4PAI0gLw7VnQdS0VFg=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=uKNog/vwKw8AViHsdwdMmnZm+dcneuEAc4WZ8cZqB+452RsA30FPlhL6vejhu8w6C
         ee35audlkd6ruIfzsoqizhKCIeKzPXg7JsN3g7jDjWgJYCDBXMwsuneJ9idD7R1VDB
         opmUEIS7cdYoUhYmFVyItWbmrHm58UfRAddaaWvioL5FuY1GIjILAaibDzxE/R5VHp
         nWqP9u+ZMOLZhLG95xyeBXXFIUkvhcZIDqmuotxXPAGQo14xkPqsWohjNGKLvVpmGK
         wL4+eY5kuEIG+kbz1N6gPdS9T1eZcDrHDV8VWHstFC35YjwgSN2tkJkD/FJp6kmvcG
         IGqA6nIVxECcA==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <20220419215326.309991-1-dev_public@wujek.eu>
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

Add registers to debugfs:
PMBUS_MFR_ID
PMBUS_MFR_MODEL
PMBUS_MFR_REVISION
PMBUS_MFR_LOCATION
PMBUS_MFR_DATE
PMBUS_MFR_SERIAL

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/hwmon/pmbus/pmbus_core.c | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index ef9989be8f89..6dc63f364ee6 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2156,6 +2156,31 @@ static int pmbus_debugfs_get_status(void *data, u64 =
*val)
 DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_statu=
s,
 =09=09=09 NULL, "0x%04llx\n");

+
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
 static int pmbus_init_debugfs(struct i2c_client *client,
 =09=09=09      struct pmbus_data *data)
 {
@@ -2286,6 +2311,66 @@ static int pmbus_init_debugfs(struct i2c_client *cli=
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

 =09return 0;
--
2.17.1


