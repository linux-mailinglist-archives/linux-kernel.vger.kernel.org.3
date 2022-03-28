Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB304E96D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242587AbiC1MlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiC1MlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:41:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344332A723
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648471160; x=1680007160;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GZ4Li+reMz0wiGOjmlCTeQjiyHmTBER6q5y2GCW0Hcc=;
  b=ZGg463vDN+xxLx0jl4i3fr2MDJfEtt5+lJHVCt8Chgv4RS79Ctt+R7kH
   ClQXOg3IlTyFLaY1/eGw5el6gvSb2Irbh+EwineZSKlfNAjqrN5oSyy4d
   rtDw79ZstLUDBhlHMsj0XGbzSyFevbnc0I/vsBxVV80V+Aqu18jJt/4LG
   LbS9XKKssq6/4k6U1dsvbcFPX5LduSmO38oS03taHs34YUPjePeD7c3wk
   KGphi6aNR97Jgnkt3MOhtqatfkEEl/TAcVIsETUSnfOWkiFEFp0WY03lc
   GxAsAx/xNAK0HcbWo1+Cfeu8VXi0757QwkHYy8xp/6sZy0ICV+ild4P7O
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="258700136"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="258700136"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 05:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="694347751"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 05:39:19 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 05:39:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 05:39:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 05:39:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 05:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn6u6D4q4mizvtG6IMzVl4z0a0Kj1IzhSMj0u4nBrzrvuEJcVP/dAhl14V5QXZD2qJEvqPcWREFG3kqZATzPZLTnX1e+hrDlGyexEA84L7cDFf38BGvS3UaYHG1HTARMJ7ylLAUhnaIG/B+YdldzuaO4MpcEnRhVILazspScfWz/j8xLurFJ7Kay31YxfgpvPlR/DtMYywiXEh7nm/vtlXiz9kzLxzCywpUlIL7utBrNczwxHR1JqzPLLaSWkVv/+u+VF7px6W1ZxVHqs3sA4Xy000jn6jwbP3esSqHNjKvi0SVddTpJqBjRh8e9k5aC9Ul50LIYoabEIMNDkAb83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG9VWGKu2IzM89iFpsFoa3Oy2sGItx7SolpUzdI+9ZQ=;
 b=Ogr77YhyGUksBmylq+N8D7b6XErev/APTHYeF4ceMzajirw9uhIyCJ27p+U0gXxW0Ap+DQHDkUCQJdvFXCT0adlZOVUWdO8f0Hs8KruNe5PhUCONl7gBYLrEUxtBDzb7/d3nBHogZ/TcXMd5FI4GkA/7OtG6maDsQul+jNFAveQkJ4rTOkPI46br27VTQiYPxAvRhOiKJj5fGrSZojhZGE1CNnRnHFL0VrdugZ3NKBW0aobDcZl8m1WgI+u9TB2yspbM0iSn+iduxA94ydkon786JXwk9nbOepvUlKNwmbtdBPZj2icFwG4d365nVBcI8j7RP5Ra0jsjbOmMC9okMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by MWHPR11MB1885.namprd11.prod.outlook.com (2603:10b6:300:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 12:39:16 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::4d47:2a37:da9b:81e4]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::4d47:2a37:da9b:81e4%3]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:39:16 +0000
