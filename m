Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE0523263
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiEKMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiEKMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:02:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05A65432
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrFv8DzmyEKrZLVuyE15l5JLOvARpD1wlTa8TRFeX6gqj7BSV1jn+Qb1WXNeYoZ6BlRQkjJd+m5+bUMyZo9PBtPYztLUCfVjdLeAO4wcJPDBc1AfilGC0/+SQlBRaDaJwBjc8HFGK6pcBR5dovHayPIwTCitCqk5eXcJgdhDuXIoPFau2lu6kmsqNsToIVSRJD38A0qpjvhtppStb7r/MctZre3u7BrqvdhVmwVw9az5wuqr8hpqPp1+iySzCDZ6sxUm/7qeMoNmBAnI2r1oxqtGeDbY04+Xkc1zHZGP1S5i3L3I1D/N8NoepDIs1csqclLO+YatVkXzDiJR6c5hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT/MNsQKg2yMZPsivv0pk099Bzm7G5Iqdijw+0cnOKg=;
 b=XXAwCFj43E0EO0sZW9YT5MEJN3QRNDTaktEZr8QjHY6nCVc7Sktpj2InmRcPyNGrWHXvuzVv8TD0RYynb3iDlbXf8NqFHVmcGkjnN1Gwi/iByGKCPuteaU6xfeHRjzxhXSBtpLmvRrIpODlOU8YD1tFO7ahBppbY2btj1jF7stAUrsgbzVNoeoXqMdxl3TcKBn7RFHNVEqipezsCTK4fOG+SNBCdD7UIdy85V+J8/GXDTsMnUwFz9K1qnjLy0fso3W/8MnUzX+XPSYcWY54xOmPR6EaEh0lSokHo1umzcrY9jxfZS1llSgQxPwxOkdGgiGgDYsUu0NJFbNi07/mLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT/MNsQKg2yMZPsivv0pk099Bzm7G5Iqdijw+0cnOKg=;
 b=pnQojE0BiRmk14ZTKvdSBkd2ozzsSPlCu9mofkKWCfybyf2ZCptgOvUauQCXcUrmt5w9+/kFzQucDu+Mo1PsrR15A4ySTXDi0Ea+zNkDN46XAYGNcOZQL0VODLsmjf9LnOy/UQw6FV74w50JYVTts4yHpzzUMr+bzoHUTbMGQ1j63+dC+W5rFO1h3ufHjZlQU4enTwQkpBS5DMe8PKGwxn+zErrQVxlkmVnIBqMONCUAdQXdp7sEJVM2bF4FiCmS65haDyB63eJXqPMbEXjGk1FOt9FZPj7Fq2s3aWW7z5QGgN61tCSRfKO09YFYAIzveiHhSQx/QQO4/mOa6ky49A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 12:02:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 12:02:42 +0000
