Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E536053C5C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiFCHN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFCHN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:13:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF901C90C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWZ0DQUwQ2NglbknGst5acNXuxfAyFssBH5b+SC2rHJTddxQ9e6/OhHwBFmtXtZ5TH+2dBZYasfyNpUPV5Ry6waeuxnAU8rTIhuB/JgG+Yd+QWR8o1f51ErI3ImGe4/hp470BX8RHnY71GnOROtH5ysD+dFvBDXaQfv0aeeRshx0/vYtJtAPlOWDnER18YKOjbgz6IjWFtvAQXitg/1uqI5jS5/r+8NU9P1yTHYJ5rHcer21YfiY138mMtsScnS7wwcY96IpF69zWW6G2UJtz0plnVuaakIdUysbv4ETA14OS65gRUiqTnmt/2AwbOYGjfRIuxSGmIPf3nT8sWSC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmmdSooXGWpO/T5ONgx0JQakMy2y4cSXwIusNyvvuYc=;
 b=gAD/8iJo2jfDY6dSZPIEOEru31eOD2hnVJ7u77FjyzTy2rmWHwvfc161mYDSb6rVyvcrRRcmMCoczAcdDykLnkll93UUKFaGZdgxIfJDtO/Ls01lLlmBd33xwlRDFtgBisNHU3XrXhrUkCQBG95ZVn+RqT/TD1XWOreFx5AZqOgZCLFAIQfDLvClYVvtDP0w3i6Wq1UK9MDinf1qpFrYn0i+JS7diCSUcEhL3iUjZinpVzrkvJdXF6I4xOkMQxgZqVjMsar2fAjKNO4R1Jb97ruodmPPMLJ7mxuStpsA9VW+3YHHTVKzaKva5/nscG+8BfO4xhk2PPxUGT1WoRu4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmmdSooXGWpO/T5ONgx0JQakMy2y4cSXwIusNyvvuYc=;
 b=trsexLMiBHKIYUgmVotpAfjryXDXpjvLMzHeGF1ZB3ePFIqeCiQKITTJGfJqJhl2owd/A3QL6fhHliZSbCDo5Pevc5QwfUlhkIN3YqYZfggSGTMJalGST374uRzF0pOcqUPNtkZMxaKlmR4bE/+UJhb1k44DwxWbftK3iVKbfn6Noq87Qswr2/Ke+8EGcuo2cFBTpFesAZFUyzzC5KTRFYK1/I0ffL6h+J/r5rG9h1yan3nNN02lCQuYOz/JkqU3mYShJ4byuyELsSUH8WlDNjdt0037VFZXD++N7FdRJyb7tM5dpwVRh729F6zeaG+wCTYArkaycsvj/VLuNhrC+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN6PR12MB1650.namprd12.prod.outlook.com (2603:10b6:405:3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 07:13:52 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::59cf:d090:5d26:6e7b%5]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 07:13:52 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/filemap.c: Update comments in filemap_fault()
