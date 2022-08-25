Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64AD5A1B11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiHYVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbiHYVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:31:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E7EBD098
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:04 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGTSe4005807
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=uien9I9/yhH00YAFVEobmw25WG+SJWjbrVulEVTverU=;
 b=Dkt7hI8aIBVy/JYVx3xACW0zEof75KS3MZZQhQIYQ3EswSFWMXy+g+CoXuZDPQi2a8GP
 Z8LIx1pLYalEOmpkmy2RsCsMCUgFUfLaKKwXfg4tKp7DGYP/snxeDmCNZh4NqwS4ba/x
 UnDlq8+JjNhotMRKHe/2nnqNESxepcYjbqQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5u5785gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:31:03 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 14:31:01 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 093D02DC95F6; Thu, 25 Aug 2022 14:30:57 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <hannes@cmpxchg.org>,
        <akpm@linux-foundation.org>, <riel@surriel.com>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: [RFC 0/3] THP Shrinker
Date:   Thu, 25 Aug 2022 14:30:51 -0700
Message-ID: <cover.1661461643.git.alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2gGg-llaj7bS_V_FyWCGeZUM_l_XlDJM
X-Proofpoint-ORIG-GUID: 2gGg-llaj7bS_V_FyWCGeZUM_l_XlDJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

Transparent Hugepages use a larger page size of 2MB in comparison to
normal sized pages that are 4kb. A larger page size allows for fewer TLB
cache misses and thus more efficient use of the CPU. Using a larger page
size also results in more memory waste, which can hurt performance in som=
e
use cases. THPs are currently enabled in the Linux Kernel by applications
in limited virtual address ranges via the madvise system call.  The THP
shrinker tries to find a balance between increased use of THPs, and
increased use of memory. It shrinks the size of memory by removing the
underutilized THPs that are identified by the thp_utilization scanner.=20

In our experiments we have noticed that the least utilized THPs are almos=
t
entirely unutilized.

Sample Output:=20

Utilized[0-50]: 1331 680884
Utilized[51-101]: 9 3983
Utilized[102-152]: 3 1187
Utilized[153-203]: 0 0
Utilized[204-255]: 2 539
Utilized[256-306]: 5 1135
Utilized[307-357]: 1 192
Utilized[358-408]: 0 0
Utilized[409-459]: 1 57
Utilized[460-512]: 400 13
Last Scan Time: 223.98
Last Scan Duration: 70.65

Above is a sample obtained from one of our test machines when THP is alwa=
ys
enabled. Of the 1331 THPs in this thp_utilization sample that have from
0-50 utilized subpages, we see that there are 680884 free pages. This
comes out to 680884 / (512 * 1331) =3D 99.91% zero pages in the least
utilized bucket. This represents 680884 * 4KB =3D 2.7GB memory waste.

Also note that the vast majority of pages are either in the least utilize=
d
[0-50] or most utilized [460-512] buckets. The least utilized THPs are=20
responsible for almost all of the memory waste when THP is always=20
enabled. Thus by clearing out THPs in the lowest utilization bucket
we extract most of the improvement in CPU efficiency. We have seen=20
similar results on our production hosts.

This patchset introduces the THP shrinker we have developed to identify
and split the least utilized THPs. It includes the thp_utilization=20
changes that groups anonymous THPs into buckets, the split_huge_page()
changes that identify and zap zero 4KB pages within THPs and the shrinker
changes. It should be noted that the split_huge_page() changes are based
off previous work done by Yu Zhao.=20

In the future, we intend to allow additional tuning to the shrinker
based on workload depending on CPU/IO/Memory pressure and the=20
amount of anonymous memory. The long term goal is to eventually always=20
enable THP for all applications and deprecate madvise entirely.

Alexander Zhu (3):
  mm: add thp_utilization metrics to debugfs
  mm: changes to split_huge_page() to free zero filled tail pages
  mm: THP low utilization shrinker

 Documentation/admin-guide/mm/transhuge.rst    |   9 +
 include/linux/huge_mm.h                       |   9 +
 include/linux/list_lru.h                      |  24 ++
 include/linux/mm_types.h                      |   5 +
 include/linux/rmap.h                          |   2 +-
 include/linux/vm_event_item.h                 |   2 +
 mm/huge_memory.c                              | 333 +++++++++++++++++-
 mm/list_lru.c                                 |  49 +++
 mm/migrate.c                                  |  60 +++-
 mm/migrate_device.c                           |   4 +-
 mm/page_alloc.c                               |   6 +
 mm/vmstat.c                                   |   2 +
 .../selftests/vm/split_huge_page_test.c       |  58 ++-
 tools/testing/selftests/vm/vm_util.c          |  23 ++
 tools/testing/selftests/vm/vm_util.h          |   1 +
 15 files changed, 569 insertions(+), 18 deletions(-)

--=20
2.30.2

