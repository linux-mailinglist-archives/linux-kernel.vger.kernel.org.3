Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB84A79FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbiBBVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:03:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36512 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbiBBVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwocC024834;
        Wed, 2 Feb 2022 21:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=T3x0f6fqd7fsm18zTd80ylnS3LNbr5ZnTsQnxtmUV43K93nIYHKv9ARJE2ixkOEj/dng
 iiDIO36oRaFdriEsJmbk0dR/kt+x15a38eXzXWzsy3C398XgLg2aMEN0MjuVtosH1dps
 hS6nPebmFe7DYg/5MDlsersBam6d/Ax3pzWvegCsmnX28htBxrup8Qi9gFYk9rN7i2n+
 qMP7Cg6LexCEG+oMm1d+XpQByNa8RS+evkCzls1H0Mj3A21JcLirYb/qbmEgKj2t8xT3
 oS0idPk+1saZx9u8mTxhmN88QO2CCveLnmZKEi9RC0ia+dyXSKDBhngBNQTSTebVUsoi fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatyf0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejo021471;
        Wed, 2 Feb 2022 21:02:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHtxS9TAZ62MPvc6i3cHKHL5ZHMRbv/pWb4G5uFDazSa/vxLik1WpVUsZVX8VSTQzBXEhZnRkXmdCTDTXzhBcoHDc94pXSr60A159h4IFnKjTFTujMaVckl4E+jPP5cs4vGWcM89OfPtSoLdc2PmCLKpu1YpdzD5kimSOpwd4JhxICQP6zQ3OVzFFGW13Ari4aZ7ANI9RxMqsp9QxDjQtkDYe1HTqDmTRv5hGeeMtAxabuwOXSFB8OxwSyeUh1sgcBzLmur1TjBGA5iqgJljo+T5TjrKCOQxnjnN6DLQgbva5SdNwCDi+O5egJOR5MQP+ViAUgDWI0ZcdwIdcJHmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=gWE6nRWiJN4JyKYwLevXanJkj67NxrK+DpX8l+wdFBuM+CkWm0n0NE8hT0FD1DC5Z41y19Z6NZhj8b2cWAb18SgnCYJnqwlEpxfg+NNbdP2ysVMMEEG2dVdBjEUKe4D8r0RLFD64N9Asc8U/bOb/uPr4GnWmZyfo630kn/iKU0h8s6wyIZuwBexnse+ReK9pFTOK34+La0cWQZaba8i5anxSp9pQ52f53nH1BCU7XZy8LwkLjBoL35kdji+FffgkpLuXtiAPlQkQJQI0uUjJCF2lbX2i5vS9MgJQjI98E0MS7bDNZ2mQFsNYNV1bXWTO1eO6TZ5zIw5He8rNs3+Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xElEgH6bcMjxMOndqXAbJ3z5HgjC0FhUwvkQXnbmQM=;
 b=vml6m3vXhZbp4Gj3AP7RxrKgN/Wab2mjOsCOnH8LAlh3pi9vFybLEXaRbDyYHEugEQxuZbPJ24n3iLNqxT5cXTTXcGpafNjkp4SEPTKLAzXZMOOYPYoc/nQ7dLUxF3Pn9yTWoccUIvwXfjfFiWwMSdZvk4jZaxOrx/9jgMacFyc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:13 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:13 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/8] fork: add USER_WORKER flag to not dup/clone files
