Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A396E51F979
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiEIKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiEIKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:17:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02127EBA9;
        Mon,  9 May 2022 03:13:34 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2499x3hc015416;
        Mon, 9 May 2022 10:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=/UmWbXM6MJ8mhaloo9ri3McWS/eohEhnBJnXhosd4iE=;
 b=FDJEJAQtRMGO8yAX0RzIXQMs7Q0RTNF2rAOpHfXDHpt5ov/u7SpE0agVppXVVtAhP2dk
 PE268ijGLMXVlQsLNiZHQuDglUB2wUaHVWKrr6idUpwnC6kVCEvZXIwJticOW4XHeEid
 4iHuaRcB9dzRfC78Tp/zNGMthpHXG3Q2LWacGdGmm1oJJ9FyO2O8uiGVI1fwDl3SFFFh
 q0MpRoVjiYdaVdYfql3/ov7KGel24M2/cHbKFWqRloCuVxJ8T/uzOzTpQ1eVEFVy4LxQ
 l8CGo88wluXYuxIqOoTRSzdaPEncDL2K31GEonaqUsrrQ+DSAE9SpJdXEHjNnMzL/XsT XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fx2srxmqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 10:10:20 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 249A1nnS003737;
        Mon, 9 May 2022 10:10:20 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fx2srxmp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 10:10:20 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 249A8s9B012155;
        Mon, 9 May 2022 10:10:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 3fwgd95d8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 10:10:17 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 249AAEjL23789934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 May 2022 10:10:14 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9026E05B;
        Mon,  9 May 2022 10:10:14 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 362396E052;
        Mon,  9 May 2022 10:10:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  9 May 2022 10:10:13 +0000 (GMT)
MIME-Version: 1.0
Date:   Mon, 09 May 2022 12:10:12 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Patrick Steuer <patrick.steuer@de.ibm.com>,
        Harald Freudenberger <freude@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: add crypto library interface for ChaCha20
