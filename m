Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49DA49FDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiA1QMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiA1QMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:12:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A097C061714;
        Fri, 28 Jan 2022 08:12:05 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so11345149pju.2;
        Fri, 28 Jan 2022 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T0gAqCfOxCNh3Tki5mXje3PXqfET1SNQsXyN2HdLLdE=;
        b=o4vTZcMdl7aQ5CinIIevTCCp1Vvw+vsssds9tjxQW3nKc8CD5CjVfz2KVEwe8BHbTV
         tA/hTywAnOPEjUgWS4BAA7fQbw/DSChEe0Nw9sCiPoMLfvS14uTisjISopb/qBTf6ID5
         VxFDf7vUJEO4PrWkQ+3zTGhaGkCpYJF22MNW3Bnf60GpuBC7rjgS9ufOLpXOr2/AzpM9
         cog9GtKm8stFUxhWyGbd1rfqjJ3X6RJSOz96H0t1pGATrwUl5jP/BnqMbrHB/Itw7om2
         CF1+GfxV0W3WaRRabruZ6+rr29hQcPwY1VNWDZWst1AYCQixQZQLNGoZ14WwXvPvarDN
         7NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T0gAqCfOxCNh3Tki5mXje3PXqfET1SNQsXyN2HdLLdE=;
        b=I1f67TqYbaI656F0WQoI0QzVGtI0fAO5KlDI98URYszzIxav4PxD1PbJmC4UXgH26R
         LPqFcHtjh2ZGhmgzevy1oSWEHz3Jpj1TCRaj/hfdkFO/v6EwNf6QYEKHmnj6tm1u2dK6
         YKDlZc8Dgt+BQhcYyty7iSQNBDEXpWTYtHcKLPDUT/Q74TLtoLrxZmw9Aw4iaL18ii+8
         Olmzvle27C1WZXdwH8+mjHBaMYJ6JI6qbQO3rcJxKQ5Zp5jyRSPHGAWmoOHsA5cHo2A+
         YdpruYOUDzsOsMH7qYNnDqX/L4WPvx9EzY9ZspHkzlXw6fzx21J6u7TskdP2Fl7kgHRE
         9a1g==
X-Gm-Message-State: AOAM531j2Y1Xujl0D8e3WibmarMFNqRf317VBNu87vbfSW90uebHcHqe
        N304wM2g436Oej+PjsvNJPM=
X-Google-Smtp-Source: ABdhPJyr+/E6lg9lmSxPC+5Zd4f66JpwmC73WNLq4sP3COaactSNFP3PPgMKohlTGYJLkfs3sF/eww==
X-Received: by 2002:a17:902:ec86:: with SMTP id x6mr9326466plg.96.1643386325042;
        Fri, 28 Jan 2022 08:12:05 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id y13sm10026244pfi.2.2022.01.28.08.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:12:04 -0800 (PST)
Message-ID: <f28cba7f-6799-9f08-71b2-249a2a506913@gmail.com>
Date:   Fri, 28 Jan 2022 08:12:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] pinctrl: bcm2835: Fix a few error paths
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jason Wang <wangborong@cdjrlc.com>,
        Marc Zyngier <maz@kernel.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220127215033.267227-1-f.fainelli@gmail.com>
 <YfP/TuEERCrgst+k@smile.fi.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YfP/TuEERCrgst+k@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2022 6:35 AM, Andy Shevchenko wrote:
> On Thu, Jan 27, 2022 at 01:50:31PM -0800, Florian Fainelli wrote:
>> After commit 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio
>> hogs") a few error paths would not unwind properly the registration of
>> gpio ranges. Correct that by assigning a single error label and goto it
>> whenever we encounter a fatal error.
> 
>>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> While this seems legit per se, my eyes caught this:
> 
> 
>>   	if (!girq->parents) {
>> -		pinctrl_remove_gpio_range(pc->pctl_dev, &pc->gpio_range);
>> -		return -ENOMEM;
>> +		err = -ENOMEM;
>> +		goto out_remove;
> 
> Non-devm....
> 
>>   	}
>>   
>>   	if (is_7211) {
>>   		pc->wake_irq = devm_kcalloc(dev, BCM2835_NUM_IRQS,
>>   					    sizeof(*pc->wake_irq),
>>   					    GFP_KERNEL);
> 
> ...followed by devm.
> 
> It means more ordering bugs in the ->remove() and error path are lurking
> around. Can you double check and be sure that we do not have a case where
> non-devm registration code followed by devm?

It seems to me like we are fine with the patch as is, because:

- girq->parents is allocated with devm
- pc->wake_irq is allocated with devm
- name is allocated with devm

and those are the only variables being allocated for which we also 
process an error handling path.
-- 
Florian
