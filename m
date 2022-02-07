Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A684AB4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbiBGGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiBGGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:22:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52560C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAvAaR6IRlGHDzB8K0cIhptg4eU+OjwAMiDYJ4a/96x/Q7/+MlmbJML8kznCLSpGmr0j0zCrT+l54Z4sBITKG5qsTgYwr+X/JXxRDR2YO8HXKKJvWqIB+MjMYcnbZr7GYfTCK0p9vly41yZ7KGzD/1vQ2d818ZdUOwFx8WAAD5dJFFUQD8Up8/Q7Bi+OoFJQyJaOmrTbmBBezLN6VWSQHOqiVhnZoajS5ZtI3yBj3sBZVKS6LGJgAgo2ULCQ+TSAcxC0QMLkXT5NdI2x+P6wOaaNhXcTs6LZHrCI6R8lg+DS03OIcSmpcXMfxCGEHFgzt71bntECWHjidOKCQ4hLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjyuYIijrLlunK3pxo0HIHNRqMmgFbeZ6YB3w2NfS4c=;
 b=HOb8jkQX/JDGyivjlgHgXlF04ntflOo5tkxW0huqLLT8Z69AMb/Z7Xsan8T+EY1xXqFHrkb0i1McHJ/y2YSpruxOtx5OtVpHr7Cw2So5NRGHY+Y0G2vzBTquy/7iikuk5EDUISJBsItPkWlSvmQ++jKcb9lF40iMt1jHgElzd5C00QZy/Esv55J2QDCmUdFQTfEX0JWq+aMqv9f2a0edvAjpqI0wJU1TV2BYeDHxva4FUHIdvFqq+nYhgIPZynvYRu8T/Iw2hL2ZCitAo//S5ETUyUqWyVKtB0lNQ7Ps/DV/dMyr22m9jT08fUb73dsXu/VcelI0h0V25TXt7skihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjyuYIijrLlunK3pxo0HIHNRqMmgFbeZ6YB3w2NfS4c=;
 b=a1xcEJPX4dL7gd2SHcDeiwCdqe5iHB9lrMQOQZvZBYnycA9R492NbqYDYeGYJiG1qhd48RXC+l35FsafPiyzUGfhuVu7sZaqnfWbD2N+X/Udn9aEzs88gad9jk+Ifwgx1CBAQ8QsSXpAN12aOjHQOCloqml+agKeUdBsn4rGPto9Cdyi8EkKz2nQftdkxTnjs5Z6WMbZu3pYMZFbZ1zD11yHTBtaTrliWQyegzSDTgh+DKI5n05BEHOHJHn4GA2WItwnExmVdnVN0D+xo+/p/kDEulPK09F6iAzY/PzYV0gLEYBZ/YqJ2wk6W3lldyd/LVC1cquY/L/S87V1fYoLWw==
Received: from MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) by DM6PR12MB4220.namprd12.prod.outlook.com
 (2603:10b6:5:21d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 06:22:33 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::a8) by MWHPR2001CA0018.outlook.office365.com
 (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 06:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 06:22:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Feb
 2022 06:22:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 6 Feb 2022
 22:22:31 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 6 Feb 2022 22:22:31 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 0/5] mm/gup: some cleanups
