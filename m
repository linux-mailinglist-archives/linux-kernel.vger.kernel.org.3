Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3A52B8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiERLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiERLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:40:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F375D6321
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652874041; x=1684410041;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=cIB6VdWDGBUIC0EFE1d8r+JulD29DL8ul3+vEs+Rqhs=;
  b=YhcD1SRB4V154SqGXX+McoHD4vui5W1z1mWi19lTf1cqAogvp0ZY6Pat
   Wh4XhHtP/mtuHqb62ub6y+hRMsc8ZwKu17/NFru8pCg8hJXz4kmcq3qnW
   /BqihHMdnNGMJOnGsWzeTrHemC4gwoA+hA8Qy5ZzfxfiLKbC7Mq1aFJJS
   lNXimlfVv4ZLVs7LmhynoTmngihiWyfKtYOPRbz65ZwpMlclamaNq/bWW
   AfNlwHdJflOIDoYXfdd/ftG6DGglwJMcRpEK9IWtt2qu0EmhU0stReNhb
   NwNQz5+vket4mli7Rw7SFs/FDN2/4nti+PtfDus4tmvKS5TWDuD1mbvZU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="259198563"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="259198563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:40:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="597742518"
Received: from jwasiuki-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.133.47])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:40:37 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH -next] drm/i915: fix compilation errors caused by
 `-fsanitize=shift`
In-Reply-To: <20220517214733.139446-1-gongruiqi1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220517214733.139446-1-gongruiqi1@huawei.com>
Date:   Wed, 18 May 2022 14:40:34 +0300
Message-ID: <87h75ndq6l.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022, "GONG, Ruiqi" <gongruiqi1@huawei.com> wrote:
> Fix the compilation errors produced by building recent mainline on x86
> with allmodconfig:
>
> (1st type of errors)
>   drivers/gpu/drm/i915/display/intel_ddi.c:1916:2: error: case label does=
 not reduce to an integer constant
