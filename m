Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B654FCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiFQScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFQScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:32:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6007134B8B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaOYpCbpmcg8r8Cjw1IOk8g/0hcX718AZ6zeJCmUHGd1gHfAhaXHzaRGt5lAyUe8K1qjLRwINk7t60IxKaTQNQsO8dXq5UvbbWaJbFJMGSAGvPxCe20Fo/KrToLybRzkyk8d9oTamoI/m+rPfbDofxiOuUUXvc/oU/YqpD+7cl0i+okUUx+iFsv/iLJ3uKBKQmyAta28Lkf+tt2jL2rARPqGL9ykHqVySao6dlAaR16ruiaGvhCUDBIFu04fOh4rJ6nwvCbFgFap3f+P7nzexDs8gtRWGdkQj86QsVveZegOEhFtPc6oe+s8ONNjztqPHbN6sSgDyN/pLG38mcgF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0z5K292Tw/sxM5Dmitjx2ICDMLJpdd6yoor9B/K7PE=;
 b=Va1KTDY4kVkZZCmNhNluFUpZa7X4tSkgRWoj9mBRbl0niYJM8cxxlaE7+EJxWds2W0hbkVPB+AYbot3Fq15pg1FYquEmyV1PQTJMN5pwUOwCrTQ8E6mWdjkwborEB3Za4FKHQH1AfUtdndKHdWKD1h+b7vOF+FQYtUiJeSccWbcgIR70pgjpdHNaw0s3TRG+ajjNXGvUzyF6k/ZElaSQ1oMpu1gKAHjB6jehe6saWQ8llIcneKj0ra3CetTTeDHyH79Dk7rft42po/N8hgpKOjdKJt5vJY4mWPDaQtWCWt4KCrIOFhRWkTAtdnFZnfbcoiSFZHp3uDhbV4lz0akONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0z5K292Tw/sxM5Dmitjx2ICDMLJpdd6yoor9B/K7PE=;
 b=nbMEJl6BZz2R35YcWN4eJm4g3l0DpqZ0qLSy845qw92pwnIVjUi2gORcVGOFuq2TUMcVv4twnE2hALQn5GoTEtkiykRJN8OqK9jfb8Rdm5bUS7KDD4lPnqYIFxA709d2aJ3JDN7FliCWs9s3GRht+ORR3isz8gCl5gOhcJZFA9k=
Received: from MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Fri, 17 Jun
 2022 18:32:15 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::ee) by MWHPR07CA0022.outlook.office365.com
 (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 18:32:15 +0000
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
 2022 13:32:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] scripts: Introduce a helper script for git send-email
Date:   Fri, 17 Jun 2022 13:32:13 -0500
Message-ID: <20220617183215.25917-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b33708c-dd6e-4ac1-18a3-08da508fb3e4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540DA56EE0FDDC51355CB43E2AF9@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcSM7Eo1u1EtB3fkVUf2vTh+qqCbrNBpSr3OMJpcw5cw0wIbfUc+HUkUH5SldkUdKWGUWy0TEBn3JCL7M9vKKVr+Z1sX2XXozOBqb0D7qx6k+c5650qvByhbDqcns5AxF1mgNHyXjkTGUXJqN+v6LyzckER8XqAovC1gQeXteg1LoGiqpnWRWvQZmeZogOTvtyup5YmErZokvLJ6Zbw5O5vyJs2aJNMhcpnuqWhTfWg8ZOZ+M0/KAFSHovW3fndnVpee0LT7+Gb+YjiIlt+lK7YBt9Wa3APdU+EZFmAVY7J0KlQm6IZrpKr+wxUWW6JmCn6AmN632w5zbBgIyyp9FoJH/UtT3ux6laRdaELl3nKE5tAAIzffw5PxImjujuWDdVSbVwmw7udi25mwiMk7BPLMHPLOQlpwhSzKQ2fNOWLRe5xBS7BiYWYo6S/2N+09hPoopITw9m0HCJeSC9kuXRAYAuU3iPKR26D3CTU/2WdFIqfDdo64DYJZweiHu0h4O82ezwQNx5MB1mHd5BqiHJ9jsAjNzYj1s/zjmkrQLbr2HZGhPYmuGQtsFYzK6LfBPlBc+1aL3kJkr6IO9mXQJXeGo7HTtjiVCq6tMA4BAyrfZecYQoT+bxBK/zQZN2cm0G8B2ao2qM9Nk9XNXBmJRyhEWcAOaVz3LIMaEZhfwfIfMjdKU8SvfWujY8O7g/JhbZ64mUD5IxXgS0vfS7RKqyEq42Coratk2cD8swdevuo7F+VHzTbX4igZaF3PNuf6Ju0HkLaD1SI+GkGBJqNDJuQBQTppFNLj8PI6hRXF3jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(498600001)(5660300002)(8936002)(966005)(86362001)(110136005)(8676002)(82310400005)(4326008)(16526019)(44832011)(2906002)(36860700001)(70206006)(40460700003)(36756003)(316002)(186003)(70586007)(1076003)(2616005)(336012)(7696005)(26005)(81166007)(356005)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 18:32:15.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b33708c-dd6e-4ac1-18a3-08da508fb3e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel documentation suggests to use scripts/get_maintainer.pl to
find maintainers, but this can be a tedious process especially when
contributing to new subsystems.  To make the process easier, introduce
a helper script that can be used with `--to-cmd` and `--cc-cmd` with
`git send-email`.

