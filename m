Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0A54F33B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380458AbiFQImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346467AbiFQImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:42:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654DB52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:42:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z17so1956390wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRsPQ6YoMUXlXTGW3E7PNDzDgKHjtkMAZVeJ0/9gCRw=;
        b=Gm2bHtLAwX54QRAH31/ufashV/+sBOx1MQAA71CdXgTPuuPQwlke2QKfJZ96i8DU1F
         naWItmvKRIM+13tl9Nofq26raXvmr9xice+7bkZ6j4wQez99Q0SHIyCaazKYHHsnmjAI
         uYbAE1HoldiK5ym6jssqTsG2Wh1PgnS3JtpwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRsPQ6YoMUXlXTGW3E7PNDzDgKHjtkMAZVeJ0/9gCRw=;
        b=F4ZYM659TceYPaVQQEDk8XxilAZNO+CaMHrWR+tUJN1WUVEus9AKRyR/674ogjS5zq
         7P4gyygTaw7yMxi2v/HLfFcgmVAyyS7KTJ8AX1qS+QW54j+BssBmKRXX3ayFh49LiOIk
         5X2NK2C68JOvNJxLWciDRYvhnsxIedHIT2VQAZCPWXVrlDovCVokYsWJ8mlwkdYh/noW
         /3dI7jAQbkLaN93xlYxi6xUA/IXa+6r+Vt5FG5OSIr3eKrWNr5Gsfc/aYGdak7t3sqP+
         XdMdK9LaYoAyd3bYaUfpU5Ghaq5tg3oXhDEJyYJymdO+uHoDeA9OoyATPFsnmXQ4sNd0
         dkSw==
X-Gm-Message-State: AOAM533qHNur1p1QNBIvOgAzsZShcNPsn3veJAAn47xClUjsa8YmAkyM
        hz5IDH5lau1Mpxd4RDfD57uAMA==
X-Google-Smtp-Source: ABdhPJzjTrmueZq1O6auy5IcvMcZibvFqvQMYVLu8c6zOgU6VLkJu/tp0yIXVFS+vHx5u1nfWXgUPw==
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr19519376wms.3.1655455352975;
        Fri, 17 Jun 2022 01:42:32 -0700 (PDT)
Received: from localhost.localdomain ([90.195.227.41])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003974860e15esm9991953wmq.40.2022.06.17.01.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 01:42:32 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] crypto: rsa - implement Chinese Remainder Theorem for faster private key operations
Date:   Fri, 17 Jun 2022 09:42:10 +0100
Message-Id: <20220617084210.907-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  * exported mpi_sub and mpi_mul, otherwise the build fails when RSA is a module

The kernel RSA ASN.1 private key parser already supports only private keys with
additional values to be used with the Chinese Remainder Theorem [1], but these
values are currently not used.

This rudimentary CRT implementation speeds up RSA private key operations for the
following Go benchmark up to ~3x.

This implementation also tries to minimise the allocation of additional MPIs,
so existing MPIs are reused as much as possible (hence the variable names are a
bit weird).

The benchmark used:

