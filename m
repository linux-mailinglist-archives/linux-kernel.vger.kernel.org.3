Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359F84713DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLKMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLKMwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:52:14 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B2C061714;
        Sat, 11 Dec 2021 04:52:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5F12B42499;
        Sat, 11 Dec 2021 12:52:07 +0000 (UTC)
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: apple,aic: Add
 apple,aic2 support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-2-marcan@marcan.st>
 <YbI8wBS2mrETiTfw@robh.at.kernel.org>
 <8c099fc2-a319-7c80-3053-ed2b39b86835@marcan.st>
 <87tuff9upz.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <fbb54509-c32c-ecc9-53d3-664168699e17@marcan.st>
Date:   Sat, 11 Dec 2021 21:52:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87tuff9upz.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2021 21.44, Marc Zyngier wrote:
> On Sat, 11 Dec 2021 12:28:10 +0000,
> Hector Martin <marcan@marcan.st> wrote:
>>
>> On 10/12/2021 02.28, Rob Herring wrote:
>>> On Thu, Dec 09, 2021 at 01:32:44PM +0900, Hector Martin wrote:
>> <snip>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - apple,aic2
>>>> +    then:
>>>> +      required:
>>>> +        - apple,event-reg
>>>
>>> Is this property valid for aic1? If not, you need:
>>>
>>> else:
>>>     not:
>>>       required:
>>>         - apple,event-reg
>>>
>>
>> Thanks, I wasn't sure how to do this. Took me a second to realize how
>> the logic works here, heh.
>>
>>>
>>> I tend to think you should just make this a separate document. There's
>>> not a whole lot of sharing (compared to any other interrupt controller).
>>
>> Good point. I just kind of defaulted to this way because the driver is
>> the same (and does share a bunch), but indeed the binding doesn't
>> really reflect any of that. I'll split it off into another document
>> for v2. Might as well make the 4-argument interrupt form mandatory
>> then (we use it for all DTs, even the current 1-die machines, on AICv2
>> SoCs; the driver can handle both but we might as well be stricter with
>> the binding).
> 
> Well, I'm about to add this 4th cell for FIQ signalled interrupts so
> that we can specify an affinity (similarly to what we do with GICv3, 0
> meaning no specific affinity and a non-zero phandle indicating a
> specific affinity).
> 
> Generalising the 4-cell even on AICv1 systems would be pretty nice,
> and we can always keep the backward compat as a fallback for old DTs
> (that'd pretty cheap).

The driver still takes both, so that's not an issue; we can certainly 
have the AICv1 binding allow both and the AICv2 one require the 4-cell 
form. That will also make copy/paste between t8103 and t6000 SoCs 
slightly less error-prone, since both will have the extra cell.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
