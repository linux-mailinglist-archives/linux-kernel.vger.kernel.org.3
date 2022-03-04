Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558134CDEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiCDULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiCDUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:08:45 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BF23A1B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:04:26 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so8256765otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=7J5xZolceiL495PA4LrptiYb01qKHBDWhuLdkam6bj8=;
        b=UQRxHd9yjv5NrGtZb3wTkZO/S0f+DyyHvqEsmvjMk1Oqg2H+t5Sd6EeC817WdlDGFF
         XBu43L6pggqUtK+nLbo2lWpai+HHZx0LJJxLDXQrNBkiJWRGPkTWBTTh8skHtUcPrfH5
         ISCe+OeKtoGySHbXyENb+bEbJsExQQZBEBn4pTEECbf7gqa6JJwGXVcXXnN7wwB0/2nL
         HV6XFHFiRGObYfxH040xH/AbI41TUzsPFwGXV4esGyDmuVLxYuWUVVibQ/RuFpizrvdM
         5A86kdABWi+aTNgBrC62Meg9ld6ypQ0RXIipwphoZnxcLeU79EPRf3CkY/Pk57hrXTDJ
         WEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=7J5xZolceiL495PA4LrptiYb01qKHBDWhuLdkam6bj8=;
        b=pt4U7C7e+HfCcj+3fygLcdORPxQaHTkcyhx6jJSdNba+2bJwgiSbT6/XcSMY7d71/G
         GkVjbipkZdfNlEnmBD6uxwpW1xBKL+K5wkQ+XsXj2GNQ4zSoVnrs9KtzGdoamx7lfdTS
         XaJnno8ENLT3PbtUJVWzdtJDzzkXweaR1MOsgom0+oEUZWXeL1Wpig50mZK7fvdMCaw8
         qZT+j4VIEceXd1L5i4VvdFJK7tkV9fVQOOt8n9hJpVXSAic2/93nLav2wTPbD+6eCkd9
         m94Mlg3nuMIJ11/ULklr5vGgjq6ao8+Wi30q9kLrm3EzgyoK1FxOLF7HKG8pGke2xnWh
         WNWg==
X-Gm-Message-State: AOAM5315vxXeZCNHUfWIZzyUbI2WrM/Ol27wC2HkZcBK8L3y5E4gPptb
        ii1T232zz4hlK2K4LgtUMFMJfi2iSIc=
X-Google-Smtp-Source: ABdhPJxfegI64M6j8rtErGH0VoGb2dwzS4/4bmu63bVt8mFLR2+HcBhmQZ9Kb8OYw4J0dH0VBJfEHg==
X-Received: by 2002:a9d:6e09:0:b0:5ad:1fcd:bfd0 with SMTP id e9-20020a9d6e09000000b005ad1fcdbfd0mr181791otr.312.1646424264609;
        Fri, 04 Mar 2022 12:04:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v7-20020a4aa507000000b0031c01a4ef37sm2652822ook.32.2022.03.04.12.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 12:04:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc6d94ff-4c06-8dcb-b53c-2ba7cd64ef7b@roeck-us.net>
Date:   Fri, 4 Mar 2022 12:04:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Roger Quadros <rogerq@kernel.org>,
        krzysztof.kozlowski@canonical.com, vigneshr@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220220004415.GA1519274@roeck-us.net>
 <4bbe337e-8cd8-a4d6-303d-d5aa21bee2e0@infradead.org>
 <20220304165451.0129012e@xps13>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mtd: rawnand: omap2: Actually prevent invalid
 configuration and build error
In-Reply-To: <20220304165451.0129012e@xps13>
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

On 3/4/22 07:54, Miquel Raynal wrote:
> Hi Guenter, Roger,
> 
> rdunlap@infradead.org wrote on Sat, 26 Feb 2022 22:55:28 -0800:
> 
>> On 2/19/22 16:44, Guenter Roeck wrote:
>>> On Sat, Feb 19, 2022 at 09:36:00PM +0200, Roger Quadros wrote:
>>>> The root of the problem is that we are selecting symbols that have
>>>> dependencies. This can cause random configurations that can fail.
>>>> The cleanest solution is to avoid using select.
>>>>
>>>> This driver uses interfaces from the OMAP_GPMC driver so we have to
>>>> depend on it instead.
>>>>
>>>> Fixes: 4cd335dae3cf ("mtd: rawnand: omap2: Prevent invalid configuration and build error")
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Sorry for noticing that just now, but there is still a problem with
> this patch: we now always compile-in the OMAP_GPMC driver whenever we
> need the NAND controller, even though it is not needed. This grows the
> kernel for no reason.
> 

Sorry, you lost me.

> In fact, Roger once said:
> 
> 	"We will figure out how to enable OMAP_GPMC for K3 architecture
> 	some other way."
> 
> It turns out this is not what was finally proposed. Could we try yet
> another solution?
> 
>>
>> Thanks.
>>
>>>    
>>>> ---
>>>>   drivers/mtd/nand/raw/Kconfig | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>>>> index 36e697456ec4..9b078e78f3fa 100644
>>>> --- a/drivers/mtd/nand/raw/Kconfig
>>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>>> @@ -42,8 +42,7 @@ config MTD_NAND_OMAP2
>>>>   	tristate "OMAP2, OMAP3, OMAP4 and Keystone NAND controller"
>>>>   	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
>>>>   	depends on HAS_IOMEM
>>>> -	select MEMORY
>>>> -	select OMAP_GPMC
>>>> +	depends on OMAP_GPMC

No matter if select or depend, both result in OMAP_GPMC enabled
if MTD_NAND_OMAP2={m,y}, and both suggest that OMAP_GPMC is
needed for MTD_NAND_OMAP2. That conflicts with

  we now always compile-in the OMAP_GPMC driver whenever we
  need the NAND controller, even though it is not needed
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If it isn't needed, why the dependency in the first place ?
Also, commit 4cd335dae3cf2 states "this driver depends on OMAP_GPMC
driver and uses symbols from there". Are you saying that this is not
correct ?

Guenter
