Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047344AFDEC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiBIT7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:59:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiBIT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EECE06C412
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:26 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HAbE1027666;
        Wed, 9 Feb 2022 19:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=j0oWpMhrVtFGnGj0GqWGztVHMmb4qcECw6VUMycpGKI=;
 b=0PRwB2aeB39K5QSYTh213Xcp7F9mXk3ZJATETtGZOZ05yVn6e3mppss0oDPcUEOOPgpn
 L1CNSNPRA5VHsMPI1Lj3/ADSkNvrYRu7+YA1DL4aabGArTCtZlZ+dOm3SWXDAJKFijt/
 Lu320Pa6E3lFH5v9KDDxKrxQgShAM3wZvS+bOXg7JUQEl6fx68xp9Xl2OkcoGkdnOSps
 la/mAjCQaL5D8wfSX8PTo4X+V6Fwc7uYr36dQDWXEvP47etSnX2UaHamITpi4Z/FX/3T
 N1LUY+AW34hawQfNjKtuMsC2GOeMSFLkP5Aaf0ARqtmdDpj+v847wXQad1RgD5Byn3Ra hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdswn35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtqrW046251;
        Wed, 9 Feb 2022 19:57:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3e1ec3b0ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBBEL/llaCZ0t62ylMzYgQY/A5AaqrWkFma+wQZgVLK6WktbHXbpeEGTQixu5ksd8XCoFk6o0EhD85orSD7UCGqHs+htztGhcASwAzAZde4vKSrqKasWfG48e1tJ1qgV+uGjKmlBdHzYbrDbwekUDgdxt/BgaBZydFoFPwu8JtmDCSonRdL8/sMqjK5gILrNZ5PtTNYPj9z5Ujavl5AuEtmpn2K/UAliFcgm08jitZRZYBATuoH6HbyiwJG4UfSSD8nG16CdAayt6lckNIyBwo1KLR4rK2sl4bRy02hM996K5g0aqQQrZvJQhf4qE1cNYAN6UOrrIJ653/Xz/BYbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0oWpMhrVtFGnGj0GqWGztVHMmb4qcECw6VUMycpGKI=;
 b=cXKr2jVX9Mlq9+AkoWBqHerMgor1I4vn9Q3bf+UnPshUBv74Qqyog+raIzEu7VAhpA1YzISO1orB/Elm8Rd9JHoPgd0By3AJHLlw6ii1hpDkBcLtcgA5Nx396sKxrC8BypQ+ldYzQCBKQkZOrajHV/1NW5SR0hmyDFl2FcogQJ5IW0NGAlnl8oRsWpbQSQ0KQukH2iRsPnqo87sZYtrUi3JQTxs8rBolK2A1CP8OjqxgthbUSpBy6rQdDLHjbmOn/3l65gJVxfxpglOhgXNEtm8mn9QDGWvhAmeLsmmC+p0vUw46bfxkmJpIMEWINHSnEHHIFIjSx8JNKzKN+jKeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0oWpMhrVtFGnGj0GqWGztVHMmb4qcECw6VUMycpGKI=;
 b=HD/BzDxiTi1SGQL/kUNjoZMszVHiFCSN8CeVM3l3W9Zuqxj6HhfvgLr2ZlgC9EqJ2u1rFEqXwhrn7b2MyYk3+wZGY5kW7TCT6VRjaGUGZpWMe2CLPjBwz1ncAsH04XKyetNffIzg9Gv5w/NB231XDPKEMM9Ssqi8kK+AhC/y5Bs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:36 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:36 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v4 07/10] crash hp: exclude elfcorehdr from the segment digest