Date:   Fri,  3 Jun 2022 17:12:33 +1000
Message-Id: <20220603071233.2296100-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80bacc2b-efbe-47fb-9b2f-08da45309d42
X-MS-TrafficTypeDiagnostic: BN6PR12MB1650:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16504C445DE76B1BABC0EEC7DFA19@BN6PR12MB1650.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGtmDsHhLJ9Um1Hq2SkN2py0c2ERWuw2v4chu1QAWg2j5ca3QuUtk5Wde06QtRAOq6WVqH90H+KhdeDCEnidX90CINlaWH2N+YfrhFVR2iZVIWzXf/8XD5Ize3nttkYW3L3poWeRmeFrWwASIa4uej8/AhsVGlCVVKgvvKmUCnK3yv90TbtJGF36E9Q8KglRkmZz7XA6jnIQzluBVdeA2xYDxtK9UpTsjwDWl64eSj2H4347dhUkZOyOR/MvrBgNtjg3vlouuGuCHHPoVdzv5sDUP186HGHYH12FykMfFDPmyVL/cpkNMTeX/xGfzLr2yP37aLxIJF63bAgdW7A+2rjIqrpvsp9IMPFV5W4V8F+DaSShGeQnIhmmgcE8SIbDLNeiSVobWr4MfPRmnahArwtXASbvENOepHKvQzgpuIUMbq9p9HtcYGsguFEnwPoVP+VHKZQfveUy6lq8FRk2Wj8q9N2LMnZsfzs1Afgh9uoTOA8/hqTj5G4qIUBre/0yrfjiD+sSNIJASTIYh50CDap4yxNwuagHZDyhQJDWDeQ/y2ymC5UbDbT8ZTN3O1kIHqrMBf7M908PfpKww7UTsEe/tWKLUpxyLhvqrYPAcASuHoWL5haWQoxKa+z07/VTgdUQh/IxFrHpl7f3cyGY9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(2906002)(186003)(6506007)(6916009)(316002)(8936002)(38100700002)(6666004)(6486002)(26005)(6512007)(5660300002)(83380400001)(86362001)(2616005)(508600001)(4326008)(66476007)(66946007)(36756003)(1076003)(66556008)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uXwU7h0et1KMCoS8RTSY5y0beAGpoGDiSFy088CIaNfg7jAlEbZ+gZTe/y8?=
 =?us-ascii?Q?MBlvTezMs06tDj1ELg9gPzDqvM0B9KCs3BItbeH7uVDPLrisZCt7YknxSjrn?=
 =?us-ascii?Q?o1sAyd7ol1iZ68HI0kFj5IpyGywfb1lkUAf3aiZyZ3LJm+gSiBQG/WeZXK6F?=
 =?us-ascii?Q?pcOKSx5a2Q0vbg3mMwTSAKM7HSH1y24GuE/If8MquoMu8f5FB4U/szzuX7pM?=
 =?us-ascii?Q?wcWThCoM3lfmOxrfxQ4vbw932SNLGep3DkI14OzgH6L2nHYa+8K0FagMNH9t?=
 =?us-ascii?Q?tGjl1zwmty7+8JD1+FFd7XEeY0k1qFkAhycZ9tsvIICi7UZAKhEPxtXG/CNv?=
 =?us-ascii?Q?PK9pC/ROF/DNpCSh/fXwFVsmgAvPatv0BhC32ZmleDA1ZYCmPisZ0LDLbgqO?=
 =?us-ascii?Q?pP1zs3WVSIwaOMdnz2Qs2Ts4qah2/2QveHYY78T1G7t7b7kbUdCNRtt9lNod?=
 =?us-ascii?Q?nyX1ZGiAHH3Y/fbWLEwj4tfiZIXdyg0EGjBaPGOns6aW6qNQAM3MxpBjDLej?=
 =?us-ascii?Q?VaaYGcNjC3AJL5b0+ADHdPJAYaH7Eu5j1spiskBIhw4rk02cICXn/SasdXiG?=
 =?us-ascii?Q?MQrJcuvatDN2AavSen+3Gy0drUnysQS49l9j4/7BJisVv9mYr7Km78r8MigZ?=
 =?us-ascii?Q?g4/Zk2xKdkstqiE/jmnGRBMce+Qth16Jjmwpn7ShzOCpJlKdt/lllps0YH99?=
 =?us-ascii?Q?mgk9GT0/87X/y5u3NMxFdrvO81r+GwFk37NHj3iKoddGRvk73nv4pc/Wh4MO?=
 =?us-ascii?Q?skpJYeVC1xbzB2pSVtQPINOIpfFYV/GRp2n4C+gVyxq/kSEfBoVRRkJ8xEZm?=
 =?us-ascii?Q?+hLpGSCPBO7qujOsHniqOgrNcsdnzvEEnPClXXnM3Ju7a6QjPumbQb5vTqCq?=
 =?us-ascii?Q?KZCQYBbdOAvXNrS9GFIXNMLbzV404UnayDqN3KwtMk/lFRp/bjqp88InFFKr?=
 =?us-ascii?Q?WDDHs8Q44DvhR+rEU5dEyPdQyIl33RlzIVZofdoT/lpG0xzWhNb4mTb2TfW1?=
 =?us-ascii?Q?gA/b3t5LKz4oBOb+xkm9Q44qbzAQxMkknWRb45axLGc//G3EjN4pRKT8W5RQ?=
 =?us-ascii?Q?T9TQO/70Cf8T0Gl8XyYJ0FbjszvyZmSVijZCiXVhIwk7siOblyciKzcziQG2?=
 =?us-ascii?Q?EIXmkNB70KK4daJOs9QL3913ItM40+PArGMJanXBsZRJFVzfHc8r5X13aZMs?=
 =?us-ascii?Q?GN4q3RRn0/sAptgb1z9Q3H6ZOdlF+eF+yUxSBFWiS9RnqlACydmUysth1swj?=
 =?us-ascii?Q?vNoea3i3R2d46U7wtxAoxSOkn8SeOS3iqdJE5d8/wTxKl+PnFFyM5wB1+q/C?=
 =?us-ascii?Q?BW/ZJ5g8XpBB+gqnf78u2psetZICh5gO8AYsZb9lvOxgC90hlZmDFDHkcbGS?=
 =?us-ascii?Q?rM69fzCyDf7e400o3gwtyKGKd0Msa6gPxjwL/omHt6xI2oJmedQN+qlzUx4x?=
 =?us-ascii?Q?rQYSC6/7dcAcMBYt6bmC4gs8o4ei6xr6TTF/Jvhr1JZfVv/mna56r/AfmaBK?=
 =?us-ascii?Q?+bDul9FKOdw1uQdb3qGgjDRZ6vPi1zTQtjT5F4eoEt98S52Hgv6biHheeN/a?=
 =?us-ascii?Q?C3Q0XziasPOqvct+fJoWALaNWqCcOsP0jky84nyN/E3EifYc5oCCwsrdsxyq?=
 =?us-ascii?Q?/c1JR7AcFsW2bqFzH4aA7Bd+9WuxBwMC2f7BJYJ4WWfWJWt+OX7DrBGVOywI?=
 =?us-ascii?Q?l+SoXDDvUD8N+agnyrk5CxbnEpHp5va81EeQXE3+sqV0xJfc7nQR+BJFpCUQ?=
 =?us-ascii?Q?oeYbLxWW6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bacc2b-efbe-47fb-9b2f-08da45309d42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 07:13:52.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpLnp2VbW99zOqeyJgJEwB1CkIrNSdwQjJ7mnm9qBljLsejaw3c/e2eqJe4wsDtmX4gAButrGKY8vsJps3Ec7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1650
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code structure in filemap_fault() has evolved significantly since
these comments were added making them out of date and slightly
confusing. Update them to more accurately reflect the code.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

