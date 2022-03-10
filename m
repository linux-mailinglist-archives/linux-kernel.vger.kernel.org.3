Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E44D51C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiCJSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCJSvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:51:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B75D2269;
        Thu, 10 Mar 2022 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646938222; x=1678474222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Pyoj+uFI7uFhGVgD/gxdKY5VXGBJrsUvYU8j0cbP6w=;
  b=jbEQ6tZu273PHm8/dFEgpp1J+fGoxdkQKPVw47Tv7piIw5FF8T0umIFb
   Ahwf5Ghm2ClEK4Fa3O2daFHzvWZTGBJIyTzac3spqV/XRb8APi2s4NfUC
   RV8FCDb2q1ghMs5pturWEsAL86q45fqZtlCYfvfWUNsmyjJvt2PPqlfk+
   LFRv44+AXs04PvyA37LCotXzj4nACzw2HhoHLPt975spUMdUK/C3rMUxP
   PLeirKEqTfzLFNovQhCzdnyZ0nNyxgviOLbnDVZaAknI0tKP50BMGhAzD
   wlrdHYMKOwBR8v5oWAQ/q33d5PFA031Qqp7zlxAnyzVlLMHgOVDF2nnxa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255075879"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255075879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 10:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554787555"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 10:50:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 10:50:21 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 10:50:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 10:50:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 10:50:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E181tjsjDm2brfnUk0+V+C0dfQTizh74CZfI6P4fpS2UG9PjMEMHQRBMT/N+99Afa2vlnZlnsFW0dfHjhF525b736TCPIqQGgZrrP9p1nZZFhh+tjAyoOGeExRav0OsoCqHevjUjFvCkSLP7yQnTH8T4wp9aj9BFjrIHL2BjXFaSMzR4wZf23tRslsxzMNGFU3/I3ZPxqo9R9cDwu3vRfu4BhCGG96eG802/U1r/9jfUkWwkQjSqjcpWBs9Jjq0xLnueA0/Qo/K1aKMrHUfFzZqrbmppx9hCF4Wf4qWFfzunV/XfViV6pSS1Qf4bMYJfoH3Isl02+Y9tviYsL4Se/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwi5M7fpejMH+nag2dnL+KftXus74J7PZ3O2b3j8fxQ=;
 b=Y1992MnnNg6dnciDQUjXnNbAtB4zH41cuUSywWyaEw772UBCCS522P7J3EMITmsWznEHN/EkNb28ucAZ0+SCRlVFcIS6jP+yLnYAl+1bDvhjX8RHQ3mfmVryBiRXsn2AiwEwYncGup58isbGQor/B8VmpxBZnWi0qetQ6cU1wnHizObbykGyB7U0Ph6m1dYfpZq4i5rPiik6gBOsjmKK37jD7GUxHwatFrypo5PUXF8vGNxtl0xvRPJcgrmKvVQ43QY/GhSVhlMV8OE/mq4KxwlTC3k6tHVKLbuE+L5XDwJCqCxjWtAzvPlYTb9q2wQyLGP/uEJaS6kyMqxjFqcbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 18:50:19 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::c044:86e4:5f8:e345%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 18:50:19 +0000
Message-ID: <8fc192be-348d-0102-22ab-57b974e9d840@intel.com>
Date:   Thu, 10 Mar 2022 10:50:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] intel_idle: Add a new flag to initialize the AMX
 state
Content-Language: en-CA
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
 <20220309223431.26560-3-chang.seok.bae@intel.com>
 <CAJZ5v0g2ZU8PY8QkGD1Nb6VH37pm=ho8ZYa3h3UBRWDoH+xqnQ@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAJZ5v0g2ZU8PY8QkGD1Nb6VH37pm=ho8ZYa3h3UBRWDoH+xqnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54b2d0a-fd0b-4283-9093-08da02c6d2b7
