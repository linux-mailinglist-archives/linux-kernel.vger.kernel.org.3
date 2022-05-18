Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3425F52AFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiERBMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiERBK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:10:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524FC10F7;
        Tue, 17 May 2022 18:10:43 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2vtf5pMczCsYC;
        Wed, 18 May 2022 09:05:46 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 09:10:40 +0800
Subject: Re: [PATCH -next] serial: cpm_uart: Fix build error without
 CONFIG_SERIAL_CPM_CONSOLE
To:     Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>,
        <geert@linux-m68k.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220517081355.35456-1-yuehaibing@huawei.com>
 <2612fae5-e972-5c82-c44e-af1fb1d839fd@kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6fd7c506-3ab1-7f58-62fc-d02d41b81034@huawei.com>
Date:   Wed, 18 May 2022 09:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <2612fae5-e972-5c82-c44e-af1fb1d839fd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/17 17:12, Jiri Slaby wrote:
> On 17. 05. 22, 10:13, YueHaibing wrote:
>> drivers/tty/serial/cpm_uart/cpm_uart_core.c: In function ‘cpm_uart_init_port’:
>> drivers/tty/serial/cpm_uart/cpm_uart_core.c:1251:7: error: ‘udbg_port’ undeclared (first use in this function); did you mean ‘uart_port’?
>>    if (!udbg_port)
>>         ^~~~~~~~~
>>         uart_port
>>
>> commit d142585bceb3 leave this corner, wrap it with #ifdef block
>>
>> Fixes: d142585bceb3 ("serial: cpm_uart: Protect udbg definitions by CONFIG_SERIAL_CPM_CONSOLE")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> index d6d3db9c3b1f..ec3a8f768555 100644
>> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
>> @@ -1248,7 +1248,9 @@ static int cpm_uart_init_port(struct device_node *np,
>>     #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>>   #ifdef CONFIG_CONSOLE_POLL
>> +#ifdef CONFIG_SERIAL_CPM_CONSOLE
>>       if (!udbg_port)
>> +#endif
>>   #endif
> 
> That's ugly, could you merge the two to
>   #if defined(ONE) && defined(TWO)

Ok, will do this in v2.
> instead
> ?
> 
>>           udbg_putc = NULL;
>>   #endif
> 
> 
