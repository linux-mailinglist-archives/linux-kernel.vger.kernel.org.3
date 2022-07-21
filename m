Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC957D54D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiGUU5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGUU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:57:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F08FD74;
        Thu, 21 Jul 2022 13:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658437068; x=1689973068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YD0yWRs2rO/Kd/l5RnQK88XGS5b5cmQSj2+xUQTJL44=;
  b=dvRz4agquSEi5aijMP6TpxfiZmwcB7UyUoFMW38vdi2PyhMAHZf1JzvC
   dNcoqSmuLKCYi2rd+JAl3YrYKY8FBMSLikdjVkq3Otu2t/IXrqkKwltLT
   ZJot5m2LL5YtPumKm8DAmcVvuEJBLxnbXjfoQ1Hf0dQeeGIkAob27P+Ro
   vKdCfSiU6HPuplRKGwKyhYcZ4FIOY4NWAvRCoV3yeHIXex0IXaWw5UY5H
   r/1vH4T+Ugjwru5ByLvQdoW1xEoJXFM0WHk3sZiau+pJssxodaHkhpxpf
   bYK2q+8eds5YZ66QlovSlFUEJcW7Q8k1GWNAP57BMD/SoGmzrgkRj/Nii
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287923763"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="287923763"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 13:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="925810903"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 13:57:48 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 13:57:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 13:57:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 13:57:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 13:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzHofOpM0LaN3+zMOhuq3xvyzI7kkbaoo0J5c4rD/05PkxdaKl/kLMUEVSA+xP8tFCUl31duuil640aj2GQ2BWMM5MmyQ2QbXP8ShzezVZaTfRGt47fPY3ChCPCGiE0O51po/WaZ/YuG7XvgAQ6GDqTBx7X3Ux0I6OQQ8arkkzD1vPtnvbAMELFA56mk0CgjFapGVMP96bJUGQD9D4nro1SRddwOFeUKl5ehcgN+lw7Ryl5Q+C4AlYE7rhV282iaQqpHxZD11lcVy1/CU5QyJWTmCSGEnjqJE8jvq6GBexXRgfZIVXKDLvXEWjI2JhOoBWh+SRWS3lA1XDIVTg7fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7jNaj2QP/OOehhlBU9NM+yDkSP74iTPrn8k6yUauF8=;
 b=gHZ6VBTD0BR44ZPqxKnKt0WgEH0NvHEyWN+HHrF8yznT3D6Xmxdxz2/5YOeZ7HBj4BTgz377mPW43RihEVkR39ZDbxxszLjQ3htIHYBv87vzE1F4Mnatim1soLQ0TVbrsdUKbHjPxZJ61d+KyxgIVy7lCTdAhJiEGB2B0GbnsdM+5B/1cnGcxW/E+SItQ+QHXXsJGf/IVZ9NbbjtQk4G6C8bKTrU5TcNuGaM3v8f2AeGefucCTuxAwGa6bRm+L+8y6cTCzd5uuaaNaieYEIPQvgCaKjCx91zUs4mukZTjfHb1aTIrQ/fmyp4hwWdzRB/ECU2538t52dzHeGbgsW0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BY5PR11MB3973.namprd11.prod.outlook.com (2603:10b6:a03:185::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 20:57:44 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::95a9:2d1d:b36e:4319%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 20:57:44 +0000
Message-ID: <cd56a293-6353-c57a-56c7-adb5b3052848@intel.com>
Date:   Thu, 21 Jul 2022 13:57:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] x86: AMX enabling example with new constants
Content-Language: en-CA
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220711171347.27309-1-chang.seok.bae@intel.com>
 <SJ1PR11MB6083E042762320A642D1FC5AFC919@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <SJ1PR11MB6083E042762320A642D1FC5AFC919@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0feef772-65cf-470d-7f23-08da6b5ba8a0