```
package keyring_test

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"io"
	"syscall"
	"testing"
	"unsafe"
)

type KeySerial int32
type Keyring int32

const (
	KEY_SPEC_PROCESS_KEYRING Keyring = -2
	KEYCTL_PKEY_SIGN                 = 27
)

var (
	keyTypeAsym = []byte("asymmetric\x00")
	sha256pkcs1 = []byte("enc=pkcs1 hash=sha256\x00")
)

func (keyring Keyring) LoadAsym(desc string, payload []byte) (KeySerial, error) {
	cdesc := []byte(desc + "\x00")
	serial, _, errno := syscall.Syscall6(syscall.SYS_ADD_KEY, uintptr(unsafe.Pointer(&keyTypeAsym[0])), uintptr(unsafe.Pointer(&cdesc[0])), uintptr(unsafe.Pointer(&payload[0])), uintptr(len(payload)), uintptr(keyring), uintptr(0))
	if errno == 0 {
		return KeySerial(serial), nil
	}

	return KeySerial(serial), errno
}

type pkeyParams struct {
	key_id         KeySerial
	in_len         uint32
	out_or_in2_len uint32
	__spare        [7]uint32
}

// the output signature buffer is an input parameter here, because we want to
// avoid Go buffer allocation leaking into our benchmarks
func (key KeySerial) Sign(info, digest, out []byte) error {
	var params pkeyParams
	params.key_id = key
	params.in_len = uint32(len(digest))
	params.out_or_in2_len = uint32(len(out))

	_, _, errno := syscall.Syscall6(syscall.SYS_KEYCTL, KEYCTL_PKEY_SIGN, uintptr(unsafe.Pointer(&params)), uintptr(unsafe.Pointer(&info[0])), uintptr(unsafe.Pointer(&digest[0])), uintptr(unsafe.Pointer(&out[0])), uintptr(0))
	if errno == 0 {
		return nil
	}

	return errno
}

func BenchmarkSign(b *testing.B) {
	priv, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		b.Fatalf("failed to generate private key: %v", err)
	}

	pkcs8, err := x509.MarshalPKCS8PrivateKey(priv)
	if err != nil {
		b.Fatalf("failed to serialize the private key to PKCS8 blob: %v", err)
	}

	serial, err := KEY_SPEC_PROCESS_KEYRING.LoadAsym("test rsa key", pkcs8)
	if err != nil {
		b.Fatalf("failed to load the private key into the keyring: %v", err)
	}

	b.Logf("loaded test rsa key: %v", serial)

	digest := make([]byte, 32)
	_, err = io.ReadFull(rand.Reader, digest)
	if err != nil {
		b.Fatalf("failed to generate a random digest: %v", err)
	}

	sig := make([]byte, 256)
	for n := 0; n < b.N; n++ {
		err = serial.Sign(sha256pkcs1, digest, sig)
		if err != nil {
			b.Fatalf("failed to sign the digest: %v", err)
		}
	}

	err = rsa.VerifyPKCS1v15(&priv.PublicKey, crypto.SHA256, digest, sig)
	if err != nil {
		b.Fatalf("failed to verify the signature: %v", err)
	}
}
```

[1]: https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Using_the_Chinese_remainder_algorithm

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 crypto/rsa.c      | 78 ++++++++++++++++++++++++++++++++++++++++++++---
 lib/mpi/mpi-add.c |  2 +-
 lib/mpi/mpi-mul.c |  1 +
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/crypto/rsa.c b/crypto/rsa.c
index 39e04176b04b..0e555ee4addb 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -17,6 +17,11 @@ struct rsa_mpi_key {
 	MPI n;
 	MPI e;
 	MPI d;
+	MPI p;
+	MPI q;
+	MPI dp;
+	MPI dq;
+	MPI qinv;
 };

 /*
@@ -35,16 +40,49 @@ static int _rsa_enc(const struct rsa_mpi_key *key, MPI c, MPI m)

 /*
  * RSADP function [RFC3447 sec 5.1.2]
- * m = c^d mod n;
+ * m_1 = c^dP mod p;
+ * m_2 = c^dQ mod q;
+ * h = (m_1 - m_2) * qInv mod p;
+ * m = m_2 + q * h;
  */
-static int _rsa_dec(const struct rsa_mpi_key *key, MPI m, MPI c)
+static int _rsa_dec_crt(const struct rsa_mpi_key *key, MPI m_or_m1_or_h, MPI c)
 {
+	MPI m2, m12_or_qh;
+	int ret = -ENOMEM;
+
 	/* (1) Validate 0 <= c < n */
 	if (mpi_cmp_ui(c, 0) < 0 || mpi_cmp(c, key->n) >= 0)
 		return -EINVAL;

-	/* (2) m = c^d mod n */
-	return mpi_powm(m, c, key->d, key->n);
+	m2 = mpi_alloc(0);
+	m12_or_qh = mpi_alloc(0);
+	if (!m2 || !m12_or_qh)
+		goto err_free_mpi;
+
+	/* (2i) m_1 = c^dP mod p */
+	ret = mpi_powm(m_or_m1_or_h, c, key->dp, key->p);
+	if (ret)
+		goto err_free_mpi;
+
+	/* (2i) m_2 = c^dQ mod q */
+	ret = mpi_powm(m2, c, key->dq, key->q);
+	if (ret)
+		goto err_free_mpi;
+
+	/* (2iii) h = (m_1 - m_2) * qInv mod p */
+	mpi_sub(m12_or_qh, m_or_m1_or_h, m2);
+	mpi_mulm(m_or_m1_or_h, m12_or_qh, key->qinv, key->p);
+
+	/* (2iv) m = m_2 + q * h */
+	mpi_mul(m12_or_qh, key->q, m_or_m1_or_h);
+	mpi_addm(m_or_m1_or_h, m2, m12_or_qh, key->n);
+
+	ret = 0;
+
+err_free_mpi:
+	mpi_free(m12_or_qh);
+	mpi_free(m2);
+	return ret;
 }

 static inline struct rsa_mpi_key *rsa_get_key(struct crypto_akcipher *tfm)
