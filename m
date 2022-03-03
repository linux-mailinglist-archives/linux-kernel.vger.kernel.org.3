Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C404CC6EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiCCUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCCUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C30D19A5;
        Thu,  3 Mar 2022 12:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F8F61CB2;
        Thu,  3 Mar 2022 20:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ABBC340F2;
        Thu,  3 Mar 2022 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338402;
        bh=uaQpq/CEFn25exO2I5EA9h+tWP1uzIXArcfdpJGyMC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAv2i8CX3uV9/mvvr0XRZehFUKmLZ4fkAcbY2ZQ5hybgVouN1BtU5Bncm3siZnjgj
         tTxeYSlBq34VJyikyXHi9h4sS1ozndXz/C2TzUCAxsVLgqbCbwPwtDOnUhCr63+PSS
         k/UkcX9FfRof9YcfE1qF/jmeWdtYBImmuZoyhtrQQgbslpjOaw/QKkDghmXwC7NHm9
         W6MdmB7NfKkkpHrOLjeEpfVlQ068zJMjQubxh9r3E2gpaZkRMxeOsIMfoQwbfXlLQr
         aX47QlRp5sJYFEGaZ0+QWwy/SVFkmqayzXqMO16V2NJoV5e/dKq5mGqzCnTRvEr8Ds
         vWouB2vviHHuA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Date:   Thu,  3 Mar 2022 12:13:10 -0800
Message-Id: <20220303201312.3255347-7-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware specific features may be able to calculate a crc64, so provide
a framework for drivers to register their implementation. If nothing is
registered, fallback to the generic table lookup implementation. The
implementation is modeled after the crct10dif equivalent.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Updated naming, and Kconfig help texts, and Kconfig dependency

  Added crc64 test vectors to crypto/testmgr.c

  Use unaligned le64 macros for setting the result

  Use _GPL for EXPORT_SYMBOL

 crypto/Kconfig                  |   5 ++
 crypto/Makefile                 |   1 +
 crypto/crc64_rocksoft_generic.c |  89 ++++++++++++++++++++++
 crypto/testmgr.c                |   7 ++
 crypto/testmgr.h                |  15 ++++
 include/linux/crc64.h           |   5 ++
 lib/Kconfig                     |   9 +++
 lib/Makefile                    |   1 +
 lib/crc64-rocksoft.c            | 129 ++++++++++++++++++++++++++++++++
 9 files changed, 261 insertions(+)
 create mode 100644 crypto/crc64_rocksoft_generic.c
 create mode 100644 lib/crc64-rocksoft.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 442765219c37..e88e2d00e33d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -735,6 +735,11 @@ config CRYPTO_CRCT10DIF_VPMSUM
 	  multiply-sum (vpmsum) instructions, introduced in POWER8. Enable on
 	  POWER8 and newer processors for improved performance.
 
+config CRYPTO_CRC64_ROCKSOFT
+	tristate "Rocksoft Model CRC64 algorithm"
+	depends on CRC64
+	select CRYPTO_HASH
+
 config CRYPTO_VPMSUM_TESTER
 	tristate "Powerpc64 vpmsum hardware acceleration tester"
 	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
diff --git a/crypto/Makefile b/crypto/Makefile
index d76bff8d0ffd..f754c4d17d6b 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -152,6 +152,7 @@ obj-$(CONFIG_CRYPTO_MICHAEL_MIC) += michael_mic.o
 obj-$(CONFIG_CRYPTO_CRC32C) += crc32c_generic.o
 obj-$(CONFIG_CRYPTO_CRC32) += crc32_generic.o
 obj-$(CONFIG_CRYPTO_CRCT10DIF) += crct10dif_common.o crct10dif_generic.o
+obj-$(CONFIG_CRYPTO_CRC64_ROCKSOFT) += crc64_rocksoft_generic.o
 obj-$(CONFIG_CRYPTO_AUTHENC) += authenc.o authencesn.o
 obj-$(CONFIG_CRYPTO_LZO) += lzo.o lzo-rle.o
 obj-$(CONFIG_CRYPTO_LZ4) += lz4.o
