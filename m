Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441CB496566
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiAUTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:03:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57370 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231432AbiAUTC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:02:57 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGxQom011574;
        Fri, 21 Jan 2022 19:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vQkKGYfO4zMQHsDrOBWaiIFLYDTRWiidVYGHvnH9gAY=;
 b=SVyFKTaImunIU7LhK3bK2SJr1BM4dVY4GYPfkDRkdudtzgBeuCP0lNNro+yTrYO6m+ZB
 HbAqoELrmYF90J1HTSPs8BZeGiocqVK/mwidqisF4BrJq4AHOke77QNps4hginXIvdzu
 vgLqN6/B1v24hzwwwfBcQNYStCT7rNAgTfzODnskrDA2yNi3ShskdCv2xIq54TDxsKIs
 mlkobgU8muZS/OgdleqAEcORAt+y2b8uCrO7W4VkNwjzXYN2+BTnlNNSVDg3f+/Jsqax
 yOwW/7OrxjN2XY6ZoonBUxCAHRvD+iwu2kbRClf3+Zvx7L/vc+kXU2WDc5i5uaEp6soK kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhykt96c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJ0k0v093876;
        Fri, 21 Jan 2022 19:02:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3dqj0wc1xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:02:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUbEB/+XG7XS8Lfg2N1tHN+cur2BAOwXHqrUqqQYzjomXj3TQn6zcLxU8AWLy6MueNSARd7D6+PBKu2YCWXdJw96obfcmMTFx+im17o40HSeMUMg/Vb0hNR5tGjgVCMJvLDpe0U/RiyiBj0NiN33SPq+O+3lHqp1Pop1mH1l8tNSCTFg6ACiz+8NUDgSaBQXEQvbsylWTlEnHA1rACzwv2lHVLrSVN2fnEAxvF64Tz0frjK/l0SZaOrejNirDDAoKJfJmQqspAa3XKz+ShBIDorGVeKGYcvChsxDGEyQbpIAX5XUoNb9ye25kE74GFMYDB95eBXi3CbQTN1JbtOJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQkKGYfO4zMQHsDrOBWaiIFLYDTRWiidVYGHvnH9gAY=;
 b=Hw5QyZpK2Dv5lhkJx6obiAUpaVSWHkAWIwxVX8ZRAkY8PC7Y33R2MAIGCep3e1qjt7NK/yb/L+bcseoQkQjkqSotVKSw9pgu9ZIrRRq9oOVdKyEoDXGnppAyO9LTfUN5rIlXAMVmlXXLgursjyqez76vcyeMUMiiskNFvbb3TErwSz9SyZkO6yUWmARnLycYa8JFxrfbrY9psHzIuDpKuUlh72f6yTskLGQbFAHNeXzAgCQtbOvtICr5Qbr+9BqfV1l+Kq4vvH0QDtbpWeIDXywTygTZwKxM/wveJACq2d0jG3DkSk23vK1OeeHVL8xPmsjUIuuECeOmIkhpZuu+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQkKGYfO4zMQHsDrOBWaiIFLYDTRWiidVYGHvnH9gAY=;
 b=sLRLOdWb1OhblFzgSwAX4nfyBxFLrhdnc+xkOBbblkizIsKyxV8BIbaI03/XHgiTxeG2hYy8P1Ira0Q9UB4n5p7Hd/E9+bthI9Q9xjq0tIa/aSEq5rW1djj85qGmRokIy3hue62QoEjMIjUtdirHiiibb5YmdgXdlwugYhPptWU=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB3434.namprd10.prod.outlook.com (2603:10b6:5:6a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 19:02:32 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:02:32 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] printk: disable optimistic spin during panic
