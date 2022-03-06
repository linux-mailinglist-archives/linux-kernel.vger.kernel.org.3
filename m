Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D504CEBE8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 15:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiCFOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 09:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCFOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:25:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E314EF68;
        Sun,  6 Mar 2022 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646576703; x=1678112703;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=7D2A1Jj8fXJWuj285AinFJdioUYXWjRFvGmf/pVb0jU=;
  b=bmUOBUta4S3ARDJnnuDWRESsQ9qv71JCk9+JhwY+sai+hHLgO+lcJoUI
   +MwdUMAJBd1A7wkNPcHZhSxyR9MLlPPfRvgYhmORuS/x5lf1ksmVKn/T5
   IO8+KYVW7oPREg881HsRppfgKVPX/Drpxz/tS8Yf7k1X67DAXJERg7b+q
   mbRDhVilGbtzJXHlu+6tQRlB3meVIAmUT85zcJXqWNpy1rTZGd1dZpEp1
   QLsPhq6rMOR/9Jz3NmC2fsWa2UKuVGln6HFhCPSW5t2yibohQmIkc/lmG
   5EXYBbSb4ImL/83RLzIKx11xQs79htNd+T8Bg5s6ypt1Ge3xkX2Nz53i0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10277"; a="253962887"
X-IronPort-AV: E=Sophos;i="5.90,159,1643702400"; 
   d="scan'208";a="253962887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 06:25:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,159,1643702400"; 
   d="scan'208";a="552819144"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.37.141])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 06 Mar 2022 06:25:00 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
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
References: <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com> <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net> <YiFMyZ4t2MC0n5Pn@iki.fi>
 <op.1ihmv4mvwjvjmi@hhuan26-mobl1.mshome.net> <YiHOHn3q4gwoFv+u@iki.fi>
 <op.1iijnwtpwjvjmi@hhuan26-mobl1.mshome.net> <YiK2pL7eoVGMZyH9@iki.fi>
