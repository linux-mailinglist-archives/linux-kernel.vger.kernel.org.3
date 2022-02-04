Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AC4A922D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356595AbiBDCBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:01:24 -0500
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:52289
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352178AbiBDCBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:01:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFE/+/kQWU7Sv9aO4fUJx2kpywL3OQBQD4UGd92Oxmj+tWgKEkrckLLCsuVrDPXmR4kPphxZpvHl77G6zlgJKCrGqPPn5+4Cs9cvb87yr+6rxRjf9WuoIk/J5zE/UJRqyu4yfsuaT6UP1i+p2KcGKrpafH6vGNcf32wRaubWdCd1YRKs0+o2J9tUDKdE1GE3wwoy1sZ8sq+8YVAHRtcbHZdeObuP7zvpgnA7+Le+d2y8qWkkFlohWAdlODYkdxCppdq+wvlFbweVtdFeGntqxTZ9iyZruMbaF4e6B4Fj3+53hQ3Nt4nm3itvESOwxyOev8Epb4Lr2ZKCjOOFMj4CLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKpptENJJnJtIzFcPNilhjqWWC4uFRvZ0zxpZOikQbE=;
 b=C7ev3/iIuXTkxLg805T28lx9ILVkcBbeJZ/XglNBTkNqpxWObj5qmoxZBGdJJ0R8cU/1L56wqSw6vCIZY9wt0ycmTQdB/ylufuwAAzUfWikU91Tw1gDIpZj2rSYnGtic7Qu1JJ/T02TXRDVavgeqxW3lBEIJYDKR9RLyt8PYWJJpeWuLrItOmDz8H4GG7i2bnYqM+FYcAu9ahg0bd0j/gt9nnv+7RK/FFEwOnBlxsxK9KiZFPVR6Ca0aSV7yq041khbiFf0RQs/qj4nLsl+2k8t0+RA262lIxf9eIf9Yd0+rFrvCw4+ZZFt2RhmIPNq6DOFrz8RBrsiGWZ3gG5+GGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKpptENJJnJtIzFcPNilhjqWWC4uFRvZ0zxpZOikQbE=;
 b=Avou752TaBy/Hl6b7bcNLDlfyCfRHqdR7w4A6AIbQZRCazBziYv5bkA/F0zFrSmV/iMdpyl/KWXtdhtIMW12NMBYIoMPkRYb/MVIehIl+m4mQfhJDk1OVOZMcKn9p1bmvkguh8gTQ0A87AeM6mYZIfcVQEcwLaP0GApVaSkSXQkOPjJKkkO+8lhvxJQOmvi70gs+ftTlpB5TjeDsB2xoE4B63gwN0CsdrTnZIVF/Oty9NbkQIrtxSrw2nEvyS+dtY2bn5Gl+GSFoX6lLF4voA0dzzaWQsJinGZ6R6gYgCZgslgkW3Ws8GU9xGbmLFNI+OzxDpgFzZG4siLO1P5DMPg==
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:01:15 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::88) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 02:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:01:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:14 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:14 -0800
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
Subject: [PATCH v4 4/5] mm: change lookup_node() to use get_user_pages_fast()
Date:   Thu, 3 Feb 2022 18:00:09 -0800
Message-ID: <20220204020010.68930-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220204020010.68930-1-jhubbard@nvidia.com>
References: <20220204020010.68930-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560ebe94-484b-4f80-561d-08d9e78239fa
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4442D55B3811B2EC339F8BD2A8299@MW3PR12MB4442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTXrCmqsT2/uAw2xCghVLP9a6axNYiT7cTBe4dMsFcrwlWbMNq2LbiOrnUi3W/zzRKcGoOhk/PfiDnMr6EFz0h1fyJNY5XPPIcTvY7QRLUexKkYo/g59+zr38wdNJjWzIkQaYxFnebVEQUlNnhJgoa5WznZ2rbQK+04GrDRA36cbgZPmjoJh+zKSUSxNlsna/Z8mpIBK6EV398QlVMkc00i58uvZfsomFmad/EqdyF4SlQiS1ZOA9f95yvPEiDzfuj6Ek0AcewbEtUNc0oc9TWF8achm2zU4DwqIsAtcm3xA3baE/4LH/HLQW5IEuPq8NS71k7FfMliyxoFQBcTjnCfVVW4U0Pp2FO7pEkGaslU6iXBIYmS8rrDU11WXT33NatC0ck1r2hmUP/OSNbAp7jcQxP/vQmrhIeGaglsReVg1x5iXk9Dc2koKSAjv13d+FCCyVrUr3Fy4WBFPgBzsJC2SvMZ6kFKXdV6smFTupJAXJoD0xIpwcBxJJmE8cowOALprMawXLWVPYzSAjleapXaFgrIfRHsChmx8SqWEev8/txFiZwLn6X82ENcntl8cIFBVpVSIMp87rXY4EjSLhyGZ6quHQ32iSXWCmUSqVAheOEhgGD3RNHFUFLQVVIr1TSVdFvqtCXXZgk0GPOvcwVihgYvXkCJCPnUyeb7vUm9iFjKkSfxU49/XOTGzpOZLj3NQzGUVyAs68tl99yUXIg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(336012)(426003)(1076003)(26005)(70206006)(70586007)(186003)(40460700003)(110136005)(8676002)(4326008)(54906003)(47076005)(2616005)(8936002)(36756003)(316002)(36860700001)(107886003)(7416002)(356005)(508600001)(5660300002)(81166007)(2906002)(82310400004)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:01:15.2857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560ebe94-484b-4f80-561d-08d9e78239fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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

Cc: Christoph Hellwig <hch@infradead.org>
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