diff --git a/crypto/crc64_rocksoft_generic.c b/crypto/crc64_rocksoft_generic.c
new file mode 100644
index 000000000000..9e812bb26dba
--- /dev/null
+++ b/crypto/crc64_rocksoft_generic.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crc64.h>
+#include <linux/module.h>
+#include <crypto/internal/hash.h>
+#include <asm/unaligned.h>
+
+static int chksum_init(struct shash_desc *desc)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = 0;
+
+	return 0;
+}
+
+static int chksum_update(struct shash_desc *desc, const u8 *data,
+			 unsigned int length)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	*crc = crc64_rocksoft_generic(*crc, data, length);
+
+	return 0;
+}
+
+static int chksum_final(struct shash_desc *desc, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	put_unaligned_le64(*crc, out);
+	return 0;
+}
+
+static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
+{
+	crc = crc64_rocksoft_generic(crc, data, len);
+	put_unaligned_le64(crc, out);
+	return 0;
+}
+
+static int chksum_finup(struct shash_desc *desc, const u8 *data,
+			unsigned int len, u8 *out)
+{
+	u64 *crc = shash_desc_ctx(desc);
+
+	return __chksum_finup(*crc, data, len, out);
+}
+
+static int chksum_digest(struct shash_desc *desc, const u8 *data,
+			 unsigned int length, u8 *out)
+{
+	return __chksum_finup(0, data, length, out);
+}
+
+static struct shash_alg alg = {
+	.digestsize	= 	sizeof(u64),
+	.init		=	chksum_init,
+	.update		=	chksum_update,
+	.final		=	chksum_final,
+	.finup		=	chksum_finup,
+	.digest		=	chksum_digest,
+	.descsize	=	sizeof(u64),
+	.base		=	{
+		.cra_name		=	CRC64_ROCKSOFT_STRING,
+		.cra_driver_name	=	"crc64-rocksoft-generic",
+		.cra_priority		=	200,
+		.cra_blocksize		=	1,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static int __init crc64_rocksoft_init(void)
+{
+	return crypto_register_shash(&alg);
+}
+
+static void __exit crc64_rocksoft_exit(void)
+{
+	crypto_unregister_shash(&alg);
+}
+
+module_init(crc64_rocksoft_init);
+module_exit(crc64_rocksoft_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Rocksoft model CRC64 calculation.");
+MODULE_ALIAS_CRYPTO("crc64-rocksoft");
+MODULE_ALIAS_CRYPTO("crc64-rocksoft-generic");
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 5831d4bbc64f..2e120eea10b1 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4526,6 +4526,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(crc32c_tv_template)
 		}
+	}, {
+		.alg = "crc64-rocksoft",
+		.test = alg_test_hash,
+		.fips_allowed = 1,
+		.suite = {
+			.hash = __VECS(crc64_rocksoft_tv_template)
+		}
 	}, {
 		.alg = "crct10dif",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index a253d66ba1c1..f1a22794c404 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -3679,6 +3679,21 @@ static const struct hash_testvec rmd160_tv_template[] = {
 	}
 };
 
+static const u8 zeroes[4096] = { [0 ... 4095] = 0 };
+static const u8 ones[4096] = { [0 ... 4095] = 0xff };
+
+static const struct hash_testvec crc64_rocksoft_tv_template[] = {
+	{
+		.plaintext	= zeroes,
+		.psize		= 4096,
+		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
+	}, {
+		.plaintext	= ones,
+		.psize		= 4096,
+		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
+	}
+};
+
 static const struct hash_testvec crct10dif_tv_template[] = {
 	{
 		.plaintext	= "abc",
diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index 9480f38cc7cf..e044c60d1e61 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -7,7 +7,12 @@
 
 #include <linux/types.h>
 
+#define CRC64_ROCKSOFT_STRING "crc64-rocksoft"
+
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
 u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
 
+u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
+u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
+
 #endif /* _LINUX_CRC64_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index c80fde816a7e..da3e03579666 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -146,6 +146,15 @@ config CRC_T10DIF
 	  kernel tree needs to calculate CRC checks for use with the
 	  SCSI data integrity subsystem.
 
+config CRC64_ROCKSOFT
+	tristate "CRC calculation for the Rocksoft model CRC64"
+	select CRC64
+	select CRYPTO
+	select CRYPTO_CRC64_ROCKSOFT
+	help
+	  This option provides a CRC64 API to a registered crypto driver.
+	  This is used with the block layer's data integrity subsystem.
+
 config CRC_ITU_T
 	tristate "CRC ITU-T V.41 functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b..7f7ae7458b6c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_CRC4)	+= crc4.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_CRC8)	+= crc8.o
+obj-$(CONFIG_CRC64_ROCKSOFT) += crc64-rocksoft.o
 obj-$(CONFIG_XXHASH)	+= xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
diff --git a/lib/crc64-rocksoft.c b/lib/crc64-rocksoft.c
new file mode 100644
index 000000000000..55d32872778a
--- /dev/null
+++ b/lib/crc64-rocksoft.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/crc64.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <crypto/hash.h>
+#include <crypto/algapi.h>
+#include <linux/static_key.h>
+#include <linux/notifier.h>
+
+static struct crypto_shash __rcu *crc64_rocksoft_tfm;
+static DEFINE_STATIC_KEY_TRUE(crc64_rocksoft_fallback);
+static DEFINE_MUTEX(crc64_rocksoft_mutex);
+static struct work_struct crc64_rocksoft_rehash_work;
+
+static int crc64_rocksoft_notify(struct notifier_block *self, unsigned long val, void *data)
+{
+	struct crypto_alg *alg = data;
+
+	if (val != CRYPTO_MSG_ALG_LOADED ||
+	    strcmp(alg->cra_name, CRC64_ROCKSOFT_STRING))
+		return NOTIFY_DONE;
+
+	schedule_work(&crc64_rocksoft_rehash_work);
+	return NOTIFY_OK;
+}
+
+static void crc64_rocksoft_rehash(struct work_struct *work)
+{
+	struct crypto_shash *new, *old;
+
+	mutex_lock(&crc64_rocksoft_mutex);
+	old = rcu_dereference_protected(crc64_rocksoft_tfm,
+					lockdep_is_held(&crc64_rocksoft_mutex));
+	new = crypto_alloc_shash(CRC64_ROCKSOFT_STRING, 0, 0);
+	if (IS_ERR(new)) {
+		mutex_unlock(&crc64_rocksoft_mutex);
+		return;
+	}
+	rcu_assign_pointer(crc64_rocksoft_tfm, new);
+	mutex_unlock(&crc64_rocksoft_mutex);
+
+	if (old) {
+		synchronize_rcu();
+		crypto_free_shash(old);
+	} else {
+		static_branch_disable(&crc64_rocksoft_fallback);
+	}
+}
+
+static struct notifier_block crc64_rocksoft_nb = {
+	.notifier_call = crc64_rocksoft_notify,
+};
+
+u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
+{
+	struct {
+		struct shash_desc shash;
+		u64 crc;
+	} desc;
+	int err;
+
+	if (static_branch_unlikely(&crc64_rocksoft_fallback))
+		return crc64_rocksoft_generic(crc, buffer, len);
+
+	rcu_read_lock();
+	desc.shash.tfm = rcu_dereference(crc64_rocksoft_tfm);
+	desc.crc = crc;
+	err = crypto_shash_update(&desc.shash, buffer, len);
+	rcu_read_unlock();
+
+	BUG_ON(err);
+
+	return desc.crc;
+}
+EXPORT_SYMBOL_GPL(crc64_rocksoft_update);
+
+u64 crc64_rocksoft(const unsigned char *buffer, size_t len)
+{
+	return crc64_rocksoft_update(0, buffer, len);
+}
+EXPORT_SYMBOL_GPL(crc64_rocksoft);
+
+static int __init crc64_rocksoft_mod_init(void)
+{
+	INIT_WORK(&crc64_rocksoft_rehash_work, crc64_rocksoft_rehash);
+	crypto_register_notifier(&crc64_rocksoft_nb);
+	crc64_rocksoft_rehash(&crc64_rocksoft_rehash_work);
+	return 0;
+}
+
+static void __exit crc64_rocksoft_mod_fini(void)
+{
+	crypto_unregister_notifier(&crc64_rocksoft_nb);
+	cancel_work_sync(&crc64_rocksoft_rehash_work);
+	crypto_free_shash(rcu_dereference_protected(crc64_rocksoft_tfm, 1));
+}
+
+module_init(crc64_rocksoft_mod_init);
+module_exit(crc64_rocksoft_mod_fini);
+
+static int crc64_rocksoft_transform_show(char *buffer, const struct kernel_param *kp)
+{
+	struct crypto_shash *tfm;
+	int len;
+
+	if (static_branch_unlikely(&crc64_rocksoft_fallback))
+		return sprintf(buffer, "fallback\n");
+
+	rcu_read_lock();
+	tfm = rcu_dereference(crc64_rocksoft_tfm);
+	len = snprintf(buffer, PAGE_SIZE, "%s\n",
+		       crypto_shash_driver_name(tfm));
+	rcu_read_unlock();
+
+	return len;
+}
+
+module_param_call(transform, NULL, crc64_rocksoft_transform_show, NULL, 0444);
+
+MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");
+MODULE_DESCRIPTION("Rocksoft model CRC64 calculation (library API)");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crc64");
-- 
2.25.4

