Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9814D3D73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiCIXOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiCIXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:13:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC6AC052;
        Wed,  9 Mar 2022 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646867578; x=1678403578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CzX5fUe04+qtC5qlUYHJQXA4ixSlBJF4w8Ltzpt2og8=;
  b=L+Ass3wMt8EAaSXPeFSUOwLNoiSPcXEJsQx79wo8l1qvmFASQKBbwLbr
   ETegseoGMrnDlWoNLsxuiPpQPHsZv6Yg19M7MY8P0WaO/Q6piaQgQTqbe
   OL5U+U/DKwBsOyXg9c9Kd6I0lD4tspoXHuojGFjGw+fP0W2FEEuWPbF24
   2kl8zOlWwZUPlqyltviL72mWGLKv39bPOALLCZjS8gvMe1wrafNklb8XB
   UIl3uSeAMaREkSlksWtyGAm30bpL/ZJC2SGY3Wew/HIpzi0qGYSGgNGJn
   rX3a4ax2G1fdNvxbJJkcITIpCu7nlaWzEUhxVEfKvO0dEKvVfZ6Ksw1vx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255056297"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255056297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="578570465"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 15:12:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 15:12:57 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 15:12:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 15:12:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 15:12:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNnXS+eLvk6VM+9zYu59dcbjn3TB+XLGd0Al9rcqi5xVov12skSZQO6Y+GBRQ3slMwEfk+7+GAQWemtDkQHPgrui0hii37w1JBkpWfOfIx5LcAYrsmCwPZaA7q/DdQk+wqRFodzDMbOrkmcAsSRqTWB7FnvKRtSGCEtudzkwSQGr5bhMRfHoTNqny0UPaH4kvEzRKr7VwqAwfS1YkbiPmk0tsb/37qLUWGtuOaEckK3kb4rcYM8LVbm5Uh0HPBc7izPfedH/5Y0R9t4uh2qvPKfzbTXbL0sV4LezEbuqTGKFF3yGwiWSmUL9phbOhYR+32QIuo6jqQmIjD4NfLYHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mi68G+cNmKqwgq8rsmxkWbSaXdKMHh1ZdNAcn0q1Uc=;
 b=TCqb6XkdXnVxQ5P/eWVqU/kBB9HKs1sHn9mz5YFp5IBWHmjpUdwhCW/mn/caOFbI98bbWMGq7Di6KMo2X8IR8SjhwROVU2nq2VlgIYRAY/MaXi+PfnfJ6CrJjrWnfoJUg8ebGSvc7f0vklDR9WNYhgXi1tY2nOI/DN5CgGJBJYYxp0xqpLLIfvmS9OR31eTyNLL3YS+h94Aq432HlpU7tauZGhtm6f2EUG9FMQ3MDxBOPoEi7yt14PGrEwaevzbT36h2L1onf48fxURSGgLMQTKs345hR3HDfUv2leqf5cUhJ3D05MKMY1DE3YHaUcN+KlGaaQhzhVU+6KwtXDgsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CH2PR11MB4296.namprd11.prod.outlook.com (2603:10b6:610:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 23:12:54 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 23:12:54 +0000
Message-ID: <c6a9632e-cdcb-cf05-183e-a124e9cec0e2@intel.com>
Date:   Wed, 9 Mar 2022 15:12:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] x86/fpu: Add a helper to prepare AMX state for
 low-power CPU idle
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <ravi.v.shankar@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-2-chang.seok.bae@intel.com>
 <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <bde83c5f-ffe9-d548-de08-de3e14738bf0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:e::18) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9e6a6a-3337-439e-4e2b-08da02225741
