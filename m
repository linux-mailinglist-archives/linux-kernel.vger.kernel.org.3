Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E344C97B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiCAVVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiCAVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:21:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD429427E5;
        Tue,  1 Mar 2022 13:20:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x18so15462123pfh.5;
        Tue, 01 Mar 2022 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zcBTrbjX0+CQjxp9R0yaPxHqWIjrxSKZgC3PETeJRJM=;
        b=ZO7Mf+4TigphNBTs6SJUAhkcnXzlmJPgGqbVEklYhU6sh8glYJ1ENl6k56PTgoBWEF
         3l5N/zwvacRlLHlXOKzkmEC2WgEpBY9mYQ2WCyB7D/21wjJCDfrYj3WhD0N7NBsJcUE+
         4XefI9+Hp0sZloIYBARtBhjIEIRcyCQcfcOLVLKKp9NdUb0Gjl23a7W+Qf8bRoiUQ22L
         7UUA8lEMycjfGGDY9OMJPsc3nux26dbh3DBPL1P+SF7OQEBKDgZEQ1FIggibpMBuwNLV
         xipMJ4BRBLp2vpiXTHdcQgvGZbySDtyoiMezvINZ7Io5aqemBhJQkFjfhd98gWwEpiVF
         L4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zcBTrbjX0+CQjxp9R0yaPxHqWIjrxSKZgC3PETeJRJM=;
        b=IR/eTCCUj+ci55ZdnJmbRjyVZhEnFOfayWIwOf40rB+xxVlfpm0fgj5EgRPzOQmYtu
         HGBJRN0gcIGeoeY/JYgbgg6mLZBCOXbvLtRem7rZrkkrO1hAUYRwIW8epPWIchylAWFC
         RQWg/Q27pffqkbMrLnoUdWUPdoJI/YSPJv6y/nlNe3JR3033DkkcMYpn3hJ+T8YdbydX
         KN+K1kLuiopLQq0f54i53xJJfL067HGDJuqcf0RUrPkBjtv/rj+4Nepv84QZ8LuEJpoN
         mxIADfn2fSmwpGenQ/adCHoTd/PY12TDqkwfssQL6esfbGyzcMd5A6RH9u5o8VLpmfDk
         Wk+g==
X-Gm-Message-State: AOAM531JB68nJT47pQyIPc5wkgooj4cXgkDIvlfml/K5bWfQlmgQQ6px
        hK+GrojDnmdH23f7KO7IBy0=
X-Google-Smtp-Source: ABdhPJwHnV9jlJdDpc+Aek6kzoMn7NO58plC1DnzLvnLDuB9dFcDlgCDrupshh2g+/fk0Yv/BKOz5g==
X-Received: by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id t18-20020a63d252000000b00363271cfe63mr23520447pgi.524.1646169634332;
        Tue, 01 Mar 2022 13:20:34 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v189-20020a6389c6000000b00372e3b6fe90sm13949702pgd.55.2022.03.01.13.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 13:20:33 -0800 (PST)
Message-ID: <f5af24df-ceca-16ca-af85-38435130a9de@gmail.com>
Date:   Tue, 1 Mar 2022 13:20:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210426213647.704823-1-f.fainelli@gmail.com>
 <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
 <7359c3c1-8928-d448-e503-13f587cbb567@linaro.org>
 <2f8da2c7-98c5-4061-2e16-42b7fd4f9694@gmail.com>
 <f6f61340-24b1-770e-6b8d-9b47218a87be@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f6f61340-24b1-770e-6b8d-9b47218a87be@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2022 12:47 PM, Daniel Lezcano wrote:
> On 01/03/2022 19:05, Florian Fainelli wrote:
>>
>>
>> On 9/17/2021 12:51 AM, Daniel Lezcano wrote:
>>>
>>> Applied, thanks
>>
>> Was it applied? I still cannot find it in linux-next or Linus' tree.
> I thought it was :/

No worries, I just resent it:

https://lore.kernel.org/lkml/20220301181412.2008044-1-f.fainelli@gmail.com/
-- 
Florian
