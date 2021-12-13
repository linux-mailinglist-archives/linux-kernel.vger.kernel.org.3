Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B429472E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhLMN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhLMN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:58:31 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D9C06173F;
        Mon, 13 Dec 2021 05:58:31 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so17482606otl.8;
        Mon, 13 Dec 2021 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mBLhz6A6Q0VH5JV+eiVr4N7Gacdp/EmRBkeIUehBuAc=;
        b=Lg4T2IY/D/+51o/rU3Rn2puW7wvH+vbgG3k4avOz/pd8ff489KMUuPsGzj7CHvf3q2
         PlXXIVx0CL3/EWPngY/29y405spODVh6pnVHcREmAKSF0DCYlyOGuOtIX1esKbjbql9N
         MTT2zUcgYJg0q4c4/A4g5HIv30VoQ7eSBu/AKpP9YL7BUmTk3KJ3Y6RjGn1HnFgdlpz3
         TVhJ6nf54te0PQFxenL23uy1rEf4vUljFM9OnRMhemaTGg3Q8UFXWM2WkzMzZEbLahQv
         ySJfJ25TnTHxsVIFzt8X4O0Q9FwAuBKIKJ7hBnknFk4mXGj/hvVEMHO2ymO0XaVcHPdB
         0EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mBLhz6A6Q0VH5JV+eiVr4N7Gacdp/EmRBkeIUehBuAc=;
        b=UF5WmFGPa9ouOX45WrZrPoPC5KuLeI/9NXZOeGu5rEYHgFRatFboUwLKLhOjnQHC0h
         dQrMUOUfJ4Uos2jrf4aBfYdF+vXc+NzlRohRYnIJ7dxF6yIEKgppXfBdhsIrjn7BXHSw
         eut87u1vfM6T20cbdPtkmEMMwbgXf7JUqQVMDKSna5xrTrA1WXJGkyXHx0StvefZec2t
         s6FCHI+kQQlWJdZQigRQs7ATcZtjteRZCJXXCExLsnmK9A8WyZqqrVDjzD0j2eTWTMeE
         D59M9af8YAbh2qawESpfWLYH4WtH9b8SEHYEE1f2b354uCk/r0BgrI2LlZdzaGtLn93U
         T4FA==
X-Gm-Message-State: AOAM531n2qpR24VAFqhBpXXD+4J7WRtyFGtXeuF4Q0eLCsSfrV3VLHw4
        zzU7syDanoTfDdEzgY59FQth2CcGJE4=
X-Google-Smtp-Source: ABdhPJyD6v5hbaxoafWopasqzuNC7C2S8LEhwf6aPAvlK/StZtDUj3fikYssXd7JEJ3/Iy95vY5w2g==
X-Received: by 2002:a9d:12c:: with SMTP id 41mr25283367otu.322.1639403910194;
        Mon, 13 Dec 2021 05:58:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22sm2317352ooj.8.2021.12.13.05.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 05:58:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Message-ID: <03871bd3-ea78-52e1-f57b-3e35724c8934@roeck-us.net>
Date:   Mon, 13 Dec 2021 05:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 1:11 AM, Christoph Niedermaier wrote:
> Resend with [Klartext] to turn off TLS encryption.
> 
> From: Adam Thomson
> Sent: Monday, December 6, 2021 5:38 PM
>>> Thanks anyway, so now I know it must be
>>> problem with my DA9061 chip.
>>>
>>> @Adam
>>> Where can it come from?
>>> Can you give we a hint what to check?
>>
>> I've spoken internally and have been informed that this is down to the fact that
>> DA9061 runs only from an internal oscillator which may be slower. The indication
>> is that the values for TWDSCALE describe the window where if a kick/ping occurs
>> within that period then the watchdog is guaranteed *not* to timeout. The actual
>> timeout would be at some point after the selected timeout period, assuming no
>> ping/kick occurred.
>>
>> Table 8 in the datasheet specifies a minimum watchdog timeout of 2.5s (tWDMAX)
>> under specific operating conditions, so if the minimum 2s window was chosen
>> (TWDSCALE = 1) then earliest the watchdog would actually timeout, following a
>> ping, is 2.5s, assuming the conditions matched those described.
>>
>> If you have further questions it probably makes sense to contact Dialog/Renesas
>> support as they will be able to provide more detailed info on this.
> 
> So a DA9061 runs only from an internal oscillator, whereas a DA9062
> can run on either an internal or an external oscillator. So this
> means that the DA9061 timeout values are differ from the DA9062
> with an external oscillator not only on my device but on all DA9061
> devices.
> 
> This are the values (in seconds) in comparison:
> DA9062 (from driver): 0  2  4   8  16  32  65 131
> DA9061 (measured):    0  3  6  12  25  51 102 204
> =================================================
> Difference:           0 +1 +2  +4  +9 +19 +37 +73
> 
> In my opinion, the differences in the higher values are very huge.
> If I expect that the watchdog triggers and I have to wait more than
> a minute for that to happen I ask myself is there something wrong.
> 
> @Andrej
> I guess, you are using an external oscillator, aren't you?
> 
> @Adam
> Is there a way to check in the driver which oscillator is in use?
> 
> @Maintainers
> Is in the driver a need to distinguish between an external and an
> internal oscillator to get the timeout values more accurate?
> 

It would be very desirable to get timeout values more accurate.
I would not want to dictate how to implement it, though.
It could be automatically detected if that is possible, there
could be a devicetree clock property providing the clock
frequency, or maybe there is some other solution.

Guenter
