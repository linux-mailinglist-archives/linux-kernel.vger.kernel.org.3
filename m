Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6A515141
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbiD2RGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378535AbiD2RGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:06:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD9E7563C;
        Fri, 29 Apr 2022 10:03:04 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k25-20020a056830169900b00605f215e55dso2171680otr.13;
        Fri, 29 Apr 2022 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cP3k5kUuoWg5JR2OnDd92i4XFuEk9RrNw2XTYs8+nHQ=;
        b=J4UGuTtuXijrsWLpCIDKsVNcOlRwtCJB+Dge/RcmmqI3XLLu3oqSHHWB81RXtKxWbB
         dcpdUVaQC8StWrr75rhw0N67W8IfmJhPl82AtQcM1Jy8rX7TOH7SeECOu8SPi0j2oSJC
         lR/xnUZTW2ylPgn1Oae7xp4RGYamBuRHNvUNXM9rppG6rYva78Z/qha3rac5G/2qsRET
         BVhO3O+6Lmnaq79GWLwLyroVm33bfNv4/u4EZeZ6PNoEgSK1eiK2KoH6AJXq4ABAgQt9
         Scd8DnwZtGT4sNFK/pSRiyYE8OUqgxanKI92+Wz6fsT+OYDaWiMMLaedwooMeQJov58K
         d1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cP3k5kUuoWg5JR2OnDd92i4XFuEk9RrNw2XTYs8+nHQ=;
        b=lQyVhm3AfT7Z8Bw10zIu4QXAbJU9ooxw7yp9Ng8kezixDpnmLlseSOvLRIiitL/XOP
         gD7yyrZr7EVu9RP+0KGA1vNSoKQ5W+xMA2LvxFSB/Ud1I1vJjbJd1iY5srTIz2P+e7pZ
         n6ixNy0QB3nf+gHNAzMwcUOVVRv1CF3P33dV+RhKt7IiH3SXbpZiZEF1GvKhO3agTfG3
         2CrIuCzHnLK2cwzdQOg7MGYkmzscuekJbGxltrhEaVI1dMuwN2Pa9FhdhZa3VcD69nyj
         ukLTtbAro29eZU9Z+tNIPdFPJpjATj8RPXjJdmOGFPkCfVyH7bFRoyg+kySvGWdVoYE/
         KSKg==
X-Gm-Message-State: AOAM530feSzX2fWzZJ6NssArwDksAkTKq713U0/OEz7NtF9PJRswVbKg
        sZvBoBc5o4X45Aaoh9g5slE=
X-Google-Smtp-Source: ABdhPJzewteeoRai5yOxCPAaxMcsmX2oilokDlj7mjkEf3C0syrfnE0N29DHjdHjC/EZcdezN6J83Q==
X-Received: by 2002:a05:6830:1081:b0:605:e78a:ea4d with SMTP id y1-20020a056830108100b00605e78aea4dmr99480oto.315.1651251783432;
        Fri, 29 Apr 2022 10:03:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j72-20020a9d17ce000000b005e6b89f9f54sm1285246otj.32.2022.04.29.10.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 10:03:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dbbe0db1-9a0d-4f14-f8e9-81fae4422d31@roeck-us.net>
Date:   Fri, 29 Apr 2022 10:02:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Sebastian Ene <sebastianene@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmunAm8ooJkNCx5D@kroah.com> <YmuvQvuPF/mn5S4C@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmuvQvuPF/mn5S4C@google.com>
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

On 4/29/22 02:26, Sebastian Ene wrote:
> On Fri, Apr 29, 2022 at 10:51:14AM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
>>> This driver creates per-cpu hrtimers which are required to do the
>>> periodic 'pet' operation. On a conventional watchdog-core driver, the
>>> userspace is responsible for delivering the 'pet' events by writing to
>>> the particular /dev/watchdogN node. In this case we require a strong
>>> thread affinity to be able to account for lost time on a per vCPU.
>>>
>>> This part of the driver is the 'frontend' which is reponsible for
>>> delivering the periodic 'pet' events, configuring the virtual peripheral
>>> and listening for cpu hotplug events. The other part of the driver
>>> handles the peripheral emulation and this part accounts for lost time by
>>> looking at the /proc/{}/task/{}/stat entries and is located here:
>>> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
>>>
>>> Signed-off-by: Sebastian Ene <sebastianene@google.com>
>>> ---
>>>   drivers/misc/Kconfig       |  12 +++
>>>   drivers/misc/Makefile      |   1 +
>>>   drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 219 insertions(+)
>>>   create mode 100644 drivers/misc/vm-watchdog.c
>>>
>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>> index 2b9572a6d114..26c3a99e269c 100644
>>> --- a/drivers/misc/Kconfig
>>> +++ b/drivers/misc/Kconfig
>>> @@ -493,6 +493,18 @@ config OPEN_DICE
>>>   
>>>   	  If unsure, say N.
>>>   
>>> +config VM_WATCHDOG
>>> +	tristate "Virtual Machine Watchdog"
>>> +	select LOCKUP_DETECTOR
>>> +	help
>>> +	  Detect CPU locks on the virtual machine. This driver relies on the
>>> +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
>>> +	  has to do a 'pet', it exits the guest through MMIO write and the
>>> +	  backend driver takes into account the lost ticks for this particular
>>> +	  CPU.
> 
> Hi,
> 
>>
>> There's nothing to keep this tied to a virtual machine at all, right?
>> You are just relying on some iomem address to be updated, so it should
>> be a "generic_iomem_watchdog" driver as there's nothing specific to vms
>> at all from what I can tell.
>>
>> thanks,
>>
>> greg k-h
> 
> That's right although I might think of using the term "generic lockup detector"

Agreed, that would be a much better name.

Guenter


> instead of watchdog. The only reason why I would keep "virtual machine"
> word in, is that there is no actual hardware for this.
> 
> Thanks,
> Seb

