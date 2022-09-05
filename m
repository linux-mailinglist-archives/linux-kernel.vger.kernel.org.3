Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779FA5AD1C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiIELpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiIELpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3C17E08
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662378306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXaA3E4TeoLSiXCrVTczKxpCpoc9IkMCBxtbTOE4obg=;
        b=UnZtHt6Dd0crNuaE23y5SE6usVJaEWvDFdgPb4hfiS2GVLu0n8FQThkTqIdEUKoHnvEmbE
        XfvRgA1Bevh10wiwDCzOPK0TJ/PLIyNVolnflMxyGul2BTGAuRQBw5oADPHnrLF/w2lVmP
        iZNyvXuh0JWfhVa8RIXaw0PlkVHH/sE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-ZFPzbvzQPLqBjz03s3BGmA-1; Mon, 05 Sep 2022 07:45:04 -0400
X-MC-Unique: ZFPzbvzQPLqBjz03s3BGmA-1
Received: by mail-wm1-f71.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso5260905wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sXaA3E4TeoLSiXCrVTczKxpCpoc9IkMCBxtbTOE4obg=;
        b=7WjAoVZE+Rig6VmiQ5m8Oc1naol5ehAqJrdd94vwK7EUfX3EGV8UVFUkndxKKEB74o
         cLrXngSn3cK/LBgVspoHMhKuQNUQJI3p2tZPTU2kinAM96tfhWa/r893/IywSY09tGoW
         zxFBrhxlEEq64Jl7IFUA5JxUjZCr2FI+6MSsVcE+Pq6octdCixoMY1f4AYEP1TMvgHqZ
         WIsALzr2QFbwmmnL0uWkb96pchdBzacpS5KI9fACj2naAeNfr4sq78QqcIXQL7lkqF4g
         rw7MbRSxlLfC0DOmDSB39wrnGY0rLv/2wwtOLu9AdWTosWXzdHX7ukMQS68f/4rWfmAD
         LDKQ==
X-Gm-Message-State: ACgBeo0MfTqZjAAMUgMWKwMHYWvJXIMLdsOZaSqof8LJs5J5oFlFY/Wh
        6TgQ6MlAhH4fqymtprI/uA+opnC6RzhCRPsgWQAZDpJUHBfSPBzNhOEbWm05KSqVOSjxX0QbeHp
        gF45DipjrfcM6z8NY4JkSLHc6
X-Received: by 2002:a05:600c:2317:b0:3a5:a3b7:31f with SMTP id 23-20020a05600c231700b003a5a3b7031fmr10532305wmo.6.1662378303639;
        Mon, 05 Sep 2022 04:45:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR507ThDRQf0F4Vj6vouQTbPwKSRrGz2VTnuaPbtNhYgLbivGZ0rljiQm/TFfybJ3sTvLwDXqw==
X-Received: by 2002:a05:600c:2317:b0:3a5:a3b7:31f with SMTP id 23-20020a05600c231700b003a5a3b7031fmr10532289wmo.6.1662378303425;
        Mon, 05 Sep 2022 04:45:03 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b003a5dde32e4bsm17603531wmq.37.2022.09.05.04.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:45:03 -0700 (PDT)
Message-ID: <7376fe7b-3644-6081-2d7c-9d4f490da9c8@redhat.com>
Date:   Mon, 5 Sep 2022 13:45:01 +0200
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
 <3cb956d7-aac0-6a1a-6be1-098057e2fd03@redhat.com>
 <7e77aa04-8a0d-8d48-d156-2ed551d10e7c@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7e77aa04-8a0d-8d48-d156-2ed551d10e7c@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 13:37, Thomas Zimmermann wrote:
> Hi
> 

[...]

>>>> -	return 0;
>>>> +	return drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
>>>> +						   DRM_PLANE_NO_SCALING,
>>>> +						   DRM_PLANE_NO_SCALING,
>>>> +						   false, false);
>>>
>>> I'm undecided on this change. I know it's correct and more to the point.
>>> But the call's logic is non-intuitive: the call either returns an error
>>> or we have to test ->visible afterwards. So I wrote it explicitly.
>>>
>>
>> Yes, but the check has no effect so I found it even less intuitive. Maybe
>> add a comment then if you wan to keep the current code?
>>   
>>> I saw that your change to ssd130x also uses the pattern. If we find more
>>> such drivers, we could implement the atomic check as a helper. I suggest
>>> drm_plane_helper_atomic_check_fixed() in drm_plane_helper.c
>>>
>>
>> Sure. I can add a preparatory change in v2 that adds that helper and then
>> use it in the follow-up patch.
>>
> 
> Maybe wait for your ssd130x changes to land and then you can convert 
> both drivers to the new helper.
> 

Makes sense. I'll do that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

