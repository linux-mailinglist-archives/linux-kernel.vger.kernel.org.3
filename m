Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4944C4EC636
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbiC3OLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346659AbiC3OK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:10:57 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.46.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21931B255C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:09:12 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 12773400FEFA3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:09:12 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id ZZ0Znb9lJHnotZZ0anStVD; Wed, 30 Mar 2022 09:09:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xz8yh43Ee8bsOdPZexT5kTM/Pf85kWOgS2F3siy5ElI=; b=aZfwJyVTrvxuIj2Xy5lLmW9lGF
        oSbJ8KcTuJsaxOQvWhts64PnQAC89U8Gm9zFnwM8evUriD5z5Cv+wbLGuYDBu1aCikJidQ+ghmxBb
        /GRbW61Vkvuyt1tSJobZs8U56+9uoNo85akwQN0cPKvr/TiYVpEnBqkZ6hQsJRozECHvERv6AScBd
        puMg6xlrzorqgKqo0XrkuYf9QR1khL+y3l79icnm8F2ZgcU4K8kZmuOxPME38nrUPNtdTi8UOcti1
        UT7j238IcDi2/nfcxwoZnDz78w+55EYoq341m3EPo97yrL90SJf0L6C/7vk+bg45o1t06Hp5ZK3rG
        L4SNGJtw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54564)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nZZ0Z-002Dzr-K2; Wed, 30 Mar 2022 14:09:11 +0000
Message-ID: <679dfcda-a0b4-b420-b45b-2ccdc21a579d@roeck-us.net>
Date:   Wed, 30 Mar 2022 07:09:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-2-eugene.shalygin@gmail.com>
 <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
 <CAB95QATxYy5aj97P=S=L-kGE9dppuEbTYq=K=HGMBuZYVUBR4g@mail.gmail.com>
 <1239901b-9b4a-53ef-be86-1aa8337e0f31@roeck-us.net>
 <CAB95QAQGWRT=UsXPn65oiiwBRa1RKj61sg7wq9d7VntnFWzaOg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
In-Reply-To: <CAB95QAQGWRT=UsXPn65oiiwBRa1RKj61sg7wq9d7VntnFWzaOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nZZ0Z-002Dzr-K2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54564
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 00:51, Eugene Shalygin wrote:
> On Tue, 29 Mar 2022 at 22:28, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/29/22 12:22, Eugene Shalygin wrote:
>>> On Tue, 29 Mar 2022 at 15:44, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>>     struct ec_sensors_data {
>>>>> -     unsigned long board_sensors;
>>>>> +     struct ec_board_info board_info;
>>>>
>>>> Please explain why this needs to be the entire structure and not
>>>> just a pointer to it.
>>>
>>> I marked the board_info array as __initconst assuming that this large
>>> array will be unloaded from memory after the init phase, while we keep
>>> only a single element. Is that assumption incorrect?
>>>
>>
>> What happens if you build the driver into the kernel and then instantiate
>> and de-instantiate it multiple times ?
> 
> Sorry, I have no idea because I don't know how to load a built-in
> driver multiple times. But since this driver is attached to a
> motherboard device, which is persistent and always single, do I need
> to consider such a scenario?
> 

Drivers have "unbind" and "bind" attributes, which can be used to unbind/bind
the driver mutliple times. That is quite useful for testing, including for
built-in drivers. As long as the attributes exists, they have to be supported.
This is not about having to consider a scenario, it is about preventing crashes
if existing functionality is used.

Having said that, I notice that the probe function is marked __init. I guess
I didn't pay attention. It may be interesting to build the driver into the
kernel, unbind/bind it, and see what happens.

Guenter
