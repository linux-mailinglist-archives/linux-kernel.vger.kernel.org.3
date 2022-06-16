Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655654E7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiFPQoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFPQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 219A9286CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655397831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjMtM8OGnDrbMwcn+8vKnlZdrkOGRhE/5nADc7InRc4=;
        b=TSQFJkRBWy3mvIQerMvPzNPpML8zeT0oOJPe6Z6WXrAzfYtgo0XC38GHDJkICj+3i9k/ps
        8EzERBrf4TEe/rq3FmxDsc86RgyXxqLg1QyMeKB+nFZe8gNAeVoHRcN1ka5A7y1DkBF6u7
        xwdZ7fI3mYdQdGrwQICBt86RGeIjSW0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-rzlTIEnfORamicqTFLj-pw-1; Thu, 16 Jun 2022 12:43:49 -0400
X-MC-Unique: rzlTIEnfORamicqTFLj-pw-1
Received: by mail-wr1-f72.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso383212wrw.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AjMtM8OGnDrbMwcn+8vKnlZdrkOGRhE/5nADc7InRc4=;
        b=JFWJNhssbwF4vHlRmq0WIXHh0J8No5SqdNOjHF8gX7/3EjTa5goqPzto0KSpJCfs7G
         YK0hdl10qDqYKuGP4T/fNfmzHcNX2JTF7ai5gWOR3Mkzc6geyXtdeM7m5kXpUHn0bljN
         zEalcX47ZFV8qagZU/pMN8cwiKOYR/wq/hL3cwOJjag58C1rtSRS+3v8jKRFRN+8K/0L
         uzwCPaln+EmxRZekNQxEvDO7xRPeVDlgsCcUygF3lTj1PwRhncpUNbmtHUE8rxh76rRX
         gC+tU9Z96AaE1k1bVJJ1NkFiprNDsRlJcSDnMyXqY4Jdi4m1FMnuYwEzDZB/aZPd/hBO
         NQPQ==
X-Gm-Message-State: AOAM533qf8LXMxnUGO+cDEg992337PgvJlDKL/fRQUb50D7MNY7oGxDo
        dqgNzNE94Kp8Nzt3R95nXnUkIJEagvfpOMpFz82trErSmBZMyyna2gvlUfuxGywRCDxzWE7N7QY
        1goc3gpfabJcFRNMuTILMntUY
X-Received: by 2002:a05:600c:10cf:b0:39c:8270:7b86 with SMTP id l15-20020a05600c10cf00b0039c82707b86mr16724431wmd.180.1655397828436;
        Thu, 16 Jun 2022 09:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8+fKsEXIAvNyB94ZpK27ofIlM12w0GekOLSDeZEFo92yryX6GxBCFSwKJr3GgRIgUlCaqhQ==
X-Received: by 2002:a05:600c:10cf:b0:39c:8270:7b86 with SMTP id l15-20020a05600c10cf00b0039c82707b86mr16724402wmd.180.1655397828203;
        Thu, 16 Jun 2022 09:43:48 -0700 (PDT)
Received: from [172.20.10.8] ([185.124.31.117])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b0020e63ab5d78sm2381222wrn.26.2022.06.16.09.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:43:47 -0700 (PDT)
Message-ID: <d6c00532-5546-ea4a-1927-9d4ea5e83741@redhat.com>
Date:   Thu, 16 Jun 2022 18:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/10] drm: selftest: Convert to KUnit
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        dri-devel@lists.freedesktop.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <20220615135824.15522-1-maira.canal@usp.br>
 <CABVgOSkVOKx1EEYtg-Os+kui-UivfFLT9OSEB9+sDxcgcxh5Mg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CABVgOSkVOKx1EEYtg-Os+kui-UivfFLT9OSEB9+sDxcgcxh5Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 16:55, David Gow wrote:
> On Wed, Jun 15, 2022 at 9:59 PM Maíra Canal <maira.canal@usp.br> wrote:
>>
>> KUnit unifies the test structure and provides helper tools that simplify
>> the development of tests. The basic use case allows running tests as regular
>> processes, which makes it easier to run unit tests on a development machine
>> and to integrate the tests into a CI system.
>>
>> That said, the conversion of selftests for DRM to KUnit tests is beneficial
>> as it unifies the testing API by using the KUnit API.
>>
>> KUnit is beneficial for developers as it eases the process to run unit tests.
>> It is possible to run the tests by using the kunit-tool on userspace with the
>> following command:
>>
>> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests --arch=x86_64
>>
>> For CI system, it is possible to execute during the build. But, we also think
>> about IGT: we are developing a patch to introduce KUnit to IGT.
>>
>> These patches were developed during a KUnit hackathon [0] last October. Now,
>> we believe that both the IGT side and the Kernel side are in good shape for
>> submission.
>>
>> If you are willing to check the output, here is the Pastebin with the output
>> and execution times [1].
>>
>> [0] https://groups.google.com/g/kunit-dev/c/YqFR1q2uZvk/m/IbvItSfHBAAJ
>> [1] https://pastebin.com/FJjLPKsC
>>
>> - Arthur Grillo, Isabella Basso, and Maíra Canal
> 
> Great to see these going upstream!
>

Indeed, this is pretty awesome!
 
I haven't reviewed the patches yet but just have a meta comment. There's a TODO
entry for this [0] in Documentation/gpu/todo.rst, so I think that you could add
a patch removing that as a part of this series.

[0]: https://cgit.freedesktop.org/drm/drm/tree/Documentation/gpu/todo.rst#n620

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

