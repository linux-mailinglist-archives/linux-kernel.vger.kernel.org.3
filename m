Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1041559643
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiFXJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiFXJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:15:18 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAB4F466;
        Fri, 24 Jun 2022 02:15:17 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o4fP9-00Ai5D-GQ; Fri, 24 Jun 2022 19:15:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Jun 2022 17:15:07 +0800
Date:   Fri, 24 Jun 2022 17:15:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] crypto: rsa - implement Chinese Remainder Theorem for
 faster private key operations
Message-ID: <YrWAm+Y/3/LjkLMo@gondor.apana.org.au>
References: <20220617084210.907-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617084210.907-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:42:10AM +0100, Ignat Korchagin wrote:
> Changes from v1:
>   * exported mpi_sub and mpi_mul, otherwise the build fails when RSA is a module
> 
> The kernel RSA ASN.1 private key parser already supports only private keys with
> additional values to be used with the Chinese Remainder Theorem [1], but these
> values are currently not used.
> 
> This rudimentary CRT implementation speeds up RSA private key operations for the
> following Go benchmark up to ~3x.
> 
> This implementation also tries to minimise the allocation of additional MPIs,
> so existing MPIs are reused as much as possible (hence the variable names are a
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
> func (keyring Keyring) LoadAsym(desc string, payload []byte) (KeySerial, error) {
> 	cdesc := []byte(desc + "\x00")
> 	serial, _, errno := syscall.Syscall6(syscall.SYS_ADD_KEY, uintptr(unsafe.Pointer(&keyTypeAsym[0])), uintptr(unsafe.Pointer(&cdesc[0])), uintptr(unsafe.Pointer(&payload[0])), uintptr(len(payload)), uintptr(keyring), uintptr(0))
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
> // the output signature buffer is an input parameter here, because we want to
> // avoid Go buffer allocation leaking into our benchmarks
> func (key KeySerial) Sign(info, digest, out []byte) error {
> 	var params pkeyParams
> 	params.key_id = key
> 	params.in_len = uint32(len(digest))
> 	params.out_or_in2_len = uint32(len(out))
> 
> 	_, _, errno := syscall.Syscall6(syscall.SYS_KEYCTL, KEYCTL_PKEY_SIGN, uintptr(unsafe.Pointer(&params)), uintptr(unsafe.Pointer(&info[0])), uintptr(unsafe.Pointer(&digest[0])), uintptr(unsafe.Pointer(&out[0])), uintptr(0))
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
> 		b.Fatalf("failed to serialize the private key to PKCS8 blob: %v", err)
> 	}
> 
> 	serial, err := KEY_SPEC_PROCESS_KEYRING.LoadAsym("test rsa key", pkcs8)
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
> [1]: https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Using_the_Chinese_remainder_algorithm
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  crypto/rsa.c      | 78 ++++++++++++++++++++++++++++++++++++++++++++---
>  lib/mpi/mpi-add.c |  2 +-
>  lib/mpi/mpi-mul.c |  1 +
>  3 files changed, 75 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
