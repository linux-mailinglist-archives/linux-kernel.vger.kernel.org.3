Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8BC4B95FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiBQCm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:42:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiBQCm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:42:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EF137005
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 18:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ69nXZQNXfsi9YX2N0HSo1FUvuMdxTap/ln+w5qY8PQA3myZWJwVENjQ9XXmQNK6SODBhkyFUlb2cn0DvOWUiHLUy9et7LDzJwFCEveSzzsmFfHWMYGPmJ1UAceKYPoUywKQcSgIoOtfymclBnfuM7vGNWEgTG3XCqxALh0uCDTxWjDSI1fhsFodxcFOE7FeNyjALlRpVA3a1psosxeJmsVBm9iykV8QDhgU4zKvuazNpIzlJC2R+7L+GD4X6QjtEJxepF79ZflfoILXmwN1IrwRaHHRrCkA3/EbC2hMolXtq42r1DLmtuUw5w3/hNaYEPFyBPTRXCa+UMsqWpIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haUOimLJoYbvZx+diRziOgufwuVxQmOkqLncWF1+/Lk=;
 b=Yop+wR55AW3n4qpIHyVE72ackXIwT55n1YjXM3y5SbfYegrCi7EsuBRDs/YZ71RefTdd4j1e7XErQZT9Fkh9074Io0nSzpTFKo5AWPeDESOHy6eF3MU/miima1XEmhmS/qWshetRh8Td3fIYQnCIQF5iIrVBHpjTBxqkqjZi5PLOfy4SiluRyHnvQ+Q/F0Cq8kllsELn4KXOUASGPKGsUvSGQQD06vDF557ZxHBEjHOU9eF6VCbX3U0QwV3z7GP44Ij9jOPWSgxYcgwyGi9wBte2B+hfkzEug06A1BM53JMmxHRwNRvtSdDCi9FsQKZ/iiSOT/KQw4FL9gU9bKkR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haUOimLJoYbvZx+diRziOgufwuVxQmOkqLncWF1+/Lk=;
 b=YzxL8zhbficvih+dlkwBzEbIpX61d8CgEWJVheA09mJW4f3ppVf37hnmA9rAqjjYvi9Kr/tzPJVnqkaIjMKqYFdJJ+i8V86iAlg0EDiBvXDQFAvgy9qxqhPh3TWEk7X7S3S+yihV2SwWGi4C0ITmGItSl4oeR6L/zHZa4OWgp+QSI9EyCRgK4E0e7CObQHDbnQTM3klbDQE1RtnQYAVsrnR63DJiRSBmtwYEImKZN4J4A0YmiUZH6SvkuEJBbZjkdrIJ97ildlpkRdu4BoshJ/GOWg2rrS77FJ0CFOaCwLYkHIxLf+U3jvhCleCNZbejyoEumdLleV7P8O+JMDLtPQ==
