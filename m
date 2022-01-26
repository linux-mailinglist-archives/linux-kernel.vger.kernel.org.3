Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5049CC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiAZOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:42:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56940 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbiAZOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:41:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B983B81D44;
        Wed, 26 Jan 2022 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7B2C340E3;
        Wed, 26 Jan 2022 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208117;
        bh=cn+/zI4VIz9YEzNZSoSjYuaFtq2e0acwIf7Eh9M4sBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1DvjJzXthEZWF43IrSVETEvUA1GIv3ad2S7gGlvfg94+rTMb2OXSmj0ELc1h3VYQ
         45nTX9lJctBCuAPFf43SArTvpIOv4PFmJU67N+w6RLpync43LFT6RJuWdHTahIwicB
         4SWASnLaaO5ebn42tcfYUgvjo7NtKZ1MXC+0kFa/USek99J1o/KqA/QvZZW1VpdH3t
         SZ4AzzMLRhZyIndTr8CGzgdkst35PLe/DquPwehHnuxqBxBFbD4P+5EM46gsNexo1j
         PSIgB02f5Zj5OWntp6fKSbcYvNp/5WWKvt0NvZ348lnqKfkGR0ow9dsZD700Q2N4Ca
         90Q9y5W1PGa1A==
Date:   Wed, 26 Jan 2022 16:41:36 +0200
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
Message-ID: <YfFdoPkytm97hWad@iki.fi>
References: <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
 <YeIgzLzPu0U8s0sh@iki.fi>
 <YeK2hFcy72tYL61S@iki.fi>
 <CAHAy0tT7+AwgQUtzndj1E99hVcHNmyk2xJ6wUSxa4oPYytAMzA@mail.gmail.com>
 <YeYe/gGQbtTAXxLe@iki.fi>
 <YeYkdUHt7/HsRsZq@iki.fi>
 <eb696213-b066-0b6f-19ff-dd655b13209c@intel.com>
 <04761b2b4a77bda145a1fdb975da50da18c9d2d0.camel@kernel.org>
 <41ae95bb-45c8-24f9-1e57-617f28ed4f24@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ae95bb-45c8-24f9-1e57-617f28ed4f24@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 08:52:28AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 1/20/2022 4:53 AM, Jarkko Sakkinen wrote:
