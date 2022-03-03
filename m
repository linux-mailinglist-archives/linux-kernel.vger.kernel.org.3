Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFE4CC9EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiCCXUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiCCXUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:20:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767AD2A70E;
        Thu,  3 Mar 2022 15:19:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0861FB8261F;
        Thu,  3 Mar 2022 23:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034BC004E1;
        Thu,  3 Mar 2022 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646349553;
        bh=zUdbEHecEubRFJARwcEcsfFryI8gGII87QyMhE6UR9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idw7f/KIPHtSmI3SvbojhznW/xbH9fG2FTIrEMMKFDqpYOjAyRa3nxjW451dSABFd
         6r1asfnphCnPHMPmFbS6VERnPh2tUP/Dgrrqg/UN1x+ZVvn9UjAYXEPN/VHy5+hKg8
         JwlesND+1zPeCHVe5DJ5sJz8CRTLnUtTuO4ECTkoTi48bl4RSk6BInrcRoBn5uf45K
         xjjvQac+6dtDSbvu1PvNIZQ2P1hfgx+3JTg8dR6bQfAx82nqKiZpceFiyJQGbZwSdU
         cim26lHhx0x6IMIUGM7tsgwA3O6SRLjuk+NHRmqC7qJXJnpoI4SMeifjUfDxXEOGgi
         mNJAtDH5q/o/Q==