X-MS-TrafficTypeDiagnostic: DM6PR11MB3404:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB340494BC785459CCE53808D8D80B9@DM6PR11MB3404.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XF9MuaN/Ha2x/orP9djBUrohHk8yfl6Rdr1YVY8OvgGeqLwSkJUriIca7VmkJI8bPF43QdKVBJny5YQAUe4Q6SMNlK0tWIOcFxdnjDTO+lBKQr99nLy30UyZwjZBt8KI4UHwsRS9v+sPAa/xxcM4dBhRj0sb3hjV0VCN2hLALzuqBxv4Wdj286qhfDc7oxYNFM5883XpbfWzYMULnn9Bhy0fHPbPKArrvyGn/LnIkXeEvytmCfoDnAOTd71JWPr0rjheSlwPw93tmwdf2F5FopCl6y3mnAg0kvhAVsxeq+K7vAoBfLgTfi+4VNVf6xQQmLndfpnh+USdiLr+yZq1oKCiLOM4BV1OCRgAMiG6Hp3lewRqmwXtcRxpm1uA1v+d5wqRX6X9Pw4poBifrffUH/0LvuCu6xNrFCvi/FOf8uVuR42DGWFh03rkgvcBlEPfdzKbn+mAs6TFvUtrdCU5V9tCNcIThoTBOwDizKiHxyzLB48h/9LdUS5TyunwbQ/hC8O+EiC7Ov6e96jep9x8tjMmiobFiCGZJEbtVtGjDxOjSFQTfLX07MaaWcNUVkw9Q8LaQFakiBeAMo+SPW8SwxlP2cDLKU9smou1RAkwlMuoMrdVOI7nvwEGvmMeiPSi0YaiXFd5xCGTI1aHDzdmlLwQ0qsLPdc+knjDDrm9Fa3jnWWmr+KUfeIKWYK2K6RANX5sKYP6q6aYq9aHwDxdhjEabnY5tWw4BwAVIEEvs0scifZjR/EZL8u8OFb5ziW34w7lH9w/nRyZdQuN/VnhhZXASyB59XTEIOV8NQUZRSwb9tqJpkgGWV6q3M/DtdaH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(5660300002)(6486002)(6506007)(6512007)(54906003)(8936002)(4744005)(316002)(6916009)(2906002)(2616005)(966005)(36756003)(38100700002)(508600001)(31696002)(66476007)(31686004)(8676002)(66556008)(6666004)(4326008)(82960400001)(66946007)(26005)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRLUzU5TmpPSnZ1TUpUNWx0c21PckVNYXBUbDZTZnBZa0NhMWgxOXcyajZr?=
 =?utf-8?B?eTZQaUxpby9Xa2hlYWlUZy9VYmxVbnRnTjlKOHZnd0s4QVF3eTZBUnNlTmZz?=
 =?utf-8?B?eWZlNHBMcFRoRGo3OEh2eUlaLzgzU2N3WjBWcXkzeVBxSkZUcnIwcVd4MC94?=
 =?utf-8?B?QzQ2WE1BczIvT1d5TFMzMCswSHhOaXhGVUR1K09tdTByeTVWZzd6d0w0TVh2?=
 =?utf-8?B?V1plVFUrZHYxK0VaMWlIb216NW9UaU1aM3d0Mm5hTDhTNlZELzR2eFF4V2lY?=
 =?utf-8?B?N1kyeExHcTRid2JaZENSZG1mdTN4dTdrN21lM0tPaUhiRHBlNHJyU0JiUHpO?=
 =?utf-8?B?Qk5HTzRMRC9WNzNHUnp1clplaGxBN0pLd29iWmRQMXd0aUJLNjR0ZndHbDE3?=
 =?utf-8?B?dmJORloraTN1TXR6eTczM2x3Wm1lZldTZ3hvMksyK2JlZHRsQ25RUmtFaUFS?=
 =?utf-8?B?eHA0NTZzTk1kdkhqUDErSzcxYnNTZzd6Skp3UmljSWNBeERJNWpXbC9uSTJ6?=
 =?utf-8?B?eGdmaythSlMxVkRyWnlnNkR5UHNCb3VmdFhOL1N2RUdRYU8vMFNwVm9hbTAw?=
 =?utf-8?B?T1VvOTlrZHZmM2gvQkZqZE1UK0grNi9kTkVLM0gvKzhYWkhxYmc0M0ZIVWpv?=
 =?utf-8?B?TFRGWnJFRCtyaTFhVHFmemtiVXByR3I5d1FhdU5SRGlrbXduTFJRQXovS3hp?=
 =?utf-8?B?T1VkMEtCbEhPY3RteXNlTFJ4b1VHMWZVdm9pRkNTK2NzaXhYRWtLYnRoTWw4?=
 =?utf-8?B?L2RiVVlYNTJqV2lpb2RIdHZJdVJCTXdqeGtYRmlkT0ZhR0Z0ang2VjRPNXVS?=
 =?utf-8?B?WGxHMzBMQ01jUTNYanVkTGp3d3JxUlpaZk9WeGdjS2tJaTFlT0QyR3UveWd5?=
 =?utf-8?B?R2tLUnpReDF2ZHpBL1h5am1iNnNtY1pVV2JPM3VSSW9LNU94WFNPQ0x5MHZ2?=
 =?utf-8?B?cmZMWUNxaEJRdVNueElZM0YvdFJCRTBYc001SUEybjN1V3JjeFFPUUFLL0xR?=
 =?utf-8?B?MFdXOVZOV3ZlWGtsSGJlR1N5WTMyKzFBdEx4T2toYWNSVWNMU1ZjTFRGRkFZ?=
 =?utf-8?B?REgrWHd2UUdHSWlMbFBiblc3ZGhCOEZ1SUt4c2s0MHZ4ZG9ISmVWZXJMUmJJ?=
 =?utf-8?B?YlFiZ0ZOVGdBdm5YdEd6K2NPVU93NW9oaThOWFJoRGtZUzkxbEk2YVF3WHVy?=
 =?utf-8?B?bUxpL3d0VTgrSXdRS1RFaUxQdTBvMy9SeHB3alp1ZytKMVUvRmpQM3huVXVp?=
 =?utf-8?B?cUljQ3ZWcEdNaWNZSmhidm1oQzgzUG1LTUdxVVZQQWZxRGdsYk13ZFIxTEJY?=
 =?utf-8?B?bU5QczlwMjBieHpMM2k3S1hzUFVNejBXNjVYVkZjSTZaZTNvY1BUaGtZWExp?=
 =?utf-8?B?WC8yZGNTYldrcVVET25YYnVZK1ViV0xCOW5VblJBWCs3REZSeWVDakxpS3RC?=
 =?utf-8?B?c2ttSXZ0RWs2ajNOTjhGNTFVTldDYlB5bHVROVY2OC9LQ0sxOEd5YjhsVUJJ?=
 =?utf-8?B?cEh0MUI2VlJybUlyeVBhTGdKcjVEcDlsMkdhUjVudnJTL2dqYXcwMURNSDVt?=
 =?utf-8?B?UFMySGRRWElCTTVTbWFoVkdsb2R2S1gzVS9aUWMvUE9wc3g0eWNHMXV4VFZU?=
 =?utf-8?B?aS9rSTI0M0RIWndZQWRrUHRScS9kVjlWZW05Mzc0Y3dqOVpVRFN6T1NNcHQ0?=
 =?utf-8?B?WDZ6SmJEK1FSS1ZvTzUwSVV6MXJIL1ZMK3NtWnc4REc3Tk5QQ1J3VzFWMlFj?=
 =?utf-8?B?TDd0NE4yR3FiTmp2aHpVV0RTUHFubDZIV3FzbVdzZFJEcy81Y0h3cFhJSm1h?=
 =?utf-8?B?enlBcFlNZzc1K1dSUUNQaTlvQWo5dDJDQWZzYktLVXp1eGRIVk9qN0JoMlNm?=
 =?utf-8?B?NDJZbmFEQUVTVEtpKzJUYnVaUTFoTmlvMEYxaytvWTloQXRmeWo5NkczaGg2?=
 =?utf-8?B?RXlLS3RUN1hPWUxFQ21IQnZJd05yMVMzcXR2MjB0cEhWTkhneHN1NkJJbU8x?=
 =?utf-8?B?NVpUYlYzM2NnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f54b2d0a-fd0b-4283-9093-08da02c6d2b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:50:18.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evP+1CSg2Y6Z2QybHB5xGt5Ol/SfyiuIVvO96V8uHMPNacw/xpiIzdl/8rlz0XsjACnxTRqsi5aCHQoP/goeWWfWzoNJiLNiweDtBAO0SAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2022 10:34 AM, Rafael J. Wysocki wrote:
> On Wed, Mar 9, 2022 at 11:42 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
[...]
>> @@ -792,7 +805,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
>>          {
>>                  .name = "C6",
>>                  .desc = "MWAIT 0x20",
>> -               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED | \
> 
> Why is the backslash at the end of the line needed?

No, it is not needed.

Sorry, I think I was mindlessly following the style in this new c-state 
table:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/drivers/idle/intel_idle.c?h=linux-next#n787

Thanks,
Chang

