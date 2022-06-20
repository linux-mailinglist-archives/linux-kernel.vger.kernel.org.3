Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1498551939
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbiFTMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiFTMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:46:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16A815829
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655729173; x=1687265173;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2+QvE3+wZSpZa2VGu7+V3PAJf9h7zO3xUJ+BH1YJ0zk=;
  b=mJ+IdrPPiV8Gz4xmldlg0goVc1clEQydjVTnxVBn9rjKRERdAz+zReMf
   8x/tai/Xg13bHx4WTyRsGNJPJejyk2X9s9xmQLilFXTXMIBngqXeOmh8k
   xGVIVEi880Yj40d83xGa4MSGU46Cmr5h3XR1VRodYXALbp1WdoYz6/50+
   M8Zl81YIeqqed+MdqqDSsfNV8qm4G1I3VWA1lcooFFV2OW3eKr0oVUHxW
   p4WyFBPRPjydalvqhu0fxMwn3efBdM95b+EPdIBxMTeONT0z9lOqlb0g+
   HjVkS4s1kgFt89m4Jgn2RaHepHEOzHOOIh65mrIiLMOzSxvxillfLAiIz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343877735"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343877735"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="537665504"
Received: from dkburrow-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.191.162])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:46:05 -0700
Message-ID: <d90a10964ecee3269a26a48155733e10848ae471.camel@intel.com>
Subject: Re: [PATCH v7 0/5] Add TDX Guest Attestation support
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
Date:   Tue, 21 Jun 2022 00:46:03 +1200
In-Reply-To: <d0931a48-ac87-c83e-1241-64819b87cf3c@linux.intel.com>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <d0931a48-ac87-c83e-1241-64819b87cf3c@linux.intel.com>
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

On Sun, 2022-06-19 at 17:36 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Dave/Boris/Thomas,
>=20
> On 5/23/22 9:05 PM, Kuppuswamy Sathyanarayanan wrote:
> > Hi All,
>=20
> Gentle ping!
>=20
> Can you please let me know your comments on this patch set? This series
> is so far reviewed by Kai, Wander, and Isaku. I have addressed all the
> comments raised by them. So to progress further, your comments would be
> appreciated.
>=20
>=20

To be precise I provided Acked-by to the first patch.  Sorry I was basicall=
y
sick leave in the past two weeks so didn't fully review the rest.

--=20
Thanks,
-Kai


