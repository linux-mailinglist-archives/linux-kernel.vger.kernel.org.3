Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCAF53280F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiEXKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiEXKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:44:13 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830184F9C6;
        Tue, 24 May 2022 03:44:11 -0700 (PDT)
Date:   Tue, 24 May 2022 10:44:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1653389049; x=1653648249;
        bh=TM6OZzaFDIBZ7AfxBRZG/Z6TtzL2ULL0ZxBRpcxXoPo=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Z5JqZzTR+F11OSHNI8B+1Mf+YJ3zA0EJcAsI0cauQXXSU53W2g+OgEPv1ulnFXFta
         qg0ZE8E410nWQiI3UP0ciW2Kb62J074FiJcuU71mP2lA6413vxT80QzsIZCfWsoCLF
         iGsxKN/XIFmxGvxuebfmzwXy2Oa4w/NqBSz0Iv+h6npPjHbMivYoCof0+jfL/w/KdT
         4fXHxWxrlDyay8l7hzT27PwyIf79bxiYRnBzVE+EmIWpAx095OEvjNcr5G6xp7MhGm
         89rI8skfd5E9BisZf1B2bdwwg8SmAFla9w12VvT1WD8DDm00OJLgpN6R6z1KSOwDuk
         MfyH7/Qxj8G4g==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH v2 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Message-ID: <20220524104307.272806-2-dev_public@wujek.eu>
In-Reply-To: <20220524104307.272806-1-dev_public@wujek.eu>
References: <20220524104307.272806-1-dev_public@wujek.eu>
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

Please note that it is assumed that values of these registers are the same
for all pages. To reduce the number of debugfs entries, only values from
page 0 are reported.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
Notes:
- This is a reworked patch to report the registers only once

 drivers/hwmon/pmbus/pmbus_core.c | 100 ++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 2ff66f133d95..72411d30dd78 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2657,6 +2657,34 @@ static int pmbus_debugfs_get_status(void *data, u64 =
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
+=09rc =3D pmbus_read_block_data(entry->client, entry->page, entry->reg,
+=09=09=09=09   data);
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
@@ -2721,9 +2749,13 @@ static int pmbus_init_debugfs(struct i2c_client *cli=
ent,
 =09=09return -ENODEV;
 =09}

-=09/* Allocate the max possible entries we need. */
+=09/*
+=09 * Allocate the max possible entries we need.
+=09 * 6 entries device-specific
+=09 * 10 entries page-specific
+=09 */
 =09entries =3D devm_kcalloc(data->dev,
-=09=09=09       data->info->pages * 10, sizeof(*entries),
+=09=09=09       6 + data->info->pages * 10, sizeof(*entries),
 =09=09=09       GFP_KERNEL);
 =09if (!entries)
 =09=09return -ENOMEM;
@@ -2731,6 +2763,70 @@ static int pmbus_init_debugfs(struct i2c_client *cli=
ent,
 =09debugfs_create_file("pec", 0664, data->debugfs, client,
 =09=09=09    &pmbus_debugfs_ops_pec);

+=09/*
+=09 * Add device-specific entries.
+=09 * Please note that the PMBUS standard allows all registers to be
+=09 * page-specific.
+=09 * To reduce the number of debugfs entries for
+=09 * devices with many pages assume that values of the following
+=09 * registers are the same for all pages and report values only
+=09 * for page 0.
+=09 */
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_ID)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_ID;
+=09=09debugfs_create_file("mfr_id", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_MODEL)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_MODEL;
+=09=09debugfs_create_file("mfr_model", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_REVISION)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_REVISION;
+=09=09debugfs_create_file("mfr_revision", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_LOCATION)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_LOCATION;
+=09=09debugfs_create_file("mfr_location", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_DATE)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_DATE;
+=09=09debugfs_create_file("mfr_date", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09if (pmbus_check_block_register(client, 0, PMBUS_MFR_SERIAL)) {
+=09=09entries[idx].client =3D client;
+=09=09entries[idx].page =3D 0;
+=09=09entries[idx].reg =3D PMBUS_MFR_SERIAL;
+=09=09debugfs_create_file("mfr_serial", 0444, data->debugfs,
+=09=09=09=09    &entries[idx++],
+=09=09=09=09    &pmbus_debugfs_ops_mfr);
+=09}
+
+=09/* Add page specific entries */
 =09for (i =3D 0; i < data->info->pages; ++i) {
 =09=09/* Check accessibility of status register if it's not page 0 */
 =09=09if (!i || pmbus_check_status_register(client, i)) {
--
2.17.1


