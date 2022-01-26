Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E4249D5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiAZXDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:03:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31106 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232803AbiAZXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:03:11 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYoME016826;
        Wed, 26 Jan 2022 23:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7t9nsNPOCsT6BFjau8nOqYco0RpwwaQjb1rKk3ztWq8=;
 b=k/K0tECIvON7KCDhW+22RYvtRl1tud5hrf9vKYVS1WCfdSuVbr3gam0P8GiV+t0kZkP/
 NqUDR5phzALSuWmyli7Ffl/5aSxDNjzMDJjAQcK7nTnmyUkJ8ZWy180w9Hx2GOmy9SuN
 3zGIoMSWBoBOH5VePeKBd8y0i63XmHFDSrzfbHRZV7jRNgxHurBE8f1UGaKkZXnTQlPr
 rROPGvCKUTMaNkB5KsPlV2mvFgA7sWusAl52aWsShylYmhXuDkm5CtUpatzX+ptnmv6O
 if8u8FjXHBmMP25cTiTlJINVfsQ19JAH5SiqUH6uH5nMcSsGUMwTGw9vl8OsgS11eg8w qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s7eer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QMoU8V151142;
        Wed, 26 Jan 2022 23:02:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3020.oracle.com with ESMTP id 3drbcs2ns1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti/IEPnr89WyeX3zOBAoiaxVfkJuzg+TdIzmtF100XPxkj9t7feYA6BfNraKVZO5tyc4Cwd0LFIu3/yt9GlcRUD1WWsmyhMbiC/4Uvmqd5CvI8MQj54Timn3hY8wbmHU4/ay6lMPts46x01Qo1FgKFFeIPv+jCdYaJQipqhNfbIMd23H3KTsj7gqSE13NKBiYzXqVm/MqWJM9bFuMKmOP2orMshCXl175JPJZeG2mMJWkWeLBXSVzjh6kYFEqjDGWzBCLsklC8jIg+rNKqIZOO04Bz0qMRxpzisSRh7luWma2WQDjtiCnASPkAUt9K8PrMnHIIElR+YDqHgqS0M72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t9nsNPOCsT6BFjau8nOqYco0RpwwaQjb1rKk3ztWq8=;
 b=PefhNobTLuChIfDSo6UU3KlN8PSk0MNBUhix/NNfmYBXVSEZMtMEvMOI5T5B+CjyYsv03uUiDEUSgjq3HDIBLhCKEzw1EmHAAWxtHI529wMgR+9ofG/g7YJWqrO+fkDjjEXjyi12zkOpc0W+uA/es5787u5eECc6Dcuvw34qRPDYOWvd2V6eO7kreC3OXn5osPlKaYeASsae0fEOlIhlodc5vX91drXMJblaZ9NAjD2hiIm2OKE3uIuGXBoUxUys29KwpYLBkHxkITZvEvAD54YgbVx30Q1KxfgZe+dZuvimaHIbWDudykgefht0ohSAhLr8sHEXGin9WvEwBLCtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t9nsNPOCsT6BFjau8nOqYco0RpwwaQjb1rKk3ztWq8=;
 b=c2W2u/JpP03iQE5Cpq5F4oyoAr4nQaXjZbDYTLgbQJxoiItl0FP+EWGlMSxujVLMdYVIXB/+WHawUx9JYh3GC2Rc7Z5kfhaArObtgnb1yQHBdwZ9ObCSP8JzHtbwWVg2S91CBiV/um4WynwXnTUl0SOGLTvpi08nVjeJnrg5KFY=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2350.namprd10.prod.outlook.com (2603:10b6:301:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Wed, 26 Jan
 2022 23:02:42 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:02:41 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] printk: Avoid livelock with heavy printk during panic