X-MS-TrafficTypeDiagnostic: BY5PR11MB3973:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPHzob8QOPLs70cgCYEzrzkwRiOrHd1g+UL377P8Z0aVMfRWlVa5074yxoelIdAApZa68Mo7qHpe9l8ZhF1l09o9onQQt77hQJkXrLjQjrii0xFOzYzpkqfz+nA585DKN1+aoeEQV6ZtZ15vgkNcD4q6+i7vAdui/iPt7JmOvJpL8+RH+hLNe9jfl8BOG2q7lpVCxRmjERLcJubtnQMytyRPKjVMUZriBq42e5MiShA8mxNwA2+GB/IP47lyRvjZl0+uobydAnl1xRNWxE6RG+zJkRyUyY3tRq9Q8WW1JgTTM3e6NitfBg3GQP49GxkZ2t6AFhNF3Uo/b5D46D4ou5MbCGj62rNdI68Pi+h6DntOwFrXkYtzArQ8jo5+LjQgAQsEXTiS6/Iee9qz8yRT44TApMfi83W2TKlQNVvqC2ZID9sSVIlboNtzmfl2oKhZ9UiwIvxn16JRR40mj7FFL8b6dTx7O6HPbwxRSa9PMiILNSWvlmChqNBNGmvpLiC7MOthmV9Lr0/dltpBWQXIyu8Qz8DwwJSWSOPipQDQXRc6IkmpO5g66ECXbc6OBe7ie8AL7Hq8GebLPNiqOBOfY25aM+ntTHRoYE6lCbdbmPNmqTCPeF8lRlLbkWeUJO2X48HFbh/WTm6N64kr9eYm0nobtd7pz47lr17ALks9VsqgNFqqGJ5cwcJMnDQx2EOZS0G5VrhAG/B5PoulPkpD2SVeRlzN/UalZJxV4jCTCmvusik0z1p1y2dKvV93g8cSa+Hea1jjBXmxsmnWdVgrEVnyVHB7gSSTurkesDnzMK+FMhGv9UQ/1p7WvrAxpOT9xpgyk5Gr9RFrzEDC6rUyCQ6KgKEvzIR+BpAQgI1JZHl0AoIKdio6pMS5BjuKm20w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(31686004)(82960400001)(86362001)(31696002)(921005)(38100700002)(36756003)(83380400001)(186003)(2616005)(966005)(6486002)(6506007)(26005)(6512007)(4744005)(2906002)(53546011)(110136005)(54906003)(66476007)(41300700001)(6636002)(316002)(66946007)(8936002)(66556008)(8676002)(4326008)(478600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVoT28rYkdzbzlEMmY1emc2ZmRYaFUvRUVEVXdJMmViSTRYQlVKMFZPSUFB?=
 =?utf-8?B?Rm1HMktadlA0L0J6dmpXWU1MTys3ckxEWEI5SjNUUU9GWFFMY0dHYWhmOVdy?=
 =?utf-8?B?RHI2d2Yrc1BFVW0wMmljRkIwZERiZ3l2UFZjdTdjaVBaNEdrMlE2K2VXcTlR?=
 =?utf-8?B?aVpBSVBJRnFMNWs1Q0xkeDJYRFEwdXBuZ2NYWlllaWpsckNndWxFNTlzMnIy?=
 =?utf-8?B?S2FvbldnWVdiQlZucENMTm9WS0l2UWNjbytwQ0pmdjZ3a0czc2tVVVNhdWRZ?=
 =?utf-8?B?c1BwT3Q4SldnSWRyZlI2dHE3ZEp5d1Jjb1FDMDFkNE1uT1pJL2d2TEs1OVRj?=
 =?utf-8?B?cDJFZlRXZXNiZzQwalpNdmlTNXVhdTRYQTVwcXZQNHRWVkRRcGpPS0ZvcDVw?=
 =?utf-8?B?b2g0cE1CdG5kcG1xQnJ3UEtJbVc1MWtpTC9RWmtMcFQ3NWtwd053bVd5QXow?=
 =?utf-8?B?ZHJVRVQxNjRvWWpnbCtaV3Rrc1ZxaXpjOU9tTkhhWElVTERNeWt6a3JDcFN2?=
 =?utf-8?B?QWhzMkY4U1ZVMlp0NHR1bkY4QlRYMFJmdzkyVFBRaGRvQXk1TjhCeTVGdmgv?=
 =?utf-8?B?N2JwR1lLMC9IdnFsQ2FzY1dYaXFiNUtZaG1oenNjYWJiNU5OMi9GRlRITmpU?=
 =?utf-8?B?NUxCeDExQU9Ob3VEejUwc2c1UDArbnFNOEVQVjhLM2FHL1l4Y25yd3RmVWRN?=
 =?utf-8?B?RlVGSFRRVDQ1NzNaYjBFNC9HOGNLTmRBOWQrK2xzU2N3MkxaaFRhbVNJR1hK?=
 =?utf-8?B?aTVoS3FEWjdGcTE2d0VuR25vWTI2UWwzYWZmQ014VlFGNGh3dGF5Nm9uYnJ4?=
 =?utf-8?B?WmlTSEg0ZUFmNnkvY1dOTk5NSlJSRkhUV0ZnN3dxV3ZTQmNEU1JTOGJtNDg0?=
 =?utf-8?B?RmFpUU16Vk5JdHFUUnh2T0pxVTY1UXJoK1RrOUM0TnZXVURSZlM4WUdpbUlL?=
 =?utf-8?B?L1VPVDZWTmNmMEtlOGtjcklMempvaU94bWhZNzcxRUJoTE0wUWNqVklaODRz?=
 =?utf-8?B?TlNyOW5PVGk1bmh4eERCUGxpQlBuRVdhNllXYXliMCtzTGhBOTRGNDV6VDh6?=
 =?utf-8?B?SjlmUHl0ZEF1ek5YVlFISWpxV0x6YzB3T1pNa1V0MDNhSWRUWEFCTzVVV1U4?=
 =?utf-8?B?N1Zxc2lMZmJrc2dKZ00zZUVxUnU2K0NVdVR5djl6Y3U1OXlZK2dOSnlaV3Jl?=
 =?utf-8?B?c3BneUFNdTB5QkpNQm0yM1VubitmdlF4ZzNKWXhGanVVYTk2UXdteVlUY2VL?=
 =?utf-8?B?TThXZ1MxNHI2d3F3YTROMVIxTE1mTWJFOUR1MndXYTh3bG1rSVFTYUF2aUNS?=
 =?utf-8?B?MWtOdTVHdmlackg0a3FCSzR4eWF3RzRTZ0VpSVpPSzJzZzFrM2JwL2dvcmhp?=
 =?utf-8?B?OEN0RGd0T3A5UXVBMUtOM2tHdXdUUXNjUlRZUHdyeGRETk9XRFpFdmVEU0lJ?=
 =?utf-8?B?TFNRUWRtOGJ2MldyYy9UTW83TDAwYmJFZk1WVGM3RVIraXJqVk9zQ3M5am04?=
 =?utf-8?B?OFp1L0ZxUTRKN0diRDJSOGhxano2US8wNUNwZmFMcVVjZGJ0Zm1RSWVGVnpE?=
 =?utf-8?B?TUZIOG5KdUtRdVRZTjVJRkhuYktIYVM4ZWhkbWFpcmd5MUZzSlBaRTdOQUJN?=
 =?utf-8?B?WFN0UjJhakFwTEx3Q3oveXhtTXNhNjl6YlJsSm5aL0poT2xkQ1NEVFZYbEZ0?=
 =?utf-8?B?VXJZU2o3Tkh2dEZ0OW1hMGJZZ0pBYTA1U1dYUzQvZThzR3Z0TG5icGp4RTlV?=
 =?utf-8?B?SGNKQ3lZdHRXSC81SDl5QmZBMkxXK0dMVVkrZUpwMGpDNEh2N0V4clNPeWhj?=
 =?utf-8?B?TzFmbE4vWlhtV3FWTkZpV0FwTy9nY0hOYzBTWndBZnUzSlRYamhiTEVoT083?=
 =?utf-8?B?SXQzS1hDZU0vZm1WMXRZQ29XOTZzV2pVYzNUQ2FjVklkcUtDYTB4eXplbE4r?=
 =?utf-8?B?WWE1V1ROenBGVG5ZNDIybk9POGxzVENSZXVhWnhzNDByWU9ISUpHRDEzalRJ?=
 =?utf-8?B?cHZqdzdtQ0djME9tK3JmTlRZN1diZTMraGxTUnJUaExxbDNOejlsaDA0d1dO?=
 =?utf-8?B?YkxjZFZxV0ZEL2ZJWE1VSTYrLzl3c2NjMSsyd3I1MlZmWlZPcERSUFlZYjZx?=
 =?utf-8?B?d3dyMk55SWMxaTBVZ0Y5RTZvWUN0T0RhWXY0ZnpsZGtKNk1RRmx1RFhHd2ZS?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feef772-65cf-470d-7f23-08da6b5ba8a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 20:57:44.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTkSnNNOFw62YHbLtQXBamgLTluUkRxL+T8eGKVXRmOY+WxqexiIyyYPV448XxKPEr6wzLzABsL7rlCAt7QiAUzrHLTc014EY8zpWyL3E0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2022 1:53 PM, Luck, Tony wrote:
>> The arch_prctl(2) manual page [2] is missing these new options. Perhaps,
>> the man-page update follows up along with this.
> 
> This isn't the right process to get a manual page updated.
> 
> See:
> 
> https://www.kernel.org/doc/man-pages/contributing.html
> 
> then log a bug, write a patch, and submit it to add the AMX options.

Indeed. I didn't intend this series to initiate the process to update 
the man page. Instead, I wanted to establish the kernel doc before 
starting it. But it looks like not super clear, sorry.

Thanks,
Chang
