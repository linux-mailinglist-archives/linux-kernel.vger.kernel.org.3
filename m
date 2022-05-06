Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7551D15A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbiEFGbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbiEFGaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88A66209
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:26:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nmrPo-0005oE-MP; Fri, 06 May 2022 08:26:12 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nmrPi-000edb-5Z; Fri, 06 May 2022 08:26:04 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nmrPf-004Tvu-J0; Fri, 06 May 2022 08:26:03 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Michael Walle <michael@walle.cc>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v9 4/7] crypto: caam - add in-kernel interface for blob generator
Date:   Fri,  6 May 2022 08:25:50 +0200
Message-Id: <20220506062553.1068296-5-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP Cryptographic Acceleration and Assurance Module (CAAM)
can be used to protect user-defined data across system reboot:

  - When the system is fused and boots into secure state, the master
    key is a unique never-disclosed device-specific key
  - random key is encrypted by key derived from master key
  - data is encrypted using the random key
  - encrypted data and its encrypted random key are stored alongside
  - This blob can now be safely stored in non-volatile memory

On next power-on:
  - blob is loaded into CAAM
  - CAAM writes decrypted data either into memory or key register

Add functions to realize encrypting and decrypting into memory alongside
the CAAM driver.

They will be used in a later commit as a source for the trusted key
seal/unseal mechanism.

Reviewed-by: David Gstir <david@sigma-star.at>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v8 -> v9:
  - Improve kernel-doc with ``literal`` formatting and &struct/func()
    references
  - Have caam_blob_gen_init return -ENODEV in absence of job ring
    or blobbing support with appropriate info messages
v7 -> v8:
  - remove unneeded new line in kernel doc (Jarkko)
  - Make comments parse as kernel-doc and fix associated warnings
  - add Pankaj's Tested-by
v6 -> v7:
  - Added more verbose comment on how CAAM_BLOB_DESC_BYTES_MAX adds up.
  - remove error message on kzalloc failure (checkpatch)
  - Replaced buffer arguments with structure containing them (Pankaj)
v5 -> v6:
  - Dropped caam_blob_alloc_desc() in favor of kzalloc() with fixed size.
    This simplifies code and wastes at most 12 bytes which are freed
    at the end of the function anyway.
  - Factored out common code between caam_encap_blob and caam_decap_blob
    as both functions were largely identical
  - use append_seq_(in|out)_ptr_intlen for both encap/decap as a result
  - use reverse christmas tree order for caam_process_blob variable
    definitions.
v4 -> v5:
  - Collected Reviewed-by's and Tested-by's
  - Note in CAAM patch what CAAM is (Jarkko)
v3 -> v4:
  - Collected Acked-by's, Reviewed-by's and Tested-by
  - Fixed typo spotted by David
v2 -> v3:
 - No change
v1 -> v2:
 - Enforce maximum keymod size (Horia)
 - Use append_seq_(in|out)_ptr_intlen instead of append_seq_(in|out)_ptr
   (Horia)
 - Make blobifier handle private to CAAM glue code file (Horia)

To: "Horia Geantă" <horia.geanta@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Michael Walle <michael@walle.cc>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 drivers/crypto/caam/Kconfig    |   3 +
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/blob_gen.c | 182 +++++++++++++++++++++++++++++++++
 include/soc/fsl/caam-blob.h    | 103 +++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 drivers/crypto/caam/blob_gen.c
 create mode 100644 include/soc/fsl/caam-blob.h

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index 84ea7cba5ee5..ea9f8b1ae981 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -151,6 +151,9 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
 	  Selecting this will register the SEC4 hardware rng to
 	  the hw_random API for supplying the kernel entropy pool.
 
+config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+	bool
+
 endif # CRYPTO_DEV_FSL_CAAM_JR
 
 endif # CRYPTO_DEV_FSL_CAAM
diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makefile
index 3570286eb9ce..25f7ae5a4642 100644
--- a/drivers/crypto/caam/Makefile
+++ b/drivers/crypto/caam/Makefile
@@ -21,6 +21,7 @@ caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += caamalg_qi.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) += caamhash.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += caamrng.o
 caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) += caampkc.o pkc_desc.o
+caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN) += blob_gen.o
 
 caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += qi.o
 ifneq ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
