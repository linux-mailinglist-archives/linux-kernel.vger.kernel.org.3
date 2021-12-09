Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A646E4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhLIJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:08:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhLIJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2F291FD2A;
        Thu,  9 Dec 2021 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639040668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bcDM7eBt0Fg+cJF3hszRX0A6AM//koniIO66rTJXn8=;
        b=SGL2iFzHgINYtS2t1vJOUgJUGOwjNL7g+xjwPR9g+d5XtIPLhhcbG7uC6I4Y4t6DY09tNT
        1ZL9RUeE7wNIgherfX0wcP+bmdw1shUYSX4FfuuHkrEa6P2R5TK3Lxu/x0wyUdzRCHb9Dq
        WxN39o5rSCbAN1BkDF0sibbtiJDQgpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639040668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bcDM7eBt0Fg+cJF3hszRX0A6AM//koniIO66rTJXn8=;
        b=d4ZAP6OcpBK9BBvA7SQ79FeY5dR+vGmBVj9egGh/9V1OEa1BzBPZWLVGD+gchMrSK+wtk9
        wT7aUIjejvimQjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDF1613A86;
        Thu,  9 Dec 2021 09:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BP3INJvGsWG3aQAAMHmgww
        (envelope-from <nstange@suse.de>); Thu, 09 Dec 2021 09:04:27 +0000
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
Subject: [PATCH v2 09/18] crypto: dh - implement private key generation primitive
Date:   Thu,  9 Dec 2021 10:03:49 +0100
Message-Id: <20211209090358.28231-10-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211209090358.28231-1-nstange@suse.de>
References: <20211209090358.28231-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support for NVME in-band authentication currently in the works ([1])
needs to generate ephemeral DH keys.

Implement crypto_dh_gen_privkey() which is intended to be used from
the DH implementations just in analogy to how ecc_gen_privkey() is used
for ECDH.

