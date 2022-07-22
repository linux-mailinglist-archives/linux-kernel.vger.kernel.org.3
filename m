Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6406B57DF37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGVJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGVJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:51:37 -0400
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1C100E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:51:34 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658483488tiq7mmxl
Received: from eureka.localdomain ( [123.124.208.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 17:51:21 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000020
X-QQ-FEAT: u333Yk6K//cJf6U3Gg35wNrITo20vet63t8xhIw9HlBoV0teoSgOYTlAyOa/V
        qkJYzrZKYsHDG0fLMX9OAHn4pTepV4VwPQOlO01nTdipDxzGs7BKJPPdqGKgmfg/5gYNvRQ
        zAwwPdQ3CsGH2IsdvQlqe0iP04U2qsCqtmQESwk2umYpdstqIPs2S1F90uWWm9wNKRlodmR
        /2nHcGBmezFWe6nNDMgWMSEnkpn5AU15KhhL0vejZ680TPMgkBdQmm6o56P+Py5gvOsfmxF
        sODPTnDYNyO7OOd0rfhhrbfzt0FF0HxWOUh2WHsdiNYVw38lDknKptMgg0vxS6bdPnOxCvn
        acqHFT6t+TyeBGkpOx9hSC7xZADuujfwswzWCDoez3AhvaKf4dSQ7FgZ8Y2UgqEHVgr7tCy
        pBRvDhZXSnCrtLLIEVrBLQ==
X-QQ-GoodBg: 1
From:   Wang You <wangyoua@uniontech.com>
To:     axboe@kernel.dk, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, jaegeuk@kernel.org, fio@vger.kernel.org,
        ming.lei@redhat.com, wangyoua@uniontech.com,
        wangxiaohua@uniontech.com
Subject: [PATCH v2 0/2] Improve mq-deadline performance in HDD
Date:   Fri, 22 Jul 2022 17:51:18 +0800
Message-Id: <20220722095120.371212-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jens,

We already know that batching requests can increase the storage
performance of some devices, but after testing, I found that it
will reduce the performance of some low and medium speed devices
when using the scheduler (especially mq-deadline), such as
rotational disks connected to a raid.

In order to balance the performance difference between different
devices, a more sophisticated mechanism may be needed to control
the number of batching (such as sometimes 1 is better),
but obviously this is not easy.

At the same time I noticed that when the mq-deadline scheduler select
a request for a higher sector outside the batch, deadline_fifo_request
is used to select the request within the fifo and restart the batch.
Selecting a request from a fifo tends to satisfy the request's timeline,
but it is not always very urgent.

So in the case of no expire, can the selection strategy of the first
request in the batch be changed? Because in devices with rotation
characteristics, proper sector access order is beneficial to performance.

This patch series includes the following two parts:

- Added a temporary sys interface nr_sched_batch to control the number
  of batching requests.

- Added a deadline_head_request function to select the request from the
  first of the red-black tree instead of the fifo when appropriate.

Thanks,

Wang.

Wang You (2):
  block: Introduce nr_sched_batch sys interface
  block/mq-deadline: Prioritize first request

 block/blk-mq-sched.c   |  4 +++-
 block/blk-sysfs.c      | 32 +++++++++++++++++++++++++++++++
 block/mq-deadline.c    | 43 +++++++++++++++++++++++++++++++++++++++---
 include/linux/blkdev.h |  1 +
 4 files changed, 76 insertions(+), 4 deletions(-)

-- 
2.27.0




