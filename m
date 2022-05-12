Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D904F524255
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiELCIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiELCIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:08:17 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80846D85E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:08:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="72336034"
X-IronPort-AV: E=Sophos;i="5.91,218,1647270000"; 
   d="scan'208";a="72336034"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 12 May 2022 11:08:13 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B5E0D3EB0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:08:12 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id AF517F28A1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:08:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 7629E200B383;
        Thu, 12 May 2022 11:08:11 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     linmiaohe@huawei.com
Cc:     akpm@linux-foundation.org, aquini@redhat.com, ddutile@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return pfn in the target zone
Date:   Thu, 12 May 2022 10:47:36 +0900
Message-Id: <20220512014736.16376-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <07e0ceb8-a637-b011-bbf6-ba760a0b12e4@huawei.com>
References: <07e0ceb8-a637-b011-bbf6-ba760a0b12e4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 17:26:16 Miaohe Lin wrote:
> On 2022/5/11 15:07, Rei Yamamoto wrote:
>> On Wed, 11 May 2022 14:25:34 Miaohe Lin wrote:
>>> On 2022/5/11 12:43, Rei Yamamoto wrote:
>>>> Prevent returning a pfn outside the target zone in case that not
>>>> aligned with pageblock boundary.
>>>> Otherwise isolate_migratepages_block() would handle pages not in
>>>> the target zone.
>>>>
>>>
>>> IIUC, the sole caller isolate_migratepages will ensure the pfn won't outside
>>> the target zone. So the below code change might not be necessary. Or am I miss
>>> something ?
>> 
>> While block_start_pfn is ensured, this variable is not used as the argument for 
>> isolate_migratepages_block():
>>   -----
>>   static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>>   {
>>   :
>>           low_pfn = fast_find_migrateblock(cc);
>>           block_start_pfn = pageblock_start_pfn(low_pfn);
>>           if (block_start_pfn < cc->zone->zone_start_pfn)
>>                   block_start_pfn = cc->zone->zone_start_pfn;  <--- block_start_pfn is ensured not outside 
>>                                                                     the target zone
>>   :
>>           block_end_pfn = pageblock_end_pfn(low_pfn);
>>   :
>>           for (; block_end_pfn <= cc->free_pfn;
>>                           fast_find_block = false,
>>                           cc->migrate_pfn = low_pfn = block_end_pfn,
>>                           block_start_pfn = block_end_pfn,
>>                           block_end_pfn += pageblock_nr_pages) {
>>   :
>>                   if (isolate_migratepages_block(cc, low_pfn, block_end_pfn,  <--- low_pfn is passed as 
>>                                                                                    the argument
>
> Sorry, I think you're right. And could you please add the runtime effect of this issue?
>
> Anyway, this patch looks good to me now. Thanks!

Thank you for your review.
The runtime effect is that compaction become unintended behavior.
For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
As a result, pages migrate between nodes unintentionally.

Thanks,
Rei
