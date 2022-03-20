Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9522B4E1B93
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiCTMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiCTMUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:20:15 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDE1EEC7;
        Sun, 20 Mar 2022 05:18:52 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id b15so15072602edn.4;
        Sun, 20 Mar 2022 05:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0ngaHSzUacrYaeOGJ+j5/OjSsoxw0oxsf+1Qqz4bC0E=;
        b=Lkps+qH/iqATOKd/DDLWbq3l2YgsSDWZUsljt7tmW0/cz+jTiV45+VKkgyVDXTR4yL
         y+oaIyJty7htghbAeUveKJpLRcRs6gaiOQvRTiiiCnOrWAoILKRayGEqjIrj4prUShW5
         +BzmgjntX5hZoQBD0aLk1/dK2ox6j8S4FHX6rFbCWsCDopEH83/BubvsJU0vKS8hPFZ7
         eka3X+bWZjgUgV7Vy183Af9XqxuKbyeTnkauO2bV2nmRa8VjpuSEHBm+27JkAvzp0t4U
         tcM2xLAFmaWANCVHsAQ2XMT62ZSXuZfZUMBEGnLDNev5oHsIyyacmA5PEqeGQTImfjrR
         b7Uw==
X-Gm-Message-State: AOAM5313uGI4CYypvDG0L7ckVl9PI9tblC/bx803nEUgw41gotez6j6x
        b8yePSUhmv/8CIaSq02CMDE=
X-Google-Smtp-Source: ABdhPJzXA2wIFJ4JL7RhzGich0KS3Vh2dxbivOsInGQMtbtarLE/kL4X++EBMMTk6Yz+D+yCsfuWyw==
X-Received: by 2002:aa7:dbd0:0:b0:416:633c:a0cc with SMTP id v16-20020aa7dbd0000000b00416633ca0ccmr18225070edt.349.1647778730960;
        Sun, 20 Mar 2022 05:18:50 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p3-20020a1709060e8300b006d0e8ada804sm5667823ejf.127.2022.03.20.05.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:18:50 -0700 (PDT)
Message-ID: <5d43031e-382d-b12c-bba2-0e630fbec1ad@kernel.org>
Date:   Sun, 20 Mar 2022 13:18:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh
 on max17055
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm>
 <facf5551-bfc7-aeb4-daed-5bfcb8a36475@kernel.org>
 <7080597.aeNJFYEL58@pliszka>
In-Reply-To: <7080597.aeNJFYEL58@pliszka>
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

On 18/03/2022 20:58, Sebastian Krzyszkowiak wrote:
> On piątek, 18 marca 2022 09:22:16 CET Krzysztof Kozlowski wrote:
>> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
>>> Unlike other models, max17055 doesn't require cell characterization
>>> data and operates on smaller amount of input variables (DesignCap,
>>> VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
>>> by max17042_override_por_values, however model refresh bit has to be
>>> set after adjusting input variables in order to make them apply.
>>>
>>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>>> ---
>>>
>>>  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
>>>  include/linux/power/max17042_battery.h  |  3 +
>>>  2 files changed, 48 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/max17042_battery.c
>>> b/drivers/power/supply/max17042_battery.c index
>>> c019d6c52363..c39250349a1d 100644
>>> --- a/drivers/power/supply/max17042_battery.c
>>> +++ b/drivers/power/supply/max17042_battery.c
>>> @@ -806,6 +806,13 @@ static inline void
>>> max17042_override_por_values(struct max17042_chip *chip)> 
>>>  	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
>>>  		
>>>  		max17042_override_por(map, MAX17047_V_empty, config-
>> vempty);
>>>  	
>>>  	}
>>>
>>> +
>>> +	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
>>> +		max17042_override_por(map, MAX17055_ModelCfg, config-
>> model_cfg);
>>> +		// VChg is 1 by default, so allow it to be set to 0
>>
>> Consistent comment, so /* */
>>
>> I actually do not understand fully the comment and the code. You write
>> entire model_cfg to MAX17055_ModelCfg and then immediately do it again,
>> but with smaller mask. Why?
> 
> That's because VChg is 1 on POR, and max17042_override_por doesn't do anything 
> when value equals 0 - which means that if the whole config->model_cfg is 0, 
> VChg won't get unset (which is needed for 4.2V batteries).
> 
> This could actually be replaced with a single regmap_write.
> 

I got it now. But if config->model_cfg is 0, should VChg be unset?


Best regards,
Krzysztof
