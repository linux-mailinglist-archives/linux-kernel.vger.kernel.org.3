Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808C5502B66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354220AbiDOOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiDOOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:01:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A072CCA1;
        Fri, 15 Apr 2022 06:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dblqBk3o9g+5s5x63L1njali2ejzRozAtQtCQxzC6S/bWd8nw8DqcKYiXuSAKv+G8yK+ufvvZZyIYRD5Hu5HiToNQLWCDMJlT6uYtInlu3NEQjyffY6lRNi/7juW2gwlBXrUs+KFxmj7ODByrCQI4/qGTVSZe1dgsOEKr6o3q0cfXmxngn7fsIJ7gWipIM3f4cfTdPMe/jYKftL0FZsEXRCa9j4oQ0WApf2Y6T1cehOmMPjxFndpwYi51+K0iJNWtYwcjgBs/tO/BADTcadDuzYxmGgbINKtsfHZitRadBXgr/I5WoDYy8ON3idchAJUwiruT7BHCQ8qJrD8vwmJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDKAql1ylDNNspwqVW4QQRDxaEihZc22yK9P5S+mxI8=;
 b=iyLvrdg0apx21wJJryjDuuFsqoBH/MgJLrYOCgyG7Unnt0aOiv9Zdxf87uW9vd5yGgYiDQIyLDf1tZ7sUiQX2vYtH4Y5xQOCWHPvZp7NTP5X5wlj5aajLXo7/1feyR+U0v6Y4K6zYFeqd5C0xHHDdvKpuh2toR6xwWKYP1Trh2OrUqTns9dVumrG0TBAE2RtBMu4qvBfQdjHfuqDFBopfKH9j2V/M8AOX1v0j3KUQkoup9nD3KYEdaN1tzgwEvjnMPvq/cvENaBWc5efm5D125n6muJCD6W8YimlJOQuY6Z+IqfCQBdaaCBJt/LpPAby4zzrJOr9z1uJKKnJV8GzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDKAql1ylDNNspwqVW4QQRDxaEihZc22yK9P5S+mxI8=;
 b=EACqgidW3kKdLx2Ep7/h47vd9I/O7BDjBLMO6oAcBuua5OVsGjN+z29SIfDWhcG+m0uomavjcWgj/eIzfBAvUAO59H2Cdsk7OqXg/ZlK5bax+oxkvKRp6XqOGRtv9xSxb1VWZDzYCNlrjcQPsaAX/Malq92WFLEGUGinfoo2X48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB2531.apcprd06.prod.outlook.com (2603:1096:203:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 13:59:25 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 13:59:25 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Yihao Han <hanyihao@vivo.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] sparc: kernel: Add missing put_device() calls
