Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685152A690
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbiEQP26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiEQP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:28:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7C4F9C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:28:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m23so22222111ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hPZfDtq+SkRuHXe2OoUht+X8414HDvU1qCCePA6TW0o=;
        b=BWtJYBSQrALz0kehGa0zLzvRkDep6BCb4gJVEse1w0U8n7cS73FAvOIhDDLLf/OZnf
         AtgGo0S5cOLhM52J5ZW9DBMEo0sm4pJTJvaW67DJDo7d+9XNtrm5hXSZ5rF1un863G28
         WNSlRe8cAOjnCsNhAUJL5LMVsgnwV8Uq+A4pLYfL3aO/2R1P53H7vmCP+RIN2ccSD++J
         bIpx83TLiVlizoo4kF9YZdE5ZUlS7VNExCBmBI5t5qnoee0HJ8lSYOuKVg5tczQtRMBh
         vfnXsSkHHIOBQxuXAsBWHk9tupfeAW81vxXMZi2owrT/+uv4iFUrzM838PNCu8Q3u7+l
         olmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hPZfDtq+SkRuHXe2OoUht+X8414HDvU1qCCePA6TW0o=;
        b=JbqrrzA0yrapXJv7Fbg87AM4aJY7DiOokRefpjd1Rvo3vE8solbM0oieTOiMl7Fm11
         Lp8um6S8aAI/h6Jrr/UB+DIrXlCuge64ja5FNvVdF/FwNshzRTHo9TjOJITdX1Yv48VD
         fOwSeB1UMB8GRBKFVepiTqQghe6KP95/MPqS5hWSo1nDeZx2bEClaM+UP81D20qvexwE
         MkgV4gA3bh2u857h9WOaL2xhkhJOy+RSUlQi2BvT6ta16hKaMIY6C15KWBKWfTQiqFWX
         siBFd0KlcqrsI3JKOuiJuNttmfFoNm5Y3YxiMddyzNOUmCbiuaBGdesPoSB7I7phH4MH
         CQJg==
X-Gm-Message-State: AOAM531p+b/iz4PuqbQyrLyNQWRSDgBlVjDYltw8Ef8CPlfrt540KrcI
        1ppn/Zym9lMZQPaab5Ez4HDBGg==
X-Google-Smtp-Source: ABdhPJw9ZiS3f8ZiEe+SesZUS83Wf5AYmLXGowoTItvvXmkliGb0bg4HoPgkbP2vxl87SdzeD09m0A==
X-Received: by 2002:a2e:9957:0:b0:253:b63e:fcce with SMTP id r23-20020a2e9957000000b00253b63efccemr2338615ljj.71.1652801333129;
        Tue, 17 May 2022 08:28:53 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z15-20020ac24f8f000000b0047255d211e2sm1615380lfs.273.2022.05.17.08.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:28:52 -0700 (PDT)
Message-ID: <68ccef70-ef30-8f53-6ec5-17ce5815089c@linaro.org>
Date:   Tue, 17 May 2022 17:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH net v2] NFC: hci: fix sleep in atomic context bugs in
 nfc_hci_hcp_message_tx
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-kernel@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
        alexander.deucher@amd.com, broonie@kernel.org,
        netdev@vger.kernel.org
References: <20220517105526.114421-1-duoming@zju.edu.cn>
 <2ce7a871-3e55-ae50-955c-bf04a443aba3@linaro.org>
 <71c24f38.1a1f4.180d29ff1fd.Coremail.duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <71c24f38.1a1f4.180d29ff1fd.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 17:25, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Tue, 17 May 2022 13:42:41 +0200 Krzysztof wrote:
> 
>> On 17/05/2022 12:55, Duoming Zhou wrote:
>>> There are sleep in atomic context bugs when the request to secure
>>> element of st21nfca is timeout. The root cause is that kzalloc and
>>> alloc_skb with GFP_KERNEL parameter and mutex_lock are called in
>>> st21nfca_se_wt_timeout which is a timer handler. The call tree shows
>>> the execution paths that could lead to bugs:
>>>
>>>    (Interrupt context)
>>> st21nfca_se_wt_timeout
>>>   nfc_hci_send_event
>>>     nfc_hci_hcp_message_tx
>>>       kzalloc(..., GFP_KERNEL) //may sleep
>>>       alloc_skb(..., GFP_KERNEL) //may sleep
>>>       mutex_lock() //may sleep
>>>
>>> This patch changes allocation mode of kzalloc and alloc_skb from
>>> GFP_KERNEL to GFP_ATOMIC and changes mutex_lock to spin_lock in
>>> order to prevent atomic context from sleeping.
>>>
>>> Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>> ---
>>> Changes in v2:
>>>   - Change mutex_lock to spin_lock.
>>>
>>>  include/net/nfc/hci.h |  3 ++-
>>>  net/nfc/hci/core.c    | 18 +++++++++---------
>>>  net/nfc/hci/hcp.c     | 10 +++++-----
>>>  3 files changed, 16 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
>>> index 756c11084f6..8f66e6e6b91 100644
>>> --- a/include/net/nfc/hci.h
>>> +++ b/include/net/nfc/hci.h
>>> @@ -103,7 +103,8 @@ struct nfc_hci_dev {
>>>  
>>>  	bool shutting_down;
>>>  
>>> -	struct mutex msg_tx_mutex;
>>> +	/* The spinlock is used to protect resources related with hci message TX */
>>> +	spinlock_t msg_tx_spin;
>>>  
>>>  	struct list_head msg_tx_queue;
>>>  
>>> diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
>>> index ceb87db57cd..fa22f9fe5fc 100644
>>> --- a/net/nfc/hci/core.c
>>> +++ b/net/nfc/hci/core.c
>>> @@ -68,7 +68,7 @@ static void nfc_hci_msg_tx_work(struct work_struct *work)
>>>  	struct sk_buff *skb;
>>>  	int r = 0;
>>>  
>>> -	mutex_lock(&hdev->msg_tx_mutex);
>>> +	spin_lock(&hdev->msg_tx_spin);
>>>  	if (hdev->shutting_down)
>>>  		goto exit;
>>
>> How did you test your patch?
>>
>> Did you check, really check, that this can be an atomic (non-sleeping)
>> section?
>>
>> I have doubts because I found at least one path leading to device_lock
>> (which is a mutex) called within your new code.
> 
> The nfc_hci_hcp_message_tx() is called by both process context(hci_dev_up and so on)
> and interrupt context(st21nfca_se_wt_timeout()). The process context(hci_dev_up and so on)
> calls device_lock, but I think calling spin_lock() within device_lock() is ok. There is
> no device_lock() called within spin_lock(). 

There is.

nfc_hci_failure -> spin lock -> nfc_driver_failure -> nfc_targets_found
-> device_lock

I found it just by a very quick look, so I suspect there are several
other places, not really checked.

Best regards,
Krzysztof
