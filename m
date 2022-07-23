Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14DA57EC77
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiGWHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGWHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:38:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E937165A9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 00:38:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LqdRq25n1zGp8s;
        Sat, 23 Jul 2022 15:37:11 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 23 Jul
 2022 15:38:16 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <keescook@chromium.org>, <mike.kravetz@oracle.com>,
        <almasrymina@google.com>, <shakeelb@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] hugetlb_cgroup: fix wrong hugetlb cgroup numa stat
Date:   Sat, 23 Jul 2022 15:38:04 +0800
Message-ID: <20220723073804.53035-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to set cft->private for numa stat file. As a result, numa stat
of hstates[0] is always showed for all hstates. Encode the hstates index
into cft->private to fix this issue.

Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb_cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f9942841df18..c86691c431fd 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -772,6 +772,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
 	/* Add the numa stat file */
 	cft = &h->cgroup_files_dfl[6];
 	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
+	cft->private = MEMFILE_PRIVATE(idx, 0);
 	cft->seq_show = hugetlb_cgroup_read_numa_stat;
 	cft->flags = CFTYPE_NOT_ON_ROOT;
 
-- 
2.23.0

