Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0044A88C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352314AbiBCQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:41:48 -0500
Received: from ptr.189.cn ([183.61.185.101]:11379 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352309AbiBCQlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:41:44 -0500
HMM_SOURCE_IP: 10.64.8.43:50542.1204295110
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id AF1C31001F1;
        Fri,  4 Feb 2022 00:41:38 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-vjdjk with ESMTP id d6e90b2fef1845d2b24da08f91bf1b66 for maxime@cerno.tech;
        Fri, 04 Feb 2022 00:41:39 CST
X-Transaction-ID: d6e90b2fef1845d2b24da08f91bf1b66
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <4dd6d32a-9818-1adf-cb3f-20c183ae2020@189.cn>
Date:   Fri, 4 Feb 2022 00:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20220203085851.yqstkfgt4dz7rcnw@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static int lsdc_primary_plane_atomic_check(struct drm_plane *plane,
>> +					   struct drm_atomic_state *state)
>> +{
>> +	struct drm_device *ddev = plane->dev;
>> +	struct lsdc_device *ldev = to_lsdc(ddev);
>> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>> +	struct drm_framebuffer *new_fb = new_plane_state->fb;
>> +	struct drm_framebuffer *old_fb = old_plane_state->fb;
>> +	struct drm_crtc *crtc = new_plane_state->crtc;
>> +	u32 new_format = new_fb->format->format;
>> +	struct drm_crtc_state *new_crtc_state;
>> +	struct lsdc_crtc_state *priv_crtc_state;
>> +	int ret;
>> +
>> +	if (!crtc)
>> +		return 0;
>> +
>> +	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>> +	if (WARN_ON(!new_crtc_state))
>> +		return -EINVAL;
>> +
>> +	priv_crtc_state = to_lsdc_crtc_state(new_crtc_state);
>> +
>> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
>> +						  new_crtc_state,
>> +						  DRM_PLANE_HELPER_NO_SCALING,
>> +						  DRM_PLANE_HELPER_NO_SCALING,
>> +						  false,
>> +						  true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Require full modeset if enabling or disabling a plane,
>> +	 * or changing its position, size, depth or format.
>> +	 */
>> +	if ((!new_fb || !old_fb ||
>> +	     old_plane_state->crtc_x != new_plane_state->crtc_x ||
>> +	     old_plane_state->crtc_y != new_plane_state->crtc_y ||
>> +	     old_plane_state->crtc_w != new_plane_state->crtc_w ||
>> +	     old_plane_state->crtc_h != new_plane_state->crtc_h ||
>> +	     old_fb->format->format != new_format))
>> +		new_crtc_state->mode_changed = true;
>> +
>> +
>> +	priv_crtc_state->pix_fmt = lsdc_primary_get_default_format(crtc);
> Storing the pixel format in the CRTC state is weird? What would happen
> if you have a primary plane and a cursor in different formats?
>
> Also, reading the default format from a register doesn't look right.
> atomic_check can occur at any time, including before a previous commit,
> or while the hardware is disabled. You should rely on either a constant
> or the previous state here.
>
Currently, private CRTC state(priv_crtc_state) is not get used by the cursor's
atomic_check() and atomic_update(). I means this is only for the primary plane.
And both and the primary and the cursor using  XRGB8888 format, what I really
want here is let the atomic_update to update the framebuffer's format, because
the firmware (pmon) of some board set the framebuffer's format as RGB565.
If the hardware's format is same with the plane state, then there is no need to
update the FB's format register, save a function call, right?

When the plane is disabled the drm core will call the atomic_disable() function, right?

I will reconsider this, thank for your advice and i will correct other problems
at the next version. Thanks for you take time review my patch again.

