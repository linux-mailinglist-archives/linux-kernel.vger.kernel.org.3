Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2394A76AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbiBBRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:18:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34832 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232289AbiBBRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:18:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HFmqu012793;
        Wed, 2 Feb 2022 17:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=l0GwcuejTlh69ODQ9OFtnEdLNbsWO3CNaRak0kEhjD0=;
 b=tyPlkWcXYuzYYj0yP8CgYEhsx/UfpIfAWxfhQ0O5lO/70QB75rC6FeerwmrqjdzHO+Ce
 1o2wTReCfTxuhuy6s3V/BwWMoOPT2JgDZgHM62nIuWlWrFA21im2ZpVDLtXJv486veHh
 tuXSnhGLAp6VxX0EUA5FVmyKaClKnjVeMI6qP6H2Z+I2fJ2zB+DHYrSPq6P4n8aeCffZ
 /qc4YL6pTBtQ4Y2adPtj9A3ikZI748TVr3iL6iDu+NKrB0wHMQVMrAOQz2rUkzfr96fq
 6NpEfHUVe5gLWBReXFxaysmpOe8tNxraL5fjtOCwd79SZ8ohYCmRuie4vOXP5z9e3ILC 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fxs11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HFlLg196127;
        Wed, 2 Feb 2022 17:18:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3030.oracle.com with ESMTP id 3dvumhuma5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 17:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZkAIWc3Q7mm+9AXBguS+inHwJ0k6IBZnjcDMUZv0PYEjDvdvo0V/83UubBTKvjyRIQJeVax0LsQgnEnYpR0PYt3JBropiJWl9FHwoeOSMLIIidqm+vbFJGl1GIx64vonBv6xTd7mO+DztJ9wN7sSAwXp+lBktvVFTp58YtCK3oWCrtRfGchuQRUy8TsbrhkrdUVDXkVe1+gwD+zyrLeRPERIVAwy4OZA1PsoeqtK8hxl0UA+CTEl6RfWSMz5ZpAFTk6w+fFRmHTtdxRg84p0krkZf1P6Db2TjTBLHrz5sdRsqM7FKCCIkWRJt7jjGK38i40uFWQVujs0QwJFr3tGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0GwcuejTlh69ODQ9OFtnEdLNbsWO3CNaRak0kEhjD0=;
 b=em/oO68swl4g1waK+aWlpe61J9y2ZYJUWoHgbRMeyqkAVOJmTmbIsegHrhnSz97EhaUK4cBUlisu6SIO3p7FrK8kffzLok/ftfL+KJPxyO+tfmWVAL32M7ncwC43UMcFsTAxzhjqenBX0+4jjGZ6cE17ecAZEYX7To9+ACpuU5NY8NM7AjZ7e2FNP3yCobwDK8TkkqTf0O4iIz5Z5591AvfuLKtXb1TOY/sPXsZw/z3kEyBeWY2rdDzihjKm4dhhZpC2GN+sJnsJNOdq+OAJPG68frE3XJG1mVKb1skOA4/XRJuymIYmwhg/imOxdkKHOXBU8MU3PCq0vw3aKrpzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0GwcuejTlh69ODQ9OFtnEdLNbsWO3CNaRak0kEhjD0=;
 b=CwMdSLd/PBe9eXWoS9gOvxE2z6YXHv7dFeKnWRk8V3s3muUyurM5YvGpzZELVWdXy0mvlEXISQm6u+8F0eJ2KgywqR5ppKj/QcXhlzfSOvAkZeAeFrrNIPTnBw8OEJD3Bh473yQXKTXFgHnQfbpJ0A/GjFr0msnxZna4jnheVks=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:18:31 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 17:18:31 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v4 2/4] printk: disable optimistic spin during panic
