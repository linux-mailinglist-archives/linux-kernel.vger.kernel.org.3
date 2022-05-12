Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46BC524C18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353445AbiELLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353434AbiELLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:48:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936466160F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9E3bDf1md3mWiOVqKQMDFTXz6xi6GRADCKP8av/qQpfWD13wQXDiJQ3U/nh5HGW7T8Ng/4LPya1XDjGEWnF08R76ySxmv/oyQcCNoj5/QZuHbto6IsgiytV7nBpRtv+Vsph+XwQK9909G4IsAEM4NQbdgBmaHTgBQNMIPZ6ggp66V2Ov0aqUl2Z+K+zH+ynjYovkYMmtZqSUjjg4puRA5YpIFyNZmZ53sMr1MG4DsosZVCAaExII3XPx1Vepzbc3KOl6W9SOs/meeve2+jcLgVrQeYDLY5dj/kyc4fm9waEpy7Vx/kH3vMTRUOoZ38Glpueok0aBWGAIsp4GMDwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+VYzlcmnpOLLF5ggAMk+8wRfHOAhBwLATLAFuPFXpY=;
 b=DAnt71sfRjaZWJqd5l0Qz5AZlOyV+YFOtu9Ob0MkTVtDatdRRNL+KtF783RvMRwUxPvgQIJ8AD7fqteHfsnpLprI6Re8oYtcTQhAxte7snEiR5NdfRlpkjJfojH5SUWeA/n1hkg7dHxv2Hu+ZgN8fWgMIe2Nups0ob30Ce8pPOkyo0dRem3/2cmk/qizPzhhHIMqYePvxHgML+pZzOLFyQOuc6RxcCnvajZIpXIALROl2UTiHmLOYy75YdoThk9p04VIH4icuUDYCWraJZOSxcFnSu5aqo9iF837wB11E1b72GGrI0wx2lgg0Y3qLSso6xLCgJS/htg1yxWQxDG9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+VYzlcmnpOLLF5ggAMk+8wRfHOAhBwLATLAFuPFXpY=;
 b=ONhlOYac+erfbrb5oAwC1YArM7Ab1bxVk+5KHs3xS8s1yrYpbs+39KHVXecYdqflp7U83M5NcWUqdXeQGtKGTJu7dPA+x1rWXeWvyUyBBwvVzdYxL37Z3EoxBrJ5ETHVS/JCZCCTzzyp6KlzJg0WE2FbSAu15etpp4KfD6PpUxhb1oUZdwM7QXfdvFsyG4UoROOjZ/FZf83UaoA/Y3jrbOMdHY7LZpsmE1PHKB5RjVzK0ZGS4ER7JVS/x8hAI2+Whin6giYgz24oD1Nzmq5JLpdrU3Q2CYUhlJ0HHx4ljYdkO7ba2G1bA/R9thqj1dyhMYemz7Xf1pJgWLdsf7+G3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 11:48:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:48:46 +0000
