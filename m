Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64C4B014A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiBIXbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:31:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiBIXaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40332E06145B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KSAZr020152;
        Wed, 9 Feb 2022 23:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JVVMWWAgJZkOZl8pzLkY0CwA8WarJlNyYk4gZe4QNp8=;
 b=qVcspgzQ4MEhJuapMrFyk4WlmaxIo+75Bs5UToJz6sQXipMSsurrEktd0Zyc5nTrfYk7
 UEUL3JmerWiCS6uDqBqB43Dlsyy2XW3YRvxWW88Ox8YlyE0rDmvPsEePhT9EZoQWJR7U
 hDa8AFeaWWfaz6gI4fWarPoqDf/iD+Ieinedu12ribIHb3fXoIga4txXA2vzdV2QIMKA
 uxJiJTOHLHOaasn6mvzzySpy4qXs24gg5k8YjvhIiP7XCaG5Q3p/OuA+vCtMsgdagst2
 vKT28DKg/OoKSD+njYiCwKYlq6upNdPCC37i/XBiynm+xcwTNBZwZTYHhSmjnUB2OefI TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wyd4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFa117827;
        Wed, 9 Feb 2022 23:29:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5sZFgslWTZ98YNYyQzpOoH3WBKXWboL9kd+7kKmZxtcmv7RNOV6H/TP0KSncPKsdk88s6H9Qifwj1qJTvKRZj+37B/KpV7ahSlMQeyeJOgTWhYTWBnGnzR9m3HXtkWIuYAiUfw+q+LRc59svC7fiuU+e4u6ng/pDM7X1tp5t68Nn0dRsjVP+mJOfucIECKbqDXXl017I9CF2Mh8KYpUpbjddKud5pOgWYJ38d6i6JXn+XYVbyZbmK2K9C25/WMtL9EveSQEYzQJfccmtOf8t++WXPRpyKA/WCpBG2Jx92+FY92SQOBWYC692g5HqMXgv6RMXYxzSV07rKnkEvObnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVVMWWAgJZkOZl8pzLkY0CwA8WarJlNyYk4gZe4QNp8=;
 b=ZTNYmIt1wCXtbjLuGIMTQAEWbNtgxyuMn8je6zUcmiG1LRNPss4ezFPs+GDWxIebRvUHUL/FMlMgTf+z+pjLNiBm+/qC1gj4eaLmN2W0Rrwbs+aDbTCr3iNgKkON1eDP4IgLoM7BE2aWKwLRjZTNNEiWmfqalpIq/0KjsPb/VdfcU4kDQhLrOjX+BIckbhTMnavK1xo2ayIH2sDCiMUOR3lVuQt80+YwXn3NaefVucqXD+L1LQXwI+VbMtGwNZeVKFky/gaAEisFxi2xnwQP29JlfRENDraUwnGVJuFjMPY8AXgiKP3s0ryCFwkTgEeYHrpEU+OF+hYj5lZmxmdx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVVMWWAgJZkOZl8pzLkY0CwA8WarJlNyYk4gZe4QNp8=;
 b=XVBBkKDH7vR3sYJnsLqKrJYKuO52m8VTYUPfE7w/VsOfE7Zhg99qLMN3yje1u/C+uQQNWVWWMbdb6gF472MHGkFrc3uktMWQfl6sfLlFHPfvZx+THPkEkGNnlXubbB5yVacYirS44nFkVMWK2T0SQWDwCvR6b6tUD6JTjElq7qU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:53 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:53 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V8 6/8] vhost_task: Allow vhost layer to use copy_process
