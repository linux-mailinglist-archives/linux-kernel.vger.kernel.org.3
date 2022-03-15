Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CFC4D9B74
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348413AbiCOMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiCOMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:45:36 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEC37BC2;
        Tue, 15 Mar 2022 05:44:21 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Mar
 2022 20:44:16 +0800
Received: from [10.29.8.53] (10.29.8.53) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 15 Mar
 2022 20:44:15 +0800
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
 <261420fb-28b4-0def-a9e1-9c011bab7912@linux.intel.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Message-ID: <1882dfc1-0f46-a594-d75b-b73d30f6d6db@zhaoxin.com>
Date:   Tue, 15 Mar 2022 20:44:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <261420fb-28b4-0def-a9e1-9c011bab7912@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.53]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/15 下午4:08, Mathias Nyman wrote:
> On 14.3.2022 9.25, WeitaoWang-oc@zhaoxin.com wrote:
>> On some situations, software handles TRB events slower than adding TRBs,
>> xhci_irq will not exit until all events are handled. If xhci_irq just
>> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records in xhci irq is equal to driver current dequeue pointer. It will cause driver not update ERDP and software dequeue pointer lost sync with ERDP. On the next xhci_irq, the event ring is full but driver will not update ERDP as software dequeue pointer is equal to ERDP.
>>
>> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
>> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7 inflight: CMD OUT
>> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00 00 08 00
>> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not responding to stop endpoint command.
>> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
>> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding, assume dead
>> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6 inflight: CMD
>> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00 00 08 00
>> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD
>>
>> Fixed this issue by update software record temp variable when handles 128 TRB events.>
>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> 
> Thanks
> 
> Solution itself looks good but patch has some minor format issue:
> 
> 
> It would also be interesting to know if the full event ring was triggered in a real
> life usecase?
> If that is the case I might need to look more into it.
> 
> Bigger event ring, more rings, faster handler, avoid irqoff time...
> 
> Thanks
> Mathias
> .
Some performance test tools such as fio or iometer can be used to reproduce
  this case, If tested with 4KB read or write. xHCI will generate a lost TRB
  events fast than software consume on a certain period of time. Once 
the interrupt is entered, software may handle more than 128 TRBs at a time.
While the software is processing, xHCI is still generating events. This may
has problems caused by the ERDP update mechanism. If update software
  record temp variable when handles 128 TRB events, event ring full will not
  happen any more even though fio test with 4KB read or write.

Thanks
Weitao Wang
> 
