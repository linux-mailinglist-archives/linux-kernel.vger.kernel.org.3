Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6D4F4DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582687AbiDEXtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351951AbiDEKDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CB16A5E84
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649152357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKqNwDVXh0g59f1MR986HOwdQbf3gnXSvWESiK0Rw5E=;
        b=dZk79HK2Dk5tchMGLY3feQ7LkJpvYstLKmrLMx3XsUshgn4gMsVjdEDaasvjKUY4oYeoOH
        HW4jQNW02MgIZHFaxHBGZF2GNIYajW5nxJKBbWriaFNRjWFOgb5ZXhjXitEi/n52yNvaif
        60lBxdWR/TRcdb18il6mFPmQqCnGY1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-oVfmL2kMOO6gmjXV3AykAw-1; Tue, 05 Apr 2022 05:52:36 -0400
X-MC-Unique: oVfmL2kMOO6gmjXV3AykAw-1
Received: by mail-wr1-f71.google.com with SMTP id v30-20020adfa1de000000b002060d11eb63so1387249wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EKqNwDVXh0g59f1MR986HOwdQbf3gnXSvWESiK0Rw5E=;
        b=Y5yA/hupr64lVL5oKJgWpsyS6UH3a7hy+cZ8RA7lUibVS9Ve/zd3+ZgoEpgOlfi9UE
         BjR8C0QTkNfIMmph1LQ5lQ0G82ZFiGosJ7TJZdB7AWcVce0+eq+c4P2SJ4P/hyVrUIX8
         JhVV5tzUb4IN9SMN0hLqTp2B945BIYJhqtvfuMfPS/s/qrOBVDDweFIhgqsAZh0wSLit
         B3kShXEqA2QIsdegOQB8/QjqiD+ok217rxnX/lEwRhAGSfhJLnVWr9VvbWjQHw7yV7n+
         8N1o2kiwzZZB8Z5P8reQOYK6ghLFbEcNH5X/kagnn6zj/LFkdM7ANwWbosJQ8hiGcws1
         44Qw==
X-Gm-Message-State: AOAM531w+IVxVM5nwyBpCw7Yl98bJqfHv1+ZGXGWam0fQ7IENR0DC2M1
        Ry7ToPWXFzUSdPWvrsTy/vGRv7AC4lQw90HvXTcUyUU1GSDk7S3DvzqusuIGRajEHQttwtYfg2m
        D4cV428IKyf8vOnpObHMSsK54
X-Received: by 2002:a1c:770e:0:b0:38e:75d3:16f2 with SMTP id t14-20020a1c770e000000b0038e75d316f2mr2244424wmi.204.1649152354885;
        Tue, 05 Apr 2022 02:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmRwRtyUQRVrKEcfVYMrKeLB3/oCcKnV0ten450p4GScIETbruCyXTcG+eLnrIWu6wGR5FQg==
X-Received: by 2002:a1c:770e:0:b0:38e:75d3:16f2 with SMTP id t14-20020a1c770e000000b0038e75d316f2mr2244401wmi.204.1649152354614;
        Tue, 05 Apr 2022 02:52:34 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0038cc046cb2esm2655361wmq.32.2022.04.05.02.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:52:34 -0700 (PDT)
Message-ID: <e124af06-4f24-277a-543a-82b383f48cea@redhat.com>
Date:   Tue, 5 Apr 2022 11:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
Content-Language: en-US
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
 <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
 <Ykv/k/WoVemoCJJA@phenom.ffwll.local> <YkwAhSt9HlbxcuZo@phenom.ffwll.local>
 <408ffe9b-f09f-dc7e-7f5e-a93b311a06fa@redhat.com>
 <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAKMK7uHf6H8mhSm6eDHUruWK5Xc2cSPkJUX6v-jpeQfjS19dKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 11:24, Daniel Vetter wrote:
> On Tue, 5 Apr 2022 at 11:19, Javier Martinez Canillas

[snip]

>>
>> This is how I think that work, please let me know if you see something
>> wrong in my logic:
>>
>> 1) A PCI device of OF device is registered for the GPU, this attempt to
>>    match a registered driver but no driver was registered that match yet.
>>
>> 2) The efifb driver is built-in, will be initialized according to the link
>>    order of the objects under drivers/video and the fbdev driver is registered.
>>
>>    There is no platform device or PCI/OF device registered that matches.
>>
>> 3) The DRM driver is built-in, will be initialized according to the link
>>    order of the objects under drivers/gpu and the DRM driver is registered.
>>
>>    This matches the device registered in (1) and the DRM driver probes.
>>
>> 4) The DRM driver .probe kicks out any conflicting DRM drivers and pdev
>>    before registering the DRM device.
>>
>>    There are no conflicting drivers or platform device at this point.
>>
>> 5) Latter at some point the drivers/firmware/sysfb.c init function is
>>    executed, and this registers a platform device for the generic fb.
>>
>>    This device matches the efifb driver registered in (2) and the fbdev
>>    driver probes.
>>
>>    Since that happens *after* the DRM driver already matched, probed
>>    and registered the DRM device, that is a bug and what the reverted
>>    patch worked around.
>>
>> So we need to prevent (5) if (1) and (3) already happened. Having a flag
>> set in the fbdev core somewhere when remove_conflicting_framebuffers()
>> is called could be a solution indeed.
>>
>> That is, the fbdev core needs to know that a DRM driver already probed
>> and make register_framebuffer() fail if info->flag & FBINFO_MISC_FIRMWARE
>>
>> I can attempt to write a patch for that.
> 
> Ah yeah that could be an issue. I think the right fix is to replace
> the platform dev unregister with a sysfb_unregister() function in
> sysfb.c, which is synced with a common lock with the sysfb_init
> function and a small boolean. I think I can type that up quickly for
> v3.

It's more complicated than that since sysfb is just *one* of the several
places where platform devices can be registered for video devices.

For instance, the vga16fb driver registers its own platform device in
its module_init() function so that can also happen after the conflicting
framebuffers (and associated devices) were removed by a DRM driver probe.

I tried to minimize the issue for that particular driver with commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0499f419b76f

But the point stands, it all boils down to the fact that you have two
different subsystems registering video drivers and they don't know all
about each other to take a proper decision.

Right now the drm_aperture_remove_conflicting_framebuffers() call signals
in one direction from DRM to fbdev but there isn't a communication in the
other direction, from fbdev to DRM.

I believe the correct fix would be for the fbdev core to keep a list of
the apertures struct that are passed to remove_conflicting_framebuffers(),
that way it will know what apertures are not available anymore and prevent
to register any fbdev framebuffer that conflicts with one already present.

Let me know if you think that makes sense and I can attempt to write a fix.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

