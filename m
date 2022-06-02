Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641053BD5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiFBR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiFBR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76BED255BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654190988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBTeWiiYW/rW3MZsHyTxu/jl9RRbd9h3yH+yLfy453k=;
        b=FDJwOtEuouwephBXnUZRVS9dQ6eem8AKvcrZbCNJ87HsjqdqciypVKimtRIxnFzi9umx8q
        AUwvSSo+/OYQnKOsqcPSJjjSau+jdp8bGgv6V4IyLUUHlxDKZel8mAlGtYI+i+mr++oZx8
        Gr5RIttOrRr0LE058Ka/s1s58lqAVRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-krzoMsm-OY2uaDPQZYTgFw-1; Thu, 02 Jun 2022 13:29:47 -0400
X-MC-Unique: krzoMsm-OY2uaDPQZYTgFw-1
Received: by mail-wm1-f70.google.com with SMTP id m31-20020a05600c3b1f00b003973a563605so2698504wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 10:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dBTeWiiYW/rW3MZsHyTxu/jl9RRbd9h3yH+yLfy453k=;
        b=zEZpbATxP0Ey504CBrahg7WJHDVDK0TzMAcL6mypbmbYtEuI5PfxfxSsmd764atdmF
         Cwbys2KBuxbUmb9NrB+hVbz6KKfRgm0P65iW6vbV+YNMeP6UONLecufysmouB0Mj4tdU
         3ADg/4s/6Kc4R8USK51VijaHC9KpomoSd2MY1Ya5shjgWXDpG+k03Hsn5tKtITPcwRI/
         UIZ1/bkPO2g1rM7uCVIaSuz7WlVNcn6gXSZAcAFs9upfM08HFvHerUpDxAjJyJQJQ1vz
         qsC5zZdWKCbLvEHywysNRWH7zKGcQnOt93uRKDdtUtOIG8Q1Vjob83ndUg41vsZ/TInt
         AzMQ==
X-Gm-Message-State: AOAM533E/vV4VCoMFZV2V8oEB/oUCSYCrnE2Qmr9K9BfbhnelZV/wadX
        veM78QPpGAE5WFcjsR8ewJNk8BmmgwFQJELeN1ln7X4fDegmMnv6vlNXXA3f5MUBaIXop2I9rnp
        +ZD278c3aliNTZVFXasKQdiuc
X-Received: by 2002:a05:6000:1d9e:b0:20f:fb42:4b38 with SMTP id bk30-20020a0560001d9e00b0020ffb424b38mr4547017wrb.268.1654190986236;
        Thu, 02 Jun 2022 10:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3RaBnbtgePjQfMXYRB7quw1mFYOf0GfERhyY4/DG9GKach7FhKYe8GN4LYEptHWxBQRhgmQ==
X-Received: by 2002:a05:6000:1d9e:b0:20f:fb42:4b38 with SMTP id bk30-20020a0560001d9e00b0020ffb424b38mr4546999wrb.268.1654190986044;
        Thu, 02 Jun 2022 10:29:46 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003973c54bd69sm10976449wmq.1.2022.06.02.10.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 10:29:45 -0700 (PDT)
Message-ID: <fea8f80a-939b-2c73-d94b-5179d1e65be9@redhat.com>
Date:   Thu, 2 Jun 2022 19:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        KUnit Development <kunit-dev@googlegroups.com>,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com>
 <20220530131158.kqq2mohxoh52xpeg@penduick> <20220530162903.GA6546@elementary>
 <CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 19:12, David Gow wrote:
> On Mon, May 30, 2022 at 9:29 AM José Expósito <jose.exposito89@gmail.com> wrote:

[snip]

>>
>> A .kuniconfig example is present in the cover letter. (...)
>
> FYI: it's also possible to run these tests under UML with the extra options:
> CONFIG_VIRTIO_UML=y
> CONFIG_UML_PCI_OVER_VIRTIO=y
>

Oh, very interesting. I didn't notice before that his example had --arch=x86_64

> I suspect it's probably better not to add those to your .kunitconfig,
> as they're UML-specific and will therefore break other architectures,
> but it does mean the tests can be run with, for example:
> 
> ./tools/testing/kunit/kunit.py run --kunitconfig
> drivers/gpu/drm/.kunitconfig --kconfig_add CONFIG_VIRTIO_UML=y
> --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> Or, without the .kunitconfig:
> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_DRM=y
> --kconfig_add CONFIG_DRM_FORMAR_HELPER_TEST=y --kconfig_add
> CONFIG_VIRTIO_UML=y  --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> 'drm-*'
>

I wonder if would make sense to have for example an arch/um/.kunitconfig
with those symbols and maybe others and then the tests could also be run
with something like:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig \
--kunitconfig=arch/um/.kunitconfig

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

