Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB189525AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376952AbiEMEcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiEMEb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:31:59 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EAD6129C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:31:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="72493187"
X-IronPort-AV: E=Sophos;i="5.91,221,1647270000"; 
   d="scan'208";a="72493187"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 13 May 2022 13:31:55 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5D6AD646C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:31:53 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E67DAD99BC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:31:52 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 935B2203EEC0;
        Fri, 13 May 2022 13:31:52 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     akpm@linux-foundation.org
Cc:     aquini@redhat.com, ddutile@redhat.com, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return pfn in the target zone
Date:   Fri, 13 May 2022 13:11:12 +0900
Message-Id: <20220513041112.31609-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220512134945.fe74df5e322b98ae4046ce15@linux-foundation.org>
References: <20220512134945.fe74df5e322b98ae4046ce15@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 13:49:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 12 May 2022 13:27:33 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:
>
>> >> Thank you for your review.
>> >> The runtime effect is that compaction become unintended behavior.
>> >> For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
>> >> As a result, pages migrate between nodes unintentionally.
>> >
>> > Many thanks for clarifying. :) Is this worth a Fixes tag or even CC stable?
>> >
>> > Thanks!
>> 
>> Thank you for your reply.
>> 
>> If add a Fixes tag, I think the following commit:
>>   Fixes: 70b4459 ("mm, compaction: use free lists to quickly locate a migration source")
>> 
>> Andrew, how do you think about this? 
>
> Thanks, I added that and also a paragraph describing the effect of the bug:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-fast_find_migrateblock-should-return-pfn-in-the-target-zone.patch
>
> I assume this problem isn't sufficiently serious to require a -stable
> backport of the fix?

This would be a serious problem for older kernels without commit a984226, 
because it can corrupt the lru list by handling pages in list without holding proper lru_lock.

Thanks,
Rei
