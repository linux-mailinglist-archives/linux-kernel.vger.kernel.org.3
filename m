Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04D4A79F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347396AbiBBVCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347359AbiBBVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhHr023475;
        Wed, 2 Feb 2022 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fseAn7YO78aTwAzJ16qHietl5vUI9fSQponEomcd2pE=;
 b=V995AxMfSuKAwV0tPlxWdjaHaJC/PvIl2LXHMMFLqFCx8wtIHIrept2C46c5bIuYDO56
 vG/CMgDpEq9Y0FuqU/TXnxsuJbav/tLrru/uv65SZwZ00y1wJ/eCf1OBXJFTEVOwiQDF
 4JoIyn7rvmA4GFiqAm0cmqeUDY1SMplJsBD+pAPnjIcmISsNWhrI4s79dq4uyGlJxNop
 IxEYvuztoHiU8ceWwwvIWwexa+6NFd6lchF7dcW62RZhs9XN+pnJdgBk8Ka/pmvQRP8N
 uoG3tJIF1XG+nIIli6VWydMpL+k/Xkh+xSnU/jGJuLElYpXGN4QPBmnDhJ15wBYWq5rP XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejr021471;
        Wed, 2 Feb 2022 21:02:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itB3uegqEGCqwiLmbF0mhSJcXTCCAz6czY2kYwLA2dzqrL2zurhvUGW5tRD4J7JV6a79NhPfFjB7iKvL25CSyTN/5xCGdjs9763hCLdJoJisbVXr7s9nh/zDg95KJZaUrFxx1/ujwif08jYcub/zF+qwYh5yLcJ5vBbENzRtldVuNejKIuvNYfC7reK46MeEob5Th301tPvWA4fIUPPg9taXEiq9s5dm/r7swxY3Zy0GrJCett2pMp3+y0u/oQyKcJOM2SurgBC44TE3Qld7jb4kOWgAkzJ//qARXVOXlZeAW5Anh6YzHJsUpA+SjCNGpaAWnCA0Zjj1SiAA8cjHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fseAn7YO78aTwAzJ16qHietl5vUI9fSQponEomcd2pE=;
 b=ewdo3BOAlmlXfMtnao6GmFgNLqLCC5AlzcT0Tshd/eqfusze9CFg7UrGvjA4xA3Q1vQfY6mMqSkVBuo8aF7sxM1d1rLISimgOxQpbKlKgBVetDXuEEheNL6/h7CAbrNokXuvg1PsLpu4y1XznvwrYtIl2M+tkSqe9DQKTyq/3/bgkZWT7CZ0/TnBvO8A9ROQ4A3gWdk+DfbM0iFOO7sChGuoeViLI6/Kn8CsxXiQiDpz2+r1HnkFEsZWbEkIRUYvPs1wRGsqzAbO3nJuh1ln3Wv0SNwTypU79hwXAPZoUheZZp+oC17W1PZyaj3ZuijC12g7yWXMaxKA88v8QCeT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fseAn7YO78aTwAzJ16qHietl5vUI9fSQponEomcd2pE=;
 b=Z0VQfhXAkzSxKNQw4INIq7DR2LjQWNnr7bcsMj/Kd5TVRSiaoPOYsiRZXwyFl/qLS1JVy9kt6U+K8KzpqmG6FCLCnhL/qaCSoi+mneRb+VLkCkxb3BibT53TjZJpBcFhCDiBTAzaondpdpfJVRBK67qFL7HR8ImXtjVNxUlRIQY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:15 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:15 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 6/8] vhost_task: Allow vhost layer to use copy_process
