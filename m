Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4C514292
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354692AbiD2GoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354579AbiD2Gnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:43:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA1C1A822
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:40:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KqNBb2Y8Wz1JBpy;
        Fri, 29 Apr 2022 14:39:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 14:40:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/9] A few fixup patches for z3fold
Date:   Fri, 29 Apr 2022 14:40:42 +0800
Message-ID: <20220429064051.61552-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few fixup patches to fix sheduling while atomic,
fix possible null pointer dereferencing, fix various race conditions and
so on. More details can be found in the respective changelogs. Thanks!

Miaohe Lin (9):
  mm/z3fold: fix sheduling while atomic
  mm/z3fold: fix possible null pointer dereferencing
  mm/z3fold: remove buggy use of stale list for allocation
  mm/z3fold: throw warning on failure of trylock_page in z3fold_alloc
  revert "mm/z3fold.c: allow __GFP_HIGHMEM in z3fold_alloc"
  mm/z3fold: put z3fold page back into unbuddied list when reclaim or
    migration fails
  mm/z3fold: always clear PAGE_CLAIMED under z3fold page lock
  mm/z3fold: fix z3fold_reclaim_page races with z3fold_free
  mm/z3fold: fix z3fold_page_migrate races with z3fold_map

 mm/z3fold.c | 97 ++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

-- 
2.23.0

