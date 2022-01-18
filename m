Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59F4914CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 03:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiARCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 21:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbiARCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:23:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A748C0613E3;
        Mon, 17 Jan 2022 18:23:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 059DCB8122C;
        Tue, 18 Jan 2022 02:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AD1C36AEB;
        Tue, 18 Jan 2022 02:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472579;
        bh=uwSXBDaHlurEkOctOLsRQNIiAyTTLUDQ1Gyqx78oCZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mc4XhQx8joJC04FZuQUX4YUb62f7WhZ3ed1d0wa+zch3BI3a1MA5RgijGzbcSZ2aH
         1hifwTgdf9Q7VNxD9j1tTtT5YZO08XHlSjqkQNvmvcC1FWy+15wdj8ZTTS+uOQlg66
         +fwEyeKuHuWtkn21QAULqk067kEn8wQXmuU4hbX+RmWhZ15swlLef6l0pihTEWgqnu
         6lVw1/gxpHwNqIN/n7I3biONwxm2Kyq/BxCv1/9YBMC3rcWZLd8m+ahpTPKOlQ4ih5
         d3WpT+GqC26i1UeRsfyXWjogGLVjwdzfbp5kNvV+D6E85XbJqVUZfHDFK00EAc3tqH
         KUeyaJWkam0+A==
Date:   Tue, 18 Jan 2022 04:22:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nathaniel McCallum <nathaniel@profian.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YeYkdUHt7/HsRsZq@iki.fi>
References: <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
 <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
 <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
 <YeIgzLzPu0U8s0sh@iki.fi>
 <YeK2hFcy72tYL61S@iki.fi>
 <CAHAy0tT7+AwgQUtzndj1E99hVcHNmyk2xJ6wUSxa4oPYytAMzA@mail.gmail.com>
 <YeYe/gGQbtTAXxLe@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeYe/gGQbtTAXxLe@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:59:29AM +0200, Jarkko Sakkinen wrote:
> On Mon, Jan 17, 2022 at 08:13:32AM -0500, Nathaniel McCallum wrote:
> > On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen wrote:
> > > > On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre wrote:
> > > > > Hi Jarkko,
> > > > >
> > > > > On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> > > > > > On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
> > > > > >> Hi Jarkko,
> > > > > >>
> > > > > >> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> > > > > >>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
> > > > > >>>> Hi Jarkko,
> > > > > >>>
> > > > > >>> How enclave can check a page range that EPCM has the expected permissions?
> > > > > >>
> > > > > >> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
> > > > > >> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
> > > > > >> time the enclave provides the expected permissions and that will fail
> > > > > >> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
> > > > > >
> > > > > > This is a very valid point but that does make the introspection possible
> > > > > > only at the time of EACCEPT.
> > > > > >
> > > > > > It does not give tools for enclave to make sure that EMODPR-ETRACK dance
> > > > > > was ever exercised.
> > > > >
> > > > > Could you please elaborate? EACCEPT is available to the enclave as a tool
> > > > > and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).
> > > > >
> > > > > Here is the relevant snippet from the SDM from the section where it
> > > > > describes EACCEPT:
> > > > >
> > > > > IF (Tracking not correct)
> > > > >     THEN
> > > > >         RFLAGS.ZF := 1;
> > > > >         RAX := SGX_NOT_TRACKED;
> > > > >         GOTO DONE;
> > > > > FI;
> > > > >
> > > > > Reinette
> > > >
> > > > Yes, if enclave calls EACCEPT it does the necessary introspection and makes
> > > > sure that ETRACK is completed. I have trouble understanding how enclave
> > > > makes sure that EACCEPT was called.
> > >
> > > I'm not concerned of anything going wrong once EMODPR has been started.
> > >
> > > The problem nails down to that the whole EMODPR process is spawned by
> > > the entity that is not trusted so maybe that should further broke down
> > > to three roles:
> > >
> > > 1. Build process B
> > > 2. Runner process R.
> > > 3. Enclave E.
> > >
> > > And to the costraint that we trust B *more* than R. Once B has done all the
> > > needed EMODPR calls it would send the file descriptor to R. Even if R would
> > > have full access to /dev/sgx_enclave, it would not matter, since B has done
> > > EMODPR-EACCEPT dance with E.
> > >
> > > So what you can achieve with EMODPR is not protection against mistrusted
> > > *OS*. There's absolutely no chance you could use it for that purpose
> > > because mistrusted OS controls the whole process.
> > >
> > > EMODPR is to help to protect enclave against mistrusted *process*, i.e.
> > > in the above scenario R.
> > 
> > There are two general cases that I can see. Both are valid.
> > 
> > 1. The OS moves from a trusted to an untrusted state. This could be
> > the multi-process system you've described. But it could also be that
> > the kernel becomes compromised after the enclave is fully initialized.
> > 
> > 2. The OS is untrustworthy from the start.
> > 
> > The second case is the stronger one and if you can solve it, the first
> > one is solved implicitly. And our end goal is that if the OS does
> > anything malicious we will crash in a controlled way.
> > 
> > A defensive enclave will always want to have the least number of
> > privileges for the maximum protection. Therefore, the enclave will
> > want the OS to call EMODPR. If that were it, the host could just lie.
> > But the enclave also verifies that the EMODPR operation was, in fact,
> > executed by doing EACCEPT. When the enclave calls EACCEPT, if the
> > kernel hasn't restricted permissions then we get a controlled crash.
> > Therefore, we have solved the second case.
> 
> So you're referring to this part of the SDM pseude code in the SDM:
> 
> (* Check the destination EPC page for concurrency *)
> IF ( EPC page in use )
>     THEN #GP(0); FI;
> 
> I wonder does "EPC page in use" unconditionally trigger when EACCEPT
> is invoked for a page for which all of these conditions hold:
> 
> - .PR := 0 (no EMODPR in progress)
> - .MODIFIED := 0 (no EMODT in progress)
> - .PENDING := 0 (no EMODPR in progress)
> 
> I don't know the exact scope and scale of "EPC page in use".
> 
> Then, yes, EACCEPT could be at least used to validate that one of the
> three operations above was requested. However, enclave thread cannot say
> which one was it, so it is guesswork.

OK, I got it, and this last paragraph is not true. SECINFO given EACCEPT
will lock in rest of the details and make the operation deterministic.

The only question mark then is the condition when no requests are active.

/Jarkko
