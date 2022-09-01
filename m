Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B345AA116
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiIAU4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiIAU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:56:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7062474D6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662065775; x=1693601775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQknBmlWjIeyIFTD3S3qNZI+ouP/Y0fpFS7iT4rBcMg=;
  b=eXaHxtaghldMCZIA2+Z8pcqvNnRxHJtNicSuQDRyyGaFerIthRSIl9Z9
   4S0ZFZ7P7uBPyadVqy0RVWRUKXC5Wj0TrDx/d2C/oerqL/QhPnKOJc6FJ
   EvuYfvW92AwN9rBNDeFV+EmtZ6JU32yeBjLpczTnTS4puHIngIvOoSfOF
   kOHaUrmOSE5q7MhDDfo09hIj+8YlydhSezcCTFUS+gm6ybo2l7hjbJym5
   pHo7639kKf+EJLOmqm+trUJimZQD323R4qnHdhRieF+FE2zyavUHJFgvy
   1WBHlvjfLMzly1poMJztUtuhEmFN7rTN83KKkP9HQV6olkv7Vim4fBseN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297109798"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297109798"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642551109"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2022 13:56:15 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:56:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 13:56:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 13:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4WQn2NaX284QXeVSVmjL+bjR8RrJUz/xfYSov6z9bPUXk9yNxBnwZOO8D1x7BbVeIBmBKp41jU8ReYoYnahyh399CfxpthnaSh+nNgQW8w38i2VahjGf+sPIz0NgTD8PobySZTqw7U/Aus0dLmoQe8FnOBjAOg9iDeetw1vcsUN8DeSiY2024RqX+2SGRzH0jZCj+4gBPX98L7RSeGrFCGVJ8f0O8XYNLa0XInbbJqq3B8wR+79u9aytoMuZ27UTr2AQO155b5V+KKtqngjTREWh8nIC2rx6mPrvp/2e5cTVpXW1XsggxMUnk2PlO5VlwOggWXKqXfMt7sL4wU13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41uf3IEyjF3u3mutxxOYHCKgnEZzrG9YDX4Zzw4pdSY=;
 b=UrPPoTKh3yIHpwFpGh/LJHi4Z5Q7AW8IBZrd/EuZSP8X1cUwZSP74V5WPrJUpaNqi/8T/V+aqYETmkiN136dfJ0XmBTMWivHWmgOl0fIVkEEOzrmt4qtNkjY95Loxc9IIwZFV8af4zNfzIX7DY2vBNcgzpI+MAITCUY4CXaGMhK3ZORhLj7vlutDQk6SNHsegj6DBMcsaxBupip2KJlYnrEWjEPJEjipRC7hIFqK+XMfeWpQGw21ZQ/ZhQzXeNVnbFKJwUipmVK03hSs/i59q//tYs2nccUcDCJbnZDvmJApXIYzsxN0h1uYvYwoeejr3zTlC2LzpALc5dwiV7BCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 20:56:13 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 20:56:13 +0000
