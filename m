Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAF4F46DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbiDEUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1458105AbiDERIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:08:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1EAF47D8;
        Tue,  5 Apr 2022 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649178412; x=1680714412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oWsS1ImesnvvbOpcFJIbCqb8f9BlqEbXj+S+u/fKh74=;
  b=ki0UF+DT+P0OWjhTgnU5XkFP8Qlucn/lXARaJxRpHhN4k1chPNtjnJp6
   YCqxkqV3P8ecq6cXXdKiqFGbAKdg7LGfIymwFzi27jp+pEE6fEHaGVbOg
   RiX8oONiO7ja3zHwI7VRtlou548bOmicI1Ob44wSml7OX392GDI7GROGh
   A0bkndcoCPC1T4qZbVNxkgcIbuc7r3hpb5jzedMTGADpd/npS/C3w7H/w
   Pp6kKdGn0t5OpH49SdlnJTlF+31lR9zQNHRaQ3WNPU20KSvHemHniX3C8
   r8aKv35r4kH4cMQ45seZOV0ZS0AjBtaUx84QItvgwjZAo3BJaJdwZcEKc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241392661"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="241392661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="524075771"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 10:06:07 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:06:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 10:06:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 10:06:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdJcRyp39b/Cx/NqigZcWO/HqzVcyYXDGvne11ITdOcWjwIrj52qr36VQ7ZtvpCIA1Wge5XPRrRIukac4sK9jnxUytweMO85yqgkLX4Pe5XohdH1JUu+YxfrkApfO96fQrPjgOFu0KXhmlfAgi8JDNWVQw2HBNg4yGgsnniAycvzQ0zppZ7s7CvP4XOdrxOvWiTThXSIS4F2tRkfL6QTqd3twR5XjdZ8U1tRGJ5y6+d46yCVAdF7ztZddQ2N/cLcXCH+iWJzg/TMSNvvM+c4ZErPQbL+2JP3+CiFPfKxoeuoDKknDpkyMO3nH8Ldx87dsznK2Gb5jKpLMpbgSCjNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GcbS2zvd2VXVjf8PF7d3ZSVEF7ZaolnJpoalB07Rqw=;
 b=MemqHlty2Dot2dpHvPiq53ci1Ux8xNN/LuBe+DfJdLzUW0cq5hveNZuuAcoNcWQEa9QVQWIfGhkdgZtc09mmjdEO5snj2MliiIq9NW20TqtGwIEueYip36l3x/6amZlkBOblhSF1tbX5j8kWGMcf38O6gjDM4TFpMle1eK3OG9aHG5CXJJ28PtOpzt4Z0OC1YKhgWJBQnkD/yqBJxCsA+Bb61V9VQEVNmIPxK4vMJE7Ay3iM7KhS1Hp//zeTL/AT8INn3xXUOh3ANith0MKKwoBBcboBw88fTIJS4j8ySppoBuA49p170fS/LM+cIecsWugnMs7jpeDfJoOmoUtsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:06:04 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:06:04 +0000
Message-ID: <d8cc2142-c50d-fbd9-425f-01e279c9a0f1@intel.com>
Date:   Tue, 5 Apr 2022 10:05:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 17/30] x86/sgx: Support modifying SGX page type
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <bac6e77fe04100d6bfebd4e13aa9b916f82bfea6.1648847675.git.reinette.chatre@intel.com>
 <Ykvqf3Ws6jlN5g+p@kernel.org>
 <b41d81ebcb6934765d7f37d4ce95baa16ec9b5d2.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b41d81ebcb6934765d7f37d4ce95baa16ec9b5d2.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca0418f-1052-49e5-52de-08da17269110
