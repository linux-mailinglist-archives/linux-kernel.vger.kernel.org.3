Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAD5A11A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiHYNOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbiHYNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:14:09 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE5D52081
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HE8hTk+H5l+7TVDNJJZsO8rmjAkuVyVw8iY3tny3vDM=; b=fGwxP9A2syGp/ejDXu2bKS2mFC
        CW0jtYFVyzVsNSvpKIvYVXukB5W1rP7NYwwkrWkkTPBUwg0GaeeTQQo02hU+/T08VxcDor1vicyfe
        CKFE2p6xI64sUWgC2FcN8SSGKMFJ+F0Bryif7wVyR4J/6m4tJcFwkaSNu79RWTzs9y3J7gvSgjNkH
        2/9duRDkWKmwqJtKcx6ugWMtFp+pKF4uPqABJZJYCsbGAicistOldWIRhovFatcsSiWtITzDcY/Lg
        aF7yAEP6nUKDjOKyV8flHCPd0SSbzCKO9ld5ZY1JNrndfD1AsMC7CcJmOvp5oeh0i3KeoRkPvGBZF
        tjrKBgqw==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=63408)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oRCgQ-0001R9-1W; Thu, 25 Aug 2022 15:14:06 +0200
Message-ID: <7bdcc3c4-e04c-c2f3-5691-bcbdb158276f@tronnes.org>
Date:   Thu, 25 Aug 2022 15:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 23/35] drm/vc4: vec: Convert to the new TV mode
 property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-23-3d53ae722097@cerno.tech>
 <0255f7c6-0484-6456-350d-cf24f3fee5d6@tronnes.org>
 <20220824152619.5def5b2puj5b2a3o@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220824152619.5def5b2puj5b2a3o@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 24.08.2022 17.26, skrev Maxime Ripard:
> Hi,
> 
> On Sat, Aug 20, 2022 at 07:22:48PM +0200, Noralf Trønnes wrote:
>> Den 29.07.2022 18.35, skrev Maxime Ripard:
>>> Now that the core can deal fine with analog TV modes, let's convert the vc4
>>> VEC driver to leverage those new features.
>>>
>>> We've added some backward compatibility to support the old TV mode property
>>> and translate it into the new TV norm property.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>
>>> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
>>
>>>  static int vc4_vec_connector_get_modes(struct drm_connector *connector)
>>>  {
>>> -	struct drm_connector_state *state = connector->state;
>>>  	struct drm_display_mode *mode;
>>>  
>>> -	mode = drm_mode_duplicate(connector->dev,
>>> -				  vc4_vec_tv_modes[state->tv.mode].mode);
>>> +	mode = drm_mode_duplicate(connector->dev, &drm_mode_480i);
>>> +	if (!mode) {
>>> +		DRM_ERROR("Failed to create a new display mode\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	drm_mode_probed_add(connector, mode);
>>> +
>>> +	mode = drm_mode_duplicate(connector->dev, &drm_mode_576i);
>>
>> Maybe the mode that matches tv.norm should be marked as preferred so
>> userspace knows which one to pick?
> 
> I'm not sure how realistic that would be. Doing this based on the driver
> / cmdline preference is going to be fairly easy, but then it's a
> property, it's going to be updated, and we probably don't want to mess
> around the mode flags based on new property values?
> 

Strictly speaking we need to fire an event to userspace if the mode
changes, and this is probably not straightforward to do underneath
modeset locks, would probably need a worker.

Clever userspace like GNOME will try to use the active mode, so it will
handle this that way. If someone has set up the pipeline first that is.
drm_client/fbdev and plymouth can do that because they honour userdef modes.

Other userspace that don't know the userdef flag will fallback to the
first mode which is NTSC which is also the default tvmode, so maybe this
is good enough. PAL users will have to specify the mode, or teach their
program about the userdef flag.

But ofc relying on the userdef flag depends on the fact that there's a
mode on the kernel command line, but maybe there's no way to avoid that
since much/most? userspace treat "unknown" connector status as
disconnected so many will have to force the connector to "connected"
anyway. At least I don't know any way to permanetly force the connector
status other than using video=.

Noralf.
