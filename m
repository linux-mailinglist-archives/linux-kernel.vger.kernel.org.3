Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4E46CA27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhLHBkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhLHBkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:40:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A73C061574;
        Tue,  7 Dec 2021 17:36:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE1F9B81F42;
        Wed,  8 Dec 2021 01:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C802C341CB;
        Wed,  8 Dec 2021 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638927404;
        bh=/OWRvk0R3Q4EDyrDlRrFU3XAN56tDl4pTKZFLV/IE/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2hBcIp0njMQAsNWx2sIc8PFByrN3xiODOLl1WDp0DaPjvJQRaI+Ajt861P2Ka0g3
         mlt4HcO5XERY15Kc81iERXY78+tpBrT9l3frgE6oaJ3vgRsEaOLSybcArKOfTG+/3O
         0gE/ZODf7qOicWaE3Sd1UYGpT61VXKNr3qaAZJIF7u+IVF9kW115be1tqaFMtoe3Jw
         xgc1ukMOG/ocxW5GNKJSDPZkHkYQLeMjKpe8qTumkGuELgYWDPdTbxBCEmOYAhIX3g
         6MXIrKDQC/ti0rEsfuDVdHYapC2DKZVC420TigzWdc9Qo+KX6dO6AWGTA1IQJh9n5n
         jDEE8Vt6LQilA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Date:   Tue,  7 Dec 2021 17:35:34 -0800
Message-Id: <20211208013534.136590-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208013534.136590-1-ebiggers@kernel.org>
References: <20211208013534.136590-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add sysfs files that expose the inline encryption capabilities of
request queues:

	/sys/block/$disk/queue/crypto/max_dun_bits
	/sys/block/$disk/queue/crypto/modes/$mode
	/sys/block/$disk/queue/crypto/num_keyslots

Userspace can use these new files to decide what encryption settings to
use, or whether to use inline encryption at all.  This also brings the
crypto capabilities in line with the other queue properties, which are
already discoverable via the queue directory in sysfs.

Design notes:

  - Place the new files in a new subdirectory "crypto" to group them
    together and to avoid complicating the main "queue" directory.  This
    also makes it possible to replace "crypto" with a symlink later if
    we ever make the blk_crypto_profiles into real kobjects (see below).

  - It was necessary to define a new kobject that corresponds to the
    crypto subdirectory.  For now, this kobject just contains a pointer
    to the blk_crypto_profile.  Note that multiple queues (and hence
    multiple such kobjects) may refer to the same blk_crypto_profile.

    An alternative design would more closely match the current kernel
    data structures: the blk_crypto_profile could be a kobject itself,
    located directly under the host controller device's kobject, while
    /sys/block/$disk/queue/crypto would be a symlink to it.

    I decided not to do that for now because it would require a lot more
    changes, such as no longer embedding blk_crypto_profile in other
    structures, and also because I'm not sure we can rule out moving the
    crypto capabilities into 'struct queue_limits' in the future.  (Even
    if multiple queues share the same crypto engine, maybe the supported
    data unit sizes could differ due to other queue properties.)  It
    would also still be possible to switch to that design later without
    breaking userspace, by replacing the directory with a symlink.

  - Use "max_dun_bits" instead of "max_dun_bytes".  Currently, the
    kernel internally stores this value in bytes, but that's an
    implementation detail.  It probably makes more sense to talk about
    this value in bits, and choosing bits is more future-proof.

  - "modes" is a sub-subdirectory, since there may be multiple supported
    crypto modes, sysfs is supposed to have one value per file, and it
    makes sense to group all the mode files together.

  - Each mode had to be named.  The crypto API names like "xts(aes)" are
    not appropriate because they don't specify the key size.  Therefore,
    I assigned new names.  The exact names chosen are arbitrary, but
    they happen to match the names used in log messages in fs/crypto/.

  - The "num_keyslots" file is a bit different from the others in that
    it is only useful to know for performance reasons.  However, it's
    included as it can still be useful.  For example, a user might not
    want to use inline encryption if there aren't very many keyslots.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block |  49 ++++++++
 block/Makefile                       |   3 +-
 block/blk-crypto-internal.h          |  12 ++
 block/blk-crypto-sysfs.c             | 172 +++++++++++++++++++++++++++
 block/blk-crypto.c                   |   3 +
 block/blk-sysfs.c                    |   6 +
 include/linux/blkdev.h               |   1 +
 7 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-crypto-sysfs.c

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index e988742a54a4c..b97a8cf7c3ad0 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -155,6 +155,55 @@ Description:
 		last zone of the device which may be smaller.
 
 
