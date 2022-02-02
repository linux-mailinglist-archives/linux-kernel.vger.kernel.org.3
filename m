Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311FB4A6F06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbiBBKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:41:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239832AbiBBKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CDFD1F37C;
        Wed,  2 Feb 2022 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uMEyPPMWoptVVBkG9m83VbcZpbIyBOmwMFU/MrDW5k=;
        b=PHm4/X8s/HOUtM1OJMGz2FOGNqLJjLJ2GNGPcGT/WTcqtAW/tUIZM9OlqafD1tjiblRNiI
        i4EY+QixOhnVlX91sSJQLROE7YCVOM9sqUA4oUOfEyv2e1gmPUI2v/W6coAyZ90xQdmG0w
        J3NdPturPPWDnNZslXv5jtv+T64/hdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uMEyPPMWoptVVBkG9m83VbcZpbIyBOmwMFU/MrDW5k=;
        b=T2xeano9sumpXB3DucmzvLeQ/y8ouAEEaHwkS4kTfk6QGRNd0MfWxcTNp0aAAsoTqavyN1
        HBtCD4PSG4kI/zCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09D0B13E02;
        Wed,  2 Feb 2022 10:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2JKAdtf+mFhbAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:31 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 02/15] crypto: kpp - provide support for KPP spawns
Date:   Wed,  2 Feb 2022 11:39:59 +0100
Message-Id: <20220202104012.4193-3-nstange@suse.de>
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

The primitves needed for providing kpp_alg services from template instances
have been introduced with the previous patch. Continue this work now and
implement everything needed for enabling template instances to make use
of inner KPP algorithms like "dh".

More specifically, define a struct crypto_kpp_spawn in close analogy to
crypto_skcipher_spawn, crypto_shash_spawn and alike. Implement a
crypto_grab_kpp() and crypto_drop_kpp() pair for binding such a spawn to
some inner kpp_alg and for releasing it respectively. Template
implementations can instantiate transforms from the underlying kpp_alg by
means of the new crypto_spawn_kpp(). Finally, provide the
crypto_spawn_kpp_alg() helper for accessing a spawn's underlying kpp_alg
during template instantiation.

Annotate everything with proper kernel-doc comments, even though
include/crypto/internal/kpp.h is not considered for the generated docs.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/kpp.c                  |  9 +++++
 include/crypto/internal/kpp.h | 75 +++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 458195495a1d..7aa6ba4b60a4 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -95,6 +95,15 @@ struct crypto_kpp *crypto_alloc_kpp(const char *alg_name, u32 type, u32 mask)
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_kpp);
 
+int crypto_grab_kpp(struct crypto_kpp_spawn *spawn,
+		    struct crypto_instance *inst,
+		    const char *name, u32 type, u32 mask)
+{
+	spawn->base.frontend = &crypto_kpp_type;
+	return crypto_grab_spawn(&spawn->base, inst, name, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_grab_kpp);
+
 static void kpp_prepare_alg(struct kpp_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/internal/kpp.h b/include/crypto/internal/kpp.h
index c4d5a970fe9d..9cb0662ebe87 100644
--- a/include/crypto/internal/kpp.h
+++ b/include/crypto/internal/kpp.h
@@ -28,6 +28,20 @@ struct kpp_instance {
 	};
 };
 
+/**
+ * struct crypto_kpp_spawn - KPP algorithm spawn
+ * @base: Internal. Generic crypto core spawn state.
+ *
+ * Template instances can get a hold on some inner KPP algorithm by
+ * binding a &struct crypto_kpp_spawn via
+ * crypto_grab_kpp(). Transforms may subsequently get instantiated
+ * from the referenced inner &struct kpp_alg by means of
+ * crypto_spawn_kpp().
+ */
+struct crypto_kpp_spawn {
+	struct crypto_spawn base;
+};
+
 /*
  * Transform internal helpers.
  */
@@ -139,4 +153,65 @@ void crypto_unregister_kpp(struct kpp_alg *alg);
 int kpp_register_instance(struct crypto_template *tmpl,
 			  struct kpp_instance *inst);
 
+/*
+ * KPP spawn related functions.
+ */
+/**
+ * crypto_grab_kpp() - Look up a KPP algorithm and bind a spawn to it.
+ * @spawn: The KPP spawn to bind.
+ * @inst: The template instance owning @spawn.
+ * @name: The KPP algorithm name to look up.
+ * @type: The type bitset to pass on to the lookup.
+ * @mask: The mask bismask to pass on to the lookup.
+ * Return: %0 on success, a negative error code otherwise.
+ */
+int crypto_grab_kpp(struct crypto_kpp_spawn *spawn,
+		    struct crypto_instance *inst,
+		    const char *name, u32 type, u32 mask);
+
+/**
+ * crypto_drop_kpp() - Release a spawn previously bound via crypto_grab_kpp().
+ * @spawn: The spawn to release.
+ */
+static inline void crypto_drop_kpp(struct crypto_kpp_spawn *spawn)
+{
+	crypto_drop_spawn(&spawn->base);
+}
+
+/**
+ * crypto_spawn_kpp_alg() - Get the algorithm a KPP spawn has been bound to.
+ * @spawn: The spawn to get the referenced &struct kpp_alg for.
+ *
+ * This function as well as the returned result are safe to use only
+ * after @spawn has been successfully bound via crypto_grab_kpp() and
+ * up to until the template instance owning @spawn has either been
+ * registered successfully or the spawn has been released again via
+ * crypto_drop_spawn().
+ *
+ * Return: A pointer to the &struct kpp_alg referenced from the spawn.
+ */
+static inline struct kpp_alg *crypto_spawn_kpp_alg(
+	struct crypto_kpp_spawn *spawn)
+{
+	return container_of(spawn->base.alg, struct kpp_alg, base);
+}
+
+/**
+ * crypto_spawn_kpp() - Create a transform from a KPP spawn.
+ * @spawn: The spawn previously bound to some &struct kpp_alg via
+ *         crypto_grab_kpp().
+ *
+ * Once a &struct crypto_kpp_spawn has been successfully bound to a
+ * &struct kpp_alg via crypto_grab_kpp(), transforms for the latter
+ * may get instantiated from the former by means of this function.
+ *
+ * Return: A pointer to the freshly created KPP transform on success
+ * or an ``ERR_PTR()`` otherwise.
+ */
+static inline struct crypto_kpp *crypto_spawn_kpp(
+	struct crypto_kpp_spawn *spawn)
+{
+	return crypto_spawn_tfm2(&spawn->base);
+}
+
 #endif
-- 
2.26.2

