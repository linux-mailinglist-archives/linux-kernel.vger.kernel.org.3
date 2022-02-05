Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6574AA672
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 05:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379325AbiBEEaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 23:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiBEEaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 23:30:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E736C061346;
        Fri,  4 Feb 2022 20:30:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so1721102pjv.5;
        Fri, 04 Feb 2022 20:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=ULZ4mupthaZMgaibmp4OG2WYJdz6Bd+6gS+dmGIdwTQ=;
        b=j9qAotRGY/7fKs3UWaQ0fpx+2aDAmtUO0BCb56HWk4grGDuMdZWibXN6onB7r2P8Th
         RECzjqwUdgYy6uiMNAg/lBekmZZaoRPvC/mcCwr+7TXz1USNal5osLtyRjw3Pwdy7PXk
         9mS6bbubtRkGWVbicwUfr7GPE/i5OhbfiDHqlVAnUi8uDdlnbbrMYeNHQY9yInFqnWQ9
         HtkttX+YapE6mZaahJ3668jxF/bKAglpcFT7WS/iaMVeMp81VvslfJVD6pX1Ba99kU2Y
         Qf0c+CbkXWRxAl6JbJW5jfz+kE444tL6UF5fQnxhjT00u5r7JSN0eAzYnh/E4RLhNQ6p
         18ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ULZ4mupthaZMgaibmp4OG2WYJdz6Bd+6gS+dmGIdwTQ=;
        b=qSoezHZdIxfVMqyyqpXgVeydFFyjn9pp9xfC2rrKZMvuumcAbl+rAOWv8LY9s2QCdK
         FpupyoNurYrxWAMnVrCnxSOm1GUx79DZC5JoQ6ygdwhxRn1sCU5lPD0LB2ACZlidiqv7
         Ha5EmzhSHWX5wGDrCbza2ETkJGt1NDIGIeR7nXvS/FQf5KTWlFdjf5RoVP/SxdXmu5kx
         3luLL8R8h71APoTUcIIqll/QqfXJtKemhT5i6u+B6TD9aSwIpYbaKC5cQn4lJp4k28Rk
         htava9Vt8zVS0hwkiOM3y/Qm41PbbsAoCwkqej/F+5ezrM2c3soqXqs5NIPr1YSK5XbR
         sN0w==
X-Gm-Message-State: AOAM532vYbJrCmwZV+vkxAz5IExXWKQmu0LACHvTEB7uBHMXd7Tp9BBB
        Rr8QKYe4wFJImVY6ppKNcpE=
X-Google-Smtp-Source: ABdhPJwJX1Az1UyBa9GY+1a1lB82aokfjMozL/I3PzEefaueVHighT1EcehoNrH//oPTBaUPO8SHHA==
X-Received: by 2002:a17:902:8504:: with SMTP id bj4mr6593706plb.108.1644035408882;
        Fri, 04 Feb 2022 20:30:08 -0800 (PST)
Received: from [10.200.0.14] ([85.203.23.14])
        by smtp.gmail.com with ESMTPSA id h27sm2776413pgb.20.2022.02.04.20.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 20:30:08 -0800 (PST)
Message-ID: <97667b25-11e6-d918-2468-2cf17532c3ad@gmail.com>
Date:   Sat, 5 Feb 2022 12:30:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [BUG] tty: serial: possible deadlock in uart_remove_one_port()
 and uart_hangup()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
 <YfUPlYwoWpMjhvpR@kroah.com> <20220201090740.3816-1-hdanton@sina.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
In-Reply-To: <20220201090740.3816-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/1 17:07, Hillf Danton wrote:
> On Tue, 1 Feb 2022 14:51:09 +0800 Jia-Ju Bai wrote:
>> On 2022/1/29 17:57, Greg KH wrote:
>>> On Sat, Jan 29, 2022 at 05:34:05PM +0800, Jia-Ju Bai wrote:
>>>> Hello,
>>>>
>>>> My static analysis tool reports a possible deadlock in the tty driver in
>>>> Linux 5.10:
>>> 5.10 was released over a year ago and over 100 thousand changes ago.
>>> Please redo your check on 5.16 at the oldest.
>> My static analysis tool checks the tty driver in Linux 5.16, and also
>> finds this possible deadlock:
>>
>> uart_remove_one_port()
>>     mutex_lock(&port->mutex); --> Line 3032 (Lock A)
>>     wait_event(state->remove_wait, ...); --> Line 3034 (Wait X)
>>     mutex_unlock(&port->mutex); --> Line 3036 (Unlock A)
>>
>> uart_hangup()
>>     mutex_lock(&port->mutex); --> Line 1669 (Lock A)
>>     uart_flush_buffer()
>>       uart_port_unlock()
>>         uart_port_deref()
>>           wake_up(&uport->state->remove_wait); --> Line 68 (Wake X)
>>     mutex_unlock(&port->mutex); --> Line 1686 (Unlock A)
>>
>> When uart_remove_one_port() is executed, "Wait X" is performed by
>> holding "Lock A". If uart_hangup() is executed at this time, "Wake X"
>> cannot be performed to wake up "Wait X" in uart_remove_one_port(),
>> because "Lock A" has been already hold by uart_remove_one_port(),
>> causing a possible deadlock.
>>
>> I am not quite sure whether this possible problem is real and how to fix
>> it if it is real.
>> Maybe we can call wait_event() before mutex_lock() in
>> uart_remove_one_port().
>> Any feedback would be appreciated, thanks :)
>>
>>
>> Best wishes,
>> Jia-Ju Bai
> Hey Jia-Ju
>
> Thank you for reporting it.
>
> In uart_flush_buffer(), uart_port_unlock() pairs with uart_port_lock()
> which bumps refcount up. OTOH no wakep is needed without refcount
> incremented, so the wakeup above in the hangup path is not waited for
> in the remove path.

Hi Hillf,

Thanks for the explanation :)
So I wonder which wait_event() can be paired with 
wake_up(&uport->state->remove_wait) in uart_port_deref()?


Best wishes,
Jia-Ju Bai
