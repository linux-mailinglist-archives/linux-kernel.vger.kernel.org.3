Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FC5AD168
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiIELGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiIELGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1952DFC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662375970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO1i55RplxPZ02kGwMsg/12FGLiwqlnF30GYvzC7fc4=;
        b=jKbj9MRYlfSjYjo16U/IAGn8p0R79VJvS2sDiYL2ymUhKGC/NEwNO4dk9jDiMFLSWgZ/yS
        viXvIDPccBRx9ZYR4OAlQ2pWZLZn+V+ZKImRUwuWjYJ7RytyLlKhkb5J1Eh/r3fnozPUUh
        J5i44AvOZgGwrlNGfiDlQ+sMSXiK2Ho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-N5x8ATbcOlGaKQRQHpx3Qg-1; Mon, 05 Sep 2022 07:06:09 -0400
X-MC-Unique: N5x8ATbcOlGaKQRQHpx3Qg-1
Received: by mail-wr1-f69.google.com with SMTP id b17-20020adfc751000000b00228732b437aso512215wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fO1i55RplxPZ02kGwMsg/12FGLiwqlnF30GYvzC7fc4=;
        b=ujvuUVOa0Uhffh9SuDoYusUMie33tKM5m8kZ5nRaKDDXqPuCniLGX3GHEa9HJ13w53
         y79OmaIyr4xtTc1x2Yn9cXFhw566ksSGPPbcHgWs8AkNWUPgLZL/r+5+zUvdUAhsVhAD
         8Pzp4SZ2NtfKPvWKeJJN9YN2Xf682wfGsa/OtAsAup08fhEv8a0pYldHZJ5FnpIF4k1S
         GyOdVpV/450lNycJuFlH2CgOuW8D/Npps7jbxgxGRKl0yQpJfy0ehGZl4BubojE1scnc
         FqY+ZeYijAW0yzjkgIHIpWpVscTBwUc63i66u6gobux67m2osY1JC2hS9GeNV2Jyfs+Z
         ZyUw==
X-Gm-Message-State: ACgBeo08hAkmR55wg4WiDJUPIKsuBRmNdXaGP/rdmGh/6SJygGjSBJby
        pcpt8FcFHeAoeqR6ypXJOO+wpia/oy7hTHnNCx45h7xfSS9F7gDCeOQ9VuoOg088k2ySGH2Yi+1
        JyvfDhEavEkpmUjifd6lsJ2gI
X-Received: by 2002:a05:600c:22c7:b0:3a6:68e4:1e5f with SMTP id 7-20020a05600c22c700b003a668e41e5fmr10553350wmg.46.1662375967615;
        Mon, 05 Sep 2022 04:06:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TMlz0cg+Da+T5vw7hPchTgHKEuLCta7hHxP5YSvjT2BsJts1L8D8WV3F+qViax1jfzeQyfw==
X-Received: by 2002:a05:600c:22c7:b0:3a6:68e4:1e5f with SMTP id 7-20020a05600c22c700b003a668e41e5fmr10553335wmg.46.1662375967344;
        Mon, 05 Sep 2022 04:06:07 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id az24-20020adfe198000000b00228619a097esm6007312wrb.49.2022.09.05.04.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:06:07 -0700 (PDT)
Message-ID: <3cb956d7-aac0-6a1a-6be1-098057e2fd03@redhat.com>
Date:   Mon, 5 Sep 2022 13:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/simpledrm: Drop superfluous primary plane
 .atomic_check return logic
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220831111243.1530620-1-javierm@redhat.com>
 <43e3dead-6089-c342-5050-34d7325bcb24@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <43e3dead-6089-c342-5050-34d7325bcb24@suse.de>
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

On 9/5/22 12:57, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 31.08.22 um 13:12 schrieb Javier Martinez Canillas:
>> The simpledrm_primary_plane_helper_atomic_check() function is more complex
>> than needed. It first checks drm_atomic_helper_check_plane_state() returns
>> value to decide whether to return this or zero.
>>
>> But it could just return that function return value directly. It also does
>> a check if new_plane_state->visible isn't set, but returns zero regardless.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/tiny/simpledrm.c | 15 ++++-----------
>>   1 file changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
>> index a81f91814595..0be47f40247a 100644
>> --- a/drivers/gpu/drm/tiny/simpledrm.c
>> +++ b/drivers/gpu/drm/tiny/simpledrm.c
>> @@ -485,21 +485,14 @@ static int simpledrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
>>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>>   	struct drm_crtc_state *new_crtc_state = NULL;
>> -	int ret;
>>   
>>   	if (new_crtc)
>>   		new_crtc_state = drm_atomic_get_new_crtc_state(new_state, new_crtc);
>>   
>> -	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
>> -						  DRM_PLANE_NO_SCALING,
>> -						  DRM_PLANE_NO_SCALING,
>> -						  false, false);
>> -	if (ret)
>> -		return ret;
>> -	else if (!new_plane_state->visible)
>> -		return 0;
>> -
>> -	return 0;
>> +	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
>> +						   DRM_PLANE_NO_SCALING,
>> +						   DRM_PLANE_NO_SCALING,
>> +						   false, false);
> 
> I'm undecided on this change. I know it's correct and more to the point. 
> But the call's logic is non-intuitive: the call either returns an error 
> or we have to test ->visible afterwards. So I wrote it explicitly.
>

Yes, but the check has no effect so I found it even less intuitive. Maybe
add a comment then if you wan to keep the current code?
 
> I saw that your change to ssd130x also uses the pattern. If we find more 
> such drivers, we could implement the atomic check as a helper. I suggest 
> drm_plane_helper_atomic_check_fixed() in drm_plane_helper.c
>

Sure. I can add a preparatory change in v2 that adds that helper and then
use it in the follow-up patch.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