The comments also suggest there is no performance concern in the
page_not_uptodate path. This isn't entirely true, because this is a
common path for MADV_RANDOM due to the lack of read-ahead/around.

We always drop mmap_lock and retry when handling faults for
!folio_test_uptodate(). Not dropping the lock resulted in a ~3-7%
performance increase on a simple test on my local system. However we
typically avoid holding mmap_lock during IO to reduce contention so not
sure if changing that is worth pursuing or not?

---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a1eef6c5d35..407420ebd6dc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3168,8 +3168,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 
 	/*
-	 * We have a locked page in the page cache, now we need to check
-	 * that it's up-to-date. If not, it is going to be due to an error.
+	 * We have a locked page in the page cache. Check that it's up-to-date.
+	 * If not it is because there was no page in the page cache (only likely
+	 * in the case of MADV_RANDOM) or due to error.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
 		/*
@@ -3214,10 +3215,9 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 page_not_uptodate:
 	/*
-	 * Umm, take care of errors if the page isn't up-to-date.
-	 * Try to re-read it _once_. We do this synchronously,
-	 * because there really aren't any performance issues here
-	 * and we need to check for errors.
+	 * Read in the page if it's not up-to-date. We have to do this
+	 * synchronously so we can map the page to handle the fault or deal with
+	 * errors.
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	error = filemap_read_folio(file, mapping, folio);
-- 
2.35.1

