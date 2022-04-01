Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B894EFCB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353280AbiDAWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiDAWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:16:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B165657A0;
        Fri,  1 Apr 2022 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648851256; x=1680387256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EnrRCXJOxIBwGpJCUa+NnG+rQQ0RKF0QNUWRy1DsaQk=;
  b=OWaTSzf6I/5+NdLZKgPTXFbsKB4qya0BzUdRifU+9gZeqYUg8+UexAzu
   da2OzgTlVIuvMS/G6812vvyzOigDAnngi0jkY2Lg5FBQJTKbfSSZ/xmWf
   cTGmnPY85YcBpyql7LoQh+Pl/Onb9Y+Ku4vJtgRADQ6egHd2+CDS0nx1G
   4l5M9NOeIdSjeWlNiF58PJdapYQlcu9xE2U9SpGkgXxFAuk1iWN5NOP7y
   s+ZeFQEb1Fk87W1CRhOqmcIig/H9brlnA/JSPlzGfO0RNPv0ow2phILvK
   Gtct6lcYOuDlNv4lcMEUnyF3zILTHgCtxyi72TY1unjbES5DMdw42F20J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="323417247"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="323417247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="844710437"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2022 15:14:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 15:14:15 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 15:14:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 15:14:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 15:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTWFt9YqLu+11vYME53qqlodqEWGIAmc8inpjj+WWYSSuzBFb15DtMjosOa2vRe2803rTuvzENl9cNQUxoVlUCMhSqm5vXrHJVppLNGrcpZnAw6GXqFUbvZnexuABfZh1+hZmYeik4b1xef+KrY9ClW0r2Bd9HbN/duYSTcML/pqJLmecJBrieCTOCwEYuT2vLpeEpHHAOtNzFOiP51RknwANS6KVl5T44MDILAO9HieuQ1zCbBFyOigxCUZIfRsNvLx3+95PZOFBfGVD/q2dMmO6WDAVfmoktbSnFQ3wC/wvx2D8Q7+vgnAz7/GprbfJyidD4/8lwUJeKgASPlUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRgAa3Re9ZYihtEU0WGVsdwGvJjYlg95cFvdMD3SW2Y=;
 b=csjrXXUdbx1nCNakdxjhEvmh17bDu5SO4WIPV+ttBUn8ahSCTA5Lgt6mA7wPv97sKypnnRymO9yi89jMX/17ORDhOoS+vbuiS8UGh9cIxpkM2ElmW27wS404Avbu9v5hRz2j8X5B2Xl1FN4/rt3/3auPR7qNaySMz87006doYSIoQ0NxETkLe5QXUYLIO1s+a28nFJEw4fSVE1pnSFzgPisD+g7xFLI+ugRj8HFJp/YpvJFyofI4gPwxWMFBenxD+iPfxeBiPJd9d3QXd7fCUqp+bbDZqzr752H4Bp8UYD6AuASR6p5PCO+SJNGIVYKt/uP5DiRThzoDE4gT3Wbmqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.26; Fri, 1 Apr
 2022 22:14:12 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5db2:8079:a9c6:7ff3]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5db2:8079:a9c6:7ff3%5]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 22:14:12 +0000
Message-ID: <9e60c0de-d47c-3a47-a2a9-9ae203cff4cf@intel.com>
Date:   Fri, 1 Apr 2022 15:14:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/3] x86/fpu: Make XCR0 accessors immune to unwanted
 compiler reordering
Content-Language: en-CA
To:     Dave Hansen <dave.hansen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <tglx@linutronix.de>, <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <bp@alien8.de>, <rafael@kernel.org>,
        <ravi.v.shankar@intel.com>
