Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0067847CE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbhLVJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbhLVJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:02:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:02:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bq20so3901201lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=VDdusWnmXaR3nxorqCBH/H6b5AMX/vYTXou53++UlL0=;
        b=P4T3wD1CogcUbJ1LKPN43Lwus7GYdbLfZBB1/QgBYlpwQYXEyrbSIDJBpYVRp0hVe2
         n26lKzD6/zbaamDaK14tnu4oqmEMl0sgIZoAjTUjBgO3FiAljVRzBiqtNClo1UN43cKG
         uF/b73Uypx3ZkH22D7J1/TkfqTXv1uxSovZazVklujbkl4vMGrhd9xErR615PArLgShI
         MAh3AQYzoGSXNQd4WD9emWzUAfgnxkmbdqN1Kugkr0tFnXhMgpeP5O9h5kvGV7HzQP8y
         TDM0UepxATBaNt3Nxpt18WtUFe3l2v8eQOFWPsnGNuLES+r9D4TFTiN1mGaYUDpyaOuU
         ZUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VDdusWnmXaR3nxorqCBH/H6b5AMX/vYTXou53++UlL0=;
        b=VJcDC6n8kjnPV+36YT8Tj4/MqVPZLRcy1uNrqhPKQKnUeryIfQjmQSS0OHI9Nep3IX
         b2TW6ZXZsazxgSOmylCtT14TlyXhDHR9dgkMEINfGGNfDnsSzGnlxubT06kw+EE7Bm03
         DT/mozqBI998bIPhYaYDRfEZfl+ShmCl5EMBbOoqmdpjkipOvHBDRQh6hJqaYRjQZ1c2
         CEwlX//emUxdylgXFd5JlDKPE8j3iV5hnZ5rzCL6FfhyZ2VAk2XpsU1vl+H+c5dJau3J
         vEdjvngkzhvBrCoZP7llKeo6O4xlWCV3R+03erfL3jGOL5N2mF3TfiSLAu8Ja892VrhW
         1AeQ==
X-Gm-Message-State: AOAM532RSK/onEthWzE6oc4wCL1EFL45HctY64KEjNi0/pX/Ip/f5ekt
        KX6HkveIz4K46yQm0Jiflgo=
X-Google-Smtp-Source: ABdhPJzn8kemUt6O32Twz61oBnYSmy+glvsbxZpzt4P73mj0CWxOzOUdLHZfYw59rMVUHCMGkZPCwA==
X-Received: by 2002:a05:6512:3d02:: with SMTP id d2mr1783774lfv.78.1640163765058;
        Wed, 22 Dec 2021 01:02:45 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j22sm152044lfu.155.2021.12.22.01.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:02:44 -0800 (PST)
Message-ID: <3b4656cf-3c00-9a0e-c38e-33c2934a2aa5@gmail.com>
Date:   Wed, 22 Dec 2021 10:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register() error
 path
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com> <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com> <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <YcLoPV6A9XJImBXa@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcLoPV6A9XJImBXa@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 09:56, Greg Kroah-Hartman wrote:
> On Wed, Dec 22, 2021 at 09:38:27AM +0100, Johan Hovold wrote:
>> On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
>>>> On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
>>>>> On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
>>>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>>>
>>>>>> 1. Drop incorrect put_device() calls
>>>>>>
>>>>>> If device_register() fails then underlaying device_add() takes care of
>>>>>> calling put_device() if needed. There is no need to do that in a driver.
>>>>>
>>>>> Did you read the documentation for device_register() that says:
>>>>>
>>>>>    * NOTE: _Never_ directly free @dev after calling this function, even
>>>>>    * if it returned an error! Always use put_device() to give up the
>>>>>    * reference initialized in this function instead.
>>>>
>>>> I clearly tried to be too smart and ignored documentation.
>>>>
>>>> I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
>>>> Most kernel functions are safe to assume to do nothing that requires
>>>> cleanup if they fail.
>>>>
>>>> E.g. if I call platform_device_register() and it fails I don't need to
>>>> call anything like platform_device_put(). I just free previously
>>>> allocated memory.
>>>
>>> And that is wrong.
>>
>> It seems Rafał is mistaken here too; you certainly need to call
>> platform_device_put() if platform_device_register() fail, even if many
>> current users do appear to get this wrong.
> 
> A short search found almost everyone getting this wrong.  Arguably
> platform_device_register() can clean up properly on its own if we want
> it to do so.  Will take a lot of auditing of the current codebase first
> to see if it's safe...

If so many people get it wrong maybe that is indded an unintuitive
design?

I'll better hide now ;)
