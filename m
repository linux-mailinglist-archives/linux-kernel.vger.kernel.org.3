Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A7F48D351
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiAMICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:02:35 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:43724 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231391AbiAMICe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:02:34 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACXn1d_3N9h7bRFBg--.37830S2;
        Thu, 13 Jan 2022 16:02:08 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     jirislaby@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] tty/serial: Check for null pointer after calling devm_ioremap
Date:   Thu, 13 Jan 2022 16:02:06 +0800
Message-Id: <20220113080206.1198250-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXn1d_3N9h7bRFBg--.37830S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr43KryUGw47tr15Xw43Wrg_yoWDGwb_WF
        s8Can3Z34rAr1rta1qkry3Zw4aqrsI9ayxWr1xZF9Fy3s8ZFs7WFZrurn7Zw4UXws2qF1D
        Gr47Zw4UZF4jvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIzuXUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 03:35:14PM +0800, Jiri Slaby wrote:
>> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
>> index 8f2cab7f66ad..1ecbf6d0dc79 100644
>> --- a/drivers/tty/serial/milbeaut_usio.c
>> +++ b/drivers/tty/serial/milbeaut_usio.c
>> @@ -523,6 +523,10 @@ static int mlb_usio_probe(struct platform_device *pdev)
>>   	}
>>   	port->membase = devm_ioremap(&pdev->dev, res->start,
>>   				resource_size(res));
>> +	if (!port->membase) {
>> +		ret = -ENOMEM;
>> +		goto failed;
>> +	}
>
> what about using devm_ioremap_resource() and have only one if there?

Well, I check the comment of the devm_ioremap_resource() and notice that
it checks and requests region before ioremap.
And the usage example is fit for the situation.
But I have still have no idea what the concrete advantages of the
devm_ioremap_resource(), like fixing something or improve the efficiency.
Please give me more detail.

Sincerely thanks,
Jiang