Date:   Fri, 21 Jan 2022 11:02:20 -0800
Message-Id: <20220121190222.572694-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3de880-1c10-4e53-e630-08d9dd1093e5
X-MS-TrafficTypeDiagnostic: DM6PR10MB3434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB343425F965053BB6B51539E8DB5B9@DM6PR10MB3434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ykbl3DdcjGl0O9LT2HGcP78NljlQHby6Xk5TD7jb16LPS/PRhxCrTaq1N28Vvh4P24iMPCzHLnJQTYcJPkWA1qa8zZNIfOM0q960jMmLELmWoBIRdfng228+0Z6tk9bXD4R+xwZCakbmm1zNkljgtKnv4RMyyr7CubaDk6iBKVXg1GdD0oKMgPRDY4DjvSV5VHu39HLQEsIgfbKKd2Ev5vjATZLDs4BXwtlfEZRSRxAOqa0B5QobFma4CpDdXl69ZYHaZFtku5VIU1AOhSzaQeCJ8cD51IkFUypEI1MCqQU1rFmjZCfJ5Vq70RwoBySr1NpbPcYHuTdOgupnrw4DpNKQhMEc+0gZ4p2beFwSgxdQzM8JyRsdh9XE890oUE8JDqrQGvM0jGgSIZHk7TUw4z+00SyLMBfEuuaXYoZbglpFHUzoEnCcaRLUZK/dIhnWkJY4OFdlqQH5BIwn3LGZs7stvcai4jZwaUE7/UrLT+a827SVtdMpD57ejLmuE0HE/S44/LKSRW2gEIty7nVXpBSzUIsH02U4U7GpFnba8nD+p4ByYPDJ2vASrcdckDlDQ2v8CmINNmlm3SqLKtICKtzenLIcweten54iNcVmEoZsaQoEKkNIqsg4LDfy9kEigTAjzY43kRcn/2rEfC5DSZZtklAR9Fr8U/Y0A41MPmghb44VrGXisbtMIr6smcZ2xBC4GWFAQIcGDUfvvzW9DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(316002)(8936002)(54906003)(5660300002)(103116003)(8676002)(38100700002)(6486002)(38350700002)(86362001)(110136005)(508600001)(6512007)(6506007)(36756003)(26005)(83380400001)(186003)(6666004)(2616005)(66556008)(52116002)(66476007)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTEqNGCFerC5KPbos8mlgNpI2IqdnIJXl1mNOrqD6OcIfymtcqw5dTVIhlZk?=
 =?us-ascii?Q?KBpBwPMuF7Xqq7/SXzH4Y3o1G2WzvdlALNl7aBAxH73qb/5ZDaargX+grHCk?=
 =?us-ascii?Q?L43rpclwTN1VweyrdhIXAmbsESMhHi/EN6NnkuwhgpllHuffaOkG1pBAS8mf?=
 =?us-ascii?Q?HOx/Ll3U3VgDV8pKgqwJhdRg1FCshnO02gwTEntEnYiZXu7e0+9PtKDm0NjW?=
 =?us-ascii?Q?xGAjv6tCL7y7ba3RvkbV9sw++DxZtMnzCI5tB+zCw9skepy4BA963G875XN1?=
 =?us-ascii?Q?lj4jDoy35fgVpiWfBxtCzrwbBJUNe7+Vaw0G3oHqy1sOGES4FTWzRnSt4UpE?=
 =?us-ascii?Q?oReFb9BhZQP0rgDSs9C9mwsBzzpGHHrjLuVrJuFk86iHWA3zdkrQWpeMsYK0?=
 =?us-ascii?Q?3OI6J1vFp8q1Rn/MK8PdxkLKx7NK4v5FrGbT3iRcBV6rchaa3C9QCsQqNEhS?=
 =?us-ascii?Q?ZJVT0Pr1wYBycMpW9qT7w2BjQc5ZnLhBxPHIXbMPoLDyn2x19Z8mYvOMa6tr?=
 =?us-ascii?Q?FtI3l50fYEk2l7aknVFs7O5ux79Ck4c6GwxJ5OH34++A5Z9g32ciMRpQ4whk?=
 =?us-ascii?Q?L75fwZ+zyvQIqzXu7CyCc8J6uGI4vQA1Q6NetcAQ0PwaRg8xn4VimDtReoWH?=
 =?us-ascii?Q?UqMRchLadKxaB++bp4M7vDJDppg+DRIDIWbQWVUuiVd8V92C6Dg5ijUdne/j?=
 =?us-ascii?Q?LepPqpNVhweqkHGDrKjXRRTsrJ6VVolDHloASy/2gdHL3X5P6eWAc35m0XQg?=
 =?us-ascii?Q?wcU40sXGEdV5siOW4OOxTCEWg6IPAaK/SkPS0YUc3yBcEpHrKpjOAix/2Av4?=
 =?us-ascii?Q?IQJZ2JGbsmVkvbmIDAFhY/kK+gJwRw4TnXzmnZjl+bdhQEc3Yl8CIl2+1df3?=
 =?us-ascii?Q?UO6YRreQvtCnBROYXzXQd1/vb9iWseQgugC27AmBHV4Q9Jm2Wk40R95gfjKi?=
 =?us-ascii?Q?cX22Du1Tp9Mqy3VC8fHFYrhfmjTgaAGlJUiI+K321vGhzmdbV50QlUTlQ9t1?=
 =?us-ascii?Q?YZPkKDvFzis+eu47++ZdNs3o5QQK4mYQumLInmxvS8AL4XJ9CqxO3gbDe+s8?=
 =?us-ascii?Q?JhzobakhLcssnAcIra9rMstjxh7yEi936mR84OCRgT14uivySdIR6kN5rH8a?=
 =?us-ascii?Q?mBwWc8DWtMHbaBve+ujJZiJ+04Jfz4kyyc20Pjnd+TTbaRiDAZ1W51N3cOXG?=
 =?us-ascii?Q?p2STGJpQkfHsRcrC2m+MWgS8pRQ8ZLvZfJJn8+QJgEeG9Rqyh/77u9fF0xHt?=
 =?us-ascii?Q?62k7C8sCm7mR7LYDvQBsldz+OggYJjfenDPR4FhGXfe1Nbp8vd72EV2IgI3p?=
 =?us-ascii?Q?olMSny44vNXUESkals75kMLScXOai4SP45vmrVm2zIpfeHoOoLO7AbbGoRy2?=
 =?us-ascii?Q?L05DVemhIAIuV8ApDnd3vaFxtiD/oFlBsCMbXneb1Ukpi9pzLGkkh1m7OIRl?=
 =?us-ascii?Q?tvJsnf0Hx3dlQtgcBE+Bj0S4cDrW4ONZwdfyVFCd5Do9X2DLE9IldMX4EZNF?=
 =?us-ascii?Q?veqx8ESGEUfrdC29rMVE1zuNcOva1XCNZzbuNtxPHgPsHcOj3hdiRAUUMr5o?=
 =?us-ascii?Q?ASBg5eLp6Ili+2+wRFQkOWmcFQ0EoQ6lQmch/tGDpwD2jDWR5D4J/iahfjH9?=
 =?us-ascii?Q?8RCrhjrj7XqouAdKrx71PmqPglnlNPEgzgTA0HjPDkn12A12rv4cMuc6PUQP?=
 =?us-ascii?Q?iaBntw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3de880-1c10-4e53-e630-08d9dd1093e5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 19:02:32.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08CNw2gVVhvjbRzcIy0UCZ3ffs9eGeOXVSMjSF75Y17vDpO/Q0LGcsWjyj9WUiVQfvRkTwTR1shwPg2EKkDskPcCjtP5DI3MLYyWl+Ke7Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3434
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210124
X-Proofpoint-ORIG-GUID: TfVJSRHuiPbJuyFKrp3OSEtSREKq6IMP
X-Proofpoint-GUID: TfVJSRHuiPbJuyFKrp3OSEtSREKq6IMP
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

