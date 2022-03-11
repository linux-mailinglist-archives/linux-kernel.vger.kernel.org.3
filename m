Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24454D5763
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiCKBeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbiCKBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:34:23 -0500
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1178615472B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:33:20 -0800 (PST)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4KF7jp2vjkz4xLGK
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:33:18 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VjPOX00Z"
Date:   Fri, 11 Mar 2022 01:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1646962393;
        bh=pC0Stx9zAakq2s3xSgEIytNW/jYoF22vG7SHJdIxGsY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=VjPOX00ZDYe8ltsBmTBIX1vKQ+TO/UcgxZABeC9Xe4H9eH6IN3Vr/EUxCzkW2I4qo
         KzFQLpvgncSB51fT4QmdowF4PrtyQWAp603jgDIsjZFB9xEfQ2iJ0O2ZhzVIz2gSC1
         5gdcIQINEL+vphU1EAyMu87EJsmweMRu2x1QAlzjIO/HNF1PHtk5e2wYgyPMe2qNru
         NungNWJdytg2ERYOEho0DwQFxyJiDqgo6Yblox/eo8953LZ/ls+2358htX9CqhEKiJ
         4tbWcENKTWqJ79zUrJFv+7o4zO52LQgk6F+GIecdTxgqyltO6+f0nVMGSIdKffuVWd
         cAojbBg5o2goA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [RFC PATCH v1 2/2] platform/x86: wmi: use tlist for WMI blocks
Message-ID: <20220311013238.3387227-3-pobrn@protonmail.com>
In-Reply-To: <20220311013238.3387227-1-pobrn@protonmail.com>
References: <20220311013238.3387227-1-pobrn@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tlist is a type-safer wrapper around the existing
`list_head` facilities. Use that to make the code
type-safer and shorter.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 drivers/platform/x86/wmi.c | 53 ++++++++++++++------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 58a23a9adbef..4da968bda3dc 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -22,7 +22,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
+#include <linux/tlist.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -39,8 +39,6 @@ MODULE_AUTHOR("Carlos Corbacho");
 MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
 MODULE_LICENSE("GPL");

