Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC81585EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiGaMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbiGaMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:50:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20CED104
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659271842; x=1690807842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5s8pmA8w0gqPvbakPYM5YSx7bA7odSe3PkiFEZEGHwE=;
  b=iXxKeHBXaPDEwjVGjahRcd4ROnK8dLwkiGqXW+7AR3giOltSsWwbb6Zo
   VPmK/hvVkB9CwC4nmFzoU+OnEKQvcQTtiRXHDxLuGRJIXOc6qu9M0MInG
   qbRAKeaCtczv7gT85ojRP/rTKUHzKPZkK+MM3ccg6AmVgpppbOJa/K/V3
   tlU9oluQBuocMgVWKYg0xURJbgCaxiZD8Y3FansKZCDOGG8o6N1E0UOCM
   1aXSfzBcngYFeaFgmeIXDfxBs0b5KzUYg1B0lUid6S8O0DXwsSH+hjorS
   E/wY7Yu+mRmUTQsoIklxxyCQa4M1k07GgD0n4Qw5r0D00p59dnKZn59OV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269374680"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269374680"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634605413"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 05:50:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:50:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:50:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvvQQJIlYRpv3N4QYnu+S6f7xRxP0iRU8/EGLYP5hizJV4zX7QTWR276qswmZFozdHdc2+Bs3IRH+rihtJvQY+l1/OHkXW3DS9D6eaoruSeumSgq/KMvgx16NItZYdWZbB93yHmB1dnmG6e+b4aqM1jgDZPkn4F4/YWimKF9jmK6H04z1GsGAyqc/o4DKBhNNeI3iILXHiP3Pa/SE4afP1Lr8XfqBD7TkVOure+24G06q97VcX7GJdWqR/qLXyyvQxAAfGDi2NBji3coyl3We6gysRk373WQ1JJzPr3d3aj9tBSMeBOcOJpMZKLVewNfpY0Xo/dTgTtwaYa2O3FmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCC6ciB+Tk020++E6Ea+wTUwPmR9+bMP8n27Q3Z3y+4=;
 b=R7/xIPzbPugwF8wJ04woQm/d6G7M8Kq8k/xVD5jBbbRtkGQTWkTB8C+9ufzw6nCDukr23coa6dN+MizmM+kzsUQEOcTfosyz5Gk8sZHCANudyP8fvfSn5VYdvXZkyX4aN7/Etrvt1rHT7fEJ+whE0R7afuE45vPK75TdKVKFL5XGGipqpEZy+J/OZojG/LHEmM0mgrbvSQiAhlHuL++PVcRdWGty6coXvNph4numdDvdzu0E+UrFgA3vr+0yiqfD0Gt8A2aXQYstsqcZb4kwQasJ226a6JfB5Bk1C+vBst8SvHu7CUtwzYH6vkV3o8tSieRuR2d0LkR2ZuBD6Nmjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by DM6PR11MB3098.namprd11.prod.outlook.com (2603:10b6:5:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Sun, 31 Jul
 2022 12:50:40 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:50:40 +0000
Message-ID: <b0403334-1b88-e75a-418d-71a78ef97c9c@intel.com>
Date:   Sun, 31 Jul 2022 20:50:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::28)
 To PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72b56f04-827f-4407-f733-08da72f345a2
