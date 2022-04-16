Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF75045BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 01:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiDPXIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 19:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiDPXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 19:08:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FD2A730;
        Sat, 16 Apr 2022 16:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9731BB8068A;
        Sat, 16 Apr 2022 23:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF475C385A1;
        Sat, 16 Apr 2022 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650150359;
        bh=HpJTWn8rxtUvc2Uu9L51I1bEMCgj7T0IW46gNpnpj7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdOc9VUw2V0PUM/e7qmNJi+t1Xi/1kWnT5NM9AglczIaO/xqg31+Vfljl4TQCpPTu
         SkxOfizLJ27x+afCUtRE66UBenFyFwIf7oA8B5Bl51ngB9i3gTTQauqxvxT0tU7Llj
         zAlZ63LrjIfgz0rVGZx01ZsjmDFL+bjODaAHpwcz65qB6BOEk0kMkqoFbb9kI3SfaH
         ChW9U5o4UCSID+Sykc4JI0W3tj+ZNkM2PlSQqRW50Ntx0X3eqEhNfRRESngMKJyLyr
         i9EQieKUV34lhbCaFICG9CfAPPKGsqBfbWJuT3h9Qti/ul9XV9a2V5K+IJdmo97360
         jd+SDSgkiCsLQ==
Date:   Sat, 16 Apr 2022 16:05:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     broonie@kernel.org, ndesaulniers@google.com,
        paul.kocialkowski@bootlin.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] spi: initialize status to success
Message-ID: <YltL1RXdeO82s/bR@dev-arch.thelio-3990X>
References: <20220416205132.295779-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416205132.295779-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 04:51:32PM -0400, Tom Rix wrote:
> Clang static analysis reports this issue
> spi.c:3583:2: warning: 2nd function call argument
>   is an uninitialized value
>   trace_spi_setup(spi, status);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It is possible that status is never set because
> its function level setting was removed by the
> commit listed in the Fixes: tag.
> 
> Assume that setting 8 bits-per-word is ok and
> initialize the status to 0.
> 
> Fixes: b3fe2e516741 ("spi: core: Only check bits_per_word validity when explicitly provided")
> Signed-off-by: Tom Rix <trix@redhat.com>

I am very surprised that -Wsometimes-uninitialized does not trigger
here, as this instance does not require interprocedural analysis, right?
status is not passed by reference as far as I can tell and it is only
initialized in if statements now but it is unconditionally used at the
end of the function. Maybe it does not matter too much, given that
auto-initialization is turned on by default when supported.

Regardless, this fix looks fine. I do not really like initializing
variables at the top of the function as it can hide error codes but it
is always a maintainer preference anyways so:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/spi/spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 563a56ce34a0..890ff46c784a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -3475,7 +3475,7 @@ static int __spi_validate_bits_per_word(struct spi_controller *ctlr,
>  int spi_setup(struct spi_device *spi)
>  {
>  	unsigned	bad_bits, ugly_bits;
> -	int		status;
> +	int		status = 0;
>  
>  	/*
>  	 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
> -- 
> 2.27.0
> 
