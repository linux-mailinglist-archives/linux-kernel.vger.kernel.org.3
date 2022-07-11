Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4556D23B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGKAgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:36:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881E63DF;
        Sun, 10 Jul 2022 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=PZ48ag4JsCJQwRf+bGkFcTAC/I8X5hdkoFIm/OJJqOE=; b=BGeIGUudIIh6JnnOm+nhW7z+Fl
        aLMSr+BXpol0PJ9z/jpE8TZOKuMFgrb2DPWDhhDrjY6pQ1DyVFmiR7Z0kmks1/oPKE6MGCNmmLAzv
        pK7Lk6IWPf93mBLveSh6mzxDS5f4bpku5JPt3907ZECgH5gHvmslhaXDmnZWPyemOl2IJ0KSB+51i
        I9V3iz/6XWOUPdOMc/NR4mfum7E5VY8S9uuGTz8sk9nQJxBsK+LOgnpydSxFtowmTn/hSFRYuz60X
        Fnni/wt8jatkNh3SKdAF+a4hifDKFljVr1jherHR+M5quuI4S/wlCqS9XjM+ovaFbAARyqaqQI+AA
        khTu8akA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAhPB-00EmFp-Lw; Mon, 11 Jul 2022 00:36:05 +0000
Message-ID: <b707a74b-48ca-5547-3d07-8aa05be0c132@infradead.org>
Date:   Sun, 10 Jul 2022 17:36:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] certs: Fix Kconfig dependency
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, simo@redhat.com
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220704112028.183193-1-renzhijie2@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220704112028.183193-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/22 04:20, Ren Zhijie wrote:
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
>  crypto/asymmetric_keys/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 3df3fe4ed95f..fe007db96c69 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
>  	  for FIPS.
>  	depends on KEYS
>  	depends on ASYMMETRIC_KEY_TYPE
> -	depends on PKCS7_MESSAGE_PARSER
> +	depends on PKCS7_MESSAGE_PARSER=y
>  
>  endif # ASYMMETRIC_KEY_TYPE

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Reported-by: kernel test robot <lkp@intel.com> # 2022-06-30

thanks.

-- 
~Randy
