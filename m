Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE95E56D300
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGKCe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:34:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EBADF36;
        Sun, 10 Jul 2022 19:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56156104F;
        Mon, 11 Jul 2022 02:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE78C3411E;
        Mon, 11 Jul 2022 02:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657506894;
        bh=weipIFQYReWTUKQ8HLFhld62fDRiI13OW1xTRijDdlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6FbwByUpFESDiGzaDrNYqm2RcQpwk9FVw8jxE5+A8VoS9lD7eyIlI1LBjK+I/PAU
         HXwlADcf5kF45Ve8uBbcBw+IY6XLgMz6xbXrrVRG1tBee0PEnK6E3jNRRK7iyau3yC
         LPvQkTUatnKbZersHliHs8GsvdLDMJFwcu2KIP61TzNKi6eJhyUBGJIMsWo6zyysXL
         indIlQHCWZwgGTsvwSX0sQux7mgfuqfhpej7qIP9W+2CaFWIu0ulllAIunT6GUcWoQ
         HlA4yP6E5XbBefmxAMl8bVW7Jy6KOthJcXSMYmsNkc+ZMKTfVDvr17tlH5ozcZ2arp
         /jXD1v853XDRg==
Date:   Mon, 11 Jul 2022 05:34:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <YsuMK0JIYqqjtVdk@kernel.org>
References: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:36:48AM -0700, Dave Hansen wrote:
> Short Version:
> 
> Allow enclaves to use the new Asynchronous EXit (AEX)
> notification mechanism.  This mechanism lets enclaves run a
> handler after an AEX event.  These handlers can run mitigations
> for things like SGX-Step[1].
> 
> AEX Notify will be made available both on upcoming processors and
> on some older processors through microcode updates.
> 
> Long Version:
> 
> == SGX Attribute Background ==
> 
> The SGX architecture includes a list of SGX "attributes".  These
> attributes ensure consistency and transparency around specific
> enclave features.
> 
> As a simple example, the "DEBUG" attribute allows an enclave to
> be debugged, but also destroys virtually all of SGX security.
> Using attributes, enclaves can know that they are being debugged.
> Attributes also affect enclave attestation so an enclave can, for
> instance, be denied access to secrets while it is being debugged.
> 
> The kernel keeps a list of known attributes and will only
> initialize enclaves that use a known set of attributes.  This
> kernel policy eliminates the chance that a new SGX attribute
> could cause undesired effects.
> 
> For example, imagine a new attribute was added called
> "PROVISIONKEY2" that provided similar functionality to
> "PROVISIIONKEY".  A kernel policy that allowed indiscriminate use
> of unknown attributes and thus PROVISIONKEY2 would undermine the
> existing kernel policy which limits use of PROVISIONKEY enclaves.
> 
> == AEX Notify Background ==
> 
> "Intel Architecture Instruction Set Extensions and Future
> Features - Version 45" is out[2].  There is a new chapter:
> 
> 	Asynchronous Enclave Exit Notify and the EDECCSSA User Leaf Function.
> 
> Enclaves exit can be either synchronous and consensual (EEXIT for
> instance) or asynchronous (on an interrupt or fault).  The
> asynchronous ones can evidently be exploited to single step
> enclaves[1], on top of which other naughty things can be built.
> 
> AEX Notify will be made available both on upcoming processors and
> on some older processors through microcode updates.
> 
> == The Problem ==
> 
> These attacks are currently entirely opaque to the enclave since
> the hardware does the save/restore under the covers. The
> Asynchronous Enclave Exit Notify (AEX Notify) mechanism provides
> enclaves an ability to detect and mitigate potential exposure to
> these kinds of attacks.
> 
> == The Solution ==
> 
> Define the new attribute value for AEX Notification.  Ensure the
> attribute is cleared from the list reserved attributes which
> allows it to be used in enclaves.
> 
> I just built this and ran it to make sure there were no obvious
> regressions since I do not have the hardware to test it handy.
> Tested-by's would be much appreciated.

Is this available on recent ucode updates e.g. for Icelake
or Geminilake?

> 
> 1. https://github.com/jovanbulck/sgx-step
> 2. https://cdrdv2.intel.com/v1/dl/getContent/671368?explicitVersion=true
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-sgx@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/sgx.h | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index 3f9334ef67cd..f7328d8efd83 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -110,17 +110,28 @@ enum sgx_miscselect {
>   * %SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used to
>   *				sign cryptographic tokens that can be passed to
>   *				EINIT as an authorization to run an enclave.
> + * %SGX_ATTR_ASYNC_EXIT_NOTIFY:	Allow enclaves to be notified after an
> + *				asynchronous exit has occurred.
>   */
>  enum sgx_attribute {
> -	SGX_ATTR_INIT		= BIT(0),
> -	SGX_ATTR_DEBUG		= BIT(1),
> -	SGX_ATTR_MODE64BIT	= BIT(2),
> -	SGX_ATTR_PROVISIONKEY	= BIT(4),
> -	SGX_ATTR_EINITTOKENKEY	= BIT(5),
> -	SGX_ATTR_KSS		= BIT(7),
> +	SGX_ATTR_INIT		   = BIT(0),
> +	SGX_ATTR_DEBUG		   = BIT(1),
> +	SGX_ATTR_MODE64BIT	   = BIT(2),
> +				  /* BIT(3) is reserved */
> +	SGX_ATTR_PROVISIONKEY	   = BIT(4),
> +	SGX_ATTR_EINITTOKENKEY	   = BIT(5),
> +				  /* BIT(6) is for CET */
> +	SGX_ATTR_KSS		   = BIT(7),
> +				  /* BIT(8) is reserved */
> +				  /* BIT(9) is reserved */
> +	SGX_ATTR_ASYNC_EXIT_NOTIFY = BIT(10),
>  };
>  
> -#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | BIT_ULL(6) | GENMASK_ULL(63, 8))
> +#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | \
> +				 BIT_ULL(6) | \
> +				 BIT_ULL(8) | \
> +				 BIT_ULL(9) | \
> +				 GENMASK_ULL(63, 11))
>  
>  /**
>   * struct sgx_secs - SGX Enclave Control Structure (SECS)
> -- 
> 2.34.1
> 

BR, Jarkko
