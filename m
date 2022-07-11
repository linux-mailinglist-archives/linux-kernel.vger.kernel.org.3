Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431855701BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiGKMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiGKMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C1E48E8C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657541403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZO1t8x1vKKXKqRlgpTXp1+pMPXfuqgvu4S1UnnB/Hc=;
        b=RtrTYJ4EJ75oP3jg1ay61c5ys6h4b0/EiZqn/5cYiGbW2uInalUUoSSMzi9R5h+lEKR4Rt
        WdJK9ecZlDpUYSCxYVSUaVADUfCSHpiY1IecCndNYtJv9r55uMyAI9w+uGmyUigp9tQWSv
        hO8flLwbXkFJUsft0Ln+nqKuF3xvNp0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-bUzbS4MrPt2u8HQEac6Lfg-1; Mon, 11 Jul 2022 08:10:01 -0400
X-MC-Unique: bUzbS4MrPt2u8HQEac6Lfg-1
Received: by mail-ed1-f71.google.com with SMTP id o13-20020a056402438d00b0043aa846b2d2so4002239edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zZO1t8x1vKKXKqRlgpTXp1+pMPXfuqgvu4S1UnnB/Hc=;
        b=GvKhmqHdd88EMkE9sC+xxaMeK3m10j4LCBtlLq+LY+EgmyCtE+4Vb3xnTE5XDiJFnt
         kjk9v4Ay03Sr7BDRSu5YR4VuAZzKvQCKg9VzTR4LiJiUkGu7Ml0TGxmdiq/tTL5a+/Sk
         CczBuP+Uj8lvMOKe0i3i+4WSMFMkeRJPX4ABtJ8r/KmX4lI8Z2/ZcwXUdYB/zaXUbYEg
         NXqH2YFrG+3QYQWozftL0eMB/Dx7oBHJOvoCUAJ5/0yb7ZHi0Fq3Td16melGAbknJKMj
         RUEX9MZ2nznHSudmKeenRJ8+E2rvLHfV8PXgL9K3Fk6QG6jkK4KykEkarPz3R7bzseW+
         0djQ==
X-Gm-Message-State: AJIora+XVHNCOf4sgYLjD0ji0LyZ76iduj9jvaiMJxY/JZ0FWlfRYntd
        ZGzSpJXhxg+8HpLTUuhZxndhjX4hVAc/z2Oa6tB8vQPDxK46c8smLuhQSSdkMpRL2Vf9aWV9VVC
        sfG3PXZWihqkvYZB1Bjw+J13m
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id w5-20020a05640234c500b0043a8f90e643mr24064575edc.88.1657541400742;
        Mon, 11 Jul 2022 05:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unc4Zn4OKThc2UuVsZ8zNRcENKGzVs1wpa6vNt9iTO0Lm22fWG7sRgAh0Do/nGeuAIxmuWeg==
X-Received: by 2002:a05:6402:34c5:b0:43a:8f90:e643 with SMTP id w5-20020a05640234c500b0043a8f90e643mr24064551edc.88.1657541400588;
        Mon, 11 Jul 2022 05:10:00 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s17-20020a056402037100b00437938c731fsm4242723edw.97.2022.07.11.05.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:09:59 -0700 (PDT)
Message-ID: <c89d39eb-17b9-8800-c8ff-8d236b80de2f@redhat.com>
Date:   Mon, 11 Jul 2022 14:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite Dragonfly
 G2
Content-Language: en-US
To:     Alex Dewar <alex.dewar@gmx.co.uk>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, markgross@kernel.org,
        "Lopez, Jorge A (Thin Clients)" <jorge.lopez2@hp.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
 <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
 <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
 <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <df7313597d2ac3212f10c05aa3d369728f030c86.camel@gmx.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 7/11/22 09:49, Alex Dewar wrote:
> Hi Hans,
> 
> On Sat, 2022-07-09 at 16:56 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/5/22 19:25, Alex Dewar wrote:
>>> Friendly ping? 🙂
>>>
>>> I'm also CC'ing the x86 platform people into this, as I'm not sure
>>> whether this problem is something more within their remit.
>>
>> Please test the atbkd device with "sudo evemu-record" or "sudo
>> evtest"
>> and if the brightness keys generate events there, write down the
>> raw event codes (MSC events).
> 
> I tried this but unfortunately this doesn't seem to be the whole story.
> If I press "decrease brightness" I get:
> Event: time 1657525393.922727, -------------- SYN_REPORT ------------
> Event: time 1657525397.043348, type 4 (EV_MSC), code 4 (MSC_SCAN),
> value 81
> Event: time 1657525397.043348, type 1 (EV_KEY), code 190 (KEY_F20),
> value 1
> Event: time 1657525397.043348, -------------- SYN_REPORT ------------
> Event: time 1657525397.050384, type 4 (EV_MSC), code 4 (MSC_SCAN),
> value 81
> Event: time 1657525397.050384, type 1 (EV_KEY), code 190 (KEY_F20),
> value 0
> 
> And if I press "increase brightness" I get:
> Event: time 1657525397.050384, -------------- SYN_REPORT ------------
> Event: time 1657525398.607184, type 4 (EV_MSC), code 4 (MSC_SCAN),
> value 81
> Event: time 1657525398.607184, type 1 (EV_KEY), code 190 (KEY_F20),
> value 1
> Event: time 1657525398.607184, -------------- SYN_REPORT ------------
> Event: time 1657525398.614190, type 4 (EV_MSC), code 4 (MSC_SCAN),
> value 81
> Event: time 1657525398.614190, type 1 (EV_KEY), code 190 (KEY_F20),
> value 0
> 
> There's no difference! And I also get the same thing if I press the
> *actual* mute mic button 😞.
> 
> Any ideas?

From this it looks like we need to use some other interface to get
these events (+ ignore the above events).

Do you have a "HP WMI hotkeys" device in your list of input
devices?  And are you getting any events on that ?

Likewise do you have a "Video Bus" device and any events on that ?

I've also added Jorge from HP to the Cc. Jorge, can you help with this ?

Regards,

Hans

