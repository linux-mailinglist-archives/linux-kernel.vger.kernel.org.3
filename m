Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1958928F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiHCTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiHCTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:03:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D8625A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEJoQCbd5uCbVn7WDPiG1raPjaO85yXeEBP5YjBavMg1ssoe5N2nIUTibcYNiYnldCuoYB+44iS0A6+qRhKZEzB6TDIw+b1B6IR6fjK9QV2zvtHx4A+CuJ04HkGH6Mg7OHNm5s5LQbO59WVljfSwdBfxrzQwU5sDgyZfv1ZbG8uKj2M4KpETx5AoXmvmbZQ8kkLPyAk082v+1y8CzV6HqjSU+5q/rbfkUi1+F8qYZP76F4LKtkpFKzmisv8okKUmsbyjlof0ixNMExrI6FiUHKDpo44QD75VxSIKYYnHVzY8a+QwzlkNsanCWTAMTKzBPdxfQk+fBXpp5hp5kjGQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BGCgLYxjcy8Z0DB6kJwVxzDvIfFfatik/juVWBCkd0=;
 b=G8CRDz/pmHetZhutquwd+yLCOT4RaceroaNmt4VPiAZ8oHHV1VAxRO6rX8MpDS6wkKomzOoMF3dOtUipdM+Wx5zXUUzKFk+MJG/olaofuGEZ7gJLlFCsCJmbT0fkFUEGyBwi086nwLMY8h45G9z+KHrrvVO41gzhuRPGlTI2vRBwCUjb4oVg34LGd4w0ASpw95MIB0gBc/NFmdpmYN5lxhiXRqnMedqWajfrlM24N1cgteS42faExtoZc4o0L2cnHEgm5OWdtnFrOvzURfWWl0m04y4muSBp4JZH0VK5pFChLTTz+IF7lPN46yq/l2VOjWWb0s+Lcb3PS3FYvbVzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BGCgLYxjcy8Z0DB6kJwVxzDvIfFfatik/juVWBCkd0=;
 b=TFyZi6MtN6Ab/bx5PvwyZBIVkqQMn5HrAUfqqS3/pZwVLP6bmkuJPCGhQGpTw321TCumYjDkH9VnRw00b4+FKv1UOWQHM9oKymYJzR29dvZZJinN9czBT/V4SrK5w+Jtv2uTnm1V4z4hjzbk58IqMChN7QkJMxbPJLZ9cS/fHbPVjLXX3CHAJtWX/y1lOCKfZuuQRkMEaebAHvJR0Dh7e1dBV4GvJWoXj8BBcDFQk/9/CpDNcxdFz+NkqeLimj1N8Neh6l25vFEl13NUeU+JvJupL7BwEKnwgpvLojtdv77JGrb5DRldATjaUje1vze2QvIAdjKlo2JJ7gy8Cq2mng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 19:03:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 19:03:24 +0000
