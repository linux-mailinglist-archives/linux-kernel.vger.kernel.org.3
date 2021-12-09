Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A419C46E4DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhLIJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35382 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhLIJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:07:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5881FD50;
        Thu,  9 Dec 2021 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/WgwVJ3MjLJcDaKptkoLcGHGElh/ysgF1bUl47RBDs=;
        b=pt97+5DqihBxf1pOLXfJZj00IzNq3mGDPEo7fNlMuFuEviwsipMjyamOBDlEVyOgFoe4qS
        z/kvMlJCLPdk4Zo4Eifk3WXUnewYTvaSR3yAr0Q2OBo2SYMEJ4TaiT/g6D6ZEjYiBpv60m
        YMYF0sapq+YsIAwHN8Is7UAMMj17B/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040660;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/WgwVJ3MjLJcDaKptkoLcGHGElh/ysgF1bUl47RBDs=;
        b=ejvBqoOPjA7pcv19Jzx8Mp4LRX5tF41OzN37ejzVuYze/o5Bz3KQpvNLGJDjBArCh6EnLJ
        l9UCC0xKS0jd6IBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57AE113A86;
        Thu,  9 Dec 2021 09:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tFOxE5TGsWGRaQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:20 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH v2 03/18] crypto: dh - optimize domain parameter serialization for well-known groups
Date:   Thu,  9 Dec 2021 10:03:43 +0100
Message-Id: <20211209090358.28231-4-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DH users are supposed to set a struct dh instance's ->p and ->g domain
parameters (as well as the secret ->key), serialize the whole struct dh
instance via the crypto_dh_encode_key() helper and pass the encoded blob
on to the DH's ->set_secret(). All three currently available DH
implementations (generic, drivers/crypto/hisilicon/hpre/ and
drivers/crypto/qat/) would then proceed to call the crypto_dh_decode_key()
helper for unwrapping the encoded struct dh instance again.

Up to now, the only DH user has been the keyctl(KEYCTL_DH_COMPUTE) syscall
and thus, all domain parameters have been coming from userspace. The domain
parameter encoding scheme for DH's ->set_secret() has been a perfectly
reasonable approach in this setting and the potential extra copy of ->p
and ->g during the encoding phase didn't harm much.

However, recently, the need for working with the well-known safe-prime
groups' domain parameters from RFC 3526 and RFC 7919 resp. arose from two
independent developments:
- The NVME in-band authentication support currently being worked on ([1])
  needs to install the RFC 7919 ffdhe groups' domain parameters for DH
  tfms.
- In FIPS mode, there's effectively no sensible way for the DH
  implementation to conform to SP800-56Arev3 other than rejecting any
  parameter set not corresponding to some approved safe-prime group
  specified in either of these two RFCs.

As the ->p arrays' lengths are in the range from 256 to 1024 bytes, it
would be nice if that extra copy during the crypto_dh_encode_key() step
from the NVME in-band authentication code could be avoided. Likewise, it
would be great if the DH implementation's FIPS handling code could avoid
attempting to match the input ->p and ->g against the individual approved
groups' parameters via memcmp() if it's known in advance that the input
corresponds to such one, as is the case for NVME.

Introduce a enum dh_group_id for referring to any of the safe-prime groups
known to the kernel. The introduction of actual such safe-prime groups
alongside with their resp. P and G parameters will be deferred to later
patches. As of now, the new enum contains only a single member,
DH_GROUP_ID_UNKNOWN, which is meant to be associated with parameter sets
not corresponding to any of the groups known to the kernel, as is needed
to continue to support the current keyctl(KEYCTL_DH_COMPUTE) syscall
semantics.

Add a new 'group_id' member of type enum group_id to struct dh. Make
crypto_dh_encode_key() include it in the serialization and to encode
->p and ->g only if it equals DH_GROUP_ID_UNKNOWN. For all other possible
values of the encoded ->group_id, the receiving decoding primitive,
crypto_dh_decode_key(), is made to not decode ->p and ->g from the encoded
data, but to look them up in a central registry instead.

The intended usage pattern is that users like NVME wouldn't set any of
the struct dh's ->p or ->g directly, but only the ->group_id for the group
they're interested in. They'd then proceed as usual and call
crypto_dh_encode_key() on the struct dh instance, pass the encoded result
on to DH's ->set_secret() and the latter would then invoke
crypto_dh_decode_key(), which would then in turn lookup the parameters
associated with the passed ->group_id.

Note that this will avoid the extra copy of the ->p and ->g for the groups
(to be made) known to the kernel and also, that a future patch can easily
introduce a validation of ->group_id if in FIPS mode.

