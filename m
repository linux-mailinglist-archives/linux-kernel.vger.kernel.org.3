Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9DB4A6EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbiBBKmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:42:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36770 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245001AbiBBKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:41:37 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EED9A1F387;
        Wed,  2 Feb 2022 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643798495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVrOdXP55KwyevEnk2bjml5wRX2UHp0zngksfaywLa0=;
        b=oB+T6B5TMUwwSyvfA7CVbLRFP4cZWUyCJsYzLHRHyM2ijtgtQ1UDyPUS8sMTOY21wKqB0K
        SF7MuNvbJgfwHP2PauCAO1YD4LJw0e+AWPTdM4Ocd7bKVzmMQ/qC88umt/iUsF3Bxq84O2
        fV2dFoCJmlH4sX5ULgrACkmeZnHioOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643798495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVrOdXP55KwyevEnk2bjml5wRX2UHp0zngksfaywLa0=;
        b=UHhTqTQ4aylwxHnJd4QH9hr96l6YlZTWfmTKIkv2s58Vue1VpobLRLnr5ME0t32EyD/hYT
        PXX8HqpTX/4juBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D0513E02;
        Wed,  2 Feb 2022 10:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I8qUM99f+mF0bAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 02 Feb 2022 10:41:35 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH v3 06/15] crypto: dh - introduce common code for built-in safe-prime group support
Date:   Wed,  2 Feb 2022 11:40:03 +0100
Message-Id: <20220202104012.4193-7-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220202104012.4193-1-nstange@suse.de>
References: <20220202104012.4193-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent work on NVME in-band authentication support ([1]) needs to invoke
the "dh" KPP with the FFDHE safe-prime group parameters as specified in
RFC 7919 and generate ephemeral keys suitable for the respective group. By
coincidence, the requirements from NIST SP800-56Arev3,
sec. 5.5.2 ("Assurance of Domain-Parameter Validity") basically boil down
to disallowing any group parameters not among the approved safe-prime
groups specified in either RFC 7919 or RFC 3526 in FIPS mode. Furthermore,
SP800-56Arev3 specifies the respective security strength for each of the
approved safe-prime groups, which has a direct impact on the minimum key
lengths.

In this light, it's desirable to introduce built-in support for the
RFC 7919 safe-prime groups to the kernel's DH implementation, provide a
SP800-56Arev3 conforming key generation primitive for those and render
non-approved group parameters unusable in FIPS mode on the way.

As suggested ([2]) in the course of discussion to previous iterations of
this patchset, the built-in support for ffdhe groups would be best made
available in the form of templates wrapping the existing "dh"
implementation, one for each group specified by RFC 7919: ffdhe2048(dh),
ffdhe3072(dh), ffdhe4096(dh), ffdhe6144(dh) and ffdhe8192(dh). As these
templates differ only in the safe-prime constants they'd configure the
inner "dh" transforms with, they can share almost all of their
"dh"-wrapping template implementation code.

Introduce this common code to dh_generic. The actual dump of the RFC 7919
safe-prime constants will be deferred to the next patch in order to
facilitate review. The ephemeral key generation primitive mentioned above
likewise deserves a patch on its own, as does the mechanism by which
unapproved groups are rendered unusable in FIPS mode.

Define a struct dh_safe_prime container for specifying the individual
templates' associated safe-prime group constants. All ffdheXYZ(dh) template
instances will store a pointer to such a dh_safe_prime in their context
areas each. Implement the common __dh_safe_prime_create() template
instantiation helper. The intention is that the individual ffdheXYZ(dh)
crypto_templates' ->create() implementations will simply forward any calls
to __dh_safe_prime_create(), passing a suitable dh_safe_prime in addition
to the received ->create() arguments. __dh_safe_prime_create() would then
create and register a kpp_instance as appropriate, storing the given
dh_safe_prime pointer alongside a crypto_kpp_spawn for the inner "dh"
kpp_alg in the context area.

As the ffdheXYZ(dh) kpp_instances are supposed to act as proxies to the
inner "dh" kpp_alg, make each of their associated crypto_kpp transforms to
in turn own an inner "dh" transform, a pointer to which gets stored in the
context area. Setup and teardown are getting handled from the outer
->init_tfm() and ->exit_tfm() respectively.

In order to achieve the overall goal and let the ffdheXYZ(dh) kpp_instances
configure the inner "dh" transforms with the respective group parameters,
make their common ->set_secret(), the new dh_safe_prime_set_secret(), fill
in the P and G values before forwarding the call to the inner "dh"'s
->set_secret(). Note that the outer ->set_secret() can obtain the P value
associated with the given ffdheXYZ(dh) kpp_instance by means of the
dh_safe_prime referenced from the latter's context. The value of G OTOH
always equals constant 2 for the safe-prime groups.

