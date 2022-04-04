Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF24F1E11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiDDVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379224AbiDDQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:49:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A936141
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaVLMRNqk1ZWqotDqukAoVBMsIwdUSnuLaqZ4GVwQpuSdY3/fw8vLsINoZtmcbDilobvyh1Yb+BigSNLbFbHsGNlM4O47lfb71X/iJ84nCKnveWAe/S+lbSUTC1iZ+7G8JHWcaHgFT60mq4+e2uK9pFYyQa88bLjWVhMZT5NBgV2E8AX9rUFYeQCI66UQgd8LNlHXv2IavYvrlHk5miMJDA8OJeVBbXWRNkdDCydulOUSWsKu8PR8WsAX7RShuyhzK+h2k5tMTwwI8rcFv/jGKqwXvZNwK9WFEi/V2iU/WKQxvTVflV504UUspl0iVG+3JUU26vnBfEr81KhM25/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F/SelIyUMGN/DQc2HNe/2kBt5loWYxH6mrOBVOe0ko=;
 b=aL/eIO4ZmWkATSG4NyQB+KszVdPmQK60hreck1krpnoRNdGvJsQwMJbnRo6dYtlYjVscb3Yk/rUeJkn2nFZ4CKm0SnNrT4IPbtgv7cyujqhUFwYno6aMkvzL3GBV58QvMSLKMNMR1wT8IWzRe5fV4woPW/lx+RNcZp8khnTilqBxo8aJD/+7OdaIDVU1GuuoQW99ye86IXBtEtPSrb+G8EBFbtySNonShVCEuMs44Ew/FgciOB4nMurqqkMu7tEowvHbC91tSaI4BVX/NWO0khWrGxi+xWlTSSK+03eUYePEJ0nwAeZbrWbtgPca5T08DPqjIKlvXMcdtdMY69vo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F/SelIyUMGN/DQc2HNe/2kBt5loWYxH6mrOBVOe0ko=;
 b=YCCQiZBIHvkjUSugbb9ocMgHbhKVVe/Kjm83OZFuR12SWIuLvJ5Avh3weVoDuJTGQyJi9WQsymbAsf9+aW8plBdEnOL+JtuQPhv9U6rE1tvDJkHpfPfXGNZ5R6ppaO5mjRuttjBtI3l++cSBkVFFi44SwF4QMIqe5z5rp1IpIdw=
Received: from BN6PR19CA0091.namprd19.prod.outlook.com (2603:10b6:404:133::29)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:47:31 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::47) by BN6PR19CA0091.outlook.office365.com
 (2603:10b6:404:133::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 16:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 16:47:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 11:47:26 -0500
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
Subject: [PATCH 1/2] swiotlb: Check that slabs have been allocated when requested
Date:   Mon, 4 Apr 2022 11:47:06 -0500
Message-ID: <20220404164707.1128-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404164707.1128-1-mario.limonciello@amd.com>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee731ba-e78f-469c-6b0b-08da165acf7b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4280:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4280AEC189B6538D31E7AF3CE2E59@CH2PR12MB4280.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERV4Xiz2H3SOY7IfLKniguquS96CnWD6iOw/948ZWvI6dI9FJyjhz71080KgHAGK4B0UjY5OKaypNgOn5/lZEaw3xUcVavR7b5MYCR/NU5QweJd0WqeT0hPVV2/jbjTcjqXzWIrCBCbVyUXyX57cXOf1QkEUgnLNi0MrCjhncYd6jfu149Y/9NaPytFVC6fC8LWOg6shWThDOkYexKx0/EGhniv6pTTWnl1dsNPY2iZaFnJsn1sRBJBzHYwshdqhKSgvOmlVn06fqeigsncWrc76/DBemmr1MteqlnGdmH9tnljmsYfpQ6i/xVKGVyo81o5ySKVbV9EXVwxWJy3qsf0+sjlgEp0Em4I7H0+HPg54Uk3mmRD/HK/SG8qqi4JkKamDvuqdX6O9zihJqCGFIuK7m0DvPkvoXtt/w2uH634b14oFRvSS0oP7ChhhM1cNiH0fgWfDvqu31YWpZ6rggE1YQh8yOPlRTFqyB6NnxM4dyTd/YH3HgiDo7rAl3L/e61nVbwWSIa73qM+KD7s+VndWPJmbVf7D+A3QKc8iFR9hqiDjJaeotuu9YjHMzFnNyAm86JP4YaeK38nnTg63rNzr/G+bSRKclWubuZkbBwC3oRS+hAefaVYDvFrKyDx4eFxd4YAmxP5cQ/Gwn1VPA/sn3Eeklf65bmVyK1I/b1rKelK8Xnjv3RvER9DZjyn9TQ5zERCdTi98VNTGBo+/qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(36860700001)(2906002)(8936002)(44832011)(36756003)(86362001)(5660300002)(70586007)(70206006)(81166007)(356005)(40460700003)(2616005)(6666004)(110136005)(54906003)(7696005)(82310400004)(316002)(4326008)(8676002)(1076003)(426003)(336012)(508600001)(26005)(16526019)(186003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:47:30.9561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee731ba-e78f-469c-6b0b-08da165acf7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the IOMMU is in use and an untrusted device is connected to an external
facing port but the address requested isn't page aligned will cause the
kernel to attempt to use bounce buffers.

If the bounce buffers have not been allocated however, this leads
to messages like this:

swiotlb buffer is full (sz: 4096 bytes), total 0 (slots), used 0 (slots)

Clarify the error message because the buffer isn't full, it doesn't
exist!

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 kernel/dma/swiotlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 73a41cec9e38..d2a20cedf0d2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -591,6 +591,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (!mem)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
+	if (!mem->nslabs) {
+		dev_warn_once(dev, "No slabs have been configured, unable to use SWIOTLB buffer");
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
-- 
2.34.1

