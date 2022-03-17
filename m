Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8304DD065
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiCQVwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCQVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3392C541A;
        Thu, 17 Mar 2022 14:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE2AB61A38;
        Thu, 17 Mar 2022 21:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD685C340E9;
        Thu, 17 Mar 2022 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647553889;
        bh=UEjtWBrvVMzMTeXYvIZE6l7v6RCpQdgoiA55NPHYC4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7F94hWCDcDo37NBNHPqkZ1uqtCmipODNhNkbKq72Zjn6K6DwDvOgaWQFOn6u+yTR
         XA10HM9HBC/5VWOL3M4olrII9rw9LYCWvZjlIwq9uidgLXJ1/ndBc/xvK4Rr1pMM2k
         rd527wNHlN1LfjyfA7rhRmY7DO6jf6MSU5vroAZJXKNxxCNp52oxhIMqwhnRWirAto
         FvfaJgg63qX7Wsos8vHxFXHIm8xJRMkXbhdOxf52rumDXx97sMDhVW9kWJ7/98K9dB
         A3hzPAs33yGZDcUFU8MMA5WfRk7c4FgqQhKNAphAAtFImOg+JAwTa1HcCw2pWuZhdS
         8yyhWKaryq0aA==
Date:   Thu, 17 Mar 2022 23:50:38 +0200
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
Message-ID: <YjOtLp4f4nu18Fzx@iki.fi>
References: <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <Yi6tPLLt9Q+ailQ3@iki.fi>
 <Yi6tinbF+Y7a66eQ@iki.fi>
 <Yi6va4dCaljiQ1WQ@iki.fi>
 <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net>
 <YjLcr9TwLNWUtwkS@iki.fi>
 <YjLfIMz4/Vx8Jm24@iki.fi>
 <op.1i6iegamwjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1i6iegamwjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:28:45AM -0500, Haitao Huang wrote:
