Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E865467B37
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbhLCQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhLCQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:25:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF80C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:21:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so5553562pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=j/5ecamC7ddvajilWR2KuZ9hro3rMRRJOO4sN6pkOcw=;
        b=BA379woLXMV7sunjp3DYGTcEgY85D/pwf0ebSsGDvzGFrpwmd6tXkfGcIMdZF3IxuJ
         X2kvHP3VuMckYgEGKqbzoCwsLISUbp6zokE30CnN28VLSGJSlNa8AxOvPlf7RJhSn/Wb
         RLkWOWjgy6HImjnkHp2T4H3Nhx7abjWR2Tf8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=j/5ecamC7ddvajilWR2KuZ9hro3rMRRJOO4sN6pkOcw=;
        b=I1lqD8uY2yQLqepNnTrt4SkXzQQIauEal6ZMcny6OepJR/sLAPW5bz6ufN1rQPahts
         3+Rg//wQu0nKVyRZ4gysuILGBOadI6uYFv6K6hZkFvtRCxfBgmA/8jceBo9Lao3K3VRE
         Sa6O0MT+dfA4slECyTgSParZWZvvt7nzihruxK87Dv4NXVY0adOy/J0jQ7//YN2JTady
         C/bsWXRX2hCoPn6R4eSTdCCuB8JQGGxpZHtOotGKXj4kLP/cpdijXs7txvg0RVNpUuUZ
         XFSTVxMa5Pzw/J5RfUIvr1ZAmF6nKTeRLT0F16qa21moz3hWpp2np4ElnlU3fHDLkZXP
         wkaQ==
X-Gm-Message-State: AOAM530jdqd3n6AC9sSUb+pmKLjfCfArUFAK3BSiQ35X22Q882yEew9U
        CFtsmwGlQfe1k8C4+06b6eu8Sg==
X-Google-Smtp-Source: ABdhPJyLipV9EiNWJaJhwEI7+g6PZlOABwHuSVKHcZHj7Sc3iBWtSBamTSBa/OhhzE8rmPqEPh2dFg==
X-Received: by 2002:a17:90a:1283:: with SMTP id g3mr15316290pja.174.1638548513291;
        Fri, 03 Dec 2021 08:21:53 -0800 (PST)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm3808219pfv.136.2021.12.03.08.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:21:52 -0800 (PST)
Date:   Fri, 03 Dec 2021 08:21:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_lib/test=5Fubsan=3A_Silence?= =?US-ASCII?Q?_compile-time_array_bounds_warnings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CANpmjNPCjXp_0iQjdznpvS2vF-VvDkxJrtWnBAoj6TAU488VAQ@mail.gmail.com>
References: <20211203093000.3714620-1-keescook@chromium.org> <CANpmjNPCjXp_0iQjdznpvS2vF-VvDkxJrtWnBAoj6TAU488VAQ@mail.gmail.com>
Message-ID: <CE7F1A95-67C7-4BDA-B803-D93901EC2378@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 3, 2021 2:49:53 AM PST, Marco Elver <elver@google=2Ecom> wrote=
:
>On Fri, 3 Dec 2021 at 10:30, Kees Cook <keescook@chromium=2Eorg> wrote:
>> The UBSAN tests intentionally operate beyond array bounds, so silence
>> the warning visible with a -Warray-bounds build:
>>
>> lib/test_ubsan=2Ec: In function 'test_ubsan_object_size_mismatch':
>> lib/test_ubsan=2Ec:109:16: error: array subscript 'long long int[0]' is=
 partly outside array bounds of 'volatile int[1]' [-Werror=3Darray-bounds]
>>   109 |         val2 =3D *ptr;
>>       |                ^~~~
>> lib/test_ubsan=2Ec:104:22: note: while referencing 'val'
>>   104 |         volatile int val __aligned(8) =3D 4;
>>       |                      ^~~
>>
>> Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>> ---
>>  lib/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 08959b10bac9=2E=2E2742a54a4275 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -70,6 +70,7 @@ obj-$(CONFIG_KASAN_MODULE_TEST) +=3D test_kasan_modul=
e=2Eo
>>  CFLAGS_test_kasan_module=2Eo +=3D -fno-builtin
>>  obj-$(CONFIG_TEST_UBSAN) +=3D test_ubsan=2Eo
>>  CFLAGS_test_ubsan=2Eo +=3D $(call cc-disable-warning, vla)
>> +CFLAGS_test_ubsan=2Eo +=3D $(call cc-disable-warning, array-bounds)
>>  UBSAN_SANITIZE_test_ubsan=2Eo :=3D y
>>  obj-$(CONFIG_TEST_KSTRTOX) +=3D test-kstrtox=2Eo
>>  obj-$(CONFIG_TEST_LIST_SORT) +=3D test_list_sort=2Eo
>
>Are there other warnings or only the one for the fsanitize=3Dobject-size
>test? I think this is fine if there are other warnings=2E

I will double check, but I think it's only the object-size test, which see=
ms to confirm my suspicion that -Warray-bounds provides sufficient coverage=
 and object-size can be removed=2E

I have another patch I intend to send today for the sk_buff/sk_buff_head i=
ssue, as -Warray-bounds warns for that as well=2E

>But, if it's only about the fsanitize=3Dobject-size test, I'm going to
>propose something more drastic=2E :-)

Are there any cases where object-size does a run-time check that couldn't =
be done at compile time? That's the only reason I could see to keep it at t=
his point, as -Warray-bounds can do the compile time checks=2E

>I had wanted to wait a bit and dig a little deeper, but I just posted
>part of my analysis here:
>https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecgi?id=3D214861#c4

Thanks, I'll refer to that in my sk_buff patch=2E It seems -Warray-bounds =
suffers from the same conservativism about object casts, which is frustrati=
ng on the one hand since the warning can be a false positive (cast vs acces=
s), but on the other, it does call attention to fragile arrangements which =
maybe could do with adjustment=2E

>My proposal is to remove UBSAN_OBJECT_SIZE and its related tests=2E The
>bugzilla bug goes into the details, but the TLDR is:
>1=2E fsanitize=3Dobject-size is incomplete,
>2=2E it should have been a compiler warning,
>3=2E for everything else there is KASAN which detects real OOB,
>4=2E for GCC we already disable UBSAN_OBJECT_SIZE=2E

And maybe:
5=2E -Warray-bounds provides the same coverage and is about to be enabled =
globally=2E



--=20
Kees Cook