Date:   Wed,  9 Feb 2022 17:29:37 -0600
Message-Id: <20220209232939.9169-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209232939.9169-1-michael.christie@oracle.com>
References: <20220209232939.9169-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2feccb-9005-4255-0d30-08d9ec24131f
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007632A44516F8D3774DE22F12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hLTHB6RalHLdlWB0LjFjLAcmDu3NKOBby6AMZzkzHBJBqCzocBOv1tVwjT1/vqEyggRSmkAVxKN7D32h4V96Ap/bUZCTBhABifj6IyuW9NFv9yYj20z0gdENPscfbjtPvmTTRXG4kA1t66Wgt7TkLo1YTxTCN8xs35SFy0mhBUsLM2UZGH+jXMzmySDt42PcNxiHkISi9Gn/xUO2xKQ/JW5B6Lx2Diy2Jy7T0Q+j1YC8SDDdOzO2RWJZ1YgE3iMrvVUCX9r6zOIcaj0jU1HrP8NSL9Smpt5BehD+l2TkBdpwjDbojLYAN4t3V7AIGQKZmKbXzyTX1EZvxiJHxc9YNZgt0mgBlde8pknYw18Y2HWeMFCSY6vcL1WPHf/Stm0GzvOg1EItZkcaDxBBLER0cH0+L4gAYKkPIt/Gg6mdPEnGZtY4TgxVF2Pyg6jDQr3nX7vE6mqwtC0s8qVXIPceaLCaquyBKKiER0ik0zuI7TMBfefXjIAoh7UGXCVv+4LW6ctikW4h8MJtmnIV7FZA4zdzH6BPDBd3YcbVtpGZ5a6Z4XSalOe8zbz2z85q5LUUQjaiS2vA20+LoCmiYxZTmofqe4WxBRFEPjDwshBjfS6oYv2hpEuZwKyQP+PpZDPkBOtRJAItv5glXCSH+Wxzs/rULrS3h7W2GQIxKjc7dUTPIBBMiULfce6wYLk1ZE3zcFhovd2yCBM25b+6kIe3bOmKfKrX4PZLqoSlZU6g5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(107886003)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrNGaVcmbfsvjU583W/+IEk8/avYSuOHZBMGfkymmmUL1tB7+jwxsdD8J2MY?=
 =?us-ascii?Q?DSycVtWTVeYnThoO1Ac1hZxTLNUB7zXx53k9bLpUlQ6Kvua7D3IdAuSxKRfC?=
 =?us-ascii?Q?HHdefHfh3T6c6HI4MZB7mBU8egpqQrn4NkkUWVkAmk9pUN3Fv3Zg2GBtfYit?=
 =?us-ascii?Q?SeOEt/hOEYyDD1CS5p9owaUAIvk2xkv8ft7JjfeIdnYprkckhQX+KPkMgP48?=
 =?us-ascii?Q?7nww5F1xw5HqiL/25wl/gUNfz2SDACU4RMwOaugQcAfIF8xwaF6rCIXh5osg?=
 =?us-ascii?Q?LCmJUuRPuWZEZESXmyccB4RV6gHvAkE5yz1HVkowFYLAGhno+P9UNS81EIzy?=
 =?us-ascii?Q?ONbonQdPwU9Djdgj3x/BFqtqoLLC+Ul8cr8nVJxNTy/gBmyuM7HaOb+qdUKK?=
 =?us-ascii?Q?zrVl4l+i1JSNwilXBLlfi1dsSCm5GwsVFQI3/4qNH2NBMFqzwIT6jBvSZZI6?=
 =?us-ascii?Q?H5t9fkmtEBmNKqag1BaCoS4hTCc0ujiX6cefsG418y9uIUJbZ522PDZSFcgh?=
 =?us-ascii?Q?zxQAOfRW+/oMYawh+GtppqxjbpeA58oyrcyBdC1u71bN0QB9mbsWK5VJrtgm?=
 =?us-ascii?Q?njIYRIAu/7TC8nSz4Soo4mlng+GIewKu+CLYNJvonM60zr8o6ei835DLHCf3?=
 =?us-ascii?Q?PuFqErW6HCKu7QYQ++NcVjuP9PnPL3QdSyD5psh8Ie5jtDCwCbEbWYp8j5l3?=
 =?us-ascii?Q?G+6Ymza5jnwoghoq4jFdf3mSLNvOjlaMZpwvxCYpLzM98rg0+aXZN12850kv?=
 =?us-ascii?Q?yztwg9Hzjzr4cX8hxQgnYrMUNOLhMzvDWveG3LwBRDesWHRbZxm3CBd4qt1L?=
 =?us-ascii?Q?oloWH5f9SoNVzJ71jps/YYOkHAK3S+hFh3OsHyKDhBLh9EH3ZZQ7x0O+yf0g?=
 =?us-ascii?Q?VynSWkZeZaUmwTu+/ATLXreuAM8RNZ55ypc9ZS/zMTpxtCKE7LRhi3ZrAHur?=
 =?us-ascii?Q?lEuBjttYWiMmuV10rUDHc5RcX6M+ViR0MDJwKaTBN7/+cY7UkjnrxVPUVXjP?=
 =?us-ascii?Q?Alko51LUvjVU4MKzWSswlZurFJGD6xH5GM5//GR3/D+Jc0Ui6N0qAZ6Z3YRc?=
 =?us-ascii?Q?4g0M3jYhyGx0Tpa8bshMAx/cDaJKq+hdWsheGkcYjZJ8HSeFK1h8Mu7NbW/a?=
 =?us-ascii?Q?RRBo6aczTl2JnX37XJfK1PiqhmV3XCfGX+YtgYV9aBiDSEQ72/RFZzPLC4Fn?=
 =?us-ascii?Q?m50Dd6R+9XihbULw46R8yPD1fH92frxTK+l5DIcfWjgfzUTqepB+uAM+owZk?=
 =?us-ascii?Q?DLOdSpGPCXFKwxZZ9SlGwdXco5CiKwIfzJ3zCO58kiGnkjAepWujfTUEQ602?=
 =?us-ascii?Q?WUE47PkSnfAu+Urio/LtLj+ZwZsIgAgzy/mjQIf2mubJDJZlBAD47KBf1FQY?=
 =?us-ascii?Q?yVfjTWPlEcKRSA9LrE2Ekw2ylgfZdlyePhT2bUI/+YJ7SP92tWfdRoy2OhGE?=
 =?us-ascii?Q?+vbwSy/nm2RUEJz18pnGOao3z1gLsKaKlHQKW6SF+y76JIcMNveUFC9KNpkz?=
 =?us-ascii?Q?fkNchtKub40hhvyHp+VXpW+n6VuipkNVE42WC/147bxtb21gkfLOynChaFiH?=
 =?us-ascii?Q?sHbGMDSACDQWo1iWRHFNmvWZZEIG29hzILlkAFkqmSims3jTczBim0ClXnc4?=
 =?us-ascii?Q?Zj/yD/HfW3i9jP9LdaTyBOGrin6gCxNbmXff9+U4IsZ0Kh86PSQWAq2HaEcq?=
 =?us-ascii?Q?8lB+eA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2feccb-9005-4255-0d30-08d9ec24131f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:53.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW5edfpJf7M9cxRbB/U8bl710U5iP0L9ZmFPfFxQQPTskpD06if7xfRtFb3/utSeaXmOX/axZs8V40HBDxxSv0SB8Olppe2TT084c3I8S64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: HJ6CKZzgio3Gs4DxOE79OeuPAvQt7GlB
