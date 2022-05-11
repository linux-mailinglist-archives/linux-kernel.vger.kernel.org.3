Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D517522D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiEKH3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbiEKH3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:29:06 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 00:29:04 PDT
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B9F1DEC49
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:29:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="72307277"
X-IronPort-AV: E=Sophos;i="5.91,216,1647270000"; 
   d="scan'208";a="72307277"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 11 May 2022 16:27:59 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id F2B8CD646B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:27:57 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 43885BDC5F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:27:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id ECF07200B31F;
        Wed, 11 May 2022 16:27:56 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     linmiaohe@huawei.com
Cc:     akpm@linux-foundation.org, aquini@redhat.com, ddutile@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return pfn in the target zone
Date:   Wed, 11 May 2022 16:07:10 +0900
Message-Id: <20220511070710.5576-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <2c2900eb-886a-5bbe-f7c7-9d74a6399893@huawei.com>
References: <2c2900eb-886a-5bbe-f7c7-9d74a6399893@huawei.com>
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

On Wed, 11 May 2022 14:25:34 Miaohe Lin wrote:
> On 2022/5/11 12:43, Rei Yamamoto wrote:
>> Prevent returning a pfn outside the target zone in case that not
>> aligned with pageblock boundary.
>> Otherwise isolate_migratepages_block() would handle pages not in
>> the target zone.
>> 
>
> IIUC, the sole caller isolate_migratepages will ensure the pfn won't outside
> the target zone. So the below code change might not be necessary. Or am I miss
> something ?

While block_start_pfn is ensured, this variable is not used as the argument for 
isolate_migratepages_block():
  -----
  static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
  {
  :
          low_pfn = fast_find_migrateblock(cc);
          block_start_pfn = pageblock_start_pfn(low_pfn);
          if (block_start_pfn < cc->zone->zone_start_pfn)
                  block_start_pfn = cc->zone->zone_start_pfn;  <--- block_start_pfn is ensured not outside 
                                                                    the target zone
  :
          block_end_pfn = pageblock_end_pfn(low_pfn);
  :
          for (; block_end_pfn <= cc->free_pfn;
                          fast_find_block = false,
                          cc->migrate_pfn = low_pfn = block_end_pfn,
                          block_start_pfn = block_end_pfn,
                          block_end_pfn += pageblock_nr_pages) {
  :
                  if (isolate_migratepages_block(cc, low_pfn, block_end_pfn,  <--- low_pfn is passed as 
                                                                                   the argument
                                                  isolate_mode))
                          return ISOLATE_ABORT;
  -----

So, the low_pfn passed to isolate_migratepages_block() can be outside the target zone.

Thanks,
Rei
