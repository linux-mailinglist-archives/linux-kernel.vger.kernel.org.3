Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0C553643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbiFUPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiFUPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:37:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A032AC67;
        Tue, 21 Jun 2022 08:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20FF3B81A66;
        Tue, 21 Jun 2022 15:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A11C341C0;
        Tue, 21 Jun 2022 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825815;
        bh=R+7eOw1UxDGfNTC9eOlkXtD+UAdSyJVXtEUpakJxuTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cgw80VQDw7WhA0PPvv4uEPaD3S2bCx/c+A4ShMI5Cq9WcAe/YP6x9rgE3/c4PaAa5
         GoCjO8rLcIR5Q49d1o2GGoZcdfCd/tQwAUMRJ65vtRcbZ37NEVNa7Cc5TraQNKQZV3
         FTVfl05dOL+Sas24oZbDJEy0LHVwhqcuzNmaRv7V0X5/C6n++OqLy6bhIV+NVXarBa
         DtzEBD2z+AVhNR4KqwtiXVzdNmm55EZ6vPYRFmzZs4DQgj0/CljCTX02jLYMVgrmP9
         BoKfn+v8sjo3cyoc0CgQeNtZi1t+LbBcQTe4xJx1kf2zcbk3u3y9PHDrd5BpkCkz5j
         BaMIeA2dMYK5Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 9/9] efi: vars: Move efivar caching layer into efivarfs
Date:   Tue, 21 Jun 2022 17:36:23 +0200
Message-Id: <20220621153623.3786960-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=47768; h=from:subject; bh=R+7eOw1UxDGfNTC9eOlkXtD+UAdSyJVXtEUpakJxuTo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseV2N6/F6zsZDBcTKRIWITEZY79mspaiaM3BKuzy gn9nmWeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHldgAKCRDDTyI5ktmPJGHqC/ 44f7pXKwcUFBHfPIJ09Jxj5z7KkZtnrMqKKmg6OauH+Bk9XvNlmx5cgreun+4WudcrWXTDUaPv3H51 3xK7Ovee75WNgRljYShvWDQ+6mHEUKaxoBeXmktYLOwdOpuPiRh312ZaKhxLBJeJwRv6yZ6icMxhXb 1Mfqr1dyMhPq1VOEVuf6hjir6KtUwk3lFs01lCySLoFbQw7LK4Ves+eim2z6PvIwe84r2Sx9Ypu/xp X3NIjUxyed1EA1ENskA5CGGGbYS89TBTQe/AjeMZ69ZzrSnCmlRFyT+XYUOsw2o+94prNxVbo7aEoU wjJQK3GU+dZf44k0bR6FwpAHkh6wCnA8fTW6IjZaP7E7nP11AKE85c4sZYuDb0hrKx65uQ4GTH2dbq QLMOPxiI+7HyKIgp5ugQrlnngtPHt+sU+MTcyQd15a6vcPPdYzwkg0QJpnBsLCirlsEsUXNilfrRbJ /YCYNy7AaYRPcn8aczectlaguBRxTi6PeCtHvEcsczZkM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the fiddly bits of the efivar layer into its only remaining user,
efivarfs, and confine its use to that particular module. All other uses
of the EFI variable store have no need for this additional layer of
complexity, given that they either only read variables, or read and
write variables into a separate GUIDed namespace, and cannot be used to
manipulate EFI variables that are covered by the EFI spec and/or affect
the boot flow.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c  |   1 +
 drivers/firmware/efi/vars.c | 733 -------------------
 fs/efivarfs/Makefile        |   2 +-
 fs/efivarfs/internal.h      |  40 ++
 fs/efivarfs/vars.c          | 742 ++++++++++++++++++++
 include/linux/efi.h         |  38 -
 6 files changed, 784 insertions(+), 772 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7f06065d3eb0..e4080ad96089 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -899,6 +899,7 @@ int efi_status_to_err(efi_status_t status)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(efi_status_to_err);
 
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
 static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index cafc128a5774..dd74d2ad3184 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -6,298 +6,20 @@
  * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
  */
 
-#include <linux/capability.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/efi.h>
-#include <linux/sysfs.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
 #include <linux/ucs2_string.h>
 
 /* Private pointer to registered efivars */
 static struct efivars *__efivars;
 
-/*
- * efivars_lock protects three things:
- * 1) efivarfs_list and efivars_sysfs_list
- * 2) ->ops calls
- * 3) (un)registration of __efivars
- */
 static DEFINE_SEMAPHORE(efivars_lock);
 
