Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1E4B4CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349535AbiBNKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:52:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349976AbiBNKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:51:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4A6D388;
        Mon, 14 Feb 2022 02:15:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXPHgB5sZytHiFM2lFabDRrZTs4sqUbIfcu8Gc7FkvlNeiupc4wMH3WevdJzgRxOfOsEASujw8fLHmnWwtOWhTvcgX9EWBRj2mtM0iGaqWmCDfbTpD4pZeH/jr1HZZ8X58UXpvlg5kJIUcNS7LUjL0vRHNdEM9oXkdSsoAwjBYSKhZ2xH+4DvDvPIcKj5l9cLExF0eA+YenAJO9x4PahADWbi6vaWO9oZnRFUGSP6PSidltivHQJx1xMTCXXLbq4sPtSuHYJWVFKO9HSbnEFXuymT6L3yE4FEffMq4SYznyT2gV4pZDC+O7uI7biHEvbfRxolff1fVVSpJYBFVYbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cArs/9AXZc1xBrfm7NS8nlyy3cwxYEYhYbGW2zn0Zg=;
 b=FoFFBqscV/msGwsRBbkGrOPpw7c1eKxRMIzQk02nkZmVH7kbOOOArYXuYFHVFYtkInhCizbqMIvJT/LvFtrfz53ba1Ze51PWvQwkNLANv4xLSK2HhOi5/fUKzbBjF1wf+vuTAADWlDXi2CGXjm4NOsyl3CxpCqkfgW+IaEQRhIDeoqyKg2gUXXoCQE2N34FcmgGX1ni1xYwOilq6+t7FUI+08qcazATv8iF1Ispl4iAn30sDnDIEQ9DjdggEaOYKvwb0BqhNjL5V/UhDs7kRESAyFWoovM6oxBFQrsRJSEK7sDSXDjZjQQFf4+lWGbBxpYAAch6tfBdDfCtGKMrNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cArs/9AXZc1xBrfm7NS8nlyy3cwxYEYhYbGW2zn0Zg=;
 b=nkFzBsxPOgWgqU+0P1cId1IAoIG3iAm1UaxJYZ2kiwkRqFrnPPoiI4I6+s2VQs7qYSUlX4HvL/vvzVgmSWVJlgZbFuPgN4gOqeIb8w8JzpoItmma+UD7gEeNI2QaND7Kq2JRx0oY4yIOXE7KcLJCBurkd89CONIN2dy7CIchbG4=
Received: from DM6PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:100::18)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 10:15:12 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::20) by DM6PR03CA0041.outlook.office365.com
 (2603:10b6:5:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:15:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 04:15:06 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Deepak Sharma" <deepak.sharma@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 0/4] x86/acpi/cppc: Minor clean up for x86 CPPC implementation
Date:   Mon, 14 Feb 2022 18:14:46 +0800
Message-ID: <20220214101450.356047-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0ad941a-964b-4695-9e73-08d9efa2e260
X-MS-TrafficTypeDiagnostic: CH2PR12MB3880:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB388083FE99C1BBFFFB300B36EC339@CH2PR12MB3880.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9xPqZMRWd4elT15SLBg3ph67o9/gXsN1peFK66bIvQzMPouChDi40y9/61WTaXgk6lr6RDkZw+XJ8p+m/vz+LsxAfASolaG/mssj5zJnp/duMWthx/f/1hRQ3h0IjVw7X/vdE3XUeJWKk4VknQODFLghOWHrwUB22bxvJTAQc883IffEkrzp2fb9nPGSl3P35UbuUCZSbDFG7CkHaSTUupKnZU7JGF6cD1xo3GhLDUiPDE8FSIJVkiBidu/Z7V3ztn24vv6ZHSjv9rfj7ywP4dBLzbD6StM24l3GOw/1Bj3svmrGTLTqkqqVJMXA3LTnJTi3Xi0IrpRgN9zNqN1Z1X1BNMxKm2UtRqmw/QxgUysqjIG/CGDM89xF8oOpTKRJCr7xqz2xaCGfdN+UheD2eSBB3b/Qd04qGIKFJ26X9weEmqGzRvhFQWN10khNPm/wj7iSbCS5lnfreZy/pGYU2Ux+fusD6P+lYu7QUaMwPE43RQ3Xg8Qa7qgtsosHFZF3a1RhgxwFoxjmsuotRK5FOAlydiuRNmBo6sEoIuJJLPXvf3RslIn8Y6hqgx21ZyXNEUbhpLpOpIbXIzKAYkL4sV2Q8HFgjzSMEVEzCtK/wt1wB+G7I9V2wGbREtRN34OiLYBMt5xCrKjPVRVNXCC3LL6dJAt6ln+WyDkAtCeHngU6wnG758EoAiHudIhvXEoWtuKhcVATYBaCaCkGJXdv9+e12783le5veRVm4UOlHpXd60xqnRgSlvVwoCibRsxXss2iusOlN72PSHDPDnL48Ag0vLJjXzRCGmDZjjjaQw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(8676002)(4326008)(40460700003)(966005)(5660300002)(316002)(70586007)(2906002)(6666004)(70206006)(7696005)(81166007)(86362001)(110136005)(54906003)(356005)(83380400001)(47076005)(36860700001)(36756003)(26005)(508600001)(2616005)(1076003)(336012)(426003)(186003)(16526019)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:15:11.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ad941a-964b-4695-9e73-08d9efa2e260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While we were fixing the legacy issue below, we found the dependencies
between smpboot and CPPC were not very good. But due to urgent fix for
5.17-rc1, I didn't have much time to provide a complete solution.

https://lore.kernel.org/lkml/YdeWDDCwBQAYnlKb@amd.com/

In these series, I expand the scope of acpi/cppc_msr to acpi/cppc to cover
the all the CPPC helper functions for x86 ACPI. And then clean up the
smpboot and move CPPC related functions into the acpi/cppc.c. This design
is more straightforward and more clear to handle the CPPC in x86 and
resolve dependency issues between CPPC and smpboot.c.

Thanks,
Ray

Huang Rui (4):
  x86/acpi: Expand the CPPC MSR file to cover the whole CPPC
    implementation
  x86, sched: Move AMD maximum frequency ratio setting function into x86
    CPPC
  x86, sched: Expose init_freq_invariance to topology header
  x86/acpi: Move init_freq_invariance_cppc into x86 CPPC

 arch/x86/include/asm/topology.h |  13 +++-
 arch/x86/kernel/acpi/Makefile   |   2 +-
 arch/x86/kernel/acpi/cppc.c     | 103 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/acpi/cppc_msr.c |  49 ---------------
 arch/x86/kernel/smpboot.c       |  72 +---------------------
 5 files changed, 118 insertions(+), 121 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/cppc.c
 delete mode 100644 arch/x86/kernel/acpi/cppc_msr.c

-- 
2.25.1

