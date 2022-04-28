Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58951360E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348105AbiD1OGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbiD1OFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:05:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0DAC921
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:02:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iN-0000Ax-M1; Thu, 28 Apr 2022 16:01:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iO-005lwr-8A; Thu, 28 Apr 2022 16:01:50 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nk4iL-003i0z-CS; Thu, 28 Apr 2022 16:01:49 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 2/6] KEYS: trusted: allow use of kernel RNG for key material
Date:   Thu, 28 Apr 2022 16:01:41 +0200
Message-Id: <20220428140145.870527-3-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428140145.870527-1-a.fatoum@pengutronix.de>
References: <20220428140145.870527-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two existing trusted key sources don't make use of the kernel RNG,
but instead let the hardware doing the sealing/unsealing also
generate the random key material. However, both users and future
backends may want to place less trust into the quality of the trust
source's random number generator and instead reuse the kernel entropy
pool, which can be seeded from multiple entropy sources.

Make this possible by adding a new trusted.rng parameter,
that will force use of the kernel RNG. In its absence, it's up
to the trust source to decide, which random numbers to use,
maintaining the existing behavior.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: David Gstir <david@sigma-star.at>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v7 -> v8:
  - add Pankaj's Tested-by
v6 -> v7:
  - No changes
v5 -> v6:
  - Squash with follow-up patch enabling trust sources to use
    kernel RNG if they don't define their own .get_random
  - Collected Jarkko's Reviewed-by
v4 -> v5:
  - Changed trusted.kernel_rng bool option into a string trusted.rng option
    (Jarkko)
  - Typo fix in commit message (Jarkko)
v3 -> v4:
  - Collected Acked-by's, Reviewed-by's and Tested-by
v2 -> v3:
  - No change
v1 -> v2:
 - Allow users to force use of kernel RNG (Jarkko)

To: James Bottomley <jejb@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++++
 .../security/keys/trusted-encrypted.rst       | 20 ++++++-----
 include/keys/trusted-type.h                   |  2 +-
 security/keys/trusted-keys/trusted_core.c     | 35 ++++++++++++++++++-
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..4deed1908a75 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5963,6 +5963,16 @@
 			first trust source as a backend which is initialized
 			successfully during iteration.
 
+	trusted.rng=	[KEYS]
+			Format: <string>
+			The RNG used to generate key material for trusted keys.
+			Can be one of:
+			- "kernel"
+			- the same value as trusted.source: "tpm" or "tee"
+			- "default"
+			If not specified, "default" is used. In this case,
+			the RNG's choice is left to each individual trust source.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index f614dad7de12..2fe6fd1a2bbd 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -87,22 +87,26 @@ Key Generation
 Trusted Keys
 ------------
 
-New keys are created from random numbers generated in the trust source. They
-are encrypted/decrypted using a child key in the storage key hierarchy.
-Encryption and decryption of the child key must be protected by a strong
-access control policy within the trust source.
+New keys are created from random numbers. They are encrypted/decrypted using
+a child key in the storage key hierarchy. Encryption and decryption of the
+child key must be protected by a strong access control policy within the
+trust source. The random number generator in use differs according to the
+selected trust source:
 
-  *  TPM (hardware device) based RNG
+  *  TPM: hardware device based RNG
 
-     Strength of random numbers may vary from one device manufacturer to
-     another.
+     Keys are generated within the TPM. Strength of random numbers may vary
+     from one device manufacturer to another.
 
-  *  TEE (OP-TEE based on Arm TrustZone) based RNG
+  *  TEE: OP-TEE based on Arm TrustZone based RNG
 
      RNG is customizable as per platform needs. It can either be direct output
      from platform specific hardware RNG or a software based Fortuna CSPRNG
      which can be seeded via multiple entropy sources.
 
+Users may override this by specifying ``trusted.rng=kernel`` on the kernel
+command-line to override the used RNG with the kernel's random number pool.
+
 Encrypted Keys
 --------------
 
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index d89fa2579ac0..4eb64548a74f 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -64,7 +64,7 @@ struct trusted_key_ops {
 	/* Unseal a key. */
 	int (*unseal)(struct trusted_key_payload *p, char *datablob);
 
-	/* Get a randomized key. */
+	/* Optional: Get a randomized key. */
 	int (*get_random)(unsigned char *key, size_t key_len);
 
 	/* Exit key interface. */
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 7cdbd16aed30..9235fb7d0ec9 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -16,12 +16,17 @@
 #include <linux/key-type.h>
 #include <linux/module.h>
 #include <linux/parser.h>
+#include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/static_call.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 
+static char *trusted_rng = "default";
+module_param_named(rng, trusted_rng, charp, 0);
+MODULE_PARM_DESC(rng, "Select trusted key RNG");
+
 static char *trusted_key_source;
 module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
@@ -312,8 +317,14 @@ struct key_type key_type_trusted = {
 };
 EXPORT_SYMBOL_GPL(key_type_trusted);
 
+static int kernel_get_random(unsigned char *key, size_t key_len)
+{
+	return get_random_bytes_wait(key, key_len) ?: key_len;
+}
+
 static int __init init_trusted(void)
 {
+	int (*get_random)(unsigned char *key, size_t key_len);
 	int i, ret = 0;
 
 	for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
@@ -322,6 +333,28 @@ static int __init init_trusted(void)
 			    strlen(trusted_key_sources[i].name)))
 			continue;
 
+		/*
+		 * We always support trusted.rng="kernel" and "default" as
+		 * well as trusted.rng=$trusted.source if the trust source
+		 * defines its own get_random callback.
+		 */
+		get_random = trusted_key_sources[i].ops->get_random;
+		if (trusted_rng && strcmp(trusted_rng, "default")) {
+			if (!strcmp(trusted_rng, "kernel")) {
+				get_random = kernel_get_random;
+			} else if (strcmp(trusted_rng, trusted_key_sources[i].name) ||
+				   !get_random) {
+				pr_warn("Unsupported RNG. Supported: kernel");
+				if (get_random)
+					pr_cont(", %s", trusted_key_sources[i].name);
+				pr_cont(", default\n");
+				return -EINVAL;
+			}
+		}
+
+		if (!get_random)
+			get_random = kernel_get_random;
+
 		static_call_update(trusted_key_init,
 				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
@@ -329,7 +362,7 @@ static int __init init_trusted(void)
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
-				   trusted_key_sources[i].ops->get_random);
+				   get_random);
 		static_call_update(trusted_key_exit,
 				   trusted_key_sources[i].ops->exit);
 		migratable = trusted_key_sources[i].ops->migratable;
-- 
2.30.2

