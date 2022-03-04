Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593CF4CBF1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiCCNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCCNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:46:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827A18A7B1;
        Thu,  3 Mar 2022 05:45:26 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8XJk69WQzdZwK;
        Thu,  3 Mar 2022 21:44:06 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:45:24 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 21:45:23 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 1/2] iscsi_tcp: Fix NULL pointer dereference in iscsi_sw_tcp_conn_get_param()
Date:   Thu, 3 Mar 2022 21:56:07 -0500
Message-ID: <20220304025608.1874516-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel might crash in iscsi_sw_tcp_conn_get_param() because it dereference
an invalid address.

The initialization of iscsi_conn's dd_data is after device_register() of
struct iscsi_cls_conn, so iscsi_conn's dd_data might not initialized when
iscsi_sw_tcp_conn_get_param() is called.

Following stack would be reported and kernel would panic.

[449311.812887] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[449311.812893] Mem abort info:
[449311.812895]   ESR = 0x96000004
[449311.812899]   Exception class = DABT (current EL), IL = 32 bits
[449311.812901]   SET = 0, FnV = 0
[449311.812903]   EA = 0, S1PTW = 0
[449311.812905] Data abort info:
[449311.812907]   ISV = 0, ISS = 0x00000004
[449311.812909]   CM = 0, WnR = 0
[449311.812915] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000e26e7ace
[449311.812918] [0000000000000008] pgd=0000000000000000
[449311.812925] Internal error: Oops: 96000004 [#1] SMP
[449311.814974] Process iscsiadm (pid: 8286, stack limit = 0xffff800010f78000)
[449311.815570] CPU: 0 PID: 8286 Comm: iscsiadm Kdump: loaded Tainted: G    B   W         4.19.90-vhulk2201.1.0.h1021.kasan.eulerosv2r10.aarch64 #1
[449311.816584] sd 1:0:0:1: [sdg] Attached SCSI disk
[449311.816695] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[449311.817677] pstate: 40400005 (nZcv daif +PAN -UAO)
[449311.818121] pc : iscsi_sw_tcp_conn_get_param+0xec/0x300 [iscsi_tcp]
[449311.818688] lr : iscsi_sw_tcp_conn_get_param+0xe8/0x300 [iscsi_tcp]
[449311.819244] sp : ffff800010f7f890
[449311.819542] x29: ffff800010f7f890 x28: ffff8000cb1bea38
[449311.820025] x27: ffff800010911010 x26: ffff2000028887a4
[449311.820500] x25: ffff800009200d98 x24: ffff800010911000
[449311.820973] x23: 0000000000000000 x22: ffff8000cb1bea28
[449311.821458] x21: 0000000000000015 x20: ffff200081afa000
[449311.821934] x19: 1ffff000021eff20 x18: 0000000000000000
[449311.822414] x17: 0000000000000000 x16: ffff200080618220
[449311.822891] x15: 0000000000000000 x14: 0000000000000000
[449311.823413] x13: 0000000000000000 x12: 0000000000000000
[449311.823897] x11: 1ffff0001ab4f41f x10: ffff10001ab4f41f
[449311.824373] x9 : 0000000000000000 x8 : ffff8000d5a7a100
[449311.824847] x7 : 0000000000000000 x6 : dfff200000000000
[449311.825329] x5 : ffff1000021eff20 x4 : ffff8000cb1bea30
[449311.825806] x3 : ffff200002911178 x2 : ffff2000841ff000
[449311.826281] x1 : e0c234eab8420c00 x0 : ffff8000cb1bea38
[449311.826756] Call trace:
[449311.826987]  iscsi_sw_tcp_conn_get_param+0xec/0x300 [iscsi_tcp]
[449311.827550]  show_conn_ep_param_ISCSI_PARAM_CONN_ADDRESS+0xe4/0x100 [scsi_transport_iscsi]
[449311.828304]  dev_attr_show+0x58/0xb0
[449311.828639]  sysfs_kf_seq_show+0x124/0x210
[449311.829014]  kernfs_seq_show+0x8c/0xa0
[449311.829362]  seq_read+0x188/0x8a0
[449311.829667]  kernfs_fop_read+0x250/0x398
[449311.830024]  __vfs_read+0xe0/0x350
[449311.830339]  vfs_read+0xbc/0x1c0
[449311.830635]  ksys_read+0xdc/0x1b8
[449311.830941]  __arm64_sys_read+0x50/0x60
[449311.831295]  el0_svc_common+0xc8/0x320
[449311.831642]  el0_svc_handler+0xf8/0x160
[449311.831998]  el0_svc+0x10/0x218
[449311.832292] Code: f94006d7 910022e0 940007bb aa1c03e0 (f94006f9)

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/iscsi_tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 1bc37593c88f..14db224486be 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -741,11 +741,16 @@ static int iscsi_sw_tcp_conn_get_param(struct iscsi_cls_conn *cls_conn,
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
-	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
+	struct iscsi_sw_tcp_conn *tcp_sw_conn;
 	struct sockaddr_in6 addr;
 	struct socket *sock;
 	int rc;
 
+	if (!tcp_conn)
+		return -ENOTCONN;
+
+	tcp_sw_conn = tcp_conn->dd_data;
+
 	switch(param) {
 	case ISCSI_PARAM_CONN_PORT:
 	case ISCSI_PARAM_CONN_ADDRESS:
-- 
2.32.0

