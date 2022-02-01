Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB934A59A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiBAKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:15 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:43745
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236310AbiBAKLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiSik00hs8nFGFRSgg/jx+ZYBoGfmGUZiA1yLM0YciihyNZ3tXpjOT1isBCsNQIVncTDx60lz3Zpsp8EmZDII/HyrgCyYCCC0ZaqmyTxvJSmQufrPyh5dfkWXZzSKnPhTR4Qc0BIDUox9QnPKxYXFahUJWa5wPXQnm4UtDnGKQAowAPSwDnOf2HndsV/8bB3UZSQVdFdcJ7XxicHdB7GioZ5FWgDxEPdc3LmPVyUPVaTr7lZ8JpM+Y6BgE2TQ9fkVa+gG+4PAq0MNYzBiZzwQHxsxkHF/oM7q9u9p5lO8/7ZNP31BQeQyX+/pFiT5PfX2a2EaJGNZip5I6q3P+xtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5dXUFu4F02c5p0qaOO1nvAxgrh0JAJOcuRgbAC8kDQ=;
 b=WDj4WhoikwIZlo83TYR4jw0KL/22X8ULEuixldkBD6rjCQ6UglHXFzfFKXs5bZYYr5g9OACkcRD05GATlQ3y8dQUXbMgtRVZLjg1C+AcfmuzCzx0O+evO3Zrz5GaeqHPT9Zrk0zc1dETXygRa13Yac4Rl+2AYBoEBxazRrxdSr53mtHZ0A5lbV5vwf7Du5ln/tXfZnHo9WfNUlXtdZhE1ybQkQWVCDJ535CXGJVuOz+BbnsqeN87mb1XtjRUB1aobGtkuzLeKppAJRN5fXwOK7qzAhGSzo0GEzvBHr3FvFz5cYrxI2RP1Zn5/uCTkXQhXt6FqjAml/YRRiCSWvs+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5dXUFu4F02c5p0qaOO1nvAxgrh0JAJOcuRgbAC8kDQ=;
 b=hRm4RiAz1OnBsMfJJHiCIUc0A9osgrK7KJELroW5SgIxnKC/oXc6bsR36LN+1nOX+oM7wZs7h1V02WurTtNmZVGCICyp2L50uQp2zqayDH93dhK9KjsRyDonIm1PWsFWHlv5cFzXH3uPrmdJAfEvfUNyYrr7nEypnAcGYy8k3wdVq7GeJsEOBK0aFUnB28tn5X/Yb/yuYM/dxmp6pIq1woOmuYiG8GaXVBLOUC/dmDnx+xHshEgzOA3SkVe+cmn3j8jCn3HhhuujOhXiF3G6YiThwVZViWnFR0Gy9igqpJE2cl0Tv+I1lrORH1G4Gr2utp3nkrvOxU3/XO1M8r/BYw==
Received: from MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) by DM6PR12MB4715.namprd12.prod.outlook.com
 (2603:10b6:5:36::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Tue, 1 Feb
 2022 10:11:12 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::32) by MWHPR1701CA0018.outlook.office365.com
 (2603:10b6:301:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 10:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 10:11:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 10:11:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 02:11:10 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 02:11:09 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/4] mm/gup: some cleanups
Date:   Tue, 1 Feb 2022 02:11:04 -0800
Message-ID: <20220201101108.306062-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e51e191-100f-496f-d012-08d9e56b2c30
X-MS-TrafficTypeDiagnostic: DM6PR12MB4715:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4715FE68967DEF5961FCE7BAA8269@DM6PR12MB4715.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vMo9krAQcF3ys4juWkasn6rfsMraDi8vETlHFEKBi3aqNf1A4xMvZRIcdn/tW2Vy7/djniXNq+ajyWdZKbJzyLXEp7e2bb7oowmgTRLBIUxABfhCU/hn1Km6EqTdMeijhMgPS0buHlyanjBRGDo9SB9plFeQSGZDZqZjr8lTLMfq6M8Ga2hXylsJrHXiefOTbEZOx4Sm7ODVCiBwOIB5VFk0+7qZhjX1knvuLUZxQNHFPdKPJoJx3YcmTiYHWm8AjozSd2cQtfNCO9sSrCRUpglgcb4GuXHtSWloT+w4eNtB8aw+i9O4bZ6B4Rp/3bFwbZuaxZE1xynNbL4S8sfcXu3JXyJYrfm2J8O5s7nQ+vqngPCnSURILgQNeuIPQFIstKHbnZYvmlsTE1y35GRqXqSwFbK281LGbd+Tt6aQF94CBjjn7wbHOEOLe9BQP6E2Dfdr3s259OFTEHefHAiRMYdLcv967ZNw43Pb6DnFhLCtY/H9Siu9KoBsvxdOHfNFrUCLzFXOFYrdLxybz9o+tKHGFhYwMY0EPhn/rXAV1zweUc+GMS91AvaREimsB8rii+iO17EOnMURum6DEL8Zvbgu4K9mQOiI0Ob267n2sKhM1c3exxpcQQiKAfFGJabkp5z8M/+hYX5OLgDmYUXudSxNxX1mSo43IiAI9NUvEgHpRUQD0hQdfhv1ZksQICGrw5NosARM4OsNqc4s9vt2IGHgpUdVd2jOlkXyC/NhCBjZaGOLZUCPuKIOAgO7gARk09GPGucO8LneMGYfYjEnit7V/PgFi3ghgGYY7nXzwhEibYR0U0ls5GxB1yE4lnjlCFs4wzRwuukmfdw5+wdWw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(110136005)(36756003)(81166007)(2906002)(83380400001)(316002)(54906003)(426003)(26005)(1076003)(356005)(186003)(86362001)(2616005)(107886003)(82310400004)(8676002)(47076005)(70206006)(4326008)(36860700001)(40460700003)(7416002)(966005)(508600001)(6666004)(5660300002)(8936002)(70586007)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 10:11:11.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e51e191-100f-496f-d012-08d9e56b2c30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Jason and all,

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
fix [1].

Plus, a couple more small removals that I had queued up:

The third patch removes a completely unused routine:
pin_user_pages_locked().

The forth patch removes a similar routine, get_user_pages_locked(), that
only has one caller. It now calls get_user_pages_fast(), instead.

v1 of this patchset is here:
https://lore.kernel.org/all/20220131051752.447699-1-jhubbard@nvidia.com/


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
 mm/mempolicy.c     |  21 ++++------
 3 files changed, 16 insertions(+), 109 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.1

