Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5F586C19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiHANjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHANjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3452C3DBE4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659361139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bxk5IP3/94tP9SFYyYIcCMGXNDnNDMS3Kt0vZ8Pz3Y8=;
        b=eyWMdxyYb8h5q+rDb5aTXOohyeWP2NE9ZgfUZuEJFjS8JG4jtnt42QpIelzLWBNMcus4ft
        dqtGBQJg88le7k5dOTHHQJsHkXB2lTPhD+xN7n7wTOc6wGh52kEzqEzXusCxpP3Y9mITJF
        4prtrcFLXzWyaKd9gEFQcynHa0qLVpo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-qpsgaJSOP7u0Q_Xu_f6h3w-1; Mon, 01 Aug 2022 09:38:58 -0400
X-MC-Unique: qpsgaJSOP7u0Q_Xu_f6h3w-1
Received: by mail-ed1-f72.google.com with SMTP id h15-20020a056402280f00b0043bd8412fe0so7218176ede.16
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bxk5IP3/94tP9SFYyYIcCMGXNDnNDMS3Kt0vZ8Pz3Y8=;
        b=1x6HJkOTixqqWn401d1ahtYqbAgZ2zi2LYJMOEfa/6P1bbbjbuteM4a9MluMab+K8z
         gk5OOV3tCnwF1xqOnUDFkks51dN2OCtsEnG3P0f0B4puH3QLrtX1wVNJoy+cekiopkBB
         o0QMF6la3pIq9e2hWzeSGfyBAqUbf65blVRCIayTDNvxMxjKkgNTh7lQorAyWB6h043m
         0hV/LtW7ESuxNz1eFV7kcuuxn0axv0fjNFjKZ2N/x9vwMlBTgG+Ai1OaMe/Eh9IlQ+eA
         fIuXE9SUGEyg3xFwdb+ei6ZdIDdaDRG1uIRxQEVrZp1ucITIEaQs+2OBYfb5YTS605WV
         SO/g==
X-Gm-Message-State: AJIora/KJzw19K0PiaJZcWpAgWsqL/pZZzjxzbglcxphZfpXzlCN6HpO
        OBjP4Vq8By/5QIKZ6OjX5XwPyBcRwiRyqzNPCBEtHq1EOEIjuz/rHOV1hxAGPNcbqd/eb/IOhqA
        IP5yJIco/0XHjqRm7F2BqupVG
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr16323570edb.348.1659361136875;
        Mon, 01 Aug 2022 06:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5tg3PmSvHtnuiETSeF7KYKv7HUrAenheOhgZM5ZhMqK+FDb6jAJnez8c6YUXxRU77PS17iA==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr16323550edb.348.1659361136684;
        Mon, 01 Aug 2022 06:38:56 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b007307e7df83bsm1480827ejc.21.2022.08.01.06.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:38:55 -0700 (PDT)
Message-ID: <20f78e0f-cbf5-2672-7c27-e366f5d7be5f@redhat.com>
Date:   Mon, 1 Aug 2022 15:38:55 +0200
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

True, ok I'll merge the branch and add Andy's fix on top.

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

