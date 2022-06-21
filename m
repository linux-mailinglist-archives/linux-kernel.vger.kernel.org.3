Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D415531FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350364AbiFUMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350178AbiFUMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D60AA26110
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655814344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChvXxqyn9OOMyURFW0VTLkgw2UAz7rtxv6HEJjFmKS0=;
        b=atXEIrPbHJar4Iiksv11BcResq7BKqi0Ryhu/MAax18XFr+sYbFF6wJ3gaJ2hu/kD+dUZZ
        paVDuFs+hx74cIHNsY6hgETL4/pxaqUXg6N0EGC2Z3tOzrvEq50WRD2LXIamimeT6uRxTu
        eQ1i8IUz/TNek+wPFiABllPHhawzVQs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-3aIx_EubP1iaomYqQxpIgw-1; Tue, 21 Jun 2022 08:25:42 -0400
X-MC-Unique: 3aIx_EubP1iaomYqQxpIgw-1
Received: by mail-wr1-f70.google.com with SMTP id v8-20020adfa1c8000000b0021b81a553fbso2547792wrv.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ChvXxqyn9OOMyURFW0VTLkgw2UAz7rtxv6HEJjFmKS0=;
        b=sAiAyYVxYFjvT4WKs30EEcVc52wAl86xw5WqInraqEE8DMoTgOYUMUQPXGEfvOrj5i
         /wLSqYijlXM4i4RSgn3TT5kghrwXskGk3qkRFG6npy1MGnDaXBu+PwmWvzzrYN51AFUe
         s7tSmFitO/RJvYbYncrmqFj14FJjUykpiT/1uuzd2bQJUC2bZf5lmEuqCuBmAB9ltYDT
         tZV8ZXW1n43MQr/SBP5XA5MVY/AciqIkDy8++YR0rr23ukY7l04D1B5secfUrftk51My
         Xatl0+31wKDmwJcjO57heJZR2ZtvOjEEQ16Qb6n2ZbIiPWyFfSh9VvYQKMD/TGUuozC/
         mQyQ==
X-Gm-Message-State: AOAM532wgwvNzc3ZE/IB9k2As9WjiMetSuL1PlQx+YRfFvGXUKUmbga2
        JORUm6VXQ/o6MIF9cLHrnt88Ya1hFjAMBmIuZEuGFBWVjUih2WoUfRaW2a1lSyRtfAosyWLjtiL
        d3TOKUYjSWRxb8TyZRTWQazyv
X-Received: by 2002:a1c:5411:0:b0:39c:4761:66f8 with SMTP id i17-20020a1c5411000000b0039c476166f8mr39561332wmb.47.1655814340790;
        Tue, 21 Jun 2022 05:25:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTAiCn5Imotvz18wokmi04OBc4tB0BgS4MkpRYCxooHQh3Q2IacQwQDWlfA//FgEeY08KGiA==
X-Received: by 2002:a1c:5411:0:b0:39c:4761:66f8 with SMTP id i17-20020a1c5411000000b0039c476166f8mr39561316wmb.47.1655814340566;
        Tue, 21 Jun 2022 05:25:40 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t19-20020a05600c129300b0039c8a22554bsm18838723wmd.27.2022.06.21.05.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 05:25:40 -0700 (PDT)
Message-ID: <c259699e-c478-d3f6-f892-721727a5f1bf@redhat.com>
Date:   Tue, 21 Jun 2022 14:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/2] drm: Implement DRM aperture helpers under video/
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Williamson <alex.williamson@redhat.com>, corbet@lwn.net,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <165541020563.1955826.16350888595945658159.stgit@omen>
 <165541192621.1955826.6848784198896919390.stgit@omen>
 <e1fd76ae-a865-889f-b4f0-878c00837368@redhat.com>
 <4f6e9b63-f955-d263-e69b-6396fbe48868@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <4f6e9b63-f955-d263-e69b-6396fbe48868@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 6/21/22 13:29, Thomas Zimmermann wrote:

[...]

>>> +
>>> +static bool overlap(resource_size_t base1, resource_size_t end1,
>>> +		    resource_size_t base2, resource_size_t end2)
>>> +{
>>> +	return (base1 < end2) && (end1 > base2);
>>> +}
>>
>> There's a resource_overlaps() helper in include/linux/ioport.h, I wonder if it
>> could just be used, maybe declaring and filling a struct resource just to call
>> that helper. Later as an optimization a resource_range_overlap() or something
>> could be proposed for include/linux/ioport.h.
> 
> Bu then we'd have to declare struct resource-es for using an interface. 
> This helper is trivial. If anything, resource_overlaps() should be 
> generalized.
>

Yes, that works too. Probably then we should just keep as is and then as a follow
up we can add another helper to include/linux/ioport.h to avoid having something
that's only for the aperture helpers.

>>
>> Also, I noticed that resource_overlaps() uses <= and >= but this helper uses
>> < and >. It seems there's an off-by-one error here but maybe I'm wrong on this.
> 
> struct resource stores the final byte of the resource. In our case 'end' 
> is the byte after that. So the code is correct.
> 
> Do we ever have resources that end at the top-most byte of the address 
> space?
>

I don't know to be honest.

[...]

>>> +static void detach_platform_device(struct device *dev)
>>> +{
>>> +	struct platform_device *pdev = to_platform_device(dev);
>>> +
>>> +	/*
>>> +	 * Remove the device from the device hierarchy. This is the right thing
>>> +	 * to do for firmware-based DRM drivers, such as EFI, VESA or VGA. After
>>> +	 * the new driver takes over the hardware, the firmware device's state
>>> +	 * will be lost.
>>> +	 *
>>> +	 * For non-platform devices, a new callback would be required.
>>> +	 *
>>
>> I wonder if we ever are going to need this. AFAICT the problem only happens for
>> platform devices. Or do you envision a case when some a bus could need this and
>> the aperture unregister the device instead of the Linux kernel device model ?
>>
> 
> In the current code, we clearly distinguish between the device and the 
> platform device. The latter is only used in a few places where it's 
> absolutely necessary, because there's no generic equivalent to 
> platform_device_unregister(). (device_unregister() is something else 
> AFAICT.)  At some point, I'd like to see the aperture code being handled 
> in a more prominent place within resource management. That would need it 
> to use struct device.
>

Ok, I was wondering what was the value of the indirection level other than
making the code more complex and supporting an hypothetical case of a FW
driver that would not bind against a platform device.

But if the goal is to move this at some point to a more generic place (i.e:
the Linux device model itself) then I agree that we can just keep it as is.

When you re-spin this patch, feel free to add my R-b since looks good to me.

And thanks again for working on this!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

