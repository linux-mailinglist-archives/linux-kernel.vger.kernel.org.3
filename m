Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2745952E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiHPGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiHPGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:46:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCEB2ED61
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660614431; x=1692150431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hUdJC+EawkfCQtCOQqHWcHOVjrX15fdf7ZiHCBWQ/qE=;
  b=k9th5A8WdZDEGgLAYzuhPXk4Qhu8tzEKUTDRpfhmUBCF59KDJQlhnKDy
   mxSXO06R8jRaPXwhJY9lfZOEG/W1v5Qd16uimsy8Aj7MYh0r2S6FPlJKz
   GhEVS5f2wnCEXFpKRkHtSUfMzmAZ0od46aUp+6jlG/+fPORJjKLg9PrkG
   Iuwpaxq2e9yNts2gagH6waim7UlZABCkgScHzxtu7rrWQiSU1dP4JLpsi
   CDITmCcfn7rHsae7IsxbckcdjDL7CvRtp/hBt9LUAHfBJP5DjnrvbpDCU
   7gV8IO3dqErMVKOGM8sR7wbwiskM+eMmP6UqfkbUlTN+S6558MjsZcCf0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356103462"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="356103462"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 18:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="666894000"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 18:47:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:47:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 18:47:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 18:47:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 18:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5whmedRjIiIJtUuTWaCVevM4pKdkfSc1fjazn1T5FJbjuZyt/5XkhSB7DMxMC6BA6HcPlIZKD6m3yawTNoNsBgHBlLJTWGR2IU4HH2xT/xN//NxitUzwIBHfQDp10savcnbyrlnkfQDeaCVeaHN3MUxqY1KhaMYtG++coVyYWdEhj7uMt7RIa9rF5q+NhbeKUHKrpkkb7cnamVzmhMeubCOZw7ab8HopyZ0UTctYBBZ8FqjTAxSXwIR8FnoEVSPnwyCiP5+txSD5d1mVS0swt07RDSF46P6JYoDnHf7hsiewm2XwJPA6EBeGkLNYJJ6iZGCr3EiUi7zRPPOKUQduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEnlZT2bpc7a1KCi4bgofyrD0ke23IKVzDPslUzc4ao=;
 b=ARSPC83DaET8FyodD6koHO5kpR9mwGnvMbIHU3YiVizkWERsunjSM8KE4fgzohgFoplLZVGQh71Vx2KxJkOGDiih8pxrl6RZ2dcSyTYZAr2mPLkN2Fv1a3QuKzhuRBI2IqgtUYCATvrUSBKT9dJCkBuo4QHu4+k3YwcrGTVJZxpsDFRemt6K3VXFmx1jV1KLDvT2HSTcMHukNqScsDTyZ9Im/mT+dcYLLKbd9WKJxj5cf09iUqz21knyp2Webzsr7lDNsKImaUGTJuAsRGBfVg00GrB9KCEjfZlz544SW59wmqfldNl/3jDkXPPjf7JVXiXSeveEZ0NOsteqJAtaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BYAPR11MB3800.namprd11.prod.outlook.com (2603:10b6:a03:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 01:47:06 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::5189:5e48:228f:ae9e%3]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 01:47:06 +0000
Message-ID: <b5444ddd-78b3-b420-d902-1411ed016793@intel.com>
Date:   Tue, 16 Aug 2022 09:46:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 7/8] memblock tests: add tests for memblock_*bottom_up
 functions
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>
References: <cover.1660454730.git.remckee0@gmail.com>
 <69524966ac92d93b45a8a8e739434d5fb31e3084.1660454730.git.remckee0@gmail.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <69524966ac92d93b45a8a8e739434d5fb31e3084.1660454730.git.remckee0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f72ba6-0501-45b7-2e4d-08da7f293970
