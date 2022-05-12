Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D120524C24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353458AbiELLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353450AbiELLvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:51:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7E5C672
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBGGzhKpKKIaACGMFvy0GGVvpPsWXv1vp+ulwfQ8U3Rshsi3clxdqHQsPaBjtw5fnNbXf+2fKqBGfxjzPriRZACA6hyOhhMgoEy8aOcgVI30BDQQ7ujZNzAVamimRCLOGVLWvwHKSlpqGUvhD4MVkS5bBrx9x0QBLk0/T4WArEegsHo8ti+P+4ohd5/Hj5Bob8iD6ReIFkPsKeNtc0lcwymjtT5NUwGoWeGy6EhytHmooyFzDMv7I4GR6TRqUZcc4nB8ECaA3xPbOyaXoOd5SHNcb5ZHX7Y1qndcBS+4ccmxP9pto88Wc4aqn24mnxjqn7RwicHXgtMYaL7zwBAfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2krsJZN1R4JxfByCzBGjTkTHffKsGrgBP227f/I+vA=;
 b=Ba0+otkO8RInuiVDAxPF7ezIEU2kDuUNNaPvXyJmtful4Jvzgs/RoIa70ywhFsvlMxQpo5KcxASSAHkaHbAlckvg+JODHbTe0SlUHxD4oz6KTMR6huvZnARNTTge1lRQz3//Y89hy3z4uW3qmDgVIrMKS36Gr142KWV1hdtCrti+MYx/q68TxDmtpYYS3iXTaoYc8iG5HTmiAI7qZKDbaF4U0fN4YSmLXkWBKGdTgBEIANBBOkRi4g3xlO8Ri7NVFjHGKfB8mkHkAtwlAOCDEW8ok+3/9Rz5wkGo6ZYPghPdFZLLAxpb7PqFrKKkjJXDPFnVmKSSQOnkHcJRojEgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2krsJZN1R4JxfByCzBGjTkTHffKsGrgBP227f/I+vA=;
 b=oFJYWhRcWzicm49uE+H8615q4EAx/n0ruDO+wbeo5tWsn5RAuED9hz6p4lTE3hW81eQOf1v2mncPnbC/3NzTpvgnMwsr1WZyn43GofHdRM16TQPEMzL5+CaQPBbfWU6fKKJVb534xfXldL8As+ZtTuu6TnKNW50Ad1ESXEXnwiSnZIwUqQKobsD1JQDaZiWTqdchgRFlqGnXZ8qmQq7fWOkuhPJzbibz4fHwxETminKP+axzJgZPx4Rew0+oQYUB2NZ6PEIto2TtjDmOrT6lbpIsKoraqmF0/9c6skqgQB1DsuI8EwuQgmsLQSkQZdtH1MUhuptQnmGwpuJiuCNmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 11:51:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 11:51:38 +0000
