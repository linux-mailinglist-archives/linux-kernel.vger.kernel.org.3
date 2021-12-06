Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C434690D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhLFHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:32:39 -0500
Received: from cpanel.siel.si ([46.19.9.99]:50230 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhLFHcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=59FNbHp+qi8agiRS24YJVOOwbs8fZUEtObV+5fUGmVQ=; b=FnaqUDVVC8/iZdpJmD9CBwuJ5D
        QNO4wmlMVa1eCYqsu0YOXaY3OUfbRlr1ttqr8IVFx62GNkORcIGe260M0ex10xJCoBQewyyD6mlZI
        1WtF5fz9Sewwr/whII0hD9PdB4mHjQrbB+bauoDnfIsDZfdvQpHntQSjXpOKUrQMkVO/9u+AvYdtp
        1KvR0pPgpOS/CHzxltQt2BwutSS46BDUh+DEmi1P7I6M3OakUKCtJYiIyVRFnnm1HxJkvudsIYW+P
        +lBRBcifE5C2D4R+CSzN3j73sv3kumwrdZtgYHa4/Zya79lXFAV0dg1725UUqhxiL7CN+fODwEfI9
        /8s4RQKw==;
Received: from [89.212.21.243] (port=40752 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mu8Qg-00GP1F-Uk; Mon, 06 Dec 2021 08:29:02 +0100
Subject: Re: [RFC PATCH] watchdog: da9062: Correct the timeout values
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
 <dc6a432c-79a3-881c-eac4-32620040d11b@roeck-us.net>
 <4bfb6ab512cd45ee81c55361525987b7@dh-electronics.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <a0b6a801-f911-3371-1067-479b66240bdc@norik.com>
Date:   Mon, 6 Dec 2021 08:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4bfb6ab512cd45ee81c55361525987b7@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3. 12. 21 18:31, Christoph Niedermaier wrote:
> From: Guenter Roeck
> Sent: Friday, December 3, 2021 5:52 PM
>> On 12/3/21 8:35 AM, Christoph Niedermaier wrote:
>>> I measured the timeout values of my DA9061 chip. According to the
>>> information in the data sheet the formula should be:
>>>
>>> timeout = 2.048 * 2^(regval - 1)
>>>
>>> But my measured values differ from that.
>>> Accoring to my measured values the formula must be:
>>>
>>> timeout = 3.2 * 2^(regval - 1)
>>>
>>> Is there something wrong with my chip, or has anyone else noticed this as well?
>>
>> The driver assumes a static and well defined clock rate. Maybe that rate
>> is different in your system (if that is possible) ?
>>
>> Guenter
> 
> @Andrej
> Do the values in the driver match what your chip does?
> 

Just did a quick test. The values in the driver match what the chip 
does. I checked multiple timeouts 16, 32, 65 and 131 seconds. The 
timeout triggers quite accurately.

> I have not changed anything. After power on, the chip behaves like this.
> So I guess it either come from an OTP value or the wiring outside the chip.
> Does anyone know what needs to be checked?

Can't help you here, sorry.

Best regards,
Andrej
