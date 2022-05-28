Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5047536A06
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354799AbiE1B7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 21:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352313AbiE1B7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 21:59:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35C5B3CA;
        Fri, 27 May 2022 18:59:07 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L94Yl6WH3z1JCBP;
        Sat, 28 May 2022 09:57:31 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 09:59:05 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 09:59:04 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <yukuai3@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH -next v4 0/6] nbd: bugfix and cleanup patches
Date:   Sat, 28 May 2022 10:12:29 +0800
Message-ID: <20220528021235.2120995-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4
 - in patch 3, return from nbd_handle_reply() with flag cleared if
 request is ready to complete.
 - add reviewed-by tag for patch 1-2, 4-6.
Changes in v3:
 - rewrap to 80 columns where possible in patch 6
Changes in v2:
 - in patch 3, instead of clear and then reset the flag if rq is not
 completed, test first and clear if rq is going to complete.

path 1-2 fix races between nbd setup and module removal.
patch 3 fix io can't be completed in some error path.
patch 4 fix io hung when disconnecting failed.
patch 5 fix sysfs warning about duplicate creation.
patch 6 use pr_err to output error message.

Previous versions:
v1: https://lore.kernel.org/all/20220426130746.885140-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220518122618.1702997-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220521073749.3146892-1-yukuai3@huawei.com/

Yu Kuai (5):
  nbd: call genl_unregister_family() first in nbd_cleanup()
  nbd: fix race between nbd_alloc_config() and module removal
  nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
  nbd: fix io hung while disconnecting device
  nbd: use pr_err to output error message

Zhang Wensheng (1):
  nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

 drivers/block/nbd.c | 109 +++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 46 deletions(-)

-- 
2.31.1

