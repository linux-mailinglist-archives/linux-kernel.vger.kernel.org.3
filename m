Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F3E547F40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiFMFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiFMFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:46:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F46581;
        Sun, 12 Jun 2022 22:46:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25D5kccK099819;
        Mon, 13 Jun 2022 00:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655099198;
        bh=YGrd/7kl44LtBnocymnKeoW4pEzFWqJ8jpENxUsO5Ug=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cXuRNnIsDUbn1d/dCjQoZ9pn56r+PMRmMYMsJa60XoJO/WOv5vjBD9roceAjAq8Zf
         TVMx5jXH8rQc3IuA15atWOMarprN7LMGaY9SX1uom0MagJ2uQlqTXwGor2CKKDm3Mo
         0z26zVtgZ8w6/BYOY6MDKJSzbGyA0YqV/eGSevHg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25D5kcUj118310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jun 2022 00:46:38 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 13
 Jun 2022 00:46:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 13 Jun 2022 00:46:38 -0500
Received: from [172.24.145.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25D5kZtT073781;
        Mon, 13 Jun 2022 00:46:35 -0500
Message-ID: <2aa6259b-92b8-e169-7004-1876a7aaa1fd@ti.com>
Date:   Mon, 13 Jun 2022 11:16:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] gpio: davinci: Add support for system suspend/resume
 PM
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220610054622.21281-1-a-govindraju@ti.com>
 <CAHp75VdPXHF96B5QWNOS3zfF+EOnWeRe+LCGnjvLBcb30kVzWg@mail.gmail.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <CAHp75VdPXHF96B5QWNOS3zfF+EOnWeRe+LCGnjvLBcb30kVzWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/06/22 17:50, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 8:08 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>>
>> From: Devarsh Thakkar <devarsht@ti.com>
>>
>> Add support for system suspend/resume PM hooks, save the
>> register context of all the required gpio registers on suspend
>> and restore the context on resume.
> 
> the resume
> 

Fixed this in respin
> ...
> 
>> +       writel_relaxed(0xFFFFFFFF, &g->intstat);
> 
> GENMASK(31, 0) ?

Used this instead of the direct value in the respin

> 
> ...
> 
>> +static int __maybe_unused davinci_gpio_suspend(struct device *dev)
> 
>> +static int __maybe_unused davinci_gpio_resume(struct device *dev)
> 
>> +static const struct dev_pm_ops davinci_gpio_dev_pm_ops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(davinci_gpio_suspend, davinci_gpio_resume)
>> +};
> 
>> +               .pm = &davinci_gpio_dev_pm_ops,
> 
> Can you utilize pm_sleep_ptr() and corresponding macros instead of
> __maybe_unused?

Used pm_sleep_ptr instead of the __maybe_unused in the respin.

Thank you for the review. I have posted a respin(v3) for this patch,

https://patchwork.ozlabs.org/project/linux-gpio/patch/20220613054310.21186-1-a-govindraju@ti.com/

-- 
Thanks,
Aswath
