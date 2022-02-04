Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7D4A922F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356583AbiBDCBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:01:30 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:56257
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356584AbiBDCBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:01:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/hA+zm7Ok8WFDJ/YKuKeftzPhf0U33wYiwB8gXr8zkDY+5fVDHdl7qvuuw7zaHkHDJwK6f6+XjGgHzz5wh5ZJdooxOKqhwlA5ZbzHRUDCvVs5GXOv5nghs2sNQ0MsVOEXQnqdCyJfaSPg5bgD8+/9kKC6B/7ylwMe7hNviBE89mQavWjY0MiXasAV+Gadbn5z/v8gHJi1Q0bdV4RcnGMRDwrws+PU3jJn9GVBk2udyhRMWB7QQNEqcHH/kLg7vv3I2jef48t5sfhinoiCdltnVAvBr0e8zC7MkNUre/65mfcKGSQTw/IeWvfk5qcHy/irXhcMCNfE7jkrYX2oEZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGsczoCZGFtPqCHPi0mUV4F0RcftFgkGL9R9aYznJ4A=;
 b=TWnBKgxWTRtMzgAX4Yh7Acpqism0t0X0K0nNP254ZBsy3NaZFQLxTfie1u978VCKbcIwgr8CLUuXZGfKDIP83VXDdxFgbeUC1pmvNRFDzpp30Q7w1CiVJeCl5CM6tcJkL/bFkRBrYcJGi4+MlJfvS/1EG2YuHPTAKrSiE4nQkDCru9XuftaenWty/ILL5uOSY8Ko0xNRJVbACNhGt1jzqRoBM7TjUaklHMq3LMlXFdM9zcCP4Gna3nMPQyyMxbTxkjiM0ehcnNeKt6334uCym3A/3zMsDr//TqT4jjYpiOCMQ0l45Yzapxide+elzG+AvGNsgS4TKV7gbioe7I8LDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGsczoCZGFtPqCHPi0mUV4F0RcftFgkGL9R9aYznJ4A=;
 b=TxM+e4GCk1MTilAxvabtyRtolzAC056ClbbtqHvmhl8r0AillzjSZ8iZ693q6lhpNfjSVFXdlNN4HqhRq3kkIIPEy2DnnmFtcOVff3BDN6wul6iT5/Wx7Tep71/aD+aAitS2a9ph+/+j8OLpElDhtWmYLGB/gQLqfV7iCc09LSKJCHgon5r2jUrXc3+fczpo0tmSoKfFZB19RzYSpYF2RBmOM+FlQjxbb+I46AMqIRQLSFOxn2PwXfnBAE7MJ4Os5Qru8xGPyl7WIWPg7sX7Uhj9DUlKdZPFixSxQYTEF2kLumdNtFQ3Ld/VDw7cfS1XU0jUWJRC2j6NJFGtI7n1Jg==
Received: from BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) by DM5PR12MB1178.namprd12.prod.outlook.com
 (2603:10b6:3:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 02:01:21 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::8e) by BN6PR1701CA0007.outlook.office365.com
 (2603:10b6:405:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Fri, 4 Feb 2022 02:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 02:01:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 02:00:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 18:00:11 -0800
Received: from sandstorm.attlocal.net (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Thu, 3 Feb 2022 18:00:11 -0800
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
Subject: [PATCH v4 0/5] mm/gup: some cleanups
Date:   Thu, 3 Feb 2022 18:00:05 -0800
Message-ID: <20220204020010.68930-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95329bbb-4e28-4dfb-c4f0-08d9e7823d8d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1178:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11781CDAEA680A7F260EE14EA8299@DM5PR12MB1178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFmHBOPQgNNE3FBLCEwhYzTHQa2eyuWcM+eBjSZi6jJi4kE7Bgz+OMU5eNge8mV4WN1CBKDM581c6SRio2gM1TzavBaTLCNKe0RWZBl7hqfLdwxlCUXRpLgv4gWtbFCKV1Twlzkosx8mQ6+8WnHgSw8g4SRNwfoIxHdxc78dUQYM+py/NtydGOG8TBhMGfWfN/8urn91e7jHwcZKDKmX/LrLrG7XEQt+LrHuL+1yRqVve8y8yEujWvzgskzVKb8AkCegqK4jkmgW3PgvEyfZzbwjBRFvNZ+Eyg1QCnCWeAf3tbiTiFYx9Gd5SiT4Tfpfpm1gxP5cQnmyKwsMzyj8JdpGwp/qvId+KZBYOw4jyz6lJaW2ZXfhg0DUlcyFyCKa+iIn2NfpBnulPCALxSY0wdc4k+jblMx21g/TI4Ksbn+hn8eoVai0UcspiU1sixJ81nB05FBLs0tcKJHYd8uzh6NvwTnoZ49ucQ0jfIj8dxyAG05OsI6nrAz9hP5a+PJcjz6KJY7aChA0Rv7Mz7NlJXIeFtgqUNqWViw3Q9DtVi83Mztv9T1gtkRyv6t7ecfGariPYJASBxrIA992xG3bfZX/s0jH/t/PAzzTqFtm0orWppUL7B1RVhgkK+L+JpwWx1zI3DU1xp5ycbyI+i+45aHmrBI5N5Tb0N/q8wuvRWeWqu1kJHGQ1MswTFxTQGaxY9LAUcwM3F9TDfncQveXtxONyqVQGPgQDPt+OOwIM7hyRd/t7kQOWWKjjwkxOdzhaL/iKDQZ1Bl0Px7UvsF4uXn3LGJkTdSWHpv8MtWPj/bKAVL7+KkjNw86r2ejk0EyWkqk4UiZXx2+xUROPkzPQg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(1076003)(316002)(336012)(426003)(26005)(54906003)(8936002)(70206006)(83380400001)(107886003)(4326008)(8676002)(36756003)(81166007)(40460700003)(2906002)(356005)(86362001)(966005)(47076005)(82310400004)(508600001)(70586007)(6666004)(36860700001)(5660300002)(2616005)(110136005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 02:01:21.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95329bbb-4e28-4dfb-c4f0-08d9e7823d8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for all the reviews and feedbacks so far. Here is an update.

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


base-commit: 1f2cfdd349b7647f438c1e552dc1b983da86d830
-- 
2.35.1

