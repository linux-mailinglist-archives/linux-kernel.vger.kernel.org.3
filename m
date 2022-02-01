Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05794A6458
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiBAS6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55140 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242126AbiBAS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:48 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IEVGR009491;
        Tue, 1 Feb 2022 18:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YV/NjcPf7GM9ZMBXXfy2+T7y/1bycMjjgIPsf7t49uI=;
 b=wpIER45YKPc1m5PKQLrqoPsPw+D0r4mTo5EPXkpUt5iweTE01BPabbo4fMobyzGYnT87
 mncRF6T1xtAqfA6vjJ/GXNNjVmJILOSWqNoZOy0xby28jrJoaq/kQiUXvVDNUadFochc
 u1gb5N18PN0E3lqh8dMSTGbu4TmSadkL9TqQdUXo6ggXrXsSjoNqA1Wa+LgTOvue6FLf
 V6G4TydM/N404XCChOwb1bmZxsHFd/ZjA0d03pyrPkizdIvVL+vca0YpfcMwkTkLdRE+
 cC4PiEsxb/vN8Sq0hBMt7ntnOdwY4bDS+4nT6eczb6FkyhDAh+GX052H3vmv5DMKHpRg Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatv0jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211Ip94R162610;
        Tue, 1 Feb 2022 18:58:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3dvwd6qkcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRWbTML3EjVJUWkO87alLZ9dDT/7uy6IiKIRm05yG/GCES8Awu9oZNJl6epLKf0oHj6WM3B4esY8sMx2m0jQ5rxrnBf8v6a9vTvJbvK8LnCu2Oh56+dIgyFRq8C14vtPzQvNRflE4Hkp9Z3LvmUhQ1fTvO8p/VeqUR/tjO4e6VF1qLqcIX2x3GWM0HNAAhYgmF7dRR+kPXSG09AoTKKd8XvPTpxcIvdxvryIWH3gvf3rcWwoFclG+nhSw6MBZtIkNZq/i+CRO0qVcWOJExHNpdQCBVfa8h5jv9tKTTV51K2L3hj1lVbQDQsAhmU1b4QaPp4UjRLtWC8beKmkzcVLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV/NjcPf7GM9ZMBXXfy2+T7y/1bycMjjgIPsf7t49uI=;
 b=G92y9FWVZdf+CzJmDwoY8ZIs2HxVeD8weMFahQX4dZjVQItVqX6Ks2Dods2xlVRo1hvls/tapPUoKOfPDEae4HHO+aUr7wWG/eWBQUOpaATklpoJ1sV14oE5fn3jb+GxQEw7U8/SwMSB8sdje3zurKCgCBLewIRxgDYJfXquON/v+7ugUYKOgyBFG3F7CEuv0xHVif6wxVatXYg1zK5Ex86zqbSs6HZb6nD2Vw7vcEEMfNXJhsh2p8bFI2UzsqmaDqzYGq43fwf4+Bs05IFl6vaK63/pKCAoXGmijLNteCWSwginSJR1ZYmvzhskn3pgN0wQ7NuI1CuB+5oMg0xTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV/NjcPf7GM9ZMBXXfy2+T7y/1bycMjjgIPsf7t49uI=;
 b=D2VU/3op3brsONLlROHJEutHIKQNH7wsOdKJolkrUwSqtsVcv1pdX+Hi7PvqqJoTtHLZYtDUKSOnDvnrdOoLNlYG4SMmu7YCnobp69eov8u2glDhmPlT3rSb7iKpxx7vBU9ROjB8jhKm5t8GMnK6rEmcwFFDQyufZpHNh9qH1qA=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:58:15 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 18:58:15 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 3/4] printk: Avoid livelock with heavy printk during panic
