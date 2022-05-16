Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03178528C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiEPSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiEPSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:04:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4627B1E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPDCMt5XrIy99g/vMTs9PueVuPMvbgqxusk23XqVBsrFVWsdoQA7ZyS1I70O4KsjDMjlrB4gB1KKADCvtJ0GF6TFiUDJ8KjSIrK+bmsJ3CDtoVxzXLg9QsZc2tyIsrXzk8pvW2r06aNWCJpiaTg4ADCzyoAk3cDwDHd2yvujgENEdK6AFhdQ+OmPepTYpEv2LYzPrm2RAJO6zjoLY1U8kuixcTXBwL6C3k8NGOTISMfK2PbJgnpSkELkBP7FHPoRnThBYXOWfak8cNNYvAVsNrR9vgJ4jLI+H3qeaBDdwNehzYQpl2nEA54eFAfsCoaBBqh9DCCWWCeNS50U79DbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qteYJ70k9k8QpBRgatBtBtnKEHF0LiT7+VIBzDVUl+E=;
 b=iFMccei4DAbUSzT0ytoq5avRhwmvYoux9Kkog5u+3Ysr3eFWJ+uCShtzGsI5ZMc7qV+V9ydmIEBaaEKZxRhElpSnWgNdliLvC1Q0dzfflOCm7Y/sVARswRojo/WDqWVs2pqd9aDwLI4s2HZc3rv2tuRvPPVVTPZTphMDtbwEMF1MNV11fvY5COFV8sH9C8uEEVmhfzGxh6MhnKQkGEqkFUx0nb1ilKWUCojriw0d3Z4BJTNobkTsLq0E8eDU1OOgsZjkZLTF9Z9/A/oChpnr2SUDgR2aCEwDfG0J1UxJ7qvIy1KDzMH9mwvg0ggLK51n/WUbrW9D/dq5rLml6YKwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qteYJ70k9k8QpBRgatBtBtnKEHF0LiT7+VIBzDVUl+E=;
 b=gB0JpOQ4bCeUyFpAQXtwbtcpFDzLQgIuYFZrfpXSd14uWVBglLEIaLys7LU6JZ+nlFEzWo/+/uj9Oyec52hiSCCqzJ4BFIyd8LoyfgkdLHdKc00GWNgYuYhhEqi+HuL7ANC4QYowdbP2QKsBibko7euMTUdQbc+wDRwQaHS7OakDzr4FT9ZLR7I2qLVDcej61KyolIAdmgxsiEmPSI3wpZxbWSkOTfBZiz8hLyrM1S+IxWdXYRzYNVTwvlcu4NtnoOmDUngKHNOCbrfeyKdMOw+WDkpByuwnlY1YzVensJ3xko4wy09x0pt0Kf1iuXp8NvzVpDHmVgkZMaxCBZJASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 16 May
 2022 18:04:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:04:13 +0000
Date:   Mon, 16 May 2022 15:04:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Move trace/events/intel_iommu.h under
 iommu
