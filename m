Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7644848CF79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiALX4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:56:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33958 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiALX4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:56:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBDD61209;
        Wed, 12 Jan 2022 23:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195EAC36AEC;
        Wed, 12 Jan 2022 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031780;
        bh=4Y0xWoLOQCcyaOD6zkLkEVyq9HhnUPTs5P99NoUOcvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPnCX3bBpfwVEIZqtAoQy+56wECmnL8LZqgefE+rG/OBeU2LU1oRYDcgRyzATbPxy
         1XstZbpam4N7YncNnhyodS7a4lNw4dyXzCGO1Hsrxsj2R0WNW5aO6hqIMBQZC/Deun
         VWpIb6qWVg6rppaHaVJNik391xHTDQJuBk8ycTbQOqhaTBBcZQHVGqj/r7I9jJkJ0G
         3cfFQnMGR1LWTYnBOlCR5W1czNiMHVsBV6NTodrjYEBJ8DkGc93RkKyKW4DHdQNVS1
         dLJ5XPyykEZHZseBJRNfiYddu8ig8NF0g6o4BkO0XrqVZYvVYdrm3Te5/oPoaA8SVi
         acYUL+UtBRe4g==
Date:   Thu, 13 Jan 2022 01:56:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <Yd9qmMx7NO450mzZ@iki.fi>
References: <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi>
 <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com>
 <Yd9pMq4lUy56B+50@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd9pMq4lUy56B+50@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 01:50:13AM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 11, 2022 at 09:13:27AM -0800, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 1/10/2022 5:53 PM, Jarkko Sakkinen wrote:
> > > On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
> > >> On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> > >> wrote:
> > >>
> > >>> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
> > >>>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
> > >>>>> On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
> > >>>>>>>>> OK, so the question is: do we need both or would a
> > >>>> mechanism just
> > >>>>>>>> to extend
> > >>>>>>>>> permissions be sufficient?
> > >>>>>>>>
> > >>>>>>>> I do believe that we need both in order to support pages
> > >>>> having only
> > >>>>>>>> the permissions required to support their intended use
> > >>>> during the
> > >>>>>>>> time the
> > >>>>>>>> particular access is required. While technically it is
> > >>>> possible to grant
> > >>>>>>>> pages all permissions they may need during their lifetime it
> > >>>> is safer to
> > >>>>>>>> remove permissions when no longer required.
> > >>>>>>>
> > >>>>>>> So if we imagine a run-time: how EMODPR would be useful, and
> > >>>> how using it
> > >>>>>>> would make things safer?
> > >>>>>>>
> > >>>>>> In scenarios of JIT compilers, once code is generated into RW pages,
> > >>>>>> modifying both PTE and EPCM permissions to RX would be a good
> > >>>> defensive
> > >>>>>> measure. In that case, EMODPR is useful.
> > >>>>>
> > >>>>> What is the exact threat we are talking about?
> > >>>>
> > >>>> To add: it should be *significantly* critical thread, given that not
> > >>>> supporting only EAUG would leave us only one complex call pattern with
> > >>>> EACCEPT involvement.
> > >>>>
> > >>>> I'd even go to suggest to leave EMODPR out of the patch set, and
> > >>>> introduce
> > >>>> it when there is PoC code for any of the existing run-time that
> > >>>> demonstrates the demand for it. Right now this way too speculative.
> > >>>>
> > >>>> Supporting EMODPE is IMHO by factors more critical.
> > >>>
> > >>> At least it does not protected against enclave code because an enclave
> > >>> can
> > >>> always choose not to EACCEPT any of the EMODPR requests. I'm not only
> > >>> confused here about the actual threat but also the potential adversary
> > >>> and
> > >>> target.
> > >>>
> > >> I'm not sure I follow your thoughts here. The sequence should be for enclave
> > >> to request  EMODPR in the first place through runtime to kernel, then to
> > >> verify with EACCEPT that the OS indeed has done EMODPR.
> > >> If enclave does not verify with EACCEPT, then its own code has
> > >> vulnerability. But this does not justify OS not providing the mechanism to
> > >> request EMODPR.
> > > 
> > > The question is really simple: what is the threat scenario? In order to use
> > > the word "vulnerability", you would need one.
> > > 
> > > Given the complexity of the whole dance with EMODPR it is mandatory to have
> > > one, in order to ack it to the mainline.
> > > 
> > 
> > Which complexity related to EMODPR are you concerned about? In a later message
> > you mention "This leaves only EAUG and EMODT requiring the EACCEPT handshake"
> > so it seems that you are perhaps concerned about the flow involving EACCEPT?
> > The OS does not require nor depend on EACCEPT being called as part of these flows
> > so a faulty or misbehaving user space omitting an EACCEPT call would not impact
> > these flows in the OS, but would of course impact the enclave.
> 
> I'd say *any* complexity because I see no benefit of supporting it. E.g.
> EMODPR/EACCEPT/EMODPE sequence I mentioned to Haitao concerns me. How is
> EMODPR going to help with any sort of workload?

I've even started think should we just always allow mmap()? The worst thing
that can happen is that the enclave crashes. Does that matter all that
much? I'm asking because access control is the main theme in SGX2 patch set
that IMHO should be considered to the ground. It really "stress tests" that
area. If we can settle on  that, then other things are just technical details
that we can surely sort out.

/Jarkko
