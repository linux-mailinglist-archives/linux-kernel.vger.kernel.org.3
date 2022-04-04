Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D24F1ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381780AbiDDVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379225AbiDDQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:49:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5C35DFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfzNfsFxyTgkYz4mCp0kYUL5jQXzA34/Uu449ruGff3J2h11/nc1FqsHW8EuxFIQyNifOrcLe2iknJSPQztBI/9VILeR5nyKq80C4MtoXTPCWfwPvVfBDSLNwiKOF0ZBpECeUPnHiYjhA6tSkFGX997syRS2zQbT+xXqEgG6Qwsn3Vgzks64BKvwvzWcUrCk3TmmJDGQBIzYEHEd6DKPpWo8wsG1T44xQGirUPgImKMVYPS9L+E6LZP9ZqBBCH3Rhh45+MzqkG3hzPWoDo0ct/kBX+nDTy3C4gZKOcbc7Au0eS+SPw0YUbpgpgZ6SifDi9cd1MSEqToWjLNt9kZL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEd8QmK3Y1nSAMnzZe3OZ627GVk9DCTl1dw4qnU8vPY=;
 b=kUGAv8F9mbt83FL2QujwDN9tBK2+8IEcdSWShsrRdieQ5l9HjFcIJtW5O+4hJvKnuTdLESJCW0YwddTOAoSCy+utuCLIOfNkWCl22e6GmVXNbdRrDANS0Gfu5QeHr2luUnby9J94WOpcZA2iaEnczqU2hvrA1YslwTPBhyIDLpy89LyR2JJKX9fey8nxwdOyBl98k1/r8zzeVa9dgscxTyJfEHze+Lctd5BdXxWCQQCzO0m05Brc1DCt/RVMjW68XwwajfUE3c7x7fur2M6oIabt6cdTeyLN+G3+PqVQD1Stg0nYbl63hMvCUfkUEFXDIa25Gp2hR12EEqi9SNBCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEd8QmK3Y1nSAMnzZe3OZ627GVk9DCTl1dw4qnU8vPY=;
 b=WWnL2Bqxjo65DzLOz0f9Cbm7M5DMJ5QLysjnLlaac3wGmvZzBtgycCwqVULGpNLsmAw0+t5agQBheSF3ptEB6dvSpDpemR5V/0T9Xe2vueB8UnvtjIpOgaqatuKWE9c57Qg5YkfNJywl0VTJLxmlCR8RYhecSF4gzS6+WvK3q1k=
Received: from BN6PR19CA0079.namprd19.prod.outlook.com (2603:10b6:404:133::17)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:47:29 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::90) by BN6PR19CA0079.outlook.office365.com
 (2603:10b6:404:133::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 16:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 16:47:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 11:47:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Date:   Mon, 4 Apr 2022 11:47:05 -0500
Message-ID: <20220404164707.1128-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b94de659-901d-46eb-fa7a-08da165acdfd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4396:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4396BFA0D52BFDBE12E913EFE2E59@MW3PR12MB4396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrBsskV5TlLTwbiLExPPZhjngvNOjkxVCaCR6xgtnjauw00x22xTFKZniozO6eEcVSmTSYuudHreXur/07El7GwN1tU4YHGQaoaHoNPwoGa9uA1Ru6NXoyljcosFw6tv3YOOaMH6QJD3gtugzU4FmexfTIusMixq77melQmKN57anrFFqZfONFquERhqAIsskGkerFI9lIllwSx2F0ugLcYN6ncAsMe9Sd1yyTa55E3uHUr3clVNWuG279lVtuTXukxYpCP48eeWzRl87PZ0qktRx9WncFM0+yKdimWHcZ4WgufKGmMPZRlm4bUfLLJ11rRYSqrwWuzaoi3m4zU6o7DLUGmx9OBfJ0C15FSjez1jsh3IApyOo4uLUtNwHzO3Aw0FQj9LudMvgjhPjYX2ZqDWSFbwKx9Z7ubuVZlnQ4K69zzggYh75Ujq/tdjmiO0BNTiJ/zziCHuSreJQw6WFqdoAEbe/cIchFge3h+120+9ub2EU9nO74DSP/02whN4hkLa/41SdtX3CtKCm/K2EAy50OaaL3FQKSfndve38iV4q+56LGfmDWaZCtNVTQlIBdLnw9aR0oLobeuQaWAmwWgZnXHmfb4ii5iyPBfkPg5RfazS1nVbSjKyAwNWFV/tGFiO55Nyj6kUiH3jEypohG78zeX/4hqLZ0FxK6+6BBDaZefRbWNikJx7WuwiEX0OCtR7y+zWjVdLqYQa06zhzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(110136005)(36860700001)(44832011)(82310400004)(54906003)(316002)(83380400001)(356005)(2906002)(8676002)(26005)(4326008)(186003)(47076005)(16526019)(70586007)(70206006)(426003)(7696005)(508600001)(36756003)(81166007)(336012)(6666004)(8936002)(40460700003)(5660300002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:47:28.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94de659-901d-46eb-fa7a-08da165acdfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been observed that plugging in a TBT3 NVME device to a port marked
with ExternalFacingPort that some DMA transactions occur that are not a
full page and so the DMA API attempts to use software bounce buffers
instead of relying upon the IOMMU translation.

This doesn't work and leads to messaging like:

swiotlb buffer is full (sz: 4096 bytes), total 0 (slots), used 0 (slots)

The bounce buffers were originally set up, but torn down during
the boot process.
* This happens because as part of IOMMU initialization
  `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to 0.
* When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
  called and the buffers are torn down.

This can be observed in the logs:
```
[    0.407286] AMD-Vi: Extended features (0x246577efa2254afa): PPR NX GT [5] IA GA PC GA_vAPIC
[    0.407291] AMD-Vi: Interrupt remapping enabled
[    0.407292] AMD-Vi: Virtual APIC enabled
[    0.407872] software IO TLB: tearing down default memory pool
```

This series adds some better messaging in case something like this comes
up again and also adds checks that swiotlb really is active before
trying to use it.

Mario Limonciello (2):
  swiotlb: Check that slabs have been allocated when requested
  iommu: Don't use swiotlb unless it's active

 drivers/iommu/dma-iommu.c | 3 ++-
 kernel/dma/swiotlb.c      | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1

