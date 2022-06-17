Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF754FCFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiFQScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:32:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE235248;
        Fri, 17 Jun 2022 11:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfU8DD+AoOqXJJupaZA3Tkt+6SYg6CFyLGUkjwSHz59ZIZJKAxCKP3J3ZzbjgGWZUBFG8bHZQ/UagxpUBZdNbmvSdrTwnQbN1iOrNlIaf6fyc7jXvJPmV/kci3Idd/VaG5gKsPI9unBzxivXXkjLwtTP5shXq2jjrQ27g7ILtlFdpphs4i4i/wJoymiX1nf5O8OU9FL63T8yqdOUn8TQ0CLdrcGnxgl9vLxl44SxDUmnJPlwn4AtNLntOwQqEyXf2MxsRLD7yDKY7sYlAoah9Ji5UnBDPiwzIWs2KQfRzrL+eEquZOSMj3aW8Gsu8IYGf6/ZM1/KruJvjoVDF5TCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XurL10kM4jLCHETzZ2njXWVw42ABJD6G4WT2X9pj3ec=;
 b=IszUDBMP8qy2c1lg83QUu1DZfd7vONVEwAcinlyUtCTac9JOHeximCxTE13PGM6MvafvdT7Y/kf/2OmDb0jvMnumgbMdKkx3v4xcDthpnTpWHRWxd/YhH/M0nGrCwCw0Q5evQkPE6mzB5d9WuTKq10ZLU4m3ArGDmLo469WTXnPvTtXYlUmlxaJJe4IFUQPBHHy/zsd0gxWP1sId8T7cd5WCxjZDjv54k898QyutH0ZTDsfnj50oqYwe7OJkL9qzcwC+n+1MwT7u85ffYiZeuyr4NxnD+BUgCeBUMA29+ZSM7/fKtSyFXVDUxQihGVdDQxYwMVh1forf1oec7W4QAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XurL10kM4jLCHETzZ2njXWVw42ABJD6G4WT2X9pj3ec=;
 b=ytPxSd29jEIUom3RxysrMTs4nNlCH8wWUwXqbH9Yh5lA3WeO8RBVj/Ifj6xM64Pc6Otnmak/5mTeQTbDQ6/8qw0ePW0+8td5X8JgT+5Oim2PKqLzQPMEn0x2gWQpq06vE2X8vxiH9TAhRqq2jzGke8iPK+MOThzaW0xXeFORTj4=
Received: from MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32)
 by DM5PR1201MB2538.namprd12.prod.outlook.com (2603:10b6:3:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 18:32:16 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::5d) by MWHPR07CA0022.outlook.office365.com
 (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 18:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 18:32:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 13:32:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] Documentation: Add a blurb about using scripts/git-send-email.sh
Date:   Fri, 17 Jun 2022 13:32:14 -0500
Message-ID: <20220617183215.25917-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617183215.25917-1-mario.limonciello@amd.com>
References: <20220617183215.25917-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75dfb14-e843-44ec-398f-08da508fb448
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2538:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2538EA29BBFE264C226DA6AEE2AF9@DM5PR1201MB2538.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIZYg7AcVyna6sDM/4ws7r3X7IHJcDk8TaXoZJzK7E9zIXS1fLbnMyBxZ5HJ9cRfX0vFRFnyQbMmyr3F/Raytdkg55Z8C5VW6pf4YuBUhPsMEuxp0SayStQhILEUbW3qRgVUODbbD08TYbpTWfzA987TBJeghCbo46I2KYKjTcsMARKM1c7O31xPwZ73KpUXMiclrTRAnNJiXx/5JsBlY1ee7rRnpc1g8tX2wE7gmBwVLar/CulngVLJH1lpjtv/H//rpiXyu8UG9o6Y/6NOjUT+W25SMvmrxdk3R552/BJ+E6/OP50r5I9kQZ5o6+4hyhTvz8EEqcI/G/c5VpHvkbbipEwwS3EdCsAsFGEv2BmGvpKsuSjrE9mtREt4L8Mwvga+BlEamoSUw6MIubMdEQ8QgOIOii/QjimxjJ8DR6htBCAaerFHmOlGdw/rrQ+nodkmUnN3/EZv0pxVD3a49TibX14z9ozezfEO7YXl6YGMx2X0ZZhOEmsT374jnFUIlrPYpwP+0xPxDtlju6MvVkBEV2O5B0Q/Ex8Iog01BnlqMdH5WHfzsJnKWI4FFcEewvIE385zAgm45UzIt0F0Yfklm1BqdzsBDJGxZurkqQO4+tMoOfHll7zsAx5Jw1+MkAOItZQJh6REzA2N5d4iif5lSAboVNUfKaszhRKBn++10pJWhtPaWIz+vjBZw+Vysu7sYQCfwfKm3jh48RJNnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(2616005)(186003)(16526019)(47076005)(82310400005)(81166007)(86362001)(356005)(1076003)(426003)(336012)(36860700001)(4326008)(5660300002)(8936002)(70206006)(44832011)(7696005)(2906002)(40460700003)(26005)(70586007)(8676002)(316002)(36756003)(498600001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 18:32:15.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75dfb14-e843-44ec-398f-08da508fb448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the part of the documentation explaining about identifying maintainers
mention the `scripts/git-send-email.sh` helper script.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/process/submitting-patches.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index a1cb6280fbcf..039deed14c49 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -225,7 +225,10 @@ Select the recipients for your patch
 ------------------------------------
 
 You should always copy the appropriate subsystem maintainer(s) on any patch
-to code that they maintain; look through the MAINTAINERS file and the
+to code that they maintain. A helper script is available in
+./scripts/git-send-email.sh that can be used with git-send-email to automatically
+findd the appropriate recipients for a patch.
+Alternatively you may look through the MAINTAINERS file manually and the
 source code revision history to see who those maintainers are.  The
 script scripts/get_maintainer.pl can be very useful at this step (pass paths to
 your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
-- 
2.25.1

