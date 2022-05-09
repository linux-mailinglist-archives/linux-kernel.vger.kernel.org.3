Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C7520281
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiEIQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiEIQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41FFC28ED29
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652114030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaU6wCec1EMQuT5ULCUqY7NTQ3dkhl3bP6/9uWSpRY0=;
        b=KY3Hw9tEznsUne+dQbBXq+/NoEr3RtIr45zdpDnhxNaNjvbkpYfmtVoat3P62HT89qp0xh
        I1Fll234+M1PZrItQgFBQeTaMVGm3Kwl2agyqP4DeHF9GLAqI2WyjLCMXL0kriLLzwnGwO
        KLMHEL1t6qIQRPzEOHjdEGax8pzIAyA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-nwg_L9_6PgK-3G5k03uY-g-1; Mon, 09 May 2022 12:33:48 -0400
X-MC-Unique: nwg_L9_6PgK-3G5k03uY-g-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso10114521wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zaU6wCec1EMQuT5ULCUqY7NTQ3dkhl3bP6/9uWSpRY0=;
        b=oC1YBqijEQZbhv+YRVRsy4AaJYyY8I+zllF5RFKEDFOtOmsD1TzV9CMcOBewMN7wS5
         HOciMPNzqUEBpY2ZDfY+vpviXGj9KYlf9ShJsPKDaHoGIDfLFAAc5odtak1mid7PKE/T
         XfzCNmfbKbBe0oekjHJibszGhH56+ATJtUhLs1+FmOFTPQUECSUwjmHrryFK2DdW32ax
         /8v7ZftweLDqz2maIeXUMPjqkMz+wnrqR/hIxhUKpld0YdEdAUwAugM0pefEVjueMmlD
         9s6WzhMz5w+8RvaPUOKSZDaQbdb4TqAcAbaHlMhHvE+80tQmBsryXx4w5P9YarkMsMot
         ML/g==
X-Gm-Message-State: AOAM533bFgzkwKr3NJUdoIC5otzdvodeFzTFVviCNYSeLQQh5E2rYfLs
        im5Cvmz/9/TLRDIBiwI6eFPwZtkXy50u9Nj3FcBHOR2cq4BP29XOAprVPhqKjQx7+BD4Uu1naEX
        6WyeLxLC53ICF2sVYajuosfsx
X-Received: by 2002:a7b:c3c2:0:b0:394:9229:3b40 with SMTP id t2-20020a7bc3c2000000b0039492293b40mr5126308wmj.195.1652114027776;
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7bKnj6TnYeYMJ8WQEUK1qVaIvYRO7Ss8XM5JhYhOquufFe51hhnCGnSjqUxw1TY5t+U+8cQ==
X-Received: by 2002:a7b:c3c2:0:b0:394:9229:3b40 with SMTP id t2-20020a7bc3c2000000b0039492293b40mr5126294wmj.195.1652114027554;
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d6883000000b0020c5253d91asm11484506wru.102.2022.05.09.09.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
Message-ID: <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
Date:   Mon, 9 May 2022 18:33:46 +0200
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
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
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

On 5/9/22 17:51, Andrzej Hajda wrote:

[snip]

>>>> +
>>> Regarding drm:
>>> What about drm_fb_helper_fini? It calls also framebuffer_release and is
>>> called often from _remove paths (checked intel/radeon/nouveau). I guess
>>> it should be fixed as well. Do you plan to fix it?
>>>
>> I think you are correct. Maybe we need something like the following?
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index d265a73313c9..b09598f7af28 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
>>          if (info) {
>>                  if (info->cmap.len)
>>                          fb_dealloc_cmap(&info->cmap);
>> -               framebuffer_release(info);
> 
> What about cmap? I am not an fb expert, but IMO cmap can be accessed 
> from userspace as well.
> 

I actually thought about the same but then remembered what Daniel said in [0]
(AFAIU at least) that these should be done in .remove() so the current code
looks like matches that and only framebuffer_release() should be moved.

For vesafb a previous patch proposed to also move a release_region() call to
.fb_destroy() and Daniel also said that it was iffy and shouldn't be done [1].

But I'm also not fb expert so happy to move fb_dealloc_cmap() as well if that
is the correct thing to do.

[0]: https://www.spinics.net/lists/dri-devel/msg346257.html
[1]: https://www.spinics.net/lists/dri-devel/msg346261.html

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