Date:   Fri, 15 Apr 2022 06:59:09 -0700
Message-Id: <20220415135910.87598-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::32) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cae075c5-a7b6-4b4c-912f-08da1ee82631
X-MS-TrafficTypeDiagnostic: HK0PR06MB2531:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2531C1FC2B9C7AC34E10E5EEA2EE9@HK0PR06MB2531.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qx4mss8UFbA6bke7ODU/QHyrTEXC7QYyQWsrI4GlAUwf9+qhLMEYia6ygN+0IVEVk0uJx2CSeWmBqUN18R4L3xCefZQZsfllpoZ6V4qKYTGXG3KIQtVZuBqX5doo+aSnpDCJQLSNxFj3DfKdKOxD1OOwk7r/Gytz5SWdzBjN24JS78hzaEeS+kykrH7p+taanTYzOwNWRBiMfNVPhIOnEcA0WWxMXFIHwkesI5fpCJHgM72NPv/VNZLuWHrxWcws6WsHAA6pamsCvousDG5FZUR3iD4YihBX3RVY7ln6ZZC7vH8xFUoYNJSSaZ+MITUywLQzT5T8c6lBc50zCSg0xY9dkLvUDIeC9MiCjBST6Z7LJCVBfaQJsQdXuwIzaa+5WsjnFj3sXhhi9DQQjkDJ4ssOSp3QEDUzpPHaDTzdrNGMIzIuZd0WHmUJtw8ZbHWSeGGhPLpeFA3l7yneX+N6aiSkuEklOVBQFeJgxVnzh3CG4dyBIMg4Z4gk5hHtAX+7s3xiTA7kLNjOZDeOyon8xQhzeD+LKMRs9nrtkilQq7u7asVKDgLXaHFwZSLskSTafdlSmlIUFp6nVQtQJY1rw1T8t61A6igeTiDK+C4zGfWrF0uZQVGv7z+fOJTYPrx0ERUYVIrLa8FML858U8NXy/YHuSJiRsgApHfkessLNJME2+BHL/6ZZfETm4JjhJ0T7S1AjjrEbcT6ubGOmTCDtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(186003)(36756003)(52116002)(2906002)(6506007)(2616005)(6512007)(5660300002)(316002)(6486002)(107886003)(508600001)(8936002)(1076003)(8676002)(66556008)(66476007)(66946007)(4326008)(38350700002)(26005)(110136005)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmsGL9V0qydiyApYe3+qejBjOq5gfLOXZLLbBwgdYT8tId/hacVmowcpPqRZ?=
 =?us-ascii?Q?R8RkXn0O+L6zAUzeBUbfG7JTco/6zRCIrTBX9vnx5riO5i4VD7FpbQxocQXv?=
 =?us-ascii?Q?5y+Mh+L0evCpKA9SonzoIGSOOAP50ia9Eee63TexHcdmYk0kVOXaDm6yC31C?=
 =?us-ascii?Q?v1xic7hd6LpP3vWyquBTM7456FpMsmACZcZgSz3b1GrKiyJXf4Dx6vlCier2?=
 =?us-ascii?Q?2Z7wAcMG2Bqtzh8og5RHqu5mcMrNnrXmDpxOH4mPKNDcACATZK6X4FdyloE2?=
 =?us-ascii?Q?znCRJlQbWUfvDfkoqQSGApDJKKVzFasuAVEu38b8CmADhDuUynICQS8Sunoa?=
 =?us-ascii?Q?59NEaxQgetTLYA+QeNFUagO9z/MRwLvoiFHa3Zf4xjO0QXOuqbJK5ZutjxvN?=
 =?us-ascii?Q?CH9RpQZMfBJ6NUX3vBxKAL8OtFmqvcRH4+/rHoSrNeymNT/VGLYs1bVDdfyD?=
 =?us-ascii?Q?JUQFoI6X/a1lFSo2IjNmTBt7JDkTkPbLm+03cXN0hYaLScstrW7M/yr/aF+c?=
 =?us-ascii?Q?2wz41kMyhdeSkxMy/0SOHGI9booZ8s1LqqBCPLnM0OZQKkB4cHS0AjGrt8Ig?=
 =?us-ascii?Q?JRSRa3/CUupdG92HKCB6DGUdOriqRus+EQZAzIkoQlvhMzykpArDfhLTTy4G?=
 =?us-ascii?Q?eMOjb0LHPVRjN76tTRc/WnHDqgAJdSGA118e/Y7amXh5YTQXD4lrFH45ZTBc?=
 =?us-ascii?Q?lCa4cw8/CKw7ZHbovCteEOVKjdhyEGSputw4JNd4PhKE26HNSzOuT6BQNjQI?=
 =?us-ascii?Q?mugitLcIkYn4WZsyCTzyS1aNz71DFacCNs35nuuTEqiGoqaaU/j4aN5nSast?=
 =?us-ascii?Q?g+/GAjz//2Fw6H84zkV4LdFKRJr+c0U8/L3IQW44pyv6jwNA+1ffY0INZ3BR?=
 =?us-ascii?Q?66hy9GPxa1utzo21b6g10gcfo/QwmFlxtz2lpFnY0pjYQPQrkZkOFJ9OepM5?=
 =?us-ascii?Q?jlUsokjVasb9/ATrkDkxvHbHyLPsf+x2BvPOnHPJzJVnHK8k6ge+4e7nz5t9?=
 =?us-ascii?Q?O45SW8XjeB9XrOoBPtrVXoxiXdK793EmMlVlzITFq5Fmn6B1sqfr/dT2VmsO?=
 =?us-ascii?Q?AxKKpumENvcPuOyAKUL4xUYn0kn5Ti31eheFk9Na6/tYNc7QgO2LnWbNbdcA?=
 =?us-ascii?Q?C9OfSiK741WeAbwKkRn930x+Fp1/6nPYsC0a/RWQB2/uOdn9Z6qRfAl+MbCn?=
 =?us-ascii?Q?ZA3zlpBcSMKObOQDXsh9+ffajjPUZrQqUhMjxNV8uxZUg4YvATg7SStHNf4b?=
 =?us-ascii?Q?JX/9b6NxbA9jyHaP9sa9y5KJ/8tkpiZopC2H2OnP8i/8RQZ8yiuxNK5RhL4x?=
 =?us-ascii?Q?kaFdshMTBSwN7ZkmcNMVEyGWj7bLsVGyaw5cbJEHFo2oH5h0BrBAaSC1Qxls?=
 =?us-ascii?Q?xApU/PXrj7mvLxpWUofDDD9qN3fRUtqkgbjfKEUSvqjg8RBhBPskNdSSF8je?=
 =?us-ascii?Q?s0UEXflxbEkc9ry2u7JmZ2Cb48QSuQSOpWUExe/pItwSJZ55/vjtVtAxVdIc?=
 =?us-ascii?Q?twI1tuulDbFXNJPvulYbj0fMGtBhmNHCKq76ERw6YiaewtM82+TIcx0DB7in?=
 =?us-ascii?Q?H7/r5c2Gx1ZyjULc5MeZDPAV0a/HCFjUhEln/GlyW4V9OA+VUL+SsNdQkS04?=
 =?us-ascii?Q?wAvPh+tWqWfcTtNo4va548jRAHbA50p2H6mF6qYGd3dj6dn/19pBYW8x4Io6?=
 =?us-ascii?Q?mgn37xBDYyLJT6b2qcggb9qWBoN5oP45oCCIr5hmk8oKk3E4/b/PutnObx+U?=
 =?us-ascii?Q?EwprujVE8A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae075c5-a7b6-4b4c-912f-08da1ee82631
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 13:59:24.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtMR+6V2F9KWc97cQiDjmQUVr3a0o7e0rha/oTJWD1U4RlbL8ihk9xV8WETPIf36qGjdAFCV4LwLPTOt5kNVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2531
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coccicheck run provided information like the following.

arch/sparc/kernel/pci_sabre.c:335:2-8: ERROR: missing
put_device; call of_find_device_by_node on line 324, but
without a corresponding object release within this function.
arch/sparc/kernel/pci_sabre.c:369:0-1: ERROR: missing
put_device; call of_find_device_by_node on line 324, but
without a corresponding object release within this function.

Generated by: scripts/coccinelle/free/put_device.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 arch/sparc/kernel/pci_sabre.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 3c38ca40a22b..5d0d13840ac3 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -331,8 +331,10 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	 * 2: CE ERR
 	 * 3: POWER FAIL
 	 */
-	if (op->archdata.num_irqs < 4)
+	if (op->archdata.num_irqs < 4) {
+		put_device(op);
 		return;
+	}
 
 	/* We clear the error bits in the appropriate AFSR before
 	 * registering the handler so that we don't get spurious
@@ -366,6 +368,7 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	tmp = upa_readq(base + SABRE_PCICTRL);
 	tmp |= SABRE_PCICTRL_ERREN;
 	upa_writeq(tmp, base + SABRE_PCICTRL);
+	put_device(op);
 }
 
 static void apb_init(struct pci_bus *sabre_bus)
-- 
2.17.1

