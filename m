Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3D4CC5F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiCCTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCCTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:22:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1719D61E;
        Thu,  3 Mar 2022 11:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1895261A05;
        Thu,  3 Mar 2022 19:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FFBC004E1;
        Thu,  3 Mar 2022 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646335295;
        bh=trgVHyCtfDd4sh/3BteU8XpwMHMv2ENMdJz2RE0AFpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNeZhbRBisdlpiBay+maESK2KZYQ7pAjcepR+j7StEctf7d3gVG4cHCUssG0XA1CZ
         VkCFCm91GtgaepI/qI0Xvjhgs6M112ZGYxSlKGDRSJi/ArboT/n2B9CVW1V7l14lY4
         1gng4MQ1QW2y78sYBSHI/1KA6nFdtPgP1LTDGFc2XXzug6Wk43yENU7LxI/WLZtMWk
         4zTLd+yCyuFIfPlRwzTfrowIhLmimk7aspGHrJKV2Vd2V0tjFQurfMJphE5mEjL++g
         AqD2nBwlHJpuLWacQIbqaaEfIRZcfg17236qFMTLRL7GINK4Zwgje88HLsTK6IeD8j
         eSqSsyEniYclA==
Date:   Thu, 3 Mar 2022 19:21:33 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YiEVPc2cd38AnLZB@gmail.com>
References: <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
 <Yh9G7FyCLtsm2mFA@kroah.com>
 <Yh9ZvLHuztwQCu0d@silpixa00400314>
 <Yh+FpKuoyj3G16lK@kroah.com>
 <Yh/vY4t3xnuoCW3Q@gondor.apana.org.au>
 <Yh/yr6oB5yeOUErL@silpixa00400314>
 <Yh/znCnZzWaL49+o@gondor.apana.org.au>
 <YiDHT31ujlGdQEe/@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDHT31ujlGdQEe/@silpixa00400314>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 01:49:03PM +0000, Giovanni Cabiddu wrote:
> On Thu, Mar 03, 2022 at 10:45:48AM +1200, Herbert Xu wrote:
> > On Wed, Mar 02, 2022 at 10:42:20PM +0000, Giovanni Cabiddu wrote:
> > >
> > > I was thinking, as an alternative, to lower the cra_priority in the QAT
> > > driver for the algorithms used by dm-crypt so they are not used by
> > > default.
> > > Is that a viable option?
> > 
> > Yes I think that should work too.
> The patch below implements that solution and applies to linux-5.4.y.
> If it is ok, I can send it to stable for all kernels <= 5.4 following
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> 
> ---8<---
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Date: Thu, 3 Mar 2022 11:54:07 +0000
> Subject: [PATCH] crypto: qat - drop priority of algorithms
> Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
> 
> The implementations of aead and skcipher in the QAT driver are not
> properly supporting requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
> If the HW queue is full, the driver returns -EBUSY but does not enqueue
> the request.
> This can result in applications like dm-crypt waiting indefinitely for a
> completion of a request that was never submitted to the hardware.
> 
> To mitigate this problem, reduce the priority of all skcipher and aead
> implementations in the QAT driver so they are not used by default.
> 
> This patch deviates from the original upstream solution, that prevents
> dm-crypt to use drivers registered with the flag
> CRYPTO_ALG_ALLOCATES_MEMORY, since a backport of that set to stable
> kernels may have a too wide effect.
> 
> commit 7bcb2c99f8ed032cfb3f5596b4dccac6b1f501df upstream
> commit 2eb27c11937ee9984c04b75d213a737291c5f58c upstream
> commit fbb6cda44190d72aa5199d728797aabc6d2ed816 upstream
> commit b8aa7dc5c7535f9abfca4bceb0ade9ee10cf5f54 upstream
> commit cd74693870fb748d812867ba49af733d689a3604 upstream
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/crypto/qat/qat_common/qat_algs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
> index 6b8ad3d67481..a5c28a08fd8c 100644
> --- a/drivers/crypto/qat/qat_common/qat_algs.c
> +++ b/drivers/crypto/qat/qat_common/qat_algs.c
> @@ -1274,7 +1274,7 @@ static struct aead_alg qat_aeads[] = { {
>  	.base = {
>  		.cra_name = "authenc(hmac(sha1),cbc(aes))",
>  		.cra_driver_name = "qat_aes_cbc_hmac_sha1",
> -		.cra_priority = 4001,
> +		.cra_priority = 1,
>  		.cra_flags = CRYPTO_ALG_ASYNC,
>  		.cra_blocksize = AES_BLOCK_SIZE,
>  		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
> @@ -1291,7 +1291,7 @@ static struct aead_alg qat_aeads[] = { {
>  	.base = {
>  		.cra_name = "authenc(hmac(sha256),cbc(aes))",
>  		.cra_driver_name = "qat_aes_cbc_hmac_sha256",
> -		.cra_priority = 4001,
> +		.cra_priority = 1,
>  		.cra_flags = CRYPTO_ALG_ASYNC,
>  		.cra_blocksize = AES_BLOCK_SIZE,
>  		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
> @@ -1308,7 +1308,7 @@ static struct aead_alg qat_aeads[] = { {
>  	.base = {
>  		.cra_name = "authenc(hmac(sha512),cbc(aes))",
>  		.cra_driver_name = "qat_aes_cbc_hmac_sha512",
> -		.cra_priority = 4001,
> +		.cra_priority = 1,
>  		.cra_flags = CRYPTO_ALG_ASYNC,
>  		.cra_blocksize = AES_BLOCK_SIZE,
>  		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
> @@ -1326,7 +1326,7 @@ static struct aead_alg qat_aeads[] = { {
>  static struct crypto_alg qat_algs[] = { {
>  	.cra_name = "cbc(aes)",
>  	.cra_driver_name = "qat_aes_cbc",
> -	.cra_priority = 4001,
> +	.cra_priority = 1,
>  	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
>  	.cra_blocksize = AES_BLOCK_SIZE,
>  	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),
> @@ -1348,7 +1348,7 @@ static struct crypto_alg qat_algs[] = { {
>  }, {
>  	.cra_name = "ctr(aes)",
>  	.cra_driver_name = "qat_aes_ctr",
> -	.cra_priority = 4001,
> +	.cra_priority = 1,
>  	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
>  	.cra_blocksize = 1,
>  	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),
> @@ -1370,7 +1370,7 @@ static struct crypto_alg qat_algs[] = { {
>  }, {
>  	.cra_name = "xts(aes)",
>  	.cra_driver_name = "qat_aes_xts",
> -	.cra_priority = 4001,
> +	.cra_priority = 1,
>  	.cra_flags = CRYPTO_ALG_TYPE_ABLKCIPHER | CRYPTO_ALG_ASYNC,
>  	.cra_blocksize = AES_BLOCK_SIZE,
>  	.cra_ctxsize = sizeof(struct qat_alg_ablkcipher_ctx),
> 
> base-commit: 866ae42cf4788c8b18de6bda0a522362702861d7
> -- 
> 2.35.1
> 

If these algorithms have critical bugs, which it appears they do, then IMO it
would be better to disable them (either stop registering them, or disable the
whole driver) than to leave them available with low cra_priority.  Low
cra_priority doesn't guarantee that they aren't used.

- Eric
