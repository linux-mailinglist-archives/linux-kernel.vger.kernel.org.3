Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3E586D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiHAOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiHAOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E893AB3A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPYiXDhaESDDlUqMSp8278u1iB29EOZV/3YaR/+rAG0=;
        b=JT51uNOw7pK1eNLSedjAULE69tCzd5OzeVYMyRDZbht/0AQzgh4+0Likd5j1p4zl0jq5QW
        /rYpqhLux4nyjmxL/eUK8eB+lsYvHxH8oLzdOeLLz2xhpEZA9SybPsIN9KKBN+LqDB528y
        +Wndc2OCXpwGiaUhMlYrvJc9s4w1zI8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-y_VDmuz0OEa4zZ9zxIeJMQ-1; Mon, 01 Aug 2022 10:40:41 -0400
X-MC-Unique: y_VDmuz0OEa4zZ9zxIeJMQ-1
Received: by mail-ed1-f69.google.com with SMTP id i6-20020a05640242c600b0043d5404f2e9so3686946edc.22
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dPYiXDhaESDDlUqMSp8278u1iB29EOZV/3YaR/+rAG0=;
        b=yRo753lcL2GiY6GcAn3OeTVwqB7gtkk8VZuuxM3QqSpd+lw4d4ucI8qqTWXuM94dJm
         VxzyJnRHu+E/Mn1/R4mKznz3diC3Q4BiwwP7Y23C8FS+2GHlbcfBy4FSsQ3pQcfoZFG0
         gtqPTRG08nUMqh2OXP3KYJ5PEbJ1fwRNpbCLJvhEeyVqWhLHfTYAb+UQCweW4UZ3sTDS
         5/YebJdPrNp1ojikY9im+6b5j7T8X/LZwFQQ6UcEi6cj5b4oiXqbPtiKsbrsVTqZy5OD
         BBi/5wbrRaWhNatOgxrPcActmX39v8ybvYGaL7LqSiWEOOrxvp1CaX6xEzbG65uPmaWx
         2b9g==
X-Gm-Message-State: AJIora/xp/3HoallKAk1Zm53xdrRNyMnA5eXozb5POI1Dc+l1mhl3qcP
        vStiKVuxSkx/Wh+aVMpqRmw4Y9gve1UffsL0BcDkNpJrxfRdBUNzkCeeOgpIAvKgZT216oiKLHg
        SioDXGHY5VCHxyK1/4lUpGY2p
X-Received: by 2002:a17:906:c781:b0:726:c967:8d1b with SMTP id cw1-20020a170906c78100b00726c9678d1bmr13057556ejb.54.1659364840721;
        Mon, 01 Aug 2022 07:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFazZco81Jdd7IQiFo4yx8dEY6I5Zc8J1NnmkMxgFaFH+Cla1eGtIocR5HBAEQZxXka6+QIg==
X-Received: by 2002:a17:906:c781:b0:726:c967:8d1b with SMTP id cw1-20020a170906c78100b00726c9678d1bmr13057547ejb.54.1659364840578;
        Mon, 01 Aug 2022 07:40:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ku26-20020a170907789a00b00730979f568fsm401575ejc.150.2022.08.01.07.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:40:39 -0700 (PDT)
Message-ID: <a2c40124-4b7c-0f71-1153-2bc03802724a@redhat.com>
Date:   Mon, 1 Aug 2022 16:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] platform/x86: p2sb: Move out of
 X86_PLATFORM_DEVICES dependency
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
References: <20220718145328.14374-1-andriy.shevchenko@linux.intel.com>
 <2b1b4cd1-faec-85a1-5ad2-e2b29290e0c1@redhat.com>
 <YufTmwg/A94XjrQ8@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YufTmwg/A94XjrQ8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/22 15:22, Lee Jones wrote:
> On Thu, 28 Jul 2022, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 7/18/22 16:53, Andy Shevchenko wrote:
>>> The P2SB library is used for various drivers, including server
>>> platforms. That's why the dependency on X86_PLATFORM_DEVICES
>>> seems superfluous.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> v2: added X86 to the dependencies of P2SB (Hans), added Rb tag (Hans)
>>
>> Lee I presume that since you've merged the original series
>> (in your ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
>> branch) that you will take this fix on top ?
> 
> The point of supplying an immutable branch is that whoever maintains
> this subsystem can pull from it and apply this patch on-top.

I've added the fix to pdx86/for-next now.

Regards,

Hans


> 
>> This fix is necessary to fix a bunch of randconfig build
>> failures in the current linux-next.
>>
>>>  drivers/platform/x86/Kconfig            | 12 ++++++++++++
>>>  drivers/platform/x86/Makefile           |  4 ++++
>>>  drivers/platform/x86/intel/Kconfig      | 12 ------------
>>>  drivers/platform/x86/intel/Makefile     |  2 --
>>>  drivers/platform/x86/{intel => }/p2sb.c |  0
>>>  5 files changed, 16 insertions(+), 14 deletions(-)
>>>  rename drivers/platform/x86/{intel => }/p2sb.c (100%)
> 

