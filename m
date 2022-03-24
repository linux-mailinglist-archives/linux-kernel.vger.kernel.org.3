Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE14E6774
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352113AbiCXRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352136AbiCXRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:08:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC919B0D12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:06:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OGYg8q010804;
        Thu, 24 Mar 2022 17:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bXtqS8+Jt30txUizQ6WYBvP8ot8dW13GO3B8ybU+un4=;
 b=rAAlpFCAUSZmuLN70q+jUxLhtsFWiO0kJKli6lgPPLI2sVCVRCNMrI4YmCz9xCH/GuJ1
 a66ou8k7VUSVMK7JrjkWkWFS36ZeOX2jyU0pM0w2caov3qZmd43k+HXzcl0alFOyjGev
 1Kz+ti2UNQp4x139P0DJ2213GDbQ2btx8tnFAcUoUhHOh0GJy7KRE+M9ssPXZucDqXD5
 OplbHaw+IWkDgvKcyHQx0BL16FhiHrYPLf0b39NnD5ExN1PAGOf7jf1DQnHwjidK450R
 U8mOEv/vlGbiGGRx16RnSIMuL/fd5vln1kb/hwZnKUnhawN6wN9FPE3E8D6ciWYmZpRq mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ssd58m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 17:06:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22OH1TF5039955;
        Thu, 24 Mar 2022 17:06:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3ew701s347-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 17:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqSJNXXBndT/atCw2OD8kMFcA53ELXtrkyOhna2hf/gQcegoar1RtToNO3oYErxw/XeDtw+Mcx3lpn5SFT5NDAg0kImT/hwuGzq6DG9fkrd4ZwXJ3jNoHj40pRWEVHLlpm/0n9ilz3uS/3NHvIjToQzMCZfZuTaKcNyiyAu9rrPVBNz17od831xRVIsLJXtG1HUnszyimW97/Mpn4iKMw0AMZ247GviFZOUP87tcYZEqmqWOK/2nJKv6S95Tim0642WIPQuJGN20FBI2iXstCHbx1DLEVxngSUYAk3RyJeSyOEB1RnZUAi6RXV3YYWOnmI5JhIwNcWANKMolsMhONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXtqS8+Jt30txUizQ6WYBvP8ot8dW13GO3B8ybU+un4=;
 b=QX6tW4aqcRsWUUz4h8LgTFO57h6uW+afOBn1AM+A97tda4yu5UvI0nENIHXLUvBaCyLs3YcxrreeACETuUrbT5ZxSA0TwRx45RizHH3Q46ua+hAMZrpWEKV+HpdZ2xyEfq6z+d0Gq2zmwwTU0THkVmTzUO+wRiIJG2OhawaI9pSpXBoe3/tBPNTorZNBHJmiq457gIJhK8Z6aHLNHYQazJ151UrOxWimKEDbC6ot4MBcQOZfvVG0DIbDLehyQE9XDJ3B8Kuqnl0iLJdnRoh2jyBsvlsOfuLBGNtta/G1eq6JlcvVc0EiUPLec3U5OE6TfpuizTNePfHYgEWkJ4UAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXtqS8+Jt30txUizQ6WYBvP8ot8dW13GO3B8ybU+un4=;
 b=w9EdX8iqbPI70ygusP3Wtuu3Y8eyCD37UcQ5OkYQjllQSKGf88Z5Jsycc8AHYHBMmHiFaTT/df+oyRQATtlgaUgB2R0ZykRs27alhd9hmut07WU0n5YJKoNCKNRvDfRfdQDNbgeAhu6/xDPurftWjPT7AnNDOLpDt0mnhMCc4eA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2254.namprd10.prod.outlook.com (2603:10b6:301:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 24 Mar
 2022 17:06:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::245f:e3b1:35fd:43c5%7]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 17:06:14 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH] hugetlbfs: zero partial pages during fallocate hole punch
