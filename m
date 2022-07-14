Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630C8574ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiGNNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiGNNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:19:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3615A2D6;
        Thu, 14 Jul 2022 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657804777; x=1689340777;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=MlovTKwdv4vyOzzEPdprXX3mxaB1TZB0fD8qqF0s5OY=;
  b=KJ/uAkLHjE36UkJ1ARKNSf+j6fn7nWNXc2ZoUnCQ+ZEmyk23KkcWbGi2
   7AVN0m1UV4JYk9U6LPQN3y9UcZFNtFHEIyU4Lgn/cGXzZ0txye23ZB5KO
   dZvP0Rcfvn8at2clLNv8jOkTk+OUN2hsreB/iAzLroxlPkE2nfseNFLVl
   V0zeCQyG+rCpI9DxSIbv/Mf9VQAbYtXMcrCdTJTlokaiXrHQ647sTrj2H
   w+hlIqToDn5Zkjtl8fTsyfAQ2WjFri9dxZfPnIL3LNJ+wGJWzb3i//vtT
   oFxVnBftlm1Eqk2p8yDWSWmRAjmYcZ+S/wtdFp+2Ua4JIurKDL1J4kYuM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="283064623"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="283064623"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:19:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="653870234"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.123.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 14 Jul 2022 06:19:36 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-kernel@vger.kernel.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Cc:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
References: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
Date:   Thu, 14 Jul 2022 08:19:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1pasmtstwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave

I think you need add this change in arch/x86/kernel/cpu/sgx/ioctl.c,  
inside sgx_encl_create function:

-	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |  
SGX_ATTR_KSS;
+	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |  
SGX_ATTR_KSS | SGX_ATTR_ASYNC_EXIT_NOTIFY;

Otherwise, EINIT ioctl fails with this new attribute set in enclave secs.


Thanks
Haitao
On Tue, 05 Jul 2022 13:36:48 -0500, Dave Hansen  
<dave.hansen@linux.intel.com> wrote:

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
>   * %SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used  
> to
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
> -#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | BIT_ULL(6) |  
> GENMASK_ULL(63, 8))
> +#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | \
> +				 BIT_ULL(6) | \
> +				 BIT_ULL(8) | \
> +				 BIT_ULL(9) | \
> +				 GENMASK_ULL(63, 11))
> /**
>   * struct sgx_secs - SGX Enclave Control Structure (SECS)
