Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678FD496563
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiAUTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:02:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47176 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230332AbiAUTCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:02:53 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGwlHm008938;
        Fri, 21 Jan 2022 19:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lbXTetsfULxeYtQMGDIeyAgumEu41SQFgH07KVy0vgM=;
 b=rCY85e5k6CQE/HaGnaVSy8N0SJLkoeUmEfgzybM9dQ8W5MkWLsPqkqLiA2UVijVWxZ2s
 560ThW+WB4TtsCmRHVWmPCcmB3xKi7+5vw/+N42FzPvWUn0LyTJHzSl61RiDmTKM9myL
 6L6wHiuATHfA7jPqUt5U2xOivGPmDEuEa+0uLTg0zX0k7/zKo1zEmSGZaJvi+NjbD0ga
 MjAz04M+JPbedy2soppqY0T3Tk7KsNDPZB5annv2EXj4dL4uRXivEXTRqPhQJgMsn+jE
 7vE/Cea1bKj/jyqfieVdtFb/oqtbBecjmHTuTy9/M1f7VRdce5i/Ksedxr+Wi0dKTE/l LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9tbgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJ0X8M184117;
        Fri, 21 Jan 2022 19:02:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3020.oracle.com with ESMTP id 3dqj0tetxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJF/lZtBk+r2UNmYwzJ4FOAiScoLNXm9plDoTNpJ6qBwHRN4XFqghhxtOE5fN3b5W2Tq+8yDqm4HYwploGw80mxAWtJWw6koEf9bby+CwJz9C6v6pqrzUvIJZIMYgI83MpA6E22Fd782g5Di2Q07wiT1ll/dmvEHhTCXpR60H3tKB5xgI8OcLl4BC/hiNJYQ5ShqjIM2KSURzeED+6ZSWnGxp7RW6dUMCOj1vVl6tcfiVbeUgw+uEhlBurduF8yfuLCSm8ta/hK7v0eyTF7ChEIYeAr7AxxTSe0Y9UlTlgzXISfQ2tuO2jBH3Y+Fk4hG/L8NPtfXj1pWZc62rBOhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbXTetsfULxeYtQMGDIeyAgumEu41SQFgH07KVy0vgM=;
 b=AbzEjfMNsVF+UEoGwYxdCJ53rws9PLg6hZ2044LNSFfkZGDtQgiYaFCiqr3tE9HTSLOLqB6VX44wJrnt4kbZtD/RJRD6Gxt76KBb8JfLUawbX7csUWVUaOqSQolKaGsH8YByuVgIYJC2aDzyfpxnByTw/IoZ5ylLsSAeKyfMUo4mcnezFvgMCV6O/YvSFmXoyQHt763gwJ+arZ5x6ZbCGMYaHXGa6+pT5CvQkcYwD7sLRzNmn8/DHEs+BLQKtRd/XqYP+pbABGTVZjki4YPmgO1IOSDWWHLFbyuOBFtJTc96tynh/5f/5yDLRAblanRHnl1/g4AXLnALTBI9lRH60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbXTetsfULxeYtQMGDIeyAgumEu41SQFgH07KVy0vgM=;
 b=cSF3gLeXMqd8V5obozDuGLMv9yL6hA5xW6mC/8E/W4AZ/XifB5qfiow+7lpEWS2RiRiLoM8GQ/7sfWfyffAfHC3DhaJB5D3xO6PgwfXrCcpIQeag5YKRouVRIhKfod6DlBlRkLXbEL15xzHypWRBhwCVLlEbAwmYYg41+m33WhU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 19:02:29 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:02:29 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] panic: Add panic_in_progress helper
