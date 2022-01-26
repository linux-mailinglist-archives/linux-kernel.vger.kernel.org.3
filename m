Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91649D5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiAZXDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:03:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28416 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbiAZXDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:03:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYpok016835;
        Wed, 26 Jan 2022 23:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=A+9hSAc9AjnYwsjzGLbU8+FCohJr+cAWiqPZMeQxc4A=;
 b=SNc9aG25GiLZNFyrRCqW/x4ZO4D0+aG/p2/lD9Bn9H8IxmvBeRfCD6cKxf/GsBCwCGE7
 bJ44OCDTpjHKAQGxnG2xJ6OLK2hbsxSWxH0HKNdfkwAmWOPtDr91OMchG8/oN/v7NjtD
 85kyxjBICG1jOhhBBhYQSRTTx7f7CKifr9mBh4uziJr7ZIuNVeUFJFrK4dPyp9yRaoF2
 L3hiXolXEWncJnQnSPsvAFA28KuEClKmSG/VFDRbo2AL6ZAjZrUc9frOws7o/RvcpX5Z
 //dXWZ5RNnQ32ZlVvCEzByzy8w8xr5pJFuXoMxq9wWMD3IjrdfrVCQryLAXNrP4cBg75 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s7eeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QMoUfl151130;
        Wed, 26 Jan 2022 23:02:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3drbcs2nph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQvSjmQl0I6G3m9ImJnnC6tlefmcoxDSVbjTFDt6YtvfOcmgtjVwblmK2krNTdQm30qOFG/dUX1z0G1PJ9N7AoCkqH6F+P7yRLUh83VNWDOUMuSViP9O0UekMpolVhfGe4k3PZAthxNCSSvBb93WQnBpZ1JmvlytvdwX5207x3R2mJqOFhtUbwCzjYxkVV3dcy2dmcP6FLayyymJZ9QJGc/qh5r2QGiPzoUXYCCWhUfxkK1P85TiVy/9h1imhk1q7FXyTcdVjcnEEOKl2DGf0m61BJV8cfgfHOKzwYud5k1QxcT8NJH6HYMupE3wpyiiDlNyhRHu0MKXQox1g72vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+9hSAc9AjnYwsjzGLbU8+FCohJr+cAWiqPZMeQxc4A=;
 b=EOjk4gLktI5jv6Jrilprkt4NgaxIowVZVyUa2M4ltEiasZVoMIAs25UhRd6ZorMuKG6SHIO7QSlG+/XNFWG/R0ZeqeZLeHTL3KnHFR/lcOghbl8wMMBt7UGi6mUrkLbuLnMZmbtGpI+xPBRI53QrHxTzTnJZSBQa8jDRbUE8Xqd09GVbXxqAJC70Ulx1kU5TLJ4TQoVgHHHDi80GmQ7CREQI2gpOCzK+h5Rj0K1dVi6ixLB9LnHeaL9B3JaYy/nIop5A4glpEwSCl4MJEQkx7I9WdbWO1XLY4WSdQHliX4GqvcDlptnnX1oZ40Sr/xfJrVHvO42AWnLqg/+Pz40A8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9hSAc9AjnYwsjzGLbU8+FCohJr+cAWiqPZMeQxc4A=;
 b=exW5c3TcERFIi9MzMGTOAxqfVLm746sv2va69HFjqO3s9x0Q950GzNLbAd5zDabyxB16ShRCvpGUcN1laI1qtfprhyk5QgACo1o+yhtw992ikisE80KJ1x1aByTxG7Vc9MNmaG26edeuJeTO4ezhRgF+YnINe0BiAJAxWsV4Yr0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR10MB1615.namprd10.prod.outlook.com (2603:10b6:301:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 23:02:39 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:02:38 +0000
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
Subject: [PATCH v2 2/4] printk: disable optimistic spin during panic
Date:   Wed, 26 Jan 2022 15:02:34 -0800
Message-Id: <20220126230236.750229-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:903:98::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02f06f6-d864-40a3-c3b7-08d9e11ff309
X-MS-TrafficTypeDiagnostic: MWHPR10MB1615:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1615B7887DC38211362580B7DB209@MWHPR10MB1615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDxx5AyZFsngFzEzSpsxkZ9vCR2R/BeMuHQQme17gDz1PWw+1x/Xh0Y8V93zFZTKjwGCmIeFVgBat2R1pZscItK4o182XWhOilDmmPiyqSARVuWP/FN35IBObE1lZnSdelCBs2M01XIaeSRey/AdKa5pIioTgTSKN+mNggn3L/AStERR6DM/R4ncbnnKICBD8CB43LD6q229dhIoS+xLcVlZV54umCOKpvO3g7Bfc0D5iXVnyqmwwMQ0JxsvPKv1ttdfGo2yBArlLzEMvddDDsaWqVqXewDgRd+vsuBKS9Y7LZDSNHZ+eZpHavkC9Elfh1awqO8zAnXxjRoag33338cAIW4WrjbVDn+qoWrUbYFRh2z/3nVVXSn5h5LUYu5OqN12AUtHgyPUzyTBewqovshrpxADRoypa03l9ANbbidGFh6i2zMY3HqOJyf+hOzkPGagZlxSymiDi9lHWCaszJAAaJ7x+qjLk8z85mDZbaeoPS1zmufL7CWk+ZUzIhjMN+H8KanWF1HgAhGN6yUnoL0W2/gwTWvVuqDL/7NIdg/k/33GD4/EjmKkQFV6J7PgyyNNsoaGs8aXKn00y49YO2I8lqzQ5U/uP8YW8s0bMDoNX6AL8otNCvEZDC2oUHTDhG7CbNGJZG8x3h+2/55uAbXdZ7nURfMkNVlf16d/Lu4JYuUibxRYM7eoY4qgrMRmosEVt3SvXQ0Rf/dtjgZ9uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(2906002)(86362001)(6666004)(110136005)(54906003)(6506007)(52116002)(5660300002)(38100700002)(38350700002)(508600001)(6486002)(8936002)(103116003)(186003)(4326008)(6512007)(8676002)(66476007)(66556008)(66946007)(316002)(26005)(1076003)(7416002)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UaG0Zt8nXxTRvSaJSSeBxaiKT9DJo4QssFjqLwxV8h04KlXwMDXEsIod1QhS?=
 =?us-ascii?Q?smnqBs86beITcahZ0hzvyxTMnD7oHwHaJIloJp+CoA+f1apmUx4Ht8lt2VJr?=
 =?us-ascii?Q?fZvX+OrIKlctc66fMSfsyla9xztocClqWWXt+G/fLcaAde3n8MUimi2UKSR/?=
 =?us-ascii?Q?8nmSHXBsgrLWULn6/0Qop19TFfzqlv+e25FPTqlKkNg6hXTSD1LEKfwO+GaH?=
 =?us-ascii?Q?xPHdDBdUhlu4CbsOhn0EvaQFDznbfw9w8xUkbEP/ZeznI2WJdKHbQaSqHRXy?=
 =?us-ascii?Q?REo6MOkybBQVnyIoeaYlgSHKgZP8yZBncU2YoUTZNEZrumyJMCgXRzsWJBKa?=
 =?us-ascii?Q?k1BHlncjsI0m8jn02IHM+6y52v62eQH8lksEiMG84aUeC6KVErE155yBqQ+A?=
 =?us-ascii?Q?V2HI+n/CZ3+5FCLAICN2BiTQI+FA3dCD/Tsnd4Nb1nVlhFhYzhiESN5Odt0K?=
 =?us-ascii?Q?p/pHEUgE+pT6pI9oEmsff432Kr8xyRR4pwAkdx/f0d8MWVnCf2gmP4kC9mwQ?=
 =?us-ascii?Q?Ddz/YLnXzW1eEtUZCUraG1luvcb3OzcycLZ7PT5v3XIIBda84drhSNck+MHN?=
 =?us-ascii?Q?DVyqASh/JKsJRkUVaWuhCgb5KZLoxFsDYkaNf1j4ZtQE8jq9guSLuIRd8FFv?=
 =?us-ascii?Q?Fr9wNnOG1/yu9TIlmqZka27pyfyMoEjvqIMCi9zD8lMENtXMDOSpIM1X1hnc?=
 =?us-ascii?Q?0CBIY85wYxmp+DCQrGWpl0wOndzvrGqnGVdYjkHen9vOd2T4eKcRDz6j7+e1?=
 =?us-ascii?Q?B+LmIdXXzQqlK8MagKiRpQygzYUr4VCJP7iv6oFv/km98CgGssYiUphlfzgz?=
 =?us-ascii?Q?+8itS0WpkKqjXi4+Lb4RMpqjr4rMgVQCUGZmwwp7v8f9lHHwoQNxhrLTbM7r?=
 =?us-ascii?Q?Eu0+YDNSPaVMTo/XrpqRYhdoPRG0cVB3kEVQQ9gMyktm220A+e7AdRcTUehJ?=
 =?us-ascii?Q?wVqN12I76w+QqZu2giaSVjKxHLB7/J/UbmtHGMAVa90ObZtVn3Z7j/uWwix6?=
 =?us-ascii?Q?VNrk5sscUZdIEyBJPTQH7G8xd+XKgmUvuVbbuvknwr+32VdVm6KCF4rx/UmM?=
 =?us-ascii?Q?S5xoomJ0UGxGf9eM6/qIiWjpHgVzGiWqgTxXzXo5YWwvQ2c95l7a++Eq0u0u?=
 =?us-ascii?Q?GnTK2nfip8pYAGSGubieq5US1Sy1OSla158YPCVur/FS5h/Q2M6WquukHOBJ?=
 =?us-ascii?Q?U0rjNJQf248SqR8XVfZknDt0jIgeuVsJJIrsR2gZdqOEbr+VOSVmej4hSNKK?=
 =?us-ascii?Q?LqhdxiXbU7m28ipB8A/4JkUhl1ar91oD4NkBayIjmFYRmcaaw4vNqfG95J6k?=
 =?us-ascii?Q?Ds4kcTFtMfhmd/AaQRuITC9b1nZfFa5LabA6agoLcieejDFCNWVNB9jUp3B5?=
 =?us-ascii?Q?FoyPBd826xS1prXqMbUJ4/pSQdyZ9tiEtt1xT0tSa6/fttfwSrOFPkBMz3k6?=
 =?us-ascii?Q?BCCTN7XvGLB5nQaG6QwcfKY6TU0iucGg9A4HUnCjuDKi+e92xfelnkLgotWy?=
 =?us-ascii?Q?jL3AoZHXXIGXscGafJgGLRLD05wjUUltLpxrbdN4CB759g4ZK13zM389b1hY?=
 =?us-ascii?Q?Q78yFiPNOu1QilOVMM9yqrliRDzE3bzyNyr5TgiEnJzjxh1BJ5mF2zHNu6l8?=
 =?us-ascii?Q?7zAkz5l4Ct9YQRcNUpU3nomYBF2Tj1aSJ7+b+w+V6wh/3ovmYHAJZOpZH8eu?=
 =?us-ascii?Q?xjgbZA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02f06f6-d864-40a3-c3b7-08d9e11ff309
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:02:38.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Kf0Fl8PTUN+AB00qfB5l3vGoTlfui7jRTcqCgwcWmphgwfC16a3krwBq5hvQWWaKZytxWat+BJzeesSu5INmjrODH+vOCWeBbDnFm7ZTu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260131
X-Proofpoint-GUID: lRpGq5qzcR_cATYwJguxenTXFvafJaKO
X-Proofpoint-ORIG-GUID: lRpGq5qzcR_cATYwJguxenTXFvafJaKO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CPU executing with console lock spinning enabled might be halted
during a panic. Before the panicking CPU calls console_flush_on_panic(),
it may call console_trylock(), which attempts to optimistically spin,
deadlocking the panic CPU:

CPU 0 (panic CPU)             CPU 1
-----------------             ------
                              printk() {
                                vprintk_func() {
                                  vprintk_default() {
                                    vprintk_emit() {
                                      console_unlock() {
                                        console_lock_spinning_enable();
                                        ... printing to console ...
panic() {
  crash_smp_send_stop() {
    NMI  -------------------> HALT
  }
  atomic_notifier_call_chain() {
    printk() {
      ...
      console_trylock_spinnning() {
        // optimistic spin infinitely

This hang during panic can be induced when a kdump kernel is loaded, and
crash_kexec_post_notifiers=1 is present on the kernel command line. The
following script which concurrently writes to /dev/kmsg, and triggers a
panic, can result in this hang:

    #!/bin/bash
    date
    # 991 chars (based on log buffer size):
    chars="$(printf 'a%.0s' {1..991})"
    while :; do
        echo $chars > /dev/kmsg
    done &
    echo c > /proc/sysrq-trigger &
    date
    exit

To avoid this deadlock, ensure that console_trylock_spinning() does not
allow spinning once a panic has begun.

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..20b4b71a1a07 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1843,6 +1843,16 @@ static int console_trylock_spinning(void)
 	if (console_trylock())
 		return 1;
 
+	/*
+	 * It's unsafe to spin once a panic has begun. If we are the
+	 * panic CPU, we may have already halted the owner of the
+	 * console_sem. If we are not the panic CPU, then we should
+	 * avoid taking console_sem, so the panic CPU has a better
+	 * chance of cleanly acquiring it later.
+	 */
+	if (panic_in_progress())
+		return 0;
+
 	printk_safe_enter_irqsave(flags);
 
 	raw_spin_lock(&console_owner_lock);
-- 
2.30.2