-static bool
-validate_device_path(efi_char16_t *var_name, int match, u8 *buffer,
-		     unsigned long len)
-{
-	struct efi_generic_dev_path *node;
-	int offset = 0;
-
-	node = (struct efi_generic_dev_path *)buffer;
-
-	if (len < sizeof(*node))
-		return false;
-
-	while (offset <= len - sizeof(*node) &&
-	       node->length >= sizeof(*node) &&
-		node->length <= len - offset) {
-		offset += node->length;
-
-		if ((node->type == EFI_DEV_END_PATH ||
-		     node->type == EFI_DEV_END_PATH2) &&
-		    node->sub_type == EFI_DEV_END_ENTIRE)
-			return true;
-
-		node = (struct efi_generic_dev_path *)(buffer + offset);
-	}
-
-	/*
-	 * If we're here then either node->length pointed past the end
-	 * of the buffer or we reached the end of the buffer without
-	 * finding a device path end node.
-	 */
-	return false;
-}
-
-static bool
-validate_boot_order(efi_char16_t *var_name, int match, u8 *buffer,
-		    unsigned long len)
-{
-	/* An array of 16-bit integers */
-	if ((len % 2) != 0)
-		return false;
-
-	return true;
-}
-
-static bool
-validate_load_option(efi_char16_t *var_name, int match, u8 *buffer,
-		     unsigned long len)
-{
-	u16 filepathlength;
-	int i, desclength = 0, namelen;
-
-	namelen = ucs2_strnlen(var_name, EFI_VAR_NAME_LEN);
-
-	/* Either "Boot" or "Driver" followed by four digits of hex */
-	for (i = match; i < match+4; i++) {
-		if (var_name[i] > 127 ||
-		    hex_to_bin(var_name[i] & 0xff) < 0)
-			return true;
-	}
-
-	/* Reject it if there's 4 digits of hex and then further content */
-	if (namelen > match + 4)
-		return false;
-
-	/* A valid entry must be at least 8 bytes */
-	if (len < 8)
-		return false;
-
-	filepathlength = buffer[4] | buffer[5] << 8;
-
-	/*
-	 * There's no stored length for the description, so it has to be
-	 * found by hand
-	 */
-	desclength = ucs2_strsize((efi_char16_t *)(buffer + 6), len - 6) + 2;
-
-	/* Each boot entry must have a descriptor */
-	if (!desclength)
-		return false;
-
-	/*
-	 * If the sum of the length of the description, the claimed filepath
-	 * length and the original header are greater than the length of the
-	 * variable, it's malformed
-	 */
-	if ((desclength + filepathlength + 6) > len)
-		return false;
-
-	/*
-	 * And, finally, check the filepath
-	 */
-	return validate_device_path(var_name, match, buffer + desclength + 6,
-				    filepathlength);
-}
-
-static bool
-validate_uint16(efi_char16_t *var_name, int match, u8 *buffer,
-		unsigned long len)
-{
-	/* A single 16-bit integer */
-	if (len != 2)
-		return false;
-
-	return true;
-}
-
-static bool
-validate_ascii_string(efi_char16_t *var_name, int match, u8 *buffer,
-		      unsigned long len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (buffer[i] > 127)
-			return false;
-
-		if (buffer[i] == 0)
-			return true;
-	}
-
-	return false;
-}
-
-struct variable_validate {
-	efi_guid_t vendor;
-	char *name;
-	bool (*validate)(efi_char16_t *var_name, int match, u8 *data,
-			 unsigned long len);
-};
-
-/*
- * This is the list of variables we need to validate, as well as the
- * whitelist for what we think is safe not to default to immutable.
- *
- * If it has a validate() method that's not NULL, it'll go into the
- * validation routine.  If not, it is assumed valid, but still used for
- * whitelisting.
- *
- * Note that it's sorted by {vendor,name}, but globbed names must come after
- * any other name with the same prefix.
- */
-static const struct variable_validate variable_validate[] = {
-	{ EFI_GLOBAL_VARIABLE_GUID, "BootNext", validate_uint16 },
-	{ EFI_GLOBAL_VARIABLE_GUID, "BootOrder", validate_boot_order },
-	{ EFI_GLOBAL_VARIABLE_GUID, "Boot*", validate_load_option },
-	{ EFI_GLOBAL_VARIABLE_GUID, "DriverOrder", validate_boot_order },
-	{ EFI_GLOBAL_VARIABLE_GUID, "Driver*", validate_load_option },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConIn", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConInDev", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConOut", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ConOutDev", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOut", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOutDev", validate_device_path },
-	{ EFI_GLOBAL_VARIABLE_GUID, "Lang", validate_ascii_string },
-	{ EFI_GLOBAL_VARIABLE_GUID, "OsIndications", NULL },
-	{ EFI_GLOBAL_VARIABLE_GUID, "PlatformLang", validate_ascii_string },
-	{ EFI_GLOBAL_VARIABLE_GUID, "Timeout", validate_uint16 },
-	{ LINUX_EFI_CRASH_GUID, "*", NULL },
-	{ NULL_GUID, "", NULL },
-};
-
-/*
- * Check if @var_name matches the pattern given in @match_name.
- *
- * @var_name: an array of @len non-NUL characters.
- * @match_name: a NUL-terminated pattern string, optionally ending in "*". A
- *              final "*" character matches any trailing characters @var_name,
- *              including the case when there are none left in @var_name.
- * @match: on output, the number of non-wildcard characters in @match_name
- *         that @var_name matches, regardless of the return value.
- * @return: whether @var_name fully matches @match_name.
- */
-static bool
-variable_matches(const char *var_name, size_t len, const char *match_name,
-		 int *match)
-{
-	for (*match = 0; ; (*match)++) {
-		char c = match_name[*match];
-
-		switch (c) {
-		case '*':
-			/* Wildcard in @match_name means we've matched. */
-			return true;
-
-		case '\0':
-			/* @match_name has ended. Has @var_name too? */
-			return (*match == len);
-
-		default:
-			/*
-			 * We've reached a non-wildcard char in @match_name.
-			 * Continue only if there's an identical character in
-			 * @var_name.
-			 */
-			if (*match < len && c == var_name[*match])
-				continue;
-			return false;
-		}
-	}
-}
-
-bool
-efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
-		unsigned long data_size)
-{
-	int i;
-	unsigned long utf8_size;
-	u8 *utf8_name;
-
-	utf8_size = ucs2_utf8size(var_name);
-	utf8_name = kmalloc(utf8_size + 1, GFP_KERNEL);
-	if (!utf8_name)
-		return false;
-
-	ucs2_as_utf8(utf8_name, var_name, utf8_size);
-	utf8_name[utf8_size] = '\0';
-
-	for (i = 0; variable_validate[i].name[0] != '\0'; i++) {
-		const char *name = variable_validate[i].name;
-		int match = 0;
-
-		if (efi_guidcmp(vendor, variable_validate[i].vendor))
-			continue;
-
-		if (variable_matches(utf8_name, utf8_size+1, name, &match)) {
-			if (variable_validate[i].validate == NULL)
-				break;
-			kfree(utf8_name);
-			return variable_validate[i].validate(var_name, match,
-							     data, data_size);
-		}
-	}
-	kfree(utf8_name);
-	return true;
-}
-EXPORT_SYMBOL_GPL(efivar_validate);
-
-bool
-efivar_variable_is_removable(efi_guid_t vendor, const char *var_name,
-			     size_t len)
-{
-	int i;
-	bool found = false;
-	int match = 0;
-
-	/*
-	 * Check if our variable is in the validated variables list
-	 */
-	for (i = 0; variable_validate[i].name[0] != '\0'; i++) {
-		if (efi_guidcmp(variable_validate[i].vendor, vendor))
-			continue;
-
-		if (variable_matches(var_name, len,
-				     variable_validate[i].name, &match)) {
-			found = true;
-			break;
-		}
-	}
-
-	/*
-	 * If it's in our list, it is removable.
-	 */
-	return found;
-}
-EXPORT_SYMBOL_GPL(efivar_variable_is_removable);
-
 efi_status_t check_var_size(u32 attributes, unsigned long size)
 {
 	const struct efivar_operations *fops;
@@ -324,461 +46,6 @@ efi_status_t check_var_size_nonblocking(u32 attributes, unsigned long size)
 }
 EXPORT_SYMBOL_NS_GPL(check_var_size_nonblocking, EFIVAR);
 
