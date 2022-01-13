Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB03B48CFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiAMAzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:55:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52492 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbiAMAzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:55:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CKEQtN010471;
        Thu, 13 Jan 2022 00:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCRxUWJ2tEzpen0v1pzpD0oK0TXbr9UxZl7btjso6K0=;
 b=InfcJD7fziqVEm5sGwa4cQ52bdhI6ssQR61PSlgKpV3WqIcthQ+qP0+jYf+QW6Ii6QSz
 kmdcFwTqOj31kaK/VVVYZdVA9FCnpntpXyLo4KKq+uHSqUO8H0NVMDjV/o5d8FbEXL3A
 3JMEiof7xGzhJlT1WSDa8Un3nZ5uOojG0yeOX89e4tMCsIqS8FjFVbyiX3FXIphJM36y
 z22KxvuJqQpLZOBQITleAEiYHSGzGNTlLSXKLsAV42d6zmP+PFmgv05WugKNPsn1o280
 S8l+E6BKgqbBNdATFwsdE+1Q9zLL9m8+3rqOccKehp68Iy4jmD0wK9JZtAIQ3Nw9P+9v 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx7v7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 00:54:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D0UXNl184346;
        Thu, 13 Jan 2022 00:54:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 3df0ngaga7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 00:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4dj5uEPUhZ3WZKFQAzLpoOUVYw+I1ucNTPiFsP/ssfsWFKvCn20vyL6b2+9k8R3W2Wu4GS215BfZZaU66FMyFkYyHrB29iE6rwz5ruXmu3vaX1fKXlANmk1Xha53TvjYUjho5NeMmvIY32AV/r4O7ArErZ7poooBlJK/jzlQcxLIKePjzVhyQg6cO3cB6N4G7yOZ6gWZTZBw44DFgoJSN8nlpWvKgMdOqVV9ZefjLL7lYzmQzzPwqdhCrcOuSydWOmsz06Hihq8YVE+fY6tTo/lCSkWXPAIuswq3Qx1zLPhKGqX7B4Ex/WXpyR8438rgtpGj5rBNtoi9wGWiLtsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCRxUWJ2tEzpen0v1pzpD0oK0TXbr9UxZl7btjso6K0=;
 b=Qo8/nZNw0US0P+MuOg6Kkc+0imtuLr3Wk+55VsTN0mdj9IbPUydLN8O43QyRmV8bQYCChbIGLRekRSHw6+nSc9pOYx493/cFjSOQmuUiY3tnS2HoVmaDC1ha9PUA3Jl3VcP9b1IZRxxJzygDDGpn8E+ukR60siAuPp50jlcOyY5obQxIXkB9+F0AMOsVwyDHCclWTjfZIDFLkM1utFNRDFEf+mlzIVugfmLnKSEXCbUWlyTMq4RI04/pG2bBsWVzbJCNxtUCoLM1DLnDZ9rEErgxLKeGxZUOHvZEm0P+MknOq8bNbyFYzcFVNWcjHxO5/w2cj3tb4u+/y+ekr1C6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCRxUWJ2tEzpen0v1pzpD0oK0TXbr9UxZl7btjso6K0=;
 b=aF8xNvdrmiF+v9NIPNn7EdW5u+zoBxEK7oKlYdP2dQ7UiWBOZyB7+yxkrqIlRkLHevWfkO25ii2uqaj2+QpOaMobr9m435fSy+xXtqsOByHp9HlQ9nXLPv65c+v2zbJaTvasw0IH79VQUGqteGGN4nX9VbM0vis6jIOMQytDgfs=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 00:54:29 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8c57:aca7:e90d:1026%9]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 00:54:29 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] panic: disable optimistic spin after halting CPUs
