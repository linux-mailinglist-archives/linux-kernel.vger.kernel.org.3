Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A207519BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbiEDJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbiEDJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B777A25EB4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651656540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiHfuXpjUO1Kx7oSpMgn+KkNUM21let3MfJCKQvBKl4=;
        b=ShWIKnuJfMwR+qHBaPkRbzvqrku9xqFJsbrSP/yfadAZ9MASRFkukJZWo+vzk5EgNvRX5Y
        X+VzoTleaU9rcXUuYoDT1HmmnAY1fAElhyCgze/dsSXIuzGZbQf3tL7L3F2XapT6FmSoqs
        xs3E3/pHGXYNvVxRZ3blqBNRs9BW6nA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-rsNqqJRNMAyf0BjdG38IcA-1; Wed, 04 May 2022 05:28:11 -0400
X-MC-Unique: rsNqqJRNMAyf0BjdG38IcA-1
Received: by mail-wr1-f69.google.com with SMTP id s8-20020adf9788000000b0020adb01dc25so185724wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QiHfuXpjUO1Kx7oSpMgn+KkNUM21let3MfJCKQvBKl4=;
        b=Dr3gyDq8whJKSuqfxqXqaUrAl7rTxyTjj0VIB+glhZdjV3bSnrEwpvTquJwx03AiyX
         iif9PDiK5yRH8e5UnUR/Jnhs9yyz27QvxZcld1ounSa+aYuYJEx7x7O1md7UBsVeX/Kg
         nuM8pQUDg00oU6IWekdj8SnB8i1rqmgHa16WP2/+h8fXfVEfJ4So9XtTtSuXi3WEU14p
         PgZdWVQGjrgU6sMi1LufXmN9CwpLWlBRGJD7eO07VBbTEtJ7kU6MpEmd19ixb/9G/dXS
         bn7srW6HaUoB9EHsE1Jb/DVfvKr999RKpJp5Mq7MYoaieHIR30GTO/lTjm/GQSLAYfVw
         UBNQ==
X-Gm-Message-State: AOAM532wzMujHSuoLmLguoOSBRs0o5PAmSVMZ7NtDwsNTq9nix9b5hQL
        m5Tnv1905SlPxCkIOsfLqioWZiW7Af/djHu7rkiTrmX/9FxJYh1yCy64IaaaXE7oQUKsifU5cJZ
        MfXe/kmpBf0tae4DfgXzBJikcjKNvBjSKHZ/WA+M1jc+C8EkTtZrXOnndsD0ofUIrDd71gGB2z2
        8=
X-Received: by 2002:a05:600c:3b85:b0:393:edbb:ab9d with SMTP id n5-20020a05600c3b8500b00393edbbab9dmr6913228wms.126.1651656489583;
        Wed, 04 May 2022 02:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO3DLL2UeA2DZ+PW0v7ebQsybxG7YXPPfUWTKRUpRPBprerOB67LepYluV2171Xt8UBvnI7Q==
X-Received: by 2002:a05:600c:3b85:b0:393:edbb:ab9d with SMTP id n5-20020a05600c3b8500b00393edbbab9dmr6913196wms.126.1651656489202;
        Wed, 04 May 2022 02:28:09 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j30-20020adfb31e000000b0020c5253d8c2sm10915423wrd.14.2022.05.04.02.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 02:28:08 -0700 (PDT)
Message-ID: <038f8365-b23b-9d81-f7b2-8f8c6eb3a065@redhat.com>
Date:   Wed, 4 May 2022 11:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220503201934.681276-1-javierm@redhat.com>
 <YnJBGpvlViLV+0/a@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnJBGpvlViLV+0/a@phenom.ffwll.local>
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

Hello Daniel,

On 5/4/22 11:02, Daniel Vetter wrote:
> On Tue, May 03, 2022 at 10:19:34PM +0200, Javier Martinez Canillas wrote:
>> A reference to the framebuffer device struct fb_info is stored in the file
>> private data, but this reference could no longer be valid and must not be
>> accessed directly. Instead, the file_fb_info() accessor function must be
>> used since it does sanity checking to make sure that the fb_info is valid.
>>
>> This can happen for example if the registered framebuffer device is for a
>> driver that just uses a framebuffer provided by the system firmware. In
>> that case, the fbdev core would unregister the framebuffer device when a
>> real video driver is probed and ask to remove conflicting framebuffers.
>>
>> Most fbdev file operations already use the helper to get the fb_info but
>> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
>>
>> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
>> exported. Rename it and add a fb_ prefix to denote that is public now.
>>
>> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Note that fb_file_info is hilariously racy since there's nothing
> preventing a concurrenct framebuffer_unregister. Or at least I'm not
> seeing anything. See cf4a3ae4ef33 ("fbdev: lock_fb_info cannot fail") for
> context, maybe reference that commit here in your patch.
>
> Either way this doesn't really make anything worse, so
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Yes, I noticed is racy but at least checking this makes less likely to
occur. And thanks, I'll reference that commit in the description of v3.

BTW, I also noticed that the same race that happens with open(),read(),
close(), etc happens with the VM operations:

int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
{
...
	vma->vm_private_data = info;
...
}

static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
{
...
	struct fb_info *info = vmf->vma->vm_private_data;
...
}

static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
{
...
	struct fb_info *info = vmf->vma->vm_private_data;
...
}

So something similar to fb_file_fb_info() is needed to check if
the vm_private_data is still valid. I guess that could be done
by using the vmf->vma->vm_file and attempting the same trick that
fb_file_fb_info() does ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