Date:   Thu, 24 Mar 2022 10:06:00 -0700
Message-Id: <20220324170600.16491-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b197fc-f1f8-4af3-c0f8-08da0db89a4c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2254F7AD93369B706FC92B72E2199@MWHPR1001MB2254.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu1xDfAJO30D78TzAXP46bTuDQtfZGE9enPigif1r1K6oUE5jeGwjX88Crfjztx8tXBjxjggpr9ER+Qf3+DmOARSGVBJK06qdxae2UcreR5LcRI6NguAp2WkVLGRrgJu/HLj2gjOylkRKTJFNnH0hF0YaXblAQHlZ3ZtKv3TbNrdwuqWgpdRw2e5sCbO55A8fOmimilLZBD9C5LqsjdWYY6Apzr+KN+R2R3bsjdzwbUEHFqmp5Y3FKadbVh49DFaQn11KF2whzN2M6U7D07qXrhPsFknCibIr6BOxvaj97GqS9+i0srD/0rxfCYbMV+xMZqWgyZXuQJ0lWt0W9yJoz1ghlU4wEPooGDk7MH5TOxyoqeoXog1ciKk/3DqzSY4SO1IGcBEv8mRrd4H8+V0vX7EZQNgIVBpKNS7NlEZzQTKrnLv81qlZxLqmw5dgv/niu9xd+Bv8/MJ/Fi9Sg96yQII1THZmdQgRJeezz4F9Vlt7R5GgOfsR5b2iwSZwDpxQU7WbYk8CLDp49thiBWwOwGRw9DlCfwmAjzoCeyUbFpFORhsCtfY45Lh6av/nVoEEtmn5ds1OSj+7bW4JejAZAevnUmQJ54JPBQ30vRaMBMynem2i9K6wmXJz7oq2G/giU+IQkPsjhrTg7kKyWCS/eVjZTQPN3s0FJSk0Y/QF1LVSReCWlu2nh52C5yStqlO3GZBKwGvqi3Y7IifLPdTeCBumUySW8/OjiE9AHZHTQgLTUeSXr2O65neus6Fr6ZwDiZTDzP1rWdfNEKexRP6oqPtGjdVrM3+CqU9o/QfoqJCw65b4k6BAyuhzM652WiW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8676002)(38350700002)(66556008)(66946007)(38100700002)(66476007)(54906003)(316002)(5660300002)(4326008)(8936002)(83380400001)(26005)(186003)(107886003)(2616005)(1076003)(2906002)(44832011)(966005)(6486002)(508600001)(6666004)(36756003)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZRrvxQ2oiV+0npsNxOMK7sDB8uLIjBJZSwPSLYAWINhwFmQrGvmU5v5151f?=
 =?us-ascii?Q?0UNCR873fyqSi5OFz+5+XJb3vvRVWFBtQlhPy7dGpMlf6w3m9Ei/NbF/tKoj?=
 =?us-ascii?Q?tWGZYmoSO6+T6KH5rF8Ln09X/bsKqI/TTjLjqth34mHXJ2CVuYEAV4kQYM1H?=
 =?us-ascii?Q?VpT0mqOYthCiGIlSR/fkr/rWGuDLJABhNNZX5Uh7H2Un2IXolQzKReruVfpu?=
 =?us-ascii?Q?isZ9nohckT1zpa29bAG4NPfXkvDqR61Qi819kN19ZPFW05FsZiJj63vhFmo1?=
 =?us-ascii?Q?JsUuq3v09dql9+QLyFRjClkdjcBjo7jGBAfKowxMJT1wCFv4zZEJ2PCT43Ac?=
 =?us-ascii?Q?k31KXZGuFs0RUGtHaU5D5nQC+S8ZvMnx86N5LzzHpDyf1mH7+6x/DCFPi1bL?=
 =?us-ascii?Q?niKTpLxTOn3VLEo8BFUBvpfG3ShMY4QTIvSqWC8w/mmj1dt2AuipwQ5wJ0SX?=
 =?us-ascii?Q?TXXj+RKuuTyovjZwS5iCLNvuBjNI3cFvIcSYtlapIbX6PHuTlG5TwXLIGxAk?=
 =?us-ascii?Q?V0Qwt3L2b4MRs56DtgnThYRxOwieQqpes3ji8AfTyP/5cgu7m4YRzbdwyv/v?=
 =?us-ascii?Q?c5wYeFwh2BTOWOUtz6lH0yfcE4Ezfxbgj1eyg21QeuDx/Jju2oDyxe8cgFkf?=
 =?us-ascii?Q?cDAUd4RaWmglvGD4627ahyLGJe89KpPM6cOjlKVr7O86/Ymh6gwcyZzcowBq?=
 =?us-ascii?Q?B9F+cHnZgG3ihrQ0xh28pp2APY0A6DHHE0nI9Xd+VXFkQg41nISOQzQGhkrC?=
 =?us-ascii?Q?a02pHPrAoa0ktptlh28sGiCS+K9I3oglr7KVE3duToL8iyhefbicLHP5DiAd?=
 =?us-ascii?Q?ImbbedUEHqlJPCejMYPPl68I55O3Z4zKWIf7nf0Pu46gXBJtu51brm+eGh1r?=
 =?us-ascii?Q?lngQ5A4WdxJ6EXG34TmY+qnVRUMM9iE0Il/GKmIzIBo40K29LWxLlf/me1R1?=
 =?us-ascii?Q?NToqq8trElRsx2fD73qW/0jm5tcRMph6GemTSfHgPPY23IUwAj9rMK0sexMd?=
 =?us-ascii?Q?mG2mLjdwycyEfkIS+Ydr9dRtlXW2Bh/OtgjmMWatgHykhOH3D+jE/MCh43Bx?=
 =?us-ascii?Q?QZBP1yFKbBqFDOTlbKjNAl4PyKNVrcTSmczpNNG4J1innx0hp6vavQFPq/s3?=
 =?us-ascii?Q?QhL38hUYKKijext4lc5SJXmFSelCfR+gHCw7KAKW05LOmniIe/kNJiI1JFJE?=
 =?us-ascii?Q?hy2BFJFFvDUZ33aAtyYht0x8gIMSno88DCd4zMSoFHNvhy7lAYNr0bDMtIuw?=
 =?us-ascii?Q?ihcoCjk+J3sI/VUPHAZdLcgF200nTy6hxRIbU72iymnZqr2ELoP4zuJ1q/sQ?=
 =?us-ascii?Q?aRcM16E5nOZ4eQcZ6zK4Huldwg7h0f9H4wn5pz6GLvwoBaY1ys6uXpgAUS0T?=
 =?us-ascii?Q?4XHekIL2cCvo5qAEGozch0AGWFVafgYADPNWRjwTm6qf0I2/AGTbLAj6Y2eg?=
 =?us-ascii?Q?//DBxRm8yuAwjqI5Od42QcZ88anbWDN3n981YooGL3WXx6ToZRAl/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b197fc-f1f8-4af3-c0f8-08da0db89a4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 17:06:14.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iigt6OLA9ZoQtSu0r/NZcVFYxji4oBpqf0uhDCrs81UD5Tw8CMCpMGYby7RT1zy+tZ6YS9TDx8JU/rXiAChPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2254
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10296 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240094
X-Proofpoint-ORIG-GUID: sWIZetxhwtNNPP6WxGkXWUdtadqCOgTW
X-Proofpoint-GUID: sWIZetxhwtNNPP6WxGkXWUdtadqCOgTW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs fallocate support was originally added with commit 70c3547e36f5
("hugetlbfs: add hugetlbfs_fallocate()").  Initial support only operated
on whole hugetlb pages.  This makes sense for populating files as other
interfaces such as mmap and truncate require hugetlb page size alignment.
Only operating on whole hugetlb pages for the hole punch case was a
simplification and there was no compelling use case to zero partial pages.

