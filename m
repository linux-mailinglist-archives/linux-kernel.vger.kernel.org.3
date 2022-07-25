Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3757FBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiGYIxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGYIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:53:49 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883B14D07;
        Mon, 25 Jul 2022 01:53:47 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 16:52:20 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 25 Jul
 2022 16:52:18 +0800
Message-ID: <0db4dc76-68cf-dc84-1a1b-ebe5abbbff8e@zhaoxin.com>
Date:   Mon, 25 Jul 2022 16:52:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] USB: HCD: Fix URB giveback issue in tasklet function
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <kishon@ti.com>, <dianders@chromium.org>, <s.shtylyov@omp.ru>,
        <mka@chromium.org>, <ming.lei@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
References: <20220725065251.832087-1-WeitaoWang-oc@zhaoxin.com>
 <3b9a3fec-7716-3e9d-1e91-cfdac46845f7@gmail.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <3b9a3fec-7716-3e9d-1e91-cfdac46845f7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/25 16:29, Sergei Shtylyov wrote:
> Hello!
> 
> On 7/25/22 9:52 AM, Weitao Wang wrote:
> 
>> Usb core introduce the mechanism of giveback of URB in tasklet context to
>> reduce hardware interrupt handling time. On some test situation(such as
>> FIO with 4KB block size), when tasklet callback function called to
>> giveback URB, interrupt handler add URB node to the bh->head list also.
>> If check bh->head list again after finish all URB giveback of local_list,
>> then it may introduce a "dynamic balance" between giveback URB and add URB
>> to bh->head list. This tasklet callback function may not exit for a long
>> time, which will cause other tasklet function calls to be delayed. Some
>> real-time applications(such as KB and Mouse) will see noticeable lag.
>>
>> Fix this issue by taking new URBs giveback in next tasklet function call.
>> Add a member high_prio for structure giveback_urb_bh and replace the local
>> high_prio_bh variable with this structure member in usb_hcd_giveback_urb.
>>
>> Fixes: 94dfd7edfd5c ("USB: HCD: support giveback of URB in tasklet context")
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>> ---
>> v1->v2:
>>   - Fix compile warning by remove label "restart".
>>   - Modify the patch description info.
>>   - Change structure member from hi_priority to high_prio.
>>
>>   drivers/usb/core/hcd.c  | 25 ++++++++++++++-----------
>>   include/linux/usb/hcd.h |  1 +
>>   2 files changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 06eea8848ccc..1feb9a604380 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
> [...]
>> @@ -2959,6 +2961,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>   
>>   	/* initialize tasklets */
>>   	init_giveback_urb_bh(&hcd->high_prio_bh);
>> +	hcd->high_prio_bh.high_prio = 1;
> 
>     s/1/true/?
Okay,this Boolean variable should be initialized to ture.
Thanks for your suggestion.

weitao
>>   	init_giveback_urb_bh(&k->low_prio_bh);
>>   
>>   	/* enable irqs just before we start the controller,
>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>> index 2c1fc9212cf2..98d1921f02b1 100644
>> --- a/include/linux/usb/hcd.h
>> +++ b/include/linux/usb/hcd.h
>> @@ -66,6 +66,7 @@
>>   
>>   struct giveback_urb_bh {
>>   	bool running;
>> +	bool high_prio;
>>   	spinlock_t lock;
>>   	struct list_head  head;
>>   	struct tasklet_struct bh;
> 
> MBR, Sergey
> .
