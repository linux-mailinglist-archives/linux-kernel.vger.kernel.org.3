Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847764DA6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbiCPAkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiCPAki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:40:38 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6EE5DA51;
        Tue, 15 Mar 2022 17:39:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V7JkLTl_1647391161;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7JkLTl_1647391161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 08:39:22 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] capability: Add parameter description in kernel-doc comment
Date:   Wed, 16 Mar 2022 08:39:20 +0800
Message-Id: <20220316003920.108121-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @mnt_userns in privileged_wrt_inode_uidgid()
and capable_wrt_inode_uidgid() kernel-doc comment to remove warnings
found by running scripts/kernel-doc, which is caused by using 'make W=1'.

kernel/capability.c:491: warning: Function parameter or member
'mnt_userns' not described in 'privileged_wrt_inode_uidgid'
kernel/capability.c:507: warning: Function parameter or member
'mnt_userns' not described in 'capable_wrt_inode_uidgid'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/capability.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/capability.c b/kernel/capability.c
index 765194f5d678..ab401d17574d 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -481,6 +481,7 @@ EXPORT_SYMBOL(file_ns_capable);
 /**
  * privileged_wrt_inode_uidgid - Do capabilities in the namespace work over the inode?
  * @ns: The user namespace in question
+ * @mnt_userns: The user namespace of the capability to use
  * @inode: The inode in question
  *
  * Return true if the inode uid and gid are within the namespace.
@@ -495,6 +496,7 @@ bool privileged_wrt_inode_uidgid(struct user_namespace *ns,
 
 /**
  * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapped
+ * @mnt_userns: The user namespace of the capability to use
  * @inode: The inode in question
  * @cap: The capability in question
  *
-- 
2.20.1.7.g153144c

