Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D256A99D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiGGR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiGGR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:29:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5780F20F69;
        Thu,  7 Jul 2022 10:29:20 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267HL91M016080;
        Thu, 7 Jul 2022 17:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : reply-to : in-reply-to : references : message-id : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=Z+Q2PypGQY6MUqhxoVTIXtgQJxqTys6a6U0K2xYP5MQ=;
 b=WObE0SnkMmOspVc1dNvhR8fMXl5hCJPlvrUH0szHvY8YJy8NrWidf8RSdC5jJijAIn4P
 cJjBHEA+rox1sKBkt5y5YRDVbA0heZNdg8WXg3R3+p6TVmGO7b+/YtuMfbNyRgmPWAUe
 9LnHWmwOZqtCxylph+ABISkP7m+5JWl8FJW9AddRGQHcM2JS+xb+TnjTJXprwdIp5RkT
 1gupqtMb0mPy9gSKQYt5SodvBAEl7Oc2d4kUcytkHYqH6lV93sZXAxQ4uX/CW1HUYDTA
 p7a4lbSSVycfvzcIdrS+vZE5sLaB+qCmIzGPJlpgg260pIHZQYqib8dYuzwjH0/w0DxQ UQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h63tg053b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 17:29:13 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267HLNEr023688;
        Thu, 7 Jul 2022 17:29:12 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3h4ud1vu7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 17:29:12 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267HTBL813304214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jul 2022 17:29:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B248A124053;
        Thu,  7 Jul 2022 17:29:11 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487B6124052;
        Thu,  7 Jul 2022 17:29:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jul 2022 17:29:11 +0000 (GMT)
Date:   Thu, 07 Jul 2022 19:29:11 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, kernel test robot <lkp@intel.com>,
        egorenar@linux.ibm.com, jchrist@linux.ibm.com
Subject: Re: [PATCH v2] crypto: rsa - implement Chinese Remainder Theorem for
 faster private key operations