X-MS-TrafficTypeDiagnostic: CH2PR11MB4296:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR11MB42961514513197AF85E23E86D80A9@CH2PR11MB4296.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezF14f2lWYfagAar8mNUpKfUjfxgEGbnDco+Nf6TwncvtNZoflITDvopZ/V5n6Olwzma6181VWEqQ2a3C0FoEEzoznAJUEEVNZKn5TXVG5siQka+UQOmYvVMWAEtSj6zsx97DLNg+mv0Px4vz6/JWLn+EYDoXIzRNf10nF9yvOZzptC+4odY+VeewbhYvYOHvsE87oArqOPAnGgRxWE0LwGKM7FNZKNa7PrOZLGqHRiCpdY1B2kBnmcAxzzqlMvpxHApJi6Xa0KCsnji8TOPcHqI8KExN23yx9M6XPXrP14BO1JExjxMXyESln9dv8PryXs5l9AL8yCxzlCybks5FIIehHJeQtQWMbH0YPXfVgIp77H57naJ7VwOwJo8v+Dmb3oFdQ+5GDUmbHN9MgNR7phaCkeQFJ9f/tUAVAbDZqb1UURrxK/gdkOZ9dC4EzpoSQcY+bCHenCh37TYgboWLPFNr2/q6e/CH6QgCj5x4poNb/qaFID0MbikXZKo7s5ffQQlaoLrb3N3EyfH2zKm7MTH3e+MOf3ePQtxFJGYQnSzdH2ychVVQcWsvWKVwGLeYD/qsHhVvWy7/pHEiqzuDbZVC9Ioom4JesQUuxtZGEuoxU31qUAWLUh5CRGCy5dAtI1w3L3a4Dbx0c35KbrpkEu36ogmZ52FVV1+Gty0N6YHh/qdkmfCs3Gbua52OpkzMqog632h+m87idzte4Z8hgpnsEzVSfuC7q/aM0qN4QDhEswNi5d6TZB6prZJJEahot31x0n2+YQsYxes7cWpOnEXsCy3QfRqo/9c9q8NuaICVit2sXzujWjcyH4vUlja0ILa+jIiG20cRcZ14WMiq3D562o+TCrF/qYudh3qkYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(5660300002)(26005)(30864003)(6512007)(6666004)(6486002)(6506007)(31686004)(316002)(53546011)(83380400001)(4326008)(31696002)(8676002)(86362001)(508600001)(8936002)(66946007)(66476007)(66556008)(45080400002)(82960400001)(2906002)(2616005)(966005)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklhWGJTTUZrTEwvT2JOOG5Ba0lSWEFqdVVvVVlRL0tCN1M0cy9Pa1h4OCtB?=
 =?utf-8?B?NG8wMGVOZWJtS3FvektUTEdOM1RQbWhPSzAwRzFQRXNSNDdKNDJ4ZHdCd2h3?=
 =?utf-8?B?VU1nUW1ycGhFNTA4SzQ4V3JzV3d5NVJJTDF0cUpSdUFzc1dQNHRjQ3VJR3hj?=
 =?utf-8?B?RXp1OUx2aDBKMDIrZzNTaUFSU3N0anVFSVRTZmdUSU44enY3Wk1ZMDB2VUFs?=
 =?utf-8?B?UmtLemxjQzh1eFNLQnpMQzZrQ1J2SW9ORmpsVElBNjNuRGJrNllLL0xuSTRW?=
 =?utf-8?B?R0loYktuVEhUZzgwWFEwZDNYSitFQk1nL3hsTEpCKzhnejN6UUpRS1RTbFFl?=
 =?utf-8?B?K2xOUEFRMVg5UHZWZDhOeWE4VGllam03TlE3N3ZjOGFlZTZsMW1paGlnWDFR?=
 =?utf-8?B?Vm41RHY1TEI3WFhVTVJzZGNKMi9hdWxYVTRQVTIrUDVXd3psUUdVS2ppZndG?=
 =?utf-8?B?U1k0WDJnVWhZd3Foa1BmR2ZHSUxmdHBqUXRIQ0ZPOGNvNlp1RHlqMW16MHht?=
 =?utf-8?B?T0Njakl0VlR1cGdBOGIwcXBUaGpRbUpmc1FUQk9LeGJuM3kyeHVIRUhRamJH?=
 =?utf-8?B?cHViUGQzL3JvUWRGWVRCb1haR3k3WS9NUGUzUzRvTGVxV3FhaU9xajV6QTE5?=
 =?utf-8?B?bHR3d2UzQXY0UE52a21oYm4zZXV0N2MvbFQ3T3FadEFtci9yYjFXM0xhbUNS?=
 =?utf-8?B?OGFJdUpEWGxYN2hVdldFbzhwRVdYTmRqREo5NWJyNy9OOTAzWURqaHFtUXVL?=
 =?utf-8?B?bGg2Ky8rY0RveTMrRjdOc0h0YlIxOWdCZkJuUEpNRnF4N05yek9keUU2N25x?=
 =?utf-8?B?a0VDREdrVGZWWWhLSDdjZFVCV3BFV3VrQmtEOFczTWlCcGsrcGY3M1ZUb3FV?=
 =?utf-8?B?djgzN091NE1PcXcxSSs1dHd1dFBLQzlSUG81MlFUaDE1WGF1ZG95ZlA5eEU2?=
 =?utf-8?B?cjBnaWU4dEEzYURPQlRyaGxtdkkrSFp2YTE2NjEzNGRaWU1sQm10TERDaXRE?=
 =?utf-8?B?c1ZEZkJDU1VXNnhmc3NTaDdiVStMNFJLcjFUbURXYUI1aXlib01ia1ZZYlJ2?=
 =?utf-8?B?UisrRitsKy95NnJMZ1d2eExNS005R21RdDV1Q21sd2RPMjBQU0wyK2JSRG0w?=
 =?utf-8?B?TjhEeHhpU1VuSHVJdzllRklNRCtCZmJLV2lsak1YdGJjSXJqQ1d6Nkg2WUxy?=
 =?utf-8?B?cSttNWdseXUrSzZGSEZxNy8xSXJqVzlILzhQMkpucFUwMW5kdVhvbHNSMEli?=
 =?utf-8?B?L0hWMCtQZ0RIbVYyVnl5ckZMcFF2U05XbFBueFdkQmY0L3V1K2Fsa2t5T25T?=
 =?utf-8?B?c044TDVvVW42T3RxREpFZXRMV1FzZTNLRTlBblV3TXZrazR1bWtrMmF6eFRl?=
 =?utf-8?B?c25BT3dlRlMxdE9HUFJMZURWZnhpVktjL25LZ2hueUdMNHlma2c2VHAxZmJa?=
 =?utf-8?B?YUpwQmFFUE4yUmJpQkQzekZzdGFFdS9ubmRvZE1UbnhtbjZqWktHUFRiZlVu?=
 =?utf-8?B?QmY0QmpwcjZwdllQNG0vS0duNW80S3Eyb3MxaTFRbWVxbDFKUlh4aEw5ZGR0?=
 =?utf-8?B?d0lTcnYrRGVDa282WUhuN045Z0VqdXNtRFBNOWljdmZzbDNuSnNieElTNjBp?=
 =?utf-8?B?VjI1QklGSWMyQy9zaVhPai9hZWlnUFB2QTdPczZjVTVsYVBjZUpjbnpsdjNa?=
 =?utf-8?B?SFFWdGV1U3c2SGJPQXg3MWVFSkZKMkRvelZyTUMxMzRyOFM5MUxyWFVISmlB?=
 =?utf-8?B?R0hGS1czSmRlbjVXblNpR3BBWFZNRHF3Y1ZzeU5MMk5XY2tOU2dPdjdKa3Fw?=
 =?utf-8?B?UDRXWlZydDB5L1h6Z1lwTWlUQWNvZUo2RVZIaGRqUlU3dTl6NGhlL0N4Rk51?=
 =?utf-8?B?QU1PQ0g2dC96emRtRWU1K21MR1FBbUxBdjczQnJGazZ5ZERlanBtenNvUkNO?=
 =?utf-8?B?TGFQQ2ppQTBKcFpNUzg2WjF3ZVpZNGo3aXBtTHBDTk5RZXQwK0hsNWh6VUZt?=
 =?utf-8?B?ejNpMGcvK3FSeDJ6RE02T0VTU093SjA1elJvdlRUUjRVaXQzM0gwOTNNZ2dN?=
 =?utf-8?B?alR3VDVDcnhZT0V6U05pbDR3VzkwRmdKYTZ4MC9BczhNY2g2a3dIRlJkWS9Z?=
 =?utf-8?B?QXZRMXl3bTFSVzR4aXZFTkp5dVc5cjFuOXdZaWNzSjlzNlFzSjJNWk5yV2Rz?=
 =?utf-8?B?bTYzWWZkTlllOXhPNVFMbmlqb09yRUpSQ29iTXdCMmJMNUhVeDBzaVFBMmp4?=
 =?utf-8?Q?0Kc2+rB/ozKPtyL1XwGIZD2R3WPy8ANFDbd2JjE1ao=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9e6a6a-3337-439e-4e2b-08da02225741
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 23:12:54.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9/c77W4OJKGQ10EFFVcw5FJMzlOWbiDqR5e3HrC62Ss/aCyqjtJWzkMgjQ4vGhDgCXEXj3mNStmv+tgEtHg0EXCrsM3TCM+xr7cfsdimws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/2022 2:46 PM, Dave Hansen wrote:
> On 3/9/22 14:34, Chang S. Bae wrote:
>> +/*
>> + * Initialize register state that may prevent from entering low-power idle.
>> + * This function will be invoked from the cpuidle driver only when needed.
>> + */
>> +void fpu_idle_fpregs(void)
>> +{
>> +	if (!fpu_state_size_dynamic())
>> +		return;
> 
> Is this check just an optimization?  

No. 0day reported the splat [3] with the earlier code in v1 [1]:

if (fpu_state_size_dynamic() && (xfeatures_in_use() & 
XFEATURE_MASK_XTILE)) { ... }

It looks like GCC-9 reordered to hit XGETBV without checking 
fpu_state_size_dynamic(). So this line was separated to avoid that.

> I'm having trouble imagining a situation where we would have:
> 
> 	(xfeatures_in_use() & XFEATURE_MASK_XTILE) == true
> but
> 	fpu_state_size_dynamic() == false

Yes, I don't think we have such situation in practice.

> 
>> +	if (xfeatures_in_use() & XFEATURE_MASK_XTILE) {
>> +		tile_release();
>> +		fpregs_deactivate(&current->thread.fpu);
>> +	}
>> +}
> 
> xfeatures_in_use() isn't exactly expensive either.