Date:   Wed,  9 Feb 2022 14:57:03 -0500
Message-Id: <20220209195706.51522-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7775026-4561-4885-8d63-08d9ec066b01
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701CA7B33BD447A9018D7A0972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l23Opjep0BH4DUoBbQw8O4G0ZoKa6ciECvY2UYRTApvb9EK0TnKmShnln7hEQf6+Xh7Acw3gvHCBYDgcm/C2sQT1JYjpESmx2g+4rdEaHzMjmnyPLJ1q6tI/pJBGaVoX0fgI2Q/m9rpIGMQdbkOew45iGtuP9AUYjmax9K7wE1HNqlvJwccqxijPRO4LMx2sLCsB1qcL8uK0yOaGKlF5bZPvuK3JTkf7oytrkXLfAfJBgusOK4ZArMYpEHWfkvlqgA3E3fxYlKUJVStlATwxRpCN53wVvhhLLEH19i/kvOWUTQPlAlT3aaKFbFSeYme5eLRDjjvE4lZR7Ib1YUnBQ41uE+KZ3BmMnRJ3sDsxiNIj8ydczi7ozYiMwNg0Xyied9JpoJfZtcglU8SlBE002eYi60MoeDzYAQbDWBBIoDBM0WPhwSjE4D92+t71rlRyPQFl4M26TBwkIaDwK9mgZ3d1WOlTrg4uAOpHOFTAZaWV3gtnNQnTJa4EhIkCEIAOa4pTqFvc8QJYYlsuCKzmQayoFJlFU8lshvzL3gmM62eLm6AKriZBcWNpICpesiuWWJXRj2kd7CoRw1Uh3vify0ZIX2MGGDM1bBtN9H6jWvXkASDHKWVy+y7zmZWVZJwE9OJl9k135hH8e8SdDk1Y8JM2nSV9M5IeOYNuj71lIY/OflSM7GHJYi3+kwQ/Yt7gp/O/c0rBjtCvqx1sCTurRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8FU3cwS7cND82R/3Iduio1YGGOiVOc+fJeokujEHFrKRu3ZaAa+JGi6jBLET?=
 =?us-ascii?Q?1jPbW77+d77aSJ+BgyrZ+uNPob7vDW2gjGVLWKhAbAI0EVadngLyA8TvS9iv?=
 =?us-ascii?Q?PB4sym3gsoioDGbcpxVFGCMffqTIXctkKMQblr0aoWK+nT9gyzadaUhIQwe+?=
 =?us-ascii?Q?zTSAfeT2kzeI1jgqmIlYlfFlf5BcGY9G3JYYSx2JMzrR1SnMbs1IwW04URLL?=
 =?us-ascii?Q?PhUxWzoCC864Sej2xB7NHeOAXcZ/CqkR0qkYb2xYYqyMcUnjSvBGBsUTP7P5?=
 =?us-ascii?Q?bQhBoTGTB9FgpQPurb5YXmFS42LWc8wAz/jtzn0bqRhzeIt2dX8Q7/gR31Qy?=
 =?us-ascii?Q?OTlJgWOa5gisrAYwAU1HJl7AoW5QOERVpA94N99PwgYKFPLOZHh0QQ5+sOIF?=
 =?us-ascii?Q?Ln0Xa8aFfgWH2oMeDDgbdtQgj3LiVkB3G0IIIPBnUZO2VuYI4kArJBP1cOXF?=
 =?us-ascii?Q?s0Dc6o1CXU2fZpNljaIm1HYPHXbkyNZBEk/3J8OXz66jj1FlF6WCBVE/vS2G?=
 =?us-ascii?Q?ngOOqkVa63v7vJfMw2GZjbE+5bPRTZps8erC9jU3qbxfKzXpJhWV47hEfmez?=
 =?us-ascii?Q?s7L+xIsSNfPHqhk0S+FbrtVQJkRqvryUXDuWPbygghmjx9EUN/jYU6MoUJrM?=
 =?us-ascii?Q?MuN9z2yYgAeZcN2VPv7menGhQDhTX3Qb1AbBeU2YEKsgKwOlQQQ+i9Utr4Hy?=
 =?us-ascii?Q?4YDGZUHuE+6OUCVWtT/gJi1/QNQAqHTEjOIUJaGBAepAxTcKRfpkkxzlByKj?=
 =?us-ascii?Q?XPMF3lQNM9Q5InZYkfCCRBUgQeFNHxSzARw+umEUt1ABKyqw4FqKZdaP2s6I?=
 =?us-ascii?Q?Wg9fM7gAMXBbX8qrhaicPcflfCaXUSPFv1la3L+IsgFsZjgbpbZeB5loNfd+?=
 =?us-ascii?Q?QT3y9+v/V196KhNbCzyFVBfNPPoOqIyRPmiklDWBN6qR+VLZXP6jfgK7pGQJ?=
 =?us-ascii?Q?8UcDR0GWJbGPEJ8DKUIYBAwP8djmlO6E7URoXVHzm+tBK4+Llfs41qFwOjoX?=
 =?us-ascii?Q?FcpPGDOS/qzlti7sR63WJhKMOP3vyLkCiiJDA/FIU5LyGvKT29iJdSrmI2tu?=
 =?us-ascii?Q?waCEWfMlYdPmf06fXPN3TRQ9dXPnYMHmw1MoGPuPxkLGVRPqtnzG5mJeGYs+?=
 =?us-ascii?Q?vCAGZeMG34Hsk9NnH202ZKLQRGGVQUxb9TYoZG9eKvdtAvbrjvZUQZ7Jacw8?=
 =?us-ascii?Q?ZenxT5hi66lo2WpKPp7Rl8VCZFCFbanavfuTiY2F+nZG6YmgxPCV4VlbQ3BL?=
 =?us-ascii?Q?7bHqyHRo+6holP2cWBl+mrWVLZPdK6eVlsdXFLH77e/4xD8QyBKzeh6iZJ+C?=
 =?us-ascii?Q?t8E63HBKZtYtWEVJUv3Mv0Aumto1KoJuuwYhdD/yfe7dtAF3YGQ2S9RsOFjx?=
 =?us-ascii?Q?aiVI8M3qr7SErSz9L9kdBewFMkIbd8UsDD+oAhrBb8/n9LdtPHf4UiCsxzFq?=
 =?us-ascii?Q?YUSZBPOjNQnzU011KkqnY/Be/MtMmOtJVZD/mEbWLlX/UAQmsvGQLwW4/YJ6?=
 =?us-ascii?Q?oAzLri0ITJvl3gsHuqOqBEygY3UV0dzIlPP3noCxUW35NhNNX012yiORhMGI?=
 =?us-ascii?Q?0B0tTCTMv1GOz2Q7W43HZUWrmaipUKj4saeuBCz7sVXS24sy6KXwvMW5mtFo?=
 =?us-ascii?Q?r6epQe0hWRwWOngsxAnegqaPzToLrMjmyH60wYp9TyrPbqfW3WR2vmdO+Y9b?=
 =?us-ascii?Q?hlSw8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7775026-4561-4885-8d63-08d9ec066b01
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:36.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Di9Mjy3eKHHwvuGinuyYw6RmLALWWdYXrdLKZD0gjQpBzh4InV/cno/xLDBXpehl5q79nYCcyqeZmicfXRLEcjvp2pSOZ7BrGlG9JuYmPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-GUID: qj4BcoWoCvivL2DepstKwDiAoevd_BNY
X-Proofpoint-ORIG-GUID: qj4BcoWoCvivL2DepstKwDiAoevd_BNY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 801d0d0a5012..93bb0c0ce66c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elf_index_valid && (j == image->elf_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.27.0

