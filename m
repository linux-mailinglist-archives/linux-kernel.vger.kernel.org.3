Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100A352A2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347218AbiEQNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346226AbiEQNNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:13:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F3E427C0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuY/Mcg0mqSh/iUOXMyk5+jdcGH81bzKQpONEvEkg6fJ5cHW5CrcUUKRorjlQpUwe6kCkb8+5NWrX55ZP+OR2tOODFfMiBwiRjd4YL2IHtyVtxCn9QL83Bh88ZLSHhBguWW3DmcD0WksATn8SLJhQyE29H23keY2+91KxgbnQB+0dHDsc7t2Z0KikXbdKXw1NJmEavWyrKnXoEuJDfTPXe8eS58lfvbCxIr+D2BrBwFKXktdyOF3JBElLg7kBJZA1kAy+msthxk3t6dV79hQLNBaVphIfCVYo5vmW22C5Y4LnhwQ/OT1AtRFHRyzbWMXVsGIG7RUbWSywnnUV6sKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3dexjRQzLsGGVIyndP2j2QTG9rU1ejz5D4FmuEoKD0=;
 b=ZOkA8e52/qVqhhr772L2OdjuxFXWsuNE1QExLzUjx7SW110DDtIigku86Eh4IJ0CixKnSZH61Nz68QX1+fILsNKGmK/qjAdrUnMM2oR7XfvjyXqFY/YAWWfxSW+9rJYVL4BisQyEJuQWOvmeoN7l4O9iBsiQweFNILkBvWfBXD/LqcJsGSbvYRIPqvpnNFZ0D9VEPzuE2Paid3beHfqMcKg7ZSgNb2bown38HMjWHrkDoGcvGs63WVZWd9USBCrE555geZbb30VKCRsLR17h1a87Q82Dqu754NS9Eai6Cp1LdoOXKdRO/CLseACioOPgClVCZib99Z0AGLcmEY0w0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3dexjRQzLsGGVIyndP2j2QTG9rU1ejz5D4FmuEoKD0=;
 b=Lrkwvw7PGyfzkdEa5gZvpozQkS358lWM/VFIPNFDkK2b29fK+BBSZ13KfSKGrubj8u2U25MtMqu+ZqVq7DmbRIsFm6ZSRjFnNmScDE/t4h7GXN1tpzhPbxmWpw5gzIgDZcwQVOqPXlyZgwTaAwDmCBxUmsQvlE/ZvpUAPYBfrM/zHsPBkkXEcrmXrngC9Uu+rozsdrhoMyWAS2dzewXA4dK6fF8tm9CFQIiT8vLU/JYz63parp5tfJx9/a4POgdzgt3D0TUAaudrvx5Je0gtzcbsJ9MG4GPy5f5bZt+bYfRrag5ooBgtoUzlBYT85GcA1UjJj9WpNT0uFBlNzjEiQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3491.namprd12.prod.outlook.com (2603:10b6:408:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 13:13:25 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::182c:a653:21b2:b351]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::182c:a653:21b2:b351%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 13:13:25 +0000
Date:   Tue, 17 May 2022 10:13:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
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
Message-ID: <20220517131324.GU1343366@nvidia.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
 <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
