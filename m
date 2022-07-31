Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC675585EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiGaMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiGaMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:36:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C12DF44
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659271004; x=1690807004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSEi+o6iX/x0BQ42UHIUhTEp4/VvOYvVYNgiEymkVzU=;
  b=AJwYgSAYsnYCf49yus5ahQGJdi64YGeQJxZlQjVAKSYQ9YiJgg25RevC
   2LfIxeKi6iKPyA4NOHXvWetrRhs09bVLQuWLaCL/cqHsGT49CiUdUDyb9
   NWHdGfW8Ul9Z0nKZpvbJib9KbAwoOuzr9sEOTO1jU8aToE7S/kqgBVvX+
   aqn8SeLFoAKRF2Ag8wBxp+wnVP2XdSAwgrJ8hoY5gvC7d3DMg5kyhlLO0
   Ke0wC+u9LfVaSJB7kG+27qWqMSaj4IhznLi3aUN7uvf6cTZpolVhB0Y/Z
   iZt/amz+eAfRy6C3l623SgrApsBnshj48ggVlARGbVxftOyokaVuVJEAW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269373916"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269373916"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634603833"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 05:36:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:36:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:36:43 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:36:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsp6MC7ZsTS4eHgEAv2j/ceRDnoqxw3wq4yZg3P9/KbWpvWGeWzGjVLZiwDolISJMR+Blc7WL8AmfawJLnVgySYdsUGPnGxBcmbYQn1ByfGTsS65LBr0UCHbmlt9A++DifVxt1obU8gO8Ka+r4Mya3AmkEpUUjg/swOpyNcbcl0PvptJ4mgZ9hOPrFyCvERSht/WL8w8W3R+mF/+t9yjgksI5ifn2Virsa1dac0SkWnAOJbmwf+tRCDc7pE9bMT2stnOjPqtytgwkzQ1ZJsIG0UGBzCiYs+lrf/aPZeqnJHM81VTDdODDbkXmVzwuDpe9OtSh7LJ67zYyqqLj6XJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edjU6txdNNCK+wZWtVPKqTf2rVOGI9aFBW9180qcE0w=;
 b=X1nvj2VkoZHvIcrdmONKKOsgiW6xu8tFNhUV3e26Tzce48uElpdUlIdVyQA5h/v1Oxn1FOg6qWfmkSCNI1wsgOVFJWYD/Y1UlSa81ooC7E1qeJ6FXtj9nRdFrMwIm0k5aCpn/PsDBfMQRx5HXzMq0e/OkZXgLcW0rwLa8ImeJWCLFO0hmrY9TDOtnuJLBSlHrRa0bSVn04JYX7giKna+FG9Mu4mdIdPKwLz/jW9tvEcVWBVv7cGNlwdBpQQDCKHY93Yl/dfnwE0TbpwtkW9Tboa1cPiTXecwsfTPPq38YFTnETK1maXCqKgn4GlfZeqJJRhuVEKji6lU8LUyvMgSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by CY4PR1101MB2229.namprd11.prod.outlook.com (2603:10b6:910:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Sun, 31 Jul
 2022 12:36:41 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:36:40 +0000
Message-ID: <7e9e61e0-bc8a-a757-a666-0a7828b7fde8@intel.com>
Date:   Sun, 31 Jul 2022 20:36:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
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
        <linux-kernel@vger.kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c072521-2d32-43bd-f02a-08da72f15183
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2229:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRgMsXJ8nPXTch+7yt6R40kHIwZIgbki4c4lr5R/1LXJyiv47Dz0xiRg+j0lumegRMX6QQ0vGtXNINMhvowtpIHLNFwf5HJ0m03UfXDghJpmygXgzZXDVPoipm2a4NGyJwggbs2apKOjEC/3+IT/A2/l0i/cWwtv/7iPtvFecyQ2Oprg3RQIvAH6f/Jtgx96TNBbuSkIE35gjLKgQrWPkC47zyZlyMTlw2CGXuVr2Rzt08NASD2O51bSSmgf/yGJWwFAWrHBHgRDc2Qbv4AsRFQe0tbEmjGAonZtil8M5lKJoRlb0UyNikAAtE3CjVNudYwLUNPhzcIhd6Dx6jSg9BmFpHycgPuHLBf6CucgP+DQyIEi+98qRXXEcAUkbEK8EQhNF8+RiHqJgJco2Sh3f27ZhQquhHz4cmQs6xaL09eYrYRSLVjmqLMztZYczXNP53OtkKAjXdYRPf/nzG/UWRGHeYmxv7PDHU4WoNPZjdJsmqAZN86Ev9tDHKxT+5se286BSdpYchHTEjXsoobqyNhutnL+L4L4I5/615aL48Bp3oMXWp2NLUC+UDwom62MbQmADw7BWbymFzC4ikxsQtmUFEBNosgDlbwjujXHP8WkcJaTSMAVtNNInMY8dNHFKAFwNKDBoKSaEx8fevYdIFwDJoRsD6DGkUmwE53WiYMzqtZw9BUtopxxwsKut8ZP7sdwePaGTreTGendQvmK3Mledfkwv+7BQGZjMTFbahg8uJewY6oKKGR3Lw5NYw2Zlv3fv2uOGUJ6FaSFIDokZBH9me5NA+WAwKkCyxL7AaStG6i36aCzxFwKSkTRKDw/eU1qEhclsFSwEnhgQDZBHn6xvX94rWeIDaqGQ8Vvhr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(186003)(6512007)(26005)(38100700002)(8676002)(30864003)(4326008)(66946007)(31686004)(7416002)(66556008)(66476007)(2616005)(5660300002)(36756003)(8936002)(83380400001)(6486002)(54906003)(2906002)(316002)(110136005)(478600001)(53546011)(86362001)(921005)(6506007)(82960400001)(31696002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU5EVnFiaWZyc0EwemlRRXFPMHpxTUwwL2svSmVWNFhQZW9PSmUyRFYvODE5?=
 =?utf-8?B?aitPWTJSYjJEdVNrZW5QYms3RHpVc2xZRThGaU5hdHBLNndqeG9XUEJkbXpX?=
 =?utf-8?B?VW5lNkVGMDFsYkpGcDJXclRkYlZPcmUxTm9wSWhDaDhHWXVnUDFhbURJMHQw?=
 =?utf-8?B?TFFLdHFXL2R5ZFR5SFZzN0g2WndiNWJaUm1oL1cxSWxBV0xNcUd6bVBDNWtk?=
 =?utf-8?B?c0dRREl1RWNPOVgzMDhJeVV1blYySjkyL1ZIS3R2c1lRelBKYUFLa2h3dDBZ?=
 =?utf-8?B?dGgyM2F6TnJYYm8xTXlDUkp2cWdNL25RVEpiYStrRCtOaFhGKzRaMFBPekJM?=
 =?utf-8?B?dWxhT3lIdWR0T0lKYzZ3NDk4SFVlMnJQYW9mQ0FEQ09kWWp0RTlzSmFGcUhE?=
 =?utf-8?B?Y21nTXZYZ1M5Vm9VSzlhZG93SkJjQkZFekdPZlVyeW5HV0xLamlMUndyRGd1?=
 =?utf-8?B?ME4vRlNYNWRPSkJTb0lzQ3p1cDRqY21HU2hGbTJNU1JLNTd4bFZ2ZnRnSmVt?=
 =?utf-8?B?MHVtRlY0MlFlNFJDSmZiVmJwc3hpU1crM3diR2luclhIeDJYYmpDK2J2WWRK?=
 =?utf-8?B?UnlPdnJibUNpMTBDVksyZUJidU93UGxRUlJDazJzM0tZd1RlNkZTUERMWEQ2?=
 =?utf-8?B?bUJkazhFMnR4Y1BLQkVRWXNrSWtYakg2MS9WdDdJK0NoS1VpY3pBNzlHS2Jy?=
 =?utf-8?B?ZllEOEdIZTFhVUdqTUJSVHIzYS9DY0N1cEpSeElxenRWTFJIWmVhOS95Mkc4?=
 =?utf-8?B?dTBLQlR2NzNRaHUxWXBZWHB2WUZ5MVdWNkdBV1RSa041aGV1L1cxYk5NSmM2?=
 =?utf-8?B?aWFheHdTOHVZT3kwNlNXL256bzVENzI1R29hWEJTYm5weUc0Z2hPSEhxeEhI?=
 =?utf-8?B?a3FzcGJDMUdtazR3TFVHZXE4dmVrb0pMeHhseUhFSjREZWlhZmY2VU1XajZS?=
 =?utf-8?B?TjFpUHM5eXlNczVYc2FiVTJPeDRRZUZUMktVdDVoYnU0d3hhdmFCbmgxcHJV?=
 =?utf-8?B?akxOamlMRFJFUUgrRXovUVViOERSNk51cjZCSU9HVEtYN3NES0YzcENVamhr?=
 =?utf-8?B?clVwNk1xa0x4UUlJb0JMSzQ5T3libDVtUXgybUZjanM5RmJmSmlEODloL0gx?=
 =?utf-8?B?OTBNMDJSRzlUYzBHcW5Ick1sZy81SlZ3UDZrZzVUdEhOSncxSTRJaVJ4U3lS?=
 =?utf-8?B?UjR3b0tITHF3ZnFDYnBuZmZFZjlUY0wzR3BxRStDcVpoZjJVTG90MHdNVmdz?=
 =?utf-8?B?QVVMd0FzVlBhcjZqWFFXWkpVdFhmRm9xL2Nyc2l1Q1NPM1pSaE93cXBnNDY4?=
 =?utf-8?B?SUZld284d3hJSkhIS2FFU1JVbCtTcnNKaHNzS1hnZlNybHhnZXNxYzU1Y1lv?=
 =?utf-8?B?RGlucUNRSXJ6ZnFzNy9WWm9odEJka3Y1WGdtcFBtd0JwSU9DaWx0c0xXZXE2?=
 =?utf-8?B?ak9YQUVxQXN4T2JvVE9pWW1pTGFQdWlybURtaGU4OG5IM3dCZTFMYXF4TWd6?=
 =?utf-8?B?M25oaFgvUUJiaVVOU2h2VXAweUx4bkZMOTQ0TG1PRnRDUEtCM0ltVHRsL0pz?=
 =?utf-8?B?Q2Nna09SMHNiVGNKODhDb0pBUUl6WWRFUGNtWUxnZVU2UlRJNEl6TlNHWTRP?=
 =?utf-8?B?RFZpRisrb05HbUNqREw5K3E5bW9CcU12VFFvQWk0RGx6S21MT2F6SnIrNlRO?=
 =?utf-8?B?RzVpUXFvUzBWbmhRbXlqcFNpNjQ1V3lONFZ0aUw3Yll4WWc1VzJVRUJNK2ww?=
 =?utf-8?B?S3RqV2s3dktURFZpUGxnZGlVR3NTYThmYU1YZ201bnJTZnZYSlRoeW5EbnI0?=
 =?utf-8?B?L2gwMUJ6RWdqTmZEcW1hVmRlaVdkV2VVUGJWMjIxTnI1NnR0K0s3UFcxQXE1?=
 =?utf-8?B?dTJ0VFBSRk11bDhxckFoTXNQSTU5UzY4dUhnbnpOQ09XaWhNSXJFSS90N2pk?=
 =?utf-8?B?L2dmWXdFaEpGaXJwUkZSZnVTSlkxcVdVTHpPdGpvV0Nwb21nN2EwSU15aXI0?=
 =?utf-8?B?Nnk4WFZPV1lqMkVKVFlkdHo0cXE1WWltQlE3NkhvaTdvV2JVQ2lnaFRoZ0g4?=
 =?utf-8?B?SXdUK2Jna1F0eWd5QmwySWphSVFLeVFWcGx3aEFvMmh6MmpYa3l6ZTdhRXYw?=
 =?utf-8?Q?abGIgzLPDVnudHqllhef7uuEX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c072521-2d32-43bd-f02a-08da72f15183
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:36:40.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3DNcC8dkCOdlxx6twYRwyhSUcutqH//9auZBjP9teOLKfX0mSd2TUtYoPFtMAzikhL7zT4PkSJJbvwEGb7F8A==
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
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.

s/"attach/detach_dev_pasid"/"set/block_pasid_dev"/

> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h         |  67 +++++++++++--------
>   drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>   3 files changed, 165 insertions(+), 119 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 42f0418dc22c..f59b0ecd3995 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -39,7 +39,6 @@ struct device;
>   struct iommu_domain;
>   struct iommu_domain_ops;
>   struct notifier_block;
> -struct iommu_sva;
>   struct iommu_fault_event;
>   struct iommu_dma_cookie;
>   
> @@ -57,6 +56,14 @@ struct iommu_domain_geometry {
>   	bool force_aperture;       /* DMA only allowed in mappable range? */
>   };
>   
> +/**
> + * struct iommu_sva - handle to a device-mm bond
> + */
> +struct iommu_sva {
> +	struct device		*dev;
> +	refcount_t		users;
> +};
> +
>   /* Domain feature flags */
>   #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
>   #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
> @@ -105,6 +112,7 @@ struct iommu_domain {
>   		};
>   		struct {	/* IOMMU_DOMAIN_SVA */
>   			struct mm_struct *mm;
> +			struct iommu_sva bond;
>   		};
>   	};
>   };
> @@ -638,13 +646,6 @@ struct iommu_fwspec {
>   /* ATS is supported */
>   #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
>   
> -/**
> - * struct iommu_sva - handle to a device-mm bond
> - */
> -struct iommu_sva {
> -	struct device			*dev;
> -};
> -
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>   		      const struct iommu_ops *ops);
>   void iommu_fwspec_free(struct device *dev);
> @@ -685,11 +686,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>   
> -struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm);
> -void iommu_sva_unbind_device(struct iommu_sva *handle);
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> -
>   int iommu_device_use_default_domain(struct device *dev);
>   void iommu_device_unuse_default_domain(struct device *dev);
>   
> @@ -703,6 +699,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			      ioasid_t pasid);
>   void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			       ioasid_t pasid);
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1033,21 +1031,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   	return -ENODEV;
>   }
>   
> -static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	return NULL;
> -}
> -
> -static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -}
> -
> -static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>   {
>   	return NULL;
> @@ -1093,6 +1076,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>   					     struct device *dev, ioasid_t pasid)
>   {
>   }
> +
> +static inline struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   /**
> @@ -1118,4 +1107,26 @@ void iommu_debugfs_setup(void);
>   static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> +					struct mm_struct *mm);
> +void iommu_sva_unbind_device(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +#else
> +static inline struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
> +static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +}
> +
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>   #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..751366980232 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -4,6 +4,7 @@
>    */
>   #include <linux/mutex.h>
>   #include <linux/sched/mm.h>
> +#include <linux/iommu.h>
>   
>   #include "iommu-sva-lib.h"
>   
> @@ -69,3 +70,100 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
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
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	ioasid_t max_pasids;
> +	int ret = -EINVAL;
> +
> +	max_pasids = dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> +	if (domain) {
> +		refcount_inc(&domain->bond.users);
> +		goto out_success;
> +	}
> +
> +	/* Allocate a new domain and set it on device pasid. */
> +	domain = iommu_sva_domain_alloc(dev, mm);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +	domain->bond.dev = dev;
> +	refcount_set(&domain->bond.users, 1);
> +
> +out_success:
> +	mutex_unlock(&iommu_sva_lock);
> +	return &domain->bond;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out_unlock:
> +	mutex_unlock(&iommu_sva_lock);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space. The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev = handle->dev;
> +	struct iommu_domain *domain =
> +			container_of(handle, struct iommu_domain, bond);
> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (refcount_dec_and_test(&domain->bond.users)) {
> +		iommu_detach_device_pasid(domain, dev, pasid);
> +		iommu_domain_free(domain);
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct iommu_domain *domain =
> +			container_of(handle, struct iommu_domain, bond);
> +
> +	return domain->mm->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10479c5e4d23..e1491eb3c7b6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2789,97 +2789,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>   }
>   EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>   
> -/**
> - * iommu_sva_bind_device() - Bind a process address space to a device
> - * @dev: the device
> - * @mm: the mm to bind, caller must hold a reference to it
> - *
> - * Create a bond between device and address space, allowing the device to access
> - * the mm using the returned PASID. If a bond already exists between @device and
> - * @mm, it is returned and an additional reference is taken. Caller must call
> - * iommu_sva_unbind_device() to release each reference.
> - *
> - * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> - * initialize the required SVA features.
> - *
> - * On error, returns an ERR_PTR value.
> - */
> -struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	struct iommu_group *group;
> -	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_bind)
> -		return ERR_PTR(-ENODEV);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* Ensure device count and domain don't change while we're binding */
> -	mutex_lock(&group->mutex);
> -
> -	/*
> -	 * To keep things simple, SVA currently doesn't support IOMMU groups
> -	 * with more than one device. Existing SVA-capable systems are not
> -	 * affected by the problems that required IOMMU groups (lack of ACS
> -	 * isolation, device ID aliasing and other hardware issues).
> -	 */
> -	if (iommu_group_device_count(group) != 1)
> -		goto out_unlock;
> -
> -	handle = ops->sva_bind(dev, mm);
> -
> -out_unlock:
> -	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
> -	return handle;
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> -
> -/**
> - * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> - * @handle: the handle returned by iommu_sva_bind_device()
> - *
> - * Put reference to a bond between device and address space. The device should
> - * not be issuing any more transaction for this PASID. All outstanding page
> - * requests for this PASID must have been flushed to the IOMMU.
> - */
> -void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -	struct iommu_group *group;
> -	struct device *dev = handle->dev;
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_unbind)
> -		return;
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return;
> -
> -	mutex_lock(&group->mutex);
> -	ops->sva_unbind(handle);
> -	mutex_unlock(&group->mutex);
> -
> -	iommu_group_put(group);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> -
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
> -
> -	if (!ops->sva_get_pasid)
> -		return IOMMU_PASID_INVALID;
> -
> -	return ops->sva_get_pasid(handle);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> -
>   /*
>    * Changes the default domain of an iommu group that has *only* one device
>    *
> @@ -3366,3 +3275,31 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   
>   	iommu_group_put(group);
>   }
> +
> +/*
> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
> + * domain attached to pasid of a device. It's only for internal use of the
> + * IOMMU subsystem. The caller must take care to avoid any possible
> + * use-after-free case.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +	/*
> +	 * The xarray protects its internal state with RCU. Hence the domain
> +	 * obtained is either NULL or fully formed.
> +	 */
> +	domain = xa_load(&group->pasid_array, pasid);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}

-- 
Regards,
Yi Liu
