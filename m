Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97434C178A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242376AbiBWPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiBWPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:46:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB813C084A;
        Wed, 23 Feb 2022 07:45:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0451B820C9;
        Wed, 23 Feb 2022 15:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D30AC340E7;
        Wed, 23 Feb 2022 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645631130;
        bh=kZDlRKaFrJs14SSOER1lGpAd5UKzlhkkD+Hu55Em64Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVZ9owF+aJ2CIrk6HV782/IIKB+VWHDzca7DNV+C8FVvbSSphQHEc+Oea2BKckmH8
         BH5i4PaOkM6KtkbGGn9z/Rch672B9vYXhcrb8Kfw/iRdeuFnBI7/nonYBp/1qDCUep
         bPtFhwX/e2sw7HKoqFVpiw2QWkFVPSeN5SfCCnhnaerrImvm2Dj9iSqLYweSYBH7zG
         MSrPQZbHzk4QqT+NF4B5GJo3/415QrvBwRho8jjxNFXSfFjRhwMmRwn7p6+5vzcfXC
         X/a1Y3Vc8aLQAu0zu+y1hShrr58z1IqMo9b87j/XDXuSoiSk4oiUgLwYolNfXZQKvQ
         DGm9fs0ca7Bxw==
Date:   Wed, 23 Feb 2022 16:46:04 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <YhZWvFSuax2GI9cQ@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <d6a5c304-d448-5f0c-6367-26dcba872db3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a5c304-d448-5f0c-6367-26dcba872db3@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 10:35:04AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 2/20/2022 4:49 PM, Jarkko Sakkinen wrote:
> > On Mon, Feb 07, 2022 at 04:45:38PM -0800, Reinette Chatre wrote:
> 
> ...
> 
> >> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> >> index 5c678b27bb72..b0ffb80bc67f 100644
> >> --- a/arch/x86/include/uapi/asm/sgx.h
> >> +++ b/arch/x86/include/uapi/asm/sgx.h
> >> @@ -31,6 +31,8 @@ enum sgx_page_flags {
> >>  	_IO(SGX_MAGIC, 0x04)
> >>  #define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
> >>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
> >> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> >> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
> >>  
> >>  /**
> >>   * struct sgx_enclave_create - parameter structure for the
> >> @@ -95,6 +97,25 @@ struct sgx_enclave_relax_perm {
> >>  	__u64 count;
> >>  };
> >>  
> >> +/**
> >> + * struct sgx_enclave_restrict_perm - parameters for ioctl
> >> + *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> >> + * @offset:	starting page offset (page aligned relative to enclave base
> >> + *		address defined in SECS)
> >> + * @length:	length of memory (multiple of the page size)
> >> + * @secinfo:	address for the SECINFO data containing the new permission bits
> >> + *		for pages in range described by @offset and @length
> >> + * @result:	(output) SGX result code of ENCLS[EMODPR] function
> >> + * @count:	(output) bytes successfully changed (multiple of page size)
> >> + */
> >> +struct sgx_enclave_restrict_perm {
> >> +	__u64 offset;
> >> +	__u64 length;
> >> +	__u64 secinfo;
> >> +	__u64 result;
> >> +	__u64 count;
> >> +};
> >> +
> >>  struct sgx_enclave_run;
> >>  
> >>  /**
> 
> ...
> 
> > 
> > Just a suggestion but these might be a bit less cluttered explanations of
> > the fields:
> > 
> > /// SGX_IOC_ENCLAVE_RELAX_PERMISSIONS parameter structure
> > #[repr(C)]
> > pub struct RelaxPermissions {
> >     /// In: starting page offset
> >     offset: u64,
> >     /// In: length of the address range (multiple of the page size)
> >     length: u64,
> >     /// In: SECINFO containing the relaxed permissions
> >     secinfo: u64,
> >     /// Out: length of the address range successfully changed
> >     count: u64,
> > };
> > 
> > /// SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS parameter structure
> > #[repr(C)]
> > pub struct RestrictPermissions {
> >     /// In: starting page offset
> >     offset: u64,
> >     /// In: length of the address range (multiple of the page size)
> >     length: u64,
> >     /// In: SECINFO containing the restricted permissions
> >     secinfo: u64,
> >     /// In: ENCLU[EMODPR] return value
> >     result: u64,
> >     /// Out: length of the address range successfully changed
> >     count: u64,
> > };
> 
> In your proposal you shorten the descriptions from the current implementation.
> I do consider the removed information valuable since I believe that it helps
> users understand the kernel interface requirements without needing to be
> familiar with or dig into the kernel code to understand how the provided data
> is used.
> 
> For example, you shorten offset to "starting page offset", but what was removed
> was the requirement that this offset has to be page aligned and what the offset
> is relative to. I do believe summarizing these requirements upfront helps
> a user space developer by not needing to dig through kernel code later
> in order to understand why an -EINVAL was received.
> 
>  
> > I can live with the current ones too but I rewrote them so that I can
> > quickly make sense of the fields later. It's Rust code but the point is
> > the documentation...
> 
> Since you do seem to be ok with the current descriptions I would prefer
> to keep them.

Yeah, they are fine to me.

> > Also, it should not be too much trouble to use the struct in user space
> > code even if the struct names are struct sgx_enclave_relax_permissions and
> > struct sgx_enclave_restrict_permissions, given that you most likely have
> > exactly single call-site in the run-time.
> 
> Are you requesting that I make the following name changes?
> struct sgx_enclave_relax_perm -> struct sgx_enclave_relax_permissions
> struct sgx_enclave_restrict_perm -> struct sgx_enclave_restrict_permissions
> 
> If so, do you want the function names also written out in this way?
> sgx_enclave_relax_perm()        -> sgx_enclave_relax_permissions()
> sgx_ioc_enclave_relax_perm()    -> sgx_ioc_enclave_relax_permissions()
> sgx_enclave_restrict_perm()     -> sgx_enclave_restrict_permissions()
> sgx_ioc_enclave_restrict_perm() -> sgx_ioc_enclave_restrict_permissions()

Yes, unless you have a specific reason to shorten them :-)

> > Other than that, looks quite good.
> 
> Thank you very much for reviewing and testing this work.

NP
 
> Reinette

BR, Jarkko
