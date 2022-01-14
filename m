Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71448F228
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiANV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:57:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiANV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:57:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE309B825F5;
        Fri, 14 Jan 2022 21:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101A1C36AE9;
        Fri, 14 Jan 2022 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642197438;
        bh=D0GrlHyXRbjGyU5VwZ/bmomL3KML/0vKzsHz5fDajRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVlSMmgtSpHeq4DQonhKhYyjxEz9TbQHA6UCR6ETsEsNK38GsyxokdQjfqe9p3weJ
         UW2sj/pOp6MV4Sy1ZVFwqzQ/7w1ZKB82FEdDHV9AXG0F1B92l33+TNiIhwX755A6kw
         HockYO4ontoJ24vtArh70aXKNJ8SjRwg+ihWnGM6gmDFj49RUK4rrbPUj0XLcb0cMU
         R7FRDvZZIpIlGnLAJqBY2vp3TEObNBppLzy1M5OGbSFvDVyt3GoakjzkHUqba6aAob
         97Ylif5xqAbIUyhVVv9h3FUHr4AjtI9J81DOed8ELAtFlWL8hHOYtb3SdrRdB22UIp
         cXUTjwaAPkMZg==
Date:   Fri, 14 Jan 2022 23:57:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YeHxsYaJMINYFJOm@iki.fi>
References: <YdmzDy1BOHgh8CII@iki.fi>
 <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <YeHwzwnfsUcxiNbw@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeHwzwnfsUcxiNbw@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 11:53:22PM +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 13, 2022 at 01:42:50PM -0800, Reinette Chatre wrote:
