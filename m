Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F65246FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbiELH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350977AbiELH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:29:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB37813B8EA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:29:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so8390402ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6pAZCGyP8MKNDHSnHkp9Vkj/nq2Rx3C2O79znDA1ohY=;
        b=gxJRzrkmadF3F010BI/AMYnQC5Uyk0pnkL9ydptziONsEZn/T/Fbr536Bj0CqT43/F
         OE8wBqNbrMI1khevv0mxyHVfbDzMZ0KwNdeo/bIpVHajTT+EF0oDYf7N0VNN3eIe2c0O
         bJgEjttmuMaTQOa5J2uuTwyztqxfHYcUX2fk7ZNZB18NWHk4aV009x5qtgb8QqTLTAaS
         8y1to59ZLt6vcN6xaJxMesvLgIVpZbaUxsHo0IzdyH1F+HGrknc0It+VZabYdtbKbDlG
         oOIQGI+//4lh04gMHGLybH31m8u8DcH87bpUKK9AOmqcOMltr0HhDsM4I8CDWsx0WSDg
         fO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6pAZCGyP8MKNDHSnHkp9Vkj/nq2Rx3C2O79znDA1ohY=;
        b=Giy++5fhCF5Y/uTqegJv8zxjBGuVBpIcmJZHShdsOXkS520Z4kwdrRpSV8maEdkU8i
         3Xm+Vbx5swRG895Dr2/oUcYG3Xd09+llFS64sXRv+4tfPwtKYenU4MezcQU4mBTl9HWH
         USTygtUqI0/TorgEFsJBdVyLKQqpSdIHNgUIrXKrGU7Xsan32RaQ8OTQ0AWvvqr3lSeU
         lqMu0Md2qFfv0yObdzlYuwpG6vi6yoC6Qs0QGnLwEA/IgESeWD60k7GOh3ValS1Zkfwa
         ytODOJfdFZSndZo3IuxgWXoYg2XkMX9/93Js+9Qnc0Hd5KPYtuqcGFRAzhVntW0bjNc6
         wuBg==
X-Gm-Message-State: AOAM5303FxiWbOmwCdvCkmep9jHHMuf5jyvOBxBQgJAebfAi8XuzOAk8
        V20WLSG8UpZ9mXtifYxOy48=
X-Google-Smtp-Source: ABdhPJzmYNUvkYEksV5JP3JbnVmzNZnB1l4WyXgWPZVb+mOEjX9GxlW5bDRlUp4xgoD9wQN+D9XfMw==
X-Received: by 2002:a17:907:60d6:b0:6fa:95d3:d4e5 with SMTP id hv22-20020a17090760d600b006fa95d3d4e5mr13864164ejc.357.1652340578275;
        Thu, 12 May 2022 00:29:38 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea033.dip0.t-ipconnect.de. [91.14.160.51])
        by smtp.gmail.com with ESMTPSA id da26-20020a056402177a00b0042617ba63a5sm2274053edb.47.2022.05.12.00.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:29:37 -0700 (PDT)
Message-ID: <f6e42cfb-0252-1273-2ba3-76af818e0799@gmail.com>
Date:   Thu, 12 May 2022 09:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Stone <daniel@fooishbar.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <01506516-ab2f-cb6e-7507-f2a3295efb59@collabora.com>
 <YnOHAh9I1ds4+1J+@phenom.ffwll.local>
 <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
 <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
 <4d08b382-0076-1ea2-b565-893d50b453cb@collabora.com>
 <YnuziJDmXVR09UzP@phenom.ffwll.local>
 <56787b70-fb64-64da-6006-d3aa3ed59d12@gmail.com>
 <3a362c32-870c-1d73-bba6-bbdcd62dc326@collabora.com>
 <YnvWUbh5QDDs6u2B@phenom.ffwll.local>
 <ba2836d0-9a3a-b879-cb1e-a48aed31637d@collabora.com>
 <YnwI5UX/zvmnAHvg@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YnwI5UX/zvmnAHvg@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.05.22 um 21:05 schrieb Daniel Vetter:
> [SNIP]
>>>> It's unclear to me which driver may ever want to do the mapping under
>>>> the dma_resv_lock. But if we will ever have such a driver that will need
>>>> to map imported buffer under dma_resv_lock, then we could always add the
>>>> dma_buf_vmap_locked() variant of the function. In this case the locking
>>>> rule will sound like this:
>>>>
>>>> "All dma-buf importers are responsible for holding the dma-reservation
>>>> lock around the dmabuf->ops->mmap/vmap() calls."
>> Are you okay with this rule?
> Yeah I think long-term it's where we want to be, just trying to find
> clever ways to get there.
>
> And I think Christian agrees with that?

Yes, completely.

A design where most DMA-buf functions are supposed to be called with the 
reservation lock held is exactly what I have in mind for the long term.

>>>>> It shouldn't be that hard to clean up. The last time I looked into it my
>>>>> main problem was that we didn't had any easy unit test for it.
>>>> Do we have any tests for dma-bufs at all? It's unclear to me what you
>>>> are going to test in regards to the reservation locks, could you please
>>>> clarify?
>>> Unfortunately not really :-/ Only way really is to grab a driver which
>>> needs vmap (those are mostly display drivers) on an imported buffer, and
>>> see what happens.
>>>
>>> 2nd best is liberally sprinkling lockdep annotations all over the place
>>> and throwing it at intel ci (not sure amd ci is accessible to the public)
>>> and then hoping that's good enough. Stuff like might_lock and
>>> dma_resv_assert_held.
>> Alright
> So throwing it at intel-gfx-ci can't hurt I think, but that only covers
> i915 so doesn't really help with the bigger issue of catching all the
> drivers.

BTW: We have now somebody working on converting the existing 
libdrm_amdgpu unit tests over to igt.

Regards,
Christian.

>
> Cheers, Daniel

