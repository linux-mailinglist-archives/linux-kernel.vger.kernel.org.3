Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F674C02AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiBVUAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiBVT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:59:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73FFE7F7C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:59:21 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJF-00050U-2N; Tue, 22 Feb 2022 20:58:53 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nMbJC-009hyI-At; Tue, 22 Feb 2022 20:58:50 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     kernel@pengutronix.de, Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 1/5] KEYS: trusted: allow use of TEE as backend without TCG_TPM support
Date:   Tue, 22 Feb 2022 20:58:15 +0100
Message-Id: <20220222195819.2313913-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
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

With recent rework, trusted keys are no longer limited to TPM as trust
source. The Kconfig symbol is unchanged however leading to a few issues:

  - TCG_TPM is required, even if only TEE is to be used
  - Enabling TCG_TPM, but excluding it from available trusted sources
    is not possible
  - TEE=m && TRUSTED_KEYS=y will lead to TEE support being silently
    dropped, which is not the best user experience

Remedy these issues by introducing two new boolean Kconfig symbols:
TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
dependencies.

Any code depending on the TPM trusted key backend or symbols exported
by it will now need to explicitly state that it

  depends on TRUSTED_KEYS && TRUSTED_KEYS_TPM

The latter to ensure the dependency is built and the former to ensure
it's reachable for module builds. This currently only affects
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE, so it's fixed up here as well.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-By: Andreas Rammhold <andreas@rammhold.de>
Tested-By: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v4 -> v5:
  - collected Jarkko's Reviewed-by
v3 -> v4:
  - rebased on top of Andreas' regression fix and pulled it back
    into series
v2 -> v3:
  - factored this patch out as a fix for backporting
v1 -> v2:
  - Move rest of TPM-related selects from TRUSTED_KEYS to
    TRUSTED_KEYS_TPM (Sumit)
  - Remove left-over line in Makefile (Sumit)
  - added Fixes: tag
  - adjust commit message to reference the regression reported
    by Andreas
  - have ASYMMETRIC_TPM_KEY_SUBTYPE depend on TRUSTED_KEYS_TPM,
    because it references global symbols that are exported
    by the trusted key TPM backend.

[1]: https://lore.kernel.org/linux-integrity/f8285eb0135ba30c9d846cf9dd395d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de/
[2]: https://lore.kernel.org/linux-integrity/20210719091335.vwfebcpkf4pag3wm@wrt/T/#t

To: Jarkko Sakkinen <jarkko@kernel.org>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
To: James Bottomley <jejb@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
To: Sumit Garg <sumit.garg@linaro.org>
To: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
---
 crypto/asymmetric_keys/Kconfig            |  2 +-
 security/keys/Kconfig                     | 18 ++++++--------
 security/keys/trusted-keys/Kconfig        | 29 +++++++++++++++++++++++
 security/keys/trusted-keys/Makefile       |  8 +++----
 security/keys/trusted-keys/trusted_core.c |  4 ++--
 5 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 security/keys/trusted-keys/Kconfig

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1f1f004dc757..8886eddbf881 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -25,7 +25,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 config ASYMMETRIC_TPM_KEY_SUBTYPE
 	tristate "Asymmetric TPM backed private key subtype"
 	depends on TCG_TPM
-	depends on TRUSTED_KEYS
+	depends on TRUSTED_KEYS && TRUSTED_KEYS_TPM
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 969122c7b92f..826cd0904f9a 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -70,23 +70,19 @@ config BIG_KEYS
 
 config TRUSTED_KEYS
 	tristate "TRUSTED KEYS"
-	depends on KEYS && TCG_TPM
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA1
-	select CRYPTO_HASH_INFO
-	select ASN1_ENCODER
-	select OID_REGISTRY
-	select ASN1
+	depends on KEYS
 	help
 	  This option provides support for creating, sealing, and unsealing
 	  keys in the kernel. Trusted keys are random number symmetric keys,
-	  generated and RSA-sealed by the TPM. The TPM only unseals the keys,
-	  if the boot PCRs and other criteria match.  Userspace will only ever
-	  see encrypted blobs.
+	  generated and sealed by a trust source selected at kernel boot-time.
+	  Userspace will only ever see encrypted blobs.
 
 	  If you are unsure as to whether this is required, answer N.
 
+if TRUSTED_KEYS
+source "security/keys/trusted-keys/Kconfig"
+endif
+
 config ENCRYPTED_KEYS
 	tristate "ENCRYPTED KEYS"
 	depends on KEYS
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
new file mode 100644
index 000000000000..fc4abd581abb
--- /dev/null
+++ b/security/keys/trusted-keys/Kconfig
@@ -0,0 +1,29 @@
+config TRUSTED_KEYS_TPM
+	bool "TPM-based trusted keys"
+	depends on TCG_TPM >= TRUSTED_KEYS
+	default y
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
+	select CRYPTO_HASH_INFO
+	select ASN1_ENCODER
+	select OID_REGISTRY
+	select ASN1
+	help
+	  Enable use of the Trusted Platform Module (TPM) as trusted key
+	  backend. Trusted keys are random number symmetric keys,
+	  which will be generated and RSA-sealed by the TPM.
+	  The TPM only unseals the keys, if the boot PCRs and other
+	  criteria match.
+
+config TRUSTED_KEYS_TEE
+	bool "TEE-based trusted keys"
+	depends on TEE >= TRUSTED_KEYS
+	default y
+	help
+	  Enable use of the Trusted Execution Environment (TEE) as trusted
+	  key backend.
+
+if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
+comment "No trust source selected!"
+endif
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index feb8b6c3cc79..2e2371eae4d5 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,10 +5,10 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_core.o
-trusted-y += trusted_tpm1.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
 
 $(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
-trusted-y += trusted_tpm2.o
-trusted-y += tpm2key.asn1.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
 
-trusted-$(CONFIG_TEE) += trusted_tee.o
+trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 9b9d3ef79cbe..7cdbd16aed30 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
-#if IS_REACHABLE(CONFIG_TCG_TPM)
+#if defined(CONFIG_TRUSTED_KEYS_TPM)
 	{ "tpm", &trusted_key_tpm_ops },
 #endif
-#if IS_REACHABLE(CONFIG_TEE)
+#if defined(CONFIG_TRUSTED_KEYS_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
 };
-- 
2.30.2