Date:   Wed,  2 Feb 2022 15:01:58 -0600
Message-Id: <20220202210200.5235-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202210200.5235-1-michael.christie@oracle.com>
References: <20220202210200.5235-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec17e43e-9bf7-4cef-d96f-08d9e68f4897
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4014EF3DA35DDC2222343896F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v64T0e/Ub413C0nFzhlcErFS/sPmE5nkVH0/avL2lht7WW0SsiVHsc4fcVegyObR86fPYOEzsUFvkNQblQoSpX/2BEDggkJNZiLoWmXJ3q35C7hr7IZQGW4s1V4Lf0BocZfAL30aqvR3iw5aG8oaFRq6joBYNcmJXapeSrbDA+l5Mxi1ApoeZHXd1jYlR3pw6uHJ3Pgzv+DdzLXMVjLws0KIYvOX2fGByRVrPdmPODxxAElZPd1PPj4KricBV/OYO1+S1MW+mRZ/KyNSzd3QUXOhdCaFdqiyyb9cwG8yoVGB4kZ8eq/jUC4upppcMX2ZIiDFLgXsMJ30NcrckgFjzmELxYsKo7MJq6P1rvkpmyPYrr36D4TnRLT6GAZGboxr3jCUrdhWRpO3xtdmphKz7+0TC0Qe+3E7dQaerK7+LPiSoRK/Mabdm1tW07SuStzGIBzTyssgKc8FGkg3RkUyy58OMASZQ5Sy33rIX+p/3BQu85/s9fbUUepKtyaynkSGw5bCq0iNxpdRDuW+s1iz5IPeGChR9kNukwjLmO8v2C7q3EugeyHoL/1LL7wz8NmABsUfX8CKbbP7BlLamPAgaSJsXt2zvzZV0hnwphcZYg+Cs/YLnes2rAMgeT4OKScCyXLGKfBLUiDRFQwsSm1FVbD6kYFIymBhcgijGUcw+GPePaw51nNqNNsS8TvLySV00wQ6hcgUJYwGD0JjYeERPeklSLYvZmSMEc2Ui9xwwiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(107886003)(316002)(38100700002)(1076003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LOYltyNLTn9EjrEjcvXxALAbPHaPN7kWpScVPWTy31zoExLj3HLDVU6H5e6M?=
 =?us-ascii?Q?x+rTVfVkmpK6yHtiWg/qOErTagRnPH6ieUgNi8k6i61eDVos5DNMQrgyZ5Nw?=
 =?us-ascii?Q?msGFQrED+Oo0F1pNXhPK4mNkyu7UuQf3dcSu4CxoB4W8JyGOJTYknFWU7Ag0?=
 =?us-ascii?Q?FeIPHM1QA47YzjWnZ3opPQ17KKqzGAqrhW//8N1xjjMXBjcPCr8QbgtRzdcN?=
 =?us-ascii?Q?tuZONSMteMZFIu6SmpGSLbPQCrGLBDiU5SpISHgMFgF6WmfFe6bwP7TaBdej?=
 =?us-ascii?Q?IHQ//aAAQVjiJm8dZLzZGfya5dkP4Ec8tdVPMkpVj4IMSC7wXmk+JrKKf5PM?=
 =?us-ascii?Q?/elCTzhkX/m3f2tBGNXaEdEjZQHAt6NjS6/xuq3cl+8E6zfCV6q73o08/dyE?=
 =?us-ascii?Q?NEb5C1P/SnTaTYrHcBmPHVc1Fgb43FPP0Y3HZAMwzeMwNoHUdHFj2Yj9wHuG?=
 =?us-ascii?Q?3s7ac4NfOzT7beM2RxymUvrNOjrNiqtHa+X93dvA1xJ7oZTnHt3Ga3WGBj4j?=
 =?us-ascii?Q?FiSY6ZK4UJm5vhZrOekjDIa8g3R84efaZTxMgJtcY0YBfl1mavE/RwnEfL7v?=
 =?us-ascii?Q?2GCHF7EPBqdUROL5Xhc9c2IPDBQLhmzjwmHBTV1tLEmGCURauMQqLzmC1tS+?=
 =?us-ascii?Q?d+sOksWqAokUUKFXHRMUgCLALDpm2x4k3XTHNhHc+qpt2FAvGdVJCCONBpoM?=
 =?us-ascii?Q?Bv3CoRrTpO9bhkUcJUhZtiYTCFytdYPu13bdas7n3zN37SsjZHUldTTw6Txx?=
 =?us-ascii?Q?sdAdyM0RGLewRP2FpQJ0w21E9u9wR1LbqwGyeOHiTXgasHA8oR28IHJPIwZ3?=
 =?us-ascii?Q?wnRgVAqq7v0MefSCR8GeOcDLiCKwiJeM4JrfoP+aiXcwolBa3vOg/Wa7a5NJ?=
 =?us-ascii?Q?i8DJjQ0ZKXKjOPH/wRX/0LXpg0ZfraKMLUJSK97GqvRPqL2E5MIZlJUSK1TV?=
 =?us-ascii?Q?0/aecrYu/3rYXGfM2x1nM49nKFzFkw0o9jw67ldm1IAkg34FKKU0q0/aqsCn?=
 =?us-ascii?Q?WcHHK2Spqj6OdVt2RxJyj/fvfnbAub553wdDTo06aHXYvh4J07WcXUCC8+Md?=
 =?us-ascii?Q?T8xyeZlFS7iwKxPIn73VVGLwgOasOVKOhjY9n0Tfg5OUJmNbF1RlR4ajTEGs?=
 =?us-ascii?Q?RtALoSpqakjW3qWikb+oRqegyqHqghiPelH259s+zrHZUBg6GHHs9hBavoZT?=
 =?us-ascii?Q?6jplKhpmCqOQaG9JxJ6vFU2qroEBR+qPrpoxO/aUGdUUJuhrU/+azNLWmdxB?=
 =?us-ascii?Q?6CzNvb6N+XGPFbWEl1ZYFqVdodzokyAuRrLo1Y1+PHLQlUwEt7isoLkrpchB?=
 =?us-ascii?Q?FQzdPsCM22w3mXZHBdyK46uBquPc0dx+kfkvMOxBTjIE5eD1ln/I8QR1FfJr?=
 =?us-ascii?Q?BM+WuCzjrijZA3CKMmgFz6et9eb1EzaGwYJmq+ncjFSeP/Rhy5Z52nBSO9dT?=
 =?us-ascii?Q?glh5oF9jTg+Tz7LNmrTVtZVCxd48h3WkL0Vb+5aaE4qVnKx1ERqHY7ukBtyc?=
 =?us-ascii?Q?0EKKxn3DyfUzV7LvLuQ1Jm9k3AOsTQfofhmQwSsIbBmWTRYak7pWfyCjTlzF?=
 =?us-ascii?Q?pADi1ZAN04m8IIVss2BxijZmt1JMg79jo0aR6d9EtQTdBKdTswoljHLbbatk?=
 =?us-ascii?Q?CcRKBRK5rP5DiyzgvERcfJqLOyEbWhBJ9s1pjY5RuaPNbE7zKE9hA+PmdFcN?=
 =?us-ascii?Q?S0m4mA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec17e43e-9bf7-4cef-d96f-08d9e68f4897
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:12.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /W1/tg6VGHK/Oc1Yc8zPnbVF6l9ZRUGFr/IghDTU+hS5v8mT0bhoYImo0/ss8KWEDJK+pfGRxVq2ZuJOtzAyJ1q6EuXAWdJAwlwniHgFcv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: D6USeyZKmyrwU5tFp-ifFTeniAwVzBAY
X-Proofpoint-ORIG-GUID: D6USeyZKmyrwU5tFp-ifFTeniAwVzBAY
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
index f41088418aae..0d595f2ef4ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20464,7 +20464,9 @@ L:	virtualization@lists.linux-foundation.org
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
index 000000000000..cdf875617656
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
+	vtsk = kzalloc(GFP_KERNEL, sizeof(*vtsk));
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

