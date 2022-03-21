Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C04E2607
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbiCUMGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347215AbiCUMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:06:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326E5D5DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnOPKpgHZ4iCaalrC5g4dw1X4dGOOf+jYMQF2+RobUfOVAVncRQpFq87w92iPP3L8NJQbjtFGq2+2DETrh2OHR5a/5APPtOqRfUmiRcs2gURNPKgeb2Tcj4fHuKfFrLio7unDYdcZVsB0Mv7NsHVpI7B1FXaWBClBRsBjY1Ac/cE9iGl+/U+NO5zbCuZAZb99VR8CAP0cRVWXHeEHRfCuJBWQ0soaiE6InTKKQDtIDLoBh8apjDLmCHLM5GBX7BgUmezAyA7MHMUdZHSiOgFXEzOVfSsSyEfyOUXVsU5KX7sDfCDQW61+yMuwINtmGAQeo/Jl7mcoWY6WT8CK+1S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A48WT1vVx0f3vAgwXWr6Ncr+Ch9VF4nT6NdTTVMti2U=;
 b=V8opLu4dn/+ufXTqeEF31xh8bkvbiqWZkfzzmRnqer/rrfWeYlCMwFEGpKGzW/eTrBIdFxMZ0GiNRgfTpGji+g2nBtx7i1p9b2P7jlX/iORwDYtQr8lwcVuOPtWTYuYYlnW1tAYNyemwcb1PJ6/YlALXChuD/sJG/KYD0fBqawQezczLzHwWKm4vS/Slny79CtGGbQqjS8p6gvLh4YJ+vpRarmg9PeL+syZ04CpZeKozpgrF7yqmVOCbW1pBrkIRFBd7v7CpHcKhvnkZxUHh2adAkQBOYYgsQMjmYM9oBSTdlVdh3IutIRg5D3msMYdySLPkZYvzZjuOK6QAhdizOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A48WT1vVx0f3vAgwXWr6Ncr+Ch9VF4nT6NdTTVMti2U=;
 b=ffEvquUP28aNk5e+i7hG0uBNyazKsifoP029CGVc86BPxIP2Dj01vg5p+OnChBD0zltm0JFd2vlJ3K/YAMglptmTPjd5z+Z9S+wi5222KUnDDNVgAT0m9hrPiL/Y6trudowGpMtL0eoJN2Zozu5QSzO7ugwu7xh/VsjtGRIRUfVZYA8oUPnPOTJGLvQoeXZF0tFp1cjoJ+BV24HyAJCHqZBvEGUvHF/ltdh7s1BA1V6fRRZS8XWHQhoaImFh94VOTl1evx22ZvkVrlMqwjqogbpRMPyRMN9whSf5xtbLQ2iDVLw+uXsd+6V6v7FXdfCfPOuVWuDyDVlFIrWT8NgTrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 12:05:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:05:04 +0000
