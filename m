Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6549B46FD26
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhLJJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:02:40 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:38532 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhLJJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:02:39 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 3A37D20E4351
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
Date:   Fri, 10 Dec 2021 11:59:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 1:49 AM, Damien Le Moal wrote:

>> platform_get_irq() will print a message when it fails.
>> No need to repeat this.
>>
>> While at it, drop redundant check for 0 as platform_get_irq() spills
>> out a big WARN() in such case.
> 
> The reason you should be able to remove the "if (!irq)" test is that
> platform_get_irq() never returns 0. At least, that is what the function kdoc
> says. But looking at platform_get_irq_optional(), which is called by
> platform_get_irq(), the out label is:
> 
> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> 	return ret;
> 
> So 0 will be returned as-is. That is rather weird. That should be fixed to
> return -ENXIO:
> 
> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> 		return -ENXIO;
> 	return ret;

   My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
but returns -EINVAL instead.

> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

   Of course it isn't...

>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[...]

MBR, Sergey
