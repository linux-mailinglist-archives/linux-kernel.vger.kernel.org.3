Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553934DBDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 05:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiCQE5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 00:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiCQE5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 00:57:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9B1275B1;
        Wed, 16 Mar 2022 21:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E569CE2296;
        Thu, 17 Mar 2022 04:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4129C340E9;
        Thu, 17 Mar 2022 04:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647491623;
        bh=POUoBf600nbgvc/u7XulzZAAI++wE8DaYIxOSNvmlhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7BakpF53xL/tmtjmg7eRYvWaLXE67lDtzsNXQlC9QlCMp+NdYK46fcm3BUn4Lw5K
         +7lVV52od1TGWXvOeFayV17PI97ExxPJ/LhnyQaj7CfI4Fm9ji9n4ddOgl5JOZXUXZ
         sBObzrBGSx19xOa+ltwsqPvrkW+8klO4ycfdoIFbmoKtpPTx4pJ4PjXANr0fs7tRsa
         N3XCeNqypg7rb20LpMgfeaXj8p6hbupYbaqVT6ZI3npr9ZgmgI6AHGx8MEtCQdyEHi
         OTeQzLyOr+csHogWZpK+kXO9k0cROXFq8m3Hlnhc8vOSHvbW2Nedv2weFaM6gRNVW2
         hWjbOlWIaYuUg==
Date:   Thu, 17 Mar 2022 06:34:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nathaniel@profian.com
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <YjK6X3qX/E/J7qc+@iki.fi>
References: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <Yi6tPLLt9Q+ailQ3@iki.fi>
 <Yi6tinbF+Y7a66eQ@iki.fi>
 <Yi6va4dCaljiQ1WQ@iki.fi>
 <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:39:36AM -0500, Haitao Huang wrote:
> Hi Jarkko
> 
> On Sun, 13 Mar 2022 21:58:51 -0500, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Mon, Mar 14, 2022 at 04:50:56AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
> > > > On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
> > > >
> > > > > I saw Haitao's note that EMODPE requires "Read access permitted
> > > by enclave".
> > > > > This motivates that EMODPR->PROT_NONE should not be allowed
> > > since it would
> > > > > not be possible to relax permissions (run EMODPE) after that.
> > > Even so, I
> > > > > also found in the SDM that EACCEPT has the note "Read access
> > > permitted
> > > > > by enclave". That seems to indicate that EMODPR->PROT_NONE is
> > > not practical
> > > > > from that perspective either since the enclave will not be able to
> > > > > EACCEPT the change. Does that match your understanding?
> > > >
> > > > Yes, PROT_NONE should not be allowed.
> > > >
> > > > This is however the real problem.
> > > >
> > > > The current kernel patch set has inconsistent API and EMODPR ioctl is
> > > > simply unacceptable. It  also requires more concurrency management
> > > from
> > > > user space run-time, which would be heck a lot easier to do in the
> > > kernel.
> > > >
> > > > If you really want EMODPR as ioctl, then for consistencys sake,
> > > then EAUG
> > > > should be too. Like this when things go opposite directions, this
> > > patch set
> > > > plain and simply will not work out.
> > > >
> > > > I would pick EAUG's strategy from these two as it requires half
> > > the back
> > > > calls to host from an enclave. I.e. please combine mprotect() and
> > > EMODPR,
> > > > either in the #PF handler or as part of mprotect(), which ever
> > > suits you
> > > > best.
> > > >
> > > > I'll try demonstrate this with two examples.
> > > >
> > > > mmap() could go something like this() (simplified):
> > > > 1. Execution #UD's to SYSCALL.
> > > > 2. Host calls enclave's mmap() handler with mmap() parameters.
> > > > 3. Enclave up-calls host's mmap().
> > > > 4. Loops the range with EACCEPTCOPY.
> > > >
> > > > mprotect() has to be done like this:
> > > > 1. Execution #UD's to SYSCALL.
> > > > 2. Host calls enclave's mprotect() handler.
> > > > 3. Enclave up-calls host's mprotect().
> > > > 4. Enclave up-calls host's ioctl() to SGX_IOC_ENCLAVE_PERMISSIONS.
> 
> I assume up-calls here are ocalls as we call them in our implementation,
> which are the calls enclave make to untrusted side via EEXIT.
> 
> If so, can your implementation combine this two up-calls into one, then host
> side just do ioctl() and mprotect to kernel? If so, would that address your
> concern about extra up-calls?
> 
> 
> > > > 3. Loops the range with EACCEPT.
> > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   5. Loops the range with EACCEPT + EMODPE.
> > > 
> > > > This is just terrible IMHO. I hope these examples bring some insight.
> > 
> > E.g. in Enarx we have to add a special up-call (so called enarxcall in
> > intermediate that we call sallyport, which provides shared buffer to
> > communicate with the enclave) just for reseting the range with PROT_READ.
> > Feel very redundant, adds ugly cruft and is completely opposite strategy
> > to
> > what you've chosen to do with EAUG, which is I think correct choice as
> > far
> > as API is concerned.
> 
> The problem with EMODPR on #PF is that kernel needs to know what permissions
> requested from enclave at the time of #PF. So enclave has to make at least
> one call to kernel (again via ocall in our case, I assume up-call in your
> case) to make the change.

Your security scheme is broken if permissions are requested outside the
enclave, i.e. the hostile environment controls the permissions. That should
always come from the enclave and enclave uses EACCEPT* to validate that
what was given to EMODPR, EAUG and EMODT matches its expections.

Upper layer application should not never be in charge, and a broken
security scheme should never be supported.

If EMODPR sets unconditionally to PROT_READ, enclave is able to validate
this fact and then it can use EMODPE to set appropriate permissions.

BR, Jarkko