In a recent discussion[1] it was assumed that hugetlbfs hole punch would
zero partial hugetlb pages as that is in line with the man page
description saying 'partial filesystem  blocks  are  zeroed'.  However,
the hugetlbfs hole punch code actually does this:

        hole_start = round_up(offset, hpage_size);
        hole_end = round_down(offset + len, hpage_size);

Modify code to zero partial hugetlb pages in hole punch range.  It is
possible that application code could note a change in behavior.  However,
that would imply the code is passing in an unaligned range and expecting
only whole pages be removed.  This is unlikely as the fallocate
documentation states the opposite.

The current hugetlbfs fallocate hole punch behavior is tested with the
libhugetlbfs test fallocate_align[2].  This test will be updated to
validate partial page zeroing.

[1] https://lore.kernel.org/linux-mm/20571829-9d3d-0b48-817c-b6b15565f651@redhat.com/
[2] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_align.c

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c      | 67 ++++++++++++++++++++++++++++++---------
 include/asm-generic/tlb.h |  2 ++
 2 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a7c6c7498be0..f62ec4f71132 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -587,41 +587,78 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
 
+static void hugetlbfs_zero_partial_page(struct hstate *h,
+					struct address_space *mapping,
+					unsigned long start,
+					unsigned long end)
+{
+	struct page *page;
+	pgoff_t idx = start >> huge_page_shift(h);
+
+	page = find_lock_page(mapping, idx);
+	if (!page)
+		return;
+
+	start = start & ~huge_page_mask(h);
+	end = end & ~huge_page_mask(h);
+	if (!end)
+		end = huge_page_size(h);
+
+	zero_user_segment(page, (unsigned int)start, (unsigned int)end);
+
+	unlock_page(page);
+	put_page(page);
+}
+
 static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct hstate *h = hstate_inode(inode);
 	loff_t hpage_size = huge_page_size(h);
 	loff_t hole_start, hole_end;
