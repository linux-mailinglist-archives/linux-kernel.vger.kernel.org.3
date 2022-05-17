Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7690E529B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiEQHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiEQHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:51:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E22618382
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652773881; x=1684309881;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LWIEB4/lPMy65N4AJNM7XhWmKfMhu8OaBtUPWfYPFRM=;
  b=oBQvk/8x+ysG+UXf+EL7cwQUiVXMrkP+DXGzRx6WpNvsb63Irvb8PcE6
   zgpf0HFN3P2ppYmVflZAA+1eLxMFpdMSVVx3qP+tIQ7UMr5pejI1Xow4Q
   vy8HB0kuKzGRAuHMisl5PR5mtRCBjYxslIT6q9XYyoFN29tzM7m/jkfis
   TDWo1WuKmRKPEXt0PNtjlsu8M9n7TQvz+06ZcV4O+Qj/BpWrpdVjtxknL
   kucm0DWy4qQOiBXmDJAHf6htGFSX+UqycSPhOMjuifmib4Jpx58kxQDYO
   +eO6UWBns30tzhXrGYgNefDZ44bYunFkDqhYStHztIRylSayxJQmM6tSZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271045377"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271045377"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568758921"
Received: from psagan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.132.13])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:51:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, markyacoub@chromium.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>, markyacoub@google.com
Subject: Re: [PATCH] drm: Add a debug message when getting a prop is missing
In-Reply-To: <20220510182810.1223574-1-markyacoub@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220510182810.1223574-1-markyacoub@chromium.org>
Date:   Tue, 17 May 2022 10:51:14 +0300
Message-ID: <87bkvwfvgt.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022, Mark Yacoub <markyacoub@chromium.org> wrote:
> [Why]
> If a connector property is attached but
> drm_atomic_connector_get_property doesn't handle a case for it,
> modeteset will crash with a segfault without.
>
> [How]
> Add a debug message indicating that a connector property is not handled
> when user space is trying to read it.
>
> TEST=modetest
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index acb1ee93d206..36b0f664dd80 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -884,6 +884,12 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
>  	} else {
> +		// LOG that the kernel is missing handling this property as a case here.

The comment is unnecessary, and we also don't use // comments.

> +		drm_dbg_atomic(
> +			dev,
> +			"[CONNECTOR:%d:%s] Get Property [PROP:%d:%s] is not handled\n",
> +			connector->base.id, connector->name, property->base.id,
> +			property->name);

Why not use the same message as in drm_atomic_connector_set_property()?

Blank line here.

BR,
Jani.

>  		return -EINVAL;
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
