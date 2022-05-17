Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6800952A2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiEQNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244361AbiEQNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:08:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490D35264
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEdrBzYqLkbCR2I+l+GFnpO8kzCCXDxKqCsbDKUPm/D7CCPfFgXK89rFiPbyCG5OInfj8+XWnLM1srxvKgELQNH/xCi/Y13FE9hVvyCYWTS0ZPV4nvKE7SQP2Q0a3l8Rrgv6nB8as6aa4ulWX/zxrLeopGX2UbpCyNDV1IxosfssV8FSClar86QAt+ubG1/w2Gi3ATZcI/2USl49A/WenCxqqtnkyZ5TVu2Mrd0WGLd69PrkSUEQfJjgHFgr3siU4qSsUlnISJxl1jp5ONtvDqPIc9qmC6qYrysJVPqfXprtR66fHn5J3fX0iZy1Ne0a8qfuFKuWPSo0bmglkD//eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVrE5+twuWMh6yBOLXSH5h7kx3QbCfOfleNgGIrsmhU=;
 b=aMvhxzDeWP8VwQhKYL53YiaMrpXIUpGaPdiqQtRr5EVL5SeYU96n9MSrN5N/gbki9Za1/36Sbw3Ahd8DDLWBirZ1MHC3MeMMeqb3z/9r9Lo1A1VQxf5zU2hiNIZhZgFHTKN71EE/W7idqksFhhtaZrIkPEdrWcQkuNERE/dsx0yN2DJiZfG9mc3U9oi0x9zLwEjveylfcVukq0P1WKAEHHnVeECMUKSc6JNjGBlyO+D+r9L1UrG5EDeYLbULtwI27UgXjGFzHOoqN9ouWYBWSFxSm+JWSxAT+FGETeAC3fqKdrLw++ooZFZKdH/SpFqnen6p9koQBtAdEFkDdcoHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVrE5+twuWMh6yBOLXSH5h7kx3QbCfOfleNgGIrsmhU=;
 b=E/ZSY6qltJncBiZyHfZvBt9+SPcjlua0dFfptE0Fyv4TTvFZTkN7sglM6pri6MzTaLMMSVUZedWtzKivAFQIbN9n/5xU0mc6vx7QiZJ69ud/DhZZcBsHaLMHf/8fgCdWo/vXqGxQlnUtU9KQo/DPmldV9TALKULkx9jjagxKGAZIV8OGqFivbal2UHqfq5EPWbTIiEvBi/3YbOiDDgg/YxUzIWp/MZaDYffV2tEb9ZYXelOFXp1lB7YyDnolgJHD7ROzlRYUp/G2hhxi/NYFS7EnUcLAcXZzT5j4uc65BV10SCybyyPeNGjBOeDOGYhP0mvzi0ucCj9roqhS9tUAow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3491.namprd12.prod.outlook.com (2603:10b6:408:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 13:08:04 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::182c:a653:21b2:b351]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::182c:a653:21b2:b351%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 13:08:04 +0000
