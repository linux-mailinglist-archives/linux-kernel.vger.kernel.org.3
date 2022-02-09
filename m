Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33464AF324
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiBINnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBINnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:43:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B809C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYZusAXeUzmS6YRGcPiDnLoRDEkXqj5sbOi8cKGSpjjFIM6XSXtnDrJaFt2ZaMBFldvMgNxR5oT41aQhTu/P8TErxuRNqZ/1h2IpUOkGtVaAjV7pjGSUld4n/arAEPYlcLmF51NYdR3KQl3jqSvecokVNParwCKOpLPNGffZKrq1DYymQNoAdpyA+I+LzPc8fQeg7vDd2jtFsbClGp71FBYTv/wOmVzVM3m/mEsFN4W6lpRl6BmwgaaY6dx4JlDIj5QCxzrlL3xZinCUnRVISxkdeepFabNoYR5+bxd3VQig1A2tLZq6drVdIvjxYCavYrrNY/Fkqh5kTkCYRP/ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScznlaNlmaEhDn/1H0WI/7SaxVry+0XPViWDGiyM6l0=;
 b=F58/AxtPrdpHqGEZtUIG/PrEzsUKSm2yoU7grFtSnIxaphDLuik9o6VDzIw+tQsJAq4oWmJmzl6/F6CuEEqTH4nr8Kr8yjlZk10RQ+X7/Lu1GVuGXshsobEth+lBrjePoCYjj7Yuh8zyNYmPGTSzbsAnuL9hQ8FlAIAqCp2KdUwNgY0xb7jfN4XVsbI/RmkzrzL/Ab/57pMebAl5HIIK+Q450lKSoKocT08kwC9oxotopHib9dqNMGjpJzR5rijouh05fhVzIkox8UEyAFZGYL0Z0iwc017fHedrz8x7JJvmhKbnyI2ZPQVMqsGVOBeg0Jp/dJEm4mz7dZVufw4B4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScznlaNlmaEhDn/1H0WI/7SaxVry+0XPViWDGiyM6l0=;
 b=riECeG1jowz17chHy6t5OdSKr9B/ycUHMQqbOIAwgQYkPqLwCd41gJEBaocsFeeBSR/E8vDfMTcYwlJAtOXk5G1Ot6TvtV2x1J6KxsXL0V1kdXBfAgutWdLaBHjbr65p0mbBjDbH6F8q6fX3YI2XLBt50gz6qQc6YK+r32ZM/VLPClYsaL5JgGSQh4rt49uTswJQwribBvgBuaDbG16QhGum8VE2pt6WZmf1tDxIB1OPW3gkg154R1BQHCo+7BlB/SHFuQbxDHIU/GsreNTn7mmYUXiBQoe2/2iO0zG8k5iGbkgaArx0bHJjlUbQNarlLtwSoGY/Sd+atZ+Qu0c/+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 9 Feb
 2022 13:43:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:43:08 +0000
