Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8985F4FB341
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 07:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiDKFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 01:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244012AbiDKFba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 01:31:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46423BF0;
        Sun, 10 Apr 2022 22:29:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so17385668pjb.0;
        Sun, 10 Apr 2022 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HNjOIvGfpKlYe9wGf5L54cTS95mFqUVX5pLI3c1t/0Q=;
        b=pYw7EYEt5KRWyio0EGoQnA8bnjK/xoTj2lt4hWQjWWfOcz+F25jauhf5U5+k69poCq
         9/j97ypRf1M3MEK7H0UtqxQy8T5r9ugHSd+B8lY8W89mBBNC9BHFev+BSlIO6OZ7jrcM
         OoTNzHT68ontPn3UaADQs5/94Sd21PnyMAW8nn9jqNO/pIAkNVYdRtSeLDw3m+8Bu66r
         +HHBp+hTzjxPxcT+/3VyzIRYx6WBaCcE8VtMA1JlDaS+jt5xYeNjCwZJ7xiDiAeA5IO2
         RIAJm0RU2FoMv1HFfdtYbsViArO1Fivi8Mzh62zSqOWieYsv43jPA8InOChYe7O55RKN
         5y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HNjOIvGfpKlYe9wGf5L54cTS95mFqUVX5pLI3c1t/0Q=;
        b=S0UpqPCuzgMW1ePFDojEJX5+FhvhaCPQ0nxv9c9uqEbfSVc/tIExHpR5W1uTf0JdiE
         6Rq2EqwzxqNHwvuFl8S0n/McdHs5GhtGVsGEA/3fqVgWNpTa+15RLNxUC52GUuVVoij/
         ZXo9Iv/oCpfWQbaSe0vcA+fjmPOQBL5ChEGYJcNLt79LUtZqVNsO1/1imycKRsxWop13
         vIZA5ipN2jvWmTA7bd75waNdwsQjEubRGyR+PYD/J8/nK/tp964bzyxPlj5WkijuypC1
         VQLMiU81owEf0nxYg1rzivlcRRuiLqnzwhKviiF0PsnKp1K4pI0HvcmPJiKPjQhtZ1LP
         ChRA==
X-Gm-Message-State: AOAM531IEHFm4BXh2FgdZlVOiwn3Pu08XcO/2XjJK5rp9jLNYossigYq
        bxibm2QaXegfjw8I++i5NVoKjgTkw7K3gQ==
X-Google-Smtp-Source: ABdhPJxc3T4pl5lVimkQQoQLXOf8Qm96a/yVwv0beUf9D1C+MSK2hld/dLKIlDd+Ke4oteQRox3QDg==
X-Received: by 2002:a17:903:32c8:b0:158:72d6:90ee with SMTP id i8-20020a17090332c800b0015872d690eemr884829plr.3.1649654953761;
        Sun, 10 Apr 2022 22:29:13 -0700 (PDT)
Received: from [10.11.37.162] ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id q13-20020a056a00088d00b004e1bea9c582sm33751227pfj.43.2022.04.10.22.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 22:29:13 -0700 (PDT)
Message-ID: <55d22e24-09ad-20b8-e1de-8d7c2f8ab1a8@gmail.com>
Date:   Mon, 11 Apr 2022 13:29:09 +0800
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
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <91089407-cc21-ba05-5346-4f546cca7555@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/8 23:04, Shuah Khan wrote:
> On 4/7/22 7:59 PM, Hangyu Hua wrote:
>> Hi Shuah,
>>
>> I find this by code review. Do i really need to add this to commit 
>> log? This look like a little weird.
>>
> 
> Great. Good find.
> 
> It is important to understand how the problem is found. Please add it
> the change log. We usually expect dmesg or such info. that revealed
> refcount leak, since this one is found during code review, we would
> like to see that information the commit log.
> 
> Also please remember to avoid top posting.

I get what you meant now. But i don't know how to get a clear dmesg or 
any other log. The kernel will not crash because of this. I just used 
gdb to find that udev->dev->kobj->kref gets bigger and bigger whenever I 
call stub_probe with busid_priv->status = STUB_BUSID_REMOV.

Thanks for telling me the rules.

> 
>>
>> On 2022/4/8 00:31, Shuah Khan wrote:
>>> On 4/6/22 8:22 PM, Hangyu Hua wrote:
>>>> usb_get_dev() is called in stub_device_alloc(). When stub_probe() fails
>>>> after that, usb_put_dev() needs to be called to release the reference.
>>>>
>>>> Fix this by moving usb_put_dev() to sdev_free error path handling.
>>>>
>>>> Fixes: 3ff67445750a ("usbip: fix error handling in stub_probe()")
>>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> ---
>>>>
>>>> v2: add more description of this patch.
>>>
>>> Still missing details on how this problem was found. Please add them
>>> to the commit log.
>>>
> 
> thanks,
> -- Shuah
> 
