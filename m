Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB54656CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhLAUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbhLAUBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:01:06 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E3C061757;
        Wed,  1 Dec 2021 11:57:44 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s139so50802283oie.13;
        Wed, 01 Dec 2021 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSiupfPo4YWM0AdAHXHjqq8+PKRjJxz9aP4LHU1ZiSQ=;
        b=gEBU83rBs7p4ai8Y6aHoqbiqS3mEvEZ3rxKOAySRppfqX5hrhXwGsx/uQz5AWBAjHP
         sygULyotzC7UTuIdiYO32GJGMeRgW5dPrwjf/ljAX9vYPS14mT+a0tgCEtR7m+qS0MSr
         vxMPCqAztunXkebHsSw2N4EoVf6iqYha4MAuGR/6BjdyRT33/iRLQdvjyGHv+oK4X80o
         QUWlF6Og0rvC/hscGdut16Wj39pekOWK0jUMjfDSHNYw8gHKjcU89URkeelt/hvItemQ
         lc2fecdBHZ9fivtD84tM/Z8W8oqE+XOZheLZItiVNRWxSlkvmlbA9F2VJf6jKNZ7mtpC
         SM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSiupfPo4YWM0AdAHXHjqq8+PKRjJxz9aP4LHU1ZiSQ=;
        b=IK0Gh+ZMV6dSoSJ0TVvqAdBqL9LbwJ+3U5tzYuHDn0qGppKiBJLBcbn6amDOSiSIHv
         M7aTa/FtNo0pbd2m3uOcGchGUwKfp1dY5tbGtJuwnV6pPkou/2rtmMF1u2u27gyFKkgK
         psSoRoNg5NklR5QMjDai5O32wfjG9JnJixNE8IyVDjXt9pirpMDau0aR6e62iaHXFN82
         p+3YxNXeKsvrLE5LeAKE6xi+qyEnvdkP5X62yuYzkA4b0rRkZ9TG7D6e8L/Uxfxq6kUY
         0Md+jxgC8YKmgNwZc1QxJP+KlB/d4LXa2BZNh8Z4f/ETQok4rUDvwJWh0DC+WzIDqvma
         EhDw==
X-Gm-Message-State: AOAM532YAT6SKFJdeWXCVLoeATh+x+pjQBFcU9/vcB5GeMxiSIpkLBK1
        Jg0lZZKwgJQFgRRNR435ygxC7QGy0L8=
X-Google-Smtp-Source: ABdhPJw7AYMUGm5mqas42geJjbQ4gmIUpy6V1fGfVLPFgBXtnwn243lBc89IiAWxThihFZ2cJpslBw==
X-Received: by 2002:a54:4614:: with SMTP id p20mr336106oip.39.1638388663754;
        Wed, 01 Dec 2021 11:57:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20sm306095ote.28.2021.12.01.11.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:57:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Madhava Reddy Siddareddygari <msiddare@cisco.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210605052700.541455-1-pmenzel@molgen.mpg.de>
 <20210606125012.GA2887349@roeck-us.net>
 <4ea0c5b7-3ccd-d6a1-c7a5-edd7034e6522@molgen.mpg.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (pmbus_core) Check adapter PEC support
Message-ID: <06ca395e-470c-6cf7-4745-1c895e7b7d21@roeck-us.net>
Date:   Wed, 1 Dec 2021 11:57:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4ea0c5b7-3ccd-d6a1-c7a5-edd7034e6522@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 12/1/21 7:58 AM, Paul Menzel wrote:
> Dear Guenter,
> 
> 
> Am 06.06.21 um 14:50 schrieb Guenter Roeck:
>> On Sat, Jun 05, 2021 at 07:27:02AM +0200, Paul Menzel wrote:
>>> From: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>>>
>>> Currently, for Packet Error Checking (PEC) only the controller
>>> is checked for support. This causes problems on the cisco-8000
>>> platform where a SMBUS transaction errors are observed. This is
>>> because PEC has to be enabled only if both controller and
>>> adapter support it.
>>>
>>> Added code to check PEC capability for adapter and enable it
>>> only if both controller and adapter supports PEC.
>>>
>>> Signed-off-by: Madhava Reddy Siddareddygari <msiddare@cisco.com>
>>> [Upstream from SONiC https://github.com/Azure/sonic-linux-kernel/pull/215]
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Applied.
> 
> Thank you very much. Would it be alright, if I asked the stable series maintainers to backport this patch to the Linux 5.10 LTS series?
> 
That is not how it works. The stable maintainers will apply
a backport if you prepare one and send it to the stable
mailing list, but they won't do the work for you.

Having said that, if you want to provide such a backport,
sure, go ahead.

Guenter
