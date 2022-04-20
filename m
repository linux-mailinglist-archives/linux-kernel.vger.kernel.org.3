Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF050923C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382620AbiDTVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382624AbiDTVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:44:07 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF8427CD;
        Wed, 20 Apr 2022 14:41:16 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:41:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650490875;
        bh=KmMNR6faHtqUvs9lVAABz3wIvjkciGijqVJv/rEeN9I=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=BQOGgQSpieFh8CzNHO1r9GsXm5vX25hwrxRQgpNc6JPeFNbfvuyQYPPXqk63USmoq
         4wFe02/TalZU1zaSWcQwbJYXRBhRGrUJMARxkPReRzYl5wBG4kVcZwT4/ekUHsk+6L
         4B0ImiqaYTAqHQcD0EQ/abedaoDN7/0YwuBHbXcq3/3GWHT0RVR89hw3dYlTUQDVQr
         uwxdYoAjZOdfjisuC+yRsvRF1u2tg6qt4wJ6t12TgnmPmBWoRP7RDcsvD04YcvhMH/
         RirH6RldwGVSdf7ncjjo7pAjR5/hIuJuAdcEQoWNzaOAwcf9N9DSdpsibnFOADnX9d
         cQea3NZRgV+rA==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [v4 PATCH] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <20220420214053.482902-1-dev_public@wujek.eu>
In-Reply-To: <1b12cb3a-3d87-8254-b229-dcf83ad0bc0a@roeck-us.net>
References: <20220419215326.309991-1-dev_public@wujek.eu> <20220420122128.411757-1-dev_public@wujek.eu> <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net> <PFzjnraIDClF6umMOqlCKCzxG6q5lIhBLHpynRA6juh6gXSp5Y7SLPpzXZGNU6L7OGCEwl_F-niJn1jTflifWnqm9PX3Rcfqbtdo6rmPAT4=@wujek.eu> <6f697b2c-58aa-6ca4-966b-147bcc184dad@roeck-us.net> <Liq6d7nBil1lQx274diOvpjRJ9cEYH6co7ZMjrudPfYn0TTzOsfqsjuVBK-pMpFF5nBC0jhuoFEtbtmUY4Td4uY-a4qn6j-OmQD-Qu_xdck=@wujek.eu> <1b12cb3a-3d87-8254-b229-dcf83ad0bc0a@roeck-us.net>
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
Notes:
    Changes in v2:
    - Rebase to the latest kernel
    - Marked wrongly as a part of series of patches

    Changes in v3:
    - Submit as a single patch. V2 was wrongly submitted as a part of
      series of patches
    - Add justification for "rc +=3D 2;"
    - Increase allocated memory for debugfs entries

    Changes in v4:
    - Change "rc +=3D 2;" into "rc +=3D 1;". With "rc +=3D 2" an extra '\0'=
 is
      observed after '\n' at the end of debugfs file's output.

 drivers/hwmon/pmbus/pmbus_core.c | 89 +++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index d93574d6a1fb..a791e5f08fb2 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2627,6 +2627,33 @@ static int pmbus_debugfs_get_status(void *data, u64 =
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
+=09/* Add newline at the end of a read data */
+=09data[rc] =3D '\n';
+
+=09/* Include newline into the length */
+=09rc +=3D 1;
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
@@ -2693,7 +2720,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,

 =09/* Allocate the max possible entries we need. */
 =09entries =3D devm_kcalloc(data->dev,
-=09=09=09       data->info->pages * 10, sizeof(*entries),
+=09=09=09       data->info->pages * 16, sizeof(*entries),
 =09=09=09       GFP_KERNEL);
 =09if (!entries)
 =09=09return -ENOMEM;
@@ -2803,6 +2830,66 @@ static int pmbus_init_debugfs(struct i2c_client *cli=
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


