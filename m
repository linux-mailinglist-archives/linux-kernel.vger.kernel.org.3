Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A79494E63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiATMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:54:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34608 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiATMxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:53:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8845616F2;
        Thu, 20 Jan 2022 12:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E78C340E0;
        Thu, 20 Jan 2022 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642683224;
        bh=mis9tUpiKFNKn1Gt78pVxuZell+C29XTqer3xCbdmDA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IcaF7gZdCW9O1QhNZNxOMi4CkhQ6PSoWHSuCvf1aSfhgNFmB4j6VO97TV5GrY+9if
         OAhibVGQjI5DqrGhm2MP/DHTrJwyc2bZEHn0MiEY6stRyWyEGkMMZdqUWQTufwHoWq
         SlAYlZe2ew2bmtEpbJuhMS0Zl0x9QuZ4ib4uNSwNwguD5aIUu6Bon3B+rWFM3aCzLF
         GBlSQLeyb1R0JmejEZZppxNwrHyILaq5mYtux0ktFFCDOK9bGePuxfqt7ng5uP9xat
         Z5Sr+dH5FibrWKKYLz251VQwrVb1BPcOiH8w8hrXqbISL5utz9r02vJboS1krmlEr5
         0AgI5HXVHsnZg==
Message-ID: <04761b2b4a77bda145a1fdb975da50da18c9d2d0.camel@kernel.org>
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Jan 2022 14:53:28 +0200
In-Reply-To: <eb696213-b066-0b6f-19ff-dd655b13209c@intel.com>
References: <YeHwzwnfsUcxiNbw@iki.fi>
         <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
         <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com> <YeIU6e6wetrifn+b@iki.fi>
         <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com> <YeIgzLzPu0U8s0sh@iki.fi>
         <YeK2hFcy72tYL61S@iki.fi>
         <CAHAy0tT7+AwgQUtzndj1E99hVcHNmyk2xJ6wUSxa4oPYytAMzA@mail.gmail.com>
         <YeYe/gGQbtTAXxLe@iki.fi> <YeYkdUHt7/HsRsZq@iki.fi>
         <eb696213-b066-0b6f-19ff-dd655b13209c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 12:59 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 1/17/2022 6:22 PM, Jarkko Sakkinen wrote:
