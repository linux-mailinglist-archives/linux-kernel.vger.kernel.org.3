Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F0585827
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiG3DJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiG3DJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:09:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E74E50064;
        Fri, 29 Jul 2022 20:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659150558; x=1690686558;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k15e640Ac5kBV2qmOLkobhBC26rzlrHl47y6EDbeQTU=;
  b=bpg02TieQr4xZRmsKBtyUrZ+8Gc1UlnJf6rPTRY9z9Z+GIqrebaTDx6M
   zlwffe6ZIyKiGgMvKBvg9YXTqep9M1vlKXIy7K8Sp4VzOnOpZ+CNZL5SX
   ZpQXVM4Izsjp8kaw6TccwXeV9xSwZtnlHhC2f5DgrTIcE+6BZdtJWrBDf
   zXMbLFdSFvhs//rUI6vLe8TrLb4E9HHB6jPVfemsWypryRu8O7wzFGj4G
   s08NaherMZWBbctLLRsPCuVGJwsxvVV9cDyK/3Nuc4fMu+JWhAinzV0DD
   ePqaG02+ov9N5eu+aMc/SYfV5gEJBPiSE1JchvEkS/PCN7dwLt9AFDv6D
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288898755"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="288898755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:09:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="928953118"
Received: from abdulra4-mobl.gar.corp.intel.com ([10.214.159.26])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 20:09:15 -0700
Message-ID: <9c1937c1d7ab7687412c15c26532aea258aec078.camel@intel.com>
Subject: Re: [PATCH] thermal: intel: Add TCC cooling support for Alder
 Lake-N and Raptor Lake-P
From:   Zhang Rui <rui.zhang@intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 30 Jul 2022 11:09:59 +0800
In-Reply-To: <20220728175456.2796-1-sumeet.r.pawnikar@intel.com>
References: <20220728175456.2796-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-28 at 23:24 +0530, Sumeet Pawnikar wrote:
> Add Alder Lake-N and Raptor Lake-P to the list of processor models
> supported by the Intel TCC cooling driver.
>=20
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
> =C2=A0drivers/thermal/intel/intel_tcc_cooling.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
> b/drivers/thermal/intel/intel_tcc_cooling.c
> index a9596e7562ea..95adac427b6f 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -81,7 +81,9 @@ static const struct x86_cpu_id tcc_ids[]
> __initconst =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODE=
L(COMETLAKE, NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODE=
L(ALDERLAKE, NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODE=
L(ALDERLAKE_L, NULL),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODEL(ALD=
ERLAKE_N, NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODE=
L(RAPTORLAKE, NULL),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0X86_MATCH_INTEL_FAM6_MODEL(RAP=
TORLAKE_P, NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> =C2=A0};
> =C2=A0

