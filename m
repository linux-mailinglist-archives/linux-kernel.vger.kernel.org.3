Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BC5199E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiEDIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346291AbiEDIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BB424971
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651653283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if3uv1JcdUh98ACrRo4ZvJgdrj3l4HR7vDdntef3MiY=;
        b=hfckusm0m3BJNS5hlzZ2ZaMqtq/RuUvqNyFrj2TmTI/5QnPiu6OkbrKmccUtxRrANIkJ/n
        4eCBod5SAmd5aqx1M70ll/ZbovXXO4g4Ym1lYSVLHi/wHzpSxcmMVS6a+t6Qv5/8yqX0mg
        PzIkdBw28BFqUOBfsiSDGQiQNlsfxNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-NuRd3UpWNjuGTM-qd74sng-1; Wed, 04 May 2022 04:34:42 -0400
X-MC-Unique: NuRd3UpWNjuGTM-qd74sng-1
Received: by mail-wm1-f72.google.com with SMTP id v184-20020a1cacc1000000b00393e492a398so2681967wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=if3uv1JcdUh98ACrRo4ZvJgdrj3l4HR7vDdntef3MiY=;
        b=Cwq2Z0ioMEdX9gd1bKpPgP/H8ahuyLiwdRyK4RRRpgCyM8q4xmYhlql11HN4u+tTd1
         ESXdSaVJ2mtaTUcL6e2HKqPyIIHb/Eok5NEa5LpSpLbCfFEQ1glDuH9ENJwxFPWoL0px
         PZnfawp3dHcijuLtJzXsfyNZRpFTIe+Q/tqmR/8MZX6dvx3tJpxvwYo4M/pA48v1AseR
         UJrUcvIlRkGqjPBT910su2Rd8WBq2/N2Ls2bmkxnAak00LyQrubavcUxCjA43vpZNbs6
         ZzrOqcFdkucYzyJDb4Aeupy/DS8V34v8D+kByE6bCmpkhTZJpWQPjPCtZZDuX7w/Hp4U
         Lq3g==
X-Gm-Message-State: AOAM530qbljwqF5UVSra8Liqsoh/9cb3k2AaO+/SEE8TbkkI7f4NGOec
        bEHEusC2JiV1Jz0KpCG+t7a9wKiNe4ul9xcAmbBnC2U6iwlKiWNTbeqJhzoN8D3gSLqZhj5YgLs
        PHMBHFjDDQm+PA2BFc5cwL2wL
X-Received: by 2002:a05:600c:4ed3:b0:394:20e7:bb86 with SMTP id g19-20020a05600c4ed300b0039420e7bb86mr6555293wmq.169.1651653281545;
        Wed, 04 May 2022 01:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAZVwBp/nDI1nIpeJGb6Pci/26KKoAcohnWXc6tvbHvFBQaP3kohFTAC4NC7vLVQIejL3L9A==
X-Received: by 2002:a05:600c:4ed3:b0:394:20e7:bb86 with SMTP id g19-20020a05600c4ed300b0039420e7bb86mr6555283wmq.169.1651653281303;
        Wed, 04 May 2022 01:34:41 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003942a244ed7sm3318494wmb.28.2022.05.04.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:34:41 -0700 (PDT)
Message-ID: <b9aebad9-30df-2906-d935-0483a5429a1a@redhat.com>
Date:   Wed, 4 May 2022 10:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/todo: Add entry for using kunit in the subsystem
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220504080212.713275-1-javierm@redhat.com>
 <20220504081030.ky57nenipnif5r2e@houat>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504081030.ky57nenipnif5r2e@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

Thanks for your feedback.

On 5/4/22 10:10, Maxime Ripard wrote:
> Hi,
> 
> On Wed, May 04, 2022 at 10:02:12AM +0200, Javier Martinez Canillas wrote:
>> The Kernel Unit Testing (KUnit) framework provides a common framework for
>> unit tests within the Linux kernel. Having a test suite would allow to
>> identify regressions earlier.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>  Documentation/gpu/todo.rst | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
>> index 127e76ee0b2d..10bfb50908d1 100644
>> --- a/Documentation/gpu/todo.rst
>> +++ b/Documentation/gpu/todo.rst
>> @@ -603,6 +603,20 @@ Level: Advanced
>>  Better Testing
>>  ==============
>>  
>> +Add unit tests using the Kernel Unit Testing (KUnit) framework
>> +--------------------------------------------------------------
>> +
>> +The `KUnit <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
>> +provides a common framework for unit tests within the Linux kernel. Having a
>> +test suite would allow to identify regressions earlier.
>> +
>> +A good candidate for the first unit tests are the format-conversion helpers in
>> +``drm_format_helper.c``.
>> +
>> +Contact: Javier Martinez Canillas <javierm@redhat.com>
>> +
>> +Level: Intermediate
> 
> Kunit is fairly easy to grasp if you have some knowledge of other unit
> testing frameworks already (pytest, cmocka, etc.)
>

Yes, I didn't set to intermediate due kunit but rather due the format
conversions, since the functions are not easy to read and understand.

And the person writing the unit tests will have to get familiar with
the different formats to verify that conversions are done correctly.
 
> Another good candidate would be to convert (some ?) selftests to kunit.
> I'm not sure the others, but at least test-drm_cmdline_parser should be
> fairly easy to convert.
>

Indeed. Maybe I would add it as a separate entr though, as a follow-up.
 
> Maxime

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