True.

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/20211104225226.5031-3-chang.seok.bae@intel.com/

[2] 
https://lore.kernel.org/lkml/20211104225226.5031-4-chang.seok.bae@intel.com/

[3] 0-day report:

FYI, we noticed the following commit (built with gcc-9):

commit: 66951fd5ad7a2aabae7dc54be46a4eac667a082c ("x86/fpu: Prepare AMX 
state for CPU idle") internal-devel devel-hourly-20220113-144327

[chang: this refers to [2]. ]
...

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 
-m 16G

caused below changes (please refer to attached dmesg/kmsg for entire 
log/backtrace):

[    1.767825][    T1] x86: Booting SMP configuration:
[    1.768363][    T1] .... node  #0, CPUs:      #1
[    0.113687][    T0] kvm-clock: cpu 1, msr 38a24a041, secondary cpu clock
[    0.113687][    T0] masked ExtINT on CPU#1
[    0.113687][    T0] smpboot: CPU 1 Converting physical 0 to logical die 1
[    1.780411][    T0] general protection fault, maybe for address 0x1: 
0000 [#1] SMP KASAN PTI
[    1.781350][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
5.16.0-00004-g66951fd5ad7a #1
[    1.781350][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.12.0-1 04/01/2014
[ 1.781350][ T0] RIP: 0010:fpu_idle_fpregs 
(kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:12 
kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:32 
kbuild/src/consumer/arch/x86/kernel/fpu/core.c:772)
[ 1.781350][ T0] Code: 89 74 24 04 e8 d4 6e 82 00 8b 74 24 04 e9 f8 fe 
ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 eb 01 c3 b9 01 00 
00 00 <0f> 01 d0 a9 00 00 06 00 75 01 c3 55 53 c4 e2 78 49 c0 65 48 8b 
2c All code ========
    0:   89 74 24 04              mov    %esi,0x4(%rsp)
    4:   e8 d4 6e 82 00           callq  0x826edd
    9:   8b 74 24 04              mov    0x4(%rsp),%esi
    d:   e9 f8 fe ff ff           jmpq   0xffffffffffffff0a
   12:   66 66 2e 0f 1f 84 00     data16 nopw %cs:0x0(%rax,%rax,1)
   19:   00 00 00 00
   1d:   0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
   22:   eb 01                    jmp    0x25
   24:   c3                       retq
   25:   b9 01 00 00 00           mov    $0x1,%ecx
   2a:*  0f 01 d0                 xgetbv           <-- trapping instruction
   2d:   a9 00 00 06 00           test   $0x60000,%eax
   32:   75 01                    jne    0x35
   34:   c3                       retq
   35:   55                       push   %rbp
   36:   53                       push   %rbx
   37:   c4 e2 78 49              (bad)
   3b:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   3f:   2c                       .byte 0x2c

Code starting with the faulting instruction 
===========================================
    0:   0f 01 d0                 xgetbv
    3:   a9 00 00 06 00           test   $0x60000,%eax
    8:   75 01                    jne    0xb
    a:   c3                       retq
    b:   55                       push   %rbp
    c:   53                       push   %rbx
    d:   c4 e2 78 49              (bad)
   11:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   15:   2c                       .byte 0x2c
[    1.781350][    T0] RSP: 0000:ffffffff96007e50 EFLAGS: 00010047
[    1.781350][    T0] RAX: 0000000000000001 RBX: ffffffff96022280 RCX: 
0000000000000001
[    1.781350][    T0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 
ffffffff96db7da0
[    1.781350][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: 
fffffbfff2db6fb5
[    1.781350][    T0] R10: ffffffff96db7da7 R11: fffffbfff2db6fb4 R12: 
fffffbfff2c04450
[    1.781350][    T0] R13: ffffffff96db7da0 R14: dffffc0000000000 R15: 
0000000000000000
[    1.781350][    T0] FS:  0000000000000000(0000) 
GS:ffff88839d600000(0000) knlGS:0000000000000000
[    1.781350][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.781350][    T0] CR2: ffff88843ffff000 CR3: 0000000388a14000 CR4: 
00000000000406f0
[    1.781350][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.781350][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.781350][    T0] Call Trace:
[    1.781350][    T0]  <TASK>
[ 1.781350][ T0] ? arch_cpu_idle_enter 
(kbuild/src/consumer/arch/x86/kernel/process.c:712)
[ 1.781350][ T0] ? do_idle (kbuild/src/consumer/kernel/sched/idle.c:294)
[ 1.781350][ T0] ? _raw_read_unlock_irqrestore 
(kbuild/src/consumer/kernel/locking/spinlock.c:161)
[ 1.781350][ T0] ? arch_cpu_idle_exit+0xc0/0xc0 [ 1.781350][ T0] ? 
schedule (kbuild/src/consumer/arch/x86/include/asm/bitops.h:207 
(discriminator 1) 
kbuild/src/consumer/include/asm-generic/bitops/instrumented-non-atomic.h:135 
(discriminator 1) kbuild/src/consumer/include/linux/thread_info.h:118 
(discriminator 1) kbuild/src/consumer/include/linux/sched.h:2120 
(discriminator 1) kbuild/src/consumer/kernel/sched/core.c:6328 
(discriminator 1)) [ 1.781350][ T0] ? cpu_startup_entry 
(kbuild/src/consumer/kernel/sched/idle.c:402 (discriminator 1)) [ 
1.781350][ T0] ? start_kernel (kbuild/src/consumer/init/main.c:1137)
[ 1.781350][ T0] ? secondary_startup_64_no_verify 
(kbuild/src/consumer/arch/x86/kernel/head_64.S:283)
[    1.781350][    T0]  </TASK>
[    1.781350][    T0] Modules linked in:
[    1.781350][    T0] ---[ end trace 2bef003d678c9f1a ]---
[    1.781350][    T0] general protection fault, maybe for address 0x1: 
0000 [#2] SMP KASAN PTI
[    1.781350][    T0] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D 
          5.16.0-00004-g66951fd5ad7a #1
[ 1.781350][ T0] RIP: 0010:fpu_idle_fpregs 
(kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:12 
kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:32 
kbuild/src/consumer/arch/x86/kernel/fpu/core.c:772)
[    1.781350][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.12.0-1 04/01/2014
[ 1.781350][ T0] Code: 89 74 24 04 e8 d4 6e 82 00 8b 74 24 04 e9 f8 fe 
ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 eb 01 c3 b9 01 00 
00 00 <0f> 01 d0 a9 00 00 06 00 75 01 c3 55 53 c4 e2 78 49 c0 65 48 8b 
2c All code ========
    0:   89 74 24 04              mov    %esi,0x4(%rsp)
    4:   e8 d4 6e 82 00           callq  0x826edd
    9:   8b 74 24 04              mov    0x4(%rsp),%esi
    d:   e9 f8 fe ff ff           jmpq   0xffffffffffffff0a
   12:   66 66 2e 0f 1f 84 00     data16 nopw %cs:0x0(%rax,%rax,1)
   19:   00 00 00 00
   1d:   0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
   22:   eb 01                    jmp    0x25
   24:   c3                       retq
   25:   b9 01 00 00 00           mov    $0x1,%ecx
   2a:*  0f 01 d0                 xgetbv           <-- trapping instruction
   2d:   a9 00 00 06 00           test   $0x60000,%eax
   32:   75 01                    jne    0x35
   34:   c3                       retq
   35:   55                       push   %rbp
   36:   53                       push   %rbx
   37:   c4 e2 78 49              (bad)
   3b:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   3f:   2c                       .byte 0x2c

Code starting with the faulting instruction 
===========================================
    0:   0f 01 d0                 xgetbv
    3:   a9 00 00 06 00           test   $0x60000,%eax
    8:   75 01                    jne    0xb
    a:   c3                       retq
    b:   55                       push   %rbp
    c:   53                       push   %rbx
    d:   c4 e2 78 49              (bad)
   11:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   15:   2c                       .byte 0x2c
[ 1.781350][ T0] RIP: 0010:fpu_idle_fpregs 
(kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:12 
kbuild/src/consumer/arch/x86/include/asm/fpu/xcr.h:32 
kbuild/src/consumer/arch/x86/kernel/fpu/core.c:772)
[    1.781350][    T0] RSP: 0000:ffffffff96007e50 EFLAGS: 00010047
[ 1.781350][ T0] Code: 89 74 24 04 e8 d4 6e 82 00 8b 74 24 04 e9 f8 fe 
ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 eb 01 c3 b9 01 00 
00 00 <0f> 01 d0 a9 00 00 06 00 75 01 c3 55 53 c4 e2 78 49 c0 65 48 8b 
2c All code ========
    0:   89 74 24 04              mov    %esi,0x4(%rsp)
    4:   e8 d4 6e 82 00           callq  0x826edd
    9:   8b 74 24 04              mov    0x4(%rsp),%esi
    d:   e9 f8 fe ff ff           jmpq   0xffffffffffffff0a
   12:   66 66 2e 0f 1f 84 00     data16 nopw %cs:0x0(%rax,%rax,1)
   19:   00 00 00 00
   1d:   0f 1f 44 00 00           nopl   0x0(%rax,%rax,1)
   22:   eb 01                    jmp    0x25
   24:   c3                       retq
   25:   b9 01 00 00 00           mov    $0x1,%ecx
   2a:*  0f 01 d0                 xgetbv           <-- trapping instruction
   2d:   a9 00 00 06 00           test   $0x60000,%eax
   32:   75 01                    jne    0x35
   34:   c3                       retq
   35:   55                       push   %rbp
   36:   53                       push   %rbx
   37:   c4 e2 78 49              (bad)
   3b:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   3f:   2c                       .byte 0x2c

Code starting with the faulting instruction 
===========================================
    0:   0f 01 d0                 xgetbv
    3:   a9 00 00 06 00           test   $0x60000,%eax
    8:   75 01                    jne    0xb
    a:   c3                       retq
    b:   55                       push   %rbp
    c:   53                       push   %rbx
    d:   c4 e2 78 49              (bad)
   11:   c0 65 48 8b              shlb   $0x8b,0x48(%rbp)
   15:   2c                       .byte 0x2c
[    1.781350][    T0]
[    1.781350][    T0] RSP: 0000:ffffc9000010fdf8 EFLAGS: 00010047
[    1.781350][    T0] RAX: 0000000000000001 RBX: ffffffff96022280 RCX: 
0000000000000001
[    1.781350][    T0]
[    1.781350][    T0] RAX: 0000000000000001 RBX: ffff8881003e0000 RCX: 
0000000000000001
[    1.781350][    T0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 
ffffffff96db7da0
[    1.781350][    T0] RBP: 0000000000000000 R08: 0000000000000001 R09: 
fffffbfff2db6fb5
[    1.781350][    T0] RBP: 0000000000000001 R08: 0000000000000001 R09: 
fffffbfff2db6fb5
[    1.781350][    T0] R10: ffffffff96db7da7 R11: fffffbfff2db6fb4 R12: 
fffffbfff2c04450
[    1.781350][    T0] R10: ffffffff96db7da7 R11: fffffbfff2db6fb4 R12: 
ffffed102007c000
[    1.781350][    T0] R13: ffffffff96db7da0 R14: dffffc0000000000 R15: 
0000000000000000
[    1.781350][    T0] FS:  0000000000000000(0000) 
GS:ffff88839d600000(0000) knlGS:0000000000000000
[    1.781350][    T0] FS:  0000000000000000(0000) 
GS:ffff88839d700000(0000) knlGS:0000000000000000
[    1.781350][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.781350][    T0] CR2: ffff88843ffff000 CR3: 0000000388a14000 CR4: 
00000000000406f0
[    1.781350][    T0] CR2: 0000000000000000 CR3: 0000000388a14000 CR4: 
00000000000406e0
[    1.781350][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    1.781350][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[    1.781350][    T0] Kernel panic - not syncing: Fatal exception
[    1.781350][    T0] Call Trace:
[    1.781350][    T0]  <TASK>
[ 1.781350][ T0] ? arch_cpu_idle_enter 
(kbuild/src/consumer/arch/x86/kernel/process.c:712)
[ 1.781350][ T0] ? do_idle (kbuild/src/consumer/kernel/sched/idle.c:294)
[ 1.781350][ T0] ? _raw_spin_lock_irqsave 
(kbuild/src/consumer/arch/x86/include/asm/atomic.h:202 
kbuild/src/consumer/include/linux/atomic/atomic-instrumented.h:513 
kbuild/src/consumer/include/asm-generic/qspinlock.h:82 
kbuild/src/consumer/include/linux/spinlock.h:185 
kbuild/src/consumer/include/linux/spinlock_api_smp.h:111 
kbuild/src/consumer/kernel/locking/spinlock.c:162)
[ 1.781350][ T0] ? arch_cpu_idle_exit+0xc0/0xc0