Date:   Wed, 11 May 2022 09:02:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220511120240.GY49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yntrv+nq2t/IeVo2@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yntrv+nq2t/IeVo2@myrica>
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44549c0-6cb3-41c9-27a7-08da334626cb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4952:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB495258DDEFCC41D773A04814C2C89@BY5PR12MB4952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1u271J3cIaXD8ka6BQgsM5I5BSIWhC7+clk3VBrYjBk0EXQUa4fD1gZOj/AgMNllN+YN1Th2RWEQPfNeyBiQwaJKQev5MP9D4/OiM60Q+WE0qRaw25E//mnyI6wfPb7PNp9ON7qbBaAe2W6BNH9CoNqoV0cE60NjKI+lBN1U7JJWq96630jgv+WwH9LHtCanDMM4cygEVpli7gVWIy6Y3r6jaAFFrI2MWrBX8LnICfj7SrSStDJu2X6AqiwGmg4Z16p5uFSQH4FLD+uHUGsLo2AYt8rKJOU5poa2QXY8ZM2qLhDJ/VdoJssZwGamDmMwnzvolN9Nl49pNobYyLbByTFglW+haKEeo22be8oPaw9LA5cdjst/u+xs9DN89slSYdkN4IXCAPjHPsu6DvOi6ERrxs1OPRFTz5691NGmK7ECGKGg8qTksCHRPbp461gKmGiv5KgCgzvHfQ5b+QPLC6DL3+oSdd4CNftfQ72mzuVy4+C5iSe9IsHUzyY5S65Td5K1//WUKqNZMjR13McvzgNfAjlN+4zwlHKf4a9ZyKRCCmqOE39LlRN/Xpul/P7Ibl7wFi9Q2eaO7mg0kkJKjcUBviSsnOp84GBNpZV400KnIuFZrkUhSBH6MvkiEB4HhjfrTyI+jKef/l+Mw4aJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2616005)(86362001)(38100700002)(5660300002)(36756003)(6506007)(83380400001)(8936002)(7416002)(1076003)(26005)(316002)(66946007)(508600001)(6512007)(6486002)(66476007)(66556008)(4326008)(8676002)(54906003)(6916009)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3roa3OlpHR/Y7jVkxarGRkXANyh9PWROjhU0tB0NnIANuGXH79BKNCE4t7oD?=
 =?us-ascii?Q?q49sB45XM53iKL1f+Nkem827IBMfy3FvbyW2IwkNbfXBnYgPmwI6tfDx6u0K?=
 =?us-ascii?Q?Ypi9/RAj+NB0gUfPCN/kWcBxZHdSpc80EYfnjxw8vKCPHRhGDvHTTW2cEk7J?=
 =?us-ascii?Q?AcR9jF03Uo9OdX5OOH4l8vT8aPoLv4RAtRecRKPs8uiJp0Y5i7DATxhJKfFJ?=
 =?us-ascii?Q?Rq4TdpEOoKJpfa9OVBvpGfOAsu0M9hOL7x2mvQiC94pBb2K9OstfdagtDW69?=
 =?us-ascii?Q?0vNei8pRIZU1+h4NI+m9UEZtLpmWKijPAv6BdqQrpU5biQ1MWjNFvzDc4/b7?=
 =?us-ascii?Q?YtuGmu3UTVwA/44dbswzuSEdSAH366NCzyL2VVpYJWPgcTlNBmuyKYWEBa+F?=
 =?us-ascii?Q?L2jXDjl0LsxAFknd3SMq68CboY7YhDiQg/F/Ddbd9PrvqGQmOKeOVQs40YG4?=
 =?us-ascii?Q?tEXbm52/t8VQf4MsBg3hxpyMDrceZFMR0Z8c5Ws7lqY8AMB7Js+OSNTBzhB/?=
 =?us-ascii?Q?YXmgjCgSBQu1R7C6wOGFgz1n6At9I0+Kz3Hj9G+FoGlQm+/TloaC/bfvvYQD?=
 =?us-ascii?Q?XeQHkjPzLuG+WnU/RMkddi9JRqM67y++x0Rahl+qQq6KKgg8MxSdTeHZEq2r?=
 =?us-ascii?Q?I71w/f6sAs2E3W5Hwn9UsCQ+h8v2BaRwWy2wXXyki93eMiuR2YLcD9SsK52h?=
 =?us-ascii?Q?V8sQyd8W+LuX3DpJp/ObkNBOdMvtcR2DXrj5y8VvlqhtKJ/4RVFGpP7HaJvB?=
 =?us-ascii?Q?kbIr5qRT17gZNKrVCqkh+WjmqOqjcsx863bujnBQzO7zcRboIUsnTzjbC8lr?=
 =?us-ascii?Q?7eZJ8O5t4zdGNPB6Y+1bqIcAZc7tCoA9LUMzXLP1rwahIbZXau37I5rqQEM8?=
 =?us-ascii?Q?o9wZjwfV/WFTU3ZemlS3Xq/eM1JoMOoFJoM9dQ8aeohcSHjeU6IdcQv8l2+b?=
 =?us-ascii?Q?5YMLymfVvqgFNX1L/Qmre1tU0EStaiHPaEOGb2QyfgR83EUbSAKuD6juXMDd?=
 =?us-ascii?Q?LU/ymWEvGqtsvTNyn//QcvDPDhBKKD9VH8pQEBtx4WTMdR1aD/OT9tCfPkH6?=
 =?us-ascii?Q?iDWvAQnr247mHnJf8Y9ch4nAfNCCCUaauRZTYtv8HHjSCwv81IB0QB6wRlBb?=
 =?us-ascii?Q?TwnAt4HJ59lhNGmKTOw+GCLZsXEetLIa5K0DpoFtvNMfL8LA9POojMadUwUQ?=
 =?us-ascii?Q?eVoBWxFghdsKc++tq3vOqN2y+9glfyShPzdO9mjpIcibQS3U7WpkGmUu+5YA?=
 =?us-ascii?Q?kHkdCwNJ/eOz5KwMJ7CUDXiUJrCU42d6jtdxVfhHp9qQJfNrgWABQiiTEwmT?=
 =?us-ascii?Q?VuXZbeMQHZfwqml2wUskfTOUCVmf/Q+9jCDXU2l7ZhaRW2kIQyKenIqvVgGF?=
 =?us-ascii?Q?xozZzDQ02Xkh0u0Cz2KfAbr3BePJW+RFWCtFuS0NYYXs3l7pEvgWryLlhxqF?=
 =?us-ascii?Q?6Iu3WAKFsscuL0Bup6morYoI15oWcGIQsaUJ+VQnvbIjCnHO8vfNRvwTldL1?=
 =?us-ascii?Q?EU23ESkZk+obyZxTjYhjMBB77pSfVSXpin8u/aDZV+n0M5QZIAqT0WGXv9SD?=
 =?us-ascii?Q?4e3snN3ElZ1iTr2wCPrROIy0y1QS1Gzj3/WHZu1yXfcuOMpL6FfKPu+83Vbo?=
 =?us-ascii?Q?0XMbJofzHHcI2xv5m07/2URWtaefx2vtgMMIaX9z7UdUtLpvNWrRRqlxcKE4?=
 =?us-ascii?Q?r4wp1yML9p+ojuL62yhvXE7nwL2HTtR2FaX2Hd1JFoXoyh9vAR1FUEfuVjjP?=
 =?us-ascii?Q?QYrJkXa1tQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44549c0-6cb3-41c9-27a7-08da334626cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:02:41.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mhkCtXk7wiDvdiUAazg3H/pABFOvjlVTJGLA0k7R1n+ZB5jr3ONhJJ2s5IzML/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:54:39AM +0100, Jean-Philippe Brucker wrote:
