Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC04DB138
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356381AbiCPNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356332AbiCPNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:21:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7855692B8;
        Wed, 16 Mar 2022 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647436747; x=1678972747;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3gydTSfJJ0kj7X+pEx3OA6sK9bKnh0Gb6dYO4OHWtjw=;
  b=NPYLy9lK9jY8hOqyrqfYiffIpKlW9C57obYh/zuTqUXUJwiPllHUDbXQ
   TOKzIDMdqNlag2JaN6SBEdUxBtke4iLeJ1mBhte4PrW+BwaVvatiMekzb
   v0WTBum0j4QvDdjio25oiizpbmxk1BJIhQB2eut5h2m2Ff2uFKrtXy5DL
   FBjqPxZvmps3cPmF3nB9HzHT0ssU4hQGvyOVBwGtWRmdZei5p8gM2GsfV
   WXfMcn5n5orKEKAYWrzxg6ofSATCoyKBoDuDk1bQbKPSjCILAPjjk1LRT
   pJ2z0j9g3YBs/avUaiw5jBq+JMqIMq3zgSo1AvowAkky5GfHkbf3K7S/c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="343013016"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="343013016"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646642824"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 06:18:58 -0700
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com
References: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
 <261420fb-28b4-0def-a9e1-9c011bab7912@linux.intel.com>
 <1882dfc1-0f46-a594-d75b-b73d30f6d6db@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <6c11dc4f-4984-e7aa-9fc5-7026100b38e1@linux.intel.com>
Date:   Wed, 16 Mar 2022 15:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1882dfc1-0f46-a594-d75b-b73d30f6d6db@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.3.2022 14.44, WeitaoWang-oc@zhaoxin.com wrote:
> On 2022/3/15 下午4:08, Mathias Nyman wrote:
>> On 14.3.2022 9.25, WeitaoWang-oc@zhaoxin.com wrote:
>>> On some situations, software handles TRB events slower than adding TRBs,
>>> xhci_irq will not exit until all events are handled. If xhci_irq just
>>> handles 256 TRBs and exit, the temp variable(event_ring_deq) driver records in xhci irq is equal to driver current dequeue pointer. It will cause driver not update ERDP and software dequeue pointer lost sync with ERDP. On the next xhci_irq, the event ring is full but driver will not update ERDP as software dequeue pointer is equal to ERDP.
>>>
>>> [  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
>>> [  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7 inflight: CMD OUT
>>> [  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 00 00 08 00
>>> [  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host not responding to stop endpoint command.
>>> [  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
>>> [  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not responding, assume dead
>>> [  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6 inflight: CMD
>>> [  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 00 00 08 00
>>> [  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD
>>>
>>> Fixed this issue by update software record temp variable when handles 128 TRB events.>
>>> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
>>
>> Thanks
>>
>> Solution itself looks good but patch has some minor format issue:
>>
>>
>> It would also be interesting to know if the full event ring was triggered in a real
>> life usecase?
>> If that is the case I might need to look more into it.
>>
>> Bigger event ring, more rings, faster handler, avoid irqoff time...
>>
>> Thanks
>> Mathias
>> .
> Some performance test tools such as fio or iometer can be used to reproduce
>  this case, If tested with 4KB read or write. xHCI will generate a lost TRB
>  events fast than software consume on a certain period of time. Once the interrupt is entered, software may handle more than 128 TRBs at a time.
> While the software is processing, xHCI is still generating events. This may
> has problems caused by the ERDP update mechanism. If update software
>  record temp variable when handles 128 TRB events, event ring full will not
>  happen any more even though fio test with 4KB read or write.
> 
> Thanks
> Weitao Wang
>>

Thanks for the clarification.

Could you resubmit this after fixing the minor patch format issue?
Also make sure patch passes checkpatch test

Thanks
-Mathias
