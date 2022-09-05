Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558E05AC91C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiIED3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIED3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:29:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437E6276
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:29:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLYpv673fznV0D;
        Mon,  5 Sep 2022 11:27:03 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:29:35 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:29:34 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <david@redhat.com>, <npiggin@suse.de>,
        <ying.huang@intel.com>, <hannes@cmpxchg.org>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>, <mgorman@suse.de>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <surenb@google.com>, <mawupeng1@huawei.com>,
        <rppt@kernel.org>, <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH -next v3 0/2] watermark related improvement on zone movable
Date:   Mon, 5 Sep 2022 11:28:56 +0800
Message-ID: <20220905032858.1462927-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

The first patch cap zone movable's min watermark to small value since no
one can use it.

The second patch introduce a per zone watermark to replace the vanilla
watermark_scale_factor to bring flexibility to tune each zone's
watermark separately and lead to more efficient kswapd.

Each patch's detail information can be seen is its own changelog.

changelog since v2:
- add comment in __setup_per_zone_wmarks

changelog since v1:
- fix compile error if CONFIG_SYSCTL is not enabled
- remove useless function comment

Ma Wupeng (2):
  mm: Cap zone movable's min wmark to small value
  mm: sysctl: Introduce per zone watermark_scale_factor

 Documentation/admin-guide/sysctl/vm.rst |  6 +++
 include/linux/mm.h                      |  2 +-
 kernel/sysctl.c                         |  2 -
 mm/page_alloc.c                         | 49 ++++++++++++++++++-------
 4 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.25.1