> > > > Then 'detach pasid' is:
> > > >
> > > > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> > > pasid);
> > > >
> > > > And we move away from the notion of 'detach' and in the direction that
> > > > everything continuously has a domain set. PASID would logically
> > > > default to blocking_domain, though we wouldn't track this anywhere.
> > > 
> > > I am not sure whether we still need to keep the blocking domain concept
> > > when we are entering the new PASID world. Please allow me to wait and
> > > listen to more opinions.
> > > 
> > 
> > I'm with Jason on this direction. In concept after a PASID is detached it's
> > essentially blocked. Implementation-wise it doesn't prevent the iommu
> > driver from marking the PASID entry as non-present as doing in this
> > series instead of actually pointing to the empty page table of the block
> > domain. But api-wise it does make the entire semantics more consistent.
> 
> This is all internal to IOMMU so I don't think we should be concerned
> about API consistency. I prefer a straighforward detach() operation
> because that way IOMMU drivers don't have to keep track of which domain is
> attached to which PASID. That code can be factored into the IOMMU core.

Why would a driver need to keep additional tracking?

> In addition to clearing contexts, detach() also needs to invalidate TLBs,
> and for that the SMMU driver needs to know the old ASID (!= PASID) that
> was used by the context descriptor. We can certainly work around a missing
> detach() to implement this, but it will be convoluted.

It is not "missing" it is just renamed to blocking_domain->ops->set_dev_pasid()

The implementation of that function would be identical to
detach_dev_pasid.

Jason
