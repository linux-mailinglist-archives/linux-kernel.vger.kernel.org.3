Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3974FFFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbiDMUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiDMUVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:21:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891668118A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbFw3JyuBCKpnNNpxSkcX3sxiPpvnf9ZYsdc+dCQBdQJrlc5Zfk5bm+SaH0JCAcYlyEJeFAqMiAsGrpXewhx6JTCZ21CHr8pzxwezUl1DEP/ZYPr5Cw1euZJvmr6Q6614TQlTDdhn6mktMPuPp60Y9BYPdTxuvGA4OiKUKIQWPzAzjEU1XOmrYODlVv7TdXp28mh8SrnG8FWL9FasqOr5rTJgd/4bhXs8SjGO/1D20YK7CST9U2v2jvy86eHxZg4XGkbt9d/QBBH+xJ3vjTAsjB1PYGOGmBuFv0VNzeeYAv2qoUTpuryfa2sqZI4dvWCp6eAlt/A7D/zOJdOcKDMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T4J0nuby/qYy51mN29SPbuFy1VArRpDnoDjrbZN4WU=;
 b=Bt7Dl2kdnzXcqZnnPmULvVIAQOPEgUvJyr92662RnC9q/MdcIrggM3yjaTzZBlYBGrK2xrXAAdyE5krHU58dH6X0H1CrdNas+hCG6rdCDPZN1YX14tFYY3WN/BWtUwRtYeE+XP/SBdmUcBUSPvWMvqxnlaWPuQNjoit/xsbfN0SnwywSF+muspJo4T0E5mVIx0O3QtFpNOsLlSj+G48IMV7pUQogsDdNZJ5tSlqiHyJcKjmV9d+dtk+ybFPyWDboVprkQMdprIi0O663Qyv5KEEn9gdquUdzVt4Nx6gseo7rtL0to8ohOe8wCcVVrqEJ3vpQy/aDb+Xlx2inYE6auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T4J0nuby/qYy51mN29SPbuFy1VArRpDnoDjrbZN4WU=;
 b=iiE7kUL/n27YyI3ms2rrfcTUrRZf0Lq0K+L/RBGd99CAViIDCQjna7mDa5VqFqQB4KXaYT/1v+CNvirM2NCi4hv4juIeEaAqbg+Op4ted4iLkumkOusV0+CEzRphz9IGR4YUmiGf0tHLD/7gBR5h7dsKTFtOu1iMCmv9jYyu6D93Ctz8sVWxyOFLgZKqV57QNWibTj96W9t+79yl3QnFz8l3M18E2C3KIt5AkOYKUfIDxWstmPPTI2vzYmBbmi1nPcNyrlIY+0nEvaCVbUfBfrllIV2qpfy90g/z5qtFOs2OMKtfX/fDArYrPHRcqTx09aDvba459ClMYvfzYRgNqg==
Received: from DM6PR13CA0018.namprd13.prod.outlook.com (2603:10b6:5:bc::31) by
 BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Wed, 13 Apr 2022 20:19:12 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::90) by DM6PR13CA0018.outlook.office365.com
 (2603:10b6:5:bc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 20:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 20:19:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 20:19:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 13:19:10 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 13:19:09 -0700
Date:   Wed, 13 Apr 2022 13:19:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <joro@8bytes.org>, <thunder.leizhen@huawei.com>,
        <jgg@ziepe.ca>, <tglx@linutronix.de>, <john.garry@huawei.com>,
        <jean-philippe@linaro.org>, <christophe.jaillet@wanadoo.fr>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30044c83-5f3e-4ea3-3b37-08da1d8adf95
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13786C1B1437BE997245DAD5ABEC9@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaYeA2uX3Cav27yGPSN2o57b222u2SMGJ3la2/Idi76cV4zDy5ZI3wfjDcnWDBy5sdxrcWjPv76g/Endg6Aau+u4RMQnZd/e+qGuVeETtSxf37eA7yHYNtEs0cG6JcCymmaYu3K6Ou1KepO7LBPgYmSozWxH1xZ0cKx7W0eNWKcrX4es92CbDsdzaBzhmL/RrokJfibk3FSWv3fGqt0sUMff6rR6yrSJRohRMAY1iPD+IKmx/zYiYGfVs26EnRPEbfSYUg1iqBzf/2r/koa511dRvk/SiFd0ASxL03u8zbV/42C/dLAu/Ik9T5qE6gAl5TFdFh9oKMVMLxrc9wnc7VgYKw6g5er8ZFFLJypoOqBr0vEzoePeP8BesUuM/H8GaMLukAk7Uw3L3yBqx20oS4iq+Q2TXIvlnEypcwTuo78e21Aq0fhyVl93Vesm59rQrWJsifhEjVJZQ2TPrUS53abCrKXZlPDTKeFsJm0hNTs/pVmEKWYvEYLkol2wBQLbcaDkST4yhfCrOFnKRAzJnpr8xPN41JkQRrECZyef+6rliLe6USnpnHLBFIzrGBpsizIIKqDSZ4kXsgynPFQHqRdjOLIz3mVvwi0ke1dFx2S2JMNCTVmNaAswQQGErBkTN+9Wm7tlcwgUrSSoybIZQ5qRdnNnEaOFpv/Nt1gJKAiZEIEX0joxJ8YmepcN86zhYjLP0xJPkrDC7V7NfXrRYQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(53546011)(9686003)(26005)(36860700001)(82310400005)(47076005)(6916009)(54906003)(8676002)(426003)(70206006)(70586007)(316002)(336012)(7416002)(4326008)(33716001)(55016003)(8936002)(5660300002)(508600001)(81166007)(86362001)(186003)(83380400001)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 20:19:11.9044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30044c83-5f3e-4ea3-3b37-08da1d8adf95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Apr 13, 2022 at 02:40:31PM +0100, Robin Murphy wrote:
> On 2022-04-13 05:17, Nicolin Chen wrote:
> > To calculate num_pages, the size should be aligned with
> > "page size", determined by the tg value. Otherwise, its
> > following "while (iova < end)" might become an infinite
> > loop if unaligned size is slightly greater than 1 << tg.
> 
> Hmm, how does a non-page-aligned invalidation request get generated in
> the first place?

I don't have the testing environment because it was a bug,
reported by a client who uses SVA feature on top of SMMU.

But judging from the log, the non-page-aligned inv request
was coming from an likely incorrect end address, e.g.
	{ start = 0xff10000, end = 0xff20000 }
So the size turned out to be 0x10001, unaligned.

I don't have a full call trace on hand right now to see if
upper callers are doing something wrong when calculate the
end address, though I've asked the owner to check.

By looking at the call trace within arm_smmu_* functions:
  __arm_smmu_tlb_inv_range
  arm_smmu_tlb_inv_range_asid
  arm_smmu_mm_invalidate_range
  {from mm_notifier_* functions}

There's no address alignment check. Although I do think we
should fix the source who passes down the non-page-aligned
parameter, the SMMU driver shouldn't silently dead loop if
a set of unaligned inputs are given, IMHO.

Thanks
Nic
