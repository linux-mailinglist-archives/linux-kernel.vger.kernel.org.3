Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD149325B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiASBcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:32:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350638AbiASBcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:32:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxY7m012923;
        Wed, 19 Jan 2022 01:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ygn7zjz5BpX6o1wqjv/Vlj+1w6kXB6Q7ikydnONXfRA=;
 b=T6mGMrtXPaF+lV4h8F78xC6U/J0Sk6ixGKyhq/4FqErF7Gs2RunZ32+qKUr3HovClvtz
 piEgT/zFHkxK0UQURgQS5EGhAAw4vU6t6vZlX7myKJxq3eCr6gj6fPt7v9spA7T9yHeR
 1jINGR15XCUIhRyxdi6CF3ulQ0zVDz/2QQ49EJoLTvkhhMYnOFz7UnAqB01228ytCeKy
 k9aujmYewTIq1dJX9n5wsPogncIZHGbvzCqfEvA+1CURl1c7AX3Uox7d1qXz/X2VL0VV
 WdBX0nZEN/fW4s/7+WVGheQCGrInJjcsBWmJRFXBtOypmJZBw9XMCLAVy0S88uhep6+S tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q3pqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 01:31:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J1GPCG072683;
        Wed, 19 Jan 2022 01:31:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3dkp3552mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 01:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0S1S5raMIMlFIgUt/pauK1QnGO6lOwMBhxyuXO9UyyG60O6rCyHabl1ni6kt9ng8s+xHpMLA173Zm7PILHgS4NCs2MDMIWwfocohQmUvYV0ULSsLAhZQw2xvLlcMereJ/GNcVAG8ZpazFUV57V0P1XBjj9MHsmHXFIuJrh1iEaCZpgTGG1esQPOXOPktbMEPJnG4dS0e0NL2xI9/8av5ktlQ8eSl1sKEJsRFeDbzexm0kUEZgF2QiSNOuBk/BV/FoXKdREEj83Ya7yk5YwjYyDX5jlkufBPhgioIxD1F9qUgbPtraodGcuD0rbNPG4aDyObGb9kZr+zcHaeeXPY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygn7zjz5BpX6o1wqjv/Vlj+1w6kXB6Q7ikydnONXfRA=;
 b=c9alym+M0wX80FgHgh4suf/9THG/3ilyHGGoBv4k84/e5YC2aM0z/Zze4qx3GcK/gA8Ejyl+27qzEjg/Iou0cDIb3tx4MloppEJ1ViBln9DepK/ompsUPJCO6kEu0QETTwyjNH7EGwcKT4zPgKM4WAOsH866M+pbxFl0MaaFWgXCvmQpgZUJyukrIYkvOElowemP3wYoi15ZuZQnsxkgrpFtfnCqkiZIj7b6K2x7YBj0Fx20BmDLFyTxa/bpaNyyzpzGkPnV/Zv4T6ccbFIV/fwQp1jSq/T69PtYtjrF0pndQOAAGldt2HTU6ckaLn7EqBMvjANMIYGNVkwSgvFxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygn7zjz5BpX6o1wqjv/Vlj+1w6kXB6Q7ikydnONXfRA=;
 b=nODMAhfml/D+X7KctOd5LZ2N1pkF7hrMuI5HrS2oy/t+OvS9uDKyQuyzaf7aKTiC3TlVJF2cWGDcXr7KRDnh2GgPGCbVITHJ0kwD5gKRvjmGsYxZs+9HBy2K4zk/RfMgLtOj4V+hFD29mDAZjjbBDxnQqR5jOrvd5Z358ym1S9U=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4055.namprd10.prod.outlook.com (2603:10b6:610:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 01:31:43 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::e430:bb9e:c983:23bf%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 01:31:43 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] printk: disable optimistic spin during panic
