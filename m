Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7B520122
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiEIPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiEIPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 134BF10275B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652110230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32O50jez/PbrMF8EQrDMnibyIcUmfYiL4OMerJWfOrc=;
        b=EklfuR4UegZe3InuUHBcWmkfSZgZrLQ7xRLdVJbck/qfzlKBNiRCX6omqg/jS7LNAkwO3c
        Q5xn3B5oUra7RVaRbBl1q3sQm2rOcTJHRF5bdDHn1hN6ptvjD2BeIC1RASNQqOJCKVabij
        86NbhqS63wHOkJ+ZIfYZKM/WumENWjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-w-0OWGr8NbavJ8oRc6r2KA-1; Mon, 09 May 2022 11:30:26 -0400
X-MC-Unique: w-0OWGr8NbavJ8oRc6r2KA-1
Received: by mail-wr1-f71.google.com with SMTP id v29-20020adfa1dd000000b0020ad932b7c0so5896875wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=32O50jez/PbrMF8EQrDMnibyIcUmfYiL4OMerJWfOrc=;
        b=5rzmbR34DyphNuiB4CRFwtq22El3x5ym5SE4HaLI9ndU6rOMUKpMlF0AGDaqhi4/7a
         kaNczkTWXCMEEFvlT8YdAkcj77PwcMmtgCAbMFnwm0E+3CUNrJ2vwuz1o7lGlRZ9Xvk1
         oqU5yQWwDdZyJN5WtTYcG1nR5e/NLWWDNhHhIUxKoR5wrWDUUIH6axnj/fWChzq8nO9y
         Npa890VmOStHdwwrEw3M+4m/j9lRVo27Rfu83CStgpQ3kF9QnNEFWUPfRzGC1KPmDS/+
         T8ogOkOR5X3iemWTRLVmoD5x+9yqMBDiSkIFQex5yog7//nKOKBb4mxzS/5aI4+bk8Gf
         Oj7A==
X-Gm-Message-State: AOAM531oBP6dPGqxuXDp9Lw3kzteDR2LZVBD6H7od/M4vU4oq3kmjWxg
        /SLg4AuMM88y6wH7+TMJfkYskXhpCPBB/C3nF+JSpokVFOaAxs2XFGvNNoSbea6K6Ko5rZQu+AP
        /WQrR+4UV/GdUyS9u6IDkKTQV
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr23110374wmc.160.1652110225682;
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2OJQhUhbDP19T1Ygw1cNWeWjH+vy1pamLfQvh45VT2yujXYJ3AxWzNA16UgHpJIS114J32Q==
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr23110328wmc.160.1652110225343;
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b0020c5253d903sm11552799wrv.79.2022.05.09.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
Message-ID: <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
Date:   Mon, 9 May 2022 17:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrzej,

On 5/9/22 16:56, Andrzej Hajda wrote:
> On 06.05.2022 00:04, Javier Martinez Canillas wrote:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Most fbdev drivers have issues with the fb_info lifetime, because call to
>> framebuffer_release() from their driver's .remove callback, rather than
>> doing from fbops.fb_destroy callback.
>>
>> Doing that will destroy the fb_info too early, while references to it may
>> still exist, leading to a use-after-free error.
>>
>> To prevent this, check the fb_info reference counter when attempting to
>> kfree the data structure in framebuffer_release(). That will leak it but
>> at least will prevent the mentioned error.
>>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/video/fbdev/core/fbsysfs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
>> index 8c1ee9ecec3d..c2a60b187467 100644
>> --- a/drivers/video/fbdev/core/fbsysfs.c
>> +++ b/drivers/video/fbdev/core/fbsysfs.c
>> @@ -80,6 +80,10 @@ void framebuffer_release(struct fb_info *info)
>>   {
>>   	if (!info)
>>   		return;
>> +
>> +	if (WARN_ON(refcount_read(&info->count)))
>> +		return;
>> +
> 
> Regarding drm:
> What about drm_fb_helper_fini? It calls also framebuffer_release and is 
> called often from _remove paths (checked intel/radeon/nouveau). I guess 
> it should be fixed as well. Do you plan to fix it?
>

I think you are correct. Maybe we need something like the following?

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d265a73313c9..b09598f7af28 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
        if (info) {
                if (info->cmap.len)
                        fb_dealloc_cmap(&info->cmap);
-               framebuffer_release(info);
        }
        fb_helper->fbdev = NULL;
 
@@ -2112,6 +2111,7 @@ static void drm_fbdev_release(struct drm_fb_helper *fb_helper)
 static void drm_fbdev_fb_destroy(struct fb_info *info)
 {
        drm_fbdev_release(info->par);
+       framebuffer_release(info);
 }
 
 static int drm_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)

> 
> Regarding fb drivers, just for stats:
> git grep -p framebuffer_release | grep _remove | wc -l
> Suggests there is at least 70 incorrect users of this :)
>

Yes, Daniel already mentioned that most of them get this wrong but I was
mostly interested in {simple,efi,vesa}fb since are used with "nomodeset".

But given that I only touched those tree and still managed to introduce
a regression, I won't attempt to fix the others.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

