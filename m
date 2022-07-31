Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999A8585EC0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiGaMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGaMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:01:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E411814
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659268907; x=1690804907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NftEYzNlBm7tQ5Q2edgwTBhpWapNn4lXiMN93Btzqjs=;
  b=d6KHC+tlaqGdbpxufSYxIieAzgC26Jv+MitZJT8jFQM9Y+PpBtv2lLGH
   1gYZ2r7e6EYGwlxmPVDO1CvhYfh6KYa76g5tdD4W96Pq8bA7XFhxc/y1T
   ZOtB86AD46/gHVqohi1uoHRwes+g98HoTF/sNBpWhkAiXNOOQcDuFX2Wa
   lGLWCbDf/8kwIPud4P2JKGoSPtu3zOL4sU8QvfLDVCLE1uzZQVb+kK9hD
   qigaNbkR7TFAYl62Nt2/IbjjjVXcwLqwZJ7Yx2i1MefXSsrNcUECJQK67
   AQ/E6prvNiHwM3/P9VlhLWVdFzrDXTYB+AF0yZtcK2CitNON22os3PabF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="352995319"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="352995319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:01:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629915128"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2022 05:01:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:01:44 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:01:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:01:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:01:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYPPvfNhqpRWnFMEdSgl2xku/cfqL59LAK/U+g97qufbz0ML3mMniRTsTsglAFIM1mxPjM7xHIBmGq55sjqzOsQ55JIY24AV6df/+WVKxeBGatjSIthwUneX8j/4O0FaWjppNTuyNCb8qKQ23bGqVTlA7P9jozbSe3o2YEyeAgUWogPQTj19JQNDfyR86Id+Km+Aj4Paasfzmq+cwNfYeH1cn9qJtDoISACkZw522A62JT/T0ijC0+YnHVbGffxIssQhECJihM3c/6KmPEOj7WO08uoKNFH/LZoJfiJsW23LOIBHWbn2e6mfT/rKJD3t9v6OmhnIdwQ9xP84rK5S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyD0LmZXi/BJI/HV46HctpShGXZiD7khN7zLYkI8LBg=;
 b=OIEplHVRYiQ1QzU2N0e5Is6zi/9WCjUN9D4HR3PR1J34zSjM6aGIwVq99EXt9V+0ez8IMOrz//atygcTTTgQeaIAdzrzch/8o1AUe9djwI/TJNI55F6ePhJRqC0f5NKRRUZtb+KUlf1rwvXZ+ZUQK5x0kG27ggBtUWEy7B0umyK4RqT/3fouGyS2Ea2DBz2HY2wowMA1aBR7r+Zlhq7qvRErJk+Da6+l4WsRXFNIYQGOWW4GeD4k4h9gq6J9vugKt2kMaJSPMu9VTo8kFVGlccoFvZEnM/+9pv9YUrtgnUjLUCK4UOQh/yPgLS9KqXRuqLEaPXaVNLi0+rYou5GosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by DS7PR11MB6222.namprd11.prod.outlook.com (2603:10b6:8:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sun, 31 Jul
 2022 12:01:39 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:01:39 +0000