Date:   Tue, 18 Jan 2022 17:31:40 -0800
Message-Id: <20220119013140.383261-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50fa0d5d-0617-497d-b841-08d9daeb731e
X-MS-TrafficTypeDiagnostic: CH2PR10MB4055:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB40558D3F8D696307D343D438DB599@CH2PR10MB4055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR4j2tTo9DK4mOalY7RIYYgwt+fFRHCgJ685wS5kWwOnMLJvMbneOcpIgrb4yyjZF88Rjahna5LroDMJ4Coku2xnYi7xgD29xVruHmi5C1jXuqrumofY8QX6j18K0aPvlxY+8bZYe+057dvxUNlYm+WT0BACnkrhoQtk+VvH0tT24CmtkubdI2U/lHU/iV9T87r6q4GqlaSTYDUltzBkMEmRV5mIRWdPDKA37Lnm6Jp6afqnkT9q8Eyhyc0Fqw6P2Gf/EZ9LI7wMsDlbrZzyDV6kYItyx5wAlLbwxukPYInn7nA2/EbvUCL5LAv7GQ7kzXNapo4yjbge8s5IiidKoTKHK6qcZbm3dR+ZxW1vkgDHX5l1d4FpNnebyY2+TRSqZDjucGnJ5AqPFGkx2gJqyGwIG18lDT8FwRYURynM89vfWv5UszuLxYIcNoYrdLXWObOGy0br8kZohmMlvoGaAkaGvoh+PNLe+dR/bB8vnGcQNWZ/G7M5A5TIeAfkEKSNvo1sgWutc32U3fnGHsjVzwNOoDCfOHfHk/H5vJFurWH1c4qXYZKarwj4IXKffTsS0N2ujJN7UtR32xzSC9gBDNGhcKKrRccfrUvaqmy7PLLmTnD59Sq3/dZwcvkIpePKEpXmZA2ZHFLRzS2vL+lXYNhNOY2ctB8uIdVbHDEcSHQvsdYuDpNgGj1+qFF0NFS2TKDRkwCgiWwvIieL+68KvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(1076003)(4326008)(110136005)(86362001)(83380400001)(66556008)(26005)(316002)(66476007)(54906003)(508600001)(6486002)(52116002)(6506007)(38350700002)(8676002)(2906002)(103116003)(38100700002)(2616005)(6512007)(8936002)(5660300002)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flO8wCwGHdXaabGPiibNS27EnC6vm0N56sgy8yJeNTSpG+c4heAXS8pxmCVB?=
 =?us-ascii?Q?yYDHjwhmx9lSgb/BMRCaGev2jo8CzuSWIYjdTj48iFoCd2+wWHokWNlJN1j3?=
 =?us-ascii?Q?1p7VC7+YIaklhUcoltmZBcLsgEaliy423kyuDM20fjUHbaPXNgnL3FyMXL6A?=
 =?us-ascii?Q?V0lOhMh0mOTz4/XZwzimYeLu4odE9DyMoHUmfsKr/7fsj3CyuZktxQYSZmwj?=
 =?us-ascii?Q?0e20zNEfy6hBhkWWcw3Rlt0tdIfuZSOEtPe6wJLoLKv23Ct4SCzv2gmjcVRH?=
 =?us-ascii?Q?I+IwE3RD7u9LpUHd4sWywjCEiGCrRRoJMrtdZb/TDQkwY2gmTTyX1y4gKlfb?=
 =?us-ascii?Q?xXRiFBzatWbsLxPyFXx19Z3/4YKe7Qnijv00u/dVBNMTupYkvPAbELVwc6ur?=
 =?us-ascii?Q?gJpEfL4mh55OoF+dhf4l6o5tccNmWnRipHi3bvk3JUp+WR72N3N9evlbPV2g?=
 =?us-ascii?Q?tMOzz/Y2bGdEwH/Kj3Cmz6c0o716VsOPjjVEATJ258dbYUcpc9dJKEWyfW9r?=
 =?us-ascii?Q?Gnma0mYgOhAdhCP79ne08woG0t3FhEUzfrGgoIQ603fMuNU/dAGL1KibIFZx?=
 =?us-ascii?Q?YdgrBkDzWvn39SkRcVi4Ml6MJBPz+nehBn+FqJtJWAO2DFg1PFDhdgoQcY3b?=
 =?us-ascii?Q?VxaB7ctSAuHxGvU21J8SmLodt5+Dabt31WuHYIQ4Ke/6Hxcyfi+a4DC30ZPl?=
 =?us-ascii?Q?eNtfQK1kgjOG6XS+tuCk+OLMV5PRl8L08MQoMgVaIMErepJCG5BCC30AWbLJ?=
 =?us-ascii?Q?1oKhCEJvZdLxlRDff1k0OaZGEYu1Gqi5qz/2hQ9G5nrx9N7fXEeTzQwIIug3?=
 =?us-ascii?Q?mPGvxoAfFk8YTzj895fOVla949G1dcfsMC1H4TKmtTg2p44ZoP+omcYkgm5t?=
 =?us-ascii?Q?6KgD+jqUoybumirgLcjjhvYHe1h7Ysb6BmZUdeYNpI08p1QyLBq+UTVcMTuC?=
 =?us-ascii?Q?VpdveBOQkCWzC8DZSSmKwwnSTvh3Jo+0QLxpEBICpwnrDaSe4YE1Awh7WztQ?=
 =?us-ascii?Q?VduLvvgzZjoxarbpHSDEwwzGi0aS80dm520UALlAsOPF8uoCiOv/+2ESrqII?=
 =?us-ascii?Q?L65tWFqbJV/PopixoP5E1BUfLrvIPX9AxQDxl5QSTyKQtF7zYpEE+O7U1NUJ?=
 =?us-ascii?Q?424UyQT7wGfesP0Wvq2IQ9VbG9fgtHqoDJOe2htZecPKomEoHQr4eaPeiAoE?=
 =?us-ascii?Q?NpPwmpD5KecJBYU7SHyiGZgeEQSombHi2szTbgtIR6aRBgw0NDSwXgP0993k?=
 =?us-ascii?Q?fqgXcQ+CWguv/OIYvSvinK6wV7G8v1R/XU/ihgkwPq956Z7684Cyp8zpJNDE?=
 =?us-ascii?Q?CUtETUOe5p42zq3YJdNaIwK8C8uF4r9TrGBR6TVLrL27L5RBa4HxtARAreaH?=
 =?us-ascii?Q?7ssPM61UvQDCa2sppvBLB1+rblL4nTUWovEnH++MDeQ4EWACoeZyxDv3LYh0?=
 =?us-ascii?Q?AVSbQJ/DvCExlrYoMKPX8gr+3FixizSWJWOoheTd4MfmVEZ8W/VAhzy2Oq8I?=
 =?us-ascii?Q?tPRmxM2ChFlR6w1cBfrtjVZwzHC0lvkNXVgSsUP+x1Hv0k0DCZkCfXhV2VfA?=
 =?us-ascii?Q?c+4PUfIpfxOGFa9SJcrl8KqArbUHdbeRB/xSYS/mG2+6/rbDun4zJ+0e9dB5?=
 =?us-ascii?Q?8eXfHH9TLYqSQhulhD5OmcN+SP0iXbgBwWiscd4sDieMkV3HwABtJCWKgca7?=
 =?us-ascii?Q?TWTxzQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fa0d5d-0617-497d-b841-08d9daeb731e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:31:43.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0HBXeeTcS5CDMAVn86mFAoL6wZpLu4rK36BFHiMiaigZ+i/2jA59Nz61TOv3CHWGtLAAsN5ssBvLnKuV85RNLT4jW+n4wE+Zw4IT2v0QYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190004
