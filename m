Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0047D240
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbhLVMnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:43:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33894 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245050AbhLVMm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:42:29 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtHw0jQMzcc0Q;
        Wed, 22 Dec 2021 20:42:04 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (7.193.23.29) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 20:42:27 +0800
Received: from localhost.localdomain (10.175.101.6) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 20:42:26 +0800
From:   Peng Liang <liangpeng10@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <xiexiangyou@huawei.com>, <zhengchuan@huawei.com>,
        <wanghao232@huawei.com>, <liangpeng10@huawei.com>
Subject: [RFC 0/1] memfd: Support mapping to zero page on reading
Date:   Wed, 22 Dec 2021 20:33:59 +0800
Message-ID: <20211222123400.1659635-1-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Recently we are working on implementing CRIU [1] for QEMU based on
Steven's work [2].  It will use memfd to allocate guest memory in order
to restore (inherit) it in the new QEMU process.  However, memfd will
allocate a new page for reading while anonymous memory will map to zero
page for reading.  For QEMU, memfd may cause that all memory are
allocated during the migration because QEMU will read all pages in
migration.  It may lead to OOM if over-committed memory is enabled,
which is usually enabled in public cloud.

In this patch I try to add support mapping to zero pages on reading
memfd.  On reading, memfd will map to zero page instead of allocating a
new page.  Then COW it when a write occurs.

For now it's just a demo for discussion.  There are lots of work to do,
e.g.:
1. don't support THP;
2. don't support shared reading and writing, only for inherit.  For
   example:
     task1                        | task2
       1) read from addr          |
                                  |   2) write to addr
       3) read from addr again    |
   then 3) will read 0 instead of the data task2 writed in 2).

Would something similar be welcome in the Linux?

Thanks,
Peng

[1] https://criu.org/Checkpoint/Restore
[2] https://patchwork.kernel.org/project/qemu-devel/cover/1628286241-217457-1-git-send-email-steven.sistare@oracle.com/

Peng Liang (1):
  memfd: Support mapping to zero page on reading memfd

 include/linux/fs.h         |  2 ++
 include/uapi/linux/memfd.h |  1 +
 mm/memfd.c                 |  8 ++++++--
 mm/memory.c                | 37 ++++++++++++++++++++++++++++++++++---
 mm/shmem.c                 | 10 ++++++++--
 5 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.33.1