Date:   Thu, 12 May 2022 08:48:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220512114844.GT49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:c0::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 583bd338-4caa-4fdf-75d6-08da340d5eea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1578:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1578489223E55E5AA9063889C2CB9@DM5PR12MB1578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDsrfD/KKu7GnEeBv5rfY5Iz723joYYOmjfopyozxkiE9tJu7CNGj2Xqq7/05XfgPEXBa1869jVPGOxReMp2M7cDzrkLzIwMNjyy+Rgqz7YCQM49nV4XnpfhHRI1GEDoISze7nMum6sw1UxhhKi0x2ufzn9UvI6uhnqPeKG4UvreGJHuH0tc2E+J+JadaTnrcl3OWnLi+DIVgI/JaXM8pNg3pHEncRaupU6ZbEuuBvcw9t0hgEssTLlIFEI83vkqeEvAfQYMYc4/OzEEv4G4gxYrQqgqycm7bAbB4zMAuWV6yCBvK4BNxDw+AGymbh9NA0dXAIycMtYPY/QxeMm3DLyHSvECCShq3rkNN3mXJW/VpP0vFppOIsJ6TOF+lme5aapvTEcSl/13KFnODlsfUCcfbLiv2/q1crC2wd2Ovfs4XIeSr5KpNodsj7BbnkGQMxAh44YAN02Lddl88adcYlplX6/feRlw8GIlVEaAhXG0jJwgIscEl+UE+FxjCiyZKXtW4sbXZX92cSKBLBqMMhtwDCPYk5C7pmilDQreCL8lTy8B0ghgyH4W/6WSjWYbErN1g0e8XmzbpnLZRTl4asegrukh59M2Va5UpwKr0Uwa+dGSspwxYlyNex7ByDKcf6EcfBjyAaZFKbmP862EZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(26005)(186003)(83380400001)(6916009)(33656002)(6512007)(316002)(8936002)(54906003)(1076003)(6506007)(53546011)(7416002)(5660300002)(36756003)(2616005)(508600001)(6486002)(4326008)(8676002)(66946007)(66556008)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EgGNPImiJTkTixIEaTSeAQjVAUOTYAPRM8QJws8m7pYXTfIPohfBW5pRPc7n?=
 =?us-ascii?Q?hlENs8TxjBm45KAIZeweyPGQox/fllQyYXZ/qAAJVz0Vv5APp4yqmI6s2Unq?=
 =?us-ascii?Q?yIuSd4IET+aN1yVTsWQJ7+x6w4jN+I/vmD2f2JsMFIPWcnw3pzN8hfRm6JjJ?=
 =?us-ascii?Q?2X/aGk+JiMpmLkUxGnUrIGV34N2bVDPlOXjO4yNBChRmcM/jRNV1Rnjr0Rhp?=
 =?us-ascii?Q?XACB6lRz1HvuC291QFdII9faJiROa2M1fng0hrhdV57AIyi/1lxOVsxLEeqU?=
 =?us-ascii?Q?+HMkm1XBpNBe5v/G5S9E52i1vbXLqW6sc68BykDWbBnPJLzu1LjIYCg7CGWZ?=
 =?us-ascii?Q?isGGwNo8+jGzfLBbVUd243dt9O4lKEo6ATmAHAxkoO1gJCMo34QvZicDttYG?=
 =?us-ascii?Q?z1P55j/8l8M5M5BUR2Fd40VgWorDbVwGB8A+eFU6E9efAsnxqZdTMLek1sJ4?=
 =?us-ascii?Q?MbJwDu5xPfRDi28bvakeWQPtmaCCll6D4BDlb40UoCgXntuCzMGBphy7QLd6?=
 =?us-ascii?Q?7Agv+puFSzi4c/hF8M5QF8rZ3yqRcIB9kHiqq0CVDc5U53V3Za1ECGXlx4vI?=
 =?us-ascii?Q?g1XH90wFi7DwDg2KtYykyO59IZv6KNT1I8kD/MgjlPdXoHlXPfgbPRyeSIdM?=
 =?us-ascii?Q?4QwRQrpA+XkZfZROrVkDZCdjplPHp/O6IovflD06zKbTZMmx3oJgL4vuZdf/?=
 =?us-ascii?Q?TPnYb+TawXBuT5Q4HMROmfQQyKwvQlnpnufF8v/WMpvieM+is19KiL7oFcrh?=
 =?us-ascii?Q?63J2q6WKpOjn9zHQukdOOxWMsCUXh/DIwJRolKya2bGKjLmdV0H6ij3d0MTi?=
 =?us-ascii?Q?OzO8bCH+G4Fdejqd9N7HZfF2dPVJQphEylGOBiG54ygZxjr6sGtVoyvXIupc?=
 =?us-ascii?Q?wToivnueTMW7abG+KYa/WA+QMw/gj6d72WpO3fMVHmggv6nBPfOlG3CtXkVQ?=
 =?us-ascii?Q?Fr/XYEMN2X7scvbVbmUp3zb4ECB17A53BAiRCStzOXmYjYi0e31GMxDdHhz6?=
 =?us-ascii?Q?JsOYKPTtgVUs7u/viEq5JE8i6DB2T4mcof2sSZscIXnjdeGvcymGqJewBVwU?=
 =?us-ascii?Q?90orpjaATAj8kM8Js+SQSYGZgl05cEwDiOMA/UtazFKazSwPRg23vlESmsTe?=
 =?us-ascii?Q?zmpicKjwp451ZvUhVgCBr9okc6gO5MBDEDIynXevMpXid6DwSa8QNuyqSDl+?=
 =?us-ascii?Q?LgqVxRjQscEVljjHyFQD4vBstSAUoumm7+1umWve9vU4BGydCcH/h8QlvALu?=
 =?us-ascii?Q?7o5yG/oc0s9mf8/6TY9khYzF1A/EwoeTVI+ZI4CZaWSdYTZ47nDsjg3BPL1g?=
 =?us-ascii?Q?/GvJy8m7sT5b9MmE0RZ8bXa+YcVlMiUw1zNWERh/lAmJcRcRdDELWzdPuCEr?=
 =?us-ascii?Q?7BWMyfXeQ9hD+JBDHStQlRq03K7uGvyovId29e1Ic5W/GZfxvcFu+W2CREh7?=
 =?us-ascii?Q?hDUSfrT3H9XonDBjzumcCLx4Ow+Nem6CjQocQbJAOBIf8gVa263aSMuvxaM8?=
 =?us-ascii?Q?2zle6fRvDpGyVGPPOfmuLrlrVWJiilISp7y/x3MV5GPiFJTPxWFwFr6ssIwR?=
 =?us-ascii?Q?JPhyOybY6oeKYjC7jtH/c/r2Hi5hQ0fGyT+CiMjWULeNtQ6hVF9TJhqXayi9?=
 =?us-ascii?Q?9zkw4W6R3iLlN+TjZLMLMiAoChJ01GJe0QSonrDbR8iV9AYiFoDkx7n6QgwG?=
 =?us-ascii?Q?6uZjBPOpbQ0GrwhnnenU9uIRzolxlAe4xEoK8oiQEISvJxAH7wAa5eBd5PgI?=
 =?us-ascii?Q?/3nfy2ND3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583bd338-4caa-4fdf-75d6-08da340d5eea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:48:45.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJWux541omgEjKSQAy9luA+OMYKorJTzUP/lCIfpVlFYuv9axyR85mfdBqwvo2IE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:17:08PM +0800, Baolu Lu wrote:
