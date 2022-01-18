Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37829491F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiARFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 00:31:52 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59636 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235752AbiARFbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:31:46 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n9h5d-0006et-EJ; Tue, 18 Jan 2022 16:31:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 18 Jan 2022 16:31:29 +1100
Date:   Tue, 18 Jan 2022 16:31:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: kdf - Select hmac in addition to sha256
Message-ID: <YeZQsSkRsioTHE1z@gondor.apana.org.au>
References: <20220118015649.GA12486@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118015649.GA12486@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:56:49AM +0800, kernel test robot wrote:
> 
> [ 42.753085][ T1] WARNING: CPU: 1 PID: 1 at crypto/kdf_sp800108.c:138 crypto_kdf108_init (crypto/kdf_sp800108.c:136) 
> [   42.754665][    T1] Modules linked in:
> [   42.755366][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc1-00049-gd3b04a4398fe #2
> [   42.756752][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 42.758199][ T1] RIP: 0010:crypto_kdf108_init (crypto/kdf_sp800108.c:136) 
>
> CONFIG_CRYPTO_HMAC=m
> CONFIG_CRYPTO_KDF800108_CTR=y

---8<---
In addition to sha256 we must also enable hmac for the kdf self-test
to work.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 304b4acee2f0 ("crypto: kdf - select SHA-256 required...")
Fixes: 026a733e6659 ("crypto: kdf - add SP800-108 counter key...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3ba2f532d79c..2b0456731603 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1850,6 +1850,7 @@ config CRYPTO_JITTERENTROPY
 
 config CRYPTO_KDF800108_CTR
 	tristate
+	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 
 config CRYPTO_USER_API
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
