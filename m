Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405453EA3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiFFNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiFFNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA3DE10F379
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654523403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4qn3cjI7HqyUIxd4oKh+0A1P3k2mR1E2+5cIHyDYGM=;
        b=Y8aQlRby5WN0dqdtNJcXOEd2mZehiz9OrQp2UF/zt0A75H11h0N2uTD9zEs1xhzR13lf1j
        T9W/BXamHpoANCKhvXJCdcg8xvvOvdNfuT7L/0dgnOIC+cfvztga6r2SdFLLHj2uf+PZbk
        VIMTsvr2UKBeOu7z78QGsSyGnDpawnc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-nDj4Z9_VNeekF9UgFSdnzw-1; Mon, 06 Jun 2022 09:50:00 -0400
X-MC-Unique: nDj4Z9_VNeekF9UgFSdnzw-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so715323wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b4qn3cjI7HqyUIxd4oKh+0A1P3k2mR1E2+5cIHyDYGM=;
        b=Wyacrjc9EXBaTZ24hCm6RFutK/NPDATH0rLE52GkUPrOMJLO277TnsnNAjsSKfV8HT
         CuNGZaBfIiyKMaB5iZo6qH0WqqRHQir4QRyGLM6dsIJLOU/BGDJZOetBr+8HoWRBUjMF
         on29tIB2Q9hqvYyiMoZEwBnEmXv3+9ARUxueRQtSpvqZdAfRKmIPwiZMcvFeZdshpgDa
         tA2Vhc2wdWbNTovnI+toGH5/v0Tm62SIYdiTpme23L3ks+mQ2bpa9/jclIGv0RVSqnMF
         D6ftnaO5s3Nxb9H1OC3gQCJA7eCJwbOmzCR+Wu3VOB5K7a8VYOn1dwLv1gtAARZm1OkC
         vELw==
X-Gm-Message-State: AOAM531KktvPfCEOE/A9KDjXbSouVoNnNmJDy8GfGoja0NJ+7cW0Hqun
        R/072bJ/EJCO89OANIu/7NBjfPvvwe1vCfTq12BA6O2X6KhOJ0xtTbwfnGodQ9lHNaNsMa3Xulj
        MpCL1bGjOBjVzrC1SEvtBkXQS
X-Received: by 2002:a05:600c:19c8:b0:398:c5db:aeba with SMTP id u8-20020a05600c19c800b00398c5dbaebamr44023368wmq.199.1654523399303;
        Mon, 06 Jun 2022 06:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyWCdhmvcE0h6rwg+BogKrl/NSZO6bwH4Cl9p4VVAO3rw2D+6bzdBeNXYk7CexdL++HidvEA==
X-Received: by 2002:a05:600c:19c8:b0:398:c5db:aeba with SMTP id u8-20020a05600c19c800b00398c5dbaebamr44023339wmq.199.1654523399055;
        Mon, 06 Jun 2022 06:49:59 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d69c8000000b002102b16b9a4sm15245571wrw.110.2022.06.06.06.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:49:58 -0700 (PDT)
Message-ID: <576ed6ef-b961-9214-2c9b-56cb5b493b4e@redhat.com>
Date:   Mon, 6 Jun 2022 15:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
 <20220606134242.h6kuqn4zbpmc2rql@houat>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220606134242.h6kuqn4zbpmc2rql@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On 6/6/22 15:42, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jun 06, 2022 at 11:55:16AM +0200, José Expósito wrote:
>> Test the conversion from XRGB8888 to RGB332.
>>
>> What is tested?
>>
>>  - Different values for the X in XRGB8888 to make sure it is ignored
>>  - Different clip values: Single pixel and full and partial buffer
>>  - Well known colors: White, black, red, green, blue, magenta, yellow
>>    and cyan
>>  - Other colors: Randomly picked
>>  - Destination pitch
>>
>> How to run the tests?
>>
>>  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
>>          --kconfig_add CONFIG_VIRTIO_UML=y \
>>          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> It's not clear to me why you would need VIRTIO here? The Kunit config
> file should be enough to run the tests properly
>

It's needed or otherwise KUnit will complain with:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig
[15:47:31] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_DRM=y, CONFIG_DRM_KUNIT_TEST=y
Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".

The following works correctly but it won't use User Mode Linux:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig --arch=x86_64

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

