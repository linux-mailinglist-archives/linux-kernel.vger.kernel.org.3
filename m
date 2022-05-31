Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D25399F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348623AbiEaXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiEaXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:11:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE85005A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsvUes3r403UEXNx0HEr5c4e1gjolh9GgNL2RdoXgi9NRuJBEDJAf0Tm2NvKykl7QfMDETYwLnTsl/DGR63hHat7XNi5UwS1X8kpt43VvjArMmxKFMZPe81+5NkLT5UKbuvpVM19FxZc0VZV3vrzFg98/KxQI2IAzeVwHLmBv7q9/udC/lNb5JHAUjlWMXVEUMVrckqtG4yLoHXDczPIVt/tPX1WkPBolGUSSrjM1ItqlTGfbCJZVqR0e+82i6bTexT7Atkgfct3KoeyodWMhnejCgKdqlaIs6XvocfsbQ2/FTxjVZ6hddgYSZ+u3FAs7YJPnv0rfoK9LW9MFMQj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e47f95y4ilbc95kRfoSoALJPFy0RXOfvHIW+7lJs44o=;
 b=So2pZlppSnHkrwh3FqgExC9/aZnxTdVXglDy6R8+oxD43efWkZg0wqci4ApjE1zWoUOn1Ps4/bRhxJjPxT+mLVEaHQW4I2G8ugZ7aVX1WTWAB3TDiCHklOT0aqmQ46lSKpEX8564TZuHntDHCyYzMimGph+v4rjo4pM/Y41lbSuWb5pYEbDasb6v4Fj+2cmqFf6ee807mUmfNrsZdx7PGrY4MgAuFgDCFu1H0giCSiSfA1MaR/j02F9FBLbcOUOMzpNLxDywyKg70p475JVcPR5aank2U5U4572AxQJk/f8uwIc7zRZm54tr4Nb/dvAEWs5splauGCtPSdFBUP3y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e47f95y4ilbc95kRfoSoALJPFy0RXOfvHIW+7lJs44o=;
 b=KAr+swBerJVn8lQX0ObCceoW+V/SjWtj11cSKMCRf1JG3mR44LnEVPClW8kigCbJQjdbTdPyIZ/lZ1bbEeIFi9VfUP0jltdVN2+KztVPN41PCL7it7DTxt7BPedOk9y/mTY6LgtI79ewznpWcK3/MbVD7XWlIWIPHrAD37PGeTC2ms8LAwnO3lCKy4GQuR6u0Oo+Zuu1rfvByEqRyAmtlE2Fj7mQ+y4IJJlIcK3O0cexIN4OH0gj+9+42OdH+nekhXp6hlBsLIsMvC+7qvDAOnEJB+EwvdbU74tT+z8EzaL2uFuNH6zufQiFa/Fq7L4Qj7TGYdYIFvJleEqmYeCjNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 23:10:57 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 23:10:56 +0000
Date:   Tue, 31 May 2022 20:10:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531231039.GO1343366@nvidia.com>
References: <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
 <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
 <20220531162152.GH1343366@nvidia.com>
 <10f16c13-c50d-892c-a20d-979b2135c953@arm.com>
 <20220531185110.GJ1343366@nvidia.com>
 <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bbbad7-bcba-a440-692b-64e50b4eddf8@arm.com>