> > Hi Jarkko and Nathaniel,
> > 
> > On 1/13/2022 12:09 PM, Nathaniel McCallum wrote:
> > > On Wed, Jan 12, 2022 at 6:56 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >>
> > >> On Thu, Jan 13, 2022 at 01:50:13AM +0200, Jarkko Sakkinen wrote:
> > >>> On Tue, Jan 11, 2022 at 09:13:27AM -0800, Reinette Chatre wrote:
> > >>>> Hi Jarkko,
> > >>>>
> > >>>> On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
> > >>>>> On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
> > >>>>>> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> > >>>>>> wrote:
> > >>>>>>
> > >>>>>>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
> > >>>>>>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
> > >>>>>>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
> > >>>>>>>>>>>>> OK, so the question is: do we need both or would a
> > >>>>>>>> mechanism just
> > >>>>>>>>>>>> to extend
> > >>>>>>>>>>>>> permissions be sufficient?
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I do believe that we need both in order to support pages
> > >>>>>>>> having only
> > >>>>>>>>>>>> the permissions required to support their intended use
> > >>>>>>>> during the
> > >>>>>>>>>>>> time the
> > >>>>>>>>>>>> particular access is required. While technically it is
> > >>>>>>>> possible to grant
> > >>>>>>>>>>>> pages all permissions they may need during their lifetime it
> > >>>>>>>> is safer to
> > >>>>>>>>>>>> remove permissions when no longer required.
> > >>>>>>>>>>>
> > >>>>>>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
> > >>>>>>>> how using it
> > >>>>>>>>>>> would make things safer?
> > >>>>>>>>>>>
> > >>>>>>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
> > >>>>>>>>>> modifying both PTE and EPCM permissions to RX would be a good
> > >>>>>>>> defensive
> > >>>>>>>>>> measure. In that case, EMODPR is useful.
> > >>>>>>>>>
> > >>>>>>>>> What is the exact threat we are talking about?
> > >>>>>>>>
> > >>>>>>>> To add: it should be *significantly* critical thread, given that not
> > >>>>>>>> supporting only EAUG would leave us only one complex call pattern with
> > >>>>>>>> EACCEPT involvement.
> > >>>>>>>>
> > >>>>>>>> I'd even go to suggest to leave EMODPR out of the patch set, and
> > >>>>>>>> introduce
> > >>>>>>>> it when there is PoC code for any of the existing run-time that
> > >>>>>>>> demonstrates the demand for it. Right now this way too speculative.
> > >>>>>>>>
> > >>>>>>>> Supporting EMODPE is IMHO by factors more critical.
> > >>>>>>>
> > >>>>>>> At least it does not protected against enclave code because an enclave
> > >>>>>>> can
> > >>>>>>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
> > >>>>>>> confused here about the actual threat but also the potential adversary
> > >>>>>>> and
> > >>>>>>> target.
> > >>>>>>>
> > >>>>>> I'm not sure I follow your thoughts here. The sequence should be for enclave
> > >>>>>> to request  EMODPR in the first place through runtime to kernel, then to
> > >>>>>> verify with EACCEPT that the OS indeed has done EMODPR.
> > >>>>>> If enclave does not verify with EACCEPT, then its own code has
> > >>>>>> vulnerability. But this does not justify OS not providing the mechanism to
> > >>>>>> request EMODPR.
> > >>>>>
> > >>>>> The question is really simple: what is the threat scenario? In order to use
> > >>>>> the word "vulnerability", you would need one.
> > >>>>>
> > >>>>> Given the complexity of the whole dance with EMODPR it is mandatory to have
> > >>>>> one, in order to ack it to the mainline.
> > >>>>>
> > >>>>
> > >>>> Which complexity related to EMODPR are you concerned about? In a later message
> > >>>> you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
> > >>>> so it seems that you are perhaps concerned about the flow involving EACCEPT?
> > >>>> The OS does not require nor depend on EACCEPT being called as part of these flows
> > >>>> so a faulty or misbehaving user space omitting an EACCEPT call would not impact
> > >>>> these flows in the OS, but would of course impact the enclave.
> > >>>
> > >>> I'd say *any* complexity because I see no benefit of supporting it. E.g.
> > >>> EMODPR/EACCEPT/EMODPE sequence I mentioned to Haitao concerns me. How is
> > >>> EMODPR going to help with any sort of workload?
> > >>
> > >> I've even started think should we just always allow mmap()?
> > > 
> > > I suspect this may be the most ergonomic way forward. Instructions
> > > like EAUG/EMODPR/etc are really irrelevant implementation details to
> > > what the enclave wants, which is a memory mapping in the enclave. Why
> > > make the enclave runner do multiple context switches just to change
> > > the memory map of an enclave?
> > 
> > The enclave runner is not forced to make any changes to a memory mapping. To start,
> > this implementation supports and does not change the existing ABI where a new
> > memory mapping can only be created if its permissions are the same or weaker
> > than the EPCM permissions. After the memory mapping is created the EPCM permissions
> > can change (thanks to SGX2) and when they do there are no forced nor required
> > changes to the memory mapping - pages remain accessible where the memory mapping
> > and EPCM permissions agree. It is true that if an enclave chooses to relax permissions
> > to an enclave page (EMODPE) then the memory mapping may need to be changed as
> > should be expected to access a page with permissions that the memory mapping
> > did not previously allow.
> > 
> > Are you saying that the permissions of a new memory mapping should now be allowed
> > to exceed EPCM permissions and thus the enclave runner would not need to modify a
> > memory mapping when EPCM permissions are relaxed? As mentioned above this may be
> > considered a change in ABI but something we could support on SGX2 systems.
> > 
> > I would also like to highlight Haitao's earlier comment that a foundation of SGX is
> > that the OS is untrusted. The enclave owner does not trust the OS and needs EMODPR
> > and EMODPE to manage enclave page permissions.
> 
> Thanks, this was very informative response. I'll try to elaborate why
> EMODPR gives me headaches.
> 
> I'm having hard time to connect the dots between OS mistrust and
> restricting enclave by changing EPCM permissions. To make EMODPR actually
> legit, it needs really at least some sort of example of a scenario where
> mistrusted OS is the adversary and enclave is the attack target. Otherwise,
> we are just waving our hands.
> 
> Generally speaking a restriction is not a restriction if cannot be enforced. 
> 
> I see two non-EMODPR options: you could relax this,  *or* you could make it
> soft restriction by not doing EMODPR but instead just updating the internal
> xarray. The 2nd option would be fully backwards compatible with the
> existing invariant.
> 
> It's really hard to ACK or NAK EMODPR patch without knowing how EMODPE is
> or will be supported.

Off-topic: I was able to compile a kernel with your SGX2 patches and run
kselftests. I cannot give tested-by's before the design is locked-in but
in that sense I don't think we are far away of some solution. EAUG side
looks pretty good to me.

/Jarkko
