Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A350EBED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiDYW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiDYWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:10:25 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8181D33F;
        Mon, 25 Apr 2022 15:07:16 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6C6E6806B7;
        Tue, 26 Apr 2022 00:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1650924434;
        bh=3xdUpz0rxOpaFXzw5F0nSyIQaIXNBm7+paVzz99k0qk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=QH0u//pMrhzlghzFLFFQUSLoTUPjS9kwA5AOm14Y6mj84GUj+/pSvTa6HAUNWMH3i
         E6OyUUUl0+Jx7TdyYh9IKkBf9OUbzYQhewlQ9zikp5CZqQq+JivK4CkZfk4F/THr9b
         jgLdExXdNzLJvAQM4tGKstaAklhCJdUtZHn2IAkyAjo4qvnM0rFYVCyqkwk0V6qw21
         dQc6ITPuRK/dWI+cT2jIVWVQNXV8UY6DpNxKartwFKkJnxVLopj/Zl1OvlKcQfhKId
         hc2pW/tTqN7EmA2FL8zIdUS/2s3+2hsEk6W/HtsQSgumfP2drMM/INNDvp6UiMgNkS
         aqMqT/0qvR4Hw==
Message-ID: <580a2c04-67ca-17f3-54ec-5b07ca46c254@denx.de>
Date:   Tue, 26 Apr 2022 00:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] pinctrl: stm32: improve bank clocks management
Content-Language: en-US
To:     Fabien DESSENNE <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220422143608.226580-1-fabien.dessenne@foss.st.com>
 <c48500cd-50be-1d70-2f2c-02c2dcede1eb@denx.de>
 <442677d2-7e9f-14f0-4b5a-1f98a8f40c8a@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <442677d2-7e9f-14f0-4b5a-1f98a8f40c8a@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 11:27, Fabien DESSENNE wrote:
> Hi Marek
> 
> 
> On 22/04/2022 18:26, Marek Vasut wrote:
>> On 4/22/22 16:36, Fabien Dessenne wrote:
>>> Instead of enabling/disabling the clock at each IO configuration update,
>>> just keep the clock enabled from the probe.
>>> This makes things simpler and more efficient (e.g. the time required to
>>> toggle an output IO is drastically decreased) without significantly
>>> increasing the power consumption.
>>
>> [...]
>>
>>>   static struct irq_domain *stm32_pctrl_get_irq_domain(struct 
>>> device_node *np)
>>> @@ -1575,6 +1537,10 @@ int stm32_pctl_probe(struct platform_device 
>>> *pdev)
>>>               ret = stm32_gpiolib_register_bank(pctl, child);
>>>               if (ret) {
>>>                   of_node_put(child);
>>> +
>>> +                for (i = 0; i < pctl->nbanks; i++)
>>> +                    clk_disable_unprepare(pctl->banks[i].clk);
>>> +
>>
>> There are clk_bulk_*() functions, maybe you can use those to get rid 
>> of these loops ?
> 
> This sounds goods, but checking more in details I see that moving to the 
> 'bulk' implementation would require to move the clk information from the 
> "struct stm32_gpio_bank *banks" member to its parent "struct 
> stm32_pinctrl".
> 
> This would make the clk device information stored in a different 
> structure from the other device-related information (base address, reset 
> control, ...). It's better to keep all those information together in the 
> same struct.
> 
> As another drawback we would loose access to 'clk' from any function 
> that have 'bank' (or 'struct gpio_chip *chip') as input parameter (e.g. 
> stm32_gpio_get() called from gpiolib).
> 
> So I really prefer to keep the current implementation.

All right, I agree.

>> The rest looks good to me.

Reviewed-by: Marek Vasut <marex@denx.de>
