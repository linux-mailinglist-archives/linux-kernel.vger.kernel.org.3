Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385759F00B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHXADI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHXADE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:03:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70530895CB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9/6r2FQ3tv1kH+KkQ0002UODaKscRmh9Bla7FI/9xVj4AGeqALtKPmMHLwyz9IOua0rMWre+5ltJRov5UHRUobsz+iKDCKyMwdVvu8l6oJ3vwT1atk0wm5/Y0TTMfQ7SqmFFA/GcDZl/R+keGLTlagDykdP07Z66/AlvbVLKbGW278mBOwgltAoQ4UkLQkryd1uop35zDY6o1vecpO+RN64MHR0Y2RehIq2MgBb2zblplJCjpsLFxwqywGVg4V+GAUmtbQBGXAJG9QYOnsoEhxTgCQSnW/SuCTPSiHDtPlZiCjcpSRnQm3zuta9EYVu7oqmtLCAVYISU6w9dikNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaUH4+e/VcpFHVKnAbLFYbqSY32nk/kFTx1hA/QQG14=;
 b=XM6wtESWILMK1nweYr8ASUbbo5OagPqopGwExmVRnxz/HI+ZbM7mPjR6Xj7Z7ZJ8NIa5xWWeVRU/E4n8R4rgQ6Ht6P+XyI3PoVeJHjdgWXPH+El/njOh6YGagv3cQdKn97STpAUnRazMqzlDDgUe78i43rBu80wNJrQkHek/1bU3t/pna0fuPmb67lAgeD0l21tREY5wU1fGqMsxnPJccRZTnfhB/MRGbn4846IsFZWo6tpb9yjZIai13uCAVaeFqIEy6KMUworw+TB1JXeFt9P8jn1ppJ7Pw5PjU8yq3g0EokmZ3GDb8jaWJ7Fyv32HrPOFZKWvb2+pMFVquTM45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaUH4+e/VcpFHVKnAbLFYbqSY32nk/kFTx1hA/QQG14=;
 b=jNTjeqq4TnpYF5erJDWjwvUDZZzt1LSZ7nC3Ha5gxSHYYW9ehb2LHmyjq0Y1ubD5XRGgEyrOcCkKGJ9CZYLE4LsGc3/yXtiF0ldjUcie58zThuJPoDql2k1SHpQzsgwZmQoi131xn+x/aNIcReiGn16PAlVu1uQyXb89v+4FdlbFi1Sf2+SytAKClSLTdZt9tzoA1H3soCij1ojC5A8+cmE8CAK8WcQ4a1shu3LaUTVs4gi4SDQovnl94fUM/tOOXQlzekCcXcac75BMyOzMLP5owRJuz7joVeMp6J5LpTo+88/wMwoQxEjfolZAWFyvuy/Q/gQ9j5QRorAi7p0ecQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 00:03:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 00:03:01 +0000
Date:   Tue, 23 Aug 2022 21:02:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Pan@nvidia.com, Xinhui <Xinhui.Pan@amd.com>
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Message-ID: <20220824000259.GA4090@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
 <478c4aba-897f-7e08-1df7-4e296538db9c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478c4aba-897f-7e08-1df7-4e296538db9c@arm.com>
