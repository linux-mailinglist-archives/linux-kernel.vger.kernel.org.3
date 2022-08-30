Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E95A6377
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiH3Mgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3Mgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DED5707
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH6Bf71XdzYcmn;
        Tue, 30 Aug 2022 20:32:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:36:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/6] A few cleanup patches for memory-failure
Date:   Tue, 30 Aug 2022 20:35:58 +0800
Message-ID: <20220830123604.25763-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few cleanup patches to use __PageMovable() to
detect non-lru movable pages, use num_poisoned_pages_sub() to reduce
multiple atomic ops overheads and so on. More details can be found in
the respective changelogs.
Thanks!

Miaohe Lin (6):
  mm, hwpoison: use ClearPageHWPoison() in memory_failure()
  mm, hwpoison: use __PageMovable() to detect non-lru movable pages
  mm, hwpoison: use num_poisoned_pages_sub() to decrease
    num_poisoned_pages
  mm, hwpoison: avoid unneeded page_mapped_in_vma() overhead in
    collect_procs_anon()
  mm, hwpoison: check PageTable() explicitly in hwpoison_user_mappings()
  mm, hwpoison: cleanup some obsolete comments

 include/linux/swapops.h |  5 -----
 mm/memory-failure.c     | 28 +++++++++++++++-------------
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.23.0