@@ -112,7 +150,7 @@ static int rsa_dec(struct akcipher_request *req)
 	if (!c)
 		goto err_free_m;

-	ret = _rsa_dec(pkey, m, c);
+	ret = _rsa_dec_crt(pkey, m, c);
 	if (ret)
 		goto err_free_c;

@@ -134,9 +172,19 @@ static void rsa_free_mpi_key(struct rsa_mpi_key *key)
 	mpi_free(key->d);
 	mpi_free(key->e);
 	mpi_free(key->n);
+	mpi_free(key->p);
+	mpi_free(key->q);
+	mpi_free(key->dp);
+	mpi_free(key->dq);
+	mpi_free(key->qinv);
 	key->d = NULL;
 	key->e = NULL;
 	key->n = NULL;
+	key->p = NULL;
+	key->q = NULL;
+	key->dp = NULL;
+	key->dq = NULL;
+	key->qinv = NULL;
 }

 static int rsa_check_key_length(unsigned int len)
@@ -217,6 +265,26 @@ static int rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 	if (!mpi_key->n)
 		goto err;

+	mpi_key->p = mpi_read_raw_data(raw_key.p, raw_key.p_sz);
+	if (!mpi_key->p)
+		goto err;
+
+	mpi_key->q = mpi_read_raw_data(raw_key.q, raw_key.q_sz);
+	if (!mpi_key->q)
+		goto err;
+
+	mpi_key->dp = mpi_read_raw_data(raw_key.dp, raw_key.dp_sz);
+	if (!mpi_key->dp)
+		goto err;
+
+	mpi_key->dq = mpi_read_raw_data(raw_key.dq, raw_key.dq_sz);
+	if (!mpi_key->dq)
+		goto err;
+
+	mpi_key->qinv = mpi_read_raw_data(raw_key.qinv, raw_key.qinv_sz);
+	if (!mpi_key->qinv)
+		goto err;
+
 	if (rsa_check_key_length(mpi_get_size(mpi_key->n) << 3)) {
 		rsa_free_mpi_key(mpi_key);
 		return -EINVAL;
diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
index 2cdae54c1bd0..9056fc5167fc 100644
--- a/lib/mpi/mpi-add.c
+++ b/lib/mpi/mpi-add.c
@@ -138,7 +138,7 @@ void mpi_sub(MPI w, MPI u, MPI v)
 	mpi_add(w, u, vv);
 	mpi_free(vv);
 }
-
+EXPORT_SYMBOL_GPL(mpi_sub);

 void mpi_addm(MPI w, MPI u, MPI v, MPI m)
 {
diff --git a/lib/mpi/mpi-mul.c b/lib/mpi/mpi-mul.c
index 8f5fa200f297..7f4eda8560dc 100644
--- a/lib/mpi/mpi-mul.c
+++ b/lib/mpi/mpi-mul.c
@@ -82,6 +82,7 @@ void mpi_mul(MPI w, MPI u, MPI v)
 	if (tmp_limb)
 		mpi_free_limb_space(tmp_limb);
 }
+EXPORT_SYMBOL_GPL(mpi_mul);

 void mpi_mulm(MPI w, MPI u, MPI v, MPI m)
 {
--
2.36.1

