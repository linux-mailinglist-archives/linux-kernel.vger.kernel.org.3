Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055D35099A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386035AbiDUHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386037AbiDUHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F751ADAF;
        Thu, 21 Apr 2022 00:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUwwFVq66I3ru2zftLPCXpYRh5jqnSjFNE7SG0Y3wNrws0Wv+ZzKETeXFVesff3OH4DWVyZU+TF8w4dIJqIevz9Pd8iA0Ark9lb1MO16oK8sbS3DwqcTiooAzZYB7n3wrsfQpvod1/t0KvAQi1x9YETR8MTbDWah0OUUFvpQKdJGgrh74ivwqZaXyTey4puOTX5Qtsvr1off8wZA8FM707SYLZmO/JS+wTeUEZTPM/zME29g3Hk4MijpzDNrBNUUmZKZfWHuGlHZzuwgeqRsCkPwCUDPxrlMUHg3gUpQ+BTNn4bL2Hpzr7vz14aHXAAxoDZVBjk8Mo/NV8kfJ9VWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gPQswBCeVqq5iJtd9jDv96rdeBiTe7RrvBY9I7eCpc=;
 b=CH20M/7ydv9A/WC/Bf+KWYvUOPnHJ0RQ9pqFsUIxmtwsA2Zur3c7r18Wd8NmUy7/ehkihzdLN5/7PYg2Oyoox5UMbw3dOUAS1bNXxjUszpiQDRczI9y44j8/TkK3SRLXQ/o8c/NHa/OR+LkiU3jEm/OkQz9iRya1Son7uDcYKm3S8okP/JjUdGtlblSNkQzIWePNYyxX7bL3udNKv2wFmhcPz50Kp3mNfTXwel7rSEDqfmaLdrcyiAGQJCJEhaRUP9qt8cEXL9+xOBMWlvTIFK0LQbdrG9fGjK1Z7nevW4LPO2mVF6cEHQjd6BdVFLKg4UrPl/a2OIlt1kBDYCjQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gPQswBCeVqq5iJtd9jDv96rdeBiTe7RrvBY9I7eCpc=;
 b=3j/IHKXAQSZJ/pYde1ZukAfpF57fTYzx3+Ab27LvGzHBu6oQpH/QXkOBB9fl4Di9IXWmDQOLg62EXERRls+JDiqgMtDUCLXSog4+RpW0szMFb1BhLEHTFjupIMFVao69S7Y80lptiP+LgxPoXqt+dVayA0yJZ8SPv7AIdYJloEg=
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 07:42:14 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::c4) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 07:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 07:42:14 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 02:42:09 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 0/3] Add unit test module for AMD P-State driver
Date:   Thu, 21 Apr 2022 15:41:49 +0800
Message-ID: <20220421074152.599419-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0965ade6-9c6b-49e3-8c73-08da236a73b2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5172:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB517266E4D0573BEABC10430DF7F49@CH0PR12MB5172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOzKsh7ZJw6w1pjfgzjx9hY6mv671VfBOdzfIZRDAUdmNtrOKchf93YfAPJ4xD6yG2M+5aN3U46gJBPR5WUNrd06G6fiWmDlT2EUsiJkuBn67wUwmLJagk+17vGBk5qu2GhfsdbwLVoipvBpuRujv0JPATHWFEAn/qx2bLgX/vpdpSTJkxCMT2ZHVWovU3ktnEnh4IU1VhEJ7zQhgO94752RKsB9v3AjB6NSv6djKiEyC8o5cb8hNJ+3uJZjJgqRwvf0gxBZDoX8pQ898plVkCvJ1Eg8H3k7rN5DVG/+zZtyQJItDHKtVcGBoi7zuphxGpPdxm2U/+c6LGxCf1KAIm4c5EagfouvpqW29HGzX5KPjXCpXuhdAk5rKziX2bkeFTIRVebB0Hqr43PG2oCb4JTy3n3x0aZls6dMBhNQB/mll2Ej0eqQWBUpL0WLBtTHO1EjUANjAne7xcJCMf7K3NhIs8eZPh83ln4ASWNCIsBm34vpR2yXPK3Z/aw78Fkn3/46SZ0wD5xEAhTa1c7dmUHvuzMXkMSn5mU55oWiZeVusuWh8Qduv12FhphTsT0Tx7aILTaAisi91PQf40FvHa7O84/f9QvMqyXN926RlPQrtX7kiwOQPX4RWmLEy90YMvKiIrUnL1ikLrgdK7Tr/NYM4IzeXLrnilJk3f1j8IrsqBwe03PEtS1UJpbWsc9bN85uM4zIUwgPXHbPKDuCuk41ydT2uNK6oFxcts4o0KNaKIbD2aBtLHZPhwJ93PV9aeWSHtYsIc5DCazjh7Q0VCwcAa4cBP3deM6Ni62lr4NpS2oyikGk+EaR16cx2HzL/+kry/s+3x+zTGqSfNdXZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(966005)(26005)(70206006)(36756003)(186003)(5660300002)(81166007)(70586007)(508600001)(8936002)(16526019)(2616005)(47076005)(336012)(426003)(83380400001)(86362001)(6666004)(7696005)(36860700001)(8676002)(82310400005)(110136005)(356005)(54906003)(1076003)(4326008)(316002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:42:14.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0965ade6-9c6b-49e3-8c73-08da236a73b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

AMD P-State unit test(amd_pstate_testmod) is a kernel module for testing
the functions of amd-pstate driver.
It could import as a module to launch some test tasks.
1) It can help all users to verify their processor support (SBIOS/Firmware
or Hardware).
2) Kernel can have a basic function test to avoid the kernel regression
during the update.
3) We can introduce more functional or performance tests to align the
together, it will benefit power and performance scale optimization.

