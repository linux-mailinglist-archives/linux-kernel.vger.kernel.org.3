Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3647E8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbhLWVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:04:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1962 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245175AbhLWVEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:04:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNJSjPP017919;
        Thu, 23 Dec 2021 21:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=+AfYHJrm1ZIci0la2y/BhWrd0qj7Y4fb1MBBaPEIbDc=;
 b=Xn0DzaaMeZtgFMXGgjbE9tkDWsIsfY1FDJkkxkYdEJ7kgLZWW3EykEGvQQZRtnsmvJOw
 jussbvf/529n/kXJZ1BbVEqAv4nGIDr8xzja/lzou6hONMbpPIs3O1tliYCR98mDb+pv
 uXPcKrLcHqMXz5S5vKiK2VmhyzKaiolqcFW1QB4D8QVnMINqLMRKUOl5yhJGw+Tv47Jk
 jAr8VZ4t6JQKdbYvpJZd+PL7yR97DUtBnm9WoPjuSda2WpOxFXVZAQXYl7djyn0Kvj9W
 ITqBcKWQSQWfIZDYOL9GprcMz4guc+SpdZIifpZQExcmcb945tU0/LD8QceEZI2hoxGQ KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d46rm44sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 21:03:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNL15rQ108729;
        Thu, 23 Dec 2021 21:03:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3d14s0kx8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 21:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzdvWZ3KkGzEZJgJjEpDzq5tMgUf0YxTYspwwjnGJZOQglZBf05aACARrO7yWdrg/cknW2OWKkXm7tTsoPJDekfMElkLZV8EI1JtHbFiGa1zHPsqh4fyOhEDucWcWjiqSpLkCCjbVDurgzQ7Sl8uVT8N907H3BD+MhWo6uWV5HZsLTp9uFPhKyarxejDK/sNAUoYZy/whkMe52ntFLt9pFTYZGvdm1aNuxVis50AtxU+DRcsp/Pb6tFnW3AMqfxgdXjWD4Sue+jw8idke8ll7w2T+0DwP0ely37nnIb/7KrdAnn2cGHk6D1JigmAX7AFa6Zs8UtwmrDxFMtGi7SN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AfYHJrm1ZIci0la2y/BhWrd0qj7Y4fb1MBBaPEIbDc=;
 b=Es4/7XWwNgyt02d53Z0BfBznMyFNG0RY9ql4Hw2WzzSzO3M+V4KK6jRd7W+K82aAJt4Hr02MqmJYp3Ob7NnkyHY4j5zGF+u7or6C5fwcvXyu63S2GVTz3XqBueTkrBsheFJj0D5dQbY21e/Wz/wX0KgOxFRgvfDxty0uyecGZifU6FHTHzlUYOQXcdZEroDfhEghjs6hSlbvgr4Ph/Vc6aoxUyc0jTA1vE53N1B0EHDuzUQQJ/0d/W4FBiMOyOpe4GLz8MydYEzYSQnGWxyyFfokyrsLjCZBY6ST47A47YQDGzwY86ew0/QcLzSEADEWmeP63Nw9LeO836+ibRpODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AfYHJrm1ZIci0la2y/BhWrd0qj7Y4fb1MBBaPEIbDc=;
 b=EuJZLWzAylMg4DfN5xG+oOgFsM7obBCWIhf+aiLqzBf+3IJlrK1qFqBwJRZa7J/zxaR94GitKYyom3bBQ0+MlZ64e+H/iZMN4F3m9bZiBJWmJZwy/GW5vOcG2LZhoe2Okg0aZwWh1HHVXTT2cLIqLOWdJ6b9+FCy71qjJs8Z6ZQ=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BYAPR10MB2613.namprd10.prod.outlook.com (2603:10b6:a02:b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 21:03:52 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::91ce:8d4f:e5d1:c67b%7]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 21:03:52 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        rafael.j.wysocki@intel.com, vkuznets@redhat.com,
        alison.schofield@intel.com, tim.c.chen@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        longpeng2@huawei.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/1] x86/smpboot: check cpu_initialized_mask first after returning from schedule()
Date:   Thu, 23 Dec 2021 13:03:43 -0800
Message-Id: <20211223210343.1116-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0017.prod.exchangelabs.com (2603:10b6:804:2::27)
 To BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f62abd-68f6-46c8-a57c-08d9c657b8fd