+What:		/sys/block/<disk>/queue/crypto/
+Date:		December 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		The presence of this subdirectory of /sys/block/<disk>/queue/
+		indicates that the device supports inline encryption.  This
+		subdirectory contains files which describe the inline encryption
+		capabilities of the device.  For more information about inline
+		encryption, refer to Documentation/block/inline-encryption.rst.
+
+
+What:		/sys/block/<disk>/queue/crypto/max_dun_bits
+Date:		December 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file shows the maximum length, in bits, of data unit
+		numbers accepted by the device in inline encryption requests.
+
+
+What:		/sys/block/<disk>/queue/crypto/modes/<mode>
+Date:		December 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] For each crypto mode (i.e., encryption/decryption
+		algorithm) the device supports with inline encryption, a file
+		will exist at this location.  It will contain a hexadecimal
+		number that is a bitmask of the supported data unit sizes, in
+		bytes, for that crypto mode.
+
+		Currently, the crypto modes that may be supported are:
+
+		   * AES-256-XTS
+		   * AES-128-CBC-ESSIV
+		   * Adiantum
+
+		For example, if a device supports AES-256-XTS inline encryption
+		with data unit sizes of 512 and 4096 bytes, the file
+		/sys/block/<disk>/queue/crypto/modes/AES-256-XTS will exist and
+		will contain "0x1200".
+
+
+What:		/sys/block/<disk>/queue/crypto/num_keyslots
+Date:		December 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file shows the number of keyslots the device has for
+		use with inline encryption.
+
+
 What:		/sys/block/<disk>/queue/dax
 Date:		June 2016
 Contact:	linux-block@vger.kernel.org
diff --git a/block/Makefile b/block/Makefile
index f38eaa6129296..3950ecbc5c263 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
+					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 2fb0d65a464ca..e6818ffaddbf8 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -11,6 +11,7 @@
 
 /* Represents a crypto mode supported by blk-crypto  */
 struct blk_crypto_mode {
+	const char *name; /* name of this mode, shown in sysfs */
 	const char *cipher_str; /* crypto API name (for fallback case) */
 	unsigned int keysize; /* key size in bytes */
 	unsigned int ivsize; /* iv size in bytes */
@@ -20,6 +21,10 @@ extern const struct blk_crypto_mode blk_crypto_modes[];
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
+int blk_crypto_sysfs_register(struct request_queue *q);
+
+void blk_crypto_sysfs_unregister(struct request_queue *q);
+
 void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 			     unsigned int inc);
 
