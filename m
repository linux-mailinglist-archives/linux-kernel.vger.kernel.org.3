Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889124B0156
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiBIXcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:32:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiBIXcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:32:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697D2E05ADE3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:32:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KLRfV013540;
        Wed, 9 Feb 2022 23:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=hfSrv2SKQZwpNHlRz5pPwTI14Gs+RW+43zGZVmZmuoY=;
 b=JKYoekXnAFzuR8JwPl+f/NS9lEzJYKytVkOQjU5/3WseBv/vuO81/cpicCGhPgyfomvh
 Jq4b/cZqebJNXn5ZTAhfU8+reDTUooWXZMfml9NPS7PFw2qDc5hR6Pi7hj56Qzoe4r53
 /r5aHzUiJ2ug+OtWSgMlGXOhTjUuVP/M+rb7zmaTALVXY+aS5JdgM7YFMsMVfdb2AqfG
 /UhhTFqBnzh7c+OxJRRcFRZiwTellKjsS185tncvzCIVidvWWgnVmazPrsz7N1oyr6vQ
 JWOSR64Wr27htXOsrSFgvRgAr0q7Z+cjTT6IEzHmOaTc0aOqlNcaZor/FTfR43nFWgvm 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sr1k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFW117827;
        Wed, 9 Feb 2022 23:29:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIN/ljcEK4OKfwxxLCZtgtt3hTwJcf0U3ldzTTSMdCTXLKD4entbse1sTtuff8kXado5JWs9y1Nnm/BHlPH1Drxdq6DlCmUa4k06dLE85IjFF8mwTyYl8XF4D02hHkvCDqiOAUDtLo60LDtn1+NUmTGPqw+EW6x9/Zy0+VJVt3gXmVa9csrE6dUclDjWPdQBxNWnOuwniQFwCovzhoq42oebkLGMfJSABjLDCAP92FnWHQL1TRuU7OHP1MxSBJVa5pDHob4PVoXFyQHVCGpfef9B1pQKH4OJ2KevHJEqw+VjJnxN3aFO/ZdENs81br8hAxRZesiB/XR6BC7+ng0tPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfSrv2SKQZwpNHlRz5pPwTI14Gs+RW+43zGZVmZmuoY=;
 b=TRuSM/DUrRQNmb6ZOmHQGvRfWxQm1wnzff3gAcOCgVJbDloTSH37/lmL7mWsknqo6+K78htpUM+3qp/Ht+rT53UpdmqEbEoqUjtGmU0A8Us3xj0FczgP8wj9noqll5tnEe36ZKeKet59TfBA5LPlWjgoHOLsDmkkfw64durNbK2Z/fieZaE5DqFnk7cKMYmVUfhmiIoxrXhPnbS3JAbcp9wy3azRgYYegormXySEnvSEulD0R6mQH/15qbBqmO36WOaUVjYdqysqGyJ6FRBPjOXhb8DYmDKOdfaZ5QJ+TTH2OWFxDO2hxQ8LVLaxeVP4/Vsw6riFZhzPloLNFmcdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfSrv2SKQZwpNHlRz5pPwTI14Gs+RW+43zGZVmZmuoY=;
 b=FtyaCzbEfX2fvIzTiy15iNQp9P7VnaQAscsARYPyuCngJrPz9+gNEm3kc2wLZs0yGnEP2jU7QnbXVIJigCLJWAmUwB5+aYxy76s73uTq0179O8BgxE4ybQZLJYIuVQm2B50tC1v0XBNKbG+QEhf/VTZ618KDM3nnK0h4Pfl8I6I=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:50 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:50 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V8 2/8] fork/vm: Move common PF_IO_WORKER behavior to new flag