When this script is launched directly (./scripts/git-send-email.sh) it
will emit usage instructions.  This is based off of scripts posted by
Joe Perches.

Suggested-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/lkml/1473862411.32273.25.camel@perches.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 scripts/git-send-email-cc.sh |  1 +
 scripts/git-send-email-to.sh |  1 +
 scripts/git-send-email.sh    | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 120000 scripts/git-send-email-cc.sh
 create mode 120000 scripts/git-send-email-to.sh
 create mode 100755 scripts/git-send-email.sh

diff --git a/scripts/git-send-email-cc.sh b/scripts/git-send-email-cc.sh
new file mode 120000
index 000000000000..ecb7bcc91077
--- /dev/null
+++ b/scripts/git-send-email-cc.sh
@@ -0,0 +1 @@
+git-send-email.sh
\ No newline at end of file
diff --git a/scripts/git-send-email-to.sh b/scripts/git-send-email-to.sh
new file mode 120000
index 000000000000..ecb7bcc91077
--- /dev/null
+++ b/scripts/git-send-email-to.sh
@@ -0,0 +1 @@
+git-send-email.sh
\ No newline at end of file
diff --git a/scripts/git-send-email.sh b/scripts/git-send-email.sh
new file mode 100755
index 000000000000..89760d50c124
--- /dev/null
+++ b/scripts/git-send-email.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Helper script for git send-email to determine who to send email to.
+# Uses scripts/get_maintainer.pl to parse MAINTAINERS
+#
+
+usage()
+{
+	echo "To use this script add these lines to your gitconfig:"
+	printf "[sendemail]\n"
+	printf "\t    cccmd = ./scripts/git-send-email-cc.sh\n"
+	printf "\t    tocmd = ./scripts/git-send-email-to.sh\n"
+	exit 1
+}
+
+patch="$1"
+opts="--nogit --nogit-fallback --norolestats"
+if [ $(basename "$0") = "git-send-email.sh" ]; then
+	usage
+elif [ $(basename "$0") = "git-send-email-to.sh" ]; then
+	opts="$opts --pattern-depth=1"
+	maint_opts="--nol"
+fi
+#Handle cover letters - Add maintainers for all other patches in the directory
+if [[ $(basename "$patch") =~ ^0000- ]] ; then
+	./scripts/get_maintainer.pl --nom $opts  $(dirname "$patch")/*.patch
+#Handle patches
+else
+	maint=$(./scripts/get_maintainer.pl $maint_opts $opts "$patch")
+	if [ "$maint" = "" ] && [ "$maint_opts" ]; then
+		echo "linux-kernel@vger.kernel.org"
+	else
+		echo "$maint"
+	fi
+fi
+
-- 
2.25.1