X-MS-TrafficTypeDiagnostic: BYAPR10MB2613:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB26130F12DFEF084D3D639DA4F07E9@BYAPR10MB2613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJGaYicRfoQWva+LnSASjpQh74J+ogLlWJl8nz77R3lEI/mnI0+eN1GtmjPOz7yXDgj9tsGVB82EHrSC/bHvv2CJ4aVfT8UWesd47Y+Hw6Jn/kicxYxqEiOUthiDRxzD8vFTM0n9bShCTb7M5Sffe+3koda4PyY/qHTwUD8kfYfaQch7cdKXI8wds/3QyE2jg+55UGPnd/li21vWYQ+xT0dne7lUSBL0UeED0AKnvQKz2+OSoBgZi+oy693ufyRaF4zzjUenE9wop0dPQkZcX+/Yx6R+CIdZEt1L2mmi6mRHaS6cD6PC8sONMrxHN8J4bFKFsLJoOxutfHfCKweRHANqYbZzUq219TeEPg/r24qQJkMVsYiumSKmZ1Yqiocxk0yoX9smG3JX/K1CPm/kd4fEB/UFlgG530yJ44+4bfjhPgBQXEZhvRRtxOueqQMj99XyTPYHfx8hRNPIcKbimwJk6NsFWam1iel3CqAwIvQ78tU+goHSoH/rtdS7US6zPpcAH4SEZPW8lOpkQ0v3ELGKd1U+WqGtDhEu3iw/M9Dhni2OOviJ9J+G8hHd9n8M8+x89eqROOUXwzrZccmyXGhDk9dVE1moJpLH9eeKtqo1OhFFQrUmT3dmAYmARsKGRlfaoiGeeBWsLQBcmBau90XGImjnllVds9WtbKQoLTpglvv1x0cv+i6bam9qaE2Q2zQARTJ/YTmZ8L+B4utDOys6aed2uJVdJvCknCYCSiowoPjSVRf7Ggo4t4/WK/TyT8+CulTBEYnYiRPf7OWrTLLRHQ7r5NRyegOcheIQ0P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(6916009)(66946007)(2906002)(6506007)(966005)(7416002)(6512007)(1076003)(508600001)(186003)(8676002)(316002)(83380400001)(26005)(5660300002)(6666004)(86362001)(8936002)(44832011)(66556008)(66476007)(38100700002)(38350700002)(4326008)(2616005)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyqjAW6VNLYoPCHctG+HLZZM2iuDIkM1JcMyZpOzdVf7SEWHV0B1AfIt9+ch?=
 =?us-ascii?Q?P/tY64AiCd1HVydzD9VtY2V6RCDhsAc3oaxXXBOf2WkX31sCt8l8XyYOEKvd?=
 =?us-ascii?Q?BJqVTksspjImOef+r51YvdHfPB4WSzYz3QtTDebRxJz+Lwzo7caw+Lmo589g?=
 =?us-ascii?Q?IxzS+g06odqj2aFrtY8mWlrb9RoPC/frZTw162y86amfaI2Xcnk7Af7m6L9R?=
 =?us-ascii?Q?S6XwH5LGQaBiz9Z/9tgpsI2cBoTAW4YbLGXEfu4l0QmgDvGaqZ8IpzAZPakw?=
 =?us-ascii?Q?V0Krc/6/xO2GGve2FXvLdzqeNPJVC/FGsKVsrj9LMKHUNRZadSA+XyndUi9Q?=
 =?us-ascii?Q?y8K2xDUNk8S0giAyDWNL3oP6Hn5wdQ9OlT5p8YViqVLJw+o1Lgy6R18/HEzH?=
 =?us-ascii?Q?DIqRknI0wuyHaHYQ9GHtld1oml/SobHVYuj6L3Av0liVZCo/pEayDzdcYTDC?=
 =?us-ascii?Q?3dQMPVk4w417AjrHl64k8miTegJop8JLPvB6OBo33WpP2e0Xm2P7iMhSp8Ov?=
 =?us-ascii?Q?YME1eZl5/YFglr2lgyTp74mQF+8FYrFsLLxOFGdSCrI8HAy0NkD5q/3wBXPX?=
 =?us-ascii?Q?exB2Ets8Hsuof4zFzQAQdlD0AG1NN8+al0ZgnQcxqtdWlWWPgXOp/mQpVGaT?=
 =?us-ascii?Q?VtIj+pN05WrGT5M8fVACzo7KUgSVY3npjxOK0RwqgQl2xsA4YRGkXrHOp5e3?=
 =?us-ascii?Q?YpvScUU3tSJVqLo2G5mjmCeymO2kyJRDCpzeFFNchlNsDYpqJQb6leKvvIbE?=
 =?us-ascii?Q?cMM4/Jo5bkidJ1BCESMlaKUwIi2GspPbqZBvQyFGApzE/f6vUXN4aRJwSM6L?=
 =?us-ascii?Q?mWnTiwqrvLRwMusahvp3WCEYEd0cXEDFRylIwVLHnc7B8Asxzfv/pF5Bq6a3?=
 =?us-ascii?Q?FFCX9CUWwAhCaekkXEBL9voBxzXtV7c2qi8KPB4I++5j8WPqkDe9zoLj3GhL?=
 =?us-ascii?Q?0HAKhXuiW8wd4OWcEHltC7L3b196eKCw2ATpc6npnod1b1orOkLeMKDlNGhA?=
 =?us-ascii?Q?8LsXwgTDXrHYIXDSdUm3ooIpoiX/Th3ogAPMFmQx80ItaW5/sgto9wDJ5k1M?=
 =?us-ascii?Q?excaHvNRAswpi4Ydgwu3hkWY85VsQWrkCd4pM3N8Mux5seMefwuSIK2dRLEo?=
 =?us-ascii?Q?oqqFaDuMQLxJ9O1zmb9YaPFWkJyvpz8le/7KVUK+q+eNTu/bobbpMovWYnUY?=
 =?us-ascii?Q?R2SDLyOtVrHhLHFo1Pe46zeaLY4qSMaTux4vBNf2jxiOhiZs0anCMUD1tehI?=
 =?us-ascii?Q?rO+OsEjGo5huk69PEFHQfjbB6GSh6rwghweFVmM0kNaHmhvpMbAjsxZZpkZs?=
 =?us-ascii?Q?kjuaVaytSG6msP/rW3ByxvgVyZC4tXUInEDyvJYL2TMX95SaZJgNIcpra4Na?=
 =?us-ascii?Q?e7pp8CRFTdQWbp13mGhRrc6mUsfLz7BVTAzP5jBwOi9ngj3O3X5WmlXdEL6i?=
 =?us-ascii?Q?cll2U2lfeHYYEbUKpVqpWGocEM8Z9xdTuHK2dT8u2gyhU2jKT2tynYKkwa6D?=
 =?us-ascii?Q?cvxQpLVaNZIafYvjn7PT0hM5yRpMvficc4297IJY3jQe4xOjozppLrtn5hJk?=
 =?us-ascii?Q?AgEXGwVKm3D5jbPfRz6EeRo36sdPQ8tWGTUrOD20K7ZKCJ9KFWopyQl8hMnA?=
 =?us-ascii?Q?7wpKfE9NKFMeWgEizCwBqxE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f62abd-68f6-46c8-a57c-08d9c657b8fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 21:03:51.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjB+YcvAdFfNzIiFD90ap9/D9la4fHlhzhIRKbzlO/aA3H4sjIoFaA8fa/xCs35jX9DMGlW18MN2TENqQCRyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2613
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10207 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230106
X-Proofpoint-GUID: Qc08lX2TVYFiizlvHvQjsSgGjShV-h_f
X-Proofpoint-ORIG-GUID: Qc08lX2TVYFiizlvHvQjsSgGjShV-h_f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To online a new CPU, the master CPU signals the secondary and waits for at
most 10 seconds until cpu_initialized_mask is set by the secondary CPU.
There is a case that the master CPU fails the online when it takes 10+
seconds for schedule() to return (although the cpu_initialized_mask is
already set by the secondary CPU).