X-ClientProxiedBy: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6345cb38-141b-4ca0-9b97-08da435ac832
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3106AD33FF2EBCF926845A81C2DC9@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxOWHxPC/n23WssJ59vLeSjOiPlkH6vPjTB1vjUiQTNMVq7dmosQQufa27pp2wNRYmB/A/bpBPIYn9RG+yVnKQU97baYxmymM8nOg7hYlKClyYy8UWl/GEn4MXn8vJ+AwjgBOvf668Bmfdk+yj+L1NWp6YtrHFQ2hQvI4wjjUsYbp83TYSoOwU3H1vhQW5GZ53aV6Ma/w+aiiKLXKfKBbZGYFl73Jwz8UBq2EkGTmwVTZcEXX+f+gQRuADjWWx9mgNXLspFJrQJXypPKh/IepJOrZFwBrLPIuFpFlr0igSnSDWi9SudfEqNtSzPPzP/evVmoU+Uasy2SYg++AFtZQvUJmUPrdVP38mul54DLJPm+wH2ya2g/ebWkCmG483pV9KnisDvJqZyVnHSjGpTt4jJWU5L0Q8RDs9EB+Xnt3U8csb2TD5ISMgK4Tnoq7nbLVAt0Q0+zq/EwB1L5ckKV9BLmFtLXn/70O/dfXq6WLozhTVIeiUhQYGc6WI0e6AewXdCGzZYBrb59Z02yvcIR9D9aSCT/mZKYEC/kbViIcH7RJ6f1ovXO9g7zpEiAtFwWb8qNkolAYEw4WVgPlhc/m6SQGqibTzd7yPtSoRWpgtk/aKxoTL5nIE8q8E1tYVZHK1ogxL15ZiDm4QcGQgVjGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6666004)(26005)(2906002)(6512007)(508600001)(7416002)(1076003)(186003)(8936002)(86362001)(2616005)(6506007)(83380400001)(5660300002)(38100700002)(36756003)(6486002)(110136005)(54906003)(316002)(4326008)(66556008)(66476007)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8O7PsQw62j1PU5gEZo6eaNjft95+L07qgDblrd6oHAWiIW+/gjeHGC0qILu?=
 =?us-ascii?Q?R8ivHe4b+Z1J8IEQvwcGSDcO72C8DUOzX97mJfKKXKg9IGbERoqYmvzPW6UJ?=
 =?us-ascii?Q?sqvZaCgR/D53OPNK6WbseYosXMcyrE6tO2Yr3uEiwGT7r8RYPZfVS9otEduh?=
 =?us-ascii?Q?FqEb4UVyMtKR7w8EVHZ82yB+PRch7Eu6asihQx5CLrIagOxjFjm1T59tv8Gc?=
 =?us-ascii?Q?SmsKNgWNThBVNnznygjtxSdnTMpKiteovCz9LcU7OQ1znQkEAj8DBXnQ0VAN?=
 =?us-ascii?Q?OyvxXnLUebil+s8ZqVY1jwabblBQZq0vjgSioaZXMQPDEqXvONhoEg8gxeV8?=
 =?us-ascii?Q?PSQsE7Kz/6K0w7AYhSHfjSKJw5vzbM640krFy/5XuJ05CcrfQo/CEgTOx4XT?=
 =?us-ascii?Q?raX/SmIejj6b59iic9O34ujFrtXvgnHnRj73rACVM2cgE6zIZBmR1SWj5e7l?=
 =?us-ascii?Q?7VlI6ygs4tgcsEEZlCkpMORSYH5Jcmgb4J7crcoBP3+tonUdyKp9KyIgszDO?=
 =?us-ascii?Q?ELrIyF6QydizwAGa+0ZTZrZ3A6Mrh13V/5fkvRrWGzulrwl4Q9RCA30GLjuR?=
 =?us-ascii?Q?gBD71SkR8VpkpN07T3BjF8HyFbHOQTjhAwxwAHHA0hTixFPQc5RCrOoU5kGo?=
 =?us-ascii?Q?K9seOFx880OWRxTSdquj8TGeVBU2E08n2FoOPcbmDmomlQszstOfC0h7UvUx?=
 =?us-ascii?Q?TkEmbeTCwG60LGdXn//8vtfGcz3K9N9g8Sa78Wg1G+9GXZYIObbfWfYxNIfC?=
 =?us-ascii?Q?WG0e6GsZiJIqiWVnfccu/Zt3zSG96qfN3JFJEkzzuCaJ80sN51N1AQsfX9ek?=
 =?us-ascii?Q?VVcOtcpZ7InuPnw3SaWpkEsh8T452jDye8xnBaCiVspWYowrP97CpJ1Jg80W?=
 =?us-ascii?Q?kH6AYMoBJuGbg+zQn41SwPQ2GJj/FpM7+hmgTbg7pXbJEdCk3XAJbnr3xFXm?=
 =?us-ascii?Q?HuMXwP5YdejVXR2M0WSE6QX5YCx9TmdzLipY33Ol3F5n+GVxEbgmLiyqO6Sy?=
 =?us-ascii?Q?H+11feezj7Y7Wao0jRRVHMfLwDvzBxMgEZRMhyUtPlkUHfB1k1eejDM0o9qs?=
 =?us-ascii?Q?qre1uHoGdLbJS3q/UmdnxM8Y6r3iOmygKraJkyqUHl9PALf+WlXhxKy67gEz?=
 =?us-ascii?Q?0Mh1po5mgV4rqkEdl8KD1Vw6U9GYwUJIZgA2iBtqy62vaXGIqw9lzimrY31z?=
 =?us-ascii?Q?QxfFanWVhP9agDeC3lQZjdjNBYqr0H+OIT4Ys3UIAT9ahlgffrOnxuJNfC2n?=
 =?us-ascii?Q?RVTjJ2AAKgW3OxUTOYWDqX9VQhpkbwvVGnjZYdH7/PdzLxFqy/F1zeT0+nOs?=
 =?us-ascii?Q?zYtIyS6CjKuclWkifZs0pdc8rx431ZRDB59p71WspfzI3YgMyeqXtu5gDp/3?=
 =?us-ascii?Q?r9CqOS9tFpIJjHN23aEDeBObQk91+cF36NTZAVX4yIy9gozXzD83/8o7gEVg?=
 =?us-ascii?Q?oXg31ZZOcze6SRNHNb3E6wEH36ymyeFyHzM3h8xUySz6hkt4i7sOorZBT0ka?=
 =?us-ascii?Q?PJwpabVSa7KIw96cxJtTcTG+9P2xXtuDotMWKjbPJJd9WCIgL+/ChU+LvMxk?=
 =?us-ascii?Q?XhK1SI8HBVOuEQ36+l1gH/LjkLOftzs8JZH6yfnIPt56NCs9JSEj9nPl1FzZ?=
 =?us-ascii?Q?2yogyHrvCqzMaN+nF0cKwAR+lnfe5cauwDV7ZQNlHF1OQyt3/oC9teT/my3H?=
 =?us-ascii?Q?XRkTOc2rY0oAEfFGyGfME40ToG6FT9CVja2bCk2LbX8uvQMF1uqt5RsY7J20?=
 =?us-ascii?Q?en4xVvQS+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6345cb38-141b-4ca0-9b97-08da435ac832
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:10:56.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NVe2dx0W2ngZl0eUVgiFqwTr4z8ODNe2yIL33R+gAONEUMZIMwqpNsJmGo5CFTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 10:22:32PM +0100, Robin Murphy wrote:

