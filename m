Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4A45205A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiEIUEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiEIUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F531CE2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652126445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNTeuuELA3k+mm60Gr40WBmjicvf+wfPyLcRV/GayX4=;
        b=bWybqTw6LQl9R0i/FdQAg2aRCWXb8dDxdmvX0BhB23ZINYKcho5JvNHdVDy3DeZwOyMquh
        EIO8beXcH0bxK8dwT96a7TC+vVeImpobq/1xmX4SeWQz9tyvI3c29IHaJN+KD2m/bSwjso
        3LHZtUwZL/9lhrpfOvLa7wTNSw5Y+UE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-eqPIGaDKNa6HZQ4EmhdgOw-1; Mon, 09 May 2022 16:00:44 -0400
X-MC-Unique: eqPIGaDKNa6HZQ4EmhdgOw-1
Received: by mail-wm1-f70.google.com with SMTP id t184-20020a1c46c1000000b00394209f54f1so4632443wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 13:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gNTeuuELA3k+mm60Gr40WBmjicvf+wfPyLcRV/GayX4=;
        b=HzHrVd07jgkAZtqLOVYn/0nTrVJ6ZKpMq+8XIyTRb+JkgKGhBroTw8gV2XRu8w5Qqo
         JDw1dASVkhjb3W2rT6Wa5l1rx60AugOGVTIfXNTfo4gnvckTVuQ9J5AT4hSm4gYemXnF
         rX/MWPZvth4HuU5LD+A6Rwa1i8/E3dScZD7p+kzQ5kTL0cd+dGjcQ8Nb9ZIHJbAnkdJk
         ftKL8US4zKNs1ACV5EHlQGzbhborZy0GFCnuJyfOt4yNbG3OVPYQtT8qUwFK3+614jud
         N6nb2svpRtiAc/ie05NCJTdeoIUX/QynP3ptz4eV5XlHf6ioQ06aIITHtlG58Gj9ZR38
         +oCw==
X-Gm-Message-State: AOAM533FEY25MO/iJVTwozjJLhNoGmxv6a7nuNRKzl5+ay3gWaELj/Jf
        1fIFZqZux0n0wCwByJAjGx0+h1w3TI7yVzQTaPyyNzfM4Bt6E/+9jgZA6n46QfSOALWwwssfbt/
        GfE5mCKP3OQGzu63dFlm0ESDl
X-Received: by 2002:a05:6000:1f0e:b0:20c:4fde:7e20 with SMTP id bv14-20020a0560001f0e00b0020c4fde7e20mr15545382wrb.532.1652126442992;
        Mon, 09 May 2022 13:00:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyACMJm+r6tlK8VZGCgzdHoFW+ert1TBWVKzmQnKSqvFbAYevfQT5KjzCveN5b6GZInW/cO7g==
X-Received: by 2002:a05:6000:1f0e:b0:20c:4fde:7e20 with SMTP id bv14-20020a0560001f0e00b0020c4fde7e20mr15545370wrb.532.1652126442776;
        Mon, 09 May 2022 13:00:42 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b00394832af31csm1280992wms.0.2022.05.09.13.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 13:00:42 -0700 (PDT)
Message-ID: <2c59cd79-76d4-7829-e1db-88bc31396c8a@redhat.com>
Date:   Mon, 9 May 2022 22:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
 <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
 <51254d3d-af8d-61b3-e8a2-8fd0e583e783@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <51254d3d-af8d-61b3-e8a2-8fd0e583e783@suse.de>
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

Hello Thomas,

On 5/9/22 20:32, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.05.22 um 18:33 schrieb Javier Martinez Canillas:
>> On 5/9/22 17:51, Andrzej Hajda wrote:
>>
>> [snip]
>>
>>>>>> +
>>>>> Regarding drm:
>>>>> What about drm_fb_helper_fini? It calls also framebuffer_release and is
>>>>> called often from _remove paths (checked intel/radeon/nouveau). I guess
>>>>> it should be fixed as well. Do you plan to fix it?
>>>>>
>>>> I think you are correct. Maybe we need something like the following?
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>>>> index d265a73313c9..b09598f7af28 100644
>>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>>> @@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
>>>>           if (info) {
>>>>                   if (info->cmap.len)
>>>>                           fb_dealloc_cmap(&info->cmap);
>>>> -               framebuffer_release(info);
> 
> After reviewing that code,  drm_fb_helper_fini() appears to be called 
> from .fb_destroy (see drm_fbdev_release).  The code is hard to follow 
> though.  If there another way of releasing the framebuffer here?
> 

Andrzej mentioned intel/radeon/nouveau as example, I only looked at i915
and the call chain is the following as far as I can tell:

struct pci_driver i915_pci_driver = {
...
        .remove = i915_pci_remove,
...
};


i915_driver_remove
  intel_modeset_driver_remove_noirq
    intel_fbdev_fini
      intel_fbdev_destroy
        drm_fb_helper_fini
          framebuffer_release
              
So my underdestanding is that if a program has the emulated fbdev device
opened and the i915 module is removed, then a use-after-free would be
triggered on drm_fbdev_fb_destroy() once the program closes the device:

drm_fbdev_fb_destroy
  drm_fbdev_release(info->par); <-- info was already freed on .remove

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

