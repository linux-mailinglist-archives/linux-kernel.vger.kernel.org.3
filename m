Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43553BD4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiFBRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiFBRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB66421F99F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654190492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkWLRL2btcOuYEbOqP+XTrwGTww6RFdHa8AA7224PiA=;
        b=eqUAXRP7k88+zmKp7gQNEl4gxV6JMsXHpZiFaf7uD8YPkajXcbpIYamND/2U91uqbdMGSp
        SNhfJab+EdHo6hceuoFqamU4Ymfjzat7MPmZlTjqHqJLpvH1quPnl9hde6e7+sUwsdbNVM
        v9MOq3J4iANWLmy49JrmFKLpdl524bU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-L_7n0X49Mju_F5BKxvV9QA-1; Thu, 02 Jun 2022 13:21:31 -0400
X-MC-Unique: L_7n0X49Mju_F5BKxvV9QA-1
Received: by mail-wm1-f70.google.com with SMTP id k7-20020a05600c1c8700b003974d762928so2693811wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 10:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkWLRL2btcOuYEbOqP+XTrwGTww6RFdHa8AA7224PiA=;
        b=xJHkXx/KAwySj/3nnHp/7S8JzyvfuLVZ3eNAcQVIBJ+wo/5dJ9rjVGmWxH7yqoP5th
         L9GIOHsIMSIRD3rpCcQ0SLwqG/NjuXQ/e/ZKsSw8qGBiyGr2SKAp2Qwa8EiLeOS7/LYr
         qHOkZaBpKwZgeSA1T8dxHBJKLpz2cBzcneAIgCcxpFjAxytDXsfhC4XpRvHPiKErBRPE
         5SfCTOOEap0J8VGG1Kir6f7HGmoyO1kAbkKyrqSz4oN770eF7I3i3Cjng/dyaxgTbjgL
         T1ZOunpTv2Y8jYSugVQBgrukHvSXw9ncZj7xLi2ZNqc1df2ibmgdbZxl3auN7hL8APZF
         5ncw==
X-Gm-Message-State: AOAM532xOXeip7aJE58GCBRfQUyCDEOf1JhtQKy1w7YTFNV/8VWJaXD5
        PTM7m2uLuIvLI57QJmshEiSQ1Qs1nUsAj5YBDofGO0hWLqoi4DrQoyuM5++JNSWiUM7hJjnQJni
        yEq+NrjNapY5k1E3RluYHAzKs
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr34805615wmi.67.1654190490152;
        Thu, 02 Jun 2022 10:21:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfb60ZuTiGga+Bjp8S2I84M/UXb4TC42fVW3h9HcsF2pfLSR34C0NgiuM41gBgcWb82UUXcA==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr34805587wmi.67.1654190489891;
        Thu, 02 Jun 2022 10:21:29 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d69c8000000b002102b16b9a4sm4963168wrw.110.2022.06.02.10.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 10:21:29 -0700 (PDT)
Message-ID: <195c6865-d6f7-fbc4-6ee5-784c5c49d243@redhat.com>
Date:   Thu, 2 Jun 2022 19:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com>
 <e26de140-afb7-7b1b-4826-6ac4f3a4fe02@redhat.com>
 <CABVgOSkCxu2xBnxwc6mO2AQaqzTbDf53PJzT2QvZNyLeumt5hg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CABVgOSkCxu2xBnxwc6mO2AQaqzTbDf53PJzT2QvZNyLeumt5hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 6/2/22 19:07, David Gow wrote:
> On Thu, Jun 2, 2022 at 9:27 AM Javier Martinez Canillas

[snip]

>>
>> And doing that will also allow you to get rid of this, since just selecting
>> CONFIG_DRM_KUNIT_TEST=y would be enough for the tests built and run by KUnit.
>>
> 
> This is definitely something other KUnit tests (apparmor, elf, etc)
> are doing, and it's generally fine. You do lose the ability to build
> the tests as a separate module, though. (This is not usually a big
> problem, but there are some cases where it's useful.)
> 
> That being said, I don't think 'select' is enough of a problem that
> you should feel the need to refactor in this way just to avoid it.

Oh, yes I didn't want to imply that this was the main reason but just
pointed out that wouldn't even be needed if done that way. And it is
something that we want to do anyway IMO, since as mentioned it would
allow to test the static functions, which are the majority the format
helpers in that file.

> Given most of the other DRM drivers (as well as DRM_DEBUG_SELFTEST)
> are select-ing DRM_KMS_HELPER, it seems like a sensible enough thing
> to continue doing for the KUnit test. As Daniel pointed out, as a
> hidden option it was clearly always meant to be select-ed anyway.
>

Yes, it can be done from the DRM_KUNIT_TEST symbol or just have it set
(and any other needed DRM helper libraries tested by other suites) in
the .kunitconfig file.

I don't think is that important, since at the end that dependency will
have to be maintained in some place.
 
> Cheers,
> -- David
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