Date:   Wed,  9 Feb 2022 17:29:33 -0600
Message-Id: <20220209232939.9169-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209232939.9169-1-michael.christie@oracle.com>
References: <20220209232939.9169-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04fcd479-9ed3-43f0-5361-08d9ec241155
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007ACABB1E3BA0F6F3DB3FBF12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIu6G+eURYrL6JPqwDW2c7HWXPdZmirBHuG7LUWZk2zBUYuXC1GFVC22nyzSKp1Fs7i1r6JLkkmZVc3XHr6aZBGRNMbqIlzKlpULG7E0Bq+OAbG177UXnk4pNXJ5IZQ8obKXZPgCbMjA6y1MryOQr6DUaHVNGFBr+jtlNTlDPGzn6FEy2Vuroscrubb4CWTPgqnz41YqpEzGaxwHHmEc8KGFfEz4PJJpG2a44gRnUROu9ZZvCousxL9wt1/Lbr0ZYqOFlDRDo9MFB35wtkdc13BXz2O1rEN43hTs+W4njIQ7HTBc9ByNIYSpbOM+qEgAvbuxxSxpGhiWn+Yp9k33cd7auy5YZ29qkeLpC7agzzkxQZcWcosWOzWRj1l4ekWqyElV4slVTtUnowHYPo6nnzW1NyBYxlHioOX2f+3KDIXyFwXSIkyWexYHkSwzVmnnLQZTxpwCqIoyoVgs+kVsHDtbUxdisT1DbLsYnECG79xC4Y0+AYCJYgOucgvfczleP4G4gYUhWF/uDimSMIXC4gUUx9VuYkaPAy6p0mmqKdSNGetDwNMpqbKzQ+m4GyOG0F6HDyvJfSpdX6B2USlfHj3xnysbKAqhLjPQhvVN8UoFLxCiifvZZYEjyNX9oBxEWuHVxgitave5by2wjEs5IEaLf6ZUsIxlCE2U2pQPzGKLmPC1dvZLA/CXiPca6sDGKBd9ouNTwyYSUu0c/JKMuEiY2q819TC5cr+p5Tp1nxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(107886003)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(30864003)(52116002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pOXsbZhtb8DdBDnAyZms/csWgk91kYR8TeRFLs529CZI/v/7v7H4rTXjvygb?=
 =?us-ascii?Q?U8m/e5YIKuaIyP7CfDe171g9oD9F/EEC4xhlUudebARUQWQMiVT72T6pa6HQ?=
 =?us-ascii?Q?eAic7Z/q+U40GKFE8RVIoscFKFOJmQaLPccZDiYyDW2iYh8cI1sY6vQPmpAD?=
 =?us-ascii?Q?YW451OGNCh3QRcG+aO6eEsMCp/cPqGJokJDlJRPjI5rzgC0wOTfmURD/Zn60?=
 =?us-ascii?Q?MnVvzdi6nj+6cusoe/7+TsD2hQ4L7et/CK48JdvHgpzXnKI1YLkO4ZDKOeEN?=
 =?us-ascii?Q?m8AGc9tEbWttJTLQjF4UAHAB+3o5fHkfu64LGF/ndh/fqKUQ9sPtJglVVq2M?=
 =?us-ascii?Q?HnK7wByH6OsYsIOoQ+XSpREO14nRr8BM+N8LB0o547qvwi4BUZCdoDXJPW8H?=
 =?us-ascii?Q?zg229A+oLqXWPQ255z0CC5m/XDCvphUO0gOO8wxOuCdPQg15pO1Iz/lTtX5+?=
 =?us-ascii?Q?llH6QTyvn775WLBx8rYOsxxxo4xSaoTObNJyroKAIlHebkNEuf/4G0Lw2E45?=
 =?us-ascii?Q?8ziJZSCmfzrcwGrOQ4zp/wSye4lVDcOtmx9aArdvQrCX5BeJY2CtwxWO2Ua0?=
 =?us-ascii?Q?nlT7dZ/PpUO/5rRrVzyIWKtTnw8/RcxMR8YXiaWprHAN6dTA5KHjdJB1fOCa?=
 =?us-ascii?Q?1Oa371sF5CDRKLU43WQMGfz6oaOKfCLgOZAmo43sdVH7FCfH/qYliTbGekuD?=
 =?us-ascii?Q?B91/IkjTGmnX9C5lLq672A2G4PhwNw6tiEz8fD+Lz5mDsJBCKXsJ2gsLhlgX?=
 =?us-ascii?Q?l2GyW2sOM4m5bYquLNI+mZ14vbSxMol/owoK5wB/GuFeL6xIApqaYwhRy+Uv?=
 =?us-ascii?Q?tw94NvD2/8zucxgJQTpPegSGw24EJFW4x7EKbCutE1LgdqqWKyA/vljMua4K?=
 =?us-ascii?Q?IhSi9r5ikRJD9NZ1xg9yWKCq+QsDrX7g9rRC5fVmP1PH+BGcRuWjkmiNGMbM?=
 =?us-ascii?Q?BbzCvzSxpyFf7utaN3TxRL6MR6//D3baHHvXZxVMjGGWqtX1hPu140uPjgQr?=
 =?us-ascii?Q?dxo5FYJFIEw/ZKiJqGbOjE+M5GdwggmsVylYI0PsGESrMbxLQRDn/NGXQc1X?=
 =?us-ascii?Q?Qk87DEMx9n9MK3IHiKRGjf4uYcMWwh4BauVH58IXETg98K+VLgLsevSP0XNQ?=
 =?us-ascii?Q?UKEgYJ1pvQCike3/jl9JvAi83pbMjzcu+ibUyDrgmyWgUs7A/RgJDrvgDHXp?=
 =?us-ascii?Q?34/RwiIGJNbza84XWblVsmTnrTJD/hscn5KdcZQMOWZb+fS2z1F0Kt0CtBsk?=
 =?us-ascii?Q?3TsgoXxLQkI4uQD1VrS15+Wb5ItMVizKnGHVjd+9CNHqfiTQkLiiGU3qrgk/?=
 =?us-ascii?Q?aVwudmsQakakaWtAajjSyPG/LOLj/GWVdT6qekCXXLkFr2oo//glh00u/j96?=
 =?us-ascii?Q?C59uJm0s9yODD5U5mU/CddA1yJSakTGukroP3Zal0C0iLQlsfbEb4rVlckGH?=
 =?us-ascii?Q?jeKPvyJwQlwv8kJzZigL5xsG6bsLL6iQ4L11WxSJ893VY50h6V5DBe6pdic2?=
 =?us-ascii?Q?tLZaiTTiXNV43/uOWlsALo1vlYmrdnRNw7Fw386Boj4advj56JA2i1/eOWRb?=
 =?us-ascii?Q?7Uk5MKe8Vbo+0yQxfh9sWKVahoVKf+iLQxE9bZuq4TL29YUF31b4IENKg4s4?=
 =?us-ascii?Q?doAtAAJkXiPeoHdrU5cpsyS54/cGC1QBqbuMiCsO4LNQgRTMp4kdw4IOw6el?=
 =?us-ascii?Q?A98APQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fcd479-9ed3-43f0-5361-08d9ec241155
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:50.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xI0Htujzhs14N00QV4Yir6llm86J8MxxB7XasFU5taqOONxSsnq8DWDFC59J/u78lx+EW/mpTjFrwfg3tQA+qosXy2UonWC7WE7A/esmlfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: uTKO86xhz4icep-xjt8Mcn2LKxYDPmLt
X-Proofpoint-ORIG-GUID: uTKO86xhz4icep-xjt8Mcn2LKxYDPmLt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new flag, PF_USER_WORKER, that's used for behavior common to
to both PF_IO_WORKER and users like vhost which will use a new helper
instead of create_io_thread because they require different behavior.

The common behavior PF_USER_WORKER covers is the initial frame and fpu
setup and the vm reclaim handling.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
[For m68k changes]
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/kernel/process.c      | 2 +-
 arch/arc/kernel/process.c        | 2 +-
 arch/arm/kernel/process.c        | 2 +-
 arch/arm64/kernel/process.c      | 2 +-
 arch/csky/kernel/process.c       | 2 +-
 arch/h8300/kernel/process.c      | 2 +-
 arch/hexagon/kernel/process.c    | 2 +-
 arch/ia64/kernel/process.c       | 2 +-
 arch/m68k/kernel/process.c       | 2 +-
 arch/microblaze/kernel/process.c | 2 +-
 arch/mips/kernel/process.c       | 2 +-
 arch/nds32/kernel/process.c      | 2 +-
 arch/nios2/kernel/process.c      | 2 +-
 arch/openrisc/kernel/process.c   | 2 +-
 arch/parisc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/process.c    | 2 +-
 arch/riscv/kernel/process.c      | 2 +-
 arch/s390/kernel/process.c       | 2 +-
 arch/sh/kernel/process_32.c      | 2 +-
 arch/sparc/kernel/process_32.c   | 2 +-
 arch/sparc/kernel/process_64.c   | 2 +-
 arch/um/kernel/process.c         | 2 +-
 arch/x86/kernel/fpu/core.c       | 4 ++--
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/kernel/process.c     | 2 +-
 include/linux/sched.h            | 1 +
 include/linux/sched/task.h       | 3 ++-
 kernel/fork.c                    | 6 +++++-
 mm/vmscan.c                      | 4 ++--
 29 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..f4759e4ee4a9 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 8e90052f6f05..b409ecb1407f 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d47159f3791c..44603062d661 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -251,7 +251,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..2528fb9650ef 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -334,7 +334,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!(p->flags & (PF_KTHREAD | PF_USER_WORKER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..509f2bfe4ace 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -49,7 +49,7 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 8833fa4f5d51..050aca44ba6d 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 232dfd8956aa..40f8294c6c7c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 834df24a88f1..29015ebdcf1d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -338,7 +338,7 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index a6030dbaa089..cbb693012b5e 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 5e2b91c1e8ce..de1da9900f7e 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cbff1b974f88..6f1ed337cd41 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..dba91dd1e289 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -156,7 +156,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index f8ea522a1588..eabf3452e5e2 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..aa110383cfa1 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -172,7 +172,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..a76120e30eb4 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -197,7 +197,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 984813a4d5dc..02f91fcc1417 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1736,7 +1736,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..8deeb94eb51e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 71d86f73b02c..51169bb351d4 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -130,7 +130,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 1c28e3cddb60..0506a739b0a8 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 2dc0bf9fe62e..5386e56b5e6c 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index f5b2cac8669f..6058b3966f71 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 4a420778ed87..25dd496fd820 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -158,7 +158,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = current->flags & (PF_KTHREAD | PF_USER_WORKER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..c5b34fa8bb0c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -579,10 +579,10 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	/*
-	 * No FPU state inheritance for kernel threads and IO
+	 * No FPU state inheritance for kernel threads and user
 	 * worker threads.
 	 */
-	if (dst->flags & (PF_KTHREAD | PF_IO_WORKER)) {
+	if (dst->flags & (PF_KTHREAD | PF_USER_WORKER)) {
 		/* Clear out the minimal state */
 		memcpy(&dst_fpu->fpstate->regs, &init_fpstate.regs,
 		       init_fpstate_copy_size());
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..b0e58fe55b31 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -195,7 +195,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(p->flags & PF_USER_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index bd80df890b1e..00d81668ead4 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -224,7 +224,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 #error Unsupported Xtensa ABI
 #endif
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!(p->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..fc45e692f6a2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1690,6 +1690,7 @@ extern struct pid *cad_pid;
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_USER_WORKER		0x01000000	/* Kernel thread cloned from userspace thread */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0bf95966ae7d..0467b3ce1c94 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,7 +18,8 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
-#define USER_WORKER_IO		BIT(0)
+#define USER_WORKER		BIT(0)
+#define USER_WORKER_IO		BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9273fd81a329..1f6e7184b31f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1998,6 +1998,10 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+
+	if (args->worker_flags & USER_WORKER)
+		p->flags |= PF_USER_WORKER;
+
 	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
@@ -2497,7 +2501,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= USER_WORKER_IO,
+		.worker_flags	= USER_WORKER | USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 090bfb605ecf..bb85b454ff07 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1061,12 +1061,12 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	DEFINE_WAIT(wait);
 
 	/*
-	 * Do not throttle IO workers, kthreads other than kswapd or
+	 * Do not throttle user workers, kthreads other than kswapd or
 	 * workqueues. They may be required for reclaim to make
 	 * forward progress (e.g. journalling workqueues or kthreads).
 	 */
 	if (!current_is_kswapd() &&
-	    current->flags & (PF_IO_WORKER|PF_KTHREAD))
+	    current->flags & (PF_USER_WORKER|PF_KTHREAD))
 		return;
 
 	/*
-- 
2.25.1

