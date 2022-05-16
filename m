Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6169B527C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiEPDDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiEPDDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:03:02 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 May 2022 20:03:00 PDT
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7898558D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:02:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="60951355"
X-IronPort-AV: E=Sophos;i="5.91,229,1647270000"; 
   d="scan'208";a="60951355"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 16 May 2022 12:01:54 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D8FB1CFC7C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:01:54 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 18FD0D996B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:01:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 1E01D200B29C;
        Mon, 16 May 2022 12:01:52 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     akpm@linux-foundation.org
Cc:     aquini@redhat.com, ddutile@redhat.com, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return pfn in the target zone
Date:   Mon, 16 May 2022 11:41:22 +0900
Message-Id: <20220516024122.71543-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220513140141.3b2accfc8fbae08ec4177781@linux-foundation.org>
References: <20220513140141.3b2accfc8fbae08ec4177781@linux-foundation.org>
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

On Fri, 13 May 2022 14:01:41 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 13 May 2022 13:11:12 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:
>
>> On Thu, 12 May 2022 13:49:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>> > On Thu, 12 May 2022 13:27:33 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:
>> >
>> >> >> Thank you for your review.
>> >> >> The runtime effect is that compaction become unintended behavior.
>> >> >> For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
>> >> >> As a result, pages migrate between nodes unintentionally.
>> >> >
>> >> > Many thanks for clarifying. :) Is this worth a Fixes tag or even CC stable?
>> >> >
>> >> > Thanks!
>> >> 
>> >> Thank you for your reply.
>> >> 
>> >> If add a Fixes tag, I think the following commit:
>> >>   Fixes: 70b4459 ("mm, compaction: use free lists to quickly locate a migration source")
>> >> 
>> >> Andrew, how do you think about this? 
>> >
>> > Thanks, I added that and also a paragraph describing the effect of the bug:
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-fast_find_migrateblock-should-return-pfn-in-the-target-zone.patch
>> >
>> > I assume this problem isn't sufficiently serious to require a -stable
>> > backport of the fix?
>> 
>> This would be a serious problem for older kernels without commit a984226, 
>> because it can corrupt the lru list by handling pages in list without holding proper lru_lock.
>
> Thanks, I added the above to the changelog.
>
> The patch applies OK to older kernels (I tried v5.10).  So I guess we
> put a cc:stable in this, so it gets backported?

Sounds great.
I think that's fine.

Thanks,
Rei
