Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2F5AD1E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiIELzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiIELzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF01D301
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662378905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dN+gArBAb1MXvGBnjXPIWD80ttEdRkSoYzrprgnDVV0=;
        b=Bnz7BF9ftEfvzZbW6daHqN2+KfNprmDKdizRrKelY4v+hdIUInfzb9L09/6UHU20mMachk
        5V0d/TIbIbAelwR9iB2MXwT6b8pY51JqRWw/zNyxyS+8WuEIRmZAU5fuAbDDd20MB0QYFH
        j8+bXWEt9k27rCuFXtLlzNK3AEikI8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-qkNlHJP_On2fA9i5Gld7cg-1; Mon, 05 Sep 2022 07:55:04 -0400
X-MC-Unique: qkNlHJP_On2fA9i5Gld7cg-1
Received: by mail-wm1-f72.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso7359067wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dN+gArBAb1MXvGBnjXPIWD80ttEdRkSoYzrprgnDVV0=;
        b=rofXdLx7DV7Q2Be8s/N3anqhIwLsicSXF46uLbnSyMUUiGLfoJ+iiEPUyQBB3R71Zn
         RF2X7VAWnp7zMZoYf2/c4gYZyPmDQRXMB2e6Wb1JCu1MxWaPkUrZ/voPwnQPdQXvb414
         VwvPoRwyOZQrrFRPFlGyOeQ328Nh9Njxfe9Da7W7IfXxkBcYTQ7IiRWNhBEhcHbjeaIV
         xP4qUx0vVmT3K/6r2nX2/xrwCAqjfWbH5rJv9lqa//338d+FQYYyR0TFejTdhtU1Ljgm
         Fd7+65ri1WP2HKcllEjOUTe3QdPnLs0sv8F6w0R2i6HZrscMpxpwmNisHK35RYXf9mXL
         Cstw==
X-Gm-Message-State: ACgBeo3wPv/Aylzc1i1YFjq20uGrnqPO6eufJAcGlMECoOsD1n9VNs8L
        PCbucIccqeXfbe0BBG6TYBDg1SCH+6ol9CINm/gSoqwMQOBJnvKnP1fEc7oFUshlr/0X+XZYT9c
        ZqZYcU0iir5SkfEmXvOtko+WE
X-Received: by 2002:adf:d846:0:b0:226:defc:3a01 with SMTP id k6-20020adfd846000000b00226defc3a01mr18853182wrl.313.1662378903320;
        Mon, 05 Sep 2022 04:55:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4KV4ZibjWbGN6YgO4KVDqVIO2XVkXWu4lHnfwaE7vitwyhRqHtdISnnm2nghZt1WcwxckCTA==
X-Received: by 2002:adf:d846:0:b0:226:defc:3a01 with SMTP id k6-20020adfd846000000b00226defc3a01mr18853174wrl.313.1662378903090;
        Mon, 05 Sep 2022 04:55:03 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003a5ea1cc63csm17694363wmo.39.2022.09.05.04.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:55:02 -0700 (PDT)
Message-ID: <49b62a63-a1d7-ca3f-abfc-df08edb46da3@redhat.com>
Date:   Mon, 5 Sep 2022 13:55:01 +0200
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
 <03b207a8-e09c-2858-fd54-b95f2e8e8d11@redhat.com>
 <bd987b93-ebcc-8fad-ee5e-2e25f4d64eaf@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <bd987b93-ebcc-8fad-ee5e-2e25f4d64eaf@suse.de>
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

On 9/5/22 13:34, Thomas Zimmermann wrote:

[...]

>>>
>>
>> Yes, I was abusing the concept of encoder here just to have a place where
>> I could hook the enable / disable logic, since I was looking at the other
>> DRM objects helper operations structures and found that these were only
>> defined for the encoder.
> 
> I liked the idea of handling backlighting here. Power on/off also seems 
> sensible.
>

Ok. I'll keep that then.
 
>>
>> But there is technically no encoder on this device. As you can see, I was
>> using DRM_MODE_ENCODER_NONE when the encoder is initialized.
>>
>> But I notice now that the struct drm_crtc_helper_funcs also have .enable
>> and .disable callbacks, it seems I was just blind and didn't see before.
> 
> You certainly want to use atomic_enable/atomic_disable. They are 
> mutually exclusive with the other enable/disable functions.
> 

Ah, then I wasn't blind after all. It was because the encoder was the
only DRM object that had .atomic_{en,dis}able. The CRTC only had some
.{en,disable} helper callbacks.

>>
>> Would having the init and poweroff logic in the CRTC helpers be correct
>> to you or was do you have in mind ?
> 
> There's quite a bit happening in the init function. Does it have to be 
> re-initialized on each enable operation?  If it survives the power-off 
> call, the initial init can be done in the CRTC reset function. It's 
> purpose is to set hardware and software to a clean state.
>

I need to check if it survives a disable/enable cycle. Specially since
on disable the VCC regulator is disabled, which might lead to the chip
state to get lost.
 
> Best regards
> Thomas
> 
>>
>>> Best regards
>>> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

