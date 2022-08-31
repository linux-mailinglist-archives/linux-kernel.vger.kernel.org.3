Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BA5A7481
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiHaDf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiHaDfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:35:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28424BDF;
        Tue, 30 Aug 2022 20:35:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9DSpKDnNvM0cl9QST2EwBtLW9rjO7porZ9s/C3ikqorOhpHu1NoVsaQO87GMsnpqvza0l4AtsQVhSliVXmzRTxGxVBt5z2IwQmVHRTR6uSZgBAh8IUPz9q1zVZzXPihZprY8/7hP/Us3OmhiKPlxEShx3j1tSAx5xLeqN0/fncgxhWYGZpbRsFIgZuv6cat/pAqDnLN8+r2VK0of89nDtOE7iScJ5kvnrTVXe98v7TTexjkpKI+7BcPjz3SGdHtS2zbTJDDxrbxzNNE13n/I7d1Nqdyw9xhk9G0UctELhbThZqXuVsV31cdhIdzXvwQ1mmkeLqwPVlxBzQNCJ+jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYSVB8NqYE0Wy5sbDJv3tPeXrAuInEwVxc0YFDNUdS4=;
 b=FXQHPsnfcDo/0MPFtkJxbUpGALeM5VuFpyXHJdlMDJyEK12JFoUsTPQdz9pIG9z3lTXO4RBekUfKR1XUxnXot/lddjBzChHRVWtigYqetQw1MGqnUxsmirwi4nMcglMvOlBGXwKg5JVvG6HM+RdrWUoEWOMaSj0lh4jGTX4BmqMZdpWXLtO0EH1TZQ6X6o/SCI9RI45xe7qZqqUq/JNqeZAqChPS0K4FQhMf9tvlrEoQ2tsUM8Zqmo1lAf4beBbnjSdR9zPGHEzBSJtBH2/61akp5mCsQxX5Pfqz7Fmx5Gw/7f/Vgsnv6t0Jl9tL6qBLGoF7Bdii3ScVwR8rSzlnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYSVB8NqYE0Wy5sbDJv3tPeXrAuInEwVxc0YFDNUdS4=;
 b=XFGLd/+/4MiFcU4uuTXTSlmd5Iu6gEvAyPsK7ZZ/eNHuGmyeR1FM0GrY+rldD+aMQrNaATHjFX+QmrkYz+LpDkLcWpSyjYagYLMZw/Q+1DRp2E5Dczm8KiGEgAr12GuGlC6JfYjrU70uaOCEcEWPI18mZQGstf9VleJX1o+NXog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4497.apcprd06.prod.outlook.com (2603:1096:820:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Wed, 31 Aug
 2022 03:35:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::5c0:a9e4:9917:8982]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::5c0:a9e4:9917:8982%9]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 03:35:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     code@tyhicks.com
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] ecryptfs: make splice write available again
Date:   Wed, 31 Aug 2022 11:35:05 +0800
Message-Id: <20220831033505.23178-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2d67b50-2c81-4670-2647-08da8b01d122
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4497:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaBcN2PW4612a55J4RvXDQui+qXY+DAwh06oVb5gU0/eMbuCfH9I5iLkfKg/uNXJSfANHhl3GYjXRD3ByTJcRlPzqAt8m54p6iMlpzjaEr+uYV5dfPvzK5vFTGA6i6HZt2RN5YWNaJZhejf57iJBN6yem8CtQBdXpqsv3Z3XINvbA0DA4QrZGrm9Z0gI8jlw2jbGz7+EhV5aYvaOwcGYUZXi9K6dDS1+sIJkC2rZR3nvCtk0B6gbctTcqAJhM93GDFLF4rbqcJtHsLKtjPznNcbmTZH89SPSj5IPxkPEFN0xGLQtV2MB9gz5dkDt8aCbQvFD55/8pxsenUh7IdW+jEKfLae5K5S9RA/8IaQm1K5iyMZKt4+NDy7hjD1F+txG+l890MKR5tiV1u6gyTNAR+PPylBagq+oY7KPQ/PfM8kQob9Ex7jLyr7xpzfD8Xj3ELIQ3imsbe1Nf2c584LJd1QWKCQIOhsCLRfcJqqkF9cNtrjZEwoaBAgvB+VbjUsZ+/HtiFtZK15qJx2O8DzKIDykv4Z+n8eYMjCA3qeLlTC+OSrT0qN9dT+p4bg9pSHaR588Wqn5nWxB1okABjULj+gPHz6jdNd/GLowxdkOSGtOnoBE0LaSjfnADFajJ/JAxRbJAzQ2GL/iSDYgdsoGagqubmD2jNmeiBb0lLXqmUf1ppChX17zP8eILIQldtiR34T2W6cK3CG7Fjz6f6/qeKU72pT9yJ7HW5gMo2yhmfEVjhexGffssffLcFc8cwLujkdi76+iyP//mZgI1w89LqLeiO3pygz3MXUSfU8vZ1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(26005)(6512007)(316002)(36756003)(38100700002)(1076003)(38350700002)(6916009)(66556008)(6486002)(8936002)(8676002)(41300700001)(6506007)(4326008)(107886003)(66476007)(52116002)(5660300002)(6666004)(66946007)(2906002)(4744005)(83380400001)(478600001)(86362001)(186003)(2616005)(131093003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sANMMBb8bkNMbHuqWlq0gQ+eJzjq+FvZRBSZpcoydbsJ/CF+LPDq1SegV63p?=
 =?us-ascii?Q?MzJaNP/wXuiTCECuxbhiQ2GFTwaJ+p3Gu+2sN3YfeHCB5DkSNJKeZQDhPZ1g?=
 =?us-ascii?Q?y4efp16CymqE7eZwcgt6EnI7UBqfmZidB5wKW9BW3FxRXkVBio3IxLsDBIq3?=
 =?us-ascii?Q?CMFPY1sz4AkZoH9fDLQaDpmPoES3MPB45Bdsut3G/WkJwjBhYhnKtk9ulnip?=
 =?us-ascii?Q?ePZ2EKdA6KOiDXOkWrfxtNjvD3qPSeZBgU8AOWVxYDFX6J5EF83aZy5+BRJa?=
 =?us-ascii?Q?+d4GpSxYowR5ncXDMOkVSSZ4BfPCqed8U0ba3tsmd9yM+xeXtQUNI6qyJdoq?=
 =?us-ascii?Q?q70WbTnVPo91VYXlyoqZrYNYALj8UnCwb41W/s1Ix/ygWKDkMLIjwuPOAJMk?=
 =?us-ascii?Q?++w4yubiaT7isGxVWvTl8RY6Wehjr9Cl82bGe9N1+CroYjCDvgq46v1tgpa0?=
 =?us-ascii?Q?9SZodqDsYdf8y3uHeDPHyWW9ewJrRAFxjMddF0DRTuTopmWtLIzEDX+y7gOD?=
 =?us-ascii?Q?KhNaIQG6ov0uWDFXi7oSMBRZ0ZefQqmIBDuDOfPzCzFQ3J7Jw6wjQydb/0tK?=
 =?us-ascii?Q?/H7LYMtr2guVnGNw34Wzs8fFaHXDg1Bc1fbLG8AZP/pzwV6AdXiGHANHsPhX?=
 =?us-ascii?Q?GBLT6YvEV/HXKiQ+fRzrhnDE/DZbIrPq5pqkNJUtw4PQ6MRhYMDdr/RXW6vD?=
 =?us-ascii?Q?YkKWTzXgUYvFPi4rRVrecrBE/EiYBh7TEUklp/+zDfxmpEhGnJRA5SfLO1NS?=
 =?us-ascii?Q?bC8LY8PZ46Mg9VljgBEgEgbmGV1YBAyEso63FjGM9V63uNNg4rM9Yseh+GDL?=
 =?us-ascii?Q?U2/OC+2306Bioiu8HRGZ0Ukb8ajcoeX3SZLrOsrxjzCtw0QaY5irsXiWIq87?=
 =?us-ascii?Q?Usxyo2iq8146fOwi7t3tEn67hsUSSyyfIEoF8jT6RX6IdDClZ2/rKQcfP+oF?=
 =?us-ascii?Q?gIcay7zs0oHE7jJtJdD2g1t1ILL7Mc4Q8sIH+VndHVolV873n0EjcCFwk1Xa?=
 =?us-ascii?Q?4YQ68fntov8l+wJCGl69v3Xv385lsdEBG/5QaqVXSpsO0otXNuPWD5LKAsyc?=
 =?us-ascii?Q?yu5Sv2JTkNhNp3YJwQXjpXVpnY0VAhMBqp59JuUEaYe1A96v5KTpci11GAkM?=
 =?us-ascii?Q?iQihjG8IC4B2yFfiaDhYcysD2SNlOJCKgKYVOMQHNpgzAk5S/9vzsGWU9gju?=
 =?us-ascii?Q?t5KulGF68aYGJO/KjSDfxUSvsgw9mVXxqb87oQkxPB0bG8CQ1D7MxRfEQDnp?=
 =?us-ascii?Q?XgX+oI8FM/sfsto9F/6fEXSK3LoncOgm90QT3p7mEYid3LqVUQ8NpSH3yWdO?=
 =?us-ascii?Q?nLsXAI7f1B4ZVZoXGHVA47Pt2+PpCD/1KDLV41Q1urjJf5uHdYhi5pFEXYrm?=
 =?us-ascii?Q?GciqFn5WsSeB6d1sT8rZq1Md+TjjZ7WOP4ML9Bk5ui3diIQJN9d/nV9fkb7E?=
 =?us-ascii?Q?XT4C5YDTSUGYMHoc0xvqrocp/NcBh7sHA0CJ4x1K42WnOWdVX3cAv5ebAXO8?=
 =?us-ascii?Q?YvqyqnJ/+o62O41uYdyFAhpecjzYs2li/k4QAA7ofoIU/V5mmWsEt2bEdVOu?=
 =?us-ascii?Q?sNCHeo9V23QMSyorarCducZkkCO6ljvx221jA4Lr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d67b50-2c81-4670-2647-08da8b01d122
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:35:14.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/Xms6hRvU0j54U6D+vjOA3cbdpOiN9ssbLqEDOgB9W+ZIXgGXguN+HnNZlkH48xb+jhtLKXycs9ZnJBuEOlvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4497
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5.10, splice() or sendfile() return EINVAL.  This was
caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
without explicit ops").

This patch initializes the splice_write field in file_operations, like
most file systems do, to restore the functionality.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ecryptfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 18d5b91cb573..d070ca0fac2b 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -421,4 +421,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
 	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
 };
-- 
2.25.1

