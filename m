Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228725874B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiHBAJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:09:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46332AE1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659398942; x=1690934942;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KS3slYws7+HYujsRo52LZ1HU4qpuaGOPegrhl+QWUOU=;
  b=Vng2TYaziUuVYQPg1bNgr/vJ2zMwtQR+PbfLg7z3aqiZrTGbPj0P4Dde
   4+Ps+1UdZ1ALBKd3fsnE+M+BSMyThwx3YluFgkYqOwqiLd+FNc0eiqsef
   EsJiZ6v/aZUhdwptZsKJS58hCamBqw4eKKqVl+puk68gcTKe0Nyl3tSSn
   Xrr1Unn98ANqSGAbeBSKktuMCJHi5za5/iOI2l12CTv5SYB0z0KoHowR+
   EJssOt+MJp9Fa82UxTdR2X8jtkp4Xhci4km+Sqh1wp7OdSt58t7QGJy2P
   G//Hs7YWEpQxKKdKjPgN/3xhOL+i2YbTjClAcPeTw9A+Y/GDmbkfPJ13K
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276187861"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="276187861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 17:09:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="630471703"
Received: from vgutierr-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.22.230])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 17:08:57 -0700
Message-ID: <34e60402a0e9223ce241d022dead94a5074f5436.camel@intel.com>
Subject: Re: [PATCH v9 2/6] selftests: tdx: Test GetReport TDX attestation
 feature
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
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Aug 2022 12:08:55 +1200
In-Reply-To: <2d5e6b7f-c499-aaa1-a308-cb17b5500c84@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220728034420.648314-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <03c6c9cecd281d64d0efd48cb40135092dc2d0df.camel@intel.com>
         <2d5e6b7f-c499-aaa1-a308-cb17b5500c84@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-01 at 10:49 -0700, Sathyanarayanan Kuppuswamy wrote:
> >=20
> > Btw, as it appears you only verified reportdata below, is it worth to h=
ave
> > all
> > those data structures (and they are used by hardware but not __packed)?=
=C2=A0
> > Perhaps
> > a macro to define REPORTDATA offset in TDREPORT is good enough?=C2=A0 O=
r maybe I
> > am
> > missing something.
>=20
> I have added these data structs to make it easier for readers to understa=
nd
> the contents of the TDREPORT. I thought a simple offset based check would=
 look
> like a magic number. If the maintainers are fine with offset based compar=
ison,
> I am ok with it.

They need to be __packed, at least.

--=20
Thanks,
-Kai


