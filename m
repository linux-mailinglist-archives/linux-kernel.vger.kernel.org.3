Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0CC4A69A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiBBBlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:41:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243588AbiBBBlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:41:17 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120XCvT015791;
        Wed, 2 Feb 2022 01:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BvqQ5y3f3dwZNLlUZ9/s580M/wXc76Av07SpkWkj8W4=;
 b=zpsylloabR5ouDmWX3WUhbmKt7BmBO2/eouDA5Tb9sfnG4jy16AIx70o6As9db9VYtSW
 r8Qph8u9zYT7H7lkrmdHma/Xreu9epBckgkAcDya5JgTlHkIIIukHW/mpTOGSYCabCVu
 Fy2dqfEuyCZf9C75ylAx05BrH6mE1DoY6dZDJayOgJ7noTg8okntaP4DDLRofmaL988G
 O+LzMrF2sY3N5oDCxE71Va1oi9MUsAqzDt60Sw/d+qfI8WxJIwVzyWMlQV+BeCLu+yig
 S20cC787vIzJkokblg+oHdsX/zoVXUM4cqbbxfHS9uUy2BcKfwlAonOgG2jO0L6oD+GC TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9wcje7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2121VbwZ024096;
        Wed, 2 Feb 2022 01:41:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3dvy1r63uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:41:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeprMzFyiaVxUpyhz4i8M/WVp12RkbiJz6YN7SLfSYinSlQucM5nBXqKGqqEMsmkAemmkMnZBSHRv5RRx04V1MPQoyr7BZFdZloT96L5HvPRsxWjJbsrIg7SQ3x5LISaotoBKZ1qPre5I980yKJYAaJuoy82FFk6g3+qKPzwcwdh1YvxgXcDgg+qS/ucS0GnFcAoIlJGK2Lt4mLn3ZV+kth3HhgdjUeoH0IrhS5MVcJ1a8XYQhXe5c11MAftrjJHffgd1obvQgaVUzwIgOC8M5wZmxgUxz0H0KHJ2xioXIFTa0sSJFWb1Pb7GSWVgqYCP4YVkqag7CDz4Gctechblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvqQ5y3f3dwZNLlUZ9/s580M/wXc76Av07SpkWkj8W4=;
 b=hEjfwCm5nWmpu4nBTdp9QE9AbceGsMopyZGFYvOHo8DsI09THL0Fc1KX7ypfMNsH4+HJJQ+V7B3OR8ra2xzPu/faUcj4xuOMvusyCR5/X6U5mzWLRA7cAy2HUUjFS1cjDgZ/p6TYua0PdHONmhhDLFVcJ66U6FbV3/qmh1ZuT+j8Gg8AgPSzC5Ls/T8Uv/3iHdSBPfGOpTcWtGQkuHprBW7SekYHy1pA4o1H+eoEfoauj41DVnvPaLOxvs2xDkgqbAet8wl4csUefX/FXhFH3pUfRyev8zP5QU/NdP8HtFojq37u2RqhAJnxcGiVzVxCs7JL/+d3F/soi4eX6lcfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvqQ5y3f3dwZNLlUZ9/s580M/wXc76Av07SpkWkj8W4=;
 b=sry0/RUR63B6Zm390daNWgrLh05VwgG+U4qGYIVNARLB8BnKJ4qL05dIJQFbcb0uCWVZLCPH2c/Y0KtulQ7nN2KPJUI8Wk+LcgU+Pj36rQfHhzwfNGrFJJgqkI9flj8qo/cYwSTYf8g8oKu7Ahk+d+hRZeRYq0x5cvYeTKiGcpE=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM6PR10MB3433.namprd10.prod.outlook.com (2603:10b6:5:61::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 01:41:03 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::1057:d8d1:8372:c8b4%8]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 01:41:03 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Date:   Tue,  1 Feb 2022 17:40:32 -0800
