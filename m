Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293358FCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiHKMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiHKMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:47:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B44357FF;
        Thu, 11 Aug 2022 05:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl1Bd6RihGHAoc89txNCHB7KdyPCuiY02jknVasnROwH4eNwobAMT75lsAqjyZhP5eQ52oQ2VzzlvCSjkSCis4eRIhwh+Vs4f1/pA/duGnFZsyRwYPmRsHpxOiJWIsTEt363KnHAdr92TAxPWfg+ce841HEAJtRS+cuv2h6ScDa4pITVmY1XxdcUoATBaa8tkMCMrBfPHnrgLrEVVn+EYRXHWphuhQ2q6g8qZ+lIE6JqdqPuKwQ5ymx10EejwDiIyGYXqIPi3CFxrxEZqeHeo7K6Seuh+wdSwf5A0dh4sLSD1InsFWMYWRREzuCeL+/ZRAz7vd1uLgHTxcwCHToYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA+s12UHgbxDU/zAiZWYtelFFILYjkNXPofU91p00oI=;
 b=gSf2AQncT7CWhxHremXuLFDsLXXbWrOrghv/gVaH6+NzWXwK/uF0rvCDR++mB6E0WQV0NfG+Mm9jJdCL1MZKeH/K+Q91BcR6d0/H+amPisSDeL+2LeXC7oaoKF+gj+n30HzrDoVynCQviCkbta3BTLeYxfqnTs0bI4bfLjaNLylNRjXv/30Cs6jBiMJdTMY/mQmm1I67yF/QTuydewg3UJN2qlysJIerbHSY2GoUBZ81BBN9kqTg8iLeaMyQtJh3IEHyszA9iG6zhc+C53XX1Lh9qJumAr0uTzPbQJ/YRA4XnICr6qJkDM+cz4LXDjwKgM5udOpcmHYTN5m/mitLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA+s12UHgbxDU/zAiZWYtelFFILYjkNXPofU91p00oI=;
 b=FgjEYjFv+WobEhl+5Hh/IjHlboeX2ZDBgHcFPFT6lY3l3ZIa9CiLVqos6WgaUxl6d3Pjz2CBAxKqtujmJiNbw2u+bc8olyNjbZl2uAZrxCdHFQXpv0H5hzUahlQX8mJwo01DKgia1QgQ8uCRYNU2OMYC1j6YK1PaKUGpTaydiBY=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 12:47:04 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::48) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 11 Aug 2022 12:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:47:03 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:46:57 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 0/4] tools perf: Add branch speculation info
Date:   Thu, 11 Aug 2022 18:16:45 +0530
Message-ID: <cover.1660217326.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4be5cef8-fca4-4504-11d9-08da7b9797a3
X-MS-TrafficTypeDiagnostic: PH8PR12MB7025:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzT2/kPWx4c8V8RHeT4GXmFQLoCdw0lYKuNuXnjz+A7IZk7Tsg/m/xdEcN9kjc0o9fYjTAYtG2Y2yZcKgQA9LszKeJ8cuK9S1Gr2NLXBaWPbMW5GHmAa+WOMnVqj3IgOpcGY2gyqBTybZbKeQo6wM7aSr0EZbA6VNBbrluB1Y9V+OFdhoVpTdR+U0pF44Dq0ZF+ETqpW6murPf77ToQ4btohiHQdPFRJ9EJbV99IVu6eEngomIzs6lt/4IFi91Pt6m+ZYq64NP/fwuurDxLKXLedVujBQIDIDnRrJUPHR//V7jS65b8HjNCI5qUDCtkV1Re6Mv8ZkBCjHzfvih6ptjccYnt4yni6nOKPXuWYaMco0d4OwMJjtpXjbeMzniWT8BxRXN+WnPpW2Pxbpy60RvwZEdYgUPrGftbBmE78i6QapUMuL+V+JbYVd9nUUiw5lQGsDyoDYx3GVGjUA5oT4tJ7oaw3ybAZ9qWPWQB9vnyTZ9lfLFoWcI0yTPh4VtLmJ5cuT59xYMqFsF5uFVlgS5RlbSiqPUIeNkxeg1dv3Uwcuj/Td/q9Xzbq/jpgradCatsOCD2ljkklye2wGK2VDTk2iD0M2HDQuU8ri4VlLqa32WtwhPxqKvR0ixVrGmXfq/oQjL9b36GLcH2jvUJHjOl5pri3iDVnEloswHUP1BB0QUt4TCfDwzOOLk67csXYmnzJDi9OMYHNIKJNragRztkEfjggzjYKblAvxTmHZzHSMtO3j1Tnubd321okm8wfqNAmHmK6dXBikn36wss7Q6ba5ms0YcHJZdN3MxGoyCb7nzzsPN+zy/n+gRRaMx5VoZy1xA1TOiXXCKZxWqKFtDR17QWYzD/KvyanRyyWwz7EQqzOPY8AjaEu9AV9SBt8
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(8936002)(356005)(7416002)(5660300002)(4744005)(44832011)(26005)(40480700001)(86362001)(81166007)(82310400005)(336012)(2616005)(426003)(186003)(16526019)(47076005)(41300700001)(6666004)(7696005)(36860700001)(83380400001)(478600001)(316002)(4326008)(8676002)(82740400003)(70206006)(70586007)(54906003)(966005)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:47:03.9733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be5cef8-fca4-4504-11d9-08da7b9797a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
speculation information and the perf UAPI is extended to provide this in a
generic manner. Update the tools headers and perf tool to be able to show
this additional information.

The LbrExtV2 enablement and UAPI changes can be found at:
https://lore.kernel.org/all/cover.1660211399.git.sandipan.das@amd.com/

Sandipan Das (4):
  tools headers uapi: Sync perf_event.h with kernel sources
  tools headers x86: Sync msr-index.h with kernel sources
  perf script: Show branch speculation info
  perf session: Show branch speculation info in raw dump

 tools/arch/x86/include/asm/msr-index.h |  5 +++++
 tools/include/uapi/linux/perf_event.h  | 15 ++++++++++++++-
 tools/perf/builtin-script.c            |  5 +++--
 tools/perf/util/branch.c               | 15 +++++++++++++++
 tools/perf/util/branch.h               |  5 ++++-
 tools/perf/util/evsel.c                |  9 ++++++---
 tools/perf/util/session.c              |  5 +++--
 7 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.34.1

