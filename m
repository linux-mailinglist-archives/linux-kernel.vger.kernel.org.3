Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7091655770A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiFWJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiFWJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33C4993A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655977607; x=1687513607;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dkT6gRwvrLbjvDhUZyB0/o+VGt+V2nKpbiaPqxSVTpM=;
  b=NXu6XWbNlxuKF//udlsl4FQ3CsUtpKfg7uIGcVR+agdjAJe7BYTts14H
   OrJw1xGNNP94jS4iWmIIsHafBxuZCNlMbBz3woZpgSUfHxXZ0YCIJyUeJ
   jxdXtRTtJ0h7Uj3spt3tbzQ8fTdAc43l2mPZ7FwlxvafhZvqZbX/sisRS
   jVR/RdM9f3Ozpt+5JPFgD7lgRU+YBf+56NcSiBZv4C3kcwfNzwxxNiR7n
   DvhzwmNKw2Jk0cn8l0bosH5CTkTgwHuCMT+tk6rC8d1acwYh90ApOT3cM
   Ke3vdkoW7gaKg8akf+rx8glPUvVqgeRom5+a5djdLwfLM9+BsSzg68FFC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342358754"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="342358754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:46:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="915120162"
Received: from mjalmada-desk.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.144.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 02:46:43 -0700
Message-ID: <61af8186d3252440baf28706c46ef1a8edead3ba.camel@intel.com>
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
Date:   Thu, 23 Jun 2022 21:46:41 +1200
In-Reply-To: <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
         <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> >=20
> > That being said, if a TD has multiple devices, it cannot know whether t=
he VMM
> > will inject the removal event via the vector set by SetupEventNotifyInt=
errupt.=20
> > And for the same device in the same TD, different VMMs may use differen=
t way to
> > notify its removal.
>=20
> As per current design, If it is used for device removal, I think all regi=
stered
> device drivers will get the notification and the individual device driver=
 has
> to check whether it is applicable for them.

The problem is there's no _specification_ around this.  As I said above, I =
don't
see why TDX architecture cannot support Qemu enumerated ACPI-based hotplug,
which uses SCI.  Maybe I am missing something here, but IMHO we should have=
 some
_specification_ around SetupEventNotifyInterrupt in GHCI.

>=20
> If the SetupEventNotifyInterrupt TDVMCALL specification is extended to sp=
ecify
> the exact device or use case detail, then it can optimize the implementat=
ion.
>=20
> >=20
> > It seems GetQuote is the only user of SetupEventNotifyInterrupt.  Maybe=
 we
> > should just declare it is for GetQuote.
>=20
> Ok.

If you believe this is reasonable, perhaps you can drive the spec change.

>=20
> >=20
> > Isaku, what do you think?  Does this make sense?
> >=20
> > >=20
> > > In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
> > > guest to specify which interrupt vector to use as an event-notify
> > > vector to the VMM. Details about the SetupEventNotifyInterrupt
> > > hypercall can be found in TDX Guest-Host Communication Interface
> > > (GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
> > > Add a tdx_hcall_set_notify_intr() helper function to implement the
> > > SetupEventNotifyInterrupt hypercall.
> >=20
> > As you also used "can" above, the GHCI only says the VMM _CAN_ inject t=
he vector
> > set by SetupEventNotifyInterrupt, but not must (3.3 TDG.VP.VMCALL<GetQu=
ote>).=20
> > This means theoretically TD should implement pooling mode in case VMM d=
oesn't
> > support injecting event via vector done by SetupEventNotifyInterrupt?
>=20
> Yes. But GetQuote specification does not talk about the pooling mode
> use case as well. So I think it is just a wording confusion.

It doesn't need to mention I think.  "can" means VMM can choose to inject o=
r
not, but not must, which basically implies GetQuote should support pooling.

>=20
> >=20
> > Perhaps we should update the GHCI spec to use must..
>=20
> Ok.

If you don't want to support pooling, I guess you'd better to improve the G=
HCI.

[...]

>=20
>=20
> > resource especially on server systems with a lot of CPUs.
>=20
> FWIW, this reservation is protected with CONFIG_INTEL_TDX_GUEST. So it wi=
ll be
> reserved only for TDX use case.

This reason doesn't stand.  I think distributions basically tends to enable=
 all
Kconfig options so one binary works on all machines, so it can be (maybe li=
kely)
turned on even on bare-metal machines.

--=20
Thanks,
-Kai