Message-Id: <20220202014034.182008-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202014034.182008-1-mike.kravetz@oracle.com>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:104:1::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c47189-2d8b-451c-5648-08d9e5ed129c
X-MS-TrafficTypeDiagnostic: DM6PR10MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB34338AAAA9D0DCD3317FC4C4E2279@DM6PR10MB3433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aIYk+h7GTkMJYfoNXq5Y1bhQloRFP+KQN3+dGexNA/nCMB0cTZWYkkn9KCG/WpAfT3UkCSMOFSLz0qBWqzALYAy5HfMAINWm6Bdwo1xBVP2v5wvtt9+D/mS1HF+rne67DlunjuaycI5ZgfgX3qa/nwE5tlAefrPqX9B38sZoZF4nCv4bUQ/jPz1st8Xpkvw3WYcK320qgaw21Igp2S0/GTs/xq1+6X7ERaMz9VbycTJt4IvNcriCdDkuoGgE1LLXQTgTD2ZRO0ADRvjTM1RrsDFhFIMfLn/1+tIx4ov4uNsjZSMNp17KXLxsPXPkWyBqGv9ZYjJ2fUJGXEiV9RhBL7hZBe5hbfsywz/yv8zDBR8yNqo9j9kCf50bDnAJibgmj+qbAmHbkEUsQGqisRj00RSkYhiW9BF3+0B6GNo6hRPmlZRzeDzKGatJIvS/uujOF8OAFs/dhCy6hlKJcuXMwYnvbAx+OEFMMCbYJ8eyrs4sf0ef4BJn8hmBk0gfiB+8dsKeghRgn9JdqRThuwZt5FiKaTnPErrU7OoTly8C/YGDQNVVOhNh6JeGDeIn6hymoBEnGv9jESpzBDWi6K4zazCUYVt6Pf3OlVJqfy0MR6ZGtQbCdQyQyjSYq8/xzh4nKgy9w9NIiyUUW4dd+Of+9tJtFQOtJoBDo5/aga4W9zHUy2MLcPaHMetzwznVqrdFUY0U4xj6hG1Uymng13qAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(7416002)(54906003)(44832011)(5660300002)(86362001)(38100700002)(316002)(4326008)(8936002)(66946007)(66476007)(8676002)(66556008)(6486002)(508600001)(83380400001)(36756003)(52116002)(107886003)(2616005)(1076003)(6512007)(26005)(6666004)(186003)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eJzh8fpveZa/MRBux/+ii6gTEcTNZP8Z+84CuEoK05Q+rfB8SS/NLhtAeeCV?=
 =?us-ascii?Q?KauiEF8iDbM9vow/Mf7JdAesPzvfDCWpQazfzQo0FR0QAILX3c76sBra3WDt?=
 =?us-ascii?Q?MB8bQ+WeMUisoKHEin6xzodusoDoJf92V3eCh4A468hD9gMHADzYzP1Bqb8/?=
 =?us-ascii?Q?01TxO60DxLhzXP6fZA0TBQZDsyw4hMWsiQJVqWukE8nyzFr4qL5VQiEEZjkL?=
 =?us-ascii?Q?X3F4/G/lYb1MAvELV46nf3gRLWWjH2jrK/DhJJ/NzZj2dtTfy+CEgBwvQZGF?=
 =?us-ascii?Q?PL3XkrNW9J6WV2KXe+9Li3i/Wh1jhADbpx5YEX2giZcNXrjCyzUNMkwaezfk?=
 =?us-ascii?Q?CCV6MgGz44KtKykClYb/qxjG2H8f7Avbgjm03lKCYkksEZ0ZNCVfe7vBT9Jy?=
 =?us-ascii?Q?lv5WbGTSAhnCMBr+BcuyBBmxuBkoXL3LDyfzwHOLJCr7ML5+3smtU2QRLlqi?=
 =?us-ascii?Q?EI2BM4MCANF+hTRrIO0aquwet7V9z3w/zS6zSBxbUhLjnulg7t7dC28kUJ+n?=
 =?us-ascii?Q?PdEP+N/cPnknn/FdSrpbivV+35QonNG9DqU6auvNwiH67zrae/ctx9h5kV+v?=
 =?us-ascii?Q?g/LcHDjGEVXOcYbzIiiYJWvBDRsY5VgB2iMqIY4kQGBGnezJLYYoBZ096Lls?=
 =?us-ascii?Q?zAqk7uuqsFp0ewpsqkRtgnYB2tupb3zfrsbQUsaZPFJwRj3MlEbDSO5eI/ld?=
 =?us-ascii?Q?HjyjoIoaPcppTHWi+PqI7LS7oEI1XiKiaBpbv0SlhZXMIgSk5PkCE9TRIy4i?=
 =?us-ascii?Q?+MZxYiq4pJ66n1ZG1xDDhgL6Zv7DA0iHPonB0/6ut8XppKdOIwRV8VScPGSN?=
 =?us-ascii?Q?2EHYKBrdKGi65EOILIEbQhjTRSu6wMsR4hC76xVUZ+nS8YnPlgLDqmtJeSN3?=
 =?us-ascii?Q?2Ob4ThXagscGnUDwwG6OWLWoLlbOMzLSy2yTSD1zQ9kPD9EWX6j3gboOEYBF?=
 =?us-ascii?Q?WJDs11XDLUfUcB0ZLpXskdTUdYyf51uUdx6I3Hc7B11Dhek+6ucnCHMb0mWO?=
 =?us-ascii?Q?IjO/TvfcEl3jEHeKXMICTqMHQgJVroXxbl0OKyraRx6mf5s41mm9BShx4M8A?=
 =?us-ascii?Q?gdsP3+yiwY92/CgD3NWeBSf9sCg2wyRX4csdR5iYrcfyBGhHYGUgVa3ARhni?=
 =?us-ascii?Q?PbhaUUwlH9oJHJgNpXCdKJeyRN1XBJREUhbdcaUHlw6TRMRB+9SSpnDP29VX?=
 =?us-ascii?Q?rE9CwM6G4sxXv5PxZkoKn2PN6qm5hw0aKOvXhbNptUoeDU3emB7f9HbO6fA8?=
 =?us-ascii?Q?tO9jIQ7oLTL9sstepKl3Fas0EF80UXhScgBJBRBgTXrc2LFR6zFjselGMGWG?=
 =?us-ascii?Q?UQG5qE5SL29yF/eQt3jxa5mlipOyU68luwCjz/DQV5UY8iFXTf3Gafv4jouR?=
 =?us-ascii?Q?JYFA2P2SxBaYH4AP1lUZijDNcm4NJswPBfKObuWImh0rI7q7YrHOpWGDaWTR?=
 =?us-ascii?Q?awy6EKpTwHq+5zU7ayBR+QtPpHYiufY1+zvwmRgrfGE3WvBWM0nmwOuzP7On?=
 =?us-ascii?Q?r6F56O+Ofn4G2bAkxawwaXDYKrWrXrh4GDK1/aHJ2RhqCZUUHEJHLkELz7K1?=
 =?us-ascii?Q?Ua03vyJdC9zIqFchgNjToA681bfVoVsr8GQl7NnTKIu+GPc1RVzpH4Ods/B5?=
 =?us-ascii?Q?ujpiMnZcoLQEcTcD3hSjQUI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c47189-2d8b-451c-5648-08d9e5ed129c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 01:41:03.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6om8MX0LGt2DlaRyVpCXXc8C8pZDIQL215JN763o7hUuBSIlaUCoCmMcq+3QLRh5mwJjCu3FZ3CXzNeCsrYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=918 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020004
