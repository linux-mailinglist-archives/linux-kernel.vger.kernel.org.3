Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7D2519E18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348872AbiEDLgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348858AbiEDLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E15B72BB35
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651663960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSmRyvY5USUJK4bqOwkMxhLEWYFefLvLLVRpwsW24V4=;
        b=JKhqgmAztVTPamoAqkHcjBpDzjHX1qT0odi3JFJ5jb1+fkz5vxb/5TzYPc3gsuobuDHccD
        r7X3+LKSh904KvAkKpAlbqjYjaVvQ+ymBflmIq4+LwFuijVJhsI6st0Oh74lJpD8T4GG+J
        838FURjc1xFUZNKxLoSI4YEQLWzeo98=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-vlKWuOsYMfCvp3-xYseHkw-1; Wed, 04 May 2022 07:32:39 -0400
X-MC-Unique: vlKWuOsYMfCvp3-xYseHkw-1
Received: by mail-wr1-f69.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so277336wrg.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xSmRyvY5USUJK4bqOwkMxhLEWYFefLvLLVRpwsW24V4=;
        b=yi2pKkVFOC3iX7JziJrdNlpQ2OFO8pxOWta0Pw7eruczdUcyTqfdXGO5pS/+qPR/Gr
         2tK1jwUH24V27oNH3fnGuZHyggJYFKSZaQhLhrb2a8KW49UlB8dpsBej6yoR8cSGBWEv
         j+x3o6HgdNFJmvvljDleE5HnfqojHaRWOmwOngGO5ijh+9cenCRiCekkdVSicQyQi5PQ
         z2eK4ETcYGgEqjVjDLJqRX0uvWe8+StGZqvvh+bSyDzqUjAblmfRdi2PsSw61i8/jm4r
         irCveIOjvATqTckhU0k2hbdLhl3e8AtpzL/7exiPbcLG2dK5Gh7ZdTpOi42AMSxS9HTQ
         373g==
X-Gm-Message-State: AOAM530vp4xgo/M+WYKt9rgCuZoGUrkpr8uqFmedaCkJ2sJ0cPaBckfj
        E9T6WqrW+b+1L0+wY+M3ETK0azicNy2mqSoqvNOWTENtNNRevZJO8+7yFSd/aGRGB8hB8+b0WjL
        Nh1ovjex8vdcccHdfMIEAZRNcm3H9VwfknWTeEFgfLQNW1IjfpjCi3L4ANRY7wKUVXAGV+/LwVn
        E=
X-Received: by 2002:a7b:ce08:0:b0:394:32df:2ae6 with SMTP id m8-20020a7bce08000000b0039432df2ae6mr7189960wmc.184.1651663958465;
        Wed, 04 May 2022 04:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA5wXaWnN+rrsK5flhGj5h/2tfXvIEclG8Wrk1xlOuCGc80m9A3smlCSu4+D4IoWK24dOV7Q==
X-Received: by 2002:a7b:ce08:0:b0:394:32df:2ae6 with SMTP id m8-20020a7bce08000000b0039432df2ae6mr7189946wmc.184.1651663958176;
        Wed, 04 May 2022 04:32:38 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b0039429bfebeasm4958174wms.2.2022.05.04.04.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 04:32:37 -0700 (PDT)
Message-ID: <bfb03d40-a023-12a9-9554-1b6e6c474134@redhat.com>
Date:   Wed, 4 May 2022 13:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
References: <20220503071540.471667-1-javierm@redhat.com>
 <20220503071540.471667-4-javierm@redhat.com>
 <YnJcaaDcIsJKhSwQ@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnJcaaDcIsJKhSwQ@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 12:58, Daniel Vetter wrote:
> On Tue, May 03, 2022 at 09:15:40AM +0200, Javier Martinez Canillas wrote:
>> Indicate to fbdev subsystem that the registered framebuffer is provided by
>> the system firmware, so that it can handle accordingly. For example, would
>> unregister the FB devices if asked to remove the conflicting framebuffers.
>>
>> Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
>> Drivers can use this to indicate the FB helper initialization that the FB
>> registered is provided by the firmware, so it can be configured as such.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>
>> Changes in v3:
>> - Drop the firmware local variable (Laurent Pinchart).
>> - Use DRM_FB_OPTION() since DRM_FB_SET_OPTION() got renamed (kernel test robot).
> 
> Just for the record what I brought up on irc already:
> 
> FBINFO_MISC_FIRMWARE is purely an internal flag with no uapi impact, and
> it's only to control whether we nuke this from
> remove_conflicting_framebuffer or not. Since simpledrm only ever binds
> against sysfb I think it'd be cleaner to only rely on that, and relegate

That's not actually true. The OF subsystem also registers "simple-framebuffer"
devices when there are Device Tree nodes that contain a "simple-framebuffer"
compatible string. In that case these pdev will also bind against simpledrm.

> that entire FBINFO_MISC_FIRMWARE misc hack to the fbdev dungeons and let
> it quietly wither away there.
>
> Also I'm not a huge fan of these midlayer flags in general :-)

And while I agree with you that these midlayer flags are horrible, that is
what any other fbdev that makes use of a firmware-provided framebuffer set,
so simpledrm emulated fbdev shouldn't be the exception IMO.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

