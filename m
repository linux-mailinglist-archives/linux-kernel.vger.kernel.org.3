Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34E52330E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiEKMYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiEKMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 588AB1C345C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652271866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=StKeixQ3rsAMa6ZFGvWGBr2LGTsx9ja9jzeia2Tii80=;
        b=CYbz11wO/adqfQko8U2ODGkHnGCEsAcWcXh3x5Q1p6cclb8nU55Icib+W/oSlQ6qk0RqSz
        vyYKlVyWFSq5lhBsVEukWYbwLC5c1/3GWBC0lblgcE1+nZy/unIp2MtNFi+Cux/FDMGllr
        BGmVwieVEw+DzQlQ1QY8AUk4cZGGEG8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-jf9uAF_mMnGR5DqBlb-6gw-1; Wed, 11 May 2022 08:24:25 -0400
X-MC-Unique: jf9uAF_mMnGR5DqBlb-6gw-1
Received: by mail-wm1-f70.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso645822wmm.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=StKeixQ3rsAMa6ZFGvWGBr2LGTsx9ja9jzeia2Tii80=;
        b=YiRrcGRNDrboPMaJlSbWjiTcBKYRnqTocT8Ue3JxaLmN2xMsCLEl4gW9tM3RYsCmDw
         yiTBUm4PdjYa2cGkospp9723vhicQSR07mrIrS32D+UYepxTrhASNN9NyPguqca96q1h
         qwC6DOlpx9meiD71LY/PiXZtYk6QKRvk3FhZ3FBS4EEbT8cfJXdZMmpFKjj3XRScSwTC
         nuslM5MFImC3QWcA0zosKCD4u+/9JRqRlDn9MjnUv1h/BcRcE0Y7+H3qXx+xncxo5gPA
         XiIdoPj1WgofFKgK7HisT8QvAmJ+JYznI8lMST/4vHIR3RztFY/PkAxUiyNB2OXUtIf5
         RdIw==
X-Gm-Message-State: AOAM532K0mdQY9SikPBfnWFs9Sxxki3vv2byoW14sI0zwYidhdzxqG5t
        RgRmHnpxbHcfSjUEBbts9E62O1cIAW7JLbae1u3AwSNWcHWz5p0CZkJ36+Z3ctA89sR8ZDEeN+M
        YgkkU16X4LalkW/SRnqO9iIgb
X-Received: by 2002:a5d:64ae:0:b0:20c:6030:d6f0 with SMTP id m14-20020a5d64ae000000b0020c6030d6f0mr22641352wrp.298.1652271864002;
        Wed, 11 May 2022 05:24:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj/yczfYQv2d8rR90uXHwUui4saVslbeigPoq1BVFw07uRYvJAhRqIieGGIQuhaIXCbGy9Fg==
X-Received: by 2002:a5d:64ae:0:b0:20c:6030:d6f0 with SMTP id m14-20020a5d64ae000000b0020c6030d6f0mr22641315wrp.298.1652271863436;
        Wed, 11 May 2022 05:24:23 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x6-20020adff646000000b0020cd2e8d3b1sm1614780wrp.5.2022.05.11.05.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 05:24:23 -0700 (PDT)
Message-ID: <99a8b131-8e30-4ff1-3561-4ccbfa538a60@redhat.com>
Date:   Wed, 11 May 2022 14:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/7] firmware: sysfb: Add helpers to unregister a pdev
 and disable registration
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511112438.1251024-3-javierm@redhat.com>
 <67ed69d1-ebea-c9d0-45be-3c6c7e5ea1e5@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <67ed69d1-ebea-c9d0-45be-3c6c7e5ea1e5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 5/11/22 14:02, Thomas Zimmermann wrote:

[snip]

>> +
>> +/**
>> + * sysfb_disable() - disable the Generic System Framebuffers support
>> + *
>> + * This disables the registration of system framebuffer devices that match the
>> + * generic drivers that make use of the system framebuffer set up by firmware.
>> + *
>> + * It also unregisters a device if this was already registered by sysfb_init().
> 
> Why? I still cannot wrap my mind around, why we need to store *pd at all 
> and use sysfb_try_unregister() for unregistering.
>

Because on sysfb_disable(), the registered platform device has to unregistered.

And sysfb has no way to know if it was unregistered already or not unless that
stage is maintained in sysfb itself.

Let's have some examples assuming that we don't have this helper in sysfb
(will use the vc4 DRM driver just to avoid typing "a real DRM driver).

a) simplefb probed and then vc4

   1) "simple-framebuffer" pdev is registered by sysfb
   2) simplefb is registered and matches "simple-framebuffer"
   3) a vc4 device is registered by OF when parsing the DTB
   4) vc4 driver is registered, matches vc4 and probes
   5) vc4 requests the conflicting framebuffers to be removed
      and fbmem unregisters "simple-framebuffer"
   6) fbmem calls sysfb_disable()
   7) sysfb_disable() should unregister the pdev but can't
      because has no way to know that fbmem already did that.
 
b) vc4 probed and then simplefb.ko module is loaded

   1) "simple-framebuffer" pdev is registered by sysfb
   2) a vc4 device is registered by OF when parsing the DTB
   3) vc4 driver is registered, matches vc4 and probes
   4) vc4 requests the conflicting framebuffers to be removed
      and fbmem unregisters "simple-framebuffer"
   5) fbmem calls sysfb_disable()
   6) sysfb_disable() should unregister the pdev but can't
      because has no way to know that fbmem already did that.
   7) simplefb.ko is loaded and simplefb driver registered
   8) simplefb matches the registered "simple-framebuffer"
      and will wrongly probe and register a DRM device.

In option (a), making sysfb_disable() to attempt to unregister the device
that register in sysfb_init() will lead to a use-after-free if this was
already unregistered by fbmem in remove_conflicting_framebuffers(), so
it can't attempt to do that.

Same for option (b), but sysfb_disable() can't rely on fbmem to do the
unregistration because it only does for devices that are associated with
an already registered fbdev.

[snip]

>> + * Return:
>> + * * true          - the device was unregistered successfully
>> + * * false         - the device was not unregistered
>> + */
>> +bool sysfb_try_unregister(struct device *dev)
> 
> As it stands, I strongly object the use of this function as still don't 

No worries, it's my bad since I clearly failed to explain the rationale in
the commit message and comments.

> really get the purpose. It looks like a glorified wrapper around 
> platform_device_unregister(). Do we need disable_lock to serialize with 
> something else?
>

Yes, it has to serialize with sysfb_init() and sysfb_disable().
 
> Best regards
> Thomas
> 
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