Date:   Fri, 4 Mar 2022 01:18:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <YiFMyZ4t2MC0n5Pn@iki.fi>
References: <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:08:14AM -0600, Haitao Huang wrote:
> Hi all,
> 
> On Wed, 02 Mar 2022 16:57:45 -0600, Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> 
> > Hi Jarkko,
> > 
> > On 3/1/2022 6:05 PM, Jarkko Sakkinen wrote:
> > > On Tue, Mar 01, 2022 at 09:48:48AM -0800, Reinette Chatre wrote:
> > > > Hi Jarkko,
> > > > 
> > > > On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:
> > > > > > With EACCEPTCOPY (kudos to Mark S. for reminding me of
> > > > > > this version of
> > > > > > EACCEPT @ chat.enarx.dev) it is possible to make R and RX pages but
> > > > > > obviously new RX pages are now out of the picture:
> > > > > > 
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * Adding a regular page that is architecturally allowed to only
> > > > > > 	 * be created with RW permissions.
> > > > > > 	 * TBD: Interface with user space policy to support max permissions
> > > > > > 	 * of RWX.
> > > > > > 	 */
> > > > > > 	prot = PROT_READ | PROT_WRITE;
> > > > > > 	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> > > > > > 	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> > > > > > 
> > > > > > If that TBD is left out to the final version the page
> > > > > > augmentation has a
> > > > > > risk of a API bottleneck, and that risk can realize then
> > > > > > also in the page
> > > > > > permission ioctls.
> > > > > > 
> > > > > > I.e. now any review comment is based on not fully known
> > > > > > territory, we have
> > > > > > one known unknown, and some unknown unknowns from
> > > > > > unpredictable effect to
> > > > > > future API changes.
> > > > 
> > > > The plan to complete the "TBD" in the above snippet was to
> > > > follow this work
> > > > with user policy integration at this location. On a high level
> > > > the plan was
> > > > for this to look something like:
> > > > 
> > > > 
> > > >  	/*
> > > >  	 * Adding a regular page that is architecturally allowed to only
> > > >  	 * be created with RW permissions.
> > > >  	 * Interface with user space policy to support max permissions
> > > >  	 * of RWX.
> > > >  	 */
> > > >  	prot = PROT_READ | PROT_WRITE;
> > > >  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> > > > 
> > > >         if (user space policy allows RWX on dynamically added pages)
> > > > 	 	encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ |
> > > > PROT_WRITE | PROT_EXEC, 0);
> > > > 	else
> > > > 		encl_page->vm_max_prot_bits = calc_vm_prot_bits(PROT_READ |
> > > > PROT_WRITE, 0);
> > > > 
> > > > The work that follows this series aimed to do the integration with user
> > > > space policy.
> > > 
> > > What do you mean by "user space policy" anyway exactly? I'm sorry but I
> > > just don't fully understand this.
> > 
> > My apologies - I just assumed that you would need no reminder about this
> > contentious
> > part of SGX history. Essentially it means that, yes, the kernel could
> > theoretically
> > permit any kind of access to any file/page, but some accesses are known
> > to generally
> > be a bad idea - like making memory executable as well as writable - and
> > thus there
> > are additional checks based on what user space permits before the kernel
> > allows
> > such accesses.
> > 
> > For example,
> > mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect()
> > 
> > User policy and SGX has seen significant discussion. Some notable
> > threads:
> > https://lore.kernel.org/linux-security-module/CALCETrXf8mSK45h7sTK5Wf+pXLVn=Bjsc_RLpgO-h-qdzBRo5Q@mail.gmail.com/
> > https://lore.kernel.org/linux-security-module/20190619222401.14942-1-sean.j.christopherson@intel.com/
> > 
> > > It's too big of a risk to accept this series without X taken care
> > > of. Patch
> > > series should neither have TODO nor TBD comments IMHO. I don't want
> > > to ack
> > > a series based on speculation what might happen in the future.
> > 
> > ok
> > 
> > > 
> > > > > I think the best way to move forward would be to do EAUG's
> > > > > explicitly with
> > > > > an ioctl that could also include secinfo for permissions. Then you can
> > > > > easily do the rest with EACCEPTCOPY inside the enclave.
> > > > 
> > > > SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
> > > > this purpose. It already includes SECINFO which may also be useful if
> > > > needing to later support EAUG of PT_SS* pages.
> > > 
> > > You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it
> > > a day.
> > 
> > I could, yes.
> > 
> > > And if there is plan to extend SGX_IOC_ENCLAVE_ADD_PAGES what is
> > > this weird
> > > thing added to the #PF handler? Why is it added at all then?
> > 
> > I was just speculating in my response, there is no plan to extend
> > SGX_IOC_ENCLAVE_ADD_PAGES (that I am aware of).
> > 
> > > > How this could work is user space calls SGX_IOC_ENCLAVE_ADD_PAGES
> > > > after enclave initialization on any memory region within the
> > > > enclave where
> > > > pages are planned to be added dynamically. This ioctl() calls
> > > > EAUG to add the
> > > > new pages with RW permissions and their vm_max_prot_bits can be
> > > > set to the
> > > > permissions found in the included SECINFO. This will support
> > > > later EACCEPTCOPY
> > > > as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> > > 
> > > I don't like this type of re-use of the existing API.
> > 
> > I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is consensus
> > after
> > considering the user policy question (above) and performance trade-off
> > (more below).
> > 
> > > 
> > > > The big question is whether communicating user policy after
> > > > enclave initialization
> > > > via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable
> > > > to all? I would
> > > > appreciate a confirmation on this direction considering the
> > > > significant history
> > > > behind this topic.
> > > 
> > > I have no idea because I don't know what is user space policy.
> > 
> > This discussion is about some enclave usages needing RWX permissions
> > on dynamically added enclave pages. RWX permissions on dynamically added
> > pages is
> > not something that should blindly be allowed for all SGX enclaves but
> > instead the user
> > needs to explicitly allow specific enclaves to have such ability. This
> > is equivalent
> > to (but not the same as) what exists in Linux today with LSM. As seen in
> > mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect() Linux is able
> > to make
> > files and memory be both writable and executable, but it would only do
> > so for those
> > files and memory that the LSM (which is how user policy is communicated,
> > like SELinux)
> > indicates it is allowed, not blindly do so for all files and all memory.
> > 
> > > > > Putting EAUG to the #PF handler and implicitly call it just
> > > > > too flakky and
> > > > > hard to make deterministic for e.g. JIT compiler in our use
> > > > > case (not to
> > > > > mention that JIT is not possible at all because inability to
> > > > > do RX pages).
> > 
> > I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more deterministic
> > but from
> > what I understand it would have a performance impact since it would
> > require all memory
> > that may be needed by the enclave be pre-allocated from outside the
> > enclave and not
> > just dynamically allocated from within the enclave at the time it is
> > needed.
> > 
> > Would such a performance impact be acceptable?
> > 
> 
> User space won't always have enough info to decide whether the pages to be
> EAUG'd immediately. In some cases (shared libraries, JVM for example) lots
> of code/data pages can be mapped but never actually touched. One
> enclave/process does not know if any other more important enclave/process
> would need the EPC.
> 
> It should be for kernel to make the final decision as it has overall picture
> of the system EPC usage and availability.

EAUG ioctl does not give better capabilities for user space to waste
EPC given that EADD ioctl already exists, i.e. your argument is logically
incorrect.

BR, Jarkko