-static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
-				struct list_head *head)
-{
-	struct efivar_entry *entry, *n;
-	unsigned long strsize1, strsize2;
-	bool found = false;
-
-	strsize1 = ucs2_strsize(variable_name, 1024);
-	list_for_each_entry_safe(entry, n, head, list) {
-		strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
-		if (strsize1 == strsize2 &&
-			!memcmp(variable_name, &(entry->var.VariableName),
-				strsize2) &&
-			!efi_guidcmp(entry->var.VendorGuid,
-				*vendor)) {
-			found = true;
-			break;
-		}
-	}
-	return found;
-}
-
-/*
- * Returns the size of variable_name, in bytes, including the
- * terminating NULL character, or variable_name_size if no NULL
- * character is found among the first variable_name_size bytes.
- */
-static unsigned long var_name_strnsize(efi_char16_t *variable_name,
-				       unsigned long variable_name_size)
-{
-	unsigned long len;
-	efi_char16_t c;
-
-	/*
-	 * The variable name is, by definition, a NULL-terminated
-	 * string, so make absolutely sure that variable_name_size is
-	 * the value we expect it to be. If not, return the real size.
-	 */
-	for (len = 2; len <= variable_name_size; len += sizeof(c)) {
-		c = variable_name[(len / sizeof(c)) - 1];
-		if (!c)
-			break;
-	}
-
-	return min(len, variable_name_size);
-}
-
-/*
- * Print a warning when duplicate EFI variables are encountered and
- * disable the sysfs workqueue since the firmware is buggy.
- */
-static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
-			     unsigned long len16)
-{
-	size_t i, len8 = len16 / sizeof(efi_char16_t);
-	char *str8;
-
-	str8 = kzalloc(len8, GFP_KERNEL);
-	if (!str8)
-		return;
-
-	for (i = 0; i < len8; i++)
-		str8[i] = str16[i];
-
-	printk(KERN_WARNING "efivars: duplicate variable: %s-%pUl\n",
-	       str8, vendor_guid);
-	kfree(str8);
-}
-
-/**
- * efivar_init - build the initial list of EFI variables
- * @func: callback function to invoke for every variable
- * @data: function-specific data to pass to @func
- * @duplicates: error if we encounter duplicates on @head?
- * @head: initialised head of variable list
- *
- * Get every EFI variable from the firmware and invoke @func. @func
- * should call efivar_entry_add() to build the list of variables.
- *
- * Returns 0 on success, or a kernel error code on failure.
- */
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
-		void *data, bool duplicates, struct list_head *head)
-{
-	unsigned long variable_name_size = 1024;
-	efi_char16_t *variable_name;
-	efi_status_t status;
-	efi_guid_t vendor_guid;
-	int err = 0;
-
-	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
-	if (!variable_name) {
-		printk(KERN_ERR "efivars: Memory allocation failed.\n");
-		return -ENOMEM;
-	}
-
-	err = efivar_lock();
-	if (err)
-		goto free;
-
-	/*
-	 * Per EFI spec, the maximum storage allocated for both
-	 * the variable name and variable data is 1024 bytes.
-	 */
-
-	do {
-		variable_name_size = 1024;
-
-		status = efivar_get_next_variable(&variable_name_size,
-						  variable_name,
-						  &vendor_guid);
-		switch (status) {
-		case EFI_SUCCESS:
-			variable_name_size = var_name_strnsize(variable_name,
-							       variable_name_size);
-
-			/*
-			 * Some firmware implementations return the
-			 * same variable name on multiple calls to
-			 * get_next_variable(). Terminate the loop
-			 * immediately as there is no guarantee that
-			 * we'll ever see a different variable name,
-			 * and may end up looping here forever.
-			 */
-			if (duplicates &&
-			    variable_is_present(variable_name, &vendor_guid,
-						head)) {
-				dup_variable_bug(variable_name, &vendor_guid,
-						 variable_name_size);
-				status = EFI_NOT_FOUND;
-			} else {
-				err = func(variable_name, vendor_guid,
-					   variable_name_size, data);
-				if (err)
-					status = EFI_NOT_FOUND;
-			}
-			break;
-		case EFI_UNSUPPORTED:
-			err = -EOPNOTSUPP;
-			status = EFI_NOT_FOUND;
-			break;
-		case EFI_NOT_FOUND:
-			break;
-		default:
-			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
-				status);
-			status = EFI_NOT_FOUND;
-			break;
-		}
-
-	} while (status != EFI_NOT_FOUND);
-
-	efivar_unlock();
-free:
-	kfree(variable_name);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(efivar_init);
-
-/**
- * efivar_entry_add - add entry to variable list
- * @entry: entry to add to list
- * @head: list head
- *
- * Returns 0 on success, or a kernel error code on failure.
- */
-int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
-{
-	int err;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-	list_add(&entry->list, head);
-	efivar_unlock();
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_add);
-
-/**
- * __efivar_entry_add - add entry to variable list
- * @entry: entry to add to list
- * @head: list head
- */
-void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
-{
-	list_add(&entry->list, head);
-}
-EXPORT_SYMBOL_GPL(__efivar_entry_add);
-
-/**
- * efivar_entry_remove - remove entry from variable list
- * @entry: entry to remove from list
- */
-void efivar_entry_remove(struct efivar_entry *entry)
-{
-	list_del(&entry->list);
-}
-EXPORT_SYMBOL_GPL(efivar_entry_remove);
-
-/*
- * efivar_entry_list_del_unlock - remove entry from variable list
- * @entry: entry to remove
- *
- * Remove @entry from the variable list and release the list lock.
- *
- * NOTE: slightly weird locking semantics here - we expect to be
- * called with the efivars lock already held, and we release it before
- * returning. This is because this function is usually called after
- * set_variable() while the lock is still held.
- */
-static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
-{
-	list_del(&entry->list);
-	efivar_unlock();
-}
-
-/**
- * efivar_entry_delete - delete variable and remove entry from list
- * @entry: entry containing variable to delete
- *
- * Delete the variable from the firmware and remove @entry from the
- * variable list. It is the caller's responsibility to free @entry
- * once we return.
- *
- * Returns 0 on success, -EINTR if we can't grab the semaphore,
- * converted EFI status code if set_variable() fails.
- */
-int efivar_entry_delete(struct efivar_entry *entry)
-{
-	efi_status_t status;
-	int err;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-
-	status = efivar_set_variable_locked(entry->var.VariableName,
-					    &entry->var.VendorGuid,
-					    0, 0, NULL, false);
-	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND)) {
-		efivar_unlock();
-		return efi_status_to_err(status);
-	}
-
-	efivar_entry_list_del_unlock(entry);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_delete);
-
-/**
- * efivar_entry_size - obtain the size of a variable
- * @entry: entry for this variable
- * @size: location to store the variable's size
- */
-int efivar_entry_size(struct efivar_entry *entry, unsigned long *size)
-{
-	efi_status_t status;
-	int err;
-
-	*size = 0;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-
-	status = efivar_get_variable(entry->var.VariableName,
-				     &entry->var.VendorGuid, NULL, size, NULL);
-	efivar_unlock();
-
-	if (status != EFI_BUFFER_TOO_SMALL)
-		return efi_status_to_err(status);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_size);
-
-/**
- * __efivar_entry_get - call get_variable()
- * @entry: read data for this variable
- * @attributes: variable attributes
- * @size: size of @data buffer
- * @data: buffer to store variable data
- *
- * The caller MUST hold the efivar lock when calling this function.
- */
-int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
-		       unsigned long *size, void *data)
-{
-	efi_status_t status;
-
-	status = efivar_get_variable(entry->var.VariableName,
-				     &entry->var.VendorGuid,
-				     attributes, size, data);
-
-	return efi_status_to_err(status);
-}
-EXPORT_SYMBOL_GPL(__efivar_entry_get);
-
-/**
- * efivar_entry_get - call get_variable()
- * @entry: read data for this variable
- * @attributes: variable attributes
- * @size: size of @data buffer
- * @data: buffer to store variable data
- */
-int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
-		     unsigned long *size, void *data)
-{
-	int err;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-	err = __efivar_entry_get(entry, attributes, size, data);
-	efivar_unlock();
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_get);
-
-/**
- * efivar_entry_set_get_size - call set_variable() and get new size (atomic)
- * @entry: entry containing variable to set and get
- * @attributes: attributes of variable to be written
- * @size: size of data buffer
- * @data: buffer containing data to write
- * @set: did the set_variable() call succeed?
- *
- * This is a pretty special (complex) function. See efivarfs_file_write().
- *
- * Atomically call set_variable() for @entry and if the call is
- * successful, return the new size of the variable from get_variable()
- * in @size. The success of set_variable() is indicated by @set.
- *
- * Returns 0 on success, -EINVAL if the variable data is invalid,
- * -ENOSPC if the firmware does not have enough available space, or a
- * converted EFI status code if either of set_variable() or
- * get_variable() fail.
- *
- * If the EFI variable does not exist when calling set_variable()
- * (EFI_NOT_FOUND), @entry is removed from the variable list.
- */
-int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
-			      unsigned long *size, void *data, bool *set)
-{
-	efi_char16_t *name = entry->var.VariableName;
-	efi_guid_t *vendor = &entry->var.VendorGuid;
-	efi_status_t status;
-	int err;
-
-	*set = false;
-
-	if (efivar_validate(*vendor, name, data, *size) == false)
-		return -EINVAL;
-
-	/*
-	 * The lock here protects the get_variable call, the conditional
-	 * set_variable call, and removal of the variable from the efivars
-	 * list (in the case of an authenticated delete).
-	 */
-	err = efivar_lock();
-	if (err)
-		return err;
-
-	/*
-	 * Ensure that the available space hasn't shrunk below the safe level
-	 */
-	status = check_var_size(attributes, *size + ucs2_strsize(name, 1024));
-	if (status != EFI_SUCCESS) {
-		if (status != EFI_UNSUPPORTED) {
-			err = efi_status_to_err(status);
-			goto out;
-		}
-
-		if (*size > 65536) {
-			err = -ENOSPC;
-			goto out;
-		}
-	}
-
-	status = efivar_set_variable_locked(name, vendor, attributes, *size,
-					    data, false);
-	if (status != EFI_SUCCESS) {
-		err = efi_status_to_err(status);
-		goto out;
-	}
-
-	*set = true;
-
-	/*
-	 * Writing to the variable may have caused a change in size (which
-	 * could either be an append or an overwrite), or the variable to be
-	 * deleted. Perform a GetVariable() so we can tell what actually
-	 * happened.
-	 */
-	*size = 0;
-	status = efivar_get_variable(entry->var.VariableName,
-				    &entry->var.VendorGuid,
-				    NULL, size, NULL);
-
-	if (status == EFI_NOT_FOUND)
-		efivar_entry_list_del_unlock(entry);
-	else
-		efivar_unlock();
-
-	if (status && status != EFI_BUFFER_TOO_SMALL)
-		return efi_status_to_err(status);
-
-	return 0;
-
-out:
-	efivar_unlock();
-	return err;
-
-}
-EXPORT_SYMBOL_GPL(efivar_entry_set_get_size);
-
-/**
- * efivar_entry_iter - iterate over variable list
- * @func: callback function
- * @head: head of variable list
- * @data: function-specific data to pass to callback
- *
- * Iterate over the list of EFI variables and call @func with every
- * entry on the list. It is safe for @func to remove entries in the
- * list via efivar_entry_delete() while iterating.
- *
- * Some notes for the callback function:
- *  - a non-zero return value indicates an error and terminates the loop
- *  - @func is called from atomic context
- */
-int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-		      struct list_head *head, void *data)
-{
-	struct efivar_entry *entry, *n;
-	int err = 0;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-
-	list_for_each_entry_safe(entry, n, head, list) {
-		err = func(entry, data);
-		if (err)
-			break;
-	}
-	efivar_unlock();
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(efivar_entry_iter);
-
 /**
  * efivars_kobject - get the kobject for the registered efivars
  *
diff --git a/fs/efivarfs/Makefile b/fs/efivarfs/Makefile
index 0b1c5e63eb71..7bfc2f9754a8 100644
--- a/fs/efivarfs/Makefile
+++ b/fs/efivarfs/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs.o
 
-efivarfs-objs			:= inode.o file.o super.o
+efivarfs-objs			:= inode.o file.o super.o vars.o
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 30ae44cb7453..8ebf3a6a8aa2 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -7,6 +7,46 @@
 #define EFIVAR_FS_INTERNAL_H
 
 #include <linux/list.h>
+#include <linux/efi.h>
+
+struct efi_variable {
+	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
+	efi_guid_t    VendorGuid;
+	unsigned long DataSize;
+	__u8          Data[1024];
+	efi_status_t  Status;
+	__u32         Attributes;
+} __attribute__((packed));
+
+struct efivar_entry {
+	struct efi_variable var;
+	struct list_head list;
+	struct kobject kobj;
+};
+
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+		void *data, bool duplicates, struct list_head *head);
+
+int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
+void efivar_entry_remove(struct efivar_entry *entry);
+int efivar_entry_delete(struct efivar_entry *entry);
+
+int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
+int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
+		       unsigned long *size, void *data);
+int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
+		     unsigned long *size, void *data);
+int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
+			      unsigned long *size, void *data, bool *set);
+
+int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
+		      struct list_head *head, void *data);
+
+bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
+		     unsigned long data_size);
+bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
+				  size_t len);
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
new file mode 100644
index 000000000000..b22141dcc4d3
--- /dev/null
+++ b/fs/efivarfs/vars.c
@@ -0,0 +1,742 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Originally from efivars.c
+ *
+ * Copyright (C) 2001,2003,2004 Dell <Matt_Domsch@dell.com>
+ * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
+ */
+
+#include <linux/capability.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/efi.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/ucs2_string.h>
+
+#include "internal.h"
+
+MODULE_IMPORT_NS(EFIVAR);
+
+static bool
+validate_device_path(efi_char16_t *var_name, int match, u8 *buffer,
+		     unsigned long len)
+{
+	struct efi_generic_dev_path *node;
+	int offset = 0;
+
+	node = (struct efi_generic_dev_path *)buffer;
+
+	if (len < sizeof(*node))
+		return false;
+
+	while (offset <= len - sizeof(*node) &&
+	       node->length >= sizeof(*node) &&
+		node->length <= len - offset) {
+		offset += node->length;
+
+		if ((node->type == EFI_DEV_END_PATH ||
+		     node->type == EFI_DEV_END_PATH2) &&
+		    node->sub_type == EFI_DEV_END_ENTIRE)
+			return true;
+
+		node = (struct efi_generic_dev_path *)(buffer + offset);
+	}
+
+	/*
+	 * If we're here then either node->length pointed past the end
+	 * of the buffer or we reached the end of the buffer without
+	 * finding a device path end node.
+	 */
+	return false;
+}
+
+static bool
+validate_boot_order(efi_char16_t *var_name, int match, u8 *buffer,
+		    unsigned long len)
+{
+	/* An array of 16-bit integers */
+	if ((len % 2) != 0)
+		return false;
+
+	return true;
+}
+
+static bool
+validate_load_option(efi_char16_t *var_name, int match, u8 *buffer,
+		     unsigned long len)
+{
+	u16 filepathlength;
+	int i, desclength = 0, namelen;
+
+	namelen = ucs2_strnlen(var_name, EFI_VAR_NAME_LEN);
+
+	/* Either "Boot" or "Driver" followed by four digits of hex */
+	for (i = match; i < match+4; i++) {
+		if (var_name[i] > 127 ||
+		    hex_to_bin(var_name[i] & 0xff) < 0)
+			return true;
+	}
+
+	/* Reject it if there's 4 digits of hex and then further content */
+	if (namelen > match + 4)
+		return false;
+
+	/* A valid entry must be at least 8 bytes */
+	if (len < 8)
+		return false;
+
+	filepathlength = buffer[4] | buffer[5] << 8;
+
+	/*
+	 * There's no stored length for the description, so it has to be
+	 * found by hand
+	 */
+	desclength = ucs2_strsize((efi_char16_t *)(buffer + 6), len - 6) + 2;
+
+	/* Each boot entry must have a descriptor */
+	if (!desclength)
+		return false;
+
+	/*
+	 * If the sum of the length of the description, the claimed filepath
+	 * length and the original header are greater than the length of the
+	 * variable, it's malformed
+	 */
+	if ((desclength + filepathlength + 6) > len)
+		return false;
+
+	/*
+	 * And, finally, check the filepath
+	 */
+	return validate_device_path(var_name, match, buffer + desclength + 6,
+				    filepathlength);
+}
+
+static bool
+validate_uint16(efi_char16_t *var_name, int match, u8 *buffer,
+		unsigned long len)
+{
+	/* A single 16-bit integer */
+	if (len != 2)
+		return false;
+
+	return true;
+}
+
+static bool
+validate_ascii_string(efi_char16_t *var_name, int match, u8 *buffer,
+		      unsigned long len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (buffer[i] > 127)
+			return false;
+
+		if (buffer[i] == 0)
+			return true;
+	}
+
+	return false;
+}
+
+struct variable_validate {
+	efi_guid_t vendor;
+	char *name;
+	bool (*validate)(efi_char16_t *var_name, int match, u8 *data,
+			 unsigned long len);
+};
+
+/*
+ * This is the list of variables we need to validate, as well as the
+ * whitelist for what we think is safe not to default to immutable.
+ *
+ * If it has a validate() method that's not NULL, it'll go into the
+ * validation routine.  If not, it is assumed valid, but still used for
+ * whitelisting.
+ *
+ * Note that it's sorted by {vendor,name}, but globbed names must come after
+ * any other name with the same prefix.
+ */
+static const struct variable_validate variable_validate[] = {
+	{ EFI_GLOBAL_VARIABLE_GUID, "BootNext", validate_uint16 },
+	{ EFI_GLOBAL_VARIABLE_GUID, "BootOrder", validate_boot_order },
+	{ EFI_GLOBAL_VARIABLE_GUID, "Boot*", validate_load_option },
+	{ EFI_GLOBAL_VARIABLE_GUID, "DriverOrder", validate_boot_order },
+	{ EFI_GLOBAL_VARIABLE_GUID, "Driver*", validate_load_option },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ConIn", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ConInDev", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ConOut", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ConOutDev", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOut", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "ErrOutDev", validate_device_path },
+	{ EFI_GLOBAL_VARIABLE_GUID, "Lang", validate_ascii_string },
+	{ EFI_GLOBAL_VARIABLE_GUID, "OsIndications", NULL },
+	{ EFI_GLOBAL_VARIABLE_GUID, "PlatformLang", validate_ascii_string },
+	{ EFI_GLOBAL_VARIABLE_GUID, "Timeout", validate_uint16 },
+	{ LINUX_EFI_CRASH_GUID, "*", NULL },
+	{ NULL_GUID, "", NULL },
+};
+
+/*
+ * Check if @var_name matches the pattern given in @match_name.
+ *
+ * @var_name: an array of @len non-NUL characters.
+ * @match_name: a NUL-terminated pattern string, optionally ending in "*". A
+ *              final "*" character matches any trailing characters @var_name,
+ *              including the case when there are none left in @var_name.
+ * @match: on output, the number of non-wildcard characters in @match_name
+ *         that @var_name matches, regardless of the return value.
+ * @return: whether @var_name fully matches @match_name.
+ */
+static bool
+variable_matches(const char *var_name, size_t len, const char *match_name,
+		 int *match)
+{
+	for (*match = 0; ; (*match)++) {
+		char c = match_name[*match];
+
+		switch (c) {
+		case '*':
+			/* Wildcard in @match_name means we've matched. */
+			return true;
+
+		case '\0':
+			/* @match_name has ended. Has @var_name too? */
+			return (*match == len);
+
+		default:
+			/*
+			 * We've reached a non-wildcard char in @match_name.
+			 * Continue only if there's an identical character in
+			 * @var_name.
+			 */
+			if (*match < len && c == var_name[*match])
+				continue;
+			return false;
+		}
+	}
+}
+
+bool
+efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
+		unsigned long data_size)
+{
+	int i;
+	unsigned long utf8_size;
+	u8 *utf8_name;
+
+	utf8_size = ucs2_utf8size(var_name);
+	utf8_name = kmalloc(utf8_size + 1, GFP_KERNEL);
+	if (!utf8_name)
+		return false;
+
+	ucs2_as_utf8(utf8_name, var_name, utf8_size);
+	utf8_name[utf8_size] = '\0';
+
+	for (i = 0; variable_validate[i].name[0] != '\0'; i++) {
+		const char *name = variable_validate[i].name;
+		int match = 0;
+
+		if (efi_guidcmp(vendor, variable_validate[i].vendor))
+			continue;
+
+		if (variable_matches(utf8_name, utf8_size+1, name, &match)) {
+			if (variable_validate[i].validate == NULL)
+				break;
+			kfree(utf8_name);
+			return variable_validate[i].validate(var_name, match,
+							     data, data_size);
+		}
+	}
+	kfree(utf8_name);
+	return true;
+}
+
+bool
+efivar_variable_is_removable(efi_guid_t vendor, const char *var_name,
+			     size_t len)
+{
+	int i;
+	bool found = false;
+	int match = 0;
+
+	/*
+	 * Check if our variable is in the validated variables list
+	 */
+	for (i = 0; variable_validate[i].name[0] != '\0'; i++) {
+		if (efi_guidcmp(variable_validate[i].vendor, vendor))
+			continue;
+
+		if (variable_matches(var_name, len,
+				     variable_validate[i].name, &match)) {
+			found = true;
+			break;
+		}
+	}
+
+	/*
+	 * If it's in our list, it is removable.
+	 */
+	return found;
+}
+
+static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
+				struct list_head *head)
+{
+	struct efivar_entry *entry, *n;
+	unsigned long strsize1, strsize2;
+	bool found = false;
+
+	strsize1 = ucs2_strsize(variable_name, 1024);
+	list_for_each_entry_safe(entry, n, head, list) {
+		strsize2 = ucs2_strsize(entry->var.VariableName, 1024);
+		if (strsize1 == strsize2 &&
+			!memcmp(variable_name, &(entry->var.VariableName),
+				strsize2) &&
+			!efi_guidcmp(entry->var.VendorGuid,
+				*vendor)) {
+			found = true;
+			break;
+		}
+	}
+	return found;
+}
+
+/*
+ * Returns the size of variable_name, in bytes, including the
+ * terminating NULL character, or variable_name_size if no NULL
+ * character is found among the first variable_name_size bytes.
+ */
+static unsigned long var_name_strnsize(efi_char16_t *variable_name,
+				       unsigned long variable_name_size)
+{
+	unsigned long len;
+	efi_char16_t c;
+
+	/*
+	 * The variable name is, by definition, a NULL-terminated
+	 * string, so make absolutely sure that variable_name_size is
+	 * the value we expect it to be. If not, return the real size.
+	 */
+	for (len = 2; len <= variable_name_size; len += sizeof(c)) {
+		c = variable_name[(len / sizeof(c)) - 1];
+		if (!c)
+			break;
+	}
+
+	return min(len, variable_name_size);
+}
+
+/*
+ * Print a warning when duplicate EFI variables are encountered and
+ * disable the sysfs workqueue since the firmware is buggy.
+ */
+static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
+			     unsigned long len16)
+{
+	size_t i, len8 = len16 / sizeof(efi_char16_t);
+	char *str8;
+
+	str8 = kzalloc(len8, GFP_KERNEL);
+	if (!str8)
+		return;
+
+	for (i = 0; i < len8; i++)
+		str8[i] = str16[i];
+
+	printk(KERN_WARNING "efivars: duplicate variable: %s-%pUl\n",
+	       str8, vendor_guid);
+	kfree(str8);
+}
+
+/**
+ * efivar_init - build the initial list of EFI variables
+ * @func: callback function to invoke for every variable
+ * @data: function-specific data to pass to @func
+ * @duplicates: error if we encounter duplicates on @head?
+ * @head: initialised head of variable list
+ *
+ * Get every EFI variable from the firmware and invoke @func. @func
+ * should call efivar_entry_add() to build the list of variables.
+ *
+ * Returns 0 on success, or a kernel error code on failure.
+ */
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+		void *data, bool duplicates, struct list_head *head)
+{
+	unsigned long variable_name_size = 1024;
+	efi_char16_t *variable_name;
+	efi_status_t status;
+	efi_guid_t vendor_guid;
+	int err = 0;
+
+	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
+	if (!variable_name) {
+		printk(KERN_ERR "efivars: Memory allocation failed.\n");
+		return -ENOMEM;
+	}
+
+	err = efivar_lock();
+	if (err)
+		goto free;
+
+	/*
+	 * Per EFI spec, the maximum storage allocated for both
+	 * the variable name and variable data is 1024 bytes.
+	 */
+
+	do {
+		variable_name_size = 1024;
+
+		status = efivar_get_next_variable(&variable_name_size,
+						  variable_name,
+						  &vendor_guid);
+		switch (status) {
+		case EFI_SUCCESS:
+			variable_name_size = var_name_strnsize(variable_name,
+							       variable_name_size);
+
+			/*
+			 * Some firmware implementations return the
+			 * same variable name on multiple calls to
+			 * get_next_variable(). Terminate the loop
+			 * immediately as there is no guarantee that
+			 * we'll ever see a different variable name,
+			 * and may end up looping here forever.
+			 */
+			if (duplicates &&
+			    variable_is_present(variable_name, &vendor_guid,
+						head)) {
+				dup_variable_bug(variable_name, &vendor_guid,
+						 variable_name_size);
+				status = EFI_NOT_FOUND;
+			} else {
+				err = func(variable_name, vendor_guid,
+					   variable_name_size, data);
+				if (err)
+					status = EFI_NOT_FOUND;
+			}
+			break;
+		case EFI_UNSUPPORTED:
+			err = -EOPNOTSUPP;
+			status = EFI_NOT_FOUND;
+			break;
+		case EFI_NOT_FOUND:
+			break;
+		default:
+			printk(KERN_WARNING "efivars: get_next_variable: status=%lx\n",
+				status);
+			status = EFI_NOT_FOUND;
+			break;
+		}
+
+	} while (status != EFI_NOT_FOUND);
+
+	efivar_unlock();
+free:
+	kfree(variable_name);
+
+	return err;
+}
+
+/**
+ * efivar_entry_add - add entry to variable list
+ * @entry: entry to add to list
+ * @head: list head
+ *
+ * Returns 0 on success, or a kernel error code on failure.
+ */
+int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
+{
+	int err;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+	list_add(&entry->list, head);
+	efivar_unlock();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(efivar_entry_add);
+
+/**
+ * __efivar_entry_add - add entry to variable list
+ * @entry: entry to add to list
+ * @head: list head
+ */
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
+{
+	list_add(&entry->list, head);
+}
+EXPORT_SYMBOL_GPL(__efivar_entry_add);
+
+/**
+ * efivar_entry_remove - remove entry from variable list
+ * @entry: entry to remove from list
+ *
+ * Returns 0 on success, or a kernel error code on failure.
+ */
+void efivar_entry_remove(struct efivar_entry *entry)
+{
+	list_del(&entry->list);
+}
+EXPORT_SYMBOL_GPL(efivar_entry_remove);
+
+/*
+ * efivar_entry_list_del_unlock - remove entry from variable list
+ * @entry: entry to remove
+ *
+ * Remove @entry from the variable list and release the list lock.
+ *
+ * NOTE: slightly weird locking semantics here - we expect to be
+ * called with the efivars lock already held, and we release it before
+ * returning. This is because this function is usually called after
+ * set_variable() while the lock is still held.
+ */
+static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
+{
+	list_del(&entry->list);
+	efivar_unlock();
+}
+
+/**
+ * efivar_entry_delete - delete variable and remove entry from list
+ * @entry: entry containing variable to delete
+ *
+ * Delete the variable from the firmware and remove @entry from the
+ * variable list. It is the caller's responsibility to free @entry
+ * once we return.
+ *
+ * Returns 0 on success, -EINTR if we can't grab the semaphore,
+ * converted EFI status code if set_variable() fails.
+ */
+int efivar_entry_delete(struct efivar_entry *entry)
+{
+	efi_status_t status;
+	int err;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	status = efivar_set_variable_locked(entry->var.VariableName,
+					    &entry->var.VendorGuid,
+					    0, 0, NULL, false);
+	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND)) {
+		efivar_unlock();
+		return efi_status_to_err(status);
+	}
+
+	efivar_entry_list_del_unlock(entry);
+	return 0;
+}
+
+/**
+ * efivar_entry_size - obtain the size of a variable
+ * @entry: entry for this variable
+ * @size: location to store the variable's size
+ */
+int efivar_entry_size(struct efivar_entry *entry, unsigned long *size)
+{
+	efi_status_t status;
+	int err;
+
+	*size = 0;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	status = efivar_get_variable(entry->var.VariableName,
+				     &entry->var.VendorGuid, NULL, size, NULL);
+	efivar_unlock();
+
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return efi_status_to_err(status);
+
+	return 0;
+}
+
+/**
+ * __efivar_entry_get - call get_variable()
+ * @entry: read data for this variable
+ * @attributes: variable attributes
+ * @size: size of @data buffer
+ * @data: buffer to store variable data
+ *
+ * The caller MUST call efivar_entry_iter_begin() and
+ * efivar_entry_iter_end() before and after the invocation of this
+ * function, respectively.
+ */
+int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
+		       unsigned long *size, void *data)
+{
+	efi_status_t status;
+
+	status = efivar_get_variable(entry->var.VariableName,
+				     &entry->var.VendorGuid,
+				     attributes, size, data);
+
+	return efi_status_to_err(status);
+}
+
+/**
+ * efivar_entry_get - call get_variable()
+ * @entry: read data for this variable
+ * @attributes: variable attributes
+ * @size: size of @data buffer
+ * @data: buffer to store variable data
+ */
+int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
+		     unsigned long *size, void *data)
+{
+	int err;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+	err = __efivar_entry_get(entry, attributes, size, data);
+	efivar_unlock();
+
+	return 0;
+}
+
+/**
+ * efivar_entry_set_get_size - call set_variable() and get new size (atomic)
+ * @entry: entry containing variable to set and get
+ * @attributes: attributes of variable to be written
+ * @size: size of data buffer
+ * @data: buffer containing data to write
+ * @set: did the set_variable() call succeed?
+ *
+ * This is a pretty special (complex) function. See efivarfs_file_write().
+ *
+ * Atomically call set_variable() for @entry and if the call is
+ * successful, return the new size of the variable from get_variable()
+ * in @size. The success of set_variable() is indicated by @set.
+ *
+ * Returns 0 on success, -EINVAL if the variable data is invalid,
+ * -ENOSPC if the firmware does not have enough available space, or a
+ * converted EFI status code if either of set_variable() or
+ * get_variable() fail.
+ *
+ * If the EFI variable does not exist when calling set_variable()
+ * (EFI_NOT_FOUND), @entry is removed from the variable list.
+ */
+int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
+			      unsigned long *size, void *data, bool *set)
+{
+	efi_char16_t *name = entry->var.VariableName;
+	efi_guid_t *vendor = &entry->var.VendorGuid;
+	efi_status_t status;
+	int err;
+
+	*set = false;
+
+	if (efivar_validate(*vendor, name, data, *size) == false)
+		return -EINVAL;
+
+	/*
+	 * The lock here protects the get_variable call, the conditional
+	 * set_variable call, and removal of the variable from the efivars
+	 * list (in the case of an authenticated delete).
+	 */
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	/*
+	 * Ensure that the available space hasn't shrunk below the safe level
+	 */
+	status = check_var_size(attributes, *size + ucs2_strsize(name, 1024));
+	if (status != EFI_SUCCESS) {
+		if (status != EFI_UNSUPPORTED) {
+			err = efi_status_to_err(status);
+			goto out;
+		}
+
+		if (*size > 65536) {
+			err = -ENOSPC;
+			goto out;
+		}
+	}
+
+	status = efivar_set_variable_locked(name, vendor, attributes, *size,
+					    data, false);
+	if (status != EFI_SUCCESS) {
+		err = efi_status_to_err(status);
+		goto out;
+	}
+
+	*set = true;
+
+	/*
+	 * Writing to the variable may have caused a change in size (which
+	 * could either be an append or an overwrite), or the variable to be
+	 * deleted. Perform a GetVariable() so we can tell what actually
+	 * happened.
+	 */
+	*size = 0;
+	status = efivar_get_variable(entry->var.VariableName,
+				    &entry->var.VendorGuid,
+				    NULL, size, NULL);
+
+	if (status == EFI_NOT_FOUND)
+		efivar_entry_list_del_unlock(entry);
+	else
+		efivar_unlock();
+
+	if (status && status != EFI_BUFFER_TOO_SMALL)
+		return efi_status_to_err(status);
+
+	return 0;
+
+out:
+	efivar_unlock();
+	return err;
+
+}
+
+/**
+ * efivar_entry_iter - iterate over variable list
+ * @func: callback function
+ * @head: head of variable list
+ * @data: function-specific data to pass to callback
+ *
+ * Iterate over the list of EFI variables and call @func with every
+ * entry on the list. It is safe for @func to remove entries in the
+ * list via efivar_entry_delete() while iterating.
+ *
+ * Some notes for the callback function:
+ *  - a non-zero return value indicates an error and terminates the loop
+ *  - @func is called from atomic context
+ */
+int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
+		      struct list_head *head, void *data)
+{
+	struct efivar_entry *entry, *n;
+	int err = 0;
+
+	err = efivar_lock();
+	if (err)
+		return err;
+
+	list_for_each_entry_safe(entry, n, head, list) {
+		err = func(entry, data);
+		if (err)
+			break;
+	}
+	efivar_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(efivar_entry_iter);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 10ef0a0d5e9a..8122c2ed505c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1030,21 +1030,6 @@ struct efivars {
 
 #define EFI_VAR_NAME_LEN	1024
 
-struct efi_variable {
-	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
-	efi_guid_t    VendorGuid;
-	unsigned long DataSize;
-	__u8          Data[1024];
-	efi_status_t  Status;
-	__u32         Attributes;
-} __attribute__((packed));
-
-struct efivar_entry {
-	struct efi_variable var;
-	struct list_head list;
-	struct kobject kobj;
-};
-
 int efivars_register(struct efivars *efivars,
 		     const struct efivar_operations *ops,
 		     struct kobject *kobject);
@@ -1052,29 +1037,6 @@ int efivars_unregister(struct efivars *efivars);
 struct kobject *efivars_kobject(void);
 
 int efivar_supports_writes(void);
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
-		void *data, bool duplicates, struct list_head *head);
-
-int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void efivar_entry_remove(struct efivar_entry *entry);
-int efivar_entry_delete(struct efivar_entry *entry);
-
-int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
-int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
-		       unsigned long *size, void *data);
-int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
-		     unsigned long *size, void *data);
-int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
-			      unsigned long *size, void *data, bool *set);
-
-int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-		      struct list_head *head, void *data);
-
-bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
-		     unsigned long data_size);
-bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
-				  size_t len);
 
 int efivar_lock(void);
 int efivar_trylock(void);
-- 
2.35.1