@@ -62,6 +67,13 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+static inline int blk_crypto_sysfs_register(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_crypto_sysfs_unregister(struct request_queue *q) { }
+
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
 					       struct bio *bio)
 {
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
new file mode 100644
index 0000000000000..fd93bd2f33b75
--- /dev/null
+++ b/block/blk-crypto-sysfs.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ *
+ * sysfs support for blk-crypto.  This file contains the code which exports the
+ * crypto capabilities of devices via /sys/block/$disk/queue/crypto/.
+ */
+
+#include <linux/blk-crypto-profile.h>
+
+#include "blk-crypto-internal.h"
+
+struct blk_crypto_kobj {
+	struct kobject kobj;
+	struct blk_crypto_profile *profile;
+};
+
+struct blk_crypto_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct blk_crypto_profile *profile,
+			struct blk_crypto_attr *attr, char *page);
+};
+
+static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
+{
+	return container_of(kobj, struct blk_crypto_kobj, kobj)->profile;
+}
+
+static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
+{
+	return container_of(attr, struct blk_crypto_attr, attr);
+}
+
+static ssize_t max_dun_bits_show(struct blk_crypto_profile *profile,
+				 struct blk_crypto_attr *attr, char *page)
+{
+	return sysfs_emit(page, "%u\n", 8 * profile->max_dun_bytes_supported);
+}
+
+static ssize_t num_keyslots_show(struct blk_crypto_profile *profile,
+				 struct blk_crypto_attr *attr, char *page)
+{
+	return sysfs_emit(page, "%u\n", profile->num_slots);
+}
+
+#define BLK_CRYPTO_RO_ATTR(_name) \
+	static struct blk_crypto_attr _name##_attr = __ATTR_RO(_name)
+
+BLK_CRYPTO_RO_ATTR(max_dun_bits);
+BLK_CRYPTO_RO_ATTR(num_keyslots);
+
+static struct attribute *blk_crypto_attrs[] = {
+	&max_dun_bits_attr.attr,
+	&num_keyslots_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group blk_crypto_attr_group = {
+	.attrs = blk_crypto_attrs,
+};
+
+/*
+ * The encryption mode attributes.  To avoid hard-coding the list of encryption
+ * modes, these are initialized at boot time by blk_crypto_sysfs_init().
+ */
+static struct blk_crypto_attr __blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX];
+static struct attribute *blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX + 1];
+
+static umode_t blk_crypto_mode_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+	int mode_num = a - __blk_crypto_mode_attrs;
+
+	if (profile->modes_supported[mode_num])
+		return 0444;
+	return 0;
+}
+
+static ssize_t blk_crypto_mode_show(struct blk_crypto_profile *profile,
+				    struct blk_crypto_attr *attr, char *page)
+{
+	int mode_num = attr - __blk_crypto_mode_attrs;
+
+	return sysfs_emit(page, "0x%x\n", profile->modes_supported[mode_num]);
+}
+
+static const struct attribute_group blk_crypto_modes_attr_group = {
+	.name = "modes",
+	.attrs = blk_crypto_mode_attrs,
+	.is_visible = blk_crypto_mode_is_visible,
+};
+
+static const struct attribute_group *blk_crypto_attr_groups[] = {
+	&blk_crypto_attr_group,
+	&blk_crypto_modes_attr_group,
+	NULL,
+};
+
+static ssize_t blk_crypto_attr_show(struct kobject *kobj,
+				    struct attribute *attr, char *page)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+
+	return a->show(profile, a, page);
+}
+
+static const struct sysfs_ops blk_crypto_attr_ops = {
+	.show = blk_crypto_attr_show,
+};
+
+static void blk_crypto_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct blk_crypto_kobj, kobj));
+}
+
+static struct kobj_type blk_crypto_ktype = {
+	.default_groups = blk_crypto_attr_groups,
+	.sysfs_ops	= &blk_crypto_attr_ops,
+	.release	= blk_crypto_release,
+};
+
+/*
+ * If the request_queue has a blk_crypto_profile, create the "crypto"
+ * subdirectory in sysfs (/sys/block/$disk/queue/crypto/).
+ */
+int blk_crypto_sysfs_register(struct request_queue *q)
+{
+	struct blk_crypto_kobj *obj;
+	int err;
+
+	if (!q->crypto_profile)
+		return 0;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+	obj->profile = q->crypto_profile;
+
+	err = kobject_init_and_add(&obj->kobj, &blk_crypto_ktype, &q->kobj,
+				   "crypto");
+	if (err) {
+		kobject_put(&obj->kobj);
+		return err;
+	}
+	q->crypto_kobject = &obj->kobj;
+	return 0;
+}
+
+void blk_crypto_sysfs_unregister(struct request_queue *q)
+{
+	kobject_put(q->crypto_kobject);
+}
+
+static int __init blk_crypto_sysfs_init(void)
+{
+	int i;
+
+	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
+	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
+		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
+
+		attr->attr.name = blk_crypto_modes[i].name;
+		attr->attr.mode = 0444;
+		attr->show = blk_crypto_mode_show;
+		blk_crypto_mode_attrs[i - 1] = &attr->attr;
+	}
+	return 0;
+}
+subsys_initcall(blk_crypto_sysfs_init);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index ec9efeeeca918..f8a36c723a987 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -19,16 +19,19 @@
 
 const struct blk_crypto_mode blk_crypto_modes[] = {
 	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
+		.name = "AES-256-XTS",
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV] = {
+		.name = "AES-128-CBC-ESSIV",
 		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_ADIANTUM] = {
+		.name = "Adiantum",
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
 		.ivsize = 32,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c11242ef88558..b5f8029fe155e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -877,6 +877,10 @@ int blk_register_queue(struct gendisk *disk)
 			goto put_dev;
 	}
 
+	ret = blk_crypto_sysfs_register(q);
+	if (ret)
+		goto put_dev;
+
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(q);
 	blk_throtl_register_queue(q);
@@ -908,6 +912,7 @@ int blk_register_queue(struct gendisk *disk)
 	return ret;
 
 put_dev:
+	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
@@ -952,6 +957,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
+	blk_crypto_sysfs_unregister(q);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c80cfaefc0a8f..c9461fb185d1f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -262,6 +262,7 @@ struct request_queue {
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
+	struct kobject *crypto_kobject;
 #endif
 
 	unsigned int		rq_timeout;
-- 
2.34.1

