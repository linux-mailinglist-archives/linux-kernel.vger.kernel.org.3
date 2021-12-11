Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4534713C4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhLKM2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:28:18 -0500
Received: from marcansoft.com ([212.63.210.85]:35036 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhLKM2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:28:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5FAAB42499;
        Sat, 11 Dec 2021 12:28:13 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-2-marcan@marcan.st>
 <YbI8wBS2mrETiTfw@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: apple,aic: Add
 apple,aic2 support
Message-ID: <8c099fc2-a319-7c80-3053-ed2b39b86835@marcan.st>
Date:   Sat, 11 Dec 2021 21:28:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YbI8wBS2mrETiTfw@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 02.28, Rob Herring wrote:
> On Thu, Dec 09, 2021 at 01:32:44PM +0900, Hector Martin wrote:
<snip>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - apple,aic2
>> +    then:
>> +      required:
>> +        - apple,event-reg
> 
> Is this property valid for aic1? If not, you need:
> 
> else:
>    not:
>      required:
>        - apple,event-reg
> 

Thanks, I wasn't sure how to do this. Took me a second to realize how 
the logic works here, heh.

> 
> I tend to think you should just make this a separate document. There's
> not a whole lot of sharing (compared to any other interrupt controller).

Good point. I just kind of defaulted to this way because the driver is 
the same (and does share a bunch), but indeed the binding doesn't really 
reflect any of that. I'll split it off into another document for v2. 
Might as well make the 4-argument interrupt form mandatory then (we use 
it for all DTs, even the current 1-die machines, on AICv2 SoCs; the 
driver can handle both but we might as well be stricter with the binding).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