Date:   Wed, 12 Jan 2022 16:54:25 -0800
Message-Id: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ec77593-f50e-4f7e-a797-08d9d62f40c0
X-MS-TrafficTypeDiagnostic: CH0PR10MB4908:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4908D47B083204F7D3E8A6D4DB539@CH0PR10MB4908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmDNuoATccNrbU4pmWY4wvZYUtFoOCrewxwoojvYV0sReV6b9CVeieRJXKQFowSQC+eg54PlBBiN1KQ05lTyGl8groO3oxoxWcVgRisnvrMiGJ04+J6TqSlTLwbYBtsPI3Okf5kb1AieS619EI1x+GTx+jIcsIs62AMP1wzDTOFySlj3i+RVLWOzF6GGtKU+cSX9fBE4MADXhz8Du01GLM2sulrdF099j5mAKF7KbLJuKJJj5FLl7ipnWcreaOKiElvli1vnQ9hhwcwil5hPyZN93CdPeLUJzxr2Firp8UbLavxarNxld1uqoIPH2xqjIOW3cv7064YZq0S8S8rRfI/OkMJEwLXd0qsyryKmSmB4LdhhOBgcIZ9mYZ21MY+HQRM6YuUSrEXim91TnL0cznfHMQbZwPI7u7ujpsJfXze1j4ihQyxC0lJ3CTT7jm/zrO9NDvERAypI8fmYrj7wy8muNWSJ0gQB96ZbFIJ/FtpRlyrh5I7BLH1pWd/DWagM/Qg0bQdVVzC43qUCz3I7gtx0nC1f1kCyu8nSVxKbzyJ5xcJaMGo9c4iizuiIjM5IWh4BGu3S0gALywa5YNPb/TjA5i//p2hcorQg5KAxOrC4uET2g7qeSRoqyx+t2QiUkKfpmQ4CIbOV0Ljjbr1cUa6unegkTCbYz8h8n3XNbe/kWxetQeqFEoE8YO2l9fSuqd6hy4ZYmto2IObh0KZVoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(6486002)(2616005)(6506007)(103116003)(508600001)(316002)(186003)(26005)(6512007)(5660300002)(4326008)(36756003)(1076003)(6666004)(2906002)(8676002)(66476007)(66556008)(83380400001)(86362001)(8936002)(52116002)(54906003)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xH1eD9ff1geC5KA4gn98O/qyQR8j1fWEPFFB48TIgeWJ/kthybVBLs4INZNk?=
 =?us-ascii?Q?ea+Bvkx4g4GgMLS7+UVrs50dhzypM3hrdYy99Gw78X4QRdMfuyr34ItRG+qo?=
 =?us-ascii?Q?q0YSUB+4Bkv4Urgq6xH1TEnn08edoCQ2Z72ufQYE0lDD60YI2PSLwPH+BNBt?=
 =?us-ascii?Q?GoED9D8Vqmip1aBwq2XIyqZVSTJT/qJ9VUf4NOFk4tq+5LBH4N/sGW/y61FX?=
 =?us-ascii?Q?GHExFRMCrCoOMWmfJBiJ9g7fr/yysEmaS1bXaNt6gHrPrza4Qs6LdFDDZRFQ?=
 =?us-ascii?Q?Lfl1bfoe0OSmvQj755KTY1dBS4L7/9Ceed2+7qCYrXYbbkCiB2yTbse2gNWc?=
 =?us-ascii?Q?7ZU2WkxyFrfbKFLQtmZGB9etTfu+KkpJJaF/ZGianau2sYdTJtVssGTXT+EC?=
 =?us-ascii?Q?oVgLPAmoosZUlkLCX60HlWHJ6eqaGJTih+rePqMWxdM/h4cUK+e/3p1NuI7B?=
 =?us-ascii?Q?Vj2oM5VgaOktN/v11S2+bzi5pgvIQs9dFIdRvmSezSV7HpMHPRaomIZe84/8?=
 =?us-ascii?Q?iMMTgEOnhvB4s407o9A91KdnUh13gfc25B6F1Zy1dHYQyzEHI7IYxM8hm1sm?=
 =?us-ascii?Q?hhV/oeLZIPiVtkY6B6qZ3Uv8Kst+YZdN4G579FWzE1qPfYrdm53iKUGIX12w?=
 =?us-ascii?Q?ovtnWbH6PSbG07JZb1hM0m9wAOou/kZtA9QUJrgiBwbk0uekEOBQVrdu4YJ4?=
 =?us-ascii?Q?Umc7WktVxXRmU2e7q7yM9RwQsBM4i286a2nqBcu04h6EK5GQkJmOSrkylTr3?=
 =?us-ascii?Q?pE6cq+mwGz19oMYvvtl1uoSmLT0DlcMP6mQGYx6wBkP2eKdY6vsee6Uj/jRn?=
 =?us-ascii?Q?RgGRuwgLI/2aLmClaFv7u1OqBqusaxx9CxEELu2L6Rf72bo18vHFCWs7NNFG?=
 =?us-ascii?Q?pk6Lv5zwZ8ohTPXp32dRTvtUAwdCVGOCIkV9B98IranJqNDHMoiZxQKkAxLZ?=
 =?us-ascii?Q?/aQI+vqZiv/fzfUVuvgKmRxFaDmxH5lhlgI2pxAtaDsl04IsFHp8TIw/PNHT?=
 =?us-ascii?Q?V97FxQLDmO/jU8xmLADqv+zNInAs8XtAhqyP+VpmkaOF4SaD+033h+y5cejI?=
 =?us-ascii?Q?2qwcIGxr2FIzQyU0UgMgjk39N1Sdc0t9Zdbpf/vqa4G9Hyr9SWxxKP9dwBPt?=
 =?us-ascii?Q?2SCMEWK1ZhpKbbgDcEL64hMJlk69qa7sHdhHJ9PpDf6aLKUItIb6rJXU+x38?=
 =?us-ascii?Q?zXobB5sUr0d4M015btytLjf7s4BGIPbl4mBwjTJw8MCDrO/c8IRcn2wF9uLf?=
 =?us-ascii?Q?pFYFERB3siKpiT9kalV9hCLo0q9QPY74gJzWaQLPONaxOylJsVUWxDysa8Kt?=
 =?us-ascii?Q?Cq/nqOa4KxOloXlz4quZsDoe/oCqXGt5iEpcI/IV7mZjW1PJN0+BtFiEoVML?=
 =?us-ascii?Q?Vrh2crv+S69xyd1pw98YywyJFD4HwbR431Bs0vfLlDCp6yQESMPIDsJ4x+Om?=
 =?us-ascii?Q?MdYhPWDCjaveFptb1bdtxAIDTnnNlgi3+LTHPvKCUTFBpXc/qOxSqEjUF71G?=
 =?us-ascii?Q?j1zgUKgL/yfsyoF+A8XE3Jko8yr+adr7HqaAeUFmv9KdmdI5fox/5Jb4ZlNX?=
 =?us-ascii?Q?GaR8ACLgljnCqECLd9VuP3CVzrUVAklbAcmawVOfszrXqTnYJ7BGSJA1aR6j?=
 =?us-ascii?Q?iokjU50Xq0bG6LNujxpG/E2qJfaHOOFxTFHyLp5u2yLdDTQfCFdwKT2NGAYx?=
 =?us-ascii?Q?G6vltw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec77593-f50e-4f7e-a797-08d9d62f40c0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 00:54:28.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soMjMWrBD9zey/jebBErXhlPe5ZVOcQwBq5FqgqjSZ+oHC0b9B0R0FlVSDQJTEgyfj3nVm122mUlmAK+87DEtUYvMIXZDplJje2zo4LhFLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130000
