Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81767481108
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhL2Imr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:42:47 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:63413 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL2Imq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:42:46 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 2UXknTm1kMxZu2UXknMd7W; Wed, 29 Dec 2021 09:42:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 29 Dec 2021 09:42:45 +0100
X-ME-IP: 86.243.171.122
Message-ID: <26e05a4b-93b3-c38a-3a89-9c56816c63f7@wanadoo.fr>
Date:   Wed, 29 Dec 2021 09:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] HID: magicmouse: Fix an error handling path in
 magicmouse_probe()
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
 <20211229075025.GA11488@elementary>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20211229075025.GA11488@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/12/2021 à 08:50, José Expósito a écrit :
> On Tue, Dec 28, 2021 at 10:09:17PM +0100, Christophe JAILLET wrote:
>> If the timer introduced by the commit below is started, then it must be
>> deleted in the error handling of the probe. Otherwise it would trigger
>> once the driver is no more.
>>
>> Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/hid/hid-magicmouse.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
>> index eba1e8087bfd..b8b08f0a8c54 100644
>> --- a/drivers/hid/hid-magicmouse.c
>> +++ b/drivers/hid/hid-magicmouse.c
>> @@ -873,6 +873,7 @@ static int magicmouse_probe(struct hid_device *hdev,
>>   
>>   	return 0;
>>   err_stop_hw:
>> +	del_timer_sync(&msc->battery_timer);
>>   	hid_hw_stop(hdev);
>>   	return ret;
>>   }
>> -- 
>> 2.32.0
>>
> 
> My bad, thanks for catching it!
> 
> Tested-by: José Expósito <jose.exposito89@gmail.com>
> 

Hi, just in case, I got a reply from syzbot that this patch fixes:

https://syzkaller.appspot.com/bug?id=ae4e9aaf5651e1d6895071208c7844d4fdfbe30c

If it is the same issue, we can add:
Reported-by: syzbot+a437546ec71b04dfb5ac@syzkaller.appspotmail.com


I've not found it with syzbot, but with a coccinelle script which tries 
to spot things that are in the remove function and should also be in the 
error handling path of the probe.

However, if it help syzbot, I don't care mentioning it.

CJ
