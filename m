Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39783482291
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 08:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbhLaHFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 02:05:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17314 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhLaHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 02:05:36 -0500
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JQGNM1jB0z9s1L;
        Fri, 31 Dec 2021 15:04:35 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:05:32 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:05:32 +0800
Subject: Re: [PATCH v2 2/6] crypto: arm64/sm3-ce - make dependent on sm3
 library
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        "Eric Biggers" <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-crypto@vger.kernel.org>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211222045022.27069-1-tianjia.zhang@linux.alibaba.com>
 <20211222045022.27069-3-tianjia.zhang@linux.alibaba.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <18fdaf2c-827e-8d17-1eb7-cb1c12d15808@huawei.com>
Date:   Fri, 31 Dec 2021 15:05:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211222045022.27069-3-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/22 12:50, Tianjia Zhang Wrote:
> SM3 generic library is stand-alone implementation, sm3-ce can depend
> on the SM3 library instead of sm3-generic.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/arm64/crypto/Kconfig       |  2 +-
>  arch/arm64/crypto/sm3-ce-glue.c | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index addfa413650b..2a965aa0188d 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -45,7 +45,7 @@ config CRYPTO_SM3_ARM64_CE
>  	tristate "SM3 digest algorithm (ARMv8.2 Crypto Extensions)"
>  	depends on KERNEL_MODE_NEON
>  	select CRYPTO_HASH
> -	select CRYPTO_SM3
> +	select CRYPTO_LIB_SM3
>  
>  config CRYPTO_SM4_ARM64_CE
>  	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
> diff --git a/arch/arm64/crypto/sm3-ce-glue.c b/arch/arm64/crypto/sm3-ce-glue.c
> index d71faca322f2..3198f31c9446 100644
> --- a/arch/arm64/crypto/sm3-ce-glue.c
> +++ b/arch/arm64/crypto/sm3-ce-glue.c
> @@ -27,7 +27,7 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
>  			 unsigned int len)
>  {
>  	if (!crypto_simd_usable())
> -		return crypto_sm3_update(desc, data, len);
> +		return sm3_update(shash_desc_ctx(desc), data, len);
>  
>  	kernel_neon_begin();
>  	sm3_base_do_update(desc, data, len, sm3_ce_transform);
> @@ -39,7 +39,7 @@ static int sm3_ce_update(struct shash_desc *desc, const u8 *data,
>  static int sm3_ce_final(struct shash_desc *desc, u8 *out)
>  {
>  	if (!crypto_simd_usable())
> -		return crypto_sm3_finup(desc, NULL, 0, out);
> +		return sm3_final(shash_desc_ctx(desc), out);
>  
>  	kernel_neon_begin();
>  	sm3_base_do_finalize(desc, sm3_ce_transform);
> @@ -51,14 +51,22 @@ static int sm3_ce_final(struct shash_desc *desc, u8 *out)
>  static int sm3_ce_finup(struct shash_desc *desc, const u8 *data,
>  			unsigned int len, u8 *out)
>  {
> -	if (!crypto_simd_usable())
> -		return crypto_sm3_finup(desc, data, len, out);
> +	if (!crypto_simd_usable()) {
> +		struct sm3_state *sctx = shash_desc_ctx(desc);
> +
> +		if (len)
> +			sm3_update(sctx, data, len);
> +		sm3_final(sctx, out);
> +		return 0;
> +	}
>  
>  	kernel_neon_begin();
> -	sm3_base_do_update(desc, data, len, sm3_ce_transform);
> +	if (len)
> +		sm3_base_do_update(desc, data, len, sm3_ce_transform);
> +	sm3_base_do_finalize(desc, sm3_ce_transform);
>  	kernel_neon_end();
>  
> -	return sm3_ce_final(desc, out);
> +	return sm3_base_finish(desc, out);
>  }
>  
>  static struct shash_alg sm3_alg = {
>You have modified the implementation of SM3 algorithm, so what benefits will be gained
after such modification?
What flaws are solved or can performance be improved?
Thanks.
Longfang.
