Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155C4F66BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiDFRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiDFRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:10:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6B17E37A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649255560; x=1680791560;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=D2k6neIoq0HuAMjXdsRZhn8IXAOS7zwhgg73BXGOJrA=;
  b=T2kyJ+lcCfFwJRcwFB3pwl//gpVY7V9ZO4Y9bkJrRSXsLHq4t8SwycJm
   Mlt4CM3zHUCJ19obuRtAU7PyJxjD25NpvQZQUqEEaHnNemAj2TQheJPj3
   Vwlvdg2RjmlbPaneaPvq9CFD6PE6knP/7wrIjwJR87F9F+LEKkyv67ks2
   Xt/gyb15sJ+5poi7MkiAY52C5lWwP+QsgWCkOyxq49SWQx5xiHgAw09mO
   siTb1WNReBJpOzLw+7bk5h7ecqHD2+JvMig+/RGVjoNbCwoAMWNAYSFcB
   M4/5ssvlfvmk5rAMxDlYFp1lz16lSPz1XrAL9jzd7i4rxYSYvcpRdlza6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261058191"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="261058191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:26:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="722540100"
Received: from mgrabins-mobl.ger.corp.intel.com (HELO localhost) ([10.249.141.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:26:47 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jiawei Gu <Jiawei.Gu@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Senseless code and unnecessary memset
In-Reply-To: <614a4844-fa5d-8b8e-0628-894394f31608@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220405173632.2663-1-h0tc0d3@gmail.com>
 <614a4844-fa5d-8b8e-0628-894394f31608@amd.com>
Date:   Wed, 06 Apr 2022 17:26:44 +0300
Message-ID: <874k3670ez.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Apr 2022, Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Am 05.04.22 um 19:36 schrieb Grigory Vasilyev:
>> Using memset on local arrays before exiting the function is pointless.
>> Compilator will remove this code. Also for local arrays is preferable to
>> use {0} instead of memset. Mistakes are often made when working with
>> memset.
>
> Well actually memset is preferred when working with structures which are=
=20
> given to the hardware parser because {0} won't initialize paddings.

Not that I'd know anything that's going on here... but it sure seems
strange to me to be passing unpacked structures where the padding might
matter to a "hardware parser".

*shrug*


BR,
Jani.


>
> So please don't use {0} in any of the atom bios code.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/atom.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amd=
gpu/atom.c
>> index be9d61bcb8ae..537e48fbbe6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -1538,11 +1538,9 @@ struct atom_context *amdgpu_atom_parse(struct car=
d_info *card, void *bios)
>>   int amdgpu_atom_asic_init(struct atom_context *ctx)
>>   {
>>   	int hwi =3D CU16(ctx->data_table + ATOM_DATA_FWI_PTR);
>> -	uint32_t ps[16];
>> +	uint32_t ps[16] =3D {0};
>>   	int ret;
>>=20=20=20
>> -	memset(ps, 0, 64);
>> -
>>   	ps[0] =3D cpu_to_le32(CU32(hwi + ATOM_FWI_DEFSCLK_PTR));
>>   	ps[1] =3D cpu_to_le32(CU32(hwi + ATOM_FWI_DEFMCLK_PTR));
>>   	if (!ps[0] || !ps[1])
>> @@ -1551,10 +1549,6 @@ int amdgpu_atom_asic_init(struct atom_context *ct=
x)
>>   	if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
>>   		return 1;
>>   	ret =3D amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps);
>> -	if (ret)
>> -		return ret;
>> -
>> -	memset(ps, 0, 64);
>>=20=20=20
>>   	return ret;
>>   }
>

--=20
Jani Nikula, Intel Open Source Graphics Center