X-MS-TrafficTypeDiagnostic: BL0PR11MB2946:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB29463F53B24FFC98FB3A3A1DF8E49@BL0PR11MB2946.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GdFeTVA+WzIwexPqC2GSkcdJ8eu0gdNxZLVt7+PkUoFvUzTpcR+FXqHEVKfanqr6PNQOv0dsWlW2D0V7P40jRoIBNdXN/0nuEV5aWKnp0Bz/ZJjUDek6FoktT1eIFOVy5EATsxXuBi2JNDi09t5imyuzsVvP2S7FhMnN+la5nudW0xqFs5bI7i17hY9/CVX0O79DY4jdXYCnAe5iOmF0saaAOnroW7VMtc+tAtKqzdtiJe7MKOs9c4RGx3OBJbUBymFVf9oOuw0Y0ySKyek4Gktd3SrQOl0V+0+N2PhadbxmESCtCpluzKkdjLXIugnft9NNbqS+ft/PSSRoJ+2GVnSfBZnbZLEPL4utrtyx+6EUbCeW6J+JriDNZutSFC9L3Vy/3/BJCpyMEmXZr/qYJ1BvN78ed/irsX7JdWgbpBj5VDflNFgB5DtmDafzWVyPcrYUWzqTlKWp/9eE3LlFLfU0b+HmbnhtTjApveh3AAwI42x8WEOBePk0rLGQE4rC+Io7iv9KWURx9zg/UQx+APKD/bOGcLoi2wZ+6zsnka7NkyDVcNFBWMAZMRPzZWwVzy9HKEiz+AA/P7i/6IJZuGV7lcHVnH/tLBYWQGNKN5tH30hqF9HdCr1h5yauENKtancF/TR/99IuWLV6a60gCRt7jcs5snRqAhH5KSZ9cLFf6m7DIZZ4VIUrKnTcwtV82a8qbcdBZXP506tkPCIOPOk21IbatdmvMO4snsdaeAvz9EAB89nweSXOP64OpaOCFSBrMm1JPgTI2VQjQCxYyKF/xVh/8osb0K7H+MmvXzuaOXwQ5K5FGoBI7ONJpZgB/A13a37TtMORYzCgLI//w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(8676002)(4326008)(66476007)(66946007)(83380400001)(26005)(6666004)(186003)(6506007)(6512007)(86362001)(53546011)(66556008)(2616005)(6486002)(2906002)(38100700002)(5660300002)(966005)(31686004)(4744005)(7416002)(8936002)(508600001)(44832011)(36756003)(82960400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGU5NG10NjRDeG5jUVhGODRRTHRuS2NpNDArQ0J1Z0QvUlk2emxNa2VDVjhN?=
 =?utf-8?B?akc2OWJTY1Y3YlJVcS9wbDV5c1I2YUhQZXY2SnY1YVRRZkJXdXZKU21zNUxl?=
 =?utf-8?B?dHlTcEh0TFMyTUs5cXh4cm15NnpMMWgyM2VEMWFDdEs5cXkwMEUxRnNleEZZ?=
 =?utf-8?B?S2wxM3R0MnZzbm9CZmJyZGV6V2lnbXpHZzE2bXNHU00zZHp0QjJLc3hJM2hY?=
 =?utf-8?B?czhnN1g0RjBpeEU2YU9EOWFvV1loMGVVNmhSaWFyMXNkd2lvajFaaTBXcTRy?=
 =?utf-8?B?WEEwL1FwSWNmZ2ZQOHo0RHQ2ZnIvRmcveDFwcDNYSzNZSXJtSmR2eFdONG1m?=
 =?utf-8?B?bGViWG93N3JYcmdxWm9BN3V5V1M2cmFIcFhOLytWZE5KU3FhV3dGUXRySHRr?=
 =?utf-8?B?dThLVFhsY2lRQytZUTJKOTc1YXhNdFVUMnRaem5HY2twNjFtWlRSbXRNbDRk?=
 =?utf-8?B?L0I1aFNJNWk3UDArNkxYbkNqOXhFYVBBdDNlMGFIU1JyTmF3VXoyY3BsY1lI?=
 =?utf-8?B?UUxGZmgvSW5GZzFpbThETnVxa0ZYcEY3SExTTDZITExCcGhpRWlkMmtEMHR4?=
 =?utf-8?B?S0V5eW1ZQlQyTGYyMGgwQlF3YUZ6aWd2d0VlZnVHNGpTUDdUaGdkSFVuYll2?=
 =?utf-8?B?NmdtM3NuaVBWVmYxQStDT0REVEJuYktmQ2JuM0pYYUdTQ1RPSlR4a1djTGxR?=
 =?utf-8?B?NkFoclpjUndSaWROYXl3VElzUWZCRDZpRFNYYWZrZW5NdURncXkxZTd0UUQr?=
 =?utf-8?B?RkVNV0cydFpkOUJnalQ5dHgreDA3RzZnVHY5MjRrRjV3YWJLVENpTEJMeWRk?=
 =?utf-8?B?NjgyWld3VUFpc1VwdGxLZnB2ZlpaM2ZsalJ4VVhNUkxJUVV1TnB4QU5xOVNk?=
 =?utf-8?B?VFhYK0V3WEpMSE5WdDhpaVd1NUp4TzJ4VHRncnFnVE40VzAyYWtMOUIzekhW?=
 =?utf-8?B?dE5iYmRwTWNXRFZuNW05TFJoVVNLTi9qWkpxUDVKQVlVaDdBN0tXb1VrbnM3?=
 =?utf-8?B?N1ZXZWU2ZGVYdFVveThkN3JDNFhyZXVXdkk2SzRBOCtZL1luYk1rMWhWa3la?=
 =?utf-8?B?dHd1R3ZVZzcwTiswU2JDZXpiT3FKZTk2Wi9pMUVJYWh6bGlKUGplMDhHVno5?=
 =?utf-8?B?WTZUSDVEYllOZ0RNejZkdXp1amlUUklOUlo4Z1VvTVc2d1ZkUGhNUHp0S0FW?=
 =?utf-8?B?K3RKWSs5b3NJcEgwT2dFRG9neDhWZzlxN2Y5bXNIbTkvUjRXWWp3QkVVTkov?=
 =?utf-8?B?cjBYcGgxMkFVdEV1WW9PaVd6YmhhbE9oTDEvZk9pd0VzZzlOVWpCb0xOS2xv?=
 =?utf-8?B?Ujl4eVpvNm1mZVl5NGxZVWhnS29DcDNpV0RRcXNoUXR5VmUxUkM1OStlNUdk?=
 =?utf-8?B?TVZtNTlrbEpLazQ4NStBYmhXWUlLWis4UUpaMFlNOEx2ejRkdGhvMDZwWS92?=
 =?utf-8?B?aWtmY1hrSnlHZnRQSzJPSWdHM2VVbENwYzl5dkZIMTRTUkNQS2NRUlk5VkRN?=
 =?utf-8?B?NzJGMmVNaCtkSXJUY3ZQOU9HU2ZLOXUrRVEraGlHdDVHWFJidnh3SU1kbXhx?=
 =?utf-8?B?a2N3WUZyamdoZHlBUld5VWFMYWNTRFY1ZlBGMlV0THd5UTFVVkdSMDlINUpC?=
 =?utf-8?B?VEpOZWZRTjl6M1d0MHZJQ3pSSnMvQVNPcE1sYTdrRm42Y3FOOU92NnVPTVg1?=
 =?utf-8?B?YU42NGZiZUFaYWJuSjZLbFhvLzNLU1NpWFh6OXAxUmpuS0NGTmVLUkxzdFhv?=
 =?utf-8?B?KzlycUc1RkJWeDhkZmdKWEJwNGgxWVBNUWNvaUhiekVJSTNTUmRlR2p2ZEdH?=
 =?utf-8?B?WHZNNGZQSGsyaDVoeEJXbmtwN255STVGNnp0YlE5eVBySi93VWg2QkZlWWVD?=
 =?utf-8?B?cmthczRmakovZTV6cUdMSS84RmVGTFN4UzMxaUxWVXR5OUlnNEFpcGJjbmc1?=
 =?utf-8?B?RDVENVRVN3paZzZTd0ExVnJ4ZHNZV21qV25LNjduS1ErbDRVN1JOZS80ZXVn?=
 =?utf-8?B?d0t2VDNnb29QMFZTMGp0SmZaZU82MG1oMXZnZDIwWjlaYzg2dXdTRFJnL042?=
 =?utf-8?B?UUdZMkpwZUJLTHU2YXJBNlV1N0xOMW5TUXBOR0VMazM0dXpIQnZJb01tczd1?=
 =?utf-8?B?dS82cm52M3ViZ3Z5TC9SaXp0YlBDcVpUcDhEWjVSSE9YakRvVzhaYlF5bDEr?=
 =?utf-8?B?a3p2MUQ2TVZ2dFJMRVp1Ymptbmt3RTNKNytTQlZSWkRkekxGaU9RZFVraFlI?=
 =?utf-8?B?TzVtTUlCOWlnUm5uRlREWlF4Z2tFVUs5VFhqaEhIVkVMSUFaZjUvQklHQ2ht?=
 =?utf-8?B?NURiaFpJZ3NLOFUzb1dsRmQrYmhhNlJDeEdCWTNaZEx5VkpqODluRHN5eHky?=
 =?utf-8?Q?4WCEDpRWaZ3/QvHY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca0418f-1052-49e5-52de-08da17269110
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:06:03.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Wgr6CLsnb0drEMDSMd4P3XNR6d5FHMVqUototf0m49W10QwIt7ppjhHS6g/A3ctcRva/Jts7ppnvFFtqpzpTpm7NF7Dlst3Yqlv7SmcuPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 8:34 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 10:06 +0300, Jarkko Sakkinen wrote:

>>>
>>
>> To be coherent with other names, this should be
>> SGX_IOC_ENCLAVE_MODIFY_TYPES.

This is not such a clear change request to me:

SGX_IOC_ENCLAVE_ADD_PAGES - add multiple pages
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS - restrict multiple permissions
SGX_IOC_ENCLAVE_REMOVE_PAGES - remove multiple pages
SGX_IOC_ENCLAVE_MODIFY_TYPE - set a single type

Perhaps it should rather be SGX_IOC_ENCLAVE_SET_TYPE to indicate that
there is a single target type as opposed to the possibility
of multiple source types (TCS and regular pages can be trimmed).

> 
> This should take only page type given that flags are zeroed:
> 
> EPCM(DS:RCX).R := 0;
> EPCM(DS:RCX).W := 0;
> EPCM(DS:RCX).X := 0; 
> 

ok, this was how it was done in V1 [1] and I can go back to that.


Reinette

[1] https://lore.kernel.org/linux-sgx/c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com/

