Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F056AB23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiGGS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbiGGS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:58:33 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F520140AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:58:31 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h5so11567923ili.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQPSH9SWdzDj3/e0BMmAev7GJ+pdJy3w6jaxeInTct0=;
        b=WXzJcVBElv+MVR0EADFm8RcL6SSGuURNI8Boer+g1cp3L6I+MDVhKHXUtCsvolmk0v
         q7pH6hvcmNj3nUP1pL5aG7Z1v3wuSmeHgrORfy7QSr6U1FT9/xvo/Cer9UVWFY4rqn4t
         9+sor0J2Ek9fpmMEG1WGU2ius/ZExpaJPEHGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQPSH9SWdzDj3/e0BMmAev7GJ+pdJy3w6jaxeInTct0=;
        b=YTOOH0k4fe8UJmJrleWPwxXNRX6xI4kSQvHNYYkWpL7uswvfDyrfZa8/YE5fOJMXIU
         LS3hBUCF6cIfDn8KNqKaKmWMFFlSAy63ixFaY4Dvbl7FzCah2DIFgsZ0dCDE2AcLpV9w
         VHkL9yWtkGA27xjv2JfmY7Blzn9wvDVE4CUx3b4Po8WqaSsSHxyT7W2FGSDTIh52WqLn
         1UGgTa2bAgpCqa/dtqo2Ybd86XKB4md9r3k+be6NFfROhiNfbozo8wwO/sIbDixgCcNY
         DC51p/a8A+E+cWGYcamtVI8HZKUyNSUOW4YNcixwRJ/WZeVh7cGBtQMoC0UEP0tYzl2U
         zAbg==
X-Gm-Message-State: AJIora+LNbYpuGnhroRZHyXuccxQAg1AK7r+jbSa5ikfA4dUDTrVVUji
        tBBJ8IUMmeytOnL+aEa+rQPMXyQQvXZ1vpEOzuO9P1QgVJMUXA==
X-Google-Smtp-Source: AGRyM1vCDn92fMp+WPQ9BT9c2HEtobp+veAd/ELloOL6ff2j5nRVow+7YlFWPCloO5WKHpp30zqdP2A5siJvI7VPyKw=
X-Received: by 2002:a92:cda7:0:b0:2dc:335d:fabd with SMTP id
 g7-20020a92cda7000000b002dc335dfabdmr6755739ild.16.1657220310681; Thu, 07 Jul
 2022 11:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220617084210.907-1-ignat@cloudflare.com> <87a675dc70199baf013b417c55275ee1@linux.ibm.com>
In-Reply-To: <87a675dc70199baf013b417c55275ee1@linux.ibm.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 7 Jul 2022 19:58:19 +0100
Message-ID: <CALrw=nG6y46XO9VQ1JsMNAX1keXTMFeb2U8g6tpVys-KhbeAZQ@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: rsa - implement Chinese Remainder Theorem for
 faster private key operations
To:     freude@linux.ibm.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        kernel test robot <lkp@intel.com>, egorenar@linux.ibm.com,
        jchrist@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 6:29 PM Harald Freudenberger
