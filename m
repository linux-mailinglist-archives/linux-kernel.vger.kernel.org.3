Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA87585EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiGaLyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGaLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:54:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3B11148
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659268454; x=1690804454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uPjFrycpdUYKx4fI+9biZPy9LkXkqngC41CVhbwUzj8=;
  b=koIIfl/wig9xwFHfbLcOro8wEBtk3dfnhLfZp/1yEkaa0a1bd4s3c64t
   HPNccCYVeNCJnH0N9fA2P9mbuefUcnYRkp4eSFH9j4O8FLgJlxDdIYs6K
   ohCdh4S+H1Isr8TiTye/KzmKugjy2ip1mQbtgGztlUwagGa9GejiKaLi6
   vrMDOvFHTzStXr/xJrGjlUqda3l3uvYJbuM2l/ZlN+OUdlb8uRRswNQsW
   UKz5z5Q8Aq1UPWGX3GP7pVgC8kIxPIGilIGCHluFdJ3FgYIzFymSLBLl7
   jV8dFgQhc+px8HbnCjZP+DBR8Vmk+rM1wsP3XNRyQq7w/UuDp/qAylWnR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268755337"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268755337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 04:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="728176817"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2022 04:54:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 04:54:13 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 04:54:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 04:54:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 04:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtsMfMEfoHWNPNkevyqNblZqsFc561FatiXet2bK4AlYPr0innmid33o+RLVU9HEjrI1KhGdMWR4eDT8pCK1NR+PLXMun/gy4AD5Yaz11pAQlDDraKz5prqkdozlp77gL/1IvVBlPQOmYMQSl7fld0TKQD7H9CwNTO5ok/pz7UUlFPNDuYxYtA3ZxBu9O0diCQ5Ppr10AegLSJA5TivcA7/Oecm5lxQFS2T8ayWANWz2v609Lj8dpEZu7bxJaguEx6zsAJovtJzPjZWk8lYAR9iqrzAF8PlisfvvAaXcn8dBcpfQDsvND6nv5PknAk58AIgfp6jkgmnUJuT7Bw4PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nCZDm6AdKWLLBUyTa64qO8DQg478hb1DntUTyDcxsY=;
 b=d8zQULpqI6hyAkxqmfrsb0fQHo+vHgjKkfDCOn1t0r2d2d8/QQL2/8VJW7bcxUrwnQ2U2/lbxLmvCetvAD2daJ8auStCxJu2SSEYpdyImg3Og8B7t1O23z7XesMyqS260FF1+VPxBaUCo9vIs1DOVXv+ME09aRpDzqLYJvX1NUf8WxcaAdpEIrj78XHwTta2p5TZkdOrEuxKyOjn271DRMfbxvYc5Huy3YbiRr73sbh0UiaBETsVenM27cOAdtEcdezwjXhSmkV+9FYJt7gaTdd7j1ZbJRo/hHStoDmnRmhQymBT2uFdMBK/Rpr8i21w/q6bNQb9Izbvp9rqxjdTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by BYAPR11MB3174.namprd11.prod.outlook.com (2603:10b6:a03:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sun, 31 Jul
 2022 11:54:09 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 11:54:09 +0000
Message-ID: <a837d035-1897-99f1-03e5-0d02ab9f2b4f@intel.com>
Date:   Sun, 31 Jul 2022 19:54:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 01/12] iommu: Add max_pasids field in struct
 iommu_device
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
 <20220705050710.2887204-2-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ccd5bc3-3bf5-461e-9e68-08da72eb60cd
