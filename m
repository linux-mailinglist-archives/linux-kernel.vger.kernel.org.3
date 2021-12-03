Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC0467EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383088AbhLCU1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383061AbhLCU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:27:37 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E7FC061751;
        Fri,  3 Dec 2021 12:24:13 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so4786108otv.9;
        Fri, 03 Dec 2021 12:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SB5nO6GMOsdpAGwiwGyDMuxFOk1QphTKVAVEfv8rscg=;
        b=Exo5knQ8sty9K+cjzjD8nzNce34e5NeGbr+rxKC30t8FITLhyfwAsxjZNEuVIX9g36
         r+Zc7wqmS4u2BccDc5F+Uw8aYlBbLLlHHv4a5tyut2aer/8jqPPplMlom0X06x26X/tG
         3bDQ97n4fDt+yoK0sAmjId4ufKqxQIMCLyGSqagmCnzBt56iZwADKRBETqsgakN++aCs
         o75TVLJF4GvX7pyFQMk67bSpFcYTUq2PM4RzCm/KIP8bce/zcg+qPU2kWoOQpTiIxkKa
         PA9FnLpzVJD0pQxUHKUewhgS0NruDMTDHH6aRJ/STj6KG+5cF6ZjBJSyPy58yuhHPgUG
         wmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SB5nO6GMOsdpAGwiwGyDMuxFOk1QphTKVAVEfv8rscg=;
        b=AXKj+PI89Vnyr9ZucOHZS9RvFPX0kgbeDWz0WycMu+Jn+YJWdRsKCi1xho+A+1oiZP
         GKFG+agh+wVN215ruxJDb5WA6YUkYwfWXYpJhy585MF8nsGcKgZuJ8uYEXeW8++OoD0V
         Y2TPOzQDxsxmCgcCC29TJnvUjN8zXaPcoU80hRj0Ka67HDHJT8sa60qybIys0rB2sJji
         ccw26tmgei1eI0OLwrfrekxs8zwymvANtWQLthnzoyKViA2s/4/coOAbcfjPlLwtLZQW
         d+HRnjrSVIolWyxap+WkoFpxTHsYUcl5y2cWtPoMejv9eIIijqMRVVyMOkfAUeCRR0r8
         1eKA==
X-Gm-Message-State: AOAM532ldo++iJSstJ17t5blBMdwuzoEaT2Ab2r5lqz8PP2Rz0Inmc/d
        4ZGpNoHwM1s23YqWhRLtZsU=
X-Google-Smtp-Source: ABdhPJyRXmuAJ5KD1CBwaCKjwejh0mP+Mkxn6KJLaD7Q/fJvj6Q4zZs4/EQfOpQV0EaN/0bziR8QmQ==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr18303979otq.8.1638563052437;
        Fri, 03 Dec 2021 12:24:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b22sm849627oib.41.2021.12.03.12.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:24:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 0/7] Removal of bcm63xx-wdt
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211112224636.395101-1-f.fainelli@gmail.com>
 <78c9c9f7-7e7c-abde-066a-240d642f3412@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e63401b1-b924-a08c-98dd-5ce8ba1a89c3@roeck-us.net>
Date:   Fri, 3 Dec 2021 12:24:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <78c9c9f7-7e7c-abde-066a-240d642f3412@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 12:07 PM, Florian Fainelli wrote:
> On 11/12/21 2:46 PM, Florian Fainelli wrote:
>> his patch series prepares the bcm7038_wdt driver to support its bcm63xx
>> counter part, updates the MIPS BCM63xx platform code to provide the
>> necessary information about the "periph" clock, and finally proceeds
>> with removing the bcm63xx_wdt altogether.
>>
>> This was only compiled tested as I did not have a readily available
>> BCM63xx system to test with.
>>
>> This should also help with adding support for BCM4908 which Rafal is
>> working on.
>>
>> Changes in v5:
>> - removed unnecessary "bcm7038-wdt" platform devtype
>> - added Rob's Reviewed-by tags to the 2 binding patches
>>
>> Changes in v4:
>> - fixed binding patch (Rob, Guenter)
>> - updated Kconfig description title to mention BCM63xx
>>
>> Changes in v3:
>>
>> - added Guenter's and Thomas' tags to patch 6
>> - added missing initialization of id_table
>> - use Rafal's latest binding patch
>>
>> Changes in v2:
>>
>> - added Guenter's Reviewed-by where given
>> - update binding patch to pass make dt_bindings_check (Rob)
> 
> Are we good with this version? If so, could it be picked up so we have
> one less driver to care about, and we have one additional binding
> converted to YAML?
> 

It is queued in my watchdog-next branch, so Wim will hopefully
pick it up either from there or from the mailing list.

Guenter


