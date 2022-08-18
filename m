Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3E597DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiHREn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHREnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701B30561;
        Wed, 17 Aug 2022 21:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F56615F0;
        Thu, 18 Aug 2022 04:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27953C433C1;
        Thu, 18 Aug 2022 04:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660797830;
        bh=gSsFoI1AWK9CL15kE39tUDBOoWa4JqW6oofu4Wo28R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBfInsjffYZ5f1LvRk5vVrkWPQUZSJ/MWcr160ssyag9KNKcuXYqDoPF7Kn2c9mS5
         jvTzlwWA0LKHKG8BhF7lVl194p0Rfa4ISJZKPXVQzmTDNU/atrMoPtvdGnh2uS1CBI
         dDvrX3gnrvm2My+7El5vge2U9uC9XBZQ+rfS0zqFwvTr4hoYPrRSqD+wKOkziXRswn
         4kyAxITHpC7WtZ7YcWFq2lW9erYCMWSpjLX7yNSbWcp/OdcZT5UFH4VFPMkQ5A+dVI
         YAZZEWeQXqc/V+SgXV6SKwTmNrOr58oA7PrvG+Lk7TZdkAQT/5IHSTzoRLgJjQkizs
         RLkSrOJeburHQ==
Date:   Wed, 17 Aug 2022 21:43:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] crypto: Kconfig - add submenus
Message-ID: <Yv3DhH7WkhNPnqMu@sol.localdomain>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
 <20220817232057.73643-11-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817232057.73643-11-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:20:57PM -0500, Robert Elliott wrote:
> Convert each comment section into a submenu:
> Cryptographic API
>     Crypto core or helper
>     Public-key cryptography
>     AEAD (Authenticated Encryption with Associated Data) ciphers
>     Block modes
>     Hash modes
>     Digests
>     Ciphers
>     Compression
>     Random Number Generation
>     User-space interface

Thanks for doing this!

Some of these proposed categories are confusing.  By "hash mode" you mean a mode
that operates as a hash, not that uses a hash, right?  (CMAC is included.)  So
what is "block mode", then?  And what's the difference between that and
"ciphers"?  What about modes that use both a hash and a block cipher, like
Adiantum and HCTR2?  And there is a category for "Ciphers", but then a category
at the same level for "AEAD ciphers"?

Some of the naming used in the code is poor, which is unfortunate and is not
your fault, e.g. crypto_cipher really should be crypto_blockcipher.  But this
doesn't need to be carried through in these new menus.

Just brainstorming, how about the following:

	* Block ciphers
		=> i.e. crypto_cipher algorithms
	* AEAD (Authenticated Encryption with Associated Data) ciphers
		=> i.e. crypto_aead algorithms (and templates)
	* Length-preserving symmetric ciphers
		=> i.e. crypto_skcipher algorithms (and templates)
	* Digests and MACs
		=> i.e. crypto_shash and crypto_ahash algorithms (and templates)

Those 4 categories would replace your 5 categories "AEAD ciphers",
"Block modes", "Hash modes", "Digests", and "Ciphers".

CRYPTO_AUTHENC would go in the AEAD ciphers category, while CRYPTO_ESSIV would
go in length-preserving symmetric ciphers.  (CRYPTO_ESSIV registers a
crypto_aead too, for a weird reason, but that is an obscure case not worth
worrying about.) CRYPTO_CHACHA would go in length-preserving symmetric ciphers
since it's a stream cipher.

- Eric
