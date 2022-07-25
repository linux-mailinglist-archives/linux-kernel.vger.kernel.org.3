Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86757F953
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGYGTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:19:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F536DFEC;
        Sun, 24 Jul 2022 23:19:30 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrqXm0bT5z925M;
        Mon, 25 Jul 2022 14:15:36 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 14:19:22 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 14:19:22 +0800
Message-ID: <bc13f52c-7728-f20b-e62e-dec96c16d651@huawei.com>
Date:   Mon, 25 Jul 2022 14:19:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] certs: Fix Kconfig dependency
To:     <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <simo@redhat.com>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220704112028.183193-1-renzhijie2@huawei.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <20220704112028.183193-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a friendly ping...

在 2022/7/4 19:20, Ren Zhijie 写道:
> If CONFIG_PKCS7_MESSAGE_PARSER=m and CONFIG_FIPS_SIGNATURE_SELFTEST=y,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
>
> crypto/asymmetric_keys/selftest.o: In function `fips_signature_selftest':
> selftest.c:(.init.text+0xc3): undefined reference to `pkcs7_parse_message'
> selftest.c:(.init.text+0x101): undefined reference to `pkcs7_supply_detached_data'
> selftest.c:(.init.text+0x112): undefined reference to `pkcs7_verify'
> selftest.c:(.init.text+0x13f): undefined reference to `pkcs7_validate_trust'
> selftest.c:(.init.text+0x169): undefined reference to `pkcs7_free_message'
> make: *** [vmlinux] Error 1
>
> To fix this error, add depends on PKCS7_MESSAGE_PARSER=y to FIPS_SIGNATURE_SELFTEST
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 3cde3174eb91 ("certs: Add FIPS selftests")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   crypto/asymmetric_keys/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 3df3fe4ed95f..fe007db96c69 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
>   	  for FIPS.
>   	depends on KEYS
>   	depends on ASYMMETRIC_KEY_TYPE
> -	depends on PKCS7_MESSAGE_PARSER
> +	depends on PKCS7_MESSAGE_PARSER=y
>   
>   endif # ASYMMETRIC_KEY_TYPE

