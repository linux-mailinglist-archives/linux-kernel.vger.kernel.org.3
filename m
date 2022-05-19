Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4884B52E0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiESXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiESXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:44:12 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A711993B;
        Thu, 19 May 2022 16:44:11 -0700 (PDT)
Date:   Thu, 19 May 2022 23:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1653003849; x=1653263049;
        bh=FuvKFEz/ehEY1iZ/jEF7OJP6nXdaq/8tqjztR76eiUU=;
        h=Date:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=OshkabWvC9oYJhicXhoKZtVCCbnPymDjosLhmyQfnsN18EubuuJpI9pSH96Jf6cPZ
         Tm+fYdz16CO4K+H/w8wFxeJ8CrtfIGgh63d8AyxIm0Ze9nQByyzAHGsgtw+HCPjPpy
         cQa2ifErinfxnC2SDrnzTTXXmF1pmJDPU55R8Gq+CsFMbXLo9K/d0OLu/sUcMFlyTK
         jFpJ8CM1yPiz7J73EvelKk86aQcraSabWtm43vCrc//dUTpzjH+W3HkqcFsXnHpB5J
         Q+f6ByM4lYc0DXcP0wSvGc+nFSeZhMYzrVuIajTvJYW7vkUaGH7qmxSPno+fmkcAdf
         3AWQSJ1LjbyEQ==
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH 2/3] hwmon: (pmbus) use block presence checking for registers PMBUS_MFR_*
Message-ID: <20220519234346.440398-2-dev_public@wujek.eu>
In-Reply-To: <20220519234346.440398-1-dev_public@wujek.eu>
References: <20220519234346.440398-1-dev_public@wujek.eu>
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

When PEC is enabled, using the function to check byte register presence
(pmbus_check_byte_register) for block register generates an error.
The second byte of a block is interpreted as PEC, which is usually wrong.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
Note:
- This commit requires commit which is accepted, but not yet in the kernel
  tree:
  hwmon: (pmbus) add MFR_* registers to debugfs

 drivers/hwmon/pmbus/pmbus_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 2634ac1fa3d5..597cbe85df07 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2858,7 +2858,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_ID)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_ID;
@@ -2868,7 +2868,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops_mfr);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_MODEL)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_MODEL)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_MODEL;
@@ -2878,7 +2878,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops_mfr);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_REVISION)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_REVISION)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_REVISION;
@@ -2888,7 +2888,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops_mfr);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_LOCATION)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_LOCATION)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_LOCATION;
@@ -2898,7 +2898,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops_mfr);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_DATE)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_DATE)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_DATE;
@@ -2908,7 +2908,7 @@ static int pmbus_init_debugfs(struct i2c_client *clie=
nt,
 =09=09=09=09=09    &pmbus_debugfs_ops_mfr);
 =09=09}

-=09=09if (pmbus_check_byte_register(client, i, PMBUS_MFR_SERIAL)) {
+=09=09if (pmbus_check_block_register(client, i, PMBUS_MFR_SERIAL)) {
 =09=09=09entries[idx].client =3D client;
 =09=09=09entries[idx].page =3D i;
 =09=09=09entries[idx].reg =3D PMBUS_MFR_SERIAL;
--
2.17.1


