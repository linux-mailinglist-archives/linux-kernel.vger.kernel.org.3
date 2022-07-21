Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18F957C92A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiGUKis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGUKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB78966BBB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658399924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaxNNmAMeKmY5Be3rBByjMwZvM0Y1Hkwf+IaULdYHwI=;
        b=FJ0KpZdBMa1/n9kv0k49dbOIkEzznKkCun12XVfsmQGI+bTa8vUVkESpCGDiqIlkmjhVpr
        5flytQ4JpgUR1X5EC31EB2ugNDFqp3RXMflgS+ReMMcVzjgiCVB8cxuiE3F177Bqexzzuz
        tyB0v5jwo/JFIV2OtuNtA+mhw90oLck=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-nhl8hpaOOT-6oHEejQBHag-1; Thu, 21 Jul 2022 06:38:43 -0400
X-MC-Unique: nhl8hpaOOT-6oHEejQBHag-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b0043ac600a6bcso865068edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 03:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SaxNNmAMeKmY5Be3rBByjMwZvM0Y1Hkwf+IaULdYHwI=;
        b=50EmnFXNtHz+vNkFknIKuvLtdm2pv3TYJCEq6YkQKu2orNuGgqqHeKSYP/pI9vumYE
         +x82IJWcyNMgT75Ti3H2QUgesGB1bM0W5sKM1Emq1grvAIIIN98x/hspBIb4YCUDWGXW
         6BlAphozb5qoy/4riUKJDU++Sjrfn2lQhJTRausJHAfk5hXMG4pUsFUPGYVQIbWMiJVM
         l3M6bIKon6YnsbRGyxpqgI3C6z12Bo5/8wvPXUcGccM4ZNNe6qzMcjgerDtRueCpRuMm
         C1c4IGa49P8Edd87D/XaI4zlKeIBle5xDVTDr7rL7JdK3FPtLXAo7anrzr0oKPkfKrZL
         VcAQ==
X-Gm-Message-State: AJIora9D/jwgcA3i6mjD0RbJGqzi/hbloR/iUK90aLZ757Qa4jP0IaKP
        eAdH71QfD0zQip4ADkkX5zggOgKMoslipDuXXX7IqlRpY4UtSoiJCs4/b6uhQB2qDy3aNlJxIv9
        vnEstJVoVFF+Tbt12QUxMrkVd
X-Received: by 2002:a17:907:9620:b0:72b:5822:93d0 with SMTP id gb32-20020a170907962000b0072b582293d0mr40705117ejc.235.1658399922140;
        Thu, 21 Jul 2022 03:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFrGgrvPUPCiOk65wuDavzKJ5p4duaVmlJufhQdl7r0gqIa3EUYvRtGcGU6K/FAoYY/CVYzA==
X-Received: by 2002:a17:907:9620:b0:72b:5822:93d0 with SMTP id gb32-20020a170907962000b0072b582293d0mr40705088ejc.235.1658399921751;
        Thu, 21 Jul 2022 03:38:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id z7-20020aa7d407000000b0043b5adf54b3sm747999edq.61.2022.07.21.03.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:38:41 -0700 (PDT)
Message-ID: <2c3b55f9-7b18-4083-1b61-ad0ce6a13660@redhat.com>
Date:   Thu, 21 Jul 2022 12:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 1/2] drm/virtio: plane: use drm managed resources
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        kraxel@redhat.com, linux-kernel@vger.kernel.org
References: <20220720140214.199492-1-dakr@redhat.com>
 <20220720140214.199492-2-dakr@redhat.com> <YtgcgovHX6jAqbt8@ravnborg.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <YtgcgovHX6jAqbt8@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 7/20/22 17:17, Sam Ravnborg wrote:
> Hi Danilo,
> 
> thanks for submitting this patch.
> 
> On Wed, Jul 20, 2022 at 04:02:13PM +0200, Danilo Krummrich wrote:
>> Use drm managed resource allocation (drmm_universal_plane_alloc()) in
>> order to cleanup/simplify drm plane .destroy callback.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_plane.c | 30 +++++++-------------------
>>   1 file changed, 8 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index 6d3cc9e238a4..3008551d6a05 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -67,16 +67,10 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
>>   	return format;
>>   }
>>   
>> -static void virtio_gpu_plane_destroy(struct drm_plane *plane)
>> -{
>> -	drm_plane_cleanup(plane);
>> -	kfree(plane);
>> -}
>> -
>>   static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
>>   	.update_plane		= drm_atomic_helper_update_plane,
>>   	.disable_plane		= drm_atomic_helper_disable_plane,
>> -	.destroy		= virtio_gpu_plane_destroy,
>> +	.destroy		= drm_plane_cleanup,
> 
>  From the documentation of drmm_universal_plane_alloc:
> 
>      The @drm_plane_funcs.destroy hook must be NULL.
> 
> So the above assignment looks wrong.

Good catch! Indeed it registers the drm_plane_cleanup() with 
drmm_add_action_or_reset() already.

I'll send a v2.

> 
> The rest of this patch looks OK.
> 
> 	Sam

Danilo

> 
> 
>>   	.reset			= drm_atomic_helper_plane_reset,
>>   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>>   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>> @@ -379,11 +373,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>   	const struct drm_plane_helper_funcs *funcs;
>>   	struct drm_plane *plane;
>>   	const uint32_t *formats;
>> -	int ret, nformats;
>> -
>> -	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
>> -	if (!plane)
>> -		return ERR_PTR(-ENOMEM);
>> +	int nformats;
>>   
>>   	if (type == DRM_PLANE_TYPE_CURSOR) {
>>   		formats = virtio_gpu_cursor_formats;
>> @@ -394,17 +384,13 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>   		nformats = ARRAY_SIZE(virtio_gpu_formats);
>>   		funcs = &virtio_gpu_primary_helper_funcs;
>>   	}
>> -	ret = drm_universal_plane_init(dev, plane, 1 << index,
>> -				       &virtio_gpu_plane_funcs,
>> -				       formats, nformats,
>> -				       NULL, type, NULL);
>> -	if (ret)
>> -		goto err_plane_init;
>> +
>> +	plane = drmm_universal_plane_alloc(dev, struct drm_plane, dev,
>> +					   1 << index, &virtio_gpu_plane_funcs,
>> +					   formats, nformats, NULL, type, NULL);
>> +	if (IS_ERR(plane))
>> +		return plane;
>>   
>>   	drm_plane_helper_add(plane, funcs);
>>   	return plane;
>> -
>> -err_plane_init:
>> -	kfree(plane);
>> -	return ERR_PTR(ret);
>>   }
>> -- 
>> 2.36.1
> 