<freude@linux.ibm.com> wrote:
>
> On 2022-06-17 10:42, Ignat Korchagin wrote:
> > Changes from v1:
> >   * exported mpi_sub and mpi_mul, otherwise the build fails when RSA is
> > a module
> >
> > The kernel RSA ASN.1 private key parser already supports only private
> > keys with
> > additional values to be used with the Chinese Remainder Theorem [1],
> > but these
> > values are currently not used.
> >
> > This rudimentary CRT implementation speeds up RSA private key
> > operations for the
> > following Go benchmark up to ~3x.
> >
> > This implementation also tries to minimise the allocation of additional
> > MPIs,
> > so existing MPIs are reused as much as possible (hence the variable
> > names are a
> > bit weird).
> >
> > The benchmark used:
> >
> > ```
> > package keyring_test
> >
> > import (
> >       "crypto"
> >       "crypto/rand"
> >       "crypto/rsa"
> >       "crypto/x509"
> >       "io"
> >       "syscall"
> >       "testing"
> >       "unsafe"
> > )
> >
> > type KeySerial int32
> > type Keyring int32
> >
> > const (
> >       KEY_SPEC_PROCESS_KEYRING Keyring = -2
> >       KEYCTL_PKEY_SIGN                 = 27
> > )
> >
> > var (
> >       keyTypeAsym = []byte("asymmetric\x00")
> >       sha256pkcs1 = []byte("enc=pkcs1 hash=sha256\x00")
> > )
> >
> > func (keyring Keyring) LoadAsym(desc string, payload []byte)
> > (KeySerial, error) {
> >       cdesc := []byte(desc + "\x00")
> >       serial, _, errno := syscall.Syscall6(syscall.SYS_ADD_KEY,
> > uintptr(unsafe.Pointer(&keyTypeAsym[0])),
> > uintptr(unsafe.Pointer(&cdesc[0])),
> > uintptr(unsafe.Pointer(&payload[0])), uintptr(len(payload)),
> > uintptr(keyring), uintptr(0))
> >       if errno == 0 {
> >               return KeySerial(serial), nil
> >       }
> >
> >       return KeySerial(serial), errno
> > }
> >
> > type pkeyParams struct {
> >       key_id         KeySerial
> >       in_len         uint32
> >       out_or_in2_len uint32
> >       __spare        [7]uint32
> > }
> >
> > // the output signature buffer is an input parameter here, because we
> > want to
> > // avoid Go buffer allocation leaking into our benchmarks
> > func (key KeySerial) Sign(info, digest, out []byte) error {
> >       var params pkeyParams
> >       params.key_id = key
> >       params.in_len = uint32(len(digest))
> >       params.out_or_in2_len = uint32(len(out))
> >
> >       _, _, errno := syscall.Syscall6(syscall.SYS_KEYCTL, KEYCTL_PKEY_SIGN,
> > uintptr(unsafe.Pointer(&params)), uintptr(unsafe.Pointer(&info[0])),
> > uintptr(unsafe.Pointer(&digest[0])), uintptr(unsafe.Pointer(&out[0])),
> > uintptr(0))
> >       if errno == 0 {
> >               return nil
> >       }
> >
> >       return errno
> > }
> >
> > func BenchmarkSign(b *testing.B) {
> >       priv, err := rsa.GenerateKey(rand.Reader, 2048)
> >       if err != nil {
> >               b.Fatalf("failed to generate private key: %v", err)
> >       }
> >
> >       pkcs8, err := x509.MarshalPKCS8PrivateKey(priv)
> >       if err != nil {
> >               b.Fatalf("failed to serialize the private key to PKCS8 blob: %v",
> > err)
> >       }
> >
> >       serial, err := KEY_SPEC_PROCESS_KEYRING.LoadAsym("test rsa key",
> > pkcs8)
> >       if err != nil {
> >               b.Fatalf("failed to load the private key into the keyring: %v", err)
> >       }
> >
> >       b.Logf("loaded test rsa key: %v", serial)
> >
> >       digest := make([]byte, 32)
> >       _, err = io.ReadFull(rand.Reader, digest)
> >       if err != nil {
> >               b.Fatalf("failed to generate a random digest: %v", err)
> >       }
> >
> >       sig := make([]byte, 256)
> >       for n := 0; n < b.N; n++ {
> >               err = serial.Sign(sha256pkcs1, digest, sig)
> >               if err != nil {
> >                       b.Fatalf("failed to sign the digest: %v", err)
> >               }
> >       }
> >
> >       err = rsa.VerifyPKCS1v15(&priv.PublicKey, crypto.SHA256, digest, sig)
> >       if err != nil {
> >               b.Fatalf("failed to verify the signature: %v", err)
> >       }
> > }
> > ```
> >
> > [1]:
> > https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Using_the_Chinese_remainder_algorithm
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  crypto/rsa.c      | 78 ++++++++++++++++++++++++++++++++++++++++++++---
> >  lib/mpi/mpi-add.c |  2 +-
> >  lib/mpi/mpi-mul.c |  1 +
> >  3 files changed, 75 insertions(+), 6 deletions(-)
> >
> > diff --git a/crypto/rsa.c b/crypto/rsa.c
> > index 39e04176b04b..0e555ee4addb 100644
> > --- a/crypto/rsa.c
> > +++ b/crypto/rsa.c
> > @@ -17,6 +17,11 @@ struct rsa_mpi_key {
> >       MPI n;
> >       MPI e;
> >       MPI d;
> > +     MPI p;
> > +     MPI q;
> > +     MPI dp;
> > +     MPI dq;
> > +     MPI qinv;
> >  };
> >
> >  /*
> > @@ -35,16 +40,49 @@ static int _rsa_enc(const struct rsa_mpi_key *key,
> > MPI c, MPI m)
> >
> >  /*
> >   * RSADP function [RFC3447 sec 5.1.2]
> > - * m = c^d mod n;
> > + * m_1 = c^dP mod p;
> > + * m_2 = c^dQ mod q;
> > + * h = (m_1 - m_2) * qInv mod p;
> > + * m = m_2 + q * h;
> >   */
> > -static int _rsa_dec(const struct rsa_mpi_key *key, MPI m, MPI c)
> > +static int _rsa_dec_crt(const struct rsa_mpi_key *key, MPI
> > m_or_m1_or_h, MPI c)
> >  {
> > +     MPI m2, m12_or_qh;
> > +     int ret = -ENOMEM;
> > +
> >       /* (1) Validate 0 <= c < n */
> >       if (mpi_cmp_ui(c, 0) < 0 || mpi_cmp(c, key->n) >= 0)
> >               return -EINVAL;
> >
> > -     /* (2) m = c^d mod n */
> > -     return mpi_powm(m, c, key->d, key->n);
> > +     m2 = mpi_alloc(0);
> > +     m12_or_qh = mpi_alloc(0);
> > +     if (!m2 || !m12_or_qh)
> > +             goto err_free_mpi;
> > +
> > +     /* (2i) m_1 = c^dP mod p */
> > +     ret = mpi_powm(m_or_m1_or_h, c, key->dp, key->p);
> > +     if (ret)
> > +             goto err_free_mpi;
> > +
> > +     /* (2i) m_2 = c^dQ mod q */
> > +     ret = mpi_powm(m2, c, key->dq, key->q);
> > +     if (ret)
> > +             goto err_free_mpi;
> > +
> > +     /* (2iii) h = (m_1 - m_2) * qInv mod p */
> > +     mpi_sub(m12_or_qh, m_or_m1_or_h, m2);
> > +     mpi_mulm(m_or_m1_or_h, m12_or_qh, key->qinv, key->p);
> > +
> > +     /* (2iv) m = m_2 + q * h */
> > +     mpi_mul(m12_or_qh, key->q, m_or_m1_or_h);
> > +     mpi_addm(m_or_m1_or_h, m2, m12_or_qh, key->n);
> > +
> > +     ret = 0;
> > +
> > +err_free_mpi:
> > +     mpi_free(m12_or_qh);
> > +     mpi_free(m2);
> > +     return ret;
> >  }
> >
> >  static inline struct rsa_mpi_key *rsa_get_key(struct crypto_akcipher
> > *tfm)
> > @@ -112,7 +150,7 @@ static int rsa_dec(struct akcipher_request *req)
> >       if (!c)
> >               goto err_free_m;
> >
> > -     ret = _rsa_dec(pkey, m, c);
> > +     ret = _rsa_dec_crt(pkey, m, c);
> >       if (ret)
> >               goto err_free_c;
> >
> > @@ -134,9 +172,19 @@ static void rsa_free_mpi_key(struct rsa_mpi_key
> > *key)
> >       mpi_free(key->d);
> >       mpi_free(key->e);
> >       mpi_free(key->n);
> > +     mpi_free(key->p);
> > +     mpi_free(key->q);
> > +     mpi_free(key->dp);
> > +     mpi_free(key->dq);
> > +     mpi_free(key->qinv);
> >       key->d = NULL;
> >       key->e = NULL;
> >       key->n = NULL;
> > +     key->p = NULL;
> > +     key->q = NULL;
> > +     key->dp = NULL;
> > +     key->dq = NULL;
> > +     key->qinv = NULL;
> >  }
> >
> >  static int rsa_check_key_length(unsigned int len)
> > @@ -217,6 +265,26 @@ static int rsa_set_priv_key(struct
> > crypto_akcipher *tfm, const void *key,
> >       if (!mpi_key->n)
> >               goto err;
> >
> > +     mpi_key->p = mpi_read_raw_data(raw_key.p, raw_key.p_sz);
> > +     if (!mpi_key->p)
> > +             goto err;
> > +
> > +     mpi_key->q = mpi_read_raw_data(raw_key.q, raw_key.q_sz);
> > +     if (!mpi_key->q)
> > +             goto err;
> > +
> > +     mpi_key->dp = mpi_read_raw_data(raw_key.dp, raw_key.dp_sz);
> > +     if (!mpi_key->dp)
> > +             goto err;
> > +
> > +     mpi_key->dq = mpi_read_raw_data(raw_key.dq, raw_key.dq_sz);
> > +     if (!mpi_key->dq)
> > +             goto err;
> > +
> > +     mpi_key->qinv = mpi_read_raw_data(raw_key.qinv, raw_key.qinv_sz);
> > +     if (!mpi_key->qinv)
> > +             goto err;
> > +
> >       if (rsa_check_key_length(mpi_get_size(mpi_key->n) << 3)) {
> >               rsa_free_mpi_key(mpi_key);
> >               return -EINVAL;
> > diff --git a/lib/mpi/mpi-add.c b/lib/mpi/mpi-add.c
> > index 2cdae54c1bd0..9056fc5167fc 100644
> > --- a/lib/mpi/mpi-add.c
> > +++ b/lib/mpi/mpi-add.c
> > @@ -138,7 +138,7 @@ void mpi_sub(MPI w, MPI u, MPI v)
> >       mpi_add(w, u, vv);
> >       mpi_free(vv);
> >  }
> > -
> > +EXPORT_SYMBOL_GPL(mpi_sub);
> >
> >  void mpi_addm(MPI w, MPI u, MPI v, MPI m)
> >  {
> > diff --git a/lib/mpi/mpi-mul.c b/lib/mpi/mpi-mul.c
> > index 8f5fa200f297..7f4eda8560dc 100644
> > --- a/lib/mpi/mpi-mul.c
> > +++ b/lib/mpi/mpi-mul.c
> > @@ -82,6 +82,7 @@ void mpi_mul(MPI w, MPI u, MPI v)
> >       if (tmp_limb)
> >               mpi_free_limb_space(tmp_limb);
> >  }
> > +EXPORT_SYMBOL_GPL(mpi_mul);
> >
> >  void mpi_mulm(MPI w, MPI u, MPI v, MPI m)
> >  {
> > --
> > 2.36.1
>
> Hello Ignat
> on s390 the linux-next kernel gives me this during startup:
Hi Harald,

The issue has been reported previously and I've submitted a follow up patch: [1]

[1]: https://patchwork.kernel.org/project/linux-crypto/patch/20220704103840.924-1-ignat@cloudflare.com/

> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: akcipher: decrypt test
> failed. err -22
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: akcipher: test 1 failed
> for rsa-generic, err=-22
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ------------[ cut here
> ]------------
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: alg: self-tests for
> rsa-generic (rsa) failed (rc=-22)
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: WARNING: CPU: 6 PID: 111 at
> crypto/testmgr.c:5773 alg_test+0x348/0x4d0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Modules linked in:
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: CPU: 6 PID: 111 Comm:
> cryptomgr_test Not tainted 5.19.0-rc5-next-20220706 #1
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Hardware name: IBM 8561 T01
> 703 (LPAR)
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl PSW : 0704d00180000000
> 00000000f8b15ab4 (alg_test+0x34c/0x4d0)
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            R:0 T:1 IO:1 EX:1
> Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl GPRS: c0000000fffeffff
> 0000000080000000 0000000000000035 0000000000000000
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            0000000000000001
> 0000000000000001 000000008da15c80 000000000000000d
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            000000008da15c00
> 00000000ffffffff 00000380000000b6 ffffffffffffffea
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:            000000008cd53200
> 00000000fb19dfd0 00000000f8b15ab0 0000038004847cf8
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Krnl Code: 00000000f8b15aa4:
> c02000523738        larl        %r2,00000000f955c914
>                                                       00000000f8b15aaa:
> c0e5002d52a7        brasl        %r14,00000000f90bfff8
>                                                      #00000000f8b15ab0:
> af000000                mc        0,0
>                                                      >00000000f8b15ab4:
> b904002b                lgr        %r2,%r11
>                                                       00000000f8b15ab8:
> eb6ff1300004        lmg        %r6,%r15,304(%r15)
>                                                       00000000f8b15abe:
> 07fe                bcr        15,%r14
>                                                       00000000f8b15ac0:
> 47000700                bc        0,1792
>                                                       00000000f8b15ac4:
> 1829                lr        %r2,%r9
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Call Trace:
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f8b15ab4>]
> alg_test+0x34c/0x4d0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ([<00000000f8b15ab0>]
> alg_test+0x348/0x4d0)
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f8b13b98>]
> cryptomgr_test+0x68/0x70
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f83b4be8>]
> kthread+0x138/0x150
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f832f91c>]
> __ret_from_fork+0x3c/0x58
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f90ecf6a>]
> ret_from_fork+0xa/0x40
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: no locks held by
> cryptomgr_test/111.
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: Last Breaking-Event-Address:
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel:  [<00000000f90c005e>]
> __warn_printk+0x66/0x70
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: irq event stamp: 729
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: hardirqs last  enabled at
> (737): [<00000000f841f3b4>] __up_console_sem+0x8c/0xc0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: hardirqs last disabled at
> (744): [<00000000f841f396>] __up_console_sem+0x6e/0xc0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: softirqs last  enabled at (0):
> [<00000000f837d6da>] copy_process+0x7fa/0x17d0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: softirqs last disabled at (0):
> [<0000000000000000>] 0x0
> Jul 07 11:50:28 t35lp54.lnxne.boe kernel: ---[ end trace
> 0000000000000000 ]---
>
> I tracked this down with git bisect to exactly your patch.
> Looks like the testmanager needs an update also ... maybe use CRT
> formated keys instead of ME keys ?!?
>
> regards
> Harald Freudenberger
>
>
>

Regards,
Ignat
