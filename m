Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6B4A6EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiBBKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41778 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiBBKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91DF821111;
        Wed,  2 Feb 2022 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+L6VyJmCMvNVNuiDAXoevTUJE4AYHiaWKCh7cVzh1c=;
        b=RkDxzeqzWMKn4dtAuxLntVdD3DZKqzuQxPXaJ3bd8+3bJJerH2/XC0pP0jForFnXKfKB1n
        /XyomBIUtuyHd2QFC+5F6c1OTkVZGfMrqvqrhlxnh9bLRJ3p5kHwdsFBUs+b6lRZO7D8to
        APmp9aXQxUgcQciJ2qUv79etOH9saoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J+L6VyJmCMvNVNuiDAXoevTUJE4AYHiaWKCh7cVzh1c=;
        b=LyzK6yBiz+IfPR35OT4uy0ligZDyZkbv1wbvbhIN1nmT6Mdgeko5Rh00Nw0fpYD4xMKJvT
        r/uFaL4I66SbgjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B9F213E02;
        Wed,  2 Feb 2022 10:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zX2cHNlf+mFdbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:29 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 01/15] crypto: kpp - provide support for KPP template instances
Date:   Wed,  2 Feb 2022 11:39:58 +0100
Message-Id: <20220202104012.4193-2-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming support for the RFC 7919 ffdhe group parameters will be
made available in the form of templates like "ffdhe2048(dh)",
"ffdhe3072(dh)" and so on. Template instantiations thereof would wrap the
inner "dh" kpp_alg and also provide kpp_alg services to the outside again.
Furthermore, it might be perhaps be desirable to provide KDF templates in
the future, which would similarly wrap an inner kpp_alg and present
themselves to the outside as another kpp_alg, transforming the shared
secret on its way out.

Introduce the bits needed for supporting KPP template instances. Everything
related to inner kpp_alg spawns potentially being held by such template
instances will be deferred to a subsequent patch in order to facilitate
review.

Define struct struct kpp_instance in close analogy to the already existing
skcipher_instance, shash_instance and alike, but wrapping a struct kpp_alg.
Implement the new kpp_register_instance() template instance registration
primitive. Provide some helper functions for
- going back and forth between a generic struct crypto_instance and the new
  struct kpp_instance,
- obtaining the instantiating kpp_instance from a crypto_kpp transform and
- for accessing a given kpp_instance's implementation specific context
  data.

Annotate everything with proper kernel-doc comments, even though
include/crypto/internal/kpp.h is not considered for the generated docs.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/kpp.c                  | 20 +++++++++
 include/crypto/internal/kpp.h | 83 +++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 313b2c699963..458195495a1d 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -68,9 +68,17 @@ static int crypto_kpp_init_tfm(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static void crypto_kpp_free_instance(struct crypto_instance *inst)
+{
+	struct kpp_instance *kpp = kpp_instance(inst);
+
+	kpp->free(kpp);
+}
+
 static const struct crypto_type crypto_kpp_type = {
 	.extsize = crypto_alg_extsize,
 	.init_tfm = crypto_kpp_init_tfm,
+	.free = crypto_kpp_free_instance,
 #ifdef CONFIG_PROC_FS
 	.show = crypto_kpp_show,
 #endif
@@ -111,5 +119,17 @@ void crypto_unregister_kpp(struct kpp_alg *alg)
 }
 EXPORT_SYMBOL_GPL(crypto_unregister_kpp);
 
+int kpp_register_instance(struct crypto_template *tmpl,
+			  struct kpp_instance *inst)
+{
+	if (WARN_ON(!inst->free))
+		return -EINVAL;
+
+	kpp_prepare_alg(&inst->alg);
+
+	return crypto_register_instance(tmpl, kpp_crypto_instance(inst));
+}
+EXPORT_SYMBOL_GPL(kpp_register_instance);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Key-agreement Protocol Primitives");
diff --git a/include/crypto/internal/kpp.h b/include/crypto/internal/kpp.h
index 659b642efada..c4d5a970fe9d 100644
--- a/include/crypto/internal/kpp.h
+++ b/include/crypto/internal/kpp.h
@@ -10,6 +10,24 @@
 #include <crypto/kpp.h>
 #include <crypto/algapi.h>
 
+/**
+ * struct kpp_instance - KPP template instance
+ * @free: Callback getting invoked upon instance destruction. Must be set.
+ * @s: Internal. Generic crypto core instance state properly layout
+ *     to alias with @alg as needed.
+ * @alg: The &struct kpp_alg implementation provided by the instance.
+ */
+struct kpp_instance {
+	void (*free)(struct kpp_instance *inst);
+	union {
+		struct {
+			char head[offsetof(struct kpp_alg, base)];
+			struct crypto_instance base;
+		} s;
+		struct kpp_alg alg;
+	};
+};
+
 /*
  * Transform internal helpers.
  */
@@ -33,6 +51,62 @@ static inline const char *kpp_alg_name(struct crypto_kpp *tfm)
 	return crypto_kpp_tfm(tfm)->__crt_alg->cra_name;
 }
 