As mentioned above, the introduction of actual safe-prime groups will be
deferred to later patches, so for now, only introduce an empty placeholder
array safe_prime_groups[] to be queried by crypto_dh_decode_key() for
domain parameters associated with a given ->group_id as outlined above.
Make its elements to be of the new internal struct safe_prime_group type.
Among the members ->group_id, ->p and ->p_size with obvious meaning, there
will also be a ->max_strength member for storing the maximum security
strength supported by the associated group -- its value will be needed for
the upcoming private key generation support.

Finally, update the encoded secrets provided by the testmgr's DH test
vectors in order to account for the additional ->group_id field expected
by crypto_dh_decode_key() now.

[1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/dh_helper.c  | 90 ++++++++++++++++++++++++++++++++++++---------
 crypto/testmgr.h    | 16 +++++---
 include/crypto/dh.h |  6 +++
 3 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index aabc91e4f63f..9f21204e5dee 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -10,7 +10,31 @@
 #include <crypto/dh.h>
 #include <crypto/kpp.h>
 
-#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 3 * sizeof(int))
+#define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 4 * sizeof(int))
+
+static const struct safe_prime_group
+{
+	enum dh_group_id group_id;
+	unsigned int max_strength;
+	unsigned int p_size;
+	const char *p;
+} safe_prime_groups[] = {};
+
+/* 2 is used as a generator for all safe-prime groups. */
+static const char safe_prime_group_g[]  = { 2 };
+
+static inline const struct safe_prime_group *
+get_safe_prime_group(enum dh_group_id group_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(safe_prime_groups); ++i) {
+		if (safe_prime_groups[i].group_id == group_id)
+			return &safe_prime_groups[i];
+	}
+
+	return NULL;
+}
 
 static inline u8 *dh_pack_data(u8 *dst, u8 *end, const void *src, size_t size)
 {
@@ -28,7 +52,10 @@ static inline const u8 *dh_unpack_data(void *dst, const void *src, size_t size)
 
 static inline unsigned int dh_data_size(const struct dh *p)
 {
-	return p->key_size + p->p_size + p->g_size;
+	if (p->group_id == DH_GROUP_ID_UNKNOWN)
+		return p->key_size + p->p_size + p->g_size;
+	else
+		return p->key_size;
 }
 
 unsigned int crypto_dh_key_len(const struct dh *p)
@@ -45,18 +72,24 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params)
 		.type = CRYPTO_KPP_SECRET_TYPE_DH,
 		.len = len
 	};
+	int group_id;
 
 	if (unlikely(!len))
 		return -EINVAL;
 
 	ptr = dh_pack_data(ptr, end, &secret, sizeof(secret));
+	group_id = (int)params->group_id;
+	ptr = dh_pack_data(ptr, end, &group_id, sizeof(group_id));
 	ptr = dh_pack_data(ptr, end, &params->key_size,
 			   sizeof(params->key_size));
 	ptr = dh_pack_data(ptr, end, &params->p_size, sizeof(params->p_size));
 	ptr = dh_pack_data(ptr, end, &params->g_size, sizeof(params->g_size));
 	ptr = dh_pack_data(ptr, end, params->key, params->key_size);
-	ptr = dh_pack_data(ptr, end, params->p, params->p_size);
-	ptr = dh_pack_data(ptr, end, params->g, params->g_size);
+	if (params->group_id == DH_GROUP_ID_UNKNOWN) {
+		ptr = dh_pack_data(ptr, end, params->p, params->p_size);
+		ptr = dh_pack_data(ptr, end, params->g, params->g_size);
+	}
+
 	if (ptr != end)
 		return -EINVAL;
 	return 0;
