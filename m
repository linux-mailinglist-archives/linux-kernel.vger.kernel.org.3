Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B0F496569
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiAUTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:03:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6944 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231558AbiAUTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:03:03 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGxFSP031049;
        Fri, 21 Jan 2022 19:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=0L13pwsIgGoVT4ayl7ss4kDAewGzM7aPF32rYuNhKUg=;
 b=mYDxuXUsZBUcw1aU7MzUZYsr8BnAwUmGxY9v7Uz+Y+0MeIgVhhPAbho5ISKNOk6i2r20
 Z9qnDd0egH+PQJw9KcBZicISNk3SNt7ymtwxSHpnOJEbwnvtPNQhhVgx2wINzxuJkh+P
 MhxTSlCjaH3VEgi7DFuhVChk9ZAoPHglkhyiTCTPwho1K1Z5K1jaF7Tx3KPcRpZdYJiR
 MW5E6UH0lccbp/7jfMnemJvcaZVcszT4+FwZUMDVxF5G8M25r7dZ/nMwc8Ux7oaQdAsC
 V6+3GlMqiipmACA7P15Su4zXrIyBRI9cHOME64Ojy1cb5tTQV+teqoIqWhtqgOU74z1l iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhycjaak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJ0DmB181197;
        Fri, 21 Jan 2022 19:02:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 3dqj0nenad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRHOBu0/cp0ka1WpPMHMsHHWCRhv+JAG+GDdQD4+2YJKpdBFr6sh0QKMhUWbOqWG6NFM173JFXM8Iv2mj2JnFgxBKVOY1/EHGla2kK/p1sktIuB8NAgoUZOctUOhQcwkqkKVC/WP3T+iOpL0CYFisW+MQ0UmJ2JIKcq8XPky3uT39xmIW2vUwY2+SciRInOi46TBShV9w9I8fP0S+mVYJe7d1qvt4MNb+v01n6txb+TyEDBngWd26yjIB5kBD8/iTT25UXL1sngqskEUqwW5zoJxOx7SnHQTm+y6ZPvmuECXl1pO8FaQtEdGL+IMa0KVH87t28jD7RsfQuHi3tOvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L13pwsIgGoVT4ayl7ss4kDAewGzM7aPF32rYuNhKUg=;
 b=XHmgIpWQh2SVcAKFUaGgvNpdZR5q2bbCvKpP7Zk8pAfL7SFY8I+qPjzzI1QhVoau4uy9xw7WnhCGweYsa3XyDgzXQt7EoIx9ux84eRhPs8vD3U2JGqttSax3rTzs5i0UlqlD5o4yk0tVuhzI5nC/IbksNv6kgRkGcT97wcKl9l5BYHG2UJ2bHsgBwSQiol8+oJ/+p72Q5nibFMjuah3jl+K5Fo7lVHyTXpwNvMpZESUoHCco7YXkl6KciTGwEF+HqEThjvJLlfTKVCpP1W3tzErkiz1iXY9IDvnykkxbX2Yuuko72dR7oIyt55ct7nGvl5tZboZxZ8MWybwXjJSURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L13pwsIgGoVT4ayl7ss4kDAewGzM7aPF32rYuNhKUg=;
 b=EZ4qBYOkzh5+fHAjlAvfxFbTLc4na2YN7innd3CRDiGSEw3Fbw9imzknOHLATWmsq+N0dtWx9/wG6vxB591Z8r2nL3rI23iJ8NkhsDCMNIUDibHpDJFsHw0/yV6ymTSyKfZSERbVbqtWMaw+w+GIJc4DTdbJoKxb8V6bJGxxueQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 19:02:37 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:02:37 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] printk: Drop console_sem during panic