> There are only 3 instances where we'll free a table while the domain is
> live. The first is the one legitimate race condition, where two map requests
> targeting relatively nearby PTEs both go to fill in an intermediate level of
> table; whoever loses that race frees the table they allocated, but it was
> never visible to anyone else so that's definitely fine. The second is if
> we're mapping a block entry, and find that there's already a table entry
> there, wherein we assume the table must be empty, clear the entry,
> invalidate any walk caches, install the block entry, then free the orphaned
> table; since we're mapping the entire IOVA range covered by that table,
> there should be no other operations on that IOVA range attempting to walk
> the table at the same time, so it's fine. 

I saw these two in the Intel driver

> The third is effectively the inverse, if we get a block-sized unmap
> but find a table entry rather than a block at that point (on the
> assumption that it's de-facto allowed for a single unmap to cover
> multiple adjacent mappings as long as it does so exactly); similarly
> we assume that the table must be full, and no other operations
> should be racing because we're unmapping its whole IOVA range, so we
> remove the table entry, invalidate, and free as before.

Not sure I noticed this one though

This all it all makes sense though.

> Although we don't have debug dumping for io-pgtable-arm, it's good to be
> thinking about this, since it's made me realise that dirty-tracking sweeps
> per that proposal might pose a similar kind of concern, so we might still
> need to harden these corners for the sake of that.

Lets make sure Joao sees this..

It is interesting because we probably don't want the big latency
spikes that would come from using locking to block map/unmap while
dirty reading is happening - eg at the iommfd level.

From a consistency POV the only case that matters is unmap and unmap
should already be doing a dedicated dirty read directly prior to the
unmap (as per that other long thread)

So having safe racy reading in the kernel is probably best, and so RCU
would be good here too.

> that somewhere I have some half-finished patches making io-pgtable-arm use
> the iommu_iotlb_gather freelist, so maybe I'll tackle both concerns at once
> (perhaps we might even be able to RCU-ify the freelist generically? I'll see
> how it goes when I get there).

This is all very similar to how the mm's tlb gather stuff works,
especially on PPC which requires RCU protection of page tables instead
of the IPI trick.

Currently the rcu_head and the lru overlap in the struct page. To do
this I'd suggest following what was done for slab - see ca1a46d6f506
("Merge tag 'slab-for-5.17'..) and create a 'struct page' sub-class
like 'struct slab' for use with iommu page tables and put the
list_head and rcu_head sequentially in the struct iommu_pt_page.

Continue to use put_pages_list() just with the list_head in the new
struct not the lru.

If we need it for dirty tracking then it makes sense to start
progressing parts at least..

Jason