Message-ID: <d723e20a-b461-f63e-2fd1-eea91b0dddf1@intel.com>
Date:   Mon, 28 Mar 2022 05:39:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch 0/7] x86/fpu: Cure supervisor mode (ENQCMD) fallout
Content-Language: en-CA
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Paolo Bonzini <bonzini@gnu.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220324134548.432837672@linutronix.de>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20220324134548.432837672@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To CO1PR11MB4849.namprd11.prod.outlook.com
 (2603:10b6:303:90::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a03201a-dbd7-4ab0-fb83-08da10b7f872
X-MS-TrafficTypeDiagnostic: MWHPR11MB1885:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1885A1D535F2610052A49BF1D81D9@MWHPR11MB1885.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0oJAwQpKRTc6layyTFY7WgnSTpCw+sHutDFnAHFAXY2P03vJfngBKbTpvYcPgxpKao8ScwB9Bg0fqMLIDpp07x/lPWVBqVxvZNJTlP4U52IOLW8FGNTUkD5MtYozur2+20X2gcfXPTj18oHCEXZSNcXLqDzP+F6/mj3S0zYglgHG4ZVZMb5C5arjafUxWBqj1FcTQd0xwaDEf1wQa1XsZshctzBxzGljEFVWl9zNHdQsomAOttePClQ52Jhsw5pGUifoYw4ZdRLcRXGPZbfKTegr6YxqpQlgijzQ6q8B9cxmbpLu1JPYL1chpjVthzRCzBBzpcTRAa7JyrfJS+uvdM8d7DXlE6Q1zi6dEey3YP2BpOd9MBYN5haPO34swPlkRfkt3GArFwD7cKDF9zwGQ0+UTGkl4Bl2cpkyizLHIs/f670O4j+MGPbtJncbLBBLKsjhWtkLXhrHHV0TZPwepBLQjrrwgbzfFzt46ouCURnhuOqN+Oma+70yLGitkRcVTt5CJoQRG49fhh0ujievVRRldNbH6lM3/EbL9SLjQsGHYdZR1/gv1iK8q2b+wmAEbcMDVT5Q9suC6mQQBKzQdcniuxvsVDdzy6ajEdI1zg+XxBKnlX544iuUzz5QhV3ZwGlKhUnGRz8uX88fy2ymHQtEnQfz8UFecer2ya+pQ7/jmYBKgooquGI/M8mr17GrLwJ6OGOU72fi2ITi7n0aC9HBIFdvhOtz+WzFNzWSLsOBJopVdra5cFiZXXGkh6tUFWYbLadiC1otOBe24lSc8kR/wTPK6cLE2dt8m6JMpZIb8Wfyh79FlJYSpk/svjyOLvF++YuU7CFy0pXYNiL+gwJBhqfapqEiF9Ey9/fW74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(8676002)(66946007)(66476007)(6512007)(66556008)(31686004)(2906002)(4326008)(31696002)(86362001)(36756003)(508600001)(8936002)(82960400001)(186003)(26005)(54906003)(107886003)(5660300002)(966005)(6486002)(110136005)(316002)(2616005)(83380400001)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWcxdkhnT3pUMVc3MUs3Ukh2dUl5T0xMeFMyNjNaQjBJU011WU1hTW5SSmhS?=
 =?utf-8?B?eVRFWTlmVmlIdGZqNi9oTXZnRTYwODRuVHVJdGs0TVFRNzdkSWE1U0NLU0Ex?=
 =?utf-8?B?bThwWlFrTC8xeEJhaW93ejhHN2UxVG9tRVlqSW9NemxTR0NycStnbXpBOFJa?=
 =?utf-8?B?Q2xKUnZsRmZTZlZCaGdpNDNyNEZHZFZWaUJxT1RXKzZ4YVFWbFR0U0xaZTRL?=
 =?utf-8?B?dEJrTWIrQTRJdjdodkRISHhkWVNKeU5pWEtkdmprdW1oZWUwazZBNWFWWFVl?=
 =?utf-8?B?UHl4UERTRXo2eE5WaDAvMHBXcDNyKzZ0VDlNS0UyUDZtNWZ2aEhYMlNIdEhq?=
 =?utf-8?B?NGxFVW5GSHIxNUgrb1hPZ2pEOGFlTG5GTjVsdk5Qa2VqT3pFK0daTDJPQVdV?=
 =?utf-8?B?T0dGMVlMZkl3TGxmV0taNjlTWThxbnRMd0FjTUFFYm9CRmtVaWxIM3dzWUFz?=
 =?utf-8?B?djhqZnRsVVpoaTVrZThFQTB5YlhEbGhZV3RBRGN5aDZCWEJVZzNGN0QvVndP?=
 =?utf-8?B?aEREMXBDMVZ3K3p6aCtRWmVWWU1lMTdrRjFpdlBlMXI3L2dKWkwrQkdhZWpz?=
 =?utf-8?B?bFlIZytqTUZYeUZhTVMyL2d3SDR5NFNVM09Wc3lPdWJGRnhkRXBjNUM4UU1L?=
 =?utf-8?B?SWk4czRaVWNhMUlDa2poeUxnSTAxSG8yTDgreWpFTm1vSDR6R1VpeDdZTDMw?=
 =?utf-8?B?V09ySGRESU9uSEpxSFFKQ0xlQUZNckJ4ZktjRUJQNHNpTzhXQXNKWGpFaitE?=
 =?utf-8?B?VllQQlJDcGNoNFNuczgwTWNKdVhTcjY1eGpiYlZIOWh0aUMvUzA4WXc0TE9X?=
 =?utf-8?B?dFZ2dDZscUVncjBTVEVzRzJ3dTZoTnRieVJPeGlaWGNFK0ltZ0FFcDh4S282?=
 =?utf-8?B?ZE4vZkFSVHFKdGZTaG1pQzFCMHhXbEVJeDNlc3FUL2dyUE5VcmdXaGtwVm1X?=
 =?utf-8?B?U3ZXV2R1UkJ3MThsTzVPRDAzRlo2U09OUmFGWVcxWWlxeXpOdFZldmNlMHI0?=
 =?utf-8?B?YjlmbHgvSHc0U1R4SkVQYWZ5MllOeGx1cnQzczd6ZGNhSnU2NXVwaGNZQjlG?=
 =?utf-8?B?cjZWQmZTVzZFTVlKdGVQQ05MNFVDa1NyZ0RPbTBScjhJSGdVSHJpcmorZTAw?=
 =?utf-8?B?OW5KQTJVT0RZL2ZKajJWUUtLQW9OQjBtSC8rdlVhQkZBMTYxWDBrak1mZVRx?=
 =?utf-8?B?T01kTEk4M0c3UU1JTEhXVlc4NWZOYlJBR2JtZUdXK244bFFiNmNzVm44OXhR?=
 =?utf-8?B?UTA3ckMyZUk1VFhqTUdLOFhscE5oRk9YYm90RmFQSmU1Tnp5d0FvUzBtUmVG?=
 =?utf-8?B?elI3L3BUcUpwUmtYRFZOY3VIRkY2UFJqMTMxc0Y5V1lVU0tjb0l4bXpuN1ps?=
 =?utf-8?B?ZklGVVlRbkNGMkxuNXBOcHhZeDBMb2RVUjBONHJrRGxIUTFrWG1tT01wMWxw?=
 =?utf-8?B?cXJsN1gxR1E3RTBaMVkxSWpOZ3EwOVQya1BZTkVtZzB2a2p1TEdxYWNsRUlQ?=
 =?utf-8?B?WE9jTWF4OUcrdm05d1R1eDdScDJIV1BSR0NCaUI1bVFoRG42dExaL2huTGJm?=
 =?utf-8?B?cjluaWw4RmNmVmlNMktHNDhaOUxnK3c1U2VCYUNxMjhlSWkxSyt2eXhuOEgz?=
 =?utf-8?B?UWVtaTR4QWFsNFlQQ0pBZVZUS3JzalBvNUFEZ21ycWYxaGdnbFZQaHNQblRY?=
 =?utf-8?B?aDFpUWJZZ2F1VWxBT0NpSStBYjNpaC9kVUJNdmpxREE2NCs4ampNYjFTVGVO?=
 =?utf-8?B?cS9LaFQra0hzRkQvc0EySitiZG96azlOWWJBeDQ1YW5ZOS9hV1hqUEE5bXZ4?=
 =?utf-8?B?MVlyMVd4VjdRZTdTNkNCSGlxZ29ZYTFrd0tURGFSdHdJb3h0NWZwSXdKRDA0?=
 =?utf-8?B?VnRteE5RMDhMU3UrbTQzb0tLT0s3Y2hTZDMyZWNBZ2xZQ05qSHplcWlDU2E4?=
 =?utf-8?B?MHplcC9BV2RLVmxqUnZMQnBhZHlDVlBDYmEvUjNRVjJoYkdjNUZCaWsvRXdi?=
 =?utf-8?B?RXF3THRGbjdlM1JQYnpRY29HV1BUbWRWMDRhdlorL2pMbHVXYzJ0Qlc2cE9X?=
 =?utf-8?B?VEF5KzZETEIrVERkMEtPaXFzbVQweStNazhPTWRXQnd4bGRTcWpPSTJXZ3F3?=
 =?utf-8?B?OGVZenl0V3JmRUNUN3dQT0FIOWZpM3gxb2ZUck5rM1FpR0g0NGRnT3F5U0ds?=
 =?utf-8?B?ckVZQldFTnNPOTY1bXBSTEpTUEpMaCtwYXpqeFNoS3ZTMy9GWjNzVGxDaUpM?=
 =?utf-8?B?ck9SL29RUU1kblhONTUvYVRTb2loWEluYzNMMTJYL05DOVJ2NkgrZUx0WGY2?=
 =?utf-8?B?TXRNd05UU3NrOTdLOEUzS3RMNGpUNGVMSm9lS0VINzNQL2c0ckthZndSN253?=
 =?utf-8?Q?lWAwjjm8kDrAchj8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a03201a-dbd7-4ab0-fb83-08da10b7f872
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 12:39:16.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKFEVSkgrk2KKcySZewJ4p5Yqg02C4eXgH3wvaZ3ohbdmXM82xOeC7Zmzbk7SR/YnVQf65tcfBZk83rCdnfalWTvFbaGnM2uAfkYbRdeUpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1885
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/2022 6:47 AM, Thomas Gleixner wrote:
> 
> It builds, boots on host and guest, but is not yet extensively tested.
> Testing with a AMX + PASID enabled machine has not been done at all as I
> don't have easy access to such a beast.

The AMX tests [1][2] went well on both host and guest. Also dmesg logs 
look to be okay:

On host,

$ sudo dmesg | grep fpu
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys 
User registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x400: 'PASID state'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile config'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: xstate_offset[10]: 2440, xstate_sizes[10]:    8
[    0.000000] x86/fpu: xstate_offset[17]: 2496, xstate_sizes[17]:   64
[    0.000000] x86/fpu: xstate_offset[18]: 2560, xstate_sizes[18]: 8192
[    0.000000] x86/fpu: Enabled xstate features 0x606e7, context size is 
10752 bytes, using 'compacted' format.

On guest,
(AMX is available with the upstream Qemu [3].)

$ sudo dmesg | grep fpu
...
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys 
User registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x20000: 'AMX Tile config'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x40000: 'AMX Tile data'
...
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: xstate_offset[17]: 2496, xstate_sizes[17]:   64
[    0.000000] x86/fpu: xstate_offset[18]: 2560, xstate_sizes[18]: 8192
[    0.000000] x86/fpu: Enabled xstate features 0x602e7, context size is 
10752 bytes, using 'compacted' format.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/tools/testing/selftests/x86/amx.c?h=x86/fpu
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/tools/testing/selftests/kvm/x86_64/amx_test.c?h=x86/fpu
[3] 
https://git.qemu.org/?p=qemu.git;a=commit;h=3d31fe4d662f13c70eb7e87f29513623ccd76322