Finally, make the remaining two kpp_alg primitives both operating on
kpp_requests, i.e. ->generate_public_key() and ->compute_shared_secret(),
to merely forward any request to the inner "dh" implementation. However, a
kpp_request instance received from the outside cannot get simply passed
on as-is, because its associated transform (crypto_kpp_reqtfm()) will have
been set to the outer ffdheXYZ(dh) one. In order to handle this, reserve
some space in the outer ffdheXYZ(dh) kpp_requests' context areas for in
turn storing an inner kpp_request suitable for "dh" each. Make the outer
->generate_public_key() and ->compute_shared_secret() respectively to setup
this inner kpp_request by means of the new dh_safe_prime_prepare_dh_req()
helper before handing it over to the "dh" implementation for further
processing. dh_safe_prime_prepare_dh_req() basically copies the outer
kpp_request received from the outside over to the inner one, but installs
the inner transform and its own ->complete() proxy callback therein. This
completion callback, the new dh_safe_prime_complete_req(), doesn't do
anything beyond completing the outer request. Note that there exist some
examples in crypto/, which would simply install the completion handler
from the outer request at the inner one in similar setups, e.g. seqiv.
However, this would mean that the user-provided completion handler won't
get called with the address of the outer kpp_request initially submitted
and the handler might not be prepared for this. Users could certainly work
around this by setting the callback ->data properly, but IMO it's cleaner
this way. Furthermore, it might make sense to extend
dh_safe_prime_complete_req() in the future and move e.g. those
post-computation FIPS checks from the generic "dh" implementation to the
ffdheXYZ(dh) templates.

[1] https://lore.kernel.org/r/20211202152358.60116-1-hare@suse.de
[2] https://lore.kernel.org/r/20211217055227.GA20698@gondor.apana.org.au

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/crypto/dh.c b/crypto/dh.c
index abc2a72c8271..08fb7610fe2a 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -257,6 +257,214 @@ static struct kpp_alg dh = {
 	},
 };
 
