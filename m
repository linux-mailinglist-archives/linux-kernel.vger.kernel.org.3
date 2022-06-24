Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8D5595C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiFXIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiFXItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9315D105;
        Fri, 24 Jun 2022 01:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 152E86202E;
        Fri, 24 Jun 2022 08:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE48C341C8;
        Fri, 24 Jun 2022 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656060584;
        bh=56IF+p6ZRKtIMtoS9fAs8VmyAr/kQM9xHoUlBuj9S2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCNeaeqzee1PP9ObcGzhMXyBbyDSH+IMHbMFn6j9/8ZbgRJcdu8il3r/Q878AN+AX
         kS6ukb/vSi/tzZ9O/TduWyf5t+/ORANCMfPprCu9C5OHg/wTfF4SbItG11NuxQLPhm
         XR+TLeMSQi+BtzPKzPm1ntuDIvEWseU4S3DsM5vbJTvICnHBkQ/FV2pzCYsn9f5UrQ
         alpIc4h1NR3IzpWJ391ZhsAwIlu5ZWZTGI/Yh5Gmwmp90Z87IcWT5D/4gCm/F8Zq79
         ZX6kgIfY3xron0CEeX1rG/WnLHs5Q1pB5dG1vLiK7PtJJhGbRi7vDViXJFk26kXuII
         V12DGBfKlNZVg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3 2/9] efi: vars: Don't drop lock in the middle of efivar_init()
Date:   Fri, 24 Jun 2022 10:49:18 +0200
Message-Id: <20220624084925.724516-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624084925.724516-1-ardb@kernel.org>
References: <20220624084925.724516-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5517; h=from:subject; bh=56IF+p6ZRKtIMtoS9fAs8VmyAr/kQM9xHoUlBuj9S2A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBitXqIsbWXK1ba1qtaxOzy6beuyeIfsZcL6+fe4pEi OKlnrDuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrV6iAAKCRDDTyI5ktmPJMgVC/ 9sNS4ITTheU9lbTc+VDw2CSbOhcZ1Ly7NxJEdkrC9TV27nZo0XNTi24CnjW3Fbyt8fOSCdLgWcdMvI V7FR64mfENCHr0Afh5+jk6Hw8yX3n5hrG+1cHK8cSSgAW2s37+gBQHerrL9aunhNN3SPqi1uujm5sP 45R1JkLyc4QRwnuhsIfZdphGUWn6Hg2K/KftbxswT9xah7gt+Xtkir6B2F9qE1O1GXcABfcc2EQD5X iqg/Yf4R8kJsI2BSNrqIsEyz4JX5IrZ8X2PhUPWOHqgU+tnEisnNJTypcjxC0jKLU7f0h++y8u2MBk F+YvZGKtV95RdpmLNAZ0ikk47tSg5Oztccz0hzTzT98m7wKEx0tuw1cFzzhHjrnwn4ZWYoTqojdCKM VsQny6cZp7+R6nQOTNwxYQtW6oZjLaol2c96Q9PBaxfvCsbbdVWSlpm4I8JxvRAAQcVg78t8ch4e8r 3kngV6IDgXg52QHNYUCjt+TdHvll+LrEXxEu6rGGLHqn4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the efivars_lock lock is documented as protecting the
efivars->ops pointer (among other things), efivar_init() happily
releases and reacquires the lock for every EFI variable that it
enumerates. This used to be needed because the lock was originally a
spinlock, which prevented the callback that is invoked for every
variable from being able to sleep. However, releasing the lock could
potentially invalidate the ops pointer, but more importantly, it might
allow a SetVariable() runtime service call to take place concurrently,
and the UEFI spec does not define how this affects an enumeration that
is running in parallel using the GetNextVariable() runtime service,
which is what efivar_init() uses.

In the meantime, the lock has been converted into a semaphore, and the
only reason we need to drop the lock is because the efivarfs pseudo
filesystem driver will otherwise deadlock when it invokes the efivars
API from the callback to create the efivar_entry items and insert them
into the linked list. (EFI pstore is affected in a similar way)

So let's switch to helpers that can be used while the lock is already
taken. This way, we can hold on to the lock throughout the enumeration.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  7 ++-----
 drivers/firmware/efi/efivars.c    |  5 +----
 drivers/firmware/efi/vars.c       | 22 ++++++++++----------
 fs/efivarfs/super.c               |  6 ++----
 include/linux/efi.h               |  1 +
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 7e771c56c13c..0d80cc7ff6ca 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -364,7 +364,6 @@ static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
 			       unsigned long name_size, void *data)
 {
 	struct efivar_entry *entry;
-	int ret;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -373,11 +372,9 @@ static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
 	memcpy(entry->var.VariableName, name, name_size);
 	entry->var.VendorGuid = vendor;
 
-	ret = efivar_entry_add(entry, &efi_pstore_list);
-	if (ret)
-		kfree(entry);
+	__efivar_entry_add(entry, &efi_pstore_list);
 
-	return ret;
+	return 0;
 }
 
 static int efi_pstore_update_entry(efi_char16_t *name, efi_guid_t vendor,
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index ea0bc39dc965..c19db0b35c0d 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -527,10 +527,7 @@ efivar_create_sysfs_entry(struct efivar_entry *new_var)
 	}
 
 	kobject_uevent(&new_var->kobj, KOBJ_ADD);
-	if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
-		efivar_unregister(new_var);
-		return -EINTR;
-	}
+	__efivar_entry_add(new_var, &efivar_sysfs_list);
 
 	return 0;
 }
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index cae590bd08f2..146360e2f1cb 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -450,9 +450,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 						&vendor_guid);
 		switch (status) {
 		case EFI_SUCCESS:
-			if (duplicates)
-				up(&efivars_lock);
-
 			variable_name_size = var_name_strnsize(variable_name,
 							       variable_name_size);
 
@@ -476,14 +473,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 				if (err)
 					status = EFI_NOT_FOUND;
 			}
-
-			if (duplicates) {
-				if (down_interruptible(&efivars_lock)) {
-					err = -EINTR;
-					goto free;
-				}
-			}
-
 			break;
 		case EFI_UNSUPPORTED:
 			err = -EOPNOTSUPP;
@@ -526,6 +515,17 @@ int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
 }
 EXPORT_SYMBOL_GPL(efivar_entry_add);
 
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
 /**
  * efivar_entry_remove - remove entry from variable list
  * @entry: entry to remove from list
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 15880a68faad..09dfa8362f50 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -155,10 +155,8 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 		goto fail_inode;
 	}
 
-	efivar_entry_size(entry, &size);
-	err = efivar_entry_add(entry, &efivarfs_list);
-	if (err)
-		goto fail_inode;
+	__efivar_entry_get(entry, NULL, &size, NULL);
+	__efivar_entry_add(entry, &efivarfs_list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 53f64c14a525..56f04b6daeb0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1064,6 +1064,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
+void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 int efivar_entry_remove(struct efivar_entry *entry);
 
 int __efivar_entry_delete(struct efivar_entry *entry);
-- 
2.35.1

