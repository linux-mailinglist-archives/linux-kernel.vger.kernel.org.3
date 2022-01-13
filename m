Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97648D4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiAMJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:08:17 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43643 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiAMJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:08:14 -0500
Received: by mail-ed1-f47.google.com with SMTP id m4so20460216edb.10;
        Thu, 13 Jan 2022 01:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wC2KgNOyavftb+JH6q0bbSSTyPPUp1FHUEoqTU+2oII=;
        b=SOnD2sGfqZsRZXBYWXVODzMnFQBlc4FE4Hi5xuglrYlrAadZlzgCX6k/kkBP1zAOM2
         gKoUEs7xA2EiPxI912UDla9wOJOE6NzyHVRXoTIs7Bu6vwnFz/Xp2At4WeXLDA3nGMEv
         7UUzfX19eKfMMf1gbFPOzoVC0hzNoFoGPNz2A/qyLCcJhFX864BcNJonImNCPRRCCYdF
         qiy+FCCB+Fe1uKeUBxf1YYJH+S1b6vuiixcPFHQEa/8UK62zckClf3PpUg+fSx1QCeWO
         fjSf+F4yl4eQQHVwBLMGkavF8zmendCk8krhUqddO/YnNdQtVIXVUV8KhFwOUD8Aalhy
         9ffA==
X-Gm-Message-State: AOAM5329hbOFW6d+UrKbMlWMOTfdlwsJvDhXLxz2ebMHFDGSq/tx/we5
        sO1ZCpAMLR2skfNoXgM0Oaw=
X-Google-Smtp-Source: ABdhPJxDvbw8uDi/CZCHdNVb8ZF0cm/dXO5wxlQuyJkPUYQmVI9ihlrf7qz1xLinH94LB5ZX9C933w==
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr3235992edy.353.1642064893088;
        Thu, 13 Jan 2022 01:08:13 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id 20sm656699ejy.105.2022.01.13.01.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 01:08:12 -0800 (PST)
Message-ID: <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org>
Date:   Thu, 13 Jan 2022 10:08:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Content-Language: en-US
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com>
 <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 22, 9:54, hammer hsieh wrote:
>>> +static void sunplus_shutdown(struct uart_port *port)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&port->lock, flags);
>>> +     writel(0, port->membase + SUP_UART_ISC);
>>> +     spin_unlock_irqrestore(&port->lock, flags);
>>
>> I asked last time:
>> * What bus is this -- posting?
>>
>> You replied:
>> * Here just clear interrupt.
>> * Not really understand your comment?
>>
>> So I am asking again:
>> What bus is this? Isn't a posted write a problem here? I mean, shouldn't
>> you read from the register so that the write hits the device? That
>> depends on the bus this sits on, so just asking.
>>
> 
> Each UART has its own ISC register.
> Ex.
> dev/ttySUP0 base_adr = 0x9C00-0000 , isc_addr = 0x9C00-001C
> dev/ttySUP1 base_adr = 0x9C00-0080 , isc_addr = 0x9C00-009C
> dev/ttySUP2 base_adr = 0x9C00-0100 , isc_addr = 0x9C00-011C
> dev/ttySUP3 base_adr = 0x9C00-0180 , isc_addr = 0x9C00-019C
> dev/ttySUP4 base_adr = 0x9C00-0200 , isc_addr = 0x9C00-021C
> So sunplus_shutdown() just simply turn off its own device isc only.
> That's why I didn't read register value, just write 0 for it.

Could you explain me what posted write is and how does it not matter in 
this case?

thanks,
-- 
js
suse labs
