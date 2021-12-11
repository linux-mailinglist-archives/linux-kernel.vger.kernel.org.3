Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916434712A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhLKIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:00:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60878 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLKIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:00:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51DD3CE2F2A;
        Sat, 11 Dec 2021 08:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C32C004DD;
        Sat, 11 Dec 2021 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639209626;
        bh=gk/pnaYtvoyCznrv2bELrpd8OKGXJvBahzKbG4HQShw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hduvZKPoi7O+qSafpiEwFVJfk3KXb5Bi/d+3fglNXqlmwpYrA8JflWOtHFPIsz5Ze
         qTq2FYlkrU1sSKrBeESJWeABMscxtUU9IYXBO0/9PApQY7xJfkiN20RH43XzveHGnW
         uu+6Hl+ax+L8xLuLgPx0+H4kun9fozt/zWi0Ylik17sJDAhFypa28dy5chZ3yn19Ve
         uWRzNlRws/0f20JlkkiRps9jkkTKuY0whZkfVMBlGyXHDbil/z5lH+Dmi7+Whf4ECs
         JiFB+KDFbT2VTGvrWnFX5bxyFJSn9fAkRdQZFbDo8L9FmF04cDnTyjbrtOmBypKJU7
         S3FrBV9KW133w==
Message-ID: <ce00226feaa02dbc0f66f3f8aa7a243f61e410aa.camel@kernel.org>
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 10:00:22 +0200
In-Reply-To: <cc6ecffd-7d4b-0b15-eaf1-6f585e8b31be@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
         <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
         <Yav1/ZRX68cECD7a@iki.fi> <cc6ecffd-7d4b-0b15-eaf1-6f585e8b31be@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 13:44 -0800, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 12/4/2021 3:13 PM, Jarkko Sakkinen wrote:
> > "to initialize" -> "to an initialized"
>=20
> Will do.
>=20
>=20
> >=20
> > On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
> > > With SGX1 an enclave needs to be created with its maximum memory dema=
nds
> > > allocated. Pages cannot be added to an enclave after it is initialize=
d.
> > > SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> > > pages to an initialized enclave. With SGX2 the enclave still needs to
> > > set aside address space for its maximum memory demands during enclave
> > > creation, but all pages need not be added before enclave initializati=
on.
> > > Pages can be added during enclave runtime.
> > >=20
> > > Add support for dynamically adding pages to an initialized enclave,
> > > architecturally limited to RW permission. Add pages via the page faul=
t
> > > handler at the time an enclave address without a backing enclave page
> > > is accessed, potentially directly reclaiming pages if no free pages
> > > are available.
> > >=20
> > > The enclave is still required to run ENCLU[EACCEPT] on the page befor=
e
> > > it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT=
]
> > > on an uninitialized address. This will trigger the page fault handler
> > > that will add the enclave page and return execution to the enclave to
> > > repeat the ENCLU[EACCEPT] instruction, this time successful.
> > >=20
> > > If the enclave accesses an uninitialized address in another way, for
> > > example by expanding the enclave stack to a page that has not yet bee=
n
> > > added, then the page fault handler would add the page on the first
> > > write but upon returning to the enclave the instruction that triggere=
d
> > > the page fault would be repeated and since ENCLU[EACCEPT] was not run
> > > yet it would trigger a second page fault, this time with the SGX flag
> > > set in the page fault error code. This can only be recovered by enter=
ing
> > > the enclave again and directly running the ENCLU[EACCEPT] instruction=
 on
> > > the now initialized address.
> > >=20
> > > Accessing an uninitialized address from outside the enclave also trig=
gers
> > > this flow but the page will remain in PENDING state until accepted fr=
om
> > > within the enclave.
> >=20
> > What does it mean being in PENDING state, and more imporantly, what is
> > PENDING state? What does a memory access within enclave cause when it
> > touch a page within this state?
>=20
> The PENDING state is the enclave page state from the SGX hardware's=20
> perspective. The OS uses the ENCLS[EAUG] SGX2 function to add a new page=
=20
> to the enclave but from the SGX hardware's perspective it would be in a=
=20
> PENDING state until the enclave accepts the page. An access to the page=
=20
> in PENDING state would result in a page fault.
>=20
>=20
> > I see a lot of text in the commit message but zero mentions about EPCM
> > expect this one sudden mention about PENDING field without attaching
> > it to anything concrete.
>=20
> My apologies - I will add this to this changelog. This matches your=20
> request to describe the __eaug() wrapper introduced in patch 02/25.=20
> Would you like me to duplicate this information here and in that patch=
=20
> (a new patch dedicated to the __eaug() wrapper) or would you be ok if I=
=20
> introduce the wrappers all together briefly as in the example you=20
> provide and then detail the flows where the wrappers are used - like=20
> this patch?

I think it would be a good place to describe these details in 02/25,
and skip them in rest of the patches.

/Jarkko

