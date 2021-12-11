Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FF471200
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhLKFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:43:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38922 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLKFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:43:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EABEB82AA5;
        Sat, 11 Dec 2021 05:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C5CC004DD;
        Sat, 11 Dec 2021 05:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639201197;
        bh=hwFn8av9NpYhRVc0lXY+IBn8be7Fk/0rfLSz20DagtE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HLSkIJOs6fRJnyGs/82DPwZ+Oymo0iUb7oWWSok/1fFbhKDjQOHT3QjnlV/ZQ5zgp
         tnMZcUU4EwXOAg7OgVKCIdHjMpWE5JX4BwGXKtrgSiRcET6/SNI++vQu0IkjewBgbM
         KBdo2nztCmPLf0AewljKCQbRRHNht9LR3dtajurjFN6BQz/Fokc0s6PS1mfEGVTvVj
         hqyHl0+gKUCGv5FTeBsf8SfxKzI2ghaSH111QEWV6HZhqdpMSFnimoPkOH+0u43cqp
         75OdVSBaWUHjIFu8fW7AhUbZtNw78VtPVpMdyHZSoYlfrLyHj2cDB1f+cbwzJmjw5t
         CssCXszHxpaqg==
Message-ID: <bb7757c5b5cc3fe45e74cbee1ddafb9c71c4f4e1.camel@kernel.org>
Subject: Re: [PATCH 03/25] x86/sgx: Support VMA permissions exceeding
 enclave permissions
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 07:39:54 +0200
In-Reply-To: <81308f67-a4d1-1774-f58b-223d4e81f8db@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <7e622156315c9c22c3ef84a7c0aeb01b5c001ff9.1638381245.git.reinette.chatre@intel.com>
         <Yavq83gZzvkVaDqq@iki.fi> <YavrSFDJBGqe7K46@iki.fi>
         <81308f67-a4d1-1774-f58b-223d4e81f8db@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:16 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 2:27 PM, Jarkko Sakkinen wrote:
> > On Sun, Dec 05, 2021 at 12:25:59AM +0200, Jarkko Sakkinen wrote:
> > > On Wed, Dec 01, 2021 at 11:23:01AM -0800, Reinette Chatre wrote:
> > > > =3D=3D=3D Summary =3D=3D=3D
> > > >=20
> > > > An SGX VMA can only be created if its permissions are the same or
> > > > weaker than the Enclave Page Cache Map (EPCM) permissions. After VM=
A
> > > > creation this rule continues to be enforced by the page fault handl=
er.
> > > >=20
> > > > With SGX2 the EPCM permissions of a page can change after VMA
> > > > creation resulting in the VMA exceeding the EPCM permissions and th=
e
> > > > page fault handler incorrectly blocking access.
> > > >=20
> > > > Enable the VMA's pages to remain accessible while ensuring that
> > > > the page table entries are installed to match the EPCM permissions
> > > > without exceeding the VMA perms issions.
> > >=20
> > > I don't understand what the short summary means in English, and the
> > > commit message is way too bloated to make any conclusions. It really
> > > needs a rewrite.
> > >=20
> > > These were the questions I could not find answer for:
> > >=20
> > > 1. Why it would be by any means safe to remove a permission check?
>=20
> The permission check is redundant for SGX1 and incorrect for SGX2.
>=20
> In the current SGX1 implementation the permission check in=20
> sgx_encl_load_page() is redundant because an SGX VMA can only be created=
=20
> if its permissions are the same or weaker than the EPCM permissions.
>=20
> In SGX2 a user is able to change EPCM permissions during runtime (while=
=20
> VMA has the memory mapped). A RW VMA may thus originally have mapped an=
=20
> enclave page with RW EPCM permissions but since then the enclave page=20
> may have its permissions changed to read-only. The VMA should still be=
=20
> able to read those enclave pages but the check in sgx_encl_load_page()=
=20
> will prevent that.
>=20
> > > 2. Why not re-issuing mmap()'s is unfeasible? I.e. close existing
> > >     VMA's and mmap() new ones.
>=20
> User is not prevented from closing existing VMAs and creating new ones.
>=20
> > 3. Isn't this an API/ABI break?
>=20
> Could you please elaborate where you see the API/ABI break? The rule=20
> that new VMAs cannot exceed EPCM permissions is untouched.
>=20
> Reinette

I just don't understand the description. There's a whole bunch of text
but=20

It does not discuss what the patch does in low-level detail what the
patch does, e.g. the use of vm_insert_pfn_prot(). I honestly do not
get the story here...

/Jarkko