X-Proofpoint-GUID: DaU0y8nkpJ1u0Qd8ebZ3xVpODpbzh61b
X-Proofpoint-ORIG-GUID: DaU0y8nkpJ1u0Qd8ebZ3xVpODpbzh61b
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
allow spinning once a panic has begun. Below are the hang rates for the
above test case, based on v5.16-rc8 before and after this patch:

before:  776 hangs / 1484 trials - 52.3%
after :    0 hangs /  102 trials -  0.0%

Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Note: I continue to run my tests past 100 trials, but at this point I'm
confident enough in the fix to send the patch.

As Petr suggested I will send another patch making the non-panic CPUs
bail out of console_unlock(), but I wanted to get this one first, since
it is implemented and ready now.

 kernel/printk/printk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 57b132b658e1..612ed895b967 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1843,6 +1843,16 @@ static int console_trylock_spinning(void)
 	if (console_trylock())
 		return 1;
 
+	/*
+	 * It's unsafe for the panic CPU to spin, since the CPU holding the
+	 * console_sem may have already been halted. However, if a panic has
+	 * started, but we're not the panic CPU, we still spin. This protects
+	 * the panic CPU from needing to write out messages buffered by other
+	 * CPUs in console_unlock().
+	 */
+	if (atomic_read(&panic_cpu) == raw_smp_processor_id())
+		return 0;
+
 	printk_safe_enter_irqsave(flags);
 
 	raw_spin_lock(&console_owner_lock);
-- 
2.30.2

