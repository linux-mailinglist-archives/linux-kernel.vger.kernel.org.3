Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D471A49D5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiAZXDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:03:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24634 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233095AbiAZXDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:03:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKZI9O002970;
        Wed, 26 Jan 2022 23:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=pn9j2qaA7d5HEoT3kVLjkRhSOBlzLmlOgsk3PYZ60aM=;
 b=mXSY+BjpyWsHz8/QLftgpLuY6cbU9vjkDd6dU8tbOns1WdABxQmfBfYVGNWGMsKaOkYZ
 8PofmRaRu0VdNtyLJo6mjJz3oZqn45+KYLAmE8jWlfW/IuftSMKfguh5vFG35eSqelXN
 ZYi/bQTbyiom2a0sT2ywwSzLgcy+1UwF3hp+O3p+DkwS1ba377RZ8SBbVJf+0wA5P42+
 ndBZYPOlGmBZCOrdlJfGEzXYPnFwqnOp1FDReoO9dqc0F1s1+oC1dQ3yXjVu31Bgsyk3
 8LBm0QA3aRCxVRCkfMqFOks8SwBUquDAs0wIK+esDn8Ik9621u8/2UzjGaa1CR2MgfoJ PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9que4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QMoU8W151142;
        Wed, 26 Jan 2022 23:02:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3020.oracle.com with ESMTP id 3drbcs2ns1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0nUmhl1/NwEWr/okKHjqASKkVgDIaN3zK4dfq1HiM2SRvNR7xVt8xEWdpoQCjfFHFOZRakJarrA6SEVxcsCMaFUV/kD+dMIarKW//yhaRR0e+INqccGxis2DLlVeKRpecN+8XUDQLvLDJWC50hb1C9SiyyM/RcHt23UzVErYdO3QGng8HddO0sEDE9likmYFDsErXE0HLNzNykVJBKHaEmBzKUWq6dVkD0Tl2Rf1yTbpuJyR8QE0G2+Htv9WDL/Rvw+tAze+0NI/RwkSk9HHo/y/6+/S9kESM+ADPhauP0+G0MQhLrfAVPr7DH9kMF6P30VMY3w3ZZ4PSqgisNkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn9j2qaA7d5HEoT3kVLjkRhSOBlzLmlOgsk3PYZ60aM=;
 b=CaKD5Jc38YdG3rwhO7a/eqEwuf0QtJrOrPEJGX5Yw5jL6LlUS5gWWAncOfdqEYJ5kNAmPi5vhLWE1LaSy++dz2MWcqgZHZjslUK6EjrUL8l1OCrocOoQN6YOCqqH5oj67zlVFkXNzuGkmgNrznJs5TZlQFEgRv+mTbICPtC1mDaM1dsia5lShNgcGGnhnJVOn/xP84wMSdfl251W218tdGrtyttCkmHCON+ZvgUjxXMR2/S1snwDSDAlvWeK4wBU9BcMATUJHo8ykCkRHYZu6/4nnTxefxVEMGWgKxeHdiyqRFugh1m/s77LsRhrdViJaKSP7dJ8ae3cgdHE+cx3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn9j2qaA7d5HEoT3kVLjkRhSOBlzLmlOgsk3PYZ60aM=;
 b=K4sthvbMeYP84XjUyzMxhnfiCAifhu/4PBZQy9SKPK6rAk5KQiy664VbYK+S5KK8g3tNVpN3CVLyIHituQG9Gs/QUtu8rVkoi2vokEYvDiO+BaLnpbRDEOn79i2GZLDC6ElALxmoAldlmPGzxbZMEjxNRWj0BTuILXpXhtd1Jpk=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MWHPR1001MB2350.namprd10.prod.outlook.com (2603:10b6:301:2f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Wed, 26 Jan
 2022 23:02:43 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:02:43 +0000
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
Subject: [PATCH v2 4/4] printk: Drop console_sem during panic
Date:   Wed, 26 Jan 2022 15:02:36 -0800
Message-Id: <20220126230236.750229-5-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0077.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:9::12) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ae66c91-193f-4d29-a71e-08d9e11ff609
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2350:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23503E0072CC01B8DF86D536DB209@MWHPR1001MB2350.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KzLg6KbB6tXKJxXfG4cqrhdaVpZsRm8OwJZx7n2f3qQVXDFn/3LESmtvJ6Yh54tlEeupI4eaYRkyy4RSUUBA3zau0qqqL6stLYA2SBFL/TKufAX5lBu1v2V/t5CqUdsJVWpsvsfMltkv9DUKY4xPab0cyPhphSbHFhbYyzOhM1OSBkIXa7DToOfKeYfW6f3L++F//edi+JuPWcUdvpilHEdZDD4mNZh+HLf+IHL/ptGG0TVyA80bKUHBHVcOhe+9n4xAlDuD9os5Hk43SyS9uxnS3DuXgfJYuvF5Qh6FBg+VT6R86YuN5o0fRcVfC6/Q+0fXZwk5iI0Eidl7sfttt1H2w+9HbD08EcotixQHg/CiZkL4nvmHnOQRM/XfB0zm3tPVoBCiTVHBMGC+rqpAlXORlDre/xFtm4/V4kRqUrE8zQW4EZN+3M82Q4TNcasusu+guMSFKolYMtpATwoMIw4MtY+J700AQYefc28+t7C3UcA2LOfJX/7YmrnxiAhaVz4JdDs+5TxmtQn+5KNq1o/93+V9rlJc8PddbN8lQSr8hReIi108vfSvFpDpD80nHJsA96xT+QLtM+zyZRhksjlJAXNKlA6L5G8OX07HT2UWjfiIDXGLv7X+PREaJjhiCF2cNGg/jU+XTbWDCevTsIcXdvlL/8pof0YE3v7Y6NmQoOlwyfDSWi+cyOmcgsr8VNK5dVCH95H+mI25K7SkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(316002)(110136005)(54906003)(4326008)(5660300002)(83380400001)(38350700002)(1076003)(86362001)(6486002)(6506007)(36756003)(186003)(38100700002)(26005)(8676002)(6512007)(8936002)(508600001)(7416002)(52116002)(103116003)(6666004)(66556008)(66476007)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2vMvD5jZl0CCfnrosCxJq7SeN9Fth7LbbQoDJbcNrx3f6AD8y4KBwCn/V7M?=
 =?us-ascii?Q?H8TvMjUkM0u+SOupDsKnTtGSTCS0crzDkFPNj2qVq9xmHq3ECAxypaBF9d+y?=
 =?us-ascii?Q?2JKtp6t1PpbS/S9pSwftRoRaxiw3o5W2R12daLD0KGhwFbVfev2apuDSaftv?=
 =?us-ascii?Q?eUxNB01/YbpmWV+V6lLFoe23zA9/8LiZ2n2t/a5jfS/sex6ekVcTBP2ki85W?=
 =?us-ascii?Q?ZN8lz+jmh0zqQ7CiQxJkw0P/f2bMsf11sM3Xtyhc6briyT1E3KyiW9bTn0un?=
 =?us-ascii?Q?FVwBlhmiAqQ5CUaUlX+4sVc3B82Rc+afiB3mTeigBhrbvj5+h2AZ11sVDqFf?=
 =?us-ascii?Q?Lk2d1olt6amb01zJlkw9kdRdjH31aVJ/Drp2xfQF8ck51p7HhicW1BidQKAY?=
 =?us-ascii?Q?48CcBST5NBMY7AY9fEN4xq4hoz7yqqvWbTolct3dn24HqIcvr8EVNW25bDF5?=
 =?us-ascii?Q?HICA60u4oP1TkZ2HdiYnyLXMLTUBdIPaDSPCuVlZoXxON1BqcJEUKDdxml/6?=
 =?us-ascii?Q?tgGyY245lsShORzXM17TRc4Y5EOU7iN9PRtoQbXXdNgwPVZW8APQMVyd937P?=
 =?us-ascii?Q?w9vXXNC4AcT20iB+0R1XLPDOExo6S2Bn3StWp7liZg3W88a8LPY4K5psHn2I?=
 =?us-ascii?Q?87EtyjYjBpblZKgoSfokEDNU47xPVZ+/QqiOhbmkx1GTc1qxcB4b6wyyGc1b?=
 =?us-ascii?Q?XFU3Oa76gMfn4pY7t91PKqT9rcGP9HgC6VjkhR/mR+c+dY1FxddvG6/K8nMe?=
 =?us-ascii?Q?HfrZoM1IhLeUGSa8uQZzQorqesnr3ZshN5sVSpRQIp7qcCPquzQD8HmsVFHV?=
 =?us-ascii?Q?f2tpYjtMWHzopWdjS7GPrlkgiWuxEyBUtoeYSTZHZjS2QvbE20XfhAWQFzUG?=
 =?us-ascii?Q?zqOea0vnVEjP1ifUx08DDnCo5ndUptQX31a9FMfpWChfc6tXHSxvGcJuvo+Q?=
 =?us-ascii?Q?MpUpneFtHQMQxSyhtN1bSVmvTjAaBy2/xxsC3wOjA4uLFSI/BKZttFsvvVLB?=
 =?us-ascii?Q?+THveXj6Uh4MXxio+ByMUkQ4ASmF7bKy3cZwG7BZp1/At4PPDtx8YaXCYVFd?=
 =?us-ascii?Q?q3Uk4+yBLNysGT2TvDn/MbkuHOrIqV+nXwWxC7+k5fnaDh5i2ZNFZaTRfoDX?=
 =?us-ascii?Q?NXApOoZF/Ji4MDgwXN7kAXBp4N7joDLi7SbhZ1RwlHJZR4UL+aZF4SOLmviR?=
 =?us-ascii?Q?2OdH0fga0dXOsdh4QX0XUjMytBGukMUyxKn2f0YP/HYdgTVah7lqCdmdjJV7?=
 =?us-ascii?Q?K3kxUzN+bkcSPt0kvds+yC3KcvgjIopUca6MMZQXKI68eBI6p/vh+rm76E5E?=
 =?us-ascii?Q?QwNSgvkMCpS/lX9YDBEMC8A0pu7/UptL3Mw3ozX8OwwBe4Jjwr7udwzB8nuk?=
 =?us-ascii?Q?t++9YLYkS7XpA3VnQXU0R/rqB8dQW7sHQzQouctDlWqtnGfHSF/G3R/yXcLL?=
 =?us-ascii?Q?kjLzj+995Zr0/t1rZJbeF3LqvkI62FZsMBov8QcOfFl8nrJ/yJuFOiq/nOoQ?=
 =?us-ascii?Q?b26UxYt35KFXctqEqfsnT/gzXLsmtNKt/ojkEMP/h/01GZGLmhNB6y07QTna?=
 =?us-ascii?Q?FSP3sO6FBTpXIM8MWDvyTUK4Arab/3PcMY/U+Rxi9tNExHKx/7ucvOXa82r3?=
 =?us-ascii?Q?lKp4SRZr2a746kDmhC5QmmPzPTISy/oaJGMFipZMMvY5qpiP0eFY8N0wvJdO?=
 =?us-ascii?Q?0EILCA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae66c91-193f-4d29-a71e-08d9e11ff609
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:02:43.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOEWEpssSnhckGhim2NHWAy98mTDvtTWx6c0b5ByOrUdkHlsXk1+O9TwACqQA+zjckI51fPTFxCokW7H1MVPrSzsMldgn5fdOO4vON4sF7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2350
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260131
X-Proofpoint-ORIG-GUID: 2s41U2Q95kwGHQukx2LxenAdkaoNDJo1
X-Proofpoint-GUID: 2s41U2Q95kwGHQukx2LxenAdkaoNDJo1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If another CPU is in panic, we are about to be halted. Try to gracefully
abandon the console_sem, leaving it free for the panic CPU to grab.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Notes:
    v2: Factor check out to a helper, and check at the end of
    console_unlock() to prevent retry as well.

 kernel/printk/printk.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 18107db118d4..572363ff716f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2593,6 +2593,25 @@ static int have_callable_console(void)
 	return 0;
 }
 
+/*
+ * Return true when this CPU should unlock console_sem without pushing all
+ * messages to the console. This reduces the chance that the console is
+ * locked when the panic CPU tries to use it.
+ */
+static bool abandon_console_lock_in_panic(void)
+{
+	if (!panic_in_progress())
+		return false;
+
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return atomic_read(&panic_cpu) != raw_smp_processor_id();
+}
+
 /*
  * Can we actually use the console at this time on this cpu?
  *
@@ -2742,6 +2761,10 @@ void console_unlock(void)
 		if (handover)
 			return;
 
+		/* Allow panic_cpu to take over the consoles safely */
+		if (abandon_console_lock_in_panic())
+			break;
+
 		if (do_cond_resched)
 			cond_resched();
 	}
@@ -2759,7 +2782,7 @@ void console_unlock(void)
 	 * flush, no worries.
 	 */
 	retry = prb_read_valid(prb, next_seq, NULL);
-	if (retry && console_trylock())
+	if (retry && !abandon_console_lock_in_panic() && console_trylock())
 		goto again;
 }
 EXPORT_SYMBOL(console_unlock);
-- 
2.30.2

