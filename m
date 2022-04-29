Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B2515129
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379334AbiD2Qz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378075AbiD2Qz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:55:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B0DA6D5;
        Fri, 29 Apr 2022 09:52:08 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s131so9127890oie.1;
        Fri, 29 Apr 2022 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3gN9L8fgj3arWyvLL1eoMyFDhKmUmNEAeRCWYpFP81M=;
        b=HYJZb1+TjL+NZtcxhNNPtmjzwuTI7BFC13MlgBbKLfVkYZXHh9sYUBS593Dzh1cL7B
         tX5SEcYd9PDF3RyRKEAL6yy4YEN4pec95QvZThAcc2hnYTiir2NHVMVxsh8deWhJbZ4u
         k6jTUHZqX1n1wAgGACiADOtL3BkcDFdBHbumvUQSVSJvP8oMthgjYTSyw9j13nRUYiUR
         lt+tK2YYD1pcKQGShSRJvNnOrdict+pIQcdnC0oOvudXMVqfVha9uNOjIR2CyZ84TbhW
         396unP/SCiQAg4bjKZUScLV0zuRlX0siu+rjpMB3ADr4xHFTP3sN8o3xZQ1bkD3F8CHR
         gtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3gN9L8fgj3arWyvLL1eoMyFDhKmUmNEAeRCWYpFP81M=;
        b=G+XsOsC5cAq9glT1+r4nVmY3PNDjBMBf1gfVJRSG1C8B+DXqzpoFP+4wDursXSug6F
         Qqkfy3kwlrcXe3MWmqLA2RYE1i5TiJ8j3uqgp8PdOf3UKoFHpalHQhPTgn86fWIgJvPE
         cTmV4HTPoqPFvSNZqlzLZClcxiYiRLgdXJbTqTqt3tPaeVWY74uAGvXv+sL53XMVCCBd
         ShAzIQ4VN3gNom5ZQtI3ZzwaXKQZxB3js1VmoD8eCM7K3aOoKlMWdB3Oge4p7s0D2Ns+
         NBM3zFnOMG90+DW6nOXFndFzDi6e/jMUlvMdOmtRQOZp+eWb5bNsSFloamb2o4VB+034
         5ylA==
X-Gm-Message-State: AOAM531h6fKpV6etKGinZ0bfKs2zwOP/jQbqSaRG8xH0/tts6MlUox4I
        fN9TsNQez8Mi8CTYp0oBvvrxv0sBqvs=
X-Google-Smtp-Source: ABdhPJwJVtAH64XyxRgIc+jOqrEZAHoBphIx0E1qBLKg7jR2nmNkU5h4kukWxC1L/r+Aq2qaEQFjxw==
X-Received: by 2002:a05:6808:2125:b0:325:b284:d438 with SMTP id r37-20020a056808212500b00325b284d438mr1935014oiw.232.1651251127666;
        Fri, 29 Apr 2022 09:52:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22-20020a056870e49600b000e686d13871sm3134169oag.11.2022.04.29.09.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:52:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e94fdd89-7b8e-eec3-4b2f-dcea55c7f0bc@roeck-us.net>
Date:   Fri, 29 Apr 2022 09:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmumSgiTrQUWoXsb@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmumSgiTrQUWoXsb@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 01:48, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
>> This driver creates per-cpu hrtimers which are required to do the
>> periodic 'pet' operation. On a conventional watchdog-core driver, the
>> userspace is responsible for delivering the 'pet' events by writing to
>> the particular /dev/watchdogN node. In this case we require a strong
>> thread affinity to be able to account for lost time on a per vCPU.
>>
>> This part of the driver is the 'frontend' which is reponsible for
>> delivering the periodic 'pet' events, configuring the virtual peripheral
>> and listening for cpu hotplug events. The other part of the driver
>> handles the peripheral emulation and this part accounts for lost time by
>> looking at the /proc/{}/task/{}/stat entries and is located here:
>> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
>>
>> Signed-off-by: Sebastian Ene <sebastianene@google.com>
>> ---
>>   drivers/misc/Kconfig       |  12 +++
>>   drivers/misc/Makefile      |   1 +
>>   drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 219 insertions(+)
>>   create mode 100644 drivers/misc/vm-watchdog.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 2b9572a6d114..26c3a99e269c 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -493,6 +493,18 @@ config OPEN_DICE
>>   
>>   	  If unsure, say N.
>>   
>> +config VM_WATCHDOG
>> +	tristate "Virtual Machine Watchdog"
>> +	select LOCKUP_DETECTOR
>> +	help
>> +	  Detect CPU locks on the virtual machine. This driver relies on the
>> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
>> +	  has to do a 'pet', it exits the guest through MMIO write and the
>> +	  backend driver takes into account the lost ticks for this particular
>> +	  CPU.
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called vm-wdt.
> 
> You forgot to name the module properly here based on the Makefile change
> you made.
> 
> And again, as this is called a "watchdog", it seems crazy that it is not
> in drivers/watchdog/
> 

I disagree. It is not a watchdog driver in the traditional sense (it does
not use, want to use, or need to use the watchdog driver API or ABI).
Its functionality is similar to the functionality of kernel/watchdog.c,
which doesn't belong into drivers/watchdog either.

Guenter
