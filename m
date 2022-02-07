Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149554ACB19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiBGVSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiBGVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD4D8C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644268706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohHLwvfKybaizfnGYVN/UXzGqRLg0cSkCpnNJnPKHFA=;
        b=fvTLslRYS2TOXm6LubA06kZlXdpziZqzEJ9RkB6Hiig4U/pGC3RH4HhWT+rDwydomTdaCo
        j/tgcLj3189VmATk1VjjMnEWj73vy7BQ2IYejHnJ/PAocjFTgC6A1tw1x/OkbOi4+mqHzS
        NxEutgK8FqQM0R0JAW4GVqvoFTf/lQ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-JwOjyAB3NT2j4kBAzVA3NQ-1; Mon, 07 Feb 2022 16:18:24 -0500
X-MC-Unique: JwOjyAB3NT2j4kBAzVA3NQ-1
Received: by mail-ej1-f69.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso4842035ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ohHLwvfKybaizfnGYVN/UXzGqRLg0cSkCpnNJnPKHFA=;
        b=XJP8S/j/WkAagcrXwGxvp99Tf+mDiF/PkUELRdJ+D58PBpAR/Mi8Ky10gROFzEtHYv
         EbUjPiW3RGOfQnCrJHfWFeHIgIQtrVkNWW4enKVIPPjo8H1/rcYkCe9hQiYJP/ENn9TH
         LbgmAG0D4Fc1J438SoFQAjSH/Xt2mXqS9YB7+u3JpdWGxPMNg04xMAIXQpth/biVh7Ay
         YifAMs/yNxU1W0Cx/+5pU5u5jsbG5n7UWa9ZLStpIl4HP5CERcmB4ivbE89MBRTnqcb+
         ylJuTgK+ArbkRZ/aaFqR1ExoP1mcbzZcVQulOqkGuDvpkeSpwZDHhQ5St5Sx3Jl4HFxL
         y/rw==
X-Gm-Message-State: AOAM532LYFk1Mjgb6ZpWvKm86cu8MWO6/+SoHqiGI0uanxKIugA5V7Zl
        xfbQkBkw4sniHnevde2GeHGonR0eZvr9u58jfaGeIpyhOVKH7ZLpuJO/Vi1mwmUnWey4NRhbpsq
        c7EDA6K9Lrz4hyl77Wf3agR5M
X-Received: by 2002:a17:907:9619:: with SMTP id gb25mr1212912ejc.426.1644268703061;
        Mon, 07 Feb 2022 13:18:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZe2JkZub/2BYBuTaJ/HdswW1ZYVXvc4hVXxTGdgwS6QDiEMeoDgIzND6l3DhQ9+hYI23aZA==
X-Received: by 2002:a17:907:9619:: with SMTP id gb25mr1212905ejc.426.1644268702873;
        Mon, 07 Feb 2022 13:18:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c25sm5672738edu.103.2022.02.07.13.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:18:22 -0800 (PST)
Message-ID: <9d2f23e3-712e-5df2-28a5-2779a107759c@redhat.com>
Date:   Mon, 7 Feb 2022 22:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Content-Language: en-US
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <markgross@kernel.org>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
 <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
 <b0642e67-7752-8d27-9e67-7e9a493adb08@o2.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b0642e67-7752-8d27-9e67-7e9a493adb08@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/22 20:31, Mateusz Jończyk wrote:
> W dniu 07.02.2022 o 19:51, Hans de Goede pisze:
>> Hi,
>>
>> On 2/7/22 19:29, Mateusz Jończyk wrote:
>>> In Kconfig, inside the "Processor type and features" menu, there is
>>> the CONFIG_I8K option: "Dell i8k legacy laptop support". This is
>>> very confusing - enabling CONFIG_I8K is not required for the kernel to
>>> support old Dell laptops. This option is specific to the dell-smm-hwmon
>>> driver, which mostly exports some hardware monitoring information and
>>> allows the user to change fan speed.
>>>
>>> This option is misplaced, so move CONFIG_I8K to drivers/hwmon/Kconfig,
>>> where it belongs.
>>>
>>> Also, modify the dependency order - change
>>>         select SENSORS_DELL_SMM
>>> to
>>>         depends on SENSORS_DELL_SMM
>>> as it is just a configuration option of dell-smm-hwmon. This includes
>>> changing the option type from tristate to bool. It was tristate because
>>> it could select CONFIG_SENSORS_DELL_SMM=m .
>>>
>>> When running "make oldconfig" on configurations with
>>> CONFIG_SENSORS_DELL_SMM enabled , this change will result in an
>>> additional question (which could be printed several times during
>>> bisecting). I think that tidying up the configuration is worth it,
>>> though.
>>>
>>> Next patch tweaks the description of CONFIG_I8K.
>>>
>>> [snip]
>> For other reviewers, the only consumer of the CONFIG_I8K
>> option is drivers/hwmon/dell-smm-hwmon.c
>> which has a couple of:
>> "#if IS_ENABLED(CONFIG_I8K)" checks to enable its old
>> legacy /proc/i8k interface.
>>
>> So this move definitely makes sense.
>>
>> I wonder if it would not be better to just completely drop
>> the old  /proc/i8k interface though ?
> 
> No!!! I use it. The problem is that the laptop (2010-ish Dell Latitude E6500)
> has only three fan power levels: off, mild and full. So I think it is
> not well-suited to traditional fancontrol. On the other hand,
> i8kmon (slightly modified), which is designed for a small number of fan power levels,
> works well.

Ok, I was wondering if there would still be any users and
usually the best way to find out is just remove something
and revert the removal if it turns out there are still users...

But since you still use it the question if there are still
users is answered now :)

Regards,

Hans