Reply-To: freude@linux.ibm.com
In-Reply-To: <20220617084210.907-1-ignat@cloudflare.com>
References: <20220617084210.907-1-ignat@cloudflare.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <87a675dc70199baf013b417c55275ee1@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y83XM2paxD3EP26KwQkXaofmswTLqvN_
X-Proofpoint-ORIG-GUID: Y83XM2paxD3EP26KwQkXaofmswTLqvN_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_13,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 10:42, Ignat Korchagin wrote:
> Changes from v1:
>   * exported mpi_sub and mpi_mul, otherwise the build fails when RSA is 
> a module
> 
> The kernel RSA ASN.1 private key parser already supports only private 
> keys with
> additional values to be used with the Chinese Remainder Theorem [1], 
> but these
> values are currently not used.
> 
> This rudimentary CRT implementation speeds up RSA private key 
> operations for the
> following Go benchmark up to ~3x.
> 
> This implementation also tries to minimise the allocation of additional 
> MPIs,
> so existing MPIs are reused as much as possible (hence the variable 
> names are a
> bit weird).
> 
> The benchmark used:
> 
> ```
> package keyring_test
> 
> import (
> 	"crypto"
> 	"crypto/rand"
> 	"crypto/rsa"
> 	"crypto/x509"
> 	"io"
> 	"syscall"
> 	"testing"
> 	"unsafe"
> )
> 
> type KeySerial int32
> type Keyring int32
> 
> const (
> 	KEY_SPEC_PROCESS_KEYRING Keyring = -2
> 	KEYCTL_PKEY_SIGN                 = 27
> )
> 
> var (
> 	keyTypeAsym = []byte("asymmetric\x00")
> 	sha256pkcs1 = []byte("enc=pkcs1 hash=sha256\x00")
> )
> 
> func (keyring Keyring) LoadAsym(desc string, payload []byte)
> (KeySerial, error) {
> 	cdesc := []byte(desc + "\x00")
> 	serial, _, errno := syscall.Syscall6(syscall.SYS_ADD_KEY,
> uintptr(unsafe.Pointer(&keyTypeAsym[0])),
> uintptr(unsafe.Pointer(&cdesc[0])),
> uintptr(unsafe.Pointer(&payload[0])), uintptr(len(payload)),
> uintptr(keyring), uintptr(0))
> 	if errno == 0 {
> 		return KeySerial(serial), nil
> 	}
> 
> 	return KeySerial(serial), errno
> }
> 
> type pkeyParams struct {
> 	key_id         KeySerial
> 	in_len         uint32
> 	out_or_in2_len uint32
> 	__spare        [7]uint32
> }
> 
> // the output signature buffer is an input parameter here, because we 
> want to
> // avoid Go buffer allocation leaking into our benchmarks
> func (key KeySerial) Sign(info, digest, out []byte) error {
> 	var params pkeyParams
> 	params.key_id = key
> 	params.in_len = uint32(len(digest))
> 	params.out_or_in2_len = uint32(len(out))
> 
> 	_, _, errno := syscall.Syscall6(syscall.SYS_KEYCTL, KEYCTL_PKEY_SIGN,
> uintptr(unsafe.Pointer(&params)), uintptr(unsafe.Pointer(&info[0])),
> uintptr(unsafe.Pointer(&digest[0])), uintptr(unsafe.Pointer(&out[0])),
> uintptr(0))
> 	if errno == 0 {
> 		return nil
> 	}
> 
> 	return errno
> }
> 
> func BenchmarkSign(b *testing.B) {
> 	priv, err := rsa.GenerateKey(rand.Reader, 2048)
> 	if err != nil {
> 		b.Fatalf("failed to generate private key: %v", err)
> 	}
> 
> 	pkcs8, err := x509.MarshalPKCS8PrivateKey(priv)
> 	if err != nil {
> 		b.Fatalf("failed to serialize the private key to PKCS8 blob: %v", 
> err)
> 	}
> 
> 	serial, err := KEY_SPEC_PROCESS_KEYRING.LoadAsym("test rsa key", 
> pkcs8)
> 	if err != nil {
> 		b.Fatalf("failed to load the private key into the keyring: %v", err)
> 	}
> 
> 	b.Logf("loaded test rsa key: %v", serial)
> 
> 	digest := make([]byte, 32)
> 	_, err = io.ReadFull(rand.Reader, digest)
> 	if err != nil {
> 		b.Fatalf("failed to generate a random digest: %v", err)
> 	}
> 
> 	sig := make([]byte, 256)
> 	for n := 0; n < b.N; n++ {
> 		err = serial.Sign(sha256pkcs1, digest, sig)
> 		if err != nil {
> 			b.Fatalf("failed to sign the digest: %v", err)
> 		}
> 	}
> 
> 	err = rsa.VerifyPKCS1v15(&priv.PublicKey, crypto.SHA256, digest, sig)
> 	if err != nil {
> 		b.Fatalf("failed to verify the signature: %v", err)
> 	}
> }
> ```
> 
> [1]:
> https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Using_the_Chinese_remainder_algorithm
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  crypto/rsa.c      | 78 ++++++++++++++++++++++++++++++++++++++++++++---
>  lib/mpi/mpi-add.c |  2 +-
>  lib/mpi/mpi-mul.c |  1 +
>  3 files changed, 75 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/rsa.c b/crypto/rsa.c
> index 39e04176b04b..0e555ee4addb 100644
> --- a/crypto/rsa.c
> +++ b/crypto/rsa.c
> @@ -17,6 +17,11 @@ struct rsa_mpi_key {
>  	MPI n;
>  	MPI e;
>  	MPI d;
> +	MPI p;
> +	MPI q;
> +	MPI dp;
> +	MPI dq;
> +	MPI qinv;
>  };
> 
>  /*
> @@ -35,16 +40,49 @@ static int _rsa_enc(const struct rsa_mpi_key *key,
> MPI c, MPI m)
> 
>  /*
>   * RSADP function [RFC3447 sec 5.1.2]
> - * m = c^d mod n;
> + * m_1 = c^dP mod p;
> + * m_2 = c^dQ mod q;
> + * h = (m_1 - m_2) * qInv mod p;
> + * m = m_2 + q * h;
>   */
> -static int _rsa_dec(const struct rsa_mpi_key *key, MPI m, MPI c)
> +static int _rsa_dec_crt(const struct rsa_mpi_key *key, MPI 
> m_or_m1_or_h, MPI c)
>  {
> +	MPI m2, m12_or_qh;
> +	int ret = -ENOMEM;
> +
>  	/* (1) Validate 0 <= c < n */
>  	if (mpi_cmp_ui(c, 0) < 0 || mpi_cmp(c, key->n) >= 0)
>  		return -EINVAL;
> 
> -	/* (2) m = c^d mod n */
> -	return mpi_powm(m, c, key->d, key->n);
> +	m2 = mpi_alloc(0);
> +	m12_or_qh = mpi_alloc(0);
> +	if (!m2 || !m12_or_qh)
> +		goto err_free_mpi;
> +
> +	/* (2i) m_1 = c^dP mod p */
> +	ret = mpi_powm(m_or_m1_or_h, c, key->dp, key->p);
> +	if (ret)
> +		goto err_free_mpi;
> +
> +	/* (2i) m_2 = c^dQ mod q */
> +	ret = mpi_powm(m2, c, key->dq, key->q);
> +	if (ret)
> +		goto err_free_mpi;
> +
> +	/* (2iii) h = (m_1 - m_2) * qInv mod p */
> +	mpi_sub(m12_or_qh, m_or_m1_or_h, m2);
> +	mpi_mulm(m_or_m1_or_h, m12_or_qh, key->qinv, key->p);
> +
> +	/* (2iv) m = m_2 + q * h */
> +	mpi_mul(m12_or_qh, key->q, m_or_m1_or_h);
> +	mpi_addm(m_or_m1_or_h, m2, m12_or_qh, key->n);
> +
> +	ret = 0;
> +
> +err_free_mpi:
> +	mpi_free(m12_or_qh);
> +	mpi_free(m2);
> +	return ret;
>  }
> 
>  static inline struct rsa_mpi_key *rsa_get_key(struct crypto_akcipher 
> *tfm)
> @@ -112,7 +150,7 @@ static int rsa_dec(struct akcipher_request *req)
>  	if (!c)
>  		goto err_free_m;
> 
> -	ret = _rsa_dec(pkey, m, c);
> +	ret = _rsa_dec_crt(pkey, m, c);
>  	if (ret)
>  		goto err_free_c;
> 
> @@ -134,9 +172,19 @@ static void rsa_free_mpi_key(struct rsa_mpi_key 
> *key)
>  	mpi_free(key->d);
>  	mpi_free(key->e);
>  	mpi_free(key->n);
> +	mpi_free(key->p);
> +	mpi_free(key->q);
> +	mpi_free(key->dp);
> +	mpi_free(key->dq);
> +	mpi_free(key->qinv);
>  	key->d = NULL;
>  	key->e = NULL;
>  	key->n = NULL;
> +	key->p = NULL;
> +	key->q = NULL;
> +	key->dp = NULL;
> +	key->dq = NULL;
> +	key->qinv = NULL;
>  }
> 
>  static int rsa_check_key_length(unsigned int len)
> @@ -217,6 +265,26 @@ static int rsa_set_priv_key(struct
> crypto_akcipher *tfm, const void *key,
>  	if (!mpi_key->n)
>  		goto err;
> 
> +	mpi_key->p = mpi_read_raw_data(raw_key.p, raw_key.p_sz);
> +	if (!mpi_key->p)
> +		goto err;
> +
> +	mpi_key->q = mpi_read_raw_data(raw_key.q, raw_key.q_sz);
> +	if (!mpi_key->q)
> +		goto err;
> +
> +	mpi_key->dp = mpi_read_raw_data(raw_key.dp, raw_key.dp_sz);
> +	if (!mpi_key->dp)
> +		goto err;
> +
> +	mpi_key->dq = mpi_read_raw_data(raw_key.dq, raw_key.dq_sz);
> +	if (!mpi_key->dq)
> +		goto err;
> +
> +	mpi_key->qinv = mpi_read_raw_data(raw_key.qinv, raw_key.qinv_sz);
> +	if (!mpi_key->qinv)
> +		goto err;
> +
>  	if (rsa_check_key_length(mpi_get_size(mpi_key->n) << 3)) {
>  		rsa_free_mpi_key(mpi_key);
>  		return -EINVAL;
> diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
> index 2cdae54c1bd0..9056fc5167fc 100644
> --- a/lib/mpi/mpi-add.c
> +++ b/lib/mpi/mpi-add.c
> @@ -138,7 +138,7 @@ void mpi_sub(MPI w, MPI u, MPI v)
>  	mpi_add(w, u, vv);
>  	mpi_free(vv);
>  }
> -
> +EXPORT_SYMBOL_GPL(mpi_sub);
> 
>  void mpi_addm(MPI w, MPI u, MPI v, MPI m)
>  {
> diff --git a/lib/mpi/mpi-mul.c b/lib/mpi/mpi-mul.c
> index 8f5fa200f297..7f4eda8560dc 100644
> --- a/lib/mpi/mpi-mul.c
> +++ b/lib/mpi/mpi-mul.c
> @@ -82,6 +82,7 @@ void mpi_mul(MPI w, MPI u, MPI v)
>  	if (tmp_limb)
>  		mpi_free_limb_space(tmp_limb);
>  }
> +EXPORT_SYMBOL_GPL(mpi_mul);
> 
>  void mpi_mulm(MPI w, MPI u, MPI v, MPI m)
>  {
> --
> 2.36.1

Hello Ignat
on s390 the linux-next kernel gives me this during startup:

Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: akcipher: decrypt test 
failed. err -22
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: akcipher: test 1 failed 
for rsa-generic, err=-22
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ------------[ cut here 
]------------
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: self-tests for 
rsa-generic (rsa) failed (rc=-22)
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: WARNING: CPU: 6 PID: 111 at 
crypto/testmgr.c:5773 alg_test+0x348/0x4d0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Modules linked in:
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: CPU: 6 PID: 111 Comm: 
cryptomgr_test Not tainted 5.19.0-rc5-next-20220706 #1
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Hardware name: IBM 8561 T01 
703 (LPAR)
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl PSW : 0704d00180000000 
00000000f8b15ab4 (alg_test+0x34c/0x4d0)
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            R:0 T:1 IO:1 EX:1 
Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl GPRS: c0000000fffeffff 
0000000080000000 0000000000000035 0000000000000000
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            0000000000000001 
0000000000000001 000000008da15c80 000000000000000d
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            000000008da15c00 
00000000ffffffff 00000380000000b6 ffffffffffffffea
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            000000008cd53200 
00000000fb19dfd0 00000000f8b15ab0 0000038004847cf8
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl Code: 00000000f8b15aa4: 
c02000523738        larl        %r2,00000000f955c914
                                                      00000000f8b15aaa: 
c0e5002d52a7        brasl        %r14,00000000f90bfff8
                                                     #00000000f8b15ab0: 
af000000                mc        0,0
                                                     >00000000f8b15ab4: 
b904002b                lgr        %r2,%r11
                                                      00000000f8b15ab8: 
eb6ff1300004        lmg        %r6,%r15,304(%r15)
                                                      00000000f8b15abe: 
07fe                bcr        15,%r14
                                                      00000000f8b15ac0: 
47000700                bc        0,1792
                                                      00000000f8b15ac4: 
1829                lr        %r2,%r9
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Call Trace:
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f8b15ab4>] 
alg_test+0x34c/0x4d0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ([<00000000f8b15ab0>] 
alg_test+0x348/0x4d0)
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f8b13b98>] 
cryptomgr_test+0x68/0x70
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f83b4be8>] 
kthread+0x138/0x150
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f832f91c>] 
__ret_from_fork+0x3c/0x58
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f90ecf6a>] 
ret_from_fork+0xa/0x40
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: no locks held by 
cryptomgr_test/111.
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Last Breaking-Event-Address:
Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f90c005e>] 
__warn_printk+0x66/0x70
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: irq event stamp: 729
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: hardirqs last  enabled at 
(737): [<00000000f841f3b4>] __up_console_sem+0x8c/0xc0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: hardirqs last disabled at 
(744): [<00000000f841f396>] __up_console_sem+0x6e/0xc0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: softirqs last  enabled at (0): 
[<00000000f837d6da>] copy_process+0x7fa/0x17d0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: softirqs last disabled at (0): 
[<0000000000000000>] 0x0
Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ---[ end trace 
0000000000000000 ]---

I tracked this down with git bisect to exactly your patch.
Looks like the testmanager needs an update also ... maybe use CRT 
formated keys instead of ME keys ?!?

regards
Harald Freudenberger



