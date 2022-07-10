Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748156CC95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 06:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiGJEJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGJEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 00:09:36 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6E12D2B;
        Sat,  9 Jul 2022 21:09:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4LgYR80ScHz6PCT4;
        Sun, 10 Jul 2022 12:08:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mn4UMpiguJUAg--.16364S4;
        Sun, 10 Jul 2022 12:09:30 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, asml.silence@gmail.com, osandov@fb.com,
        jack@suse.cz
Cc:     kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC v3 0/3] bugfix for sbitmap
Date:   Sun, 10 Jul 2022 12:21:57 +0800
Message-Id: <20220710042200.20936-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgB32mn4UMpiguJUAg--.16364S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy7CryUJF17Kry5AF45Awb_yoWDCFg_AF
        ykKa4rKwn7XF4UKa4xJr1rZryvk398Jw1kZa4DtrWxAr13Zw1fJrs3GrZ7Xw47Z3Z5XryU
        tFyUZ34vqr1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - rename patch 2, and add some comments.
 - add patch 3, which fixes a new issue pointed out by Jan Kara.
Changes in v2:
 - split to spearate patches for different problem.
 - add fix tag

This patchset fixes problems in the wakeup path on concurrent scenarios,
the problems are found during code review, and it's not reporduced in
real test yet in my environment.

Keith reported a possible related io hung problem in nvme:

https://bugzilla.kernel.org/show_bug.cgi?id=215679

Previous versions:
v1: https://lore.kernel.org/all/20220617141125.3024491-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220619080309.1630027-1-yukuai3@huawei.com/

Yu Kuai (3):
  sbitmap: fix that same waitqueue can be woken up continuously
  sbitmap: fix invalid wakeup on the wrong waitqueue
  sbitmap: fix that 'wait_cnt' can be decreased while waitqueue is empty

 lib/sbitmap.c | 70 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

-- 
2.31.1

