Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6926952AA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiEQSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351905AbiEQSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:10:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B07114F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652811048; x=1684347048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P7BXPA0f3+5tPd+PQcW2YgvkokoMHlIc+c/6yHTqzyg=;
  b=j/RBWWsGs5kADaxl+HToBIvlXm0mKfTfmO009ZxCPaaUH5FMdYrwfeOp
   PdYZfHsDz2ka5C1IKFrkY/hyXUJqTU7mJQr5ZYHdNve9fECkAhzFEOTvo
   7YmazFFNG//dJFGa1aJQYJTOSfJbed4V0k/ti7xut3QZqRUm55KmF+lKl
   +PYk4Y2yRcswPAT6d3tPBBa/tBeL47ciYcuIU3BcWIHJBsEnya7o/iM3q
   9FGGnNrlGnc/fDP8+poIHIj7oX7JnI7Y9SJrBOPoBrgmAnWmnxwHn/RN7
   uXBqQCY4jwHxk3fNfwwl9ScbpAt7IpauMSIVwR9kDHBCdn3PCjn6N+HJ7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357684373"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="357684373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597273775"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2022 11:10:48 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 11:10:47 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 11:10:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 11:10:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 11:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT92oaiOE0SVazROGcYyjpFiBO17MiRT263MXwUmvJoAbof/qeFZEn9TzykQpFKCD231VV+lAD7ID6OdjKb4nfYAcf2HI1Am4So1IdnFN0xLXi6UyTD2V3My+eUXrcONGnu5jkPbIUMtLtGxabPKUOp6LZRoNqd53IlQ7O+YSVvwEVJfLYA8X5R6szDAJFnmv6bVidhGifXinGKcLP2yxJsMqpc0sK8E/zWGY3sGIqNREnvmiv8hwOufNXQaTkXbFrCRdyAK/SbvSaYYG+5XHhqiQkjBoFMhfEn6hpkcnEA/U9MXGvdmABaUE1vBd28kYVMroyjAS5rpAEc8C5NEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyQItmFqG6dxm3fWK6CNOCgXvIAS7mk8qhuPy62IO8k=;
 b=Q9QFFZ/AclzM5jxPYlSG1C2BfOfxi+xpMCCcn5+D4tbWXh2pqsvCT070aVcKZKpZgOj+/UP99WE+45m6vcg3B6ib7MxjOph+8dPYrC4kOspX5QZ64hjAsOD5TjIQt8+J1gfETbITv0WCc1Aj9lPKIkHvk1b5u4ePtnGIhA1D5PdYE4ehkN3lvdngPs7M2jncRkBo7Pu4YXmQV2jxCnSvieKy5o/n7R/0RxEimpN9iOWJDuCVTzhzYThQ9xNWXrSC93NS3u+q5CFT0PceO4Pcisj9rImD3QRt3sdNc/qktbRgDQLL+f26t8VnGaMRauIxVNXL5/6AjSiS9CrNgC2F+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 17 May
 2022 18:10:44 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:10:44 +0000
Message-ID: <0077efdf-ab64-2924-c290-cd940977b818@intel.com>
Date:   Tue, 17 May 2022 11:10:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v2] x86/resctrl: Fix zero cbm for AMD in cbm_validate
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     Stephane Eranian <eranian@google.com>,
        <linux-kernel@vger.kernel.org>, <babu.moger@amd.com>,
        <x86@kernel.org>
