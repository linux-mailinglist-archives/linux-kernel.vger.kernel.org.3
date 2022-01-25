Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1ED49AC59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbiAYGZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:25:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33226 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245084AbiAYGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:21:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F61A60C93;
        Tue, 25 Jan 2022 06:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DE2C340E0;
        Tue, 25 Jan 2022 06:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643091658;
        bh=BcObeviqTy0B6wg1HUmcu48JYW3Eu5vvKYtvo99BDqE=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=VezWADmaDVDLLtoJUyT0723WAMg6y6/C4ZGN5+Pjuk5ZOxbZwOtmjJE2Lexlc7IHo
         eDfhe31XBOMvaGOO1InP6qJRT+H7IdEvDmFSYcTjFoCiIyU9fxMf8wkTf55lVTJgfC
         9vMNzKxaNqJg1swtaPpttFM7mpG1nwrK20mBkitp8HyiKau1LbrdtDwByh7WgxJHfF
         y1c6mrzPTcyrXCwGRpXcETqxWzkeQ7xZy7zSs7tb+0qsiNO3r/u083Ter3e5WW5rA4
         S0mXZCS98ka5spZ37pNNwoeCHEuu7hu8TF1VOBkZdvcCONSbBbE7P8Ece3c7mrWTig
         hqxjY62S0+Elg==
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <20220119002438.106079-5-sean.anderson@seco.com>
 <4696c5a4-5921-f7cb-196c-5ad956e696f9@synopsys.com>
 <f528aeb5-6155-a75e-9d35-9bf473e0bbc7@seco.com>
 <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
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
Date:   Tue, 25 Jan 2022 08:17:37 +0200
In-reply-to: <3ca6fb9e-94cf-6483-26a6-ae2682d1f55e@synopsys.com>
Message-ID: <87r18w72uy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:
>> On 1/24/22 5:46 PM, Thinh Nguyen wrote:
>>> Sean Anderson wrote:
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 5214daceda86..883e119377f0 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -348,7 +348,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
>>>>  static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>>>  {
>>>>  	u32 reg;
>>>> -	unsigned long rate, period;
>>>> +	unsigned long decr, fladj, rate, period;
>>>
>>> Minor style nit: Felipe prefers to keep the declaration on separate
>>> lines, let's keep it consistent with the rest in this driver.
>> 
>> So 
>> 
>> unsigned int decr;
>> unsigned int fladj;
>> unsigned int rate;
>> unsigned int period;
>> 
>> ?
>> 
>> Frankly that seems rather verbose.
>
> A couple of the benefits of having it like this is to help with viewing
> git-blame if we introduce new variables and help with backporting fix

it also prevents single lines from being constantly modified just
because we're adding a new variable. In the diff, adding a new variable
should look like a new line being added, rather than modified.

> patch a bit simpler. Mainly I'm just following Felipe's style and keep

it's part of the kernel coding style, actually :-)

-- 
balbi