X-ClientProxiedBy: BL1PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::24) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b5f04b-4991-4b11-ba58-08da380706b7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3491:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3491C9D58AACABB16CF23C6EC2CE9@BN8PR12MB3491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2MAbjzCw/12tDN6oicALvWa/NW78CSvAsb3eYkVQC4sC51/rGO1yluYKMD+zSq9kTTW8Zv7mtiRgTh8GVyobCUEMR8pO944wUf4EpXem/dvzYw6uQtprTL9PsOAxIeKENzcq+nxO6nOOLHAOdkGRG4erK+vlUtDsw8UEzRiAsCrpYIPmDl8ehdxxCgBzaeq14JXR3H4ZHsQZ5wpXm7pX8J27kZE+mVTu9OKGUTr7eH5iDzHMG8IvestA0dwGclYJHjIy5nqoBR/1ljTaEAf/Er+50ZWtz6Fn5cydDTB+yjL0Hf5wdD5Tm5eE+JpZ099yr4woPIgH7SfpJ5k7aeRl+R2HoGOoHPZ2HH8cityyasdsZ2F1/Dvtegc1UBQGV1qO8ZRe08b793AtmCyUxC+Fg4l5tCrkb6Wuh6MEJfjEBfBfPSX5iagabRtFH4zoel5MlVVAxz0EtiJzEWqYfxE9Ep0fUmvuaXFNHv7vy8Xzrso4fy5Xbvs1EfChw6MJYv1dGEgp1IXutG2yUhuLB5BkFWpg6JDNeBjr4eFwJabjM3ZXRCNEgd6OJqysAquiTZaxl3khF1GVKj82Bi8YT4r52FWnNthTjOBZO8t5YgqcBsBk77EvrWapjURzi6E4l4SpP0fddx/WMZ501O9B9DCjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(8676002)(4326008)(66556008)(33656002)(2616005)(316002)(38100700002)(86362001)(83380400001)(8936002)(5660300002)(7416002)(186003)(36756003)(6506007)(6486002)(26005)(6512007)(2906002)(1076003)(508600001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Mqdor52lx8UqrdNyVuvXYsJrjbCOzzWwWXfC0/O1CvYGIqK4+zPSJtMkOMv?=
 =?us-ascii?Q?M679nY9LO36Kre1B5xzFlxiXcwIB+jkz1tWf2FKLNK34OIYHVt0MqpD/FKLP?=
 =?us-ascii?Q?KZMUJ6bcLn6KZYVaes4KcOGtybAqjO9Bh1fVzD3A4E+Z8rALTfn9XIaGJNrR?=
 =?us-ascii?Q?U6F31jNEoWqyM1BbRJPlHNQ56a4oaQE7lnTeY16ogpyBpsnVDSXmBU9Dk9x+?=
 =?us-ascii?Q?4l4S5YzC68xP+d+CLjPHpHDslEuyJpLJaz9HtkZ9meqeR1D96MRgRV9E3PMP?=
 =?us-ascii?Q?u7Ngbd64FoKs8AzH0cCU7DQmkkzfza7MrtX48vzhzMx8zPr30cIfXJ5RJ1yz?=
 =?us-ascii?Q?KhdSWkbiphGx9JqgIytkhm/AVV19FEzW/NIPcwDc2YFb39Dss8H7tIrCZbtH?=
 =?us-ascii?Q?ukoGtuvvYWhnZs0wwo3RviSLCle5Yj40TlzWnbZPr8yJV2YAekpdlEOqekib?=
 =?us-ascii?Q?tvZd5VU10YtOj04BxDctJmBcm9lpisoIlY7+vwc9143q0NXWlLmsut6c0nKf?=
 =?us-ascii?Q?wkaLqBicSoOHokd0wRRmtOwI0iTNit2NSxfkXvdKypLByv8HunU3oQ7FVpDb?=
 =?us-ascii?Q?N/RBznw7Bx4ugH4s+q1ArGn400LoS5Hp68p744Pe/7VdlLtQX6by/nNZN66Q?=
 =?us-ascii?Q?jfSy+84qNHKHcMfgulZTBVRvriuzJmVP0ExafMRxaRM/4RuvIn+nS2o7c0rZ?=
 =?us-ascii?Q?LTvR7T4YdwiUIHMulJQXflYWv9ArzK723rICN4BfEKk0UWCOpVHKOvPLgrLk?=
 =?us-ascii?Q?WLmL/ubFM2Uvf4kVhYYGhsqwvb/i36ggIA7Udjw6PUMk0hKP6dlfaK0USb4T?=
 =?us-ascii?Q?lSLk1QXc2STHBbr9ZT8Zuv1wXIU8dbWtmuX8pTFxh2Ktfj6rFem1k2/3G3E3?=
 =?us-ascii?Q?aRAC7ukEBPkoXYqrv7UkAipGeyCOWMaHvkdGQOSRhnzKB0r92aBdb8lLQpC6?=
 =?us-ascii?Q?s3HRnyUeRy+r3Tq3+ydVay9/k1/cO8ZG3j09/T7GP5sjw3n8IMTQ+E/oSKMi?=
 =?us-ascii?Q?iutyWkLdEB+XG/0obZc14awaigK0xZHukMBOUvURlRapGSUSOEAgqBTKnQbA?=
 =?us-ascii?Q?osY4mp2+2+6r2tcC9fVOU/RBrP3rreJ5aTMpbhBYROTOyE5I5cnJYRub00d7?=
 =?us-ascii?Q?FbguOYQRWoTlYjcUN92dvJtdSDMubo3MbZm+gB9NQP4k29OU5yb+oJjMvwzr?=
 =?us-ascii?Q?LUrnIJUBRiK18M0C3j2YTVDcq2Ie3kt6QWMNz7zFRGq+B6/nHnPA8BhAPqdU?=
 =?us-ascii?Q?fnifeExiETwJHkKCNrIhyXe+qO/cKRecTfFVsn0/BmgYMIr1J3fDxd/e9zzP?=
 =?us-ascii?Q?4/zh04Gp5LNzPXnCj5k+4mox1lBUDgtQ+QCvxQnZknbmP+YP/5WN1FRu0Mjw?=
 =?us-ascii?Q?gjjpddDhakeZFdx1zJiZ4DK7SRBqjrqAj3ntPtWT1q9zVPMG6PhOgSmY+qg0?=
 =?us-ascii?Q?v9Y+IbkGSYuGduFJYgm+8+9Otqm9rYWS084uNn8uPEoYcq4ncVy91gUTW6+z?=
 =?us-ascii?Q?aPcFDTeVaGPjZXL2LGQMWKXf4TFHw5BDTH/LAPSvJvyUL+AnxOjeFEo4LuVn?=
 =?us-ascii?Q?vfiLogf6vEU1UFsLqaZxqwmEFPWqez2Wqndajn+epfYLSUckEy6aeszYOzQy?=
 =?us-ascii?Q?Cb/W1ZTMXs2Vn8kZpAvxrwkXcrDbFlBnI/mQj+vXyaGgS9AyWvsz6RHhvXhH?=
 =?us-ascii?Q?I3o+ekZ/HU1AbB8Aaor6jE33wf/Ef17Vakz0Cz6DhCk5DtaB1k44hVyAXK78?=
 =?us-ascii?Q?SemxZmlZTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b5f04b-4991-4b11-ba58-08da380706b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:13:25.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwxdK6R+sno4o/tHD6OkIGrefzuSpfqwmHsJlkHWL4sNURnzhmvIxnhlBRk0zpME
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

On Tue, May 17, 2022 at 01:43:03PM +0100, Robin Murphy wrote:

> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
> meaning implicitly-blocked access for now. 

If this is the path then lets not call it attach/detach
please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
names.

> On SMMUv3, PASIDs don't mix with our current notion of
> IOMMU_DOMAIN_IDENTITY (nor the potential one for
> IOMMU_DOMAIN_BLOCKED), so giving PASIDs functional symmetry with
> devices would need significantly more work anyway.

There is no extra work in the driver, beyond SMMU having to implement
a blocking domain. The blocking domain's set_dev_pasid op simply is
whatever set_dev_blocking_pasid would have done on the unmanaged
domain.

identity doesn't come into this, identity domains should have a NULL
set_dev_pasid op if the driver can't support using it on a PASID.

IMHO blocking_domain->ops->set_dev_pasid() is just a more logical name
than domain->ops->set_dev_blocking_pasid() - especially since VFIO
would like drivers to implement blocking domain anyhow.

Jason
