Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749A574EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239186AbiGNNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiGNNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:20:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C45D59C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:20:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 5so387333plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=9PvTbOQp4n28wbO5UWAbp8/0QyOUUqCrsa8uBKcvtAQ=;
        b=QWUAAzr26QjP2JPSKabdts+BUza12kAxvwW3taUje2cLVmjdSW0KgliwhAGd3ieYpS
         Y5jBon5kWw8lbyVB2ooFMUAKSJCmjxe6kV3LdUlhs/GiwSyPbqPAT/wh1QvVVhrmZXgm
         FC0PvfUGlFzx6fZGRsjBDR+iieAhYv4o2CDGONCKASbJiQRgSeEAEruhBDghGBJc2qSh
         WNxaoddoeQXfm6N1sqvuSED1pbP8Rg7Ud7MSzhLdbhOgvk2jf+JUlNKiywzv1SLk5Cy6
         4jBebTRTUciM//hkLCMqmMbaGK4th6ajF3/+bXxG4Hbe3uydE0rjCBptazINQg/zBqBW
         U2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=9PvTbOQp4n28wbO5UWAbp8/0QyOUUqCrsa8uBKcvtAQ=;
        b=Wx7fzAfv0V1MPSShwPYUSPyAPEmH2JmiZReAtkVebfNbDr0orrUQ6j9828Q0JQHSGJ
         HmCVet8kaCCQIxR5hcunvh9GiYWU2nz1HkciLKRp/O29I6yAYxY+4/aG0nUr/Uu0KyRA
         6e8DQqFe7Xt7Uf9N3q+9SmboojjJTpX8tbXWZBlMMJgzvC5ssgUDMJS/70Ww67udYOr8
         9l2CYFlAJy8eO5OWn2X06gjOr58HDD5lU70kFP/Yz1o0m1A9Dd251xzAbSkC/kVAcgX4
         JzgGQYHvotNurbQcA67jPi4MQhFzDzxeU+V+RoHwhPvpLxctqBv9QkpY5MY/PKSzjT8R
         KtAw==
X-Gm-Message-State: AJIora8s6TppTSTrtGiuQIVeqeWo3y11RONZK8IMZRcRzJIQjDURdDGy
        5GTIgOmj0cWj7aMAhIPadj4=
X-Google-Smtp-Source: AGRyM1vb0HH7038vVBg8ZPsgGUNBtQC2ygxC+R2UazdBAz/qMT1uekVP93JtAXiidBih+3sNVzCqIg==
X-Received: by 2002:a17:90a:e611:b0:1ef:92b6:d31 with SMTP id j17-20020a17090ae61100b001ef92b60d31mr16029353pjy.166.1657804839084;
        Thu, 14 Jul 2022 06:20:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b0052b2bf4cc42sm514506pfl.111.2022.07.14.06.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:20:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
Date:   Thu, 14 Jul 2022 06:20:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 00:23, Geert Uytterhoeven wrote:
> Hi Linus,
> 
> On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> If you want to apply Guenter's patch original patch:
>>> https://patchwork.freedesktop.org/patch/490184/
>>> That's fine with me.
>>
>> Honestly, by this time I feel that it's too little, too late.
> 
> [...]
> 
>> So considering that the ppc people ignored this whole issue since the
>> merge window, I think it's entirely unreasonable to then apply a
>> ppc-specific patch for this at this time, when people literally asked
>> "why is this needed", and there was no reply from the powerpc side.
> 
> Oh, it's not just this one. The lists of build regressions between v5.18
> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
> 
> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org
> 

How do you build your images ? I don't see many of the problems you report,
even if I build the files with W=1. It is odd, since reports such as

drivers/mfd/asic3.c:941:23: error: unused variable 'asic'

are real, but I just don't see that. If I build that file, I see that
it builds with -Wno-unused-but-set-variable, due to

Makefile:KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)

The override in scripts/Makefile.extrawarn doesn't seem to work even though
it adds "-Wunused-but-set-variable" to the compile flags. And if I remove
"-Wno-unused-but-set-variable" from Makefile I still don't get the error/warning.
Confused. I must be missing something, but what ?

Thanks,
Guenter
