Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6087157A77F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbiGSTx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238448AbiGSTxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC60E5508B;
        Tue, 19 Jul 2022 12:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDI0BZA13G1WdZSPka+jcuqwUoWJS0C13wqr6WU3WP5r2vPeq9shluiAhFjuvlI+dTsFhBnIzDzgdKiw2bD9AeJen1h3UTJHK4M1TGrDy/AGiFO+s0xbNpweEmSTOZGNtrcmeWdlWGOHcEDuspREiNQksoUvGnkaWhHRqVk+2srv4Ikr3lGHJp+fj309DrPGWN+5xYmSZwvhiGUcSIw03pGT1v2DvUaGPwgBX8xWVhH4kzoGytzULs/816owD0k42jEr8oW9frfKZDWjU1whrAfuVhJyExxie9MfJSdHE0CjluxJcxbqhRi/7ya/7//gkjIuD3Emj5Zy7MM3gdFNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFXhNKNRHns4z1GEKjmQhHONZe+SDBamt8UHJvhiWsU=;
 b=hZow79E65RGTw0RKmoLYSy3tDBNKQbOaX/GDRINTxYmIrrZA4ua9G1dy0zD6NLrdGIAwTu2K2nfxWBUCPbBbjiIwuCkJgtwvVTouLm1oZ9n2o90Ai14DTZwjLrTqbiuxhnWY69b5cNiywKmf8AKXjS8LCJNc1i+2xCHqDikwPwa11psJ1sPaujipOH/RWWnYq66mA0uVXB0LN4A3BXVKxdBz7cdG0is470+bOXOLYfXqnVaxkKEcyWzCresTt3WnvgbIiZtoOjLo1U09o7iEp1EzwbO+KIJJkP4zMgdAS9sk+evC9dSOZ+5unEL/RTOwwsHQxdeXW+IdWMAu7t8y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFXhNKNRHns4z1GEKjmQhHONZe+SDBamt8UHJvhiWsU=;
 b=DZDoB93yonoYOb/6eE2POWgQLnM//HunWqj4SqA8G0u0fLf8vicvuCWd1Il6BGzFPZkzqiY9U5aCkyTU5qHKEa3ekaZvrJIrMrFW5W/hgT+rGNlKjZMkDWrI4rM/posDj8OpxxKKLWDVJvNcBQBn4N4NPl/KLL0//CjYQgG8q2k=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by BN8PR12MB3299.namprd12.prod.outlook.com (2603:10b6:408:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Tue, 19 Jul
 2022 19:52:57 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c9) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Tue, 19 Jul 2022 19:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:52:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:52:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 0/6] Add support for upcoming chips to k10temp and amd_nb
Date:   Tue, 19 Jul 2022 14:52:50 -0500
Message-ID: <20220719195256.1516-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c1ec49-f566-4541-f6f0-08da69c046d6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W47QVxcx0okJI4Z/CwuEW7H1SSU7nQ+uqKzrPlE0LW1raBoQeRwIuhAzHDIJUdnC+UZTxuRT5RyDgNCXBKm/n4y5w/19Ea8zOHdhA8ovDyI4tdcHTOZMZkm+Yz7M1PWw6ji8Ax/bO7eF9L+pVeYGcpelFHss8ePvLt2TTKkA2AvuKJUkjO34DMKooNCkRJFyoZA5szY5fVfOymoC3hKtFzczmAxqN4kMC+4nWUI1Fd3FepI3yCjG7W7bzG7dWUi5VXC8O2D4Gpx5VWENv/XeyL3rak0OJn9WMA1m7zguWw/ApDTJ4hZAg2gGis1cSfyXjn/Zgin0HIqO/oUeN0ZWaaycydS5r10h7NN72Bf9p2fPShBUIYJ6MaarzZkfg2EwmcinMBJWc53vCwrv8Dit2Q5QnD93ThNSYDWxK7MO6Ql72P3UHZGDMXy6YBUQDnyjacni/SETeDB4zXyBvCA5Hd1RSwMYZdmg9TOraH5c+RaamBMhaFE6Eyj4PuUMjJyY7yyhfr5V8bQuSA90HezWI0T41On5U+ZjSzC67FSjUF/OlI/ZuZ9vQyzNMbSvhcr3OHeEQtXpEpIUFMWuqE8s33ZLTew73u9CX5QG+GKIR0YsHkKmgOd5yBlXfJoSNK2E17+Xb1W9pKQSuhf9yedwNWAf+b55xcc3DFUt5wqQU6LyomKltHi2q0I4jvX9qU+Xfql1yPGKV3MkVIY7scMQgcJgj5bGWUd7fCxJrgCcNpnsktNHX7RRHHuFPUx7BowZEPmQ8T9aOFehBpsYDmdaC81kSEgSisconW3ftGrumIJ/p0w+f7jSnYIlidJhT/z4hRj2rgU4fiXsTG5AZyeNIl4jdGfHfA+3ZBKlImlHBOrn4XaGdIELyE2Q+qHMp3ra
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(40480700001)(316002)(44832011)(40460700003)(5660300002)(54906003)(82740400003)(36860700001)(86362001)(356005)(2906002)(110136005)(81166007)(336012)(1076003)(41300700001)(8676002)(83380400001)(70586007)(70206006)(47076005)(4326008)(16526019)(426003)(186003)(478600001)(8936002)(966005)(26005)(36756003)(6666004)(82310400005)(7696005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:52:56.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c1ec49-f566-4541-f6f0-08da69c046d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series started as what looked like a correction to previous
commits, but I missed that the previous commits were for a different
family with the same chip models.  So while fixing up the series I also
noticed that a few upcoming chips have new PCIe IDs and CCD offsets not
yet supported, so add them to amd_nb/k10temp.

v2->v3
 * Pick up tags
 * Group "ROOT" PCI IDs with others in patches 2 and 3.
v1->v2:
 * Correct commit messages
 * Add more missing chips and offsets
 * since so much changed, do not include Bjorn's Ack.

V3 original submission:
* https://lore.kernel.org/lkml/20220613192956.4911-1-mario.limonciello@amd.com/#t

Mario Limonciello (6):
  x86/amd_nb: Add AMD Family 17h A0-AF IDs
  x86/amd_nb: Add Family 19h model 70h-7Fh IDs
  x86/amd_nb: Add Family 19h model 60h-6Fh IDs
  hwmon: (k10temp): Add support for family 17h models A0h-AFh
  hwmon: (k10temp): Add support for family 19h models 70h-7Fh
  hwmon: (k10temp): Add support for family 19h models 60h-6Fh

 arch/x86/kernel/amd_nb.c | 13 +++++++++++++
 drivers/hwmon/k10temp.c  | 12 ++++++++++++
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 28 insertions(+)

-- 
2.25.1