X-Proofpoint-ORIG-GUID: 6gTJYGYbgXd2uZTpWJST8zAVIS9xH3QQ
X-Proofpoint-GUID: 6gTJYGYbgXd2uZTpWJST8zAVIS9xH3QQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED is currently disabled for hugetlb mappings.  This
certainly makes sense in shared file mappings as the pagecache maintains
a reference to the page and it will never be freed.  However, it could
be useful to unmap and free pages in private mappings.

The only thing preventing MADV_DONTNEED from working on hugetlb mappings
is a check in can_madv_lru_vma().  To allow support for hugetlb mappings
create and use a new routine madvise_dontneed_free_valid_vma() that will
allow hugetlb mappings.  Also, before calling zap_page_range in the
DONTNEED case align start and size to huge page size for hugetlb vmas.
madvise only requires PAGE_SIZE alignment, but the hugetlb unmap routine
requires huge page size alignment.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/madvise.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..7ae891e030a4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -796,10 +796,30 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
+	/*
+	 * start and size (end - start) must be huge page size aligned
+	 * for hugetlb vmas.
+	 */
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *h = hstate_vma(vma);
+
+		start = ALIGN_DOWN(start, huge_page_size(h));
+		end = ALIGN(end, huge_page_size(h));
+	}
+
 	zap_page_range(vma, start, end - start);
 	return 0;
 }
 
+static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
+						int behavior)
+{
+	if (is_vm_hugetlb_page(vma))
+		return behavior == MADV_DONTNEED;
+	else
+		return can_madv_lru_vma(vma);
+}
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
@@ -808,7 +828,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
-	if (!can_madv_lru_vma(vma))
+	if (!madvise_dontneed_free_valid_vma(vma, behavior))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -830,7 +850,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_lru_vma(vma))
+		if (!madvise_dontneed_free_valid_vma(vma, behavior))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
-- 
2.34.1

