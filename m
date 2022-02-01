Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668A04A6457
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiBAS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23358 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241960AbiBAS6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:41 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IEL4F008396;
        Tue, 1 Feb 2022 18:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=l0JNnneaAhN4VO+ZeUQ737Ybu/HI7hYZWsY6kSYxKH4=;
 b=LDwfMsqrqswIYUpwcoIESdmIzHfqRVVTC0PI0UcK9+OGEwkFq3o6t36MEUup3/l3EfhT
 ECx7o9OnBF/iFSg6hTQW2WVmb/0r2PkOqNbEfbGYg8go09CH9yvRTUZKylN4FENjmjx7
 FoGZVWwEV/tiTmWJSE6bHpUUut5RRGgR8jhizLb8Ie7Dvbynas+KRCx9Q5yxTDwrTK0R
 GPfJ6+bGA80HhDUbJREZDauP4xk6L0KtP3ebjz5u1xaNlo+Utvm2V1BqFlCLSjikeFGq
 9XghahzP+Z5fh/nwb/UUAxKhX3iSXkXPzY7PgsfkGOBNYaoSDAbC9E0fxZcp4ZyGwdZF zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vby7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211IpA6m162681;
        Tue, 1 Feb 2022 18:58:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3dvwd6qkaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 18:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGuEUhX7L3cJhT0+ujLuIck/U+M++XhShNDnd9e4xaLqJPTbr9KF68mlA6IRaanRu9ST+yd139xeY/teNKjTPwxicUFWNbmoWGZtSCQ6Uuj0KrdRj15Az+0VOI/8z3dw76VsWCnS0zXnqHoHZsEjjjP6Kz510IOJ9Hb/HRMNgAmGpfDLzdbGfCOB8I4sKvgsicjAIuRc0w+gRGWwgJKHaz1FykYpbBN0q7JxHFGChVo2k5BXu2Im5fvyk0+K1bU9Nql75y9Sy7w92JWB0G+E3DpPOWvcKZY2PwRQy0l16AoewxEQfbs3AYEKexs4gbIyuOYKjZast58jDjQ3uP93sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0JNnneaAhN4VO+ZeUQ737Ybu/HI7hYZWsY6kSYxKH4=;
 b=F89GoZm5FzWjcVh/NjX12LC9iWNi3Bnzy9BVrSOCoQeYwqwgd75BUzhkB0l8mW7ihlcA+5twwV+nRtF5JIrJ86XhYDIutlvuuDIi5PTq18PHY1uHwp9b/W1Bka6NkYmmSVgtUAWUsqN+Y9Vvy6+7AsX7VgfY1pVbPeKPSea5U76On+l6qSKTDU/Z6+PcFIcZ+CEmBjNeNvBXIstK4IC3F7quqMo9mBgD0GlTQGoXsZYveZUdxHg1UqjG0XP/5i9A+G7gHUtljOeI+zhdp1IMB/s3meXHC8fy+lLN/pDdnvwnOIfKyhzqXeW0K+esxWHOfgB9f4ZYOrQYTDdVHqp5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0JNnneaAhN4VO+ZeUQ737Ybu/HI7hYZWsY6kSYxKH4=;
 b=j309UfMxpl8AXq/8VbKvl10R09TxBOKIxxjO/Ho9CbLFrzb70f/Ag0jQxtiKAVVz3n0oMGxX0xYnzuQjrQZeGOs0OVQCg6Rw6kZuBiC5bGiMxowvqx++uUZj+xHgPHSklo4WlD3tt/KUgfCY5EgPguBme8tuWvs3vbNhZFxIvr0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:58:12 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 18:58:12 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 2/4] printk: disable optimistic spin during panic
