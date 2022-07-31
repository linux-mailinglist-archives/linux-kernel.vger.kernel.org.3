Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6C585ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiGaMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiGaMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:20:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34E2AD9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659270035; x=1690806035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3QCial/J8WbZG10q1Dq1+spiAdrqiY14p1rN73IJyY=;
  b=Pw1UOROm4+QlwH+tEqqjJQx98XL7fmLRbG3XSSb9lSYE7uZyw6ErD1mt
   XySYcNxaUkuf+vV8PMoeysr+GyFHha1UtEPHLm9uQ+B1PKYWY6fNCYOrV
   DJjghtgYI+BSy7d5Kn3m/9rnTe30SADHCy6yOpBO4JNCEbqUPSU+oWzXo
   dDwOJn/6zzK9265vrulrZWdNo2gBfde3SYAOdx61IW3jLwcCa+uW8MQsf
   39cl6jwjTjMVIY28zsP8YWTrEsHZJLlIVtM4m8hU4aJpAfCBjUX1kWUi5
   +iamNRDSd197OdI1+Q2R3+mnASez7lIKV7lux2c4uzhD8nq53zMtL5gHe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375294800"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375294800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="743991965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2022 05:20:34 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:20:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:20:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:20:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jay6otfZ+14ta+vzBwIKbLuyu5bvbnmv28ZXmdru9gH9QtHLNWYB51BuDFz60D2NSYMivb/NzRBaA8HwQgkRKvj+TC/i++OOOO7VrXs+YDXxqJZHfUi2l5CNpsfTJmQnYpj7i3PENgF+INdPEQdIkFjLxACgE5ATH837tneTYkMsflak1KWKtO7FaE44joPxyynlphnfP0xNX8l8dhCqvRmdfFmfDybunKwYz4LccfexUBa1Sg9H58YAex9mb8+H7WtuSOXTaKCWmLL9clovepg4fVB0KxznoIMAxQGBmFJ9nmTf4yw+L8Y8iYqw713/Lw+s4eh4rXf3nBVL5lvQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lcl4zbTssqcQsLvrxbm6JMnCusHO5eQ59uPSNztuxo=;
 b=K3Y9sw1GBkaMNJ+jdWym3hwuI/Hcgdo69P7cT6YFE0oqnSDA7rXyiGJx2EX29AXQDTIOqvzBe57Ke+zRmM+lZBBUpVzywu6AHXYqxi00fyAjWglTijx6LrXiSJ1FPYfjD4qjKg/wFgl/vDyDgOgS8ARVpR85jmCv6B4S/XBN9ivI5iGYuUF9r0swZb95juf1mYgawqRUGTiXdMrtuc8zQ/NHJkalZLV3FklNI4Eapp7zbQE8tdulUs9YCr+zhLe/h3DxofhHYKUn6UjjEsxaYFiWW/G0/k8bgWhYDl2j4Ks7lY82LUvq2+hcirWvY0MwmM9QPA2ziHZB5vEg9+NCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by DM5PR11MB0026.namprd11.prod.outlook.com (2603:10b6:4:62::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Sun, 31 Jul
 2022 12:20:32 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:20:32 +0000
Message-ID: <dd14366b-0b2f-7662-6af9-4ba85848cd9e@intel.com>
Date:   Sun, 31 Jul 2022 20:20:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 06/12] iommu/vt-d: Add SVA domain support
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
 <20220705050710.2887204-7-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d12824a-0170-4fc6-7053-08da72ef1043
