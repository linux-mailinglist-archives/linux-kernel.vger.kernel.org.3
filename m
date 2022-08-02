Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1135879F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiHBJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiHBJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:39:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB0730F55;
        Tue,  2 Aug 2022 02:39:29 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lxqf33rRGzmVWX;
        Tue,  2 Aug 2022 17:37:31 +0800 (CST)
Received: from localhost.huawei.com (10.175.124.27) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 17:39:26 +0800
From:   Li Jinlin <lijinlin3@huawei.com>
To:     <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mark.mielke@gmail.com>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Subject: [PATCH] scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()
Date:   Tue, 2 Aug 2022 18:19:39 +0800
Message-ID: <20220802101939.3972556-1-lijinlin3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a kernel NULL pointer derference report as below:

    BUG: kernel NULL pointer dereference, address: 0000000000000038
    CPU: 4 PID: 1050 Comm: cat Not tainted 5.19.0 #38
    RIP: 0010:kernel_getpeername+0xf/0x30
    Call Trace:
     <TASK>
     ? iscsi_sw_tcp_conn_get_param+0x11f/0x17f
     show_conn_ep_param_ISCSI_PARAM_CONN_ADDRESS+0x90/0xb0
     dev_attr_show+0x1d/0x50
     sysfs_kf_seq_show+0xad/0x120
     kernfs_seq_show+0x2c/0x40
     seq_read_iter+0x12e/0x4d0
     ? aa_file_perm+0x177/0x590
     kernfs_fop_read_iter+0x183/0x210
     new_sync_read+0xfe/0x180
     ? 0xffffffff81000000
     vfs_read+0x14d/0x1a0
     ksys_read+0x6d/0xf0
     __x64_sys_read+0x1a/0x20
     do_syscall_64+0x3b/0x90
     entry_SYSCALL_64_after_hwframe+0x63/0xcd

The problem scenario is:

              CPU1                         CPU2
    -------------------------    ------------------------
    iscsi_sw_tcp_conn_get_param
      spin_lock_bh(&frwd_lock)
      if (!tcp_sw_conn || !tcp_sw_conn->sock)
         spin_unlock_bh(&frwd_lock)
         return -ENOTCONN

      sock = tcp_sw_conn->sock;
      sock_hold(sock->sk)
      spin_unlock_bh(&frwd_lock)
                                  iscsi_sw_tcp_release_conn
                                    spin_lock_bh(&frwd_lock)
                                    tcp_sw_conn->sock = NULL
                                    spin_unlock_bh(&frwd_lock)
                                    sockfd_put(sock)
                                      task_work
                                        __fput
                                          sock_close
                                            __sock_release
                                              sock->sk = NULL
                                              sock->ops = NULL
                                              sock->file = NULL
      kernel_getpeername
        sock->ops->getname
        ^^^^^^^^^
        NULL pointer dereference of sock->ops

sock_hold() and sock_put() can't ensure that sock_close() won't be
called before calling getpeername() or getsockname(). Using fget()
and sockfd_put() replace sock_hold() and sock_put(), and put them
under frwd_lock protection, to ensure that the socket struct is
preserved until after the getpeernaem() or getsockname() complete.

Fixes: bcf3a2953d36 ("scsi: iscsi: iscsi_tcp: Avoid holding spinlock while calling getpeername()")
Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
---
 drivers/scsi/iscsi_tcp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9fee70d6434a..63532dc3970d 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -612,8 +612,8 @@ static void iscsi_sw_tcp_release_conn(struct iscsi_conn *conn)
 
 	spin_lock_bh(&session->frwd_lock);
 	tcp_sw_conn->sock = NULL;
-	spin_unlock_bh(&session->frwd_lock);
 	sockfd_put(sock);
+	spin_unlock_bh(&session->frwd_lock);
 }
 
 static void iscsi_sw_tcp_conn_destroy(struct iscsi_cls_conn *cls_conn)
@@ -756,7 +756,7 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
 			return -ENOTCONN;
 		}
 		sock = tcp_sw_conn->sock;
-		sock_hold(sock->sk);
+		fget(sock->file);
 		spin_unlock_bh(&conn->session->frwd_lock);
 
 		if (param == ISCSI_PARAM_LOCAL_PORT)
@@ -765,7 +765,9 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
 		else
 			rc = kernel_getpeername(sock,
 						(struct sockaddr *)&addr);
-		sock_put(sock->sk);
+		spin_lock_bh(&conn->session->frwd_lock);
+		sockfd_put(sock);
+		spin_unlock_bh(&conn->session->frwd_lock);
 		if (rc < 0)
 			return rc;
 
@@ -808,12 +810,14 @@ static int iscsi_sw_tcp_host_get_param(struct Scsi_Host *shost,
 			spin_unlock_bh(&session->frwd_lock);
 			return -ENOTCONN;
 		}
-		sock_hold(sock->sk);
+		fget(sock->file);
 		spin_unlock_bh(&session->frwd_lock);
 
 		rc = kernel_getsockname(sock,
 					(struct sockaddr *)&addr);
-		sock_put(sock->sk);
+		spin_lock_bh(&conn->session->frwd_lock);
+		sockfd_put(sock);
+		spin_unlock_bh(&conn->session->frwd_lock);
 		if (rc < 0)
 			return rc;
 
-- 
2.27.0