References: <20220325022219.829-1-chang.seok.bae@intel.com>
 <20220325022219.829-2-chang.seok.bae@intel.com>
 <ee82ed75-03f5-1962-6888-11491c9569c8@intel.com>
 <1cb5ccc3-a84d-06da-a8e8-d9d3d8418d25@intel.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <1cb5ccc3-a84d-06da-a8e8-d9d3d8418d25@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::36) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3c98b8b-322a-467a-ec68-08da142cf398
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5117:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5117066211794AF7C09B4D48D8E09@SJ0PR11MB5117.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux1+8daWkbDScf2OWQoUE7TZBbDGVh3n1E3QaVrdbMiDqgb7ePb4B+kPPayFM8tckhKfjj569uzEOLwohZpEfTu7IT5ZMSlrsCNZvtjhQJXQSpSsuEJtCUbWF3cS1JdwW/f2VA0Bc0c6GaS7h2zy5/R+CDqZLzsmLtfg5c4vyg3oAz82J8N6wREP+gvM8GvsiedmCnxQUY4B/3MInFlPV4UczawA0jzJAfWqTdEM3EaQe3KFi6c94fp2WqmkeGEgqtwDx/OAOrAoVDGvXldTtGXV88YFdHzHd/ROZAsdt/cLVUS6gdirejeaGnLrEUE+2rkaKojatom9jG3FU6hQRW0CTXPbmG5Dg/ZQ8SuTDDf9rOj7AfvbOmosSX9cXlOeH5anFXCkoUVXQM8mWUDnhSKwObguuyM0C56Om8IAj6tml9ZGnlg8uugOiQCA7TJzj7IBPUc1pj/XYT0NJWlkAdqrFckSub7jqQ7bHteDVtpJHRpkQndeWt4Brjf2HDl98u1/rRVzlmXUcDeKyv0uYQla5534ju3YqpkCuVKHV72FGOmgu0YB1CPxeVFt2qIOh/qKyVTXdqKZ2fYwbmFrvMLNo95AA8eY4/ndV/tRVEbmAix1AUbev8i5DrrMG00rFxZa+Uhmp75pjC+hidI9RQMkrQ3Uw6Hj57p7LowImthPxFHtgYoTmtTbT3yjWRdZvu/d2dJj+7nRhWERlqbTYgatYgQsEB5q3ghIlNH7HmGVTVC33bMtRwcw4sBNUSMAps5taCamGQLL7KMfzr/KNiMzbcTGkMCs7iPkBzFqeFO3/w4xRkFch30jPVXbmQF7mDIimZ4ofIBqpSq/N8rrzqPDsZb5G/j8RoINS8Gkx9nGta6rPtGZ7NsHM6e4uCI6PFJekV9peUz7L/qLlMZ1SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(83380400001)(38100700002)(26005)(186003)(86362001)(2616005)(31696002)(4326008)(66556008)(66476007)(316002)(66946007)(53546011)(2906002)(5660300002)(36756003)(8936002)(8676002)(966005)(6666004)(508600001)(31686004)(6486002)(6506007)(6512007)(26123001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFWU3VHcU90QWdNaXdIMW1pM0czOTF3U2JRVG84c1VvSzdpZEdiOVFHVm0r?=
 =?utf-8?B?WElXZm5zRUR1VVN0bE5vSnZ0aEdBMEloUm1rN2FBeDc3a2RyOXprblNDY25m?=
 =?utf-8?B?NGlQOVdlZUgvYTl3TVAvblNQQk9CZXpMQW4weG9lKyt1ekpUeElISUdMZFUy?=
 =?utf-8?B?OW9oNWVKTG4zT0Y3MlVBKy9IVVFOS3ZFeEZuMEJmOE9yWDdUdWQ0a0tBYWts?=
 =?utf-8?B?Vkp2TU93V1Q0dzZQUkM0V1JUTkZCcUFHKzNGcXZSa0Vpa0ZwcHJJMFpJNUNX?=
 =?utf-8?B?YnVQQU0wZlM3Sk5wLzBpMDBoYXFFaEZwd3hVbnlXK0V6WFJBKzhqdXJTUWNC?=
 =?utf-8?B?N1d0aHFmQW12R2pVS29SQk9ESitTY1drNG9Idnc4QXRxcUtCbEd2Z2xicFRu?=
 =?utf-8?B?WTdlRThDa3Uxa29qdmg3bzN6eEFRUkQrNDRINnp5bEFFUGJQMkJqNE1jMGFv?=
 =?utf-8?B?SHlnQW9sN3dNNURSTkdkRkNucVpTYU5zOXNqbUFVaWo4bFRkbWYzRGJLejgx?=
 =?utf-8?B?Sm1QRTB4T3FqY3lhekhoOHhWbW9lWURGS0N6cGUwUHBCR3duY2tsQ1FnMTg0?=
 =?utf-8?B?bVJjdFRhTkQwT01jUVBSUk1pZDVJd2hRZjY3M2pvSU9mUEMwYldzVnZCcVRL?=
 =?utf-8?B?NjAxaXVsd3gzMUM0QU9IZDduU3hMQ2lLelhXNDd0Znd6N09lMEk4WndQZVZu?=
 =?utf-8?B?ZjRCd2tjYTBaMEkwRTA5Z3hMUDVTSkRMTGRnYVhVOGw2MGNveCtiQ2VaYjdI?=
 =?utf-8?B?dWxiekorN295YTBWSk85ZGRLelZGblVxRlUwelUxSXJQWFNOd24rUk5NaCsr?=
 =?utf-8?B?aUl3Z3JpTDlrSzVybTZ1K2JhcmRUL0FpbEVnaFVGd2xHRzBnY09ZcFlSYWta?=
 =?utf-8?B?REN1eFZhdS91d09zd1l0TXNNZllUMHJnUU15MmluT3k0RmFvUlc2WXNBaU1K?=
 =?utf-8?B?c0FSTSsvNHp6dWpIVW5lNFdVRWlOZ2MydGlRUmNkMVozWURxaEdvTFlDYXFq?=
 =?utf-8?B?V05sYTI5YmFnZlc3UGJjckY2SnFKVGlIdDJRM2RwaFF0bTljYlVXT1QxeFBu?=
 =?utf-8?B?Um5CQzdObjZ0YUNrMTFXbEhINkw4T3lNT1hjeXV1LzZiaDg2cTlNbWs5Skl2?=
 =?utf-8?B?OUFaakxqTHljRzd2RVZtZlFqQmhHbUh3b0VySnVsOVZxSXdwMlVid1hZOU96?=
 =?utf-8?B?Z1RKZzZRN0JxMDR1OGFyaGR4emg2bW5VaS9ZUTkxT0J2VEdhUVhPOTZkUWNT?=
 =?utf-8?B?R3RNeTdIQzBjOGpwZVFXTDJBdi8yYXNYVUdvOEJoVyt1TmJqUU01Y0VSVzhQ?=
 =?utf-8?B?dGVCeWlHaGlIWDNRbzllSm1IZFRraHZud2oyUEkyWVBnM09VWG1RY3J2cVR1?=
 =?utf-8?B?WmZFT2lWblNaczFwbE5zS3EvNnhmejA0WWlEU1p6NkFwanR3MlhuWFJzL20y?=
 =?utf-8?B?bkhkS3ZoLzZBUDl3bWUwZVd5UlhMTGVKNDFBNi94Mkxsa2pCQllHeFNudjZh?=
 =?utf-8?B?UG1FRXg4aUdFTktuZW5mNnh4Q1dCbm5tWHRJMVdIdFhRU1lBcEgrbWY4ZStw?=
 =?utf-8?B?YXk2aFV3MjJTTkswK3k2YVRQTUNTV3FmNGFWc2hQY0VBL1NmallZV2MwT1BP?=
 =?utf-8?B?c2NOaUl6bnJ6alc2aFpPUkdFSEVWL0JwZ2VWTTY0ZWsyVDFzU09CTVdjd01n?=
 =?utf-8?B?STladGswdDVKQkZlQ1Q0TUFTVGthdzRRcEZyUXdUV2VxVUgySFIrWmkvaTZT?=
 =?utf-8?B?NzVlYmhHWS9oQlRlbzl4MjhoZlVEaHNydHFaWE1Bbm8xRUNZcSt2ZWtxOStT?=
 =?utf-8?B?dHFHRFE5VGd5bU5KU0hId1o4bjdocTNEMW5Sb1lNYVZmWDZCYW5lZ1QwWXhw?=
 =?utf-8?B?SVRLaUlVeUg5TDROcEVJTUxUb0ptKzRIeTlvUUxsZUZwTnF3d0dwdG83Q1cy?=
 =?utf-8?B?Z2MxSWlOcU9RMlo3TG5zYVQzd3RpNC8xdGFyQXVKQXNqZjdTbkZOSkxXY0FX?=
 =?utf-8?B?R1ByY21lTEwvVnhjRjVmdFlYbFNIY214dDAvZnd0bkIzVmsxUVVndDZkdVpv?=
 =?utf-8?B?NGFLYjdxR0pSVTJTUUhCVlJJNHZBbXltWFZpMm5TTDhQd0REM2g0R1UvbzFM?=
 =?utf-8?B?NWNPN3A1clFBTzlBT3B5aFJrQllYaXZiNXoxVmlZOTZHVzdtRXZMTk4xSUov?=
 =?utf-8?B?V0p1N0FTK3pnOTE3NGZjb2tWdUgraWo5aWZrWHdtY05mS1BWMjNUQUdiWGQr?=
 =?utf-8?B?RStNMFVhQjA2dW1naE4vSTRSdHN5K3o4bVI3T3RjUVNSVUVJQ1RVb0dUWUxr?=
 =?utf-8?B?V2I0RnJ2dHNuWGtZY3JWa3g0Z0ZhZXVEclh3YzBYQ0xucVAxbkphMkVWeWhQ?=
 =?utf-8?Q?b4+eYKx/UgszUtGM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c98b8b-322a-467a-ec68-08da142cf398
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 22:14:12.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WFDgbWDIJcR2JzDhWH46AE6zLkDHVNWFTHrzoZELe8omy6t0tgcQ/zaR7oFXR/OVBms4nAF7GJbs0+cdRwyaCclT1owq4XyEzHdPJhgsyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/2022 11:16 AM, Dave Hansen wrote:
> On 4/1/22 10:58, Dave Hansen wrote:
>> On 3/24/22 19:22, Chang S. Bae wrote:
>>> Some old GCC versions (4.9.x and 5.x) have an issue that incorrectly
>>> reordering volatile asm statements with each other [1]. While this bug was
>>> fixed on later versions (8.1, 7.3, and 6.5), and the kernel's current XCR0
>>> read/write do not appear to be impacted, it is preventive to ensure them on
>>> the program order.
>> I thought you *actually* saw xgetbv() be reordered, though.  Was that on
>> a buggy compiler?

No, sorry, my earlier analysis was naive. The #UD was raised on the 
non-XGETBV1 system because Objtool didn't process 
fpu_state_size_dynamic() at build time. It was only when the TILERELEASE 
opcode was not given. Here is a bit more detail:
https://lore.kernel.org/lkml/aa3ff0f4-d74c-2c84-37c0-0880cabc0dd4@intel.com/

> 
> Actually, reading the gcc bug[1] a bit more, it says:
> 
>> However, correctness here depends on the compiler honouring the
>> ordering of volatile asm statements with respect to other volatile
>> code, and this patch fixes that.
> In your case, there was presumably no volatile code, just a
> fpu_state_size_dynamic() call.  The compiler thought the xgetbv() was
> safe to reorder, and did so.
> 
> So, I'm not quite sure how that bug is relevant.  It just dealt with
> multiple "asm volatile" statements that don't have memory clobbers.  We
> only have one "asm volatile" in play.  Adding the memory clobber should
> make that bug totally irrelevant.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

Yeah, now this patch looks to have created more confusion than fixing 
any real problem. Let me drop this on v4.

Thanks,
Chang
