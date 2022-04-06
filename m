Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961D64F6583
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiDFQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiDFQm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:42:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E90312151
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUJGi8jCO1ud5bZQp2EBg04Q3+uWbAlOFU7G5a0aGeqCCws0/vRHGMcc753od+hsUYNTgsKejHgfkgR5duRKPWL2kvvnXfBmHrniMctYL6kmDVjfqfeOc2JnkO7PvD95aSp/ZkcgWSp7Yge/BrOTBBnIUx7sEFmZmmbyUGkyBbhX0aK6Nr+OYUPv74YfQyzHffFfjcmP7yztz6gs2YJmYzD5I3oKmtLBJlmnEDkyPHRxH22kiNP1ZQFJdF7X3xLXnrjicJVrpB1l4E4LljBL8L8ypoCCZzEnub8j65k9wkUf6NAIxA123DKWsox9yQ0m2CcfyZtGAQsFg45SDJFz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDhN0FPhMeObVac6cPS2p1KESO1mI0eIHt4wWyIJP9M=;
 b=XS77G+nAmA1j20syJxgmUdaAQnYng2FZnHrbK0agGLCtKU/PS2WXKHMPpKe3AOTRaIudhoFPZ6poKbJ8PXIZ9rnnqATrFU/SRrFOdmnegSu+7ecQ8OtVZu532lDgtinwb6B6+bahX4izb/+cF4VhVkmeu0JG4N7V7womaP2qEUTbWy7ZgljH79bBBuCADU1zQBjkpApjsJaXR6HOmrsWdoCVhN843mNbAVBY3bmsawkrdLZLj8WxmhteF8hHA2dtwLMAvZzJfdkyKKPCL+fHcCExqt+iGCMNU22MRZ81tpSIjpxCmRe7trYf1ChkjEt7IcW+q/4tDzKePsQR+6sMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDhN0FPhMeObVac6cPS2p1KESO1mI0eIHt4wWyIJP9M=;
 b=rZCaC62iJB6E2oZjhsIEwjhrWjtvqpTZtEITLwZ3YDs+if1+pcZvm14SzkWz81tUCqE8D1ciDJdR0+0U0Uw/SWrLi6BUhoQ22hPfJCu2NiIS8ET2sHHbhYONFRl0gTUAvMWS/u0dPg1UkcQ/kCUXQ/7Um90QmRhCzXBGtQ/a5d7kdYwtctOpEhwnX9ZQypclJaVdePPYzWS9hEazqUj0Ta9ENbejcNUmm9+er1aYGEOIyJJFJLPcn7KBuimfRhdBmJYhREonkWRVRs9/B/LjSHcZeqEvFyhnnx7Yra2iKKNkLiw4eAgOpbPhuqGlY1GCf2kk1fg5/r1UG/xXdiglKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 14:01:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 14:01:45 +0000
