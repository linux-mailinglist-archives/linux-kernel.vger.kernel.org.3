Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD14D1148
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiCHHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCHHt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:49:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382D2459F;
        Mon,  7 Mar 2022 23:49:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3255DB8179F;
        Tue,  8 Mar 2022 07:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B62C340EB;
        Tue,  8 Mar 2022 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646725740;
        bh=+d+kVM1W6KT8mfpwhumkLSJjDyQCDo775FENk5X2ge4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEZYP6p6LAVs+YGXoJXCVEZeuQ4lcKAKqMQ/Os4omFU2Ma+XIlUpm31humuW3aBkD
         KWhJYxWHK/oA/lTOHLBc9cAXXuWiv80Q7G1ttJGHBUUPPKWzsKdx0c275iPQSkY+nH
         F+gBZcpaFzhC+pC7KXQ9V/9Ph0xviv+yoBsa7w30F/MnNRAUNIGmJkZQ0B19kfBHZl
         wUtK7QWUOV7VKbE/yZ1/Wc0wr0/a0DR4WmYQ28EdjalYDA36gJrVZIN+Z1ARw/IV2w
         RSFy4hoGg6iMA3xnZVFzg1ruSoOpKLMt4V0LScDkzU5S5LHBjkJbYD1AM3w2qhDfo8
         vOfaGMMujap4A==
Date:   Tue, 8 Mar 2022 09:48:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Enable PROT_EXEC for EAUG'd pages
Message-ID: <YicKRLPi047oEEPJ@iki.fi>
References: <20220307153504.198112-1-jarkko@kernel.org>
 <YiYseF3aKI70x3d8@iki.fi>
 <YiYuH95wps+yHDk1@iki.fi>
 <fd560bc9-cb0b-0f7d-9a60-76735bc55c5e@intel.com>
 <YiY/aWW25Ix2375q@iki.fi>
 <f4352558-4329-81c8-1f97-29fcd4d37f8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4352558-4329-81c8-1f97-29fcd4d37f8a@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:39:01PM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/7/2022 9:22 AM, Jarkko Sakkinen wrote:
> > On Mon, Mar 07, 2022 at 09:13:48AM -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 3/7/2022 8:09 AM, Jarkko Sakkinen wrote:
> >>> On Mon, Mar 07, 2022 at 06:02:03PM +0200, Jarkko Sakkinen wrote:
> >>>> On Mon, Mar 07, 2022 at 05:35:04PM +0200, Jarkko Sakkinen wrote:
> >>>>> vm_max_permissions was created to control the pre-initialization content
> >>>>> that contributes to MRSIGNATURE. It was never meant to be as a limit to
> >>>>> dynamically added pages.
> >>>>>
> >>>>> E.g. static content could be used as a hook for LSM's to decide whether
> >>>>> certain signature is qualified for EINIT. Dynamic content has nothing to
> >>>>> do with that. The current mechanisms only add to the complexity on how
> >>>>> to control PTE and EPCM permissions, and do not add anything else than
> >>>>> obfuscity to security side of things.
> >>
> >> Linux has mechanisms to enforce what can be executed. For example, with SELinux
> >> a process can be required to have PROCESS__EXECHEAP or PROCESS__EXECSTACK 
> >> before it can be allowed to execute writable memory.
> >>
> >> A few SGX runtimes enables unmodified executables to be run within SGX enclaves.
> >>
> >> Does a change like this not enable executables prevented by existing 
> >> security mechanisms to circumvent such restrictions by running within
> >> a SGX enclave?
> > 
> > It does not open any extra exposure as the existing policies apply for
> > the enclave content created before initialization.
> > 
> > And I'm not sure what kind of circumvention scenario we are talking
> > about.
> > 
> >>>>> Thus add PROT_EXEC to the permissions assigned by the #PF handler.
> >>>>>
> >>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>>> ---
> >>>>>  arch/x86/kernel/cpu/sgx/encl.c | 9 ++++-----
> >>>>>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> >>>>> index 79e39bd99c09..0256918b2c2f 100644
> >>>>> --- a/arch/x86/kernel/cpu/sgx/encl.c
> >>>>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> >>>>> @@ -160,12 +160,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> >>>>>  	encl_page->encl = encl;
> >>>>>  
> >>>>>  	/*
> >>>>> -	 * Adding a regular page that is architecturally allowed to only
> >>>>> -	 * be created with RW permissions.
> >>>>> -	 * TBD: Interface with user space policy to support max permissions
> >>>>> -	 * of RWX.
> >>>>> +	 * Dynamic pages do not contribute to MRSIGNATURE, i.e. they are
> >>>>> +	 * controlled only by PTE and EPCM permissions. Thus, the no limit
> >>>>> +	 * is set here.
> >>>>>  	 */
> >>>>> -	prot = PROT_READ | PROT_WRITE;
> >>>>> +	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
> >>>>>  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> >>>>>  	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> >>>>>  
> >>>>> -- 
> >>>>> 2.35.1
> >>>>>
> >>>>
> >>>> This is really a show stopper. I think here's a logical mistake on for what
> >>>> purpose vm_max_prot_bits are used for. They are meant for the static and
> >>>> also signed content of the enclave.
> >>>>
> >>>> These changes in the patch set that are related to vm_max_prot_bits only
> >>>> messes up what already exists, and make incredibly hard to implement
> >>>> anything decent on top of SGX2 features.
> >>>
> >>> I.e. once signed content has passed EINIT ioctl, and whatever checks
> >>> there are now or in future (e.g. LSM hooks), the system has accepted
> >>> the enclave behaviour, and it includes also the use of EACCEPT opcode.
> >>>
> >>> It's the exec or no-exec decision point. The thing that these patches
> >>> do is making an obfuscated mess of all this. When EINIT has passed,
> >>> it has been decided that the enclave can do its workload. Let's not
> >>> throw stick in front of it, and make everyones life misserable.
> >>
> >> A common use for these dynamically added pages is to increase the heap
> >> and stack. Always allowing PTEs of RWX on these pages irrespective
> >> whether it will be used for heap, stack, or relocatable code does
> >> not match with how the kernel manages protections.
> >>
> >> As I said before I am not comfortable with such a change and cannot
> >> sign off on this. I would defer to the maintainers to choose the
> >> direction.
> >>
> >> Reinette
> > 
> > My choice is to not use this existing mechanism for dynamically created
> > pages because otherwise the implementation overally is just crippled.
> > 
> > Something unusable is for sure as secure as you can get.
> > 
> 
> ok, I will proceed with your guidance here and include your snippet from
> this patch into the next version.

Thank you.

> One question, regarding "MRSIGNATURE" - did you perhaps mean "MRENCLAVE"?

It could either both define "static root of trust". Does not really
all that much which one you use in the comment.

> Reinette

BR, Jarkko
