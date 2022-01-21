Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2750496568
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiAUTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:03:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60612 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231483AbiAUTC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:02:59 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGwj0a008912;
        Fri, 21 Jan 2022 19:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=oeSOmWuDBI29r6r4mI3BZwL1UQ6aiLLeNtSNU+hkWwI=;
 b=mpykteVHVtOxauum4yfQCFz+lrQ1H1LUg/uksFZJHcHtx6+8EjGbJc23ZNjFEGiY2TTB
 CM+//FrbKoUsH4wSMykhVnS5mAj5cp/6bGWAVtp5xcZX7xUaZh+8BnJAM4+d8jIrylVG
 rXSdzXWIGbKpKzhNTdVTzBtIqV3xf+JEppL8UMplovlIQCSrj/0uO5x416pTTacOTngy
 UmoiF/EBvJLjCB2w2ST2hwpgsug1tv5oPzyOuj87ZlXWRtx92UtZSGnsV3K9awYOF4Ig
 987dQbDbLZy0Hb59s9M3k21j7vaTfsJeb/6dM4f3mYZ4GYRfkeXf0DQutwVXWmIgrXh/ kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9tbh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJ0Xwm184157;
        Fri, 21 Jan 2022 19:02:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3dqj0teu39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8f4C+nE0fe11lXzW/hwFHf9IuwEmVCWHKji6uUQrblyA6gXzSlhTpy5NA8fkiRWgEPKFKy3jKHu5nnqCAgxn0CFMUHJBO9gSIM4CjSC7pz4+IFOcbXtDY8kS/0S1TFqc07L36GuIV8xI1mdnc9A0kjay068KSzmo2Ztw8kXXqOv+nNvpdmDIiBJVkPGTg5SVTzDkoRcosHNZscP1fSOcTReobxCUhxevf6hVYq4O+lUs7yDF/02DgMXT/lnIKzP8rqIX+YW2nTWQmxU2n0tZMqfYkyHkLowcvdamuwrZBpyFiJ9Tgy7IiubfTW4FB2It3zsXGDQ5bCXo1Y1QQ/FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeSOmWuDBI29r6r4mI3BZwL1UQ6aiLLeNtSNU+hkWwI=;
 b=ljyL/LABZi81jpMysxY2hg7cvsR8G7GsYFCQnlp3SguuR9YB+2wni/LmsxIMImuVup8jbd6u/9BKgetlsvMkYlGxhUoSFSNlTDRDokziE15NLkjoEXyqywaxKuFsvaXK9FF4QRJn/l+W3kQGZgqiNUMd2BPwZSCG3c0BoFt56j/HbcuytnWZefvSEA3KlYORZ8cjnwxjN4lziL9Yyznw4f+jlQ4yT+1wpoKXekzQVIOGR0S2vHXv1LAdaXi1IWQw/sDpZjIv0jdXmxFvjOuqCtSkC8N/aI47mSiVTZrFVeGwGr88dy0NFVaZusQXCQv+Gb1jiNsERc/Jme5EyJc0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeSOmWuDBI29r6r4mI3BZwL1UQ6aiLLeNtSNU+hkWwI=;
 b=Ok0kuOlySMPG68292/zQo8b/ucqtfe7ZVTeV2ChlnTQTMqpjD4ypdsmODt/z2XQF6+orFTR40F1xjmOuDAITWYJA83tfNIivGQKkPuQAnj+Y+oJDTIDMM42+sbAtfF99yvVdWsmffk1ve7jJ6fs7Crbblre5EE/kYoRn5dFPkWg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 19:02:35 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:02:34 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] printk: Avoid livelock with heavy printk during panic
