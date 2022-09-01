Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412475A9C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiIAPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiIAPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:49:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0B3AE;
        Thu,  1 Sep 2022 08:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRbfD081w9tpgxBc7dZf4Z0pGS5BiBJ9b8XVVxvaEQZDHP0gNl1CvYRg9qeYWKn95/0XRL3ls4/fLze3EX6iaWF7pMuvPtbrJ516XZox2o1dxMiBqXOMHx7vjI0t9Kbn1J+LhZxSTkD0Igw6BPWSvsQyAJyF0e0xARMapxpuSBlI++T0R8CJ7Yad3u3mExAb7h1ShpxT5+rlrNpfOTmSEdwUqCX9zWGce6SQBQudD2d0O1VdYOpEc3MhOq4RGSkr0wht8K3TRvG9nK61G+OEQ5kMf+RWtHsP1rT1LeYBeQHNbkZ+CO0PA1WSaLsSwlUvsLcveuS0qmQMYo9CX/oLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVckLzpuxTLqox170T455GnnAogN/IixmtzKsdrHGqU=;
 b=ibVDrJlknNL6/PehHHZwTo+UTlX1baAOc9OW7VqxUaR3LwGSN30Jia7a1wpOcJEnZmUAr95q2hxHKV6zIoTTZSfRl/5Vtv6Fu6Bjoj3eWeLhMma1EUOaPvZOgf8WENw+zkJn9lP2fuUwLkIG8cTdZ5WPUxXsLvQm2iJzToS1HuQTQwiQAd675+s56Tvz64/nk7RlBFGdBG6ogSZVDaBmFuj9aaxIa4O5xAhAcGwdpK56H9ohCLXusV5YLGcOhVO77exhNq2gke1qAYgkJ9fllTBDq7u2tBnp5FLBnB5KC4HqOh8xmInP5TQpVu/IWiH3RDfemkKet4+/wXrgifSkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVckLzpuxTLqox170T455GnnAogN/IixmtzKsdrHGqU=;
 b=GVHP0ELwdKSQjQKG8Mt1vFSqY/R7j7SKay46dUHfZ/rnTTTewjn9G+riJFX3YV9gwX3uAUZnglNuPzCTH45P02kL/EKcWkJsEbeamW6JJoDmZhn4sMRnYbybYypo3Q5MX2DIInl2AuyvIGfA8L/d5qnRByz1TxbOx7QwvmlhKe31w9FxJv2/B2Lb2jd/1roYyb/TuT9FeH8p6PvIRKxgCRbwMw6D7SSUNtjiMpjg3c16OyaCsJCiJGQpgFlCo6XTE7Of0EuoXdh4oiERypl4dIi0IP9388cJIzFIdU/9ys9eP4LSnLIEqIp7dSmNDb1W/z9YXkwmBQ+KS0k+F2gQ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 15:49:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 15:49:42 +0000
Date:   Thu, 1 Sep 2022 12:49:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Message-ID: <YxDUlQprVaZp1RF1@nvidia.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
 <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
 <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
 <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com>
 <YxDDD2DF9KFDQ+Yk@nvidia.com>
 <58d14cfc-f8ba-777b-a975-371ff2b29e5a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d14cfc-f8ba-777b-a975-371ff2b29e5a@arm.com>