Date:   Mon, 21 Mar 2022 09:05:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220321120503.GN11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f4c5ed2-9696-4c51-e81b-08da0b3308b0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2503:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2503755E0E119F466A54626BC2169@DM5PR12MB2503.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +n6OqvqEi3VOS/9SIgVcS9ef+qDNpjwnzKlR2wXNMQd1OIZ4Tg8LSIO+1/UNrKUUh6gMs1tMGeAMh44vLgerj/ks9cYPXqHk+1E6YxFikXdmGEopr8PqNhT4y98M8EU/y2ClPYObj2QLJImo5NBLdQBLpFLa4khV7wrPyq+PuT1qAVewo3IESYKzH1DooJB3IzZJ1R3rdmtCfq6YKd7tvLN3nBSWun7pZkiSLswFPW5gvlfuWA+2eJ17LA8ltidyTMaHZ6+jzN9tMOJPUeGi7L2yO6wuM7ieasL+d7aXlxG/CHjoR+Oy18nN7kkIiDsMHU8Cf1Aqr4tjB0tFgqFFIwD0uDUe2LuWDCw7mu23+ftgOBhkmfTaGiyLrRSW/W4gDS9oofQEZ9VDdV/U1SsRstqLz9nyafUGNuV13tjle9jBciOG1Nd/qA1tzXKcp2IA+MGlO9fWdF1BO8kay359z6mgFzfQmNGDYH0WeGs2pdDKLaTH2gmscKxw5KH3LazSHijklHD8KVZhwjEkllQbOHMZAhnCB5MX78mNkP4QL+0cXwC24hl7MCvuB7fAWO0zQVeqi0f+5oS3yCDAx9bpYoIJJ72vQgkxMCbG0Nwz9Yqzxpw8z6bP41WN+5nQj5sPT4rwZ867e7oakSw8Nxwo+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6916009)(6506007)(508600001)(6512007)(26005)(316002)(186003)(2616005)(36756003)(83380400001)(33656002)(8936002)(1076003)(6486002)(54906003)(4744005)(38100700002)(8676002)(4326008)(5660300002)(7416002)(66476007)(66556008)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yVM3Hc31J9Pd/UgYLAb11lT33haYGDPGjLWKyX5+rUZI6eCu41fY6WTpsxs/?=
 =?us-ascii?Q?oDEeD4eFxhQzOsqhge3WmFXImNar1aneQ6cvBLRMhncq/Tb4v7Z6b/NLihEV?=
 =?us-ascii?Q?c+CCFJJsh2LPqBSDK01DdzavMAfCtXgpFJmD0+sMrk5VEcwIHDjfM0yihxuV?=
 =?us-ascii?Q?/6T4iTl+KdoHEm+y420hxHsfYCxNfJpkanF2+0S8rq7auHfFtr10GcLFCmYj?=
 =?us-ascii?Q?ZmPcchezVuZrXLESkUXMTDssjSokQhihd3TlsFwIudH5Y1uYojsksSc7GBLu?=
 =?us-ascii?Q?WNkqVtJ/dl5xgzNdMebxsLZc3o3wdC8fUjUqJLuGsWo5QUHsaDgSSQ0awibH?=
 =?us-ascii?Q?soS07ZX+3U7BxW97RT4EicZMdeYLUumE6PQFyP3Tk8cZc3OOU3WzLzcjs74+?=
 =?us-ascii?Q?tP2lHvhnHKU8mqi9qqsxpTZMixAcZ0C36IF6t0wdkGfbZXuFPF/GsX7vowwE?=
 =?us-ascii?Q?XkdaCL45fPEGlSlt7wBza52Dr0iD+LPWw16T4bHFCSbb8QHKabdM4dsSeYSQ?=
 =?us-ascii?Q?uvuGGLUNMwaUTEl85FbfmDsI1PI0D4C47JseLO1iTvER40A0Z9zN5sGGGVRO?=
 =?us-ascii?Q?rxgzkv5zFYJy7c7Zd+LLCBi3j/6QsEStV2NBqLgQVfBji25Ir1LU2p2P6sJs?=
 =?us-ascii?Q?dnrXLZ1KT1v30YmPCYhci6BTB5e8hNgX7ewMtUghgco3JRO0f8/WPTGpIDhZ?=
 =?us-ascii?Q?9SBzBM6TOldNlRcPuVtLLIOl2g3soMXjG90ofyA88Mwh4f/jmFAQCWVAWOyO?=
 =?us-ascii?Q?ryiJ4tcRNrPMC+wKURS5hZSb/tLsazKQzOyi7Pg8A/xxxz/O2g4NS5RB3Q/c?=
 =?us-ascii?Q?pV3fq9aApI8lu+Pxjsqu6B0hhxFfq00q0NJR4uFaTbvfQ8tK1Nygs1hwhfJi?=
 =?us-ascii?Q?z0Xkiz8gUuiVdt0rUeFfBQ+4dlpoyG8ywjRfSosww2jTn46GsFzkMQxy4P/i?=
 =?us-ascii?Q?88Uo1reXerFhhrSz4xReIF3zE7wPylLwR9Kifi8cMtMBhnVAFWS9RaMhXmC/?=
 =?us-ascii?Q?Ov2JQD0cSMjU05PAnWnT6WDN836/1zNv4paUfm8+fZkN2f3WzkS5QApwD8ep?=
 =?us-ascii?Q?NtOd4W0lbSw3hF3EnqjvQ0o04Riyle5AIE0Ma0ORWrcMtT29mXPPy1sj9pJY?=
 =?us-ascii?Q?5u8lbO/vapgRfgYwZfYI06Iqr5yLI9j95dhoidUrzwM30Tx4TknlKnwXclmB?=
 =?us-ascii?Q?JwrH4iXisyLOUhKCaRdyxYYqe9bJEASVGFcclImXOBfNd65K4au/yA4hZeJC?=
 =?us-ascii?Q?+lA0EAeHkn7piMzOG+7R7RBKFuWg8p6/4Pha8+RjPDS/a45rnQ1Fbl7GEOY9?=
 =?us-ascii?Q?A95Z1nDG6nF3XV3t9ITslXibOtaRrVPf0VjKZGSwecSiM/OHaIxXwKFaf34F?=
 =?us-ascii?Q?bNUjphBmAIykd0IHtLmiQH3n4eNoHOu/BOQKvhshqtopiM1LhxJVa4tqxA+i?=
 =?us-ascii?Q?WordvjmN4hTt3c6YUlleE2YvWRUpLZe9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4c5ed2-9696-4c51-e81b-08da0b3308b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:05:04.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slnMeyFAcbzrHk/U/VOPLuTGXy+Rcuv0qqTeqW5Sq1LiW+oJn3JuLHoVUQyOdZt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:

> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to it
> + * @drvdata: opaque data pointer to pass to bind callback
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)

The drvdata is never used

Jason
