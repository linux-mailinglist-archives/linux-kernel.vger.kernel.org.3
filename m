Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAEC46BFFC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhLGP50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:57:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59252 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239205AbhLGP5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:57:21 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FSsYq016363;
        Tue, 7 Dec 2021 15:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=x7eBDd7uZD4FH90JYzY9GeztOaNwJEc4yrfVqx1fUfQ=;
 b=LQguSvUxRiCzhLpIuFnMvGZEt00w9cAnKLNJHoYmZ+cPLnOXBxf2tIka/ipzUotEyjje
 tiRUlFygU8jvfshBnypeWQkthSyTzNN+cYhW2RsnIkWsXs+FYRK3QIV5Zlwn54mNvSbj
 PHj1KNLhv5nlBoImdCX+Ba+FfkERN8RI6u7JtK5/V0lrP8dOB5sdUEPurR6EoWjYILIr
 IN/MPz7uQYqsHAK6wtSuK3VrnaUgxdUhMAjVj6zJ3kgkV+8SA3vvlXmgq+az0v3D7x59
 +AokIe/Ufo2z1ACV3ttG/MIntPyn7BCuSN6dNwvT4ZvjSphxm5TCCg4GtN9hRYBdaj/I uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwnsyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FofpF152882;
        Tue, 7 Dec 2021 15:53:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3cr1sp60s7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVsid4/6vAmFTrya6sI2h3KHQUC9rjByM32bqRwVWQqeDZJU9fCQeFHmtmbtgRSHf9FOnbanZxAjkaSVhvzfTnFzcNr/8GzT1QD1V3ySB+LhQNWcWDCo1A7FxnWyH2Jw7qaWncog4IyQHVnaMKr/oBSz3RkDIW7khdf2KRuBYP4/eHZVc/l69/8ykXjPaJbVc/O6h6L+2k+XPFufmEWa5PK/erGQYrd3JDpRZpgqM0pzNid7YwjzbQSR7bgTi7w/fLLOvMjuDuDmWpEpQnC326z1Lr38KAcmzJQIGSPzdj93bePDYUq5SjBfxPCtTQ6RcNt2+KR0aJFnR2JjGa+OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7eBDd7uZD4FH90JYzY9GeztOaNwJEc4yrfVqx1fUfQ=;
 b=WgF4j/nEJhcTWs/p6pazLkUT5iauccvDlPXNZDg+jDJ8VkP1eEIbD5apGEMJoK7QDFI0iDLQPKvsFSWB5dUMGm5VESsrkGAqzwqCegqhTZOGGFk2NBirMKMpMemLlnyiaivsY+1FSKiCaN6OyaHpgR5KN6i0Nfc9GdCvKwoMc6c/5J5eH43xKRPiQ7/jP2Cs5S46Kcud7OlA5QhTM5AsRQELvapJaadlzctji8QD2y+S1mo2pAAlGdJLxZ9g9AfilJm8hmhn+0LwuZnWnd0TL4NOY+nAjm/G/bWMdoKo064L/DQd1cfYRoivJInDIlirHJtmZZ1gwxpUBwquAGaFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7eBDd7uZD4FH90JYzY9GeztOaNwJEc4yrfVqx1fUfQ=;
 b=KSrgc+vQGcSEgfT+21Im1ht1FAKOi0IVuwUzDF0iL4leJ+fOe42x70FU1fIbpkweilPpy4+3XDpyUBJI0tDJgyjhZLynSnPb63TarU0a+4XE+so8cB93tpe9lN60Dvc5ydNwtrkuxN+b72rhQRcFpn77zOPga3YiCor7f51U4pA=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN7PR10MB2626.namprd10.prod.outlook.com (2603:10b6:406:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Tue, 7 Dec
 2021 15:53:44 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 15:53:44 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, axboe@kernel.dk, asml.silence@gmail.com
Cc:     george.kennedy@oracle.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "block: add single bio async direct IO helper"
Date:   Tue,  7 Dec 2021 10:51:42 -0500
Message-Id: <1638892302-14475-3-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
References: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (209.17.40.42) by SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 15:53:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0376d715-62f3-407f-32ae-08d9b999bf20
X-MS-TrafficTypeDiagnostic: BN7PR10MB2626:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB262632BB701866E009961EB1E66E9@BN7PR10MB2626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FePtOPg1rnue3WIu5k0L+CBsOK3FHpZwneJuH/fOQsFL7uy/PGGyTJT3NYUntZ7avPUByp9bNB2lKsjKU92Gqy0fYPTLnSZY0Gdegn6dcnMCtJUTKJyfr9QsLUngLO3KIGDAzJvAHdo7fVRIZfVSKlWLLsB7MMuWVlrx6wGeL+U8R92xoyWl85xFs/SQV1cpAJN12InnYL1VAKuQe6xJ7OZukY/pTdwjDrL9VNEeotm0CCOBm7ojDZujN/wasomBAW2Dr1pmwwplh7c86itXZAI29s0ckhvTP/LeIlyirIVQnG9YeHJ/Ix36c81THVp/ISJK+Mi0+ub8O+4C/HVtNvy08VeEmISyBQiRzZwTom0AKdSkrMrhicpQbECSSiX1grSq4Qg457MWu9h4YG7F+eVNh5JCWry/2gZZ+A6u0/ugmQ8z7cgrxGBvF0Hv3HO5slfwuMW5ZOzYAYtT2/sNY4j4GH/dC0cK8d3kPVtIighpIOud95duR437fJRTHIP3TjOTYLFsmP8cGEHEHL+ft4owlQ65VnVxkEH/vcpJqMWo8xoKA4GrFPDJrC+mwn0vyFVbYqPEWno/pkz4b3D2HBXHbdcATKt5EIaKPR8dcxk4U8qL3OSmMdN5+eq0zW2jSe817lwhCla+AsFivxKLhU2IS7xa2m01AlUiDrSHQijLxOp5YoAGAi7oNfR0GecOZDGsg2cCR3onO5ETUaSJsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(508600001)(186003)(38350700002)(66946007)(956004)(2616005)(38100700002)(83380400001)(86362001)(6506007)(5660300002)(26005)(66556008)(36756003)(66476007)(316002)(52116002)(6486002)(8936002)(2906002)(8676002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QRiyvQeQDc4+LCUdJQo1xjBaaxUBDmcYroop69m+OFXonNIQaJqDWn4JXTjw?=
 =?us-ascii?Q?Nml23W5gFS0dra2gIXhrvWRNHyb9N1nmCmgEwbcQaA4bdj61fXzPCgA9s49Z?=
 =?us-ascii?Q?UXpGTavc5mX7HoO+bAXHAp6rdh4AgqCfBpZyrYydVn9ymhFoeGOseD2Ropmd?=
 =?us-ascii?Q?MFf+QUwMpnJPxgcHfQsGP3SrHbRZELJQl9iJ/VCpKaWdEKNg0UK0TThA5Qfh?=
 =?us-ascii?Q?WNH1pcFtUCjdEBuJqEzV9wsyWc2cdn/cF/wkD08IqisSqD0/tpIB6zYAetNq?=
 =?us-ascii?Q?+ta9+7TtYB/1V5/VGCWXD6zqAh1Xo7mpHwaLZ+DlTNmE3eRscSOnd1vnsxAc?=
 =?us-ascii?Q?IFfb0Uh+xZNrbeXZxFpv77itn8fmG6IX1em0YjMobMRV2ZnPie3oNh+Pr013?=
 =?us-ascii?Q?LjZWQNf3LAWxHv+4cFk4W/k5uYH8CmhKD4lQdUL1cPYvNFzT83iyWWHnIr+R?=
 =?us-ascii?Q?C4D+IRiSsQ+RQZLuf6Fgg7YV9qxn8+l7rGwydOe6N1mNk9/SugpuDFEj42QT?=
 =?us-ascii?Q?zyyt7u4SyYVA1mgDqtrHcq2kEO3GknNf0wt21RF50ezLTTbECKB8lg4EGUQf?=
 =?us-ascii?Q?YWZYMxnQgwMPzqKdDo1MS6HfRADg705I9DCXZiBVvBZXS8f6hVRzIb5BrTFW?=
 =?us-ascii?Q?ItACMC+A4qHwJZ2MTENOIywUnIUMHdzbFjExc6Mr427yMAwukHlK4uBnYF4/?=
 =?us-ascii?Q?kr2w9uEKz26v6pP/OrxsmlcqEgH7GblhwMlIvWb88MV+pI6lLcBX7vwfH/71?=
 =?us-ascii?Q?Q7XeP5LgMK0b++D+5xXmbwf4tYaf/Hk+qnvJ10Cfu6aJlDkZNHWRUgc0yDLk?=
 =?us-ascii?Q?2KXk7vBtLFJmJp8z7+rHi5iQasE+0jywrmM0HozC4dD0ZHD/HZ4Ep84rQph6?=
 =?us-ascii?Q?Mz6Yj8yxzQgvZGH9YwJqg+7yY/IhZoFg/5Vc/yzQnQwWlwPbnWd+24XEyTFF?=
 =?us-ascii?Q?/3v1L9GZ1b3WWmZrgJT7I/RnIkdrEM7qpBD3h8F+fM62KdBqT3BI2hOgDX4R?=
 =?us-ascii?Q?LNiStsPc912Ku2OObU+8i/qasGUXJauYaX2671+4+UJpQmdsUepjvANXyyAq?=
 =?us-ascii?Q?AdwHIvgDGM8Y3j7jQmvXpdIQy4p0pPbTJ8GBmYjArBSjpMeXdC+bAzr2hBuy?=
 =?us-ascii?Q?0KX2D4n/RFjbFhLJtCG6bto0T16fuVjf5yp7Ej4OIV4JSSjNYGaZZ/yVecqd?=
 =?us-ascii?Q?+UVYkzqoTXVRmkIBNeFOeHMM/AGsMGE78rjG2Xm17CuXp7yJdeH9QDiVc0VS?=
 =?us-ascii?Q?npfBT/4faQPQbDsgchzmVRaW/OyFi8Z4V5Sw/UA4VAe4LUjpLigqNrAHWrw6?=
 =?us-ascii?Q?wY6HoZwVUjvWYNHGx7/7x3Y2uk+vgfCC+OHgaSS21d0eJIorH+7euW/YDgCj?=
 =?us-ascii?Q?9rSZF3YbvuVuMnXq9BtmhU3IWiNMh1rc3QdHOX3ml37Njm9IJ0QDm3XPWptq?=
 =?us-ascii?Q?gjGp0nSZ1THudMXHCD7idOMcA0drc6//FawFldB0CqzWii0F9KmpMzpqowpi?=
 =?us-ascii?Q?31DLu6rwtibxQ0BElrfS4eD0Y1yM8A2/CtG/1DFKEdCE2984uLN3qWbX6KLl?=
 =?us-ascii?Q?yrhFCEUa9vkVvaiGBo+uMH8fXfiw0m/c8eOncHVy5G/TBDIPxUzGLxdUmY+M?=
 =?us-ascii?Q?tLYXco75B8Hzf92gwlQUmZb16nJC3iTk2t2kIv7L22iy89D8RHt7ZrwZ1VZ9?=
 =?us-ascii?Q?hbcEtQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0376d715-62f3-407f-32ae-08d9b999bf20
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 15:53:43.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBlf6ddfvrnWBx7qDFu9PFtZfgevD0RfVQ/3rl4fpmlLHWrR7rkHBjhXGA7kVenTpG9KwJIPZkKP4JRK2GgcxFGz1lgFqU6obt7zcinVQpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2626
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070097
X-Proofpoint-ORIG-GUID: 1GXDjFgWMa9sQNuznme8JHjFpfoGKP0T
X-Proofpoint-GUID: 1GXDjFgWMa9sQNuznme8JHjFpfoGKP0T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 54a88eb838d37af930c9f19e1930a4fba6789cb5.

git bisect shows that commit 54a88eb838d3 ("block: add single bio async
direct IO helper") causes the following UAF:

BUG: KASAN: use-after-free in io_submit_one+0x496/0x2fe0 fs/aio.c:1882
Write of size 4 at addr ffff888027c338a0 by task syz-executor873/15100

CPU: 2 PID: 15100 Comm: syz-executor873 Not tainted 5.16.0-rc1-syzk #1
Hardware name: Red Hat KVM, BIOS
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x89/0xb5 lib/dump_stack.c:106
 print_address_description.constprop.9+0x28/0x160 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold.14+0x7d/0x117 mm/kasan/report.c:450
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x18e/0x1f0 mm/kasan/generic.c:189
 __kasan_check_write+0x14/0x20 mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release
    include/linux/atomic/atomic-instrumented.h:167 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 iocb_put fs/aio.c:1161 [inline]
 io_submit_one+0x496/0x2fe0 fs/aio.c:1882
 __do_sys_io_submit fs/aio.c:1938 [inline]
__se_sys_io_submit fs/aio.c:1908 [inline]
 __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Conflicts:
	block/fops.c

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 block/fops.c | 86 +++---------------------------------------------------------
 1 file changed, 3 insertions(+), 83 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index e73167b..88e0401 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -282,84 +282,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 
-static void blkdev_bio_end_io_async(struct bio *bio)
-{
-	struct blkdev_dio *dio = container_of(bio, struct blkdev_dio, bio);
-	struct kiocb *iocb = dio->iocb;
-	ssize_t ret;
-
-	if (likely(!bio->bi_status)) {
-		ret = dio->size;
-		iocb->ki_pos += ret;
-	} else {
-		ret = blk_status_to_errno(bio->bi_status);
-	}
-
-	iocb->ki_complete(iocb, ret);
-
-	if (dio->flags & DIO_SHOULD_DIRTY) {
-		bio_check_pages_dirty(bio);
-	} else {
-		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
-}
-
-static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
-					struct iov_iter *iter,
-					unsigned int nr_pages)
-{
-	struct block_device *bdev = iocb->ki_filp->private_data;
-	struct blkdev_dio *dio;
-	struct bio *bio;
-	loff_t pos = iocb->ki_pos;
-	int ret = 0;
-
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
-
-	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
-	dio = container_of(bio, struct blkdev_dio, bio);
-	dio->flags = 0;
-	dio->iocb = iocb;
-	bio_set_dev(bio, bdev);
-	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
-	bio->bi_write_hint = iocb->ki_hint;
-	bio->bi_end_io = blkdev_bio_end_io_async;
-	bio->bi_ioprio = iocb->ki_ioprio;
-
-	ret = bio_iov_iter_get_pages(bio, iter);
-	if (unlikely(ret)) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
-		return ret;
-	}
-	dio->size = bio->bi_iter.bi_size;
-
-	if (iov_iter_rw(iter) == READ) {
-		bio->bi_opf = REQ_OP_READ;
-		if (iter_is_iovec(iter)) {
-			dio->flags |= DIO_SHOULD_DIRTY;
-			bio_set_pages_dirty(bio);
-		}
-	} else {
-		bio->bi_opf = dio_bio_write_op(iocb);
-		task_io_account_write(bio->bi_iter.bi_size);
-	}
-
-	if (iocb->ki_flags & IOCB_HIPRI) {
-		bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
-		submit_bio(bio);
-		WRITE_ONCE(iocb->private, bio);
-	} else {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-		submit_bio(bio);
-	}
-	return -EIOCBQUEUED;
-}
-
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	unsigned int nr_pages;
@@ -368,11 +290,9 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		return 0;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
-	if (likely(nr_pages <= BIO_MAX_VECS)) {
-		if (is_sync_kiocb(iocb))
-			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
-	}
+	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
+		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
+
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
 }
 
-- 
1.8.3.1