Received: from DM6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:5:80::22) by
 BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Thu, 17 Feb 2022 02:42:11 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::5c) by DM6PR08CA0009.outlook.office365.com
 (2603:10b6:5:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Thu, 17 Feb 2022 02:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 02:42:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 17 Feb
 2022 02:42:10 +0000
Received: from [10.25.73.191] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 18:42:06 -0800
Message-ID: <2e8683db-256c-5c04-bb0c-d634760620b0@nvidia.com>
Date:   Thu, 17 Feb 2022 08:12:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Content-Language: en-US
To:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <9b291987cf914f119788c42b32a08a12@quicinc.com>
 <fe6f99c47e2546429311d090999cd9df@quicinc.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <fe6f99c47e2546429311d090999cd9df@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14e3d7ca-cfb1-49a0-a840-08d9f1bf193f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4693:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4693A3196F6C44D8A9011FE4B8369@BYAPR12MB4693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdFbHpbieW8LL6L5+d7IzFP4PmIaa4PpN4NjtzXhOmoBcybITr8bLkQQoToKL991nwMVk9/1xoL2P/lF0xPrvjWaZo/woL6fN0PNFprk9iAzCzMAyjDHTqF3w0aT0yCSb6p6efdrfxhdWovc1sCxTjtjgtBmElkmfAz3VsQGV6+zpy7/3UWSqi5u/bgzknQXouVAs8vwJ0zR6iarKadG6TPKMQkHOUJ39z9uYkj1kSlXfMjfmkCtBuP+0NNK/iNwgDWKxtwf7ymKFE1IdWinQRvZ/ecqRr8j3otxHkVjiMKVNLd1SlRV8pTv+7/ygKq4afUb5U7dXD9J1ZEW51ZERez6qjq34gnuAA5ove+nMXxKzynUT0rVaINExLoUiXVQF6zN92xwNZvsQiOLdFgrNuq7kQkOv99tiBWDdAOW0eGMHO338gwpi1dgL5QweX4Rek1jwyiEeiqhpatN29CJWPpSwFnfVe+L6QTaH/iNxvtH+mYBcw8yYcO4nnAlbCYfH/o8QtPTGqjnzP4PxT5hY/FBEcNfaKrg8b/7I7lKraNUrVLg8Afx8YUr3W1KEJlVU9llWFmq+9ZQNZ/n/b0zJeueKUjMFPs3LtU0HVGpaIDisl/0LjxRcqXiiFI+1shvLByCw7FVtva8sOOS/MEV+DOPQEiWm/hc8vQTSPO6T2gNjfokXvWpneaCDVekxBxIdfKjB3R8dZ4MD5kVpm5ZL+9lByfUM1AyDsmv3ROmSJFJRtiidp5sqAu/DdA+O9iEAsTpb4lWyLtUHIOlYD04rzhYjQkFj9kS7j/CFBw28CuhcnRec8S+d8vcqhTk+55lSkOZO12tTYliQoBE95J+JDh4lZsmy8/zBF33iNpkT8Ls8kej+BUDhL4CDyzWlGJp
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(86362001)(15650500001)(36860700001)(81166007)(70586007)(5660300002)(508600001)(36756003)(356005)(53546011)(336012)(26005)(186003)(426003)(16526019)(31686004)(83380400001)(8936002)(966005)(2616005)(82310400004)(31696002)(316002)(4326008)(8676002)(54906003)(40460700003)(16576012)(47076005)(2906002)(110136005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 02:42:11.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e3d7ca-cfb1-49a0-a840-08d9f1bf193f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2022 9:39 PM, Nitin Rawat (QUIC) wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Christoph/Keith/Rafael
> 
> Since we are giving control to PCIe (NVMe power rails control), it can vary from platform to platform.
> More over, PCIe driver doesn't control these power rails directly from PCIe driver, they tie nvme supply with one of the pcie supply and control them together.
> So i think it would be better to either have quirk based on platform or always setting simple suspend and platform which needs full suspend can update it through some means.
Agree with this comment.
I pushed a similar patch for Tegra platforms @ 
https://lore.kernel.org/linux-nvme/20220217023635.8963-1-vidyas@nvidia.com/T/#u

- Vidya Sagar
> 
> Based on below link, Looks like this can be across platform ...vidya also mention similar concern for tegra platform.
> https://lore.kernel.org/lkml/20220209202639.GB1616420@dhcp-10-100-145-180.wdc.com/T/#md10b0108b3ccbb1254fe0ad8dbb6e98044a8820b
> 
> Please let me know your opinions.
> 
> Thanks,
> Nitin
> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Friday, February 11, 2022 11:53 AM
> To: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>
> Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi Grimberg <sagi@grimberg.me>; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
> Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
> 
> On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
>> Enable quick suspend quirks for Sc7280 platform, where power to nvme
>> device is removed during suspend-resume process. This is done to avoid
>> the failure dring resume.
> 
> You need to sort this out in the PCI and PM layers.  The broken platform will also affect all other PCIe drivers and not just nvme.
> 