+	struct address_space *mapping = inode->i_mapping;
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 	/*
-	 * For hole punch round up the beginning offset of the hole and
-	 * round down the end.
+	 * hole_start and hole_end indicate the full pages within the hole.
 	 */
 	hole_start = round_up(offset, hpage_size);
 	hole_end = round_down(offset + len, hpage_size);
 
-	if (hole_end > hole_start) {
-		struct address_space *mapping = inode->i_mapping;
-		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
+	inode_lock(inode);
+
+	/* protected by i_rwsem */
+	if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
+		inode_unlock(inode);
+		return -EPERM;
+	}
 
-		inode_lock(inode);
+	i_mmap_lock_write(mapping);
 
-		/* protected by i_rwsem */
-		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
-			inode_unlock(inode);
-			return -EPERM;
-		}
+	/* If range starts before first full page, zero partial page. */
+	if (offset < hole_start)
+		hugetlbfs_zero_partial_page(h, mapping,
+				offset, min(offset + len, hole_start));
 
-		i_mmap_lock_write(mapping);
+	/* Unmap users of full pages in the hole. */
+	if (hole_end > hole_start) {
 		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 			hugetlb_vmdelete_list(&mapping->i_mmap,
 						hole_start >> PAGE_SHIFT,
 						hole_end  >> PAGE_SHIFT);
-		i_mmap_unlock_write(mapping);
-		remove_inode_hugepages(inode, hole_start, hole_end);
-		inode_unlock(inode);
 	}
 
+	/* If range extends beyond last full page, zero partial page. */
+	if ((offset + len) > hole_end && (offset + len) > hole_start)
+		hugetlbfs_zero_partial_page(h, mapping,
+				hole_end, offset + len);
+
+	i_mmap_unlock_write(mapping);
+
+	/* Remove full pages from the file. */
+	if (hole_end > hole_start)
+		remove_inode_hugepages(inode, hole_start, hole_end);
+	inode_unlock(inode);
+
 	return 0;
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..4622ee45f739 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -562,6 +562,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
 
+#ifndef tlb_remove_huge_tlb_entry
 #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
 	do {							\
 		unsigned long _sz = huge_page_size(h);		\
@@ -571,6 +572,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 			tlb_flush_pud_range(tlb, address, _sz);	\
 		__tlb_remove_tlb_entry(tlb, ptep, address);	\
 	} while (0)
+#endif
 
 /**
  * tlb_remove_pmd_tlb_entry - remember a pmd mapping for later tlb invalidation
-- 
2.35.1

