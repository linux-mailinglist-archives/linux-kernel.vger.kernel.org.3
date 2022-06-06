Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA153E93E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiFFN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiFFN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36BBD22B04
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654523871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0VC7WDZcQaB0QeUnzxfKz7gfxnXoY+3H1Ie1KFzEnk=;
        b=JMA8dlpMX208KdaLaydlAUtha9zDf9S6mAxe0grEFUPu1+iUkt+Ma0+e2zAzRS2dN8hclB
        mPICLqGpuVWNT/JP5lWcB73L4jPPvLHcCEYD4pknTDF+DgcdN1lfTagJwhn1KkzOgQPOVR
        2tVoV8+5erhN6y4yLZ0MmK0P+92+mCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-04EIlHrOPquhZgFRbpu-ig-1; Mon, 06 Jun 2022 09:57:49 -0400
X-MC-Unique: 04EIlHrOPquhZgFRbpu-ig-1
Received: by mail-wr1-f72.google.com with SMTP id o18-20020a5d4a92000000b00213b4eebc25so2195140wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/0VC7WDZcQaB0QeUnzxfKz7gfxnXoY+3H1Ie1KFzEnk=;
        b=rI9gzJesNKELvJHAqDu5lVCCzKmmo4ITgTA58BHzNOwLyU2B4bcZDYmdXqvLxW+q23
         IvdOFOtkooECJ5FuWdcn+5++GSuhoUM2sHmkh7yY6lvphhM4cZcIwzQmrfyVUdGYBlqM
         PGdGH8h0FsfRJzsIq+PUOqk+8FySWVHdBij7X2qQzsCPeRBKyQTkYlIYDV2PXEHhS9Pi
         2sFxaS3qLs2lB9FhCblrJxS6idDiFNMIQjAC5du3SuKJl+PlcSM6N6DOiHGSF9+nfCY9
         Uu9ZaxIPd6PJXcuf/n8rQSiDzpYBpRkATfBXZFAJou99LN9BUTBTNcNLQsV3Ld58ryX5
         Xp9w==
X-Gm-Message-State: AOAM530Q/HlIoV9upSuiC452LNBVCv5KwtIUZvPEJTPJHjY6FdkDhyav
        /DKHPS83hAC9lhFCbruOMJ8yV2acwMN88CP3BgjvlLqyV0KI5o1gi8OwU6cMB9eMOTeHXq5RUYV
        XeNZKstvPkN30gDq9BYq3EBPZ
X-Received: by 2002:a05:6000:156c:b0:210:4a6a:16bb with SMTP id 12-20020a056000156c00b002104a6a16bbmr22136541wrz.245.1654523867416;
        Mon, 06 Jun 2022 06:57:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9YW7NYiKilW7zDGyVtf/GWRLG+UOJzXr7htfeXNK9ImAjKSBTXLgU1FFEZIpGTV7JYmZjbg==
X-Received: by 2002:a05:6000:156c:b0:210:4a6a:16bb with SMTP id 12-20020a056000156c00b002104a6a16bbmr22136508wrz.245.1654523867196;
        Mon, 06 Jun 2022 06:57:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w25-20020a1cf619000000b003976fbfbf00sm17882402wmc.30.2022.06.06.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:57:46 -0700 (PDT)
Message-ID: <78c1eb65-ea78-8744-5382-ea86a56a66f4@redhat.com>
Date:   Mon, 6 Jun 2022 15:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
 <20220606134242.h6kuqn4zbpmc2rql@houat>
 <576ed6ef-b961-9214-2c9b-56cb5b493b4e@redhat.com>
 <20220606135219.nwhp4fdawg2qjeam@houat>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220606135219.nwhp4fdawg2qjeam@houat>
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

On 6/6/22 15:52, Maxime Ripard wrote:
> hi,
> 
> On Mon, Jun 06, 2022 at 03:49:57PM +0200, Javier Martinez Canillas wrote:
>> Hello Maxime,
>>
>> On 6/6/22 15:42, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Mon, Jun 06, 2022 at 11:55:16AM +0200, José Expósito wrote:
>>>> Test the conversion from XRGB8888 to RGB332.
>>>>
>>>> What is tested?
>>>>
>>>>  - Different values for the X in XRGB8888 to make sure it is ignored
>>>>  - Different clip values: Single pixel and full and partial buffer
>>>>  - Well known colors: White, black, red, green, blue, magenta, yellow
>>>>    and cyan
>>>>  - Other colors: Randomly picked
>>>>  - Destination pitch
>>>>
>>>> How to run the tests?
>>>>
>>>>  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
>>>>          --kconfig_add CONFIG_VIRTIO_UML=y \
>>>>          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
>>>
>>> It's not clear to me why you would need VIRTIO here? The Kunit config
>>> file should be enough to run the tests properly
>>>
>>
>> It's needed or otherwise KUnit will complain with:
>>
>> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig
>> [15:47:31] Configuring KUnit Kernel ...
>> Regenerating .config ...
>> Populating config with:
>> $ make ARCH=um O=.kunit olddefconfig
>> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>> This is probably due to unsatisfied dependencies.
>> Missing: CONFIG_DRM=y, CONFIG_DRM_KUNIT_TEST=y
>> Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".
>>
>> The following works correctly but it won't use User Mode Linux:
>>
>> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig --arch=x86_64
> 
> But then, can't we add them to .kunitconfig?
>

That's what I asked in the previous RFC too. Daniel mentioned that it shouldn't
go there because is platform specific (AFAIU, one might want to test it on x86,
aarch64, etc) but then I asked why we couldn't have a arch/um/.kunitconfig.

The answer was that's not that simple and some agreement on how to do it is needed:

https://lists.freedesktop.org/archives/dri-devel/2022-June/357617.html

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