Date:   Tue, 17 May 2022 10:08:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <20220517130803.GT1343366@nvidia.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
X-ClientProxiedBy: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4f9091d-28b0-40d7-9d8d-08da38064769
X-MS-TrafficTypeDiagnostic: BN8PR12MB3491:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3491F128833E3240F76A6DF8C2CE9@BN8PR12MB3491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJVbtvsKapIQr5I7hQnlmfoX3GwkMyo4SnKOc6ceh7foi+z2Ohy4fyRJqd1rIJPcEpDGkVFPJUTF/yb8KBnFsX+PV1jhsrrtvYkqHFTloaTlRAd/6nahtPdFMDg6Er9ACgoY7vFyWXVMrnUmpFqBJ6NFQ1IqWs7nFPPAA9tNZciZ1+4SdGHrWs95JDCyq9f7Md8zPiegoUkhm6adZ65qRQON5FhfO+1NVqhHm4KW6vmNSXoc+KrdbcaKbMpRSk/Y+l1XIrSpUlygne8A8XJWGkEWm8GOxlXjYO5TBqUE+zY8fwxkH4LgQoBqDt+sPIfdhvRfaiwwM71zLDkDaviSZnLDjU6l3mLMRYqzTMI0QwBp3zUnX9Goon+NC52U7zDyvtNDCE2X1ptHM+wZaMWmfJgU/y6K0EtFe/zrawbq2And7gxDK+tw68zz2+Y5hjuIefevZS39YqQgvSB2kXzFh+Lx/FA2sYaUlWrCuysXtHpKFSmnHEOkT6m1goHdReJOtzDK4A3vHmomlIeKhqlh0fYI49FoSpjJ8i5JopQFP162bgst1uOaddsUCXU4qOAKyzwbI2l6AxCL36S9CRex52NJmflwgI4v0agPWA4RyPVsZO392C//kVHfM/vZAoBxwsAg0hXYw+yLdUmsXReBVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(8676002)(4326008)(66556008)(33656002)(2616005)(316002)(38100700002)(86362001)(83380400001)(8936002)(5660300002)(7416002)(53546011)(186003)(36756003)(6506007)(6486002)(26005)(6512007)(2906002)(1076003)(508600001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/tffpsVnOGkjxLNYT5DA/yAW5thDLD+2YKlL0iF14QHsN40ezvew0K7J6uK?=
 =?us-ascii?Q?dX0qqEcTvjKrGiMMNLVPGuS6x3ro5v4OGFoSthRlexayWSteTm09z0DtgMpM?=
 =?us-ascii?Q?trwraiv858F3VVet3L0C2TCnmaYL563IUPQbEgiRWTFYyv2DEUhgtZ0JihN4?=
 =?us-ascii?Q?pdN2fKOrTtvDaifEfLcjXFL6Eeh4bFHYBCH1mpDeqLXKTb4mWSReWy+Zn7kH?=
 =?us-ascii?Q?uz8fapT+nsV2swjBVJHm0juX1HgPPZSX0nYOAJa0zeTfvcHdtxtlB5cVIsld?=
 =?us-ascii?Q?QK8KpjcpiQjXbGW0WkmkxNTjC/LsopkRllKf0zGW0Gt7g53jWXwA6HC6O4Sv?=
 =?us-ascii?Q?IjEX9FaJXj5AxZUUQaRBH0FRtUY5hOcKg3n7oHIwRspBPxbEquFQMrPYijPr?=
 =?us-ascii?Q?LXX8Sq6KZvSa3NoTIN05unMT/jmR/tL6AFEGvAQtiqvjXDw7QgzZ4Opd7VaR?=
 =?us-ascii?Q?KrNMjnPLbbwkE2F51aYeh4AXxqVPVHafXzWMjUesGZu6uqS3dPt3pY9YW2kw?=
 =?us-ascii?Q?+53Ly2VdWo4ScngK7aFjhooE/p3HGDc/WbfAMhQF1cKw7SCW4a/ie4tGAdee?=
 =?us-ascii?Q?SXvWfrQ7oLFA2vQ5VKCHpAU7c7oCsZsxxJrd9F238nex2uKkoFnISWotoyrw?=
 =?us-ascii?Q?HvkBZeTvMd+RZ46/w0km8tjV9S10rnSbBIP2cwhry0mVTc0UUOa9R8mdcjcO?=
 =?us-ascii?Q?4uJsoF/5qGr9kQiO7jP2krdek7ygUnj+1QazyfbkXm+w2Ter3UhlnrRzc2Ay?=
 =?us-ascii?Q?nNy36NQL4qrhfl4MEolEs7sw61oluk+dPP0O/S9Yqomru3RqdzE+ZILQfzJ0?=
 =?us-ascii?Q?mEczgPtYPZAnjRNPMzviqI/c/7hbRQnNnVYd5IeGyP9/cksnlqI+5DvDc9sI?=
 =?us-ascii?Q?6L1MDD90t9OqhjjQCkKHxlVkKyGuPrfYe+j9TplPhDL4e2qwDxBtd0gXNhZO?=
 =?us-ascii?Q?Ol1aBmz+85X/S68KBeeIr7WEo/beUanJwcqp7ZP3v/B+TqH4D2VXLilPucvZ?=
 =?us-ascii?Q?hIn31Q8S5vU8aFhTJ80dfGGgLNQyyJRUn0SVzJWg7iodCLMke5M9pnsSQ1gd?=
 =?us-ascii?Q?FwawK3S0QpFs+plrSONze2uZQwNW7CGkz+f70cE+7qjMITIrZOb6mEfGgrbU?=
 =?us-ascii?Q?uKZoVdzq6AX28PMrQRGlsn8IexpqmoETyOYkg4aJBj7usrSoTTqC7pNftshr?=
 =?us-ascii?Q?M6aC3lHDJkC3MCbADajg2bRLMlmrxqplQKNvdwIU42QHLMBOrAxZU3Xyfp+1?=
 =?us-ascii?Q?sT4DLiRFuEz4XYEOcNOgTIGF6PCGJggEWEZ0mRO82Hi+Zc7CV5fWMJK/cpfV?=
 =?us-ascii?Q?zzAryYwyyIeBVR9czAkRXVP6+smYlrAA5XCIC7R4CsFuo3q4A3WDOqBasnD+?=
 =?us-ascii?Q?vFd7if2I/z/JVlZYAFrUhgKDS4z1K17X1c631eFWn08AysXe+VRRKik+rdJm?=
 =?us-ascii?Q?UUBA4360TwwaQVJwZJMpJKlWv2V846mkEa3ubTEhHKw3VJ9oXhvZAFxdvyuT?=
 =?us-ascii?Q?h/6OegcGRA8hRLduMOAktGLeKz0ecHWHhxl46Kt2t6ewiF0+lqNZJIcARk7p?=
 =?us-ascii?Q?E2eGGKmcDba0oGVfhjB2VAQIH1busNcl1jktaSJtBUge/5xev7wXjTf29ViE?=
 =?us-ascii?Q?zSfJ5ybc1sxR4jdD4fJHnJPZAYH4Uv0XvcSC5DePmMJjzLRNdhY8IP/H9MjD?=
 =?us-ascii?Q?cI7/+N1hJobRxrj9+akJe4WjTPxwvjUhMvS5gVw9nRjn16kqkJi6whWwKtQY?=
 =?us-ascii?Q?kbslwVSHFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f9091d-28b0-40d7-9d8d-08da38064769
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:08:04.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3pULMOI7NLRoVApap5bax3IoZ45CXVZogkUVfQ5k3AlUDivBjyz4s9fU05fdxZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3491
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:37:55AM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/16 21:57, Jason Gunthorpe wrote:
> > On Mon, May 16, 2022 at 12:22:08PM +0100, Robin Murphy wrote:
> > > On 2022-05-16 02:57, Lu Baolu wrote:
> > > > Each IOMMU driver must provide a blocking domain ops. If the hardware
> > > > supports detaching domain from device, setting blocking domain equals
> > > > detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> > > > domain without any mapping will be used instead.
> > > Unfortunately that's backwards - most of the implementations of .detach_dev
> > > are disabling translation entirely, meaning the device ends up effectively
> > > in passthrough rather than blocked.
> > Ideally we'd convert the detach_dev of every driver into either
> > a blocking or identity domain. The trick is knowing which is which..
> 
> I am still a bit puzzled about how the blocking_domain should be used when
> it is extended to support ->set_dev_pasid.
> 
> If it's a blocking domain, the IOMMU driver knows that setting the
> blocking domain to device pasid means detaching the existing one.

> But if it's an identity domain, how could the IOMMU driver choose
> between:

The identity domain would never be used for detaching a PASID. The
reason it is in this explanation is because every detach_dev op should
be deleted - and the code that it was doing can remain in the driver
as either a blocking or identity domain.

> > So, the approach here should be to go driver by driver and convert
> > detach_dev to either identity, blocking or just delete it entirely,
> > excluding the above 7 that don't support default domains. And get acks
> > from the driver owners.
 
> Agreed. There seems to be a long way to go. I am wondering if we could
> decouple this refactoring from my new SVA API work? We can easily switch
> .detach_dev_pasid to using blocking domain later.

Well, PASID has nothing to do with this. PASID enabled drivers would
just need:
 - Must be using default domains and must have a NULL detach_dev op
 - Must provide a blocking_domain
 - Must provide set_dev_pasid for the unmanaged and blocking domains
   it creates

That is it.

Realigning the existing drivers for their base RID support is another
task.

The appeal of this is that it matches how base RID support should look
and doesn't continue the confusing appearance that there is a strictly
paired attach/detach operation.

Any domain can be set ony and RID/PASID at any time.

Drivers intended to be used with VFIO really want a blocking_domain
anyhow for efficiency.

Jason
