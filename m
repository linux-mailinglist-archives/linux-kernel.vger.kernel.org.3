Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE49246F9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhLJEtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:49:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15716 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhLJEtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:49:45 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9JF016htzZffX;
        Fri, 10 Dec 2021 12:43:16 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 12:46:08 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <song@kernel.org>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <mcgrof@kernel.org>, <mcroce@microsoft.com>
CC:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <drbd-dev@lists.linbit.com>,
        <linfeilong@huawei.com>
Subject: [PATCH 0/3] Fix undefined behaviour during device synchronization
Date:   Fri, 10 Dec 2021 13:17:04 +0800
Message-ID: <20211210051707.2202646-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

md/drbd drivers use 'signed int' variable to track sync vs non-sync IO,
and judge whether sync IO needs to be throttled by signed comparison.
If the value of the variable is greater than INT_MAX or close to
INT_MAX, some undefined behavior may occur.

Fix by using 64bit signed integer type.

The v2 "md: Fix undefined behaviour in is_mddev_idle" patch
differences to v1:
- add ubsan info in message
- use 64bit signed integer type instead of long type;
- move sync_io variable form struct gendisk to struct md_rdev, and 
  modify md_sync_acct() and md_sync_acct_bio() to fit for this change.

Li Jinlin (3):
  md: Fix undefined behaviour in is_mddev_idle
  drdb: Fix undefined behaviour in drbd_rs_c_min_rate_throttle
  drdb: Remove useless variable in struct drbd_device

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_int.h      |  5 ++---
 drivers/block/drbd/drbd_main.c     |  3 +--
 drivers/block/drbd/drbd_receiver.c | 12 ++++++------
 drivers/block/drbd/drbd_state.c    |  1 -
 drivers/block/drbd/drbd_worker.c   |  5 ++---
 drivers/md/md.c                    |  6 +++---
 drivers/md/md.h                    | 13 +++++++++----
 drivers/md/raid1.c                 |  4 ++--
 drivers/md/raid10.c                | 24 ++++++++++++------------
 drivers/md/raid5.c                 |  4 ++--
 include/linux/genhd.h              |  1 -
 12 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.27.0

