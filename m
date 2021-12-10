Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6555846FA88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhLJGAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 01:00:51 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33840 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhLJGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 01:00:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-8.hYj_1639115834;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-8.hYj_1639115834)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 13:57:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] lsm: Fix kernel-doc
Date:   Fri, 10 Dec 2021 13:57:12 +0800
Message-Id: <20211210055712.16949-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in lsm.c kernel-doc comment
to remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

security/apparmor/lsm.c:819: warning: expecting prototype for
apparmor_clone_security(). Prototype was for
apparmor_sk_clone_security() instead
security/apparmor/lsm.c:923: warning: expecting prototype for
apparmor_socket_list(). Prototype was for apparmor_socket_listen()
instead
security/apparmor/lsm.c:1028: warning: expecting prototype for
apparmor_getsockopt(). Prototype was for apparmor_socket_getsockopt()
instead
security/apparmor/lsm.c:1038: warning: expecting prototype for
apparmor_setsockopt(). Prototype was for apparmor_socket_setsockopt()
instead
ecurity/apparmor/lsm.c:1061: warning: expecting prototype for
apparmor_socket_sock_recv_skb(). Prototype was for
apparmor_socket_sock_rcv_skb() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/lsm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f0eecb67dde..ce7d96627810 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -812,7 +812,7 @@ static void apparmor_sk_free_security(struct sock *sk)
 }
 
 /**
- * apparmor_clone_security - clone the sk_security field
+ * apparmor_sk_clone_security - clone the sk_security field
  */
 static void apparmor_sk_clone_security(const struct sock *sk,
 				       struct sock *newsk)
@@ -917,7 +917,7 @@ static int apparmor_socket_connect(struct socket *sock,
 }
 
 /**
- * apparmor_socket_list - check perms before allowing listen
+ * apparmor_socket_listen - check perms before allowing listen
  */
 static int apparmor_socket_listen(struct socket *sock, int backlog)
 {
@@ -1021,7 +1021,7 @@ static int aa_sock_opt_perm(const char *op, u32 request, struct socket *sock,
 }
 
 /**
- * apparmor_getsockopt - check perms before getting socket options
+ * apparmor_socket_getsockopt - check perms before getting socket options
  */
 static int apparmor_socket_getsockopt(struct socket *sock, int level,
 				      int optname)
@@ -1031,7 +1031,7 @@ static int apparmor_socket_getsockopt(struct socket *sock, int level,
 }
 
 /**
- * apparmor_setsockopt - check perms before setting socket options
+ * apparmor_socket_setsockopt - check perms before setting socket options
  */
 static int apparmor_socket_setsockopt(struct socket *sock, int level,
 				      int optname)
@@ -1050,7 +1050,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
 
 #ifdef CONFIG_NETWORK_SECMARK
 /**
- * apparmor_socket_sock_recv_skb - check perms before associating skb to sk
+ * apparmor_socket_sock_rcv_skb - check perms before associating skb to sk
  *
  * Note: can not sleep may be called with locks held
  *
-- 
2.20.1.7.g153144c

