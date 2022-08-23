Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A759EF69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiHWWrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHWWrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:47:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B54895D3;
        Tue, 23 Aug 2022 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661294861; x=1692830861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mMVqvjVM+yKBdoYmZIzL8uRbqLADNQ0yv+BHb78qpyQ=;
  b=HbPVfjmBhVlTv8/QcJF7DjxIfP432A9T1oX/KEpqD35vV8kavK2W+OfF
   WsOD8i08W9Z2NHg6mUBc7vBn9mEa/k5ehnFKb/lAJWXRx8HOFcsN8x74M
   E2WhF7Lq4fhLxP2D5yChbb3zR6jBYBxX1q2Bcv57RnRbq1NHlgUEc7XsT
   mXQyV7F1WHXrnIhtFGfXbaApf1WRsyI7FxwJs+wBfNMNR7KjHAQZPPXDV
   YK58VbMno3AhP09sA6HT2iTBfJ6vY749KZtCHQbzGfEPBywydfJwymoHK
   mZWtJOSv6C/JAfMDLmAhHzVA7VH7Z019EzCgejBB0+uK98nMym4aTaZwI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357784951"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357784951"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 15:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="612571366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2022 15:47:40 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 15:47:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB0irHjbPUTsErre14ELf02l0QdP2C5H6aN+EmpmJqHUZLeDGKaxlDhNx8W71V7phg++t83b5bmcXQl5swX+pnWXtTwQWVkYe9ssAMLykD1Up9qlMG4rg3uFnEnF7EdeM5HQSpKHzSnzQ2nFoAOHM3syC26Vrj7DTzOLh5mrLCnNm+HlDHbCFMNJzPbdI9iLmPZ+d54wFMEeCN8o5pm39oZ//CsjP5oXmDJo9WSiYdyudiuMb7vPVIxhBvbklHS1b4zFbrciQPWnJ+oqfZbRVyTjFm1JQ5SUvixSWcA+tl8yISZHzrFLG6DZYCdDb5Em3+6xgu+YaN8f4TPOsLLlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6Qyex/be83C0EmcJyRkhg/zN456sLNqZuiWD8vJVXk=;
 b=EmPXr08/7goSG8TZgiWTdqxQ84SK3iYpKcTLPkvChGenCo+n48ND3W9+brW/TZut/bOYu7Ajhr0OEHpMKpxc1top+NDDY9GoYPh4Zs3U8WcjmPtDYqaFbzzUxhaazxWAGnYs52NemvZstv7rOC3qe/L4D1fb2RiAmqzeyZDmqyaoLAm2E3RPRCRHaqz5dkR0IUqiKLYb27RJp1VrcRBotReLb3j0zbML3NZbhkasF8m1ytdZIGwHOeYFES0Tgyo2R8/qiGjv5ZxELkmZAHBlVMKv7aUY1zvc17oAZwlGRsmha0MIJA/eoHve+HUtGrEDU17cFqcmA3/TiCYbtktUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL1PR11MB5414.namprd11.prod.outlook.com (2603:10b6:208:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 22:47:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 22:47:31 +0000
Message-ID: <2b7e3511-8e69-2e47-0f11-7f1014b38940@intel.com>
Date:   Tue, 23 Aug 2022 15:47:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117577662.6695.15496626554784059239.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117577662.6695.15496626554784059239.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d952b10-3b6d-45c4-7cb9-08da855976c1
X-MS-TrafficTypeDiagnostic: BL1PR11MB5414:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +2G2VUTDE/7GJYrCZq9GYmmMr/r4Or0kw4GU2n4GK6lQbkU8RGsZxGXHRdE7khxU0hArbxd8VKKpVcd3O6q2hI4BmC7QF1jkJTrVm7G1NG/Y2NDX4gkqbhK88k7T2pwXbuTn9qxbOCK9zDezkEJv0ZMaeFHlx5CLdUpS6VHHD4PZNCL4SnJM/cTlpJixdSyosGykB6QW6Mt90kHmf8itfhv4Pg3opeor0t1+rN01Ue0sSxzrjgjfNte6UBwUx1XUApM9VuMPJpSkAoYsOkbBDNMmRFpL2cv1t5824YyJDgfyXu3VPh9d6px+IRm7CiyvJ/k/9o2Fv76hjU616ybdBAfEsZ4FiVm9q00vSaSIZnSgMRhQj/fe9rjk9gRWL8FyYdofJ67TSW/SlxvHXGKQkiKR5+DceIRtGsNzFwELI2Fh9Win+Hvznosli1XFkd0lX3BqoP2Vu3y6csduoo5Ji+cu+2NOz0UAaT9eyhOXbLFaOtSkTjC5wEjgZoSwbFlbznoBrQk+W2RR9UDNdV2rjmg2xfve6ORADPkn84tNcBUssAJlkkO8eep9V6Oeh9j2yMOkoESBhUbLtKeNu6/HSdNFhLegEg0MvmgemEFceakyeMeyjWP2nnsp9IYNhNWRcQEdIrp70KMf0A0zPc5Unaum4Ue6qvyn/n7idZ/pH2x9GgvzU5usA0RIRZmwK58VgTrQcjXlxgwyRcKQ49RuP3BYHkOJOt0iwHGyVXDAlx+KeEbkWkgKvIo+/Q3IZ6x/rJ6Sr3/3sAUKuXfSYBm6M/g3OjWxzQ9LBjuPQvXvO6cGY1LiEozkoWomWW/JpLyuxvuU2h8xXObSOU5QZRvczA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(376002)(136003)(31686004)(478600001)(966005)(6486002)(36756003)(83380400001)(5660300002)(38100700002)(41300700001)(8936002)(53546011)(6666004)(6512007)(6506007)(26005)(2906002)(44832011)(86362001)(186003)(2616005)(7416002)(316002)(31696002)(66946007)(82960400001)(66476007)(66556008)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJJL1dlcjdBSnpmTUphMCt4dG1EaUh4K21xWUh5OXZPQUxSU0Z5RFl5NVRP?=
 =?utf-8?B?R0gvUWpjdm1FalNTM2VWNm96YzRxRWNqYXM0dFJqZ0dDMHJqOWV5VW85bHpk?=
 =?utf-8?B?eDBxMm1idUNRMU9tbkx3ZkJyWXhHb2hnd2lQVkxzY1VzalZSZXh1dzNIWERo?=
 =?utf-8?B?OWlJZmF2Umlra2pOTDFxelJ1N3JMWHVBMUVuNnpHR1h6WkJJRmxZejB6Qk1S?=
 =?utf-8?B?cVlmTVB2TSs5djFvSnhlSXVLNnRRNDhwOWpTR21BTXdPTVhnbTE1bThndjJO?=
 =?utf-8?B?czZZWEl5OGxaWmp3bVM0S2Vkd0tUbW9QSm9SYUNXN0ZENHdKNkxQNUNVL1I1?=
 =?utf-8?B?SjZLbU9WQ2hXVnNLN0tYT3U0c3FyTXNSUEJ3NUZSVlgwdllUbGREY2I5V0lx?=
 =?utf-8?B?VmF6OEFsNkE0S0NzVVh2SDVaeVpVR3Y3ZTBaQXBqVFF1NFFkQVRiWUxJREFv?=
 =?utf-8?B?U0tMc3VPZzRYbmtqUVdtT3A3VjY0Y3EvdEdZbnpQUGFYR29jOTZ0dHQ4d2pZ?=
 =?utf-8?B?SG42V3d1MXMvZ2F2czVPdEF2cGRweW9hUjAyU2FqWmR3bG9nbjYwbjk1WmhH?=
 =?utf-8?B?TnhmYmZKOFJPQmYzUmxETklISGl6c0prS0pWNklhVWZTV01hN0llWGdwQnE1?=
 =?utf-8?B?OE1yeHNCVCtpbEpkTldBeHhyUUtQNzBpUGErN3JSNCtvOElybk5pR2JxZnZH?=
 =?utf-8?B?bTB3S2hXYy9lZ3I5V1JjbndxTGVNV3dlaFRHRUxUN0RZUXFwRXdMZ1R5V3lH?=
 =?utf-8?B?SzBiOGt6Ujg4Q25jVnRNUmpkaFhsS2gvUERabjdkV0pVempoR0tJNGpKaVZ4?=
 =?utf-8?B?alZ3REJmRDhEaHlvS0ozTmFtQm94Wm9oSWpxdlR5ZDBYam8yTCtjOTlYL0lE?=
 =?utf-8?B?M0hHQ0R1Wnp6aW91WE5UeWF0Q3JlbHZTemhCc2I1c20wNElaZHZxd25tSGpN?=
 =?utf-8?B?Q2REejhFRGNDVGNEcVl4VGFMNktSUWIwaGxxT0xpa0lGT29INGgrZk5xbURB?=
 =?utf-8?B?amtocHZqUHdEMlZHTWNWQmQ3YW1POEw0S25adG9NUFV5eVBKVjFLM0xXRjF6?=
 =?utf-8?B?M3pwSUZsYTI0NmlCanFjU2tLalBneVlWMVgzUm04Y1pXc1JtSGFYYllTNDVV?=
 =?utf-8?B?YTRmTnpycmdyZEN6cDE3TjQ4U1l5VFVUVWRqWk9FcktwT0R4enRIR0VzdVRB?=
 =?utf-8?B?OGM2ditQR0xPdG5Xd0Q0Q2w3dnlOajNRTHY0OG5yVUhYZ05JM29SWU9rVzUw?=
 =?utf-8?B?M3N0akljU2x4bVVjMXp0b0tDaGtmaW5WK2hlckNaWDVVZHl5VlJFSkR6d1lV?=
 =?utf-8?B?SWRXeWtMZHpRKy90Z0lJVFdMd2o3YVVlTlZZaGZDZm1pSTMzcW4rVnorQUJE?=
 =?utf-8?B?cmNDZW00dkFBejU3QkNpbDVGUEMzZmJZR1JuUElQT0hPeUg4ejJxUFY4dndD?=
 =?utf-8?B?MEc5U2RERDQzaDBFUEJUWEdmSXJpdS9pNHRja3NHTU1YOVV2K0Q4UXNhdDZP?=
 =?utf-8?B?dXgvdUd1c1dVaGJMZ0E3Q1VmYm55NUdwaU01Q3ljZDlXOVJ4akdKWUl4blNK?=
 =?utf-8?B?QWh3WmJiYnRVYmpKYzAzdXBnSFlHSEhBclJNQlNEM3NqcWpNaE5GOTIyN2RQ?=
 =?utf-8?B?Wm1BUTNXc2xFb2tLTXhOWXhBV1VlWml5U3JtNWFML2xpUDZkY05GQ2NqR2hv?=
 =?utf-8?B?VUFkdmQrNDJMY3d0cmFtaUtoRHRRRTVMMXZVVndrbUk1V2RsaHZqd2pkblJM?=
 =?utf-8?B?ZVBwZll1Z1NJbjBUVVgrTDVpVkp5MGlQVkFFbnNwUHNma2VyRHp1QnNaalZX?=
 =?utf-8?B?QlNQS0xpMmk2bjFDQkNKZzJ6THlsdVhZZ3lienBGTWxYQ1RNVTF5Q1pSSm9I?=
 =?utf-8?B?S3F1WWxPYXFsZUpuMytta0JaUkZHWmlCL1V3eTIxcUMxZ2Roa3ZzdElnL3Bw?=
 =?utf-8?B?ZzdFWGx0TW52c1RtMXJIMTcxVTFxUjZtZkRDbzZRMWlWelNOenM3Y3NlbjQy?=
 =?utf-8?B?MTRnYVY5cCtIdEZpa3JENmY5aExMTE9qWlVVNTRhOVVNMmZOMjF5cFQvQlJG?=
 =?utf-8?B?MG5mSGN3TnRvVUM1empxRHhsYklIUHVLUnlqeTc2ZVdJMEF2enhCeUVEVjBv?=
 =?utf-8?B?VWRSY2RIOCtDQnhOR01FSFcvLzk4elFjai8rRlJobEFMUklHRWpkWXRWa0tp?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d952b10-3b6d-45c4-7cb9-08da855976c1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 22:47:31.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WYikChI80JuOvU6W2ELSvTFdL2EiyLkmp1FUder5MQ5oZ5i87WN/QWbMctnTn/touCLfcJJy/9ddHTerd27hmVeRcHu//Bg+blsYhYWU9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5414
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:42 AM, Babu Moger wrote:
> Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
> enforcement policies can be applied to external slow memory connected
> to the host. QOS enforcement is accomplished by assigning a Class Of
> Service (COS) to a processor and specifying allocations or limits for
> that COS for each resource to be allocated.
> 
> This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> 
> CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature Identifiers (ECX=0)
> Bits    Field Name      Description
> 2       L3SBE           L3 external slow memory bandwidth enforcement
> 
> Feature description is available in the specification, "AMD64 Technology Platform Quality
> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---

resctrl currently supports "memory bandwidth allocation" and this series adds
"slow memory bandwidth allocation". Could you please provide more detail about
what the difference is between "MBA" and "SMBA"? It is clear that the implementation
treats them as different resources, but both resources are associated with L3 cache
domains and (from what I understand) throttling always occurs at the CPU. Can both
types of memory resources thus be seen as downstream from L3 cache? How can
a user know what memory is considered when configuring MBA and what memory is
considered when configuring SMBA? Additionally, I do find the term "slow" to be
vague as a way to distinguish between different memory types. What is the
definition of "slow"? Would all "slow" memory on the system support SMBA?

Reinette
