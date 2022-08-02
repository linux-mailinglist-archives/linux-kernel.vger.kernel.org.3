Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13812587C82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiHBMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHBMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:37:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448151EEF5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+UZHd0cQxHAWum65ySCsdLI45lyt3B2fZbyYUcvYOmXoIXjZTcWIGZMqrD/IqqIVAgcFFO4nPBRBsPrlyoyWlkd2ffbLw5C/Wa6brjros9rjtwWqnlxPz68yCpURZ4IwECUPYBim7RTm0EuEbXT5oCWhC7NBgjLzqzl5dmAcGuikNv1clDKjX/1dkMl7VvC+fIvnehs1SzOxs/fkOUFSGtu+KwWDjJSSM+5rOTTdnYhqfKzPuQVjXBW5u1NIIJGcSB7YOTCQ8N4BJZfYjroIKO6SMOJ/cxujX4UC7IZU4QKCKNl1ykOCN99bGA8aLGEuX2/B4IMEifDnq41N0Nikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD9nsvKY9Ottwf+VQne/gwje8RD1uIQaKlACll6lAZA=;
 b=enneGfZulFW9AfjR8KsN7sEIXy41bsIon+SNa/+51q1HY1Pxxb0b0mkHjpPLZVT+SPU+66+JbQvGMBSwnnBrcYbZyZ3gI2Q4NTz+olldoz8mxvL73nxwdWw8EJdEY8TE2tfQNy8YIUSMApUyJhfW+/JNUsUJs/6mEEC1Hj3MpMvwsPPYJXkPbDSrOp9MqySEAd2vN3/3gbVIivbJl/avllRsYCsy6Fa6cupcqTPMvBTzNMyNAWFssHc+5RhsGVypJXPIYYN422y+Pg0FjvMe3HGUa+AbsxOiUHwQJqe6HXuNIuqHcxOV3nK7eDY8eMbtlTC3bAfmEhkCXLNyuQpwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD9nsvKY9Ottwf+VQne/gwje8RD1uIQaKlACll6lAZA=;
 b=HhK9WFKRFsLTYA/D5/ROT7Vdl3vKno5X3i2AXs5a0GRYF0cLuevc5mcMXRljYcTfc6LsHRsxu9RY9S9aDZQldd+ivd8MLyNFMAJjNOHAOwPyzvQ2NJLs0qfvQWcDY2lrJShiHSO8XlZUf2XCMo5WfM3f35L9HRi/zoVesH0qV2lkvBp8ahxqTsYOqJWN2CnGqOicONz1lEwBkDyCOl1wLLDAJtAsluvwl8aGEUTXK2FVEpTPnEHzPG/VAp/s5fvmZvxpEjKfbJPx0bvVZb4iJzsmky55aAGgsDkeXTEDWGXwQXmn+7erSh/6orzrvon4r56iFxD/8pBc5wp8Scd18A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 12:37:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 12:37:08 +0000
