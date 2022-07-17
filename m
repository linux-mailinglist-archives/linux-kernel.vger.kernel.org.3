Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6B5774C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiGQGOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 02:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGQGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 02:14:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A95175BB;
        Sat, 16 Jul 2022 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658038489; x=1689574489;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=S1WgjQRPa4Uwj335+S4W8dF8LPgNSePYpZLtsiEAM9I=;
  b=nM8/Os6wETRcSTlnOzaZZ4Od7vhHu4wExXRf8URou+qfqYTHn5rLrz1k
   ErIhiTPJYq4ptqS8LRVYNo5Y7eJ5+OTsckSANqIsXdjYianwT2qVcmvp2
   y1dBpFZZ6ztf6opNaAEbd1fYiGaOOzCbL1w3DuBNOtvBHvPl79xiK+91Q
   F+4FlaCEAw/9TzEZQWrUieov/BjU4STra/37dVQs4PBrnisqzBpx/MS0s
   WYUpPFddxKnBHVuTWb4hB5J0NEn3FRsHn7lF7ri0Xn4c+zeJbpRZwoRWT
   XYTcwIDftQmInREjYmxORXVEXD7lOBDkwP9tukvZanrTrW77x557+Ai6I
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="372343457"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="372343457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 23:14:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="624329999"
Received: from agupta4-mobl3.gar.corp.intel.com ([10.215.155.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 23:14:46 -0700
Message-ID: <61311732eeea1f45e85537e911e4bb024c0a30b7.camel@intel.com>
Subject: Re: [PATCH] intel: thermal: PCH: Drop ACPI_FADT_LOW_POWER_S0 check
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Sun, 17 Jul 2022 14:14:42 +0800
In-Reply-To: <12013659.O9o76ZdvQC@kreacher>
References: <12013659.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 21:11 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> If ACPI_FADT_LOW_POWER_S0 is not set, this doesn't mean that low-
> power
> S0 idle is not usable.=C2=A0 It merely means that using S3 on the given
> system is more beneficial from the energy saving perspective than
> using
> low-power S0 idle, as long as S3 is supported.

Agreed.

>=20
> Suspend-to-idle is still a valid suspend mode if
> ACPI_FADT_LOW_POWER_S0
> is not set and the pm_suspend_via_firmware() check in
> pch_wpt_suspend()
> is sufficient to distinguish suspend-to-idle from S3, so drop the
> confusing ACPI_FADT_LOW_POWER_S0 check.

the cooling delay in the suspend callback is to make sure PCH
temperature won't block S0ix during s2idle. So if S0ix is not
supported, it is meaningless to invoke the cooling delay during s2idle.

so the problem is that we don't have an indicator for S0ix capability.
And this also applies to drivers/rtc/rtc-cmos.c, where we use ACPI SCI
for runtime RTC wakeup instead of HPET interrupt on "S0ix capable"
platforms because the HPET timer may block S0ix.

thanks,
rui

>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/thermal/intel/intel_pch_thermal.c |=C2=A0=C2=A0=C2=A0 8 ---=
-----
> =C2=A01 file changed, 8 deletions(-)
>=20
> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> @@ -207,14 +207,6 @@ static int pch_wpt_suspend(struct pch_th
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Do not check temperature if=
 it is not a S0ix capable
> platform */
> -#ifdef CONFIG_ACPI
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(acpi_gbl_FADT.flags & AC=
PI_FADT_LOW_POWER_S0))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return 0;
> -#else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> -#endif
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Do not check temperatu=
re if it is not s2idle */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pm_suspend_via_firmwa=
re())
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=20
>=20
>=20