+
+struct dh_safe_prime {
+	unsigned int max_strength;
+	unsigned int p_size;
+	const char *p;
+};
+
+static const char safe_prime_g[]  = { 2 };
+
+struct dh_safe_prime_instance_ctx {
+	struct crypto_kpp_spawn dh_spawn;
+	const struct dh_safe_prime *safe_prime;
+};
+
+struct dh_safe_prime_tfm_ctx {
+	struct crypto_kpp *dh_tfm;
+};
+
+static void dh_safe_prime_free_instance(struct kpp_instance *inst)
+{
+	struct dh_safe_prime_instance_ctx *ctx = kpp_instance_ctx(inst);
+
+	crypto_drop_kpp(&ctx->dh_spawn);
+	kfree(inst);
+}
+
+static inline struct dh_safe_prime_instance_ctx *dh_safe_prime_instance_ctx(
+	struct crypto_kpp *tfm)
+{
+	return kpp_instance_ctx(kpp_alg_instance(tfm));
+}
+
+static inline struct kpp_alg *dh_safe_prime_dh_alg(
+	struct dh_safe_prime_tfm_ctx *ctx)
+{
+	return crypto_kpp_alg(ctx->dh_tfm);
+}
+
+static int dh_safe_prime_init_tfm(struct crypto_kpp *tfm)
+{
+	struct dh_safe_prime_instance_ctx *inst_ctx =
+		dh_safe_prime_instance_ctx(tfm);
+	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
+
+	tfm_ctx->dh_tfm = crypto_spawn_kpp(&inst_ctx->dh_spawn);
+	if (IS_ERR(tfm_ctx->dh_tfm))
+		return PTR_ERR(tfm_ctx->dh_tfm);
+
+	return 0;
+}
+
+static void dh_safe_prime_exit_tfm(struct crypto_kpp *tfm)
+{
+	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
+
+	crypto_free_kpp(tfm_ctx->dh_tfm);
+}
+
+static int dh_safe_prime_set_secret(struct crypto_kpp *tfm, const void *buffer,
+				    unsigned int len)
+{
+	struct dh_safe_prime_instance_ctx *inst_ctx =
+		dh_safe_prime_instance_ctx(tfm);
+	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
+	struct dh params;
+	void *buf;
+	unsigned int buf_size;
+	int err;
+
+	err = __crypto_dh_decode_key(buffer, len, &params);
+	if (err)
+		return err;
+
+	if (params.p_size || params.g_size)
+		return -EINVAL;
+
+	params.p = inst_ctx->safe_prime->p;
+	params.p_size = inst_ctx->safe_prime->p_size;
+	params.g = safe_prime_g;
+	params.g_size = sizeof(safe_prime_g);
+
+	buf_size = crypto_dh_key_len(&params);
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	err = crypto_dh_encode_key(buf, buf_size, &params);
+	if (err)
+		goto out;
+
+	err = crypto_kpp_set_secret(tfm_ctx->dh_tfm, buf, buf_size);
+out:
+	kfree_sensitive(buf);
+	return err;
+}
+
+static void dh_safe_prime_complete_req(struct crypto_async_request *dh_req,
+				       int err)
+{
+	struct kpp_request *req = dh_req->data;
+
+	kpp_request_complete(req, err);
+}
+
+static struct kpp_request *dh_safe_prime_prepare_dh_req(struct kpp_request *req)
+{
+	struct dh_safe_prime_tfm_ctx *tfm_ctx =
+		kpp_tfm_ctx(crypto_kpp_reqtfm(req));
+	struct kpp_request *dh_req = kpp_request_ctx(req);
+
+	kpp_request_set_tfm(dh_req, tfm_ctx->dh_tfm);
+	kpp_request_set_callback(dh_req, req->base.flags,
+				 dh_safe_prime_complete_req, req);
+
+	kpp_request_set_input(dh_req, req->src, req->src_len);
+	kpp_request_set_output(dh_req, req->dst, req->dst_len);
+
+	return dh_req;
+}
+
+static int dh_safe_prime_generate_public_key(struct kpp_request *req)
+{
+	struct kpp_request *dh_req = dh_safe_prime_prepare_dh_req(req);
+
+	return crypto_kpp_generate_public_key(dh_req);
+}
+
+static int dh_safe_prime_compute_shared_secret(struct kpp_request *req)
+{
+	struct kpp_request *dh_req = dh_safe_prime_prepare_dh_req(req);
+
+	return crypto_kpp_compute_shared_secret(dh_req);
+}
+
+static unsigned int dh_safe_prime_max_size(struct crypto_kpp *tfm)
+{
+	struct dh_safe_prime_tfm_ctx *tfm_ctx = kpp_tfm_ctx(tfm);
+
+	return crypto_kpp_maxsize(tfm_ctx->dh_tfm);
+}
+
+static int __maybe_unused __dh_safe_prime_create(
+	struct crypto_template *tmpl, struct rtattr **tb,
+	const struct dh_safe_prime *safe_prime)
+{
+	struct kpp_instance *inst;
+	struct dh_safe_prime_instance_ctx *ctx;
+	const char *dh_name;
+	struct kpp_alg *dh_alg;
+	u32 mask;
+	int err;
+
+	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_KPP, &mask);
+	if (err)
+		return err;
+
+	dh_name = crypto_attr_alg_name(tb[1]);
+	if (IS_ERR(dh_name))
+		return PTR_ERR(dh_name);
+
+	inst = kzalloc(sizeof(*inst) + sizeof(*ctx), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	ctx = kpp_instance_ctx(inst);
+
+	err = crypto_grab_kpp(&ctx->dh_spawn, kpp_crypto_instance(inst),
+			      dh_name, 0, mask);
+	if (err)
+		goto err_free_inst;
+
+	err = -EINVAL;
+	dh_alg = crypto_spawn_kpp_alg(&ctx->dh_spawn);
+	if (strcmp(dh_alg->base.cra_name, "dh"))
+		goto err_free_inst;
+
+	ctx->safe_prime = safe_prime;
+
+	err = crypto_inst_setname(kpp_crypto_instance(inst),
+				  tmpl->name, &dh_alg->base);
+	if (err)
+		goto err_free_inst;
+
+	inst->alg.set_secret = dh_safe_prime_set_secret;
+	inst->alg.generate_public_key = dh_safe_prime_generate_public_key;
+	inst->alg.compute_shared_secret = dh_safe_prime_compute_shared_secret;
+	inst->alg.max_size = dh_safe_prime_max_size;
+	inst->alg.init = dh_safe_prime_init_tfm;
+	inst->alg.exit = dh_safe_prime_exit_tfm;
+	inst->alg.reqsize = sizeof(struct kpp_request) + dh_alg->reqsize;
+	inst->alg.base.cra_priority = dh_alg->base.cra_priority;
+	inst->alg.base.cra_module = THIS_MODULE;
+	inst->alg.base.cra_ctxsize = sizeof(struct dh_safe_prime_tfm_ctx);
+
+	inst->free = dh_safe_prime_free_instance;
+
+	err = kpp_register_instance(tmpl, inst);
+	if (err)
+		goto err_free_inst;
+
+	return 0;
+
+err_free_inst:
+	dh_safe_prime_free_instance(inst);
+
+	return err;
+}
+
 static int dh_init(void)
 {
 	return crypto_register_kpp(&dh);
-- 
2.26.2

