Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8B04DD0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiCQWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiCQWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC77B2B4A75;
        Thu, 17 Mar 2022 15:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 569DAB8205E;
        Thu, 17 Mar 2022 22:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A9C340F3;
        Thu, 17 Mar 2022 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647557516;
        bh=usxubETGNIj61RL6quMBw7P3iI8uvN32CF8CST1Cfqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlkRDg304AG+QXj6ZDn0h4SfnsqE4chO+gaic+mg6xZrvan9C3ODZyCwPGQJHyrZy
         lc2Hd7FOFa9dSSDTapfoMfKbekSZriAgstVkPz8d1fr8m/IeI7F8jUOkgvtDWwOPCs
         z0BQzy38Qfb4TJTriMc+1O0qpvOUCLLm5ztjFg4KAe9QSJl1bGEhW3ly8sByxxQcir
         aGEJLlzEzrgsL/FnDoMrdbC99VzcboG99pzH43WVK9UKd8BcH8e8//e+x166JPt98d
         qargol9/t3ndrJnX4Ljwm3Q9Cm2CdQSoB0c5aRpG5TH+W7kgzT4D/i0+UN8HyDT26h
         uhgMhu/ck2wLA==
Date:   Fri, 18 Mar 2022 00:51:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
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
Message-ID: <YjO7WWEbGPbPCe3/@iki.fi>
References: <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com>
 <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com>
 <YjK5ZWJRQX+lyUxS@iki.fi>
 <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:08:04PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/16/2022 9:30 PM, Jarkko Sakkinen wrote:
> > On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
> >>> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
> >>>> Supporting permission restriction in an ioctl() enables the runtime to manage
> >>>> the enclave memory without needing to map it.
> >>>
> >>> Which is opposite what you do in EAUG. You can also augment pages without
> >>> needing the map them. Sure you get that capability, but it is quite useless
> >>> in practice.
> >>>
> >>>> I have considered the idea of supporting the permission restriction with
> >>>> mprotect() but as you can see in this response I did not find it to be
> >>>> practical.
> >>>
> >>> Where is it practical? What is your application? How is it practical to
> >>> delegate the concurrency management of a split mprotect() to user space?
> >>> How do we get rid off a useless up-call to the host?
> >>>
> >>
> >> The email you responded to contained many obstacles against using mprotect()
> >> but you chose to ignore them and snipped them all from your response. Could
> >> you please address the issues instead of dismissing them? 
> > 
> > I did read the whole email but did not see anything that would make a case
> > for fully exposed EMODPR, or having asymmetrical towards how EAUG works.
> 
> I believe that on its own each obstacle I shared with you is significant enough
> to not follow that approach. You simply respond that I am just not making a
> case without acknowledging any obstacle or providing a reason why the obstacles
> are not valid.
> 
> To help me understand your view, could you please respond to each of the
> obstacles I list below and how it is not an issue?
> 
> 
> 1) ABI change:
>    mprotect() is currently supported to modify VMA permissions
>    irrespective of EPCM permissions. Supporting EPCM permission
>    changes with mprotect() would change this behavior.
>    For example, currently it is possible to have RW enclave
>    memory and support multiple tasks accessing the memory. Two
>    tasks can map the memory RW and later one can run mprotect()
>    to reduce the VMA permissions to read-only without impacting
>    the access of the other task.
>    By moving EPCM permission changes to mprotect() this usage
>    will no longer be supported and current behavior will change.

Your concurrency scenario is somewhat artificial. Obviously you need to
synchronize somehow, and breaking something that could be done with one
system call into two separates is not going to help with that. On the
contrary, it will add a yet one more difficulty layer.

mprotect() controls PTE permissions, not EPCM permissions. It is the corner
stone to do any sort of confidential computing to have this division.
That's why EACCEPT and EACCEPTCOPY exist.

There is no "current behaviour" yet because there is no mainline code, i.e.
that is easy one to address.

> 2) Only half EPCM permission management:
>    Moving to mprotect() as a way to set EPCM permissions is
>    not a clear interface for EPCM permission management because
>    the kernel can only restrict permissions. Even so, the kernel
>    has no insight into the current EPCM permissions and thus whether they
>    actually need to be restricted so every mprotect() call,
>    all except RWX, will need to be treated as a permission
>    restriction with all the implementation obstacles
>    that accompany it (more below).
> 
> There are two possible ways to implement permission restriction
> as triggered by mprotect(), (a) during the mprotect() call or
> (b) during a subsequent #PF (as suggested by you), each has
> its own obstacles.

I would have prefered also for EAUG to bundle it unconditionally to mmap()
flow. I've merely said that I don't care whether it is a part of mprotect()
flow or in the #PF handler, as long as the feature is not uncontrolled
chaos. Probably at least in mprotect() case it is easier flow to implement
it directly as part of mprotect().

