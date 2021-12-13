Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6810472F58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhLMOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:31:27 -0500
Received: from cpanel.siel.si ([46.19.9.99]:39010 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhLMOb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=w4hFH0cahRZMB5bqvXmzS66FpjQlX8PX0GYV9MFWdzc=; b=LmGJgCAW8sFNTmZveTBSaAKsWB
        FSq2685CkmaJIKdSmLediofEnSB7tzGboegWqrssIUHFBGccJyNfFTtwgodmzRZTfimfHGI2w5Fue
        5QTGbl3h+tYGgHnCcnzpmZcFsYqZnD2vox6IiBK+9/GoYBUAhHuqaL4NK16NtgCBVMFy0QAw/RUJh
        bgNR2HYydbvveQftSd0xojW++gBWdAH7o5CE5qSoXFefMdLrQrpFq1nYSMtnBda6JSCNQ0nsJauAQ
        +e4JATJUGhkaLuffZ2v64aZNnORag4CotTZhoMTHUraUbTZ6J4mwl3kUFvhjrUfo0OxIBj4rZQbA3
        MLTZap0Q==;
Received: from [89.212.21.243] (port=60312 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mwmMJ-001SUO-IC; Mon, 13 Dec 2021 15:31:19 +0100
Subject: Re: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <1450af96-f279-c545-20a0-9361a070ca13@norik.com>
Date:   Mon, 13 Dec 2021 15:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
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



On 13. 12. 21 10:11, Christoph Niedermaier wrote:
> Resend with [Klartext] to turn off TLS encryption.
> 
> From: Adam Thomson
> Sent: Monday, December 6, 2021 5:38 PM
>>> Thanks anyway, so now I know it must be
>>> problem with my DA9061 chip.
>>>
>>> @Adam
>>> Where can it come from?
>>> Can you give we a hint what to check?
>>
>> I've spoken internally and have been informed that this is down to the fact that
>> DA9061 runs only from an internal oscillator which may be slower. The indication
>> is that the values for TWDSCALE describe the window where if a kick/ping occurs
>> within that period then the watchdog is guaranteed *not* to timeout. The actual
>> timeout would be at some point after the selected timeout period, assuming no
>> ping/kick occurred.
>>
>> Table 8 in the datasheet specifies a minimum watchdog timeout of 2.5s (tWDMAX)
>> under specific operating conditions, so if the minimum 2s window was chosen
>> (TWDSCALE = 1) then earliest the watchdog would actually timeout, following a
>> ping, is 2.5s, assuming the conditions matched those described.
>>
>> If you have further questions it probably makes sense to contact Dialog/Renesas
>> support as they will be able to provide more detailed info on this.
> 
> So a DA9061 runs only from an internal oscillator, whereas a DA9062
> can run on either an internal or an external oscillator. So this
> means that the DA9061 timeout values are differ from the DA9062
> with an external oscillator not only on my device but on all DA9061
> devices.
> 
> This are the values (in seconds) in comparison:
> DA9062 (from driver): 0  2  4   8  16  32  65 131
> DA9061 (measured):    0  3  6  12  25  51 102 204
> =================================================
> Difference:           0 +1 +2  +4  +9 +19 +37 +73
> 
> In my opinion, the differences in the higher values are very huge.
> If I expect that the watchdog triggers and I have to wait more than
> a minute for that to happen I ask myself is there something wrong.
> 
> @Andrej
> I guess, you are using an external oscillator, aren't you?

You are correct, we are using external oscillator (32,768KHz).

> 
> @Adam
> Is there a way to check in the driver which oscillator is in use?
> 
> @Maintainers
> Is in the driver a need to distinguish between an external and an
> internal oscillator to get the timeout values more accurate?
> 
> 
> Best regards
> Christoph
> 