Date:   Sun, 6 Feb 2022 22:22:08 -0800
Message-ID: <20220207062213.235127-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165be2ad-0e74-43ae-c238-08d9ea0239dd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4220:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4220267E79DBC471E17F7803A82C9@DM6PR12MB4220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brNesh9eSWrqD5X/Nj8fX11RTFptp7diuYXT3QOZtzqJ05mggcn+7LWM8NY25dU121t48whjQQGO+iX39CJcVTw6/Ja0IjYjuYKuNyoS7kRy9I4JgyQZsAO4HMvOxgJh/zM6aUAB26qQa5uO+eLabjduV6L+wx5NWLQwojMXE/Zl6+Nj5JrZA5367nYBGTKQiDkXUqYs1sMiXgR1Xr5OFtdA3cAhICIMfIAOA9ZC6TxxGU4p7GZjV8+CNaMOQxMvwsCfTjNP0dboXGYJMNFq3KJHFx+V4h9Jl+rQZdnJ5fbWn8dYMVrE9AM3r1VbaFFMc7uVnVtwLp6lN2K3rP41KspoB5/bgPpIVvvjLagl73kZOVNLUJYgU5dgQzWx9sm2edriuAGvBxnn92LcDOU7EirIl7RbR1JrNdvej/2UqK8wW4I1gjMZSQijWe6kIM47BmBhfeCW1EPBcXDH/TqlF1hRyHtsJZ67nrFBVOimN70eMHIRrXxJQcjZ+MAYaYxQMll5k89JltLQZsBhrwf1+Ovcg1z/51CUKIayVp19iFdvoAvXzKxsMyrcQ8B9yf3D1B+dk88cNlYoli7gCtCKSCs1yMkBuPWpd+UnTr+MUmlzSuR5buJQZqYpRb2f9+vgjzirWvzj2P/e2A5R9sxsHm3xr/akz6SZdONaEV6qn1dyhiifOlJfhOlc69kiTHf9Luv7Yyi3/uXyGSCIVfBwCtjmLM/TBJiURIhRTCT0ryocZgWGf36Bbptt7HeXDOgScmzFhhGeyanltDD6CD62U4Yl84qGG6Ro57sALYKC2QB8b2aR8Rg4tKA7y9ofk8BnjF1nxlJUeeMWGgOa8pJGPQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(70586007)(8936002)(5660300002)(4326008)(8676002)(81166007)(36756003)(7416002)(83380400001)(356005)(966005)(336012)(426003)(70206006)(1076003)(26005)(40460700003)(110136005)(47076005)(86362001)(36860700001)(2906002)(54906003)(2616005)(508600001)(107886003)(186003)(82310400004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:22:33.0210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165be2ad-0e74-43ae-c238-08d9ea0239dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's an update, mainly just collecting reviewed-by tags:

Changes since v4:

    * Patch 1: reflowed the commit description to 72 columns.

    * Added reviewed-by's from Christoph and Jan for remaining patches.

    * Rebased onto 5.17-rc3.


Changes since v3:

    * Patch 1: Commit log: removed a reference to an out of tree module,
      and updated tags and added a short note to that effect.

    * Patch 2: Fixed up do_move_pages(), to squash -EEXIST returns from
      follow_page() into something that move_pages() allows: -EFAULT.
      This is from reviews by Jan Kara, Matthew Wilcox, Jason Gunthorpe.

      Removed all Reviewed-by tags for this patch, due to that update.

    * Patch 4: Split into two patches, as recommended by Christoph
      Hellwig. Left the Reviewed-by tags intact because no code changes
      were required.

    * Added Reviewed-by tags from Claudio Imbrenda.

Changes since v2:

    * Patch 2: Removed an unnecessary line that was causing a
      clang-analyzer complaint, as reported by Lukas Bulwahn
      [1] (thanks!), and retested locally.

      Jason: I've boldly left your Reviewed-by tag on this patch,
      because I am predicting you'll agree with it...

    * Added Reviewed-by tags from Jan Kara, Christoph Hellwig, and
      Jason Gunthorpe that have collected since v2.


Changes since v1:
    * Patch 4: changed from get_user_pages(), to get_user_pages_fast().

    * Patch 4: Rewrote the commit description--thanks to Jan Kara for
               that feedback.

    * Patch 1: Removed Jerome's Cc from patch 1, due to a stale email
               address.

    * Added Reviewed-by's from David Hildenbrand and Jason Gunthorpe.

Original cover letter, updated as necessary:

I'm including Peter's patch as the first one in this tiny series. (The
commit description has my r-b tag in place of my Cc, and removes
Jerome's Cc because he is no longer at redhat.com) The second patch is
what I had in mind for a follow-up to that, when we were discussing that
fix [2].

Plus, a couple more small removals that I had queued up:

The third patch removes a completely unused routine:
pin_user_pages_locked().

The forth patch removes a similar routine, get_user_pages_locked(), that
only has one caller. It now calls get_user_pages_fast(), instead.

v1 of this patchset is here:
https://lore.kernel.org/all/20220131051752.447699-1-jhubbard@nvidia.com/

v2:
https://lore.kernel.org/r/20220201101108.306062-1-jhubbard@nvidia.com

v3:
https://lore.kernel.org/r/20220203093232.572380-1-jhubbard@nvidia.com

v4:
https://lore.kernel.org/r/20220204020010.68930-1-jhubbard@nvidia.com


[1] https://lore.kernel.org/r/CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com

[2] https://lore.kernel.org/all/20220125033700.69705-1-peterx@redhat.com/


John Hubbard (4):
  mm/gup: follow_pfn_pte(): -EEXIST cleanup
  mm/gup: remove unused pin_user_pages_locked()
  mm: change lookup_node() to use get_user_pages_fast()
  mm/gup: remove unused get_user_pages_locked()

Peter Xu (1):
  mm: Fix invalid page pointer returned with FOLL_PIN gups

 include/linux/mm.h |   4 --
 mm/gup.c           | 101 ++++-----------------------------------------
 mm/mempolicy.c     |  21 ++++------
 mm/migrate.c       |   7 ++++
 4 files changed, 24 insertions(+), 109 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.35.1

