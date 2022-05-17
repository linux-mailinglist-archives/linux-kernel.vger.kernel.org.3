Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B952A095
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiEQLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiEQLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:39:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0077D3E5D5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:39:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z2so34109584ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8b3219JiyhAdMu7qXtwLRDUhe9o17eXhnezQfisY3zg=;
        b=U+CVj6qgp8QUW2lG8P8Rh01H0x3HW+BYkHmBnL45Jux2ihcoxftVomMk7yLlk6ViAj
         biww0Q6BPNn9fMJZUPm4889jgoqwE1plSUPajL8SrciXIxXluT7PW5ziLpa2Z/yQU7Pr
         cuygJT+roy+70H0YNeR66/h6yZmXXVDnfyTXSiX1x/jHfweJHIbtGMdUjAbhGFbHn9M9
         VX4ONkl3yd8WMuGiIWPwVSKHDCksIJ972YZB5/IAOleH1OW9MBJtBXzD6aSxckObxc2W
         i/qQ0e8giYJu4nWyqhLEoONNH6Bzu8426DB3uQSkthNRGiuxIhWcJArW7vKEGsV3tHc2
         PGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8b3219JiyhAdMu7qXtwLRDUhe9o17eXhnezQfisY3zg=;
        b=I7BvpUzBYOmphcA6pgv6rJmI6Sl1TXjZDPkaBt9VQVyVDkLefUMyChMfB/phdTjFLn
         NEGM0F7VM22vWSTp6ufznmYI/8zhZfJedZhyzBAKyDFCG++PeLMV/SboxkuLLTcUbpJq
         kzKWl+oCkyEMXft3xgjoQ0Fh11LuMTU+JNBo7SHfB9yP8aPvT+rR7ZiTgTo+e8cVKjLv
         qqGKLRIsrJDI3p3muD7hznandQys7pXwZaVIeVTPJYKDxNKOARCXJ07yblKucuyrGePy
         DIVrYcumqTKdlcMWQpi/t8ptNazIj6DjVD3KLSBkz3u1EesvId+iKfSgNIn8hkTiKkZq
         z27Q==
X-Gm-Message-State: AOAM531ZVTnSmBiZ9jlglzK7Ir9BuJ7UMzICibPqkzcW/NaG4F62y8/a
        PClpom+ZewTn9hYFEoQrao+llQ==
X-Google-Smtp-Source: ABdhPJwgqNNl3jI9pDpOhkdwAZIe/YsCJxtidLWljh6gn11xfeO9oCI8pm2LH8sJJxfTzPHKk7kUvA==
X-Received: by 2002:a17:907:9724:b0:6fe:69f4:f68c with SMTP id jg36-20020a170907972400b006fe69f4f68cmr1486140ejc.30.1652787586552;
        Tue, 17 May 2022 04:39:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7c04e000000b0042a5a39ba7esm5919015edo.25.2022.05.17.04.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 04:39:46 -0700 (PDT)
Message-ID: <171c13bb-9fc9-0807-e872-6859dfa2603d@linaro.org>
Date:   Tue, 17 May 2022 13:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH net] NFC: hci: fix sleep in atomic context bugs in
 nfc_hci_hcp_message_tx
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gregkh@linuxfoundation.org, alexander.deucher@amd.com,
        broonie@kernel.org, netdev@vger.kernel.org
References: <20220516021028.54063-1-duoming@zju.edu.cn>
 <d5fdfe27-a6de-3030-ce51-9f4f45d552f3@linaro.org>
 <6aba1413.196eb.180cc609bf1.Coremail.duoming@zju.edu.cn>
 <ea2af2f9-002a-5681-4293-a05718ce9dcd@linaro.org>
 <fc6a78c.196ab.180d1a98cc9.Coremail.duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fc6a78c.196ab.180d1a98cc9.Coremail.duoming@zju.edu.cn>
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

