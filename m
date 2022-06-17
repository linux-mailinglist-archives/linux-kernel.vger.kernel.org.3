Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8F54F413
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiFQJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiFQJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:18:04 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A647B1F2F1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:17:59 -0700 (PDT)
Received: from fedora33.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltAC3vuK9RqxiNskEAA--.8183S2;
        Fri, 17 Jun 2022 17:17:55 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linf@wangsu.com
Subject: [PATCH] kernfs/file.c: remove redundant error return counter assignment
Date:   Fri, 17 Jun 2022 17:17:46 +0800
Message-Id: <20220617091746.206515-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: SyJltAC3vuK9RqxiNskEAA--.8183S2
X-Coremail-Antispam: 1UD129KBjvdXoWrGr4kCw1rCF1kurWrtry8AFb_yoWxGFX_JF
        W8AryxCr4jvr1Iqr1kCw4Fvrn093Z3Zr1rK3y5tr1DKrn8X3yUGr9Yy3W5Ary5Jry3Gryk
        AFs8ur4Y9w4UtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr0_Cr1lYx0E74AGY7Cv6cx2
        6r48McIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
        vY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4fMxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UmzuAUUUUU=
X-CM-SenderInfo: holqwq5zdqw23xof0z/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since previous 'rc = -EINVAL;', rc value doesn't change, so not
necessary to re-assign it again.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 fs/kernfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879..54b2a13ac9a2 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -484,7 +484,6 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	 * It is not possible to successfully wrap close.
 	 * So error if someone is trying to use close.
 	 */
-	rc = -EINVAL;
 	if (vma->vm_ops && vma->vm_ops->close)
 		goto out_put;
 
-- 
2.31.1

