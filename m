Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8024959CE51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiHWCIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiHWCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:08:43 -0400
X-Greylist: delayed 1871 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 19:08:40 PDT
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D3F33A10;
        Mon, 22 Aug 2022 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VcjBr
        x5NcRDcCtos/TPNCVqfav4qyE7ow6dAU7IPv8M=; b=a4S5z2YVX3o9E+XpAyh6Y
        68/5o/XbgsAlg7PsdMjogmE2/RqIQTsHiUC2kinOmuesKZDbPToW86DQ4hzVpC5y
        KVGUtfATz0iJJrhAbhSq6aAS/r5VD3uRoUksaY0SBTe+hIQt7MetuN+t3akDk1no
        wi7w+fVS7sxC+5tzjNw1Gs=
Received: from fedora.. (unknown [123.52.27.102])
        by smtp3 (Coremail) with SMTP id DcmowAC33o49LwRj8lDqAQ--.42709S2;
        Tue, 23 Aug 2022 09:37:02 +0800 (CST)
From:   zhaomzhao@126.com
To:     djwong@kernel.org, corbet@lwn.net
Cc:     linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH v1] Documentation: filesystems: xfs: update pseudocode and typo fixes
Date:   Mon, 22 Aug 2022 21:36:53 -0400
Message-Id: <20220823013653.203469-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAC33o49LwRj8lDqAQ--.42709S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF18WrW3CryrCFWDWr48Zwb_yoWrAw1Upr
        Za9r1rJw1kJry8Ars2qw45XryF9anYqrWUGrWqy3s3Zws8K3Zayr13tr1Y9F1kXr4ru3WY
        vr1j9rn8Za47Ca7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jplk3UUUUU=
X-Originating-IP: [123.52.27.102]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbijB9md1pEJE5iSwAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

According to the implementation of xfs_trans_roll(), it calls
xfs_trans_reserve(), which reserves not only log space, but also
free disk blocks. In short, the "transaction stuff". So change
xfs_log_reserve() to xfs_trans_reserve().

Besides, fix several typo issues.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 .../filesystems/xfs-delayed-logging-design.rst       | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs-delayed-logging-design.rst
index 4ef419f54663..02b32030bab3 100644
--- a/Documentation/filesystems/xfs-delayed-logging-design.rst
+++ b/Documentation/filesystems/xfs-delayed-logging-design.rst
@@ -100,7 +100,7 @@ transactions together::
 
 	ntp = xfs_trans_dup(tp);
 	xfs_trans_commit(tp);
-	xfs_log_reserve(ntp);
+	xfs_trans_reserve(ntp);
 
 This results in a series of "rolling transactions" where the inode is locked
 across the entire chain of transactions.  Hence while this series of rolling
@@ -191,7 +191,7 @@ transaction rolling mechanism to re-reserve space on every transaction roll. We
 know from the implementation of the permanent transactions how many transaction
 rolls are likely for the common modifications that need to be made.
 
-For example, and inode allocation is typically two transactions - one to
+For example, an inode allocation is typically two transactions - one to
 physically allocate a free inode chunk on disk, and another to allocate an inode
 from an inode chunk that has free inodes in it.  Hence for an inode allocation
 transaction, we might set the reservation log count to a value of 2 to indicate
@@ -200,7 +200,7 @@ chain. Each time a permanent transaction rolls, it consumes an entire unit
 reservation.
 
 Hence when the permanent transaction is first allocated, the log space
-reservation is increases from a single unit reservation to multiple unit
+reservation is increased from a single unit reservation to multiple unit
 reservations. That multiple is defined by the reservation log count, and this
 means we can roll the transaction multiple times before we have to re-reserve
 log space when we roll the transaction. This ensures that the common
@@ -259,7 +259,7 @@ the next transaction in the sequeunce, but we have none remaining. We cannot
 sleep during the transaction commit process waiting for new log space to become
 available, as we may end up on the end of the FIFO queue and the items we have
 locked while we sleep could end up pinning the tail of the log before there is
-enough free space in the log to fulfil all of the pending reservations and
+enough free space in the log to fulfill all of the pending reservations and
 then wake up transaction commit in progress.
 
 To take a new reservation without sleeping requires us to be able to take a
@@ -615,7 +615,7 @@ those changes into the current checkpoint context. We then initialise a new
 context and attach that to the CIL for aggregation of new transactions.
 
 This allows us to unlock the CIL immediately after transfer of all the
-committed items and effectively allow new transactions to be issued while we
+committed items and effectively allows new transactions to be issued while we
 are formatting the checkpoint into the log. It also allows concurrent
 checkpoints to be written into the log buffers in the case of log force heavy
 workloads, just like the existing transaction commit code does. This, however,
@@ -886,7 +886,7 @@ can be multiple outstanding checkpoint contexts, we can still see elevated pin
 counts, but as each checkpoint completes the pin count will retain the correct
 value according to it's context.
 
-Just to make matters more slightly more complex, this checkpoint level context
+Just to make matters slightly more complex, this checkpoint level context
 for the pin count means that the pinning of an item must take place under the
 CIL commit/flush lock. If we pin the object outside this lock, we cannot
 guarantee which context the pin count is associated with. This is because of
-- 
2.37.1

