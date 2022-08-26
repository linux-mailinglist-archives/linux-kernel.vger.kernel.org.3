Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0F5A1FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 06:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiHZEoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 00:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiHZEom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 00:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66878CE30C;
        Thu, 25 Aug 2022 21:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0555660FB5;
        Fri, 26 Aug 2022 04:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40104C433C1;
        Fri, 26 Aug 2022 04:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661489080;
        bh=/qspzEQpvcbp3hJR6s8b1je1OdnXOiH08Sq/xM70qmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqpLoKYYmaGOzEVmXuWJiuZh19TWRKgkQNLR/kWHTJcd14EpblihfgpTXp9h+2i55
         wLEpZDehOoo+lHOY7oAD3V0srJNm9RZyndasyy3GABIDWW6V64b3/oTe15zMvlBXH5
         WIojSkCGm4eu1mJcvSjwwk+OY7dlYfxQsr4FeOT5QbxX3v3eskehrJBHdy/c7uMozd
         2IQokFUYD+9HQJ/cux41LLOUjBMr3UbAeqCGhjR/xIxFoJDnPurOV4fwDvzqd8yDPQ
         gHBLKsok+kuPph7/jimOG//LDXJmGYu6mk54DTAZsOLU+yzhc01YjTwSCKu99oWido
         H4VjRXyWBJAwg==
Date:   Thu, 25 Aug 2022 21:44:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 2/3] crypto: lib - move __crypto_xor into utils
Message-ID: <YwhPtnL6yVG0K2Lo@sol.localdomain>
References: <20220725183636.97326-1-ebiggers@kernel.org>
 <20220725183636.97326-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725183636.97326-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert, Jason, and Justin:

On Mon, Jul 25, 2022 at 11:36:35AM -0700, Eric Biggers wrote:
> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index b09d9d6546cbc3..7e9683e9f5c636 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -36,7 +36,7 @@ config CRYPTO_ARCH_HAVE_LIB_CHACHA
>  
>  config CRYPTO_LIB_CHACHA_GENERIC
>  	tristate
> -	select XOR_BLOCKS
> +	select CRYPTO_LIB_UTILS
>  	help
>  	  This symbol can be depended upon by arch implementations of the
>  	  ChaCha library interface that require the generic code as a

Just a heads up; the unnecessary selection of XOR_BLOCKS here (which got
backported to v5.10.120 and v5.15.45 by "lib/crypto: add prompts back to crypto
libraries") can be considered an actual bug, as it increases boot time on
systems that didn't have it selected before.  This is because the code enabled
by XOR_BLOCKS (crypto/xor.c) runs a benchmark, which takes some time.  It
doesn't take *that* long, but it got noticed as a regression nonetheless, and it
needs to be fixed.  My patch series happens to have fixed this, but I didn't
have it mind that it was a real bug fix.

Herbert, any chance that you could send my patch series to Linus without waiting
for the next merge window, so that it can be backported?

- Eric