Kernel is not the most trusted party in the confidential computing
scenarios. It is one of the adversaries. And SGX is designed in the way
that enclave controls EPCMD database and kernel PTEs. By trying to
artificially limit this you don't bring security, other than trying to
block implementing applications based on SGX2.

We can ditch the whole SGX, if the point is that kernel controls what
happens inside enclave. Normal VMAs are much more capable for that purpose,
and kernel has full control over them with e.g. PTEs.

> 
> 3) mprotect() implementation 
> 
>    When the user calls mprotect() the expectation is that the
>    call will either succeed or fail. If the call fails the user
>    expects the system to be unchanged. This is not possible if
>    permission restriction is done as part of mprotect().
> 
>    (a) mprotect() may span multiple VMAs and involves VMA splits
>        that (from what I understand) cannot be undone. SGX memory
>        does not support VMA merges. If any SGX function
>        (EMODPR or ETRACK on any page) done after a VMA split fails
>        then the user will be left with fragmented memory.

Oh well, SGX does not even support syscalls, if we go this level of
arguments. And you are trying to sort this out with even more flakky
interface, rather than stable EPCM reset to read state.

I've been implementing this exact feature lately and only realistic way to
do it without many corner cases is first use the current ioctl to reset the
range to READ in EPCM, and with EMODPE set the appropriate permissions.


>    (b) The EMODPR/ETRACK pair can fail on any of the pages provided
>        by the mprotect() call. If there is a failure then the
>        kernel cannot undo previously executed EMODPR since the kernel
>        cannot run EMODPE. The EPCM permissions are thus left in inconsistent
>        state since some of the pages would have changed EPCM permissions
>        and mprotect() does not have mechanism to communicate
>        partial success.
>        The partial success is needed to communicate to user space
>        (i) which pages need EACCEPT, (ii) which pages need to be
>        in new request (although user space does not have information
>        to help the new request succeed - see below).

It's true but how common is that? Return e.g. -EIO, and run-time will
re-build the enclave. That anyway happens all the time with SGX for
various reasons (e.g. VM migration, S3 and whatnot). It's only important
that you know when this happens.

> 
>    (c) User space runtime has control over management of EPC memory
>        and accurate failure information would help it to do so.
>        Knowing the error code of the EMODPR failure would help
>        user space to take appropriate action. For example, EMODPR
>        can return "SGX_PAGE_NOT_MODIFIABLE" that helps the runtime
>        to learn that it needs to run EACCEPT on that page before
>        the EMODPR can succeed. Alternatively, if it learns that the
>        return is "SGX_EPC_PAGE_CONFLICT" then it could determine
>        that some other part of the runtime attempted an ENCLU 
>        function on that page.
>        It is not possible to provide such detailed errors to user
>        space with mprotect().

Actually user space run-time is also an adversary. Kernel and user
space can e.g. kill the enclave or limit it with PTEs but EPCM is
beyond them *after* initialization. The whole point is to be able
to put e.g. containers to untrusted cloud.
> 
> 
> 4) #PF implementation
> 
>    (a) There is more to restricting permissions than just running
>        ENCLS[EMODPR]. After running ENCLS[EMODPR] the kernel should
>        also initiate the ETRACK flow to ensure that any thread within
>        the enclave is interrupted by sending an IPI to the CPU, 
>        this includes the thread that just triggered the #PF.        
> 
>    (b) Second consideration of the EMODPR and ETRACK flow is that
>        this has a large "blast radius" in that any thread in the
>        enclave needs to be interrupted. #PFs may arrive at any time
>        so setting up a page range where a fault into any page in the
>        page range will trigger enclave exits for all threads is
>        a significant yet random impact. I believe it would be better
>        to update all pages in the range at the same time and in this
>        way contain the impact of this significant EMODPR/ETRACK/IPIs
>        flow.
> 
>    (c) How will the page fault handler know when EMODPR/ETRACK should
>        be run? Consider that the page fault handler can be called
>        significantly later than the mprotect() call and that
>        user space can call EMODPE any time to extend permissions.
>        This implies that EMODPR/ETRACK/IPIs should be run during
>        *every* page fault, irrespective of mprotect().
> 
>    (d) If a page is in pending or modified state then EMODPR will
>        always fail. This is something that needs to be fixed by
>        user space runtime but the page fault will not be able
>        to communicate this.     
> 
> Considering the above, could you please provide clear guidance on
> how you envision permission restriction to be supported by mprotect()?

I'm not specifically driving #PF implementation but because it was so
important for EAUG, I said that I'm fine with #PF based implementation.

Personally, I would do both EAUG and EMODPR as part of mmap() and
mprotect() (e.g. to catch that partial success and return that -EIO)
flow but either works for me. The API is more of a concern than the
internals.

> 
> Reinette

BR, Jarkko