Date:   Wed, 3 Aug 2022 16:03:23 -0300
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
Message-ID: <YurGexaP/Q+N02dT@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
 <Yukac8X81CP7gDsM@nvidia.com>
 <3eb62531-fa1c-4c78-c1d2-526a3758a033@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb62531-fa1c-4c78-c1d2-526a3758a033@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6dbdd4-c6b6-4f8c-8eb7-08da7582d75a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4nG3Vew/mFcT6L/4GwJKQBHGcly9pi6nvdvRbuSstmbCPCvHKeJakS3/0v4jLSXfwciWAQZ3yN4MxJlYd7XzhgVN8wSYQuAJ5xR2m5O+hGWNz7dxSnFJivmeO1R5/JjYtl6eIj05bYKmGH1THPrzGiCkPUEtcEwT9ChBRIohR52CMCRH1lJv4GneOhJ/QUT2imMnzNimsG3WsyfAJjQ5PVJRbIKfI+uGheyY1U+qvzQ9EC3E6evdD2Ot3RyrerPmPW0lvgYfY7C9obH/18KjOU5OnPiRUZQ7NFfHkrRemsncVrFgwQbYRB51B5/vetldzGaH7+1xF1rN2D7apRYvZPzoI9lZNoHJoVGqbMzsQvKpUDOitJDi70/Zr9C2hkCh0tW8gW44GupVMtdvtkOltbwSv0/JA29drHLIE9ep1hvphB20jrKiLLoaTBSyF27Dz00YNhCZwDAoiqMjxEnztzS5FqlRgWDywkw00PfkWDH1ryYk4l5NenRZW+V9TNJ3qZNoIfWrCFE3dG7N2Xku6lpu9AvXJbLT4K2TEXWQL2lDsJAhLuOJyqaSPraT6IUdYbGPcO4HVPO90hmOJDDG+clXdGDb3EgZg3VDScXupytKd51GeFR7a1WIKFs83jdGttqc3LKtRaBc2k9CYoMxkSsA/Cw3TTYJSnqsWmtuiy1/lLToWVZCQkPItPpqibQWe8LQCMFXWlPrlWjpTA//LFG/3++F+cAJIWivLKIaWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(8676002)(6506007)(66476007)(66946007)(41300700001)(6512007)(26005)(6486002)(2906002)(7416002)(4326008)(66556008)(36756003)(5660300002)(8936002)(6916009)(54906003)(316002)(86362001)(478600001)(186003)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMb4Fh77un6R5LVNq/M6+StWq1I9oRKFSNWkQjR1hCA9bN++2RVLrxPZztMe?=
 =?us-ascii?Q?StmHoDkcbkid2XmbIA/3Fx2hD8btFRREHTQew0QaunRiZrOgL11oASom/7g/?=
 =?us-ascii?Q?n5KOzzd9SG+dFH2GBN6HbIRhIUOaYCRyNxaRPG9U33V2wTVT9kMJjzRR3W3G?=
 =?us-ascii?Q?EITeJkJ/LxAEcSfed5HiuTkBXBYiF1LMUaPkR66M1cRp1GY4lFSmUEkw82+o?=
 =?us-ascii?Q?gPRkER/KfrYlsKFXGIblml+oGpKfUOsQ9wpXMaSf9jSfBiasBpzI/+oxs12q?=
 =?us-ascii?Q?CyxMfmUqjPWrqqJvkOTTMqe5MGRctwFLxZKU9UTZNzYiw0/lDHvvvAilrtcT?=
 =?us-ascii?Q?CXpCBr/bUA4N2NsMS6Fw5Ta/EJhZHOYXWw+XhwMlO7hFO+0ImPEeugLIoZcZ?=
 =?us-ascii?Q?oE9LxfX4ArynFgieoZkUAdrKHEQOQ7PwlaXGldH1mtZQH1uVIzfWGO5o11l3?=
 =?us-ascii?Q?XcdhbLZRlSgOxfBNryVfyouiu1+m78MLfFiWGVX/KLai3thyBEv5nmPJAmtK?=
 =?us-ascii?Q?tf27cc6car5wt7znJS51e+v+TqS4P0heJdkOIRl/22/tLAbPDQtdIygx5NiT?=
 =?us-ascii?Q?gm4expOle/m5iw+/V/N4c9rEZI9yDsm/UbV8aU1s4jNYM8Bf8IGtihlIADDU?=
 =?us-ascii?Q?3vRhvN79RtrhXjAcnxYMN5uSlvLLfFPNXbBQP9BFyQllD/NaLJDMs6wMi10O?=
 =?us-ascii?Q?ulLUwPdOeS1Vatz2qC7FyP3bBy6aBnO3kmW/PaQLBj5Pda/Inp1afgLpaK+E?=
 =?us-ascii?Q?vXbSP4ryR3hxw0nx+C/SqsRCwRZvTsHCnpd8ub624AhMpxISFkjFWW3WPqNT?=
 =?us-ascii?Q?veFHTf8V+/3uxppIDBeONhGVXF/4bwFW4ygutk62XPCuhUjCkdIsmDlmqfhO?=
 =?us-ascii?Q?FB/JxMDtzJolXjTzoMAnm7akUth9oajKC6jqkvw8WrZXgYt3riNKE/A3uSp8?=
 =?us-ascii?Q?iv6xMJ38F5JqXOvnx1UGzZEIIQ+Lnz9JMeifzcc8hyXYyXvCplx2Fx3Q8m6S?=
 =?us-ascii?Q?xK7PmvsQHiJS25UoWhN7tgm+o7kHF+w4/mk3E67KM23fkJLgkPxZ+EdzH64R?=
 =?us-ascii?Q?ZO/8ECA6qnQuQdAT17xtPh7rxmdO5h1/gp0Tn+ZDk7WNvVeBnB1I3Dgs86+e?=
 =?us-ascii?Q?hsygYQ142arrZyxuAQHG4a5iXCvrl6EdPwQPXvZB6mvnBFgm2I35mmX0+zX8?=
 =?us-ascii?Q?3ooI9SZs7KC8LDkTSDOToeQ0FQzH+ILzy12sreWlt0frMHhNPMjCDa00PPNF?=
 =?us-ascii?Q?zj9KN6iX9J7qzC2FPx5bb6Yfv6pO5AbJgSskcdGlVZAjwgL3lgqdRgavT24b?=
 =?us-ascii?Q?Sq4cNaFRWRhWPIze13tUXiZ5JxSgwvDeXb+N7Aa1JMow1kyji9j5ymFWFEQv?=
 =?us-ascii?Q?ox2OiKtj3o+o6MaZG8jkK7SxB52aq9+9uZxnJjdUqBPvNiV2mo6WyxUwMgbI?=
 =?us-ascii?Q?lF7JdVKyDWejX5VyhZEeGnD6M1tCV0TX7IZcz0VvEotc1pblBXOFz+s2g8Xl?=
 =?us-ascii?Q?HwtNU9QKS4GihShaz1zgUFpuXe20JzFHg+5ZT4oxJL1xnu+fysTV1m7TCuXH?=
 =?us-ascii?Q?KwHzT5/vwvoyT85cHpY0yaYROVMinuP794t82mDp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6dbdd4-c6b6-4f8c-8eb7-08da7582d75a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 19:03:24.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw7K5nkwWSuNHKuk8Huy30PchL35fPFJWnnR4JLgXNhRQCVTFxC76qb/OnMmdPZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:07:35PM +0800, Baolu Lu wrote:
> +/**
> + * iommu_device_claim_pasid_owner() - Set ownership of a pasid on device
> + * @dev: the device.
> + * @pasid: the pasid of the device.
> + * @owner: caller specified pointer. Used for exclusive ownership.
> + *
> + * Return 0 if it is allowed, otherwise an error.
> + */
> +int iommu_device_claim_pasid_owner(struct device *dev, ioasid_t pasid, void
> *owner)

I don't see a use case for a special "pasid owner"

PASID is no different from normal DMA. If the calling driver already
has the proper ownership of the device/group then it is fine for that
driver to use any kind of IOMMU attachment, RID, PASID, whatever. It
doesn't matter *how* the attachment is made.

Remember the series that got dropped about converting all the drivers
to the new ownership scheme? That is how it should work - owernship
and domain attach are two different operations and do not get mixed
confusingly together. (and are you going to repost that series? It
would be great to get it done)

Jason
