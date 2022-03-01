Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0444C85EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiCAIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiCAIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:08:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6842EDC;
        Tue,  1 Mar 2022 00:07:38 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2213Ziqi018833;
        Tue, 1 Mar 2022 08:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+ko7rf3kb0aCPSUQiFnDyazkr+d9Hd84+t/Fzh1HTsM=;
 b=wLjz9Khuu2TFtHFMyQBwV7tOMOYxf+CMuOCT0W4+znCTEs390cHA18mHRAryt7o+dcvd
 Z9XaZCW+Xv78CMC9rYXpnFtDzQoU9VRPCPdFrZVExEV/UXGmlhi3+gmPQN9XLUcZwyWG
 AaB6n9paLbhYPLlo6cyxdQgTAvqIUdg/ouokbbi+bXvzFmo6oOYOWfqzstloZotc8QCb
 6bGO5ddliUL3IqVLyQQ0MhQMxG2ezBxqCKiV3L7w/EZFacnerGmBffV/gxatLGUsKcJX
 xTyFFxQwn88NyY2rjiUxwxEDZY+ljHm4bAx49q568g8FE5Ky1JNAy8ASn6oDHCIZTleW Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh15ahwn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:07:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2218225n088318;
        Tue, 1 Mar 2022 08:07:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3030.oracle.com with ESMTP id 3ef9awpce5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 08:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4c+dIF2wcsqTSQi/fj8v87pbfTOpE+IURYmoOXAA3pUdQpLajdbmxVoyW0LMI3VRNKg1H1Z/pRoAvrKtZ1NccLX+Pfib3XHrNwmZ3Dwk3Z3J1IOrHRxMoFKvlFMQROuj8t0jQR7LxPqsJEh2XAlO0LVweAgaOWMmnFAXs+2g0ajAQHbv/ey4ch4jLCwXzYy//CyABlHrXoMII1j3Ij29gru16tTWTgMr2WKqbG4tKIG7nQ+1ASH3QI3s9QYrQK32+RpoMpp7yq92YILbGo2FR9Hj+G+VbE+AMifBbee49FQQEPNGsG0QFWNCRH0xj03JX53GL7pajUQpKlfSfs5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ko7rf3kb0aCPSUQiFnDyazkr+d9Hd84+t/Fzh1HTsM=;
 b=BILjdZ7BxyU0AggdMSFEte8DVTS4TGTryPC56ng8XzHtKRZiB46djDs7hXloLCBv5RdsK7ezvLXC1KvFVPgjmveCzRoSl8zSviLRwcHNbpbWG10QlVRG1N/14CIJip7qlvl4Kw8/OG1zSSZ8gXx2hyegcSMvdKQ62aYXl+UoopWBBs9IGvhZ7LNlIHjIMv+fe2sLUem0rIWzBYAwl2xdbzE/YP5uxqv1nGkmFIVX9ZKekFGRhY71oEG0BZgILNunzK9+FDBlUNWzpbx1U3lMkM3Kt/ZwH207STobymgd1yHK0Ooc4QRluVHe0i/g07UFFSidnWeUHw7xXPCPIAjV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ko7rf3kb0aCPSUQiFnDyazkr+d9Hd84+t/Fzh1HTsM=;
 b=JgbmX/C9+50QUe+v8kMbVcDJLgTZ4664hiRFzegl1C7MsrykERa2iCQ2QPHJJDqOcyFPT0/RsbUEUffFnxgnA4cCoDDPWeu21qrwzYZ8A2Z/t3FYusWDybzE/+zgYWpMuvd7f/sOcYO0mZr/jBrNjnUy3WS99B9X+iKtyYJCHvM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4581.namprd10.prod.outlook.com
 (2603:10b6:510:42::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 08:07:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:07:20 +0000
Date:   Tue, 1 Mar 2022 11:07:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexey Gladkov <legion@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: remove unnecessary check in alloc_thread_stack_node()
Message-ID: <20220301080706.GB17208@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44be99de-b244-472a-afca-08d9fb5a8220
X-MS-TrafficTypeDiagnostic: PH0PR10MB4581:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4581086BE2190198C62712D38E029@PH0PR10MB4581.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkAbJnO+Lj0ovF8ofBS6oI2VygtKAtp/0NnDnfctvAz1jBBNNwU9RwL0dF6WHLyDNz1BaEFwqDr0qzFjsG+rmcly3xGLovpqQ7N47zJtY9S2rkeWcq4dk58Vzn06raGwd9l29SsVgSfZiKyk/tt/9J2FxrG4HtS1cmo153IaxcOsMQ4qM/xCeeSK8zVe4hRIX4vBhLRCn/WAPgNCGCYHQnuQv6o47Bhm5klTq5r5fFhrZoxqX7tM/JIlpJANBhejQ8BAkOs5NE00tTcxoAxrvN/oOmSxE32mZKn7EEbv2+ERFMh3Og9TuJK/nakbgZyLreiHxEdIKZs+Ev9UUDBS/xHZinUL42BwG7jNaAfkPjldQ8qaCUjh35QEmHGnnCBy9IbA91Y1jwDaufp7wIOA9+gfCtmAwpWgiNHipeoaPilqPmKqEoMOU2rUN+5UtipcREbbJESD5T2K8y7I87uQCs0VCPDjTGDQx/ojr3v7EoL5F3kC17jKcpgR8tF9mK0d9bpIKIdRNKK+Qckc5eUwf1t3pSrmhVSQ/kB5dmenzC/BCvA/UrYMfx/WojATCTL3YhZNlU/YU0mJl3Lw+DCMlw9KBMFnOfbKid77CtxCNs1M6vNG6NiM6v0WV/EjQYNS+zY9IB5xcfc1OhiEbo8BS0uJ6lfRmfvitSff9CMH93n9YeiYqeiyftTJTQlIEJJ8n+UZUZRFBr8NvGdPdIEbZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(86362001)(186003)(8676002)(26005)(110136005)(52116002)(33656002)(1076003)(66946007)(316002)(66556008)(33716001)(2906002)(4326008)(6486002)(508600001)(66476007)(6512007)(6666004)(4744005)(9686003)(8936002)(44832011)(5660300002)(38100700002)(7416002)(83380400001)(38350700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGHPKKbUELrH2EzSoeH691ZfRaDkDXXoYU8HA+jhcXFchMowJV1GICU3ytrr?=
 =?us-ascii?Q?rtvDXgG6XRjWJEGgoPVK6D0ql+qhSLMZhCEn1iwcNtdCn/K0uEcv+P/v7A7y?=
 =?us-ascii?Q?/JjoYh0FVntx1Rq6RtIwqlR8VGRZGkQL/D63JREq9sIQuvp8ZZ9GX+C8Ik9f?=
 =?us-ascii?Q?lgi/SdAIt01GnAI8yu26bPUveNgNM66mMogbaTEHsuVxJrOH227jw4VhCCt2?=
 =?us-ascii?Q?RQG0i4EX9WFFjGGC64SrDDiEpD3fw8rYFMgGE3mH8jvoca9HtowPdUg1Iho/?=
 =?us-ascii?Q?KHeZd3EIeOlHIcNWIXzaKW2J/53cMzPFI5uQaJqC7j1JKJw9vsJBahJAh5kG?=
 =?us-ascii?Q?NYnIQlnvQpgD6a/Y4ecZClylEpvJY4MXI3BvODze54NJfH3aR/GAZO6w4yUa?=
 =?us-ascii?Q?vErvUw8iGOPQiTGOOtgJlC1cElEPjG+EoLX7mkQb+oek+eOL5kHyZd7KSx0+?=
 =?us-ascii?Q?uLKe5GVYhvKhb1FXlbkUgmci6fiFtl7to9Y0CaMLNjmkFzN4hV89d+TEXOWR?=
 =?us-ascii?Q?nBecV6ha5B9qUv3Qpfe9FZYYdo5jiSnpr2iuy8+Dg15A7mpKhMFLJmXb607E?=
 =?us-ascii?Q?vIHgz2i49KvRDFn4iCy5lpRwNmFtF+UBmHaWfvj8fj1ZwoCbpHW7JyfTd6+W?=
 =?us-ascii?Q?YYul38XgD7uiW3jxraQ/vi+a/11Qd7OOwaaI11xzzlMN3Wv85T8SQgn76MIN?=
 =?us-ascii?Q?Yr0nsk0iBXVd2uAG8y+D1hLflIHXkQawU+4Lc/mn8r/D/v37FmYXLcbjKgur?=
 =?us-ascii?Q?PqJArfzJ3yhZAUJy/VOr+pGSTNT0KEgODQkmMC7A7oiGCSwuBiCVPQI0XUxK?=
 =?us-ascii?Q?5H1C6uTz9JnkPgsfyYxJZW+giL8BYnsVT9lD1DyelSQleLkJZHE8dbr9TO1h?=
 =?us-ascii?Q?zNBgJyGNmyWzg+Q6GRXfGkhNDqukS62z3e/bY5Rz31+rwsNWErEcTH5MWhSd?=
 =?us-ascii?Q?B7wL14V5hE5TPXDzMrKyNpatosgOLkI5XeazjKuUGsdByZ94UyB+TIemPWem?=
 =?us-ascii?Q?n9TGh1vYxba1SZ6OjIFd9h1n4elpSBykRLXmEhIUXL7o35PfzlE8+nSKRVz2?=
 =?us-ascii?Q?3phigKB1BC4Rk1MwX/pG7SBO9H2UVnEkgn91fJ32MT9CRu5032cfV13S2klZ?=
 =?us-ascii?Q?YfMGXIEnFtOjr5xAVdARAE7I3bAbbBfZf9dJDpuhBzC3LtYiLDaoWvzKE1zq?=
 =?us-ascii?Q?WsBf9/sK2kRxS+diZOYfaA3TjennXg2eKsPfEmTtgg7/7fp1PMIT5rk8e95m?=
 =?us-ascii?Q?9LCCbsCQgTIwz8j7knivgx4hBmQpT4Tk3EzGVj1qoW7eSeeArCDRlVknmCEP?=
 =?us-ascii?Q?Rg+tAbmAt6avnemRDqMJAW2j5iZrx2wisZyWflvFod7QBIXzC33uxNqkOZZO?=
 =?us-ascii?Q?NaPtzKHvc4VLRWDdCf/q4PVZBZboIugcOw5+owVTEDNqAToiD4sOoZ+gJh9O?=
 =?us-ascii?Q?JyJGft756Jrtt7rvCpC2oy7AQ2GtpJ6FrA1QJGqxFhkW+V0964mOpuciqKM3?=
 =?us-ascii?Q?LtObtfESu3MTtLjE1xPZxEtFP+j30XrLjmDK19mmS7mrUaYxX2hG6/3NWufZ?=
 =?us-ascii?Q?Iv7BanBLzf6BYNVB7BpcKecihRKs6hstKnWdQSfG+3gVTte/S3SjWN1fnHiz?=
 =?us-ascii?Q?o3D2Pef/ccIcifyFLi/XGOnB33isBlCB0pPZqyDBwY+lN/nMEDHfhr+3myB8?=
 =?us-ascii?Q?WVQI9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44be99de-b244-472a-afca-08d9fb5a8220
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:07:20.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LVFxsSQ1bAyfikvVbM8k1D0x/DZDXm4LTQ7YT4v5+iRmSoTEeVtYdTOhhZJFJRg40pJToUaFwP6WMm5Ev9ISQTIBg8TXR5IBceQthdduNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4581
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010038
X-Proofpoint-ORIG-GUID: dy6gCOlAE15DhmA9fUbGGPOoT4_NggIs
X-Proofpoint-GUID: dy6gCOlAE15DhmA9fUbGGPOoT4_NggIs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "stack" pointer cannot be NULL at this point so there is no
need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/fork.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 516f9db66640..5e7ca394b8e3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -327,8 +327,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so cache the vm_struct.
 	 */
 	tsk->stack_vm_area = vm;
-	if (stack)
-		stack = kasan_reset_tag(stack);
+	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
 	return 0;
 }
-- 
2.20.1

