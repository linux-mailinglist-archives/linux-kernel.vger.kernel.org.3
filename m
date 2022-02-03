Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37164A8188
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349721AbiBCJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:33:03 -0500
Received: from mail-mw2nam08on2062.outbound.protection.outlook.com ([40.107.101.62]:41408
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232183AbiBCJdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:33:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QImZb0tIDGKxzPgXTdrTlsRXtMTocufIb1aCP+cidB0wY6/7Yq/nbieZlpRJz++cGQPIS3+VQxj9NAt92mBVqIViYWGeN33gcJOxa772YhVAMhL3XTXuaHL01QhsruLEjqarjTc3gTXDMK+hudhDoQznsvAA3hEE7UeT9PxKpvI/we1sFv1DzSfAw7PwbB6AwF1joD+gYHH7n6et1GMvxe0gkx3578W7Kcg3j9L17sToqZp0jiY8m+DA6Yw8CDdIog7rFb92y8NOo3suVp/5X1iBpcs/ZafboHNbnEzl4nDV0G3A/3CfBb5qmC9xZ1GE3HTY/JXdmbePj8Grghn0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhn4G9R2JdMWjlPYYBF8HfYA8itcIYN0WsrjZQtr6kU=;
 b=DPDXmwIBfZQiT9NA+Jw1QW18EvXZamypUQwpJqMLslcjq1IEgBeH6Z11HS36JozvvGinR+c8YmgWMKgeulDmEJGxD0jlpjTaDMBjT7hDxi3qMKg/uTWSge5r5mPDizDYUynubayDpn74u1HE8SGo9vHGXHzxzqo9Hu3YVw2Ngs8wwtEcc7EI+fkKLZ0nh159xZNnHD5VbvZRv75T920dqplzw1flKljsTpiRDNg138WAQrAzGtZ1VNFXX01NbAPmuUMwiIeeU1vb36ZP9v6G5TVKalIIS90F/VWUAvYEsIT4RBZVaM64B150f3QqW55io7ABCqPSHwwutx1hu8OQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhn4G9R2JdMWjlPYYBF8HfYA8itcIYN0WsrjZQtr6kU=;
 b=QTuqNvPtVrrMuhT+nFZJTQIwb8AyMT7wo8CQGi3Vspe4JXqb2yCllHjjG0RYm2Hu+WCdE0JD8vzRLmhyzrEhX+ua813WWQey24jtydPFGEiCm2w5HqG4D+h9M5mF2LCKldBvt8BF2TnqW5GkbDBTO6Ccq9GpbGasicqVS/Iac/RJxvWtO6qt+NNIK7i7Z4fVcNVyPwjIYE7cyc9l/BOx58U0+g9AVTxtalJvANpclEL3lF4wltVymc/LzBpNk/y+TCOuDkFGgfvQDV+6Aoq87EbGn4lV5Dls/3TCxrW4YLoiYI28F4EUQdYorFfUHr60uS6C5jr8sftuWmev7k+43w==
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 09:33:00 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::c7) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 09:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 09:32:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 3 Feb
 2022 09:32:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 01:32:58 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 01:32:58 -0800
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/4] mm/gup: some cleanups
Date:   Thu, 3 Feb 2022 01:32:28 -0800
Message-ID: <20220203093232.572380-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4f9c30-4486-449e-e250-08d9e6f82b2a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4325:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB432574F9825F1704E0E9027EA8289@CH2PR12MB4325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guF+PjfoRU1ogHeKRmrx5YtnL7bpJvcLAk3zYxIOlqMvlq+OMsunrcdHPRJeI2XaYPbeRcHlxQcXbncwaLvXaIALtneDW2O7L6I7wCzIsEeyFL7buAbImAR0UxJ01tZd+RLxRCYKyCGw0hJEMc8UXltB7nisHzdNFTtl+vVmiihTsWnr9slT+O/d9LcOBqQTfkee/tiuqyCNor2qrxGFdiaPl1NcO3Eb2xK/y9wLZABYDQTR4TMDRUL8lOEZEszK2n+G4aMUB0JVn6vBgiZixp60LrdMbtelV/X36gVTd1A0H9Qh9RMjdciBK3+oOv/d/pvZseOnwSBPlOWJXT4vNmW7pBjC97Jl4cb34GrrtqgMNk94Lv+aWoRZhBeS6jY2H9EzsdwOuvrFOpw4FPIrqwdg0OQikHwJGNLjFu2TBebG/DIWPVZOHEIQROVIaXsDtRB+H1X3XqB1xPRsqwuc/9TXzRB6aZIye/b5+ujGm9Ye+Q7gLrm4h8yfj03RZiTYjG1sS35tpkxHqcfLQeXBVHQqoseVv2Xsk252Y2gC4ZkANwC6RM+K7R9GNs10dxxYkzkYc2D7duyPwirCSwCj3kaLwq1hsCSD1hm/RJe/QgXgzg+kP7ZGAC7D5sup39dEE81H33aEqSOhCKmB3YUG7FGFwyk5bekyLR699ixGsKcv6LHbqHUXEc3bmK0K6drCguxS5aySzv9RWqLDU3YCTYsDWGcBw7Tva8Pu31MhDGozaMSRlZcIT2SSSXlsuBZQ2GsYfferjxSHQ0lVXV54jvJPrmmoXnr1EKyMfkf+wdozPUZcfRCm8O3c6l0QBVPf33pi1oIX1ltgWP0b25wD9Q==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(508600001)(316002)(8936002)(8676002)(4326008)(966005)(54906003)(36756003)(40460700003)(110136005)(47076005)(70586007)(70206006)(36860700001)(82310400004)(86362001)(2906002)(26005)(2616005)(186003)(1076003)(83380400001)(426003)(107886003)(336012)(5660300002)(81166007)(7416002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 09:32:59.9050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f9c30-4486-449e-e250-08d9e6f82b2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Jason and all,

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

v2 of this patchset is here:
https://lore.kernel.org/r/20220201101108.306062-1-jhubbard@nvidia.com

[1] https://lore.kernel.org/r/CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com

[2] https://lore.kernel.org/all/20220125033700.69705-1-peterx@redhat.com/


thanks,
John Hubbard

John Hubbard (3):
  mm/gup: clean up follow_pfn_pte() slightly
  mm/gup: remove unused pin_user_pages_locked()
  mm/gup: remove get_user_pages_locked()

Peter Xu (1):
  mm: Fix invalid page pointer returned with FOLL_PIN gups

 include/linux/mm.h |  4 --
 mm/gup.c           | 99 +++-------------------------------------------
 mm/mempolicy.c     | 21 +++++-----
 3 files changed, 15 insertions(+), 109 deletions(-)


base-commit: 88808fbbead481aedb46640a5ace69c58287f56a
--
2.35.1


