Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779F479AA1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhLRL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:56:48 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:51630 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhLRL4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:56:47 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 669CD20F12C6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <e852a63f-cb84-2683-f102-2f8572b1799d@omp.ru>
Date:   Sat, 18 Dec 2021 14:56:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ata: pata_platform: Merge pata_of_platform into
 pata_platform
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211217141715.29747-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <b94e0a92-1995-926c-95df-17365f03eed0@omp.ru>
 <CA+V-a8tU6XCYw2B32obgOkezd_YMqBkpWA_EuJzK=nCmkuWtQw@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <CA+V-a8tU6XCYw2B32obgOkezd_YMqBkpWA_EuJzK=nCmkuWtQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.2021 13:51, Lad, Prabhakar wrote:

[...]
>>> Merge the OF pata_of_platform driver into pata_platform.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]
>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>>> index cb3134bf88eb..b8d8d51bc562 100644
>>> --- a/drivers/ata/pata_platform.c
>>> +++ b/drivers/ata/pata_platform.c
[...]
>>> @@ -168,23 +180,83 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>> [...]
>>>
>>> -static int pata_platform_probe(struct platform_device *pdev)
>>> +static int pata_of_platform_get_pdata(struct platform_device *ofdev,
>>> +                                   struct pata_platform_priv *priv)
>>>   {
>>> -     struct resource *io_res;
>>> +     struct device_node *dn = ofdev->dev.of_node;
>>>        struct resource *ctl_res;
>>>        struct resource *irq_res;
>>> +     struct resource *io_res;
>>
>>     Should be declared before ctl_res...
>>
> Any reason why?

    Well, it's a natural order, following from the driver logic, no?

>>> +     int pio_mode = 0;
>>> +     int irq;
>>> +     int ret;
>>> +
>>> +     ctl_res = devm_kzalloc(&ofdev->dev, sizeof(*ctl_res), GFP_KERNEL);
>>> +     io_res = devm_kzalloc(&ofdev->dev, sizeof(*io_res), GFP_KERNEL);
>>> +     irq_res = devm_kzalloc(&ofdev->dev, sizeof(*irq_res), GFP_KERNEL);
>>> +     if (!ctl_res || !io_res || !irq_res)
>>> +             return -ENOMEM;
>>
>>     Can't we get away from these allocated resources? Or at least irq_res?
>>
> Do you have any suggestions?

    Let me look deeper...

[...]
>>> @@ -198,32 +270,63 @@ static int pata_platform_probe(struct platform_device *pdev)
[...]
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     priv->sht = &pata_platform_sht;
>>
>>     Aren't those structures identical between the formerly separate drivers?
>>
> Yes so are you suggesting to drop sht from priv and use it directly?

    Yep.

> Cheers,
> Prabhakar

MBR, Sergey
