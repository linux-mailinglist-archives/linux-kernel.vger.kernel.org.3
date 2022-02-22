Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF774C0268
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiBVTvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiBVTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:51:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C4BB097;
        Tue, 22 Feb 2022 11:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE3D61638;
        Tue, 22 Feb 2022 19:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B671C340F1;
        Tue, 22 Feb 2022 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645559444;
        bh=l639N21A2FrjSs/WG0rCtIuhybcq24CZv4Vtx+UKttk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Irx+SLoYYE4wGSeXxrVOr/7x0kf5CJU/O6kGp1PTQL0PoOg7Y8xTdt4gtt35pqirB
         Fz/7MdwiISDDp7bKfySLsgjR8Qa9A1slwZId5NyeipA/9gw2FoOd3RUN5RBquwzmpW
         TJdyT49+tR9n7os7o6Ksawv/yJzeePn+eb+zPG9rvtRz2JxF9+kpiSUeMHJeMK7vft
         Az4u2xE12wvsP6fTqA2tNXevWSysmu1Bakcg8EC86sjmQEQy04gh+ECR+cm49X6eG4
         y/xN1Z/ZQ5J+meMPKwY9oNMfgvLcirNzLkJ1a/FEK8Y3soyghpccFTKPMsaO61B7y9
         UIo1jhARzPBEw==
Date:   Tue, 22 Feb 2022 11:50:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhU+kuMhueXVQvxe@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163144.1782447-7-kbusch@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> +config CRYPTO_CRC64_ROCKSOFT
> +	tristate "Rocksoft Model CRC64 algorithm"
> +	depends on CRC64
> +	select CRYPTO_HASH
> +	help
> +	  Rocksoft Model CRC64 computation is being cast as a crypto
> +	  transform. This allows for faster crc64 transforms to be used
> +	  if they are available.

The first sentence of this help text doesn't make sense.

> diff --git a/crypto/crc64_rocksoft_generic.c b/crypto/crc64_rocksoft_generic.c
> new file mode 100644
> index 000000000000..55bad1939614
> --- /dev/null
> +++ b/crypto/crc64_rocksoft_generic.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Cryptographic API.

The "Cryptographic API" line doesn't provide any helpful information.

> +static int chksum_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +	*(u64 *)out = ctx->crc;
> +	return 0;
> +}
> +
> +static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
> +{
> +	*(u64 *)out = crc64_rocksoft_generic(crc, data, len);
> +	return 0;
> +}

These 64-bit writes violate alignment rules and will give the wrong result on
big endian CPUs.  They need to use put_unaligned_le64().

> +static int __init crc64_rocksoft_x86_mod_init(void)
> +{
> +	return crypto_register_shash(&alg);
> +}
> +
> +static void __exit crc64_rocksoft_x86_mod_fini(void)
> +{
> +	crypto_unregister_shash(&alg);
> +}

This has nothing to do with x86.

> +config CRC64_ROCKSOFT
> +	tristate "CRC calculation for the Rocksoft^TM model CRC64"

I'm sure what the rules for trademarks are, but kernel source code usually
doesn't have the trademark symbol/abbreviation scattered everywhere.

> +	select CRYPTO
> +	select CRYPTO_CRC64_ROCKSOFT
> +	help
> +	  This option is only needed if a module that's not in the
> +	  kernel tree needs to calculate CRC checks for use with the
> +	  rocksoft model parameters.

Out-of-tree modules can't be the reason to have a kconfig option.  What is the
real reason?

> +u64 crc64_rocksoft(const unsigned char *buffer, size_t len)
> +{
> +	return crc64_rocksoft_update(~0ULL, buffer, len);
> +}
> +EXPORT_SYMBOL(crc64_rocksoft);

Isn't this missing the bitwise inversion at the end?

> +MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");
> +MODULE_DESCRIPTION("Rocksoft model CRC64 calculation (library API)");
> +MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc64");

Shouldn't the MODULE_SOFTDEP be on crc64-rocksoft?

- Eric
