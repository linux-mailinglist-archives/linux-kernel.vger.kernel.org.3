Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA355AD111
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiIELBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiIELA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638113D50
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662375620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pfJJRiSb2ZSlfeZzAVjNGCSUsiw68cMF8aCQiIWPoI=;
        b=AjbyhOHejhICeubRAvszkHBfj2MDM0UOB4oljauwy30vSpb0VWp3UMHDLQ2Pz1Xs7GsE/u
        oRw5IgIoPfil//tZjwhXSaqOgPS2nf3UzXKR9gHlY72AgfkwGC2mhGKC9sG6j9ZK9qOgHr
        Js7w0ymZG80se+27jnDJWuXxX8U4oEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-eJZBsvS7Pvu59DZWghQk_Q-1; Mon, 05 Sep 2022 07:00:19 -0400
X-MC-Unique: eJZBsvS7Pvu59DZWghQk_Q-1
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adf8b4f000000b002285ec61b3aso681746wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2pfJJRiSb2ZSlfeZzAVjNGCSUsiw68cMF8aCQiIWPoI=;
        b=18eWm6jQu/o4JaXZG02pv89uNCjZkB4Qzj+3FjJfJXJpGO76ppMaEFDesqLtaQAp57
         0j39Jt4bb13v/UfOJHlxRsngmjINblGEIMVNELnHcfToEoSJbZgMndEbC5Zi6O7z6DCL
         zpnO1LImKC+hi7dtoTIjbU4hCxYiw+Gv53Hdi4q/J951WKvLhQc+etJvxN+Tg4/106Eq
         /vGAef1nXv35JF/o7FtR6vCaoLfp0RfeEYtnXKAsQStbesdQZqfr+rb6xLINta1jK/dJ
         LxDqepudmuVEmeVJnRu2MHqtIW79vVIzhojt1mPSaDpfKICwsF4cFvK2BJsf9xm3wHvk
         klOQ==
X-Gm-Message-State: ACgBeo2RMfeGcNjNB9+U0SytI6+fIBF2tfVC7Vt/lghvCYzVcx2jphUC
        2iakD7qlykmbOOVXdMMVZIXqEqaDQ4gkDcGKKlGGm+iqaoihMzh/es9Gvr92tG/Q2foxRmz5mXw
        Aa4kv9eE3qjIw8QV/3JOpCSlL
X-Received: by 2002:a05:600c:29ca:b0:3a6:75fe:82af with SMTP id s10-20020a05600c29ca00b003a675fe82afmr10609470wmd.3.1662375618003;
        Mon, 05 Sep 2022 04:00:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6sUmAHALGImsHXJaABta/ZqzyFke4VjRbqissy/caXyq3Iv6Hb+qDZ/L/rDzGBEi1YbgIjQw==
X-Received: by 2002:a05:600c:29ca:b0:3a6:75fe:82af with SMTP id s10-20020a05600c29ca00b003a675fe82afmr10609448wmd.3.1662375617734;
        Mon, 05 Sep 2022 04:00:17 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b0021e4829d359sm8661665wrs.39.2022.09.05.04.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:00:17 -0700 (PDT)
Message-ID: <03b207a8-e09c-2858-fd54-b95f2e8e8d11@redhat.com>
Date:   Mon, 5 Sep 2022 13:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Replace simple display helpers with the
 atomic helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220828151114.1141510-1-javierm@redhat.com>
 <6f499b1e-daa4-7de1-6ffc-151663807910@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <6f499b1e-daa4-7de1-6ffc-151663807910@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for your feedback and comments.

On 9/5/22 12:41, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 28.08.22 um 17:11 schrieb Javier Martinez Canillas:
>> The simple display pipeline is a set of helpers that can be used by DRM
>> drivers to avoid dealing with all the needed components and just define
>> a few functions to operate a simple display device with one full-screen
>> scanout buffer feeding a single output.
>>
>> But it is arguable that this provides the correct level of abstraction
>> for simple drivers, and recently some have been ported from using these
>> simple display helpers to use the regular atomic helpers instead.
>>
>> The rationale for this is that the simple display pipeline helpers don't
>> hide that much of the DRM complexity, while adding an indirection layer
>> that conflates the concepts of CRTCs and planes. This makes the helpers
>> less flexible and harder to be reused among different graphics drivers.
>>
>> Also, for simple drivers, using the full atomic helpers doesn't require
>> a lot of additional code. So adding a simple display pipeline layer may
>> not be worth it.
>>
>> For these reasons, let's follow that trend and make ssd130x a plain DRM
>> driver that creates its own primary plane, CRTC, enconder and connector.
> 
> Thanks for considering this change.
>

You are welcome and thanks to you for mentioning this to me. After doing
this I'm convinced as well that the simple-KMS / simple display pipeline
abstraction doesn't add any value and we should just drop it in favor of
the full atomic helpers.

>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks!
 
> There are a few questions below.
> 

[...]

>> +static void ssd130x_primary_plane_helper_atomic_update(struct drm_plane *plane,
>> +						       struct drm_atomic_state *old_state)
>>   {
>> -	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
>> +	struct drm_plane_state *plane_state = plane->state;
>> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
>>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> -	struct drm_device *drm = &ssd130x->drm;
>> -	int idx, ret;
>> +	struct drm_framebuffer *fb = plane_state->fb;
>> +	struct drm_device *drm = plane->dev;
>> +	struct drm_rect src_clip, dst_clip;
>> +	int idx;
>>   
>> -	ret = ssd130x_power_on(ssd130x);
>> -	if (ret)
>> +	if (!fb)
> 
> I know that some other drivers do this check. But from reading 
> drm_atomic_helper.c, it shouldn't be necesary. If !fb, the plane has 
> been disabled. And because there's an implementation of atomic_disable, 
> the helpers should never call atomic_update on disabled planes. I think 
> the test can be removed.
>

Yes, I just added because noticed that others drivers did. I'll drop it
when posting a v2.

[...]

>> +static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
>> +						 struct drm_atomic_state *state)
>> +{
>> +	struct drm_device *drm = encoder->dev;
>> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>> +	int ret;
>> +
>> +	ret = ssd130x_power_on(ssd130x);
>> +	if (ret)
>>   		return;
>>   
>> -	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
>> +	ret = ssd130x_init(ssd130x);
>> +	if (ret)
>> +		return ssd130x_power_off(ssd130x);
> 
> It returns a value from a function returning 'void'?
>

Right. I'll fix it in v2 as well.
 
> Is this function the correct place for ssd130x_init() ? It looks a bit 
> heavy for a simple enable operation.
> 

Yes, I was abusing the concept of encoder here just to have a place where
I could hook the enable / disable logic, since I was looking at the other
DRM objects helper operations structures and found that these were only
defined for the encoder.

But there is technically no encoder on this device. As you can see, I was
using DRM_MODE_ENCODER_NONE when the encoder is initialized.

But I notice now that the struct drm_crtc_helper_funcs also have .enable
and .disable callbacks, it seems I was just blind and didn't see before.

Would having the init and poweroff logic in the CRTC helpers be correct
to you or was do you have in mind ?

> Best regards
> Thomas
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

