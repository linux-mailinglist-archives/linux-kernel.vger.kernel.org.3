Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC204A8183
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349755AbiBCJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:33:16 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:33088
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349724AbiBCJdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:33:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgYHBqtM1TF8a0WuQIZN+XzvfmTLxAkjNu0bqsEtdJ0JQF3idbFmSo/AeAbJTO2ZQFaYA6oZj8yhEsv/KGb/V4ysnm/cBFcLOGWHIOpu90XzPxxghmJnjhjtdU6FDzScMh1LQlB5oo7nkpjT4SnwbR+KJ7rtVW+f0bCDdonU8tNtqGT3Xg+pGf42fccNs9dvccz3kgMlIsrQN5P06U98SRYWEopm/5WhoSQwCTu7kJ52SUpEJAgkaMPcG+/H+pOWGyjL3BAwD6SCgB8aC3fm1FUAnq5F/V/PSA2sipGtQ9B6y+ezAqN8EqGXbUoxhJ2ggYB+d26ISOKBhyxEs2gpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JERJax4eJmh0g9cB8bxy6cGi4SvTxqiobq6FqFcixg=;
 b=mIYI3pagBAoCc1JJ/FTqTWmPJER2/BNccPEZ7iYeycFfGf5wPUWi+mzPEmW89wx2uz4mwOhDeBuWOr4KMnLngpu1xqLwhDKkRgvOB1vVeIRq9MCfR+OtQfmFL/q7jSPtHnPBP4hfrLhEts7LqXPCWCpvrax6//zZdQyIPP5/+PMr8fLb+Qfwkr9EyyO10IZPi1EcMbS6ObQVVtT1tVXv7quq+o3fCB/LVYwr3bW8LO/rEYagosH/pS+sFGHQi3rAmIC7NrHOoF8a4dLrzFRuFlPvCRz5VS8ehhN6r3Jdptq3aAaUm8upzjMEeHd0ujEymcMCuiBMNjY64yrBOIzUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JERJax4eJmh0g9cB8bxy6cGi4SvTxqiobq6FqFcixg=;
 b=nDRBTzXKfKf6omcKn7ez0zL3bp2Vp/ARj8cO0FVeywzEqs9WSA2eGCWPTpEIP8p+Ly/el5QsSFAir0BqpULRVIjfjzqhhpl9j/scQ4pmdvg2/tEoejvQcd78oMdcrYacoyS+qgJJ1TRvLVLF5+YKExDKC0cn+ExMgM08LEwtSNcbqvOE/AYv6yanypuR5RrNz0TT9gnLTkKzWalCR58HPiJz8pYMpny7X4ueYIhSTx+oFvMKru/4X7/k8y7AtiV6Fwgvd0Lx6fP6LmOEWZkVO+AfekGvnq/eNAXtgFGlADOF7T3lvcTe/qXTir8qtwxUymXUwe1Ew2rpCILnIwb5dg==
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by BN8PR12MB4786.namprd12.prod.outlook.com (2603:10b6:408:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:33:02 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::95) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Thu, 3 Feb 2022 09:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 09:33:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Feb
 2022 09:33:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 01:33:00 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 01:33:00 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] mm/gup: remove unused pin_user_pages_locked()
Date:   Thu, 3 Feb 2022 01:32:31 -0800
Message-ID: <20220203093232.572380-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203093232.572380-1-jhubbard@nvidia.com>
References: <20220203093232.572380-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e807c420-61a8-417e-467f-08d9e6f82c38
X-MS-TrafficTypeDiagnostic: BN8PR12MB4786:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB47869525EC7DEC3800A4192DA8289@BN8PR12MB4786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ua2V01+zbWWfQhMlb+gMrlugvgqEPSHMGOz23vTqEtW7qzuqNbTUkEJWBRVKu9tZh8lML0CFPNfAnX5RinwKcrCkmOijRPMHbzGxIIyGwjX8EG7EdS2ByscXtuPxF+4FIGPJEYJxKQcO+EhwYYCagIVHbhuxyMoXZlmDxtOhVZgV0+xdCpvDabT3NPmefiODi7iiF/GiHxAy9e46yJr3777m2HFXW4Lznf7VZSuo/e8fwAUFkKQEx8E8l7eKukK+3R/9Pk1db0YBM5bh+ihtFU8OlpjigIq9plzTjRQA+mxDN224TyYcwL3h+biDlzY6PXkeA82ZaUr086rjOZHFi4x5wrWvuo6yX4LbVott5X2YNhLZF4JbsrCjQS4QUyWw6iVqWkHWjId0E9r/DmL19AICfAde26ImneHXViovYNNKBh98wOn8n2MOyReS6954KuRsN8moPqiRiwFuNrWuWi3fVAdyi55DO4jMs8xIA6cdeatgs8+SwmqtHjnn0oJC+kPoTg5XncAHOx4pCbjNG2KDcFiGPI9QYlkkMpa/JTMQIDzeAl0PGvY1fX60D0otZ/UJfH3swtnJDdHpThYpdCOePAaPUSr2PUvOILjhnz1AFcg9ypfEsu6o7TbE4yCmdJnavO0frzhH3xXUwBEAfa2D5knAD10nvExagrhqPMTiQNJ96WLXfSWmQyyHFFBEbGGi/b4oVDN6q+xdQlKrw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(356005)(83380400001)(336012)(82310400004)(426003)(47076005)(36860700001)(86362001)(5660300002)(7416002)(40460700003)(70586007)(4326008)(8936002)(70206006)(8676002)(54906003)(110136005)(316002)(6666004)(36756003)(2906002)(186003)(26005)(2616005)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:33:01.6705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e807c420-61a8-417e-467f-08d9e6f82c38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine was used for a short while, but then the calling code was
refactored and the only caller was removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index cad3f28492e3..b0ecbfe03928 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3119,32 +3119,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
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
2.35.1

