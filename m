Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A7583B06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbiG1JOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG1JOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:14:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E395E320
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658999685; x=1690535685;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m9PFh2iHRfvWXqRjFhW9VSUTTeq5+BfP4N4mN6QQK8w=;
  b=Wr0AKLd4+XUADSYYve2iYvyv7lixxN0sp6n3Zbe0veeLLLP0EKNDviYd
   ltglem9bh3nRZ2jiczYSGsmKGxJRIIyxZikd5WqE6H+78Fzm0WkTnmDLM
   /o+fwtVQIfCObCgYipfxIc5RWMS3QHmIULVykXPtAHhHVuE1IjGoH3fAq
   pfmKQq1Hr+y+EXeA1t5LeBW1oAY8QKpaeTLkx+MQZrqhfRKg3+AyiswAj
   /r8GCMWC0KAjFk0gPeUAcrOfkOCdUy1Ar9ZmC4Ybgzj2BH2ywo8gpgyHq
   9atolnCSEUTtCX3k8n8MKFfgUyBYsMP5NsmTCS1+Iu92fF3cnlbbXtiLr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="350171034"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="350171034"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 02:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="727271645"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2022 02:14:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 02:14:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 02:14:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 02:14:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 02:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtQMp2LOeuShzzNNnb7YIIEBs1gMZfUxCxtVyaGBrTwLEsqhj51Mo90mzAz1WGPFJ7Q0cUboRNmplOhGe1tpuVqK1fTueeO7aG5JNTKWPOGVk8eWgXhp48fy4kiyhLfXT6+K4QCcojcArgGWSx6edTR+LJXTRX3J9Hwupr7UTWXaiiNVch9DEuQnZ7PeQPIWcn+EhkpJDFAEtXRil07OBnIlnvCC6uc7XkW3tfm17JYzXk7Ugh2vpNcK8gu5F6FZNjjpRnH7xROvfasm5erdg2XKhoCZI8N0Z0nQ/5mMDNvSfELEvebd3WHYTaVlPTiC2UOZh6J3S+dpdQksx624tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsPP0UKQPaxivP0uh1Z1wZuJp1f36WlmD1IkQirkumo=;
 b=J9pqYfAkdl7882ivi4jO/FUem8TnRHoHfUAV7cwHPgleO/gzi81FfgikzidgBT4+SHVwE8xmm2HwTpt7f/xMAllkXc9hCVyp4vOg88ehwkUNwgsp3lSnqEpMxlZ8jDWyAWJXQXrW3HGbQgNQ5RPkESbXKU/+zXOhGOu5ghn2gqLzLoJ9sH6rRhCKOT73MayBCktaY8o3ZoeG6fbdxnNQeXF/GYvf82BHXwveQFa9R0W1lNQ/QR6W/P58nN0MU4tzNKkSnlZgQpZ924lgwv6Kbn8XdsPuLGPzzmaAGH+eCjZLwt6b2StDT6iFENey+hXfAyrPQrmeEDxHktpzhy20/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3862.namprd11.prod.outlook.com (2603:10b6:a03:182::11)
 by MW4PR11MB5798.namprd11.prod.outlook.com (2603:10b6:303:185::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 09:14:42 +0000
Received: from BY5PR11MB3862.namprd11.prod.outlook.com
 ([fe80::8d57:f27:b06d:b6a]) by BY5PR11MB3862.namprd11.prod.outlook.com
 ([fe80::8d57:f27:b06d:b6a%4]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 09:14:42 +0000
Message-ID: <5729cfad-7840-6e06-f066-ac69374d1217@intel.com>
Date:   Thu, 28 Jul 2022 17:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] memblock test: Modify the obsolete description in
 README
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
CC:     Rebecca Mckeever <remckee0@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220728011228.23691-1-shaoqin.huang@intel.com>
 <YuIK7cU8uH7zVP+S@bertie> <bcff18b0-5da7-860a-410c-3868b019c717@intel.com>
 <YuJQgAJBxQkkooVT@kernel.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <YuJQgAJBxQkkooVT@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To BY5PR11MB3862.namprd11.prod.outlook.com
 (2603:10b6:a03:182::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f59786-1049-42f0-1099-08da70799b17
X-MS-TrafficTypeDiagnostic: MW4PR11MB5798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IfziGgEtszVSYHYDCTHnZeBH3DtHVdxsiksOINX056K8HWHBKXOE4BvWGa8WV6AGW+KA+omihkX9+e0eKs83gXlhTzjRg5VI0i+6/KYfh1STMHeDVXk+l6fPxyJkdfI3WroiakuWI0W+Oqo4oMBX0PjcCfShTRrNOaA3OARaPFtxxmp08EiptY0cKibuiTDFVI/WTQlDvT44p4t+2YtQ6B/O2NHazxo0UTgDtNnYVNQ6DOISbT5XEHNeAnSFgR2m4odoRl5KuWaW74NB/Lx0i/BAx5dPxy2aNJTdZhcftRylGR19Ih0/TniQZ/nPBte4kjHNv2dekabEtsRK0Y8n28bTBpGAae0Dz9x7HLmbdhHjSu+Rme6ASsZ8MyJDT4u3rxWkem9RwrhDcV5BNUMz8MnuWmEp39CYMZTOXVmMi+QQniWEM5Sgt4VltBcFXpRqOR3nxUVeHjn6zgADVBISBjRln8PYCa/oyxs6bZ+MsLAtTTy3Y1PJ8fe9yaV2A+ou+c2eGTdmYjwl/0JLvfmbVLiVe0bC+Ii7RQui4/OoXljIMue6Vz+Qflwf/14J1O1NWmYYgKqkxZT2UpZ7jgbTd5Dtaa0E3bSD2TTgGRGXoT77YGt4uOn+muygDxVGKSvFADzizYOjWUG5zvG5tfnC2WXxmHsR15XIT8fq09YWWL8ogs+z6pJmM/W0XiP8aLgU4qwhRH50EQ5PCxpfZf+3XkiUYsOaU/DwfqH6zu9Eakoj+R5ovQOyg4bLc5feVy/MZTCiMBXeUTLblczww5f/UG8vzXr/45kQgfSb8x7YP5XGr06mh1JVQZ/+mXws7vji3Lz0j93jyp2SHkgoI1uZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(39860400002)(366004)(316002)(2616005)(66476007)(4326008)(66556008)(8676002)(66946007)(6916009)(5660300002)(36756003)(2906002)(8936002)(6486002)(82960400001)(38100700002)(186003)(6666004)(53546011)(86362001)(6506007)(478600001)(26005)(6512007)(41300700001)(31686004)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpLVGFibFJRb1JKVVV0VjRDeEdHTmxSamZCSlJJOTdYbXV1NE1zellXbzlq?=
 =?utf-8?B?TnZqVnlzVnB3OE8renFIdHZIN3R0bGpGa2N4S24xeVNxYVpTTElha3ZocjhU?=
 =?utf-8?B?ZG1XYUVQdmR1bklGTUhNUjR0OGVDbVU2NmVKVmlBanlUTDI3b1lId2p5bC82?=
 =?utf-8?B?c1gyTmRCWko5VnYxY1l0RnN1UEMvZkNHTFgwK2N5Q1BMZlBVcUd5RHIweUEv?=
 =?utf-8?B?SnB2dlVDZnYvZmp3SzRhQmE5TWU4YlhWejZ3alduQVpPdkVySEtPNmxxcEY0?=
 =?utf-8?B?VUZ5OWtrVVV4c2xtMEY5R282VlZsNnVlV0dHa2NheXpQcXU4azh2S25JY2J5?=
 =?utf-8?B?ODZ0SjZYU2ZuakNxZXlwTHFuMmNuSWNheUxJRm5nYmZCZTFFNm9YQmxSR0lC?=
 =?utf-8?B?YzIyYXV0eXUvSDdlSW0xS3dkYkdVMWdMc3Yrc0ZvVW96OXVyZTdQdHVaSmlj?=
 =?utf-8?B?N3V6Z3BxRVBjMnBmdzdxME4rVG03SXdFUlRYdVVJWDBORzFOaWJMckpQcW50?=
 =?utf-8?B?UVFSN1AvRmpBUVFCbmlvanhBeGU5VDQ2VERVOTIwM3p3U2JtYmFJa3RFR0FY?=
 =?utf-8?B?eld3R0NwY0pRM28wRC9FaUJxZzkwcEFkSU9mSmk2NzNJNFk1MWtiOUdOMUpm?=
 =?utf-8?B?dVgydERSelc2MkJoNi92K2FWTDgxRDJMcGdEdHlleHFRQkZuMWRnYno0NDIr?=
 =?utf-8?B?bEpGcXVCL0lqRFJ4emU5Z3NwYzBjN0dkK1ZDdXBtNEEzMU1xZEdORmQ2cjky?=
 =?utf-8?B?SmJIaWtSNm5ZM05VTHVvckxXV0VsaEltUm5qZklNWWNERlJ6VWFmWU8yaW9T?=
 =?utf-8?B?MmczRjNVN1gwQ1ZQU21oWGpaWkp0MUVjZUpLRGt0dDJzVkNQV21WZDJnbmJh?=
 =?utf-8?B?cGpTMGZxa0g3TkxyeERkM1ZYZFlBNXoxMDkrYWFCK2F6dGYxQm1GcWJaOUlJ?=
 =?utf-8?B?cTh4cFVZKzYzUk9EVUc5aHd3NXlwRkllaC9YNllYV1B2eVkyYk1SbjFLaWw0?=
 =?utf-8?B?VnBMMTNDOUZaRzA2eUhzamw1WmZsK2oxYXk5WklOSTY2M3VCM254dXdtT0gw?=
 =?utf-8?B?WnNzT2l5MjY4Z0xoWVdySm5KVUs3MFBER0VSWVJjK1I3a01idkRmWkpZRTV1?=
 =?utf-8?B?NDVEMWZnNDFYWi9WSWkvbFpZMDJRL1hEL1VJa0wvaXZQSk9XVUdwMk0zcEd1?=
 =?utf-8?B?SVRSOU5rM1JNOW9ycTdVYldiKzJKUzI1bCtEQm8zTkxLZytBa1M2dWRzYUNS?=
 =?utf-8?B?aDl0M2QwZXhkdm5lcWJuOHZWdzExb0ZGdmhoTHVORGR3OUlvUFhUVjFpT21h?=
 =?utf-8?B?Mk9rcFVrYTNsOUpUV3ltVTF2OWkrbjB6QmZPRmttNTNhbTZLSmp0UmxjUWgx?=
 =?utf-8?B?VlFmRE1OZE8yelRkZkdZQXlsQkpSWncvS1o0c3hXNjZUTjZKVlBGc2sxVjJJ?=
 =?utf-8?B?bXZFTVJpbmhSQ0xwZGZuSFhkTFI5UEZlL3hOb2RNT3VCdUtzZWtXajZlc0VB?=
 =?utf-8?B?RVNseWlQQlNPb1FZOXV6MDQwU3FLQkl3RVhvSURiZTQrWURsbjZpQldTeDhJ?=
 =?utf-8?B?Tm5ia2NQNlNJSTMzTERDQmZDNFIvYnJ6L0g2MEs2RFp2bWJaWWgwa1V2VFlj?=
 =?utf-8?B?c3hvZ0ZCVE5aUitRZzh4N0V3dGcxaitRWWthbTJtY0R5K3RlY2NweVliRFNo?=
 =?utf-8?B?UmJkZWhYcWhCOHpOS0dCN05zZGRJKzZjWElNQlpQalFDRGVOU3hOeHJBaytI?=
 =?utf-8?B?d2EyRWRlU0FkczQyNVJ4TjZ0T3Q0ZnlpOE9lTXZSUHFHaXpYR3Nvc3JRQ0Q1?=
 =?utf-8?B?S21USGhLUEo4Tzg3NVZ6Q1pGTE1TSW81RVVZUlpQZHNrTjZMcjBuN0phbmJa?=
 =?utf-8?B?NG04eHlpeFlPbWRydm9HNVJBRFlMU28zSWlJQ1B5ZFp3N1p2M0puTDE2enYy?=
 =?utf-8?B?QzcvN1k4TmdSMWtYOTFQeGU3K0JxczY3Rnphd0w5YWhodlRta0FxSmxNZ09Q?=
 =?utf-8?B?V1dOcTFBa29sVjkwUGhRSFFtS2s0VlUvdFgyOXVYSStJNEI3b2dDcXVOV0dP?=
 =?utf-8?B?MG5GNWg5Q0ZEaC8zUm80UDdkVlhSSU5KZGlVOFM0dGpYeXNMb2Q0dkx4dWZC?=
 =?utf-8?B?T0E0cEdidUxoa0FrbGJOME9YRG9Mb0x3MkcrZDhSU2hHT2RmcnhsTWFmRUUz?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f59786-1049-42f0-1099-08da70799b17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 09:14:42.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn34x1fSBHlY9751MKWn4EX7Mr5TN1X1KJNuAYKKDBmXHE8CotchLLdaztSvDxmTyQgGnIVsC3xStz4tj43OPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2022 5:01 PM, Mike Rapoport wrote:
> On Thu, Jul 28, 2022 at 01:08:25PM +0800, Huang, Shaoqin wrote:
>>
>>
>> On 7/28/2022 12:05 PM, Rebecca Mckeever wrote:
>>> On Wed, Jul 27, 2022 at 07:12:28PM -0600, shaoqin.huang@intel.com wrote:
>>>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>>>
>>>> The VERBOSE option in Makefile has been moved, but there still have the
>>>> description left in README. For now, we use `-v` options when running
>>>> memblock test to print information, so using the new to replace the
>>>> obsolete items.
>>>>
>>> Thanks for catching this!
>>>
>>>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>>>> ---
> 
> ...
> 
>>>>    This will print information about which functions are being tested and the
>>>>    number of test cases that passed.
>>>> -To simulate enabled NUMA, use:
>>>> +For the full list of options from command line, see `./main --help`.
>>>
>>> --help will display the list of command line options by default, but a
>>> help command line option isn't explicitly implemented. I'm planning to add
>>> the help option, so if you want to remove this sentence, I will add it when
>>> I implement the help option.
>>
>> Hi, Rebecca.
>>
>> That's ok. I didn't notice the --help has not been implemented. So I can
>> remove the line:
>> -For the full list of options from command line, see `./main --help`.
>>
>> But after remove it. There seems a little stranger about how to get the full
>> list of options at the time. How do you think about it?
> 
> I '--help' option is implemented, it just does not list help for itself.
> I think it's fine to keep the "For the full list..." line.
>   
> 

Ok, if no other problem. I will resend this patch with a minimal tweak:
-For the full list of options, see `make help`.
+For the full list of build options, see `make help`.
