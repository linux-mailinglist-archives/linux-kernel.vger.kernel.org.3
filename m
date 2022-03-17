Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F14DD086
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiCQWJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiCQWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:09:37 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEF36150;
        Thu, 17 Mar 2022 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647554899; x=1679090899;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Xq9jajj5taeYSI/mpK/QoZTD2Cu0IzNWRZrHT3wTBI=;
  b=Q6z+Mh/iV8dQZhrId6yabvrhIUvTq6a5B+81yWoahkHtds+sO14mtBvM
   QKb5Rvy6gzToetGqPqKKbKtEMyTnU0LSLP88zhOwNks3eFKZqiwhLPbfz
   IxWRbPUNlogTppqKBECyCWXUILeg8d4E6PakJGK/i1BKqv5Rlzs5leii/
   7YimOZyyvRVydq01hoAm1+XR5RuNO4Po8Qugks+5jGOO6yNSUFKWbAuPi
   Z437M8tWhQc+pz6jRqSIQ2dAgfMcUWaHgyzEgB7uQEYAyYmU1YBa8ZF6u
   wiAxBYl0SHLVrnv5W0SjwjwTYPHylV8xl0TJF5egd7c/3C8vMonmNXVDu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317711383"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="317711383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 15:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="599259161"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2022 15:08:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:08:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 15:08:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 15:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0tC7NJfDzyy6XWNF2iAQ+zI+QvrftE91ygtiDdo458qE6PabMbyLDoE1iaod/Lueb33Cuy32d+FSEB0fZL1QVorcm+sBFjE31nP2Oov3CHpiVKNAu2AJQtVc35j5z9RXQ5oALr3MVZS9gbJ/DLVR/qUzK1FaukE8OHNXHvVLm74jVTX6Pes6iaJVO0OmmXfhLuBWj3MFnei3rRqTrfZJEqEiiEMEflFUcYU/rVOuZ8QbBgusN6PtxI6U76BYQSPcdnl/Co+oK0ZX2xXJMf4KQlGagQowvnu6eC7xjWfYCug4milqc/3TvQ0g4FL7verV24fGSQ4WyqeZhHadeok+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHK1bIr6A5se0u9Jb4vu3Ge/kIiAZhxgIn28z4mA7IA=;
 b=f4v6IgjhrPGXxUjIJ7CrW91T/Gidpw/Ru0IUvXgQbIQ29equCg0qWlq507JUIPL8d7cnT3iCoxRAW5x7mRUCq/esZ6cAwav4XSU3OaQsDfSFwADgOXugccP12/8QTE5oFdHJtxcGBAhWw/4i9cVHUI4ACmHQKfE/yIlyoGtSU80fF6ZSezgtWqdc0Ap9+X99cNZ4HjRkW+7ogm+9jrdw+PIL8cKvIqIzpRtt1ySGvm7P+kICK++JX1NEH45cFSl2agOhdoWBbj1sOKRk7uh3Vwm16xExD3GOlkLE73Vu3PjuD7QmOpcpDwFrJvjf61y+QpoZ8NnD31/RO4l393GYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 22:08:10 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::ec9a:f02a:6fc1:c6c%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 22:08:10 +0000
