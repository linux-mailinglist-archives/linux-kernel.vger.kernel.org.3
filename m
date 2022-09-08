Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1495B2651
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiIHS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:56:06 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08DA6B4E98
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E5i1k
        9AyNs13L3TPS31aEC3J502Y6x/1RyxN8qE8qu8=; b=VAmxsHyHnTU9VrTD2sFRw
        THzU5ljfRaPZPq2X8eHjqJocidUhfxj+Za1ieoYTiLbBWN22NTjLTmp5+r76GuSh
        nRckeeknR4nRhz2kKRmBQBujwuOnOVew++FePyMZcIC1g6DcsWQD4fl8ycDhwJkd
        W1zw4g8T0+UTDp9VujiRQQ=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp8 (Coremail) with SMTP id DMCowAA3Zy9+OhpjR7WkZw--.64992S4;
        Fri, 09 Sep 2022 02:55:06 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        roman.gushchin@linux.dev, hbh25y@gmail.com, legion@kernel.org,
        longman@redhat.com, songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] ipc: mqueue: remove unnecessary conditionals
Date:   Fri,  9 Sep 2022 02:54:52 +0800
Message-Id: <20220908185452.76590-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAA3Zy9+OhpjR7WkZw--.64992S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrWF4UAF1DJr43uF47KF43trb_yoWxWwcEq3
        W8Ga1kta1kWwnF9rs8uFWfZF9Fyw1ku3sYqan7AwnxWryYywnxurs7Jrn2krWUt3W3CF93
        uw4kAa1xArsagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRib11tUUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbisgR2F1UMWUSwAgABsg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iput() has already handled null and non-null parameter, so it is no
need to use if().

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 ipc/mqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 9cf314b3f079..467a194b8a2e 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -986,8 +986,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 
 out_unlock:
 	inode_unlock(d_inode(mnt->mnt_root));
-	if (inode)
-		iput(inode);
+	iput(inode);
 	mnt_drop_write(mnt);
 out_name:
 	putname(name);

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

