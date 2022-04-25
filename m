Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDEA50DB55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiDYIkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiDYIkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F7C6A40D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650875868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcJjktltsy20pk/1TUGpfeSXdGLoP34V6e5SW63r+UU=;
        b=jUmP/IhbgGNglEKcaXPUaH1NKp/VZBxGpTIIurcnSmyrAffLcYVJ3UIMkz4NKi1hmcKGGq
        LJXSLyjVVYioETCKI9TYvQTb5anUrNJkILliUQUfZ7Jt+WXgYqJjkzGjKa4EGLfdijjCdN
        aH56pC2y86SXWWyaPgrPlAhAZ3yssHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-oHr1IlvAM0KcAAu83NgxMQ-1; Mon, 25 Apr 2022 04:37:46 -0400
X-MC-Unique: oHr1IlvAM0KcAAu83NgxMQ-1
Received: by mail-wm1-f72.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so6878290wmh.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hcJjktltsy20pk/1TUGpfeSXdGLoP34V6e5SW63r+UU=;
        b=VAQZ4Wmfww3uY+1XAutoTy3nrNDOXU+8Brsq62NwqxYtFhvyaBwDca20Fu8OUVjXHI
         Lsq+mwyeWoLKV5S+VJ2y+NzL0ExuZRQOmvhUGEeoBq1JazvOKY3Zei1R1xT5kCSzYuP5
         kNyd1BNBSg0jpV1aXXmE8V22B3FZzZ3QCknTu4t6Sa3r0lf9TD34OnVOlxA8boVOKJ1V
         ub0wH0zy5B+C2aa6waN8n82ZektFv/7/rEOEZB4maHH41FXG1lNCfjMRlSuKb9xrnsX6
         ZWthiH2gMV/RcCekzUfot3MCHAqoJclEQgfu/e+1Nuq0uEbGyERrVEMl/nHhkv4789/Z
         ggqQ==
X-Gm-Message-State: AOAM533ITlHVZBEmoha3MkdS1cVLXWnEnoHGZBDA4BF52eisGYm7eiFe
        Uq3lyjGk45R30/NcsJ8kIzlpLVe5eHug7Ou1wzgMgFQwYtbfDbpath7aOqaIVy/OmTs1qvbw00i
        EhWyMKH0Pm4j88xQQ7X6m/mEI
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id i131-20020a1c3b89000000b0038eb37f052dmr15325218wma.197.1650875865759;
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkDkiuHJY5bNGU58CjLV3AycTkBgdIf0DyWp+hIAcCSv4pw19dJ8Ap5RCImavOptKADqXHsg==
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id i131-20020a1c3b89000000b0038eb37f052dmr15325190wma.197.1650875865524;
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d29-20020adf9b9d000000b0020ada099ed5sm2698552wrc.17.2022.04.25.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
Message-ID: <41362e99-820c-727c-019a-11ec5f38083c@redhat.com>
Date:   Mon, 25 Apr 2022 10:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/5] fbdev: Restart conflicting fb removal loop when
 unregistering devices
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <20220420085303.100654-4-javierm@redhat.com>
 <44804419-0e83-b584-96d9-a35939b715bf@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <44804419-0e83-b584-96d9-a35939b715bf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for the feedback.

On 4/25/22 10:27, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.04.22 um 10:53 schrieb Javier Martinez Canillas:
>> Drivers that want to remove registered conflicting framebuffers prior to
>> register their own framebuffer, calls remove_conflicting_framebuffers().
>>
>> This function takes the registration_lock mutex, to prevent a races when
>> drivers register framebuffer devices. But if a conflicting framebuffer
>> device is found, the underlaying platform device is unregistered and this
>> will lead to the platform driver .remove callback to be called, which in
>> turn will call to the unregister_framebuffer() that takes the same lock.
>>
>> To prevent this, a struct fb_info.forced_out field was used as indication
>> to unregister_framebuffer() whether the mutex has to be grabbed or not.
>>
>> A cleaner solution is to drop the lock before platform_device_unregister()
>> so unregister_framebuffer() can take it when called from the fbdev driver,
>> and just grab the lock again after the device has been registered and do
>> a removal loop restart.
> 
> I don't see how this patch improves the situation. So far, 
> do_remove_conflicting_framebuffers() had no business in maintaining 
> locks. And now it's doing this in in a goto-loop where it keeps 
> getting/dropping locks.  That's asking for bugs IMHO.
>

It's true that do_remove_conflicting_framebuffers() gets more complicated
with all the locks release/re-acquire but OTOH unregister_framebuffer()
doesn't do conditionally locking, and more importantly the drivers .remove
callback isn't called with the lock held, which IMHO is also quite fragile.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