@@ -67,6 +100,7 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 {
 	const u8 *ptr = buf;
 	struct kpp_secret secret;
+	int group_id;
 
 	if (unlikely(!buf || len < DH_KPP_SECRET_MIN_SIZE))
 		return -EINVAL;
@@ -75,12 +109,46 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	if (secret.type != CRYPTO_KPP_SECRET_TYPE_DH)
 		return -EINVAL;
 
+	ptr = dh_unpack_data(&group_id, ptr, sizeof(group_id));
+	params->group_id = (enum dh_group_id)group_id;
 	ptr = dh_unpack_data(&params->key_size, ptr, sizeof(params->key_size));
 	ptr = dh_unpack_data(&params->p_size, ptr, sizeof(params->p_size));
 	ptr = dh_unpack_data(&params->g_size, ptr, sizeof(params->g_size));
 	if (secret.len != crypto_dh_key_len(params))
 		return -EINVAL;
 
+	if (params->group_id == DH_GROUP_ID_UNKNOWN) {
+		/* Don't allocate memory. Set pointers to data within
+		 * the given buffer
+		 */
+		params->key = (void *)ptr;
+		params->p = (void *)(ptr + params->key_size);
+		params->g = (void *)(ptr + params->key_size + params->p_size);
+
+		/*
+		 * Don't permit 'p' to be 0.  It's not a prime number,
+		 * and it's subject to corner cases such as 'mod 0'
+		 * being undefined or crypto_kpp_maxsize() returning
+		 * 0.
+		 */
+		if (memchr_inv(params->p, 0, params->p_size) == NULL)
+			return -EINVAL;
+
+	} else {
+		const struct safe_prime_group *g;
+
+		g = get_safe_prime_group(params->group_id);
+		if (!g)
+			return -EINVAL;
+
+		params->key = (void *)ptr;
+
+		params->p = g->p;
+		params->p_size = g->p_size;
+		params->g = safe_prime_group_g;
+		params->g_size = sizeof(safe_prime_group_g);
+	}
+
 	/*
 	 * Don't permit the buffer for 'key' or 'g' to be larger than 'p', since
 	 * some drivers assume otherwise.
@@ -89,20 +157,6 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	    params->g_size > params->p_size)
 		return -EINVAL;
 
-	/* Don't allocate memory. Set pointers to data within
-	 * the given buffer
-	 */
-	params->key = (void *)ptr;
-	params->p = (void *)(ptr + params->key_size);
-	params->g = (void *)(ptr + params->key_size + params->p_size);
-
-	/*
-	 * Don't permit 'p' to be 0.  It's not a prime number, and it's subject
-	 * to corner cases such as 'mod 0' being undefined or
-	 * crypto_kpp_maxsize() returning 0.
-	 */
-	if (memchr_inv(params->p, 0, params->p_size) == NULL)
-		return -EINVAL;
 
 	return 0;
 }
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 7f7d5ae48721..637913064c64 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1244,13 +1244,15 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.secret =
 #ifdef __LITTLE_ENDIAN
 	"\x01\x00" /* type */
-	"\x11\x02" /* len */
+	"\x15\x02" /* len */
+	"\x00\x00\x00\x00" /* group_id == DH_GROUP_ID_UNKNOWN */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
-	"\x02\x11" /* len */
+	"\x02\x15" /* len */
+	"\x00\x00\x00\x00" /* group_id == DH_GROUP_ID_UNKNOWN */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
 	"\x00\x00\x00\x01" /* g_size */
@@ -1342,7 +1344,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\xd3\x34\x49\xad\x64\xa6\xb1\xc0\x59\x28\x75\x60\xa7\x8a\xb0\x11"
 	"\x56\x89\x42\x74\x11\xf5\xf6\x5e\x6f\x16\x54\x6a\xb1\x76\x4d\x50"
 	"\x8a\x68\xc1\x5b\x82\xb9\x0d\x00\x32\x50\xed\x88\x87\x48\x92\x17",
-	.secret_size = 529,
+	.secret_size = 533,
 	.b_public_size = 256,
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
@@ -1351,13 +1353,15 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.secret =
 #ifdef __LITTLE_ENDIAN
 	"\x01\x00" /* type */
-	"\x11\x02" /* len */
+	"\x15\x02" /* len */
+	"\x00\x00\x00\x00" /* group_id == DH_GROUP_ID_UNKNOWN */
 	"\x00\x01\x00\x00" /* key_size */
 	"\x00\x01\x00\x00" /* p_size */
 	"\x01\x00\x00\x00" /* g_size */
 #else
 	"\x00\x01" /* type */
-	"\x02\x11" /* len */
+	"\x02\x15" /* len */
+	"\x00\x00\x00\x00" /* group_id == DH_GROUP_ID_UNKNOWN */
 	"\x00\x00\x01\x00" /* key_size */
 	"\x00\x00\x01\x00" /* p_size */
 	"\x00\x00\x00\x01" /* g_size */
@@ -1449,7 +1453,7 @@ static const struct kpp_testvec dh_tv_template[] = {
 	"\x5e\x5a\x64\xbd\xf6\x85\x04\xe8\x28\x6a\xac\xef\xce\x19\x8e\x9a"
 	"\xfe\x75\xc0\x27\x69\xe3\xb3\x7b\x21\xa7\xb1\x16\xa4\x85\x23\xee"
 	"\xb0\x1b\x04\x6e\xbd\xab\x16\xde\xfd\x86\x6b\xa9\x95\xd7\x0b\xfd",
-	.secret_size = 529,
+	.secret_size = 533,
 	.b_public_size = 256,
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index 67f3f6bca527..f0ed899e2168 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -19,6 +19,11 @@
  * the KPP API function call of crypto_kpp_set_secret.
  */
 
+/** enum dh_group_id - identify well-known domain parameter sets */
+enum dh_group_id {
+	DH_GROUP_ID_UNKNOWN = 0, /* Constants are used in test vectors. */
+};
+
 /**
  * struct dh - define a DH private key
  *
@@ -30,6 +35,7 @@
  * @g_size:	Size of DH generator G
  */
 struct dh {
+	enum dh_group_id group_id;
 	const void *key;
 	const void *p;
 	const void *g;
-- 
2.26.2

