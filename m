Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29395480ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiFMHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiFMHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:54:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48029101DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655106852; x=1686642852;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=O8tMnzfOI/GijOMMiN7vNOf1uJlj0uc0jxlTVKkoOEo=;
  b=D7FAg/7NKDSK47ti6mNCrFavrQsgtikfvfUsBaxsra9yq38kaAG9ik3Q
   Aefzik07bnfu4dcyTyeTd+JKf/S8ggLEZTWDoPNOuTCERdwOSXRJum9R9
   SHXgYdepQo5k64CNmrFjbVLRBq4Vsq6FMLy3yjCEa33mqXYvbwjIoRMA5
   ZWPNfewPkb+av935HFoxCimXyjEdUWZiBQbjeeDplSEQpdQoYzDbqJiTe
   R1iUute7YZSKFqIbisLO+U1PBgo+WD00epqoTGJoRXPrfnCostLfAM8aQ
   X/sfN/0Hj4EkNQD/1Mfd44B+XHmemeXma3+7YwPa0i8YDv060a/V+VYTE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="278238328"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="278238328"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:54:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639594390"
Received: from njascanu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:54:01 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        javierm@redhat.com
Cc:     davidgow@google.com, airlied@linux.ie, dlatypov@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tzimmermann@suse.de,
        =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 1/3] drm/rect: Add DRM_RECT_INIT() macro
In-Reply-To: <20220612161248.271590-2-jose.exposito89@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220612161248.271590-1-jose.exposito89@gmail.com>
 <20220612161248.271590-2-jose.exposito89@gmail.com>
Date:   Mon, 13 Jun 2022 10:53:57 +0300
Message-ID: <87pmjdyp62.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022, Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com> wr=
ote:
> Add a helper macro to initialize a rectangle from x, y, width and
> height information.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---
>  include/drm/drm_rect.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> index 6f6e19bd4dac..945696323c69 100644
> --- a/include/drm/drm_rect.h
> +++ b/include/drm/drm_rect.h
> @@ -47,6 +47,18 @@ struct drm_rect {
>  	int x1, y1, x2, y2;
>  };
>=20=20
> +/**
> + * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
> + * @x: x coordinate
> + * @y: y coordinate
> + * @w: width
> + * @h: height
> + *
> + * RETURNS:
> + * A new rectangle of the specified size.
> + */
> +#define DRM_RECT_INIT(x, y, w, h) { (x), (y), (x) + (w), (y) + (h) }

Please use designated initializers.

It might help type safety if it also contained a (struct drm_rect) cast.

BR,
Jani.


> +
>  /**
>   * DRM_RECT_FMT - printf string for &struct drm_rect
>   */

--=20
Jani Nikula, Intel Open Source Graphics Center
