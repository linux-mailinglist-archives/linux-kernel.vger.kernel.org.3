Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA248B601
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbiAKSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:00 -0500
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:30080
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241456AbiAKSp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:45:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asqBXFAOq930NKnea6wWKVkJm1zbWu0huHJNVvAIhZ06L7eE0asN6UeT5A/b3Xfx8UqBiytj570+5iz6gH59WgWNh4J8bUKr/Pcx2P7Cr8G/SwWDqMK1T3c+RXjI02fa47Hp0JwV9tGIs7nuz8h9xSGkUxtjOeyFvyW/eKggCsuIANUB7N9BptcAbkfoPqg53lysGxICZX9Nh4f7OKgOPzD/yJbeFesvBVsR8vJ5mMu9FpIBDz4NnWfiuVzbIDECM8DgDvDZu9/03zjucIJZGp0DjU3J0qW9pibge7oL2Xgan62JocDlN61IB3NGoxeQ08M+Yar3j+diBHxhdhQjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+0uGS0ppa5jZIeHGZkxKEmzGYIlN9vguT/7+TCOYGQ=;
 b=fUBGZBw+8cVhW/W2AjZOqsMNWyRHFPi1VAnLmavG0e3jRYSXJXFBvj6VsRIuOExlzkUDeoPOnrXjxRu4q8pTigS+ybQWf5JvRCn3mt4GUNql+Q3EzPN4qrridPANleuiqjTc01tDnHUpbJBgGUtIKTUb3H0sK/9lZHKt1LG2qjeDCg2wpTTS6VZt/u5xNZ7xBA6GlzcCy4b6ZMKN7iC9pwT7EmaNQ9bYzy+UT6Puy1NMNDXXl6VD2SRicdrBvQKdZrkO99Z5k+H6X5iE9f8vy0KNkIn8VLCOeynGWfneq/9W6G/NBo93wQtsabsn+vfi9sDh4AF8DJB7VXzcK1RAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+0uGS0ppa5jZIeHGZkxKEmzGYIlN9vguT/7+TCOYGQ=;
 b=bnyfAFB2osszaU/EvS5qMZeDZk87xQ3nJ7b1xzeBAqxnXkOFqmuC4Wf/XX9ujLoOl51IHk9cTKTKVnfGiI6y2XgQtz3KqMmEbAhHOhxF+85I3qy2VABgGP44BHS1c+ME2naAYamq2ApGMUG58ZOC9vIX76POwDuSeWiOgboGtpkL0M0FOOq8YGmwqkhAWYUyP+6oYUok2CgYRmT6ADiwIWxePNmkZ4jnwGrSdvxyTrt8o5ahq8uh+PoAa/6GWyhYFXtbvHdU2WdpBv8tdXr8oOJ1OM+VORbBjSktbPF3JGyMRWnFgC7Ym8YOAhXLhqUavrdLFn2O33hAMX9INwoj4g==
Received: from DS7PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:3bb::25)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:45:57 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::74) by DS7PR03CA0080.outlook.office365.com
 (2603:10b6:5:3bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 18:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 18:45:57 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:45:56 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 11 Jan
 2022 18:45:56 +0000
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 11 Jan 2022 18:45:54 +0000
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <amhetre@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-kernel@vger.kernel.org>
CC:     <Snikam@nvidia.com>, <vdumpa@nvidia.com>
Subject: [Patch V1 0/4] memory: tegra: Update mc interrupts
Date:   Wed, 12 Jan 2022 00:15:46 +0530
Message-ID: <1641926750-27544-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99292e1b-b1dc-496b-9df1-08d9d5329ae6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4549C545A615CAC37262AD87CA519@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 915YqWjpKc7fC6HXpBTyCEYgT1zXRKQ3MxL10/nv3Z3ILM0/oOqZm1uW6XBHrPQGIP037g8LQ2k4JA5xrSkQwq+ciAzvueemDCnE6pk5EAahebCWbP7zC6QckW61sMjk3chTLT+C5vogVhV2Ihj4mn6cEnSq0HyE+cbAS2A/GXr3783J1DXz5ZaH8ywTCSMU53X/wZIR66tBuzuAH7vEUIkgpqkbm3PSxkpxXgNyQoW9MUg21I1WK820wuARmWAKbOZFFIH7bcIR8duJAQPAC+Ld3S+bsSYqT8lU5hhnV9dRUeSNwxX11zBTXTcPnI+mPyhwvv2EtMCqZ7PtulPKzNUtlYTnqXH6orgFsjZQ0BHALWDiJx2hX2dW2oLGtMYbIuvnRiMGVyOOnlyVuJBDPdnUXsInIV4uws6sqYszD0bjtI/S7QqI4oeX7atMOZ7qC7P7jCtGJTHxnwN4EiL2mvy08Z6lapZdaOIaKAcS7b8mkgQN3GvsUjYTFd5qhKTGbbwLQpXetDUI60rmgAbssRvxoX8b1P1r4AXR6/tDp5S4mRZnnpsg+HPJ0HN/gVe8zUDthY23DL8Hfzwe6veh8ak/XjZHmGjTYod6Xl9oKBWdaGc0toU7PmO9uHWd0CcukOqGeG8/yY0H+SV5z162jLAkWhR/F5Y9a2rYgcd1/d2ZgMzDWQ+ArCskdvBBgw/62fF0CjaoEp322rrzq/d06+WFVddORhIs3v5zLJoyjkHVGMCZt2Fo9QBhxX8v4X8QkXSRzu1iOQWSBFEKVQ0Xf9NClBDrs0VVoUPoZtQ2uh0=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(36756003)(6666004)(70586007)(26005)(82310400004)(7696005)(83380400001)(4744005)(54906003)(316002)(508600001)(15650500001)(110136005)(70206006)(5660300002)(426003)(2616005)(356005)(8676002)(2906002)(47076005)(4326008)(8936002)(86362001)(336012)(36860700001)(107886003)(81166007)(40460700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:45:57.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99292e1b-b1dc-496b-9df1-08d9d5329ae6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MC code to add interrupt handling and error logging support.
All basic interrupts and corresponding error logging supported by T186 and
T194 is added.

Ashish Mhetre (4):
  memory: tegra: Add support for mc interrupts
  memory: tegra: Add interrupt mask
  memory: tegra: add mc-err support for T186
  memory: tegra: add mc-err support for T194

 drivers/memory/tegra/mc.c       |  14 ++++-
 drivers/memory/tegra/mc.h       |  26 ++++++++-
 drivers/memory/tegra/tegra114.c |   1 +
 drivers/memory/tegra/tegra124.c |   2 +
 drivers/memory/tegra/tegra186.c | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra194.c | 124 ++++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra20.c  |   6 +-
 drivers/memory/tegra/tegra210.c |   1 +
 drivers/memory/tegra/tegra30.c  |   1 +
 include/soc/tegra/mc.h          |   7 ++-
 10 files changed, 294 insertions(+), 6 deletions(-)

-- 
2.7.4

