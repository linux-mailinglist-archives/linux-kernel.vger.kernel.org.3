Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E44F08EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356239AbiDCLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiDCLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:10:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2017666
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:08:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qh7so4484917ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4eyOOj1vOFuP0XMQ1EZmTvABGeICZ85D2/5XTsbw8mg=;
        b=cgXWqFg1UKZRWHAfxScb7y024+HG8naz7HJUBYsvmtkIXs2gqC2g638RR3l40mU2jS
         X4PA/g5bBcaEgW+qcTC/UBKUh7V25/l4G1Zl+luiUUgAnBh5ObHCFSXtY8i62PjeUwdR
         3K1HLijJlk2FGsNVjU06bWvwY10gLvTXeADDuzwjmZ5/daB9J8YYl4x6BbugRjAC1fik
         Sd6Ofu2AEuvE8A+jHkamrIzvGD3X+UVagc+GauzPpkNUPA2Tvr3f3Gkl2hzsCFUPg68Y
         SfJ3o8LG12h0m/68O24EQB8qNVesfLnd+oREkWfLa00stA/Eh1J92ZbdMJXtnxfSYY20
         rELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4eyOOj1vOFuP0XMQ1EZmTvABGeICZ85D2/5XTsbw8mg=;
        b=T1tRY3YHZq90x6fujaseS1MCbRbwpQs3/Rd9Rm/mtPqKOE/C54gQiIchWAp4CRCmD2
         ZHHz9QDE7Ec+4wLM8RHnAgnUoBkRTe/V5nxvEw6321Y2oahagUYH1qHIslq4C2kf/Siu
         ffFYAPaAl8JJSm5jNdr6CaVf/b/K8pMeAf4yCEOtm4V22h/aZLYr5+wf198IlooxctIP
         tJKLY++TIvsL/KvlRzTi1s6CUQw4MilOPrAOhwTP4sEly9LiJxIiSqy8smOejNMdEjqh
         tQUfnfj7cRp5PRLkayuINF2OGXh1VTjO/JnzxrU/P/4oJWYXLcM112/OqWO3+bc8MMie
         SW7A==
X-Gm-Message-State: AOAM531eGvjb2AAoDwrUQ+TbMq6t2GHNbPJlAdzTme6DSlMeQb0ZKZcJ
        7sDdq6kKDJAu0cy5IJH+ffE=
X-Google-Smtp-Source: ABdhPJzv7XYXzX+TCr7nTtWqm6l56byjoVuirlDIFbZDBUX8yhXagkDg/AmC5YJFWesihCst5uzWhQ==
X-Received: by 2002:a17:907:7d8d:b0:6df:f3a6:b0d9 with SMTP id oz13-20020a1709077d8d00b006dff3a6b0d9mr6850742ejc.13.1648984117751;
        Sun, 03 Apr 2022 04:08:37 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906778600b006dfc5be1ce0sm3206171ejm.146.2022.04.03.04.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:08:36 -0700 (PDT)
Message-ID: <942bbcb6-725d-9b47-5dfe-f105d30ea6b7@gmail.com>
Date:   Sun, 3 Apr 2022 13:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <4389354.LvFx2qVVIh@leap> <1813843.tdWV9SEqCh@leap>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <1813843.tdWV9SEqCh@leap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 12:49, Fabio M. De Francesco wrote:
> On domenica 3 aprile 2022 12:43:04 CEST Fabio M. De Francesco wrote:
>> On sabato 2 aprile 2022 22:47:27 CEST Michael Straube wrote:
>>> Hi all,
>>>
>>> smatch reported a sleeping in atomic context.
>>>
>>> rtw_set_802_11_disassociate() <- disables preempt
>>> -> _rtw_pwr_wakeup()
>>>      -> ips_leave()
>>>
>>> rtw_set_802_11_disassociate() takes a spinlock and ips_leave() uses a
>>> mutex.
>>>
>>> I'm fairly new to the locking stuff, but as far as I know this is not a
>>> false positive since mutex can sleep, but that's not allowed under a
>>> spinlock.
>>>
>>> What is the best way to handle this?
>>> I'm not sure if converting the mutex to a spinlock (including all the
>>> other places where the mutex is used) is the right thing to do?
>>>
>>> thanks,
>>> Michael
>>>
>> Hi Michael,
>>
>> No, this is a false positive: ips_leave is never called under spinlocks.
>> Some time ago I blindly trusted Smatch and submitted a patch for what you
>> are reporting just now again. Soon after submission I realized it and
>> then I had to ask Greg to discard my patch.
>>
>> Please read the related thread:
>>
>> [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
>> https://lore.kernel.org/lkml/20220206225943.7848-1-fmdefrancesco@gmail.com/
>>
>> Thanks,
>>
>> Fabio
> 
> I'm sorry, the correct link is the following:
> [PATCH v2 2/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
> https://lore.kernel.org/lkml/20220208180426.27455-3-fmdefrancesco@gmail.com/
> 
> Fabio
> 

Hi Fabio,

Ah I see now, thanks. Well, I think the code is not very clear and easy 
to follow here. Perhaps we should refactor this area someday to avoid 
future confusions.

regards,
Michael