X-MS-TrafficTypeDiagnostic: BYAPR11MB3800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mxs5889unMiMGpgIIV6lYtF5uArts4Nsu//c0lDwFwjHJKKO/x6kLId1u4ptQUk00nLM2P3G2UOYpqgTBybMRjU8SoHKc7mGetIwNCOyZNOLDxIgFVmDYwB4kNqZU7aFsfNVDwOLL4wsXncnM6hWkNx6pvJXzVBv2wUctY7h1I+rd2Ry86b7rgXwhloj0MhqHuh0Snn0+FUUsDVAe7GqUw0uOvFCmIlyxCMZP7Wp91aJSPkGPh8X8yU5/rzEFdGf6mT8tMhzqN8vDa2MQOmTfxvpcngpM9P4ujAXbcshBPKrA2oxpwbBwAKNY7fOSY7uc1zH8uIhPY2GXcJFzYX1hK2qfzwF1yVcwFF62DIflzIc2oLAoB6lDSR5jC+vQ/o+zhKE6Qclfizx03trn6pZLIcKC+jWuJDrp+zJlmU5uGAffeeQotnGMZWP8VQQgYYFNoo5w8xdJ0aOuSs8jIgsDdl51kqiSdMxMVghj4j/lY4x84uNwbQOYZIk/uj8Z2ysik6Jhi0ZoKS8YGIQS6e0bx37hRVq8gmIByG3Wm7buSbIp/StrnbSNfEQB6ipMbj69qweZhzMyMrvL+HTw6wUVlIkvUse3Q2xVE9StQVTRgEGhoSz1nreRx6uOvhjc9Jzn0kMgNh/X5yToljDM727V/83ec2VNEyoKxbqYx27nFF67LUr1UC8zFSMFXtY8nVHfJ1ukmr5EIpbemGXNvacO/KdxZea8ZUjidh8BPWBN1eyYlhJWxvN5ko77pgCITMBKAI7AfEYURfHQPmpXsoA7DWPkY2ooJyvInzJpfKq0/bqeMUUq03wJt6Zyh3PUuJT0YdNnUHI9UrW5z67STVTrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(136003)(366004)(110136005)(38100700002)(316002)(31686004)(478600001)(66476007)(8676002)(4326008)(66556008)(36756003)(66946007)(6486002)(86362001)(8936002)(2616005)(6512007)(6506007)(26005)(31696002)(41300700001)(5660300002)(186003)(83380400001)(2906002)(53546011)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pZeGkxOGdtWHZUSnhXR3dBTE8zaTRkQ2hLMTh0akw4WkRVa3lidFdxR28z?=
 =?utf-8?B?VU5WbnJUODFra0lzQUlIeGozQzF6RVJkRS9HOGNxV1g0MHB0VXVGekJYb3lN?=
 =?utf-8?B?SWVtM3R5VHB4VUpBbm1McEtTWHcrUTYrZTdXQUdVQVhNaHhpZEgxTzZ1YUdz?=
 =?utf-8?B?ZHFqZEpSRUcwN2RVSGZ6TDl3VFRWMmErSWIzSWtCdGdGMm9LUThpZWErdVZZ?=
 =?utf-8?B?Q1pwakdSVlZIMkg4d3JUTE1XdTc5NU1IRUdteEpURjdJR1oremh3WEh6enVC?=
 =?utf-8?B?cXgxYUI3b2pBUkQ4c1IwKzBUU3k4blg1dmRnZ3hYZ2dDV2FsOFVQb2FKSUZ1?=
 =?utf-8?B?SEJVM1Fhc09mMEJGZThuMERhdDZWZTlNN1RZQzJXbVVMdDRhQ2diazBWZXpX?=
 =?utf-8?B?YWtCTHFNdmRQa3ExQ0ZTc1lZMW5JVEVrdi81TmhsRjJLUnpxWUFQUjlTVlpK?=
 =?utf-8?B?NGYwbEtxR04wR3FrS0traU0xVExLWkViaUdSNDJFRHBqQlh2Nlo3NHFsOXhI?=
 =?utf-8?B?b1lsS2dDZTQrR2l1bXpxeFBwZEU1UXpUNHc3SE9BdVNIaVRpdWp1eXZJbXds?=
 =?utf-8?B?MGxPVG4zYy9UUHQwWlpLNWQyUXowd2d1M3Q1MkdtT3oxbEFmZnc3b0pFNnZt?=
 =?utf-8?B?NDNXdzJtL1E1UCtRRmp0aWs3TnJyTFB3RTFaSXNXbGp2VHdQZEYyMHYxZTRB?=
 =?utf-8?B?Y2p1QTdCMVNNdjRxbTdjMVgwNG13U2JvWXJodVgzV0xuR3haTTJjOUg4L3k0?=
 =?utf-8?B?RXFDOVRQR0IvN29TM3hMZnVsQUplbHJxZUlnYkRCYXREUUxNd3J0aExKL3Iv?=
 =?utf-8?B?ZThuajRRTWZiUDNOcE9WSEpONnV1M3gyQUV0clRCV1BVTHEyL0JxczlnWUxk?=
 =?utf-8?B?dVo4TmdWcGtlTUtGSFJZUXFoQ0tyR2hJdm5VeGg0cE1QNGhJN3NOK0tBaVlG?=
 =?utf-8?B?azhjQ0w4OEFIUW9VQXBmWUpxZzdIVnJmRnZJcUM2MHhEM0kyVUZlUzRCUGdh?=
 =?utf-8?B?WFRSSXE4WnNLcE1FNDlUZW1DTkRzVGtqK1ZRYTluQUhjVjRhNHFHZ3hCeDRQ?=
 =?utf-8?B?N3lPejczTnNGNjI4cTdpbVdRNGZoNzZDSlJOT3JSdndRdEd2NGZJRUdCZ3Jh?=
 =?utf-8?B?SjBUK2s1bWpKNTJhOUk4R0JqUFNNYlh1YU92NkZmYm12RTQ3SlFHTnREek1K?=
 =?utf-8?B?dW1kU2crRm1ROFI1a2c1d1daa0Y5TEYrL1AzZXpuZkl5Mi9CNVZLRXNPamt6?=
 =?utf-8?B?alo3d29pdHd5cFVzbUZYbFU5b2dXbXI1QmRYK2daanhUTTgvQ2RPeFU2emtZ?=
 =?utf-8?B?S05WMndES0lGaC8wN2VsTXBrTFdnZDZMNHRhanBGUGtqbUxQajB3ZCs5S0d4?=
 =?utf-8?B?T2FybEg4QSt6TUxLcWJLSUdzMC9mbllBNll5OG03dVJNMGhubHppSUlFSGYx?=
 =?utf-8?B?aVZuVGhnSnRXaDViV09VNUhSelZXY09Id0JPRUFaa0F5bU5vbUpZS2QxUWNH?=
 =?utf-8?B?MUhSSm81cEZqd0JjRVcvNi9aSGJaMDFtamtVbHlvdVZjaU5MQjh0eXcwNW5K?=
 =?utf-8?B?NDAvNXRNcVorM1BtY1RDRzdhUWJzaHgvKzd5MU9mZGo3RDlUcUgrUzJOTXhp?=
 =?utf-8?B?dXFUbk93TjlXNTNubXVvUjR4WVpkTjRQbkg4VzFjNE5nbHVJZDNJd1o3TVVl?=
 =?utf-8?B?TFMzRWhkVkFNREl6SEVxYk1LTzlZMDVYNVVhSWZBU3Q2bjBtNTkycjQzTlhC?=
 =?utf-8?B?TC9OK3Y1NzgwTzUwQzFwVHBQZlJtVTZsK011SUFGTE1GOGtkVi9xdWpGN0hx?=
 =?utf-8?B?dHlTSEc5Zy9YY1huSTcwRlJkTzNkd0ZCY2YxVkNZenVOc3hGcGRlZTJhUHJU?=
 =?utf-8?B?Ny9aQXdmUWhMNVVnZ2dmMUFZVGNQVXA5aXludUtGdGFRaFdqRXpDbHl1aDFj?=
 =?utf-8?B?bm5aRVhka3E0cEJ0V2hlaE9uS051N3hYd0QxN0FGTlpEcmxMQzkyNjdRdlJl?=
 =?utf-8?B?Z1g3RnFZWG55Ni9sUVpWdE5ac3VZYmdzbEwvdEZoZms1eUFyQ3VrWngxRmJy?=
 =?utf-8?B?dE03elhQaG9Da1Bza2YzSHpUWWtORkhNWk05cUFJZVhmVE90S0s5a01HWVpp?=
 =?utf-8?B?MXNVR1A2TWtwNURPZ1pZQ094OThGRUJwNVlHUzNtTWJ2dHh6WjFvbXdZSjBj?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f72ba6-0501-45b7-2e4d-08da7f293970
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 01:47:06.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN0fIa3y5Pl3QXuELyNrr36fggtQjrlOZIEekgIrYDyvOc/yLHAQ3oOy2SPlSFOu2yrezwhBrxh6ImM1HbQGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3800
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

Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>

