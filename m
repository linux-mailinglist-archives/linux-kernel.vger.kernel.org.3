Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371F5814AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiGZN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiGZN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:57:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F272CE098
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcCROGhcSZdS48itReePRqdPpX1YMxXMWbNXs5Hldn3OI4Hnxzkz2wMn6ytBToZlmsGpKAF4K/XATlopFrQhvAk54QjD2Qf0EI9DbAbZimeeVgZMH6pUpJFmHtw4tP3+z1nu7UGEKRFoxRJz3jf8xTnh8JCjYIn+qWFTdJAHpjhGug7IAVobi/2ihbq1xNuaw8V6lNOwGHhmu20oymCPrZiS/q7+78Bq4oGsGVgZdVtzJQu3sdaXzEOMRx/+7+aAnpXqvakSMl10DTqSkcqSNdWkyFJ6F0YndVwTnxeDGQt7uOLxr4srq28Xly8tLoLOAcmiPFbdpeNJA/yzwTgTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgjPuYKUqldvY5rdMscx7gi24WY+FfOR5KD/ni0jDcI=;
 b=VenaKEF2ZLBeYHQNsS+Izhg1eJgjVzNiu05gMY8at5S3B6tJcsXKgt1gNuSYKOncAL0sNeqd9FwM8o2ex2p4IjEXyUAxSgwJhQ6XQgCrjuo5sXXRS2uU4e6rTwju3C0OK00JZvS8b5ZQc4wId4ehK0H7yWROawXyknUMbMfKSOhz8dJlwymPjlk5J3NSx0+Ey0jXTf6w07wJp8RzWeFkfmXz9z3IxAAzOpIN4b6iGUtuHQmJxVdBwasPDcMuTuZY3exJTjQsxZO8j1DOJ5oWHCjEXotqug4jFkeU11kczu/X7RRKLCLUYBfh3R2zoqJ6uN8Id7ly72IrqbwiZXvYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgjPuYKUqldvY5rdMscx7gi24WY+FfOR5KD/ni0jDcI=;
 b=qMx2N+bybrrneIrU1EzeRj75miSsUHa6myJWpoQzL7d1nvb2bm48hesW8OLwjWV/Dzd5XUzMgTb8mpOkvgVZm8W7pg3ktP4NMd0n4vUiP27zTypbONnu1Se6ZAOjvFY58GXxEnS9upfYAWU/kfNAGN9TPmhuoWLck+Ga2nVC0avdSPmZPkiLy0YIUBXC9xu/aNS0e0Fk1pl03L54IVcnxhNR9EKQwSp0bRL/Umg1QQoXVaC4wtN40VC80JNurRoMRnxdfqO4WeGV/Z1dqzS8rMt9Wu5MBTkNqvC7nP0DJ31OEtUPFRWJR7iIsFR5r6EHUxJ4LukFWXvqTtWUgwPLhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 26 Jul
 2022 13:57:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 13:57:24 +0000