Date:   Wed, 9 Feb 2022 09:43:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] iommu: Split struct iommu_ops
Message-ID: <20220209134307.GB4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-11-baolu.lu@linux.intel.com>
 <YgNjNu4kVbkruvZN@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgNjNu4kVbkruvZN@infradead.org>
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9fd76e7-89ff-47f1-a491-08d9ebd21b54
X-MS-TrafficTypeDiagnostic: DM6PR12MB4988:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB498877045DD449D7B84FFD24C22E9@DM6PR12MB4988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urAdlVpzZdtIzslhMf6oKfGMfzkHHc7fSFWjTP1CiAD6t2dc4OrqtGJzmkKwjQt7go4A9uVVD9fDto40SgKBnmMP2w0vQxdgBEFTdcMTny1hgGEXVO62RV/u9SBTmO+7Q0Oi6fUUo8Cq62Y9hWiKNjFt+LAsc34IsPwsreY5iR8Okh3YVaBoG4pAWuPJ7mI3H2PsXG/uE3Md+d2Si/EzLSWU2RMuGtfVxVmYUrm59phFngTKkwUFZIBHc1Kvt7hJTeFDBzrcgf4MPgCmg7DwOKgeYW6XJ10o4lzezvPhAC7F7JVdpBdMSuQeckQ4DhCM15um+IDGEipBD8NSFpj93CWNrNeog2YsUvJbw35etm9ujWt75yKiVJiflsemFlKbu3CmC6NMxP8RwfbY6DY6GCgasvB91YTT1SB1Z1+RHMztoN1s7+oKCoEXdtS4f1P2UWDVeW2vj5Szhk5m3lQeKts/Z3PKW0qzApfiKZ1GTkO6EZnhV/uzo5qAZsjIappbOjzH0zSUvOTETa5o8H5J5vIdZQd4SzxPAsYkzP9NcGdGnS/V6Fdrpxk6AEfva9sPsx8/6rScUFw3iCubEazXnTlnsNmHjXYuFYUVh+amzkH+x8Z9DxwcqX5qsSDynMN+kMddI8NjzP/wSYhzGWatsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(4326008)(66556008)(66946007)(66476007)(6916009)(8676002)(316002)(38100700002)(36756003)(8936002)(5660300002)(4744005)(7416002)(86362001)(6512007)(6506007)(2616005)(26005)(186003)(1076003)(508600001)(33656002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJpStdMCwXIOux6ybNoOd5dLFqk/q1WSuWu4H6X0cadqKZFhpVqGT/DCzxdj?=
 =?us-ascii?Q?DBPQYrXc35Yrf/UuHnrg/53RtEYDPf3Ra/1KE8jHrSJwGIanVuXphz3pLhV+?=
 =?us-ascii?Q?ZO9+T1p5SlgJ00TmJB1gmXVv28R8jKAphj35wKFXfEJz9x5SiezViP2ixRhW?=
 =?us-ascii?Q?gH87HrFMQ8Y+4VeJhG1Qez2DrXCj5ZXN8kZHqIFClLxggxlgm1oiz2gXmM9K?=
 =?us-ascii?Q?WjjbRy5bpQ29XU4srV8P6Txo+jPdFN/krifWALL/qMQLiWboGuCcaes8hGpc?=
 =?us-ascii?Q?IZeaLm2YBW8oW9ivi4z4X3e3OZ2dHGXEhQ1mAVT932oFduyQiw3Gm6AsTARD?=
 =?us-ascii?Q?pWvH1hSjmc2/K9GgmRCci9O5IQSCNhif7u0Dl7Fs1soFHvYo4KiyJi6lW1YZ?=
 =?us-ascii?Q?UT5POvfAwMeTf71mxDDiF47IyG6GHqMI3YP7f0fzg8w6KNPfZIqNQ14xQ3Ce?=
 =?us-ascii?Q?/BS0VD6eGHU44KQHXRIGLktAhXyTK/PjVaqiR608QZ8BGCEwm7I+rOampGan?=
 =?us-ascii?Q?jwYdt3EayJWDWn5vZ26NaS8D03kGsk6QZQKRjxne9ZoB//boFG4FsiN5Fng8?=
 =?us-ascii?Q?TXpQLT/yEzctLN/QUv0O07g2YNbz5cjM0GuLYX7FN/rm0O0JZ0GPQycCplQV?=
 =?us-ascii?Q?jap6YO6wS/bLbxaRaD1VmDYML7+gtrq9OgcM5p6zQIuLLtErWiFru7YeHvHi?=
 =?us-ascii?Q?Bt6YgGKxK9PpVLhGR7Cp6fCHJiz53XMM7o1nnT6FRVO4acMQxENex+bxQBRA?=
 =?us-ascii?Q?C2j+NnjNcNi9Vmy89aM+iAm4jZxKpTbxMALyF5SduDcIfL/oPawYiuwNRdBo?=
 =?us-ascii?Q?9OD/0c5yLTtN7OJUwJ8I/57B8ZwOruQok6Q1F43QUDItSBenCs5yEXvpQKOF?=
 =?us-ascii?Q?MrYtgQsoYA98jozmiQOrGCG59/xLMtvZYCUsv6+JZ/NsRns42qNcsRbQkNER?=
 =?us-ascii?Q?4H5ByIZ9Lyx9ykwxLFfj2JIcfWnj/dfhy/4TMDqmDekTF4lh+RDgpIj39X/s?=
 =?us-ascii?Q?ApffQMnKlDg9WJsZ26n0faErJsrsWFcwRuQ6C85iNUpdCl9u0QWZea34D0HZ?=
 =?us-ascii?Q?AYIoxtX+zuWTlj1j0vS4HIhmpwDCoY23YAxdn85vUDRW8R6PVe++QjakUp5G?=
 =?us-ascii?Q?9tShc+QAi211wUgQ1h8kwfZB84g6jXahfYsOZz/WXKgDqk+h+LThPE2fv/mH?=
 =?us-ascii?Q?qhw0/SYO7qGBol8sLVZycw15L6iOeaRFhF3MyOaAW4Cc+BoLxRE+fPWBM6is?=
 =?us-ascii?Q?fe/0sDEzGnJ5egVLxpuHNxWnWMMIl12RF7gdohpWf9YbwukrsLF9Tg3+3Ws4?=
 =?us-ascii?Q?fQFNmj0IcfTxPJWKKE/bBUzwKNW58umHD9iIzdamLfnVVoKbSHvdyJTO4ook?=
 =?us-ascii?Q?V2Jkgycs9iu/z8lIrzEqz4Ow8u8Bct52dZaaEFmuHIdnv/KhzYys2C9d0Mmu?=
 =?us-ascii?Q?fwGhoMdFq4v4r3t28JafeRhIMHLGniJkQeua89vLRkX424s4XlCz855dZnPn?=
 =?us-ascii?Q?hYPuip3AJotL9lbvvj2OTtTQOtu6QVS/WUv/FDMqGUbtqPof/iI1JOaNcsoA?=
 =?us-ascii?Q?jmz9y6RJUbw+gGL/1OE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fd76e7-89ff-47f1-a491-08d9ebd21b54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:43:08.4764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMslFsjyO2H/RCltwh+wz30zZUzP/bNqfLHQcYR7UdOQ2Q3SoOLD2axClZa8ea7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:46:14PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 08, 2022 at 09:25:59AM +0800, Lu Baolu wrote:
> > Move the domain specific operations out of struct iommu_ops into a new
> > structure that only has domain specific operations. This solves the
> > problem of needing to know if the method vector for a given operation
> > needs to be retrieved from the device or the domain. Logically the domain
> > ops are the ones that make sense for external subsystems and endpoint
> > drivers to use, while device ops, with the sole exception of domain_alloc,
> > are IOMMU API internals.
> 
> I can't say I like the default_domain_ops concept all that much, but
> the split itself looks like a good idea and done nicely.

I agree, but don't think it is worth aruging about. The split is nice
so:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
