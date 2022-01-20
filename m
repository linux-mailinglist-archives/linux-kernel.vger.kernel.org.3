Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F176494EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbiATNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245355AbiATNKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE99B81A74
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8364C340E0;
        Thu, 20 Jan 2022 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684249;
        bh=aDoZ/3URPFdhRIJ6USCLyACTjwD8GaFFaNpMXe6l2eo=;
        h=From:To:Cc:Subject:Date:From;
        b=NVMOla5YHMD7FWeXo6bwCJbkXkzPJTxMqIUCIa/cjMQmzAY7/jROfDw9v9HpoDA1p
         i7icKGQROabEpOo6IBhuDM3F09eNmHKkfb9rbh5PJuu4iNZqoYlVhldXDqHl42zF8D
         ltY3Mfe1t2BU/b2+Tg61TnYwkAD8J/dy/ANbmxMFuYiinJainUGjlk4v+jBUu1ZW8C
         fhcOqGMNp5TzyGvieUq9Rr/b47e9Ab9CukZQ3MgQpevRrMNFGhndBCKtagtq+/cOmu
         IJN8FAKOViYrDlS5YF36B2j/CB03e1vyd1juxRqcgepI64qBPWHF8bZEZ/jPAAROLy
         rO6Oitr2d50LA==
From:   alexs@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alexs@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/5] remove add/del page to lru functions
Date:   Thu, 20 Jan 2022 21:10:19 +0800
Message-Id: <20220120131024.502877-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

Couple of old page/lru operation funcs are just inline replaced. Remove
them to reduce function name remember and make code simple.

Thanks
Alex

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org

Alex Shi (5):
  mm: remove page_is_file_lru function
  mm: remove __clear_page_lru_flags()
  mm: remove add_page_to_lru_list() function
  mm: remove add_page_to_lru_list_tail()
  mm: remove del_page_from_lru_list()

 include/linux/mm_inline.h     | 28 ----------------------------
 include/trace/events/vmscan.h |  2 +-
 mm/compaction.c               |  4 ++--
 mm/gup.c                      |  2 +-
 mm/khugepaged.c               |  4 ++--
 mm/memory-failure.c           |  2 +-
 mm/memory_hotplug.c           |  2 +-
 mm/mempolicy.c                |  2 +-
 mm/migrate.c                  | 14 +++++++-------
 mm/mlock.c                    |  2 +-
 mm/mprotect.c                 |  2 +-
 mm/swap.c                     | 22 +++++++++++-----------
 mm/vmscan.c                   | 23 ++++++++++++-----------
 13 files changed, 41 insertions(+), 68 deletions(-)

-- 
2.25.1