X-Proofpoint-ORIG-GUID: HJ6CKZzgio3Gs4DxOE79OeuPAvQt7GlB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups, and it bypasses the RLIMIT_NPROC limit.

This patch adds a new struct vhost_task which can be used instead of
kthreads. They allow the vhost layer to use copy_process and inherit
the userspace process's mm and cgroups and the task is accounted for
under the userspace's nproc count.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 MAINTAINERS                      |   2 +
 drivers/vhost/Kconfig            |   5 ++
 include/linux/sched/vhost_task.h |  23 ++++++
 kernel/Makefile                  |   1 +
 kernel/vhost_task.c              | 123 +++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 include/linux/sched/vhost_task.h
 create mode 100644 kernel/vhost_task.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e461db9cd91..4a3d9541e3cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20477,7 +20477,9 @@ L:	virtualization@lists.linux-foundation.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
+F:	kernel/vhost_task.c
 F:	drivers/vhost/
+F:	include/linux/sched/vhost_task.h
 F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h
 
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..b455d9ab6f3d 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -13,9 +13,14 @@ config VHOST_RING
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
 
+config VHOST_TASK
+	bool
+	default n
+
 config VHOST
 	tristate
 	select VHOST_IOTLB
+	select VHOST_TASK
 	help
 	  This option is selected by any driver which needs to access
 	  the core of vhost.
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
new file mode 100644
index 000000000000..50d02a25d37b
--- /dev/null
+++ b/include/linux/sched/vhost_task.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VHOST_TASK_H
+#define _LINUX_VHOST_TASK_H
+
+#include <linux/completion.h>
+
+struct task_struct;
+
+struct vhost_task {
+	int (*fn)(void *data);
+	void *data;
+	struct completion exited;
+	unsigned long flags;
+	struct task_struct *task;
+};
+
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node);
+__printf(2, 3)
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...);
+void vhost_task_stop(struct vhost_task *vtsk);
+bool vhost_task_should_stop(struct vhost_task *vtsk);
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 56f4ee97f328..d82f388082b8 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,6 +15,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
+obj-$(CONFIG_VHOST_TASK) += vhost_task.o
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace internal ftrace files
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
new file mode 100644
index 000000000000..4ab1c195bc76
--- /dev/null
+++ b/kernel/vhost_task.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Oracle Corporation
+ */
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/sched/task.h>
+#include <linux/sched/vhost_task.h>
+#include <linux/sched/signal.h>
+
+enum vhost_task_flags {
+	VHOST_TASK_FLAGS_STOP,
+};
+
+static void vhost_task_fn(void *data)
+{
+	struct vhost_task *vtsk = data;
+	int ret;
+
+	ret = vtsk->fn(vtsk->data);
+	complete(&vtsk->exited);
+	do_exit(ret);
+}
+
+/**
+ * vhost_task_stop - stop a vhost_task
+ * @vtsk: vhost_task to stop
+ *
+ * Callers must call vhost_task_should_stop and return from their worker
+ * function when it returns true;
+ */
+void vhost_task_stop(struct vhost_task *vtsk)
+{
+	pid_t pid = vtsk->task->pid;
+
+	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+	wake_up_process(vtsk->task);
+	/*
+	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
+	 * freeing it below. If userspace crashed or exited without closing,
+	 * then the vhost_task->task could already be marked dead so
+	 * kernel_wait will return early.
+	 */
+	wait_for_completion(&vtsk->exited);
+	/*
+	 * If we are just closing/removing a device and the parent process is
+	 * not exiting then reap the task.
+	 */
+	kernel_wait4(pid, NULL, __WCLONE, NULL);
+	kfree(vtsk);
+}
+EXPORT_SYMBOL_GPL(vhost_task_stop);
+
+/**
+ * vhost_task_should_stop - should the vhost task return from the work function
+ */
+bool vhost_task_should_stop(struct vhost_task *vtsk)
+{
+	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+}
+EXPORT_SYMBOL_GPL(vhost_task_should_stop);
+
+/**
+ * vhost_task_create - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ *
+ * This returns a specialized task for use by the vhost layer or NULL on
+ * failure. The returned task is inactive, and the caller must fire it up
+ * through vhost_task_start().
+ */
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node)
+{
+	struct kernel_clone_args args = {
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.exit_signal	= 0,
+		.stack		= (unsigned long)vhost_task_fn,
+		.worker_flags	= USER_WORKER | USER_WORKER_NO_FILES |
+				  USER_WORKER_SIG_IGN,
+	};
+	struct vhost_task *vtsk;
+	struct task_struct *tsk;
+
+	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
+	if (!vtsk)
+		return ERR_PTR(-ENOMEM);
+
+	init_completion(&vtsk->exited);
+	vtsk->data = arg;
+	vtsk->fn = fn;
+	args.stack_size =  (unsigned long)vtsk;
+
+	tsk = copy_process(NULL, 0, node, &args);
+	if (IS_ERR(tsk)) {
+		kfree(vtsk);
+		return NULL;
+	}
+
+	vtsk->task = tsk;
+
+	return vtsk;
+}
+EXPORT_SYMBOL_GPL(vhost_task_create);
+
+/**
+ * vhost_task_start - start a vhost_task created with vhost_task_create
+ * @vtsk: vhost_task to wake up
+ * @namefmt: printf-style format string for the thread name
+ */
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...)
+{
+	char name[TASK_COMM_LEN];
+	va_list args;
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	set_task_comm(vtsk->task, name);
+	va_end(args);
+
+	wake_up_new_task(vtsk->task);
+}
+EXPORT_SYMBOL_GPL(vhost_task_start);
-- 
2.25.1