Reply-To: freude@linux.ibm.com
In-Reply-To: <20220508130944.17860-1-vdronoff@gmail.com>
References: <20220508130944.17860-1-vdronoff@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <3f16033ef08063ef9fcb707010e78bd0@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NI6Ci93IOUb43TaKBeyXP8xDJOk5DnxB
X-Proofpoint-ORIG-GUID: Ym_vmLmk57eZzPa1r9SFC_RxmTd0UoFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_03,2022-05-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205090057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-08 15:09, Vladis Dronov wrote:
> From: Vladis Dronov <vdronov@redhat.com>
> 
> Implement a crypto library interface for the s390-native ChaCha20 
> cipher
> algorithm. This allows us to stop to select CRYPTO_CHACHA20 and instead
> select CRYPTO_ARCH_HAVE_LIB_CHACHA. This allows BIG_KEYS=y not to build
> a whole ChaCha20 crypto infrastructure as a built-in, but build a 
> smaller
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
> 
> diff --git a/arch/s390/crypto/chacha-glue.c 
> b/arch/s390/crypto/chacha-glue.c
> index ccfff73e2c93..2ec51f339cec 100644
> --- a/arch/s390/crypto/chacha-glue.c
> +++ b/arch/s390/crypto/chacha-glue.c
> @@ -62,6 +62,34 @@ static int chacha20_s390(struct skcipher_request 
> *req)
>  	return rc;
>  }
> 
> +void hchacha_block_arch(const u32 *state, u32 *stream, int nrounds)
> +{
> +	/* TODO: implement hchacha_block_arch() in assembly */
> +	hchacha_block_generic(state, stream, nrounds);
> +}
> +EXPORT_SYMBOL(hchacha_block_arch);
> +
> +void chacha_init_arch(u32 *state, const u32 *key, const u8 *iv)
> +{
> +	chacha_init_generic(state, key, iv);
> +}
> +EXPORT_SYMBOL(chacha_init_arch);
> +
> +void chacha_crypt_arch(u32 *state, u8 *dst, const u8 *src,
> +		       unsigned int bytes, int nrounds)
> +{
> +	/* s390 chacha20 implementation has 20 rounds hard-coded,
> +	 * it cannot handle a block of data or less, but otherwise
> +	 * it can handle data of arbitrary size
> +	 */
> +	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20)
> +		chacha_crypt_generic(state, dst, src, bytes, nrounds);
> +	else
> +		chacha20_crypt_s390(state, dst, src, bytes,
> +				    &state[4], &state[12]);
> +}
> +EXPORT_SYMBOL(chacha_crypt_arch);
> +
>  static struct skcipher_alg chacha_algs[] = {
>  	{
>  		.base.cra_name		= "chacha20",
> @@ -83,12 +111,14 @@ static struct skcipher_alg chacha_algs[] = {
> 
>  static int __init chacha_mod_init(void)
>  {
> -	return crypto_register_skciphers(chacha_algs, 
> ARRAY_SIZE(chacha_algs));
> +	return IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER) ?
> +		crypto_register_skciphers(chacha_algs, ARRAY_SIZE(chacha_algs)) : 0;
>  }
> 
>  static void __exit chacha_mod_fini(void)
>  {
> -	crypto_unregister_skciphers(chacha_algs, ARRAY_SIZE(chacha_algs));
> +	if (IS_REACHABLE(CONFIG_CRYPTO_SKCIPHER))
> +		crypto_unregister_skciphers(chacha_algs, ARRAY_SIZE(chacha_algs));
>  }
> 
>  module_cpu_feature_match(VXRS, chacha_mod_init);
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 7b2d138bc83e..ee99c02c84e8 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -216,9 +216,9 @@ config CRYPTO_AES_S390
>  config CRYPTO_CHACHA_S390
>  	tristate "ChaCha20 stream cipher"
>  	depends on S390
> -	select CRYPTO_ALGAPI
>  	select CRYPTO_SKCIPHER
> -	select CRYPTO_CHACHA20
> +	select CRYPTO_LIB_CHACHA_GENERIC
> +	select CRYPTO_ARCH_HAVE_LIB_CHACHA
>  	help
>  	  This is the s390 SIMD implementation of the ChaCha20 stream
>  	  cipher (RFC 7539).
> diff --git a/tools/testing/crypto/chacha20-s390/Makefile
> b/tools/testing/crypto/chacha20-s390/Makefile
> new file mode 100644
> index 000000000000..db81cd2fb9c5
> --- /dev/null
> +++ b/tools/testing/crypto/chacha20-s390/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022 Red Hat, Inc.
> +# Author: Vladis Dronov <vdronoff@gmail.com>
> +
> +obj-m += test_cipher.o
> +test_cipher-y := test-cipher.o
> +
> +all:
> +	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
> +clean:
> +	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
> diff --git a/tools/testing/crypto/chacha20-s390/run-tests.sh
> b/tools/testing/crypto/chacha20-s390/run-tests.sh
> new file mode 100644
> index 000000000000..43108794b996
> --- /dev/null
> +++ b/tools/testing/crypto/chacha20-s390/run-tests.sh
> @@ -0,0 +1,34 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022 Red Hat, Inc.
> +# Author: Vladis Dronov <vdronoff@gmail.com>
> +#
> +# This script runs (via instmod) test-cipher.ko module which invokes
> +# generic and s390-native ChaCha20 encryprion algorithms with 
> different
> +# size of data. Check 'dmesg' for results.
> +#
> +# The insmod error is expected:
> +# insmod: ERROR: could not insert module test_cipher.ko: Operation
> not permitted
> +
> +lsmod | grep chacha | cut -f1 -d' ' | xargs rmmod
> +modprobe chacha_generic
> +modprobe chacha_s390
> +
> +# run encryption for different data size, including whole block(s) +/- 
> 1
> +insmod test_cipher.ko size=63
> +insmod test_cipher.ko size=64
> +insmod test_cipher.ko size=65
> +insmod test_cipher.ko size=127
> +insmod test_cipher.ko size=128
> +insmod test_cipher.ko size=129
> +insmod test_cipher.ko size=511
> +insmod test_cipher.ko size=512
> +insmod test_cipher.ko size=513
> +insmod test_cipher.ko size=4096
> +insmod test_cipher.ko size=65611
> +insmod test_cipher.ko size=6291456
> +insmod test_cipher.ko size=62914560
> +
> +# print test logs
> +dmesg | tail -170
> diff --git a/tools/testing/crypto/chacha20-s390/test-cipher.c
> b/tools/testing/crypto/chacha20-s390/test-cipher.c
> new file mode 100644
> index 000000000000..34e8b855266f
> --- /dev/null
> +++ b/tools/testing/crypto/chacha20-s390/test-cipher.c
> @@ -0,0 +1,372 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2022 Red Hat, Inc.
> + * Author: Vladis Dronov <vdronoff@gmail.com>
> + */
> +
> +#include <asm/elf.h>
> +#include <asm/uaccess.h>
> +#include <asm/smp.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/acompress.h>
> +#include <crypto/rng.h>
> +#include <crypto/drbg.h>
> +#include <crypto/kpp.h>
> +#include <crypto/internal/simd.h>
> +#include <crypto/chacha.h>
> +#include <crypto/aead.h>
> +#include <crypto/hash.h>
> +#include <linux/crypto.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/fips.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/scatterlist.h>
> +#include <linux/time.h>
> +#include <linux/vmalloc.h>
> +#include <linux/zlib.h>
> +#include <linux/once.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +static unsigned int data_size __read_mostly = 256;
> +static unsigned int debug __read_mostly = 0;
> +
> +/* tie all skcipher structures together */
> +struct skcipher_def {
> +	struct scatterlist sginp, sgout;
> +	struct crypto_skcipher *tfm;
> +	struct skcipher_request *req;
> +	struct crypto_wait wait;
> +};
> +
> +/* Perform cipher operations with the chacha lib */
> +static int test_lib_chacha(u8 *revert, u8 *cipher, u8 *plain)
> +{
> +	u32 chacha_state[CHACHA_STATE_WORDS];
> +	u8 iv[16], key[32];
> +	u64 start, end;
> +
> +	memset(key, 'X', sizeof(key));
> +	memset(iv, 'I', sizeof(iv));
> +
> +	if (debug) {
> +		print_hex_dump(KERN_INFO, "key: ", DUMP_PREFIX_OFFSET,
> +			       16, 1, key, 32, 1);
> +
> +		print_hex_dump(KERN_INFO, "iv:  ", DUMP_PREFIX_OFFSET,
> +			       16, 1, iv, 16, 1);
> +	}
> +
> +	/* Encrypt */
> +	chacha_init_arch(chacha_state, (u32*)key, iv);
> +
> +	start = ktime_get_ns();
> +	chacha_crypt_arch(chacha_state, cipher, plain, data_size, 20);
> +	end = ktime_get_ns();
> +
> +
> +	if (debug)
> +		print_hex_dump(KERN_INFO, "encr:", DUMP_PREFIX_OFFSET,
> +			       16, 1, cipher,
> +			       (data_size > 64 ? 64 : data_size), 1);
> +
> +	pr_info("lib encryption took: %lld nsec", end - start);
> +
> +	/* Decrypt */
> +	chacha_init_arch(chacha_state, (u32 *)key, iv);
> +
> +	start = ktime_get_ns();
> +	chacha_crypt_arch(chacha_state, revert, cipher, data_size, 20);
> +	end = ktime_get_ns();
> +
> +	if (debug)
> +		print_hex_dump(KERN_INFO, "decr:", DUMP_PREFIX_OFFSET,
> +			       16, 1, revert,
> +			       (data_size > 64 ? 64 : data_size), 1);
> +
> +	pr_info("lib decryption took: %lld nsec", end - start);
> +
> +	return 0;
> +}
> +
> +/* Perform cipher operations with skcipher */
> +static unsigned int test_skcipher_encdec(struct skcipher_def *sk,
> +					 int enc)
> +{
> +	int rc;
> +
> +	if (enc) {
> +		rc = crypto_wait_req(crypto_skcipher_encrypt(sk->req),
> +				     &sk->wait);
> +		if (rc)
> +			pr_info("skcipher encrypt returned with result"
> +				"%d\n", rc);
> +	}
> +	else
> +	{
> +		rc = crypto_wait_req(crypto_skcipher_decrypt(sk->req),
> +				     &sk->wait);
> +		if (rc)
> +			pr_info("skcipher decrypt returned with result"
> +				"%d\n", rc);
> +	}
> +
> +	return rc;
> +}
> +
> +/* Initialize and trigger cipher operations */
> +static int test_skcipher(char *name, u8 *revert, u8 *cipher, u8 
> *plain)
> +{
> +	struct skcipher_def sk;
> +	struct crypto_skcipher *skcipher = NULL;
> +	struct skcipher_request *req = NULL;
> +	u8 iv[16], key[32];
> +	u64 start, end;
> +	int ret = -EFAULT;
> +
> +	skcipher = crypto_alloc_skcipher(name, 0, 0);
> +	if (IS_ERR(skcipher)) {
> +		pr_info("could not allocate skcipher %s handle\n", name);
> +		return PTR_ERR(skcipher);
> +	}
> +
> +	req = skcipher_request_alloc(skcipher, GFP_KERNEL);
> +	if (!req) {
> +		pr_info("could not allocate skcipher request\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +					  crypto_req_done,
> +					  &sk.wait);
> +
> +	memset(key, 'X', sizeof(key));
> +	memset(iv, 'I', sizeof(iv));
> +
> +	if (crypto_skcipher_setkey(skcipher, key, 32)) {
> +		pr_info("key could not be set\n");
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	if (debug) {
> +		print_hex_dump(KERN_INFO, "key: ", DUMP_PREFIX_OFFSET,
> +			       16, 1, key, 32, 1);
> +
> +		print_hex_dump(KERN_INFO, "iv:  ", DUMP_PREFIX_OFFSET,
> +			       16, 1, iv, 16, 1);
> +	}
> +
> +	sk.tfm = skcipher;
> +	sk.req = req;
> +
> +	/* Encrypt in one pass */
> +	sg_init_one(&sk.sginp, plain, data_size);
> +	sg_init_one(&sk.sgout, cipher, data_size);
> +	skcipher_request_set_crypt(req, &sk.sginp, &sk.sgout,
> +				   data_size, iv);
> +	crypto_init_wait(&sk.wait);
> +
> +	/* Encrypt data */
> +	start = ktime_get_ns();
> +	ret = test_skcipher_encdec(&sk, 1);
> +	end = ktime_get_ns();
> +
> +	if (ret)
> +		goto out;
> +
> +	pr_info("%s tfm encryption successful, took %lld nsec\n", name, end - 
> start);
> +
> +	if (debug)
> +		print_hex_dump(KERN_INFO, "encr:", DUMP_PREFIX_OFFSET,
> +			       16, 1, cipher,
> +			       (data_size > 64 ? 64 : data_size), 1);
> +
> +	/* Prepare for decryption */
> +	memset(iv, 'I', sizeof(iv));
> +
> +	sg_init_one(&sk.sginp, cipher, data_size);
> +	sg_init_one(&sk.sgout, revert, data_size);
> +	skcipher_request_set_crypt(req, &sk.sginp, &sk.sgout,
> +				   data_size, iv);
> +	crypto_init_wait(&sk.wait);
> +
> +	/* Decrypt data */
> +	start = ktime_get_ns();
> +	ret = test_skcipher_encdec(&sk, 0);
> +	end = ktime_get_ns();
> +
> +	if (ret)
> +		goto out;
> +
> +	pr_info("%s tfm decryption successful, took %lld nsec\n", name, end - 
> start);
> +
> +	if (debug)
> +		print_hex_dump(KERN_INFO, "decr:", DUMP_PREFIX_OFFSET,
> +			       16, 1, revert,
> +			       (data_size > 64 ? 64 : data_size), 1);
> +
> +	/* Dump some internal skcipher data */
> +	if (debug)
> +		pr_info("skcipher %s: cryptlen %d blksize %d stride %d "
> +			"ivsize %d alignmask 0x%x\n",
> +			name, sk.req->cryptlen,
> +			crypto_skcipher_blocksize(sk.tfm),
> +			crypto_skcipher_alg(sk.tfm)->walksize,
> +			crypto_skcipher_ivsize(sk.tfm),
> +			crypto_skcipher_alignmask(sk.tfm));
> +
> +out:
> +	if (skcipher)
> +		crypto_free_skcipher(skcipher);
> +	if (req)
> +		skcipher_request_free(req);
> +	return ret;
> +}
> +
> +static int __init chacha_s390_test_init(void)
> +{
> +	u8 *plain = NULL, *revert = NULL;
> +	u8 *cipher_generic = NULL, *cipher_s390 = NULL;
> +	int ret = -1;
> +
> +	pr_info("s390 ChaCha20 test module: size=%d debug=%d\n",
> +		data_size, debug);
> +
> +	/* Allocate and fill buffers */
> +	plain = vmalloc(data_size);
> +	if (!plain) {
> +		pr_info("could not allocate plain buffer\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	memset(plain, 'a', data_size);
> +	get_random_bytes(plain, (data_size > 256 ? 256 : data_size));
> +
> +	cipher_generic = vmalloc(data_size);
> +	if (!cipher_generic) {
> +		pr_info("could not allocate cipher_generic buffer\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	memset(cipher_generic, 0, data_size);
> +
> +	cipher_s390 = vmalloc(data_size);
> +	if (!cipher_s390) {
> +		pr_info("could not allocate cipher_s390 buffer\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	memset(cipher_s390, 0, data_size);
> +
> +	revert = vmalloc(data_size);
> +	if (!revert) {
> +		pr_info("could not allocate revert buffer\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	memset(revert, 0, data_size);
> +
> +	if (debug)
> +		print_hex_dump(KERN_INFO, "src: ", DUMP_PREFIX_OFFSET,
> +			       16, 1, plain,
> +			       (data_size > 64 ? 64 : data_size), 1);
> +
> +	/* Use chacha20 generic */
> +	ret = test_skcipher("chacha20-generic", revert, cipher_generic, 
> plain);
> +	if (ret)
> +		goto out;
> +
> +	if (memcmp(plain, revert, data_size)) {
> +		pr_info("generic en/decryption check FAILED\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	else
> +		pr_info("generic en/decryption check OK\n");
> +
> +	memset(revert, 0, data_size);
> +
> +	/* Use chacha20 s390 */
> +	ret = test_skcipher("chacha20-s390", revert, cipher_s390, plain);
> +	if (ret)
> +		goto out;
> +
> +	if (memcmp(plain, revert, data_size)) {
> +		pr_info("s390 en/decryption check FAILED\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	else
> +		pr_info("s390 en/decryption check OK\n");
> +
> +	if (memcmp(cipher_generic, cipher_s390, data_size)) {
> +		pr_info("s390 vs generic check FAILED\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	else
> +		pr_info("s390 vs generic check OK\n");
> +
> +	memset(cipher_s390, 0, data_size);
> +	memset(revert, 0, data_size);
> +
> +	/* Use chacha20 lib */
> +	test_lib_chacha(revert, cipher_s390, plain);
> +
> +	if (memcmp(plain, revert, data_size)) {
> +		pr_info("lib en/decryption check FAILED\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	else
> +		pr_info("lib en/decryption check OK\n");
> +
> +	if (memcmp(cipher_generic, cipher_s390, data_size)) {
> +		pr_info("lib vs generic check FAILED\n");
> +		ret = -2;
> +		goto out;
> +	}
> +	else
> +		pr_info("lib vs generic check OK\n");
> +
> +	pr_info("--- chacha20 s390 test end ---\n");
> +
> +out:
> +	if (plain)
> +		vfree(plain);
> +	if (cipher_generic)
> +		vfree(cipher_generic);
> +	if (cipher_s390)
> +		vfree(cipher_s390);
> +	if (revert)
> +		vfree(revert);
> +
> +	return -1;
> +}
> +
> +static void __exit chacha_s390_test_exit(void)
> +{
> +	pr_info("s390 ChaCha20 test module exit\n");
> +}
> +
> +module_param_named(size, data_size, uint, 0660);
> +module_param(debug, int, 0660);
> +MODULE_PARM_DESC(size, "Size of a plaintext");
> +MODULE_PARM_DESC(debug, "Debug level (0=off,1=on)");
> +
> +module_init(chacha_s390_test_init);
> +module_exit(chacha_s390_test_exit);
> +
> +MODULE_DESCRIPTION("s390 ChaCha20 self-test");
> +MODULE_AUTHOR("Vladis Dronov <vdronoff@gmail.com>");
> +MODULE_LICENSE("GPL v2");

Hello Vladis
Thanks for your work. Please add my
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

however, always the question who will pick and forward this patch ?
To me this looks like most parts are common so I would suggest that
Herbert Xu  will pick this patch.
