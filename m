Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC39D575834
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiGNX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:59:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73F23BCB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843179; x=1689379179;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xUBgmjQGNjbBk0d4a8kCNh07KWPIDLV0t+hpereXsc8=;
  b=b6Akp+AUlbxWJTctPvIEt35aEDePlOre0CWvFzZXuRklIiHdadEr/OOP
   gsEVOCZYoi0NWdz6hTAIOKYfr366gsRj8xDrmnyIkazJ0uufHh7tzJqh0
   h90oqa5VujeE36BT1EMRpbPiHcRWOlxJBVprZd2qqldbKa219/ubrnthL
   86Yza+PNOzEiOJy+7lDk2f/oUNBZbLnx4k0WDJOntgPddk96WKPIjMsJR
   D57cC0N8CfV0ol0ugf4H7ksIaKQVyXFHcj9ToM598+DTTU7nX8KgfnLgy
   vp6y5b8k3faVplZJCUTOqELIOgEv5gSN4X/pza4A5IRjEo4LvsspphSqi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286798861"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286798861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 16:58:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="654090407"
Received: from abiswal-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.1.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 16:58:08 -0700
Message-ID: <5773db7f639871e840247579fc9a7835277ede74.camel@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
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
Date:   Fri, 15 Jul 2022 11:58:06 +1200
In-Reply-To: <4421372e-14b5-1c6d-e4bf-5a88a2c88ab8@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
         <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
         <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
         <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
         <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
         <503e7135-782c-b72b-6f55-3c4acf55921b@linux.intel.com>
         <434ff0edcd5a0f1eb671bb2850ef5444ac1359a3.camel@intel.com>
         <4421372e-14b5-1c6d-e4bf-5a88a2c88ab8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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


> > > +/*
> > > + * Handler used to report notifications about
> > > + * TDX_GUEST_EVENT_NOTIFY_VECTOR IRQ. Currently it will be
> > > + * used only by the attestation driver. So, race condition
> > > + * with read/write operation is not considered.
> > > + */
> > > +static void (*tdx_event_notify_handler)(void);
> > > +
> > > +/* Helper function to register tdx_event_notify_handler */
> > > +void tdx_setup_ev_notify_handler(void (*handler)(void))
> > > +{
> > > +       tdx_event_notify_handler =3D handler;
> > > +}
> > > +
> > > +/* Helper function to unregister tdx_event_notify_handler */
> > > +void tdx_remove_ev_notify_handler(void)
> > > +{
> > > +       tdx_event_notify_handler =3D NULL;
> > > +}
> > > +
> >=20
> > Looks it's weird that you still need it.  Couldn't we pass the function=
 to
> > handle GetQuote directly to request_irq()?
>=20
>=20
> Since event notification is not only specific to attestation, I did not w=
ant to
> directly tie it to GetQuote handler.
>=20
> Alternative approach is, to make this IRQ vector shared and let its users=
 do
> request_irq() and free_irq() directly.

I think IRQF_SHARED is the logic.  We don't need it now as for now we have =
only
one user, though.

The "multiple users" case may never happen, so doesn't justify the addition=
al
'tdx_event_notify_handler' code at this moment.

>=20
> Something like below?
>=20
> --- a/arch/x86/coco/tdx/attest.c
> +++ b/arch/x86/coco/tdx/attest.c
> @@ -399,7 +399,7 @@ static const struct file_operations tdx_attest_fops =
=3D {
> =20
>  static int __init tdx_attestation_init(void)
>  {
> -       int ret;
> +       int ret, irq;
> =20
>         /* Make sure we are in a valid TDX platform */
>         if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> @@ -422,6 +422,14 @@ static int __init tdx_attestation_init(void)
>                 return ret;
>         }
> =20
> +       irq =3D tdx_get_evirq();

The function seems unnecessary.  You can put 'extern int tdx_evtirq;' to
asm/tdx.h if needed and use it directly.

