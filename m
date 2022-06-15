Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94354C24E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiFOHCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiFOHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:02:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D102A969
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:02:17 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNGRK1pKfzjY4B;
        Wed, 15 Jun 2022 15:00:45 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:02:15 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 15:02:14 +0800
From:   liubo <liubo254@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <surenb@google.com>, <peterx@redhat.com>, <neilb@suse.de>,
        <naoya.horiguchi@nec.com>, <minchan@kernel.org>,
        <linmiaohe@huawei.com>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <liubo254@huawei.com>
Subject: [PATCH v2 0/2] mm/swapfile: release swap info when swap device is unpluged
Date:   Wed, 15 Jun 2022 15:02:26 +0800
Message-ID: <20220615070228.2858170-1-liubo254@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patch try to fix the problem that the resources
corresponding to swap are not effectively released when
the swap partition disk is hot-pluged.

1/2: Extract operations of resource release in the swapoff process.
2/2: release swap info when swap device is unpluged

This is a second version, which addressed some comments:
1. turn first patch into a two patch series. The first does the
code movement with no functional changes and the second does
the actual fix.

---
For v1, see: https://lore.kernel.org/linux-mm/20220528084941.28391-1-liubo254@huawei.com/
---

liubo (2):
  mm/swapfile: Extract operations of resource release in the swapoff
    process
  mm/swapfile: release swap info when swap device is unpluged

 mm/swapfile.c | 261 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 183 insertions(+), 78 deletions(-)

-- 
2.27.0

