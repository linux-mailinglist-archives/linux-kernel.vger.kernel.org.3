Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927EB56812B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiGFIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiGFIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:23:16 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA32723BE5;
        Wed,  6 Jul 2022 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YIlwG
        mkCnNWwg9yDvnJieOw98BJOCEUEMOaSjA7XI40=; b=Z1lhBI/zQD1R3iTkNHoC/
        Eqe8yJBWFF+Z/ri7WpOgWyVBuM0XJNFabwfR5Q6pq1nh3SE4UywVGPxoftPfaJeR
        28K5HR+BdGdt4SGIi4cLtz72kT4jTx4HHJXyj4jAl4uvALjnQvH8H7PkvWFhvBlK
        svE2jHYrzByiIOK2c++DZw=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp1 (Coremail) with SMTP id GdxpCgDX3tZPRsViE6pDMw--.58602S4;
        Wed, 06 Jul 2022 16:22:48 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     djwong@kernel.org, dchinner@redhat.com, chandan.babu@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] xfs: fix potential memory leak in xfs_bmap_add_attrfork()
Date:   Wed,  6 Jul 2022 16:22:37 +0800
Message-Id: <20220706082237.2255887-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDX3tZPRsViE6pDMw--.58602S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr13uFy3tryDXr4Uur48JFb_yoWfCrb_Ja
        n7KF1xC3y5Ja9rJw1jyFZ0gr4jqFW8AFs3Za17KFy3Kr15JFZ8Xr97Xryvyr1xGrW5WFs5
        CFn7Kr1Fkrya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRibAwPUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBORg2jF-POXTu9AAAsc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_bmap_add_attrfork() allocates a memory chunk for ip->i_afp with
xfs_ifork_alloc(). When some error occurs, the function goto trans_cancel;
without releasing the ip->i_afp, which will lead to a memory leak.

We should release the ip->i_afp with kmem_cache_free() and set "ip->i_afp
= NULL" if ip->i_afp is not NULL pointer.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 6833110d1bd4..0c99726c0968 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1088,6 +1088,10 @@ xfs_bmap_add_attrfork(
 trans_cancel:
 	xfs_trans_cancel(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	if (ip->i_afp) {
+		kmem_cache_free(xfs_ifork_cache, ip->i_afp);
+		ip->a_afp = NULL;
+	}
 	return error;
 }
 
-- 
2.25.1

