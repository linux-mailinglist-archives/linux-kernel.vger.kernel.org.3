Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835A4C9A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiCBA7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiCBA7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:59:15 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB84F9F6DB;
        Tue,  1 Mar 2022 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646182711; x=1677718711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CCvMqPWupzB1+YY56gXppL744u1cGc1HZEwatUcX3Ag=;
  b=XyPSFCqsOHbMK9cxV3s+VxT4/NHm38PLlCnxNSazIvDEF5AUfJMn1WN6
   4ql7OiIyLZhqA2AaCGAulrBsO48dZp0cQAkX1Rbpd+BsAColVJYEcJS3e
   vGvKDUEcgiRz5cveDpS2xNv7u3F9Sd84/xuFFPwAzJvOU9PeBvKRmspbr
   xxfNhHZYUYb9RCRzGUjOrkvyVTDmHIslQntHfkwvXLdrnN/FcbL2HKbny
   gpxn5PRRkHbSDYn3+Mevow0hCzl/9Qbfu7F0P8hv1BLUWSz08gs7EmSrP
   5CH0Sqx8sMxtx/3j/X1BZ6tW1ZDHF3ubhSP4MZgViKRUHcbGEyuwDT8Uw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="313998325"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="313998325"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:58:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="778672737"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2022 16:58:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 16:58:30 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 16:58:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 16:58:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 16:58:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3r3ktSt7CQMHcNjxoKWvZ1pPRzyl6A3rnPILmuC+qmSqTK8qfIr/ByNSBGjGHrnm0jY9NiHqib6zLkbNws3dvt5z3e5nwW+kz3c/lBy1Avvg66UwCa3Z11bUeaIJtG8StZaO5XcERpssadMy2e7RycqyQ66LwkEeLQG4Q8RvnTTcmKJmlHsjKGxTDEVPP8upDNYZuIly8l1XOIr3pKX7TcNuQsuoN+LO1A0/8vZwH4YeKe2pitxwdyS3fZ6BcICKPttsK2IWJCKQ3l1KflOfMwp01FR4b+R4F4LxUoVom1ZSuGmZO+VgRCXxC813+zQ/CW9phWDI5CZq5kdibgBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoniuqnFDfeZYdM5yzmCTNVcIWn9DL6lQX8Is+ZekL0=;
 b=U7fAQweiC2PiKpGh5LdaIrJE0u5ipE9XT7AbQ2pN5Jke7IFp11BdYlbSgNI57M9srNPHOht1TGPv1E/b+lULG+3ToQwG8d06LCr6pJ1gpfOkh7BeIACCuIJ2Yen9EDygK9Hx8Lb/lQGwxWM0Q5yJooD34NORmk6KOhweGQxMWb6lSiMF1ev7vb9oiQqZuVJ6WiYuFPU4WfPrTsNxvcnvv9o44eH6mVoitKghThxlD6acC0E57Z3/4jXaX7Bf2sC58wau1JPYuc+QYhVKREsM/ucDG8h4Td9VijoeubAdbpiwBrsL3zITUYOik/GOS5OgRTng9492o0T9jObjpc0LdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MWHPR11MB2064.namprd11.prod.outlook.com (2603:10b6:300:27::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 2 Mar
 2022 00:58:28 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 00:58:28 +0000
Message-ID: <9be987f0-b7c0-7419-1c22-1c43d4ba0013@intel.com>
Date:   Tue, 1 Mar 2022 16:58:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 02/10] Documentation: In-Field Scan
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <andriy.shevchenko@linux.intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <patches@lists.linux.dev>, <ravi.v.shankar@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-3-jithu.joseph@intel.com> <Yh59BT1O0Bw+mCAO@kroah.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Yh59BT1O0Bw+mCAO@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:301:4c::11) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e00425-3284-4d8f-33a8-08d9fbe7c334
X-MS-TrafficTypeDiagnostic: MWHPR11MB2064:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB20640C7D5CBDA6A05D2AE71D80039@MWHPR11MB2064.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuJ1tz4V+JToZcdiOinyJ2BopOj2aGZsStn/p+HIgwi6IIuv3tWFONDJ5NwiqeY+cFdhfBHJPE3a82Y61G6raQHeAnqc2ZB3HXzgkhR32JHdlcSkdFwsKFg+6/C5JqdvL1AlQYZQMtkv2lka2tGpPE1ZwCqcrgJOHy208tOwzvXDzyPSnPl5s1zmxfOJiOkMwld2OR/hdALRz/lh/9tq3VvZHvoyc4yjEDnAum0ysW3SuuNQWuuKPAJlL2ys4diQdshGK21qkfwfctllOJAVtRqnujec3oXADDYIka2aWkGq+0+kgpcIROHIkoVBDUL84MA3V6Kw/cm+Z+mRmL72RQ9tb2gwpp54R3jaJMNPey1rbhONHtB/yl5Tngbcg7LGFG8b0SAeXbNEgZ2Dak3Nw6XumTTJNT7IJud2j9OCQTvbRzaLtYV7DCkPxkN6JWcy5bcKrAirZhBsN/atzCbhQFTc/3hdfSahb0xj1t8Az2TDiNGPD85hegiflCGy4awK2wErVTkR8u+u5daGOwoNFQuqtGsFNub45PjjFAGLJdIoi+2AxxV59bTS7I13I7MJ++P6mO4iTYIfNeeMcyMSMrOMjVuJflcFcoE+VJoZ/l3MZTENsAWg9gBgx4sDbNmml0Gi20eXzq0VCM8a6QuflbUzdrmXX08N9+DwX+PBHon11f61587okaawgKc40Vxf3Oi3A9GnvHOMWXpwfvAEBaox4g3EtN8Tk87Qe+Bm9EjIrVL/nxwPUbi1izaXe0qI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(8676002)(66476007)(31686004)(6486002)(8936002)(508600001)(4326008)(316002)(6666004)(6916009)(31696002)(36756003)(6506007)(53546011)(38100700002)(82960400001)(5660300002)(7416002)(6512007)(4744005)(86362001)(2616005)(186003)(26005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RElKT2UyMDBhcUtoNC9Ec2Z3ZEVpdENZZXo0RllWZHZ3MlUxTlJpaENHYVVm?=
 =?utf-8?B?anB4VS9IclI3dUZXa2FVNFJoaXFCOUR6YVlzSUxuT3RJS3lCVFZkbyswRkE5?=
 =?utf-8?B?c2dwMDA0U2pMV3FnYXo3K3JjaWtMZWlDYjVPb0ZLSzBkejBjd0VEVzlxU0hJ?=
 =?utf-8?B?UVBIT1BhQ3h4NGwxTCtmM1J3NU9laTZDMVgrQ04ydzFpeTJ6S2p3c3pMNmpt?=
 =?utf-8?B?NXZzN1Y0aWpTeTVadUZVSzNNWXIyemNoK0lLWXRwSVBDcXVuY1NlM2hrRVF2?=
 =?utf-8?B?aGQ1T2N5YkZ5cWdrbEwvK1BHZWFGTHY3WTZmSTN1ZTZTV3IweW9QRzRuakhO?=
 =?utf-8?B?cHBSaTFPTEovTVYxNnFZaTl1dnJ6czROY2RudWNtYmp5QWh1RHNiY1JscjI3?=
 =?utf-8?B?UzJZMDdjaDIzajB4NUYwL1pMUWFXbFEyZ2N4elhVRmF0bFBFMEhKUU5JRFFm?=
 =?utf-8?B?TEl5R2diMDYyWW1LRm9oZWd5dnkzVHM5RnpveUhQYTFIS0hIeGJoMlJoQUUw?=
 =?utf-8?B?dUVwQytueDc2cmJxWmcrZ3JPSkRtWnRielpyWkp4SXBXeGlCS0NWWmJwZkNk?=
 =?utf-8?B?N3dqZWxwVU9MazJoUXY1RDY3a0xGRFBzcUdweEdVVnpMcDlkRDd1Z21oRDRv?=
 =?utf-8?B?cWo1bFVtNWZzR2t4czhYZjdyNDM2R0RITzhzVkRVNDRDVTdpUnVCdHZCRG9J?=
 =?utf-8?B?djZMWTFMbmZyWDJMb25YSjlLa3ZpMHVUSURYQWVoZlJndE15aFh0K2N1MDhn?=
 =?utf-8?B?WGZMZ2JCSFpPWFNhQ0pwZms1MURObzJybEV5Y1hXdHMybGg5V3RMT1VyaUN3?=
 =?utf-8?B?YVZEYTVOMUJVL0pzTzBxTkZZbWJ4Yk9HYmFDUEpkUmNZQnhrbFlocGxuYVJy?=
 =?utf-8?B?UGZSMWh2YWovNlZpNnViMlJ2OVc3UnV0YUp3akprVEgzK3I4aytqSXR1K0hI?=
 =?utf-8?B?dHhzV3FJVS8vQ3dsa05jc2s0a0p1RHRYejl3a2EvbExybmt0NXhPOVVTV2Fn?=
 =?utf-8?B?K1NBdm1aMEVsNFA1eFNXTzNvRHVadWhrazFFVzhhT3l5WUVMczVrMlM5eTBV?=
 =?utf-8?B?RHU0cFZ4VTZYYlpLK0MwOElPczBodCtNVWlTNUxiSUhra25IODlKeVlsVVZM?=
 =?utf-8?B?bWJRcUFzQWNrczAzeVhnazlXa3JGR2ZZMjA5UWFWajhPNXdnTmEzdkgvRXV6?=
 =?utf-8?B?YU1GWjEybFF2L0pSV0YzOUxPUlFnYTNRU1llV1ZJb2s2eHJaZDZkbmxFZTBi?=
 =?utf-8?B?amYvSm93azQ0QVZhYkRUc2tPN3lZRjVVdlBkS2lFa21YbjA4SWYxK2xKY2c4?=
 =?utf-8?B?cXBwZmx4N3VBbFY2czhUNjNyQlNyNjNyM29EYnhvR2V3b0pXdFBha25sZ0Yy?=
 =?utf-8?B?eUhVbHZOTGNBR2lFUVlUd2d5dzg5Z1M5Z2lrU3Bqd0VUR3pMbWJ1K2VqOUI0?=
 =?utf-8?B?UUhyVU5ZaWN3bG43eW1tZlNKUUJ2NzJlTGk0MFJDa3Z6bndrakxDczA2dkhQ?=
 =?utf-8?B?V1QxU1pnRktTYWhFcDJEVWs4MlNZYXp6azdkcDNtNmZSaDJDT3lKU2ZMMU55?=
 =?utf-8?B?cU1Wc0pRdEt6Wjg1NnlwL21wUmZQVTlKZkJIMjN3NmRueGE4aEVvYzJRbkJS?=
 =?utf-8?B?Tkx0S2NLaTFSbldLTGU4UFFUYVpVWkVUbWNPbkcxbkhzTXpJQnpaV3p4Nkly?=
 =?utf-8?B?TEhoREtUWE1wdSsxaGtkUEYzTGtyRHdCVUMzSkN4VjFZdnlXc3I0VzdsNWJy?=
 =?utf-8?B?VkxHUVVkYjZ5L0hITlVhblpTY0xCQTgwSjdHbCtCSGNPUlM2ejBDbGRmR205?=
 =?utf-8?B?K1FycVZkTGs0NVlScHkrL0FHYTN4N3YraGdLMDJQVzQzQmw3a0R2ZTdUSExx?=
 =?utf-8?B?dDhSeHFKanhaN0hxSmlJM3RPZ1NBRDhXbEg1cXdYK1I4R0ZRWXZwMHNZQnU2?=
 =?utf-8?B?VU9LdU5PQjcvM3NiNzNQSGlSTTZXQmY0a0xsYkVkamp1OS9sZ29NUVVOcGJI?=
 =?utf-8?B?d3FRVWFZTHhnSCtHQXVTQnVId2REQjNPY0s2SDBVV0xSVFE4Unp5blZOdUZ1?=
 =?utf-8?B?bTV1dE9KUHBsRFI1TEQwMVpjNXNOUzJGUVhsYTBTQUE4cU1RbWpkQ0x2YVhi?=
 =?utf-8?B?WFlwdGRHNmR4bGVGTXFkYnZncFlNeHpRcWRoUWMwRDB6NEU4Um0ySTRjclBT?=
 =?utf-8?Q?sS7x/R0nKRHSbtuOV9Kv1B0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e00425-3284-4d8f-33a8-08d9fbe7c334
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 00:58:28.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAr9RiDyxmcXWY8M5qEvNRzTJM/Q7CCLoDalNa5d9UtFiPtOKqedihLU4NogFduS9MHe6QaPQCTad6TO+vDlbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2022 12:07 PM, Greg KH wrote:
> On Tue, Mar 01, 2022 at 11:54:49AM -0800, Jithu Joseph wrote:
>> From: Tony Luck <tony.luck@intel.com>
>>
>> Add documentation for In-Field Scan (IFS). This documentation
>> describes the basics of IFS, the loading IFS image, chunk
>> authentication, running scan and how to check result via sysfs
>> as well as tunable parameters.
>>
>> The CORE_CAPABILITIES MSR enumerates whether IFS is supported.
>>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> You did not sign off on this, yet you are forwarding it on for
> acceptance.  You all know this is not ok, it shouldn't be up to me to
> remind you of the rules of the DCO :(

Sorry for the mistake. Will take care not to repeat it.