Date:   Tue, 2 Aug 2022 09:37:07 -0300
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
Message-ID: <Yukac8X81CP7gDsM@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
X-ClientProxiedBy: MN2PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:208:d4::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4791c8a5-57a9-432a-017b-08da7483b6b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVUVXtuHwCTlPsTokci1tqH3TZuZ+FqwaLHeMCHgshYRhBQglkUu3nQ/Uq+M4G1hJDw6rRLZVu4PumR2ycdEMOliDj8E/sRSr+A86uOJOh5P81IqG7jR1tMEo4U/nhBpfMVYw6p864cU6yVVSdU2PBMh1hJgyz2FUaHoJEwGfJwCS4mqa7V3E5SbNu4ELrxlrtjmo6qoin82OA18ahBU3yWK4FEDnSkQLl0K1/4MCTd7jtuyJsvLIZhGvfUNDvW+E7bP6Z6/kG6U1hst+v3nZfKxIgo4LUgfwbHcKvvxuqeh+sHjWkTPBw/PeNk96/+KOe11kUNv8UVGO53ERnCNvg9YXS4Vay8c9kCL2vq0iMRzchK04Yl8IQdtQPV9FjsDRzmpcJy9ZCrOpFEBpl1JD2a0XabMOlIIpvzRUfqgMBaBmK/XxvEu73q3/l2NHFwBtDIiOMazoiSp7ENScvlmbpTBhNQqfjq2DcUsjHnE60M8CttcZwNXJIFvsiSfA0qeTPFkYDGHj9Fqpf5HeDxGBwZJQge5gNKko2BqG+VdzJdFc8eE8ZTEE1A+blySQDxhc02EEUiS1g0EqYm9PpKNhmFgI9xDJYLlQmrLH/U+UjUZn7PXgKZgamZj14vZ94rg3WKGOKR6AoQfDJGPTIQwnRqWfuWL9XVS/puSlX1/zEqHqo1fWwPj/119ZlZQM28EfPDtozTCn4qcnd77t975Kf+jLUVulQ1awThbIJiJcM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(478600001)(36756003)(83380400001)(316002)(2616005)(6486002)(2906002)(41300700001)(53546011)(66556008)(66946007)(66476007)(54906003)(26005)(6916009)(6512007)(4326008)(8676002)(6506007)(86362001)(8936002)(186003)(38100700002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8LiWED+SmhZ4HycP2URKzmZVA5bD9Gay+EaYN8HNWtz9OsmKFwmIDPc/BMC?=
 =?us-ascii?Q?RtxKSPYNvcgXUh8TebjNLxEhoXPeFfsz0maS3XQYy5kHSuo7VurxjydtijWQ?=
 =?us-ascii?Q?aC44I02yFD6CKSEA01QUPw91BF0yWvRcs9Dt9WDd3P4ZiH6/suhUeq5tNqMO?=
 =?us-ascii?Q?FmLtcPlEatA629woAK9sZ+dnrvH31uTe/OwcJuP69N9wbCEnTbOE7k/j93ke?=
 =?us-ascii?Q?NjfoK61AVIQqKGs2KHBe+dzdOP7TwPD+Y/t99oZ2KB3hkH+z6XHMcVpysTEU?=
 =?us-ascii?Q?OaH1HVmvYIKIw9MjMNEQg27vGple7DMeS2F9ZvGag/pfv/huoyY+02anuvUF?=
 =?us-ascii?Q?eyw0QavUUrHTWSKde/yqb9xtHyoUWb+ulwITwXrYLiNZ6qkDbZi1dJ4WvWgX?=
 =?us-ascii?Q?A7fMLMmr58ASTpn9XS6Msv0e+/+wfz5UzwYtsM+cKU+khSm+dvALu+cGgQyJ?=
 =?us-ascii?Q?FPb95cQWIbrDqKYaKTz5g6AZY+V6ge6s1v1qUm2REjD1qjZ+KEFdjkq+D3OG?=
 =?us-ascii?Q?jzrjfMapeaEqz5DpXANa/mPT86CkChBVMSh8HeQQ/Al7F2DpneMhcBWAMQb0?=
 =?us-ascii?Q?r87MzBst1QH9ITExR+DBYJKKkg2EqkNYkKbUFZzV5Uk6ZJF+6AS9FU3hsL0p?=
 =?us-ascii?Q?tebVMohxfI039J/l1hlfShK+mbYvZhNsDuUhI9fSdrmcck3l/oUu/83PBqGm?=
 =?us-ascii?Q?GlOa81tQOiEt4K17hY+NLuoxIraMSIuRkwBm5VL2TGbuaQm+E4SduK3/GK3E?=
 =?us-ascii?Q?rXzqgGfZLVEljsjNiyvcaxjusSmCiTWmrZMXJRiuZLXWDPAXdnIxpfFUj4Wq?=
 =?us-ascii?Q?5hYpCK6n3Ax+lBVDRYcyryR/7mUwVuNA2exx1l1vyTcd/6MNPzjiPjjLesCo?=
 =?us-ascii?Q?TEDi3VFyvjvsD0oYpbXhK6ZF4NU+5qXiPdgjpQQQM1fMunqHC8ceWsxFRhql?=
 =?us-ascii?Q?gP++fhvqc14r7WZpoq2r0o1xhjaedixHJ3ogjL/FcflXD5iQtMryfUoJjgsw?=
 =?us-ascii?Q?go+dQtGrKEugCLgQAfXmMuemHXY70egJ4qGozzWi8H2GZBqYcI95hdf7CZ26?=
 =?us-ascii?Q?ggs7MDMubqqftOBzSM+5vVmOBfONG4BbmvxUDvzqW/WZmp1gLX8/s4XIIAsR?=
 =?us-ascii?Q?yDKWmZOuXmkuHeu89L46wz36vwdY0Aq+d216nCrf6iFxCkn995S39cXSLIDS?=
 =?us-ascii?Q?IPXWHAPgxz7HkPLyp4ott2OXENo+a6n26BFw0bJDbo8lM9rgkAlHOy229Xxh?=
 =?us-ascii?Q?W99ETGvW8a0vICzfTZlfcx8BBG+b1rnGLfWjy+02OMiHU6O2NJbCsc721QgC?=
 =?us-ascii?Q?HLkMujBHke2W/nmfmv/MTK4OyWi4bD6p6KY/FwFQnYd751Ozrq7cGzX9rkFa?=
 =?us-ascii?Q?lhJ5dsp9p6y3VTNOCcXyvc68RunTLiXlnHxOjCUYeVYm8EMxstR1qvQVlrmB?=
 =?us-ascii?Q?6WcF5xaent7s+MTC0hHqx+M2NrsKml9ubKr7MLwrNEUqNUHQNSDimGb/b47u?=
 =?us-ascii?Q?jQ6XnNpEAFnPz41uUNuhzzAQvtGptyVjObhWsoGaI4VGzwqlITKWLaGqrk9r?=
 =?us-ascii?Q?HU8IKUeinOwj6WQlse06i/hy1BWz4UQFq9cEC58B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4791c8a5-57a9-432a-017b-08da7483b6b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 12:37:08.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W28lg49Dx6IQ6ia3FbVA9T4uHnuDovKnN2YAay0z0Fl3BHz421WM66tcQ7Df1r4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:19:08AM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 7/26/22 9:57 PM, Jason Gunthorpe wrote:
> > > +	/*
> > > +	 * Block PASID attachment in all cases where the PCI fabric is
> > > +	 * routing based on address. ACS disables it.
> > > +	 */
> > > +	if (dev_is_pci(dev) &&
> > > +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
> > > +		return -ENODEV;
> > I would probably still put this in a function just to be clear, and
> > probably even a PCI layer funcion 'pci_is_pasid_supported' that
> > clearly indicates that the fabric path can route a PASID packet
> > without mis-routing it.
> 
> I am fine with putting above in a function to make it clear. But I am
> hesitant to move this part of logic into the PCI layer.
> 
> From the perspective of IOMMU, TLPs with PASID prefix form distinct
> address spaces, so it's reasonable to require ACS protection on the
> upstream path.
> 
> But PCI spec doesn't require this. The interfaces defined in drivers/pci
> /ats.c should work as well even the IOMMU is disabled.

No, I don't think so, that is useless.

PCI SIG has given a bunch of tools, and it is up to the system
software to figure out how to use them.

There is no reasonable case where Linux would want PASID and broken
fabric routing - so just block it at the PCI layer.

> Yes, agreed. The iommu groups are not an issue any more. But just like
> iommu_attach_device(), if multiple devices share a group, there must be
> some mechanism to make sure that device drivers are aware of this fact
> and only attach a shared domain to any PASID of those devices.'
> Otherwise, the iommu_attach/detach_dev_pasid() might be misused.

I think it is the same as the existing attach logic for groups, with
the sharing, owern and everything else did. No change for pasid.
 
> Considering that all existing PASID use cases are singleton group case,
> probably we can start our support from the simple singleton group case?

Don't make confusing unnecessary special cases please.

Jason