Date:   Fri, 21 Jan 2022 11:02:21 -0800
Message-Id: <20220121190222.572694-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:806:6f::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4a1600-ea23-4466-278a-08d9dd109582
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34349561396CAEA09EE3EDF1DB5B9@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUaxdHvk+cUlRByu7H9aFAwB3t9g+Pc+iZjX1/YL/gEngUsy3aPjPTXa2QvlCYhF98ywIYRxEb9ByxWjqM3BoBZzDIbPHyw//uvQj4Jo2bhXxZEC3HJzO+6dDeyydM/0V8H5ikxivBgAHUuFU7BfaEdw+6cJ2RiZZkIK1zbSyy4QKHK0u4CVIiVbTR26iY/gU+XtB+kA1LmbtBBq3ez6Mhr93LE7STY1QSok6NimXK8p+ZeG+2mb8VAHRaF46Vk2iaR+pAeuccWsBvDqtQ4a26EYMJ4uwHu2vBmIgbfYmGvMf56ETjlPo01ywaL2pMd+w90QzxmEBKe7s4/rYZOjG/jD/rfL/iWCpzAZkkEu/OuhJDhQJuqQU8+unaQN46VR4Et/wquhuSivkGpUoYokJBeJVtyKshYVJIe53X+KYj5m3VRsbcKQjJwvQuHO3Wnn2Uu9BVCEhqKfE15xQJcRh2qcIu4kZlnjXy4nMsRaKN9kB9HNKZgz6wpudcFc1k1+Htdpbx7PQXkNSAMEKouGKUPEz5IVwoyE3rvV+O8cRCVAZtPa5FlSEPBTlRaIlw03lbKPgfJ7onhOGCA0wQ6nGoZC0pVxL6fR6M3tUVxxn5bJk/0N3ztKmgFgrF8KDR+9Q3Wzo4GWQ06C4Q5BU5VrCXgLtKmAnhSCo4QI2m1WIfDXL3wejpdjKBfYlrLx9RPTRcqb1QmQ6jAcQaxp6o7NKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(316002)(8936002)(54906003)(5660300002)(103116003)(8676002)(38100700002)(6486002)(38350700002)(86362001)(110136005)(508600001)(6512007)(6506007)(36756003)(26005)(83380400001)(186003)(6666004)(2616005)(66556008)(52116002)(66476007)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGXlcd4DicS6bIVlrx0TnEv48qPvz+iOb07PL3DdWvT58DZjIMR0omDEXVkP?=
 =?us-ascii?Q?H5TQqsHI5cICO9lfaeFS5ehW48db43iRmQOsoROnwfLD864Qc/smfodAL7Sb?=
 =?us-ascii?Q?GaL+KBu5IHg1/2D9+LSwhbIrlt7FJvXPtrxX1uHhy83pwDZ0+MoXzniYov1l?=
 =?us-ascii?Q?6khmu9/d2vqbbTgVP6qJnrADcKuGdDgK/DLkyLAbznn1vrKftMmCiAQH1+GA?=
 =?us-ascii?Q?0mFua5Og8fyg/ahli++Bpflopp6aQwB07NFqogUccvDwRGaaFyvfx8bkpIXD?=
 =?us-ascii?Q?cKZQdvgZsj2CamcF0Yy0UWrJiSYoK87ytN8HIcD59qvn5rpAvaUBS2wsDyyL?=
 =?us-ascii?Q?fmCQh0Aq79ODmwDaXG4eVgQcl/JdqLEMYD1GrgM7GQ40cSsGI+59x9iudExP?=
 =?us-ascii?Q?+inOJbczM8Nqzkf16pzEBfpBaZhK7MwivXP64MYgX0tKQfjH3UbKiIphjbyh?=
 =?us-ascii?Q?teUco86HUd6USmI37lbmekKEYDpw7Rn42qivOZZcsKxbMiDKRiBkneHC72Qk?=
 =?us-ascii?Q?aRxINFMN5wAKZvl314VOVi4tpgw73Y5ys8Y4d5qFh+jjlU5vUlOOXPFo1oPE?=
 =?us-ascii?Q?0u8MQiqIPAJ3H1H1yB3BNb5u4a7Usmk2nhiTGUBThkMHjOEcQjz87SpmKxp7?=
 =?us-ascii?Q?zIkUi7gw7RjnZmphY9VLMjten9NL2qkIyser5WAgLCam4QmW/86QF+wQADM1?=
 =?us-ascii?Q?Gn4qqKLCky/av0fE4+o7ntOfQu5eSdJ6ybcYizzvUeUqFDaqDb+qh4wCKJPA?=
 =?us-ascii?Q?xCQrwUJbtn3fFhctW/uAhcZvR7YuhqR9zCeHF0xJ4yvvTuHMEPUk+Z3+pLC4?=
 =?us-ascii?Q?oVkUeVbTfLmdGc/akX4PR/jQ4IeSZQohGqIZsXfGYxCrsNBKujo9bgJIUdO1?=
 =?us-ascii?Q?UUKUVHsbP1Gc+jp0FAEQV083OskOJV8GoN85wjVVL3J62fh9+8JSF0U9fvEj?=
 =?us-ascii?Q?Zbv5bT0Fw9xQcR4E7cQKcilu5cOjkp0Z9rD4NoxjNF5gjUC/QJduY1FO8lah?=
 =?us-ascii?Q?hT1cRdfQ/8BaKXHWSAZIPoZ3GnFumzSFw3Shm2nQpVS4BRIDlQhbYfscYwmR?=
 =?us-ascii?Q?G1Rdf4qlDVX07cCZuw8AKuv4S1kysoiUn5g0qs/+3nikjsiPVPPhkfK+WcdM?=
 =?us-ascii?Q?BBKKBCUp29SYIdS24BReJOpWVYCCzwmb8lpLo0HBYcavHYcO0XsAE1bZD+9t?=
 =?us-ascii?Q?egNWJgcktbxo6cMaCCn546eLWxwX3mCtFqxCdksi7eSnrLyzQZ6Vww6xABbB?=
 =?us-ascii?Q?uBFPOX34NYn3G/2+W7zrNGZ0mt+6bM62DNTUD3my4wWZDA8qYHt2NH/Cr4/t?=
 =?us-ascii?Q?+SuEyFK9q5CQ+oiCnEcpIgMLorD/56k9sRqgItUdTuQ4hRVp6uHlW64XsAEm?=
 =?us-ascii?Q?Gj5123dkyv2RQBxVaAhyAGqgH0IPbxe2Ng0dGvi9ucJB8Fztk99u1JenVQGD?=
 =?us-ascii?Q?hKqFnndl9O0bar8N6zL/G1/Zi7zEb/ZfU0TIRhnTuatAY8sAnLBv/H5fIqmP?=
 =?us-ascii?Q?jfE0PfdiNKxST6I4YrvbeN7ssNb58npBL0rbqIeCDMYxGcMMMdmxNRO8IIpT?=
 =?us-ascii?Q?T4RKJn8s1etPQXDijOVsPearB8NuKC1RZdhwRPu6OoS/yJThF6WZPEjliGvB?=
 =?us-ascii?Q?6eehUt3ZdmJ0x+nPZfPOeNduVwkhMZyzvyFlQLdgNy5YjK/Ynm4AXyA7FBIz?=
 =?us-ascii?Q?qeupXw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4a1600-ea23-4466-278a-08d9dd109582
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 19:02:34.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsc4zBIH8tNwwbo8UIEHjRM3DP9fOMRiPMcPN3d8ElTazEkt3IefUzKvJU8+M0n1gpJzo4M+HNgfzD5GnUkGglRV31fxlXmR4w2M87wIUXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210124
X-Proofpoint-GUID: DJKxD6TSlBX9Ytjb6oB4INJRS9OZB_oB
X-Proofpoint-ORIG-GUID: DJKxD6TSlBX9Ytjb6oB4INJRS9OZB_oB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a panic(), if another CPU is writing heavily the kernel log (e.g.
via /dev/kmsg), then the panic CPU may livelock writing out its messages
to the console. Note when too many messages are dropped during panic and
suppress further printk, except from the panic CPU.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/printk/printk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 20b4b71a1a07..ca253ac07615 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -93,6 +93,12 @@ EXPORT_SYMBOL_GPL(console_drivers);
  */
 int __read_mostly suppress_printk;
 
+/*
+ * During panic, heavy printk by other CPUs can delay the
+ * panic and risk deadlock on console resources.
+ */
+int __read_mostly suppress_panic_printk;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -2228,6 +2234,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
+	if (unlikely(suppress_panic_printk) &&
+	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+		return 0;
+
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		in_sched = true;
@@ -2613,6 +2623,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[CONSOLE_LOG_MAX];
+	static int panic_console_dropped;
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
@@ -2667,6 +2678,8 @@ void console_unlock(void)
 		if (console_seq != r.info->seq) {
 			console_dropped += r.info->seq - console_seq;
 			console_seq = r.info->seq;
+			if (panic_in_progress() && panic_console_dropped++ > 10)
+				suppress_panic_printk = 1;
 		}
 
 		if (suppress_message_printing(r.info->level)) {
-- 
2.30.2

