Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0288447BEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhLUL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:27:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30155 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhLUL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:27:13 -0500
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJDdJ0hV9z8vr4;
        Tue, 21 Dec 2021 19:24:52 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 19:27:11 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 21 Dec
 2021 19:27:10 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <gregkh@linuxfoundation.org>,
        <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH linux-4.19.y 0/5] fix memleak of bfq weights_tree node
Date:   Tue, 21 Dec 2021 19:38:44 +0800
Message-ID: <20211221113849.2219126-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our test found that bfq_weight_counter can leak quite easy. This problem
can be fixed by patch 4, and other patches is needed to backport patch
4.

Federico Motta (2):
  block, bfq: improve asymmetric scenarios detection
  block, bfq: fix asymmetric scenarios detection

Paolo Valente (3):
  block, bfq: fix decrement of num_active_groups
  block, bfq: fix queue removal from weights tree
  block, bfq: fix use after free in bfq_bfqq_expire

 block/bfq-iosched.c | 287 +++++++++++++++++++++++++++-----------------
 block/bfq-iosched.h |  76 +++++++++---
 block/bfq-wf2q.c    |  56 +++++----
 3 files changed, 270 insertions(+), 149 deletions(-)

-- 
2.31.1