On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> Add simple tests for memblock_set_bottom_up() and memblock_bottom_up().
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/basic_api.c | 45 ++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index ef5642d0863b..d7f008e7a12a 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -1679,6 +1679,50 @@ static int memblock_free_checks(void)
>   	return 0;
>   }
>   
> +static int memblock_set_bottom_up_check(void)
> +{
> +	prefix_push("memblock_set_bottom_up");
> +
> +	memblock_set_bottom_up(false);
> +	ASSERT_EQ(memblock.bottom_up, false);
> +	memblock_set_bottom_up(true);
> +	ASSERT_EQ(memblock.bottom_up, true);
> +
> +	reset_memblock_attributes();
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +static int memblock_bottom_up_check(void)
> +{
> +	prefix_push("memblock_bottom_up");
> +
> +	memblock_set_bottom_up(false);
> +	ASSERT_EQ(memblock_bottom_up(), memblock.bottom_up);
> +	ASSERT_EQ(memblock_bottom_up(), false);
> +	memblock_set_bottom_up(true);
> +	ASSERT_EQ(memblock_bottom_up(), memblock.bottom_up);
> +	ASSERT_EQ(memblock_bottom_up(), true);
> +
> +	reset_memblock_attributes();
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
> +static int memblock_bottom_up_checks(void)
> +{
> +	test_print("Running memblock_*bottom_up tests...\n");
> +
> +	prefix_reset();
> +	memblock_set_bottom_up_check();
> +	prefix_reset();
> +	memblock_bottom_up_check();
> +
> +	return 0;
> +}
> +
>   int memblock_basic_checks(void)
>   {
>   	memblock_initialization_check();
> @@ -1686,6 +1730,7 @@ int memblock_basic_checks(void)
>   	memblock_reserve_checks();
>   	memblock_remove_checks();
>   	memblock_free_checks();
> +	memblock_bottom_up_checks();
>   
>   	return 0;
>   }