Message-ID: <a87bd65e-b0f6-f020-79f7-d621168b5879@intel.com>
Date:   Sun, 31 Jul 2022 20:01:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 03/12] iommu: Remove SVM_FLAG_SUPERVISOR_MODE support
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-4-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8638be46-109d-4f6c-7ade-08da72ec6c93
X-MS-TrafficTypeDiagnostic: DS7PR11MB6222:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rebF7vsJGjrod28t3BANrmRqQPp4j4RbYW0cHOjw9/CX8TlmlmqVz5fVhlD3uRInAXoWLcmpoXEKFOo68fLxQCBlPraGViLG9QbM8ZZI+TvuFt+Qcpp66r99niuWTtiqMGZJfCyMd6foIIlkiWJOEt+fa5epXXzLcj8sn9tTbhYZdJqamXNeWZhyqnIvwQiuXg1IJsvbExTc7Z5LHcqoxTa/AmhJXvao9KPE7ua600rMS6pE1VuQ6l5oXtG4ljPDAsaFaYhqMInHnfnxoufH55L1rNpR/Mib7NNkJtApH0/KrKQ38ON4IUEK0t7A/m6Ss9cOAcC5skkEN0mmsPrfWyzdiifo51i4YVodPu0/rGxanp0nxXG9JlML7FEp3Z+sJl5la7O/gLFLNjOOr+lLxqFoRQIpH1ROUnQQzeoHPByxyrl808xo24jlTFQ8y0f86pEqJsQKAJjGTCKofGiCiIG8VU9y51B+OoDZlbaZey9KDX0nAIiJDgSqVawq7S/JZL2H3fLIlr74KF2ouNjo8igIwtwUI+SyZJ5tZUvircE+iprqEGdSotC9ipP3Z7LWo/tdAO2o+ZsS1lFb2FCSUou/kMcVwHUvXK5jk8fSPoIEZniaXvgjpqMiVeiGRqkBsZwJ7F9GDeFezXqn2ilYegBxHN3p6LDAxtxyeVVZokp4vWK5GGfgohshLbj5KS7u/DHQIoypYgZzZS5CayNhiItL0gF9qBT34dTE5ZXZNfr04VHCEmWLG3BK6/oYLMRYrWbyVSX9N4hxdXGvVLGfrtaO5yjaXh/uZmlBJAluangqrAwTOdp9bW/edyiExcsSM1h12aFBO5Q4uic2JOG4Yxo12RPTq0wELudGVgqXWqlnL6Xz0KXZ/fmSDsrdJ3vS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(366004)(39860400002)(136003)(66476007)(186003)(5660300002)(8676002)(6666004)(26005)(6506007)(41300700001)(53546011)(2616005)(8936002)(6486002)(31696002)(66556008)(2906002)(86362001)(36756003)(38100700002)(4326008)(316002)(110136005)(966005)(54906003)(921005)(66946007)(7416002)(30864003)(31686004)(82960400001)(478600001)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhSa01hQVM5S05VK1lRelJaTmpvZUlGYm9Fb0Fxd0p3VVNBcFN3dzJQTUlK?=
 =?utf-8?B?bk9aM2UybExvZGZHOVdXc3hWV3ZpeVZodmMzN2I3MlV4UUNtQ1lkeFBEa0Va?=
 =?utf-8?B?SEs2K1htaTE0OWo0a3BhRzdhWmEzNk4ySmNTdG8zdkUzeVV1Q0FBWGFQSExj?=
 =?utf-8?B?a1dqMytjemdndFRzMUdwOXRrbUlucTRnMGs3VkVmSUZ1c1B6QUo1ajdERVhB?=
 =?utf-8?B?S0NaRENIbFFxOXl3TUt2SkZsUnNXY091ZGhieDZQdGZPRFRPazJjc2lydEVN?=
 =?utf-8?B?ZEM3QjByRk1SbElTbWM5SnkzVmFtdjUxMm9MTVBOUlVZVnV0aEV6VXFpbmZu?=
 =?utf-8?B?bVRZd2ltSVVNbWRRTkpyRWQrS2czN1ZZUENkUWtjNnBFbVlFaXRadTZUa2Zv?=
 =?utf-8?B?Q3gxem5GTXJua25Cb011M0dPKy8yVU5XL01KYzkvaWtSd05QWmR0TEJOVUVu?=
 =?utf-8?B?VkdlL04rWHNRT0Z4VGNiWjlRRk54NjNhMXJKcVRtaVgwZkJCVFZZbGl0eVFV?=
 =?utf-8?B?M3phOUxwdE1IeGh1clpZLzdSZXpPbEVCSERYZThrQXVIdlRuV3JzM0s2ZUJV?=
 =?utf-8?B?SnZUU2kxcFJXRnR6aUxOME5TTlFiMGdyZW5hQ210Q1JsOHBEWFAzWEkyZXc4?=
 =?utf-8?B?aE1qOVp2dmtSOW8xc0FkUjJma3dXY0Zqa0l4OGxIMXYzV0JmalJMZHkxeHF2?=
 =?utf-8?B?Y3B6UCtVSDJndDM1Nk9BWFJ2dlZNaHB2c0RGcFFjaHIrcit6UUtpbUZCODVU?=
 =?utf-8?B?OW1vSXNLM1BFYUFFbGpER09tVCtVeGpsR1A3MHo0Q3p3bnNPUWxUWXRBeXcr?=
 =?utf-8?B?Q21uQTBVZXBzcVY4U3F1dHF6MUhmUDJWWERDZUNjK3RvMktaTVFlVmRLK2ts?=
 =?utf-8?B?NlJPQXhRdlVlUWU2alhTbkl2OFJFSW5RWHdqemtqaDVYdEhYRXJGOXYrbndi?=
 =?utf-8?B?RVZLODljVFFvVXlCb0x2bFVhN1BIamtFYjVUQXVDTU9Zai8xUWZTeFlicGls?=
 =?utf-8?B?TDZoSFhjVmF3WXFjTUhqdDl4QzdZM3RJRjlYMHlyMVllelg0RUVHaE1Ja0d3?=
 =?utf-8?B?SG9hc2RQb1dhRXBaRXpnUHlVWGlSYUc3UXhCVVBjQkxQSWV3VWNOOW5LVVVs?=
 =?utf-8?B?RGVQTDNmVHBuVlloQ2RLODRXeDl1ckVqSGVBMDF0YUlwOERTcGpMOWM0Qk5r?=
 =?utf-8?B?cEZzK3lYUDZhQmc2b2NTWW52UCtETGh0UjdWTFdyNWV5QjJkdXc3YUtDMUdD?=
 =?utf-8?B?OW5lWElRdEk2WmhiQVNQRFJxQmZETXlpZEt2UmRpRW5MeGZRK3loZStZaDA0?=
 =?utf-8?B?VXlXZTJ4WWp6R2ZQOUN3eFcyOEFBZFZKc0NtRmVVZlNhYkx6bXVHWHlCaXRk?=
 =?utf-8?B?a3llby9SQ0dvZGwrMGhGRVBJSEFSL3ZRQjZUbjUzUElLTGZmbU1SOXR5ZkZS?=
 =?utf-8?B?STdRdkRzRXBPUlA3Sy9XTFBJTVgwcUlFZktjbzk1OUowOSs5Y0xjU0o2RGI0?=
 =?utf-8?B?aHcwdUJBeVFiOVNjSmwwL01nUkY4UGhCYmNOd2RWZk9RZG9UbzFnL2h1N2pG?=
 =?utf-8?B?K2ZleE5NckZBRFpEYS9XUCtueGIzWVY5SFlLUzhsTHY0VGMrOXpCVzlGZGxI?=
 =?utf-8?B?bVhLakkwWklPLzBjWmRLeW91MCt1QjMzbVpYVlZzRUtodHBzeU1nTXpPVTJ5?=
 =?utf-8?B?YUhwMWlYTXBYKzJON0EwK0pKenFvOVVGUk5UL1hxeVdPTkR4amRsQlp0OWxG?=
 =?utf-8?B?VWZEY2N2NDJJMVJqdEtIODdONVcwZ2NTSjNQWElPUlBDeWRuUUEvdWlSNGhr?=
 =?utf-8?B?RHBjd3pRMXZLd1Zkemg2TGZJb0pacmMzY1pZZThmQXRyKzZITUhIVGZ0ajlp?=
 =?utf-8?B?aEpxTmc2WFUvT0R1MVUyWkpZTTd3T3JiRk1lbm5RL2s3T3UyZVZ3UWRKVWpD?=
 =?utf-8?B?MEtOZHoyVWlhN0MzS2I4ZnI4UFZFdFViZ2J6bHp1c1k3TTV4VjVHcDlSY1ho?=
 =?utf-8?B?R3BOclgvWWUwSEd0SDBmSWFDb1ZyaUozRGgyTXFBRjZBQytlMHF2cTNaR3RQ?=
 =?utf-8?B?czFQRjIzTG5JTkJrMG1XV2EyU2pOMGlTTG5DclRIRVVoVk9EUmdPdytvTnla?=
 =?utf-8?Q?ue4HZ6KKOSWHyoztfjyFysb4D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638be46-109d-4f6c-7ade-08da72ec6c93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:01:38.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIN+kbg7Vwq9RDWesDXgKpe6nICfrp1tHNH9nPnTc5qOZnxjfykRaovs1dCPzaJb1G/zb3qbZ7yxyE+3hDUm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6222
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
> The current kernel DMA with PASID support is based on the SVA with a flag
> SVM_FLAG_SUPERVISOR_MODE. The IOMMU driver binds the kernel memory address
> space to a PASID of the device. The device driver programs the device with
> kernel virtual address (KVA) for DMA access. There have been security and
> functional issues with this approach:
> 
> - The lack of IOTLB synchronization upon kernel page table updates.
>    (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
> - Other than slight more protection, using kernel virtual address (KVA)
>    has little advantage over physical address. There are also no use
>    cases yet where DMA engines need kernel virtual addresses for in-kernel
>    DMA.
> 
> This removes SVM_FLAG_SUPERVISOR_MODE support from the IOMMU interface.
> The device drivers are suggested to handle kernel DMA with PASID through
> the kernel DMA APIs.
> 
> The drvdata parameter in iommu_sva_bind_device() and all callbacks is not
> needed anymore. Cleanup them as well.
> 
> Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/intel-iommu.h                   |  3 +-
>   include/linux/intel-svm.h                     | 13 -----
>   include/linux/iommu.h                         |  8 +--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +-
>   drivers/dma/idxd/cdev.c                       |  3 +-
>   drivers/dma/idxd/init.c                       | 25 +-------
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  3 +-
>   drivers/iommu/intel/svm.c                     | 57 +++++--------------
>   drivers/iommu/iommu.c                         |  5 +-
>   drivers/misc/uacce/uacce.c                    |  2 +-
>   10 files changed, 26 insertions(+), 98 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index e065cbe3c857..31e3edc0fc7e 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -738,8 +738,7 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
>   extern void intel_svm_check(struct intel_iommu *iommu);
>   extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>   extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
> -				 void *drvdata);
> +struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
>   void intel_svm_unbind(struct iommu_sva *handle);
>   u32 intel_svm_get_pasid(struct iommu_sva *handle);
>   int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index 207ef06ba3e1..f9a0d44f6fdb 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -13,17 +13,4 @@
>   #define PRQ_RING_MASK	((0x1000 << PRQ_ORDER) - 0x20)
>   #define PRQ_DEPTH	((0x1000 << PRQ_ORDER) >> 5)
>   
> -/*
> - * The SVM_FLAG_SUPERVISOR_MODE flag requests a PASID which can be used only
> - * for access to kernel addresses. No IOTLB flushes are automatically done
> - * for kernel mappings; it is valid only for access to the kernel's static
> - * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
> - * A future API addition may permit the use of such ranges, by means of an
> - * explicit IOTLB flush call (akin to the DMA API's unmap method).
> - *
> - * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
> - * do such IOTLB flushes automatically.
> - */
> -#define SVM_FLAG_SUPERVISOR_MODE	BIT(0)
> -
>   #endif /* __INTEL_SVM_H__ */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 418a1914a041..f41eb2b3c7da 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -243,8 +243,7 @@ struct iommu_ops {
>   	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
>   	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
>   
> -	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> -				      void *drvdata);
> +	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
>   	void (*sva_unbind)(struct iommu_sva *handle);
>   	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>   
> @@ -669,8 +668,7 @@ int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>   
>   struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm,
> -					void *drvdata);
> +					struct mm_struct *mm);
>   void iommu_sva_unbind_device(struct iommu_sva *handle);
>   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>   
> @@ -1012,7 +1010,7 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   }
>   
>   static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>   {
>   	return NULL;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..d2ba86470c42 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -754,8 +754,7 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
>   int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
>   int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>   bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
> -				    void *drvdata);
> +struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
>   void arm_smmu_sva_unbind(struct iommu_sva *handle);
>   u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>   void arm_smmu_sva_notifier_synchronize(void);
> @@ -791,7 +790,7 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
>   }
>   
>   static inline struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   {
>   	return ERR_PTR(-ENODEV);
>   }
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index c2808fd081d6..66720001ba1c 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -6,7 +6,6 @@
>   #include <linux/pci.h>
>   #include <linux/device.h>
>   #include <linux/sched/task.h>
> -#include <linux/intel-svm.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/cdev.h>
>   #include <linux/fs.h>
> @@ -100,7 +99,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>   	filp->private_data = ctx;
>   
>   	if (device_user_pasid_enabled(idxd)) {
> -		sva = iommu_sva_bind_device(dev, current->mm, NULL);
> +		sva = iommu_sva_bind_device(dev, current->mm);
>   		if (IS_ERR(sva)) {
>   			rc = PTR_ERR(sva);
>   			dev_err(dev, "pasid allocation failed: %d\n", rc);
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 355fb3ef4cbf..00b437f4f573 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -14,7 +14,6 @@
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/device.h>
>   #include <linux/idr.h>
> -#include <linux/intel-svm.h>
>   #include <linux/iommu.h>
>   #include <uapi/linux/idxd.h>
>   #include <linux/dmaengine.h>
> @@ -466,29 +465,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>   
>   static int idxd_enable_system_pasid(struct idxd_device *idxd)
>   {
> -	int flags;
> -	unsigned int pasid;
> -	struct iommu_sva *sva;
> -
> -	flags = SVM_FLAG_SUPERVISOR_MODE;
> -
> -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> -	if (IS_ERR(sva)) {
> -		dev_warn(&idxd->pdev->dev,
> -			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
> -		return PTR_ERR(sva);
> -	}
> -
> -	pasid = iommu_sva_get_pasid(sva);
> -	if (pasid == IOMMU_PASID_INVALID) {
> -		iommu_sva_unbind_device(sva);
> -		return -ENODEV;
> -	}
> -
> -	idxd->sva = sva;
> -	idxd->pasid = pasid;
> -	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
> -	return 0;
> +	return -EOPNOTSUPP;

this makes it to be a always fail call. right? will it break any
existing idxd usage?

>   }
>   
>   static void idxd_disable_system_pasid(struct idxd_device *idxd)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 1ef7bbb4acf3..f155d406c5d5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -367,8 +367,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   	return ERR_PTR(ret);
>   }
>   
> -struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>   {
>   	struct iommu_sva *handle;
>   	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7ee37d996e15..d04880a291c3 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -313,8 +313,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
>   	return 0;
>   }
>   
> -static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
> -				 unsigned int flags)
> +static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
>   {
>   	ioasid_t max_pasid = dev_is_pci(dev) ?
>   			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> @@ -324,8 +323,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
>   
>   static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,

would be great to see a cleanup to rename the svm terms in intel iommu
driver to be sva. :-)

>   					   struct device *dev,
> -					   struct mm_struct *mm,
> -					   unsigned int flags)
> +					   struct mm_struct *mm)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	unsigned long iflags, sflags;
> @@ -341,22 +339,18 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   
>   		svm->pasid = mm->pasid;
>   		svm->mm = mm;
> -		svm->flags = flags;
>   		INIT_LIST_HEAD_RCU(&svm->devs);
>   
> -		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
> -			svm->notifier.ops = &intel_mmuops;
> -			ret = mmu_notifier_register(&svm->notifier, mm);
> -			if (ret) {
> -				kfree(svm);
> -				return ERR_PTR(ret);
> -			}
> +		svm->notifier.ops = &intel_mmuops;
> +		ret = mmu_notifier_register(&svm->notifier, mm);
> +		if (ret) {
> +			kfree(svm);
> +			return ERR_PTR(ret);
>   		}
>   
>   		ret = pasid_private_add(svm->pasid, svm);
>   		if (ret) {
> -			if (svm->notifier.ops)
> -				mmu_notifier_unregister(&svm->notifier, mm);
> +			mmu_notifier_unregister(&svm->notifier, mm);
>   			kfree(svm);
>   			return ERR_PTR(ret);
>   		}
> @@ -391,9 +385,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   	}
>   
>   	/* Setup the pasid table: */
> -	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> -			PASID_FLAG_SUPERVISOR_MODE : 0;
> -	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> +	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
>   	spin_lock_irqsave(&iommu->lock, iflags);
>   	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
>   					    FLPT_DEFAULT_DID, sflags);
> @@ -410,8 +402,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   	kfree(sdev);
>   free_svm:
>   	if (list_empty(&svm->devs)) {
> -		if (svm->notifier.ops)
> -			mmu_notifier_unregister(&svm->notifier, mm);
> +		mmu_notifier_unregister(&svm->notifier, mm);
>   		pasid_private_remove(mm->pasid);
>   		kfree(svm);
>   	}
> @@ -767,7 +758,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			 * to unbind the mm while any page faults are outstanding.
>   			 */
>   			svm = pasid_private_find(req->pasid);
> -			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
> +			if (IS_ERR_OR_NULL(svm))
>   				goto bad_req;
>   		}
>   
> @@ -818,40 +809,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   	return IRQ_RETVAL(handled);
>   }
>   
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
>   {
>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> -	unsigned int flags = 0;
>   	struct iommu_sva *sva;
>   	int ret;
>   
> -	if (drvdata)
> -		flags = *(unsigned int *)drvdata;
> -
> -	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
> -		if (!ecap_srs(iommu->ecap)) {
> -			dev_err(dev, "%s: Supervisor PASID not supported\n",
> -				iommu->name);
> -			return ERR_PTR(-EOPNOTSUPP);
> -		}
> -
> -		if (mm) {
> -			dev_err(dev, "%s: Supervisor PASID with user provided mm\n",
> -				iommu->name);
> -			return ERR_PTR(-EINVAL);
> -		}
> -
> -		mm = &init_mm;
> -	}
> -
>   	mutex_lock(&pasid_mutex);
> -	ret = intel_svm_alloc_pasid(dev, mm, flags);
> +	ret = intel_svm_alloc_pasid(dev, mm);
>   	if (ret) {
>   		mutex_unlock(&pasid_mutex);
>   		return ERR_PTR(ret);
>   	}
>   
> -	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> +	sva = intel_svm_bind_mm(iommu, dev, mm);
>   	mutex_unlock(&pasid_mutex);
>   
>   	return sva;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0cb0750f61e8..74a0a3ec0907 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2788,7 +2788,6 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>    * iommu_sva_bind_device() - Bind a process address space to a device
>    * @dev: the device
>    * @mm: the mm to bind, caller must hold a reference to it
> - * @drvdata: opaque data pointer to pass to bind callback
>    *
>    * Create a bond between device and address space, allowing the device to access
>    * the mm using the returned PASID. If a bond already exists between @device and
> @@ -2801,7 +2800,7 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>    * On error, returns an ERR_PTR value.
>    */
>   struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>   {
>   	struct iommu_group *group;
>   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> @@ -2826,7 +2825,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>   	if (iommu_group_device_count(group) != 1)
>   		goto out_unlock;
>   
> -	handle = ops->sva_bind(dev, mm, drvdata);
> +	handle = ops->sva_bind(dev, mm);
>   
>   out_unlock:
>   	mutex_unlock(&group->mutex);
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..3238a867ea51 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>   	if (!(uacce->flags & UACCE_DEV_SVA))
>   		return 0;
>   
> -	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
> +	handle = iommu_sva_bind_device(uacce->parent, current->mm);
>   	if (IS_ERR(handle))
>   		return PTR_ERR(handle);
>   

-- 
Regards,
Yi Liu
