Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7772E585ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiGaMTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGaMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:19:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6F11A19
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659269949; x=1690805949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jYwF2MreBT2vl+pFjnrgEb0gZPMd2Yc7WoZAh7+G9oI=;
  b=JXAOV//1+t1GYDAxGFbloXDc7aFfuOEctBwI7QQqVcHNOrj5b/sqN97X
   hBbAEx8iWXgtRfy9JEeaDvzr1YiAsAcT8a4C7u8is1esEpPTl47RIauuX
   8o6qMqhjZf4o7aZqfFlTslA6qsElwh/AiiCeyWu8YivvKst/wAnCM1QPp
   qxL+YJPJj3tvduLmfgfm2nVd/0kNMsLXzbrJJM4iviKk3WbIOqH8fcOAx
   qWX4J8RdEaXuaLbtbZlYTv3vForTDIuRkhnb/+sWxRIQ4mRxQrdG+qKo3
   AvddRtT3naVybWdP6zYYYtWnxSacB2qjdJQGtmZ0ooCSgJLHO3+UKOiOD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="272034546"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="272034546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577474527"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 05:19:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:19:08 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:19:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:19:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkkGERty50c+VpPngpHk+1B391gZiq4t7HeROR2/IYmmpSK8rBNp/O0ZpcmJZHBgEAZGACbem2CywFGx7CKt1sX2VIV20WDIa1yCRcFYa90DCJQYiKUmxnP+Ju3A1ZF7teGSQavCSTubNSfFYg0rhSaEmfrsL7E6rRGYqQJoSc9POWLBaqkon7rRpWoiD0JxMN/jYnPqT56w1ZiqJ+fISIUjQz9JgmiBi5TRT4g/HAJbpbxn1x+Amblg42z4GyM5zyxeAz/Sflns3UsFTftJGxJaDymNlRgC2ekqS9xT69lFY4AabJmVc5l894NsGcB50613+wKbk+YbWfKO9jEcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7fwlHV/8+Pj8v76+vjmLwXCImtPscLOUkJfSrBMkxY=;
 b=SlxuyUBzsdEQjpdTYFXmqBkva8UQg/wuueHmBNAxcVfBJfO9xvG4N8FAWp7XKZEW++AsYaqrhtjA5IWmK8vitM5OK4VipLkurqodm3PdjFS/bWIH+rt61dNqedMM4hGLwROVWr7zrPoHqRX/YY+YvxGBcNInOkLjzaTBGo1ZqSBTIwKfOD98loFXOeSxX0duy5sflJlch941xLvgPB0X1n0TYpav8fYdQahGmzi6jGPPojxQadapm/pcc471oaodiKKC+CM6Dg7CRsswLIuGeFEGnALFq48j1GeQ+bEYZ/xlgc/Wl7twB6QBl5p5Qy9vOztDzLM3XQ9fgkfenMSe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by DM5PR11MB0026.namprd11.prod.outlook.com (2603:10b6:4:62::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Sun, 31 Jul
 2022 12:19:01 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:19:01 +0000
Message-ID: <35ba52f0-c492-9f29-980a-3c7bf572450f@intel.com>
Date:   Sun, 31 Jul 2022 20:19:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Vinod Koul" <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-6-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4a7eda-657a-4557-88cc-08da72eed9de
X-MS-TrafficTypeDiagnostic: DM5PR11MB0026:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jduqwtgjfQ5Q1MKySHiPQucW/jVpQrZt2SaRTvYjjbPqZBejyuRLpbn/gHrv/r5R4rVpy17rweCNcz1DbMhHqEQYdiAU2N8JiE56TVTZHPSdm/p8RUQ7yRm1hjK0Ya53N4/WUnGbORxW/+4qSadzC7LNa/G0hzqeX/u8bomePF2IjbWytUmAyeRcN9mNfpo4G5WktjIIRRqhvziGY6cZev578sSo4UO7dAQyKzcd70SxK6dKagyRiPQilGHQXntxCoLxXJ6hTWCX2ecF/MvZDCd4rim3Liha+An1BstPxHDcPESnsmiZ7Pn4eVaP2/bJEkR5yHgl3O9SAhakFidKmzyml0jvmcFm5PVzSP6XQ749BcHXUxIcNuh7zna1xQO1ovoLk15bJuZfNKZVJG7sp4pJBAuNTf0wxybj8qeVAxHOYTGZguMIkQSFSj4BxWqKc2EKNCJN6ZekNwx5wA8irDQLKh6UlBCEWIqYxtahik6IMfn8aB60uLZu2p6Ozr/K4LVsXgBKy7J3L5VO20U7TK5x9zXrI095aLOlM882UBNHzLjBSC3EoeVh1U8UwWsD3s6Ahzjsh3HHJC55DV927Z1HIxhHxPT2p7ga0u+zrAlhe5fKsrIoOa7EUrUP0lQLHmv+SbQutOsIVFQR2/Gpl2Kz/nz1yHy2ch/0KJ0fPJzWSMAVhu5132YHs7i9BFspz6sSa0VMvl7EYRnxbR4P8Nv17yCSw5N8mPiq325j0FT4ojY8RDuWN46HJyp3KkB1PHDdhACNLPH9T/YaKiPxyHg0rQzBfI8RQodz1fWv0CoB3w6dQVdomrzdH82zPVi1Z+GFOVPEbr1S+DcFXvPE2gUsKw8Du/kcwhQ9Krd6pEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39860400002)(38100700002)(921005)(478600001)(6486002)(186003)(2616005)(83380400001)(82960400001)(6506007)(6512007)(41300700001)(26005)(53546011)(31686004)(66556008)(31696002)(7416002)(36756003)(2906002)(86362001)(66476007)(8936002)(8676002)(66946007)(54906003)(4326008)(316002)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJBYWRhY0FPa2EyTk03SkU4ZlhtdDdUUU81Y0ZOcXd3L2NTaTYzNnBaUFBq?=
 =?utf-8?B?THhBSzljTXArWUppTFh2NTVUdkc2elJGN3BlWCtHbVRLQUkzU2lQZmhjdnFK?=
 =?utf-8?B?Sy8wWjlMY1VwQ0czRDR6YjUzd2UvQ1ZVekpoYWFETWJOeWZyZTBpV0hTakpm?=
 =?utf-8?B?Wm9vUDFiMGhQZm1YRHYzQ05rQXMwZWM0dlYxVnZKMUpkTlZQckVUV0ZWS3Bo?=
 =?utf-8?B?WW5INHJock5CRm5vaXc2c3hDZWhwZjFIMXRRdmNKUGNkUmpSYlFWSllxOUsv?=
 =?utf-8?B?WEphU1NISVZxN2ZoUkFzUisxWFNKQnhUUVFTNkUwMnRKTnRwcFBRWm8rZmlR?=
 =?utf-8?B?b3ZFQ1o4dWM0TVRtMWRNRzJSUXEwQnpvS29wNlNaZkx2VHZtcHFIYlg1V0JQ?=
 =?utf-8?B?cjNnZkk3alQvb2R5VlpQbENvbVJiL0VtbEhaTGlQQ1VhNEI4RVBBbzNrM1k3?=
 =?utf-8?B?OExQUDBoNjhTV3FjQkhtdjVVTHFMcElucFFMMkExWGRJRkh5MEJFWXU2KzMy?=
 =?utf-8?B?Tkxvek14YXVhMXVBdE1iMjh3bkxkWGthcTRQTjNXY00waDhidTBTYktXNnlt?=
 =?utf-8?B?ekJCZ1lWdE5IUTVNTCt4ZEx0TDg1RjdSeEMyWW1SWDJZOW9ZUTYraFVqendU?=
 =?utf-8?B?TnlheVBmMTN5dEU4Q0pRaloxci9wZm8zSWQ3QkRua1UrTElrZkJad1V4c0Mr?=
 =?utf-8?B?akZnRWJEMTcwN1ljSVRqNGpuVk84NmFQblhyU25BWjcxMTB2OTBiSDRISUZS?=
 =?utf-8?B?UFI0SXFsWVA5cDNnWGZrMXRuWUNkdDZVRElDODF6Y1dSbit5OFJUVUE3dnlZ?=
 =?utf-8?B?bmFQY2paSTRJcUp1S29nNlFvak9sSTZzZUhEMDVxRjR0NVBZZlpPRGw0YXJB?=
 =?utf-8?B?eTJzSkZrZDRhSUZ2RkhPVG9tUGF5cVBmbnB1OFhGbnczS1dyWE12cnc5RDRS?=
 =?utf-8?B?Y1dVc1ZwRDRuLzNhYWwvY1BsK1lUTzRmazg5Mm5UM3lDM2tjaCtRNHBLSXJY?=
 =?utf-8?B?cVJ6TlFoNzBqaGs5MmlER2ppUmdITFdMQnBJbDBRaVVuZ3dsaVZ3a1o0ZXJt?=
 =?utf-8?B?RlZ1ODNKRG9OdlBlamZ4Vkk2dzVTQzU1bGwzN1Izb3VsOEpWK3pxMkV4MG81?=
 =?utf-8?B?NFU1ZUxOTkJxbkdCbEZRVzNGM1psczRKblVBa1JpQlpJeDI3UmNFT2V5bjl3?=
 =?utf-8?B?ODVXQnhNL29kNHgyOXkxS1JCTHlpOE1uT1p2eUE3NW9CbmZwTUl1UEZNVzl0?=
 =?utf-8?B?YW1jY0J2NzRHKzdwS2tJdWlzNEE1dG1IYUptcjJETXFFYnplUXBJS3d1cmtu?=
 =?utf-8?B?RUlwVDZxRnY2TXBEeVRwNnJwOEQ1Ull6RDhxM0dFTXA4K2JzY2VWZjhqOEtW?=
 =?utf-8?B?azlVTDhBY2didkhaMW5PUDZwSzJEOEY3VkZjUGw2RDRweU1FWkpoQjY0RFpk?=
 =?utf-8?B?bHpjMklnYXRDeGVUVEJFblNEbU5Ubm11REJJaHZIR2tMeitBUnpDbGtRQ1cz?=
 =?utf-8?B?b1JVRHpOZEtYREQ5eFlESnJTdlNxaTFWZWxWK1FzZzF0U2VFTWx2Z2dNWCtL?=
 =?utf-8?B?b3FzUHZVQ0E1b1djKzUyc2VxK3hsWVJHRVNhVnJ2QTFKQXlaWkpaZi81QTVx?=
 =?utf-8?B?SnpZdEtiMzN2T3VLRGtJTS9ZdEdiZnFVcnZiSHJYaThqWnJqZW5tWDA1L3hM?=
 =?utf-8?B?U0xQYVVQaG5kVTc5aFNXMjFLYlhGcGtmZ3dPWlVBTk5EanVzNzkreXRmem10?=
 =?utf-8?B?QmxIcFkzVTE5RFF6WkUyQ0JDak9UbTY1SkhYQ3FGdVhUYkEvMFR5aldlRmxJ?=
 =?utf-8?B?UFprL3VhSjJ3ekd4cFhRT1Y3eVc2TFB2ZUZDS05hdFVQa0YrUVNDY1FnRlkw?=
 =?utf-8?B?eHBpQlpqdHhYL1EzN2dtWHhhOHVSdjZlMzBRWUhDeDhsOVZtRlJWN1g2d2RY?=
 =?utf-8?B?UWh6WmszektPZDR4Q2Y4aGxCUDZGdER4V0xpS3VIZlYyS3JJUUxkRit4ZzFH?=
 =?utf-8?B?UWRWQjdsTW1CWm41d1g1N3N2Q2hFdjdOR0pGVXYranBMWHRrU2hGS2Q4M3Bw?=
 =?utf-8?B?K0xzeENxSVJ3SUVUTmtReDFUeHh3Z08rSEM3K09vNWp6bmwwQkVDamlOaFla?=
 =?utf-8?Q?0WQR3g8My+QexRXlX8rKY4P1t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4a7eda-657a-4557-88cc-08da72eed9de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:19:01.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXUCzNzEuLRN7fpCpf/u64SisfGGM5OHOYp+XoRAL1C8hhbiZw7I0Sseqh9fp2KeKwf1FHUnt7R1WJS217A2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0026
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:07, Lu Baolu wrote:
> The sva iommu_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
>    type. The IOMMU drivers that support allocation of the SVA domain
>    should provide its own sva domain specific iommu_domain_ops.
> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>    is still used to free an SVA domain.
> 
> The report_iommu_fault() should be replaced by the new
> iommu_report_device_fault(). Leave the existing fault handler with the
> existing users and the newly added SVA members excludes it.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h | 24 ++++++++++++++++++++++--
>   drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>   2 files changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f2b5aa7efe43..42f0418dc22c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,8 @@ struct iommu_domain_geometry {
>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>   
> +#define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
> +
>   /*
>    * This are the possible domain-types
>    *
> @@ -77,6 +79,8 @@ struct iommu_domain_geometry {
>    *				  certain optimizations for these domains
>    *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
>    *				  invalidation.
> + *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
> + *				  spaces represented by mm_struct's.
>    */
>   #define IOMMU_DOMAIN_BLOCKED	(0U)
>   #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -86,15 +90,23 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
>   
>   struct iommu_domain {
>   	unsigned type;
>   	const struct iommu_domain_ops *ops;
>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> -	iommu_fault_handler_t handler;
> -	void *handler_token;
>   	struct iommu_domain_geometry geometry;
>   	struct iommu_dma_cookie *iova_cookie;
> +	union {
> +		struct {
> +			iommu_fault_handler_t handler;
> +			void *handler_token;
> +		};
> +		struct {	/* IOMMU_DOMAIN_SVA */
> +			struct mm_struct *mm;
> +		};
> +	};
>   };
>   
>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -685,6 +697,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>   void iommu_group_release_dma_owner(struct iommu_group *group);
>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>   
> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +					    struct mm_struct *mm);
>   int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			      ioasid_t pasid);
>   void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> @@ -1063,6 +1077,12 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   	return false;
>   }
>   
> +static inline struct iommu_domain *
> +iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
>   static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>   					    struct device *dev, ioasid_t pasid)
>   {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index be48b09371f4..10479c5e4d23 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -27,6 +27,7 @@
>   #include <linux/module.h>
>   #include <linux/cc_platform.h>
>   #include <trace/events/iommu.h>
> +#include <linux/sched/mm.h>
>   
>   static struct kset *iommu_group_kset;
>   static DEFINE_IDA(iommu_group_ida);
> @@ -1957,6 +1958,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> +	if (domain->type == IOMMU_DOMAIN_SVA)
> +		mmdrop(domain->mm);
>   	iommu_put_dma_cookie(domain);
>   	domain->ops->free(domain);
>   }
> @@ -3274,6 +3277,23 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>   
> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +					    struct mm_struct *mm)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_domain *domain;
> +
> +	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	mmgrab(mm);
> +	domain->mm = mm;
> +
> +	return domain;
> +}
> +
>   static bool iommu_group_immutable_singleton(struct iommu_group *group,
>   					    struct device *dev)
>   {

-- 
Regards,
Yi Liu