Message-ID: <20220516180411.GG1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3388ad0-0d1e-4b4c-cb03-08da37667bb7
X-MS-TrafficTypeDiagnostic: MW4PR12MB5642:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56425E54422A0BA3C4A493E3C2CF9@MW4PR12MB5642.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv5F1e8ATkWN0E20WcMR+OKljlTjR8w91S/V+0IIY/FqcI0fJCjdjlUWBGfZPHl/T0XZV+9wjxAumZM/TZzgE/ZQqXGSOf4XHq73SDGKcaucWbRlax+taTuFzBWApEwKknxrtAkJS2JQw8wJV6o/ZRaBTNkWVjl8DvaYyetTZv0wcFMFp+AUq68YUApotkgdVBTMuLuU0spW6E/7xQQAGWgXRAkul6tYP3yNe7mkGdFn3Nkqk0tFqojUug6szOyqnSDMTd34PaTxloIQDABos0bsiyym2qbWCa2TeQJh7wAuQtU4nClrbfZwDXu9ypm3M97FdiIa+FzZrcRpghQd5//TcyUUoOwWoWQbWm0fyK4H+9Ve+1zmkY7Ua/TWe/KE27NTcu/LZVZN5WFZnZfDRZB1jdoVRMLbC6Ypaw35L3TT4INWkv07TVUtJEXm3E/xJqcTZ18UVp+EhriDH82cREP2BMciGd7VToHhbyiLt+sZT3+4Eh+aIWgqMmnd9KVETNFIAdctjBH5YX9h0EO9/30A+sr0IrmfNF9H5XufXKaJUQLhnflXsSn2IhPZv/WpRej0+oqEzLSjya6G7X21E5a5oA9mTiXA6u4PckVZZajSoHXdHMPKT0nah+1lp+SdanHDCg4zVHdV1V+oJ1IfTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(86362001)(38100700002)(7416002)(2906002)(316002)(6506007)(66476007)(54906003)(6916009)(66946007)(66556008)(4326008)(8676002)(83380400001)(33656002)(186003)(36756003)(508600001)(5660300002)(8936002)(2616005)(6512007)(1076003)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dmIFO6QaXbYBc3fWphHhCTGNc8yv/61Dg3K8urOAAa6WXG0jspE4ExTggSF?=
 =?us-ascii?Q?0Qtr0xoEyzFcIIon892m+VvNOTdCAGVMr1NAj2CRxED+D0G9q8ywHdrLXELl?=
 =?us-ascii?Q?6ovrK32K7/2q437m8nSyDQ9FJyhvB+YwRVX2EUVWFE86KolutVf9jW6gz/Y3?=
 =?us-ascii?Q?FsPoamx3e5TPaY53L5L/3XWU1YW713fcRZYbgxFj+qZ8UiCyI1Re31hoK2dy?=
 =?us-ascii?Q?Wbb4Y5mip7JahyHcBZ8s0ojllIa9d1zcq+5qV5Vsc9quMVchqNGGpY7NXgMJ?=
 =?us-ascii?Q?wrVZdONkT8gvknVQUg/YYhlcN9U/XAQG5mydRmehouR0B5gG8uA1S10HNf1O?=
 =?us-ascii?Q?sZHOa/A31PswW+M/majAT6rt+tHvC2tnkB8CcASSfo4S/7TwKCnAU0ZrEEu1?=
 =?us-ascii?Q?5QaM6Eejd5TqQjN+2VWGAlk++FjKsJRdL2LMokLd1drAopGxVpTU+6NxmUz9?=
 =?us-ascii?Q?BiRGQ2KPAeTkvV5csTQkBuWkZdfBdIbA+itjWLMZyV1sNa8fXk3PU5U9yE18?=
 =?us-ascii?Q?Z66xEdDBBSvhcJN09PnMj+/aqI0Rgi8xCQsQkmY4cI49kmpDGabpec6yFOsO?=
 =?us-ascii?Q?8mWJClWEJ3rikInpBXsmHBGnpo3OLA3fglHdTr6AszAtnjRKb6BEry4pQuwV?=
 =?us-ascii?Q?epSgfsO2ipKW0aZY+6mL+FNffX2f4bz8ia1PtVYINUlZ1i2a7fFjHRGL9EDv?=
 =?us-ascii?Q?KNOaS9IDLegkpkuC7pxePWBhOH0g0Nj7piPSfKewWICc1PhN+WcPItDmFtBG?=
 =?us-ascii?Q?NEjYq91Ei+3D/RMjlOyxkkAUL6sk+jO4h+XKF2dPkh/KTa1O9k1vbio0RsWr?=
 =?us-ascii?Q?KrxICiqaWWcLNn9E1gRrJegLV4Jnha1lKl1kguLO/FGnMgIc5rIOT4xgcKks?=
 =?us-ascii?Q?9DYGAqFHPBh6D18AwVnWEfbdtR8uX+KQmdn8PcwaJtBrgP1RKp5yARgfsr/r?=
 =?us-ascii?Q?KwSLIKfLqLW4sLvaT6Ue8e3CxaIxksfgLihAMHOwdQeWCXRsUE0h0psmoJFo?=
 =?us-ascii?Q?2YbwH2+wzF/XRTweQltxAWl2/P8Mt6Xig/Og/G/alOTnyucxR4ddJQOZKGyr?=
 =?us-ascii?Q?6Mf6bZ6Nr9vfG7ra8Ubl1Fq3AF2ScS/SXvrnSQq+X8tzt2vU5h8zlRlRzB5W?=
 =?us-ascii?Q?+qCbBnNwhjnvsRfkJEY7ZX6O4IxkKt9NOiKMbs9DKyjG21ddBOjuNII8z31I?=
 =?us-ascii?Q?UqggTFFYcpPKmChgp6WSevQtg8vnVbDU2VY7ejndCzTggFBoUwXRPoxXZZ0j?=
 =?us-ascii?Q?FLmjDqWMBcaw8KWewAqBKvCw4VIxJzeDpQYjMPwHDD2Q6H4171vLFqjcO61v?=
 =?us-ascii?Q?nI1V/ataaKgYSn/jw3C4ueIYpcEGch10KUOeWmBaLbCtAK3TbImZsY0M+pzK?=
 =?us-ascii?Q?iJXe40KN3r8HEVVZMMR8/vdC5nTjOm4NgUcbSsuG+SULIf+VU+S95l+Zm89Z?=
 =?us-ascii?Q?yT6PKMig4+fAD2L+6Tgrytt8lHAdxwwfUzPMPmKL+lJlrzjzcrqEd6O10y00?=
 =?us-ascii?Q?7S2r5z/QMkwi+SutJ9YIzAMicRL5QhV6XFHzcxon6871cSuyz2pAqo96GjDc?=
 =?us-ascii?Q?fpcBKEWFhawmLjURPfb5o03QfOS9aPX4ecuRnuZKY4tF6LdjHbPjGOgCMg4s?=
 =?us-ascii?Q?Y1oPITue8j/Fiu85tWGFJlUlYpRbnWe4jNiqG5C56WfpKBTFGGGLuTEQKBs3?=
 =?us-ascii?Q?vsq0i8golv3GI/sl/mMOKaGxYgM94ZZo5/iTghAVcGb5SKjI6e4lpQkw5Eqn?=
 =?us-ascii?Q?DEUcrsgOZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3388ad0-0d1e-4b4c-cb03-08da37667bb7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:04:13.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUvux4DLpAFpCv4C8ybgUXUohgvvIh3hbHE6h3bKLvZFLuCQxnFcuCZQKx+EVHgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:16AM +0800, Lu Baolu wrote:
> This header file is private to the Intel IOMMU driver. Move it to the
> driver folder.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
>  drivers/iommu/intel/dmar.c                                    | 2 +-
>  drivers/iommu/intel/svm.c                                     | 2 +-
>  drivers/iommu/intel/trace.c                                   | 2 +-
>  4 files changed, 7 insertions(+), 3 deletions(-)
>  rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
