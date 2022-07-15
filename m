Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DB57596D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiGOCEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGOCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C574DD5;
        Thu, 14 Jul 2022 19:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FB9B6215D;
        Fri, 15 Jul 2022 02:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6BFC34114;
        Fri, 15 Jul 2022 02:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657850676;
        bh=T5cx66giqRHD/M2J3VS/IjY4MsMXAcUtPtvqcYvotRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNP1BFE1UgxEMi7s3CC43G7oNXDrZtgPVSj7ZGzdVhiNDedeV9/IMFJPc5+XiglrQ
         zD22B0i1/NvwQyhhVtVGwxIk+j184DM3PGrZXS9hsP5REZ6Jrhhq84htKT7Lgshd+w
         ouQAqOZFNyhuXz3JnV/8igGmsTZInp1PhuHCFAAYX2hcnWMwyFucDyA6NmkKQ1lpPT
         WwGxctVbBfa4A18zljDP/MCNKliLK8CtWcrI9IxjWLFjmeQnYj+mgVye7U8wtkHlJP
         14mxDoUyxmXvV5hQUjPEwxTOuShUg1ZZh2xzsO+9izHH01owgJCuH2ziP67f0fSCgG
         gS0iSgS5auJpQ==
Date:   Thu, 14 Jul 2022 19:04:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: lib/arc4 - expose library interface
Message-ID: <YtDLMmwffn6p/rSV@sol.localdomain>
References: <20220714051221.22525-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714051221.22525-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:12:21AM +0200, Christian Marangi wrote:
> Permit to compile the arc4 crypto lib without any user. This is required
> by the backports project [1] that require this lib for any wireless
> driver.
> 
> [1] https://backports.wiki.kernel.org/index.php/Main_Page
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  lib/crypto/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index 2082af43d51f..2dfc785a7817 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -6,7 +6,11 @@ config CRYPTO_LIB_AES
>  	tristate
>  
>  config CRYPTO_LIB_ARC4
> -	tristate
> +	tristate "ARC4 library interface"
> +	help
> +	  Enable the ARC4 library interface. This interface is mainly
> +	  used by wireless drivers and is required by the backports
> +	  project.
>  
>  config CRYPTO_ARCH_HAVE_LIB_BLAKE2S
>  	bool

I don't think this is appropriate for upstream, as the upstream kernel doesn't
support out-of-tree code.  This is also an internal API that can change from one
kernel version to the next.

- Eric
