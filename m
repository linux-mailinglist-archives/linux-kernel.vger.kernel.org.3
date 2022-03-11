Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9542E4D61A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbiCKMfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbiCKMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:35:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D691B45DF;
        Fri, 11 Mar 2022 04:34:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F02E2CE292B;
        Fri, 11 Mar 2022 12:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D7BC340E9;
        Fri, 11 Mar 2022 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647002039;
        bh=JoyV6/q/Uv7sQ/xVpdf2TXqXbH4Qjo/Nc2SlRZv/Q/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIlHp1KHcxxQeF3O1qwwEQTVk9qL2OJA8GZXjr6kQ2zUd0/Zo3gY/mRGexds8zgJ3
         zNcHEGSceWANzM6rMcTDlaGJ5fK0BQ7sKarseBeL/ovQw8kfrf/vkoFBkLzTgFlmVg
         jIxBypGKFoXNs3s31XpvyI5Nr8RSSYUlIib24Tw4YEGUAAL0wgDHtiXKfYbnQaCeiE
         wyS/OWVC5jxpz7EQ0goN9iQbm6tEJexOgk72Z6iSqohaJ4itX8H+SQ9pYfbXu7uKlj
         IS5uMsTf5nu91jDB90PJtDxCjTT9COxE1j/wRWfK+BitE8IoImClzGcGJn6Dkm387e
         v3ZFmoOrpCAKA==
Date:   Fri, 11 Mar 2022 14:33:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
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
Message-ID: <YitBinMgBpPbqful@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yis9rA8uC/0bmWCF@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:16:47PM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 02:10:24PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 10, 2022 at 12:33:20PM -0600, Haitao Huang wrote:
> > > Hi Jarkko
> > > 
> > > I have some trouble understanding the sequences below.
> > > 
> > > On Thu, 10 Mar 2022 00:10:48 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > 
> > > > On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
> > > > > Hi All,
> > > > > 
> > > > > Regarding the recent update of splitting the page permissions change
> > > > > request into two IOCTLS (RELAX and RESTRICT), can we combine them into
> > > > > one? That is, revert to how it was done in the v1 version?
> > > > > 
> > > > > Why? Currently in Gramine (a library OS for unmodified applications,
> > > > > https://gramineproject.io/) with the new proposed change, one needs to
> > > > > store the page permission for each page or range of pages. And for every
> > > > > request of `mmap` or `mprotect`, Gramine would have to do a lookup
> > > > > of the
> > > > > page permissions for the request range and then call the respective
> > > > > IOCTL
> > > > > either RESTRICT or RELAX. This seems a little overwhelming.
> > > > > 
> > > > > Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do
> > > > > an `EACCEPT` irrespective of RELAX or RESTRICT page permission request?
> > > > > With this approach, we can avoid storing  page permissions and simplify
> > > > > the implementation.
> > > > > 
> > > > > I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK`
> > > > > flows
> > > > > to do TLB shootdowns which might not be needed for RELAX IOCTL but I am
> > > > > not sure what will be the performance impact. Is there any data point to
> > > > > see the performance impact?
> > > > > 
> > > > > Thanks,
> > > > > -Vijay
> > > > 
> > > > This should get better in the next versuin. "relax" is gone. And for
> > > > dynamic EAUG'd pages only VMA and EPCM permissions matter, i.e.
> > > > internal vm_max_prot_bits is set to RWX.
> > > > 
> > > > I patched the existing series eno
> > > > 
> > > > For Enarx I'm using the following patterns.
> > > > 
> > > > Shim mmap() handler:
> > > > 1. Ask host for mmap() syscall.
> > > > 2. Construct secinfo matching the protection bits.
> > > > 3. For each page in the address range: EACCEPTCOPY with a
> > > >    zero page.
> > > 
> > > For EACCEPTCOPY to work, I believe PTE.RW is required for the target page.
> > > So this only works for mmap(..., RW) or mmap(...,RWX).
> > 
> > I use it only with EAUG.
> > 
> > > So that gives you pages with RW/RWX.
> > > 
> > > To change permissions of any of those pages from RW/RWX to R/RX , you need
> > > call ENCLAVE_RESTRICT_PERMISSIONS ioctl with R or with PROT_NONE. you can't
> > > just do EMODPE.
> > > 
> > > so for RW->R, you either:
> > > 
> > > 1)EMODPR(EPCM.NONE)
> > > 2)EACCEPT(EPCM.NONE)
> > > 3)EMODPE(R) -- not sure this would work as spec says EMODPE requires "Read
> > > access permitted by enclave"
> > > 
> > > or:
> > > 
> > > 1)EMODPR(EPCM.PROT_R)
> > > 2)EACCEPT(EPCM.PROT_R)
> > 
> > I checked from SDM and you're correct.
> > 
> > Then the appropriate thing is to reset to R.
> > 
> > > > Shim mprotect() handler:
> > > > 1. Ask host for mprotect() syscall.
> > > > 2. For each page in the address range: EACCEPT with PROT_NONE
> > > >    secinfo and EMODPE with the secinfo having the prot bits.
> > > 
> > > EACCEPT requires PTE.R. And EAUG'd pages will always initialized with
> > > EPCM.RW,
> > > so EACCEPT(EPCM.PROT_NONE) will fail with SGX_PAGE_ATTRIBUTES_MISMATCH.
> > 
> > Ditto.
> > 
> > > > Backend mprotect() handler:
> > > > 1. Invoke ENCLAVE_RESTRICT_PERMISSIONS ioctl for the address
> > > >    range with PROT_NONE.
> > > > 2. Invoke real mprotect() syscall.
> > > > 
> > > Note #1 can only be done after EACCEPT. MODPR is not allowed for pending
> > > pages.
> > 
> > Yes, and that's what I'm doing. After that shim does EACCEPT's in a loop.
> > 
> > Reinette, the ioctl should already check that either R or W is set in
> > secinfo and return -EACCES.
> > 
> > I.e.
> > 
> > (* Check for misconfigured SECINFO flags*)
> > IF ( (SCRATCH_SECINFO reserved fields are not zero ) or
> > (SCRATCH_SECINFO.FLAGS.R is 0 and SCRATCH_SECINFO.FLAGS.W is not 0) )
> > THEN #GP(0); FI;
> > 
> > I was testing this and wondering why my enclave #GP's, and then I checked
> > SDM after reading Haitao's response. So clearly check in kernel side is
> > needed.
> 
> I would consider also adding such check "add pages". It's our least common
> denominator.
> 
> If we can assume that at least R is there for every enclave page, then it
> gives invariant that enables EMODPR with R all the time.

Since EAUG is done already in the #PF handler, so must be EMODPR. Otherwise
we do things incosistently [*]. One being in #PF handler and other being
ioctl is unacceptable.

Moving EMODPR to #PF handler would be trivial:

1. In mprotect() callback unmap PTE's for
   the range.
2. In #PF handler, EMODPR with read permissions.

This is something that would be understandable for the user space. The only
API ever required would be EMODPE for permission changes. You could
basically implement the whole thing for EPCM inside enclave with no ioctls
required.

That would leave only ioctls to the series:
1. SGX_IOC_ENCLAVE_MODIFY_TYPE
2. SGX_IOO_ENCLAVE_REMOVE_PAGES

[*] For me stick to #PF handler for EAUG is fine for the first mainline
version. The API side is factors more critical.

BR, Jarkko

