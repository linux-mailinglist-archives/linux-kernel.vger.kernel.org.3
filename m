Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0B4AB4E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352678AbiBGGhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbiBGGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F810C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez8Kb8af7X0COMUk99TvC0zkis9L5Zkgy6Ja/sLcqB0xC4MjJZ1Fxcr+PWEpj947yXQlloGRd+aYSWsxbLPVhn6KeK8nd8cLGhELP6aSZUY+ZrgbtMh6ugFoKMjAr2aPDKhBCzal3MxhLII0UuJcExefD3on8wOaFCev/cQ4X5CAzIml7c4G3MoJqsGnQDUHnOnSJt8zPo38qRuuNWwiAezI94I4jLiDUMWxZnQhhnJHwcyymp2aAnlI4osnaH7uxd1A++sm3ySQq8aWZ/puCq6YcD97nLUrzTUgjVOQiqGFFpwTRj8GDYlHt3NTM2LVVFkEVqPqv2Cr+jsBidFJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGv0z9ojEXOjWjpAU1jboDQlS+KHpuPMdtW9AZqOTRs=;
 b=ZviEVtGNui/AxVnsrfyLba1cwGsNl2+IHP4JX9VUT3uuwhoBez4oqaKoJW1EN+nHjKlu3qP/ywDh4wtugm37x6uhGlmXzeTvU0+MlA67CtC+CuLowwNrrPuE7BASn0jbtGP2f2aPhOqivyto8LhmBM/ZDpnzcj8CWlvtdA/wujnV7yL+NGJjhQE/3MvFi1x4U5SDJqtQUscwGqzWG3z1OZhd1eiJLEcp14dN5TfqPVX/c5p8qbzUOfvGb7drKDVO3UD60Vp66zq+Pq/FyBJMw6zui3I8LFwybqjl5jniQ0dhk9pmLPhlIqs2sU5/xaC8NcKSq/id2Wf+Yc7TGP29/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGv0z9ojEXOjWjpAU1jboDQlS+KHpuPMdtW9AZqOTRs=;
 b=iz5kPco3rurWNhuvr43C/Yp1Z5SCPsAuoOTKa+k6AD8gyd4Ywp8AFhDCxhhCnrKO8faVERah7NMLPGFRjWK7XtD82R6Q0SBs1SjqkSfxWw9oTJmSjY3XoY2SZttAt8QnAje6RvxNjHjgavtm/UmC3wovZQJgp5dDi4qFZVro52HxeNnuIfI2ZGqy27BDuKrCDDj1rnjjvr3+nTXYzmRQbtSGeCtJRBdGC8ctcw7uph5pchCeuvsNfSODa45OLHGX27aF554IonV9XZGh/cGulon5gTggDig74WV/MVIvq1AmP4tr7ivUDC1c5SP6dymHg1Vq1LcuhHu9tBqh8rxu8A==
Received: from MWHPR19CA0004.namprd19.prod.outlook.com (2603:10b6:300:d4::14)
 by BYAPR12MB3318.namprd12.prod.outlook.com (2603:10b6:a03:df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 06:22:34 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::b3) by MWHPR19CA0004.outlook.office365.com
 (2603:10b6:300:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:32 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:32 -0800
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 1/5] mm: Fix invalid page pointer returned with FOLL_PIN gups
Date:   Sun, 6 Feb 2022 22:22:09 -0800
Message-ID: <20220207062213.235127-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 431e5ffb-99f7-4c34-791b-08d9ea023a5a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3318:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3318D1B87A62A83211F252FEA82C9@BYAPR12MB3318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfc0Al0IUxK/TjjI6sWjNayEfVG05xSMkepvzALNtXSe1jf+vxqEm4HpGO5lcKtalbFWxhTDPCDVR/rX5vc76dFaWru/iBseYVC+V5JmiTfI6tMYfslds6wyBQVVy2VmBpmgX7oFpA2o2Hy44kirwqORIV9GSghUZN3ZowKzwR0G9tMMq0RIJG4kyoxVyqFIIzN+SsivHJLmxuhnk/Qvk+AgXN9GMJmlgzkma8eBJJB8VEqCijKT1JMvrhPY/fS3qpj3dCbwjOqsRqV/hf+eY76LX3bYBKy+EfgE0Mhk7MLCmxCGeiJdyFZ4sVwGJiWAMKFG0kNMZrwqdwDNOxsy6kRwYEtkvrkJi1jyX9pybiWBMe+a4JIyQ+vZP/nwenWK9YABuOOR2ofHfy+qTpcWLCDuvoB462PPovVzdtpbhUs6UBCs115LJjtKimqAgpMPCWEdt0QnTomHDlwNnerTgk4Y72EK/6KqbsHZoUwT005KiSNdIfPSA+HiC47ncN95MESOZrMm1L8x2vvbY1Rt6etH6L/VU41JnVt7sU7hfAOR/y1+soC5x2eC/c7z/HcEywfhAKBk40ySLj7JCC10ovO+XWhEzEdJEywLY6JsE7rzrOU9a7BKZRhqElq4jS5mltdtQ2/LuR5dLQf1Li2tvRHZ9GN0Sfnf9D0VcWLX6RAAdb4fOjkVtgJiL3uezrK10e2NDtiZlZXdeYxTCFOwNg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(26005)(186003)(316002)(54906003)(6666004)(336012)(81166007)(47076005)(1076003)(2616005)(2906002)(356005)(426003)(110136005)(40460700003)(86362001)(82310400004)(5660300002)(508600001)(7416002)(8676002)(36860700001)(8936002)(4326008)(70586007)(83380400001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:33.8384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431e5ffb-99f7-4c34-791b-08d9ea023a5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3318
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Alex reported invalid page pointer returned with pin_user_pages_remote()
from vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for
batched pinning with struct vfio_batch").

It turns out that it's not the fault of the vfio commit; however after
vfio switches to a full page buffer to store the page pointers it starts
to expose the problem easier.

The problem is for VM_PFNMAP vmas we should normally fail with an
-EFAULT then vfio will carry on to handle the MMIO regions.  However
when the bug triggered, follow_page_mask() returned -EEXIST for such a
page, which will jump over the current page, leaving that entry in
**pages untouched.  However the caller is not aware of it, hence the
caller will reference the page as usual even if the pointer data can be
anything.

We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP
handle pfn mapping unless FOLL_GET is requested") which seems very
reasonable.  It could be that when we reworked GUP with FOLL_PIN we
could have overlooked that special path in commit 3faa52c03f44 ("mm/gup:
track FOLL_PIN pages"), even if that commit rightfully touched up
follow_devmap_pud() on checking FOLL_PIN when it needs to return an
-EEXIST.

Attaching the Fixes to the FOLL_PIN rework commit, as it happened later
than 1027e4436b6a.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Debugged-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
[jhubbard: added some tags, removed a reference to an out of tree
           module, and reflowed to 72 columns.]
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..80229ecf0114 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -465,7 +465,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
 	/* No page to get reference */
-	if (flags & FOLL_GET)
+	if (flags & (FOLL_GET | FOLL_PIN))
 		return -EFAULT;
 
 	if (flags & FOLL_TOUCH) {
-- 
2.35.1