> > On Tue, Jan 18, 2022 at 03:59:29AM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Jan 17, 2022 at 08:13:32AM -0500, Nathaniel McCallum
> > > wrote:
> > > > On Sat, Jan 15, 2022 at 6:57 AM Jarkko Sakkinen
> > > > <jarkko@kernel.org> wrote:
> > > > >=20
> > > > > On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen
> > > > > wrote:
> > > > > > On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre
> > > > > > wrote:
> > > > > > > Hi Jarkko,
> > > > > > >=20
> > > > > > > On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> > > > > > > > On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette
> > > > > > > > Chatre wrote:
> > > > > > > > > Hi Jarkko,
> > > > > > > > >=20
> > > > > > > > > On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> > > > > > > > > > On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette
> > > > > > > > > > Chatre wrote:
> > > > > > > > > > > Hi Jarkko,
> > > > > > > > > >=20
> > > > > > > > > > How enclave can check a page range that EPCM has
> > > > > > > > > > the expected permissions?
> > > > > > > > >=20
> > > > > > > > > Only way to change EPCM permissions from outside
> > > > > > > > > enclave is to run ENCLS[EMODPR]
> > > > > > > > > that needs to be accepted from within the enclave via
> > > > > > > > > ENCLU[EACCEPT]. At that
> > > > > > > > > time the enclave provides the expected permissions
> > > > > > > > > and that will fail
> > > > > > > > > if there is a mismatch with the EPCM permissions
> > > > > > > > > (SGX_PAGE_ATTRIBUTES_MISMATCH).
> > > > > > > >=20
> > > > > > > > This is a very valid point but that does make the
> > > > > > > > introspection possible
> > > > > > > > only at the time of EACCEPT.
> > > > > > > >=20
> > > > > > > > It does not give tools for enclave to make sure that
> > > > > > > > EMODPR-ETRACK dance
> > > > > > > > was ever exercised.
> > > > > > >=20
> > > > > > > Could you please elaborate? EACCEPT is available to the
> > > > > > > enclave as a tool
> > > > > > > and it would fail if ETRACK was not completed (error
> > > > > > > SGX_NOT_TRACKED).
> > > > > > >=20
> > > > > > > Here is the relevant snippet from the SDM from the
> > > > > > > section where it
> > > > > > > describes EACCEPT:
> > > > > > >=20
> > > > > > > IF (Tracking not correct)
> > > > > > > =C2=A0=C2=A0=C2=A0 THEN
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RFLAGS.ZF :=3D 1;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAX :=3D SGX_NOT_T=
RACKED;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GOTO DONE;
> > > > > > > FI;
> > > > > > >=20
> > > > > > > Reinette
> > > > > >=20
> > > > > > Yes, if enclave calls EACCEPT it does the necessary
> > > > > > introspection and makes
> > > > > > sure that ETRACK is completed. I have trouble understanding
> > > > > > how enclave
> > > > > > makes sure that EACCEPT was called.
> > > > >=20
> > > > > I'm not concerned of anything going wrong once EMODPR has
> > > > > been started.
> > > > >=20
> > > > > The problem nails down to that the whole EMODPR process is
> > > > > spawned by
> > > > > the entity that is not trusted so maybe that should further
> > > > > broke down
> > > > > to three roles:
> > > > >=20
> > > > > 1. Build process B
> > > > > 2. Runner process R.
> > > > > 3. Enclave E.
> > > > >=20
> > > > > And to the costraint that we trust B *more* than R. Once B
> > > > > has done all the
> > > > > needed EMODPR calls it would send the file descriptor to R.
> > > > > Even if R would
> > > > > have full access to /dev/sgx_enclave, it would not matter,
> > > > > since B has done
> > > > > EMODPR-EACCEPT dance with E.
> > > > >=20
> > > > > So what you can achieve with EMODPR is not protection against
> > > > > mistrusted
> > > > > *OS*. There's absolutely no chance you could use it for that
> > > > > purpose
> > > > > because mistrusted OS controls the whole process.
> > > > >=20
> > > > > EMODPR is to help to protect enclave against mistrusted
> > > > > *process*, i.e.
> > > > > in the above scenario R.
> > > >=20
> > > > There are two general cases that I can see. Both are valid.
> > > >=20
> > > > 1. The OS moves from a trusted to an untrusted state. This
> > > > could be
> > > > the multi-process system you've described. But it could also be
> > > > that
> > > > the kernel becomes compromised after the enclave is fully
> > > > initialized.
> > > >=20
> > > > 2. The OS is untrustworthy from the start.
> > > >=20
> > > > The second case is the stronger one and if you can solve it,
> > > > the first
> > > > one is solved implicitly. And our end goal is that if the OS
> > > > does
> > > > anything malicious we will crash in a controlled way.
> > > >=20
> > > > A defensive enclave will always want to have the least number
> > > > of
> > > > privileges for the maximum protection. Therefore, the enclave
> > > > will
> > > > want the OS to call EMODPR. If that were it, the host could
> > > > just lie.
> > > > But the enclave also verifies that the EMODPR operation was, in
> > > > fact,
> > > > executed by doing EACCEPT. When the enclave calls EACCEPT, if
> > > > the
> > > > kernel hasn't restricted permissions then we get a controlled
> > > > crash.
> > > > Therefore, we have solved the second case.
> > >=20
> > > So you're referring to this part of the SDM pseude code in the
> > > SDM:
> > >=20
> > > (* Check the destination EPC page for concurrency *)
> > > IF ( EPC page in use )
> > > =C2=A0=C2=A0=C2=A0 THEN #GP(0); FI;
> > >=20
> > > I wonder does "EPC page in use" unconditionally trigger when
> > > EACCEPT
> > > is invoked for a page for which all of these conditions hold:
> > >=20
> > > - .PR :=3D 0 (no EMODPR in progress)
> > > - .MODIFIED :=3D 0 (no EMODT in progress)
> > > - .PENDING :=3D 0 (no EMODPR in progress)
> > >=20
> > > I don't know the exact scope and scale of "EPC page in use".
> > >=20
> > > Then, yes, EACCEPT could be at least used to validate that one of
> > > the
> > > three operations above was requested. However, enclave thread
> > > cannot say
> > > which one was it, so it is guesswork.
> >=20
> > OK, I got it, and this last paragraph is not true. SECINFO given
> > EACCEPT
> > will lock in rest of the details and make the operation
> > deterministic.
>=20
> Indeed - so the SDM pseudo code that is relevant here can be found
> under
> the "(* Verify that accept request matches current EPC page settings
> *)"
> comment where the enclave can verify that all EPCM values are as they
> should
> and would fail with SGX_PAGE_ATTRIBUTES_MISMATCH if there is anything
> amiss.
>=20
> >=20
> > The only question mark then is the condition when no requests are
> > active.
>=20
> Could you please elaborate what you mean with this question? If no
> request
> is active then I understand that to mean that no request has started.

My issue was that when:

- .PR :=3D 0 (no EMODPR in progress)
- .MODIFIED :=3D 0 (no EMODT in progress)
- .PENDING :=3D 0 (no EMODPR in progress)

Does this trigger #GP when you call EACCEPT?

I don't think the answer matters that much tho sice if e.g. EMODPR was neve=
r
done, and enclave expected a change, #GP would trigger eventually in SECINF=
O
validation.

The way I look at EACCEPT is a memory verification tool it does the same at
run-time as EINIT does before run-time.

/Jarkko
