Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2C59ECBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiHWTsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiHWTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9679A7E;
        Tue, 23 Aug 2022 11:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpEvTF0zqQNFrwAMUOOQJg9OTdV3L4tj+zrdfHMF8djHZwJokr2ZP+zTOEoNDPUIUImunTUSMkXDkUpxEju+FXCJpTqowZNdwvjYyFAITL/XYuGZagLRtsUSYN8Y7wKhdO5Dqr8lEC24lp2P6jwOAY9b5FDpLsvYYYnrfzAWWsX6F0noxXXk1qnTaKGeKyFWG6CEZprIRBlV2z/DPO7BL2/HP8dZWb6SbTXhDbqqjlydZGhDqq9lPGPp/07mluSAx9JstPlozpxdTYlBx6NSCH73h6kygg46uNHnC0tfrX/LIY+AGobshZsrWZnX4aH1y+QZ+zD0m5ZaLCSYsQferg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFnR3bXw3qX7mpCr4BxgPiUUU7a3SMELH8mcisBCcOU=;
 b=UT+Dq29fmxiOCIizlbm/5AqOey0PkJ+/0ab1aO1u6vB6DmoiN5kGe4quEJ2GM5wnEN60E6Xj0FezJMc3uCvpLabclLxC2BuT4EdpxFSeKapyQYK740JJXKfeTzA/DoIQUwROxw4+EbUA65RDGK37yAwG2+3+1VT5bYP0cU4AyG3ELTCJa2ndOpvhj1EzbA59BkpBBnzlPj7/JC+uTQP9c6ZW9GR+iutrA8m7Caa6F1kJqab+2/WOVo5MGFphyfVy61tYNZev6m7f+/89lpu41A2zsWjA8RowSdtNQszfgRMHiNMmWbuCwrOa5xwuKxGFAo3q3xTewo8+QXGzqZbM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFnR3bXw3qX7mpCr4BxgPiUUU7a3SMELH8mcisBCcOU=;
 b=dAPZljonxU0Xj61no47gh7896Eu661KiWDWYvdOrgXtHSSEOV7EtKK7OKXav9yrnDtWrkI+AXlOa5CCbQDHmWHMdxbTjckMv2KZWLx84cM89EfiOz3qzgJNRJLmHwqAnyXbXmsuBpEigPBMoNj18cCZySxDAQOFcDROvPdZ0dZg=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by CY4PR12MB1784.namprd12.prod.outlook.com (2603:10b6:903:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 18:51:25 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::31) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Tue, 23 Aug 2022 18:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 18:51:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 13:51:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <nouveau@lists.freedesktop.org>, <hdegoede@redhat.com>,
        <ddadap@nvidia.com>, <Dell.Client.Kernel@dell.com>,
        <kai.heng.feng@canonical.com>, <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ACPI: OSI: Update Documentation on custom _OSI strings
