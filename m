Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D947FAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhL0Hsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:48:45 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53405 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhL0Hsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:48:45 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1kkIn3FR8onYg1kkInbzlb; Mon, 27 Dec 2021 08:48:43 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 27 Dec 2021 08:48:43 +0100
X-ME-IP: 86.243.171.122
Message-ID: <64cfa75c-61e3-a834-db20-67cee3611d04@wanadoo.fr>
Date:   Mon, 27 Dec 2021 08:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YcldM9sgYdjMYMtH@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/12/2021 à 07:29, Greg KH a écrit :
> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
>> 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
>> there will be a double free().
> 
> A struct device can never be devm_alloced for obvious reasons.  Perhaps
> that is the real problem here?

Thanks for the feed-back.

This goes beyond my knowledge of how this should work.
As I can not test myself, I won't be of any help.
I'll let you or anyone else check if something needs to be fixed, and 
how to fix it properly.

Just take my patch as a "Hey! Looks strange to have a kfree() in a 
driver that only call devm_kzalloc() to allocate memory. S.o. should 
give a deeper look at it". :)

CJ

> 
>> Remove the 'release' function that is wrong and unneeded.
>>
>> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This patch is completely theoretical. It looks good to me, but there is a
>> little too much indirections for me. I'm also not that familiar with
>> fixing issue related to 'release' function...
>>
>> ... So review with care :)
>> ---
>>   drivers/fsi/fsi-master-aspeed.c | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
>> index 8606e55c1721..4a745ccb60cf 100644
>> --- a/drivers/fsi/fsi-master-aspeed.c
>> +++ b/drivers/fsi/fsi-master-aspeed.c
>> @@ -373,14 +373,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
>>   	return aspeed_master_write(master, link, 0, addr, &cmd, 4);
>>   }
>>   
>> -static void aspeed_master_release(struct device *dev)
>> -{
>> -	struct fsi_master_aspeed *aspeed =
>> -		to_fsi_master_aspeed(dev_to_fsi_master(dev));
>> -
>> -	kfree(aspeed);
>> -}
>> -
>>   /* mmode encoders */
>>   static inline u32 fsi_mmode_crs0(u32 x)
>>   {
>> @@ -603,7 +595,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>>   	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
>>   
>>   	aspeed->master.dev.parent = &pdev->dev;
>> -	aspeed->master.dev.release = aspeed_master_release;
> 
> Odd, then what deletes this device structure when the release function
> wants to be called?  You should have gotten a big warning from the
> kernel when removing the device from the system at runtime, did you test
> this somehow?
> 
> This does not look correct at all.
> 
> greg k-h
> 

