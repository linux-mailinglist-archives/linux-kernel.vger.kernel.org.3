Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF42C469606
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbhLFM6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:58:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4203 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbhLFM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:58:31 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J73FQ2mzLz6889p;
        Mon,  6 Dec 2021 20:50:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:55:00 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 12:54:58 +0000
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Date:   Mon, 6 Dec 2021 20:49:47 +0800
Message-ID: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
and callees for shared tags.

Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
shared tags, but it was not optimum previously.

This series optimises by having only a single iter (per regular and resv
tags) for the shared tags, instead of an iter per HW queue.

[0] https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Differences to v1:
- Add tested-by and reviewed-by tags
- Reformat 3/3 a bit to keep <= 80 char lines
	- I kept the RB tags, so please check and let me know if not ok
	  with the changes

John Garry (3):
  blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
  blk-mq: Delete busy_iter_fn
  blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags

 block/blk-mq-tag.c     | 65 ++++++++++++++++++++++++++++--------------
 block/blk-mq-tag.h     |  2 +-
 block/blk-mq.c         | 17 ++++++-----
 include/linux/blk-mq.h |  2 --
 4 files changed, 53 insertions(+), 33 deletions(-)

-- 
2.26.2

