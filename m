Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A85A8519
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiHaSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHaSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:09:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2EE97C6;
        Wed, 31 Aug 2022 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661969334; x=1693505334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhiAXrJHOhkgg+X+Q5bJkaydFaAyJnQpTQyN64jnguI=;
  b=JIsASqkSe3jAP5aWspU9g4xhG+da4V4/Gbt0B1a70bEo+t01pmyQpMT+
   O5JUKoAuad9Zh8lcQh6TnUiyGG1NXF0bErMLbjaSKCDsl4tumro/gY1d0
   aG9MqD/PTgvcFy+qmYmdvuTcWS26TJfM/nyZGOfMOQyJ/TPfTgvXcVMkn
   6yy+kgwDkVCpeCXwt2OP3aMe/UnimZp2h1//+YxxJSJZg7KOm1F4UoLzx
   e5F74O/Jb/6jV1gWUi8/jxm8m1u3jN4+PC0AIcHUET2YMHzBbs8QqMDht
   Qb12iqfKkxgqTWQPXW8uZuACC18yA10uDyWCeKQfvVhB6/xqtjBHnQa8M
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295515627"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="295515627"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563125626"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2022 11:08:52 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 11:08:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 11:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgifPv+x1z4/bDXyiRV5pm4u0DzITf309EEhOWHTMSuric0i1H9+jMK3hJfWjLo5I9qpl5/l8VQJb+yLmiW6DumZHijqfqCrPZAmZLRPFwrHD396uZkUxn+i0sT+cJ6jco3bpcRIQZCe8ydRwURt8BGqQ7uacWtWvOZczH9TNbvSFjSeVk8qRyjBi9nlnQ7jNaL5iOb5jQTqpstvBD10sTFEXohlQhdfuTe1xqnej238jdtvZz5RL1hgASWImZUj2jOtj7rAwrJDyX8BpmNe8+rRc/rqXqYsrT9EsLQXN4iBLpjCRawn9hQCcpHVRrx7eODV+bw8lm/WQglaParteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47W7VrvSwXKbPQ3JNOnpb1tl8fE+9gD8i1+yropH1M0=;
 b=QLQogNAltHKyh7Ys/KWl3ZsQrvrGnpvGc2vU9fgViTZ3pN3Vxa+lZjtbrsB1CalOqbDUmC/bn6K99FE/VCslvnMflA8aBzmL8Yrxt/vKYzUow9+D5RRYmkN2T5hYlPfNSL6UWuQuQixqYrKCKFmk7lxU0f4kht6vy+UTL1Zb53qmvu2OiIYEW1WaQQLHLTpUWm83X4j4iEG4r/JsEM+/4KGNFns890vIeDKsqQuLMnar1U8cMaAe9PmmbjRhyHYB1shuiCcK+GY1PoqfgdWz6fSdcRNbHnUfo5w59CpjuTICAhEgw13cBIcNkM/joIF0DP7kiCs7mo66ih/AtF9j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB3146.namprd11.prod.outlook.com (2603:10b6:5:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 18:08:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 18:08:50 +0000
Message-ID: <c381db29-d74a-4986-db04-fbd35b8d80b0@intel.com>
Date:   Wed, 31 Aug 2022 11:08:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-sgx@vger.kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <Yw6/iTzSdSw/Y/VO@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yw6/iTzSdSw/Y/VO@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::21) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f6dfcf-5173-412c-b0ac-08da8b7bdb5e
X-MS-TrafficTypeDiagnostic: DM6PR11MB3146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51Yu01F66nNwrDrc8bewM0U9Fu9K7FrBmHfVKT4Y/Yq4STLLGAj22OW1HzP3NHJH16VjPRbbfdHcsRODfQbCdzBwkM59vPoI0stnAyFGrgBIdzJx/CCCH9JXccATEJ5A4Bmg+XPn0tP4yfaAJUzZIOWnCx9jdIwrzhO7Nvg9spCF0GqE58T6TXghWeBM/ULQ4wqIBefiOU3ZqadguRrdwTKPhdlxrXz+gjJMgktY/FoQmwm7+TGUWn1/if3AxAqwBgHlg7HF5zyEacxHanbdEBTP5Fn+BOM6QYVdJae4TThFXPSgtzGF0cOwpQNBpfd11EgBdIrLpkyAM2UWAji2t1C0hSfxdMdj9gpEtVKtVcofSJMtVDR9C8ikTcuaR5GfneCAQjAQO8zKzc9Zj0KlBRRVhi525Ju35U0DFv1WOV8vC9TFx7v1Ic4z9MwJS/v+25Kuau2i7FhNS86ivk9djOEYLUCdBlXTPUp0qC5FjHl5vUK8o6eAWj/Jb2vnxXIRMuqESS1dshaJAENPcrtjzX4zeVzD/UXp6DBk7GrshNyfYWynxyEYxrK5TZctgKFFv8dJjClFk1gKqHG+8L5H+cgjUUyIwnf8xuhEUUBEvCRKLesqe3mnAWty3XRWfj61Wtgz91ymt5HEFkrt/i6Cm8moHXnpBTQuqBB6E9pncuz5n/NvbHJQQ1ikSq15Nnh31N3fcp1whV4QLqScOWWcGXzK/Un3ASbeqljDkcvTR7KaaeZzKbzjrNYGthDZwibkmZYeEGip9I24gPqL+PgbQ6SZAisvN//qcLljoE+hGnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(8936002)(54906003)(41300700001)(7416002)(6486002)(6666004)(38100700002)(6916009)(44832011)(6506007)(31686004)(66946007)(66556008)(4326008)(8676002)(316002)(66476007)(36756003)(5660300002)(26005)(6512007)(2906002)(2616005)(53546011)(186003)(83380400001)(478600001)(86362001)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVqRWFZbTJVZVMzTzNObW4yV0RtdDdnRUtwN1FwWnkybFNMb21GL1F3cUx6?=
 =?utf-8?B?dDdyajhPMG9Pak5HZ2pnanl2eVVkbnQ0NjFqUVRnZkVaYm9sdysvZGg5WWcx?=
 =?utf-8?B?dE1MTnRFalBOVitEZmNEZWp5TWFLYm5VY0JzVXJndHUwczFISFFObWZZb0lk?=
 =?utf-8?B?MnVMRkkySFRkcjZUUXR4L2RNakpTNjJJRDRPc3pmOVlCSFJJYUtSYTJ3U3dz?=
 =?utf-8?B?RFlBV1JNeFcxWHFZQXFVRG5JOFpLUTRkcTVPaEJCOWtXa1lqZktKVkYwYnl0?=
 =?utf-8?B?ZFJvQmRpSUU1WE9ubTZ2WXYwaUtYS1Q1aytab2tSZGt3TGovUUR1UGkzNkRj?=
 =?utf-8?B?M3NiSlNDa3FQRDBpdStOQWtXNzdBSUdmOXVmcnhTdGJ6bjVzZ2xkeFM5VkFK?=
 =?utf-8?B?NDRvYXlJTUp5U0FOdDBmN3pIc1FSOWJrTXVpL0JJNiszZG5mSWpTZjhlYUVr?=
 =?utf-8?B?YTJ0eVV3eG5QbVh1TUdtWG9kdEs0QU5TSC9KaTRZNkV2Wmk0OUNFdGZ2N21k?=
 =?utf-8?B?UXY1dUJlR1FXeEM1SWVYb1ZyMkVJWm5ncXpXU3lJeGRkVW1jOENLSXdvQ09P?=
 =?utf-8?B?OEJrY0QrWTQ0TkVLOE1hVjh6NlIycVFoMFJNUHpUSnBOUDBtVzh2YWxBUXha?=
 =?utf-8?B?UlprN2lxNEpPT0MzVExnMjFNMXoxaWtuTlJvS2lNdzlBTUxvMWtlMC9NNWZi?=
 =?utf-8?B?ZUpmakYvTDk4ZjNBTzFYZ0o3aUZ6anp6aHVvYlY4NjMxUUdTbTRVeHRGdTlo?=
 =?utf-8?B?Q3RuNk85NGllelBjeEs3UWhoNjJqcUovVWYwdHlWWlUrczJWUVBXbmdMZEd6?=
 =?utf-8?B?Mys4RE9YKzZLdU5pbnlPeENGQkxIU0M2RnF4VHpxMU5XTlZZODJaeFZhTmNu?=
 =?utf-8?B?WWxvU3hoclVxeVdCQk0yMXhpMHl3aDNXRmhWS25TTE9HWk54WTVBczhHYllt?=
 =?utf-8?B?WU5adTJ2S3V1T0V4Mjd4cXRER1ZESS9PSlB5OUxrZXVuQmdVRVY3MUVuYWdu?=
 =?utf-8?B?ZUFWQlBnUStlSEVYYVp1dGRnT0h4bS9wTjIzWFN3MGhXb1NTdGZubUt3S0Z3?=
 =?utf-8?B?R1JpdndrdHpQVEJ5QXNFMEJhc29rcjJhaVFQeUZnUGlKeTV3ZlEwQ2pKdHNj?=
 =?utf-8?B?MVhCZ1o2eEVCU2hycnE0MG1DZDVnU1VVekJ5QUZ2OUdWbytsUnZtdVkzRmlO?=
 =?utf-8?B?eG81ZCtIQXI0aGtiK2lIcWw1eGNvcFFkc1hNU1lZQlU0RXhuT3VyK2ludWtp?=
 =?utf-8?B?em5uT3dvTmRPY25MbldNSjhjdUFKOXVXNHFvWjd4bzB6S1Z4UzFMcVd0K0Rx?=
 =?utf-8?B?Vm5HZ0dYZEh6TFhMQzRLYnVVNDMwM1VnRmE2M1V5MUViZXQ1cy9HZ05SYUQw?=
 =?utf-8?B?WHU2V05Ic1dDR3d2QjlCS1M2OUNheUQzUzRNMGhwOUFiSDJBZE5KOFQyM1J4?=
 =?utf-8?B?T2s2a2ZzYXZWQXZVT1pCZUJJWVg4QXZPN2M4TUdMY0lhcmJzckxkRFZvZ1lx?=
 =?utf-8?B?NE51OUk5QWxqb2MxcDZheFJDMzhEVlQwbW4wem9DcXIwMTI0UTRuVmY0dE5T?=
 =?utf-8?B?RlNRN0hWbVlwT01GbUViODFRc1hKOGU2Y3NBR0hrbUpyanZYbzF3d3ZjMDRn?=
 =?utf-8?B?VWNicW9wenRLdHpxYnUvMEl5Z1VRb0g0bkRpUVRBd3p3RWZndzFGNThvMFFS?=
 =?utf-8?B?RG1NOGkyV1RmM0NzY01qNklxNVd6aUtJdXQvV0tsSEVudGFnblRoSW1VMUVE?=
 =?utf-8?B?ckNzSlNOekVZaEdJeEd1ZHdPa3U2WDNKelE5eHpWc3pRVGIxb2l5ZEc0SHhz?=
 =?utf-8?B?VFFXRElpcGtmV0lWYWFIVHBZS044a0FiRHVDdDFoUEQ5dHBwNDVERld0Vzcy?=
 =?utf-8?B?TG5HdWM5Y2RQYTRPcUV0REM5MGRFdm92N1d3anRzbmowbzNucHgwbXM0Sjla?=
 =?utf-8?B?QVhrTnI5V0xrUVRzVWdLUmdINjI1bitsSnhQUi8vRHcvZ25rSnA3WHFxd000?=
 =?utf-8?B?RUsxTEpjejliYjVEdW1UWXY2dEZzQlJxSjd6Wnd5RUxyWTRKUDNxb2tMK1pB?=
 =?utf-8?B?NXVwenhTZFNmQmdURlhaRFE1dFphcjNqSE1JbDlJQ2ZrZlBnZEtiWEIrT043?=
 =?utf-8?B?ZlFrbS9iOFdUMmQ4U29KRXh1S0kzT01ING5ENUg1UGFyRW5sZVJhTnN0U1Fs?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f6dfcf-5173-412c-b0ac-08da8b7bdb5e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 18:08:50.5719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/f5SkBWkovJePWMMiVzGevdZYgHMDzrcQxnEsj2bgsBxOLqCPfn9I3YkzY6c7T6bztlHY+FmKflndiIoFAFOexV01/jxeHq5vQosWTCHdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 8/30/2022 6:55 PM, Jarkko Sakkinen wrote:
> On Tue, Aug 30, 2022 at 03:54:27PM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>>> In sgx_init(), if misc_register() for the provision device fails, and
>>> neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
>>> prematurely stopped.
>>
>> I do not think misc_register() is required to fail for the scenario to
>> be triggered (rather use "or" than "and"?). Perhaps just
>> "In sgx_init(), if a failure is encountered after ksgxd is started
>> (via sgx_page_reclaimer_init()) ...".
> 
> This would be the fixed version of the sentence:
> 
> "
> In sgx_init(), if misc_register() fails or misc_register() succeeds but
> neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> prematurely stopped. This may leave some unsanitized pages, which does
> not matter, because SGX will be disabled for the whole power cycle.
> "
> 
> I want to keep the end states listed and not make it more abstract.
> 
> The second sentence addresses the remark below.

Thank you for capturing this. It sounds good.

> 
>> To help the reader understand the subject of this patch it may help
>> to explain that prematurely stopping ksgxd may leave some
>> unsanitized pages, but that is not a problem since SGX cannot
>> be used on the platform anyway. 
>>
>>> This triggers WARN_ON() because sgx_dirty_page_list ends up being
>>> non-empty, and dumps the call stack:
>>>
>>
>> Traces like below can be frowned upon. I recommend that you follow the
>> guidance in "Backtraces in commit mesages"(sic) in 
>> Documentation/process/submitting-patches.rst.
>>
>>> [    0.268592] WARNING: CPU: 6 PID: 83 at
>>> arch/x86/kernel/cpu/sgx/main.c:401 ksgxd+0x1b7/0x1d0
> 
> Is this good enough? I had not actually spotted this section before but
> nice that it exists. Apparently has been added in 5.12.

