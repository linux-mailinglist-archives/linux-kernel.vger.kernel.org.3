Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED104AB50A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiBGGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiBGGWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B683C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgZfhUkLTXgaYE8591THaQiGtE/nTvmJ8/wQ/FGyBUhRNiLnGLEb86DWW9CgU5LbTkgQ5SublTEtvYSEwwjjCnJ74HC4d9Cp0RcnkSSBvH0M+tkBACBdXVZYhZMgwgD0PRwh4446WiWkvF4POaGN8FSE4GOHhH1kn+p6m/pMuybJjdn1yIWLgZY2G9f6ua7uEhkxftVoZ48qkErrkCcRlbfIht0pJqngVFiKeMc6s3xV58EQNcRq2DfhSdYl76XsU5q0FYDrSbJxP7Lcjr4tt3kN74Oy8BHYNK47OBR8BAqnD3b+3s4HQwUcUa4tAE4zorncSKfS2LJ6E7B85EM/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqmeqmDK9WNONzndgAGAbct149ZFM+Hb4kqc64wfHqs=;
 b=Sf2DfdlYwp3AWcyb5Pn2l57wjZ3ZGlK9gKcygIGbyXHPM1pNnnMUszCAecKuBigF+Mw4SkuS4r0k/vieZkIvf6ZQSU7IdzB56al5dRuUVJkD+hxYAjaBjAqJR7bWFWAGyWpYzHEREXNlBbDfBTW+eRZxi4vqOLvMEqFpSnkPs0NBsg9Pqfs2qasEeNmvMzN4BXki0W54e7wRuf3N5PKa9NZEPM+571cLIw9gwG0zla+OXy54dy2BrccYCFhhqqnLZ0dquAVUVomlhTAHTKAVmGMf3Bqc8+O8lCTGGUQzdFgVXho2/N01cpV4I/J4fT71ahkmvb45i5K03SsXMu+yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqmeqmDK9WNONzndgAGAbct149ZFM+Hb4kqc64wfHqs=;
 b=FPbN0QA4zUB4Fa99nhxNdAVPgFCWUs0tKB5cnURHl3l35F7E0rs/h9AlUiSbYNOnB4RdL5rPCxbtzZv4WJNDpJ9CvRX6DKeZJCA7wXCdoTZKlqq/nVKlIU4xfCe4iDAgPhmVsNAlFJ4OIZ+sboetqxDeoDkus62ot27EENadZ4oWWhkSThSvQ0MPeX516SXxW38WRdH1tp5gly3yWQyID7DD6H90YyLIEAYlCImh6IVLP1E6Z6WQXV26YNENxTtLoEMxVhqNY3xjFwqhXs+6vBVvWiAD384rLjal/KHtYdq6GZZaPkS+vkXtoc18id4muU3k+jnvaH37KmrRtb2iPQ==
Received: from BN6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:404:121::18)
 by BN8PR12MB3122.namprd12.prod.outlook.com (2603:10b6:408:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 06:22:36 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::ba) by BN6PR18CA0008.outlook.office365.com
 (2603:10b6:404:121::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:34 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:33 -0800
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 3/5] mm/gup: remove unused pin_user_pages_locked()
Date:   Sun, 6 Feb 2022 22:22:11 -0800
Message-ID: <20220207062213.235127-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207062213.235127-1-jhubbard@nvidia.com>
References: <20220207062213.235127-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3091bbf4-9ccd-49f3-66a1-08d9ea023bc1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3122:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3122A6A63B239840958EB84FA82C9@BN8PR12MB3122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmAyf3gT201eeVSfqvArpAzTLu7Cpx8Mn+QssOe1xn7s2bxtL3LhWBZkesaI3gktH1Q5cqW9SRfS5mYpznUZgvvzqCGx1HAKuOGiFSCNsO4i12TIhaabvaurw0QPpAm8MB149qeBlvqP4HkJWyePND1hakWT+w1eARgQuWBcm7RuzDn90UCUOcipXepcYRN9i66cu+3fASYq00AkrzWmaq3B0r85gD1rB4O7hVrY1wqcMSSv+Oe5vLxsHS+BeYxMd6xwcQNqgmOxxKTw3oMWDJuXUURuh6r/KBMhYPIFKoEH9T9ffa5zr77yx23dPCme67Un/bwBrJzL7Vk13rfDCT23uZR6qr1wY5v4l0i9XbyUqM5gtAWxtDS9MBDUkFhPNG+fO9FvpUcSKowRl+qXZISNafgtKtw776LjhiFXm7G1ZSVohPSQv0UEpL3o9Y4buW3vcWkVNZpVzqztCFSeLumDOo1QdZBMNK8BEhRVZpQsEFc9awctONr/qM8a7Gnsgb9ALgKHpjgQ6bEcLaYFzikCSxWgcp/+mnZbQj5hbnXHL6x2Zc47Uwm+4a5zyrIlCly7ARuoSsTdszghazVlju3pTpYwC08YMh1qI7BhjvrEPpUzloIoi3O5GqGYH5HtrxpQ8H5ahcrpO5AzNI3MWOW3Ghqlnc9ojzM8y74jJdrk7qHGGc0hQR/+0n4dEV4zl2JSfxXyVEY175XnMhW9QQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(186003)(4326008)(110136005)(54906003)(5660300002)(2616005)(36756003)(36860700001)(2906002)(70586007)(26005)(356005)(1076003)(70206006)(83380400001)(8676002)(81166007)(8936002)(508600001)(336012)(316002)(40460700003)(86362001)(426003)(82310400004)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:36.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3091bbf4-9ccd-49f3-66a1-08d9ea023bc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3122
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine was used for a short while, but then the calling code was
refactored and the only caller was removed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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
index 2df0d0103c43..6664dfa7a38f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3146,32 +3146,3 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
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

