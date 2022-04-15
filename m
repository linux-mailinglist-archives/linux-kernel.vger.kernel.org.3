Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3050211E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiDOD7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349310AbiDOD7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:59:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0134A5E9E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir4D+coYxJd19VpwLd1ROzkhqMLc7MZCH9fs2mpJudwKu8J+AqtidzEhaxwBgSX4f80jj/W/3x3JOHgF20uyC+3Fttn+uhnp+hSnD+Kpx3Gw+S6R/TxGHzNR3DOiRJ1xsN5FCTmxeorDbA3vF6LKg5cD55g4EHnuTwb75bjboCf8lw1mAe9Mrv6McQnIQhJMguvTSKMy896Hu815B0AmkJle6kF+bSplO9uCH8EI2CFv364yhcW33yi3azy5QVlUelfGEpeNR7Kes+EceXJymZJTeLNJi0CJve3v/yjaxcc6yjIN9NuueDJWDHZbzcuTzvQui5AYUzRovCXZPP6M4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb2KoPpbgyGQlfPTPRM+6ao6q5CRoeoA+R5OIzsFrO4=;
 b=EAJ6grKQ9OA2dINPl/zezdHTsiNaFRT3WoHCibfyDENP2nblWZYjByyI97y9Jz6EpL7KDdVcqsUNyXcAh2hnNfeOHADqE9P6t/Mm8vOn85CBw/m+QbkVDk6rHJi9HXI8RtJKKwmNAA6s2jiZdhMqBCyHauhQY+yT7QzwuxwLhS8uwQoiwnHf66CU699MVQSoFfDRV83QbmMnRxBPDThB/Nok563NinDq3swk1HvK28w6GoZrCctHKkpmG8Svrag2Z2l3d9vJwiE2AJA6p8S1QdP7d+nSt0zIzZQzJciysAqHvbqKIKVE+7FnSCaIbhTWluuksRWBOn7C1P8Jm4W6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb2KoPpbgyGQlfPTPRM+6ao6q5CRoeoA+R5OIzsFrO4=;
 b=U8TD5osIyFHDb5Udfbi5zpt/+F7AU8FpFNee2Y6pURGQhLwc8X2TcZYZEIjt1og2/s2zIdD5TRYqSpXCDdpzSMiubnXt6hq7o9OoLkVP22aUD9bmTwuaPJJtbParsu1/Panc4k94qo6tdAtConrYb4hBZvhFDUWn0F2kQ/B6LJ8veYnOu1WA4T00ftIPcxpszFsa+Rh+F8ihz0htpSbtDHQliHmpb4NsrPuW/xbmiY0Orcg1W42+ZUgyfhHdF+CUn8sHfTgCu80cBu3O3kScZOEz92txlf/G+u5vs06/NaCyrcfODU2X3zXZtaeCQNQ4LU8QjT2Ek09E2OCMfIfokg==
