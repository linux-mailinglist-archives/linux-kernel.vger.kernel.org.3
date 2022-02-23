Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196644C1944
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiBWREy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbiBWREu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:04:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0CA5046F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:04:22 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0021C407BE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645635861;
        bh=RoNX8EzuGJlB3iCJ6r1tFSNiwtZPxPTTbVDAWTvRXkY=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=Ve8bDJDjxrsED0j9k/eV+Da6f5g88CczawtjS2qRJtLeV2KPpGrYN6xR5NUhhRDLl
         JLLxc8cO223hZnwzUXi0mgCzHowplV9vUlzP5V11F6OiFKzq7oE6Mf2x0Rhvvvl3Tn
         ZDzdBHalQ40p6616pGzMfU+TCVgMGQ/PLUTGWI8aiPrNZDqLPLdu6/lvBbhrAzuHmc
         ET2VgHDtAQxi32z2po52MuYsH+OLOm7uFOQbBt4ojEV1/CNhcfocCLehr+ZRA8UmJy
         Rm3LVjfOmP9jiQ/8FirrCdoKD8enBqLGERq2fiCazdxD2ffBPHhTdM57ANdBaFdw8n
         zWdgeOVv3ohGA==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso7330715ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RoNX8EzuGJlB3iCJ6r1tFSNiwtZPxPTTbVDAWTvRXkY=;
        b=bj+05BuninDxaKKXC1xU+nUOxU6hJd9NnEJ4kbilkedDUdoredwDqKKGsGCkpUBXJ9
         OaGXstHTwS2yqZTKyTo0nipBpR/kw2EL39BNE/nKiXTFGqOqvdqacsPnNAfc2PQYdPJI
         MEJj+v0pdjxSi0uqx0k32unpKqynZeo1vQ3Kwiw6YF27NZOam2rHqNnSC22ThKrhYuvZ
         /02BmQYHb/4Z2zC4hKLk4WEU0uC1FFDaFfxv0RmWaoVEvtrkJqLDy547vNJdDCwc6zVO
         u/NtlQv8VPgm23e0CJW7gSsAt4qW3ErYWCSu3+hm6pMyevwE55Kqj/loTa/M7Nv9lZ17
         5yvw==
X-Gm-Message-State: AOAM530sSQqkxdPHH9SU6bXqDgq2g7G3MjbAb5HErDuGawwPf6ymYBG9
        yAwEbzXXs2y7y3NVK4Z2tfQMJ8eitaf+H0KFukDVOhaFzpApqTb/OtcbTyt2m4/ALuK6FQkggn+
        bTaH8uxcCn75N9hvPsWPUeoujBBSYr+iuZE0hyS6UBw==
X-Received: by 2002:a05:6402:5209:b0:412:7cd8:a8fc with SMTP id s9-20020a056402520900b004127cd8a8fcmr343340edd.51.1645635859398;
        Wed, 23 Feb 2022 09:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKr+v6ocNLmVN3Di+yw0uJzDvkvv4Lb5lc33wOhtzJOFkvu7xL2E/jifTka6zh9g0DFLs/uA==
X-Received: by 2002:a05:6402:5209:b0:412:7cd8:a8fc with SMTP id s9-20020a056402520900b004127cd8a8fcmr343312edd.51.1645635859189;
        Wed, 23 Feb 2022 09:04:19 -0800 (PST)
Received: from [192.168.0.126] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id fy37sm73162ejc.219.2022.02.23.09.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:04:17 -0800 (PST)
Message-ID: <7fcd5ed9-4577-950a-0cdc-22917e8e26af@canonical.com>
Date:   Wed, 23 Feb 2022 18:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFT PATCH 0/3] Fix kfree() of const memory on setting
 driver_override
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
 <708eabb1-7b35-d525-d4c3-451d4a3de84f@rasmusvillemoes.dk>
 <afa7001d-901e-55bf-b8dc-77051b1e7f78@canonical.com>
 <0442526f-b6d9-8868-ac1c-dd11a2d3b2ab@arm.com>
 <636e5b92-8ed8-35a1-d6e9-516d5b35be91@canonical.com>
 <e0bc8dd2-bea9-354b-3b48-3123e0bbf717@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <e0bc8dd2-bea9-354b-3b48-3123e0bbf717@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 16:08, Robin Murphy wrote:
