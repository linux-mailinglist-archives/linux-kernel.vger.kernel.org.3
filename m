Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548CB4DD6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiCRJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiCRJIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:08:04 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AF62B5AFC;
        Fri, 18 Mar 2022 02:06:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id s25so13056593lfs.10;
        Fri, 18 Mar 2022 02:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=r6chtYaabySry09fLVBOU+taqstWPxdB+BQ1sTLpZ1E=;
        b=2B8HD3V+1Lb0V+1M2yPgVTxACeHL0YdUXtmMf7h3ExhYTHNwkXBMjKduWiKcD+UrRi
         wcT4ldbNUP+4SpP0B4v7a/6u5Z7VMpizhnEvcxidL0/mYVYPBAbZ64Lq7YoCBGT8BmWN
         RG2BsjAmg/nxa4b9g7IlmPj3+kqo0hF60hLH6qAp1CQY7boLPWF7VTc+A1TTERoX+F/3
         TptJJnrBxN+xiu6AB84ysExooon/W/j901Gtef9aZCo5qxKiyPC1g3cypF2ho2vKm++1
         kq3GQqdGOnPXJGetJ0Oddiyl3xSNuCSbLK/3l46c2ecIN6r4xB4TmLJOWVF2AFCrH+A7
         fvyA==
X-Gm-Message-State: AOAM532kpb/RYcVnYo1+Q1aN2kqNUHs27sPVB0rqJHtcjBd5wXWS3LXM
        OhXhajtlu2aGZ/3W3tyMTtA=
X-Google-Smtp-Source: ABdhPJxMvrCLFptw6sE/CcSGTU6Jey6SuneKAqL3nEIIKW8yEeMQkUMf9/eN07pUZ+nelwnYIoG0xg==
X-Received: by 2002:a05:6512:1513:b0:448:39c0:def0 with SMTP id bq19-20020a056512151300b0044839c0def0mr5343027lfb.469.1647594404296;
        Fri, 18 Mar 2022 02:06:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id k2-20020a056512330200b0044a096ea7absm262952lfe.54.2022.03.18.02.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:06:43 -0700 (PDT)
Message-ID: <f15c415a-ad08-ae4f-c79c-574964ab9cb0@kernel.org>
Date:   Fri, 18 Mar 2022 10:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: Add unit conversion
 macros
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-2-sebastian.krzyszkowiak@puri.sm>
 <97d88728-4e73-0820-07e7-199377ebff2a@kernel.org>
 <3c890d11-75c6-8370-5659-a78b1a9baea2@redhat.com>
In-Reply-To: <3c890d11-75c6-8370-5659-a78b1a9baea2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 10:00, Hans de Goede wrote:
> Hi,
> 
> On 3/18/22 09:16, Krzysztof Kozlowski wrote:
>> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
>>> Instead of sprinkling the code with magic numbers, put the unit
>>> definitions used by the gauge into a set of macros. Macros are
>>> used instead of simple defines in order to not require floating
>>> point operations for divisions.
>>>
>>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>>> ---
>>>  drivers/power/supply/max17042_battery.c | 40 +++++++++++++++----------
>>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
>>> index ab031bbfbe78..c019d6c52363 100644
>>> --- a/drivers/power/supply/max17042_battery.c
>>> +++ b/drivers/power/supply/max17042_battery.c
>>> @@ -51,6 +51,15 @@
>>>  
>>>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>>>  
>>> +#define MAX17042_CURRENT_LSB		1562500ll /* µV */
>>
>> Is this really long long? The usage in max17042_get_status() is with int
>> operand and result.
> 
> The "ll" is part of the original code which these macros replace,
> dropping the "ll" is IMHO out of scope for this patch, it would
> clearly break the only change 1 thing per patch/commit rule.

Not in max17042_get_status(). The usage there is without ll. Three other
places use it in 64-bit context (result is 64-bit), so there indeed. But
in max17042_get_status() this is now different.


Best regards,
Krzysztof