> Hi
> 
> On Thu, 17 Mar 2022 02:11:28 -0500, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Thu, Mar 17, 2022 at 09:01:07AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Mar 14, 2022 at 10:39:36AM -0500, Haitao Huang wrote:
> > > > Hi Jarkko
> > > >
> > > > On Sun, 13 Mar 2022 21:58:51 -0500, Jarkko Sakkinen
> > > <jarkko@kernel.org>
> > > > wrote:
> > > >
> > > > > On Mon, Mar 14, 2022 at 04:50:56AM +0200, Jarkko Sakkinen wrote:
> > > > > > On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
> > > > > > > On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
> > > > > > >
> > > > > > > > I saw Haitao's note that EMODPE requires "Read access
> > > permitted
> > > > > > by enclave".
> > > > > > > > This motivates that EMODPR->PROT_NONE should not be allowed
> > > > > > since it would
> > > > > > > > not be possible to relax permissions (run EMODPE) after that.
> > > > > > Even so, I
> > > > > > > > also found in the SDM that EACCEPT has the note "Read access
> > > > > > permitted
> > > > > > > > by enclave". That seems to indicate that EMODPR->PROT_NONE is
> > > > > > not practical
> > > > > > > > from that perspective either since the enclave will not be
> > > able to
> > > > > > > > EACCEPT the change. Does that match your understanding?
> > > > > > >
> > > > > > > Yes, PROT_NONE should not be allowed.
> > > > > > >
> > > > > > > This is however the real problem.
> > > > > > >
> > > > > > > The current kernel patch set has inconsistent API and EMODPR
> > > ioctl is
> > > > > > > simply unacceptable. It  also requires more concurrency
> > > management
> > > > > > from
> > > > > > > user space run-time, which would be heck a lot easier to do
> > > in the
> > > > > > kernel.
> > > > > > >
> > > > > > > If you really want EMODPR as ioctl, then for consistencys sake,
> > > > > > then EAUG
> > > > > > > should be too. Like this when things go opposite directions,
> > > this
> > > > > > patch set
> > > > > > > plain and simply will not work out.
> > > > > > >
> > > > > > > I would pick EAUG's strategy from these two as it requires half
> > > > > > the back
> > > > > > > calls to host from an enclave. I.e. please combine
> > > mprotect() and
> > > > > > EMODPR,
> > > > > > > either in the #PF handler or as part of mprotect(), which ever
> > > > > > suits you
> > > > > > > best.
> > > > > > >
> > > > > > > I'll try demonstrate this with two examples.
> > > > > > >
> > > > > > > mmap() could go something like this() (simplified):
> > > > > > > 1. Execution #UD's to SYSCALL.
> > > > > > > 2. Host calls enclave's mmap() handler with mmap() parameters.
> > > > > > > 3. Enclave up-calls host's mmap().
> > > > > > > 4. Loops the range with EACCEPTCOPY.
> > > > > > >
> > > > > > > mprotect() has to be done like this:
> > > > > > > 1. Execution #UD's to SYSCALL.
> > > > > > > 2. Host calls enclave's mprotect() handler.
> > > > > > > 3. Enclave up-calls host's mprotect().
> > > > > > > 4. Enclave up-calls host's ioctl() to
> > > SGX_IOC_ENCLAVE_PERMISSIONS.
> > > >
> > > > I assume up-calls here are ocalls as we call them in our
> > > implementation,
> > > > which are the calls enclave make to untrusted side via EEXIT.
> > > >ar
> > > > If so, can your implementation combine this two up-calls into one,
> > > then host
> > > > side just do ioctl() and mprotect to kernel? If so, would that
> > > address your
> > > > concern about extra up-calls?
> > > >
> > > >
> > > > > > > 3. Loops the range with EACCEPT.
> > > > > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >   5. Loops the range with EACCEPT + EMODPE.
> > > > > >
> > > > > > > This is just terrible IMHO. I hope these examples bring some
> > > insight.
> > > > >
> > > > > E.g. in Enarx we have to add a special up-call (so called
> > > enarxcall in
> > > > > intermediate that we call sallyport, which provides shared buffer to
> > > > > communicate with the enclave) just for reseting the range with
> > > PROT_READ.
> > > > > Feel very redundant, adds ugly cruft and is completely opposite
> > > strategy
> > > > > to
> > > > > what you've chosen to do with EAUG, which is I think correct
> > > choice as
> > > > > far
> > > > > as API is concerned.
> > > >
> > > > The problem with EMODPR on #PF is that kernel needs to know what
> > > permissions
> > > > requested from enclave at the time of #PF. So enclave has to make
> > > at least
> > > > one call to kernel (again via ocall in our case, I assume up-call
> > > in your
> > > > case) to make the change.
> > > 
> > > The #PF handler should do unconditionally EMODPR with PROT_READ.
> > 
> > Or mprotect(), as long as secinfo contains PROT_READ. I don't care about
> > this detail hugely anymore because it does not affect uapi.
> > 
> > Using EMODPR as a permission control mechanism is a ridiculous idea, and
> > I cannot commit to maintain a broken uapi.
> > 
> 
> Jarkko, how would automatically forcing PROT_READ on #PF work for this
> sequence?
> 
> 1) EAUG a page (has to be RW)
> 2) EACCEPT(RW)
> 3) enclave copies some data to page
> 4) enclave wants to change permission to R
> 
> If you are proposing mprotect, then as I indicated earlier, please address
> concerns raised by Reinette:
> https://lore.kernel.org/linux-sgx/e1c04077-0165-c5ec-53be-7fd732965e80@intel.com/

For EAUG you can choose between #PF handler and having it as part of
mmap() with the same uapi.

For EMODPR clearly #PF handler would be tricky but nothing prevents
resetting the permissions as part of mprotect() flow, which is trivial.

One good reason to have a fixed EMODPR is that e.g. emulating properly
mprotect() is almost undoable if you don't do it otherwise. Specifically
the scenario where your address range spans through multiple adjacent
VMAs. It's even without EMODPR complex enough scenario that you really
don't want to ask yourself for more trouble than use EMODPR in a super
conservative manner.

Having EMODPR fully exposed will only make more difficult API to do with
extra round-trips. If you want to use ring-0 instructions fully exposed,
please don't use a kernel. There's a bunch of hardware features in Intel
CPUs for which Linux does not provide 1:1 all wide open interfaces.

BR, Jarkko