> On 2022/5/12 13:01, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, May 12, 2022 11:03 AM
> > > 
> > > On 2022/5/11 22:53, Jason Gunthorpe wrote:
> > > > > > Also, given the current arrangement it might make sense to have a
> > > > > > struct iommu_domain_sva given that no driver is wrappering this in
> > > > > > something else.
> > > > > Fair enough. How about below wrapper?
> > > > > 
> > > > > +struct iommu_sva_domain {
> > > > > +       /*
> > > > > +        * Common iommu domain header,*must*  be put at the top
> > > > > +        * of the structure.
> > > > > +        */
> > > > > +       struct iommu_domain domain;
> > > > > +       struct mm_struct *mm;
> > > > > +       struct iommu_sva bond;
> > > > > +}
> > > > > 
> > > > > The refcount is wrapped in bond.
> > > > I'm still not sure that bond is necessary
> > > 
> > > "bond" is the sva handle that the device drivers get through calling
> > > iommu_sva_bind().
> > > 
> > 
> > 'bond' was required before because we didn't have a domain to wrap
> > the page table at that time.
> > 
> > Now we have a domain and it is 1:1 associated to bond. Probably
> > make sense now by just returning the domain as the sva handle
> > instead?
> 
> It also includes the device information that the domain has been
> attached. So the sva_unbind() looks like this:
> 
> /**
>  * iommu_sva_unbind_device() - Remove a bond created with
> iommu_sva_bind_device
>  * @handle: the handle returned by iommu_sva_bind_device()
>  *
>  * Put reference to a bond between device and address space. The device
> should
>  * not be issuing any more transaction for this PASID. All outstanding page
>  * requests for this PASID must have been flushed to the IOMMU.
>  */
> void iommu_sva_unbind_device(struct iommu_sva *handle)
> 
> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
> if we can include the device in the unbind() interface.

Why would we have a special unbind for SVA?

SVA should not different from normal domains it should use the normal
detach flow too.

Jason
