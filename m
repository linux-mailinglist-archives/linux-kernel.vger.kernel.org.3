Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403047B4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhLTVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhLTVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:08:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5A4C061574;
        Mon, 20 Dec 2021 13:08:15 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso1582698otk.5;
        Mon, 20 Dec 2021 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q3PZVJSo3K5moB8cqKpexhdnP7Dl9gnH5q2mQZQj/Dg=;
        b=SVAIos+NLdgiWDje7800YGBZ7Dstmx3Slww0isIeWDsXcW6dx5lykhwL9PBjUVlqQ4
         dcK41zxHWDHffRdMwxWU3qALoxILTLzO8sI+HYZqBRFafMHxsVxqIr0AY1zIcG5kkBOQ
         fyiCVOoh3EpUmyH0TCjKqXBlqQoP2XJ2fVmP9K4teV6Ur58kz6sE08FDbj4bLY1JBAwa
         8Ryrkt7nO+Ew8ViqiV+W9qjxsBAvWhy1uJW4mcoGIq2NIZOsJOGKDUMsLRlvvaHz3J3M
         QLCNf4xeWc7vPacL+y/DJiiFb9myOi72+QyU6illTdtq7oB9GOXLae6PpjwqKmiejY2W
         BnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3PZVJSo3K5moB8cqKpexhdnP7Dl9gnH5q2mQZQj/Dg=;
        b=JG98tPKBS2oAE6VJ2P5Jg3aQ9bB1/v1T/HNNTTzkfdH9D4rse57cUo9B5tNtaDarBI
         S4Zvjsrm+s6cqQotZ5WtNSVxcVkguIet531yXmjxFrP4yv3eEPeNevFgDUid3kUKVLrV
         MwcIK8Y+IIPQa5Eu/bkD5wF+qbHvPbWRyMX+hzbpPDGAP0AKgNo1sXa9KB2FVAFS3Lf8
         AcDeVB9jrvW3T4Weesz/y9ALL6f10v2GAKjjukLAtGEfQyt6O70KWcw3sVtXwxz7GlES
         JwbzbVZdCfiqCU6Jql/ymK12IQ8fyOK2OA10YwGOe4DiQfPthvctuqdyQVUHr7QIzapm
         s6bQ==
X-Gm-Message-State: AOAM53025Dar+MchkX/B8Y719kdHgYYlcZuu9i0XAFww7Cxu4BsNKByq
        yBVvNaZ3EOOXKNajaz48dz0ZkQaIKSM=
X-Google-Smtp-Source: ABdhPJx05JabQpq/ut8e8/5ioqnIN+RlsCKYp/ex9IygkcdWQUen1wpYPyvnQVZtVPKMiFCg5W3lOQ==
X-Received: by 2002:a9d:6394:: with SMTP id w20mr12681958otk.248.1640034494688;
        Mon, 20 Dec 2021 13:08:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm3426950otk.71.2021.12.20.13.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 13:08:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: s3c2410: Fix getting the optional clock
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212170247.30646-1-semen.protsenko@linaro.org>
 <b618ff5b-ee41-2c29-5074-24fd4d0f0933@canonical.com>
 <CAPLW+4=wcWv4P_M8kQDjB=QfT5N+mFKm0mUdSDjGSgLg=pRGSw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ad8719c-1476-3226-e426-a171b46ca568@roeck-us.net>
Date:   Mon, 20 Dec 2021 13:08:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPLW+4=wcWv4P_M8kQDjB=QfT5N+mFKm0mUdSDjGSgLg=pRGSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 7:15 AM, Sam Protsenko wrote:
> On Sun, 12 Dec 2021 at 19:50, Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 12/12/2021 18:02, Sam Protsenko wrote:
>>> "watchdog_src" clock is optional and may not be present for some SoCs
>>> supported by this driver. Nevertheless, in case the clock is provided
>>> but some error happens during its getting, that error should be handled
>>> properly. Use devm_clk_get_optional() API for that. Also report possible
>>> errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
>>> clock provider is not ready by the time WDT probe function is executed).
>>>
>>> Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>   drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
>>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>>
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
> 
> Hi Guenter,
> 
> If there are no outstanding concerns, can you please apply this one?
> Would be nice to see it in v5.17 if that's possible.
> 

I added the patch to my watchdog-next tree, but Wim handles all pull
requests.

Thanks,
Guenter


