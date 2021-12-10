Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE91470011
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbhLJLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:39:12 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29177 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhLJLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:39:11 -0500
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J9TLG4PYwz8whn;
        Fri, 10 Dec 2021 19:33:26 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 19:35:33 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <song@kernel.org>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <axboe@kernel.dk>, <hare@suse.de>,
        <jack@suse.cz>, <ming.lei@redhat.com>, <tj@kernel.org>,
        <mcgrof@kernel.org>
CC:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
Subject: [PATCH v3 0/3] Fix undefined behaviour during device synchronization
Date:   Fri, 10 Dec 2021 20:06:28 +0800
Message-ID: <20211210120631.2578505-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

differences to v2:
- Don't move sync_io variable form struct gendisk to struct md_rdev
  in these patch
- fix typo in suject

The v2 "md: Fix undefined behaviour in is_mddev_idle" patch
differences to v1:
- add ubsan info in message
- use 64bit signed integer type instead of long type;
- move sync_io variable form struct gendisk to struct md_rdev, and 
  modify md_sync_acct() and md_sync_acct_bio() to fit for this change.

Li Jinlin (3):
  md: Fix undefined behaviour in is_mddev_idle
  drbd: Fix undefined behaviour in drbd_rs_c_min_rate_throttle
  drbd: Remove useless variable in struct drbd_device

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_int.h      |  5 ++---
 drivers/block/drbd/drbd_main.c     |  3 +--
 drivers/block/drbd/drbd_receiver.c | 12 ++++++------
 drivers/block/drbd/drbd_state.c    |  1 -
 drivers/block/drbd/drbd_worker.c   |  5 ++---
 drivers/md/md.c                    |  6 +++---
 drivers/md/md.h                    |  4 ++--
 include/linux/genhd.h              |  2 +-
 9 files changed, 18 insertions(+), 22 deletions(-)

-- 
2.27.0

