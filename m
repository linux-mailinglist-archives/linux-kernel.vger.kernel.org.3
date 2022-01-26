Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDFA49C81C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbiAZKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiAZKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:54:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DEC06161C;
        Wed, 26 Jan 2022 02:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3F00B81C10;
        Wed, 26 Jan 2022 10:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEC5C340E3;
        Wed, 26 Jan 2022 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643194470;
        bh=zXGVW3VwZfxtH955/nyzBSwsLMj5oubdhnKlttWifU8=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Aou75n6LThZjv5SpeuOZm+fom5lhyY0whllTbNWWkuCROQRtBsExup8mRo9mxJZCu
         yztplbbP7sNPHH8U5b/ddwSRK4Bk6YZFZOTyMToMDzyg7Hjp2DoyDdvBWorJ+WMNqS
         wgeApisoYAs+03masRLgBQn4yHETuTRyoDQWxKzXf0KIH1/1lcOH656BCQnm04TG/j
         W7aHjHvkweRaQ/shjLYrISkP/zjd4lrLw4UeS34JTzqW3W+X/zTtFbrezXZm+gnSTV
         eApeWmxe5ZVq9ux7pPUfJlmMEPoKLmevth/YbRS+GhGWbDAXls98p6xXfSQ1jX+7ko
         5FRk7y6qN0R3A==
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
 <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2 4/7] usb: dwc3: Program GFLADJ
Date:   Wed, 26 Jan 2022 12:53:28 +0200
In-reply-to: <2831e216-737f-41b2-1aa0-4af56615e3b7@seco.com>
Message-ID: <87mtji7onx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sean Anderson <sean.anderson@seco.com> writes:

> On 1/24/22 9:11 PM, Thinh Nguyen wrote:
>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>> index 5214daceda86..883e119377f0 100644
>>>>> --- a/drivers/usb/dwc3/core.c
>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>>>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>>  {
>>>>>  	u32 reg;
>>>>> -	unsigned long rate, period;
>>>>> +	unsigned long decr, fladj, rate, period;
>>>>
>>>> Minor style nit: Felipe prefers to keep the declaration on separate
>>>> lines, let's keep it consistent with the rest in this driver.
>>> 
>>> So 
>>> 
>>> unsigned int decr;
>>> unsigned int fladj;
>>> unsigned int rate;
>>> unsigned int period;
>>> 
>>> ?
>>> 
>>> Frankly that seems rather verbose.
>> 
>> A couple of the benefits of having it like this is to help with viewing
>> git-blame if we introduce new variables and help with backporting fix
>> patch a bit simpler. Mainly I'm just following Felipe's style and keep
>> it consistent in this driver, but I don't think it's a big deal.
>
> *shrug*
>
> If it's the subsystem style I will rewrite it.
>
> (btw is this documented anywhere for future contributors?)

https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

"To this end, use just one data declaration per line (no commas for
multiple data declarations)"

-- 
balbi