Message-ID: <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com>
Date:   Thu, 17 Mar 2022 15:08:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com> <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com> <YjK5ZWJRQX+lyUxS@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YjK5ZWJRQX+lyUxS@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:300:93::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d017fb-0bb5-4390-fac9-08da08629f22
X-MS-TrafficTypeDiagnostic: DM6PR11MB4628:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB46281ED014115AA1E7B9DC87F8129@DM6PR11MB4628.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8g+t/mSqLVbfTX4Y4CNAbYmXXHJ9Y6fz4tRH+GwOPHwrZl/ZbpUXNPdT0xDbzo686uFRnQZ1ywwcJkrIU3f8qVn5zpNHM4odbN0iPalF9+DfVw9Z1kXTtHVc1PDwGfqRoCLw+PwGr1ufOPSe8HxvT0y9cO7YSy0V0MzBW8EPxMU0DJgfj0d6FQ2U2IG0EPlh4N13oyK0rWDDi3Q1xpvJfj7/P52+F/81psvP+6q0/iLaWvmVOzfr7iOFmeZDbmTgegDEPOJ5VFcQKqfQHOoDU/KiMxVLLQO7VVC4ke5YmghSZsSdMXa65V8LhtBSDkniYmCYWryGCkbKKhD0H/aeDgXvaCIPuOUHiVD3Ev5EjCWoxJC0oUqZMNQ+Zqxv7DYXRrE0yd6U9t/f9T05s7vHwKgLvdUU5UaNMAAd94A1L4pxsyWuxb7T26v8r4+U+S85NNtDX2iejsozLd5wV66OkOW0XvLoFzCebxA71oe3qA8UkyUhK6ZcGYaamqFrDs5Eb+4FMXnbuNN1SQc5ycwXb6tzMtGGoN2VXdCTit0hgtBR8aleno64AvwPHi1aMEXvhOJ/ueSAvnHnGfbWxafcXD6/4nxRnL3qCHlPqi+yH3tleH5pTtmde5qzXw5SXapDftQ9j8auuJG0d/FWih4K/8usi4hELCzNGFx0mdjfOF23a73g/WS9D2NekVuFJbQ5sj8tDhLYyiChDFEnWEgq6UgNs7NXEnzecakbu4svjuX+sQs1lmO6idEhkMaQNji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(8936002)(2906002)(26005)(36756003)(53546011)(38100700002)(316002)(186003)(31686004)(86362001)(6506007)(31696002)(83380400001)(6666004)(5660300002)(6916009)(7416002)(54906003)(82960400001)(4326008)(66556008)(66946007)(6486002)(66476007)(8676002)(44832011)(508600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG55MkRNUjN3cUVRM1N5V2dHRWVqZllwaDRiVVRQMm5SbDlFOExRV21FVEtn?=
 =?utf-8?B?NGVFSytXWE9naEVlZXhUK25xek1vcmdnTFhIenhDd2l6R3Z2R0VhQk9UcHVq?=
 =?utf-8?B?amlMM0hRVG52VUhDanI2UFhKVUZkL2tLS09xWTBBV1Y0aXBIZG1nUjVjVm5l?=
 =?utf-8?B?NW41MlpqNm5zWiszeiswWmlLYzVUZ1FETkZLempkMkgwdzZyVk9TSXFETi9O?=
 =?utf-8?B?bDJvZFhBalZUQkozSUwzTkowV0JoSWc0b1YwT2RoQkxzV2d0REZEUmxRRjc1?=
 =?utf-8?B?Nkd4elJaZUVzM2RPRVdDZWMveFVFYVQ3NFZFTUhuZ0Jua3FkZUZHVlRmYWY3?=
 =?utf-8?B?T0xsdE84QUNrOXEvTVlBTXpWQjVFL0x1WHcwSXBIMzF1Z2QwY1RaRnFZSklD?=
 =?utf-8?B?cWt4TEs0bEwzOUxIOEt4RGljVkZYSzNxbDljc05PMy92d1h6MkVTd1I3K043?=
 =?utf-8?B?K2taVHV0OU1ONm1GcHJ3ZytCa0JzY2JZSzByK0dYRll5ZGJLN0ZhNjRYekpj?=
 =?utf-8?B?VlFiSWVwcCtlOG9SdDF5bmJ3V0haQmRLS3hkQ1dkYllNMUJrVGNtN09FZnVz?=
 =?utf-8?B?N0ZXUjI5NTlUVEVNNzBXNmtJaUVNU1JWRHpVZkQxMVdZbmVQamlUK3ZKUFhn?=
 =?utf-8?B?dFdRUTdFL3BkdngvbVZjTHFWWmFrWjcwUjhTdTNoS0lTSmdleWxpZG03V2VM?=
 =?utf-8?B?SWhZdVorSXVMTktQcVZZdStOSHNhd3RKaHVxSTVHOFdvdXlQR08rN3Y1emNq?=
 =?utf-8?B?MG1SQ2Y2d3FWeUI5eVRFbkROTHRDNS9lcitxNEhIdk41aEh6L2pnU01YSTRs?=
 =?utf-8?B?U2sxQVN4V21ldDBXNmFDY2Vjcmdtd2p6cVhjYVRGZEF2RU1IQUR1V3VhSW9L?=
 =?utf-8?B?WlZrMVk5WENsb25pRUhPTEtOMzNhNnoyR25aZ0tWUDhmc0xVVlhNV3UrY3RV?=
 =?utf-8?B?dnhZNXNFUXBpejFGRU91aHdReStQdlRiWjZLK0lXQk8zbGlneWpzK214WEhT?=
 =?utf-8?B?SkxlamsrYVQ4bXZ1S3ZVRUEzcWh5QkNENk9XalBCN3kvZDc3dDh4RlJTd0Rx?=
 =?utf-8?B?QjVQaWNGVURRZFZtS1JWQ2ppbm1EcUw5b21nQVFJWXhIY1lFcjJKTFFoOTlK?=
 =?utf-8?B?WGp4emZ5N3ZUUWs2T3JpcEFlUml1WWcySFlmM2RpZzZyR05rT1dLd3BUOTdL?=
 =?utf-8?B?KytQN1dlVFJIQzY2NFEyc2pPYVNoekNwQ0xvdkQxQkRwYzhRQngzYjJkUEFj?=
 =?utf-8?B?QU51NTRsSnBRc0l1dFdtb044T3ppMmI0cHkrb0xCSk9ydlBZd0ZHT1lobXpt?=
 =?utf-8?B?cGoyQzZuRktvR0JRdmJsOEIwc01NZHVQUkhGTmR5M3ZQU1VDbWFjZXBRczVw?=
 =?utf-8?B?OGc3a29mNFZjNzZEc1pydjFzU1VscXBEdjkrUW12UkhDZUpKdmYySkNTQXBC?=
 =?utf-8?B?YUdFVHpZSlpZTGxLY25LYlJSRnEwK3JTRU9LSmNhQ2RCSDFKaFVrTjRZZTY3?=
 =?utf-8?B?SHhRRW9DUWNHVVpnTTdWZU5yYUtwK1RRbkxySFArUWlYcXRRc0p1c1VwR01C?=
 =?utf-8?B?bS9ISWcxcG85MUs1YVBCYzV6RC9jb3lvSlVWaVVlTEh0citLbWlDOEFKc2hU?=
 =?utf-8?B?bTBpd1hRdW11YXdBdS8wV0NydlFzWDJ6UDVnSDUwbkxveEdNT1k5UmpESjVS?=
 =?utf-8?B?SklPL1ZCT0tNRFNJV0QxUWdZS1gxdzdWekZHMDk5YkZicW1wSTVMemM4Yko0?=
 =?utf-8?B?Qm9NZ0JYa2o1c1ltUEFYTnJDWjZNdlBiZnhaKzZaVCtVU0FZVHpOcjFnWVVv?=
 =?utf-8?B?NUI3clNkSDFrKzlxZHd2TlF1ODgxVE44VnJNaVNzRkthbVd4K0pUSFBBSisz?=
 =?utf-8?B?MDR2WFhUY3U3dzNWdTRxRjdSejhKeVArQm5MaUsvUk5aazdyY0FsOGh6VXRF?=
 =?utf-8?B?eEdFaFVybGxJZ3BhWDJEaU53OS9FYmIrYXliRnkyR2dkVU9yZXdKNmg0cmRX?=
 =?utf-8?B?REMwZ05aNEFBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d017fb-0bb5-4390-fac9-08da08629f22
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 22:08:09.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvAtzBcdmr6tS4FZa5i2PFBEG9TZ3bFj/kDqWi1FjOKU6jmbXJYqk4aI5nJ7mDCC2aj4WyV5rDMnzYQy5OfTCAiQcvrVR+19QlFbHHQPAbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 3/16/2022 9:30 PM, Jarkko Sakkinen wrote:
> On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
>>> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
>>>> Supporting permission restriction in an ioctl() enables the runtime to manage
>>>> the enclave memory without needing to map it.
>>>
>>> Which is opposite what you do in EAUG. You can also augment pages without
>>> needing the map them. Sure you get that capability, but it is quite useless
>>> in practice.
>>>
>>>> I have considered the idea of supporting the permission restriction with
>>>> mprotect() but as you can see in this response I did not find it to be
>>>> practical.
>>>
>>> Where is it practical? What is your application? How is it practical to
>>> delegate the concurrency management of a split mprotect() to user space?
>>> How do we get rid off a useless up-call to the host?
>>>
>>
>> The email you responded to contained many obstacles against using mprotect()
>> but you chose to ignore them and snipped them all from your response. Could
>> you please address the issues instead of dismissing them? 
> 
> I did read the whole email but did not see anything that would make a case
> for fully exposed EMODPR, or having asymmetrical towards how EAUG works.

I believe that on its own each obstacle I shared with you is significant enough
to not follow that approach. You simply respond that I am just not making a
case without acknowledging any obstacle or providing a reason why the obstacles
are not valid.

To help me understand your view, could you please respond to each of the
obstacles I list below and how it is not an issue?


1) ABI change:
   mprotect() is currently supported to modify VMA permissions
   irrespective of EPCM permissions. Supporting EPCM permission
   changes with mprotect() would change this behavior.
   For example, currently it is possible to have RW enclave
   memory and support multiple tasks accessing the memory. Two
   tasks can map the memory RW and later one can run mprotect()
   to reduce the VMA permissions to read-only without impacting
   the access of the other task.
   By moving EPCM permission changes to mprotect() this usage
   will no longer be supported and current behavior will change.
   