X-ClientProxiedBy: YQBPR0101CA0219.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93fb510f-d5a2-4f80-88c3-08da85640256
X-MS-TrafficTypeDiagnostic: CH2PR12MB3880:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fRMzB5GseNOn0rlDBUoZ9dQyr0FvCFwGmCyxh4aJkb7cGAnj62H6J7XQBDLuw70CFnBvr2ri7Sik6ksVJwyxs4HoBN3mc6PBZhSciUFhYBzvXfT9GLI6OSA63M1Ux2tlYIenGC3l/9Vygi6O6zOb/TLt3N4YCVD8p4o49JTfF/r7mDFKAfnOdPTCb9BzW3m1BVuDE/v/vL1cCPNrHj9E4ekF89LbM6/BafqgMr85MQHgwc3bDriro58wsDtxAin9hD4W3wzSyI7GZOK9i3v+RrJJL7YxC1p4Fu6nqcjqbE4QVCqfgwZ48JpB2UAN5VaVAv54jiecMmRzoSwcfw/To1YC2w+b4D7+m3Lfr99o8lpphkWeCa6TSmJvUS9brQmRPg7545D7OhFFR2fBjbHHM8Ws/mpBMxenOHO6/jX+MGd09grNfDYIz5ASTtmch1LLRJ61XBo7JemVqKLJjA0kQeMJh3pd2Izr6OuQYlLbe3aTjOhgioOCTsv7sTlzLxFqzWcMtS+HuQzks6S8g8ZUu9HwIFeL/7h9HfjJxjd+lSGRee7w4ajnRTD4P1cs6TUxzCTpFq0/EevMZjvnKx7n8ap1uLlHfRU8vazR2sDsWfI8vOYLDGimDmWEosUpAOCQYKcnl95UbLJuZ6LtpJ/3QxISdBYRb+Qu63C13BqLJI1oNNeuspzsrYaGS+hFCugoUddmckPIuGW61vHFUlchYazsKfalRGmB2zbGwoRjJHiirjw5mysmAlUsmNw+Os9P7IhxrmR6hs0lepwDtTm9XYmubKUhN4STL6MH8CCohQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(38100700002)(83380400001)(1076003)(54906003)(8676002)(66946007)(66476007)(66556008)(6916009)(316002)(2906002)(5660300002)(4326008)(8936002)(7416002)(186003)(2616005)(6506007)(6486002)(966005)(26005)(6512007)(478600001)(41300700001)(36756003)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cvmh0X/IKSdJY36lgvi8rABhHItlLlr5QQ6hfi8U0MmUXF4sDy6NOU288bzX?=
 =?us-ascii?Q?iWuLarKUH3iebsxG5oJBrafto5e2q9bAprysQhc7a+zZresf6blDKfslV9Q8?=
 =?us-ascii?Q?kk4rvB5ksOfwUM6SaKmqBlp+39iJ30Kr5z7rv48kxg068tsk8sjSTLsNKMDk?=
 =?us-ascii?Q?ygm0zcn6au9StPLWxx77/ffwODSs3vYoka0R0WQjuM4fnPkRz+5fXoFtAQcq?=
 =?us-ascii?Q?4cJ6FUUgfFX8vuUXdHtBYCpNMes6wnfyqYZpMCSV6xs0CmSf/Zfv4bIJHFVn?=
 =?us-ascii?Q?XiYY0mztQPAApuKapYVJeEKksoAj1VJberM3FF6JYfU4ofpTCb4T050z57B2?=
 =?us-ascii?Q?ASwK1k2NS646/foGX65UkX4ntYyaK8/cnWI9yXiy1psSqiGaEvPkOHNgYP2I?=
 =?us-ascii?Q?99CFm1UCCIUEWzLtbb695d5MACuO7cd3HkJsudDRKKW6fNLNWbIB1K/DAaoj?=
 =?us-ascii?Q?TRnRQSdgyl/kvhxCsstw+r4ahymImUrCyznIx4BViPcknhIrztPbjcy0ZFU4?=
 =?us-ascii?Q?UoyVxflZZSmKZBtrESkW9Y9Zi58EvBlqBdkD/cE7lOQqXbC9z3jGVaudEKPq?=
 =?us-ascii?Q?UzAfZD27V7cEpChuHcWeRwJOW1/1HJ1/aoFrTEFYurb4SeRuaa9GQ0T0nGFm?=
 =?us-ascii?Q?ja6aQFT+fR21BKz1Pq4W+EQrO08vdecxTxN5ARQI7lqCbhTYpVrokUhbiTxe?=
 =?us-ascii?Q?BrseLOugcMrDFdkQImFVkHpxHHFYQ1rOdwUqzuRuDhu/LJQe7YdfROjM0utw?=
 =?us-ascii?Q?U2G9Oervt+UUxnmTnLnguv4sgsFTmdsEDSbRQEsj76xNBV7/YSOwNQbTFqby?=
 =?us-ascii?Q?sW9uPEQT5MDEwQsz5kfvp/asZDbbZVPbbRzx/9LjBGIqmgEnt/gJ21wAPH4w?=
 =?us-ascii?Q?IkEoPMuFO53booM37hB00nDi6Y64bWJ5L9YHiXM+9CnRMWaAsgb9RwUOqJUu?=
 =?us-ascii?Q?36B90DW/49h9boJ+bGaMZwieeMc0eaRIbKkgOnUhmasKMvF+PaKT2+4pInq5?=
 =?us-ascii?Q?fmz8jYqgXOYmpsSZvPYn5Us912W1kR5p3+2vZcTFPF881scKRRhjK8hIFi28?=
 =?us-ascii?Q?Du2OJZXDSf99t1GIgkAH8XfOYAXOrzV4tzPtfG3dpsG4ogxkd5iS0FYpOrAs?=
 =?us-ascii?Q?xsJppzPUuVfdQrfujRtbQngsDCgexoqf1uyIwGTg17WuSGZCNeGBftkJgZ4d?=
 =?us-ascii?Q?5bukqwovFHlCAOzGKuoRkmXNYkzlS+qmLGSaVnUs+09a2fNJW6Zx+698xSFf?=
 =?us-ascii?Q?HlwfmxSz186f4w2QsX8AtI9UgV58GMjVkMAfiWTXq439tzz2qcMkXjhAq7DB?=
 =?us-ascii?Q?2V9+/uF6Bzw8RcLpE0fnGHX0hyjHjqd03O1DJhX8YQigT6SjogAr2wzxPxTd?=
 =?us-ascii?Q?8EgcAvYSRa54py7EZDEG154gy7rorDCDyXAX6EetBxTkwvi9taUq9nOqimP1?=
 =?us-ascii?Q?AoPmAixXYkH8YY/bGMX0iGx/pQeIwrQUmMvC1O+CLX5sm3YWFOfrdkwEKC37?=
 =?us-ascii?Q?gRw4Ju2CT2ZOPXxm1JtcLTFsYA2mNix2JJMu74VWb/EvUw5B1yZUrYLJZeqF?=
 =?us-ascii?Q?g86nxfc0iF+laa8qUjLp+AqpsajbFNUfwJGj6odi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fb510f-d5a2-4f80-88c3-08da85640256
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 00:03:01.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFIXSnwtnG3kFdzKGnoY500bF3YQczLBksV/YeErNR6bdYAr6k+A8uRoJbvQO/bX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 10:01:57PM +0100, Robin Murphy wrote:

> > diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> > index 696d5555be5794..6a1f02c62dffcc 100644
> > --- a/drivers/iommu/amd/iommu_v2.c
> > +++ b/drivers/iommu/amd/iommu_v2.c
> > @@ -777,6 +777,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
> >   	if (dev_state->domain == NULL)
> >   		goto out_free_states;
> > +	/* See iommu_is_default_domain() */
> > +	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
> >   	amd_iommu_domain_direct_map(dev_state->domain);
> 
> Same question as 6 months ago, apparently: allocating an unmanaged domain
> with a pagetable then sucking out the pagetable is silly enough, but if
> we're going to then also call it a proper identity domain, we should really
> just allocate an identity domain directly; but then why not just enable_v2
> on the identity domain that we know is already there courtesy of
> def_domain_type?

Yeah, nobody who knows this code answered that question either..

Looking at it a bit, I think this comment will start to be a problem:

	/*
	 * Save us all sanity checks whether devices already in the
	 * domain support IOMMUv2. Just force that the domain has no
	 * devices attached when it is switched into IOMMUv2 mode.
	 */
	ret = -EBUSY;
	if (domain->dev_cnt > 0 || domain->flags & PD_IOMMUV2_MASK)
		goto out;

Beacuse we should have dev_cnt != 0 on the existing identity domain at
this point - worse if the probe order is backwards the sound driver
may even already be running when we reach this.

Plus the challenge of undoing it when the PASID user goes away.

Overall I can see how it is easier and more logical to transition
between two domains. We already have good infrastructure for doing
that.

From a core perspective I don't have a real problem with iommu drivers
using multiple iommu_domains to manage their internal operations, eg
for different operating modes. But you are right that it should be
cleaner and directly allocate the special domains it needs. This would
be much more self-descriptive if it called a function 'allocate v2
identity domain', for instance.

I think it would also make sense for the core to provide some API to
change the default domain (ie dma API domain) of a group, and that
would be a more logical, and self explanatory, API for iommu drivers
to use than attach/detach. ie:

   iommu_change_default_domain(group, amd_identity_domain_v2):
   iommu_change_default_domain(group, amd_identity_domain_v1):

At least for this effort I wanted something simple enough to backport
that maybe doesn't need to be an expert in the amd iommu to write..
[I checked some more and the hack to change the type looks like it is
OK on the free path, so maybe this even works]

My general hope is that we can convince AMD to work on this once the
generic PASID & PRI series lands, as this entire private path to the
GPU driver and non-standard PASID handling all needs to be aligned
with the upcoming core code. When doing that work it would make sense
to tidy and modernize this better. I added a bunch of AMD people to
this thread to that end. It sure would be good if AMD participated in
that series since they are going to have to use it too.

https://lore.kernel.org/linux-iommu/20220817012024.3251276-1-baolu.lu@linux.intel.com/

Regards,
Jason
