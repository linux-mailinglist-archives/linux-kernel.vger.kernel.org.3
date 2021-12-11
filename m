Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485994712A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 08:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhLKH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 02:58:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60198 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLKH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 02:57:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6DCF9CE2F2E;
        Sat, 11 Dec 2021 07:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A8FC004DD;
        Sat, 11 Dec 2021 07:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209475;
        bh=pNr9CZhQGLVbocWwMYJ49bvY8mM6mTI22/fci6jnc50=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g5ewPLubHWXzp4K1I8MGYAt8/cIrcOlCXMORWT/8/tdUyukYzQjtK/O7taJIoc6uu
         HlIJyzcd67Jcw6xvtdLxxDHKE7qs6YEg9fOzhvEzqhd/xJgtQKMRnU+BAGDfA3AdOw
         7Qrm0N2rwnAkhVrV+CA1bYzUSdOW/tzJUDoNUqIUWTQVki89EvWdKPhABUZE28r/z4
         a1IaAsZVETOPvGI5n9Mrtuf6AcIoWhqmDxiMn5Y4ZM5HIgXvSDEl3/zVfGS6GsIDUj
         ocHpxkrV45bHvQB7ZHg8i/jy8DguPKam5kNxMtRkDsmoIwSpOGjYYIS4nlIAFWx+T8
         fWToFIfVHiJwQ==
Message-ID: <407c12ed28b105a055c6ab6152c0458a31052963.camel@kernel.org>
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 09:57:51 +0200
In-Reply-To: <fff63bde-94a4-6c0c-3333-4cf392bee50b@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
         <Yav0/3jeJsuT3yEq@iki.fi> <fff63bde-94a4-6c0c-3333-4cf392bee50b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:42 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 3:08 PM, Jarkko Sakkinen wrote:
> > On Wed, Dec 01, 2021 at 11:23:08AM -0800, Reinette Chatre wrote:
> > > In the initial (SGX1) version of SGX, pages in an enclave need to be
> > > created with permissions that support all usages of the pages, from t=
he
> > > time the enclave is initialized until it is unloaded. For example,
> > > pages used by a JIT compiler or when code needs to otherwise be
> > > relocated need to always have RWX permissions.
> > >=20
> > > SGX2 includes two functions that can be used to modify the enclave pa=
ge
> > > permissions of regular enclave pages within an initialized enclave.
> > > ENCLS[EMODPR] is run from the OS and used to restrict enclave page
> > > permissions while ENCLU[EMODPE] is run from within the enclave to
> > > extend enclave page permissions.
> > >=20
> > > Enclave page permission changes need to be approached with care and
> > > for this reason this initial support is to allow enclave page
> > > permission changes _only_ if the new permissions are the same or
> > > more restrictive that the permissions originally vetted at the time t=
he
> > > pages were added to the enclave. Support for extending enclave page
> > > permissions beyond what was originally vetted is deferred.
> >=20
> > This paragraph is out-of-scope for a commit message. You could have
> > this in the cover letter but not here. I would just remove it.
>=20
> I think this is essential information that is mentioned in the cover=20
> letter _and_ in this changelog. I will follow Dave's guidance and avoid=
=20
> "deferred" by just removing that last sentence.
>=20
> >=20
> > > Whether enclave page permissions are restricted or extended it
> > > is necessary to ensure that the page table entries and enclave page
> > > permissions are in sync. Introduce a new ioctl, SGX_IOC_PAGE_MODP, to
> >=20
> > SGX_IOC_PAGE_MODP does not match the naming convetion of these:
> >=20
> > * SGX_IOC_ENCLAVE_CREATE
> > * SGX_IOC_ENCLAVE_ADD_PAGES
> > * SGX_IOC_ENCLAVE_INIT
>=20
> ah - my understanding was that the SGX_IOC_ENCLAVE prefix related to=20
> operations related to the entire enclave and thus I introduced the=20
> prefix SGX_IOC_PAGE to relate to operations on pages within an enclave.

SGX_IOC_ENCLAVE_ADD_PAGES is also operation working on pages within an
enclave.

Also, to be aligned with SGX_IOC_ENCLAVE_ADD_PAGES, the new operations
should also take secinfo as input.

>=20
> >=20
> > A better name would be SGX_IOC_ENCLAVE_MOD_PROTECTIONS. It doesn't
> > do harm to be a more verbose.
>=20
> Will do. I see later you propose SGX_IOC_ENCLAVE_MODIFY_TYPE - would you=
=20
> like them to be consistent wrt MOD/MODIFY?

I would considering introducing just one new ioctl:

  SGX_IOC_ENCLAVE_MODIFY_PAGES

and choose either operations based on e.g. a flag
(see flags field SGX_IOC_ENCLAVE_ADD_PAGES).

> Reinette

/Jarkko