On 17/05/2022 12:56, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Mon, 16 May 2022 12:43:07 +0200 Krzysztof wrote:
> 
>>>>> There are sleep in atomic context bugs when the request to secure
>>>>> element of st21nfca is timeout. The root cause is that kzalloc and
>>>>> alloc_skb with GFP_KERNEL parameter is called in st21nfca_se_wt_timeout
>>>>> which is a timer handler. The call tree shows the execution paths that
>>>>> could lead to bugs:
>>>>>
>>>>>    (Interrupt context)
>>>>> st21nfca_se_wt_timeout
>>>>>   nfc_hci_send_event
>>>>>     nfc_hci_hcp_message_tx
>>>>>       kzalloc(..., GFP_KERNEL) //may sleep
>>>>>       alloc_skb(..., GFP_KERNEL) //may sleep
>>>>>
>>>>> This patch changes allocation mode of kzalloc and alloc_skb from
>>>>> GFP_KERNEL to GFP_ATOMIC in order to prevent atomic context from
>>>>> sleeping. The GFP_ATOMIC flag makes memory allocation operation
>>>>> could be used in atomic context.
>>>>>
>>>>> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
>>>>> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
>>>>> ---
>>>>>  net/nfc/hci/hcp.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/nfc/hci/hcp.c b/net/nfc/hci/hcp.c
>>>>> index 05c60988f59..1caf9c2086f 100644
>>>>> --- a/net/nfc/hci/hcp.c
>>>>> +++ b/net/nfc/hci/hcp.c
>>>>> @@ -30,7 +30,7 @@ int nfc_hci_hcp_message_tx(struct nfc_hci_dev *hdev, u8 pipe,
>>>>>  	int hci_len, err;
>>>>>  	bool firstfrag = true;
>>>>>  
>>>>> -	cmd = kzalloc(sizeof(struct hci_msg), GFP_KERNEL);
>>>>> +	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
>>>>
>>>> No, this does not look correct. This function can sleep, so it can use
>>>> GFP_KERNEL. Please just look at the function before replacing any flags...
>>>
>>> I am sorry, I don`t understand why nfc_hci_hcp_message_tx() can sleep.
>>
>> Why? because in line 93 it uses a mutex (which is a sleeping primitve).
>>
>>>
>>> I think st21nfca_se_wt_timeout() is a timer handler, which is in interrupt context.
>>> The call tree shows the execution paths that could lead to bugs:
>>>
>>> st21nfca_hci_se_io()
>>>   mod_timer(&info->se_info.bwi_timer,...)
>>>     st21nfca_se_wt_timeout()  //timer handler, interrupt context
>>>       nfc_hci_send_event()
>>>         nfc_hci_hcp_message_tx()
>>>           kzalloc(..., GFP_KERNEL) //may sleep
>>>           alloc_skb(..., GFP_KERNEL) //may sleep
>>>
>>> What`s more, I think the "mutex_lock(&hdev->msg_tx_mutex)" called by nfc_hci_hcp_message_tx()
>>> is also improper.
>>>
>>> Please correct me, If you think I am wrong. Thanks for your time.
>>
>> Your patch is not correct in current semantics of this function. This
>> function can sleep (because it uses a mutex), so the mistake is rather
>> calling it from interrupt context.
> 
> We have to call nfc_hci_send_event() in st21nfca_se_wt_timeout(), because we need to send 
> a reset request as recovery procedure. I think replace GFP_KERNEL to GFP_ATOMIC and replace
> mutex_lock to spin_lock in nfc_hci_hcp_message_tx() is better.
> 
> What's more, in order to synchronize with other functions related with hci message TX, 
> We need to replace the mutex_lock(&hdev->msg_tx_mutex) to spin_lock in other functions
> as well. I sent "patch v2" just now.

You sent v2 one minute before replying here... that's not how discussion
work. Please do not sent next version before reaching some consensus.


Best regards,
Krzysztof