+/*
+ * Template instance internal helpers.
+ */
+/**
+ * kpp_crypto_instance() - Cast a &struct kpp_instance to the corresponding
+ *                         generic &struct crypto_instance.
+ * @inst: Pointer to the &struct kpp_instance to be cast.
+ * Return: A pointer to the &struct crypto_instance embedded in @inst.
+ */
+static inline struct crypto_instance *kpp_crypto_instance(
+	struct kpp_instance *inst)
+{
+	return &inst->s.base;
+}
+
+/**
+ * kpp_instance() - Cast a generic &struct crypto_instance to the corresponding
+ *                  &struct kpp_instance.
+ * @inst: Pointer to the &struct crypto_instance to be cast.
+ * Return: A pointer to the &struct kpp_instance @inst is embedded in.
+ */
+static inline struct kpp_instance *kpp_instance(struct crypto_instance *inst)
+{
+	return container_of(inst, struct kpp_instance, s.base);
+}
+
+/**
+ * kpp_alg_instance() - Get the &struct kpp_instance a given KPP transform has
+ *                      been instantiated from.
+ * @kpp: The KPP transform instantiated from some &struct kpp_instance.
+ * Return: The &struct kpp_instance associated with @kpp.
+ */
+static inline struct kpp_instance *kpp_alg_instance(struct crypto_kpp *kpp)
+{
+	return kpp_instance(crypto_tfm_alg_instance(&kpp->base));
+}
+
+/**
+ * kpp_instance_ctx() - Get a pointer to a &struct kpp_instance's implementation
+ *                      specific context data.
+ * @inst: The &struct kpp_instance whose context data to access.
+ *
+ * A KPP template implementation may allocate extra memory beyond the
+ * end of a &struct kpp_instance instantiated from &crypto_template.create().
+ * This function provides a means to obtain a pointer to this area.
+ *
+ * Return: A pointer to the implementation specific context data.
+ */
+static inline void *kpp_instance_ctx(struct kpp_instance *inst)
+{
+	return crypto_instance_ctx(kpp_crypto_instance(inst));
+}
+
+/*
+ * KPP algorithm (un)registration functions.
+ */
 /**
  * crypto_register_kpp() -- Register key-agreement protocol primitives algorithm
  *
@@ -56,4 +130,13 @@ int crypto_register_kpp(struct kpp_alg *alg);
  */
 void crypto_unregister_kpp(struct kpp_alg *alg);
 
+/**
+ * kpp_register_instance() - Register a KPP template instance.
+ * @tmpl: The instantiating template.
+ * @inst: The KPP template instance to be registered.
+ * Return: %0 on success, negative error code otherwise.
+ */
+int kpp_register_instance(struct crypto_template *tmpl,
+			  struct kpp_instance *inst);
+
 #endif
-- 
2.26.2

