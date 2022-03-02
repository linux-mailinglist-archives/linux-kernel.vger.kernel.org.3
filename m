Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9564C9ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiCBCF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCBCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737AC2A27F;
        Tue,  1 Mar 2022 18:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AD5BB81EEC;
        Wed,  2 Mar 2022 02:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA1EC340F0;
        Wed,  2 Mar 2022 02:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646186680;
        bh=i4qQTRUMKVz/Lw2o/GZqlV/+bdva2T20twC9gBHnWnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/05FiaYF8YljcgHpY54ApqD9f2xENlBfg90LnaguFJvjcPz2xw7WcbQQeHVvJLGR
         UzLxqfC8iCZfB3ZwdlHopEkEhWdl0Lnr14OuMPxcyZLNGVasHfYwvEcZJvwgerc3q8
         baST5dn4j2GkCbbtHB1nhBUXjTRo1kMx6BHn2qYYLnsiVSlaTjrMrCstIrVfT6oSGN
         8Im1EQUgWGlGOy1r/LOygk/BScjn4QDBeYHFWzxaK6wZ6LU+yIbepQKigqSKegPqD0
         I66gkkK1bM6+kGdrQY4ZwYxk/09hAvHLd1By4rlhVsYolWs+Mhj1sSjAWUfBfxniWD
         G7ivxizt7wx/A==
Date:   Wed, 2 Mar 2022 03:05:25 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <Yh7Q5fbOtr+6YWaS@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:48:48AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:
> >> With EACCEPTCOPY (kudos to Mark S. for reminding me of this version of
> >> EACCEPT @ chat.enarx.dev) it is possible to make R and RX pages but
> >> obviously new RX pages are now out of the picture:
> >>
> >>
> >> 	/*
> >> 	 * Adding a regular page that is architecturally allowed to only
> >> 	 * be created with RW permissions.
> >> 	 * TBD: Interface with user space policy to support max permissions
> >> 	 * of RWX.
> >> 	 */
> >> 	prot = PROT_READ | PROT_WRITE;
> >> 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> >> 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> >>
> >> If that TBD is left out to the final version the page augmentation has a
> >> risk of a API bottleneck, and that risk can realize then also in the page
> >> permission ioctls.
> >>
> >> I.e. now any review comment is based on not fully known territory, we have
> >> one known unknown, and some unknown unknowns from unpredictable effect to
> >> future API changes.
> 
> The plan to complete the "TBD" in the above snippet was to follow this work
> with user policy integration at this location. On a high level the plan was
> for this to look something like:
> 
> 
>  	/*
>  	 * Adding a regular page that is architecturally allowed to only
>  	 * be created with RW permissions.
>  	 * Interface with user space policy to support max permissions
>  	 * of RWX.
>  	 */
>  	prot = PROT_READ | PROT_WRITE;
>  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> 
>         if (user space policy allows RWX on dynamically added pages)
> 	 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE | PROT_EXEC, 0);
> 	else
> 		encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ | PROT_WRITE, 0);
> 
> The work that follows this series aimed to do the integration with user
> space policy.

What do you mean by "user space policy" anyway exactly? I'm sorry but I
just don't fully understand this.

It's too big of a risk to accept this series without X taken care of. Patch
series should neither have TODO nor TBD comments IMHO. I don't want to ack
a series based on speculation what might happen in the future.

> > I think the best way to move forward would be to do EAUG's explicitly with
> > an ioctl that could also include secinfo for permissions. Then you can
> > easily do the rest with EACCEPTCOPY inside the enclave.
> 
> SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
> this purpose. It already includes SECINFO which may also be useful if
> needing to later support EAUG of PT_SS* pages.

You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it a day.

And if there is plan to extend SGX_IOC_ENCLAVE_ADD_PAGES what is this weird
thing added to the #PF handler? Why is it added at all then?

> How this could work is user space calls SGX_IOC_ENCLAVE_ADD_PAGES
> after enclave initialization on any memory region within the enclave where
> pages are planned to be added dynamically. This ioctl() calls EAUG to add the
> new pages with RW permissions and their vm_max_prot_bits can be set to the
> permissions found in the included SECINFO. This will support later EACCEPTCOPY
> as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS

I don't like this type of re-use of the existing API.

> The big question is whether communicating user policy after enclave initialization
> via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
> appreciate a confirmation on this direction considering the significant history
> behind this topic.

I have no idea because I don't know what is user space policy.

> > Putting EAUG to the #PF handler and implicitly call it just too flakky and
> > hard to make deterministic for e.g. JIT compiler in our use case (not to
> > mention that JIT is not possible at all because inability to do RX pages).
> 
> In this series this is indeed not possible because it lacks the user policy
> integration. JIT will be possible after user policy integration.

Like this I don't what this series can be used in practice.

Majority of practical use cases for EDMM boil down to having a way to add
new executable code (not just Enarx).

> Reinette

BR, Jarkko
