Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75519575BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiGOHAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGOHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 860A266B8D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657868400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBVMsqeudLUDrKPrFs7ovavMecKqXiLCpPEb6YK8LdQ=;
        b=KRcS37JJThPoF3hQqtw87s1fXSDlQrKDj9qZpUIrNTo8GTgDjAIbVmdspSSYcC/k0lBYHw
        HPQIvy+NXvQ7Jd3re/Js6TUoLuOOImmNcoyusV6Q0Tn/omNFNuwl+jzDaxgzXtZeK5yFou
        jhzpZoGtCDKkR7hjzd7Wrtt3laxoUw8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-KYS2k0DwPzSjzfpz40n7NA-1; Fri, 15 Jul 2022 02:59:57 -0400
X-MC-Unique: KYS2k0DwPzSjzfpz40n7NA-1
Received: by mail-wm1-f69.google.com with SMTP id 23-20020a05600c229700b003a2eda0c59cso1519253wmf.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FBVMsqeudLUDrKPrFs7ovavMecKqXiLCpPEb6YK8LdQ=;
        b=vFczTHTkz7Gk8h5/hSfty96PG6G4pCPts8ne5EL5GidRbj+ocmTxZ/uAcgPMaEpkgY
         gqWV4UPTcChLMR7YQQVObC8MFuPh3onVgiS5kmiTiLhMulWxY8dHARs0df/W0Lq7EGTt
         oXv4ZaGS3X12Hmairb6jJBZpestBp8ivBg/DkN1sjKGouoiHPq92yVswkMLgbr/nqmIu
         bUQiYvludPkWd36qMYByv3txHgUBz+phKjvnuFkbqvzsAwW8ywNxd2sJbQUwnXAh+I7U
         CK/ynSWa3Q3rPdQ7MCEe/RMwU9bA7wdJgtZT5THALAYAEyGp+3Uss+1V1M/LNVWgOkxx
         lcUQ==
X-Gm-Message-State: AJIora91ziecqIfy/1qtRCCTfWApbQOOWZXeCuV0w9BcIpyiJsFZIxm1
        J8YQTMa8doWYSrMGZyf+qFkuB2QCKgkEKLNulaFwiQ08sEuIS270g0NZSYlajiJn3QQHBptwPz7
        tgtSFE+xWPGhNb8/ntUCWTBqP
X-Received: by 2002:a5d:4d46:0:b0:21d:8196:6181 with SMTP id a6-20020a5d4d46000000b0021d81966181mr11294034wru.459.1657868396087;
        Thu, 14 Jul 2022 23:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uAYCTgRNGQGhKCVMDYlzGS8cDv/34uFpAiy8Z6B2ARTEizEox1Diyk4fPX2N1E5/NRTO5Psw==
X-Received: by 2002:a5d:4d46:0:b0:21d:8196:6181 with SMTP id a6-20020a5d4d46000000b0021d81966181mr11294020wru.459.1657868395855;
        Thu, 14 Jul 2022 23:59:55 -0700 (PDT)
Received: from [192.168.1.165] (22.red-79-153-172.dynamicip.rima-tde.net. [79.153.172.22])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a300452f7fsm5389311wmq.32.2022.07.14.23.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 23:59:55 -0700 (PDT)
Message-ID: <5f9b35b4-09fa-a8a9-3181-cd8cd7898d03@redhat.com>
Date:   Fri, 15 Jul 2022 08:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/9] drm: selftest: convert drm_format selftest to
 KUnit
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
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
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-5-maira.canal@usp.br>
 <20220714235137.GA485839@roeck-us.net>
 <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAGS_qxrhy3=pST9f85fvxubKQShOq1XF6ZHALzMhXDOf5gnaUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 02:03, Daniel Latypov wrote:
> On Thu, Jul 14, 2022 at 4:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Jul 08, 2022 at 05:30:47PM -0300, Maíra Canal wrote:
>>> Considering the current adoption of the KUnit framework, convert the
>>> DRM format selftest to the KUnit API.
>>>
>>> Tested-by: David Gow <davidgow@google.com>
>>> Acked-by: Daniel Latypov <dlatypov@google.com>
>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Signed-off-by: Maíra Canal <maira.canal@usp.br>
>>
>> This patch results in:
>>
>> Building powerpc:allmodconfig ... failed
>> --------------
>> Error log:
>> drivers/gpu/drm/tests/drm_format_test.c: In function 'igt_check_drm_format_min_pitch':
>> drivers/gpu/drm/tests/drm_format_test.c:271:1: error: the frame size of 3712 bytes is larger than 2048 bytes
>>
>> presumably due to function nesting.
> 
> This can happen when there's a lot of KUNIT_EXPECT_* calls in a single function.
> See [1] for some related context.
> There were a number of patches that went into 5.18 ([2] and others) to
> try and mitigate this, but it's not always enough.
> 
> Ideally the compiler would see that the stack-local variables used in
> these macros don't need to stick around, but it doesn't always
> happen...

Thanks Daniel for the explanation.

> One workaround would be to split up the test case functions into smaller chunks.
>

Maíra,

Could you please look at splitting in smaller chunks to mitigate this issue ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