Message-ID: <bcdba86f-45ca-3e6f-e03c-5c991fd08235@intel.com>
Date:   Thu, 1 Sep 2022 13:56:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 10/15] mei: mkhi: add memory ready command
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-11-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-11-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b817d588-7596-4294-179f-08da8c5c6794
X-MS-TrafficTypeDiagnostic: CO1PR11MB4899:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtfB0keWJpltV+eZAZDgeJGHvo4Sey1ChwJoSYgJq9o50f7BVt/kGPsV8yq/qsTZRysOVXRdI+F2jXGeAW2/7SCE8XWC0OyDP2CF4r+UoSpfmaOFG5Eq14vw1xiOSQ6FMpoY9ihPTDGohkuaJJqbwa8PI4lqkK+WywDtuR6G7ya22ipJ4gQfNpGF4sdSJvYWmd89XuR2OygIWpzZ3XA+F/BrKXCubU86BFiL8ot7jKjsteV04OSGZQpAhvUY16BH0iPdplZYhtUZ7+Id4rMiYJBMr4DiWtknvARz6d20dn6U7u/6V3sluixyLY4MsoJDZbHUby0MShTUt7IEqhLHzOiutnfJvfWdue9ObSQw6pGGcN1bbh0rjkLAvqRbQMN7kd3tBMZIHIdcO8qNJDJbUqgg4aYepRD9jLZyn4EqmfVwMVzitg9LvbsKXsY8gJZRt0Is3tZBIMKc0yeANLr8RYiKGNI7Z3LTKForeT26pYRi9GpK4ScuFy39Pwo2nY3hPZn5EQiGZZIV9DLbOPzsK/msAyqSzS/0IVMhnPG+fhmTxXQuAKd424gJz2xhiQLNw6Wy49hJ9zby9KMJoQ7JbQifmQebYHMLNTuQPQEwSX9J2gU4jPnS5GBAjiITN+Iduc9tFSBxiA8KjXtC3TMaMvNOyv5RX5DbU0qaUqXiuMe/iFaDwUDIazl/NmniCuSs5g3JRtC1HFpRyfn9ntZ3Z9Hrbzp6ZM+GEMZT4K7qn/hVoUezLJFKw9THvM+Wrfz96OTvsh4qhGzCNAG3DTOnzbdcpZNHfAXBermnmmrCn2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(31686004)(83380400001)(186003)(110136005)(54906003)(6486002)(316002)(6506007)(36756003)(8936002)(6512007)(2906002)(53546011)(26005)(86362001)(38100700002)(31696002)(2616005)(66556008)(41300700001)(66476007)(478600001)(8676002)(66946007)(4326008)(5660300002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFN5T1hCWmswWld2VUNYK3ppZWlWVjAzU0JRTXhSekZmYlJIdVlUQVNoc2Uv?=
 =?utf-8?B?dksvcVlrV2ZKYXRUUmpUNGtFYUl2VDBrVnNLeFB1b2p6THNYSnFKRnNTRTBp?=
 =?utf-8?B?dnI2WGlTZ2tzVHJiRWdLOTBvVzc3UlJRVkFsMGxMRlZZWm9mQ1JCSzZMOVA1?=
 =?utf-8?B?dmhKVWVvVFluTXNDM0hEWmxzU2FUbWV4S3dlSWJhaGZBTmpSNTRpVTJlQjY0?=
 =?utf-8?B?ZDN1akhaemZ5aDhLaGtISTBndm5OZHpobkZadmpXSmJrYjcvc0xyYksvRWE3?=
 =?utf-8?B?U3ZFSy83bUFNYURJT01haktidGptUmt4ZzlaNUQwVEFJaVZtL3Y3K0xmaG85?=
 =?utf-8?B?TEhNZndwVmgrMW1ZYjJLTzFzU3pPZDZqYW1XSTJ3RlExU3A4SytLeVVVOHlS?=
 =?utf-8?B?NGcvL0dob01Dc3hYYjBtQklHaEs3YVQxZCtKd1pqb0VlNVRSN1Vpb1ZkWFpP?=
 =?utf-8?B?cFU1VkpvMnFkWDlqNVR0eDYrYU83dzJ6N3RyRTdud2lqS0x6cmpxTEE0Qkk4?=
 =?utf-8?B?TGs1dkE1NWljdlhnb0NzWWxVdEtTVGtkUDJTS2tSZDBwcFpjZjc1eGRxdld6?=
 =?utf-8?B?TnlySThhTVM5Y1dRc2NYVXBPNlpMZERJSWNjRUpZd2taMGZFb0VleGNlMG82?=
 =?utf-8?B?Y1FMMk9GalYrbVh2RVdrTnFvb0tpdHFGcG85YzRkaE91blNIOGorODRSVVRu?=
 =?utf-8?B?blNrSy8wdlYyWVV3a3Q1eTA4RWV1dUE3MlJEeFpPSjRFbTUyK3pwSkxZKzky?=
 =?utf-8?B?NjFNOTB5RGs4dFVIWTZDVGd2OXpkdDJQdDVpWkpvNUtYVTVTcC9HSVU3eS95?=
 =?utf-8?B?THNqKzIxN3NTTXQ1TDFaZzU4aE4xRm5tWlpTR0pUR1hFTjVIWDJPc1M3RzNE?=
 =?utf-8?B?WFI1d09tVVlHQ01OaFlrdEQrNWovQ2J0NXcyRE1CT2svR2d2ejliQklVM0dJ?=
 =?utf-8?B?QzdqcXlwT2tLbjdZdzRMSEg1STVtcStjbU5QTitsY2hIT0MzMXgwRWduZUho?=
 =?utf-8?B?VzZLcVltdnA5ZEhtNnY0S2FoZ1FqYnlkUnN4NG4vSk45c2dKRUd3djI2eU5F?=
 =?utf-8?B?MFlQWmxnbHRnM3hWUnArVHRkR1A1aGdHa05BZUNQVGl4dzdiMVZ0ZHBDUnhx?=
 =?utf-8?B?K2cvY1QrZmVBRy8zWlorU3c0TXlXTGZ4c0NHK2hsSk9kQWYzTkpXdE9GejFp?=
 =?utf-8?B?UythaTVSaDRWZVhwRG10VnFtYXdTZkJ6ekJ4MFRucjZxUUs2Y3BxUUJrQi9Z?=
 =?utf-8?B?NGNQTmxGT3VUM2JmaXJ6VjQzN3NKNTgyU2IydE9qSjB5b2tHK091elJUMkJ0?=
 =?utf-8?B?SDl0UU0vUXVuNnZyMDFUY0NGM2cxS1NZbllpdWZXWENkRGFLd2hvaWY2NDlM?=
 =?utf-8?B?dVV5SnJLOTEwYWgrMW5vR1hFOWt0bzVzV1lFeE1SZWVINmxRdFAzei9Pc0Nk?=
 =?utf-8?B?Qk1RdENtMjBDQjloNHV2emVtL2tVV1lGQUcxUlI2emNoT2xSYmw1TyttQzQw?=
 =?utf-8?B?eWNhbHdGM0x5QnB3dXA2ZUdGMElPZk44aUhEMDdYdlJ2ejI3Q09jc1F4Ri9s?=
 =?utf-8?B?bzEvMjNNa3dHYjdMMk0yUW56aXBxQ1A1SDlCNEh3T0N0cHhoTmtWN0ZzNnpZ?=
 =?utf-8?B?M01kakxSK3FIYzBpTjg2Y2pQbzJPeWxnOGdoWkV1UXZxMzMyRFdOcmxRU0Z6?=
 =?utf-8?B?alFGRWZoeWJtTW8rTEV6OTFWbnYyVEVyUnZ4VVY0eUorVjBRazU2bHdGTmZC?=
 =?utf-8?B?UGF3K2hEN0RTcmMxTXBnV1VZOHpaellPVk11eVhNU2EyTlZWZDNMQzRObVhO?=
 =?utf-8?B?MjRQR1lidHNIK1daQ3J6Sndta0FCZFV6RzVtLzZRaDF4bkRIcFFYdkJuUWhN?=
 =?utf-8?B?aytleTF5b3NtMDhkMmY1c013aFFaRWxsWjFtb3BCZzdnaTliY3I3dEMxejRI?=
 =?utf-8?B?QnBaaVM2NkxVamhNNVRnaHdvc25lNEVtdktGRjNqMWxVNk8rOWZnZ2ZJUXhy?=
 =?utf-8?B?d3h6S05EU2xzYTJ5UlFtanFsNUY2SVBNUmNNRisreDlldUd1ZEk1YitXUzJT?=
 =?utf-8?B?NU5xVHV0YnF6Y25maFJ4VXY5WFU5eVdtWDNnZTdobHZpWlZNTTlpSzV5VW5K?=
 =?utf-8?B?ZjRRclBpaDZpdU9HeDgvRHpURHVheDhoWDVKM01vUnJuMEJSbHVVd3FJQkNk?=
 =?utf-8?Q?KH+OqKTVbONqXitk/Ui1/b8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b817d588-7596-4294-179f-08da8c5c6794
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 20:56:13.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE3SsbYSOSbWKiYnE2igHDQjN3U9FcSO3+Ss29fl6B9P4an1x5CER4dHIWYrcvWi7XuQTcos+MNuK+3HynUq2Md0SyZdSzaCP1CyqQgO6HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> Add GSC memory ready command.
> The command indicates to the firmware that extend operation
> memory was setup and the firmware may enter PXP mode.
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Copyright date aside, this is:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/mkhi.h | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> index 27a9b476904e..056b76e73d40 100644
> --- a/drivers/misc/mei/mkhi.h
> +++ b/drivers/misc/mei/mkhi.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2021, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -18,6 +18,13 @@
>   
>   #define MCHI_GROUP_ID  0xA
>   
> +#define MKHI_GROUP_ID_GFX              0x30
> +#define MKHI_GFX_RESET_WARN_CMD_REQ    0x0
> +#define MKHI_GFX_MEMORY_READY_CMD_REQ  0x1
> +
> +/* Allow transition to PXP mode without approval */
> +#define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1
> +
>   struct mkhi_rule_id {
>   	__le16 rule_type;
>   	u8 feature_id;
> @@ -42,4 +49,9 @@ struct mkhi_msg {
>   	u8 data[];
>   } __packed;
>   
> +struct mkhi_gfx_mem_ready {
> +	struct mkhi_msg_hdr hdr;
> +	u32    flags;
> +} __packed;
> +
>   #endif /* _MEI_MKHI_H_ */

