Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7B4D51A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiCJShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiCJShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:37:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2DB19D630;
        Thu, 10 Mar 2022 10:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4890E61E79;
        Thu, 10 Mar 2022 18:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE8FC340E8;
        Thu, 10 Mar 2022 18:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646937408;
        bh=RdgCysgl6dR7J0j7duKi30HlTSNbetlrjcptAA8yIP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORaAk5KDQ7MKF/ON/55HLWHpH4hL8dCDmsb+0tiseGNVUI7173pEQRS2YRjDFuP2d
         g8voDYpZnRnm6Hlf9R7Ql/GPkOSM56Jfkhq/MXjURxh9/Ikr4UNUstBWB8objSCEGv
         YDdg4YOl/OwUFVwmSjIM8h4lxYXLDbnXd/05buJtiyPxJ6fnhqL6afwtEAxWnfbDWK
         XfqNfUFABIZ8dfrnkccAs1AfHA5Ooo/nwVEcdv5fPuelqf3m2qThPB7ZTDk5tBiCF3
         lXwmN1oxcs+ruTpO0WT/iQgjJWF/goswaST0dk4R3X/7Rh5BwzJrB3X+NkMXBQRZZg
         v0pnRLNb5v6+A==
Date:   Thu, 10 Mar 2022 18:36:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <YipFP8B8MxMxTVBR@gmail.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
 <YikEs7RNgPXTQolv@gmail.com>
 <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:39:59AM -0800, Keith Busch wrote:
> On Wed, Mar 09, 2022 at 07:49:07PM +0000, Eric Biggers wrote:
> > The issue is that every other "shash" algorithm besides crct10dif, including
> > crc32 and crc32c, follow the convention of treating the digest as bytes.  Doing
> > otherwise is unusual for the crypto API.  So I have a slight preference for
> > treating it as bytes.  Perhaps see what Herbert Xu (maintainer of the crypto
> > API, Cc'ed) recommends?
> 
> I'm okay either way, they're both simple enough. Here is an update atop
> this series to match the other shash conventions if this is preferred
> over my previous fix:
> 
> ---
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 914d8cddd43a..f9eb45571bc7 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -282,7 +282,7 @@ EXPORT_SYMBOL(t10_pi_type3_ip);
>  
>  static __be64 ext_pi_crc64(void *data, unsigned int len)
>  {
> -	return cpu_to_be64(crc64_rocksoft(data, len));
> +	return cpu_to_be64(le64_to_cpu(crc64_rocksoft(data, len)));
>  }
>  
>  static blk_status_t ext_pi_crc64_generate(struct blk_integrity_iter *iter,
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index f1a22794c404..f9e5f601c657 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -3686,11 +3686,11 @@ static const struct hash_testvec crc64_rocksoft_tv_template[] = {
>  	{
>  		.plaintext	= zeroes,
>  		.psize		= 4096,
> -		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
> +		.digest		= "\x4e\xb6\x22\xeb\x67\xd3\x82\x64",
>  	}, {
>  		.plaintext	= ones,
>  		.psize		= 4096,
> -		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
> +		.digest		= "\xac\xa3\xec\x02\x73\xba\xdd\xc0",
>  	}
>  };
>  
> diff --git a/include/linux/crc64.h b/include/linux/crc64.h
> index e044c60d1e61..5319f9a9fc19 100644
> --- a/include/linux/crc64.h
> +++ b/include/linux/crc64.h
> @@ -12,7 +12,7 @@
>  u64 __pure crc64_be(u64 crc, const void *p, size_t len);
>  u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
>  
> -u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
> -u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
> +__le64 crc64_rocksoft(const unsigned char *buffer, size_t len);
> +__le64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);
>  
>  #endif /* _LINUX_CRC64_H */
> diff --git a/lib/crc64-rocksoft.c b/lib/crc64-rocksoft.c
> index fc9ae0da5df7..215acb79a15d 100644
> --- a/lib/crc64-rocksoft.c
> +++ b/lib/crc64-rocksoft.c
> @@ -54,16 +54,16 @@ static struct notifier_block crc64_rocksoft_nb = {
>  	.notifier_call = crc64_rocksoft_notify,
>  };
>  
> -u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
> +__le64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
>  {
>  	struct {
>  		struct shash_desc shash;
> -		u64 crc;
> +		__le64 crc;
>  	} desc;
>  	int err;
>  
>  	if (static_branch_unlikely(&crc64_rocksoft_fallback))
> -		return crc64_rocksoft_generic(crc, buffer, len);
> +		return cpu_to_le64(crc64_rocksoft_generic(crc, buffer, len));
>  
>  	rcu_read_lock();
>  	desc.shash.tfm = rcu_dereference(crc64_rocksoft_tfm);
> @@ -77,7 +77,7 @@ u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(crc64_rocksoft_update);
>  
> -u64 crc64_rocksoft(const unsigned char *buffer, size_t len)
> +__le64 crc64_rocksoft(const unsigned char *buffer, size_t len)
>  {
>  	return crc64_rocksoft_update(0, buffer, len);
>  }
> --

I think the lib functions should still use native endianness, like what crc32
does.

- Eric