The timestamp should be removed, it is among the things listed as
"distracting information". In this case the backtrace and registers within
the trace are not adding value but I think it is important to mention
the kernel version somewhere for folks to be able to interpret the
line number provided.

Yet I see you kept the whole trace in V2 ?

>>> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
>>> index 515e2a5f25bb..903100fcfce3 100644
>>> --- a/arch/x86/kernel/cpu/sgx/main.c
>>> +++ b/arch/x86/kernel/cpu/sgx/main.c
>>> @@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
>>>   * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
>>>   * from the input list, and made available for the page allocator. SECS pages
>>>   * prepending their children in the input list are left intact.
>>> + *
>>> + * Contents of the @dirty_page_list must be thread-local, i.e.
>>> + * not shared by multiple threads.
>>
>> Did you intend to mention something about the needed locking here? It looks
>> like some information is lost during the move to the function description.
> 
> Nothing about the locking that concerns the parameter, as the
> sentence defines clear constraints for the caller.

ok

> 
>>
>>>   */
>>> -static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
>>> +static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
>>>  {
>>>  	struct sgx_epc_page *page;
>>> +	int left_dirty = 0;
>>
>> I do not know how many pages this code should be ready for but at least
>> this could handle more by being an unsigned int considering that it is
>> always positive ... maybe even unsigned long?
> 
> I would go for 'long'. More information below.
> 
>>
>>>  	LIST_HEAD(dirty);
>>>  	int ret;
>>>  
>>> -	/* dirty_page_list is thread-local, no need for a lock: */
>>>  	while (!list_empty(dirty_page_list)) {
>>>  		if (kthread_should_stop())
>>> -			return;
>>> +			break;
>>>  
>>>  		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
>>>  
>>> @@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
>>>  		} else {
>>>  			/* The page is not yet clean - move to the dirty list. */
>>>  			list_move_tail(&page->list, &dirty);
>>> +			left_dirty++;
>>>  		}
>>>  
>>>  		cond_resched();
>>>  	}
>>>  
>>>  	list_splice(&dirty, dirty_page_list);
>>> +	return left_dirty;
>>>  }
>>>  
>>>  static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
>>> @@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
>>>  
>>>  static int ksgxd(void *p)
>>>  {
>>> +	int left_dirty;
>>> +
>>>  	set_freezable();
>>>  
>>>  	/*
>>> @@ -395,10 +402,10 @@ static int ksgxd(void *p)
>>>  	 * required for SECS pages, whose child pages blocked EREMOVE.
>>>  	 */
>>>  	__sgx_sanitize_pages(&sgx_dirty_page_list);
>>> -	__sgx_sanitize_pages(&sgx_dirty_page_list);
>>>  
>>> -	/* sanity check: */
>>> -	WARN_ON(!list_empty(&sgx_dirty_page_list));
>>> +	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
>>> +	if (left_dirty)
>>> +		pr_warn("%d unsanitized pages\n", left_dirty);
>>>  
>>>  	while (!kthread_should_stop()) {
>>>  		if (try_to_freeze())
>>
>>
>> Reinette
> 
> We need to return -ECANCELED on premature stop, and number of
> pages otherwise.
> 
> In premature stop, nothing should be printed, as the number
> is by practical means a random number. Otherwise, it is an
> indicator of a bug in the driver, and therefore a non-zero
> number should be printed pr_err(), if that happens after the
> second call.
> 

Good point.

> Oh, sorry, I forgot one thing. The devices should be actually
> deinitialized in the error case. We do not want to leave a
> broken driver running.

Is this not already done on the error path of sgx_init()?

Reinette

