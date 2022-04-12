Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B244A4FCBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiDLB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiDLB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:28:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF21A838;
        Mon, 11 Apr 2022 18:26:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j8so15372092pll.11;
        Mon, 11 Apr 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VxXbudBApxhZGcBQ0qzcnlkDnqM7YeuExCtSNL/Eqvw=;
        b=gPhy/sTiFvw/el2eqjcLE3TmNLvKNHw98liUoLS8thb8poOFSm9QDgb6iOhhapdJzg
         mg9Pf39+pqsq6GDIdkohKFMvHKXqtprbKumJnV3K8haL06rSMJcsOBeIV2hk8EnkFVMn
         3PyRytXFHGJZyLNYWk4sUtKxlQiTZcwygYcoQmMwaeukeTocT7K67IZNXs4PmDVcWzBn
         /kk8ZVM32CNsJffpyVClMspjMBE/yhh3W4h6kpYMQShY4pwVjV6SmYpqazYU+3a1SwOr
         f9jX84jqYaVdRnxNCUMzV8icUYaZHKpVnCHGTS10ToIx71Ne93GZ15kqdGkiry/aDmHQ
         6cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VxXbudBApxhZGcBQ0qzcnlkDnqM7YeuExCtSNL/Eqvw=;
        b=UxklTdzcfN0AU9kFu+7twsV+sd7Hq8PAE/9vFb2JzIxfyKiGl/km6wgTeRZDJNEcHd
         WSpQ8CWO5pPhzc7tg+eYd3iJOTsVgSbv6mTp8XWpf/+a+5V/DJzHBFdr6d/xMjH4hhvP
         pRd+S0v3QlHqf+ntmRujE7vb69C4pyIVIx7wFMTT2nqN/rR5xK3kqS+41avON7TM9GDx
         +eh9+WetT0VCknMe0tR32cWKkT7U+7+LLIGTzucFmqRzViqxRMpdiWWPuAKZ3zZ9bJbX
         ixrjW7MOJwl9oaAmEX32J8lmOmDLEyevqYbVRJ1VZxbka0kczpdwe4Gq5Qr6BtlPYxOk
         cXFQ==
X-Gm-Message-State: AOAM5303za7nUxwmx10IiU+RZLymTQuaa2khtrknWbOApL1Rfcuvteq5
        JF/lCZOlOSUSqxB5VyKaH04=
X-Google-Smtp-Source: ABdhPJwhEMQKP7S6/uyBvYw37FlDMIqUEsk1tQugjoKXwy2sj+PiM58nGoeWK2Ox8uN97L91Q0uBuA==
X-Received: by 2002:a17:902:a9c2:b0:156:1859:2d05 with SMTP id b2-20020a170902a9c200b0015618592d05mr35878669plr.86.1649726787534;
        Mon, 11 Apr 2022 18:26:27 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm665768pjv.57.2022.04.11.18.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 18:26:27 -0700 (PDT)
Message-ID: <992417be-97f1-09bd-f847-b279460d595b@gmail.com>
Date:   Tue, 12 Apr 2022 09:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] usb: usbip: fix a refcount leak in stub_probe()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, khoroshilov@ispras.ru
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220407022204.10730-1-hbh25y@gmail.com>
 <7c584e2d-1c23-3df9-7e4e-c4d9a9014224@linuxfoundation.org>
 <d40cb8cf-a92d-3f87-3af1-0422f8d8264f@gmail.com>
 <91089407-cc21-ba05-5346-4f546cca7555@linuxfoundation.org>
 <55d22e24-09ad-20b8-e1de-8d7c2f8ab1a8@gmail.com>
 <16876455-ed60-65c6-1375-ac88e4209cb2@linuxfoundation.org>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <16876455-ed60-65c6-1375-ac88e4209cb2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 03:38, Shuah Khan wrote:
> On 4/10/22 11:29 PM, Hangyu Hua wrote:
>> On 2022/4/8 23:04, Shuah Khan wrote:
>>> On 4/7/22 7:59 PM, Hangyu Hua wrote:
>>>> Hi Shuah,
>>>>
>>>> I find this by code review. Do i really need to add this to commit 
>>>> log? This look like a little weird.
>>>>
>>>
>>> Great. Good find.
>>>
>>> It is important to understand how the problem is found. Please add it
>>> the change log. We usually expect dmesg or such info. that revealed
>>> refcount leak, since this one is found during code review, we would
>>> like to see that information the commit log.
>>>
>>> Also please remember to avoid top posting.
>>
>> I get what you meant now. But i don't know how to get a clear dmesg or 
>> any other log. The kernel will not crash because of this. I just used 
>> gdb to find that udev->dev->kobj->kref gets bigger and bigger whenever 
>> I call stub_probe with busid_priv->status = STUB_BUSID_REMOV.
>>
>> Thanks for telling me the rules.
>>
> 
> There is no need to gather dmesg etc. Just add a note that you found
> the problem during code review. Having complete information about why
> a change is made will be helpful for future changes to this code and
> somebody new trying understand the changes made to this file/routine
> and why.
> 
> thanks,
> -- Shuah

I get it. I will submit a v3.

Thanks.
