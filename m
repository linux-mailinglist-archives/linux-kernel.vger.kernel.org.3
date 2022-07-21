Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5957D75D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiGUXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGUXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:32:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8091CF3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658446378; x=1689982378;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jFLApGONoZZ50fPd4Iw+O+fAdEQs5vZjKGhHDpnjMmc=;
  b=ZEfFIuGMsb68Tr4geV9EIGeczJuDk/PnoQRxNRCjatOnwsE5eC0QA+Ss
   kbc/u7U+3g5O+WmCwz9sfg25F8+832BZFKUY0ixq2bHRCIH+ik6zL9w/G
   hcydkhTHyFs6iNo3pRFWNT2sdHY7lfZyJXDLeCAncj0hSCSb3dxdSFXa+
   5mzYVidJBC8EGPqzx2qFPfQibqrdnM0iZa5LWyd2/JHChZRJpIl05L92K
   tSm4UPKHNg+VMyedDzFbwWXSboRBZavnBIvvLqe5i7gW19VK5otn14Ex8
   +wUVGB0m4GwAZFma9SBqx4e4ALMj2vDuq2JbEisPmDBFtUOfzjVTiG82j
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267591002"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267591002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:32:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631365776"
Received: from refarabe-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.165.223])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:32:51 -0700
Message-ID: <23e5ea743cba1359ebf8932600266ff6a650a150.camel@intel.com>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Jul 2022 11:32:48 +1200
In-Reply-To: <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
         <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
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

On Thu, 2022-07-21 at 09:08 -0700, Dave Hansen wrote:
> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> > For shared buffer allocation, alternatives like using the DMA API is
> > also considered. Although it simpler to use, it is not preferred becaus=
e
> > dma_alloc_*() APIs require a valid bus device as argument, which would
> > need converting the attestation driver into a platform device driver.
> > This is unnecessary, and since the attestation driver does not do real
> > DMA, there is no need to use real DMA APIs.
>=20
> Let's actually try to walk through the requirements for the memory
> allocation here.
>=20
>  1. The guest kernel needs to allocate some guest physical memory
>     for the attestation data buffer
>  2. The guest physical memory must be mapped by the guest so that
>     it can be read/written.
>  3. The guest mapping must be a "TDX Shared" mapping.  Since all
>     guest physical memory is "TDX Private" by default, something
>     must convert the memory from Private->Shared.
>  4. If there are alias mappings with "TDX Private" page table
>     permissions, those mappings must never be used while the page is
>     in its shared state.
>     4a. load_unaligned_zeropad() must be prevented from being used
> 	on the page immediately preceding a Private alias to a Shared
>  	page.
>  5. Actions that increasingly fracture the direct map must be avoided.
>     Attestation may happen many times and repeated allocations that
>     fracture the direct map have performance consequences.
>  6. A softer requirement: presuming that bounce buffers won't be used
>     for TDX devices *forever*, it would be nice to use a mechanism that
>     will continue to work on systems that don't have swiotlb on.
>=20
> I think we've talked about three different solutions:
>=20
> =3D=3D vmalloc() =3D=3D
>=20
> So, let's say we used a relatively plain vmalloc().  That's great for
> #1->#3 as long as the vmalloc() mapping gets the "TDX Shared" bit set
> properly on its PTEs.  But, it falls over for *either* #4 or #5.  If it
> leaves the direct map alone, it's exposed to load_unaligned_zeropad().
> If it unmaps the memory from the direct map, it runs afoul of #5.
>=20
> =3D=3D order-1 + vmap() =3D=3D
>=20
> Let's now consider a vmalloc() variant: allocate a bunch of order-1
> pages and vmap() page[1], leaving page[0] as a guard page against
> load_unaligned_zeropad() on the direct map.  That works, but it's an
> annoying amount of code.
>=20
> =3D=3D swiotlb pages =3D=3D
>=20
> Using the swiotlb bounce buffer pages is the other proposed option.
> They already have a working kernel mapping and have already been
> converted.  They are mitigated against load_unaligned_zeropad().  They
> do cause direct map fracturing, but only once since they're allocated
> statically.  They don't increasingly degrade things.  It's a one-time
> cost.  Their interaction with #6 is not great.
>=20
> Did I miss anything?  Does that accurately capture where we are?

We can also reserve a dedicated CMA, but Kirill didn't like it.

--=20
Thanks,
-Kai


