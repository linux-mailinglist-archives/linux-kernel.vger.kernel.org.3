Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02B46BFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbhLGP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:57:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239223AbhLGP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:57:20 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FDslJ004252;
        Tue, 7 Dec 2021 15:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=5JrWO2vtakmzeU17b1LNzmPiZnC72vuN7LO5yPO7yF4=;
 b=fCHMGavureRx4pZDgIwwYuJYLqhKE9iFs3sBeVKW8hgCcKvRsjGVkZpPgkOdCP6J3o8T
 vA9RXjZOGXTqtvMHqYw1SczrnFOTA5YG2Xyg8h7ob3NWen27pl1UWo07Cryg2nz2FQjZ
 v1MMDwPjcUG5WTWec6uz4Xxe6Rjqv3fqTGPYYsqeJQlsmu4EugxS9lHupfgHSj9waZ4m
 QFmKPgrynxPSPgnb2KokXRnvckPuxFMD+NNQigStajJAWHPuTy7iZx2R4pAgnf9Lt3Nn
 P6G1Y/vPqsALF3gfajIxNDtT/CbTScxf0jTj1RZWrRjYKEi9VM1OozgagJdgrAbdF/+L ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcdyff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7FofpE152882;
        Tue, 7 Dec 2021 15:53:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3020.oracle.com with ESMTP id 3cr1sp60s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 15:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4KIbK7DoK+izqrDBc7NExQRKSxSDi/Is/9bDXdhpV+056zZsPBdpxI2Y1RSLyp9TNBSQ0oFxLNvWMGL7AAJlTgIWyby+Dw4W/PiPw4VGy+OnlOcr/+fr+SnAEZJ+qElTvqPQuhgoQNF0XMlAyGY80J34ckfZaMDhDP1DHdGtVwOJ4Np6yzy2Iaxpe5Q3jakqJgU2EoOpTTmPHCHY3Lyfi7JoXUlnk6sU0sKSOtAf7dtNbCOxjZNEGlm3DJ7B5SPG8a1Bqt3nn5WOkgalYGU75Edy5T6TgTA/i3wAOTYPURAaf+XNf1JrbB0BeNEepVVaqIXERp0Oj7zs1/5CuyEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JrWO2vtakmzeU17b1LNzmPiZnC72vuN7LO5yPO7yF4=;
 b=dILpEKCIzDN5X3n4feihq2JgBO7vwiFQipEQvSdt5pRw7WmXlUo5z+Kr7YJOmLIemWLsAXroNtgiLda09X3r892IUcQQxXOBIuOG/WDppiWEZlf1SLsKsSbu9eH8GNzY2B4NSAHUoopcc3A7hA7El9P9Cn9MVsl/lSMiTEztcIva1bOqLzR45h/liSWmjUlFJxljr4qPeFyDsIebazhkFa6My3h3vw3wo8/MNAE2w/SKuexDgP6XTwbA6fDoR/DBkUAQvNn2pqol73aQef8E+GpaCXbriarGOBCh/kcYG+fy0MjgDZOl39hulbnyR0gASOo5TcoFCb5h6xSKrD3ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JrWO2vtakmzeU17b1LNzmPiZnC72vuN7LO5yPO7yF4=;
 b=AEy1YVcVuVb7W5Ov2Oo+08uY0qp9v7k/dhSMWhL55DG1Xm+33aoUzRp8kLED86ijpO3KxM7BJ9sqnAUc133MZDjugoueu87w5lmNvt1EV7ugq2Z44gKewUZe97zLNbQG5bS7tVvDBl4JOIvpPmp9WqOry93J3OuD1IZ+k/SMpu8=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN7PR10MB2626.namprd10.prod.outlook.com (2603:10b6:406:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Tue, 7 Dec
 2021 15:53:43 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 15:53:43 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     gregkh@linuxfoundation.org, axboe@kernel.dk, asml.silence@gmail.com
Cc:     george.kennedy@oracle.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "block: avoid extra iter advance with async iocb"
Date:   Tue,  7 Dec 2021 10:51:41 -0500
Message-Id: <1638892302-14475-2-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
References: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:805:ca::17) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
Received: from dhcp-10-152-13-169.usdhcp.oraclecorp.com.com (209.17.40.42) by SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 15:53:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad09aa47-9bae-455e-444b-08d9b999be6d
X-MS-TrafficTypeDiagnostic: BN7PR10MB2626:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2626809C08F21EFDB66A6683E66E9@BN7PR10MB2626.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkJlSRN29SXOJP03apSl6MMoSQ3Wp/YNrTaOlfYRk95DES/ktqVE4wYcb+Z/hcVgsxV5ulVV5VBL6pkpag9kz+RuUW8HqdEGdqN0Oh5mjbUoqdPYZo/yQ14a051T3xjGKLsDEFhIog46lSEmaWwrWYEnLmt+oWYhQpc3yPj7nWsfq+8/iFT2VdKGIJUecVgHtzq7isw+8c529LjcVSLR6UwMdQlprstm2BHdkFxmZ4hB8fVg6ydxFZPbxyPqJYXrI9Lgfhwgoa4k6mI1TlbxGANZnRdZRIEUOmriEBK0ladFeo6S/AUKYCTc9ITcqfTsMoTokE6kCc2pHipfTMY3Tp9MDPHFicEwN2TAtGpORg6BrBAL+SAQUNeLGG4DkCBJeoFUHojswKrtgI5J1KH+4H9CgxU06m+/ramPaJg4vJxTdSBVR6pJfK2BiClNyOn+3KXrW7n1aW9DUjtwmOpA5BdMXtwdGRjX8Ji1cm2F7i3aY+7zOKmmUgua+Y2Up6XvJIH7hpcVbgqFXtBuEWQVKcaCRtekhb7RccnVc5GxkVOAUfTC+wfZoi4WLTdPYZLVhIbVkadtq2dCNJoccvu9+jV3VSqlxJxyRaL5VGJdjp9IBLGlNuvxv5cZ4Xf2t6tJABCcAiIDXIXApuh6GCQjb4b1imHObZGoXxKYkDKnHh40LPwuCYgKfALODcJLSb03IHUpWbKj54WyMTsT1TSpFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(508600001)(186003)(38350700002)(66946007)(956004)(2616005)(38100700002)(83380400001)(86362001)(6506007)(5660300002)(26005)(66556008)(36756003)(66476007)(316002)(52116002)(6486002)(8936002)(2906002)(8676002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uaIIUnmeSqmDzLtG1NvPF1Sl4sazzlz8ZZRVITRy6Ul5D1U1qRla45F7KJKT?=
 =?us-ascii?Q?+Ik8uJNSmlWxqgTgMsz4/jHTvT3PYxTnJrNnK6TI7WPtzh1JDZYHGYKOjfRR?=
 =?us-ascii?Q?nEDFjx5itdFxGkEbdvjLua3+L8ZUWyl5Eye6OJ9hEru7xGvJ2JYtyEU2IZ8k?=
 =?us-ascii?Q?fnL5XX8i3Jw0/eBLl8hTETxVc9eJlIEuMm4ZMUbL+45Pq6pNonv/6ld6M3r9?=
 =?us-ascii?Q?rMKe5BoB8hHruf2ZbfiobPk4eeuZ4bf/5JrJ2Gdrs5r0wW4Hj5kdacdRZdle?=
 =?us-ascii?Q?R9JJRoh8S81BaNzHM57ALiLb0UtkP+F45y0XGIRXiKTreATUq26KINQGQ6sE?=
 =?us-ascii?Q?+Y/LWdZFafxR46nSZpRiynjVhnG6NsflHgsAS8ALgBU3t3vQKT2PGnn92nfh?=
 =?us-ascii?Q?tPSC2FpUof2w969c895tkx4/+cH8hubiZMF9gO7/6VXRGpK24uhlaA3GtUMp?=
 =?us-ascii?Q?iw1p4p9kC3KO//G+qHYnNMPLGGYgc5tSfOxQKyN3J/3qbvXcVrMhpGD5xVnV?=
 =?us-ascii?Q?b33xjvOF9t9+NbYlI92T+bPTHdNWiwWz2lIL2jAJ/oRpa/3l2P9jb7j+ZNjj?=
 =?us-ascii?Q?VL4YceNtxPXzV1D3HHg/S0mW4iF3cM/vA/hyCZdRZv9eh97yZnZ4ljmAgyvp?=
 =?us-ascii?Q?b+uZVt8AEHNz/IeM068AoDudhs7gHzQ8b/aQq4BmW1R4bBpcckAuULyxHKUs?=
 =?us-ascii?Q?X0jpTbfqIzH3H/O96BfJO96l7TxqBMKh4HfgWTt9EhdD0IQHj8UBqMsFBWl6?=
 =?us-ascii?Q?qyXaob7WtEfVitGMS5G6ZNWe7wcMllb2B/dYZZM0hobXIskYCvtNCoJPav7R?=
 =?us-ascii?Q?WPJrJTXY1lZdqndl9ddDX6/M6+vsoQuFqM8ExdfNyTZmpjYpFjJU8k9wcfs/?=
 =?us-ascii?Q?t2lDX2X/DVFJvHQ1I7RzhFFDg9JZ3UQevdrea4V44WYHAPEHFswR0hnnGGEK?=
 =?us-ascii?Q?8JWY4j5jMlhR1S9td5k1C7hfwVcc9XzjdzmeAXVtmL9rf3cbcEkFKqfAYvFK?=
 =?us-ascii?Q?IyOWJxjmQDFl8DEpiQcnovEDvN+bspboQBo2P2ZAUhlbgWPNvNFmTFIcAQhg?=
 =?us-ascii?Q?Pma0WjJhqFJyinnpOXunh1S+P7kB4H9xpLqn+Ghs8jxR+8Skraesbs+LI2qJ?=
 =?us-ascii?Q?spn6MQoafcCDxmaO3fYtkFhASzMEw3Q5YZDGU1zJ9oASjQsKfI2DYwrn2fey?=
 =?us-ascii?Q?Qeu2Z4QBr3BYXYav/Tw4FPkHmlDZHgT0lofGwP3gIw5EN+F40z6UHFrCVka9?=
 =?us-ascii?Q?QmBVx4Z+TMVEXDFyQDPBJUpCz/pFM6HRJUb0jGc6LlclSu0eRI4zE9vShDhG?=
 =?us-ascii?Q?8oH84qjJr7jV5CVGs24NozASSPKaOXHjBlrlhXZhkviuIlezRdbVsFckgc/5?=
 =?us-ascii?Q?ggSDkjsIfrgeujFHPn3Nl7BAs7TCp4EAeXqETSkpvqmPYybMmqEg+fskL+Qa?=
 =?us-ascii?Q?j1pYCXTzZ5ZoEyYLtvBAXhpK7+oaV4/mjx2dGjQU1InIwDPwNDm0mn8ftvOT?=
 =?us-ascii?Q?R7631lcOoA52s/sO1kpl0juU4/hGIX/cZ4gsixvSJ49Cbkdz6wkRq4MbtdTf?=
 =?us-ascii?Q?rIefTlGwdsrrcN0MPLnQd3xZDUHSBO4iWZ2Tq8ivU1hJMLLetKx68h0KagvS?=
 =?us-ascii?Q?4leW66YDB3hITi9i/2QT9tGpmsmZk8CpgouL1/+NcTKAZjQyRjCwlt3XjCdH?=
 =?us-ascii?Q?cUeELg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad09aa47-9bae-455e-444b-08d9b999be6d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 15:53:42.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q070kOT7Q8RmNEROB3IrFslPQSB4CJpXMRBqxQEKOPKSPKXi8SOenTkTCnGW1YmGRdIiaqA5fCZsa8/34+S6X5g4h4KzzfR3uQ2dPF4L2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2626
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=983 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070097
X-Proofpoint-ORIG-GUID: YaiK8fHGqVUBG56SamVChMqSCTvjxHRj
X-Proofpoint-GUID: YaiK8fHGqVUBG56SamVChMqSCTvjxHRj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1bb6b81029456f4e2e6727c5167f43bdfc34bee5.

Revert this commit in order to be able to revert
commit 54a88eb838d3 ("block: add single bio async direct IO helper")

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 block/bio.c         |  2 +-
 block/fops.c        | 20 +++++---------------
 include/linux/bio.h |  1 -
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 15ab0d6..ead1f8a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1046,7 +1046,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+static void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	size_t size = iov_iter_count(iter);
 
diff --git a/block/fops.c b/block/fops.c
index ad732a3..e73167b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -329,21 +329,11 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
-	if (iov_iter_is_bvec(iter)) {
-		/*
-		 * Users don't rely on the iterator being in any particular
-		 * state for async I/O returning -EIOCBQUEUED, hence we can
-		 * avoid expensive iov_iter_advance(). Bypass
-		 * bio_iov_iter_get_pages() and set the bvec directly.
-		 */
-		bio_iov_bvec_set(bio, iter);
-	} else {
-		ret = bio_iov_iter_get_pages(bio, iter);
-		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
-			return ret;
-		}
+	ret = bio_iov_iter_get_pages(bio, iter);
+	if (unlikely(ret)) {
+		bio->bi_status = BLK_STS_IOERR;
+		bio_endio(bio);
+		return ret;
 	}
 	dio->size = bio->bi_iter.bi_size;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index fe6bdfb..c88700d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,7 +417,6 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
-void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
-- 
1.8.3.1