Date:   Wed, 26 Jan 2022 15:02:35 -0800
Message-Id: <20220126230236.750229-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:930:5::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eaef3a0-9e9c-432b-dd81-08d9e11ff497
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2350:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23501778C6037FAB7ABE9C6EDB209@MWHPR1001MB2350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hzxf6Gko7aaUPj3SQcn27IINvBUUEOLDpke8K8nstjXODA1QG01/4DI1L3X/iTY8PeyvVYvlc9Wl3VWGeCpxX+XpG9q4hoFAr2cH5qrz6B8Vp27hy38aG8km8t6/SaPdFSosm/w+FQW/UBkoVV2y/YOTiTv+va8xy06OOnxvfo6gOIAFZuPR61F00quy3r5JJ1pbBHzGx7nHHruvh/p/J9jKXmwVHxOmQT+VJFE8nI/lxA9wBjG8EH9eR89JlCa/IRVoCi94MbDSHPhUMhHGeyFNn7xLyCH+YJ5k+G5TLihboKwykuR0cPpSKg9QV7/WBPqWgg8M9MF9Aj+GU0vXXp4/Vy1sI26ew7a2peDdLd2LEWBotjSlF5NIA4Ip23KAmXUkNkdwgv4HK/YHeMYdQOXTtFpYt9Bt52NrQECLby2eQA2t4zc9mbAO2mKdZLzCFq/bu1PFzqctjJTqV2HBsQjcYzZSdcqtS8SHwWr00AEILgbz0TJKg0ogujiSFHO2vvXXn0fzUYqFgfkmBqGLwrd5CkLKgfOlpz7z8+KgQluPyfOI20CjjJANlmmVEgnx43LiBTosfc1havhG21I5MWKMOPprO4S7MCnNa55zuVXSRrotdcrmxNl2Xr3DfFW9xMp+gvbzV6FKuXHlDiT4+0KIiVvWIICOm1nXZbhwQG1cG3ZJt8TrhHFTzfxo5vzy7JgRmGkLJu2mSzvjzHaL6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(316002)(110136005)(54906003)(4326008)(5660300002)(83380400001)(38350700002)(1076003)(86362001)(6486002)(6506007)(36756003)(186003)(38100700002)(26005)(8676002)(6512007)(8936002)(508600001)(7416002)(52116002)(103116003)(6666004)(66556008)(66476007)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0N5itHM6dQKtWQVTSUV+ISXEmcOJY+H5dYVMRGHtFvuyB/7psHiXRnGQR5X?=
 =?us-ascii?Q?I3gy2kfHdJMKNMhyIY0V3AVbQH4POcT3lAl7cgIyU+j0OACKkDklXz6npfEq?=
 =?us-ascii?Q?CL9zrnAlSkcHHiM2ZS3Az2swQI/sduCfl2NEKz3mlpS8eisNP6KJ9KjXhOM5?=
 =?us-ascii?Q?VBtEUoRFUzS2vtb2CJw8QNrScJXryxLGHJWHy4QyU4KiT8vzSaZ/M3yTR1i6?=
 =?us-ascii?Q?pMmIawTI5OR/fQv5IheO8no+JM1KC0QKshiyGZM8Fc7UNvKVQSul0zgcxj0X?=
 =?us-ascii?Q?HEYXuybki0BVbTzJ+jV8I/fMXb0g41tjnmcVWNHqDFXICJixQtW+m2FSpqU8?=
 =?us-ascii?Q?tM6c7QrLIWEc+m+l/rXYxAmHl9ryP9gK+KyhjrgDqciSHUT099By+eFYF+TO?=
 =?us-ascii?Q?S+PRG3EnEFnEu4EAcYn5mI7s3BQoIgGN33pwew7JlAn2EnbG53cDIQV1hd0g?=
 =?us-ascii?Q?URdVMzH0DXf6hrlGlkgN3Acv+s6zJIlRVP5Z3gBopQPQoPPNg6vWqXpzgD8K?=
 =?us-ascii?Q?oUKR5BfZnWf191hnPnSiOGpq8o8qtWMPy4Oi0Fu46sSk2pscflBpoHqLG5Hh?=
 =?us-ascii?Q?K97xkGRtJRomorQMsu47cB+xENhr9zbggxN/xcAQ7C+M58Tmq/9qS8/O1/gu?=
 =?us-ascii?Q?Nad8RZUbVTKlYbzhdT/aS8TH5lhh6AjQDrBRp5SurUB5k4r7M3nrJVi33HQ+?=
 =?us-ascii?Q?4arcqrq1dYQ+f+kgWjF5leuOLbp+TyF1yDXnZoAp89f4XisTt6EoWWyOBkkC?=
 =?us-ascii?Q?+u9Gt2NEWt9tkJSqfQlJH1lwAyzyu87C9lIFTeelp8B7aVcd3k4YRzJ3UI/t?=
 =?us-ascii?Q?94nyRHIoa3TRxjkHKDCMOTJnSzhl5IL+Yi/GFJTlgcWgbAsKZ+LGhghVp2/+?=
 =?us-ascii?Q?1xtlEOsMg2VR2yniSsEahVF6CNzib6CMwXJ46l6IwYpt99dDR5hrkE0Qc2+O?=
 =?us-ascii?Q?eT2MkbM1fLJuiGRRceGhuVTVFNc/7SUl38H0vX6yfz0MnakBlsSCbCSWQ/rb?=
 =?us-ascii?Q?1pvvPN0CYUoWeBMmWHi11RqVuVTOtZQkmZEDpqn6yS/W/PuGhDwT/tDyp20J?=
 =?us-ascii?Q?ujhKffHmjpbuu9GVID1IMxqHZMtfZm5vM0vVGVrceAqYsJKvghK5japbkMkg?=
 =?us-ascii?Q?HvlF3a9jwdDKwk0ebMVZkNJAGc/TtLPW8Mq5hybFVzTCas5eb4AJTbPvehUX?=
 =?us-ascii?Q?D2H0TGK1vaZKfqEyaMbx1PWmf9hBYk+E/yBEJR0BDrrxJr9FlC2t4uoFkm5D?=
 =?us-ascii?Q?vFWLkF+lIHYoA+25KPbeWte5OL5jAmQS6+FLIXIYCOKERn71P0HGSNS5RkxX?=
 =?us-ascii?Q?wcjvNNEFJF3kGUu6Bni0/JOF0BbeaumbP68OpP9PkSwOp89Rrb6/LbFwQ8LN?=
 =?us-ascii?Q?7Glw4/1YcAqXXtJGtl2rI8Y4hmti2sWACCWy/an0+GQhW9PHdY1LuoxtLy9f?=
 =?us-ascii?Q?4f4tsvCkLgYWIZcxh1Mt2rueQKT+kr4hgsbvwbi5SRe26gdfkqIsCCzUf5zr?=
 =?us-ascii?Q?WGWT01Z/huK69PIeZjhTfwPa/KgalSmlde0HWjal7z3audZDlv/RVMOOnBDf?=
 =?us-ascii?Q?vQgQPtXFPPYex2tp4IEgO9GH6tk2XvV1DsRZvgdbo7HT1NHyXbz2PmZt3/Yt?=
 =?us-ascii?Q?l2J45PRgMtgsQ6cHs+1V9UcGdyjxV0N3Po/OevcCRvkTiHYVZv73ZpJ6jjaO?=
 =?us-ascii?Q?QQmn0A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaef3a0-9e9c-432b-dd81-08d9e11ff497
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:02:41.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sciBIcjlgdSeY1r4Nw8ukkxI8DAbzVuyVnjaG6Q1j0aiZEoXJBVCM6aHnrGjfg/vViGyCIdChz09LEyVnIBeTxmmNMTmptsbLz41ipvOO1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260131
X-Proofpoint-GUID: FLJHGdGniEs560aZ9QWlUNEJzGbLD0P4
X-Proofpoint-ORIG-GUID: FLJHGdGniEs560aZ9QWlUNEJzGbLD0P4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During panic(), if another CPU is writing heavily the kernel log (e.g.
via /dev/kmsg), then the panic CPU may livelock writing out its messages
to the console. Note when too many messages are dropped during panic and
suppress further printk, except from the panic CPU. This could result in
some important messages being dropped. However, messages are already
being dropped, so this approach at least prevents a livelock.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v2: Add pr_warn when we suppress printk on non-panic CPU

 kernel/printk/printk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 20b4b71a1a07..18107db118d4 100644
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
@@ -2667,6 +2678,11 @@ void console_unlock(void)
 		if (console_seq != r.info->seq) {
 			console_dropped += r.info->seq - console_seq;
 			console_seq = r.info->seq;
+			if (panic_in_progress() && panic_console_dropped++ > 10) {
+				suppress_panic_printk = 1;
+				pr_warn("Too many dropped messages. "
+				        "Supress messages on non-panic CPUs to prevent livelock.\n");
+			}
 		}
 
 		if (suppress_message_printing(r.info->level)) {
-- 
2.30.2

