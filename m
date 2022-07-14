Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397275753ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiGNRUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiGNRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:20:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093066AC0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:20:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9259858pjc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aiimYL4bGGP4Obd7S4r8NfKIKgNtZtb7QnLuS/XBbGM=;
        b=h10XwfkbRdiTDooUNnPb6LXyfdxthOG17pIb6QhROE2ENj8ZLnLAVIneYyMxI/Vsni
         EP/wwbppFhJ3tF5S76D99EqVhGqY0A/bWfRhEd2XlwEgssDD55cOxQwUCYYq+uaroqsM
         Zz4rJUqQ2p+mg3pNTdwZfINQEbnlDUFEm6ForSg8tpjYjf6PUcmZL4GTmioTO47bkLMc
         xNySOAengQHQGoQMYaJsDCOIUS0p/jR3kF/VLXz1D4WOuX8E3Smr6LzUWho5z+EhC8Vs
         NrTSZ5jbpnRCaUXYO6jbRRaQ+iZo8ee4VFo2jsMXpsNEB9x8eqhAvHDkcNBulO1ad0nJ
         gt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aiimYL4bGGP4Obd7S4r8NfKIKgNtZtb7QnLuS/XBbGM=;
        b=0XbLUYta0rkxkVRTkTPOpuOVOLtIA1VjckF4eUD7Ctvn3Oj0NeIl+2SYvILiReGUNg
         MP+IoMo+1zINCZRU++BNV2btZVBAB3Lv36yPiU0MhuezpZ5/IoK2C5ZYwk2XEc8inmik
         /8Fgy2WJpJiTYXPHrHWWjzta5o0qzxB2iuMDSugIChRF87evsWx7/Tt2JRYPyHmRXP1z
         RyEVHPsQFO46dBasctRkLdiVyeaFGmZO/ZjBrBb9eekxE9Hg6h5NDxcgJC8Tvzj1kmaY
         4QwFTMfi5TSJBIZbtF9w/6BBY1p5ypaiTLqq9wVOqfybGBPbg01Tif56erpL5CG9XkGH
         gTWA==
X-Gm-Message-State: AJIora+472KxkKQusxUWSPgJHjmWlsZdwJjSDRxmYvtxppUXfAQdUcPx
        /1puK71Iz+JZOKjAJZOHINEMBAvzQZpUcA==
X-Google-Smtp-Source: AGRyM1vM+4sA+x5IyNACx13FZKKy3VVeFA6buU+LX+i72+lqssb7wr0KfDVhzrwUHfklHa2xFydZTA==
X-Received: by 2002:a17:903:234c:b0:16c:3dba:37fa with SMTP id c12-20020a170903234c00b0016c3dba37famr9325277plh.89.1657819230890;
        Thu, 14 Jul 2022 10:20:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w125-20020a636283000000b00419b1671c54sm1672819pgb.4.2022.07.14.10.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:20:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <00a2cb3c-e358-b8f1-5e65-bc1c0694f54d@roeck-us.net>
Date:   Thu, 14 Jul 2022 10:20:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amd/display: Enable building new display engine with
 KCOV enabled
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20220712224247.1950273-1-linux@roeck-us.net>
 <98b656f3-e506-90be-ebcc-898813051e74@amd.com>
 <CADnq5_OMayFN52hr7ZWFqMHPaV5_q7Hi+4LEbNMgfTPqo3__=w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CADnq5_OMayFN52hr7ZWFqMHPaV5_q7Hi+4LEbNMgfTPqo3__=w@mail.gmail.com>
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

On 7/14/22 09:29, Alex Deucher wrote:
> Applied.  Thanks!
> 
> On Wed, Jul 13, 2022 at 4:03 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2022-07-12 18:42, Guenter Roeck wrote:
>>> The new display engine uses floating point math, which is not supported
>>> by KCOV. Commit 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov
>>> is enabled") tried to work around the problem by disabling
>>> CONFIG_DRM_AMD_DC_DCN if KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS
>>> are enabled. The result is that KCOV can not be enabled on systems which
>>> require this display engine. A much simpler and less invasive solution is
>>> to disable KCOV selectively when compiling the display enagine while

"enagine". Outch.

Anyway, thanks for applying.

Guenter

>>> keeping it enabled for the rest of the kernel.
>>>
>>> Fixes: 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov is enabled")
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Leo Li <sunpeng.li@amd.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Harry
>>
>>> ---
>>>   drivers/gpu/drm/amd/display/Kconfig     | 2 +-
>>>   drivers/gpu/drm/amd/display/dc/Makefile | 3 +++
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>>> index b4029c0d5d8c..96cbc87f7b6b 100644
>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>>>        bool "AMD DC - Enable new display engine"
>>>        default y
>>>        select SND_HDA_COMPONENT if SND_HDA_CORE
>>> -     select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>>> +     select DRM_AMD_DC_DCN if (X86 || PPC64)
>>>        help
>>>          Choose this option if you want to use the new display engine
>>>          support for AMDGPU. This adds required support for Vega and
>>> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
>>> index b4eca0236435..b801973749d2 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
>>> @@ -26,6 +26,9 @@
>>>   DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
>>>
>>>   ifdef CONFIG_DRM_AMD_DC_DCN
>>> +
>>> +KCOV_INSTRUMENT := n
>>> +
>>>   DC_LIBS += dcn20
>>>   DC_LIBS += dsc
>>>   DC_LIBS += dcn10
>>

