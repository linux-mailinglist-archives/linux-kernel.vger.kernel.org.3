Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5994D1F72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbiCHRvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349295AbiCHRvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:51:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997055BE8;
        Tue,  8 Mar 2022 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646761850; x=1678297850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uh3YN7I9AUqa09ofZe73TBAYVs2CSbKNDEvwF0hrzp4=;
  b=jlG6gxQtuD1QctQiwE2JTdphumWAvCkl2YAnYUp9k+QM2HutpcyuZPk1
   qOvHOGDfN+WKIt1idyGmTEEgbm53JUBKR85mVruJWEG5Kojv9g4s8nyON
   S8vrhuElnLjl9gkXxIN0YHQLO2M5UN7n8g+pdhVO0N9WX8boaWVRDUyGI
   JFlP9+InZKkvCjYOXWGzNCg2QNSaREvq4Dngy43+kmhd5ACUI3+ArPcHt
   KWTINDvXtLU1yccFyIGtrtxxSLaIyb0shpqQ8vNmM+p00N+YMkijUpQ88
   BCCyuoIWag3vYxtX0z6ngNYzvC5c8HsV2OUBqX8JLlAWA2bjBWpb7G27d
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252336377"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252336377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:49:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="611086631"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2022 09:49:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 09:49:16 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 09:49:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 09:49:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 09:49:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI4e0tmC5t+9D6bn82WJY9O+El2LWDVbrn+W3zE2KDnQ+AMIUeMHSeIzLxKSxr03MDFGuPKCtLXA0S5zPiBJwWlIiPz50X1XRfJ1bYQSTLlKmLMSptajpiPlUxa8Cpuvxow6DGGzHOuJBPECsbx3F+clBl+akAZxL6fuhtwSG1o+/5mixw6ycUTpgCeQOt9WfpYVr3lTKAiNRptaujIzV7q+yhpLO+sjiQ2uOBM21ckHfo6HClTFoxOJ3K1UEyI7GOxZv8+4eR4mcd94wqs1PXbMwZGH3fSZZDGfJoakGjQg2LocqSHqucLcvK6Dckk3yozqm4wtMtGuXUl9KcBcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3apn77hcf74RewaXLeRFoSAOKPIyFxF5zNXn0Ff013Q=;
 b=E9vsq2wA+/P0HPh1XRoRQx1nK/dJO3HwnkuRWRKF7zmOYx5+AqrqA7L8aVYoyyL+I+VPslQivgO26Ib3WerifY1eJtT7r8rhOhLGa9eqzu3h61TR3M5/J5U12bf/l685oGVf22hVMs4zkY4JB6dw6/U+BTBXBfjIguYe0eTfFc8WBUnMR7UzifpYhJSiFCkq+wBf68rcLopdefW0wlmhbDhFlfbmM6LTmxZWO3jezYeqUvoJm9lq2YQvj7TgwYGkN6ijx1HXEw+r1whQm4Cjy1kCHWDCfzzoR7uXnUfh9yj9sChXZOR1+hWFRS4boglB5W4EI4etWqyFsRheFXHZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Tue, 8 Mar
 2022 17:49:07 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:49:06 +0000
Message-ID: <f99e5923-af8b-80bc-838a-6c6cb698d353@intel.com>
Date:   Tue, 8 Mar 2022 09:49:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed
 than enclave permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com>
 <YiY8bD/QcmcHH8dz@iki.fi> <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com>
 <YicQbzR1o1qZUGbw@iki.fi> <YiccplUukAJ5SeFn@iki.fi> <YiceFtul/VsViuUu@iki.fi>
 <e7e8dde9-b929-4a01-1e39-dbf3303fdd0c@intel.com> <YieLk2YIMD9i8djv@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YieLk2YIMD9i8djv@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:303:2a::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f390e406-970e-4ad3-1ade-08da012bf0fc
