Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACB4C02BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiBVUAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiBVUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:00:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD0E98F4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:59:24 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJF-00050V-2q; Tue, 22 Feb 2022 20:58:53 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJC-009hyN-CR; Tue, 22 Feb 2022 20:58:50 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 2/5] KEYS: trusted: allow users to use kernel RNG for key material
Date:   Tue, 22 Feb 2022 20:58:16 +0100
Message-Id: <20220222195819.2313913-3-a.fatoum@pengutronix.de>
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

The two existing trusted key sources don't make use of the kernel RNG,
but instead let the hardware doing the sealing/unsealing also
generate the random key material. However, users may want to place
less trust into the quality of the trust source's random number
generator and instead use the kernel entropy pool, which can be
seeded from multiple entropy sources.

Make this possible by adding a new trusted.kernel_rng parameter,
that will force use of the kernel RNG. In its absence, it's up
to the trust source to decide, which random numbers to use,
maintaining the existing behavior.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: David Gstir <david@sigma-star.at>
Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
To: James Bottomley <jejb@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++++
 .../security/keys/trusted-encrypted.rst       | 20 ++++++-----
 security/keys/trusted-keys/trusted_core.c     | 35 ++++++++++++++++++-
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..844c883ca9d8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5880,6 +5880,16 @@
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
index 80d5a5af62a1..99cf34d7c025 100644
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