1. The master CPU signals the secondary CPU in do_boot_cpu().

2. As the cpu_initialized_mask is still not set, the master CPU reschedules
via schedule().

3. Suppose it takes 10+ seconds until schedule() returns due to performance
issue. The secondary CPU sets the cpu_initialized_mask during those 10+
seconds.

4. Once the schedule() at the master CPU returns, although the
cpu_initialized_mask is set, the time_before(jiffies, timeout) fails. As a
result, the master CPU regards this as failure.

[   51.983296] smpboot: do_boot_cpu failed(-1) to wakeup CPU#4

5. Since the secondary CPU is stuck at state CPU_UP_PREPARE, any further
online operation will fail by cpu_check_up_prepare(), unless the below
patch set is applied.

https://lore.kernel.org/all/20211206152034.2150770-1-bigeasy@linutronix.de/

This issue is resolved by always first checking whether the secondary CPU
has set cpu_initialized_mask.

Cc: Longpeng(Mike) <longpeng2@huawei.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
To resend by Cc linux-kernel@vger.kernel.org as well.

 arch/x86/kernel/smpboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f4619f..faad4fcf67eb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1145,7 +1145,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		 */
 		boot_error = -1;
 		timeout = jiffies + 10*HZ;
-		while (time_before(jiffies, timeout)) {
+		while (true) {
 			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
 				/*
 				 * Tell AP to proceed with initialization
@@ -1154,6 +1154,10 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 				boot_error = 0;
 				break;
 			}
+
+			if (time_after_eq(jiffies, timeout))
+				break;
+
 			schedule();
 		}
 	}
-- 
2.17.1