new file mode 100644
index 000000000000..6345c7269eb0
--- /dev/null
+++ b/drivers/crypto/caam/blob_gen.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#define pr_fmt(fmt) "caam blob_gen: " fmt
+
+#include <linux/device.h>
+#include <soc/fsl/caam-blob.h>
+
+#include "compat.h"
+#include "desc_constr.h"
+#include "desc.h"
+#include "error.h"
+#include "intern.h"
+#include "jr.h"
+#include "regs.h"
+
+#define CAAM_BLOB_DESC_BYTES_MAX					\
+	/* Command to initialize & stating length of descriptor */	\
+	(CAAM_CMD_SZ +							\
+	/* Command to append the key-modifier + key-modifier data */	\
+	 CAAM_CMD_SZ + CAAM_BLOB_KEYMOD_LENGTH +			\
+	/* Command to include input key + pointer to the input key */	\
+	 CAAM_CMD_SZ + CAAM_PTR_SZ_MAX +				\
+	/* Command to include output key + pointer to the output key */	\
+	 CAAM_CMD_SZ + CAAM_PTR_SZ_MAX +				\
+	/* Command describing the operation to perform */		\
+	 CAAM_CMD_SZ)
+
+struct caam_blob_priv {
+	struct device jrdev;
+};
+
+struct caam_blob_job_result {
+	int err;
+	struct completion completion;
+};
+
+static void caam_blob_job_done(struct device *dev, u32 *desc, u32 err, void *context)
+{
+	struct caam_blob_job_result *res = context;
+	int ecode = 0;
+
+	dev_dbg(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
+
+	if (err)
+		ecode = caam_jr_strstatus(dev, err);
+
+	res->err = ecode;
+
+	/*
+	 * Upon completion, desc points to a buffer containing a CAAM job
+	 * descriptor which encapsulates data into an externally-storable
+	 * blob.
+	 */
+	complete(&res->completion);
+}
+
+int caam_process_blob(struct caam_blob_priv *priv,
+		      struct caam_blob_info *info, bool encap)
+{
+	struct caam_blob_job_result testres;
+	struct device *jrdev = &priv->jrdev;
+	dma_addr_t dma_in, dma_out;
+	int op = OP_PCLID_BLOB;
+	size_t output_len;
+	u32 *desc;
+	int ret;
+
+	if (info->key_mod_len > CAAM_BLOB_KEYMOD_LENGTH)
+		return -EINVAL;
+
+	if (encap) {
+		op |= OP_TYPE_ENCAP_PROTOCOL;
+		output_len = info->input_len + CAAM_BLOB_OVERHEAD;
+	} else {
+		op |= OP_TYPE_DECAP_PROTOCOL;
+		output_len = info->input_len - CAAM_BLOB_OVERHEAD;
+	}
+
+	desc = kzalloc(CAAM_BLOB_DESC_BYTES_MAX, GFP_KERNEL | GFP_DMA);
+	if (!desc)
+		return -ENOMEM;
+
+	dma_in = dma_map_single(jrdev, info->input, info->input_len,
+				DMA_TO_DEVICE);
+	if (dma_mapping_error(jrdev, dma_in)) {
+		dev_err(jrdev, "unable to map input DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	dma_out = dma_map_single(jrdev, info->output, output_len,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(jrdev, dma_out)) {
+		dev_err(jrdev, "unable to map output DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_unmap_in;
+	}
+
+	/*
+	 * A data blob is encrypted using a blob key (BK); a random number.
+	 * The BK is used as an AES-CCM key. The initial block (B0) and the
+	 * initial counter (Ctr0) are generated automatically and stored in
+	 * Class 1 Context DWords 0+1+2+3. The random BK is stored in the
+	 * Class 1 Key Register. Operation Mode is set to AES-CCM.
+	 */
+
+	init_job_desc(desc, 0);
+	append_key_as_imm(desc, info->key_mod, info->key_mod_len,
+			  info->key_mod_len, CLASS_2 | KEY_DEST_CLASS_REG);
+	append_seq_in_ptr_intlen(desc, dma_in, info->input_len, 0);
+	append_seq_out_ptr_intlen(desc, dma_out, output_len, 0);
+	append_operation(desc, op);
+
+	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
+			     info->input_len, false);
+	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
+			     desc_bytes(desc), false);
+
+	testres.err = 0;
+	init_completion(&testres.completion);
+
+	ret = caam_jr_enqueue(jrdev, desc, caam_blob_job_done, &testres);
+	if (ret == -EINPROGRESS) {
+		wait_for_completion(&testres.completion);
+		ret = testres.err;
+		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
+				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
+				     output_len, false);
+	}
+
+	if (ret == 0)
+		info->output_len = output_len;
+
+	dma_unmap_single(jrdev, dma_out, output_len, DMA_FROM_DEVICE);
+out_unmap_in:
+	dma_unmap_single(jrdev, dma_in, info->input_len, DMA_TO_DEVICE);
+out_free:
+	kfree(desc);
+
+	return ret;
+}
+EXPORT_SYMBOL(caam_process_blob);
+
+struct caam_blob_priv *caam_blob_gen_init(void)
+{
+	struct caam_drv_private *ctrlpriv;
+	struct device *jrdev;
+
+	/*
+	 * caam_blob_gen_init() may expectedly fail with -ENODEV, e.g. when
+	 * CAAM driver didn't probe or when SoC lacks BLOB support. An
+	 * error would be harsh in this case, so we stick to info level.
+	 */
+
+	jrdev = caam_jr_alloc();
+	if (IS_ERR(jrdev)) {
+		pr_info("job ring requested, but none currently available\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ctrlpriv = dev_get_drvdata(jrdev->parent);
+	if (!ctrlpriv->blob_present) {
+		dev_info(jrdev, "no hardware blob generation support\n");
+		caam_jr_free(jrdev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return container_of(jrdev, struct caam_blob_priv, jrdev);
+}
+EXPORT_SYMBOL(caam_blob_gen_init);
+
+void caam_blob_gen_exit(struct caam_blob_priv *priv)
+{
+	caam_jr_free(&priv->jrdev);
+}
+EXPORT_SYMBOL(caam_blob_gen_exit);
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
new file mode 100644
index 000000000000..937cac52f36d
--- /dev/null
+++ b/include/soc/fsl/caam-blob.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#ifndef __CAAM_BLOB_GEN
+#define __CAAM_BLOB_GEN
+
+#include <linux/types.h>
+#include <linux/errno.h>
+
+#define CAAM_BLOB_KEYMOD_LENGTH		16
+#define CAAM_BLOB_OVERHEAD		(32 + 16)
+#define CAAM_BLOB_MAX_LEN		4096
+
+struct caam_blob_priv;
+
+/**
+ * struct caam_blob_info - information for CAAM blobbing
+ * @input:       pointer to input buffer (must be DMAable)
+ * @input_len:   length of @input buffer in bytes.
+ * @output:      pointer to output buffer (must be DMAable)
+ * @output_len:  length of @output buffer in bytes.
+ * @key_mod:     key modifier
+ * @key_mod_len: length of @key_mod in bytes.
+ *	         May not exceed %CAAM_BLOB_KEYMOD_LENGTH
+ */
+struct caam_blob_info {
+	void *input;
+	size_t input_len;
+
+	void *output;
+	size_t output_len;
+
+	const void *key_mod;
+	size_t key_mod_len;
+};
+
+/**
+ * caam_blob_gen_init - initialize blob generation
+ * Return: pointer to new &struct caam_blob_priv instance on success
+ * and ``ERR_PTR(-ENODEV)`` if CAAM has no hardware blobbing support
+ * or no job ring could be allocated.
+ */
+struct caam_blob_priv *caam_blob_gen_init(void);
+
+/**
+ * caam_blob_gen_exit - free blob generation resources
+ * @priv: instance returned by caam_blob_gen_init()
+ */
+void caam_blob_gen_exit(struct caam_blob_priv *priv);
+
+/**
+ * caam_process_blob - encapsulate or decapsulate blob
+ * @priv:   instance returned by caam_blob_gen_init()
+ * @info:   pointer to blobbing info describing key, blob and
+ *          key modifier buffers.
+ * @encap:  true for encapsulation, false for decapsulation
+ *
+ * Return: %0 and sets ``info->output_len`` on success and a negative
+ * error code otherwise.
+ */
+int caam_process_blob(struct caam_blob_priv *priv,
+		      struct caam_blob_info *info, bool encap);
+
+/**
+ * caam_encap_blob - encapsulate blob
+ * @priv:   instance returned by caam_blob_gen_init()
+ * @info:   pointer to blobbing info describing input key,
+ *          output blob and key modifier buffers.
+ *
+ * Return: %0 and sets ``info->output_len`` on success and
+ * a negative error code otherwise.
+ */
+static inline int caam_encap_blob(struct caam_blob_priv *priv,
+				  struct caam_blob_info *info)
+{
+	if (info->output_len < info->input_len + CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
+
+	return caam_process_blob(priv, info, true);
+}
+
+/**
+ * caam_decap_blob - decapsulate blob
+ * @priv:   instance returned by caam_blob_gen_init()
+ * @info:   pointer to blobbing info describing output key,
+ *          input blob and key modifier buffers.
+ *
+ * Return: %0 and sets ``info->output_len`` on success and
+ * a negative error code otherwise.
+ */
+static inline int caam_decap_blob(struct caam_blob_priv *priv,
+				  struct caam_blob_info *info)
+{
+	if (info->input_len < CAAM_BLOB_OVERHEAD ||
+	    info->output_len < info->input_len - CAAM_BLOB_OVERHEAD)
+		return -EINVAL;
+
+	return caam_process_blob(priv, info, false);
+}
+
+#endif
-- 
2.30.2

