Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03546E024
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhLIBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:21:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32889 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbhLIBU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:20:59 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J8bjh6xS3zcbld;
        Thu,  9 Dec 2021 09:17:12 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 09:17:25 +0800
Subject: Re: [PATCH] irqchip/irq-gic-v3-its.c: Return its_invall_cmd.col when
 building INVALL
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Wudi Wang <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211208015429.5007-1-zhangshaokun@hisilicon.com>
 <522e91148810ca7c77ad492d3a92c7a9@kernel.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <3cc66fc7-7091-37e6-350b-f9a223392804@hisilicon.com>
Date:   Thu, 9 Dec 2021 09:17:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <522e91148810ca7c77ad492d3a92c7a9@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2021/12/8 16:25, Marc Zyngier wrote:
> On 2021-12-08 01:54, Shaokun Zhang wrote:
>> From: Wudi Wang <wangwudi@hisilicon.com>
>>
>> INVALL CMD specifies that the ITS must ensure any caching associated with
>> the interrupt collection defined by ICID is consistent with the LPI
>> configuration tables held in memory for all Redistributors. SYNC is
>> required to ensure that INVALL is executed.
> 
> The patch title doesn't quite spell out the issue. It should say something
> like:
> 
> "Force synchronisation when issuing INVALL">

Make sense.

>>
>> Currently, LPI configuration data may be inconsistent with that in the
>> memory within a short period of time after the INVALL command is executed.
> 
> I'm curious: have you seen any issue with this on actual HW? In my
> experience, all implementations treat INVALL as a synchronous command,
> 
> Or was this solely done via inspection?
> 

It is noticed by checking the implementation of INVALL API function, not
by on actual HW.

>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> This needs:
> 
> Fixes: cc2d3216f53 ("irqchip: GICv3: ITS command queue")
> 

Oops, indeed, apologies that forget to add this tag.

>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index eb0882d15366..0cb584d9815b 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -742,7 +742,7 @@ static struct its_collection
>> *its_build_invall_cmd(struct its_node *its,
>>
>>      its_fixup_cmd(cmd);
>>
>> -    return NULL;
>> +    return desc->its_invall_cmd.col;
>>  }
>>
>>  static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
> 
> I'll fix the above locally, no need to resend.
> 

Thanks Marc's help.

> Thanks,
> 
>         M.
