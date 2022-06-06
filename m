Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D679153E674
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiFFNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiFFNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77B8C9CF37
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654522825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qoXnoqYpBHw1hBc7oMi8KrfARACS0m8xSrOHvWHVRQ=;
        b=UtO+g8ZJN8gyRWuFORByS89SnT3I5ZCPG8o9kLEjUSdK9+Wb9uSZqrImkphWqTHMT7xJzO
        VIY3d4uZcXqEAn4R5UdnWcuMQnQpwoadtL4HXiE+MYv1G6CdK1HaC8QO3roksETVdtzE2m
        vBnlK0xb/13olPaVP9KUqr/+VzxqAco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-JK7SlUnvO_Gavfv36vCWpw-1; Mon, 06 Jun 2022 09:40:24 -0400
X-MC-Unique: JK7SlUnvO_Gavfv36vCWpw-1
Received: by mail-wm1-f70.google.com with SMTP id ay1-20020a05600c1e0100b0039c3a3fc6a4so4799044wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8qoXnoqYpBHw1hBc7oMi8KrfARACS0m8xSrOHvWHVRQ=;
        b=XiNZsw2PA32DMkB5hBPtFjq6gi2EhJAV1gsOBtE3jNH8HQ3yRPSfghqU+pfGDNlDnj
         UBZqj2BhrKIe+S/VnBDO1NB/MdHFz7rwF82fNdnHBbm+tT7KOKAxMPx8AwuAXloLpY0O
         OLsKqgImfJ5kNLXU24pwEat96V7EuivBpDz/uxZnJkSueB9SaIWspibdxZqhE9lZRryg
         2jyX9PAUQjhQx4GDarKJRd2uibzOAb7opJCa1BlqbBLOzXBrjgi9zdbDqN+PZSD2ZctO
         Tyb+KEO7NitPda1i9wsEk9In65G1HNU00YanuKbn2rU4pjxuSq/L4LcgVuLhWHT3qUTU
         mk+Q==
X-Gm-Message-State: AOAM532B0q2xGgeS0231g0OnP6S40+fuC1jn4tNVdfseFNTz+uVB/gAF
        bDyBBarq3ZPly4vTy3bJn/4zT9rrmFeaIaB/ze8qe2TIy/IXYaRLvbxgQucOjWtvlj0D0aYW3sR
        4DDyYPb9MXHX0wCAJmc4IExuu
X-Received: by 2002:adf:f403:0:b0:218:82e:4c9e with SMTP id g3-20020adff403000000b00218082e4c9emr6360624wro.247.1654522822988;
        Mon, 06 Jun 2022 06:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZVdyGqAyzV/vlvckyOLNGFcL34R33cBgwYqi3lWgUaeO7ZYsoldrhJ+J93QvdRXiow3GN5g==
X-Received: by 2002:adf:f403:0:b0:218:82e:4c9e with SMTP id g3-20020adff403000000b00218082e4c9emr6360601wro.247.1654522822756;
        Mon, 06 Jun 2022 06:40:22 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020adfa4c6000000b0020fe61acd09sm16056329wrb.12.2022.06.06.06.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:40:22 -0700 (PDT)
Message-ID: <cbef78d3-c392-37e6-afdd-177806dfb033@redhat.com>
Date:   Mon, 6 Jun 2022 15:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220606095516.938934-2-jose.exposito89@gmail.com>
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

Hello José,

On 6/6/22 11:55, José Expósito wrote:
> Test the conversion from XRGB8888 to RGB332.
> 
> What is tested?
> 
>  - Different values for the X in XRGB8888 to make sure it is ignored
>  - Different clip values: Single pixel and full and partial buffer
>  - Well known colors: White, black, red, green, blue, magenta, yellow
>    and cyan
>  - Other colors: Randomly picked
>  - Destination pitch
> 
> How to run the tests?
> 
>  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
>          --kconfig_add CONFIG_VIRTIO_UML=y \
>          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> 
> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> ---

Thanks for addressing the issues pointed out. Patch looks good to me now.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

By the way, I think you should request an account [0], so that you can push
patches to drm-misc directly. Specially since AFAIU the plan is to add more
KUnit tests in future patch series.

[0]: https://www.freedesktop.org/wiki/AccountRequests/

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

