Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B654B5B2667
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiIHTDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIHTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:03:42 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E906AF0DE;
        Thu,  8 Sep 2022 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CaQgj
        Bob6SqadbQ0jswE4yMKXn7bLwOgC9XffFtIQnw=; b=pjU40h/r9SlyOvzNTgUDB
        kc/ZDQOL2E/i+oemjr58V/y9ShfjE034mxxzO2ij/n0+ObrvOBklAvGqZoQMvWtg
        nN7Kc+7Ti3L1D5BET4zmpn18p3wsEUkE+R+MaiCfpScZB7TcFPNMP0pA8pMoldiG
        qDA/Y+EO5tQQsBRkPF5qjk=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp8 (Coremail) with SMTP id DMCowADHdxtSPBpjc8SlZw--.61664S4;
        Fri, 09 Sep 2022 03:02:59 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     mic@digikod.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] landlock: Remove unnecessary conditionals
Date:   Fri,  9 Sep 2022 03:02:39 +0800
Message-Id: <20220908190239.76888-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADHdxtSPBpjc8SlZw--.61664S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWfKr45KFW8XrW5ArWxXrb_yoWfCFc_AF
        18Cr47Kwn5Zrnayws5Za1fZF9Fv3W8GF48WFs3GF1qywnxAFyqkw4kJF1kGrW5Ga1UCas8
        u3WSgF9akwn2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRExwI5UUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbisgN2F1UMWUTdvAAAs1
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
 security/landlock/fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6121e9834961..3d0a8a418ce4 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1009,8 +1009,7 @@ static void hook_sb_delete(struct super_block *const sb)
 	spin_unlock(&sb->s_inode_list_lock);
 
 	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
+	iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