X-ClientProxiedBy: BL0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:2d::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b8db55-9710-42c1-c6b0-08da8c31960a
X-MS-TrafficTypeDiagnostic: DS7PR12MB6192:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLDuKcZGgCKaWb5kmEoxpJk/HrZBkdOvAW2mkKyuxVD6kg7OKvO4VOL8SHeWBa0vBt3w2R1ovEgvmlmTT6ssX55AOdosXk6B4U3zHa16Eanhr+T3+9b6AUzW2DR4NhlgVDZqkhdBadkRMob5QQ7Ny9hgUPXPjW4s1ebQl9E61CUN+tBaG2LrQ1Xb4xZ8YkmMYF2+aXaoreRGTUF47XlMvDEWBMnOC8vkx8KjqkKrzuHH93uQMQGlzaqxrQUpqub6+lsUyPjV1WsSN55+UvC3RARBO//OL73AxFgiwNF5AvHHzS07JnqeePmHCp+ALdAEOdy8hN+RLIs58VEAfJouiWm23VM39ly4BCdrzZSSgx2FE34E9ZYEW3Ozjv26EDqcz0jtB24UyqcJtr2YE4/m9KSSAjQEZ09hMlu836y0NaSOfRTnTivthzrnEGlW8BOaMth0oIalrpR/EwPiTDQjffZoqKldUuc9B9L71iKgjrnsfEE7kwNvJDYYFPPwTtPTPNzweB8owX+OwnKYbZfoRGUbaCLhA6zMxn0ad66lMtB6nL+iBkYGzrShTeXpOdlzYYLX/n+4e2HknKB7SSuda5jhk3i4DlsELtDJpP2Jzv23HFTZqKaLYTvnUsdt3v+t1rpKNy1BTro2dLlEpLfg9bQod1ZsLZcKbymnwGBoqpBQRtqGASO/qZ3S5dlm4Wnf2EF9ypfOZF1WwyY+3w2AqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(83380400001)(186003)(54906003)(6916009)(5660300002)(316002)(6486002)(6506007)(8936002)(53546011)(2616005)(36756003)(41300700001)(6512007)(2906002)(26005)(86362001)(38100700002)(66556008)(66476007)(478600001)(4326008)(66946007)(7416002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbOt0NAZkUBB/TMJuOu4rvoHr4E+TGJrbwQhi7GSk8RbdH5q0jb/8X8EIKKc?=
 =?us-ascii?Q?xZDm6fM4azNbn6P6Ri+y0IlIpzJGLlVG9NPpsGPgwEc2BVG3TTA+QKRCzTnt?=
 =?us-ascii?Q?M8lefdMIXksJLhJtbEjdjvlcf7TRgFTBCfYnztJySf1wWLzDCs2AN9JiLlqx?=
 =?us-ascii?Q?VXz0UuCxRQ+CfK7RVAZv94kfx/59c0ju9Ij31KgF5tdRhd03DKJN5PBSf/L+?=
 =?us-ascii?Q?8fNDjUzVObhfFdOvB5Yh3CT2iY9uhUngKFWr92jZuXdQjtaD5Tw4KRlQ2fP5?=
 =?us-ascii?Q?OZdeoxMwnESvgd01N0oldPVW5VBYgAna0rvH7+aadZ4ZyVX4AnT8bGt2Ae0R?=
 =?us-ascii?Q?VczjlFUPFOeG9GDbgD72KMihtjZj4JJo/udnaKfuwkrofqCewwbIBL36tLN0?=
 =?us-ascii?Q?BJZ8jPHo45t3oz5I6OfP/gN5jX/wGac/s5YYJwGpf3SL0scgo4mBL+L/gTVk?=
 =?us-ascii?Q?Rc9FmGJUbCVY9f6OUXlDEqqxQZdQzf6l5zbL+7UYtIFugPlX88ElDhthpSQF?=
 =?us-ascii?Q?00OCcBCHZ5Ve+DgUA/29ffCN/cG9pa/9DynuMSEXsCcOKW1Wt3R+S5RWJb01?=
 =?us-ascii?Q?p9jNNQHOWvvf0GJne+Ke2CQFbZe5F+FmNgVtfXsj4//3d2qVdoRnUptQu0kA?=
 =?us-ascii?Q?5z9vCu9ccGfm+v1+M85cQIrdEDDvXeQ8OpCoHwXsnlI2cwWfz2jRqR23Ll+N?=
 =?us-ascii?Q?KlOLXHZsftwmbS+V21wiXpd5LqvRsByDoTadNTy7jbQ2Re7B8X18RLvUHQrs?=
 =?us-ascii?Q?JG/bPs24M4TZdmJPrG4jJ8N6W1u5L2NhAfDBNwFImDwrZt5sMYYg/xGU5PSK?=
 =?us-ascii?Q?pADrRiigFmD71ninzBEx6YvIFyLZW1KFrJu3zKtmTKOdD8Md5/MD4PTngVSI?=
 =?us-ascii?Q?PS/NkC8KqVAHs/lpP6ehH7B/zAxvdEYHIYKtihrAwIPGRlZ8ZzQ7hn+JoHa5?=
 =?us-ascii?Q?tSVBs7p+SZVJkueijR/Lqdw7mNPXe/HKnPtjP5UBs96cmoqZgisA02Qoxkhc?=
 =?us-ascii?Q?Qera6elZfK4eU4ckft/2QJp5zpbsyeSa65ewE4F5SecEda+6MOOFrGzFmdcv?=
 =?us-ascii?Q?tia7NAZU8cDcvEENyAHMy5iuYkLQYtjkO/aU2CihRe8zlCa7YMg5wRUBCqjC?=
 =?us-ascii?Q?s8jKDpvfnzRi8gD86N0q1iQfpsb1xktsilNJ7J3kFt9KdmZwUN1JmNX6qSzr?=
 =?us-ascii?Q?pD6RZv1XWEn6YUECd60gsORYa1GdGj47I/Q0cRMcb2pGMug1rK8bFbxqlZ5E?=
 =?us-ascii?Q?z0fJlPqqgdcRcd6eIuJ1CVqCOibU2bjqFgOVvQfs+wuNeWIr0Wmiy8C3Ll47?=
 =?us-ascii?Q?m76/eRv5ZNb/vc6gM5MA4CKJtrAvzKeasmHAldCXvFC4NcJdIQCeG6bCwR5g?=
 =?us-ascii?Q?cQaI+ini+LIqsNge0n7nwV0WGKE/KjvC44QBIjyAwJcoD3nBM7DduCCxJu5i?=
 =?us-ascii?Q?QPg6ZjkINUF+kQPyBfuPUmiaxT9tD5HihGFP05AZIps8ZNIJA1N/A0KYDQ1t?=
 =?us-ascii?Q?+zxUfjQ2eJ1PIK5hvlUw/LDO1Ur/+k5ItQEuIb1pi1ZvLC43Ugi1YAB04HXJ?=
 =?us-ascii?Q?a1nbWPeBwdQaEh2MrOhEa9ZKmZU3oQn8/qWqhUKx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b8db55-9710-42c1-c6b0-08da8c31960a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 15:49:42.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svOyKjTKnIeEChbrmQAjstmKJH05RQzL0eQ6OEYkHbREK3fCgpy4YMv3ba1Uk2jy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:03:36PM +0100, Robin Murphy wrote:
