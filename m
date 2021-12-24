Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4447EA16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbhLXBHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:07:08 -0500
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:55392
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350733AbhLXBG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:06:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYIB2XeEQoDjdWIT5g/+H+bcRYDabEvYrMuWDpX9hm/Q2m+tT7OBHYtfIuudQZnJ0MgYsV7bBQFXyP7/v18yQg2xCkQpzYlna31cNEjC//ye17b2Q74MEyT0W1Aqn0ntE1B1aYm2LAmyVFqKxqPo3m8APN0b4xv7vspDy4+LjBH3a0/VL0i+qdhi5EZ1Nxwl9RzE+tDCBr+NaoKHlSZ+jWPMDC1+7gVPEsuvLUqUA+v+E7V80gSrf/O8EtASkzGJbmH368aMZJykfX8qiUmi+cRUtN1ykX5MlHn/gvEALThvHxIs98HmNfPQv4+FyuxhfJ2Nhi/1OihbX3mU48pYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/LfjMYioRuigC5rv4WSx+ehE7yjhQnxsEcC3qCNrDc=;
 b=NToqFLkZfy1nhlj8rYuI9qvpXzMdbJSHntReEmvtnMQuoUArUVI+XrUAeXkXJ4Z+49qrVDlUmGpMvIXsU9ghUa6Gx9AL6dSNMu4Ufp4gusz9RXiSBQ0GbF2qViL6Sei/wgT2bjNicXLhaZtJo5+76V51JfYY4sotqr9zUHTLgr3MwDwljB/qbubgHeKCyPr9k/byWQv1DneAHKoJa4O6shPJcQHhNsK0zgNc1O/kul629PE35vvh2R47+oraYyQhlKW/M73kHWcvszW2aRvwa0rSqLGOZAgKmnaEt/D3keIVLiygpwffhdEYCoAVB715O2frH/2A5I4SKX6fNhfKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/LfjMYioRuigC5rv4WSx+ehE7yjhQnxsEcC3qCNrDc=;
 b=atMQDaH9ca93sxTL8XoOpmInzFWGwnj11fdkw0doql0w5vzRaWdGwu3JCdIZGcvCEpJmF/T4YhpDTh6uO8eQ11y6MBHucusRy7ZUMEG+SA/8y2RZPaDm09EnNGOneqDSjxZ2mf7HvnYH83z1Am3UU0TAQuHfcvJ8IfGguXxDGCs=
Received: from DS7PR03CA0052.namprd03.prod.outlook.com (2603:10b6:5:3b5::27)
 by MWHPR1201MB0192.namprd12.prod.outlook.com (2603:10b6:301:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 01:06:54 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::68) by DS7PR03CA0052.outlook.office365.com
 (2603:10b6:5:3b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Fri, 24 Dec 2021 01:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:06:54 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:06:49 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 14/14] MAINTAINERS: Add AMD P-State driver maintainer entry
Date:   Fri, 24 Dec 2021 09:05:08 +0800
Message-ID: <20211224010508.110159-15-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b3cf9d9-f502-4232-8b16-08d9c679ad21
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0192:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0192C67C030B00762A6482C4EC7F9@MWHPR1201MB0192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KcXhUa+QLyuNZUrNMFIw0zf0Pz9htbi3DWwZmyJogK8Agj8UkcV64+RvF5tGZ/UVU0fr6bsEhCjCIc7jtpnLXssrMkB1hcVH+YUkQFQ4xXQCiVCqXSDBx0U8CX5ZCUSjKnbVapINCeS0BfD/iwd8kgTGVG60SgO5j2NVKvbwrUqQ9qbcZY9WlMCVYo/y35zcBsK6DTOvQ1sU9v8oNAfyvnAfvrmjH/tNVhBskW8NBFZSH6q3g2Z0GR/zn53xiVnnGe2GXWR4uzgnSszfli01LQat/FeZ646ie6lV2aGyQ3mTZxCOdJ8LcOFE9SPe2GCPzL0Gkm9UqicQjEM7bAZ7nmTfbnDP44KORC373N6iwpw25PNcKuTOvFNVPbGt94l57vNeAw30v1uxDrw9MYGNFFq4z0TWBiQimtuOdL7feKVWG43yErjFjOQ84AIOIC3+CpT3NrMJw0sOwe9F94w9X+QGB5LorTRR3TAcpzWBRRNgP2HDWdB8thsi3r3xyIYDr92LyqBrfihdDD91uUMLn8KUYc7zMrQwJPSZkwKTeuR+dbCsgiIXxxunEUFDbKLjlCJaDK2Ps1TeJLE2viAu+Z9b2JcWgVYL8nOWyKC5SuefpKWB1WW+vfzMEKjqRz2ahWn/JFBLRhNPdwLoWY7GUqJ/mPE84Ixcaang9qVIaAqg/hMvCKhL5EFdu6eWFcPQUrOY2hw172N7gpHRIXJRpW5gRGzfpANFCGS9JxNbSiidCC9GvsC5qd0x4T/rYlmcd7S/EtZirOc62wWrTr6BqmPJ+t+isOyqQWBP0HFpgU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(70206006)(110136005)(8676002)(70586007)(5660300002)(86362001)(316002)(36756003)(40460700001)(82310400004)(4326008)(6666004)(54906003)(8936002)(2616005)(966005)(83380400001)(47076005)(1076003)(2906002)(336012)(7696005)(186003)(426003)(36860700001)(26005)(16526019)(356005)(81166007)(4744005)(508600001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:06:54.6853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cf9d9-f502-4232-8b16-08d9c679ad21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will continue to add new feature and processor support, optimize the
performance, and handle the issues for AMD P-State driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe347675fb5c..8e0666a552df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,13 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/pm/
 
+AMD PSTATE DRIVER
+M:	Huang Rui <ray.huang@amd.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	Documentation/admin-guide/pm/amd-pstate.rst
+F:	drivers/cpufreq/amd-pstate*
+
 AMD PTDMA DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 L:	dmaengine@vger.kernel.org
-- 
2.25.1

