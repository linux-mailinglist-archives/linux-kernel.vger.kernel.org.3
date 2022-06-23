Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB035577C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiFWKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiFWKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:24:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9BD3B578
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655979874; x=1687515874;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PXRJDRdRgy2fwuZsMUdDm1uxBBKgX7JBwjMasOxK/Hk=;
  b=A0HhYrZ/Vuj5CDM63FN9G8pj82KpkbxT9Df9h59T+8tnz7o0u8a4ExG6
   bvEf6kGenF6pmkvMScl0JqZi0IHTf1UUG3bBFS2cvDybUJpoh0l+P4s+5
   hZ95gKZ5DBhowZrW6iqd1UAZobn+deMTKbs9hBaktsz5zxBybCbQuYQ55
   M7COXwcXJHZpb3RqDJGSF1/GxGP3S+NOgnl+mLYKmRDmy+Po18r8N4Ahb
   JzEcgU4pL/rNMGeKPjmW6dOv/2FIxlLwoMdjldm8bHNLSPPJBVKtTTNhR
   0R7CtQT4RloxL9mmJbJXXT4d6hlV8mkX5NEZU3nijZCUFo7t/ewcahZPr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306141484"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="306141484"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:24:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="656111133"
Received: from mjalmada-desk.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.144.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:24:31 -0700
Message-ID: <97ace776b756312de05d3a9c8b1ca251e714db17.camel@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
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
        linux-kernel@vger.kernel.org,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Date:   Thu, 23 Jun 2022 22:24:29 +1200
In-Reply-To: <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
         <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-20 at 08:44 -0700, Sathyanarayanan Kuppuswamy wrote:
> I agree that event notification is currently only used for attestation. B=
ut I
> think in future there could be other use cases for it.=C2=A0
>=20

We have TDVMCALL<Service> in GHCI 1.5.  It allows specifying the vector.  I
don't know whether there's any future case that still needs
SetupEventNotifyInterrupt.

> If the intention is just
> to use it for attestation, then we can just modify the GetQuote TDVMCALL =
to pass
> the vector address, and there is no need for new TDVMCALL.=20

The TDVMCALL<Service> in GHCI 1.5 actually supports specifying the vector. =
 It
currently neither clearly says "the VMM should inject event to the vCPU on =
which
the TDVMCALL<Service> is called", nor it allows specifying which vCPU to in=
ject.
Assuming we can lobby (I am already lobbying, actually) to make either way,=
 in
fact I think it can be used as IRQ way (like I described in my first reply)=
.

I once lobbied to completely remove GetQuote (and SetupEventNotifyInterrupt=
)
from GHCI 1.0 and move TDVMCALL<Service> from GHCI 1.5 to 1.0, and define a=
 new
sub-service for attestation -- GetQuote will be one command then, and we ca=
n
define more attestation related commands (which is likely) when needed.  I
believe using TDVMCALL<Service> for GetQuote can actually allow kernel to u=
se
IRQ way, but doesn't need a system vector.  But this wasn't successful.


--=20
Thanks,
-Kai