2) Only half EPCM permission management:
   Moving to mprotect() as a way to set EPCM permissions is
   not a clear interface for EPCM permission management because
   the kernel can only restrict permissions. Even so, the kernel
   has no insight into the current EPCM permissions and thus whether they
   actually need to be restricted so every mprotect() call,
   all except RWX, will need to be treated as a permission
   restriction with all the implementation obstacles
   that accompany it (more below).

There are two possible ways to implement permission restriction
as triggered by mprotect(), (a) during the mprotect() call or
(b) during a subsequent #PF (as suggested by you), each has
its own obstacles.

3) mprotect() implementation 

   When the user calls mprotect() the expectation is that the
   call will either succeed or fail. If the call fails the user
   expects the system to be unchanged. This is not possible if
   permission restriction is done as part of mprotect().

   (a) mprotect() may span multiple VMAs and involves VMA splits
       that (from what I understand) cannot be undone. SGX memory
       does not support VMA merges. If any SGX function
       (EMODPR or ETRACK on any page) done after a VMA split fails
       then the user will be left with fragmented memory.

   (b) The EMODPR/ETRACK pair can fail on any of the pages provided
       by the mprotect() call. If there is a failure then the
       kernel cannot undo previously executed EMODPR since the kernel
       cannot run EMODPE. The EPCM permissions are thus left in inconsistent
       state since some of the pages would have changed EPCM permissions
       and mprotect() does not have mechanism to communicate
       partial success.
       The partial success is needed to communicate to user space
       (i) which pages need EACCEPT, (ii) which pages need to be
       in new request (although user space does not have information
       to help the new request succeed - see below).

   (c) User space runtime has control over management of EPC memory
       and accurate failure information would help it to do so.
       Knowing the error code of the EMODPR failure would help
       user space to take appropriate action. For example, EMODPR
       can return "SGX_PAGE_NOT_MODIFIABLE" that helps the runtime
       to learn that it needs to run EACCEPT on that page before
       the EMODPR can succeed. Alternatively, if it learns that the
       return is "SGX_EPC_PAGE_CONFLICT" then it could determine
       that some other part of the runtime attempted an ENCLU 
       function on that page.
       It is not possible to provide such detailed errors to user
       space with mprotect().


