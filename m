Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C057D74D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiGUXQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiGUXQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:16:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707A8E4FD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658445383; x=1689981383;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yXmjzY48y3LBBb1ENVUd9rxbwFFLDcvQu+zW/2hNpCA=;
  b=i0UkaAAiXXDVYtSGqwYy4FHs43R1u2X4BuDXBR9yh/NlyYLFfur1PEgS
   oLZn8OSWTmBWtQXoYAaexQxIbhWwy68sg1CnsBmyucTqgREagwNENJbhR
   exEEmVPqOxY6/j6e7LKyaJnWs3Jxq/izF4jmODDphgzurzDFERWTtC0MM
   jyX41vFLX6iVqgCJkHGekv3A7eyQc1qh8scd/cxnYTx6oEeK/tKAbvc1j
   uBr3LK1pRExSz7I3AjpadJw2fGIkL0Jo+uaUTXE8WqULZIDxCT6PjabxZ
   byZYku0KCttBfZEwhoR/Ylf+T8XVqEjHMTXfUDIVKVCH7Ta7lXNxgp41u
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348892648"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="348892648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:16:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548966548"
Received: from refarabe-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.165.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:16:19 -0700
Message-ID: <84d736f4d9321bc1245e30b43c6c2bc18965f718.camel@intel.com>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jul 2022 11:16:17 +1200
In-Reply-To: <71f3326d-319b-c78a-345b-499001e766ff@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
         <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
         <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
         <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
         <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
         <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
         <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
         <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
         <20220721184221.GA3288872@ls.amr.corp.intel.com>
         <1fdecc17-8f4f-fceb-8da0-4a21ca0d58be@intel.com>
         <d0a3d1cc-dfea-0731-c801-97c8eb2cd535@linux.intel.com>
         <71f3326d-319b-c78a-345b-499001e766ff@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-21 at 12:23 -0700, Dave Hansen wrote:
> On 7/21/22 11:57, Sathyanarayanan Kuppuswamy wrote:
> > > How does the VMM know how much to read/write?  I have a theory: the s=
pec
> > > says that R12 is:
> > >=20
> > > 	"Shared 4KB GPA as input =E2=80=93 the memory contains a
> > > 	TDREPORT_STRUCT."
> > >=20
> > > That's *A* 4KB GPA.  The maximum is one 4KB page.  That's the only th=
ing
> > > that makes sense because there's no length in the ABI anywhere.
> > >=20
> > > What am I missing?
> > I think you are looking into the old spec. Please check the version
> > "FEBRUARY 2022"
> >=20
> > Following are the ABI details:
> >=20
> > R11 - TDG.VP.VMCALL< GetQuote > sub-function per Table 2-3
> > R12 - Shared GPA as input =E2=80=93 the memory contains a TDREPORT_STRU=
CT. The
> >        same buffer is used as output =E2=80=93 the memory contains a TD=
 Quote.
> > R13 -  Size of shared GPA. The size must be 4KB-aligned.
>=20
> Yeah, silly me.  I assumed the ABI was stable and wouldn't be, you know,
> adding and removing parameters.
>=20
> I still don't know how this all works.  You just said:
>=20
> > Current ABI allows attestation service and agent to decide the quote si=
ze. So
> > we can't make assumptions on what that size will be.
>=20
> But, the guest *HAS* to make assumptions, right?  It's allocating the
> buffer and handing a pointer and size over to the host.  It's also guest
> *userspace*.  In fact, this implementation *ABSOLUTELY* makes
> assumptions about the buffer size.
>=20
> If host userspace some day decides it needs 5MB of space, then all the
> guests will just stop working.  This implementation is limited by the
> max page allocator size.
>=20
> This all just seems to work by chance.

The Intel's Quote format is pretty much defined in some spec.  I don't know
whether the spec is public or not, though.  But Quote by definition has Int=
el's
certificates embedded so the size is indeed variable -- even though in real=
ity
it can be treated as fixed as Intel's certificates don't change often.

Intel's QGS (Quote Generation Service) once had an API to query Quote size =
but
it  got removed somehow, and instead, Intel used hard-coded (8K or 16K I fo=
rgot)
buffer, which is big enough for now.

Also, theoretically, 3rd party can add more staff (i.e. their certificates)=
 when
they deploy their own attestation services, so the Quote can even be 3rd pa=
rty
dependent.

So in short, yes, we Quote size is variable and it is determined by userspa=
ce.=20
But in reality, 16K is big enough for foreseeable future.

When using the vsock, userspace just uses standard socket API to read data =
from
QGS.  It has all the flexibility, for instance, it can read the header firs=
t
(which is couple of bytes and fixed size) and decode the exact Quote size. =
 Then
it can allocate a large enough buffer and read once for all.  How vsock in
kernel uses whatever shared buffer size is implemented by vsock and transpa=
rent
to the userspace.

But with GetQuote TDVMCALL we don't have the luxury.  Userspace needs to te=
ll a
big enough buffer to the kernel since the GetQuote must receive the entire =
Quote
at once.

That being said, ideally, what we need is a TDVMCALL based communication
channel, instead of bunches of TDVMCALLs with each being associated one spe=
cific
operation (i.e. GetQuote).  But obviously this isn't the direction we are
heading.


--=20
Thanks,
-Kai


