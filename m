Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAEB56958E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFW7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:59:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23E18E36
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657148374; x=1688684374;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bh75gl/ZpQtcHPqssKBS7MqGiz/R4n3x9LdQifuC0KQ=;
  b=bGor7x4V39/t1piJ1UdA7UGsvesmDPCYPBFzJQAFufxMdQ5DpIPmxc63
   XhU37abNXwhbhGFUzZKV+s0TYPv4D2E0Dde+iVxu3xYUY1p3ap9ZaVOFo
   FMyguvoM9fGOtNJ26GAoxG6Pa2d1Y5tgcmLwDLs72FtpCkx+5Z3wHGb0T
   lMy2mMK4AZ3IuZWfRZ8LN4jWbGHQTs97kQckpidkueM3WrbJ/j8/5EaBt
   5bUMnzJq2RRJgMxYubVUPy5G0qapChHV2g/GmKr/0aLZ0Yi0VvmzfYVSW
   fvQ0+BV+YqB+j422bg0gZMI2PrKM1HMWxkhoLFDvCg2IB3lgHwAa5hGoE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="345575238"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="345575238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:59:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="597829362"
Received: from ctrainor-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.178.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:59:30 -0700
Message-ID: <82d4c654ce78416ba3635bad15f8bb21c3a42a4f.camel@intel.com>
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Date:   Thu, 07 Jul 2022 10:59:28 +1200
In-Reply-To: <e92c570e-29c0-e6d1-88e8-cb6344c01859@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
         <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
         <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
         <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
         <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
         <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
         <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
         <74383158-460e-0cd1-94bc-faca5b8175ea@linux.intel.com>
         <932869b757b384426ada376cd9791697353c2247.camel@intel.com>
         <e92c570e-29c0-e6d1-88e8-cb6344c01859@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-06 at 15:27 -0700, Sathyanarayanan Kuppuswamy wrote:
>=20
> On 7/5/22 3:31 PM, Kai Huang wrote:
> > On Tue, 2022-07-05 at 14:21 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > SGX is a related feature. It also uses IOCTL approach for enclave pro=
visioning.
> > >=20
> > > arch/x86/kernel/cpu/sgx/ioctl.c
> >=20
> > SGX isn't a good example here.  The IOCTLs are used to create enclaves,=
 but not
> > for attestation.  SGX attestation relies on enclave itself to get/verif=
y the
> > report, etc, so has no interaction with the kernel.
>=20
> If you are looking for an attestation specific example, you can only chec=
k the AMD
> code.
>=20
> https://patchwork.kernel.org/project/linux-mm/patch/20220307213356.279720=
5-44-brijesh.singh@amd.com/
>=20
> Also, sev_get_attestation_report() in arch/x86/kvm/svm/sev.c also impleme=
nts attestation
> IOCTL specific to KVM.
>=20

I think we only need to look at how attestation is implemented in kernel fo=
r
other vendors, so yes it would be helpful to look at AMD's implementation. =
=20
I'll probably also look at it when I have some time.

--=20
Thanks,
-Kai


