Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB9B5205AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiEIUKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiEIUIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4714624C772
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652126638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qnTkUabpe7jRtYxC0JIcCJ58YEOMuCVoeEj+uJ3yZCs=;
        b=ffaf+7wK9QoI4AbYp1eHqccbyPrvVEMWFBZ6X5kGDd0PR6VVwANw50EAoKd6uIhMuyJJd5
        x67BtqFc8HedrjTdARDnnXI2pUFRvDdARjgJSA79iguqocBps9Vwq7gTczDvEUa76se5MF
        Ao92PIIykLCYxomM2PEYPM4nbiXu7zk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-Eb50HacwMqGX_gcIG83toQ-1; Mon, 09 May 2022 16:03:49 -0400
X-MC-Unique: Eb50HacwMqGX_gcIG83toQ-1
Received: by mail-wr1-f72.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso6199503wrp.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 13:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qnTkUabpe7jRtYxC0JIcCJ58YEOMuCVoeEj+uJ3yZCs=;
        b=S1K35K5Y1Nx9eaF4nJGMNOxxes0B3WKAG31rZ3joHgOcgw1FT9WsyQBn2VB+Rp1pxJ
         cVgThd/niV6766iB/D4JTHa34FOyru+iTuPRbiDfMLUA/O2zbsAwLiSU6sjWewUZkr8B
         xNGfi7jo2HfEKa9m/XsLYmAQDTBFeMLtJtJVlvwabMCz2zCD+5GUsph4vC6L2w1vux48
         mY4465FDLmmCb8vCD2sgfuM6E8FW5t96gm9Rk524OI+R9jv7bhVWRtDfjQZo4ORUIkFt
         a+WvBtpGvnC/3/SYlDYk5e1AD9vsIH0tnfAYj+/1urrGvkyoVj14WuBa6Yg5ZFnmzxqB
         nryQ==
X-Gm-Message-State: AOAM532/sz20I3tkRa/wSf19YRMgcI8U8EC5poW4BQHwDbVzsZB1cSZq
        l/ETzj2N7AJkhc9zBDkuThdQc5Xn4UKpeu50IMym24Gn8hFX7R44Z4hsVOEmklmdjrovzaUnwrJ
        FlRFa2w56KgJD1otlf+lBIX2U
X-Received: by 2002:a05:600c:ada:b0:394:30f0:5b24 with SMTP id c26-20020a05600c0ada00b0039430f05b24mr17757041wmr.57.1652126628241;
        Mon, 09 May 2022 13:03:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXbnXq4q4M+gBT0G+FQfJ/08vE6H+CMK+PCG9aU5sZFTb8/Iev3kbWSsbfQd4TXLWBeAhjBA==
X-Received: by 2002:a05:600c:ada:b0:394:30f0:5b24 with SMTP id c26-20020a05600c0ada00b0039430f05b24mr17757018wmr.57.1652126627950;
        Mon, 09 May 2022 13:03:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k8-20020adfd848000000b0020c5253d8dbsm11555562wrl.39.2022.05.09.13.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 13:03:47 -0700 (PDT)
Message-ID: <2bf27b09-0896-1849-254f-d5b19abdc892@redhat.com>
Date:   Mon, 9 May 2022 22:03:46 +0200
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <b5ab1c49-04e7-36c3-677d-2989b79e50ca@suse.de>
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

On 5/9/22 20:12, Thomas Zimmermann wrote:

[snip]

>> I actually thought about the same but then remembered what Daniel said in [0]
>> (AFAIU at least) that these should be done in .remove() so the current code
>> looks like matches that and only framebuffer_release() should be moved.
>>
>> For vesafb a previous patch proposed to also move a release_region() call to
>> .fb_destroy() and Daniel also said that it was iffy and shouldn't be done [1].
>>
>> But I'm also not fb expert so happy to move fb_dealloc_cmap() as well if that
>> is the correct thing to do.
> 
> The cmap data structure is software state that can be accessed via icotl 
> as long as the devfile is open. Drivers update the hardware from it. See 
> [1].  Moving that cleanup into fb_destroy seems appropriate to me.
> 

I see, that makes sense. Then something like the following instead?

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d265a73313c9..ce0d89c49e42 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -627,12 +627,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
        cancel_work_sync(&fb_helper->resume_work);
        cancel_work_sync(&fb_helper->damage_work);
 
-       info = fb_helper->fbdev;
-       if (info) {
-               if (info->cmap.len)
-                       fb_dealloc_cmap(&info->cmap);
-               framebuffer_release(info);
-       }
        fb_helper->fbdev = NULL;
 
        mutex_lock(&kernel_fb_helper_lock);
@@ -2111,7 +2105,11 @@ static void drm_fbdev_release(struct drm_fb_helper *fb_helper)
  */
 static void drm_fbdev_fb_destroy(struct fb_info *info)
 {
+       if (info->cmap.len)
+               fb_dealloc_cmap(&info->cmap);
+
        drm_fbdev_release(info->par);
+       framebuffer_release(info);
 }
 
 static int drm_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

