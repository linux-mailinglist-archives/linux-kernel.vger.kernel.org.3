Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16149C822
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiAZK4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240353AbiAZK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:56:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD2C061747;
        Wed, 26 Jan 2022 02:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B7ECB81B99;
        Wed, 26 Jan 2022 10:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C24C340E3;
        Wed, 26 Jan 2022 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643194592;
        bh=XJR5HvUYFxeyUhmHn7KIZBZT/f62u0INwZIAbV9a60k=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Ycn7YirfIVJIlVWVlgAmOHvqy4hbwLiE8mdTAZH9GDit/LRXsHjbZh7eH9x456PiQ
         OIqtgqXfAv7FWhzwMc2Q8MLxY0RO1DpjwWizJjUxsH+6FcAoA3qTvkGY5A9L/wuAiL
         6xrkHI78yv7+/CSscCtz2jS5zXaTWqp4iXC3yg6jqLTz2aeq842385JwLqyHyab+jU
         Pr3VKjgV9G2j8iCMlEOEonmuzFMPLi2AQIVXAzNmF2zm+r7cKxBInv0SqeDMzaCU59
         ms2t8vmTdikdclKq34h4B6ROSqQfXHMcLyJissEV5HQdI4j7qq8MbAUBTiPEMGfHPZ
         euq5dAjUFMz2Q==
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
 <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
 <524027b7-1361-7cc2-842f-7c20cd4cb016@synopsys.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Date:   Wed, 26 Jan 2022 12:56:04 +0200
In-reply-to: <524027b7-1361-7cc2-842f-7c20cd4cb016@synopsys.com>
Message-ID: <87ilu67okj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>>>> On 1/24/22 5:46 PM, Thinh Nguyen wrote:
>>>>> Sean Anderson wrote:
>>>>>> GUCTL.REFCLKPER can only account for clock frequencies with integer
>>>>>> periods. To address this, program REFCLK_FLADJ with the relative error
>>>>>> caused by period truncation. The formula given in the register reference
>>>>>> has been rearranged to allow calculation based on rate (instead of
>>>>>> period), and to allow for fixed-point arithmetic.
>>>>>>
>>>>>> Additionally, calculate a value for 240MHZDECR. This configures a
>>>>>> simulated 240Mhz clock using a counter with one fractional bit (PLS1).
>>>>>>
>>>>>> This register is programmed only for versions >= 2.50a, since this is
>>>>>> the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
>>>>>> adjustment quirk").
>>>>>>
>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Also program GFLADJ.240MHZDECR
>>>>>> - Don't program GFLADJ if the version is < 2.50a
>>>>>>
>>>>>>  drivers/usb/dwc3/core.c | 37 +++++++++++++++++++++++++++++++++++--
>>>>>>  drivers/usb/dwc3/core.h |  3 +++
>>>>>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>>> index 5214daceda86..883e119377f0 100644
>>>>>> --- a/drivers/usb/dwc3/core.c
>>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>>>>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>>>  {
>>>>>>  	u32 reg;
>>>>>> -	unsigned long rate, period;
>>>>>> +	unsigned long decr, fladj, rate, period;
>>>>>
>>>>> Minor style nit: Felipe prefers to keep the declaration on separate
>>>>> lines, let's keep it consistent with the rest in this driver.
>>>>
>>>> So 
>>>>
>>>> unsigned int decr;
>>>> unsigned int fladj;
>>>> unsigned int rate;
>>>> unsigned int period;
>>>>
>>>> ?
>>>>
>>>> Frankly that seems rather verbose.
>>>
>>> A couple of the benefits of having it like this is to help with viewing
>>> git-blame if we introduce new variables and help with backporting fix
>>> patch a bit simpler. Mainly I'm just following Felipe's style and keep
>>> it consistent in this driver, but I don't think it's a big deal.
>> 
>> *shrug*
>> 
>> If it's the subsystem style I will rewrite it.
>> 
>
> Felipe also prefers Reverse Christmas Tree style.

that's also part of the coding style and probably documented somewhere

-- 
balbi
