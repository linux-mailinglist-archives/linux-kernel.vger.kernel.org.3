Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28A6520FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiEJIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEJIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE372F03D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652171448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1m42YOS6adkVOttPvzzPcpB4bdLVq0RFj4rgcIuwmIE=;
        b=goZPeP17u9qT3qm+qQj//FDuxEpAl7t68g+stlH4Rv+K0oZCAAx+fifJVhtR162AWQz5Io
        cDu919LRUj8PiSGRL3tGycC6qSzp61WovzHvJHwMTjJDRW1GiL4YKxdYf7Uzm2b0IszzAt
        QxjLwOmrzlytsPJNCtVkGAg8mVlcYSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-aqFLj3G4MgWNs_fQ0ku7YQ-1; Tue, 10 May 2022 04:30:47 -0400
X-MC-Unique: aqFLj3G4MgWNs_fQ0ku7YQ-1
Received: by mail-wm1-f71.google.com with SMTP id 205-20020a1c02d6000000b003928cd3853aso924883wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1m42YOS6adkVOttPvzzPcpB4bdLVq0RFj4rgcIuwmIE=;
        b=DAnUKh0GthNLCVn7TogJuGKBd1KOuduW6/kkjucayBGk2UIGoUWrxmf9J1HHTer/zp
         Tt+UTKlFA1rVQW4Xcyv5f8MgDzUFVVQ7CEMqcCBRXFF6x/KvamtPe9ddDfsW6nJDBF3t
         gGgySiWOXT3WCi+HjsdvprZk92a4QWjsRSzXUsVhsFog6SMqZbLd+srMVmsjjqSFH/Tt
         llUCRVKecnmtDwMWfDcuQzuxtqdn+4FdkjMoaIdOO3lY0xJXcGGtrZRk5I389y6XMZpf
         2ZSIIEMFDxxyTgYAbBjwrPmzszhGn9msSMigwYV6PRpsWurnA0G8edgcm4CS/McyJa8v
         iCrg==
X-Gm-Message-State: AOAM533Ck6j1PmNTVrReMcPOx0HWXxINXPKKs31ypTCtOUM3awcAqZEd
        OZS5xGPAP6QhoYOxx/jKjpBxN7OD/ma4T0kmlwjZMYND6KuwtHCN2Eba+36djat2o10MvcTbHOI
        VJwknuoaIeLiC4uJ7kZMjzu9e
X-Received: by 2002:a5d:4703:0:b0:20a:ce3c:7528 with SMTP id y3-20020a5d4703000000b0020ace3c7528mr17564141wrq.688.1652171445795;
        Tue, 10 May 2022 01:30:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoBMj8kXDsvsfO4i+XkAgVG6qM0AfXiyKEYB6N5jwKUXVSznUhS5NktRYArBUXsTfI3Cbm7g==
X-Received: by 2002:a5d:4703:0:b0:20a:ce3c:7528 with SMTP id y3-20020a5d4703000000b0020ace3c7528mr17564116wrq.688.1652171445454;
        Tue, 10 May 2022 01:30:45 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l29-20020a05600c1d1d00b003942a244f53sm1816260wms.44.2022.05.10.01.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:30:45 -0700 (PDT)
Message-ID: <2d8d8583-3a39-b826-dd83-ba5bc4c5b082@redhat.com>
Date:   Tue, 10 May 2022 10:30:44 +0200
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
 <b5ab1c49-04e7-36c3-677d-2989b79e50ca@suse.de>
 <2bf27b09-0896-1849-254f-d5b19abdc892@redhat.com>
 <fc3e8a40-664f-07ae-7474-c0412a1ab1b5@intel.com>
 <1c36d431-d5c0-7278-c9e0-61867e9dc174@redhat.com>
 <79aaea41-5dab-f896-ab3d-d6bc9a5de615@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <79aaea41-5dab-f896-ab3d-d6bc9a5de615@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/10/22 10:04, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.05.22 um 00:42 schrieb Javier Martinez Canillas:
>> On 5/10/22 00:22, Andrzej Hajda wrote:
>>
>> [snip]
>>
>>>>    static void drm_fbdev_fb_destroy(struct fb_info *info)
>>>>    {
>>>> +       if (info->cmap.len)
>>>> +               fb_dealloc_cmap(&info->cmap);
>>>> +
>>>>           drm_fbdev_release(info->par);
>>>> +       framebuffer_release(info);
>>>
>>> I would put drm_fbdev_release at the beginning - it cancels workers
>>> which could expect cmap to be still valid.
>>>
>>
>> Indeed, you are correct again. [0] is the final version of the patch I've
>> but don't have an i915 test machine to give it a try. I'll test tomorrow
>> on my test systems to verify that it doesn't cause any regressions since
>> with other DRM drivers.
> 
> You have to go through all DRM drivers that call drm_fb_helper_fini() 
> and make sure that they free fb_info. For example armada appears to be 
> leaking now. [1]
>

But shouldn't fb_info be freed when unregister_framebuffer() is called
through drm_dev_unregister() ? AFAICT the call chain is the following:

drm_put_dev()
  drm_dev_unregister()
    drm_client_dev_unregister()
      drm_fbdev_client_unregister()
        drm_fb_helper_unregister_fbi()
          unregister_framebuffer()
            do_unregister_framebuffer()
              put_fb_info()
                drm_fbdev_fb_destroy()
                  framebuffer_release()

which is the reason why I believe that drm_fb_helper_fini() should be
an internal static function and only called from drm_fbdev_fb_destroy().

Drivers shouldn't really explicitly call this helper in my opinion.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