Date:   Thu, 12 May 2022 08:51:36 -0300
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220512115136.GV49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07817f29-8ff4-47d9-361a-08da340dc57d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4555539801171E6D9CC408E0C2CB9@MW3PR12MB4555.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO+2DE4ed0kr9UIm0mE7whLvK9y5YmInTMkVdwHm8Kc3IjyVJDdonOyG2tUZcaLjHmrCnF+0ePNM6NQi9bIVsVJmilKFg8hWGvLGbvzFZmg9n7xDnj+83p15xwudBed04O6bffqWdFX096F+mo6P8BufzHyrLHpx3XlWAVaEWFrkUMQdwVTyBrvht7dbppzSxPaIfi951uqr6b2KjHfL/U2TM6Iv7P1tQ3B1GRv0P1Nnrt8Dfhzj0z/6tFC1Oefd9ySK6Y54XbIDXvlS3YyL6ni3NiDejCfnoCWc1VPkUy53u4/5HcirrjUPCMc8Z2AglwR2dLzUxyOYpb+Vud6mxtOfnhCn6tinUvL30yy/+7LIXt1okWFEMc9X4YofvAM9TMRe0J//bXNurCM/haptmyLhAmT+H7qCKS9OnyIW38ryQFeZjIzNF8MGj5GcDojvlvwR51GLQUg2y4xHnoi08ZQ8HDwfLr5fHorVXM/Hr/E8WgTGf5Hm0BbvNsOkQbDDGdtYDNuSmJ1WqS8gzmxEzwi2/IK/xkxv6Y2a4o7iiCY9gYEpCCvL7z8zRMiiYHfRvnhnqxsMI+94Dox/66OL3b3q8keZ8jMf5TAvy4NGULQZAlyYCacvx/5hM8k+ovbnjwRpN04UbVcCRCVF7f9LLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6486002)(86362001)(36756003)(4744005)(6512007)(38100700002)(1076003)(508600001)(8936002)(2906002)(83380400001)(316002)(8676002)(66556008)(4326008)(7416002)(2616005)(66476007)(66946007)(5660300002)(186003)(54906003)(6916009)(6506007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yK5FgpFNJiJNGZO3n/sUTMGYTEf4CPgV+LLZzRzTHXNpGP5swNzUoB6iyCVq?=
 =?us-ascii?Q?59XnNUN5RR7OQbWzf4UBU0ChL+m8r4CyV4Gcq7K2GReIFJ2y9Ufwf239q6Ak?=
 =?us-ascii?Q?cDDaYGk9S/WmfmGR/SCOIcZsfN+A2T1WLP3ON8MlrRG/DxviUkfu8xOfGExD?=
 =?us-ascii?Q?hcLDqaLk9sQDRYin4Ehl46gvDuDzPd2uLclK0RPHnD/23JNjEJupLT3ffatg?=
 =?us-ascii?Q?mwRnVXZ7k6cpQNsbc3TM6je4TeGcmYGBCvGbEqwTkRFeIlBiBxIkvmSoSHOO?=
 =?us-ascii?Q?1QeBXbrC3l7fJ3bVI189btV036cZ/JzpTClaOXLAgnZjZFCHJsbSjkUBgR8n?=
 =?us-ascii?Q?Ec4bLVNuHuytHlgC90BBpMp+hMuhzhfQnD0zvYm+8GXgtFmQfgGNI+85h0Nw?=
 =?us-ascii?Q?5wHvoNatGb7ll/vXp6lFFreuNC0vL120gPxkBCj0MS0+jJ4rEGDhUA6cEd9u?=
 =?us-ascii?Q?GIiKRLBp6qoLiIweuDUAObJZ4vRdYPpo/HlKRZKWPxgqnKK7Y9vh/0cuEAVS?=
 =?us-ascii?Q?Qz353xmPp3i0ffAu1WF/sMkaKN/lBayxikpNmNTU+21t0F2K9KiWOWhVK+3c?=
 =?us-ascii?Q?mcDqbQ4IJZn2WrraY3pYuqWJtAF7ggvtCaOwX8GIbUQvm92Bwj0yWcm7GSEq?=
 =?us-ascii?Q?cxY/ON59bvSxnepVudVLCenqgk3GbeOkW6YmXua4K4vu1ChV4eTKXaTo8R8y?=
 =?us-ascii?Q?BNZM8SP946wdTWpNE/CCSvTZ4dnlx06MrIMDMXhJUj3wLRW6q1+/g1Uvc3vA?=
 =?us-ascii?Q?5Y/q/V04s9zzYPx1GfBXmHGTSWZZwcGbk40mCGZxFsBGWKmzN/DOv3dbyoJ1?=
 =?us-ascii?Q?hk69D9EIm6DDGOklx3V9t6gowWv4v8tASpqEulDko4iXUAuItDWc0PfDXA1c?=
 =?us-ascii?Q?5aEiemdgi4EcCAH9vuWOvz9BFXUmokdGy6nWgRF74yowYO/SLAqHvcctWZaz?=
 =?us-ascii?Q?6es0GokMJjvcsgdLQnoaUIszULFLyp9WGWTZKi5jbYDvZrqLP8XnUDG/k3bb?=
 =?us-ascii?Q?WduIBzDAQqZSRPunasudvQc+1FIgz7qiUf/LHPbTb531Tr0THstzfDj/oezP?=
 =?us-ascii?Q?qa8vbaUs08Vv/TWGnkSRBxEyxG/mttPOvYt1HncnUtPHNDrmsDIM62TPvwOj?=
 =?us-ascii?Q?BuJLuzmbF4Z/Ng0m0I6KsG21MVxwfA+tND+g1rgCImz5/Vp3GflvPW5eFMUc?=
 =?us-ascii?Q?9R3FkCDv+F85q3d3j7KmWurWY/fuIzsYM9C//hEn50DQLb1H7lgmrHgc8Yw8?=
 =?us-ascii?Q?Wne5EeIgAQqWlxxfWojjJjN4g3JMWPJyBx0FtnTmZpL1Hi5AfIOjuF91B0a4?=
 =?us-ascii?Q?IUyo4lkVlBJrkARUJJ6uazaAwjvHza5L7n+BYc4AA36NlRwCF7OoBrnoCZs+?=
 =?us-ascii?Q?k1H7Rdj5LjeWmMcVqpvf4lD1Tl4kjuU2KHpsw1YLkZ4mDzkID9wFUMeXulZA?=
 =?us-ascii?Q?NsQAnb/7k0tK3LRsrTuLSaaIBHDKswU8pShrFC/S+BkDRMyysdEs1EsEPDiZ?=
 =?us-ascii?Q?931Ckh5lFLDEZDa/Xeou8FpOM/WqUVSymFfa4fXh7Rm1Si9Zu9UlbaoxMBmS?=
 =?us-ascii?Q?WqztQbvkabH4Lnnc3ntIa7rCRXEiXZjCU0Rt3JnkiCrdhdlET1aBHxy/UKSP?=
 =?us-ascii?Q?hhqQqGZl+fMedmahPYpD8lovDg/pXIPunUsCKmPI29P+8cX8qFCPY7lDTujf?=
 =?us-ascii?Q?1K/36rTbfTcuDc6XCyCblr+Hbud1xLiiVQ5Z5XbjBgQFIgr6awbNg2k2SGXA?=
 =?us-ascii?Q?8EhQiLntbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07817f29-8ff4-47d9-361a-08da340dc57d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 11:51:38.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJIxoTgepMJqZYt5wui0cuxOQ2gmWQzBGT4samA4GKbkjTo/Fe0ABmJ75HMnImQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:02:39AM +0800, Baolu Lu wrote:
> > > +       mutex_lock(&group->mutex);
> > > +       domain = xa_load(&group->pasid_array, pasid);
> > > +       if (domain && domain->type != type)
> > > +               domain = NULL;
> > > +       mutex_unlock(&group->mutex);
> > > +       iommu_group_put(group);
> > > +
> > > +       return domain;
> > This is bad locking, group->pasid_array values cannot be taken outside
> > the lock.
> 
> It's not iommu core, but SVA (or other feature components) that manage
> the life cycle of a domain. The iommu core only provides a place to
> store the domain pointer. The feature components are free to fetch their
> domain pointers from iommu core as long as they are sure that the domain
> is alive during use.

I'm not convinced.

Jason
