Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD314F4937
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiDEWG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443488AbiDEPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F57814CD06
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649166984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfhShkJ9GGB5NMk/Kf+P1wbpLhxJJWK4mdwN+7tkv6Q=;
        b=MhuXQfR9l26DRkaHKeIvxbMEoCJ0S16iWjCL/7+FQ5+bakMoUipP6CeI5NJDU15HvZ+c6U
        tRV0hLuPwDme5fb1/yfiwDjHxjBeTgk477iAOG8mrm6uan88Wnl4rGrbyO2J/tvFB+mvsb
        OhkdAq8VtS+t83J8bB9h/V7lXxWDoQ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-kuWlvZZdPZ-geokm6EsfCw-1; Tue, 05 Apr 2022 09:56:23 -0400
X-MC-Unique: kuWlvZZdPZ-geokm6EsfCw-1
Received: by mail-ej1-f72.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so6379885ejw.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cfhShkJ9GGB5NMk/Kf+P1wbpLhxJJWK4mdwN+7tkv6Q=;
        b=YK1YUSfzN+FmFQwAfmzPtRXQlohqSl+ao+ETXf4dwN6S56Sost4y5iZEALxKHvyaGN
         UFij8+PrANl5mvupjKawOWouZN1FVNcb/DXmSXp6uL/uCM1ZDRAe+dCIX2/Fjpc6X+VU
         02XJQSg5G4N9uLHYzYodlx57vffnd88jn8MPy0HAXOx/FLrkgEDG4peV+3wX8CxtvdUn
         gQranxRn1VGpec6ezC9kMSKIlRm/RwbHA4jLFACQNGP7/f3PYpWO9jXGGRh1dx77HooQ
         Gg43Rkse1s5aja6OchoFrli2UwUvUjxnES1xEaUY7iMuRkDF3clGg0pdIWxt2kCHzt1B
         e2HQ==
X-Gm-Message-State: AOAM530Jcmc1el1CbXDy64wxo3ZBZunGgLswPniQ1oatxOOPGcnK+4Av
        w1BB+I4SsmPj+cjWcWgCLUDgY9adJlD+CafsMwmDrLEy/HEWXIpvmJv4X5SJn+pt8TwjU6u480e
        N8qb5ZECS/6fx5Q/z7wfP+ngX
X-Received: by 2002:a17:907:3f92:b0:6e7:2ad3:a92b with SMTP id hr18-20020a1709073f9200b006e72ad3a92bmr3830791ejc.239.1649166982509;
        Tue, 05 Apr 2022 06:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx69MGrYFiX2diEdHGCV1GaeBoAESL3VkLvFfkO+94ucsSVEn/t7bVB93+D7yDW19qjYnxehg==
X-Received: by 2002:a17:907:3f92:b0:6e7:2ad3:a92b with SMTP id hr18-20020a1709073f9200b006e72ad3a92bmr3830772ejc.239.1649166982285;
        Tue, 05 Apr 2022 06:56:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm5576897ejy.87.2022.04.05.06.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:56:21 -0700 (PDT)
Message-ID: <6b61410d-ce1e-e84c-4a4e-aa3b22f3dc89@redhat.com>
Date:   Tue, 5 Apr 2022 15:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Make headphone work on Huawei Matebook D15
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <cover.1649147890.git.mchehab@kernel.org>
 <168fe6c3-6a7d-4019-16e3-066caf394b8a@redhat.com>
 <20220405154816.5cfdc49c@coco.lan>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220405154816.5cfdc49c@coco.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/5/22 15:48, Mauro Carvalho Chehab wrote:
> Em Tue, 5 Apr 2022 11:00:44 +0200
> Hans de Goede <hdegoede@redhat.com> escreveu:
> 
>> Hi,
>>
>> On 4/5/22 10:44, Mauro Carvalho Chehab wrote:
>>> At Huawei Matebook D15 two different GPIOs are used to control the output:
>>> 	- gpio0 controls the speaker output;
>>> 	- gpio1 controls the headphone output.
>>>
>>> Changing both at the same time cause spurious events that are mis-interpreted
>>> as input events, causing troubles on apps. So, a delay is needed before turning
>>> on such gpios.
>>>
>>> With this patch, plugging a headphone causes a jack event to trigger the speaker
>>> supply, powering down the speaker and powering up the headphone output.
>>> Removing the headphone also triggers the power supply, powering up the speaker
>>> and powering down the headphone.
>>>
>>> Mauro Carvalho Chehab (2):
>>>   ASoC: Intel: sof_es8336: support a separate gpio to control headphone
>>>   ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio  
>>
>> There is something weird with the patches here, at least for me in Thunderbird
>> both patches show up as nameless attachments to emails with empty bodies.
> 
> Weird... I tested here on Thunderbird (Fedora 35), reading it from the ML
> and they opened ok here.

Yes I checked lore.kernel.org and they look fine there, so as you
said: weird.

> There *is* an issue on such patches though: they ended using my past
> e-mail :-) 
> 
> I'll re-send those with your ack using the right SoB/From
> mchehab@kernel.org.

And in the resend they look fine in my Thunderbird too.

Regards,

Hans