4) #PF implementation

   (a) There is more to restricting permissions than just running
       ENCLS[EMODPR]. After running ENCLS[EMODPR] the kernel should
       also initiate the ETRACK flow to ensure that any thread within
       the enclave is interrupted by sending an IPI to the CPU, 
       this includes the thread that just triggered the #PF.        

   (b) Second consideration of the EMODPR and ETRACK flow is that
       this has a large "blast radius" in that any thread in the
       enclave needs to be interrupted. #PFs may arrive at any time
       so setting up a page range where a fault into any page in the
       page range will trigger enclave exits for all threads is
       a significant yet random impact. I believe it would be better
       to update all pages in the range at the same time and in this
       way contain the impact of this significant EMODPR/ETRACK/IPIs
       flow.

   (c) How will the page fault handler know when EMODPR/ETRACK should
       be run? Consider that the page fault handler can be called
       significantly later than the mprotect() call and that
       user space can call EMODPE any time to extend permissions.
       This implies that EMODPR/ETRACK/IPIs should be run during
       *every* page fault, irrespective of mprotect().

   (d) If a page is in pending or modified state then EMODPR will
       always fail. This is something that needs to be fixed by
       user space runtime but the page fault will not be able
       to communicate this.     

Considering the above, could you please provide clear guidance on
how you envision permission restriction to be supported by mprotect()?

Reinette