References: <20220517001234.3137157-1-eranian@google.com>
 <YoPOWC0waMuSlvI6@fyu1.sc.intel.com>
 <5a634c10-103e-6f3e-e51b-db26b2bc90a5@intel.com>
 <YoPa5L2jNYl/sFhw@fyu1.sc.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YoPa5L2jNYl/sFhw@fyu1.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a69200-c183-4425-a3da-08da38308f25
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5200:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB52000E951C9CEB9F0341BADBF8CE9@SJ0PR11MB5200.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQcGKkS1RcqrzEWmYszdNnmM5TrVmMDp1YdWq9cffmBHdC00hu9CJy1KRoTf7bPowFDFu9rBqfrTUS4q59Y6Ik5SEs1aQGfmlcHRMdScufLxQEneXQjHZ4Dv4eUfKqL0ovRLYYL+rla8klLi/E28N3gvDZ8qdn0PM7S30ZSbLXajteNZM5BGPdbtOUihYrFMJu5JoF49aUmMPqBWG/+9w5oPU9uvCwtBOFbhZFMS+f2k4eGp6QVx02umRFqes/HIUUUBaT1ziAsYJm4PsOQCX1FONKp42CyE4XEbnx8e2vfF48jtxkMNIAEyBdIpGZX6dLjzbJBZUbRj3XclKdf+6xnA8LJY7Ot3wv5kZ+DhUDPtf8863t0zg3VhLu3Afwd21eduorCrVz0ZD5Nb8Q3mMfjLAnXdfd+01s05Sy47OisXDFHASWJkxuDFTUJ/L4ovhSaCZk0S7DDe4EjXXvtSF2Yg6QSuJ+DhqJaqxQ3LdNsXl9sDqlcDqcI3Wq/UoeQVdl+q5afDtVYLcK1z3xRDpGvWybUrmzXMnilZSTgbB4xBcAa8SaVmEy+K1aBFoFTZVI2uDXkx5xQDfAYkOLUCtuIgJxDZsIsRUqQE4JGnImEPYzbOK7ujJRqiZg/MYMk9HSOsY1YD5IUnmPfXLTl3OGi4UhJB2h8H9rxiCRwzolyKKTmo9ypXieAKRbaoZSfOl21/sMw9gfAY4P7cwtiIkgIjMY+i4e/knZIHIqk8Rkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(37006003)(82960400001)(36756003)(2906002)(5660300002)(66476007)(6862004)(6666004)(8676002)(6486002)(86362001)(4326008)(6512007)(6506007)(26005)(44832011)(6636002)(8936002)(31696002)(66556008)(316002)(31686004)(38100700002)(53546011)(66946007)(83380400001)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z21WclhsSzZXcElHT0V4WHZaTjg3VUEzZWxNKytBKzlySU1SaHkzOUtyYzVn?=
 =?utf-8?B?bGJZc0pVZVNhWHo0M3lHWG5FVEVJc2tZWUlRQ3JGUGNKUGdFNWFoM1VqRTJH?=
 =?utf-8?B?MlFZREhlblVoN0Eza2JRQ0g3ZnVVM2RMZnZxUDBpcXU3bDIxSzVmTW02M0JZ?=
 =?utf-8?B?RHBBNGRiL0p2U21FOFdPUEV4VFcxNUQwYXpVMnA1SDNNUHZDQ09ZMlo5NEE5?=
 =?utf-8?B?dnBEWUM2bmY4Si9UdzN1R1lmamNsc2ZCZFRyL1RCTUE5bUEvOHNGYjNVczY0?=
 =?utf-8?B?b3EyL3FZaFZESFAzdER2S1RndWNFYmxNV2J1M3ZEdFNCV2tVUVRXTW5FekZt?=
 =?utf-8?B?clJ0cFJUNTc1dS9IUDZoZXRKekUzUEFocnhzOCtCbjZWc1lETlk3Qi8vYWk0?=
 =?utf-8?B?eWlkdVVCdVFTditpLyt6My95ZWxtY2c0RkhWNytYNy9Wem50R0pwZ0RVbnNB?=
 =?utf-8?B?aTZaNVd5cTF2RGVHRjF2KzVMMG1uSlhqcVpON3IzN3hvaUpvVVZUaThqK2t5?=
 =?utf-8?B?UitubVFVUVRza0dCM0xVQ2lKc01SZjI2TU0wNE5Yb3hUdFFOM0xoZjFORnM1?=
 =?utf-8?B?cmt1UmFRVHQ1emc3Q2czbmMzNWZtZjdiTldLTG9BY2tEdDdmSDFDcElqKzRs?=
 =?utf-8?B?bmRlSXA4cUFZNVl4TXFSazUyRDR1cDBwTG1UN1kyd1hYNWF4Q2ZuWU1mWHZk?=
 =?utf-8?B?ZVgzRnV4cXNPNG8rRnB6THBnNGtCaXZudk9NQ24vdGlkZVZIOXdhWGMvME5G?=
 =?utf-8?B?K1c2K0drNG4vUU5nS0pIeWo5RGhNVmFtNzRSWmk2dzIyL1JVS2wvZ2ZyZ0ha?=
 =?utf-8?B?bXVSNGwremp4clJyeDJpc2ZYa29Gakc3eGdPaFdrdGJ1SDFiNU8vSG5aTXNx?=
 =?utf-8?B?aFJWMmVRbFkrVm1uR2hXL2NnK2trRGNvQ0NHYnpnUFpPUzY1WWtUNjd1Unpp?=
 =?utf-8?B?bFNnR2E5ZGZwTFQrSnNJQTY5RFNhOE9jdUI2L1Z4NkhTSlV1eFQ1Q2NTYzEv?=
 =?utf-8?B?RE1KNTI3ZG5tVERtMldWL2R1ckwvRm1MK2NvVFUxanUrNEtBMkViSkV6OHd4?=
 =?utf-8?B?eWNBMGtmUS92QmVzdzFhWHRZMDFEWEkzd3Ura0s3eStsaGdJdkpoTGs2TXVS?=
 =?utf-8?B?ZzhzaXVUZkRvRFlNa0kzcVNUcy9lUnNkZVBORlFmL2dsTUwxbUJkMXNQY0hk?=
 =?utf-8?B?TkVuZEo0SitLNUEyR2NXUUZmZk1haVg0cXZzVEdOTDBPQzUzQnlxVjBma0ZI?=
 =?utf-8?B?MXozLzBsY2p3OEFweTBocXByZk1sODd2cGJraHRkejJXMEdseUpXd2k0YUlh?=
 =?utf-8?B?MWZmN2NLQkh1SU5kQ2pmNHJ3SEgwb1NMcjZ6WHRMN3kxZTlkeHY2MHJUNUFB?=
 =?utf-8?B?TjhEem5CSWhjK2NKeW13U1JNeDRNb3JxYWw5b1JKVzJnQ1dSZlY4QmQyb0pP?=
 =?utf-8?B?L2EyeTlwRTE3ZC9QdDd2VGc4TTNtb292QW9Bc0ZzdzVrTXFva1VpRjNTSEZm?=
 =?utf-8?B?Ri9TYTRKenhReDhtNTdkRVZnVUVYSlVBTFkxSGN4WDBvbllOVzRhTXZMMUtn?=
 =?utf-8?B?U0NEYmE4Z3lUcnBIMGtTZDM5L3p4L1FIZGxORFlaYUxwVC96UzFZMXZwR3U0?=
 =?utf-8?B?Y0dkSzVWSHhMYXBVQllPamhKcGxTQVBseFBRMXNrTnBpNm90c2V3Vk9yRkVZ?=
 =?utf-8?B?Z3dXMkRBM2JoV3pTTUxlREpSZ3V5Qmc3WVVmUFc5Z1o4WHN3UEJ4RWlMS2FP?=
 =?utf-8?B?elZvV1N1K1lJS2ZDY05jOTJRMmo5anBKY2pBeHhOMUJacUROK3VRMUZQdE44?=
 =?utf-8?B?RFJjUEdZeXhBRVZEeCtHVWJPRHBFLzc4OG9Yczk4c1JhdTJxR2FIZDR5Kyty?=
 =?utf-8?B?MEdveFVxd2tqVUdadkQwRllSeEIwTXFQVHRYRkh2RkJSYlBwSjBhS1ZyZ3ZB?=
 =?utf-8?B?VHhseDhleE41SmNTVGwwamdGY0FzbWNtT0MyeFFFOFh5bndRNkJ5c0RxMnA3?=
 =?utf-8?B?T3pDalFGVDc4Q2d2d3hDUm5JRzIrY0RHNytlUjlkU1lhcnl5ZHZJMFo3STJk?=
 =?utf-8?B?WjEwV0ZzZ3NHaUtiZTNaMEk5akZhenBabzBsMENabGRKMEVMai93UVdBM1Ux?=
 =?utf-8?B?YVZ1TXRSUTBHcGI3R0w4Z1dleW44aTAvamR5bEJZSW10L1VyY0pQZi9Gc0JH?=
 =?utf-8?B?a1FJTVpRalhkei9nY2pwNFhoTjh0bVIwOVQzclljUk5ZVDlRZlJpRG55U0Jj?=
 =?utf-8?B?aDdGYXR1YXM4WUJlNTdXV0lhaWFUQ1c0bnkwSllmdDhwTFpVa0JUZHZpNUdq?=
 =?utf-8?B?anR6REtTck9PbURtcWdGS21oQU1sdk9YdjFGV3ppMFlGVlk1cGRSSjRtV1BL?=
 =?utf-8?Q?cPhSYni2AFnT6vRc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a69200-c183-4425-a3da-08da38308f25
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:10:43.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPxEuV6FTfjqamAD5HIpxl+tpoPGnNRdt1NWpEHdUpcWWobeakMWp4jw8b9sN6wnZqk36dpEgYkD148sMV0FI35uDM2To49+Obq0myuZ8Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 5/17/2022 10:27 AM, Fenghua Yu wrote:
> Hi, Reinette,
> 
> On Tue, May 17, 2022 at 09:49:22AM -0700, Reinette Chatre wrote:
>> Hi Fenghua,
>>
>> On 5/17/2022 9:33 AM, Fenghua Yu wrote:
>>> Hi, Eranian,
>>>
>>> On Mon, May 16, 2022 at 05:12:34PM -0700, Stephane Eranian wrote:
>>>> AMD supports cbm with no bits set as reflected in rdt_init_res_defs_amd() by:
>>> ...
>>>> @@ -107,6 +107,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>>>  	first_bit = find_first_bit(&val, cbm_len);
>>>>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>>>>  
>>>> +	/* no need to check bits if arch supports no bits set */
>>>> +	if (r->cache.arch_has_empty_bitmaps && val == 0)
>>>> +		goto done;
>>>> +
>>>>  	/* Are non-contiguous bitmaps allowed? */
>>>>  	if (!r->cache.arch_has_sparse_bitmaps &&
>>>>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>>>> @@ -119,7 +123,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>>>  				    r->cache.min_cbm_bits);
>>>>  		return false;
>>>>  	}
>>>> -
>>>> +done:
>>>>  	*data = val;
>>>>  	return true;
>>>>  }
>>>
>>> Isn't it AMD supports 0 minimal CBM bits? Then should set its min_cbm_bits as 0.
>>> Is the following patch a better fix? I don't have AMD machine and cannot
>>> test the patch.
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 6055d05af4cc..031d77dd982d 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -909,6 +909,7 @@ static __init void rdt_init_res_defs_amd(void)
>>>  			r->cache.arch_has_sparse_bitmaps = true;
>>>  			r->cache.arch_has_empty_bitmaps = true;
>>>  			r->cache.arch_has_per_cpu_cfg = true;
>>> +			r->cache.min_cbm_bits = 0;
>>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>>  			hw_res->msr_update = mba_wrmsr_amd;
>>
>> That is actually what Stephane's V1 [1] did and I proposed that
>> he fixes it with (almost) what he has in V2 (I think the check
>> can be moved earlier before any bits are searched for).
>>
>> The reasons why I proposed this change are:
>> - min_cbm_bits is a value that is exposed to user space and from the
>>   time AMD was supported this has always been 1 for those systems. I
>>   do not know how user space uses this value and unless I can be certain
>>   making this 0 will not affect user space I would prefer not to
>>   make such a change.
> 
> But a user visible mismatch is created by the V2 patch:

No. V2 does not create a user visible change, it restores original behavior.

> User queries min_cbm_bits and finds it is 1 but turns out 0 can be written
> to the schemata.
> 
> Is it an acceptable behavior? Shouldn't user read right min_cbm_bits (0)
> on AMD?

Original AMD enabling set min_cbm_bits as 1 while also supporting 0 to
be written to schemata file. Supporting 0 to be written to schemata file
was unintentionally broken during one of the MPAM prep patches. This
patch fixes that.

You are proposing a change to original AMD support that impacts user
space API while I find fixing to restore original behavior to
be the safest option. Perhaps Babu could pick the preferred solution
and I would step aside if you prefer to go with (an improved) V1.

Reinette
