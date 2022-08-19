Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED85997D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbiHSIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346080AbiHSIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:39:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9D2BF7E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660898367; x=1692434367;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2oXC2Rh9gTQrMnIpvep+DkY6ag7cNME0bCSmtyTb8hc=;
  b=IcC96K+XX+b3x7lOV3rVIBg7dnBYihh5WaQ8lCrvntuWzQo7P4P43BYQ
   8U9cxhEL5uJFltXeyl0y7kC1m5HZ8p2pYu/nuyQ6n8RXomw9m3e4kGgb5
   AXrSGFY+YgsrXMVOBRaafa/0DUo0hQzwjX+Ys0nP8hC1J61IdM0VlAgXd
   6UGCS591NcCoJJ6IKtL5WQiTQGQJC+I7Y8P4CxCJ5aUTKksvu5zfYXt4K
   ndlccuyOe4MAsuakul6tOrgQSn2A80ORu8NGzVEqhBV1gLfKCt8eLfY0r
   ieTIyAoeM3WFuluftuRgIFyntKbEk5G6fGc7gon1+Qj5NYujg+NoKYAXF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="293755478"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="293755478"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 01:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="584582055"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2022 01:39:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 01:39:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 19 Aug 2022 01:39:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 01:39:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 01:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoUOBQDvYCibJRBOZnZq2TsiA0e7uJU8nzWEdoZMTqFUgd/WUnatVJaANnMFgci7DwxeJhsXVVcj7QECEpq/fWyUp4Hirmvuamhd00Q0iR7aRl8UtxRu8DL2fce7A1vV8o/up8jhthj3ChkbxGikfOxwwTDs9zBGcJRBAq9rfiAyEZDFs9u3u6uyZLNDHGEjuuxrIHWn6E2RRL/hIfHXtMUVxipJOq/hnCBu+zeO74bJCBIJ0TfBpf4u2o1wRafIhM3gcAyeTMtPdElnGBcn86H34hGNo9yuYKCfR/ZU6nB8d/QS9vN/FRTwEhR6pBuqyd2w7z8gE+dkOuDfMkCyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRwBKZge+qt8HZiHyP+jaapTfb/SDdm5FCap/sxgt74=;
 b=AnYEv7y42IB5g3nukkmNFxIhBRbnd5WOEmf979Gx8NTMAJauCZn5SSaT84trQMOirVPvfxux/3BJyRCIccbGCNX/RiqO9UGO9T8it+B0ckRkkwntuIHE371I6ZcFtZPwgr92ymGTKkcy4Utuhy9DRtzTT9H2K0UTq/NT1OdGrAQG/hZrqhN8Xl8Sky0py74z7EOqniDti1v4Lxd3j9gyK8sJOGPnO/FKSbmNQLYcgc5DFnZr53o2J33bxZi/Mfr/M9H8PnI4ssbyvRSnbl/3fSVLM6k1+QcRHFdi+kKU6BWHmswVjMGjbmXnhHpqEo9blZWz6/hGmpTaSG9VR3VSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BN9PR11MB5402.namprd11.prod.outlook.com (2603:10b6:408:11b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 08:39:22 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Fri, 19 Aug 2022
 08:39:22 +0000
Message-ID: <a128efb7-ae33-59c1-cc32-8893c2af897a@intel.com>
Date:   Fri, 19 Aug 2022 16:39:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
 <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
 <20220816023951.GB3590@sophie>
 <03f8614e-2bd7-afa8-6744-14397cbc9cb1@intel.com>
 <20220819050358.GA3930@sophie>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <20220819050358.GA3930@sophie>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b901dc-625d-42f2-fbed-08da81be506f
X-MS-TrafficTypeDiagnostic: BN9PR11MB5402:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EvG/W3I6QpUyidC63Dwi9XicSsU/1BZwdmD9vPYKSkWJhwvAQCkDOrLHYsZz7WKaqbdqDaqlib2rS5W5863V5wIPq3t2uh38TxJSHfn1qGItTMf53MfOp9StZs4hzYmey2JCOS3ri4A6T2+6LUNRhizdNfECLkOucJWEBUi5wqZtbydz6nyo1gqBFMPSwxHdZSRAla3V/XEvfQTxGkhcCqHvrMeapFfFfVP/aLVVlSQruEkhBjiJ0/dLY0SlgwDy0qpYwK51DjyPMOaGJkUREcRPSEAHlTYrJuY+Y80bAzRHJMmxuF9Bs6a5Nuechd2MMozXzrQUbH3Oz0btM6w0ZlazoApColl1wVWk4pl8IAFclHwEMccBdvZK6e/wlC6pqe+N6M4vOw/AD4RFTxU8ZXkftApvqdRCtMsMHE7SPHFNOPr2f38kqCoFvLBtt9o0ZL6aK+tcBNX3NCq/gwb8UN3R1Svjns8vmOM00S+m7wsGvGVooy5fEM8KpeCmtE2mCcaXkwdXkV2TV9GRVNEGxrQ9fwB7KjvblqxP0X5c7SdEPC3/ZIoSRenqOJivmrxpXxBbnV0zyinIVcEp28CFBMD0IslQnpVygZeKPFdNoK8uvUt7l/mhGzZtASWGbudWQIs51CuslnXuVDtLPcXdL847hs14N0UFfBaf78ZsohrgBMVRJCizFcpyhykKbUq2jSRSE7xKWii3nRel/9bSssLjomK27Dn8/NdSVihPKnT+xr86U2EtKHkBkDCoXRtdRdQ3P8wXerXIlHBu11L3pMIFGzqGBual3oZvtUEzX4PW2ULwAr0/xOsrp7g4kYs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(376002)(366004)(53546011)(6506007)(38100700002)(26005)(83380400001)(2616005)(6512007)(82960400001)(36756003)(54906003)(6916009)(31686004)(316002)(8676002)(66556008)(6486002)(66946007)(5660300002)(8936002)(66476007)(30864003)(6666004)(4326008)(41300700001)(2906002)(478600001)(186003)(86362001)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dOaG9lN05PcjRRaXdNVTBmdTNqb3ltK1diYno1VTAxTHpvTGQ3Tk9MZVZM?=
 =?utf-8?B?TnN0M1YxR1ppbk9uVHQ5TjJ0UE5LVmVlaGM4Q0Joa3VXTGZ4RWhKRXpHTEd6?=
 =?utf-8?B?dHByelE2Q1o0b08zaUlRTXRhelJDOWU0NjhvZSs0U1hQSVJqVElYdEVseFB0?=
 =?utf-8?B?TTNaUDZ4NWFrRFFMd2hOZElGQ0RBVFByTkN0ZmZKOXFpSUt5Q0t2ZzY1VUxW?=
 =?utf-8?B?Zm5DUjZncW9ONGdlQjE1Y3o5bFhKYVNudmY5bGJXV24wVC9aSU1zWEwrTTlW?=
 =?utf-8?B?Y0hMYzJIQTdmOGJLSWRQL0xhYW1XOHdWWXNhSU53UlpaYWdJN2phRFFxcGFS?=
 =?utf-8?B?TnJocHpHL2ZUbVBJRGQzM3FBclRoVjVVWGhETmwxajhaOUZWZHlrSDQ3QTBi?=
 =?utf-8?B?REtCRTVuZHJEb0pSYUVjSU1odEZsVTZwTFBiQndIUDc1MnhSb2QveXI2MVFr?=
 =?utf-8?B?NElSeElhRkh4YkNnSklwcTZITXAzOWNoS0RLWHpVYzMxaVVRY1E0bGFYem9G?=
 =?utf-8?B?YVdNb2dwc3JZVWc2SGtXVk5IU3VqcVdIaDFKRVo1NGZPcUd0Qm1xVU05NjNO?=
 =?utf-8?B?ajczcWZacWJiQ3ZyTXNwNXdoRkJPRGMwQTBsRFQvcTM1NXVUcmVEN0hoakEz?=
 =?utf-8?B?UWdGZVhNenhwRTdBbStHc2t2dG5abjBGdG0wdENIcUhtbUZJbXRBK1lzNk1W?=
 =?utf-8?B?QTExdTlIdWFiSm5Ea2VDV09RL1RpcmlRMSszYUFDeHhmVk5ESk9YZ3Q1S3pn?=
 =?utf-8?B?REVad1QrTzFrZXdCTzBrYzJiSUNlc3gxV01FQzJiQzhiUzJkNHFOalVEaVZF?=
 =?utf-8?B?KzR4S1EzZjhCQThzLzR5c0FwNUFjN2ZNRDVoOTNVOUUxV29XMk1QMEdkNkdR?=
 =?utf-8?B?Sm9DV05UdVNWdWhLRWZ1RUZmb0dFRHlXenR2UGpJa0lTdW5RMGFZUjNCdis0?=
 =?utf-8?B?VXpxY2x6V01LeGxKWGI2S2E1WjJwcmlNR0lCc0ZDRk1SV3Fhb2U4WXJCem00?=
 =?utf-8?B?SGFSMDhHclliMEp5S3d2ODkyRTNhMUVhNnBrZzdjd0JUakZMalljeUFycUNC?=
 =?utf-8?B?Sy9TeStvcEhmRWN2ZUgyN1dSQmRwaEpKazFENXhBUnhaSGk0c3lkeGR2aThl?=
 =?utf-8?B?b3lvSUU0cWdOWk9KMHEzS0pPUk93SXdxbHl0a3czRFZQV2V6L0JhWlN6RkZD?=
 =?utf-8?B?MzliMWs0YkIwQlNFNExKVk5vRWhTbWh6aUhjOFQ5MHBPQ3VzMzN1cjZ2Nm0z?=
 =?utf-8?B?cUpyY1ppNzN6WktzQW9kZTdRckVaRUFaakpRbEVITjduMEhlRFAwSSsrSHRM?=
 =?utf-8?B?L2NnYUprZU9oeXc3Y0gxMkNXdi9RWE5jZ1U4QUFzbTNPMXNlVjA5RzY0NU5I?=
 =?utf-8?B?QU9BK1haT0tIR2pEaUpiWTR1MFp5Y3hlL1E3S2s4Z1kvU2ttQndObUJQblRm?=
 =?utf-8?B?d0I4Tkp2TGN0ZU0yRzE2cnM3ZlJJWmVScjY5QVZ2bDVIamdKK0tRUzl5eWtF?=
 =?utf-8?B?SnFsdjlveUlKc3JzdkV2ZzAvYnU5TU10MUhQdVhHS29xUUVTY2hHV01CRU9l?=
 =?utf-8?B?MjMyNkp2Wm1OTGhuVGJaVWpoSi9ZTm5kVmd5MXdSaDRnT2d2TWhMazd2MlEw?=
 =?utf-8?B?WGU3QlA4TVkwbmQ4K25ta2xQZ3ZUMXYrbnNXMTd4cnFyYk1oVVlSQzliZjQ3?=
 =?utf-8?B?M0tiTEdrd1ZSOGdQQy80dFJqS2xYM21RY2ZyVFJPamR5K0JNL0RHbGNKc0t0?=
 =?utf-8?B?M3J2aEoyL0pvQ2UyQUhLVnFENTBVais5Zm50aG5pRlQxbW5pYkt6VmhjakFF?=
 =?utf-8?B?M1ltT0t5VW5abEJaWDViclVRcUtzMzRad081Wkc4VnFxdnZIOGNnK3BxRVUz?=
 =?utf-8?B?NzRoK0dubVRYazdtblVBK2RCT2l2WEFsNnV0aTcvZW0xMFJ4ZW9zQks1MFF6?=
 =?utf-8?B?c1FpaGhRUGlwSzdXV3RTem5SQTBDbTRBVktlZm1qcjJmTzJqYlVwbEp5UGxy?=
 =?utf-8?B?bnRGTVJjRVN3ejlJeEUvbVBsU0RKdUVoNXNLSTVGMGVkMUk4WUoxTms0WTRz?=
 =?utf-8?B?ZFloNzFYWWNmb3BxUktjc2dPWFZoNmEvaCtab0dXMjUwYjR1Q0EvYXRHUEFx?=
 =?utf-8?B?TlQza0ZpKytOZmtZRE1CaVhuUjFWbTd4TFdXUUJ5c1R1bXZvS1NrLzVGYVox?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b901dc-625d-42f2-fbed-08da81be506f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 08:39:22.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfBpnvRXzkETw/OmmPR5zfPx3wjgcQaeBBAvPBhgOy5bCtDlh7/x967JInrHpobFX+JpZCfygghphUu8bUHK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/2022 1:03 PM, Rebecca Mckeever wrote:
> On Tue, Aug 16, 2022 at 11:08:44AM +0800, Huang, Shaoqin wrote:
>>
>>
>> On 8/16/2022 10:39 AM, Rebecca Mckeever wrote:
>>> On Mon, Aug 15, 2022 at 05:15:47PM +0800, Huang, Shaoqin wrote:
>>>> I found original some of test function has the prefix `top_down` and
>>>> `bottom_up`, and some of test function didn't have the prefix.
>>>>
>>>> In this patch, it just modified these functions which didn't have the prefix
>>>> `top_down` or `bottom_up`, and now there are two style about these test
>>>> functions in the code.
>>>>
>>>> One is:
>>>> 	run_top_down(alloc_in_between_generic_check);
>>>> 	run_bottom_up(alloc_in_between_generic_check);
>>>>
>>>> Another one is:
>>>> 	memblock_set_bottom_up(false);
>>>> 	alloc_top_down_before_check();
>>>> 	memblock_set_bottom_up(true);
>>>> 	alloc_bottom_up_before_check();
>>>>
>>>> Thus there gonna be two output style, here is an example:
>>>> ok 89 : memblock_alloc_from: top-down: alloc_from_simple_generic_check:
>>>> passed
>>>> ok 90 : memblock_alloc_from: bottom-up: alloc_from_simple_generic_check:
>>>> passed
>>>>
>>>> ok 99 : memblock_alloc_try_nid: alloc_try_nid_top_down_simple_check: passed
>>>> ok 100 : memblock_alloc_try_nid: alloc_try_nid_bottom_up_simple_check:
>>>> passed
>>>>
>>>> It may make confuse if one is printed between the colon and one is inside
>>>> the function name.
>>>>
>>>> So maybe make the style consistent is more make sense. And I think this can
>>>> be done by modify all these function name which with `top_down` and
>>>> `bottom_up` inside, and replace them with your new run_top_down() and
>>>> run_bottom_up() functions.
>>>>
>>> So you're saying use run_top_down() and run_bottom_up() even for functions
>>> with `top_down` and `bottom_up` in the name, but don't change the names?
>>>
>>
>> Yes. We can't delete these `top_down` and `bottom_up` in the name and makes
>> two functions to have the same name. Due to these functions with `top_down`
>> and `bottom_up` have different implementation.
>>
>> If use run_top_down() and run_bottom_up() for these functions. We can get
>> the consistent output style, but a little redundant output(Maybe this isn't
>> a good idea).
>>
> Yes, I think the output would be too redundant. Even though there are
> two different output styles, the style is consistent within each pair of
> tests. So there is at least a consistent pattern.
> 

Ok. Just keep the current implementation is fine.

>>>> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
>>>>> Generic tests for memblock_alloc*() functions do not use separate
>>>>> functions for testing top-down and bottom-up allocation directions.
>>>>> Therefore, the function name that is displayed in the verbose testing
>>>>> output does not include the allocation direction.
>>>>>
>>>>> Add an additional prefix when running generic tests for
>>>>> memblock_alloc*() functions that indicates which allocation direction is
>>>>> set. The prefix will be displayed when the tests are run in verbose mode.
>>>>>
>>>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>>>> ---
>>>>>     tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
>>>>>     .../memblock/tests/alloc_helpers_api.c        | 12 +++----
>>>>>     tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
>>>>>     tools/testing/memblock/tests/common.h         | 16 +++++++++
>>>>>     4 files changed, 44 insertions(+), 56 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
>>>>> index 71c89cb9b2a8..73c2c43e702a 100644
>>>>> --- a/tools/testing/memblock/tests/alloc_api.c
>>>>> +++ b/tools/testing/memblock/tests/alloc_api.c
>>>>> @@ -752,10 +752,8 @@ static int alloc_after_check(void)
>>>>>     static int alloc_in_between_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_in_between_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_in_between_generic_check();
>>>>> +	run_top_down(alloc_in_between_generic_check);
>>>>> +	run_bottom_up(alloc_in_between_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
>>>>>     static int alloc_small_gaps_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_small_gaps_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_small_gaps_generic_check();
>>>>> +	run_top_down(alloc_small_gaps_generic_check);
>>>>> +	run_bottom_up(alloc_small_gaps_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
>>>>>     static int alloc_all_reserved_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_all_reserved_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_all_reserved_generic_check();
>>>>> +	run_top_down(alloc_all_reserved_generic_check);
>>>>> +	run_bottom_up(alloc_all_reserved_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
>>>>>     static int alloc_no_space_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_no_space_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_no_space_generic_check();
>>>>> +	run_top_down(alloc_no_space_generic_check);
>>>>> +	run_bottom_up(alloc_no_space_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
>>>>>     static int alloc_limited_space_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_limited_space_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_limited_space_generic_check();
>>>>> +	run_top_down(alloc_limited_space_generic_check);
>>>>> +	run_bottom_up(alloc_limited_space_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
>>>>>     static int alloc_no_memory_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_no_memory_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_no_memory_generic_check();
>>>>> +	run_top_down(alloc_no_memory_generic_check);
>>>>> +	run_bottom_up(alloc_no_memory_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
>>>>> index 796527cf3bd2..1ccf02639ad6 100644
>>>>> --- a/tools/testing/memblock/tests/alloc_helpers_api.c
>>>>> +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
>>>>> @@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
>>>>>     static int alloc_from_simple_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_from_simple_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_from_simple_generic_check();
>>>>> +	run_top_down(alloc_from_simple_generic_check);
>>>>> +	run_bottom_up(alloc_from_simple_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
>>>>>     static int alloc_from_misaligned_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_from_misaligned_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_from_misaligned_generic_check();
>>>>> +	run_top_down(alloc_from_misaligned_generic_check);
>>>>> +	run_bottom_up(alloc_from_misaligned_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
>>>>> index 71b7beb35526..82fa8ea36320 100644
>>>>> --- a/tools/testing/memblock/tests/alloc_nid_api.c
>>>>> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
>>>>> @@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
>>>>>     static int alloc_try_nid_min_reserved_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_min_reserved_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_min_reserved_generic_check();
>>>>> +	run_top_down(alloc_try_nid_min_reserved_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
>>>>>     static int alloc_try_nid_max_reserved_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_max_reserved_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_max_reserved_generic_check();
>>>>> +	run_top_down(alloc_try_nid_max_reserved_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
>>>>>     static int alloc_try_nid_exact_address_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_exact_address_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_exact_address_generic_check();
>>>>> +	run_top_down(alloc_try_nid_exact_address_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_exact_address_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
>>>>>     static int alloc_try_nid_reserved_full_merge_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_reserved_full_merge_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_reserved_full_merge_generic_check();
>>>>> +	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
>>>>>     static int alloc_try_nid_reserved_all_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_reserved_all_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_reserved_all_generic_check();
>>>>> +	run_top_down(alloc_try_nid_reserved_all_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
>>>>>     static int alloc_try_nid_low_max_check(void)
>>>>>     {
>>>>>     	test_print("\tRunning %s...\n", __func__);
>>>>> -	memblock_set_bottom_up(false);
>>>>> -	alloc_try_nid_low_max_generic_check();
>>>>> -	memblock_set_bottom_up(true);
>>>>> -	alloc_try_nid_low_max_generic_check();
>>>>> +	run_top_down(alloc_try_nid_low_max_generic_check);
>>>>> +	run_bottom_up(alloc_try_nid_low_max_generic_check);
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>>>>> index 7a16a7dc8f2c..e0dd5b410099 100644
>>>>> --- a/tools/testing/memblock/tests/common.h
>>>>> +++ b/tools/testing/memblock/tests/common.h
>>>>> @@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
>>>>>     	prefix_pop();
>>>>>     }
>>>>> +static inline void run_top_down(int (*func)())
>>>>> +{
>>>>> +	memblock_set_bottom_up(false);
>>>>> +	prefix_push("top-down");
>>>>> +	func();
>>>>> +	prefix_pop();
>>>>> +}
>>>>> +
>>>>> +static inline void run_bottom_up(int (*func)())
>>>>> +{
>>>>> +	memblock_set_bottom_up(true);
>>>>> +	prefix_push("bottom-up");
>>>>> +	func();
>>>>> +	prefix_pop();
>>>>> +}
>>>>> +
>>>>>     #endif
> 
> Thanks,
> Rebecca
> 
