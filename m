Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA37847D013
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbhLVKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:35:52 -0500
Received: from 7.mo550.mail-out.ovh.net ([87.98.158.110]:40931 "EHLO
        7.mo550.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLVKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:35:51 -0500
Received: from player776.ha.ovh.net (unknown [10.110.171.173])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 5F93021AC2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:16:29 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player776.ha.ovh.net (Postfix) with ESMTPSA id 596812593BD8A;
        Wed, 22 Dec 2021 09:16:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002d31a7a78-1ef3-4dfe-b0c7-e7c63879d648,
                    6227138D1A59C2D5CB218EB48BA84448E8ED8D0D) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <c5b76d10-c270-21e5-e528-9aa20b1384ef@milecki.pl>
Date:   Wed, 22 Dec 2021 10:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register() error
 path
To:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com> <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com> <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
 <YcLrHEoOy3iRSkFp@hovoldconsulting.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <YcLrHEoOy3iRSkFp@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17072301766595554267
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddthedgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejteeludegjedtveehteeiudehgfetvdegffdtvdefvdeiveejgeelffelgedtueenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.2021 10:08, Johan Hovold wrote:
> On Wed, Dec 22, 2021 at 10:00:03AM +0100, Rafał Miłecki wrote:
>> On 22.12.2021 09:38, Johan Hovold wrote:
> 
>>> It seems Rafał is mistaken here too; you certainly need to call
>>> platform_device_put() if platform_device_register() fail, even if many
>>> current users do appear to get this wrong.
>>
>> Yes I was! Gosh I made up that "platform_device_put()" name and only
>> now I realized it actually exists!
>>
>> I stand by saying this design is really misleading. Even though
>> platform_device_put() was obviously a bad example.
>>
>> Please remember I'm just a minor kernel developer however in my humble
>> opinion behaviour of device_register() and platform_device_register()
>> should be changed.
>>
>> If any function fails I expect:
>> 1. That function to clean up its mess if any
>> 2. Me to be responsible to clean up my mess if any
>>
>> This is how "most" code (whatever it means) works.
>> 1. If POSIX snprintf() fails I'm not expected to call *printf_put() sth
>> 2. If POSIX bind() fails I'm not expected to call bind_put() sth
>> 3. (...)
>>
>> I'm not sure if those are the best examples but you should get my point.
> 
> Yes, and we all agree that it's not the best interface. But it exists,
> and changing it now risks introducing worse problem than a minor, mostly
> theoretical, memleak.

Thanks for confirming that, I was wondering if it's just my mind that
doesn't find this design clear enough.

Now, assuming this design isn't perfect and some purists would like it
cleaned up:

Would that make sense to introduce something like
1. device_register2() / device_add2()
and
2. platform_device_register2() / platform_device_add2()

that would *not* require calling *_put() on failure? Then start
converting existing drivers to those new (clearner?) helpers?
