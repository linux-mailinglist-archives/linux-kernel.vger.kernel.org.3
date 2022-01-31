Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC394A3D38
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357715AbiAaFSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:18:03 -0500
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:63104
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231718AbiAaFR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:17:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNOds2qVW5zcySTRO3faTQ3kKNP5CptB4XJdt8SPJEu+UCj89qFlMSbrfsYXgJ+0R/YA8tMS/2g+G47tC87kfR4lZb4QqbnhJ0sNhUXQZtS+T4782Q2MR2u5+mloEm1Hq8vl5F3SxgZ/ipAKulRHGQS4UuwYLJvES6mU7qxQj9fHsO6y2NJzu7OF3jalZupbjkeZsJXbmWJ1B+AtwNC92Ez/NaD7oLz1gZZzOF0xN393HVzDHMdgBMcfXHv7NXtlJaDf6eX4AbsJwpkSRn8hy4SDY4AGSuP/ZvhUSTIdLSMvcdqgw17iWO08BQZRZonCYzLbkCvHc2PacuOUo8maTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg4FdGMRH74oV1E4JC+CBioQaREsN52E0m3RbyifU0o=;
 b=OI2xkMOtLCXxRyDSrm+eaI98SFiG8MuQPkA2/tKI3SticZMwO275KXjpxcN31o0Th9Pnzwg2oxYiEyPUYqXofMJbDjfS2e0xYLJoWWEfkUHnxviWnTrvUHn31+cMWzmGd1QxAz1n8ggjElQN6vct7kNUdHZ8d1YCPYklndHA7eOjKl+IphOJgGbxFrMxmFC79s6QYHi4ZOhKd+9hFka5qaMXQgYoa4aX+/IGGJwGmMtMSnOG5g1oCjyxD9OPnuufdGm+LHLOp1Q2wY0IrI7I75M6BExQwtfVDhn9nMbMTamPo2fsjV6mB4MXtjdxe9YpiS0ozVNYSb65LJUD2bpufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg4FdGMRH74oV1E4JC+CBioQaREsN52E0m3RbyifU0o=;
 b=scqvI+40/8lcrbvb5JmQQ264zAFczChva0puyLRNGwMTO6Z+cxB/BBS2kux8O8C22jZ0E0Qz/BAh7CxaEvclHI0mQFOv9OML/tHOdmzY0qoNYCshFFJaFatUoqBdDpXwui83se/8KrYUBtOC3yvdvD3Pqs7Wt9kH5mtJbdUp7g1bsJ3vUARoGhvNM8Gy9bhaK2CkvknsXCwrRS8vBSWXdoMCawDGNalNWxUkO6own3ZO/Ypc52M98hTpdOSM7RtAwqCqyRpnjzu5Vbb2H/EmlIuc/g9IVkxF98pHR65ZPFXzIMu7vcHZrmqJPMurGQHR7TkpDvvzh7wAv28MuBfMKg==
Received: from BN9PR03CA0191.namprd03.prod.outlook.com (2603:10b6:408:f9::16)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 05:17:55 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::71) by BN9PR03CA0191.outlook.office365.com
 (2603:10b6:408:f9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Mon, 31 Jan 2022 05:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Mon, 31 Jan 2022 05:17:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 31 Jan 2022 05:17:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sun, 30 Jan 2022 21:17:53 -0800
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sun, 30 Jan 2022 21:17:53 -0800
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
Subject: [PATCH 0/4] mm/gup: some cleanups
Date:   Sun, 30 Jan 2022 21:17:48 -0800
Message-ID: <20220131051752.447699-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c4959ee-fe4e-4ad6-dbb0-08d9e479094a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB351562879C6049F35C47CB25A8259@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoZiEk2sbWomP51O/GyL0Nj8PMP3JVlAutipctSNoV8/ptpt4auZfmQ0WPsVeZlfkW/T9Tx8HJTTPmUdsrX+t6e0y6TtPAp7qYjrCCNsRgGABXuF1r/DfmcM/hty6dIkPTWtOEqeFDbdmyhi+VhCt0hWmx5OQhgWRkCTleuxHxtQ8tJDZBCxJPAIakvIBPa7RLPnr36Q7ICUX84AjtYHBvQ3K7va6Yp3bTaIFHz+TMS9GQMddF2MCIPJFW6fs2tNHvE1xNHzC+AO5vziU2LwEKJzSvqPKPx2sL1CXI0BRPfJ/iXbP8fTKdQUMK7ETCJ/53oAzCYgLy2ZHQKPcsEx20I04rIWaTHVXF1t+rvK0bStl+hz0DMd1+cnvLAc5RO5gXwJ+FHzV8uuVwZ2hQebTTzTDqhSG7fP1h4ylL5uKNAKzuIsNtAA0I2hT9mj0eWE9J69KMF3ZRYZ2B6AJ+atUcWW+fM/zLPVq3m0VCuTZT5i9gxSSlH9tC3T+7VSWEw3oD/X5AyXxJ1aHbesmlbGcgbEkN5EX24mXsGjeCaBNKGIBuOdPnhTsKN3v/5luwjt+0LVeE8O36bO9qNKTW2ztQLV1RgxJ6waZJjaCBIJ9zlHeq8ku+46FqV13+F70SPBHbv+YyRyllJJjd402mCJHCEoJyqTOBkooPdLsGqv8cmTaGv274FKoSjGoL8rbnObQhMzcogmKreBi2KS0ACX9ppiH6sCUMUhhQHmpHbqXZc2ilfJ9bCS2fGlOM2Zx2sWbdEd9R6vpCR2nCbwGaczp8Rw1DLdmiQegYd2kzG+umA=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(1076003)(336012)(186003)(2616005)(356005)(426003)(82310400004)(36860700001)(81166007)(47076005)(83380400001)(107886003)(7416002)(5660300002)(4326008)(36756003)(2906002)(8676002)(8936002)(40460700003)(70206006)(508600001)(6666004)(86362001)(70586007)(966005)(316002)(110136005)(54906003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 05:17:54.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4959ee-fe4e-4ad6-dbb0-08d9e479094a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Jason and all,

I'm including Peter's patch as the first one in this tiny series. (The
commit description has my r-b tag in place of my Cc.) The second patch
is what I had in mind for a follow-up to that, when we were discussing
that fix [1].

Plus, a couple more small removals that I had queued up:

The third patch removes a completely unused routine:
pin_user_pages_locked().

The forth patch removes a similar routine, get_user_pages_locked(), that
only has one caller--and that caller is not simplified by calling
get_user_pages_locked().

[1] https://lore.kernel.org/all/20220125033700.69705-1-peterx@redhat.com/

thanks,
John Hubbard

John Hubbard (3):
  mm/gup: clean up follow_pfn_pte() slightly
  mm/gup: remove unused pin_user_pages_locked()
  mm/gup: remove get_user_pages_locked()

Peter Xu (1):
  mm: Fix invalid page pointer returned with FOLL_PIN gups

 include/linux/mm.h |   4 --
 mm/gup.c           | 100 ++++-----------------------------------------
 mm/mempolicy.c     |  22 +++++-----
 3 files changed, 17 insertions(+), 109 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.0

