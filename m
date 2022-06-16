Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4186954D80C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358210AbiFPCK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiFPCK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:10:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F672DA87
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655345457; x=1686881457;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5kuP+lU3ma8j/nmjodgOG4SJ+EuMc3E0u2cE5Q+2pDc=;
  b=JCdewuvuUbjZYduGkqyaim4bt3Ff7NmQtpEDGnkJPGeifo9WgRWPXXMA
   zHkR9/lGBvnSw/kyXn97IG494+Lbp68MPYNn3qWzLoD93KjCbQvl5wzhz
   G7Z1wMWQsuKngTzQ4/b++23DxPUv2bDQ7DpXA8e6UUWXZMAVxseoVBuqi
   S3STaAC0IooeiAk80Zs6U90tMHn5CKTwkARopxWDw+1NuaG1st+gG1VyB
   yo5lDGCOgeXg54VfPtCL0P+xTUECf/FREoeH8nYz5SSpoabmkQAQCMYC3
   ZGZxqs9Qwzs5WPgvR/o3k1uXFyxRwcNwWjKMReLd4X+wXrlMJby0leSft
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="277941352"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277941352"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 19:10:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="641312042"
Received: from nandamur-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.161.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 19:10:55 -0700
Message-ID: <3b274c9a58ddfba8bd37827519aec541d1838697.camel@intel.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
From:   Kai Huang <kai.huang@intel.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Date:   Thu, 16 Jun 2022 14:10:53 +1200
In-Reply-To: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 18:02 -0300, Martin Fernandez wrote:
> Right now the only way to check this is by greping the kernel logs,
> which is inconvinient. This is currently checked for fwupd for
> example.
>=20
> I understand that cpuinfo is supposed to report every feature in the
> cpu but since AMD is doing the same for sme/sev I think is good to
> have this for Intel too.
>=20
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index fd5dead8371c..7311172aceaf 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -570,6 +570,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>=20
>  	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_act=
ivate)) {
>  		pr_info_once("x86/tme: not enabled by BIOS\n");
> +		if (mktme_status =3D=3D MKTME_UNINITIALIZED)
> +			clear_cpu_cap(c, X86_FEATURE_TME);

The above code seems only clear TME on BSP, if I read correctly.  Why not
unconditionally clear this flag?  If TME is detected as not enabled by BIOS=
 on
*this* cpu, then the flag for *this* cpu should be cleared.

Also could you CC Kirill A. Shutemov <kirill.shutemov@linux.intel.com>, who=
 is
the original author of this code?


>  		mktme_status =3D MKTME_DISABLED;
>  		return;
>  	}
> --
> 2.30.2
>=20

--=20
Thanks,
-Kai