>   case PORT_CLK_SEL_WRPLL1:
>   ^~~~
>
> (2nd type of errors)
>   ././include/linux/compiler_types.h:352:38: error: call to =E2=80=98__co=
mpiletime_assert_1360=E2=80=99 declared with attribute error: FIELD_PREP: m=
ask is not constant
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
>                                         ^
>   ...
>   drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2316:3: note: in expa=
nsion of macro =E2=80=98FIELD_PREP=E2=80=99
>      FIELD_PREP(GUC_KLV_0_KEY, GUC_CONTEXT_POLICIES_KLV_ID_##id) | \
>      ^~~~~~~~~~
>   drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c:2323:1: note: in expa=
nsion of macro =E2=80=98MAKE_CONTEXT_POLICY_ADD=E2=80=99
>    MAKE_CONTEXT_POLICY_ADD(preemption_timeout, PREEMPTION_TIMEOUT)
>    ^~~~~~~~~~~~~~~~~~~~~~~
>
> which are all induced by `-fsanitize=3Dshift`.
>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Please see [1] and [2].

BR,
Jani.


[1] https://lore.kernel.org/r/20220405151517.29753-12-bp@alien8.de
[2] https://patchwork.freedesktop.org/series/104122/


> ---
>  drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h |  2 +-
>  .../i915/gt/uc/abi/guc_communication_ctb_abi.h   |  2 +-
>  drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h    |  4 ++--
>  .../gpu/drm/i915/gt/uc/abi/guc_messages_abi.h    |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h       |  2 +-
>  drivers/gpu/drm/i915/i915_reg.h                  | 16 ++++++++--------
>  6 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h b/drivers/g=
pu/drm/i915/gt/uc/abi/guc_actions_abi.h
> index be9ac47fa9d0..3ada7358a698 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_actions_abi.h
> @@ -50,7 +50,7 @@
>=20=20
>  #define HOST2GUC_SELF_CFG_REQUEST_MSG_LEN		(GUC_HXG_REQUEST_MSG_MIN_LEN =
+ 3u)
>  #define HOST2GUC_SELF_CFG_REQUEST_MSG_0_MBZ		GUC_HXG_REQUEST_MSG_0_DATA0
> -#define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_KEY		(0xffff << 16)
> +#define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_KEY		(0xffffu << 16)
>  #define HOST2GUC_SELF_CFG_REQUEST_MSG_1_KLV_LEN		(0xffff << 0)
>  #define HOST2GUC_SELF_CFG_REQUEST_MSG_2_VALUE32		GUC_HXG_REQUEST_MSG_n_D=
ATAn
>  #define HOST2GUC_SELF_CFG_REQUEST_MSG_3_VALUE64		GUC_HXG_REQUEST_MSG_n_D=
ATAn
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h b=
/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
> index c9086a600bce..c97ff7c38576 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
> @@ -82,7 +82,7 @@ static_assert(sizeof(struct guc_ct_buffer_desc) =3D=3D =
64);
>  #define GUC_CTB_HDR_LEN				1u
>  #define GUC_CTB_MSG_MIN_LEN			GUC_CTB_HDR_LEN
>  #define GUC_CTB_MSG_MAX_LEN			256u
> -#define GUC_CTB_MSG_0_FENCE			(0xffff << 16)
> +#define GUC_CTB_MSG_0_FENCE			(0xffffu << 16)
>  #define GUC_CTB_MSG_0_FORMAT			(0xf << 12)
>  #define   GUC_CTB_FORMAT_HXG			0u
>  #define GUC_CTB_MSG_0_RESERVED			(0xf << 8)
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/=
drm/i915/gt/uc/abi/guc_klvs_abi.h
> index 4a59478c3b5c..e811896a80a0 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
> @@ -29,8 +29,8 @@
>   */
>=20=20
>  #define GUC_KLV_LEN_MIN				1u
> -#define GUC_KLV_0_KEY				(0xffff << 16)
> -#define GUC_KLV_0_LEN				(0xffff << 0)
> +#define GUC_KLV_0_KEY				(0xffffu << 16)
> +#define GUC_KLV_0_LEN				(0xffffu << 0)
>  #define GUC_KLV_n_VALUE				(0xffffffff << 0)
>=20=20
>  /**
> diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h b/drivers/=
gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
> index 29ac823acd4c..901595300f82 100644
> --- a/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
> +++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_messages_abi.h
> @@ -40,7 +40,7 @@
>   */
>=20=20
>  #define GUC_HXG_MSG_MIN_LEN			1u
> -#define GUC_HXG_MSG_0_ORIGIN			(0x1 << 31)
> +#define GUC_HXG_MSG_0_ORIGIN			(0x1u << 31)
>  #define   GUC_HXG_ORIGIN_HOST			0u
>  #define   GUC_HXG_ORIGIN_GUC			1u
>  #define GUC_HXG_MSG_0_TYPE			(0x7 << 28)
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h b/drivers/gpu/drm=
/i915/gt/uc/intel_guc_reg.h
> index 66027a42cda9..22d2c1836f65 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h
> @@ -28,7 +28,7 @@
>  #define   GS_MIA_HALT_REQUESTED		  (0x02 << GS_MIA_SHIFT)
>  #define   GS_MIA_ISR_ENTRY		  (0x04 << GS_MIA_SHIFT)
>  #define   GS_AUTH_STATUS_SHIFT		30
> -#define   GS_AUTH_STATUS_MASK		  (0x03 << GS_AUTH_STATUS_SHIFT)
> +#define   GS_AUTH_STATUS_MASK		  (0x03u << GS_AUTH_STATUS_SHIFT)
>  #define   GS_AUTH_STATUS_BAD		  (0x01 << GS_AUTH_STATUS_SHIFT)
>  #define   GS_AUTH_STATUS_GOOD		  (0x02 << GS_AUTH_STATUS_SHIFT)
>=20=20
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_=
reg.h
> index 9ccb67eec1bd..8c10d66561b0 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -7566,19 +7566,19 @@ enum skl_power_gate {
>  #define  PORT_CLK_SEL_LCPLL_810		(2 << 29)
>  #define  PORT_CLK_SEL_SPLL		(3 << 29)
>  #define  PORT_CLK_SEL_WRPLL(pll)	(((pll) + 4) << 29)
> -#define  PORT_CLK_SEL_WRPLL1		(4 << 29)
> -#define  PORT_CLK_SEL_WRPLL2		(5 << 29)
> -#define  PORT_CLK_SEL_NONE		(7 << 29)
> +#define  PORT_CLK_SEL_WRPLL1		(4u << 29)
> +#define  PORT_CLK_SEL_WRPLL2		(5u << 29)
> +#define  PORT_CLK_SEL_NONE		(7u << 29)
>  #define  PORT_CLK_SEL_MASK		(7 << 29)
>=20=20
>  /* On ICL+ this is the same as PORT_CLK_SEL, but all bits change. */
>  #define DDI_CLK_SEL(port)		PORT_CLK_SEL(port)
>  #define  DDI_CLK_SEL_NONE		(0x0 << 28)
> -#define  DDI_CLK_SEL_MG			(0x8 << 28)
> -#define  DDI_CLK_SEL_TBT_162		(0xC << 28)
> -#define  DDI_CLK_SEL_TBT_270		(0xD << 28)
> -#define  DDI_CLK_SEL_TBT_540		(0xE << 28)
> -#define  DDI_CLK_SEL_TBT_810		(0xF << 28)
> +#define  DDI_CLK_SEL_MG			(0x8u << 28)
> +#define  DDI_CLK_SEL_TBT_162		(0xCu << 28)
> +#define  DDI_CLK_SEL_TBT_270		(0xDu << 28)
> +#define  DDI_CLK_SEL_TBT_540		(0xEu << 28)
> +#define  DDI_CLK_SEL_TBT_810		(0xFu << 28)
>  #define  DDI_CLK_SEL_MASK		(0xF << 28)
>=20=20
>  /* Transcoder clock selection */

--=20
Jani Nikula, Intel Open Source Graphics Center
