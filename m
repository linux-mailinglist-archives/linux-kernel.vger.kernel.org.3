Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05ED464970
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbhLAITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhLAITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:19:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 00:16:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so98393861edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 00:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V6zQR0fGtot8Y0hr0EL8eBOomgUYse/RC/KrmAqMq4c=;
        b=N3Jv//xt4KCpN2hwq3/lUeQmNMzmpXDcMhFnL/mORbGNyheFXxAcmxcjZIhUBxwhaX
         o/YmqiqOI+AaXwMbzZfzLlBXLh8OC+R79N52vzOrY2jsd6rKIfK9hZBc+Ac4S91Cvq96
         8iW0LBMuy52nNLmNYSL/zT9xYIF9AXvK46T7zmSyizmjfuRdDMMysNFgcd0/ObTk4/57
         MpsRx02bRwMDEEP0gRoKs4lhdk275wr6RLzUR0JVKAK3USDVeFKy2eZ4ig7I/srmHUQK
         GKt1sZWFcpan5JoDXhY0gEAK45fPgYC1udTV9J2B7BeNT+7dBsqau0EsmNUv7Kd00ypw
         tNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V6zQR0fGtot8Y0hr0EL8eBOomgUYse/RC/KrmAqMq4c=;
        b=NsoStL9mOjwmn5iYCnnme2hgcAbkrUJGheMeUsQyNYqauyT21T7OJazl2u977hz+6p
         Rfi3EJ/Bso4KR1mzEYYbT7uur4Ig/31lQtiUJJWErliOfQLi24hmjyM3izQtKIibbOn+
         bpKyJQwqlehox2T9cQ7Je5Y/W66QdHy4yBwo4Q+9K/AfVdmhvPQtzPFoW3sXu7AxIZG1
         XG2qJo0Yn8OYQRpoAC4b9n0vso64haYSYpaoTkeSI/ssFAw5LODQJu+K+EjzGSU8iZvE
         /NIi072jE5lArTr4l1LFgZSyr6CE3benlPV9FB52vvcKAel6DH/gjZtRU2gUrALUm6Wj
         4GhA==
X-Gm-Message-State: AOAM532gJx0MQxpPcdrJS5vWSgmMaHiGNThOfWVi8z0x8hn+uOpVQZfO
        RAvwRdQGSpvANEP2CymL+wAo4g==
X-Google-Smtp-Source: ABdhPJw2TIwxrsYqtYN6BP9l9K2r8DpCSdz3W6t0gaidwFtoXgWxuCKj5Yk5vxSQdBMhC85ZX3lSVQ==
X-Received: by 2002:a05:6402:42d4:: with SMTP id i20mr6507147edc.372.1638346572931;
        Wed, 01 Dec 2021 00:16:12 -0800 (PST)
Received: from ?IPV6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id hq37sm11047185ejc.116.2021.12.01.00.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 00:16:12 -0800 (PST)
Message-ID: <734dfe79-6e3f-1e68-c167-bab3ae9e8d52@monstr.eu>
Date:   Wed, 1 Dec 2021 09:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Olga Kitaina <okitain@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-mtd@lists.infradead.org, nagasure@xilinx.com, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org
References: <20211127180758.30884-1-okitain@gmail.com>
 <20211129095559.01aa63a6@xps13>
 <3da5dff5-53d4-15db-075d-9b195f2f75dd@gmail.com>
 <20211130082017.1400f24b@xps13>
 <fb6a4b49-7c10-4ed1-7054-5dd8ce2d8073@gmail.com>
 <20211201090941.73e67f65@xps13>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20211201090941.73e67f65@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 12/1/21 09:09, Miquel Raynal wrote:
> Hi Olga,
> 
> + Michal (please add him in Cc of your next iteration)
> 
> okitain@gmail.com wrote on Tue, 30 Nov 2021 23:08:20 +0300:
> 
>> Hi Miquel,
>>
>> On 30.11.2021 10:20, Miquel Raynal wrote:
>>> Hi Olga,
>>>
>>> okitain@gmail.com wrote on Mon, 29 Nov 2021 21:06:05 +0300:
>>>    
>>>> Hi Miquel,
>>>>
>>>> On 29.11.2021 11:55, Miquel Raynal wrote:
>>>>> Hi Olga,
>>>>>
>>>>> Please add all the MTD maintainers in copy, as requested by
>>>>> get_maintainers.pl.
>>>>>
>>>>> okitain@gmail.com wrote on Sat, 27 Nov 2021 21:07:58
>>>>> +0300:
>>>>>      
>>>>>> According to the Arasan NAND controller spec,
>>>>>> the flash clock rate for SDR must be <= 100 MHz,
>>>>>> while for NV-DDR it must be the same as the rate
>>>>>> of the CLK line for the mode.
>>>>>
>>>>> I completely missed that, where did you get the information?
>>>>
>>>> The "Data Interface Transitions" chapter of the spec contains timings for flash clock setup in NV-DDR
>>>> and NV-DDR2 modes. The "time period" of those clocks is equal to tCK in NV-DDR and tRC in NV-DDR2.
>>>>
>>>> The same chapter should have information about necessary steps to switch from NV-DDR to SDR,
>>>> which includes setting the flash clock to 100 MHz.
>>>>
>>>>
>>>> Just to make sure i'm not shooting myself in the foot: am I changing the right clock?
>>>> The documentation points out that we have to change flash_clk, which i thought was
>>>> nfc->controller_clk and set up by anand->clk, but it seems like it might actually be nfc->bus_clk.
>>>
>>> I believe I made a serious mistake, re-reading the code it feels like
>>> I'm changing the system's clock (which basically changes nothing in our
>>> case) instead of changing the NAND bus clock.
>>>    
>>>> In that case, does setting nfc->controller_clk to 100 MHz by default make sense?
>>>> There isn't a hard limit on what the system clock might be (beyond a specific SoC),
>>>> but there are timing requirements for the flash clock, and so setting a specific
>>>> system clock frequency seems unnecessary for most devices.
>>>>   
>>>
>>> Please create a two-patch series:
>>> 1- Setting the right clock in the current code base (inverting bus_clk
>>> and controller_clk where relevant, setting one to 100MHz and letting
>>> the other as it is)
>>> 2- Changing the default NV-DDR rate based on tCK (below patch).
>>>
>>> Do you have the necessary hardware for testing?
>>
>> I'm sorry to say - I do not. The SoC this problem was initially noticed on can't run latest Linux,
>> and even if it did I have no way of acquiring an NV-DDR-capable flash.
>>
>> Since Bootlin merged in NV-DDR support into the kernel, is it possible for you to test
>> the next iteration of this patch series on NV-DDR hardware as well?
>> Say, by purposefully preventing NV-DDR mode 5 from being chosen in anfc_setup_interface()?
> 
> I don't have the hardware anymore.
> 
> Please send a v2 with the necessary changes, then we will ask Naga (or
> somebody else from the same team) with access to the board to test it.

Keep Amit in loop. He has access to HW and able to test.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