Make the new crypto_dh_gen_privkey() to follow the approach specified
in SP800-56Arev3, sec. 5.6.1.1.3 ("Key-Pair Generation Using Extra Random
Bits").

SP800-56Arev3 specifies a lower as well as an upper bound on the generated
key's length:
- it must be >= two times the maximum supported security strength of
  the group in question and
- it must be <= the length of the domain parameter Q.
Both of these are available only for the safe-prime groups from
RFC 3526 or RFC 7919, which had been introduced to the kernel with previous
patches: for any safe-prime group Q = (P - 1)/2 by definition and the
individual maximum supported security strength as specified by
SP800-56Arev3 has already been made available alongside the resp. domain
parameters with said previous patches. Restrict crypto_dh_gen_privkey() to
these safe-prime groups, i.e. to those groups with any group_id but
DH_GROUP_ID_UNKNOWN. Make it pick twice the maximum supported strength
rounded up to the next power of two for the output key size. This choice
respects both, the lower and upper bounds given by SP800-90Arev3 for
all safe-prime groups known to the kernel by now and is also in line with
the NVME base spec 2.0, which requires the key size to be >= 256bits.

[1] https://lkml.kernel.org/r/20211122074727.25988-4-hare@suse.de

Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 crypto/Kconfig      |   1 +
 crypto/dh_helper.c  | 128 ++++++++++++++++++++++++++++++++++++++++++++
 include/crypto/dh.h |  22 ++++++++
 3 files changed, 151 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index fcb044bdc90a..578711b02bb3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -228,6 +228,7 @@ menuconfig CRYPTO_DH
 	tristate "Diffie-Hellman algorithm"
 	select CRYPTO_KPP
 	select MPILIB
+	select CRYPTO_RNG_DEFAULT
 	help
 	  Generic implementation of the Diffie-Hellman algorithm.
 
diff --git a/crypto/dh_helper.c b/crypto/dh_helper.c
index 4541a4b1a92f..ec9c4cdf57b2 100644
--- a/crypto/dh_helper.c
+++ b/crypto/dh_helper.c
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <crypto/dh.h>
 #include <crypto/kpp.h>
+#include <crypto/rng.h>
 
 #define DH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + 4 * sizeof(int))
 
@@ -594,3 +595,130 @@ int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_dh_decode_key);
+
+static u64 __add_u64_to_be(__be64 *dst, unsigned int n, u64 val)
+{
+	unsigned int i;
+
+	for (i = n; val && i > 0; --i) {
+		u64 tmp = be64_to_cpu(dst[i - 1]);
+
+		tmp += val;
+		val = tmp >= val ? 0 : 1;
+		dst[i - 1] = cpu_to_be64(tmp);
+	}
+
+	return val;
+}
+
+int crypto_dh_gen_privkey(enum dh_group_id group_id,
+			  char key[CRYPTO_DH_MAX_PRIVKEY_SIZE],
+			  unsigned int *key_size)
+{
+	const struct safe_prime_group *g;
+	unsigned int n, tmp_size;
+	__be64 *tmp;
+	int err;
+	u64 h, o;
+
+	/*
+	 * Generate a private key following NIST SP800-56Ar3,
+	 * sec. 5.6.1.1.1 and 5.6.1.1.3 resp.. This is supported only
+	 * for the (approved) safe-prime groups.
+	 */
+	g = get_safe_prime_group(group_id);
+	if (!g)
+		return -EINVAL;
+
+	/*
+	 * 5.6.1.1.1: choose key length N such that
+	 * 2 * ->max_strength <= N <= log2(q) + 1 = ->p_size * 8 - 1
+	 * with q = (p - 1) / 2 for the safe-prime groups.
+	 * Choose the lower bound's next power of two for N in order to
+	 * avoid excessively large private keys while still
+	 * maintaining some extra reserve beyond the bare minimum in
+	 * most cases. Note that for each entry in safe_prime_groups[],
+	 * the following holds for such N:
+	 * - N >= 256, in particular it is a multiple of 2^6 = 64
+	 *   bits and
+	 * - N < log2(q) + 1, i.e. N respects the upper bound.
+	 */
+	n = roundup_pow_of_two(2 * g->max_strength);
+	WARN_ON_ONCE(n & ((1u << 6) - 1));
+	n >>= 6; /* Convert N into units of u64. */
+
+	/*
+	 * Reserve one extra u64 to hold the extra random bits
+	 * required as per 5.6.1.1.3.
+	 */
+	tmp_size = (n + 1) * sizeof(__be64);
+	tmp = kmalloc(tmp_size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	/*
+	 * 5.6.1.1.3, step 3 (and implicitly step 4): obtain N + 64
+	 * random bits and interpret them as a big endian integer.
+	 */
+	err = -EFAULT;
+	if (crypto_get_default_rng())
+		goto out;
+
+	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)tmp, tmp_size);
+	crypto_put_default_rng();
+	if (err)
+		goto out;
+
+	/*
+	 * 5.6.1.1.3, step 5 is implicit: 2^N < q and thus,
+	 * M = min(2^N, q) = 2^N.
+	 *
+	 * For step 6, calculate
+	 * key = (tmp[] mod (M - 1)) + 1 = (tmp[] mod (2^N - 1)) + 1.
+	 *
+	 * In order to avoid expensive divisions, note that
+	 * 2^N mod (2^N - 1) = 1 and thus, for any integer h,
+	 * 2^N * h mod (2^N - 1) = h mod (2^N - 1) always holds.
+	 * The big endian integer tmp[] composed of n + 1 64bit words
+	 * may be written as tmp[] = h * 2^N + l, with h = tmp[0]
+	 * representing the 64 most significant bits and l
+	 * corresponding to the remaining 2^N bits. With the remark
+	 * from above,
+	 * h * 2^N + l mod (2^N - 1) = l + h mod (2^N - 1).
+	 * As both, l and h are less than 2^N, their sum after
+	 * this first reduction is guaranteed to be <= 2^(N + 1) - 2.
+	 * Or equivalently, that their sum can again be written as
+	 * h' * 2^N + l' with h' now either zero or one and if one,
+	 * then l' <= 2^N - 2. Thus, all bits at positions >= N will
+	 * be zero after a second reduction:
+	 * h' * 2^N + l' mod (2^N - 1) = l' + h' mod (2^N - 1).
+	 * At this point, it is still possible that
+	 * l' + h' = 2^N - 1, i.e. that l' + h' mod (2^N - 1)
+	 * is zero. This condition will be detected below by means of
+	 * the final increment overflowing in this case.
+	 */
+	h = be64_to_cpu(tmp[0]);
+	h = __add_u64_to_be(tmp + 1, n, h);
+	h = __add_u64_to_be(tmp + 1, n, h);
+	WARN_ON_ONCE(h);
+
+	/* Increment to obtain the final result. */
+	o = __add_u64_to_be(tmp + 1, n, 1);
+	/*
+	 * The overflow bit o from the increment is either zero or
+	 * one. If zero, tmp[1:n] holds the final result in big-endian
+	 * order. If one, tmp[1:n] is zero now, but needs to be set to
+	 * one, c.f. above.
+	 */
+	if (o)
+		tmp[n] = cpu_to_be64(1);
+
+	/* n is in units of u64, convert to bytes. */
+	*key_size = n << 3;
+	memcpy(key, &tmp[1], *key_size);
+
+out:
+	kfree_sensitive(tmp);
+	return err;
+}
+EXPORT_SYMBOL_GPL(crypto_dh_gen_privkey);
diff --git a/include/crypto/dh.h b/include/crypto/dh.h
index e238380dee01..b1917cc98867 100644
--- a/include/crypto/dh.h
+++ b/include/crypto/dh.h
@@ -99,4 +99,26 @@ int crypto_dh_encode_key(char *buf, unsigned int len, const struct dh *params);
  */
 int crypto_dh_decode_key(const char *buf, unsigned int len, struct dh *params);
 
+/*
+ * The maximum key length is two times the max. sec. strength of the
+ * safe-prime groups, rounded up to the next power of two.
+ */
+#define CRYPTO_DH_MAX_PRIVKEY_SIZE (512 / 8)
+
+/**
+ * crypto_dh_gen_privkey() - generate a DH private key
+ * @buf:	The DH group to generate a key for
+ * @key:	Buffer provided by the caller to receive the generated
+ *		key
+ * @key_size:	Pointer to an unsigned integer the generated key's length
+ *		will be stored in
+ *
+ * This function is intended to generate an ephemeral DH key.
+ *
+ * Return:	Negative error code on failure, 0 on success
+ */
+int crypto_dh_gen_privkey(enum dh_group_id group_id,
+			  char key[CRYPTO_DH_MAX_PRIVKEY_SIZE],
+			  unsigned int *key_size);
+
 #endif
-- 
2.26.2

