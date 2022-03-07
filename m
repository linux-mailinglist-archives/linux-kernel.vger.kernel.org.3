Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB34CF2EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiCGHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiCGHua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:50:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD85FF36
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:49:36 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 774843F610
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646639375;
        bh=rd6EmrXOsv2ONR5N0p94ALT/TAYWHPAB/WPREXa/y6M=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=p1SYBMoOrpa6oAUh8SyJynWQnczgDt6lAuG7WN5Mcaj9EfebfKzu9GG8Q8qzWXZZO
         JbeFWOeFoFx+DdTtEMNzGwyTkoLDKwXAlJaczXWYjWeMDi8jOE5SyJ1vI0paWrRp0P
         a/Mm3XMFHcxdFn8mI5II/qQToQLm6NVhErIDnfcRuquOMeYTt0AXJa8qrKv4e3mjRL
         W5u4ysDD/lDZ8SjejdEcgnWSZAHcoK4TyQtkujzUqqrye97HVjtI/xsSUk7HOQs4xx
         h3Yf8RqTARcDg83R6cE1lenslJRdL/kinM50adWi3nrJoK+auVf53VupbELrK0MCDP
         cDD+E2O4Ir7Ag==
Received: by mail-ej1-f69.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso4814440ejf.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rd6EmrXOsv2ONR5N0p94ALT/TAYWHPAB/WPREXa/y6M=;
        b=7wZxhf1VAE+56gdEgkEB3t8M+FIo1gZvUGs07aLiyS5pL51LVd6mOG3I1X8Ey1B+Ij
         qHAySIU4wOJmVikXA17mQAy6HEr0/Zk2WFXWm5XDVeSOs9dZF7UL+gmI0PFD0KZjLuju
         HZNs+vS+bBwm+XOx2j4sbu+zdvIIe+JfWzSe4swKo6ZJ9dap3fTg1Tg62wpeQkz8EDQ9
         242YjKIKEWchZGSwL6O8Pz/rAEtrD5NIJ1v9cIN81V27TLlwurQFoN9qDn2c9MSWqP1U
         o0NxO1dWUVHRXtrTQHmf7KrcxsD2UGBP9fBK64OjOjGZcszTB7PUI3ZskgAP3zVi3B5o
         Yw4w==
X-Gm-Message-State: AOAM533Qz7TNHQANwr+wCUCxrpKIFhHgIfPybf28/1q/Y2yyEb/OV7Kw
        n9PKRVzeOnw5WPDUsNO2Yw+jMqcdrRFfJkMKozokBiIEY0GVvSI35d5DzvNH2yhNZ0FAlAu6pfj
        X+YDrzJBuyz/LukYy8rwesC5aj4YKF/LDG8UMFy9FHg==
X-Received: by 2002:a05:6402:2810:b0:415:ff8b:cd2a with SMTP id h16-20020a056402281000b00415ff8bcd2amr9750567ede.333.1646639375145;
        Sun, 06 Mar 2022 23:49:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZm160P/v8ozuwvy5s4y7drXuxfDWxzLK87Od19lQUI0so3eyuu8eX9FSTrIjnkS1XJzmJHw==
X-Received: by 2002:a05:6402:2810:b0:415:ff8b:cd2a with SMTP id h16-20020a056402281000b00415ff8bcd2amr9750561ede.333.1646639375006;
        Sun, 06 Mar 2022 23:49:35 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm4393231eje.180.2022.03.06.23.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:49:34 -0800 (PST)
Message-ID: <0a3c099d-049b-d4d0-5a73-f1d93144e827@canonical.com>
Date:   Mon, 7 Mar 2022 08:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/7] tty: serial: samsung: constify
 s3c24xx_serial_drv_data members
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-5-krzysztof.kozlowski@canonical.com>
 <06f2b1a8-301e-6a54-50bb-58eca6b93850@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <06f2b1a8-301e-6a54-50bb-58eca6b93850@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 07:38, Jiri Slaby wrote:
> On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
>> The driver data (struct s3c24xx_serial_drv_data) is never modified, so
>> also its members can be make const.  Except code style this has no
> 
> s/make/made/ if you do a v2.

Sure, I'll send a v2.

> 
>> impact because the structure itself is always a const.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
>> ---
>>   drivers/tty/serial/samsung_tty.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>> index 279c413f2300..eecefff5c4a4 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
>>   };
>>   
>>   struct s3c24xx_serial_drv_data {
>> -	struct s3c24xx_uart_info	info;
>> -	struct s3c2410_uartcfg		def_cfg;
>> -	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>> +	const struct s3c24xx_uart_info	info;
>> +	const struct s3c2410_uartcfg	def_cfg;
>> +	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>>   };
>>   
>>   struct s3c24xx_uart_dma {
> 
> 


Best regards,
Krzysztof