Date:   Wed, 6 Apr 2022 11:01:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Message-ID: <20220406140144.GD2120790@nvidia.com>
References: <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
 <20220406130614.GC2120790@nvidia.com>
 <b7639218-2d10-fd71-0f4b-3af3f8fa224b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7639218-2d10-fd71-0f4b-3af3f8fa224b@arm.com>
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41368b38-ffca-4814-a3cd-08da17d5fc4c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4967:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4967736DC246A24A2E10675AC2E79@BY5PR12MB4967.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bneYUgc1o8GQNIvmQ3wtyUcGFPLgNm0pcws/bDkfdvJaC2hv/lxgWyK5XeOhjiD6/fZkfBVj3CDFrSRcxRrWt5rZMe9N/ighl4UdeLoiV+rNmcTvj/4S8OhqVh+R3cApdboG4RqBwEGLdnhBTkJcFf3/bjoKw0E8Rik/XeQZkt1WTm+4Jh11k8KbEG+JVDeO1VQm/RyMKZxB5/zHBrZKhZc5kK4KwfMjKR+kr5H7P2OAJJOs1sWZ5KTbIBzxMzbBDWEgHUHfEgZHLBc1Gowk4JC1PvTgCGwL+axVkVdLvfTVV9kdqs5v3cJB4Wdi8pfqG9ajjjg5s4kuRhPpvWzEnrdbLXevlD0W1Uvj8LCqdGvjZJlk/250jDAdf3Nlip1b6gWyAEq7cGLNfS0hSUiubWNilYhhIoGd5EMfImGh55o/g3zvj6ElQsEYxLUDFe6JWpSrf3VbhBfv09+EMOQ2WafkCLGz33FpQCq/vz7ygvrSEJeei6qKCHrMh7YUrN2MN4LfjfBqgM8qR5pTZBfDgWR2deecJJMwpnMNcBkQEezypl+P5iH8Eszz08KyvnxlINsbnvasLaMi9JR3jfqLaJywoPf3K9Cb70Pqtx+86NGA51n1Na4/uUXfnUQNtNZshObHzn75+WRp306TdzyQJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6506007)(53546011)(6512007)(2616005)(186003)(1076003)(26005)(8936002)(7416002)(38100700002)(36756003)(4326008)(8676002)(5660300002)(2906002)(316002)(6916009)(508600001)(54906003)(6486002)(86362001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/pm3d3X8D87CVeRh3HS9rvOtZ2GmS0aczeYSOarKE+VQgTqna2jk5LN9aK53?=
 =?us-ascii?Q?+4xRvxcjgU9QdftvL/41Ghv1HnYnfo8CLB5UGRzBnb2oLDU92GWgOjGw1472?=
 =?us-ascii?Q?HLj1M40r3skDeY8R8D4qOqxyv1pmJWj6g+hEPQrusS07VwdflzY3YfMSfq37?=
 =?us-ascii?Q?DFSxuZ87ufiBAdJlXk2OyZ22OsEtQyFIvQ6nBAjHQ9BQVIBYXu1YhuYbyZo6?=
 =?us-ascii?Q?LI+5e21SPBRaTLSfoiWdvh1PhDy6mVRDXoit3Y50K1GhJA97af4r15HLBmsM?=
 =?us-ascii?Q?sFtQ++YDcw27u1xWNUC9Evsk20PeF6fO4Etg7UDLrJ3EOItmSnYc8NWJT9nG?=
 =?us-ascii?Q?lV4+LMinVMowknu/zSHO6omNBPtcKLA4wYCXVHeZBfqOEYNkNOAf5sCTFPi2?=
 =?us-ascii?Q?4X6zl39lP7wD44bg8fZ4q4Ht9J1kgC+/IGKKupWEHOL5IeCKi61B/HWcuehW?=
 =?us-ascii?Q?6ZZZTZlMQMFwMVpS4fydzMVSmEGrpZEpuWM3fE5GLwL4GczwQJxoX5JpvLQI?=
 =?us-ascii?Q?vnklbWk8Jh/0PXrqa1RxE/RAa46gfaM5rLsckQgE+z7Q1xdFigkvR3s3Q3Uq?=
 =?us-ascii?Q?jBNJbggVZ26QX37CjNe9RpOimm5eXLXfvNiDQ+1LhSb3BVvNQdtpK+QBUmF+?=
 =?us-ascii?Q?CELiw/Cdv2MlSXkc4Im0Gjhcboj6YBhKEk0WkS0RupVDs4e+bufysNKmtEa/?=
 =?us-ascii?Q?jFvkWSXi2vdJTj3hA1M3dvQJUDQ40HwGb9qOilOO+HhVTUx9p08s5YtK8T44?=
 =?us-ascii?Q?rJCqBj7T0L2kG+SrONuUoDWeNiyrhA9LFHYTh45xWRfkGDHd1dsWUNKsA8vy?=
 =?us-ascii?Q?e4LwaQEo8MVOr/92VpaSml64eO9zcZ6TRW7oZOit40gH6KXPxSqj0MeoFUJG?=
 =?us-ascii?Q?4Ytot/sX5a0q/eg5rpHiUvzUY2wlV3IUdN2wVKI94W7ISg3xZA9y2JbksyF5?=
 =?us-ascii?Q?ner3y3UsGEKiFl2YQjJMQ0/lv7VGo3oyI/OeEPH30VCtQ6o4pMOtRa71fkxh?=
 =?us-ascii?Q?cbq4m5AMJi6JyO5h2ZWTbz3gqUyo4hSt/Btawr+87nidnZnrRkBBwhxJRSnJ?=
 =?us-ascii?Q?x478tNqd6NVAjvXjcygqrrHRCLa8E67TAdJfHUg0twUac6cPhqHiuCUNl+QR?=
 =?us-ascii?Q?aFJlCs2hVIYedkMPqhi18tDl5oXZsZHDZpPqzCzF1MQgdzdCztbLrYFhAzrE?=
 =?us-ascii?Q?mikoZa2RWkYJHIaQokCiyvUCx6dznZPUXdqFRC+3dCIZ9LBQFp4R3Wc3N5ui?=
 =?us-ascii?Q?B/CvwcBmjTQ+sZTj4JULstJN1+zMbW2eWcz7m1L3Cx8uJ2sxGuZY6xRPGHFW?=
 =?us-ascii?Q?TlGD0EBCEhkk3+0TqXY4wHdjtoaFfufMqB71WbU30JAIth4TcXZO4Zg/mtPO?=
 =?us-ascii?Q?28mfd0cxuskGiRes14qztuoW+Putl2K5fdtMfRBq4nUwvr5NP7+MB0FTPmxj?=
 =?us-ascii?Q?ykY1qFm5pU/eeLo8FLbMCAO60aaY20ypGtNCkniGMAWQvsTt1gtPP97XvhrC?=
 =?us-ascii?Q?Ah1A/jpDU5iyduKuG3xXH3eovFb7CqgvsvFkUtmq3Usvzt5P4jOEEZhy7yf9?=
 =?us-ascii?Q?mKzBkOgMN2RXwxRdlxrm2Hdi9L8YsWveb6HaeP23njyboDDvizr4QtXoY1fx?=
 =?us-ascii?Q?rMiFiHgZGjHymVmhiOz/46Nwb2JZQfuXAl50O3huQs7TOrFFn9gJj4bu/+qy?=
 =?us-ascii?Q?7Zg4tJ+yYW/nHLa5gAGEhDp3VrlPFuTxR6+mrJ6T9q9GgLr2Uzk4GP80o6sr?=
 =?us-ascii?Q?AKyfBsh6Pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41368b38-ffca-4814-a3cd-08da17d5fc4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 14:01:45.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yPXeYD5nGVqu3vIlVZNNPrSa+fTzlrV9fUkbIUIRCj8wWcPgQpw804nI1jo3mrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:37:40PM +0100, Robin Murphy wrote:
> On 2022-04-06 14:06, Jason Gunthorpe wrote:
> > On Wed, Apr 06, 2022 at 01:32:07PM +0100, Robin Murphy wrote:
> > > a particular IOMMU instance, and potentially allocate separate domains for
> > > separate devices to represent the same address space, much like
> > > vfio_iommu_type1_attach_group() does.
> > 
> > I think this VFIO code also needs some more work, it currently assumes
> > that if the domain ops are the same then the domains are compatible,
> > and that is not true for ARM SMMU drivers.
> 
> Well, strictly it uses the ops as a "negative" heuristic that the domains
> are not definitely incompatible, and only then consolidates domains if
> cross-attaching actually succeeds. So I don't think it's really so bad.

Oh that is sneaky, I didn't appreciate that bit of logic..

> > I've been thinking of adding a domain callback 'can device attach' and
> > replacing the ops compare with that instead.
> 
> Previous comment notwithstanding, much as I do tend to prefer "just try the
> operation and see what happens" APIs, that might be more reliable in the
> long run than trying to encode specific "sorry, you'll need to allocate a
> separate domain for this device" vs. "this should have worked but something
> went wrong" semantics in the return value from attach.

Overall the way vfio is doing this has alot of overhead. Not only does
it create a domain it may not use it also does this:

			iommu_detach_group(domain->domain, group->iommu_group);
			if (!iommu_attach_group(d->domain,
						group->iommu_group)) {
				list_add(&group->next, &d->group_list);
				iommu_domain_free(domain->domain);
				kfree(domain);
				goto done;
			}

			ret = iommu_attach_group(domain->domain,
						 group->iommu_group);

So, if we already have a compatible domain VFIO does an extra domain
alloc/dealloc and 3 extra attach/detatches per domain it tests.

It is not very elegant at least..

> > > It's not really worth IOMMU drivers trying to support a domain spanning
> > > potentially-heterogeneous instances internally, since they can't reasonably
> > > know what matters in any particular situation.
> > 
> > In the long run I think it will be worth optimizing. If the SMMU
> > instances can share IOPTE memory then we get two wins - memory
> > reduction and reduced work to read dirty bits.
> > 
> > The dirty read in particular is very performance sensitive so if real
> > work loads have many SMMUs per VM it will become a pain point.
> 
> In the ideal case though, the SVA domains are only there to logically bridge
> between an existing process pagetable and IOMMU instances at the API level,
> right? Surely if we're shadowing physical pagetables for SVA we've basically
> already lost the performance game?

Sorry, I was not talking about SVA with that remark, speaking
generally about normal iommu_domains and sharing between SMMU
instances.

For SVA I see no issue with duplicating it per instance since it is
very small/etc - the only drawback is that the common code has to do
the 'can device attach' dance and keep a domain list per
mm-struct. Which seems OK to me.

Jason
