Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4868A52D9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiESQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiESQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40E289CF5C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652976599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUt6lp1fjRg++kb2YdzULz0Xmj7H6l3t/jjMERJec64=;
        b=KJbJHaMUnTg3oOIXCuNTwas4fm0O6ywye/X5AkmEZesVY316Iy5jMENiWn7e68KPfldfTj
        6ZhNMcPqhwshXntyH8cn9iZGA6JuZQzCLuSGY59hmu45NeShaJPZHgcGaGKm2Y+wgVQCl/
        dGec+MDobUotliIlBM/t9OoQLly6Yuo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-WlM1agNXNcCEh7PIjYT7-A-1; Thu, 19 May 2022 12:09:57 -0400
X-MC-Unique: WlM1agNXNcCEh7PIjYT7-A-1
Received: by mail-ed1-f71.google.com with SMTP id b14-20020a05640202ce00b0042aa312ff51so3893006edx.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=MUt6lp1fjRg++kb2YdzULz0Xmj7H6l3t/jjMERJec64=;
        b=CoBaVPd4mSk2GVvjMm6X/mj8h/QvvG1yXtMFDUICUyNBKw3KbouX5GY+tn7AnBuTXw
         e2rxxt2UVPUKWxbpBH7LvQEx0+F8maf/ourilQ/3mQiK9/5H+6W8nlKnaKRdItA8Orc4
         nA+EUT7nCm6zgNdlxE8Cr+DRkGWZnPA+giI43idX/+C5pzN3+18xj+m6pVnyYRw10rty
         PEVMfTHJ2GPK8orbt+++vHhV8Ebno0PIqvsFfQwl2a5n6CfKWk2Hb+FoLldC2UxqZbYZ
         vFUIyIdk/7SGu5U8JJXD3dbzr9pO+y1qAVmAnsfMNRf0Qg13JiaaAiVjsFljBCHEKyH1
         TWxg==
X-Gm-Message-State: AOAM530qBS9J6AGR3Cv7ND+T16RGXGrmJEEah3XS+JlG9r6uAs7bmE4H
        A0tq5AsNPFejz9bmRZjBJUbAXJWAZJdipum78/ko2Ay8wB/9Uakh+YrS7q3jf+BOHMwY6Gk/AGi
        K99GKbUmFYVC0UG7XKPt1+zos
X-Received: by 2002:a05:6402:1150:b0:42a:9dbf:8860 with SMTP id g16-20020a056402115000b0042a9dbf8860mr6128427edw.350.1652976596351;
        Thu, 19 May 2022 09:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpaRyu8kgbur4IB+zusXJrOJ3q/Kh+Sp/1TFeSlDQhqK36HXAHV+iCmptLZGSNz+e1M9SUWA==
X-Received: by 2002:a05:6402:1150:b0:42a:9dbf:8860 with SMTP id g16-20020a056402115000b0042a9dbf8860mr6128405edw.350.1652976596172;
        Thu, 19 May 2022 09:09:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b006f3ef214e11sm2274669ejc.119.2022.05.19.09.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:09:55 -0700 (PDT)
Message-ID: <063d7fdb-2d4c-5798-773b-d82b4f0e918a@redhat.com>
Date:   Thu, 19 May 2022 18:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux
 5.18-rc6)
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info>
 <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
 <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
 <04f2e08c-4c39-16d3-d785-f36494c6256c@redhat.com>
In-Reply-To: <04f2e08c-4c39-16d3-d785-f36494c6256c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/17/22 17:50, Hans de Goede wrote:
> Hi,
> 
> On 5/9/22 21:04, Hans de Goede wrote:
>> Hi,
>>
>> On 5/9/22 19:20, Linus Torvalds wrote:
>>> On Mon, May 9, 2022 at 3:47 AM Regzbot (on behalf of Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>
>>>> Hi Linus! Here's a quick compilation of open reports about regressions in
>>>> 5.18-rc that I'm currently aware of; most of the reports are quite
>>>> recent and there afaics is nothing that looks particularly worrisome.
>>>
>>> Well, the Intel GPU issue seems likely to cause problems for lots of people:
>>>
>>>> [ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
>>>> -----------------------------------------------------------------------------------------
>>>> https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>>> https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>>>
>>>> By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
>>>> Introduced in b5cfe6f7a6e1 (v5.18-rc1)
>>>>
>>>> Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)
>>>
>>> Although it looks possible that it mainly affects old chipsets (ie the
>>> two reports are for a Bay Trail chip and a Core 2 Duo chip - I have no
>>> idea how they compare).
>>>
>>> That probably means there are a lot of machines out there, but likely
>>> not the kind that most kernel developers will be testing, so not a ton
>>> of reports until it hits distro kernels etc.
>>>
>>> It looks like Maarten is already involved.
>>
>> This is being tracked here:
>> https://gitlab.freedesktop.org/drm/intel/-/issues/5806
>>
>> I've just tested a patch from Maarten which fixes things for me,
>> so hopefully we can get this resolved soon.
> 
> Maarten, it would be nice if we can get this fixed before 5.18
> is released. What is the status of getting your:
> 
> https://patchwork.freedesktop.org/patch/485889/

A quick status update, this is fixed by:

https://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-fixes&id=7b1d6924f27ba24b9e47abb9bd53d0bbc430a835

Which was just pushed to:

https://cgit.freedesktop.org/drm-intel/log/?h=drm-intel-fixes

Note this is not part of any pending drm-fixes* pull-reqs yet though.

Regards,

Hans