> On 2022-02-23 14:22, Krzysztof Kozlowski wrote:
>> On 23/02/2022 15:04, Robin Murphy wrote:
>>> On 2022-02-22 14:06, Krzysztof Kozlowski wrote:
>>>> On 22/02/2022 14:51, Rasmus Villemoes wrote:
>>>>> On 22/02/2022 14.27, Krzysztof Kozlowski wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Drivers still seem to use driver_override incorrectly. Perhaps my old
>>>>>> patch makes sense now?
>>>>>> https://lore.kernel.org/all/1550484960-2392-3-git-send-email-krzk@kernel.org/
>>>>>>
>>>>>> Not tested - please review and test (e.g. by writing to dirver_override
>>>>>> sysfs entry with KASAN enabled).
>>>>>
>>>>> Perhaps it would make sense to update the core code to release using
>>>>> kfree_const(), allowing drivers to set the initial value with
>>>>> kstrdup_const(). Drivers that currently use kstrdup() or kasprintf()
>>>>> will continue to work [but if they kstrdup() a string literal they could
>>>>> be changed to use kstrdup_const].
>>>>
>>>> The core here means several buses, so the change would not be that
>>>> small. However I don't see the reason why "driver_override" is special
>>>> and should be freed with kfree_const() while most of other places don't
>>>> use it.
>>>>
>>>> The driver_override field definition is here obvious: "char *", so any
>>>> assignments of "const char *" are logically wrong (although GCC does not
>>>> warn of this literal string const discarding). Adding kfree_const() is
>>>> hiding the problem - someone did not read the definition of assigned field.
>>>
>>> That's not the issue, though, is it? If I take the struct
>>> platform_device definition at face value, this should be perfectly valid:
>>>
>>> 	static char foo[] = "foo";
>>> 	pdev->driver_override = &foo;
>>
>>
>> Yes, that's not the issue. It's rather about the interface. By
>> convention we do not modify string literals but "char *driver_override"
>> indicates that this is modifiable memory. I would argue that it even
>> means that ownership is passed. Therefore passing string literal to
>> "char *driver_override" is wrong from logical point of view.
>>
>> Plus, as you mentioned later, can lead to undefined behavior.
> 
> But does anything actually need to modify a driver_override string? I 
> wouldn't have thought so. I see at least two buses that *do* define 
> theirs as const char *, but still assume to kfree() them.

I think the drivers/clk/imx/clk-scu.c (fixed here) does not actually
need it. It uses the feature to create multiple platform devices for
each clock, with unique names matching the clock (e.g. pwm0_clk,
pwm1_clk) and then bind all them via common clock driver.

It looks therefore like something for convenience of debugging or going
through sysfs devices.

Removal of driver_override from such drivers is a bit too much here,
because I would not be able to test it.

> 
>>> And in fact that's effectively how the direct assignment form works
>>> anyway - string literals are static arrays of type char (or wchar_t),
>>> *not* const char, however trying to modify them is undefined behaviour.
>>>
>>> There's a big difference between "non-const" and "kfree()able", and
>>> AFAICS there's no obvious clue that the latter is actually a requirement.
>>
>> Then maybe kfreeable should be made a requirement? Or at least clearly
>> documented?
> 
> Indeed, there's clearly some room for improvement still. And I'm not 
> suggesting that these changes aren't already sensible as they are, just 
> that the given justification seems a little unfair :)

Yeah, maybe also my "const" in the title and commit is not accurate. I
think that literal strings are part of .rodata (and objdump confirm)
thus are considered const.

> Even kfree_const() can't help if someone has put their string in the 
> middle of some larger block of kmalloc()ed memory, so perhaps 
> encouraging a dedicated setter function rather than just exposing a raw 
> string pointer is the ideal solution in the long term.


Best regards,
Krzysztof
