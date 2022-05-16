Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD7528C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiEPRmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbiEPRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:41:32 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 10:41:25 PDT
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3C4423701D;
        Mon, 16 May 2022 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=DjFY8kI2tBxuMhCnW3UlpTLlJzV7HoCSZMoVqH/WCD8=; b=S
        RirxfGceUucx9whh94apwdg2TnJjAuwqnl5Q25s4qXetI+lACrLCcYCaz4sEG03b
        T+xN3MQh5Jczp+gCk5J/5avnk6+p/yC4fN2ygWCFxottkUetJW/q1muDbkEGnYHi
        wl5oAFUyLNYbbdsO4TXRLbirXMxCjcx8p87lqJvNEo=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogD39OR0jIJidi5ABg--.34814S2;
        Tue, 17 May 2022 01:40:05 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     serge@hallyn.com, jmorris@namei.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, ebiederm@xmission.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] commoncap: check return value to avoid null pointer dereference
Date:   Mon, 16 May 2022 10:40:02 -0700
Message-Id: <1652722802-66170-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogD39OR0jIJidi5ABg--.34814S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWfuryxJF15Xr43tF15XFb_yoW8Xr4fpa
        1fCa48Jr4rJFyj9w1vvF4Duw1Y9ayfZFW8GFWkuw1ayFs3Gry0yryakw1UuF15CryYk34j
        qr4Yk3y5WF1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEHBlPy7vG+mAAFse
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer inode is dereferenced before a null pointer
check on inode, hence if inode is actually null we will
get a null pointer dereference. Fix this by only dereferencing
inode after the null pointer check on inode.

Fixes: c6f493d631c ("VFS: security/: d_backing_inode() annotations")
Fixes: 8db6c34 ("Introduce v3 namespaced file capabilities")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 security/commoncap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986..978f011 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -298,6 +298,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)
 	struct inode *inode = d_backing_inode(dentry);
 	int error;
 
+	if (!inode)
+		return 0;
 	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
 	return error > 0;
 }
@@ -545,11 +547,13 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 	const struct vfs_cap_data *cap = *ivalue;
 	__u32 magic, nsmagic;
 	struct inode *inode = d_backing_inode(dentry);
-	struct user_namespace *task_ns = current_user_ns(),
-		*fs_ns = inode->i_sb->s_user_ns;
+	struct user_namespace *task_ns = current_user_ns(), *fs_ns;
 	kuid_t rootid;
 	size_t newsize;
 
+	if (!inode)
+		return -EINVAL;
+	fs_ns = inode->i_sb->s_user_ns;
 	if (!*ivalue)
 		return -EINVAL;
 	if (!validheader(size, cap))
-- 
2.7.4

