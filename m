Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36F4AB4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiBGGgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbiBGGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE07C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvoNCWNZ2cggSDFZPLcpRrpp8Nn3I/yHTSTzTR4z34Y9nwJKNYhkmE7rIvslOADF5PCZscn8PjjGSIRZdneu4zvfQlxmswocwyKQfF37QOzKAXEKQRF1DCz6BdER1CwO66gL738BQUIDlem9XGiHwxnZQxxePF36RsXjf0qluYwpSzEQvXGlqQjBMTEbDSMKFCf2b1Y22Qp2xW2FJBfBGxewKcDvMpXkk7WnDIfp37IE0BTCngS5zLuYq3C27eyXQUBOi5Sv7B6GYm2afp10ytPCVPXGGv5Qo+jbowcpU57jVvKpN7qNWGuAzJ58BPti3Oi4TeNRYlpp8a51ipErIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DegTwE9NFEicYWZOblQZZlp9tH9DIXZWSkR7haX5kxY=;
 b=iZJ/EyUXau23ZjPhW3/Ud5BKYeC5fk/tAoZdlx7iNKcCn+9oQ0SA+IkE4Fkt0hEB5b2sfIWS9I9HG/7rgSEJecfokagbTFgzLNDA20Jzy2PfljgbZyY38c4pfV5s1XJCpkgMrWQbBsz3uMOYdBbDGmK77r0OqQOJAg2W1okXUT2BOYolMhtvgzxCBHU2OeuX9sgBwJTx7IugeMaXxpvALLuzR2tT25LLYJijkAomDtyA1KRdgxNZS0t3m4IrGihFL0JJV37iBEgwjNbdGIfHMwtVIeqQ4FW+sNtAejPmRHBQDB+iWEz5XAjs9ADgdzbL4ZPdmI9MfqQRsHHYU+ANuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DegTwE9NFEicYWZOblQZZlp9tH9DIXZWSkR7haX5kxY=;
 b=IyP2X8Higir6GnJJq5liotvtAIV7HUE2JYJq5I2gMRmFzWTJYgb3IUTaipf1KZRXi/uOHqJhTdk9HApnHaj4Zq0hDi7rkGDwzWN7CTIM4thGw8ku+u3/Un9yTAyLq9495z7D8hMIoSE6WE0JGTDOY6eF68TnB6tQOE19wZzkcOWH3cUgfERy5dqS0P2XzuBxNOR4BouXCo5fDf4kfD68Tk0QdTOrgHWui6OGWEjVCyLwItvLBLBofaLCGofvWr9Gw+Fuvc0zjZeRc8ztHJ5971/ECIBH/+9IhesN6yn+PiffDVmPGtX3bWt0iHgPettRx82nPSSBgpDn0vJ9yIY8ZQ==
Received: from MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6)
 by CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 06:22:37 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::4d) by MW4PR04CA0151.outlook.office365.com
 (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:35 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:34 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 4/5] mm: change lookup_node() to use get_user_pages_fast()
Date:   Sun, 6 Feb 2022 22:22:12 -0800
Message-ID: <20220207062213.235127-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04adbb69-3679-4652-7eac-08d9ea023c07
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB399041ACD3BAD68127CB2F9CA82C9@CH2PR12MB3990.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oX6KNGEXMvfcvZ0LNfd5jFRUGqKqSG1wL/5KqQk8Pk6xH14pa+HlT/cG5J+e4TzY/ennRnOzDTJZgbf5sROtOGKhdXjKDqCKHkd9ZOF3Qdi1SjTk3HkRUvk19tVCkHzSTPBJ3CyQAZkkWa8kLXUkwHY2HBZ8TDOI1dlFsj+dRtTapRXiU7QRX+LrzyxvhqOt7cAKHY6GOSoDEFW/amBi8MXAtif1HDmbx5Pv7EcQeJFyI+/0ttDfo3EIB5IaJEraaI5aRG9rJI54GVBuiz65VN9gs5xZnW3ugkQFKuC523Fy1hPq0CwOCOmzakyTuhOjhmFWnT/K1BEu8iz0mDjMN52V/8leGWnH9ZOhtUzclJlqM1eaMCBONH6gf21UIVtqDDt2yt0QXgJKplKysmcdzcGUTKUN9GYgxW2f7rRHX8+RLQXoC5R+ATPJeRtTzOVEbmm95iDu7LxntR+Vx2/VLKlatopRzH10GiwTPRx9XLip0rb639VaZomUh/olT4Y8gMU+DCj1GjeXkBocA9buGLwMMSwng9kFlDlntnWQMWgVlXLn9XeLSqPl1nYajK3z/lJfuyn17AgM1JOVhbyB/I9goto5R0IHdj891fctbJ70q2liWUFKN/uR8I6bK3r5HhxSkvXqFa1muX2UpXOjytmX81eppMTZHv6TwUZgQ5quis/A4JXsSGTIalwG9pRWe6pu6yhFacD43jhynRvGPA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(8936002)(356005)(5660300002)(70206006)(70586007)(8676002)(81166007)(4326008)(36756003)(83380400001)(7416002)(426003)(336012)(26005)(40460700003)(110136005)(47076005)(1076003)(54906003)(36860700001)(86362001)(2906002)(508600001)(2616005)(107886003)(316002)(186003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:36.5563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04adbb69-3679-4652-7eac-08d9ea023c07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3990
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of calling get_user_pages_locked() from lookup_node() was to
allow for unlocking the mmap_lock when reading a page from the disk
during a page fault (hidden behind VM_FAULT_RETRY). The idea was to
reduce contention on the heavily-used mmap_lock. (Thanks to Jan Kara for
clearly pointing that out, and in fact I've used some of his wording
here.)

However, it is unlikely for lookup_node() to take a page fault. With
that in mind, change over to calling get_user_pages_fast(). This
simplifies the code, runs a little faster in the expected case, and
allows removing get_user_pages_locked() entirely, in a subsequent patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mempolicy.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 028e8dd82b44..3f8dc58da3e8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -907,17 +907,14 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 static int lookup_node(struct mm_struct *mm, unsigned long addr)
 {
 	struct page *p = NULL;
-	int err;
+	int ret;
 
-	int locked = 1;
-	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
-	if (err > 0) {
-		err = page_to_nid(p);
+	ret = get_user_pages_fast(addr & PAGE_MASK, 1, 0, &p);
+	if (ret > 0) {
+		ret = page_to_nid(p);
 		put_page(p);
 	}
-	if (locked)
-		mmap_read_unlock(mm);
-	return err;
+	return ret;
 }
 
 /* Retrieve NUMA policy */
@@ -968,14 +965,14 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
 			/*
-			 * Take a refcount on the mpol, lookup_node()
-			 * will drop the mmap_lock, so after calling
-			 * lookup_node() only "pol" remains valid, "vma"
-			 * is stale.
+			 * Take a refcount on the mpol, because we are about to
+			 * drop the mmap_lock, after which only "pol" remains
+			 * valid, "vma" is stale.
 			 */
 			pol_refcount = pol;
 			vma = NULL;
 			mpol_get(pol);
+			mmap_read_unlock(mm);
 			err = lookup_node(mm, addr);
 			if (err < 0)
 				goto out;
-- 
2.35.1

