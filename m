Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1052A75D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350620AbiEQPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350495AbiEQPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAB004F47C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652802612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6h7GjHXovS7HJ4Kp5wqYSGdYt0+9AQpi6DLOx1zqHHk=;
        b=bUeMce+2eB36pTjYH0dRgMEPdTye0Pmc3dsmlzAWlF4ZOyC71yuHIuzh/AirMZoE/uyFcC
        uKPgPHesr9wsWLjqNXBWmaqOyGzTnJKd0VwPT9hP+I2UUNyztjiM3HEh/owQEuk6u+GcsD
        tWpu/AgS2RkKehnkL3Et1NbowbXwZck=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-20ng5kgcO-CKBmFv_Lz9uA-1; Tue, 17 May 2022 11:50:10 -0400
X-MC-Unique: 20ng5kgcO-CKBmFv_Lz9uA-1
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a056402018800b00428b43999feso12171738edv.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6h7GjHXovS7HJ4Kp5wqYSGdYt0+9AQpi6DLOx1zqHHk=;
        b=nOziIlfju6brrKtkHlX3pnpOb4tyRvp99c5n9mtv+/dT9kCuc9Hem4fqyDDyHsymCI
         bbqz0RBibtGDKQN6Bu4Gk6LdOfCcE0df6Qof7jltdC04917sAnMSp6xg2+ymEuN1roAl
         UsxcJURxEqz8i4hmAMjaBjboccH/ZGGIA6onXN2THVJKXpD5uC7VqvJ2uZEDV7J4HHjx
         ovv18L9TXgIorJVGnvrRTEHNF9kpmbv344IjAt3ILUQxzOsFBbgZZlpdpI40xCDhlzIB
         l797Vy2NHRHUzW1qOq1uQJe9J73wPK/WyMYoH+VruJHvZWlhfuxz9vGf4DUQquXytkg4
         VnQg==
X-Gm-Message-State: AOAM532GqvaOMh9WXafCu6nmmTRqstpSFiROGKYgi16yZxO4y1O4qgTn
        nCeI2oZUf+lquo7hxFy9pJUPZmmQqNC1J0hCuQ9Pb7xq0f6pU+EXmiXrM/psQU1IUEKAVFfsOH+
        dUeA4O6O6xgfwHlZ7db7Hb4xE
X-Received: by 2002:a17:907:1b1c:b0:6f0:10e2:7a9b with SMTP id mp28-20020a1709071b1c00b006f010e27a9bmr21197677ejc.58.1652802609254;
        Tue, 17 May 2022 08:50:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwauTfVmlCJoRiKhXSBiOeT/A7JIF17V3tL8pRBRkaE+ZWZTtEnTbdgpF/bFVMc/K/bASQynw==
X-Received: by 2002:a17:907:1b1c:b0:6f0:10e2:7a9b with SMTP id mp28-20020a1709071b1c00b006f010e27a9bmr21197664ejc.58.1652802609081;
        Tue, 17 May 2022 08:50:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u11-20020a50eacb000000b0042617ba6383sm7426505edp.13.2022.05.17.08.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:50:08 -0700 (PDT)
Message-ID: <04f2e08c-4c39-16d3-d785-f36494c6256c@redhat.com>
Date:   Tue, 17 May 2022 17:50:08 +0200
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
In-Reply-To: <54664f6a-b046-1330-e794-cb533e942a94@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/9/22 21:04, Hans de Goede wrote:
> Hi,
> 
> On 5/9/22 19:20, Linus Torvalds wrote:
>> On Mon, May 9, 2022 at 3:47 AM Regzbot (on behalf of Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> Hi Linus! Here's a quick compilation of open reports about regressions in
>>> 5.18-rc that I'm currently aware of; most of the reports are quite
>>> recent and there afaics is nothing that looks particularly worrisome.
>>
>> Well, the Intel GPU issue seems likely to cause problems for lots of people:
>>
>>> [ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
>>> -----------------------------------------------------------------------------------------
>>> https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>> https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>>>
>>> By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
>>> Introduced in b5cfe6f7a6e1 (v5.18-rc1)
>>>
>>> Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)
>>
>> Although it looks possible that it mainly affects old chipsets (ie the
>> two reports are for a Bay Trail chip and a Core 2 Duo chip - I have no
>> idea how they compare).
>>
>> That probably means there are a lot of machines out there, but likely
>> not the kind that most kernel developers will be testing, so not a ton
>> of reports until it hits distro kernels etc.
>>
>> It looks like Maarten is already involved.
> 
> This is being tracked here:
> https://gitlab.freedesktop.org/drm/intel/-/issues/5806
> 
> I've just tested a patch from Maarten which fixes things for me,
> so hopefully we can get this resolved soon.

Maarten, it would be nice if we can get this fixed before 5.18
is released. What is the status of getting your:

https://patchwork.freedesktop.org/patch/485889/

patch for this merged ?

Regards,

Hans

