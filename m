Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE271475560
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbhLOJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231209AbhLOJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639561509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOfhMPMzb3b+8cFxZBwAoJpd4V5hJXJBPtGjNJ39SAM=;
        b=PiK3rR05aASfw1wYtroM8IyPAHuAVdud/swqFurgjukdUHxSo7JNhTPFmH/s2VMQeI7rRz
        60ZGI2UGtXRsDwJwJTFDTJB7NLtrM9K1lsXkxd1J2Sz2ValQKjn4CsIOcGLMV1DTMJvZIK
        H2W2SdG4r8rZMZh6thv2SuDsMgAJrz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-CMMSdIprMzeXsAI9XfX1oA-1; Wed, 15 Dec 2021 04:45:08 -0500
X-MC-Unique: CMMSdIprMzeXsAI9XfX1oA-1
Received: by mail-wr1-f70.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so2922662wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uOfhMPMzb3b+8cFxZBwAoJpd4V5hJXJBPtGjNJ39SAM=;
        b=MmfVXVCFBiCit4827AF7fEASdSXqqsy+U4+sVkl8OLYAT/gjwJtykhzf4DBd3wvkbi
         7fp8p6qMRhXDe1oWMtkhaBFMGZSN3Chbx3lLb2n1pe43BGtghiRWSHQ5xYfOnm5RyetK
         O377hhUvga0HB08lPyBOBS5jjpW9XsGA4zsQydDverESFJ06PhojnNOkvtIwJUTM0YJf
         4cY+5ub+Uzva6GdPlXnP5To9jFJ0uJimC1ZUy6ItMnbq2UmAVs57OOjopa80Q1z1U0Rl
         MvTWGkwZ1voQII27OqyALCeph6j4KzO5VhBdi7jaD8YHV051Yc6ManuCsDWQkpylzoR4
         ejGQ==
X-Gm-Message-State: AOAM5335FL36PV3rSDavriSfZ5rh+tIukKfd3znxdpT8Xp7brg2s8qRb
        UWkplLnq3SQANYTXXu3EHuQGSavoTwN0ywXCRrJMq8tyD1zikMfhnKsj8oV5AkkLkmw+b/1SLx+
        HkFoV6KRuwD8UEAMXxnUGPzCQ
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr3539952wrw.104.1639561506808;
        Wed, 15 Dec 2021 01:45:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeVaU0EvxegObzc8k4zlvSkAP+oYtkR2V06K+lEh+m+Jl9TcbiXRBDr5RTDDcpxNu5TORHcA==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr3539941wrw.104.1639561506619;
        Wed, 15 Dec 2021 01:45:06 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x13sm1469172wrr.47.2021.12.15.01.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 01:45:06 -0800 (PST)
Message-ID: <a919884b-1e28-bf49-5de6-5cc2b6329969@redhat.com>
Date:   Wed, 15 Dec 2021 10:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 07/60] drm/etnaviv: Add support for the nomodeset kernel
 parameter
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Erico Nunes <ernunes@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
 <20211215010008.2545520-8-javierm@redhat.com>
 <190d0eea4c134539a500a3fae514bb6e3025a7ec.camel@pengutronix.de>
 <36d2ca10-22ae-5c15-4ab1-6ff84507c0cb@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <36d2ca10-22ae-5c15-4ab1-6ff84507c0cb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Erico Nunes to Cc list]

On 12/15/21 10:39, Thomas Zimmermann wrote:
> (cc'ing Maxime)
> 
> Hi
> 
> Am 15.12.21 um 10:18 schrieb Lucas Stach:
>> Hi Javier,
>>
>> Am Mittwoch, dem 15.12.2021 um 01:59 +0100 schrieb Javier Martinez Canillas:
>>> According to disable Documentation/admin-guide/kernel-parameters.txt, this
>>> parameter can be used to disable kernel modesetting.
>>>
>>> DRM drivers will not perform display-mode changes or accelerated rendering
>>> and only the systewm system framebuffer will be available if it was set-up.
>>>
>> Etnaviv is a render-only driver, so will no perform any modesetting on
>> a display device, so I'm not sure if it's sensible to cover it under
>> the nomodeset parameter. I see that it is consistent with the other
>> drivers that deal with a combined render/display device, where the
>> render device also gets disabled with the nomodeset param, but it
>> doesn't really match the description of what the parameter is supposed
>> to do.
>>
>> I'm not opposed to take this patch for consistency reasons, but I would
>> like to hear some more opinions from other DRM folks.
> 
> Our assumption is that we want to disable all DRM drivers; except those 
> that operate on the firmware's original framebuffer. That's why the the 
> test is called drm_firmware_drivers_only().
> 

Yes, we tried to document the implicit "nomodeset" semantics to make that
clear: https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b22a15a5aca34c8f59b770f858b1c21d347175e0

> We know that nomodeset is a terrible name. We only kept it because it 
> was already there, widely used, and already does what we need.
> 
> We had similar concerns with the v3d driver of vc4. Javier, maybe we 
> should leave-out such special cases for now and discuss them separately?
>

I was discussing the same with Erico (one of the lima driver developers).

Agree that we could leave those for now. Will drop from the patch-set all
the DRM drivers that don't have the DRIVER_MODESET .driver_features flag. 
 
> Best regards
> Thomas
> 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