Date:   Fri, 21 Jan 2022 11:02:22 -0800
Message-Id: <20220121190222.572694-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:806:6f::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a31c96-226f-4ffe-0f69-08d9dd109726
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3434068CE97D45DE8A44E2A0DB5B9@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEyqV60jNw32j274nCW8Jj4GU7T23JioZLDo6yBkOTVdN4J/QtjkSv5ulEXeum+LMU68FBUdqioSFfdFuGah38P3/Jt5JvD4TQcMdhl4tMs59GNJGYd6q1A/fQ8ghYYnxixcTCxoByM7+dvVeyvOVF43nVtVPotbBUlPWOixhWv4+kv92qkXOriQxlNirUXEqC5u3fSEzQXNETlKUhHrycDTf2n5UpIEiYI/A3sqRQgqrJduspwlmXctAChQDqESQR3QORvhY9am2PuuyNer6hCOFbkDwr1c2RlecO/FvDiXn/9YBCpWb6CmiilRet0S7rUKbYb4GykU9DQ3pPCHDIVYqPVpLueuVmkOGVZQNhFrcivykXmjjVvR5fBJKbCSXfUagfUnaVWOlk9BgrhOeIe/4wNWLC0AFfcT5o6QsO6/1mqVT5S4GP0V2POabxDtuGStgTp70eQXaWZuZMha1LHdsOBUDFRIeuXlSkQnZcBAYOSpJp0WDvPasdfQCaV+tqfw3fpBMV2nb8id3xB2pB41+9USzZenrExsZIzvgE/QgOu/PymnQ9hkZ3cD12zywgExr5fsrPjOA+0vUMjJ3Dr23wTM5CoAz2o9egZgbBAG8T2jK0TYml9TAYa9fRUOMplGHZPZgEqQhxqfpkHkpxZFslpoZH3jZHBnWpnp1Pxvl0HbUcsvQ9EamWVnDeJQ7rkd95P3yjM/wc/oKAaZog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(316002)(8936002)(54906003)(5660300002)(103116003)(8676002)(38100700002)(6486002)(38350700002)(86362001)(110136005)(508600001)(6512007)(6506007)(36756003)(26005)(83380400001)(186003)(6666004)(2616005)(66556008)(52116002)(66476007)(4744005)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uE0KKRr7tU68QkiEMzd6T06qG+Vi1aYkuCn1aul4PQLlXEcsX6a6u/vqHHW?=
 =?us-ascii?Q?bTtSeE/RYVwli/e3mIPuOqLg+NJ08ZP6cSxnGpo2PFp6RzaczFFuxePXNw8g?=
 =?us-ascii?Q?fnFkaaCS+/5qTaEwbFcoZ7UJFJPIzzSiMCsdUDnB1jbII5jqO6iETGqZNzAf?=
 =?us-ascii?Q?KIuqosQ1f0AJBP0G7cEFBhi4h5CJMsksDpn0/ST1OYzQWU2pSSjyul67q0pN?=
 =?us-ascii?Q?A1NACU0gT05a+FHzNXAyGqtVfDSQXxNUwDdAlBB6bMDPm5wgrBuWg/GG32nZ?=
 =?us-ascii?Q?+yJdWGxagpIRpQFS95QMCcQ3xPT5j9MzQxFLqgH6qP+dOWx7ZqKgXGk3H1Rd?=
 =?us-ascii?Q?rlXG3VX9/Myf0d/QROzZSIdqXu1gDfOwzosJ+KEFocwHRAw5fbmWbjWNzuFR?=
 =?us-ascii?Q?Vr6bRfYSpJUPwKjgIcE/X2v/lE+VVRxPgg0odBo2ONCKRfz5O7AY63/HVmiY?=
 =?us-ascii?Q?TWuDUAnUgxaI+fnu/PtuEEukwJ2b1xJrz8ocM4nD+axoegaLNj1hD+HRo6h9?=
 =?us-ascii?Q?V2qwRQ4IxlVbbVZ5xdO2jNiAhg9JN41r5m1clh+V1/S2oS6i76byrQTPovZe?=
 =?us-ascii?Q?AWBe4FCPMVaevt50LTZFWoJP/MibZwu0/gSAUhaF5LY4lFpiibxtHIe9l4lt?=
 =?us-ascii?Q?0nHKjJVXxnXuNonTpdHVrlehzOgQ/jQZjmYgHb6JHaeHsg5x53vdJH4yLULz?=
 =?us-ascii?Q?WUcKkETar9x+SXXJsZBTONlFEFIcpeziYOYfqHEGfS5cKS9g3WkhKzibny1p?=
 =?us-ascii?Q?XfOX5Yd3E5+KTwnmybI4AIEoby6RCwgfuVzVnKVOk+FKPcWj0ic/hZxZAe0H?=
 =?us-ascii?Q?LMTPzcsYW+NmFMq1NTNXowZ2klPjinLWoUz6SMiJLuW38SSWPV8AE8elW4pn?=
 =?us-ascii?Q?G9TeYWfIHZ/iNOLwqijr6kqhg+QeOsF5jdup3xN0nad4X1aZe1nBj8XO9bBS?=
 =?us-ascii?Q?hRmU6SGjEhSKVFVOThi7s+rXrYSO1Ot05JlBM/quleXrdE5w8Pcm6+OOwa8r?=
 =?us-ascii?Q?CxEMpAPqtuiYCybwcNImsFAW+dZU3UMqg/xoMIIeE3b5Ort3RynjUkfi9rN7?=
 =?us-ascii?Q?xZfxkQQH9lfmrhFhtJclHxVdo1EHo2wH6u+lgGaD4sLXdRiDd3ag2mLCIW2j?=
 =?us-ascii?Q?tONU5+ImXM7ZHjKSRO1ipju3QI+ACVm5coQ16f6xOuQgicqjvqnslRk2dJ1l?=
 =?us-ascii?Q?FK/3Ox1Plwa+hxqTQjbrMjlQLGu/5As0ZGU5WC5FVajypWE1b008xtfLoKII?=
 =?us-ascii?Q?GELw+txZPyrwZE6fB4wz7xrHvFfG6HT6bOetb07J4mxW3kf2amTDKQP/H9cC?=
 =?us-ascii?Q?GK9OUHV6YgXcaAr89pjiqmt6ru/71pjwhxNXPy3CRtC20ADInVwo5iFuoj4o?=
 =?us-ascii?Q?XD7gmKX+6bxQvq6dtKiCNBruLCu3OugBhLek0f6noIY3A6+SJGhDYfuQR4Sw?=
 =?us-ascii?Q?RH872K+z1xkz+IWkfQd76+uBPV3/uqWU5XEGlYqYlnuPTMLeSouCZ1LIYT6R?=
 =?us-ascii?Q?w4bb0UgjuGrIhd19dEzzG4Ua2P9ujgajiAztbZpVwpFKakQWicvyImpobHyg?=
 =?us-ascii?Q?2zjX19iiOAxb74GwZVQdUEBla/cYWi87WD3vsrKb9IuYdX+uLkDxQp/2K0Rd?=
 =?us-ascii?Q?bIVCtH7ZCxLC9iC4eSD9a688gBszEZMCco1QP/P5ecGD3KzbJ2oYR/a00+tT?=
 =?us-ascii?Q?+Pigxw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a31c96-226f-4ffe-0f69-08d9dd109726
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 19:02:37.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSCrsduLmf8mUCA2pm6WKs0M/qDeRBALRI+dLZEOZx+PtudL2RaVdBKIq6CRA9hxwpvl2bVq3WT6UL7e6LKH4D1gMz80rb0jzW5nGQeCDK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=826 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210124
X-Proofpoint-ORIG-GUID: 1kHmDSndQWwlKHBis7vndhf1egauh7zq
X-Proofpoint-GUID: 1kHmDSndQWwlKHBis7vndhf1egauh7zq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If another CPU is in panic, we are about to be halted. Try to gracefully
drop console_sem and allow the panic CPU to grab it easily.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/printk/printk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca253ac07615..c2dc8ebd9509 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2668,7 +2668,7 @@ void console_unlock(void)
 
 	for (;;) {
 		size_t ext_len = 0;
-		int handover;
+		int handover, pcpu;
 		size_t len;
 
 skip:
@@ -2739,6 +2739,12 @@ void console_unlock(void)
 		if (handover)
 			return;
 
+		/* Allow panic_cpu to take over the consoles safely */
+		pcpu = atomic_read(&panic_cpu);
+		if (unlikely(pcpu != PANIC_CPU_INVALID &&
+		    pcpu != raw_smp_processor_id()))
+			break;
+
 		if (do_cond_resched)
 			cond_resched();
 	}
-- 
2.30.2