Date:   Fri, 21 Jan 2022 11:02:19 -0800
Message-Id: <20220121190222.572694-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab760fb5-2805-4740-d1ca-08d9dd10923a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB343496E3F9CCF5ED1104BCA8DB5B9@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AR28HQqBkDCzfzVThEh73Xoq1bTGK8uPkZ8mV35NM3gf2O5MdnEWA3I4d7GdNlYvjUwEl9PKl8l8NzK+Ji2eKp6VV2Q5ggD2Bey5O8tNp3DGAgHzFDb8jyjXt4jomOnx0W82gMlZ4aK1a3tiM5n6onoUpYBfs5ofnIxjypQjsHz7lzAMkQS8+WN+xcp2MGfDCQC8w86Y8Th+u8OPIgIlMM3QxQrv7ztEeTYgU3459gLB7lIBoRSaJDz+MM74Yr72LCayg+qOUfJeHCqJMW/thGJOc8N4FH7ZUM8LMzwW7qmXzlNKgdEnZffpr0i5BR9SqHKT3vFvZK41p1zp4L1EX1HEg5+F+Y21hMpmP7WdB/zckLw5iAu+vuzo5p2Jd432mpLLcAl/IfPhaw8nFS+paegfqxhuylYQs//SG+P98seUHJ+5UT/EgOeOzG3WO4p3XOVXJ//1TZe/g5GVSV37t5r8pDa8UkyKpiWQnuFhns3icXLfZ5BfJm8ScjDqZmtc37+wpUT1n5E3Z1q20l201ykf5hL6/pYUzsw73ShDX1AJ6gOE9rSRjVNtjHYfsgkqk/WG6ujJegluFJJ6rmvYq1afaFyMoGWH0pNVUTj4RVGwCslbHA7MjH4nA8H5ylOOESL1x5eQAgf4atM4KwUe9C0E444kBB4EwAUVmrzm2p1TXt/83SHtPMte5lafy7/A2jY+taYHUL89zAmftN2ouA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(316002)(8936002)(54906003)(5660300002)(103116003)(8676002)(38100700002)(6486002)(38350700002)(86362001)(110136005)(508600001)(6512007)(6506007)(36756003)(26005)(186003)(6666004)(2616005)(66556008)(52116002)(66476007)(4744005)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVREGbR7mG0muBRaHmffI5KHMVIKliBFOK4VHuFQMYD8AoUjVzua3bV1hUxj?=
 =?us-ascii?Q?znfEBNepOnf7sL9L2gDc0vKCHEF4Idg8/VDtgkLCI4fXclWHkrwb72u/vtbI?=
 =?us-ascii?Q?QlRt0iMST5fO6zZDOrQoWiU7n4GzEy5qJFH6y5iPd1ELl99nNt/aCMHFyiw6?=
 =?us-ascii?Q?wdoLRRyzEktIn91yNl6ICZZFbTRlM+FcX01ufsQl0op66s7DnjdjKc7ieKgS?=
 =?us-ascii?Q?o3z6erkFeBGN+R+m5PvlbTpmM3MgB4cHQ3qYmMBUPWo8487O1O73eC6WB/8Z?=
 =?us-ascii?Q?FD5C0xcFF6XNNbSH3rrTz3Z8czQ+Y9txUbNhYvgXSPcrXGxj2bik6Z531qPp?=
 =?us-ascii?Q?KGjwcqi6Bqkbo7eSr2aUEjSck4PBDQZNXXtRS4XdfsIKFtT2D4SPMU6SwvW1?=
 =?us-ascii?Q?tigkBNxPgOmR3RsuKVPge6ZWBCjCwgglVB3Hn9aevmqUf6q1X+e2HJ0yzXD3?=
 =?us-ascii?Q?Ev6XObaS3VMfIiJMmBxV3J1T//EPCbN08EWtm/++Q0Msu6lE+f7LWs7UPPxG?=
 =?us-ascii?Q?TBeszrhS7NegOrPzJ/ihrs21qiI4Sij0LSSf9Q/2OhyqZIiO1kK9dXkTKwa8?=
 =?us-ascii?Q?Bh75sGY05hiKpfCt6lnISE5JEghVdBqGi5Lx6UPj0vflAZwvSjRm52ElYyGc?=
 =?us-ascii?Q?/2Sfe0ihdK7H5v4I310VHB0w1BCqaDrGd4zLerHtA96un58ue6abwvYNx9B6?=
 =?us-ascii?Q?snYHUNb6JiX8fxhFsw3pz4Rt6Le0cRJ76cbZSQupv3gQwBYiZy2/ZI8Gyj12?=
 =?us-ascii?Q?u23ttxdx4qB9Zi/SpypT9CfXBNj9/SWcq7XToKgaP6mV3HcNfxpHOOvhci0u?=
 =?us-ascii?Q?+2sd/hege2e0qRj0oufMust7LIsLc9ndCyRuwhPq/sP/h9xlWG0e8xUowklY?=
 =?us-ascii?Q?MLLNyZLYEF043vM2UDyrff6yz7CQOc9yjla8nUtWIkKoXxDincQUck8ezcUZ?=
 =?us-ascii?Q?rLg23IeSBo8Kdc3kdzHkBta1nAHxsLuYqqIWUP+hOcDKHT4C8ZoQbZQAdOBI?=
 =?us-ascii?Q?fTNqsOitCcxSW2VJXZdUtlpNhbe8zzne2L3MVZx987x/71bIOBIrEGQQ8H8o?=
 =?us-ascii?Q?o27wC3lNBoJytR7DbAfYQcnGNkQgmPkfNfDg71VINiD5LEcJRTUdlk9djd5p?=
 =?us-ascii?Q?v9vjaiqDPyKuQW5ypWwAadJ8+W0PaACg6kC41p9QqDYAnudj98RaO6100BDj?=
 =?us-ascii?Q?07jovEAKeCTInduYzPtFAYSK92S/KScQ9jF3pU5vrEWPfKv57GSuXak+kBY0?=
 =?us-ascii?Q?xWwLMKgWgOqk+NsSraO57TTWYg3oga09Gy9kKSuor6i6JlAgq/vZlYekTsS3?=
 =?us-ascii?Q?YPc0TPWuchloH7PXpsF23+5Lllo21JLJ07GOep1B1WwuCJ4eGPIz70YE7vLU?=
 =?us-ascii?Q?YGWFqqjtrMH6PmSMK1SisfPRMUShfFovrWqUzZ2TMVe1VOJ0rjRA5g7+9yYY?=
 =?us-ascii?Q?jVuFqFbMvzMqxiCZii904o6qW3VTilzJ6A3NEtILsg79LoOtMzUWQ1vHtamL?=
 =?us-ascii?Q?7S/9T3syLczK/Uf2w0EqRgXCW/224TUDAjADk09RfRtLBZ+2teahZkEpmldz?=
 =?us-ascii?Q?sNEOUDgyl/khgwjuAghJoVsGMknaBnI9QUJ37ZpkcihVG6BBg6NUBp1SI8vF?=
 =?us-ascii?Q?813V42MuBY15dNdIWAlVwg52hhxUaKrxzLGD4Vmh+aJnynvIe3hTAh6vdDve?=
 =?us-ascii?Q?vZX1EQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab760fb5-2805-4740-d1ca-08d9dd10923a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 19:02:29.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbpUGfXBpAQRU6fog7gWBQy4GkIRPpls/A3RV7o4KLnLSZ0sbb0WTdF4EtaXQIC8mGa6RQtK3IifwX1JfGDBa/1kIQHMocGvSkF4oEpruXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210124
X-Proofpoint-GUID: KXNwvDmsmL7NxEOp-WucmpZqBuAa6nm9
X-Proofpoint-ORIG-GUID: KXNwvDmsmL7NxEOp-WucmpZqBuAa6nm9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
We cannot define a static inline without including linux/atomic.h, so
I just added a macro for convenience in later patches. Since macros were
the only option, I didn't include a helper for
panic_in_progress_different_cpu().

 include/linux/panic.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..8e8bd50494d5 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -45,6 +45,9 @@ extern bool crash_kexec_post_notifiers;
 extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
+#define panic_in_progress()				\
+	unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID)
+
 /*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
-- 
2.30.2