Date:   Wed,  2 Feb 2022 15:01:55 -0600
Message-Id: <20220202210200.5235-4-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26e1d168-6f5a-4d85-111c-08d9e68f47a7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40145F53135B1F11B6A230CFF1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MebAe5OAcUlMXFVrgZEIvF6siH81Gc/HSZm2Vjx00xLxK6/ln7fT08/csE1tzYQxiyJsCR1i3g433xxVXvMElIk+9zyvBI3N9FuW0GSFeoLObzvBCH9IxMYM/1goh0jhmqEDqaJb2KtZxLO9JKe2isaI/hso+mxqCpOKLAyg0sgztwZzkWUuN/uiRA2tTrkG4JGNrYoj1Ov9ZEUAu0n1prA8SefZ3dcusJnS0GZUvcWtY+gW3Pz7VXsmUT7l51+HnviMFhjyQWO37KKQjISBg9kjbBaEHb4K42dd2BJewsMluDNYwm36bNPT4hh5SoVggFcz6gDjtVpwiuyEF0+ZZkfoGa+B99BWO9s3wE/ByLuYB8cRPzBy+jje9d9lgK+m3/Lzy4CMCjPPR6f47PYmOFRqg702/zQBGj95YzWhaq/GRZdzKT04NUl4kqFUSSP8E/JGrIHq4Z69X8E37AeJjVZgC34zM+Lz/2s29VKdf7XJQY0tr2j0iNAVMqG5+YsadNNN5UzRGU5Hc3/0Ns/YUu3Q/yaVfjEUE3Kp40eZWKEDZe05funISiE325QLdH1GcfIK3cJQCkvzY6fjnWP6zqk7CjZVGEyGX8tJwEdmJnKoIMGxsKiFLCIlzAs05cYr0bQC4rfcT6JWRdLR72I9QAzUyBh4gHd1nHIQSzBfcrthuitXS+i4Bx7q63oz3nchrl8hjJeqAYQMNOS9ad6HxCZxZBC7jqiCmoIWHsuF2mE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(1076003)(54906003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMkCn23j9Lr+ZLpM/x1VGunVjkC+3mzz7QuDiEY7GNnPY0J1S67OFPT/oA2y?=
 =?us-ascii?Q?oXfo4cnTw6KX1re7T9WbLFx2aanIWrihKZqgLaUgZe6R4PF2yOfitaNbwxui?=
 =?us-ascii?Q?Et8+3tkBoc+gRoVQhgdzPnegixCCT45eBf6Q4dbOm5XQGJZy0+3N7VG6W3IK?=
 =?us-ascii?Q?idhEdpJyMHcBHAPFTZwDxgZR+rcNVcKHdSgOXaASuPO8gvq6lovNY5u1F6la?=
 =?us-ascii?Q?VAgsw5zy7dOisT8lkNUAvm1z7FjU7p9FQukloGCPijGTbySL1zgi1MyFNNki?=
 =?us-ascii?Q?vIdvRKqJZHiKtxyO5Kah04bZA3TxzqzKayOcPbFBW6ypkW9cPNcvGMdXACnT?=
 =?us-ascii?Q?bSGU5Sf7qx6JtNhC83Jc7E9cCMQUamG777uaYGKyjrfkpbkiGMn3Y2HOs7Ur?=
 =?us-ascii?Q?ASsOJI6xAbVdI9rqV5lSee+naLYuGTyLIHQB5sEemAT1kCXWZeIzLx2rsBuZ?=
 =?us-ascii?Q?EXQeqML3rkBvT9e7PdyLDxB7FPrKGuuo54YQLNKAYZIqAYqICIPefDixTjIj?=
 =?us-ascii?Q?jbj1vcmLmt5KP0JRsckdpnstFvGyncsE0eT+ntIqnIjfr5LwHF4PNFrbkLyG?=
 =?us-ascii?Q?Upu2snS4PhD25xrVbHJBIVLQ8rsqOz7GXASgZFzoSrPP5VqC//viBLLzXTHb?=
 =?us-ascii?Q?4gnAMeEimo+j70iuvevHSkuKPjbDQZuQritMlKb+Vh8pmv5aGH61Db1uTCu8?=
 =?us-ascii?Q?ii2wbRO2gNq42Juk5H9dSlI8oaUAgWOCq6BofexOZeSSK5B/AKy8FPZ0xamz?=
 =?us-ascii?Q?LCE16lDcnnGjzbRIUR3Vt543deJjfmaqhKsKP0NPLRCyLRjpRox//O5rIZ4h?=
 =?us-ascii?Q?p3jsdyCrAVuAlyh/ltJ6YYC97DUXcfJDBzNjpcRXdmbHalDuy07bbpuld4A+?=
 =?us-ascii?Q?l62klbuBoIqbJbjACSq8UFoYAEE6+r+Nq+/PiQ9kVKht7gbMhs4rHKk8ueOc?=
 =?us-ascii?Q?3UipeWNcslEeVn9uXat1KXc8EX4qoEw0HYHA7dRxVag56N/SWf4/b8xZ8g8n?=
 =?us-ascii?Q?0TiH9/qR3Tdns6MxoiWEW4y1en+Fkm8IgzUpPs7KnbOidWgYbsXXmhXH7WYq?=
 =?us-ascii?Q?U9bDUuQhHcn8NmCSsIXpu6ua4zhUMPgDMYpHwbhbk1TnwidYFIBhz1JzvTjT?=
 =?us-ascii?Q?NMqa12gGNznL/XSqKDkUqyV1i4S98yK++i8RXkDcHIsUowcRTCPVbHagDcHH?=
 =?us-ascii?Q?SfewryKSQ4pp85zYH4OXxwLaxOeKkRiXK98f2cvyfrV7SHG3dDB8aYmzcj9e?=
 =?us-ascii?Q?IOATgcM1KrpHX+llkJKq4Ho8eNu3MTZiIQ7qI+gaHI+dxVswiTfwzc0lI93S?=
 =?us-ascii?Q?BK4G0MaNkQ644yH6McAA+SH8sZPjq01F8VGqo7uiZh9LD/BfCYnTAu+TSpuJ?=
 =?us-ascii?Q?KXhWQPaJUhfo2fyudV9SK+rrIFkFGQ7/yhq9XJvJYW/cncnapw4MnZpemBDW?=
 =?us-ascii?Q?6BIOZrDRL72ccgKExi/ZYDp61TTCw4ayBZ7t5RCJ1uzkrJuualdUdLvdcofV?=
 =?us-ascii?Q?CC+qSCacPXZaFqkRDz3XWrIAJJLkCJchEANEvA6Jhbdr1LzuAVbCFiRzHY4x?=
 =?us-ascii?Q?+2cXpRKYUYbQrYLF8sVBKBB8HPuMUUWyBmipoEDYhMOTdVii6btgQo9tAsUP?=
 =?us-ascii?Q?KcRpbdSWWRsVIw7EMLHRX+aq4fEEKdQ6zVTmE+85vA65TRNGs7KjRf2dkH36?=
 =?us-ascii?Q?KL1Ljg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e1d168-6f5a-4d85-111c-08d9e68f47a7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:10.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBPxnrgu7GZFBjl0cUoeCMsaxaxxWYIthwAyHCg5/K0EqtpoNh2NeEFNhTggfgLg/tc/FbYVQvHzlPOw3VGCdIIU0Tnfn86IWoccV5z9txc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=962 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: 3owqIhtDMD1m-QNH22LgCSEoHioPLb6Q
X-Proofpoint-ORIG-GUID: 3owqIhtDMD1m-QNH22LgCSEoHioPLb6Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it creates a thread using a helper based on
copy_process we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0467b3ce1c94..706ca3dc3423 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
+#define USER_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 1f6e7184b31f..81a1096d6ee9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1530,7 +1530,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1542,6 +1543,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2153,7 +2159,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & USER_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