Date:   Tue,  1 Feb 2022 10:58:01 -0800
Message-Id: <20220201185802.98345-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4587baa9-634d-4323-03a7-08d9e5b4cd46
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5156788BEDF1FBE488F8B096DB269@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ks3q5bhTpdp0iIqTk6RkUkY4MyD260B2SncdIlGnM9dsJWNk+tosQcfb2z1QL1uGfVDubCYYgmHPgqsHARhoGF6kErlz6x+XUeOu33KhIeobwOA2H40jca0UPFUQgpkCOA6J2ZxUXuhiI/cPE0kCr49JrfnlkU8VITrTTuWo9uT+vxcXaNNajGSPcjLErmVLdZbPMJTi0SgbBuIpb0ddQOIA3YAt4nEp5eQzTNq313ghMbCETwMK5d+2MJOdocFDY5ZeuhSBdvZXXMj/4n+XqvUf6QGs1B+0syHHssrq0JOwk7jfb/nCxmG8TITI644AUiLUQJq04DkR7gMtbM6i8QyRi/XJMykmj766HddjLF8qFMvbuX46wFikKSqRZShunfqO/dri65FNI8gtpB4w+PCVwMxFKHjHqxfvCYqWvNO2lGHPLnjvuSRPxMJCgntU4oZMGxPFa3w6XZsvLmSJKiIBZMK0Ir/7UA9dqWgvTHLmBufh6o85YX50FyUq3TjWzSszl1d61AS6uIE+ne7NmnromujLJa310n3D20xsdwXKBKAoFAcKE2ZxONX5pBEymakLkgcX6kPc7hHVimiziuJVMP38bf+t7Z1wfKiWfVaTGLVzPivcxSdZSJuntc9S95zNlZ9fosCAfdV+60W/MnqK8Jogeu/WNm5Kgry1YA5fDMbh8jFMi9sCxs3BIYtRqonZcqHlFy/STNq1Uwq9CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(103116003)(6512007)(6506007)(6666004)(508600001)(66946007)(4326008)(66556008)(8676002)(8936002)(54906003)(110136005)(26005)(186003)(316002)(66476007)(6486002)(83380400001)(1076003)(38100700002)(38350700002)(2906002)(2616005)(86362001)(36756003)(107886003)(5660300002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLyGtZyIiGlG6FP/Wl/dAMggQFOrvBk7h2EmxiDCylD68GFp/G6s5DIeFBFa?=
 =?us-ascii?Q?CNfuGW5WRdBoCpmfEtmaSUom7BSAJQp12q0dftN5b4CmVwOUM4/zm1byX26a?=
 =?us-ascii?Q?4BpfiY4EYnq7BRJ/sE8GkZMSAN5wiRg1RQ+YQB028Qi17JRpbAE4td2jf8dg?=
 =?us-ascii?Q?dElSXOX4KhFK06/jfKmix9qYI1BLDb8yexjNJACju6LcPyK9iN2S9E2WSyRt?=
 =?us-ascii?Q?MTsfTOUTU3ioX4pcvGcloBI7JeZbSO+V3Mu/mRnzV9OPJJEIBPet2KM+9Zhj?=
 =?us-ascii?Q?2hb+ZC61YThD3KtAHfrLKqo9olels95WtUdUmrmq8PSurnDyN/zEanToAMYU?=
 =?us-ascii?Q?wWfNFlpqJeJIaIaK3ZSjkR9LVwwe4Txm3xG5AdfT8grcqINr8u9ksC5dkqIv?=
 =?us-ascii?Q?pRbqU+Ijruqy7Cu+D0jcybLEucHQE7GLWkL91GZLlI0dneIPBVsWcOmCsyIf?=
 =?us-ascii?Q?/IihGEateEvOlNx7e8YJQTqIuyzhXj3S1vapWZjNQ/Cik1R5nxrW42+JagPP?=
 =?us-ascii?Q?FAnS8BtMPcDK1P4oGIcAL2VeT4Uahw08J6rGHsSkwG7UXo/J0e2wXGxPxFbO?=
 =?us-ascii?Q?qPxTF+ppGyrPZ/40utetarlWmmSQT2CwciCL5zAvKHqn1odNGw5+nRsubFnl?=
 =?us-ascii?Q?mIseS9eRC5UCyEV2Och7wptylzPPtwrPzB1q6Aos52wli8/z2irgnlVf0wST?=
 =?us-ascii?Q?kN9+8AOG5KpTVXGzno16jWX+dQUqgHwe3uNygyJweuDfGAf1tXoYghNHkQdO?=
 =?us-ascii?Q?xmS4R54usPaBMG51mIE39VksoKIYAStmBeS2v2Wdjni3a2jTCmOLbCwNYLsQ?=
 =?us-ascii?Q?kB/z45NjxToSjd/RpeOsuk3xURjgY7h+gzumIG0YKhYEJSOah5uyul67p0OJ?=
 =?us-ascii?Q?oDIr50TDtZ3jyyBSu5A6JZNSai5FWcY61VyTxHwMoi4Jb4ivKwTLil2MFpoi?=
 =?us-ascii?Q?q2LXvVgWuhz/kwCNOYnjXRKfxizA2BOJE2/0FSnOZjIcvt8xvpfsryxj5/Xc?=
 =?us-ascii?Q?kUOYQycosEbgdJi/jHNu+Vwj/QorkVbDZPB0IlMMX3OEIjuOIuvieq43/rFY?=
 =?us-ascii?Q?DqHjlyNZH0M367EbI+rkapx5FnwugScjXINlR1fONr6Hb/s6y/2eB0r5N8NP?=
 =?us-ascii?Q?Z2+tOE9NpKragjJf88rhzVxOn7YQYMlRw2lLdJ0uaf/Ad8aZMaKN/FGq5e95?=
 =?us-ascii?Q?S+wCALFP+igqQTMcWr77RwOAXzI4w1gZPrXRBZN2AaE1VtNP2z0qs+Si3Riz?=
 =?us-ascii?Q?yrOvooBrD8P2Ug4MUNB6gcSeStTbUmO/wFjMc8YRsuEXu8gvt+OKrsfW3CwF?=
 =?us-ascii?Q?SdJUkFwbc7CMrMA4WMqdhCHmFWs9tV7MBZssajuShQvH7/LqCEm6rnSHxo6h?=
 =?us-ascii?Q?GkOhQ4NN7CQ0uIvoLXX/nNluzqKHuAbrpF0f8CF/NoGas6XJTACu4oM7gfYq?=
 =?us-ascii?Q?gl4baf/oAutaiJcYzwYrc2mw8PyQ0DoqSQMcISKAoC3yNNf7EIDZ2cENv7TK?=
 =?us-ascii?Q?RmNkAD4gosDVxeOb96Avd8my+a4FtCiJ7ZN7jv85q9/ftdmKD751wds0zydv?=
 =?us-ascii?Q?rMtnd5jwGKD3MP2PpjuVq7byosB/pfU7JOpmm96yvgqriJZdSZoCHXLtcfXu?=
 =?us-ascii?Q?/BjxTobcF28Ttt2H0o3KZKWQQgce2xDbu03V4YySAuQC2Hfogt8qCGnby7X3?=
 =?us-ascii?Q?/8ISSA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4587baa9-634d-4323-03a7-08d9e5b4cd46
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:58:15.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxfqlBx9RAppKPAh72wyT/2dIhSH8K2R0Qkg3tUMsPq8k1iCZLsrQRSx7HMRco57mmCqYOEYklbotoo/8JJ9Box4W+TBsfYRPb5MJTwW5jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010106
X-Proofpoint-GUID: m1jZKStXI1DAtEQ0PsfFS_fLf5dstIdV
X-Proofpoint-ORIG-GUID: m1jZKStXI1DAtEQ0PsfFS_fLf5dstIdV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During panic(), if another CPU is writing heavily the kernel log (e.g.
via /dev/kmsg), then the panic CPU may livelock writing out its messages
to the console. Note when too many messages are dropped during panic and
suppress further printk, except from the panic CPU. This could result in
some important messages being dropped. However, messages are already
being dropped, so this approach at least prevents a livelock.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v3: Use pr_warn_once, and don't break the message line
    v2: Add pr_warn when we suppress printk on non-panic CPU

 kernel/printk/printk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b96166eea35..cc7bb86f7bfe 100644
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
@@ -2233,6 +2239,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
+	if (unlikely(suppress_panic_printk) &&
+	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+		return 0;
+
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		in_sched = true;
@@ -2618,6 +2628,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[CONSOLE_LOG_MAX];
+	static int panic_console_dropped;
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
@@ -2672,6 +2683,10 @@ void console_unlock(void)
 		if (console_seq != r.info->seq) {
 			console_dropped += r.info->seq - console_seq;
 			console_seq = r.info->seq;
+			if (panic_in_progress() && panic_console_dropped++ > 10) {
+				suppress_panic_printk = 1;
+				pr_warn_once("Too many dropped messages. Supress messages on non-panic CPUs to prevent livelock.\n");
+			}
 		}
 
 		if (suppress_message_printing(r.info->level)) {
-- 
2.30.2

