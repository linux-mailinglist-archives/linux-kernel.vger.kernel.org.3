Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018884C4FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiBYUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:37:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92D203BFE;
        Fri, 25 Feb 2022 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645821405; x=1677357405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Um3Ri3Z5tNczvjbg/Kqd4t82aFPTJQvoXqKHvporKMY=;
  b=STw3OsbvzxKtGZBf1w7CWCu1ztwIvRrQk9Qb9578FlyQzWF2Da1HA2Fl
   7/1ZRyfNlopZyUQ9AnGeZfuOCHR3Q6MxaSC4wUej2pcyRj/KHCr0rgVH2
   6APviUzWsRST/HGQYbR9qheijiInUq12aCm8kSyNL8IHHoaLxd7iJTZfd
   hH1NSnLma6+dkrG4VhIlrAHdoCtrdg5hvEbZWbqseABqxr+z7B0nLO3dt
   txmVPpWDBk0KZo99fXkCJZTZd3gngNEfMCDAaZ4nTpemJY9FzJAHipjfL
   kJA7qUEdak65tGykaeRt/SEWSvWy6DmRV5Tspr6XVWaNf0lLqnBJRW42Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252771373"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="252771373"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 12:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="638353417"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.151])
  by fmsmga002.fm.intel.com with SMTP; 25 Feb 2022 12:36:41 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 25 Feb 2022 22:36:41 +0200
Date:   Fri, 25 Feb 2022 22:36:41 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm: Extend DEFINE_DRM_GEM_FOPS() for optional fops
Message-ID: <Yhk92RwhBqAAHcuT@intel.com>
References: <20220225202614.225197-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225202614.225197-1-robdclark@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:26:12PM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Extend the helper macro so we don't have to throw it away if driver adds
> support for optional fops, like show_fdinfo().
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  include/drm/drm_gem.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 35e7f44c2a75..987e78b18244 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -327,7 +327,7 @@ struct drm_gem_object {
>   * non-static version of this you're probably doing it wrong and will break the
>   * THIS_MODULE reference by accident.
>   */
> -#define DEFINE_DRM_GEM_FOPS(name) \
> +#define DEFINE_DRM_GEM_FOPS(name, ...) \
>  	static const struct file_operations name = {\
>  		.owner		= THIS_MODULE,\
>  		.open		= drm_open,\
> @@ -338,6 +338,7 @@ struct drm_gem_object {
>  		.read		= drm_read,\
>  		.llseek		= noop_llseek,\
>  		.mmap		= drm_gem_mmap,\
> +		##__VA_ARGS__\
>  	}

Would it not be less convoluted to make the macro only provide
the initializers? So you'd get something like:

static const struct file_operations foo = {
	DRM_GEM_FOPS,
	.my_stuff = whatever,
};

>  
>  void drm_gem_object_release(struct drm_gem_object *obj);
> -- 
> 2.35.1

-- 
Ville Syrjälä
Intel