Date:   Wed,  2 Feb 2022 09:18:19 -0800
Message-Id: <20220202171821.179394-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672ad6d1-3f26-4324-eaf7-08d9e67008df
X-MS-TrafficTypeDiagnostic: DM6PR10MB4236:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4236776A85CCD2562202DD22DB279@DM6PR10MB4236.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQbksiGhODQLBrUNFPK7xicVFzopAbqIwqFXAwj/Vc3pSDsbTntgWcYuYAVJkxHwTidHloGThULFUQvQzoWcOQpFGzi45/Nn0iZAR4zjfR7hcIxfPNG52jWryzyhIS6TZs3ZTPAUy9aWrDT/Dn8aIPQqW/4o6MBUM3BLVllVGEC4bF4/OETuD4DvqafVM7hw9pXmx6feF6X2PtcSL7yYLov7BFJ8+9I2qTFQ9HlEawM5/AF4H77iy8lDQRupXO3yhtIJTchAe5tE6u/kq+PxtGSO0C2rWFaEzBBIf1tTABwd6sHvHTKo+S+lBNtC/fek8ZQSjohXauHGPes5b+DfhkaEjuenMOE+kyJFTDU4RKFFoDsYJD706EKkImZ1mqaztsO9jGlC7euLI4MLNjIuFGzHeD39YKQjjSh2HxR8T9r26TDwS1YTzB3lrLoBhz3xdjjsJBJqxpGZ4OuOPXkC1oFIxXpB0CTqgjnGXBTYWfzCRsVUb/B5eVTu42nbvCfhimL9X+d82v+UAB4NTlZX1CNG4n17cMt9tYcBFOzZmONK0KmgqRRwdWMbJTqD+aGFuVmM7oZTSrVbxpOMxvQoXPAzwA10Do1VsU2s4Ns/uOkm5iIvBWjiBzrKsEEeSlbk7OzHVWUt05uVDxu8gNNLy3kYFJVRYxZDXAVWX9ZoypjNfNkJh/2sNF8NKA4+6Ucefk3FtGiExCYyBo/Y1GtD9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(186003)(26005)(6486002)(83380400001)(2616005)(107886003)(36756003)(2906002)(103116003)(5660300002)(86362001)(54906003)(6512007)(52116002)(66946007)(66476007)(38350700002)(110136005)(38100700002)(66556008)(6506007)(508600001)(6666004)(4326008)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIDzoiTeTla1otpw0CDESV8t/woDUqlqRAqy6lM8c6yZMF1hrDNcbzEjf26/?=
 =?us-ascii?Q?wzEuKW70L94k0DjpeOug6j3wEMiTjtUQZAmU4aDTNaiLJrj5Y/DlI2rcB+zH?=
 =?us-ascii?Q?oYWYfTex5nfQrgJXLvOYKwZaIlW52pDBxPa8nYoeHNcX0lX+9KxTPW1w5ePj?=
 =?us-ascii?Q?HNPfpFl8m2vKBZJ5v8oXInpXt0CCrO7zl8MdnSe1rvV+uCOODdWOYUWJ/0zg?=
 =?us-ascii?Q?t4yaHhIrDUK/YeTx2PiZoTN4qHpYUnr1svwUw8sl8zv99VShEsxQAzQP3ZPb?=
 =?us-ascii?Q?UNNiBIVO0UBC3lL1L23eLSfq5a4PytdbUSgw2bUZhcqff2NnlFf8KB+52aXF?=
 =?us-ascii?Q?nN72SPU6MU3EPtcSSC+9RzSeolycNsJyzI95tvfCWS1kAQbEyMDbF8frr4yR?=
 =?us-ascii?Q?AQ8dBJRo6LghdR4FU/0rUA0bbTO8nmMoX71sXW5eDWwxRt5E1U0BYZJ94Q/r?=
 =?us-ascii?Q?6oMo5QY+aPR2irH8cotbG+M9DBI4SClPr+gHwhc0soG6vaYa4fdK1osgixyS?=
 =?us-ascii?Q?slwHoEmlq9Pl+9V4KlUGQ86p4WnoYVbOlWIFHtEfbjAE6aCzbN+s2qniIFDn?=
 =?us-ascii?Q?BJYY9Far8dlkOWH/z+rFN7bYvoP7HZu0gN/QJBzMZvs03stpbCtffE2XpuXG?=
 =?us-ascii?Q?EHkcQdL3Q7cAtRrt5/oEvd55Liez7wmCRRQ3wIneLMCNwj7Kl+fS031AA4ly?=
 =?us-ascii?Q?7+oFRH75ceQ+BIutAUEa7fAFVc0T9Gl7d6TSmBOxdRH//sL1lg21d3RgzAAM?=
 =?us-ascii?Q?BV9mPS9caz9SeD4HSniiuhujPswsrISnmJ7Nz8lgw24kljVC8VsSVmgP6QNq?=
 =?us-ascii?Q?y3UNRdClAtHFA0aWx+XxiLKXiiELLWammsHLaURh1RtT0hfLxg/Z8wYApQUA?=
 =?us-ascii?Q?RAMoxXQUHrWExDAX/bFJLzyUKzNQ1rkeSY62x7msYkg/qDmZn+K4aGYjhIyG?=
 =?us-ascii?Q?DOm936XU4kvogThXrP4rC1XHVRe0JHWDob8mfgv+zsLCdV96UiRJ33RBccn3?=
 =?us-ascii?Q?0eYz5VGeIkQt11cjIFhtMk5u5T02VZl8CCDD3U8Bl8jojs7/vFpoMEyZ2Zmt?=
 =?us-ascii?Q?jZMh1dexA5+qgOlpliMcXkSqx9Bz0nOza/nrcvbcAbvanokuKprH+hkQDdcU?=
 =?us-ascii?Q?sUJr+5VBIbB+UKXQ4R6CbWSDo1pxldbozU0LM0UtX7mAs2f5pGLkDV0aBE9o?=
 =?us-ascii?Q?rwHjXapRH96BKXBuUnkhc6wL8VE47Zc1QFMiK9gx7PM/70Gfz4Jis24SV+rt?=
 =?us-ascii?Q?kCfXa4ByybLmCEkW7c3HkZPCkyuyQgh+4x/FAfB4rgLkNljAmlpZnuKzsvM6?=
 =?us-ascii?Q?hiXz7L4tTGd2qDa9eQWNFRjkV2T/xGWchQzbbpKJqGumxXLkxg9qehWA9RPF?=
 =?us-ascii?Q?SRlmX6Z7wDUEOwu9mAkLoNYT9D0UGep5SljxZZK6S1tk7pxv7EpxIKPa/NV+?=
 =?us-ascii?Q?D7HfiHRbsgwx4z53YHHnvDJ64Qtx6VL1lw5TjlgDS8WJykhebCpGTn3g3F6z?=
 =?us-ascii?Q?/7aPtjAOI7Jt6ndWzupYSIyugi6Uo8G3xe7ThHoznCjVvzobIQUbA9HUrbco?=
 =?us-ascii?Q?9b2H2SN3Bn37yj+WIeiWktXajcQUpPIYGskY63rZ1Y8gMVkVpspv3unB+SPO?=
 =?us-ascii?Q?9lyUpZFJmKS12RDM1sRdNNEpt4FeKKmS8Ze1HOmgF/oEetRiwwbtKRdY8qTm?=
 =?us-ascii?Q?dA96Tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ad6d1-3f26-4324-eaf7-08d9e67008df
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:18:31.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhn6hM0d6oCWfKbSY9Xu5dlmSJ1mV73pWfXZTQOvOQpoVzmHI60wfMhN+uT5Or2TTpX0i+uJWLM7yDh98aUYgoTp1Rv7ht6oEE6jcH0/eKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020097
X-Proofpoint-GUID: wWoL8pl5TaFwS9tOUh_JVsToIdvai8fA
X-Proofpoint-ORIG-GUID: wWoL8pl5TaFwS9tOUh_JVsToIdvai8fA
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
index e3d986dd49a1..dfac84876e7a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1848,6 +1848,16 @@ static int console_trylock_spinning(void)
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

