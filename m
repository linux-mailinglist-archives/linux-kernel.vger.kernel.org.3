Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF164A922E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356612AbiBDCBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:01:33 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:29024
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352178AbiBDCB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:01:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWyoYJkXKgASKv/txtylxCKQQ+LcGHTW5DEMI5okLLzyUB8owAQNCYlQQQsvlmqlLc/qAMweCCxQhRuMutQK5lpcttsaO0Xmp6hmNpSx0N3atGJw+icq7xlA+EPgEjila00xJcAd1nRwEm6l8CZpS+Vfyk8c61+N5laqg0zwjg39h66Gy1TfJ8A9D4JUVY+MndrN5tklyM+uDf3ezwYYe+aI5VkmtrgPVKnPShXHOnqn3FYrmP2bMJxmFOuDhrtjGfNrd+GZCKSt5fk9u6rkk4XTkbr4DofedKLSeILVOW9PumskJwfAnun8K/G7gDE1Q7v0hqnYJoTtU5bjjWouBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIFxx0JMJhZKbtCOo0EVoclEbiVY2wSwOwxE/BalMcs=;
 b=KXd7CIRel15FfNKV42gYY8RGKzpEZ3xILjhhoCH3Nzwe0Liw/FpXWIkN/Kq1oUnrkehuaTWr1HljqwCOotHhhPoC0j94tQx+F6RdkFNcnDNqjRZlml8erhu43TTreiFnmgk3F8gyyCTU0wOL9x/mJTTQLUin4odiNUfadz8I+ywQPIc2EiBCEPFKEYAYp5+Rfd3jBvnsR4WMZdDMlNSOKavq3KvDjMlxiAqKSGyAyD+84C9hYBo7JeApQwo0+DY3VakMdqO5S2yQEBGzXBqJrIyJiGrf4X+iLGZmEXGfPlzoKMSfPC8XtflEB+hnN3jIzV0vruBhq1fomTDn7dERJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIFxx0JMJhZKbtCOo0EVoclEbiVY2wSwOwxE/BalMcs=;
 b=Eblf77GwdLcZch+QlVHC2E1wet+UcKAofl5u55m3/9vDE/ruYGOsV7L0GYRGZfZ8WbdImI5TsS2C+guC21cBzbLisENHPaj71rTnvgfyEoiiP8Yo/rsOGQepFCmNwUYrXagVpasg0SG8SD8763j6kLFXBvgUxuFSzGRxN1bmKkfLPetexbPb+aRsinckl4+bPVoo7oTort6jx96LCTjdaQFEq9osFy0wcTxGUb6drn+7TKSUyKSGYzi+QAADjNfpdjAKq0Cc3FtmmF0JwFUMwbX5uuzfWPhP6UNs+cCQ6lprZsgHIv/nw4Xghrwa7Lz/bz9aXjqM2ODbbXXqgmU7Vw==
Received: from BN6PR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:405:15::30) by MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:01:24 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::58) by BN6PR1701CA0020.outlook.office365.com
 (2603:10b6:405:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16 via Frontend
 Transport; Fri, 4 Feb 2022 02:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:01:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:13 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:12 -0800
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 2/5] mm/gup: follow_pfn_pte(): -EEXIST cleanup
Date:   Thu, 3 Feb 2022 18:00:07 -0800
Message-ID: <20220204020010.68930-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204020010.68930-1-jhubbard@nvidia.com>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66af168e-d2fe-4384-e675-08d9e7823f1b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4192892244964D92272F9732A8299@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8C44WVBcECKpASMQ8dXOfaEKaqpgF6cAYPbukUQLaudfCiadIOK9WG9JDJaiOWjd3x5MarJWi4CRXfSaTjG8zO4OpNaDj8/k+Xt7vFLBKwZf6xLbwAVhUKrwkjEA52r9krw1vyM3byYp4clBy5kx0q55VV2hWAMMtovL9LEPdlry3mrM3pnOlXkXkoecHAGMBJNbEZj8kR6LDSKfa7mPfGgYTsusSVJzVOUzbojr8tx+AjY6iJih+sbmqC+M4Tis4DVCFZT31s/YThGhh+/6CzT79WSXU8c7wlEhRnvdfwPbk+mdS8Jg+jkq/PDYJC0BdBHDcBT7m8I5BgN+NKp6KTURB6MWiJsCRhVYD0/Itq1X3uEu/rR97hw6AaLRUAiH8XhsNH9ubZiEr2Zqp3TKNCV57Gr2U86MjXhzGJ4oVaXF6r4DtZWYBX4nRf/el4B8T2+OEFZB69wgFBbmK3t0hLRPrng43oN6rKLmYVY7IBoFoYRTZbUKAOu70AVoSB30rIPeU5s5JO5+vH/qJ8jODM/wKD9nG+XQZQCp00FvoUieF3blsH3NS1Sp/gh8orBuEk1ivW4bbSH0GpT+cKYzJbqyzxJJnZDFMaTIfclLAitglCG0/UsGv51PU0rZOrPeHRzpT+Kc9gXWBP0vEYXJ4ONAZUt2ftJYYBrYNgTdl/1jsa4ZEhuaP3vs15uTqSvd7RHiVsH66FVVQKlcOFjug==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7416002)(40460700003)(47076005)(107886003)(316002)(6666004)(5660300002)(1076003)(186003)(426003)(2616005)(26005)(356005)(81166007)(110136005)(54906003)(336012)(8676002)(36860700001)(82310400004)(8936002)(70206006)(83380400001)(36756003)(2906002)(70586007)(508600001)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:01:23.8475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66af168e-d2fe-4384-e675-08d9e7823f1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a quirky special case from follow_pfn_pte(), and adjust its
callers to match. Caller changes include:

__get_user_pages(): Regardless of any FOLL_* flags, get_user_pages() and
its variants should handle PFN-only entries by stopping early, if the
caller expected **pages to be filled in. This makes for a more reliable
API, as compared to the previous approach of skipping over such entries
(and thus leaving them silently unwritten).

move_pages(): squash the -EEXIST error return from follow_page() into
-EFAULT, because -EFAULT is listed in the man page, whereas -EEXIST is
not.

Cc: Peter Xu <peterx@redhat.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c     | 13 ++++++++-----
 mm/migrate.c |  7 +++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 80229ecf0114..2df0d0103c43 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -464,10 +464,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
-	/* No page to get reference */
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return -EFAULT;
-
 	if (flags & FOLL_TOUCH) {
 		pte_t entry = *pte;
 
@@ -1205,8 +1201,15 @@ static long __get_user_pages(struct mm_struct *mm,
 		} else if (PTR_ERR(page) == -EEXIST) {
 			/*
 			 * Proper page table entry exists, but no corresponding
-			 * struct page.
+			 * struct page. If the caller expects **pages to be
+			 * filled in, bail out now, because that can't be done
+			 * for this page.
 			 */
+			if (pages) {
+				ret = PTR_ERR(page);
+				goto out;
+			}
+
 			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..be0d5ae36dc1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1761,6 +1761,13 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			continue;
 		}
 
+		/*
+		 * The move_pages() man page does not have an -EEXIST choice, so
+		 * use -EFAULT instead.
+		 */
+		if (err == -EEXIST)
+			err = -EFAULT;
+
 		/*
 		 * If the page is already on the target node (!err), store the
 		 * node, otherwise, store the err.
-- 
2.35.1