Received: from BN6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:404:10a::29)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 03:57:00 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::99) by BN6PR13CA0019.outlook.office365.com
 (2603:10b6:404:10a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6 via Frontend
 Transport; Fri, 15 Apr 2022 03:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 03:56:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 15 Apr 2022 03:56:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 20:56:59 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 20:56:58 -0700
Date:   Thu, 14 Apr 2022 20:56:57 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <joro@8bytes.org>, <thunder.leizhen@huawei.com>,
        <jgg@ziepe.ca>, <tglx@linutronix.de>, <john.garry@huawei.com>,
        <jean-philippe@linaro.org>, <christophe.jaillet@wanadoo.fr>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <YljtCbvaAHX2lKkF@Asurada-Nvidia>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e54d91-7d75-4c56-9330-08da1e93fe40
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659FD1570043FBF3C4D19A3ABEE9@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BKyqcuZfiQriq6gTJtPb570vqKJYFVhOcRT/IuENCCW4mfTQb+MHGZ9MTMO8qCuWpQXI1m9NkI3AGjuRg9PRNIhAKznL1nWEouheoQ8nbTHS5zC59ptiNQTEdhtMfd+UKDtJlO0flLTSc9ReA4jfAJiFxb9kOdV/WujTA53TLjIfDWEnbzwBlq5GPQSn8GLAAMKU6ypwjzOYd/AkuS4HRbhvt4aFBXhbqc5Utl7Ne8JzJkNs42So96f9vn4xCZZ26sFB1W+av40o9l+pig4p3+PeP7f1CnpGb2dniPophG6840C04KqT8Vi4KW92wVGLLpUE3wBIjr1UhQKgiPsu7mMvvAnPjRJf7DsY5BeWUhU5TTvKQx4uB+zX8PTyESDWM+UFl2GrSm0+wPoeoY6sJAI0WCfZYxUxYGyl1PXwpHr3MSU7LEA4vBLW2cxxSta5f8FkWYfwTH/0BCJ8wn6ShR04UBvNikaHlf57gi8fRqm6TCnbiS2rrcbeCWhb3103RsWcyT7UucQSDtPSdK/z6gOj4671/0LkHrexo+Y+fBQcRE8qU7MVvhYIKDjhj+oLLhxp0ytJ6/XoA4/mivPgK5rEWSGkZB+nDa9LPtMMKMmldOcUS6zqhvfRoAfJQNvq0XegkDcoSnXZAJMWqFJOMP32HS86wqdg7SE2Rn+wVxyblwt6iczhOiv/d5m1GsDVm6kCzWFyFTSgexeTOnbyQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7416002)(508600001)(53546011)(55016003)(81166007)(82310400005)(5660300002)(9686003)(40460700003)(86362001)(356005)(6916009)(54906003)(2906002)(316002)(36860700001)(186003)(26005)(47076005)(8676002)(33716001)(4326008)(70586007)(70206006)(336012)(426003)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 03:56:59.9454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e54d91-7d75-4c56-9330-08da1e93fe40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:32:38AM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022-04-13 21:19, Nicolin Chen wrote:
> > Hi Robin,
> > 
> > On Wed, Apr 13, 2022 at 02:40:31PM +0100, Robin Murphy wrote:
> > > On 2022-04-13 05:17, Nicolin Chen wrote:
> > > > To calculate num_pages, the size should be aligned with
> > > > "page size", determined by the tg value. Otherwise, its
> > > > following "while (iova < end)" might become an infinite
> > > > loop if unaligned size is slightly greater than 1 << tg.
> > > 
> > > Hmm, how does a non-page-aligned invalidation request get generated in
> > > the first place?
> > 
> > I don't have the testing environment because it was a bug,
> > reported by a client who uses SVA feature on top of SMMU.
> > 
> > But judging from the log, the non-page-aligned inv request
> > was coming from an likely incorrect end address, e.g.
> >       { start = 0xff10000, end = 0xff20000 }
> > So the size turned out to be 0x10001, unaligned.
> > 
> > I don't have a full call trace on hand right now to see if
> > upper callers are doing something wrong when calculate the
> > end address, though I've asked the owner to check.
> > 
> > By looking at the call trace within arm_smmu_* functions:
> >    __arm_smmu_tlb_inv_range
> >    arm_smmu_tlb_inv_range_asid
> >    arm_smmu_mm_invalidate_range
> >    {from mm_notifier_* functions}
> > 
> > There's no address alignment check. Although I do think we
> > should fix the source who passes down the non-page-aligned
> > parameter, the SMMU driver shouldn't silently dead loop if
> > a set of unaligned inputs are given, IMHO.
> 
> Oh, sure, I'm not saying we definitely don't need to fix anything, I'd
> just like to get a better understanding of *what* we're fixing. I'd have
> (naively) expected the mm layer to give us page-aligned quantities even
> in the SVA notifier case, so if we've got a clear off-by-one somewhere
> in that path we should fix that before just blindly over-invalidating to
> paper over it;

I see. Yea, definitely should fix the source too. I've asked
the owner to track it down. I sent the change, thinking that
we could do it in parallel.

> if we still also want to be robust at the SMMU driver end
> just in case, something like "if (WARN_ON(num_pages == 0)) num_pages =
> 1;" might be more appropriate. However if it turns out that we *can*
> actually end up with unsanitised input from some userspace unmap
> interface getting this far, then a silent fixup is the best option, but
> if so I'd still like to confirm that we're rounding in the same
> direction as whoever touched the pagetables (since it can't have been us).

I see. I'll give an update once I have the debugging result.

Thanks!
Nic