-static LIST_HEAD(wmi_block_list);
-
 struct guid_block {
 =09guid_t guid;
 =09union {
@@ -75,6 +73,7 @@ struct wmi_block {
 =09unsigned long flags;
 };

+static TLIST_DEFINE(struct wmi_block, list, wmi_block_list);

 /*
  * If the GUID data block is marked as expensive, we must enable and
@@ -121,7 +120,6 @@ static struct platform_driver acpi_wmi_driver =3D {
 static acpi_status find_guid(const char *guid_string, struct wmi_block **o=
ut)
 {
 =09guid_t guid_input;
-=09struct wmi_block *wblock;

 =09if (!guid_string)
 =09=09return AE_BAD_PARAMETER;
@@ -129,7 +127,7 @@ static acpi_status find_guid(const char *guid_string, s=
truct wmi_block **out)
 =09if (guid_parse(guid_string, &guid_input))
 =09=09return AE_BAD_PARAMETER;

-=09list_for_each_entry(wblock, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, wblock) {
 =09=09if (guid_equal(&wblock->gblock.guid, &guid_input)) {
 =09=09=09if (out)
 =09=09=09=09*out =3D wblock;
@@ -565,7 +563,6 @@ acpi_status wmi_install_notify_handler(const char *guid=
,
 =09=09=09=09       wmi_notify_handler handler,
 =09=09=09=09       void *data)
 {
-=09struct wmi_block *block;
 =09acpi_status status =3D AE_NOT_EXIST;
 =09guid_t guid_input;

@@ -575,7 +572,7 @@ acpi_status wmi_install_notify_handler(const char *guid=
,
 =09if (guid_parse(guid, &guid_input))
 =09=09return AE_BAD_PARAMETER;

-=09list_for_each_entry(block, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, block) {
 =09=09acpi_status wmi_status;

 =09=09if (guid_equal(&block->gblock.guid, &guid_input)) {
@@ -605,7 +602,6 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
  */
 acpi_status wmi_remove_notify_handler(const char *guid)
 {
-=09struct wmi_block *block;
 =09acpi_status status =3D AE_NOT_EXIST;
 =09guid_t guid_input;

@@ -615,7 +611,7 @@ acpi_status wmi_remove_notify_handler(const char *guid)
 =09if (guid_parse(guid, &guid_input))
 =09=09return AE_BAD_PARAMETER;

-=09list_for_each_entry(block, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, block) {
 =09=09acpi_status wmi_status;

 =09=09if (guid_equal(&block->gblock.guid, &guid_input)) {
@@ -652,9 +648,7 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
  */
 acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
 {
-=09struct wmi_block *wblock;
-
-=09list_for_each_entry(wblock, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, wblock) {
 =09=09struct guid_block *gblock =3D &wblock->gblock;

 =09=09if ((gblock->flags & ACPI_WMI_EVENT) && gblock->notify_id =3D=3D eve=
nt)
@@ -854,10 +848,8 @@ static int wmi_dev_match(struct device *dev, struct de=
vice_driver *driver)
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
 =09const char *driver_name =3D filp->f_path.dentry->d_iname;
-=09struct wmi_block *wblock;
-=09struct wmi_block *next;

-=09list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, wblock) {
 =09=09if (!wblock->dev.dev.driver)
 =09=09=09continue;
 =09=09if (strcmp(driver_name, wblock->dev.dev.driver->name) =3D=3D 0) {
@@ -1143,12 +1135,10 @@ static int wmi_create_device(struct device *wmi_bus=
_dev,

 static void wmi_free_devices(struct acpi_device *device)
 {
-=09struct wmi_block *wblock, *next;
-
 =09/* Delete devices for all the GUIDs */
-=09list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
+=09tlist_for_each_safe(&wmi_block_list, wblock) {
 =09=09if (wblock->acpi_device =3D=3D device) {
-=09=09=09list_del(&wblock->list);
+=09=09=09tlist_remove(&wmi_block_list, wblock);
 =09=09=09device_unregister(&wblock->dev.dev);
 =09=09}
 =09}
@@ -1156,9 +1146,7 @@ static void wmi_free_devices(struct acpi_device *devi=
ce)

 static bool guid_already_parsed(struct acpi_device *device, const guid_t *=
guid)
 {
-=09struct wmi_block *wblock;
-
-=09list_for_each_entry(wblock, &wmi_block_list, list) {
+=09tlist_for_each(&wmi_block_list, wblock) {
 =09=09if (guid_equal(&wblock->gblock.guid, guid)) {
 =09=09=09/*
 =09=09=09 * Because we historically didn't track the relationship
@@ -1182,7 +1170,7 @@ static int parse_wdg(struct device *wmi_bus_dev, stru=
ct acpi_device *device)
 {
 =09struct acpi_buffer out =3D {ACPI_ALLOCATE_BUFFER, NULL};
 =09const struct guid_block *gblock;
-=09struct wmi_block *wblock, *next;
+=09struct wmi_block *wblock;
 =09union acpi_object *obj;
 =09acpi_status status;
 =09int retval =3D 0;
@@ -1232,7 +1220,7 @@ static int parse_wdg(struct device *wmi_bus_dev, stru=
ct acpi_device *device)
 =09=09=09continue;
 =09=09}

-=09=09list_add_tail(&wblock->list, &wmi_block_list);
+=09=09tlist_push_back(&wmi_block_list, wblock);

 =09=09if (debug_event) {
 =09=09=09wblock->handler =3D wmi_notify_debug;
@@ -1244,7 +1232,7 @@ static int parse_wdg(struct device *wmi_bus_dev, stru=
ct acpi_device *device)
 =09 * Now that all of the devices are created, add them to the
 =09 * device tree and probe subdrivers.
 =09 */
-=09list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
+=09tlist_for_each_safe(&wmi_block_list, wblock) {
 =09=09if (wblock->acpi_device !=3D device)
 =09=09=09continue;

@@ -1254,7 +1242,7 @@ static int parse_wdg(struct device *wmi_bus_dev, stru=
ct acpi_device *device)
 =09=09=09=09&wblock->gblock.guid);
 =09=09=09if (debug_event)
 =09=09=09=09wmi_method_enable(wblock, false);
-=09=09=09list_del(&wblock->list);
+=09=09=09tlist_remove(&wmi_block_list, wblock);
 =09=09=09put_device(&wblock->dev.dev);
 =09=09}
 =09}
@@ -1308,21 +1296,20 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
al_address address,
 static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 =09=09=09=09    void *context)
 {
-=09struct wmi_block *wblock;
-=09bool found_it =3D false;
+=09struct wmi_block *wblock =3D NULL;

-=09list_for_each_entry(wblock, &wmi_block_list, list) {
-=09=09struct guid_block *block =3D &wblock->gblock;
+=09tlist_for_each(&wmi_block_list, b) {
+=09=09struct guid_block *block =3D &b->gblock;

-=09=09if (wblock->acpi_device->handle =3D=3D handle &&
+=09=09if (b->acpi_device->handle =3D=3D handle &&
 =09=09    (block->flags & ACPI_WMI_EVENT) &&
 =09=09    (block->notify_id =3D=3D event)) {
-=09=09=09found_it =3D true;
+=09=09=09wblock =3D b;
 =09=09=09break;
 =09=09}
 =09}

-=09if (!found_it)
+=09if (!wblock)
 =09=09return;

 =09/* If a driver is bound, then notify the driver. */
--
2.35.1


