Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA8585EE8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiGaMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGaMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:38:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4FDF8A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659271104; x=1690807104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mjo5qqo//vEudgemm1heExzIxEB3AGMdz0FA6V0OT/0=;
  b=HB79cndJ8o6uhxm5GpA1KVzeivRccEPX1jJXndS5FIFrASslD9R3f+hI
   t6SgSuSPJzxdKY46jiTg+KfjqLZwav5BymjPvFvSmggbmVVD6UQmZ9lb7
   Mry1u9vcKNUBEMcrGTV/JlIfEqB3KRHDwTeT/p+pw+wR8wB/9LTPogqjC
   Y/ro8aab2ddPAn/sJB1mwS40N8sHfrJLjkKiraY1Yu2oLlpHSpYc8uGfC
   LnvtmutHW3gAfGQimhCLI0iQvEAdU2w9XCepDTjMh5j9AL46EpmQNtiyD
   yRjUUCcChH0ZrAipYi4/g8CPCb9SXxugf19T27sJC90SvEkj1qCISImCf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375295718"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375295718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629922017"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2022 05:38:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:38:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:38:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRbbPPbCG2u0IpuNJqWwWO+XSiVydjdUiGam7L5Hu27LKFYe29+ExjLB2lbKUipwSGkZRcabxgZVdluWA1GlPoDzEHcfGfRmEUjOyv6FH018DB86VmG/6Pb/PjoeCF0/BFn3uBeilcOqCbFcbgtyQDprWFXfrB7ttQFG1E6kCX0UUjNjr/C8I55nHwzz5LgdBdxuwe+zqteg3ul+NHGU6bF1F2ysHNMukCWAn4yXE+LBql8wjOYuEegtR84iVrZm7aWiY/z+Q8tHjbdniX8t7XsC0kebl9uDZFfoBmwn2OLGpAIdbq3efPrZjt365TmAKtfWed5O+HJYNdxrE7Jj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WJNLb3afjvMviXAlCwZioO43bMge0tZiPTNHJM2Zkg=;
 b=jvEPG3j6GMipTJ3ZNK2A4Qy5YlQri3mPseA7ABBUnvRzSY1XOycyYZl7Kc4Sgp2MyW0HLTNYT46fTExm1vZ9i6rfzmtNFgEXs5SqAPIehkFG76HO34PJOMswmmJBr9vFOY9YWhsuSGxD7CaCMOcl9btnEpIVCTyPlD+jTg5GH+52J2IfIzaLOPpwbulL90x9H0Sy45qHsydgy6XRDvc+z5wyatSG6Ij+feRiXzetydmUmQ1UhBjVr2e9aQMq9ZnXDZKBmBQERp+nIRG+xktRXBP5UFOzhvkO+bh48PCKmjk81psrMOIzFJChCX0uhKy+73vR6dUhMHCy+WCN701MJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by CY4PR1101MB2229.namprd11.prod.outlook.com (2603:10b6:910:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Sun, 31 Jul
 2022 12:38:20 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:38:20 +0000
Message-ID: <f4dd1f2c-56be-d469-7b4c-dc14c51db902@intel.com>
Date:   Sun, 31 Jul 2022 20:38:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 09/12] iommu: Remove SVA related callbacks from iommu
 ops
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
 <20220705050710.2887204-10-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53217ae8-7c9e-4bca-5400-08da72f18cfa
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2229:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qrRIb1pxFikVkhYdcEHXex4tC5RovoMRCmxqdJSIH4tcWwekG2gE9aooXYhiOhduLPLrHUbyw6oVaTHAvkSM1oKsPJib1hnpT6KrZBprUZGHGD9/5mazA/U3ON5WlwZ8fF8tysthZmZ+v6DqRUoiBDmawuesiOnE7YlJZINZRu5OEeWcyt8ffPsCFhQR00ckIik9l5MsUN9Awi4EKY14Up/D/RWc41eXGu8GpL0nR+SFeC5KZEyIH9PyZI9m5B2L5NWv66o+XL+eoduRuLL7ukymIRlIwktfbzjO4kt1hn2pHWrbyT8Vj96gar6U85aPzQrj5533o8BUBljFLShczaqa4iASkaoRTsxF9dunr58pD0Y9kVFES6FEHpRfnpLVcxX7UjM/fuNBTzH2BqT9Rq7Ncvlqr1W3dsfBMaXi2VA31/BauiJJj89yGnBbo4n9h05rTMiRWDUiqpA8i9lPoYxD+KC/ejE4/F33CbVq90bD5r88wAKDnlAT5u+GNwOnTpzGlF7HyuvKWqp7IOqW15fqrdPbxF+zqg9UX2IxgswGKbm/R7Pf3kVvQuYvBqvJBARGkxq93i3WkNPJjxMZyjpSi51rnZOVU305+cOd8TfpR5PSYNXwT0UcW7u7F31ySKWK7NfpCuu1OZNDtfkEHtRlATPmBx304WQxG1LQJ4qCRSPeHJGlFyqoN8wDEEtX8zyIHZ9qNU0HJ5yjrD5CQW2q95JvAyhfljincIVNvWkZzAI3uwsdCpdIVYmR5gXROy7rHCenTfFv/ynQb/lNDvx4t08BucNhIGhDUantt2Z81g9D0vt0zPvBvDuPoTmADqCqNTJZngRpJjrEfNsDX/rjHt7CBgdIzxNLF6iTbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(186003)(6512007)(26005)(38100700002)(8676002)(4326008)(66946007)(31686004)(7416002)(66556008)(66476007)(2616005)(5660300002)(36756003)(8936002)(83380400001)(6486002)(54906003)(2906002)(316002)(110136005)(478600001)(53546011)(86362001)(921005)(6506007)(82960400001)(31696002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXF1ZUU4Q0Y4U2ZJZnlLQWcrdkEwdkdveTZaMEEvWGllcXd2bDlvRldqZWIy?=
 =?utf-8?B?QlQzaXpwL0ZJelBqYyt2Y1M1Qkx5Q01mb1htenJ0VWhTSUR2YTV1SGZmbTZX?=
 =?utf-8?B?TWFsZGVua25MUThyYzMyZDlPNEpreGZGL2VGU0JXQjFhQnFYQ1lYOXo5eHVE?=
 =?utf-8?B?ZVJVWlB2d2grZzdYZVZFdUllcWJqTEdUandFKyswczJNNlJSODRCNGplczdZ?=
 =?utf-8?B?QXVPaVhSMzUrMHlLQ1RWb2NMNXJESllObzRxNU0vRFRMWkNmRk1jbFdzQWNW?=
 =?utf-8?B?UTF0WFJ6MW1QbldMZndLd3gwWEZTTlpPZUxhWlZpUXltcmVYOWl1Q3l4UzMv?=
 =?utf-8?B?YkpRZ3N2THl2U1pYUTVYbEVIVk5ja1hGTFB2a3FVbytydFlZUlh2NXRmSnpH?=
 =?utf-8?B?SEsyeXR1ZXlkMDhLZ0ZndkJyTVJsWFFvRlNxK0I0YmYzb0pudVJ1cGRSNE1h?=
 =?utf-8?B?UFNtVmhpVlBYZmRQNUFsQ3k0UlJYbFlQN25MWFVqaFg1Qy84MnBTVjQ4eU9u?=
 =?utf-8?B?cEpkQ21Cdy9JSmhmZHFFUGFRd0pVUUZXM2UrYzNSNHlaVmxBeGVKV0dMQkJJ?=
 =?utf-8?B?dHJSNk1VSytOV2J0aW9XU3pmWmJLaU5uL3cvS1hQbklnUGpYQ3hxb01lK2lC?=
 =?utf-8?B?MWhBK0ZqUWxQYmFkRjFwZFFkYTJvR0dTciszem9Pb1hXS2NxYkpHS25UUnQ2?=
 =?utf-8?B?NFVwWERtQyt5Q0JveUd0MnF1ZERTNTRrSDl1RDdBSDI4aDE0OE5FMWpkdDFT?=
 =?utf-8?B?MkdsL3pBWVpSNzhqQklhVGhqZnVIS3FxZ2g2S1dudnRtY2czV0o4SDBUODlU?=
 =?utf-8?B?Yi9qOUdrM1ZJZ3JIeWJRUHU1b3RrTXZ2UlZwc21kS1Y3TEwxaFFNakJDUmdG?=
 =?utf-8?B?d1dZMHUwT3ZGUTkwZi9BZVQrYWxhUy9RNFQwNGJHUUtCSGdJei9uUTlDVDZm?=
 =?utf-8?B?V3p2UjJqZ3M3TVZ0bFluU2RZaHE1UitWYy95NXlnMGd1VlBtVmdObDZvK24v?=
 =?utf-8?B?YWVzT0xzSTc4bDFTTFZ5T0xSc2Qya056SXdGdVhFdmZNUWc2SWN2ZWZ4L0p2?=
 =?utf-8?B?NmNCeWg2ZC9HRXhlMEZmM3R5cS9VMW43SGxOVWkwVmljekZoZmN6VWNndnpz?=
 =?utf-8?B?QUhFVzJBK2tMZW5xdDJOaGRHUnc4YklSbVgvOWFBVDZUMWEzTFlHeVptQ21X?=
 =?utf-8?B?SnZUcGFUaW9WM1ZFMmVZNTVUbXFOQnhJM0JuVTE0S243ZDRxcE56NlUwOTUx?=
 =?utf-8?B?ZE0zOHdVMkQrWHlPZ1JkU3RHd3cvSXJPaXFuY2Rla1JibjJoZ29MNnM2dCtU?=
 =?utf-8?B?Y0ZFNmpmRzlsV011YWxjNm02eDRrRW13b2RORDllak4vMTJMdk1QWGoyNHpT?=
 =?utf-8?B?S2U0WktDcGdMY2ZvR2lxQ3k5bzFFbFV4K0RscnJpUzNGSHdDajlXTmlGYmdy?=
 =?utf-8?B?N3JGVklhRzA2SzM5RzR2YmFzN1lRRXgrL2pMeDZnbndROW40SUJVSzZOY2hW?=
 =?utf-8?B?d1p0YkZVaWxLM3pjRUtFMlA3MkRkbmJ4Y3IrNW8yeEhuOUdYUHZhWVpnYmtO?=
 =?utf-8?B?SzI0dzBSSHNCa1lNTDB3MTBJclFqaG1FUFdCUTNkdGpWWmF3cm9rLzBPMm8y?=
 =?utf-8?B?Zyt3d3dpRHh4RUV2cmhrRytiMlhnTzFDRmZscHgwQnZmaUJ1c3JBM0R5Vy8z?=
 =?utf-8?B?ZmFXTW5jRTlQU0toKzEwdWdIcTZxczFKZWZKcjh1eUJzTFdycGNLWVdOeXNG?=
 =?utf-8?B?L2lrMDFaMERzWmNrazBESitYRGU4SXRWWDZlZHgxVkw3aFB0TmZnTUpYOEpT?=
 =?utf-8?B?L0JiUTRLYlZmSHJxcXIwckhHSGJkS0pHSUx3SzRYZXIvb2ZmWDREZjFXL0l0?=
 =?utf-8?B?dXpxdUFYS0hmbWhUMzhWemo1cXdwdUdncjBmTUgrdCsrNGU1NlhRYm9FNzVq?=
 =?utf-8?B?MmIrWlBGYnJoRjZHQnRQdU0vMHhQUE95OTZzK0psc3ZKc01CUWRIL1lXQjRr?=
 =?utf-8?B?V1VYNXZFcHFvaFBUQmxSdEFtQWptSko4SVdkcU5DY1ZDSmRuYlU1ZG1yeHZn?=
 =?utf-8?B?MFlURVpuUFF5V3Y4MTM1MWs4TFNxMHpYdUc4UmlaM3lvSFlWWU5VTTJIeDli?=
 =?utf-8?Q?BuDlAOh8luerOCsHmFyuTraju?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53217ae8-7c9e-4bca-5400-08da72f18cfa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:38:20.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynDjDF502mfeg197fs8bP6R6BNv1vDIMF11r+llKynfnE/gjdqShfKTD7oUcV+rTMMtqjMkJrHqr10j547zsdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2229
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
> These ops'es have been replaced with the dev_attach/detach_pasid domain
> ops'es. There's no need for them anymore. Remove them to avoid dead
> code.

nit. it is replaced by set/block_dev_pasid. isn't it?

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/intel-iommu.h                   |  3 --
>   include/linux/iommu.h                         |  7 ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 16 ------
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 40 ---------------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
>   drivers/iommu/intel/iommu.c                   |  3 --
>   drivers/iommu/intel/svm.c                     | 49 -------------------
>   7 files changed, 121 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 9007428a68f1..5bd19c95a926 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -738,9 +738,6 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
>   extern void intel_svm_check(struct intel_iommu *iommu);
>   extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>   extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
> -void intel_svm_unbind(struct iommu_sva *handle);
> -u32 intel_svm_get_pasid(struct iommu_sva *handle);
>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>   			    struct iommu_page_response *msg);
>   struct iommu_domain *intel_svm_domain_alloc(void);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f59b0ecd3995..ae0cfca064e6 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,9 +227,6 @@ struct iommu_iotlb_gather {
>    * @dev_has/enable/disable_feat: per device entries to check/enable/disable
>    *                               iommu specific features.
>    * @dev_feat_enabled: check enabled feature
> - * @sva_bind: Bind process address space to device
> - * @sva_unbind: Unbind process address space from device
> - * @sva_get_pasid: Get PASID associated to a SVA handle
>    * @page_response: handle page request response
>    * @def_domain_type: device default domain type, return value:
>    *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
> @@ -263,10 +260,6 @@ struct iommu_ops {
>   	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
>   	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
>   
> -	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
> -	void (*sva_unbind)(struct iommu_sva *handle);
> -	u32 (*sva_get_pasid)(struct iommu_sva *handle);
> -
>   	int (*page_response)(struct device *dev,
>   			     struct iommu_fault_event *evt,
>   			     struct iommu_page_response *msg);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96399dd3a67a..15dd4c7e6d3a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -754,9 +754,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
>   int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
>   int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>   bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
> -void arm_smmu_sva_unbind(struct iommu_sva *handle);
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>   void arm_smmu_sva_notifier_synchronize(void);
>   struct iommu_domain *arm_smmu_sva_domain_alloc(void);
>   #else /* CONFIG_ARM_SMMU_V3_SVA */
> @@ -790,19 +787,6 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
>   	return false;
>   }
>   
> -static inline struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
> -{
> -	return ERR_PTR(-ENODEV);
> -}
> -
> -static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
> -
> -static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>   static inline void arm_smmu_sva_notifier_synchronize(void) {}
>   
>   static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index fc4555dac5b4..e36c689f56c5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -344,11 +344,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   	if (!bond)
>   		return ERR_PTR(-ENOMEM);
>   
> -	/* Allocate a PASID for this mm if necessary */
> -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
> -	if (ret)
> -		goto err_free_bond;
> -
>   	bond->mm = mm;
>   	bond->sva.dev = dev;
>   	refcount_set(&bond->refs, 1);
> @@ -367,41 +362,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   	return ERR_PTR(ret);
>   }
>   
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
> -{
> -	struct iommu_sva *handle;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -
> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> -		return ERR_PTR(-EINVAL);
> -
> -	mutex_lock(&sva_lock);
> -	handle = __arm_smmu_sva_bind(dev, mm);
> -	mutex_unlock(&sva_lock);
> -	return handle;
> -}
> -
> -void arm_smmu_sva_unbind(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond = sva_to_bond(handle);
> -
> -	mutex_lock(&sva_lock);
> -	if (refcount_dec_and_test(&bond->refs)) {
> -		list_del(&bond->list);
> -		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -		kfree(bond);
> -	}
> -	mutex_unlock(&sva_lock);
> -}
> -
> -u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	struct arm_smmu_bond *bond = sva_to_bond(handle);
> -
> -	return bond->mm->pasid;
> -}
> -
>   bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>   {
>   	unsigned long reg, fld;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a30b252e2f95..8b9b78c7a67d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2855,9 +2855,6 @@ static struct iommu_ops arm_smmu_ops = {
>   	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>   	.dev_enable_feat	= arm_smmu_dev_enable_feature,
>   	.dev_disable_feat	= arm_smmu_dev_disable_feature,
> -	.sva_bind		= arm_smmu_sva_bind,
> -	.sva_unbind		= arm_smmu_sva_unbind,
> -	.sva_get_pasid		= arm_smmu_sva_get_pasid,
>   	.page_response		= arm_smmu_page_response,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   	.owner			= THIS_MODULE,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 993a1ce509a8..37d68eda1889 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4921,9 +4921,6 @@ const struct iommu_ops intel_iommu_ops = {
>   	.def_domain_type	= device_def_domain_type,
>   	.pgsize_bitmap		= SZ_4K,
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> -	.sva_bind		= intel_svm_bind,
> -	.sva_unbind		= intel_svm_unbind,
> -	.sva_get_pasid		= intel_svm_get_pasid,
>   	.page_response		= intel_svm_page_response,
>   #endif
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7d4f9d173013..db55b06cafdf 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -313,14 +313,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
>   	return 0;
>   }
>   
> -static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
> -{
> -	ioasid_t max_pasid = dev_is_pci(dev) ?
> -			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> -
> -	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
> -}
> -
>   static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   					   struct device *dev,
>   					   struct mm_struct *mm)
> @@ -809,47 +801,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   	return IRQ_RETVAL(handled);
>   }
>   
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
> -{
> -	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> -	struct iommu_sva *sva;
> -	int ret;
> -
> -	mutex_lock(&pasid_mutex);
> -	ret = intel_svm_alloc_pasid(dev, mm);
> -	if (ret) {
> -		mutex_unlock(&pasid_mutex);
> -		return ERR_PTR(ret);
> -	}
> -
> -	sva = intel_svm_bind_mm(iommu, dev, mm);
> -	mutex_unlock(&pasid_mutex);
> -
> -	return sva;
> -}
> -
> -void intel_svm_unbind(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev = to_intel_svm_dev(sva);
> -
> -	mutex_lock(&pasid_mutex);
> -	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
> -	mutex_unlock(&pasid_mutex);
> -}
> -
> -u32 intel_svm_get_pasid(struct iommu_sva *sva)
> -{
> -	struct intel_svm_dev *sdev;
> -	u32 pasid;
> -
> -	mutex_lock(&pasid_mutex);
> -	sdev = to_intel_svm_dev(sva);
> -	pasid = sdev->pasid;
> -	mutex_unlock(&pasid_mutex);
> -
> -	return pasid;
> -}
> -
>   int intel_svm_page_response(struct device *dev,
>   			    struct iommu_fault_event *evt,
>   			    struct iommu_page_response *msg)

-- 
Regards,
Yi Liu
