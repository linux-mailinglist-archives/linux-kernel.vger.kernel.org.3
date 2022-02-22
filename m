Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F200B4BF24A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiBVGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:53:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiBVGxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:53:04 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB9107093;
        Mon, 21 Feb 2022 22:52:40 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id gb39so39867699ejc.1;
        Mon, 21 Feb 2022 22:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3KiCNnYtMhTLO7dCmwg9IIrAqJrsqdSjvq0y9ThzW3A=;
        b=q/n9mh0+hiON9h0IldQnRM29vWge+oirNXveVqjpB9YEMryS2iXov7lnRLLe28tigX
         GzH90/GBazpO1Mhb1sO2C4FhAJD/VhbvdD05LYkp7DhRueSgnrOXmxubILuSyX1XcFFk
         obwxsPTY07j+Qn9vAqSGe6rl5rbvCI5QFxu3deiBrvPB6a5GYXcgbaxG1QhQDSUjRe++
         gmxFYrUVX62sJnPxxm71+C0D9FtOOvpfHZSM7sqpBZQDD6tAa4rUuJolfV1JdYEcmm5M
         KY/hIMw17V4y3CoWAYy69jeQ7HvXd4eNJLuuVxh0Y2NnC/BqvOXsF/PQI3hSvtU53pJU
         zCwg==
X-Gm-Message-State: AOAM530RRnCU+bHqRuJ0QXX7N2tKZqSAu3n1GvgHrjRgF7YEmqfqLMP8
        hnZIP6h5SO5xmeLtd/z+QnEc51Z6Y2Fw5Q==
X-Google-Smtp-Source: ABdhPJxaNpxWuhXmRofT3wJpeWaHuFbVIMpSvbMGv/p8Z6rw6Rn6E3NujCb1HmmwnDPwMni0Rfncsg==
X-Received: by 2002:a17:906:8493:b0:6ce:710:3739 with SMTP id m19-20020a170906849300b006ce07103739mr18139821ejx.409.1645512758577;
        Mon, 21 Feb 2022 22:52:38 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e27sm6089342ejm.18.2022.02.21.22.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 22:52:38 -0800 (PST)
Message-ID: <8c65bc42-438e-bf3e-fb76-2a4cbc7296c0@kernel.org>
Date:   Tue, 22 Feb 2022 07:52:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
 <20220222011433.8761-2-LinoSanfilippo@gmx.de>
 <e883ccb5-68ea-f802-e4fd-864672d8ad7b@kernel.org>
In-Reply-To: <e883ccb5-68ea-f802-e4fd-864672d8ad7b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 22, 7:51, Jiri Slaby wrote:
> On 22. 02. 22, 2:14, Lino Sanfilippo wrote:
>> Several drivers that support setting the RS485 configuration via 
>> userspace
>> implement one or more of the following tasks:
>>
>> - in case of an invalid RTS configuration (both RTS after send and RTS on
>>    send set or both unset) fall back to enable RTS on send and disable 
>> RTS
>>    after send
>>
>> - nullify the padding field of the returned serial_rs485 struct
>>
>> - copy the configuration into the uart port struct
>>
>> - limit RTS delays to 100 ms
>>
>> Move these tasks into the serial core to make them generic and to provide
>> a consistent behaviour among all drivers.
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>> ---
>>   drivers/tty/serial/serial_core.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c 
>> b/drivers/tty/serial/serial_core.c
>> index 846192a7b4bf..2b3afe038c1c 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -42,6 +42,11 @@ static struct lock_class_key port_lock_key;
>>   #define HIGH_BITS_OFFSET    ((sizeof(long)-sizeof(int))*8)
>> +/*
>> + * Max time with active RTS before/after data is sent.
>> + */
>> +#define RS485_MAX_RTS_DELAY    100 /* msecs */
>> +
>>   static void uart_change_speed(struct tty_struct *tty, struct 
>> uart_state *state,
>>                       struct ktermios *old_termios);
>>   static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
>> @@ -1282,8 +1287,32 @@ static int uart_set_rs485_config(struct 
>> uart_port *port,
>>       if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>>           return -EFAULT;
>> +    /* pick sane settings if the user hasn't */
>> +    if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
>> +        !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
>> +        pr_warn("invalid RTS setting, using RTS_ON_SEND instead\n");
> 
> Can't we have a device prefix here, so that everyone knows what device 
> is affected? Without that, it's not that useful. At least port->name & 
> port->line could be printed. The uart core uses dev_* prints, but prints 
> also line as uport->dev can be NULL sometimes.

And this comes from userspace, so should be ratelimited.

-- 
js
suse labs