X-MS-TrafficTypeDiagnostic: BYAPR11MB3174:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x4+F4kXSOMIDTxc3rDMk8d1BwKJze1rY/x9wkm66X0vSgU2xhIIy2tYBzV/tZzFs3OXqn3SiQ7vkgd6gvIr08teh8TTICr9FItx0udc74xCDaUxdUJiKArDAf/W9vaC4dO2zVpIPvzP/HxCGequ5CSvNvE54l7gFIAnVkpzS637OcgiYkbVGcAVf9979AkSTvbv+LOMq93ddQzN8L8mG8AprV5Hqr/zgoDOUBIyze8KtQbAKDDbUW/ZAckyvoY30jsPEaWyjxa+wQ7LkJifaGQTZgrRvLTkoprcO3WnydOBmFSJRjaRHBnhf/sNUAb9gAglpg2xNzE6CWfdMdolYcCDCGrQFoxraouu8eO26LOrpn4GP+PZTat5WLLaByQKhwuicvgJj+RTObIRHZoymzZgyJvMcCPussDA4WLySC0Hw1ietxD7o3ARDFKyR3NG4iWIUYn2dhPpEwrYOCGXunccXQpaFRHnKrqwcQzb24R1Sg7AcyZK9BiksHfY2YFwgZOK4MfNf8RJY3W/A039QQ/yNEypN2fqFl/ZJJ0wU83eXnCVSfUleIj1dYokiu2x4SJVW13e65FIP9ZdAIzbHRhMr5398lZvoRL9NREGWc4VskC5iU5GhThUsoUCFxt9gPIv7hnbHF53Dq45X+XaB0C0pW8k381hjK8EBbJdJmOP+Iofhq1vlXK7H02q1A4ZPNZhVET9Nf/Dw0klWnpeNz6Hbj3FsgPas35udSrGw0zY8pqKFMCYwyoCAHutlD/o30PA2XsGWfRwnzz5D4mB3rWK5GA2Q5pWlwrehBH6K175uEbMS6m3j+uvC+EZyanpFclqjLicYhj+6OQ8IS5UCSW5iNufHkd5dxa5m02db9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(136003)(39860400002)(8936002)(6486002)(66476007)(7416002)(36756003)(478600001)(41300700001)(38100700002)(83380400001)(2906002)(66946007)(110136005)(316002)(54906003)(31686004)(6666004)(66556008)(6506007)(921005)(2616005)(53546011)(4326008)(31696002)(5660300002)(86362001)(82960400001)(186003)(8676002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJxL0wrMzUxVjlLU2x1MXp2NzA0RjhFVnVsOHNzeWhPankwUjBXNGVjQ29h?=
 =?utf-8?B?K1phYjErTDdqR042Y3hPcithdFRKcnVKcjRQSkp1Mk9JdXVoelpVU09YQmRm?=
 =?utf-8?B?VEpnNEh1dWZ0ZVJCcnBjWDhqR0twYkVZL1NwbUlkSWFia2I0UUpoOVFHUzQ0?=
 =?utf-8?B?aHJxTmpUdUh0cTVPVEs4STdkaTVERTlXeVcydkdxOUR5Rmt1MUtWUlgvdkkx?=
 =?utf-8?B?R2t5aGIyQ2pKTm8ycHdNaFJDNFlFL29aNE9CZzdrS0xuUnlvNW1kYjlrQzVF?=
 =?utf-8?B?NXBzY3JwRzhibkFpNUV1T1hRVk9LOUdtUW8xK2xZUTRKKzhPVDdoK20xWGRN?=
 =?utf-8?B?cE10L2lHcEZaQno2SXlTLzJsaWpxaHhTUXpoalNWNnhRSmo1WHVQN0ZLcjBa?=
 =?utf-8?B?SGFUaU13eWxycGRBa2hxa1RpcFJQbkxTTWI5V2JMMUwwY1RjRTFUc2FxK3Mw?=
 =?utf-8?B?clhKNEtaK21EYU1qbkZOVkJrSk5jVlV0a1pDbG4zUlZtOFpUa0RyeTNqaEo3?=
 =?utf-8?B?c1RDNFZ0cXVRRFluUFprVFJEbGxxNnpaMVlucjVxcUNreGJ4SGVhU294bnZQ?=
 =?utf-8?B?WjhmY0VuOENsNFFDRkF1RXVrOUxNZzlnNW0xa3JwYnNRWDBadUVBeGNrZmJ2?=
 =?utf-8?B?TkVRSy9ucGszUTZXbDNtUDFKdzh3VGNqaTNEakJxYlpnUmZ0SlpaZFZpWjky?=
 =?utf-8?B?UG5kS25PQ1VHa2x0SHNkcGNHM0VYUWVoaEkwa1p5STBOQUlZRDY2UThkcllv?=
 =?utf-8?B?UHlOUGpXWFc4dzRZbFIwVFgvZDZKYnhHQXRLUlpGYWN6a2NMdnU0OC9nVVJQ?=
 =?utf-8?B?OHBKSW1lcGIzdHNpL1lkWENLK0VkYWJhYm5KdGEvRTdlZlc4NzB2cHlzU2Zj?=
 =?utf-8?B?Tm04dVYrM0FOaTkvblA1NkJ0QU8vUVZLdXBkTkJBekFuKzJWcXV2WEhhY1pW?=
 =?utf-8?B?R0xzaWhiZUNiWjJjRnVPMEwwZXlpRmVwRDRxRVNVUTlBUG9Ba1RUOExjOWpY?=
 =?utf-8?B?SW5LUDFsN1ZpNitheXJNaUlGYUFrSlhHR1dKU1F6YTdEay9zd2NyNmJZdExM?=
 =?utf-8?B?TjJUS1dYUnNoMGdxUGppZ1V6NURRSlVZNUJZcUZoV21waHJEUkZLRkd4QTBs?=
 =?utf-8?B?WUVvc1BwZXRYL1dqVGYzZWpYelVKY0JyVzhhNXVaY1lHZHMvSFZoNnJ2VFEx?=
 =?utf-8?B?WnpYWDA2aWRuMkZ0dGNzdWp0cEo3ekFWb3A3aXZIcmROQkRBTWNQdjRmd2ZL?=
 =?utf-8?B?WG5BR1czK1c0Sk9lNGU4SGtCVXc1eGltakFhU09vNWlDZmxtbHA5YkN4cmhr?=
 =?utf-8?B?dU5kQTI2T2FsMDR3Z2FoUUo4OWVveDlsZ2RwQlQ1clZHaVNIM2Q2NU0zWE1H?=
 =?utf-8?B?WWdFdG1yZkl0OWh1TUd6TzZwcGZBYkhDVENvT3IwY1lXd2dKZVczdjk1Tita?=
 =?utf-8?B?TEJFakozVUhMQlRYcU1wMEd6eDg0WEhYQi9JZENPU0RpRFpMbGZlVXB5V3BB?=
 =?utf-8?B?c0JOT0o5WjlZby9mZ2xMek9mSlJQVzNoRkowajZhV04wa2kwK3lRTHZJWUNU?=
 =?utf-8?B?OUlKZVE1aHhBbFN3bnpETk1jeDEwenU2bm5DQWdxQ1dNZTUyUU84a2R2bXc1?=
 =?utf-8?B?bnBsWGx1R3UxdjVLWklhSHlXeE1FdzVyd3JHbW9iUnQvdEsvV3VLVXc4YmhJ?=
 =?utf-8?B?VXJXbk9vR2xZMG8rdzVabmJJZWFWZWpySUFtcis2VHlIaUZyODAxL0o3M055?=
 =?utf-8?B?d0xEZ1hXVG5ZMWV5SmRmUW8zQ0Z0ZWJsNndHTTUxeUpVWkk3QkFrTWFHQkRp?=
 =?utf-8?B?RVJJazZNTjQ0TmlFdGN0d1JOcXdlMFB1RVdXdTdjLzlFVXFCU05BRWpXZ2JO?=
 =?utf-8?B?QnlpQnRHVGhQb3I2TkpQR29sRTJHZWxMaHdKc0dyb3RGSjdpQXYvLzcxbUJY?=
 =?utf-8?B?Nzk1bnkrSHlnVzRPcUQ0OVVMUWR0QkErNUpxL3l0T01ZYlI1QXFhOFNVVmt4?=
 =?utf-8?B?OEx1bjIrdUxCYjVUU1J1OEdsdEdBVlM5cFpheHJHTWVTL1REazVvYkJHb29W?=
 =?utf-8?B?aWtSb3B3OE9rQkFJUHI1cjVKWkRRNDhBOU9tSW03a1NzSnNUUHFUWXRLK0JE?=
 =?utf-8?Q?0alVxQWpPo/sCq+qPg9QiFOwG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd5bc3-3bf5-461e-9e68-08da72eb60cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 11:54:09.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8YWm8/+ZMH88lCCs168PS4WHwSfFemHMvIJRKMsVy49+DIVEe7i1CoIr1kLqfyxAxHP1P4DXyfCZCUIjc8b8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:06, Lu Baolu wrote:
> Use this field to keep the number of supported PASIDs that an IOMMU
> hardware is able to support. This is a generic attribute of an IOMMU

a nit. it should be the max pasid value an IOMMU hardware can support
instead of number of PASIDs. right?

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> and lifting it into the per-IOMMU device structure makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver that supports PASID related features should set this
> field before enabling them on the devices.
> 
> In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
> enclave so that the pasid_supported() helper could be used in dmar.c
> without compilation errors.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/intel-iommu.h                 | 3 ++-
>   include/linux/iommu.h                       | 2 ++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>   drivers/iommu/intel/dmar.c                  | 7 +++++++
>   4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 4f29139bbfc3..e065cbe3c857 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -479,7 +479,6 @@ enum {
>   #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
>   #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>   
> -extern int intel_iommu_sm;
>   extern spinlock_t device_domain_lock;
>   
>   #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
> @@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>   extern const struct iommu_ops intel_iommu_ops;
>   
>   #ifdef CONFIG_INTEL_IOMMU
> +extern int intel_iommu_sm;
>   extern int iommu_calculate_agaw(struct intel_iommu *iommu);
>   extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
> @@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>   }
>   #define dmar_disabled	(1)
>   #define intel_iommu_enabled (0)
> +#define intel_iommu_sm (0)
>   #endif
>   
>   static inline const char *decode_prq_descriptor(char *str, size_t size,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..03fbb1b71536 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>    * @list: Used by the iommu-core to keep a list of registered iommus
>    * @ops: iommu-ops for talking to this iommu
>    * @dev: struct device for sysfs handling
> + * @max_pasids: number of supported PASIDs
>    */
>   struct iommu_device {
>   	struct list_head list;
>   	const struct iommu_ops *ops;
>   	struct fwnode_handle *fwnode;
>   	struct device *dev;
> +	u32 max_pasids;
>   };
>   
>   /**
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..ae8ec8df47c1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	/* SID/SSID sizes */
>   	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>   	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
>   
>   	/*
>   	 * If the SMMU supports fewer bits than would fill a single L2 stream
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 592c1e1a5d4b..6c338888061a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1123,6 +1123,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   	raw_spin_lock_init(&iommu->register_lock);
>   
> +	/*
> +	 * A value of N in PSS field of eCap register indicates hardware
> +	 * supports PASID field of N+1 bits.
> +	 */
> +	if (pasid_supported(iommu))
> +		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
> +
>   	/*
>   	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>   	 * be set yet. When intel_iommu_init() runs, it registers the units

-- 
Regards,
Yi Liu