Date:   Tue, 26 Jul 2022 10:57:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <20220726135722.GC4438@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0366.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b06d0668-31a3-4ef8-6fa1-08da6f0ec42d
X-MS-TrafficTypeDiagnostic: DS7PR12MB6239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVNqKe9jcihAx27MpeLo1lyWiNk6S7NAcJNWu/+2BuLHDoPB3fZWypb2fp0KSrWxois6KZmdjknZqqNZxV0c32jId9j90zxXdJSYAZxcpgKDXwCzbz81wdw3Ob45EYC74kYlvBPFbo6zE5cuoXNRL1j4SJ/lDTiRCvKsih82tthBkNBnFlqU1PmWWS251QptUUAXb/h7Hefs7sqFHzTCQFs0enVuePj+LWY8JYE/+QJpNkn9vMPIivNdkHj3hu3lv1IecHAdD1O+dM4mt4JQlohQMdkR09s7FGh5fpYZ6qQmap/frykz8VXZJ6VLT1d+JVIvSUKrClVXJccOFF04sxrvyctPQX/RQwBf5OpK9S99NYJPws8pdVOKGxE5wu8Exmzi+T8byZ7km5siHJkhQGWdAjvY5ipH8ta+s57R/OjNnAne2Of56DOa9yG13yDpa8UvxpWo+kNVS5Vz2Bqm6zR7M2FEqNGBRP3Njbp2pyPysYACQicw8KNWUBOfpmStqfpgBbA4/Tq/bd3dSsFaxXYFUiPBpSUMBnTG+ac/cdBRMnp0ZaBUhdfbEZQhPFgnetkD1d1yQl0pO5u9zce+hNE47oEICrj6PW0EPftrNgnJUKcPCr5qkjIV/W6gmyUqyrMzRbc9O/zKfax9q4lPJyp/5D/d/5XAbRmNcwPLIosLebjeTiwzPRccVfXIspT3wc5qSgUVf8h/o/URNzvqiGbAlindBhFSM8Q7tMgC6gVMyuqcZHxXHljnEAoa9pmT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(1076003)(38100700002)(6512007)(2616005)(8936002)(478600001)(86362001)(6486002)(2906002)(66476007)(6916009)(5660300002)(7416002)(4326008)(26005)(66556008)(6506007)(53546011)(33656002)(316002)(36756003)(54906003)(83380400001)(186003)(41300700001)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HFivzjBJYDCPkmTiz6Q1H+IhSZEotIYiuTLXRdOgWtF97EEUSYmrseYgKmL?=
 =?us-ascii?Q?DWe6d6n+ayVvUoSgjIkt6454H94cHA2pie8fzE/tFOscCnXE14fKBZ0KBKBA?=
 =?us-ascii?Q?lZADuN6W33c5VKUGgjZlrIVVDcGorYET8sfV+WomfYz8iuJkV1JbItssVOsW?=
 =?us-ascii?Q?N7dJWVU/0Eh6E9oongKRLh/dKYIK9cvoW+pN8Q+76+PDQnRQ7GHt9EW170at?=
 =?us-ascii?Q?AM708w4DpocTP/VZSS4Egm0lZtTO1GJeXfDaIlvZViwRlFMImm+O3Oe70QuN?=
 =?us-ascii?Q?CkRCiw4oRCTo2FziL6o6LNxH06m09hEuGr0EZ0BC9tqmMAzV1pmFX+2JRalf?=
 =?us-ascii?Q?3/iPx0E5aHS6FOzVrPriIi0jfwQ9wIKVA9RO+1Ev7TN2vvvnKqR4cqtXXsd8?=
 =?us-ascii?Q?dOPYE/BZAuZcB5syAKBs7lesbEtr9SXHoPtC6+dJ+EGQOrE780LFjlvVMBmP?=
 =?us-ascii?Q?4W/nCvcmcTqazuvs3gqS/XU9SQplWd2I/vzzzR8NqfQmh3KbQfObcHV5CzsW?=
 =?us-ascii?Q?IeMRuci+RNgVvfagmNal3SazEFz3eJ5conb+fvfeF4AWdnz/t/wIrp0qczl0?=
 =?us-ascii?Q?0eJ34A3iJ7L/Bj2eFTIPON0s7RjN7Ww749moCkuYok5uDLjpqRyy40iXbvnG?=
 =?us-ascii?Q?kcwIvEyFFv5/iZBxCBfp33dkpOEceWIcVrJPjduWroIvp75G5LgYQMFMM4HP?=
 =?us-ascii?Q?THcIb+gmOx9hGQrtxjrRERm3QocNtNYJM2pOyrVsiSUcY2KMBaYoa6Lep//x?=
 =?us-ascii?Q?yBHkPNcQYU2xzWMbrIag46odFkTrFtAu6IhknY24i5oKWa0BJiLFwugl2FlN?=
 =?us-ascii?Q?faTlTzUC3SaVBqO+pnrddwJEJhS1qeiRnjSUO189MPgnba396OG7mzXHBGkI?=
 =?us-ascii?Q?eKDt+G6waAKQu2m2r54pDLyoKeLwWXiQnmU3cjvs4f08tb8VUtfIE8IntOOY?=
 =?us-ascii?Q?/40ccBJRS3oRPuPCr63MyZ4kMEJSYo7uQehC6/FZH0Q5bf6uNDOH8e5T4OzX?=
 =?us-ascii?Q?vnFm0RIEq+NX2uFpsI/2D+PgDKIi99LVKNZ3yGGovG4jCF9VCCqyA1lxszUt?=
 =?us-ascii?Q?tLKUcCYOG/XGljsC7RQkP9o+nFvhyDYB3wr4fIAn1E25O9Lv1je3mOTGE3vj?=
 =?us-ascii?Q?zhjbLCWteojQNcZhJBPmoPdA9Gdb/cvV8B7+8mwE9OuDCeVCVUTPEwZ/Zrdu?=
 =?us-ascii?Q?JKL12nOZLZrGxTF4w1zGNihwco2Rr29fzMPF+iVsyTdagNX25nr5IqdbAhJz?=
 =?us-ascii?Q?ya/f7lVCsVEaOL/+Kd9hGSP6U4b/lEyg27hpHjn+X5B4wP1ByEbY6USIamFm?=
 =?us-ascii?Q?0m9D35/r+AC8qSAZv1RAzhIRE12SUk1uMYmKaxTcUof9F/hbAgTGyIRmAaGe?=
 =?us-ascii?Q?R0FfWQGmeTC2m2y7QbDudV8fnubj4+kYL9tVrPuZLGbEBe+Xn12OtZ1+b+98?=
 =?us-ascii?Q?GEsP4FD9V554w5T3br3WRFM3SP2xny/M5g9dzmssLak0bruMpZaqFM2BbP7r?=
 =?us-ascii?Q?ElWLZxLRpwLAWb6B/yDE/cZZr3XRInsNcGOZBusNJVPy6NO/Gvq9gnpSIhM/?=
 =?us-ascii?Q?kR0o8nITLxAYiOrawOMUA5p9nHB3+FhSeMg3YusI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06d0668-31a3-4ef8-6fa1-08da6f0ec42d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 13:57:23.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIOJNfhI8rPYWgpSDLPq45h6Rp0JYHg6MDB6yv0thPMqMtu0qyq5Y9M2En4MKREi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:23:26PM +0800, Baolu Lu wrote:
> On 2022/7/25 22:40, Jason Gunthorpe wrote:
> > On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
> > 
> > > How about rephrasing this part of commit message like below:
> > > 
> > > Some buses, like PCI, route packets without considering the PASID value.
> > > Thus a DMA target address with PASID might be treated as P2P if the
> > > address falls into the MMIO BAR of other devices in the group. To make
> > > things simple, these interfaces only apply to devices belonging to the
> > > singleton groups.
> > 
> > > Considering that the PCI bus supports hot-plug, even a device boots with
> > > a singleton group, a later hot-added device is still possible to share
> > > the group, which breaks the singleton group assumption. In order to
> > > avoid this situation, this interface requires that the ACS is enabled on
> > > all devices on the path from the device to the host-PCI bridge.
> > 
> > But ACS directly fixes the routing issue above
> > 
> > This entire explanation can be recast as saying we block PASID
> > attachment in all cases where the PCI fabric is routing based on
> > address. ACS disables that.
> > 
> > Not sure it even has anything to do with hotplug or singleton??
> 
> Yes, agreed. I polished this patch like below. Does it look good to you?
> 
> iommu: Add attach/detach_dev_pasid iommu interface
> 
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of domain ops for this purpose and adds the interfaces
> for device drivers to attach/detach a domain to/from a {device,
> PASID}.

> The PCI bus routes packets without considering the PASID value. 

More like:

Some configurations of the PCI fabric will route device originated TLP
packets based on memory address, and these configurations are
incompatible with PASID as the PASID packets form a distinct address
space. For instance any configuration where switches are present
without ACS is incompatible with PASID.

> +	/*
> +	 * Block PASID attachment in all cases where the PCI fabric is
> +	 * routing based on address. ACS disables it.
> +	 */
> +	if (dev_is_pci(dev) &&
> +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
> +		return -ENODEV;

I would probably still put this in a function just to be clear, and
probably even a PCI layer funcion 'pci_is_pasid_supported' that
clearly indicates that the fabric path can route a PASID packet
without mis-routing it.

If the fabric routes PASID properly then groups are not an issue - all
agree on this?

Jason
