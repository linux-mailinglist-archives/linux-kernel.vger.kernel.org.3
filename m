Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88965525F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379170AbiEMJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbiEMJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:36:24 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886147578;
        Fri, 13 May 2022 02:36:22 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1npRiY-00DHGI-J4; Fri, 13 May 2022 19:36:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 May 2022 17:36:14 +0800
Date:   Fri, 13 May 2022 17:36:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Patrick Steuer <patrick.steuer@de.ibm.com>,
        Harald Freudenberger <freude@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: add crypto library interface for ChaCha20
Message-ID: <Yn4mjhfyMtshhEpp@gondor.apana.org.au>
References: <20220508130944.17860-1-vdronoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508130944.17860-1-vdronoff@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 03:09:44PM +0200, Vladis Dronov wrote:
> From: Vladis Dronov <vdronov@redhat.com>
> 
> Implement a crypto library interface for the s390-native ChaCha20 cipher
> algorithm. This allows us to stop to select CRYPTO_CHACHA20 and instead
> select CRYPTO_ARCH_HAVE_LIB_CHACHA. This allows BIG_KEYS=y not to build
> a whole ChaCha20 crypto infrastructure as a built-in, but build a smaller
> CRYPTO_LIB_CHACHA instead.
> 
> Make CRYPTO_CHACHA_S390 config entry to look like similar ones on other
> architectures. Remove CRYPTO_ALGAPI select as anyway it is selected by
> CRYPTO_SKCIPHER.
> 
> Add a new test module and a test script for ChaCha20 cipher and its
> interfaces. Here are test results on an idle z15 machine:
> 
> Data | Generic crypto TFM |  s390 crypto TFM |    s390 lib
> size |      enc      dec  |     enc     dec  |     enc     dec
> -----+--------------------+------------------+----------------
> 512b |   1545ns   1295ns  |   604ns   446ns  |   430ns  407ns
> 4k   |   9536ns   9463ns  |  2329ns  2174ns  |  2170ns  2154ns
> 64k  |  149.6us  149.3us  |  34.4us  34.5us  |  33.9us  33.1us
> 6M   |  23.61ms  23.11ms  |  4223us  4160us  |  3951us  4008us
> 60M  |  143.9ms  143.9ms  |  33.5ms  33.2ms  |  32.2ms  32.1ms
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  arch/s390/crypto/chacha-glue.c                |  34 +-
>  drivers/crypto/Kconfig                        |   4 +-
>  tools/testing/crypto/chacha20-s390/Makefile   |  12 +
>  .../testing/crypto/chacha20-s390/run-tests.sh |  34 ++
>  .../crypto/chacha20-s390/test-cipher.c        | 372 ++++++++++++++++++
>  5 files changed, 452 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/crypto/chacha20-s390/Makefile
>  create mode 100644 tools/testing/crypto/chacha20-s390/run-tests.sh
>  create mode 100644 tools/testing/crypto/chacha20-s390/test-cipher.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
