Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A64C02A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiBVT7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiBVT7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:59:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEBE98CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:59:17 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJF-00050X-3H; Tue, 22 Feb 2022 20:58:53 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJC-009hyX-FN; Tue, 22 Feb 2022 20:58:50 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
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
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 4/5] crypto: caam - add in-kernel interface for blob generator
Date:   Tue, 22 Feb 2022 20:58:18 +0100
Message-Id: <20220222195819.2313913-5-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
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
Tested-By: Tim Harvey <tharvey@gateworks.com>
Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: "Horia Geantă" <horia.geanta@nxp.com>
To: Aymen Sghaier <aymen.sghaier@nxp.com>
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
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 drivers/crypto/caam/Kconfig    |   3 +
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/blob_gen.c | 230 +++++++++++++++++++++++++++++++++
 include/soc/fsl/caam-blob.h    |  56 ++++++++
 4 files changed, 290 insertions(+)
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
index 000000000000..513d3f90e438
--- /dev/null
+++ b/drivers/crypto/caam/blob_gen.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
+ * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
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
+static u32 *caam_blob_alloc_desc(size_t keymod_len)
+{
+	size_t len;
+
+	/* header + (key mod immediate) + 2x pointers + op */
+	len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 + CAAM_PTR_SZ_MAX) + 4;
+
+	if (len > CAAM_DESC_BYTES_MAX)
+		return NULL;
+
+	return kzalloc(len, GFP_KERNEL | GFP_DMA);
+}
+
+int caam_encap_blob(struct caam_blob_priv *priv, const char *keymod,
+		    void *input, void *output, size_t length)
+{
+	u32 *desc;
+	struct device *jrdev = &priv->jrdev;
+	dma_addr_t dma_in, dma_out;
+	struct caam_blob_job_result testres;
+	size_t keymod_len = strlen(keymod);
+	int ret;
+
+	if (length <= CAAM_BLOB_OVERHEAD || keymod_len > CAAM_BLOB_KEYMOD_LENGTH)
+		return -EINVAL;
+
+	desc = caam_blob_alloc_desc(keymod_len);
+	if (!desc) {
+		dev_err(jrdev, "unable to allocate desc\n");
+		return -ENOMEM;
+	}
+
+	dma_in = dma_map_single(jrdev, input, length - CAAM_BLOB_OVERHEAD, DMA_TO_DEVICE);
+	if (dma_mapping_error(jrdev, dma_in)) {
+		dev_err(jrdev, "unable to map input DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	dma_out = dma_map_single(jrdev, output, length,	DMA_FROM_DEVICE);
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
+	append_key_as_imm(desc, keymod, keymod_len, keymod_len,
+			  CLASS_2 | KEY_DEST_CLASS_REG);
+	append_seq_in_ptr_intlen(desc, dma_in, length - CAAM_BLOB_OVERHEAD, 0);
+	append_seq_out_ptr_intlen(desc, dma_out, length, 0);
+	append_operation(desc, OP_TYPE_ENCAP_PROTOCOL | OP_PCLID_BLOB);
+
+	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, input,
+			     length - CAAM_BLOB_OVERHEAD, false);
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
+				     DUMP_PREFIX_ADDRESS, 16, 1, output,
+				     length, false);
+	}
+
+	dma_unmap_single(jrdev, dma_out, length, DMA_FROM_DEVICE);
+out_unmap_in:
+	dma_unmap_single(jrdev, dma_in, length - CAAM_BLOB_OVERHEAD, DMA_TO_DEVICE);
+out_free:
+	kfree(desc);
+
+	return ret;
+}
+EXPORT_SYMBOL(caam_encap_blob);
+
+int caam_decap_blob(struct caam_blob_priv *priv, const char *keymod,
+		    void *input, void *output, size_t length)
+{
+	u32 *desc;
+	struct device *jrdev = &priv->jrdev;
+	dma_addr_t dma_in, dma_out;
+	struct caam_blob_job_result testres;
+	size_t keymod_len = strlen(keymod);
+	int ret;
+
+	if (length <= CAAM_BLOB_OVERHEAD || keymod_len > CAAM_BLOB_KEYMOD_LENGTH)
+		return -EINVAL;
+
+	desc = caam_blob_alloc_desc(keymod_len);
+	if (!desc) {
+		dev_err(jrdev, "unable to allocate desc\n");
+		return -ENOMEM;
+	}
+
+	dma_in = dma_map_single(jrdev, input, length, DMA_TO_DEVICE);
+	if (dma_mapping_error(jrdev, dma_in)) {
+		dev_err(jrdev, "unable to map input DMA buffer\n");
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	dma_out = dma_map_single(jrdev, output, length - CAAM_BLOB_OVERHEAD, DMA_FROM_DEVICE);
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
+	append_key_as_imm(desc, keymod, keymod_len, keymod_len,
+			  CLASS_2 | KEY_DEST_CLASS_REG);
+	append_seq_in_ptr(desc, dma_in, length, 0);
+	append_seq_out_ptr(desc, dma_out, length - CAAM_BLOB_OVERHEAD, 0);
+	append_operation(desc, OP_TYPE_DECAP_PROTOCOL | OP_PCLID_BLOB);
+
+	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 1, input,
+			     length, false);
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
+				     DUMP_PREFIX_ADDRESS, 16, 1, output,
+				     length - CAAM_BLOB_OVERHEAD, false);
+	}
+
+	dma_unmap_single(jrdev, dma_out, length - CAAM_BLOB_OVERHEAD, DMA_FROM_DEVICE);
+out_unmap_in:
+	dma_unmap_single(jrdev, dma_in, length, DMA_TO_DEVICE);
+out_free:
+	kfree(desc);
+
+	return ret;
+}
+EXPORT_SYMBOL(caam_decap_blob);
+
+struct caam_blob_priv *caam_blob_gen_init(void)
+{
+	struct device *jrdev;
+
+	jrdev = caam_jr_alloc();
+	if (IS_ERR(jrdev))
+		return ERR_CAST(jrdev);
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
index 000000000000..83fd990ebdce
--- /dev/null
+++ b/include/soc/fsl/caam-blob.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ */
+
+#ifndef __CAAM_BLOB_GEN
+#define __CAAM_BLOB_GEN
+
+#include <linux/types.h>
+
+#define CAAM_BLOB_KEYMOD_LENGTH		16
+#define CAAM_BLOB_OVERHEAD		(32 + 16)
+#define CAAM_BLOB_MAX_LEN		4096
+
+struct caam_blob_priv;
+
+/** caam_blob_gen_init - initialize blob generation
+ *
+ * returns either pointer to new caam_blob_priv instance
+ * or error pointer
+ */
+struct caam_blob_priv *caam_blob_gen_init(void);
+
+/** caam_blob_gen_exit - free blob generation resources
+ *
+ * @priv: instance returned by caam_blob_gen_init
+ */
+void caam_blob_gen_exit(struct caam_blob_priv *priv);
+
+/** caam_encap_blob - encapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @keymod: string to use as key modifier for blob encapsulation
+ *	    can't be longer than CAAM_BLOB_KEYMOD_LENGTH
+ * @input:  buffer which CAAM will DMA from
+ * @output: buffer which CAAM will DMA to
+ * @length: buffer length including blob overhead
+ *          CAAM_BLOB_OVERHEAD < length <= CAAM_BLOB_MAX_LEN
+ */
+int caam_encap_blob(struct caam_blob_priv *priv, const char *keymod,
+		    void *input, void *output, size_t length);
+
+/** caam_decap_blob - decapsulate blob
+ *
+ * @priv:   instance returned by caam_blob_gen_init
+ * @keymod: string to use as key modifier for blob decapsulation
+ *	    can't be longer than CAAM_BLOB_KEYMOD_LENGTH
+ * @input:  buffer which CAAM will DMA from
+ * @output: buffer which CAAM will DMA to
+ * @length: buffer length including blob overhead
+ *          CAAM_BLOB_OVERHEAD < length <= CAAM_BLOB_MAX_LEN
+ */
+int caam_decap_blob(struct caam_blob_priv *priv, const char *keymod,
+		    void *input, void *output, size_t length);
+
+#endif
-- 
2.30.2