> On 2022-09-01 15:34, Jason Gunthorpe wrote:
> > On Thu, Sep 01, 2022 at 03:29:16PM +0100, Robin Murphy wrote:
> > 
> > > Right, the next step would be to bridge that gap to iommu-dma to dump the
> > > flush queue when IOVA allocation failure implies we've reached the
> > > "rollover" point, and perhaps not use the timer at all. By that point a
> > > dedicated domain type, or at least some definite internal flag, for this
> > > alternate behaviour seems like the logical way to go.
> > 
> > At least on this direction, I've been thinking it would be nice to
> > replace the domain type _FQ with a flag inside the domain, maybe the
> > ops, saying how the domain wants the common DMA API to operate. If it
> > wants FQ mode or other tuning parameters
> 
> Compare the not-necessarily-obvious matrix of "strict" and "passthrough"
> command-line parameters with the nice understandable kconfig and sysfs
> controls for a reminder of why I moved things *from* that paradigm in the
> first place ;)

I'm looking at it from a code perspective, where the drivers don't
seem to actually care about DMA_FQ. eg search for it in the drivers
and you mostly see:

	    (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_DMA_FQ))

The exception is domain_alloc which fails in cases where the domain
doesn't 'support' FQ.

But support FQ or not can be cast as a simple capability flag in the
domain. We don't need a whole type for the driver to communicate it.

The strictness level belongs completely in the core code, it shouldn't
leak into the driver.

The same general comment seems to be true of IOMMU_DOMAIN_DMA. All the
drivers implement this as an UNMANAGED domain. There are only two
places in the Intel driver that do anything special with DOMAIN_DMA vs
DOMAIN_UNMANAGED (and possibly that is just cruft). So the "does this
support DMA API" is also just a capability flag, and doesn't really
need a whole type.

This is what I mean, not going backwards to the driver specifying
strictness policy.

Jason
