Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE04FC538
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349684AbiDKTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiDKTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:41:09 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64113F0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:38:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r11so12208858ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1WfDLkMmrYqZ6Ij9lfpj1VDoW1LAn8E2xThCsyOWFGE=;
        b=IKv1G1i0A6yENpCFhUhSheXLDeap3M1/5nt62rwktvIPbzYG8x4+VcYZhp2L5BYzTS
         VC+fUvTTKInwNLDZDfjDiZTQQ4Ld6WCvs8mU2W4V3RpsVy8Nx0CN3xoPrNHhwJMqDVBb
         zhrVJg09qedrBhavLeXJtmqhkG6kxUsjwVLtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1WfDLkMmrYqZ6Ij9lfpj1VDoW1LAn8E2xThCsyOWFGE=;
        b=H6JTc4RIdJWCZgXj/xWjKyx75iBXqfmBTo1mXA1xzW0+TtuqFluELpOURnPt1YgrZH
         pznWNBc0YGbmB69/vzeCoU1YKkE1Q7wcAQLmU9r/iPXq+X7b7z2OJAFEM3fG8GAVGf2w
         ZAI984InRLw3gq85UYkfiXGaM2AXlGBADmgEAOWwIDVlHxJpQ782I270AoW7TPnE0snv
         wm+nfmb45vbME25oxTnVaWOEmHwH0mM52NS70VAc3SfS1xtjAaGd7t+TwzxXpjewb7rw
         w1uJ0B+XpYoceVwdocOflmK1WhSEOULovs+3wKgs9ueDaOTDQlB0vH3jeDrbtlIvPP7r
         o4ag==
X-Gm-Message-State: AOAM532Pp2xzFVo+zd3Bt+8DSr1HfmKaz1Bsj/RVci1sCK1nvv12xbXN
        I0d2Bh29PvoiBlNtBS9Tuninbg==
X-Google-Smtp-Source: ABdhPJz0XsoDdd0nsaFO5HSBwS1X9AjPFVqn1VnZsUg1ItNo8xlkSLtdOnYZhfiQHHdGa7DE6PR8aw==
X-Received: by 2002:a05:6e02:17ce:b0:2ca:7d71:6cb2 with SMTP id z14-20020a056e0217ce00b002ca7d716cb2mr8406267ilu.43.1649705934358;
        Mon, 11 Apr 2022 12:38:54 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q13-20020a056e020c2d00b002caa365b43bsm4314131ilg.76.2022.04.11.12.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 12:38:54 -0700 (PDT)
Subject: Re: [PATCH v2] usb: usbip: fix a refcount leak in stub_probe()
To:     Hangyu Hua <hbh25y@gmail.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220407022204.10730-1-hbh25y@gmail.com>
 <7c584e2d-1c23-3df9-7e4e-c4d9a9014224@linuxfoundation.org>
 <d40cb8cf-a92d-3f87-3af1-0422f8d8264f@gmail.com>
 <91089407-cc21-ba05-5346-4f546cca7555@linuxfoundation.org>
 <55d22e24-09ad-20b8-e1de-8d7c2f8ab1a8@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <16876455-ed60-65c6-1375-ac88e4209cb2@linuxfoundation.org>
Date:   Mon, 11 Apr 2022 13:38:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <55d22e24-09ad-20b8-e1de-8d7c2f8ab1a8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 11:29 PM, Hangyu Hua wrote:
> On 2022/4/8 23:04, Shuah Khan wrote:
>> On 4/7/22 7:59 PM, Hangyu Hua wrote:
>>> Hi Shuah,
>>>
>>> I find this by code review. Do i really need to add this to commit log? This look like a little weird.
>>>
>>
>> Great. Good find.
>>
>> It is important to understand how the problem is found. Please add it
>> the change log. We usually expect dmesg or such info. that revealed
>> refcount leak, since this one is found during code review, we would
>> like to see that information the commit log.
>>
>> Also please remember to avoid top posting.
> 
> I get what you meant now. But i don't know how to get a clear dmesg or any other log. The kernel will not crash because of this. I just used gdb to find that udev->dev->kobj->kref gets bigger and bigger whenever I call stub_probe with busid_priv->status = STUB_BUSID_REMOV.
> 
> Thanks for telling me the rules.
> 

There is no need to gather dmesg etc. Just add a note that you found
the problem during code review. Having complete information about why
a change is made will be helpful for future changes to this code and
somebody new trying understand the changes made to this file/routine
and why.

thanks,
-- Shuah