> > On Tue, 2022-01-18 at 12:59 -0800, Reinette Chatre wrote:
> >> Hi Jarkko,
> >>
> >> On 1/17/2022 6:22 PM, Jarkko Sakkinen wrote:
> >>> On Tue, Jan 18, 2022 at 03:59:29AM +0200, Jarkko Sakkinen wrote:
> >>>> On Mon, Jan 17, 2022 at 08:13:32AM -0500, Nathaniel McCallum
> >>>> wrote:
> >>>>> On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen
> >>>>> <jarkko@kernel.org> wrote:
> >>>>>>
> >>>>>> On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen
> >>>>>> wrote:
> >>>>>>> On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre
> >>>>>>> wrote:
> >>>>>>>> Hi Jarkko,
> >>>>>>>>
> >>>>>>>> On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> >>>>>>>>> On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette
> >>>>>>>>> Chatre wrote:
> >>>>>>>>>> Hi Jarkko,
> >>>>>>>>>>
> >>>>>>>>>> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> >>>>>>>>>>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette
> >>>>>>>>>>> Chatre wrote:
> >>>>>>>>>>>> Hi Jarkko,
> >>>>>>>>>>>
> >>>>>>>>>>> How enclave can check a page range that EPCM has
> >>>>>>>>>>> the expected permissions?
> >>>>>>>>>>
> >>>>>>>>>> Only way to change EPCM permissions from outside
> >>>>>>>>>> enclave is to run ENCLS[EMODPR]
> >>>>>>>>>> that needs to be accepted from within the enclave via
> >>>>>>>>>> ENCLU[EACCEPT]. At that
> >>>>>>>>>> time the enclave provides the expected permissions
> >>>>>>>>>> and that will fail
> >>>>>>>>>> if there is a mismatch with the EPCM permissions
> >>>>>>>>>> (SGX_PAGE_ATTRIBUTES_MISMATCH).
> >>>>>>>>>
> >>>>>>>>> This is a very valid point but that does make the
> >>>>>>>>> introspection possible
> >>>>>>>>> only at the time of EACCEPT.
> >>>>>>>>>
> >>>>>>>>> It does not give tools for enclave to make sure that
> >>>>>>>>> EMODPR-ETRACK dance
> >>>>>>>>> was ever exercised.
> >>>>>>>>
> >>>>>>>> Could you please elaborate? EACCEPT is available to the
> >>>>>>>> enclave as a tool
> >>>>>>>> and it would fail if ETRACK was not completed (error
> >>>>>>>> SGX_NOT_TRACKED).
> >>>>>>>>
> >>>>>>>> Here is the relevant snippet from the SDM from the
> >>>>>>>> section where it
> >>>>>>>> describes EACCEPT:
> >>>>>>>>
> >>>>>>>> IF (Tracking not correct)
> >>>>>>>>     THEN
> >>>>>>>>         RFLAGS.ZF := 1;
> >>>>>>>>         RAX := SGX_NOT_TRACKED;
> >>>>>>>>         GOTO DONE;
> >>>>>>>> FI;
> >>>>>>>>
> >>>>>>>> Reinette
> >>>>>>>
> >>>>>>> Yes, if enclave calls EACCEPT it does the necessary
> >>>>>>> introspection and makes
> >>>>>>> sure that ETRACK is completed. I have trouble understanding
> >>>>>>> how enclave
> >>>>>>> makes sure that EACCEPT was called.
> >>>>>>
> >>>>>> I'm not concerned of anything going wrong once EMODPR has
> >>>>>> been started.
> >>>>>>
> >>>>>> The problem nails down to that the whole EMODPR process is
> >>>>>> spawned by
> >>>>>> the entity that is not trusted so maybe that should further
> >>>>>> broke down
> >>>>>> to three roles:
> >>>>>>
> >>>>>> 1. Build process B
> >>>>>> 2. Runner process R.
> >>>>>> 3. Enclave E.
> >>>>>>
> >>>>>> And to the costraint that we trust B *more* than R. Once B
> >>>>>> has done all the
> >>>>>> needed EMODPR calls it would send the file descriptor to R.
> >>>>>> Even if R would
> >>>>>> have full access to /dev/sgx_enclave, it would not matter,
> >>>>>> since B has done
> >>>>>> EMODPR-EACCEPT dance with E.
> >>>>>>
> >>>>>> So what you can achieve with EMODPR is not protection against
> >>>>>> mistrusted
> >>>>>> *OS*. There's absolutely no chance you could use it for that
> >>>>>> purpose
> >>>>>> because mistrusted OS controls the whole process.
> >>>>>>
> >>>>>> EMODPR is to help to protect enclave against mistrusted
> >>>>>> *process*, i.e.
> >>>>>> in the above scenario R.
> >>>>>
> >>>>> There are two general cases that I can see. Both are valid.
> >>>>>
> >>>>> 1. The OS moves from a trusted to an untrusted state. This
> >>>>> could be
> >>>>> the multi-process system you've described. But it could also be
> >>>>> that
> >>>>> the kernel becomes compromised after the enclave is fully
> >>>>> initialized.
> >>>>>
> >>>>> 2. The OS is untrustworthy from the start.
> >>>>>
> >>>>> The second case is the stronger one and if you can solve it,
> >>>>> the first
> >>>>> one is solved implicitly. And our end goal is that if the OS
> >>>>> does
> >>>>> anything malicious we will crash in a controlled way.
> >>>>>
> >>>>> A defensive enclave will always want to have the least number
> >>>>> of
> >>>>> privileges for the maximum protection. Therefore, the enclave
> >>>>> will
> >>>>> want the OS to call EMODPR. If that were it, the host could
> >>>>> just lie.
> >>>>> But the enclave also verifies that the EMODPR operation was, in
> >>>>> fact,
> >>>>> executed by doing EACCEPT. When the enclave calls EACCEPT, if
> >>>>> the
> >>>>> kernel hasn't restricted permissions then we get a controlled
> >>>>> crash.
> >>>>> Therefore, we have solved the second case.
> >>>>
> >>>> So you're referring to this part of the SDM pseude code in the
> >>>> SDM:
> >>>>
> >>>> (* Check the destination EPC page for concurrency *)
> >>>> IF ( EPC page in use )
> >>>>     THEN #GP(0); FI;
> >>>>
> >>>> I wonder does "EPC page in use" unconditionally trigger when
> >>>> EACCEPT
> >>>> is invoked for a page for which all of these conditions hold:
> >>>>
> >>>> - .PR := 0 (no EMODPR in progress)
> >>>> - .MODIFIED := 0 (no EMODT in progress)
> >>>> - .PENDING := 0 (no EMODPR in progress)
> >>>>
> >>>> I don't know the exact scope and scale of "EPC page in use".
> >>>>
> >>>> Then, yes, EACCEPT could be at least used to validate that one of
> >>>> the
> >>>> three operations above was requested. However, enclave thread
> >>>> cannot say
> >>>> which one was it, so it is guesswork.
> >>>
> >>> OK, I got it, and this last paragraph is not true. SECINFO given
> >>> EACCEPT
> >>> will lock in rest of the details and make the operation
> >>> deterministic.
> >>
> >> Indeed - so the SDM pseudo code that is relevant here can be found
> >> under
> >> the "(* Verify that accept request matches current EPC page settings
> >> *)"
> >> comment where the enclave can verify that all EPCM values are as they
> >> should
> >> and would fail with SGX_PAGE_ATTRIBUTES_MISMATCH if there is anything
> >> amiss.
> >>
> >>>
> >>> The only question mark then is the condition when no requests are
> >>> active.
> >>
> >> Could you please elaborate what you mean with this question? If no
> >> request
> >> is active then I understand that to mean that no request has started.
> > 
> > My issue was that when:
> > 
> > - .PR := 0 (no EMODPR in progress)
> > - .MODIFIED := 0 (no EMODT in progress)
> > - .PENDING := 0 (no EMODPR in progress)
> > 
> > Does this trigger #GP when you call EACCEPT?
> 
> From what I understand a #GP would be triggered if the EACCEPT does not
> specify at least one of these. That would be a problem with the EACCEPT
> instruction as opposed to the EPCM contents or OS flow though. This
> can be found under the following comment in the SDM pseudo code:
> 
> (* Check that the combination of requested PT, PENDING and MODIFIED is legal *)
> 
> As far as the actual checking of EPCM values goes, it would not result
> in a #GP but for an unexpected value of MODIFIED or PENDING the EACCEPT
> will fail with SGX_PAGE_ATTRIBUTES_MISMATCH. EACCEPT does not enforce the PR
> bit but it _does_ enforce the individual permission bits.
> 
> > I don't think the answer matters that much tho sice if e.g. EMODPR was never
> > done, and enclave expected a change, #GP would trigger eventually in SECINFO
> > validation.
> 
> Similar here as I understand it will not be a #GP but EACCEPT failure with
> error SGX_PAGE_ATTRIBUTES_MISMATCH. The relevant pseudo-code in the SDM is
> below and you can see how MODIFIED and PENDING are matched but PR not (while
> the individual permission bits are):
> 
> (* Verify that accept request matches current EPC page settings *)
> IF ( (EPCM(DS:RCX).ENCLAVEADDRESS ≠ DS:RCX) or (EPCM(DS:RCX).PENDING ≠ SCRATCH_SECINFO.FLAGS.PENDING) or
> (EPCM(DS:RCX).MODIFIED ≠ SCRATCH_SECINFO.FLAGS.MODIFIED) or (EPCM(DS:RCX).R ≠ SCRATCH_SECINFO.FLAGS.R) or
> (EPCM(DS:RCX).W ≠ SCRATCH_SECINFO.FLAGS.W) or (EPCM(DS:RCX).X ≠ SCRATCH_SECINFO.FLAGS.X) or
> (EPCM(DS:RCX).PT ≠ SCRATCH_SECINFO.FLAGS.PT) )
> THEN
>      RFLAGS.ZF := 1;
>      RAX := SGX_PAGE_ATTRIBUTES_MISMATCH;
>      GOTO DONE;
> FI;
> 
> 
> > 
> > The way I look at EACCEPT is a memory verification tool it does the same at
> > run-time as EINIT does before run-time.
> 
> Indeed.

I think I got this now. Thank you anyway for further explanation :-)

> Reinette

/Jarkko
