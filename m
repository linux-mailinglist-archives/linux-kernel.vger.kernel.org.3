Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4E4A3D39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357765AbiAaFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:18:09 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:16609
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357685AbiAaFR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:17:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhuMiGMpcpiWqpdUMIAo++6/E+e5PxTkyVzDuhSHXzVGAn+H5ZNSv/ZY0e+OBDAOPTXLjdjFd2W0r5N61IzupJ2OTkfZeV7r81c/s7+bjmsWNoewTiuNosE40bXrTMfn4g89kX8HfSFu0GxDPBlQa7Ma66DpG4IC6/h2XInuLsVpyjpsgp1RJVBtaLgqD+vb6eviB2HKlj/14SyJifzv/QpWVLRoZLBJVjdPrVoP4RoQlJiDnVflxFHbrht3EpieSmOb3POUEjJK0s9v6W+14kD1PzW0XmKg6cFoYCJl7wSYjd5gCB+UC3fQxQpfJ7OGPUxip8BkOAftLBSMc+GhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bva+42+DrgUu9Uyzfxq4atkGyvBDi9x3N5e1IWPCg8=;
 b=aALaoV4MywgPkHu7/eJwfhjYjMmXRRck1IabIyFovnOSzIEOIhTsopnBImEtGgwHJKft9LSv/EtFqf0lmY3EB3cz9jtaTd/zSFm0vcRkdXKnvpWmokISsllojZMH8zlZpYvkndg1d6NGi0bcsVR+1o/M28TLR9Gb45TtdsI1EFVI2qt1j9QMDcoyafzImkGfQYpL93B/QjiTt8SlZUbZD/L7H5++r37AFmc6pjZna7OhReI2+tmy/BpY60m6jtn07HFBbyLTkEVDq1TbHZ0eoqAZMjKJwmFMkeRyp4agmEJQwfGYMhtqZBUPwqPY0yYGwNbLJTTN0hLzcysvMR/sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bva+42+DrgUu9Uyzfxq4atkGyvBDi9x3N5e1IWPCg8=;
 b=oy1U0pRAwcVzcsxBVuzvFFtgJuv5l9OuF4sEg1cl56abeNSVlwYgswPDoRTUAiqqTNxDaY5SSIjRfhOJdjAOIjLaX7ADR8WVg5sDBm4UJyCUBAhHKmN8XJEdPbaKLavl70bqLjm+Zg9GR4h2vSKz8n7fa5KEinT1O8rzsdWxwG0aUr9WulGz97pQ4TcCwNKeazAfSJmaID6HZURtnX69+PpVNnNYfqZ00ekxL2Vdnwo6cUBmQrv78cstU0gHLsGHw0gUQnoFRfPNIZcaP7YWe8PWNzUT+uE+zCuDyiz+T21ZHmMVFrD0BClItfHrQDlXXJvBo8ounudIZcwLLlh8rA==
Received: from BN0PR04CA0141.namprd04.prod.outlook.com (2603:10b6:408:ed::26)
 by DM6PR12MB3499.namprd12.prod.outlook.com (2603:10b6:5:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 05:17:56 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::1) by BN0PR04CA0141.outlook.office365.com
 (2603:10b6:408:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Mon, 31 Jan 2022 05:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 05:17:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 31 Jan 2022 05:17:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sun, 30 Jan 2022 21:17:54 -0800
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 30 Jan 2022 21:17:54 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jan Kara <jack@suse.cz>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/4] mm/gup: remove unused pin_user_pages_locked()
Date:   Sun, 30 Jan 2022 21:17:51 -0800
Message-ID: <20220131051752.447699-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131051752.447699-1-jhubbard@nvidia.com>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ad92a4d-b3fd-4aba-beb2-08d9e4790a26
X-MS-TrafficTypeDiagnostic: DM6PR12MB3499:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34999793241923905EADB872A8259@DM6PR12MB3499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDnoVvv9r0CbU3sNsSjeZIVQfi7BEGkDBDukLpghIiZuY3OEIVuyEQSe6M9SrJpI5U3E78YCOfvG0LkD4w0upDlzSKUsebrQiUn7Av/uzI2URRCXW3y2EIZQxosVVDNL2pXmfKuHW28ofcD44vX67+tRAyBcIXE9IJDC+55LlF1glkVVkXdB4gFuREwiHla+g/SA00BWePpKF9C79aUk9ODyX6e1/tIVnU5CMOiV2Qn6Gs+xMikZaRJg/Q4+yY13l3ks8ij4+TZDAzhVEUaWigyX4ms1Oy9PyL5plKS4bJQRiYnd50tKzTcB3SKVQbCmEySW/iMKmtQUK3FHdzjws3/IFmyfi0LWj7Fb3d9c4PDfkQlLkEzMTwOAzjPCv0LJR1adFR3pmUp62+lBQP0amuOeBWAAsRhM5byWo07N0XZWkcCLkrpsWD1CVPmqNnzCADKI+BKMXAmIF23VAd7NmYs1272kSULV54a5GEuDB/sUFBd5SDJNCzyqoA09iCDcQcEDmWpBemA4zNjN84p7zRMx5N1tlwFxRwPENUoE7k/lECHw06Hfoo9MJWjv2Vv/i5Xda/Ukrr3UFqdBYcwk+R21PPq2oEuWZcHEmWXyerRjLaS2yEBSlOalm9htyRcx23AW+QHBTPAT1a1AILjzwpWcixSrBDxQ0vwsPsr8NIa5g/hhOH6BLwtO6POIxI/9QiEtbYz1qZBySeui6lc4cg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(2906002)(86362001)(107886003)(54906003)(110136005)(6666004)(81166007)(2616005)(83380400001)(36756003)(40460700003)(4326008)(8676002)(5660300002)(70206006)(70586007)(426003)(336012)(508600001)(26005)(186003)(1076003)(8936002)(7416002)(47076005)(36860700001)(82310400004)(316002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 05:17:56.0404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad92a4d-b3fd-4aba-beb2-08d9e4790a26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine was used for a short while, but then the calling code was
refactored and the only caller was removed.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..80c540c17d83 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1918,8 +1918,6 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    struct vm_area_struct **vmas);
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages, int *locked);
-long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
-		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 8633bca12eab..58d01a96ab30 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3120,32 +3120,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
-
-/*
- * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locked().
- * Behavior is the same, except that this one sets FOLL_PIN and rejects
- * FOLL_GET.
- */
-long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
-			   unsigned int gup_flags, struct page **pages,
-			   int *locked)
-{
-	/*
-	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
-	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
-	 * vmas.  As there are no users of this flag in this call we simply
-	 * disallow this option for now.
-	 */
-	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
-		return -EINVAL;
-
-	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
-	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
-		return -EINVAL;
-
-	gup_flags |= FOLL_PIN;
-	return __get_user_pages_locked(current->mm, start, nr_pages,
-				       pages, NULL, locked,
-				       gup_flags | FOLL_TOUCH);
-}
-EXPORT_SYMBOL(pin_user_pages_locked);
-- 
2.35.0