Date:   Tue,  1 Feb 2022 10:58:00 -0800
Message-Id: <20220201185802.98345-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6979920c-06df-4293-054b-08d9e5b4cb6e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB515632973C6F520A4E601156DB269@BLAPR10MB5156.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rb/e82xwmz86OmW1t0kdS6AP9hG8hNh+rClztWqi/GDLUggJ7grkrLr5EKa607f5R0rPrLWa5JQSjmIMZTqZ7b6ixQ8QIc6TbjJfLqeolCtspQ9pWpShNv1t7JoK3pZZErSUfGNUn/UGhocOkpiOWSkNZoxhvBVkzHwOKUUm028y9UZ79gcCKFz/7f6A/IMnxNH6tPa08iNL2Qf9XAfYkb3mKdnVyDxSbp16JPqEsBpB1qPrX0PUgqxpSQW2XoMPcjC99Sf9+4ZTQP8dGQBtddDhH9FcXTEB10ufGoX1dUjp6ybuWd4szl9NrZeIK0l9t23LfuVhkN1QL3hdJsWebnCPavrM+cz3hlr7KZj2kllw0lvdI/L+I4F+KVvwA0pCBO9O0o0DD1x2k4HEzJ0wc+CDKdKsxSMKbuX40g/QUqHwS6YT7Tj042N6PcfVlGp8fTf4zsFcWSsDyYMCR2fe9A+qvkT8Z1jd6ne0mkraT4R7B9JX3F5+GhK6IdV/r8SRuSjOkM8yowYCYX9Expu5MKFMGRO+JbHiZavE+K3ISD0qKe+g3AcmMJncqaRKaYjOSahzwKps/3510Fw4lRy8QjOwLC0eip5y22xQgON6pEC3fSX5HdJ/P1AMyUfaT+Fx7iwOq9nHhyf40aemegVLA5TmhMNpaKxa/nERqTQ0AVNALtCMifGPcekyyVjfAF+aqxpQZqgO0qweUQqt6IVr7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(103116003)(6512007)(6506007)(6666004)(508600001)(66946007)(4326008)(66556008)(8676002)(8936002)(54906003)(110136005)(26005)(186003)(316002)(66476007)(6486002)(83380400001)(1076003)(38100700002)(38350700002)(2906002)(2616005)(86362001)(36756003)(107886003)(5660300002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPodl36N7iFlTTbhCMiu5HkpG2fxEb3df+cO6fiYzBcmS9mAQYRhwownCoB+?=
 =?us-ascii?Q?8N0z5C8SHw0+v1cL6ofdU/YwB+Ljnn3z8RwUDEVyI85uw65wu84MWT1aB162?=
 =?us-ascii?Q?i/0xethrUDeuBHASBv2si5V1c+JXlOxsoHUEa5GUKPLSOLcB3lIAnWAymQdb?=
 =?us-ascii?Q?GP3Zqb5tM1oo1UP6C+vN9vGd2+/YJM4Q7f6iD/5jmJtseOivIMhtso97uUuO?=
 =?us-ascii?Q?VZzQPx4M8SlBcSOcNgPrUq71rj1iScCMUyB5cj99wVXvZNQ2e/RlMQzkmugY?=
 =?us-ascii?Q?N41BdHcvvUAuTtN38GFTI33M5cLf+Fml90aBYUBJZeJHh5PtcKE0zHwbhZvr?=
 =?us-ascii?Q?cOp+tlmBSW4rwxi/6g6Od9q3flv3zJho1IVEQ5NshnIj7gNmf2b7rlQj3jEc?=
 =?us-ascii?Q?6XI1rS5o4k/sUh6nmMgvGddz5TFlQ9Y0CtULqG3Y1a60uYYqWAttCo79GbR3?=
 =?us-ascii?Q?fsuEy+hbOf4R9gJ2HKC0V5WiZO0Ux8x2jjyma/Qb7ruZU4O5YgASiMKyvFQU?=
 =?us-ascii?Q?tbwC12aVsYoMQaYvMEsUfufsCD5gO+tnR7sh0iy1/ejdoCONxeywmUQZLF+7?=
 =?us-ascii?Q?MiznEP9F5QmMZJsjJN0tEJhaq7eodPknxDT+mEuqK4I1uGvkH3e+TWAfcfRQ?=
 =?us-ascii?Q?X/AQgWuuYn327KsnkBPUFBDw6N4Vv+1JJZ4+7gn1DoEqs/nzTMLPI8WhZ7aP?=
 =?us-ascii?Q?/blyIBO+QFPBLUz6d0V7QHfe7sdwd/BQ4vNVYo2Vjxgq6GliSpNz7fxe9uRw?=
 =?us-ascii?Q?HN9MTieQW+stILV7JuhNWW8M07iBhGgBtb3xc6H10+4AlwhySVpcxySu/36D?=
 =?us-ascii?Q?nspsorZ0IpLzSWpBAIWaXbPW42rMsDQTiI1DQ8aqtu/6NWjjb4mz1sKqKse/?=
 =?us-ascii?Q?GLd/Y2Q8b18ZpscRCyMTxH4WZcnK8AiPt/+PnL3SuPm1R1zjPYEqhMxy6cCw?=
 =?us-ascii?Q?QP4JhIEwjKrofJ9yBV7VaQR1XK9HHgYd1s4c7gIHXYj6wIct16uiN/vnDgzw?=
 =?us-ascii?Q?RlJA01vuGpVP3d+CCb9871QvVVjHcHp/+hrWVOjv2EmSCCDOc7UHXhes+nUV?=
 =?us-ascii?Q?He2mQ5CXfulaGMoIFvN3wYFPt0Axqy4cyeGVE892py9DrHfYYPq9gpbZb4dS?=
 =?us-ascii?Q?AoC29sU/cWu+iyNBPp8384VavsFn+SNvqBi5DQn26iI+DmeFT+4XLekaNJUi?=
 =?us-ascii?Q?8rP0A49Zsb9wPk+Gg428cpH5vdyHNqN0IY7jP7nPcP76zBNc/gA46Jt1LM9y?=
 =?us-ascii?Q?V9XdnY1MRFjuOF18BPmHSLmENZsgI9m+veS740zweBCpGZVHl9Z9e3w8/PSA?=
 =?us-ascii?Q?R/WwGGgbiAfMVNM8knjRjs5i9KqpZgh8V11bNsK7LUxDboe34oqGAjPCTNq1?=
 =?us-ascii?Q?uk1BMjRSWyjzLCujC3cIR04EkJIrGYsaH5uDKWTl5oBb2c3TNPAUV/BVXRaV?=
 =?us-ascii?Q?1oJ+BKJZzQ79t7O8pv/nBif76vbPR5xInw/rHoWQNHIw/1Boo/yq2h4mOQ8n?=
 =?us-ascii?Q?3UXP5mzXtYawDw7XiqPYJoLY0KqUaBxTIYIHFgPR1SlDrMjY368LSsSwSsNU?=
 =?us-ascii?Q?bIW5VDKeuln1+TaqmAfcTXrktvpBCUVxK/oLjUeAPhpCrvDXcTVxMD2sSLTh?=
 =?us-ascii?Q?7tG4MYOYJcW4QcnzcFwPt8OpUnuIkoDZomAdn2sq9wclrBEEkgvJwqTX/CUG?=
 =?us-ascii?Q?+7eiuQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6979920c-06df-4293-054b-08d9e5b4cb6e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:58:12.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXPX+GpM2wsKlrDcJD6z8fy9iSpuLqq45oenEqKFO/1iaC/31nrJFA8EeupSOhWbNIzXehPFunD/prT9KAZbqq5ZBEmLjKU/I7K/EN8Dzjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010106
X-Proofpoint-ORIG-GUID: njTyVR6Vx4K2mQB0cWT7ggtpV6I7EBMa
X-Proofpoint-GUID: njTyVR6Vx4K2mQB0cWT7ggtpV6I7EBMa
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
index b33c2861a8fc..1b96166eea35 100644
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