X-MS-TrafficTypeDiagnostic: DM6PR11MB3098:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pixU4SWdWFV7m7UW9kDDXWNxgnw3l/s5RqbolAP0Z3Tuo40kPsjAGfY/qGZ7w8gseTaEUoyelrCeKp01TGz7l1bjPRiwlFUf1L7UOBJDEzqiVWud+d3XJcpC4mBHMmEeZ+9B1+pMWVVejdhrjCfL8ZyElqO0C3+9qasWY8QGXrxGQfDQp9vNvPeI4QZae8E6AdjSk/6aI60+YzHWLSUg8vf1vse/CI0UwJuIkhViLCa6+cRJB1L4crHwi9Qg2onMleGBuksPvsZ9NaZLjP3DjlvxubXHDDpnLRDRE1bexTMf49+cJK/Ew7mI5rLg246RsMEGX30UMWqI29baKWwBqiwdZ+4/sXZsnCPvOqM/O1gxvkiakz6V3lxOTNNBhQf83s5LmrBHGKnv7sHbV5NbleKpRtLUacSlweuu7xKtPtoQYDVBvg2tPclFrx4qa+Ej/wwkSMnkDayi8LUNM39cdpmnSINoCRPrYRgH6D6xLm2sTq2unMU1NjuNgHVdQsxxoGvJ8H3Mk1YAzwFQwxIlo/pEhmmn7gUc1nhZnyxAQu9PvvWacPx1rEIquxegQRWO9nc7BK1OwyuRrN5RiA8cHb+imIji+SQzaMUJaFXO1kiRSJMQDN+e7A9k9DAWXYsUV3T6Yw1smdrrgkPGg8IiFFr2Hf9yPr2uR5thSNGSeU32AOieFFJZmAvU64YM9rSMajBEJ/7P6YX/PjcH8J+oKstqLhA/p/JzTgXNP1MpHWqoPNJpzjNUesd+ctENlGA4hOAsf3mkfozwzm+pokUJKvDuA4y+ceh5vtVM/U8ZXv5MXqKwBJXcX1DbL/4W52pYm9BNYUovG93y5efMSwSRVy52OP+tJlgsebHgmCLb62o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(396003)(376002)(39860400002)(2616005)(6486002)(478600001)(83380400001)(186003)(8676002)(8936002)(7416002)(5660300002)(66556008)(66476007)(53546011)(66946007)(4326008)(41300700001)(36756003)(54906003)(86362001)(31696002)(6506007)(2906002)(38100700002)(6666004)(316002)(6512007)(110136005)(26005)(921005)(31686004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmpCb01MdWwrbXhmOUhCd0JWU2hOYkl4VTRnUlg2QzdkVmpPMFAxM0lrOURO?=
 =?utf-8?B?Qy9ucytGdDBwUHJralJKdEFjb28vZmhSWkhYQyswRUZjaFcrYWE2aldOY0lz?=
 =?utf-8?B?UGxTZUY5SnNoT2hzeThNdlVTUDFnNkEvdVF0eHpvVW41bTZNM1RMR1piNEky?=
 =?utf-8?B?QXJybjBZNm5SSlhtcmtVUk1GdTBsNUwrWFlhbUFxU2pma2RMdlArbFNaOW5p?=
 =?utf-8?B?dkFWc2diQ1I1eTdXR2ZlYVJNdUZ2anVYUUFNYkFvVU9PV0o2aksxVnJtRmxU?=
 =?utf-8?B?VWxKTklIcHNNK1pNZGYwMDBqNWVub1l5ejNTU1IzYzlwN2pEYXlja25YMlJI?=
 =?utf-8?B?ekNZeHFpc3hNdHlNQTdqOFJnbHFlOHhWa3RSZUJXUmZZczdhdEVKMEt2RWJj?=
 =?utf-8?B?aERTOHNQK2FBbXlmODUxbllXcUl3eUNucVc5c05hRFV2QjFwRjZESWtDUUZj?=
 =?utf-8?B?VzUxeXNrYWVzazZkcmxjY0NVYWpTTjBaM2xBZEVTZDRPQ3E2SHRVTFhwNDRL?=
 =?utf-8?B?ajZCNHBVaC84N0ZhYnNKS1R4MUkzQm5YOGRoNUgwNnFCVlh4eWhkeWZqdzhq?=
 =?utf-8?B?ZEk2NDFzY29MMW1NL2FZYk9vb3NPd1U0YlRITU91a3hHT3Zodko5WG1CaDZz?=
 =?utf-8?B?Qis3VDIvL0JFRUJIKytpL3pzRlRYUjlOcWhWOUxGMGZFZVlnVnpCWWFKY1hT?=
 =?utf-8?B?Z1M1NFZLYXpyNlllK0FBV3dOWEUzMU5yMnZseFphd2lBNzVLbkcvRllwZys0?=
 =?utf-8?B?NmpFVnh4SDRmRXlDeDJYL0pSWE9jN2NhZGRnVEhEejlTakVzLzYxVk5pNmtQ?=
 =?utf-8?B?RWFzQzF3NjdNZmM1eksrRUk2bWJ2SENlQWh2bndMREd0YXRHUFVZWFRjT1Mv?=
 =?utf-8?B?RjZXaUw2cDRLMVczR1FJNUN2Z1VlRTB5TGxZdXFjQWZlckZ4ZzZremJkd3dn?=
 =?utf-8?B?aDQ2RjB5aGtQS2liV05zSFc0UEpEcFhteklPYW84Qk5oOGVDcW5vU1E0WjI1?=
 =?utf-8?B?c3RhWmFtaEp4MkxTdklnY2dqbEtVY3ZkSm5ocEtWdCtoMWlUOS9VLzBKTU9P?=
 =?utf-8?B?TW5uMjU1NXdPMWpkRWhpdkY1eDJySWRXTHFVb2s0ekdJWGZYeWZFRFRvODRE?=
 =?utf-8?B?cmFVRzV1TFFpSGUyK2xZV2hDL1dkL0N6UW9OTUZ1TWgwMDM3eEkzT2FaVVJS?=
 =?utf-8?B?aERwUjlwZXE4L2dLZWVZZ05TMTJnRElBSWhtSnNranl5K0QwN3BqV2I4aG1m?=
 =?utf-8?B?RDg0NnMzZ01rU01McGoxYjdpY2dFblU3eGhGa1BocUF6MnlaQlljUHBZTmZN?=
 =?utf-8?B?YXRJRnFFWlp2ZHM1UDcwbkZQRFBrOURVdTdvblJZUUVEY3dxcVZVY3BkaE5M?=
 =?utf-8?B?ODJLdEZUSjVZSUkrQTQ4V0MzR09QL2U4b0dIeFh5RXZqUitXVTFtS3E4OVNj?=
 =?utf-8?B?RTgxM055SG9VK294bjhlSXJ2bHJHbHJrNk5GZ1FLZ3FCMysxRG96TmIyS2hO?=
 =?utf-8?B?UVpKdzFJNEdUQWViTmFBd2d4eGlTWlJveFdPUkRKaW1zNFNBTm1uMnZ0SW5h?=
 =?utf-8?B?UjNUL2RLQnByTVRVRUx6MjI4TUs4NVhaLzAwWEYvZUxEaEduMkJvc2tyS2Nw?=
 =?utf-8?B?SS9UTER4SkVwbldnR1BlZUVGQURHcU9Nbzl3dy90K0hvcnBROCtDMGd1eldo?=
 =?utf-8?B?d1c5QlRqY01RdWNJYlNHcVVZTHA1TzNURG94d2NDWDg4ZjdjeTM1ZDdZTTV5?=
 =?utf-8?B?dkE2cXRzQVBXU3ZjZGhWclFRSFZ0bERmbC9kMHZ2RWxPUG9mQ0pDNWJzUEh0?=
 =?utf-8?B?VWN0NHRnM3FlWkhGY1JSby8rVmJVaUFCS2ZKUVM2Z0kyTjBac1JYajZEdFFP?=
 =?utf-8?B?anBybi9iMGY2U0NmUTdWYU1ZM1RyQ1ppQjVnNUpySy9naW5HMEZDSzRzRFdx?=
 =?utf-8?B?VWR4YjNhaXVFTnYyeUxzaGtoTEhyTFJGaEIvQmx6aktNVzBlUUxpbzIwVUJU?=
 =?utf-8?B?QWNxRk5XSmNxVnE2VEk4OGFLZTdKL0x6UzhDYUpQUHFud3hwOHU3VmRFNTYy?=
 =?utf-8?B?TW9COHFJbXFleklSUVJ5OURlek5sT2dNQjJNN3BpR0tJSkFsVkF5b1JIUGx4?=
 =?utf-8?Q?jOBfWh8K3552MRyQ2L5uyR8ue?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b56f04-827f-4407-f733-08da72f345a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:50:40.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoLD4wdg+FQIKebzk1O/aVYVL7Z+vDu2j78t1IpM8lsp7YykOFAyoV9wpDUSvizYKt7QYsR2oJBiyRxr1VifTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:07, Lu Baolu wrote:
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
> 
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
> 
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model. The I/O page fault handler
> for SVA is copied to the SVA file with mmget_not_zero() added before
> mmap_read_lock().
>
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h         |  3 ++
>   drivers/iommu/iommu-sva-lib.h |  8 +++++
>   drivers/iommu/io-pgfault.c    |  7 +++++
>   drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c         |  4 +++
>   5 files changed, 80 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ae0cfca064e6..47610f21d451 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -105,6 +105,9 @@ struct iommu_domain {
>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>   	struct iommu_domain_geometry geometry;
>   	struct iommu_dma_cookie *iova_cookie;
> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> +						      void *data);
> +	void *fault_data;
>   	union {
>   		struct {
>   			iommu_fault_handler_t handler;
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 8909ea1094e3..1b3ace4b5863 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -26,6 +26,8 @@ int iopf_queue_flush_dev(struct device *dev);
>   struct iopf_queue *iopf_queue_alloc(const char *name);
>   void iopf_queue_free(struct iopf_queue *queue);
>   int iopf_queue_discard_partial(struct iopf_queue *queue);
> +enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
>   
>   #else /* CONFIG_IOMMU_SVA */
>   static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> @@ -63,5 +65,11 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
>   {
>   	return -ENODEV;
>   }
> +
> +static inline enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	return IOMMU_PAGE_RESP_INVALID;
> +}
>   #endif /* CONFIG_IOMMU_SVA */
>   #endif /* _IOMMU_SVA_LIB_H */
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..aee9e033012f 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
>    * request completes, outstanding faults will have been dealt with by the time
>    * the PASID is freed.
>    *
> + * Any valid page fault will be eventually routed to an iommu domain and the
> + * page fault handler installed there will get called. The users of this
> + * handling framework should guarantee that the iommu domain could only be
> + * freed after the device has stopped generating page faults (or the iommu
> + * hardware has been set to block the page faults) and the pending page faults
> + * have been flushed.
> + *
>    * Return: 0 on success and <0 on error.
>    */
>   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 751366980232..536d34855c74 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -167,3 +167,61 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   	return domain->mm->pasid;
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> +
> +/*
> + * I/O page fault handler for SVA
> + */
> +enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = data;
> +	unsigned int access_flags = 0;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &fault->prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))

is it possible to be ERR or NULL? The mm life circle should have been 
guaranteed by the mmgrab() in iommu_sva_domain_alloc(). Perhaps coding
issue if it happens. :-)

> +		return status;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> +		IOMMU_PAGE_RESP_SUCCESS;
> +
> +out_put_mm:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	return status;
> +}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e1491eb3c7b6..c6e9c8e82771 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -29,6 +29,8 @@
>   #include <trace/events/iommu.h>
>   #include <linux/sched/mm.h>
>   
> +#include "iommu-sva-lib.h"
> +
>   static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
>   
> @@ -3199,6 +3201,8 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   	domain->type = IOMMU_DOMAIN_SVA;
>   	mmgrab(mm);
>   	domain->mm = mm;
> +	domain->iopf_handler = iommu_sva_handle_iopf;
> +	domain->fault_data = mm;
>   
>   	return domain;
>   }

-- 
Regards,
Yi Liu