Date:   Tue, 23 Aug 2022 13:51:34 -0500
Message-ID: <20220823185134.14464-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823185134.14464-1-mario.limonciello@amd.com>
References: <20220823185134.14464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29c8b374-d37d-4be9-8736-08da85387aff
X-MS-TrafficTypeDiagnostic: CY4PR12MB1784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+PHUQuXyAN9k3u26Re7Tg8/lsUs6dsi8hz83U0scoF+JwnRgVPbWhq10rFTVcxXOeeSEAOvCmcYNZxgFG4Mdf70rMDCv/hds39Wvdqz6AXAugueqNki3zihlH8tujoUlmC3Bx02OoeuKmhIVPlywQYKddw2DNYcqBkelGEOmr+mZUy6LP6NC74YRYPIbrRPcwyVj1cj4jaaKotiJo/T5h57kniPOrdZt1e0A6xCmM8kBo9itIgDnzfjavgZS02kWGvTfj4H1L1yWbEwEkCxLJjuqg/8ssDjGIQ1hZ7iQZmeoD5U5Dtmg9eA0JRvf1cNEOJcYAu3BC8Y7M5qeqCD0eJObjdt0tV5ovqdANuFf+8s4AUtYx+QocWg1ixDd+AnLgMf8x8gOdUfAFrbNvPpcHEII111be/DYtS4+3LNx8NzKlrVAUPD1eXgt14ZK8m1l14HiQjf3tW8qGAqXODWqjQ1fuanrFWYiVlgJTPoOva7yrtQiC8HEQDL8XYedgbzCS7ehHVjJnwv4mSkDiR2cf4DWeVVoQITGvfmw7i4IxEX2WH579v8VH6bm/X+/SnlaKGG3hYTTFmtXvsAagUAjM8SNRPJjxtmlBQlTcbVC3vGrhyzAtWS8XAyN6z6+xrdM42LmUZXE8BXXmKJjM8NsJpVI0p8Oe08lfI50oCBrS+tErgyXRS14Ig6tdOCvPXGBuGpjYxG3E4H1WKaeMbc77CjFiu4hCGYBsyVn32uSm9ZkJOe0UTZuvViSGC1W8DFBLrM0zRZufmZ+p80/Dc2h8+DgrPOLtgsi9TTLrhnjXEmTy7EZZTNb0kGpncfrl51
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(40470700004)(36840700001)(1076003)(8676002)(70206006)(478600001)(70586007)(4326008)(54906003)(316002)(110136005)(5660300002)(41300700001)(8936002)(36756003)(7416002)(16526019)(2906002)(82310400005)(2616005)(47076005)(7696005)(15650500001)(6666004)(44832011)(426003)(83380400001)(26005)(40480700001)(36860700001)(336012)(356005)(86362001)(40460700003)(186003)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:51:25.2701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c8b374-d37d-4be9-8736-08da85387aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally when there was some custom ASL needed for Linux the guidance
for Linux friendly OEMs was to introduced a new string in APCI tables
and discuss it on the kernel mailing lists.  This lead to 3 strings
being introduced.  Those strings now have the original problems fixed
in the kernel and have since been removed.  The kernel no longer
advertises any custom Linux-* _OSI strings for OEM use.

It was discovered that these removed strings were actually being abused
to detect Linux for unrelated reasons.  So drop the encouragement for
new ones to be added.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/firmware-guide/acpi/osi.rst | 25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/osi.rst b/Documentation/firmware-guide/acpi/osi.rst
index 05869c0045d7..c9d508ba2ec7 100644
--- a/Documentation/firmware-guide/acpi/osi.rst
+++ b/Documentation/firmware-guide/acpi/osi.rst
@@ -41,26 +41,23 @@ But it is likely that they will all eventually be added.
 What should an OEM do if they want to support Linux and Windows
 using the same BIOS image?  Often they need to do something different
 for Linux to deal with how Linux is different from Windows.
-Here the BIOS should ask exactly what it wants to know:
 
+In this case, the OEM should create custom ASL to be executed by the
+Linux kernel and changes to Linux kernel drivers to execute this custom
+ASL.  The easiest way to accomplish this is to introduce a device specific
+method (_DSM) that is called from the Linux kernel.
+
+In the past the kernel used to support something like:
 _OSI("Linux-OEM-my_interface_name")
 where 'OEM' is needed if this is an OEM-specific hook,
 and 'my_interface_name' describes the hook, which could be a
 quirk, a bug, or a bug-fix.
 
-In addition, the OEM should send a patch to upstream Linux
-via the linux-acpi@vger.kernel.org mailing list.  When that patch
-is checked into Linux, the OS will answer "YES" when the BIOS
-on the OEM's system uses _OSI to ask if the interface is supported
-by the OS.  Linux distributors can back-port that patch for Linux
-pre-installs, and it will be included by all distributions that
-re-base to upstream.  If the distribution can not update the kernel binary,
-they can also add an acpi_osi=Linux-OEM-my_interface_name
-cmdline parameter to the boot loader, as needed.
-
-If the string refers to a feature where the upstream kernel
-eventually grows support, a patch should be sent to remove
-the string when that support is added to the kernel.
+However this was discovered to be abused by other BIOS vendors to change
+completely unrelated code on completely unrelated systems.  This prompted
+an evaluation of all of it's uses. This uncovered that they aren't needed
+for any of the original reasons. As such, the kernel will not respond to
+any custom Linux-* strings by default.
 
 That was easy.  Read on, to find out how to do it wrong.
 
-- 
2.34.1