Date:   Sun, 06 Mar 2022 08:24:59 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1il4zxeqwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YiK2pL7eoVGMZyH9@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2022 19:02:28 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Fri, Mar 04, 2022 at 09:51:22AM -0600, Haitao Huang wrote:
>> Hi Jarkko
>>
>> On Fri, 04 Mar 2022 02:30:22 -0600, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Thu, Mar 03, 2022 at 10:03:30PM -0600, Haitao Huang wrote:
>> > >
>> > > On Thu, 03 Mar 2022 17:18:33 -0600, Jarkko Sakkinen  
>> <jarkko@kernel.org>
>> > > wrote:
>> > >
>> > > > On Thu, Mar 03, 2022 at 10:08:14AM -0600, Haitao Huang wrote:
>> > > > > Hi all,
>> > > > >
>> > > > > On Wed, 02 Mar 2022 16:57:45 -0600, Reinette Chatre
>> > > > > <reinette.chatre@intel.com> wrote:
>> > > > >
>> > > > > > Hi Jarkko,
>> > > > > >
>> > > > > > On 3/1/2022 6:05 PM, Jarkko Sakkinen wrote:
>> > > > > > > On Tue, Mar 01, 2022 at 09:48:48AM -0800, Reinette Chatre  
>> wrote:
>> > > > > > > > Hi Jarkko,
>> > > > > > > >
>> > > > > > > > On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:
>> > > > > > > > > > With EACCEPTCOPY (kudos to Mark S. for reminding me of
>> > > > > > > > > > this version of
>> > > > > > > > > > EACCEPT @ chat.enarx.dev) it is possible to make R  
>> and RX
>> > > > > pages but
>> > > > > > > > > > obviously new RX pages are now out of the picture:
>> > > > > > > > > >
>> > > > > > > > > >
>> > > > > > > > > > 	/*
>> > > > > > > > > > 	 * Adding a regular page that is architecturally  
>> allowed
>> > > > > to only
>> > > > > > > > > > 	 * be created with RW permissions.
>> > > > > > > > > > 	 * TBD: Interface with user space policy to support  
>> max
>> > > > > permissions
>> > > > > > > > > > 	 * of RWX.
>> > > > > > > > > > 	 */
>> > > > > > > > > > 	prot = PROT_READ | PROT_WRITE;
>> > > > > > > > > > 	encl_page->vm_run_prot_bits =  
>> calc_vm_prot_bits(prot, 0);
>> > > > > > > > > > 	encl_page->vm_max_prot_bits =
>> > > encl_page->vm_run_prot_bits;
>> > > > > > > > > >
>> > > > > > > > > > If that TBD is left out to the final version the page
>> > > > > > > > > > augmentation has a
>> > > > > > > > > > risk of a API bottleneck, and that risk can realize  
>> then
>> > > > > > > > > > also in the page
>> > > > > > > > > > permission ioctls.
>> > > > > > > > > >
>> > > > > > > > > > I.e. now any review comment is based on not fully  
>> known
>> > > > > > > > > > territory, we have
>> > > > > > > > > > one known unknown, and some unknown unknowns from
>> > > > > > > > > > unpredictable effect to
>> > > > > > > > > > future API changes.
>> > > > > > > >
>> > > > > > > > The plan to complete the "TBD" in the above snippet was to
>> > > > > > > > follow this work
>> > > > > > > > with user policy integration at this location. On a high  
>> level
>> > > > > > > > the plan was
>> > > > > > > > for this to look something like:
>> > > > > > > >
>> > > > > > > >
>> > > > > > > >  	/*
>> > > > > > > >  	 * Adding a regular page that is architecturally allowed
>> > > to only
>> > > > > > > >  	 * be created with RW permissions.
>> > > > > > > >  	 * Interface with user space policy to support max
>> > > permissions
>> > > > > > > >  	 * of RWX.
>> > > > > > > >  	 */
>> > > > > > > >  	prot = PROT_READ | PROT_WRITE;
>> > > > > > > >  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot,  
>> 0);
>> > > > > > > >
>> > > > > > > >         if (user space policy allows RWX on dynamically  
>> added
>> > > > > pages)
>> > > > > > > > 	 	encl_page->vm_max_prot_bits =  
>> calc_vm_prot_bits(PROT_READ |
>> > > > > > > > PROT_WRITE | PROT_EXEC, 0);
>> > > > > > > > 	else
>> > > > > > > > 		encl_page->vm_max_prot_bits =  
>> calc_vm_prot_bits(PROT_READ |
>> > > > > > > > PROT_WRITE, 0);
>> > > > > > > >
>> > > > > > > > The work that follows this series aimed to do the  
>> integration
>> > > > > with user
>> > > > > > > > space policy.
>> > > > > > >
>> > > > > > > What do you mean by "user space policy" anyway exactly? I'm
>> > > > > sorry but I
>> > > > > > > just don't fully understand this.
>> > > > > >
>> > > > > > My apologies - I just assumed that you would need no reminder
>> > > > > about this
>> > > > > > contentious
>> > > > > > part of SGX history. Essentially it means that, yes, the
>> > > kernel could
>> > > > > > theoretically
>> > > > > > permit any kind of access to any file/page, but some accesses  
>> are
>> > > > > known
>> > > > > > to generally
>> > > > > > be a bad idea - like making memory executable as well as  
>> writable
>> > > > > - and
>> > > > > > thus there
>> > > > > > are additional checks based on what user space permits before  
>> the
>> > > > > kernel
>> > > > > > allows
>> > > > > > such accesses.
>> > > > > >
>> > > > > > For example,
>> > > > > > mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect()
>> > > > > >
>> > > > > > User policy and SGX has seen significant discussion. Some  
>> notable
>> > > > > > threads:
>> > > > > >  
>> https://lore.kernel.org/linux-security-module/CALCETrXf8mSK45h7sTK5Wf+pXLVn=Bjsc_RLpgO-h-qdzBRo5Q@mail.gmail.com/
>> > > > > >  
>> https://lore.kernel.org/linux-security-module/20190619222401.14942-1-sean.j.christopherson@intel.com/
>> > > > > >
>> > > > > > > It's too big of a risk to accept this series without X taken
>> > > care
>> > > > > > > of. Patch
>> > > > > > > series should neither have TODO nor TBD comments IMHO. I
>> > > don't want
>> > > > > > > to ack
>> > > > > > > a series based on speculation what might happen in the  
>> future.
>> > > > > >
>> > > > > > ok
>> > > > > >
>> > > > > > >
>> > > > > > > > > I think the best way to move forward would be to do  
>> EAUG's
>> > > > > > > > > explicitly with
>> > > > > > > > > an ioctl that could also include secinfo for  
>> permissions.
>> > > > > Then you can
>> > > > > > > > > easily do the rest with EACCEPTCOPY inside the enclave.
>> > > > > > > >
>> > > > > > > > SGX_IOC_ENCLAVE_ADD_PAGES already exists and could  
>> possibly be
>> > > > > used for
>> > > > > > > > this purpose. It already includes SECINFO which may also  
>> be
>> > > > > useful if
>> > > > > > > > needing to later support EAUG of PT_SS* pages.
>> > > > > > >
>> > > > > > > You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and
>> > > call it
>> > > > > > > a day.
>> > > > > >
>> > > > > > I could, yes.
>> > > > > >
>> > > > > > > And if there is plan to extend SGX_IOC_ENCLAVE_ADD_PAGES  
>> what is
>> > > > > > > this weird
>> > > > > > > thing added to the #PF handler? Why is it added at all then?
>> > > > > >
>> > > > > > I was just speculating in my response, there is no plan to  
>> extend
>> > > > > > SGX_IOC_ENCLAVE_ADD_PAGES (that I am aware of).
>> > > > > >
>> > > > > > > > How this could work is user space calls
>> > > SGX_IOC_ENCLAVE_ADD_PAGES
>> > > > > > > > after enclave initialization on any memory region within  
>> the
>> > > > > > > > enclave where
>> > > > > > > > pages are planned to be added dynamically. This ioctl()  
>> calls
>> > > > > > > > EAUG to add the
>> > > > > > > > new pages with RW permissions and their vm_max_prot_bits
>> > > can be
>> > > > > > > > set to the
>> > > > > > > > permissions found in the included SECINFO. This will  
>> support
>> > > > > > > > later EACCEPTCOPY
>> > > > > > > > as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>> > > > > > >
>> > > > > > > I don't like this type of re-use of the existing API.
>> > > > > >
>> > > > > > I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is
>> > > > > consensus
>> > > > > > after
>> > > > > > considering the user policy question (above) and performance
>> > > trade-off
>> > > > > > (more below).
>> > > > > >
>> > > > > > >
>> > > > > > > > The big question is whether communicating user policy  
>> after
>> > > > > > > > enclave initialization
>> > > > > > > > via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is  
>> acceptable
>> > > > > > > > to all? I would
>> > > > > > > > appreciate a confirmation on this direction considering  
>> the
>> > > > > > > > significant history
>> > > > > > > > behind this topic.
>> > > > > > >
>> > > > > > > I have no idea because I don't know what is user space  
>> policy.
>> > > > > >
>> > > > > > This discussion is about some enclave usages needing RWX
>> > > permissions
>> > > > > > on dynamically added enclave pages. RWX permissions on  
>> dynamically
>> > > > > added
>> > > > > > pages is
>> > > > > > not something that should blindly be allowed for all SGX
>> > > enclaves but
>> > > > > > instead the user
>> > > > > > needs to explicitly allow specific enclaves to have such
>> > > ability. This
>> > > > > > is equivalent
>> > > > > > to (but not the same as) what exists in Linux today with LSM.  
>> As
>> > > > > seen in
>> > > > > > mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect()  
>> Linux
>> > > > > is able
>> > > > > > to make
>> > > > > > files and memory be both writable and executable, but it would
>> > > only do
>> > > > > > so for those
>> > > > > > files and memory that the LSM (which is how user policy is
>> > > > > communicated,
>> > > > > > like SELinux)
>> > > > > > indicates it is allowed, not blindly do so for all files and  
>> all
>> > > > > memory.
>> > > > > >
>> > > > > > > > > Putting EAUG to the #PF handler and implicitly call it  
>> just
>> > > > > > > > > too flakky and
>> > > > > > > > > hard to make deterministic for e.g. JIT compiler in our  
>> use
>> > > > > > > > > case (not to
>> > > > > > > > > mention that JIT is not possible at all because  
>> inability to
>> > > > > > > > > do RX pages).
>> > > > > >
>> > > > > > I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more
>> > > > > deterministic
>> > > > > > but from
>> > > > > > what I understand it would have a performance impact since it
>> > > would
>> > > > > > require all memory
>> > > > > > that may be needed by the enclave be pre-allocated from
>> > > outside the
>> > > > > > enclave and not
>> > > > > > just dynamically allocated from within the enclave at the time
>> > > it is
>> > > > > > needed.
>> > > > > >
>> > > > > > Would such a performance impact be acceptable?
>> > > > > >
>> > > > >
>> > > > > User space won't always have enough info to decide whether the  
>> pages
>> > > > > to be
>> > > > > EAUG'd immediately. In some cases (shared libraries, JVM for
>> > > > > example) lots
>> > > > > of code/data pages can be mapped but never actually touched. One
>> > > > > enclave/process does not know if any other more important
>> > > > > enclave/process
>> > > > > would need the EPC.
>> > > > >
>> > > > > It should be for kernel to make the final decision as it has  
>> overall
>> > > > > picture
>> > > > > of the system EPC usage and availability.
>> > > >
>> > > > EAUG ioctl does not give better capabilities for user space to  
>> waste
>> > > > EPC given that EADD ioctl already exists, i.e. your argument is
>> > > logically
>> > > > incorrect.
>> > >
>> > > The point of adding EAUG is to allow more efficient use of EPC  
>> pages.
>> > > Without EAUG, enclaves have to EADD everything upfront into EPC,
>> > > consuming
>> > > predetermined number of EPC pages, some of which may not be used at  
>> all.
>> > > With EAUG, enclaves should be able to load minimal pages to get  
>> started,
>> > > pages added on #PF as they are actually accessed.
>> > >
>> > > Obviously as you pointed out, some usages make more sense to
>> > > pre-EAUG (EAUG
>> > > before #PF). But your proposal of supporting only pre-EAUG here
>> > > essentially
>> > > makes EAUG behave almost the same as EADD.  If the current
>> > > implementation
>> > > with EAUG on #PF can also use MAP_POPULATE for pre-EAUG (seems  
>> possible
>> > > based on Dave's comments), then it is flxible to cover all cases and
>> > > allow
>> > > kernel to optimize allocation of EPC pages.
>> >
>> > There is no even a working #PF based implementation in existance, and
>> > your
>> > argument has too many if's for my taste.
>>
>> 1) if you mean no user space is implementing this kind of solution, read
>> this section, otherwise, skip to 2) below which is only couple of  
>> sentences.
>>
>> If you are willing to look, there is already implementation in our SDK  
>> to do
>> heap and stack expansion on demand on #PF. Enclaves may not know  
>> heap/stack
>> size up front, we have implemented these features to make EPC usage more
>> efficient. I don't know why normal processes can add RAM on #PF, but
>> enclaves adding EPC on #PF becomes so unacceptable concept to you. And  
>> the
>> kernel does that for EPC swapping already when #PF happens on a swapped  
>> out
>> EPC page.
>
> In adds O(n) round-trips for a mmap() emulation, which can be done in  
> O(1)
> round-trips with a ioctl.
>
>> Our implementation has gone through several rounds, the latest is
>> here:https://github.com/intel/linux-sgx/tree/edmm_v2/sdk/emm. It was  
>> also
>> implemented in original OOT driver based SDK implementation. Customers  
>> are
>> using it and found them useful. I think this is a critical feature that  
>> many
>> other runtimes will also need.
>
> I'm not sure what the common sense argument here is.
>
My (wrong) assumption was that you are disabling EAUG on #PF totally, and  
all I was saying EAUG on #PF is critical for many usages and disabling it  
requires good justification.

But you are expecting an ioctl call for each #PF for those usages:  
https://lore.kernel.org/linux-sgx/YiK8NEnvgPerEdFB@iki.fi/#t. IIUC, that's  
better than total disabling but less optimal. (I have not checked all call  
sequences in detail to be sure it would work for all our cases)


>> 2)
>> It's OK for you to request additional support for your usage and I  
>> agree it
>> is needed. But IMHO, totally getting rid of EAUG on #PF is bad and
>> unnecessary. Current implementation can be extended to support your  
>> usage.
>> What's the reason  you think MAP_POPULATE won't work for you?
>
> I do not recall taking stand on MAP_POPULATE.

Thanks for looking into that. Like I said, that should cover all usages.