X-MS-TrafficTypeDiagnostic: BYAPR11MB3558:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3558B87F9CE2A9C54CF24118F8099@BYAPR11MB3558.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BF/nSDgvgsxrfz4/DQPw4vcpF3YdFvLhdRQdLJhAAu/12LheWsTYcrOh9GMAZLvv/D54vto0509wyRjML6VrdglM4CL2ztOhqVjZkl977gvJcx37PUsHfXUrZOYZZtOZrxnNannMJm7eEasUXHcP6xIGVfNg0SZjTlIr3TkUKeVEPjlJ4Eq3VSl9NfeUoF+mCUReUFE/f6leIO2hbqgzeyFjl4Gwa1DfykEVCmsYOcQIjB38F3R1vWsffKNBQLC6US9Hx1HNHr9M/X2VPb/NgGImHjz8Qwq3dq5KAtfk5EiMjgrV00wsREwe5R4AbP05cMCqEeVDoXibf8vQBCuh9wv47H6rS7KXU5mmqDR8V1p1BwC/Vq7o+9nZOsOmalC/RDQcNnhTMBmEIyujyt/jRjSter+uefzUTdWbvWGpM9VNdcI6ggJzFUb6Joom9ApIuWehJ5iptNAF3IsABqqEGUu4kqsLHpvHg0eCxL3i+Bh5golk43+q4RB4moUpZrDWLVsPeTF9ke0oFfHYcqLZhrP59n57tQhc+vLhZUe7Py0fMYTPoirdizvpYoJBYyxCqe6sfmVpOS7o2H+HjBaAy4BfJP2oz3rXkW0+nzrKXhs5BDKc1wZDOYv/d8DFDr535zqoW9gpO36H7sC/M0kua/eVqrMrpXz7LFrY8u61SCmYxW7q/97IOM8UTsWf/E+leHJQQBBVu++ZJXAkaZtnSkhE7V6Rq2aHVjl9ELJVd0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(316002)(66946007)(8676002)(66556008)(7416002)(4326008)(36756003)(5660300002)(6916009)(2906002)(6506007)(31686004)(6486002)(508600001)(6666004)(6512007)(53546011)(83380400001)(86362001)(38100700002)(2616005)(26005)(30864003)(186003)(44832011)(82960400001)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjllekpZQ29Mb05kemp0aUMyOGMvTHpwUHVLTThBekJ1YzVNWWVDeWhSTGFl?=
 =?utf-8?B?dUFZa2hVVm9MWFo3OHc1a0MrNTZIN0hmT1hKK3lMTGxtbnpGM2M3b01KNWxy?=
 =?utf-8?B?SXBOVGt0TzF2SjNhSFlhcU0rMVN4MzZqZlY5ZUZ3blJhMWhnVUs5MlZUQWM2?=
 =?utf-8?B?dHlPc0UzaEtsY1hPb0NvdE85WndJdEdSVGtFcXh0MzRuRjdzZUU2QzNNN0M3?=
 =?utf-8?B?MHJOV1EvSnB3WGd2b3BPbUREanlRWHJ1SVBDWllQK3ZPbTlhb3BhL3VRMS9H?=
 =?utf-8?B?VEpucWx3YTFWZXVTbGZQYVBqNDJuSG1WcVlBY3o5NFRMMkpmWlE4U0dCNndu?=
 =?utf-8?B?bnAzTVV6QVZsdmNGSElqUk95TFA1b2ovVmJWKzFhQmtTZHhueGlnRkZaZkVz?=
 =?utf-8?B?bFJhQ3Z6S1FWYnNjS0NJbndNcWdWcWlaZGhNcHVYUExBZk4vK1RLckxMUkJt?=
 =?utf-8?B?WFRLWlpENHFBYTR5OVo5MkhZbzR1ZkV3RHN6bUFEZHhhNktZbGYyd08xRUJu?=
 =?utf-8?B?cFpuU0xrR1NnZ3NkYVZONERraHpMb0dTZy82aGVURTdNYVRQZ0d6WkR4UUF2?=
 =?utf-8?B?dlo5WW8vb1pteVdmUGNHNFVJc0VSR09NSTBjeFpYUWdWSmVHS05EV2lkSi9q?=
 =?utf-8?B?c09pS3FGV2NJNitOZkpZYS9IVXpTSHBVR1cra3IzVG5iMjVDV1RSbkJwNW94?=
 =?utf-8?B?L2wrYnoxRmxKZHJJZGxoYTZwR20yZ2ZqSHVsUEt4Q2E1MU1oUG45NW5PdWhp?=
 =?utf-8?B?bWFuN3d5ckdkTTdYNkdPZ0tGbjNnV1RSUm9NQTArQW15VzRhbDRRcHFzWEFR?=
 =?utf-8?B?N1ZHUWptUFhkVUJHNloya0p1N1hFcnJkM2paT0tnOE9hVjVRWVlGbkZ2MVIv?=
 =?utf-8?B?RllmK1VNWkZCM0RjQUhYZnQ2aGdJZWpoaXlwajB5UHVmUVpySEtyV09IZlA5?=
 =?utf-8?B?bW5YTlp6YmJUTlpTcEhmUk9heWUwVHZ0WmZzQ0tLTmlsL1Mwelc5ZmJlY2Zt?=
 =?utf-8?B?QUFmcHEyc1lmWmduWUhMLzNhRFBjU1Z6a095ZnpPVDRxWlJwUDgvaW5CTFNk?=
 =?utf-8?B?bWpZY2tqeHFpczV5YnUyWUpGNEZUaWpwbjhoSjl5bUVmZ0V1aTh6aURFTTlT?=
 =?utf-8?B?TEhzUkNkb0o1enkwUlBnZVhiRlo4S2g0U3kwNE1wcDl3b1RZQjh1QVVEY1Fk?=
 =?utf-8?B?V0Nwc2VYaDM2MVl1OXA0dEdzUmdSNis5Y3h5MFB0U1dhZEJpTVlsWVM3N2xn?=
 =?utf-8?B?bjZZNUE3UWtOcnBPcnZRZWRrRTRmUjJUdE5hUUNUNWRDRVcvMnJML290VEFM?=
 =?utf-8?B?ODZORVFobkJtazk0dVRVeEtCaXh2T2JjcVFFRlcxelBrQ04yM095L25yUlJ1?=
 =?utf-8?B?RHVQS01rYXAyWnQwQXpVRDN4V2FWWk1TZExvdGNHd3JMT2ErakRzdHZZclIw?=
 =?utf-8?B?bzFXb2hWMVBlR3pEbDI3OEhVVjlETW5ndU45WDRJRXMxQ1VjT3dzTzhBdVZR?=
 =?utf-8?B?TWlJWm5PMWxCYnlNUm5DVXl0QTJYZ0h3eVZnQUt5cXoxSVdVVDdkZEJKOHc3?=
 =?utf-8?B?NndMQ1JyVmZDQnlFYUttMTB4SkFwYUNNRFRyWDBvTnBwUyt2dGVqK2pvcTUv?=
 =?utf-8?B?WStCVDNabFNyMUdGVlRJaSt2ZjBqWk5PUlV2R1QxNHBuZ3kzZ2c4SzRkMUdn?=
 =?utf-8?B?NWo1OXdVdERwMHVTRHdSNHY2eHNxdEtlYXh0S1IyMU1GYThMYUUzbC9Jcy9K?=
 =?utf-8?B?V0Y0R0E3NHN4UFNkTkhobE1qMG1VbWRzYXRFMlJGVGZrbHFnY21DRnRTaERO?=
 =?utf-8?B?QnVqcUoyZ29zc2dDSTRWK25HMWRZS1RJYmxDQytyblRxQkVSdDd5MDh3Rko1?=
 =?utf-8?B?ZmJ1cmI1Z2xvSDMxWnM4UlRzS29PaDc4Z1huamppMUsvUGJBV3FBd2V6aGNx?=
 =?utf-8?B?RDBQWWVnQzdGUnBnQUViaUllLzl3VjlYMEJ2R2dNUFlIdTAxYVZrRHZzbU9m?=
 =?utf-8?B?aVAwS1VkVVhlNTRRTVllaUVkc3UrNGI1bVRhT0l4YWNJbFZFYkxNR2R4NWJs?=
 =?utf-8?B?MDM5YzNUYXE4L0U4UGdKVVJOeXdTbVVHQk1ONWJZaHoyOXhRcXhaYU1EaThY?=
 =?utf-8?B?QXNJV0hOamtxaTR1cjhxaXV1bzFTVStqbVNjTFpIcjJudnhJNDMwYzltdEJv?=
 =?utf-8?B?cklFbjJDMDJpZThwdllWNHZOb0NocnltU3ZTZHg4L05yT3ZGeGl5dGY3Yitq?=
 =?utf-8?Q?S6erlRaDP67JGTKtR+kWqJT6hG6n6iB72FZ1WafoGU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f390e406-970e-4ad3-1ade-08da012bf0fc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:49:06.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6dCSC+ei8S/TU+VrZzYh5o3nBX0paJOlYwcDhywAt2kM3R2HMccOsQdcxGlJhev1Cbxf4W+c5GbLwOb2brettAKClvxFFyX1xV2+uAg8Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/8/2022 9:00 AM, Jarkko Sakkinen wrote:
> On Tue, Mar 08, 2022 at 08:04:33AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/8/2022 1:12 AM, Jarkko Sakkinen wrote:
>>> On Tue, Mar 08, 2022 at 11:06:46AM +0200, Jarkko Sakkinen wrote:
>>>> On Tue, Mar 08, 2022 at 10:14:42AM +0200, Jarkko Sakkinen wrote:
>>>>> On Mon, Mar 07, 2022 at 09:36:36AM -0800, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 3/7/2022 9:10 AM, Jarkko Sakkinen wrote:
>>>>>>> On Mon, Feb 07, 2022 at 04:45:28PM -0800, Reinette Chatre wrote:
>>>>>>>> === Summary ===
>>>>>>>>
>>>>>>>> An SGX VMA can only be created if its permissions are the same or
>>>>>>>> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
>>>>>>>> creation this same rule is again enforced by the page fault handler:
>>>>>>>> faulted enclave pages are required to have equal or more relaxed
>>>>>>>> EPCM permissions than the VMA permissions.
>>>>>>>>
>>>>>>>> On SGX1 systems the additional enforcement in the page fault handler
>>>>>>>> is redundant and on SGX2 systems it incorrectly prevents access.
>>>>>>>> On SGX1 systems it is unnecessary to repeat the enforcement of the
>>>>>>>> permission rule. The rule used during original VMA creation will
>>>>>>>> ensure that any access attempt will use correct permissions.
>>>>>>>> With SGX2 the EPCM permissions of a page can change after VMA
>>>>>>>> creation resulting in the VMA permissions potentially being more
>>>>>>>> relaxed than the EPCM permissions and the page fault handler
>>>>>>>> incorrectly blocking valid access attempts.
>>>>>>>>
>>>>>>>> Enable the VMA's pages to remain accessible while ensuring that
>>>>>>>> the PTEs are installed to match the EPCM permissions but not be
>>>>>>>> more relaxed than the VMA permissions.
>>>>>>>>
>>>>>>>> === Full Changelog ===
>>>>>>>>
>>>>>>>> An SGX enclave is an area of memory where parts of an application
>>>>>>>> can reside. First an enclave is created and loaded (from
>>>>>>>> non-enclave memory) with the code and data of an application,
>>>>>>>> then user space can map (mmap()) the enclave memory to
>>>>>>>> be able to enter the enclave at its defined entry points for
>>>>>>>> execution within it.
>>>>>>>>
>>>>>>>> The hardware maintains a secure structure, the Enclave Page Cache Map
>>>>>>>> (EPCM), that tracks the contents of the enclave. Of interest here is
>>>>>>>> its tracking of the enclave page permissions. When a page is loaded
>>>>>>>> into the enclave its permissions are specified and recorded in the
>>>>>>>> EPCM. In parallel the kernel maintains permissions within the
>>>>>>>> page table entries (PTEs) and the rule is that PTE permissions
>>>>>>>> are not allowed to be more relaxed than the EPCM permissions.
>>>>>>>>
>>>>>>>> A new mapping (mmap()) of enclave memory can only succeed if the
>>>>>>>> mapping has the same or weaker permissions than the permissions that
>>>>>>>> were vetted during enclave creation. This is enforced by
>>>>>>>> sgx_encl_may_map() that is called on the mmap() as well as mprotect()
>>>>>>>> paths. This rule remains.
>>>>>>>>
>>>>>>>> One feature of SGX2 is to support the modification of EPCM permissions
>>>>>>>> after enclave initialization. Enclave pages may thus already be part
>>>>>>>> of a VMA at the time their EPCM permissions are changed resulting
>>>>>>>> in the VMA's permissions potentially being more relaxed than the EPCM
>>>>>>>> permissions.
>>>>>>>>
>>>>>>>> Allow permissions of existing VMAs to be more relaxed than EPCM
>>>>>>>> permissions in preparation for dynamic EPCM permission changes
>>>>>>>> made possible in SGX2.  New VMAs that attempt to have more relaxed
>>>>>>>> permissions than EPCM permissions continue to be unsupported.
>>>>>>>>
>>>>>>>> Reasons why permissions of existing VMAs are allowed to be more relaxed
>>>>>>>> than EPCM permissions instead of dynamically changing VMA permissions
>>>>>>>> when EPCM permissions change are:
>>>>>>>> 1) Changing VMA permissions involve splitting VMAs which is an
>>>>>>>>    operation that can fail. Additionally changing EPCM permissions of
>>>>>>>>    a range of pages could also fail on any of the pages involved.
>>>>>>>>    Handling these error cases causes problems. For example, if an
>>>>>>>>    EPCM permission change fails and the VMA has already been split
>>>>>>>>    then it is not possible to undo the VMA split nor possible to
>>>>>>>>    undo the EPCM permission changes that did succeed before the
>>>>>>>>    failure.
>>>>>>>> 2) The kernel has little insight into the user space where EPCM
>>>>>>>>    permissions are controlled from. For example, a RW page may
>>>>>>>>    be made RO just before it is made RX and splitting the VMAs
>>>>>>>>    while the VMAs may change soon is unnecessary.
>>>>>>>>
>>>>>>>> Remove the extra permission check called on a page fault
>>>>>>>> (vm_operations_struct->fault) or during debugging
>>>>>>>> (vm_operations_struct->access) when loading the enclave page from swap
>>>>>>>> that ensures that the VMA permissions are not more relaxed than the
>>>>>>>> EPCM permissions. Since a VMA could only exist if it passed the
>>>>>>>> original permission checks during mmap() and a VMA may indeed
>>>>>>>> have more relaxed permissions than the EPCM permissions this extra
>>>>>>>> permission check is no longer appropriate.
>>>>>>>>
>>>>>>>> With the permission check removed, ensure that PTEs do
>>>>>>>> not blindly inherit the VMA permissions but instead the permissions
>>>>>>>> that the VMA and EPCM agree on. PTEs for writable pages (from VMA
>>>>>>>> and enclave perspective) are installed with the writable bit set,
>>>>>>>> reducing the need for this additional flow to the permission mismatch
>>>>>>>> cases handled next.
>>>>>>>>
>>>>>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>>>> ---
>>>>>>>> Changes since V1:
>>>>>>>> - Reword commit message (Jarkko).
>>>>>>>> - Use "relax" instead of "exceed" when referring to permissions (Dave).
>>>>>>>> - Add snippet to Documentation/x86/sgx.rst that highlights the
>>>>>>>>   relationship between VMA, EPCM, and PTE permissions on SGX
>>>>>>>>   systems (Andy).
>>>>>>>>
>>>>>>>>  Documentation/x86/sgx.rst      | 10 +++++++++
>>>>>>>>  arch/x86/kernel/cpu/sgx/encl.c | 38 ++++++++++++++++++----------------
>>>>>>>>  2 files changed, 30 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
>>>>>>>> index 89ff924b1480..5659932728a5 100644
>>>>>>>> --- a/Documentation/x86/sgx.rst
>>>>>>>> +++ b/Documentation/x86/sgx.rst
>>>>>>>> @@ -99,6 +99,16 @@ The relationships between the different permission masks are:
>>>>>>>>  * PTEs are installed to match the EPCM permissions, but not be more
>>>>>>>>    relaxed than the VMA permissions.
>>>>>>>>  
>>>>>>>> +On systems supporting SGX2 EPCM permissions may change while the
>>>>>>>> +enclave page belongs to a VMA without impacting the VMA permissions.
>>>>>>>> +This means that a running VMA may appear to allow access to an enclave
>>>>>>>> +page that is not allowed by its EPCM permissions. For example, when an
>>>>>>>> +enclave page with RW EPCM permissions is mapped by a RW VMA but is
>>>>>>>> +subsequently changed to have read-only EPCM permissions. The kernel
>>>>>>>> +continues to maintain correct access to the enclave page through the
>>>>>>>> +PTE that will ensure that only access allowed by both the VMA
>>>>>>>> +and EPCM permissions are permitted.
>>>>>>>> +
>>>>>>>>  Application interface
>>>>>>>>  =====================
>>>>>>>>  
>>>>>>>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>>>>>>>> index 48afe96ae0f0..b6105d9e7c46 100644
>>>>>>>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>>>>>>>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>>>>>>>> @@ -91,10 +91,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>>>>>>> -						unsigned long addr,
>>>>>>>> -						unsigned long vm_flags)
>>>>>>>> +						unsigned long addr)
>>>>>>>>  {
>>>>>>>> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>>>>>>>>  	struct sgx_epc_page *epc_page;
>>>>>>>>  	struct sgx_encl_page *entry;
>>>>>>>>  
>>>>>>>> @@ -102,14 +100,6 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>>>>>>>>  	if (!entry)
>>>>>>>>  		return ERR_PTR(-EFAULT);
>>>>>>>>  
>>>>>>>> -	/*
>>>>>>>> -	 * Verify that the faulted page has equal or higher build time
>>>>>>>> -	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
>>>>>>>> -	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
>>>>>>>> -	 */
>>>>>>>> -	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
>>>>>>>> -		return ERR_PTR(-EFAULT);
>>>>>>>> -
>>>>>>>>  	/* Entry successfully located. */
>>>>>>>>  	if (entry->epc_page) {
>>>>>>>>  		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
>>>>>>>> @@ -138,7 +128,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>>>  {
>>>>>>>>  	unsigned long addr = (unsigned long)vmf->address;
>>>>>>>>  	struct vm_area_struct *vma = vmf->vma;
>>>>>>>> +	unsigned long page_prot_bits;
>>>>>>>>  	struct sgx_encl_page *entry;
>>>>>>>> +	unsigned long vm_prot_bits;
>>>>>>>>  	unsigned long phys_addr;
>>>>>>>>  	struct sgx_encl *encl;
>>>>>>>>  	vm_fault_t ret;
>>>>>>>> @@ -155,7 +147,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>>>  
>>>>>>>>  	mutex_lock(&encl->lock);
>>>>>>>>  
>>>>>>>> -	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
>>>>>>>> +	entry = sgx_encl_load_page(encl, addr);
>>>>>>>>  	if (IS_ERR(entry)) {
>>>>>>>>  		mutex_unlock(&encl->lock);
>>>>>>>   
>>>>>>>> @@ -167,7 +159,19 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>>>>>>>>  
>>>>>>>>  	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
>>>>>>>>  
>>>>>>>> -	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
>>>>>>>> +	/*
>>>>>>>> +	 * Insert PTE to match the EPCM page permissions ensured to not
>>>>>>>> +	 * exceed the VMA permissions.
>>>>>>>> +	 */
>>>>>>>> +	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>>>>>>>> +	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
>>>>>>>> +	/*
>>>>>>>> +	 * Add VM_SHARED so that PTE is made writable right away if VMA
>>>>>>>> +	 * and EPCM are writable (no COW in SGX).
>>>>>>>> +	 */
>>>>>>>> +	page_prot_bits |= (vma->vm_flags & VM_SHARED);
>>>>>>>> +	ret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
>>>>>>>> +				  vm_get_page_prot(page_prot_bits));
>>>>>>>>  	if (ret != VM_FAULT_NOPAGE) {
>>>>>>>>  		mutex_unlock(&encl->lock);
>>>>>>>>  
>>>>>>>> @@ -295,15 +299,14 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
>>>>>>>>   * Load an enclave page to EPC if required, and take encl->lock.
>>>>>>>>   */
>>>>>>>>  static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
>>>>>>>> -						   unsigned long addr,
>>>>>>>> -						   unsigned long vm_flags)
>>>>>>>> +						   unsigned long addr)
>>>>>>>>  {
>>>>>>>>  	struct sgx_encl_page *entry;
>>>>>>>>  
>>>>>>>>  	for ( ; ; ) {
>>>>>>>>  		mutex_lock(&encl->lock);
>>>>>>>>  
>>>>>>>> -		entry = sgx_encl_load_page(encl, addr, vm_flags);
>>>>>>>> +		entry = sgx_encl_load_page(encl, addr);
>>>>>>>>  		if (PTR_ERR(entry) != -EBUSY)
>>>>>>>>  			break;
>>>>>>>>  
>>>>>>>> @@ -339,8 +342,7 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
>>>>>>>>  		return -EFAULT;
>>>>>>>>  
>>>>>>>>  	for (i = 0; i < len; i += cnt) {
>>>>>>>> -		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
>>>>>>>> -					      vma->vm_flags);
>>>>>>>> +		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
>>>>>>>>  		if (IS_ERR(entry)) {
>>>>>>>>  			ret = PTR_ERR(entry);
>>>>>>>>  			break;
>>>>>>>> -- 
>>>>>>>> 2.25.1
>>>>>>>>
>>>>>>>
>>>>>>> If you unconditionally set vm_max_prot_bits to RWX for dynamically created
>>>>>>> pags, you would not need to do this.
>>>>>>>
>>>>>>> These patches could be then safely dropped then:
>>>>>>>
>>>>>>> - [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions 
>>>>>>> - [PATCH V2 08/32] x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
>>>>>>> - [PATCH V2 15/32] x86/sgx: Support relaxing of enclave page permissions
>>>>>>>
>>>>>>> And that would also keep full ABI compatibility without exceptions to the
>>>>>>> existing mainline code.
>>>>>>>
>>>>>>
>>>>>> Dropping these changes do not just impact dynamically created pages. Dropping
>>>>>> these patches would result in EPCM page permission restriction being supported
>>>>>> for all pages, those added before enclave initialization as well as dynamically
>>>>>> added pages, but their PTEs will not be impacted.
>>>>>>
>>>>>> For example, if a RW enclave page is added via SGX_IOC_ENCLAVE_ADD_PAGES and
>>>>>> then later made read-only via SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS then Linux
>>>>>> would keep allowing and installing RW PTEs to this page.
>>>>>
>>>>> I think that would be perfectly fine, if someone wants to do that. There is
>>>>> no corrateral damage on doing that. Kernel does not get messed because of
>>>>> that. It's a use case that does not make sense in the first place, so it'd
>>>>> be stupid to build anything extensive around it to the kernel.
>>>>>
>>>>> Shooting yourself to the foot is something that kernel does and should not
>>>>> protect user space from unless there is a risk of messing the state of the
>>>>> kernel itself.
>>>>>
>>>>> Much worse is that we have e.g. completely artificial ioctl
>>>>> SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to support this scheme, which could e.g.
>>>>> cause extra roundtrips for simple EMODPE.
>>>>>
>>>>> Also this means not having to include 06/32, which keeps 100% backwards
>>>>> compatibility in run-time behaviour to the mainline while not restricting
>>>>> at all dynamically created pages. And we get rid of complex book keeping
>>>>> of vm_run_prot_bits.
>>>>>
>>>>> And generally the whole model is then very easy to understand and explain.
>>>>> If I had to keep presentation of the current mess in the patch set in a
>>>>> conference, I can honestly say that I would be in serious trouble. It's
>>>>> not clean and clear security model, which is a risk by itself.
>>>>
>>>> I.e.
>>>>
>>>> 1. For EADD'd pages: stick what has been the invariant 1,5 years now. Do
>>>>    not change it by any means (e.g. 06/32).
>>>> 2. For EAUG'd pages: set vm_max_prot_bits RWX, which essentially means do
>>>>    what ever you want with PTE's and EPCM.
>>>>
>>>> It's a clear and understandable model that does nothing bad to the kernel,
>>>> and a run-time developer can surely find away to get things on going. For
>>>> user space, the most important thing is the clarity in kernel behaviour,
>>>> and this does deliver that clarity. It's not perfect but it does do the
>>>> job and anyone can get it.
>>>
>>> Also a quantitive argument for this is that by simplifying security model
>>> this way it is one ioctl less, which must be considered as +1. We do not
>>> want to add new ioctls unless it is something we absolutely cannnot live
>>> without. We absolutely can live without SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.
>>>
>>
>> ok, with the implications understood and accepted I will proceed with a new
>> series that separates EPCM from PTEs and make RWX PTEs possible by default
>> for EAUG pages. This has broader impact than just removing
>> the three patches you list. "[PATCH 07/32] x86/sgx: Add pfn_mkwrite() handler
>> for present PTEs" is also no longer needed and there is no longer a need
>> to flush PTEs after restricting permissions. New changes also need to
>> be considered - at least the current documentation. I'll rework the series.
> 
> Yes, I really think it is a solid plan. Any possible LSM hooks would most
> likely attach to build product, not the dynamic behaviour.
> 
> As far as the page fault handler goes, Haitao is correct after the all
> discussions that it makes sense. The purpose of MAP_POPULATE series is
> not to replace it but instead complement it. Just wanted to clear this
> up as I said otherwise earlier this week.
> 

Understood. I will keep the implementation where EAUG is done in page fault
handler. I do plan to pick up your patch "x86/sgx: Export sgx_encl_page_alloc()"
since a consequence of the other changes is that this can now be shared.

Reinette

