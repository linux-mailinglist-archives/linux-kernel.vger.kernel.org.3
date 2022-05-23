Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5C531BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiEWT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEWT7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BCE7890D;
        Mon, 23 May 2022 12:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477F86140D;
        Mon, 23 May 2022 19:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9F2C385AA;
        Mon, 23 May 2022 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653335942;
        bh=ud5Q/1QhrPDGlv6dQdDPoIxkp3EA8jcR1Hd6nj1gp08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D72Ht9YY2Hp4/RJAt+daNZjCRg4xXJsw7S5wfeWwtqOZojOBnvMrtvJCaLSDaL7vJ
         EAaUf3z2/UENUCDoYMQLOXvTQ0mPW6DQLRrhYIsDrKGsFl4i9El6n/xoI4Z+1JQFDk
         NnvwOcUGCW9wwl8YS6+qaa+/U8BNh3CTsTQIpIYRwdrEMKqkC1s2ard1uPQ1v1zuxx
         Av+ChXwVii7EQFOcImDCFOWZ+nCM3ugRoj1UVKEBUWpGJN24FeuchH7KZ+Qf45UiGE
         jSkasldeUD/h24Q0yLpiCQN2PoHAUaY+TjJpWXxoMZd+soG+3mlnchhMe2npl533Z+
         KiR3u3BK4uhcg==
Date:   Mon, 23 May 2022 22:57:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: linux-next: manual merge of the tpmdd tree with the crypto tree
Message-ID: <YovnISBB4Y3DGYiW@kernel.org>
References: <20220520165701.14224ddb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520165701.14224ddb@canb.auug.org.au>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 04:57:01PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tpmdd tree got a conflict in:
> 
>   drivers/crypto/caam/Kconfig
> 
> between commit:
> 
>   0aa6ac7795ca ("crypto: caam/rng - Add support for PRNG")
> 
> from the crypto tree and commit:
> 
>   5e785783ddb0 ("crypto: caam - add in-kernel interface for blob generator")
> 
> from the tpmdd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/crypto/caam/Kconfig
> index 0aa52b612a01,ea9f8b1ae981..000000000000
> --- a/drivers/crypto/caam/Kconfig
> +++ b/drivers/crypto/caam/Kconfig
> @@@ -151,14 -151,9 +151,17 @@@ config CRYPTO_DEV_FSL_CAAM_RNG_AP
>   	  Selecting this will register the SEC4 hardware rng to
>   	  the hw_random API for supplying the kernel entropy pool.
>   
>  +config CRYPTO_DEV_FSL_CAAM_PRNG_API
>  +	bool "Register Pseudo random number generation implementation with Crypto API"
>  +	default y
>  +	select CRYPTO_RNG
>  +	help
>  +	  Selecting this will register the SEC hardware prng to
>  +	  the Crypto API.
>  +
> + config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
> + 	bool
> + 
>   endif # CRYPTO_DEV_FSL_CAAM_JR
>   
>   endif # CRYPTO_DEV_FSL_CAAM

Herbert, so I pulled the whole patch set. How should we work out this?

I sent PR before seeing this:

https://lore.kernel.org/linux-integrity/20220523165744.48234-1-jarkko@kernel.org/T/#u

BR, Jarkko
