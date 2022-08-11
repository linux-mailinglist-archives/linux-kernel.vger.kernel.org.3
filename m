Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBEF58F604
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiHKCy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHKCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:54:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAB883D9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186461; x=1691722461;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ZsDMA5q5pAMYRTD9hhg3Cm+LjvS+zik+GXMkY3O0QLo=;
  b=YLXkraHU8nf3CPv6n9WdvEaPJCYFlzLUkNSaWJYF1mv5bxfloerpGCKL
   t6fyHlie9pVNOQ7Bm/f5eM3Hk+rMNnXMroO/iFJwJqMN4Ea5OdaofL3Rj
   iGKkYYyAyF9hhLwrZsWZya8hModvoxVvXC9AC9OftixkYQd8wUBRa500G
   sJIi/yP6kJe71H8XtdbEghKx2xAwKNuXSn6lT1Vzmorin2HArGgG4bE8P
   bMavUZD1CvstYdcQgXfngBA2JMG77LLK75lOp7iCBMAIAsgZdejq5O7eX
   1kaB9OdOy7o8ohFDfiL0pcT+ZZDL3wdpkcfiL8BpQS/UMQVmIf7S5Hrre
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271629013"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="asc'?scan'208";a="271629013"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="asc'?scan'208";a="673523936"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2022 19:54:19 -0700
Date:   Thu, 11 Aug 2022 10:29:44 +0800
From:   Zhenyu Wang <zhenyu.z.wang@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     zhi.a.wang@intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i915/gvt: Fix Comet Lake
Message-ID: <20220811022944.GB1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyu.z.wang@intel.com>
References: <166016852965.780835.10366587502693016900.stgit@omen>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VYvi4N5CyHZx5xNE"
Content-Disposition: inline
In-Reply-To: <166016852965.780835.10366587502693016900.stgit@omen>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VYvi4N5CyHZx5xNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.08.10 15:55:48 -0600, Alex Williamson wrote:
> Prior to the commit below the GAMT_CHKN_BIT_REG address was setup for
> devices matching (D_KBL | D_CFL), where intel_gvt_get_device_type()
> returns D_CFL for either Coffee Lake or Comet Lake.  Include the missed
> platform.`
>=20
> Link: https://lore.kernel.org/all/20220808142711.02d16782.alex.williamson=
@redhat.com
> Fixes: e0f74ed4634d ("i915/gvt: Separate the MMIO tracking table from GVT=
-g")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_gvt_mmio_table.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c b/drivers/gpu/dr=
m/i915/intel_gvt_mmio_table.c
> index 157e166672d7..5595639d0033 100644
> --- a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
> +++ b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
> @@ -1076,7 +1076,8 @@ static int iterate_skl_plus_mmio(struct intel_gvt_m=
mio_table_iter *iter)
>  	MMIO_D(GEN8_HDC_CHICKEN1);
>  	MMIO_D(GEN9_WM_CHICKEN3);
> =20
> -	if (IS_KABYLAKE(dev_priv) || IS_COFFEELAKE(dev_priv))
> +	if (IS_KABYLAKE(dev_priv) ||
> +	    IS_COFFEELAKE(dev_priv) || IS_COMETLAKE(dev_priv))
>  		MMIO_D(GAMT_CHKN_BIT_REG);
>  	if (!IS_BROXTON(dev_priv))
>  		MMIO_D(GEN9_CTX_PREEMPT_REG);
>=20

Thanks for catching this!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>


--VYvi4N5CyHZx5xNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYvRpkwAKCRCxBBozTXgY
J2gcAJ9dPJreOMASPcIJVCkUov/utI/JmQCcCEF2AsdY8g2aRrUk9EbIcdAnagk=
=DhCn
-----END PGP SIGNATURE-----

--VYvi4N5CyHZx5xNE--
