Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF3471289
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhLKHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:37:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45562 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhLKHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:37:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91045B80769;
        Sat, 11 Dec 2021 07:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934BFC004DD;
        Sat, 11 Dec 2021 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639208259;
        bh=Zj/+eWnmC/6vkZGQspwTJcgSX9QvGekqHMX2vREyCnE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k+7grp8lQfekSHF20oAc253eU8dkpXQxymLKZfC222FiFl92uxH6dy1SYEH/mzyAr
         eYZ5ApC7/KsCrJ7VWkhTgGEfCC9FO51swhCWfnJf3rl3bLe3lRD+boyiIyb0VOLhaV
         mxo2mXcXdRRtNaDujoxs4k6b9pujHVj+PHVm6F+AhLOJuEMG2NwJmUdivSswNaGqX8
         04fmMzg86bm6CmGafPGPHDsqyBa+Ix3nj34up0tAUriBHvZsdDmdEhIZ4m0FyAI2BI
         ZlELKDP/bx4aYk952S7Bjzyk0Aco7NcCDJ94oWM+oady04gas20+SCn5I65xScj0bC
         PelCCxIeIzaDw==
Message-ID: <eb8aa99b4d2ad3d8bb7cd01542dcb99520506d84.camel@kernel.org>
Subject: Re: [PATCH 04/25] x86/sgx: Add pfn_mkwrite() handler for present
 PTEs
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 09:37:34 +0200
In-Reply-To: <d39a9c2f-c69f-c5f1-6d4e-65d66bdbd06d@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <9edf8cd20628cbf400886d88e359fb24265fdef0.1638381245.git.reinette.chatre@intel.com>
         <YavvE+wF5XQNXlFu@iki.fi> <d39a9c2f-c69f-c5f1-6d4e-65d66bdbd06d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:18 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 2:43 PM, Jarkko Sakkinen wrote:
> > On Wed, Dec 01, 2021 at 11:23:02AM -0800, Reinette Chatre wrote:
> > > By default a write page fault on a present PTE inherits the permissio=
ns
> > > of the VMA. Enclave page permissions maintained in the hardware's
> > > Enclave Page Cache Map (EPCM) may change after a VMA accessing the pa=
ge
> > > is created. A VMA's permissions may thus exceed the enclave page
> > > permissions even though the VMA was originally created not to exceed
> > > the enclave page permissions. Following the default behavior during
> > > a page fault on a present PTE while the VMA permissions exceed the
> > > enclave page permissions would result in the PTE for an enclave page
> > > to be writable even though the page is not writable according to the
> > > enclave's permissions.
> > >=20
> > > Consider the following scenario:
> > > * An enclave page exists with RW EPCM permissions.
> > > * A RW VMA maps the range spanning the enclave page.
> > > * The enclave page's EPCM permissions are changed to read-only.
> >=20
> > How could this happen in the existing mainline code?
>=20
> This is a preparatory patch for SGX2 support. Restricting the=20
> permissions of an enclave page would require OS support that is added in=
=20
> a later patch.
>=20
> >=20
> > > * There is no page table entry for the enclave page.
> > >=20
> > > Q.
> > >   What will user space observe when an attempt is made to write to th=
e
> > >   enclave page from within the enclave?
> > >=20
> > > A.
> > >   Initially the page table entry is not present so the following is
> > >   observed:
> > >   1) Instruction writing to enclave page is run from within the encla=
ve.
> > >   2) A page fault with second and third bits set (0x6) is encountered
> > >      and handled by the SGX handler sgx_vma_fault() that installs a
> > >      read-only page table entry following previous patch that install=
s
> > >      page table entry with permissions that VMA and enclave agree on
> > >      (read-only in this case).
> > >   3) Instruction writing to enclave page is re-attempted.
> > >   4) A page fault with first three bits set (0x7) is encountered and
> > >      transparently (from SGX and user space perspective) handled by t=
he
> > >      OS with the page table entry made writable because the VMA is
> > >      writable.
> > >   5) Instruction writing to enclave page is re-attempted.
> > >   6) Since the EPCM permissions prevents writing to the page a new pa=
ge
> > >      fault is encountered, this time with the SGX flag set in the err=
or
> > >      code (0x8007). No action is taken by OS for this page fault and
> > >      execution returns to user space.
> > >   7) Typically such a fault will be passed on to an application with =
a
> > >      signal but if the enclave is entered with the vDSO function prov=
ided
> > >      by the kernel then user space does not receive a signal but inst=
ead
> > >      the vDSO function returns successfully with exception informatio=
n
> > >      (vector=3D14, error code=3D0x8007, and address) within the excep=
tion
> > >      fields within the vDSO function's struct sgx_enclave_run.
> > >=20
> > > As can be observed it is not possible for user space to write to an
> > > enclave page if that page's enclave page permissions do not allow so,
> > > no matter what the VMA or PTE allows.
> > >=20
> > > Even so, the OS should not allow writing to a page if that page is no=
t
> > > writable. Thus the page table entry should accurately reflect the
> > > enclave page permissions.
> > >=20
> > > Do not blindly accept VMA permissions on a page fault due to a write
> > > attempt to a present PTE. Install a pfn_mkwrite() handler that ensure=
s
> > > that the VMA permissions agree with the enclave permissions in this
> > > regard.
> > >=20
> > > Considering the same scenario as above after this change results in
> > > the following behavior change:
> > >=20
> > > Q.
> > >   What will user space observe when an attempt is made to write to th=
e
> > >   enclave page from within the enclave?
> > >=20
> > > A.
> > >   Initially the page table entry is not present so the following is
> > >   observed:
> > >   1) Instruction writing to enclave page is run from within the encla=
ve.
> > >   2) A page fault with second and third bits set (0x6) is encountered
> > >      and handled by the SGX handler sgx_vma_fault() that installs a
> > >      read-only page table entry following previous patch that install=
s
> > >      page table entry with permissions that VMA and enclave agree on
> > >      (read-only in this case).
> > >   3) Instruction writing to enclave page is re-attempted.
> > >   4) A page fault with first three bits set (0x7) is encountered and
> > >      passed to the pfn_mkwrite() handler for consideration. The handl=
er
> > >      determines that the page should not be writable and returns SIGB=
US.
> > >   5) Typically such a fault will be passed on to an application with =
a
> > >      signal but if the enclave is entered with the vDSO function prov=
ided
> > >      by the kernel then user space does not receive a signal but inst=
ead
> > >      the vDSO function returns successfully with exception informatio=
n
> > >      (vector=3D14, error code=3D0x7, and address) within the exceptio=
n fields
> > >      within the vDSO function's struct sgx_enclave_run.
> > >=20
> > > The accurate exception information supports the SGX runtime, which is
> > > virtually always implemented inside a shared library, by providing
> > > accurate information in support of its management of the SGX enclave.
> >=20
> > This QA-format is not a great idea, as it kind of tells what are the le=
git
> > questions to ask.
>=20
> I will remove the QA-format and just describe the two (before/after)=20
> scenarios.
>=20
> > You should describe what the patch does and what are the
> > legit reasons for doing that. Unfortunately, in the current form it is =
very
> > hard to get grip of this patch.
>=20
> That was the goal of the summary (the first paragraph) at the start of=
=20
> the changelog. Could you please elaborate how you would like me to=20
> improve it?

If I do a search "mktme" through the commit message, it gives
me zero results.

/Jarkko=13=13