X-MS-TrafficTypeDiagnostic: DM5PR11MB0026:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+wqt4eY5SaUopQe2eRqIjoPv3oazr0drvx2JoVEyjJLsuVC00TSjc3xqoXItgdTqrxlupjl+48VZd9w7bsQgxYkMdgo5unDDnppV/kOz/lNiF4ADhzRwoYm2vqVeC0ZNs8HDdyw7i6n/hxGXfPpx6H7nPW1zqeQNfiKBXBgw3ohrlwVoSvDE4/jtVpfkxEanq7Ea8DP0NJIwX5x1QRUBrX909JGw17wklgbDnV5C+kIkoAkUFI32pqRT4YsQmdEjwGwWkRrnBtaBIG0cQCpsx6iJXJVIFTDTQAzi0xbuLp6NOcLcRL2hAiM2l/nz23qkWcfaSzfRSL246k0sdAHkyZawRY22DSJADiO7wk5fBTU55+KWPuJXuJ8tgE2OxgPNTtYtWx1XH7RtB37Jl/9PYUBYNzAs9FZPR5dQqinSahSJRzG3KJo8YzSXfnAjdgxUgrJpB2HJjNk/RlRQelBwN+UmZNeaQfFFq1ggparr9ET0fySmVmCeJF+Wey1aBmOgumD5VE3yr74/7y7Y8KJ6YWvrXbpOZ9wglfKUCDxygxzk9/N5CetW5pwDAnva3oCKCG7rs7wFdWTd30mV0ikxLfZwt5UdylHbJjii/575ZEv2camSlEKEF+roRoFYJJRwAwdbYggz5AgLUoyuYhb3bKdPEy+aMTNuOjhdC02HAJhefw+yqjtEI95fkcNAyQpp4Hsm1NtWdnLzXvjLoIkAJVnQ/m0BSNYhfajVP7xBab9OaryLErGkPHhcA1T6hS1U2JfsTYEe739oaGX+UeUEg7GVXKulUnsVUUCZaAQpoxFmR+n9WPzl4rofqPGb334rDcD7g+AWYP9G2EvHd07I2WjGtOUq6nZRjsamUiyj2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(366004)(346002)(39860400002)(38100700002)(921005)(478600001)(6486002)(186003)(2616005)(83380400001)(82960400001)(6506007)(6512007)(41300700001)(26005)(53546011)(31686004)(66556008)(31696002)(7416002)(36756003)(2906002)(86362001)(66476007)(8936002)(8676002)(66946007)(54906003)(4326008)(316002)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkYvRURSQVZDMDV2SVl2OUNGeXZJNmRaRUg3UmI5NzVRR0hzaW1ybDFmZUh6?=
 =?utf-8?B?WTdiRklZQitlenhEUnFKWGhIWFFGTnl2eDlYNjZnVW0ydkRGd2R2UEF3Uk5P?=
 =?utf-8?B?eUt1Z21TVXZ1bEFtSzJubUpheWF1ZDZPbEMxcnRFNFF6bEdGTnQ0NG9XTGdK?=
 =?utf-8?B?THhScWI0QUdwZGdnZ21EZExnNCtpQk1LVDVJT0hxaTg0ODFpTmpBQ3diSkZk?=
 =?utf-8?B?WHFsZk9SMVRZc1MzTnRnczcvRnFYL1ZWc1NvWTUyaE4rcmRXUnJnT3kvcjVT?=
 =?utf-8?B?ZHdQdVZQNnlxSDdCVEZvWFhpbGFqR1VYYXpzQjB2T3czRHdSYyt4RXZkZVFq?=
 =?utf-8?B?dGZsSVh2Q1N1ZG5YbzZjQkdCaTNrbUxlZE5QSjZsUEhKNi9QTXRXVVlmcERp?=
 =?utf-8?B?QmpTZnlyL0hGQTVFZjB4OXZWTVN2bkFPL3JVQ3c5TWpUdkplQUlCeCsvczlW?=
 =?utf-8?B?Mmx4WHkzZElqSFNlZzJjL3dqMDNBL01aRlZqWm5JWXdkQUwrTFRZQTRIRjk5?=
 =?utf-8?B?bUdtOXRoNXdhelZ5NmkxeU1vSkJwVzdWRDdoSysrVU5sajRibXpkRkU0UmpP?=
 =?utf-8?B?N0Z1SGNpbTE1anB6bkdVM25YaEFaOVorQmhaZk05UndQYmprdlllc0k5T3o2?=
 =?utf-8?B?OGVsRDU5NGVRY0haclBLd2ZMWmJnQzVBQ2xqcm8xTUZMcW40M25NdmV5amlB?=
 =?utf-8?B?R2dvVHZ5K05la1NxZDlMdmdqUGIzTDgzZFJWQzBRUXM5V1BxVHg4SXExRS9q?=
 =?utf-8?B?b3FFaElkdmxuVTJpTkNjNEQwZmhSZmVxcnBQa1N6amdhaEt5K2dNVjAyOExs?=
 =?utf-8?B?RERRT0wrYzZtMnMyeWpjRVE2aHpjNzlUZmhTTUUwNDhaU0l2QXIzQ0w4Ujgz?=
 =?utf-8?B?L1BvNVY0NmdWUzU3SHQ5end3MjFtcHFVZ044d0dubGZFSHcwTTVIYUdHK01R?=
 =?utf-8?B?QTFQdk54MmI5MmUvTnVrdWdmeDFEaWlwakl2R2dHRGhwbndLdk5tYnBiLzhl?=
 =?utf-8?B?aStiUDYwSGlGbVVBcFRVQTIxa3VuQkRyWnRkNnJweGpLajhpWXdFWWRtYlFZ?=
 =?utf-8?B?K0FjWWxVN1dTb3RSMTRJbUpWSkpKVDI0TVZGajZLQ0R3WmlGdllqRThzQkU5?=
 =?utf-8?B?S3MwR1hDREN4ZCtoYkhaVk91MTU2a0Z3RSt4dmUyS2taYWIzQ3pvWkFhTFNC?=
 =?utf-8?B?VWpQemNhV3V1YjJvOG5idmRuM2tyMmI5d0gwa3JoRW1PWk8zV3ZsU0ZiQWRJ?=
 =?utf-8?B?b2grUUxQZGVNRHlWOTE4Ynd0WmRsZ3ZPenFSRytrT1BpWTJNTEdSQ3YvZThp?=
 =?utf-8?B?NmhkSGpEZFJNcSsrK1lTU3RVUUZyNGNVZFRHVmczT0t5cmlqRUFCRC95QTM4?=
 =?utf-8?B?T1BibXdwK043VDRBbllRaEZCeURjMjlxZnJkM0R3Q0RqeE9jYVByV1ZWSUVV?=
 =?utf-8?B?anEwQ0c1VzNNOEtCVk1uSFpSMVBxV2pmV2hQbGZwRU1UYittRVo2cmZteE5r?=
 =?utf-8?B?NDk3UFhRcUVoZ0hkR01FVWhZT0JCbTJCcXprRFZCNUE1ZmlZaDVlNHVpVktO?=
 =?utf-8?B?bi9JVTc4QWtmSXNYL1hwdTV3eWRpSExhRkZmZE56NVRNUHdQWWxwT1lpenhB?=
 =?utf-8?B?Y1U3bUJ3OTh5UDlrVjVScjVXMXQwMUJMVE56N0lMQnJnRm93U0J6czJ1ZHdV?=
 =?utf-8?B?OExTbXJkY3Ayd1ZvT0NheXBlbXZ3eHkzOGIzTVZUMmFqcVhmeDZUWjFHQitP?=
 =?utf-8?B?ejh5SmpLUUNKMElCUGVUTDlvVUVIUGRDYStaVDE3K25wSm1xNStGdmhjQnVj?=
 =?utf-8?B?cDVnQnJySkhHM1gvcXBSTGhwUWhPQWQ0ZTgvRTcrUnVWZ2x0S2oxM2U4NkNW?=
 =?utf-8?B?VUU1RjdWYkVGcmU3YlUzc0d5K2hsemdRZFRMMjd2cDVZN2hMWmY5WjlDb0Fl?=
 =?utf-8?B?K08zQjFHRllieUtMNFE1dHBQYXovOHBSdTZBRDJES1FTUndOeXYzcnhRMWtr?=
 =?utf-8?B?VkhscTRHc2hjZEEzT2ZxejNzOHVYL3dlbDZLUjdDVkllazQwdmd6OGJMaTl6?=
 =?utf-8?B?SkNqc1IvakFXN3VIbE45ZDIzNStiTzJOTkRoQTY3SWxnMGhzTGF6aVA0NDl2?=
 =?utf-8?Q?3bn2jJUxmPIcE5Hk3StG9zF7O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d12824a-0170-4fc6-7053-08da72ef1043
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:20:32.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQl49b7Lv49XDdTqtdunEUiPEvFRUUDZ9SaHeix40es3XbbJq6uVTqnEXDihdyVHpCJm2Iuq1LtLa646mMxquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0026
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
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/intel-iommu.h |  5 ++++
>   drivers/iommu/intel/iommu.c |  2 ++
>   drivers/iommu/intel/svm.c   | 49 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 56 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 31e3edc0fc7e..9007428a68f1 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -743,6 +743,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>   u32 intel_svm_get_pasid(struct iommu_sva *handle);
>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>   			    struct iommu_page_response *msg);
> +struct iommu_domain *intel_svm_domain_alloc(void);
>   
>   struct intel_svm_dev {
>   	struct list_head list;
> @@ -768,6 +769,10 @@ struct intel_svm {
>   };
>   #else
>   static inline void intel_svm_check(struct intel_iommu *iommu) {}
> +static inline struct iommu_domain *intel_svm_domain_alloc(void)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 44016594831d..993a1ce509a8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4298,6 +4298,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   		return domain;
>   	case IOMMU_DOMAIN_IDENTITY:
>   		return &si_domain->domain;
> +	case IOMMU_DOMAIN_SVA:
> +		return intel_svm_domain_alloc();
>   	default:
>   		return NULL;
>   	}
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d04880a291c3..7d4f9d173013 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -931,3 +931,52 @@ int intel_svm_page_response(struct device *dev,
>   	mutex_unlock(&pasid_mutex);
>   	return ret;
>   }
> +
> +static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct mm_struct *mm = domain->mm;
> +	struct iommu_sva *sva;
> +	int ret = 0;
> +
> +	mutex_lock(&pasid_mutex);
> +	sva = intel_svm_bind_mm(iommu, dev, mm);
> +	if (IS_ERR(sva))
> +		ret = PTR_ERR(sva);
> +	mutex_unlock(&pasid_mutex);
> +
> +	return ret;
> +}
> +
> +static void intel_svm_block_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid)
> +{
> +	mutex_lock(&pasid_mutex);
> +	intel_svm_unbind_mm(dev, pasid);
> +	mutex_unlock(&pasid_mutex);
> +}
> +
> +static void intel_svm_domain_free(struct iommu_domain *domain)
> +{
> +	kfree(to_dmar_domain(domain));
> +}
> +
> +static const struct iommu_domain_ops intel_svm_domain_ops = {
> +	.set_dev_pasid		= intel_svm_set_dev_pasid,
> +	.block_dev_pasid	= intel_svm_block_dev_pasid,
> +	.free			= intel_svm_domain_free,
> +};
> +
> +struct iommu_domain *intel_svm_domain_alloc(void)
> +{
> +	struct dmar_domain *domain;
> +
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +	domain->domain.ops = &intel_svm_domain_ops;
> +
> +	return &domain->domain;
> +}

-- 
Regards,
Yi Liu