X-Proofpoint-GUID: qMMAcFuuVgIE1rX1jFKZ-openFWhKF0g
X-Proofpoint-ORIG-GUID: qMMAcFuuVgIE1rX1jFKZ-openFWhKF0g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A CPU executing with console lock spinning enabled might be halted
during a panic. Before console_flush_on_panic(), it's possible for
console_trylock() to attempt optimistic spinning, deadlocking the panic
CPU:

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

Below are the hang rates for the above test case, based on v5.16-rc8
before and after this patch:

before:  197 hangs / 340 trials - 57.9%
after :    0 hangs / 245 trials -  0.0%

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 include/linux/console.h |  1 +
 kernel/panic.c          |  7 +++++++
 kernel/printk/printk.c  | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index a97f277cfdfa..4eeb46927d96 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -179,6 +179,7 @@ extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
+extern void console_lock_spinning_disable_on_panic(void);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..a9340e580b20 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -265,6 +265,13 @@ void panic(const char *fmt, ...)
 		crash_smp_send_stop();
 	}
 
+	/*
+	 * Now that we've halted other CPUs, disable optimistic spinning in
+	 * printk(). This avoids deadlocking in console_trylock(), until we call
+	 * console_flush_on_panic().
+	 */
+	console_lock_spinning_disable_on_panic();
+
 	/*
 	 * Run any panic handlers, including those that might need to
 	 * add information to the kmsg dump output.
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..d824fdf7d3fd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1823,6 +1823,23 @@ static int console_lock_spinning_disable_and_check(void)
 	return 1;
 }
 
+/**
+ * console_lock_spinning_disable_on_panic - disable spinning so that
+ *	a panic CPU does not enter an infinite loop
+ *
+ * This is called once all CPUs are halted. A CPU halted during a section which
+ * allowed spinning, could trigger an infinite loop in console_trylock. To avoid
+ * this, mark console_owner as NULL.
+ */
+void console_lock_spinning_disable_on_panic(void)
+{
+	WRITE_ONCE(console_owner, NULL);
+	if (raw_spin_is_locked(&console_owner_lock)) {
+		debug_locks_off();
+		raw_spin_lock_init(&console_owner_lock);
+	}
+}
+
 /**
  * console_trylock_spinning - try to get console_lock by busy waiting
  *
-- 
2.30.2

