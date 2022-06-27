Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE655D522
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiF0LVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiF0LVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:21:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8B6566
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656328866; x=1687864866;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eDPD5a5Tj8Fg/jh61oE/jKEduG2p47Yi5l4SsATd2jY=;
  b=f3l+xbe/7ASGNGifrCODb3rmG2azGSZC9UFUhKXvwzwv+emCC5mvQIc6
   gDxbMQY+99eJ/mMe5vTmx1tXffD0DJous+kjJi/MlNXTqkQL7oHGxe3ju
   E2z7RFiN7/G8kwR9IVs6o/yMEwCVkwNn13epfpzUtAy0AOt2bgS1W2gNv
   Qq15Zidw45B43buZJTdI25VWXiq8gPnZ1Z4H0B7Vz/pa+Eb+Ex+SM2kZC
   ieCQDKd0UYOth6hYgcq+Pc9R5jG99IHwqnYs+wxoet24wGTMYedGgpAAL
   DCv7WXRh1tLY50S4zpHlzuFAlabUhgtc1ytV+mxJsvDeZ26jeFVQOAVGe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261840757"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="261840757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:21:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="540075677"
Received: from fzaeni-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.88.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 04:21:02 -0700
Message-ID: <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     "Yao, Jiewen" <jiewen.yao@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jun 2022 23:21:00 +1200
In-Reply-To: <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
         <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
         <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
         <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-25 at 15:35 +1200, Yao, Jiewen wrote:
> Thank you, Jun.
>=20
> Yes. I confirmed that we will include below change to GHCI.next spec.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
>=20
> From: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an inter=
rupt at the requested-interrupt vector into the TD via the posted-interrupt=
 descriptor. "
>=20
> To: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interru=
pt at the requested-interrupt vector into the TD VCPU that executed TDG.VP.=
VMCALL <SetupEventNotifyInterrupt> via the posted-interrupt descriptor. "
>=20

Hi Sathy,

With this change, I don't think we should use system vector anymore.  Inste=
ad,
we just need one non-migratable IRQ which has a fixed vector on a fixed cpu=
.

--=20
Thanks,
-Kai