We upstream out AMD P-state driver into Linux kernel and use this unit
test module to verify the required conditions and basic functions of
amd-pstate before integration test.

We use test module in the kselftest frameworks to implement it.
We create amd_pstate_testmod module and tie it into kselftest.

For example: The test case aput_acpi_cpc is used to check whether the
_CPC object is exist in SBIOS.
The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
existed at the detected processor, so it is a necessary condition.

At present, it only implements the basic framework and some simple test
cases.

TODO : 1) we will add a rst document.
2) we will add more test cases to improve the depth and coverage of
the test.

See patch series in below git repo:
V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/ 

Changes from V1 -> V2:
- cpufreq: amd-pstate:
- - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER.
- selftests: cpufreq:
- - add a wrapper shell script for the amd_pstate_testmod module.
- selftests: cpufreq:
- - remove amd_pstate_testmod kernel module to .../cpufreq/amd_pstate_testmod.
- Documentation: amd-pstate:
- - amd_pstate_testmod rst document is not provided at present.

Changes from V2 -> V3:
- cpufreq: amd-pstate:
- - adjust the order of add amd-pstate.h in MAINTAINERS.
- selftests: cpufreq:
- - remove the call of amd_pstate_testmod.sh from cpufreq Makefile to main.sh.
- selftests: cpufreq:
- - add explain the goal or intention of the AMD P-State Unit Test module.
- - modify comments.
- - use the checkpatch.pl to check my patches.
- - add conditions judgment before formal test.
- - delete some unnecessary test cases.
- - modify test cases about perf and performance etc.

Thanks,
Jasmine

Meng Li (3):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  selftests: cpufreq: Add wapper script for test AMD P-State
  selftests: cpufreq: Add amd_pstate_testmod kernel module for testing

 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  77 ++++
 .../selftests/cpufreq/amd_pstate_testmod.sh   |   4 +
 .../cpufreq/amd_pstate_testmod/Makefile       |  20 ++
 .../amd_pstate_testmod/amd_pstate_testmod.c   | 329 ++++++++++++++++++
 tools/testing/selftests/cpufreq/config        |   1 +
 tools/testing/selftests/cpufreq/main.sh       |   1 +
 8 files changed, 434 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h
 create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/Makefile
 create mode 100644 tools/testing/selftests/cpufreq/amd_pstate_testmod/amd_pstate_testmod.c

-- 
2.25.1

