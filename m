Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CAC56B9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiGHMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbiGHMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4982F8239A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657284188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncQ+KfyiHNfyVvOAGnrmlZhB6oXAdw/76/PZWEd53BA=;
        b=guLjz5Pz11EaKzv6ZhAtiSUA6h6jFgm8vlWrBqjq+ic28mo947FculfWFFVaeYo6wunqK+
        Fjd895I3bU+9BHGj/JPuvaj9UEPAGSyQmUMx8mx7B1+QEcofDhru3Bi4hYNUXClhkkDcKr
        pOMvXT38Kx62kbAAxjPYV5cH+uoSYP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-f7MrTGi2P2m13jZ6beE3YQ-1; Fri, 08 Jul 2022 08:43:01 -0400
X-MC-Unique: f7MrTGi2P2m13jZ6beE3YQ-1
Received: by mail-wm1-f71.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso3561631wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ncQ+KfyiHNfyVvOAGnrmlZhB6oXAdw/76/PZWEd53BA=;
        b=ix6ndZ+ueanO7iAMMJPdINJ1oE6as6+pdg47UK8ya5ZGPYTP9p/OEZqk5CdSC8x41K
         jfpVpxiw2JdwOfr8QhFqXtHQ8Vgq9wWyjl+VkTKKD22WT0v4UWA/zvFMbV3OcBfEl2n6
         fYzBY8s6HJ5zaujaEbXcGrpT66EqtyODY67x7QEhBXecgC2eWVu5QZUjcTqEKtT86ex5
         8OpA9PDW0PzSq7ZFHLJ3YZz/WIzp1CBrXFZfok/QYRWyOSuy7EFC7nNsg5Ko16cvGVeU
         R/mLEOCsaLw20gOOtZI7q8vsfHhCXyxIbeGJezF/nsAZ6SkBcvnstpDjIw7U/SLyZA5R
         PwIA==
X-Gm-Message-State: AJIora+LsFAavwP3IVvjV9qFgyEUI8BtGPQjSxu6zgyVaJnB+r2hfGUD
        BDmhKDrBGDiD9DBV0QtUI3Gv3J0NJcqjgo6C5LFeuWuQKKH9QbBPx/tT4BAVBPmxNMd6BKb1Mmt
        UwrMgprJhT3TJri8gBKqHoOWj
X-Received: by 2002:a05:6000:1d84:b0:20e:5fae:6e71 with SMTP id bk4-20020a0560001d8400b0020e5fae6e71mr3107641wrb.224.1657284180423;
        Fri, 08 Jul 2022 05:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uceXvLb2nTRXllLSEuJcv3LiXxdEtNQWkA9mvcK64CjX5el+CmC6lNxnhsOQy3kBPHocjj7g==
X-Received: by 2002:a05:6000:1d84:b0:20e:5fae:6e71 with SMTP id bk4-20020a0560001d8400b0020e5fae6e71mr3107608wrb.224.1657284180216;
        Fri, 08 Jul 2022 05:43:00 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id id8-20020a05600ca18800b0039c4b518df4sm2469004wmb.5.2022.07.08.05.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 05:42:59 -0700 (PDT)
Message-ID: <e49487ae-3531-1baa-4277-83d858c28837@redhat.com>
Date:   Fri, 8 Jul 2022 14:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/9] drm: selftest: Convert to KUnit
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220702131116.457444-1-maira.canal@usp.br>
 <4c2dc8cd-56c4-6e15-d76e-429dba87407c@redhat.com>
In-Reply-To: <4c2dc8cd-56c4-6e15-d76e-429dba87407c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maíra,

On 7/2/22 15:17, Javier Martinez Canillas wrote:
> On 7/2/22 15:11, Maíra Canal wrote:
>> Hi everyone,
>>
>> Here is the v4 of the conversion of selftests to KUnit. Since the v3, there
>> have been minor fixes, asked by Javier. Basically, fixes on the SoB chain and
>> addition of Copywrites.
>>
>> Thanks for your attention and any feedback is welcomed!
>>
> 
> Thanks a lot for the quick re-spin of the series! I'll wait a few days in case
> someone else has additional feedback and then push to drm-misc (drm-misc-next).
>  

I wanted to apply this but noticed that there are a tons of checkpatch script
warnings and checks failings. Could you please take a look with the following:

./scripts/checkpatch.pl --strict -f drivers/gpu/drm/tests/*.c

and fix the ones that you think are not false positives (I think most of the
issues pointed out are correct). I could fix them before pushing but I prefer
if you do, to prevent me adding any regressions while modifying your patches.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

