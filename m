Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D64E9CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbiC1RFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiC1RFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:05:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57862182C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648487047; x=1680023047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0NsJ3Std/fysO7DaEWTzz2gMWesKhdWMjMI3QKEei44=;
  b=U25FO4t5NuWAxnkmTFXFnNysEUqENVnytLUyVkADIeUkdLTJ6rz1u4L9
   q8CU5I2qOjAHe3gRoCUb49RhH6HKwnT6SO28NzGItW5gqDB3kCfXPKv45
   49uCC/C+2tFoqMSPriESvsa0cB+4HmChzJChY1KHn3+2QinCIAHPFoOgM
   o7zisYcb6fD8oyTZ4sxU9P0bFWUYIb7JhSyF87z13X08wC0/hoR5wWNsS
   a+8ASBoeQpIdsb6RUGkGCnDHG+tEsUuisfo+tiOo2NIM87C6PBdvRzGak
   xzmE9ncVDGRvE/dw95dj3MqiRVg7dO6WrnjWlTdE7HNZVflNZg2qtpm/v
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="246542146"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="246542146"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 10:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="719186462"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 10:04:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 10:04:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 10:04:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 10:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBXJTkQXdEms4tc+u+VlV73ERSDqVqhGgTy6IEaGSKDOxno08QfxTRpLY7MczyeL+rHu6/MLJJij6xGgZxizRV/3jHMlgiiLeCudryQFKR7/tc9q5fSWhsTyOy1WpFWaJsO0WvVFeQFn2BaHJp+lDCrvKNeT2au/8NFPBau9v8uu4j5qyNrjdHDgyd2tSLMnHFzEaCOFeLCBW7DoMKL+5cvlad3i6xM8XeQKFYVeKiVMZJc9bFhukPFiR/KelCgeWYpxIUxLnhVjeAoFC0XHJY4mVI3As/zYM6F1/l/gQXKIfBTJhjaGBntdDDtxIENE8KcGcBIl16TmrWIzifotWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz245ddxf729dvUT8ztIySahPrikUYyPTeB9EwyPGPc=;
 b=VBMYe1QTJdGTYCfR3SHU67bQMpav9M+M+GIGkRp6tBW+BOt2p229EehBos7HPLUqr+wE9HWKafVQSiEwELZX6POTek05htnLBoGR0rLbHF1Y0zI82MwcEhmmaypKEobktqBl1AsSNqk3LMSUNjweZRrQsdgUgPAJVKZeTx1AgKxAI5XZqCgEGu6Qb86DzrTQTy5+avR9yPMBFbn+kclL7dMFClOGY5kNH5+D4yYZeQoVjkTUfH9b/HNcbCFYmUC31M0575PecY2KqIC6/BZVfvJ9bdlElld0zf0q/8c9WX5YZkroekF3HuiloeJtiWZmFDS/e1vvKlVsZQ5jFIuBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Mon, 28 Mar 2022 17:04:05 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::a58a:5426:1c6b:6050]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::a58a:5426:1c6b:6050%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 17:04:05 +0000
Message-ID: <26ad86ce-a382-1a65-da78-1c2a03c01a6b@intel.com>
Date:   Mon, 28 Mar 2022 10:04:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH v11 0/5] Add driver for GSC controller
Content-Language: en-US
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
 <d318c7ce-3b9d-0a61-e501-52fd43b77f8f@intel.com>
 <MW3PR11MB4651A829B5849D219B355D15ED1D9@MW3PR11MB4651.namprd11.prod.outlook.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <MW3PR11MB4651A829B5849D219B355D15ED1D9@MW3PR11MB4651.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c0b12b-c63f-4e4b-1bc5-08da10dcf719
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB4914E249F79D1F356DAF60FDF41D9@CO1PR11MB4914.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AOFhzabS/wcLf+rDZkG+b+v7coQgrJI8RvqcBlqi/r9w5kzuLqRxlERrwOmitMm+MrlkTOJUqGbrnmwjSAaaxIrgpjmg0FftKsx0RuZ0ZiVM0QB/FOey+hSEtBZ+U04+8u88MnjD/N9Bd6CpL1hrgrs92HdOC46dKSbkk2CJwWI6YTqh5rzMYEsaLzZTxUwwHeg8VAxcTI3Wep5mK4Sg7Z93PFuLQivFL0JnJn3qvLtbzNO+53jOMk4qG7veaWKf2W65IqvkS6o8teAfZrjgtsjdVR+VMcom0PW2HACFlwvpTTfbK+TfmAXCphAlw+piT+mtU+IKheuJW+8yDA8emhKi+p1qAXr5OfOompmh1UPjkch0vS/c1rZLmLxzSVhr530c1yhYBE16nJQnBl0x4Nv2tgjqzIGq6L4CANvvoZVpIV11Qen6CIy6i+lLQdv2CE1c09C/UXtyGfokhUFx2ya0dGtRqLJW2cdIlXxNP0iXwGBa2WLgPIuAdSaV9/oZSMxhC4HwfsLLU0bUEbKk8R206aSd91DkBbyhcenPQy/DGmgBemcxY2oqoFIfyN2BC6k6VvmHR52jpPJjSmI13tCCNKJlItbVmnpNFSySZG2KqB/sopdygalGj6ar4ELWSW4KOMI1yMidRSww8I/A5LLpFuRUt6VsDLUAYfDVsKcsU3jYZEIFwxE27vy5M+JXDBi80YK5ycrG+BsInXK4hInyrBJTDAvid5zRGnuGuSwrKylI62bJcQb/4OwbB5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(66476007)(8676002)(316002)(4326008)(66946007)(66556008)(921005)(110136005)(54906003)(82960400001)(53546011)(6506007)(5660300002)(2616005)(83380400001)(86362001)(6486002)(8936002)(6666004)(6512007)(186003)(2906002)(508600001)(31686004)(36756003)(26005)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDd0VkVud01SVjExQlVObTJtbjd4WWJnQktOSkxQa0xER0hLeFROb2RqeXUx?=
 =?utf-8?B?bXo4SVVtWU9BR3ZjK2hTZlVDOHhxaU9Gek5xcWgvLys3dXBhUWlvdFVPa2Fa?=
 =?utf-8?B?NXBXT242Mlk1UWFBZ3o5Q09WVk5CYzExaFhJL2xyazZvNXpZMzN3S3k5NnUy?=
 =?utf-8?B?MDdVWlZ2VlV1bjBSbjFFT3g4alBGMzY0M3FyeDQzTnovdE1taEVzTFVrMVdm?=
 =?utf-8?B?WXUrb1NFZjhhVkMvV2pCK3JXUFg5ZFZEUXcyVUJUeVN2MmhBOVl4QjBkZW9x?=
 =?utf-8?B?Qkl5WTVoSUhJMDBvS09uOUtsUmlmRnQwK09UN3pzbDlRbHNKWUE1RTZxTndQ?=
 =?utf-8?B?VngxRFR0TXkrNEJmU3N2bVkyQituSFlZTVZ2SlJPTTZObk5tWGZaNzhWOUFa?=
 =?utf-8?B?cEdMOWNrTnduSGZLemdZaTVoQjJqeHNVTEVLZm5ON1VWZ09xaUlnVFZ4MHNx?=
 =?utf-8?B?Z0xKaVdDQlYzYzNqR1BJMWIxSERvejdzZ2g3bG1LMFl2dXA1N0hMSWJZbEdF?=
 =?utf-8?B?RFl3dnlrUWRTU012cEtaenRudUtJUnJKT3g1M2xDeVBmUWM4VFRuYUdFSENP?=
 =?utf-8?B?UTZvY3cxeTZrNHJWQmtzRWxLR05VZXRhWmxsc1pmZ0N0Rk0yanlSUXRZbVV0?=
 =?utf-8?B?TmF4Y0QyUWdnM3M2QUlFY3Btc0hqLzNQWnAxdUpMWCtKaUR5N0RqU2tVaENo?=
 =?utf-8?B?cDNJbzRMZTdWOWFodkUxVXhGNWhiQ2E1QllMQXdZa2RkRFVJcVhRNklPNWY0?=
 =?utf-8?B?ODBMZGRNQ2pQL2o2LzBwZWRRcU42cHRaOThySDQvTDVDZHdGNitsQ1BhV3BI?=
 =?utf-8?B?a1VWU2YwaElXSWdPaUhPTTFpT253RHN0M2U1SVAvUSsrbjRQcG9tb1hybzlX?=
 =?utf-8?B?dWJibW1BN1A3cE10aEtpaXQ0bldxVjNBQlhFbkpRYmk5ZHRYRllIbi9OR1lK?=
 =?utf-8?B?VDk3b0dUL2J6LytGUW5WWGhNWkp4U0pqTUpqbFJoVHQ0dmZNNHI2TXlHOUcv?=
 =?utf-8?B?QzRONW1LcnpDTlJGaHlrYjlRT2w1Z3IrQ0RlTnFGZCtTQTNYTVVFZjE1MndG?=
 =?utf-8?B?VzFNd0ZrOUZ1NE94UVlUWEFHTDVva1VoazRLQXhySDhCM3llL0FrRzd4a055?=
 =?utf-8?B?WDJNRU9CVHNDQ2RsdEhYdk9zbnIzbVpnUld4WHh3M0tsNnVoL3RMVmVXVDB1?=
 =?utf-8?B?R3BLdmsyVUp2dUd4K1FrNTFJZEdVS2puWk9GbFNSSGtzNllkdVlXQTEyS0Jm?=
 =?utf-8?B?Z2E5K0h2aFFaUHg2Uzdldllwcm1lS0Jkeml2Y1VKaFQ2c3VKaGsxTG9QS2lU?=
 =?utf-8?B?L3N1Y09VQXhBaWY3Q3IzYlRDK3k5V0tlWEl1enBEdGhhSG9LcllSZ21nZVk4?=
 =?utf-8?B?cjJaUWhmblRGWDRtcC81aXljR0VudXFqWDA3NmVJT2pUNCtYb1l6RzZ6a0xz?=
 =?utf-8?B?Z0NybDJtWDE0K2c5SHg3dm5CSGhWWXRhc3B4NWFmdDl5MGJpQXpqd2w5UUZq?=
 =?utf-8?B?ZjFjMnlmODBNSFU0aS9od2RaSm5nYlZEeGpEWDNuUXZUbjBVRzlRandhaHZT?=
 =?utf-8?B?U1hMckloZ2xFU2tCc2QwTXF4bzBEOWpucnpHMmNyZ293SGljWkk1RldURUwx?=
 =?utf-8?B?QTlvSXZOcjBLQ0tTM0VoNW5HOWswNFJGbUlBRU1vaGdmM3E5YmZ4NFcyWXV2?=
 =?utf-8?B?RDQ4Y0x0eGwvWkZ3bGZMejJsM0tvcEFYdS9YNkZnbjN2K2ZVNnhrTGdyNmhK?=
 =?utf-8?B?Wnk5WnpUa3V6cHlBM015L21jYWlLL3J4RytWUG5nT0h2VzhnMkRJeWJ6cUFp?=
 =?utf-8?B?bEJqTWNTUFJIK0VsdnJrR3BtSnhhTi94SExNK2YySkYxNGpuZ1ZFbnZlQ3c3?=
 =?utf-8?B?Mm1mVmxKc2xMZThNWW9pUU9CUU9mM0UzZ3A2UWdFNWlwd2MxaUxOSkpPbURm?=
 =?utf-8?B?M1V0djZKMVVIUW0zdXlCUVZGV2dOSXBTNEFHOTJIRmcyVjRYNmJYdHE5SVlI?=
 =?utf-8?B?N1R0VGlNNFI0ZkY3R3hkdmFnQlkwa3U5U281QkdRR0EyWUgvaW5QQlZqNUFs?=
 =?utf-8?B?Q1RGc0tRRUVJZE1xeTkwWDRqNXJ0c00vcGlFQkdwTmJQNE9hb1BmOGZwR2Y2?=
 =?utf-8?B?emNRK0JoNG5qSFM4RzRSUnlXWFRONllBb20zRWx1OU41Rm44bStXQXRxdHEx?=
 =?utf-8?B?UVpPMTJwaXE3a2dpRVl2bFllcUhpYThPYnFaQjJuRzRSUUFVVlBsdVhJMllK?=
 =?utf-8?B?N1pYRnR0ZGQ3TjFMQjlycEZudFFLY1YrcEFITEhTVmxFQkttVUF6QkNma1cw?=
 =?utf-8?B?aFc2STdRdzhhUUhDdVYzTVR5Z0ZkVCtaQ0ttRUJmQ0tUbjF1VzdnNnltZjdl?=
 =?utf-8?Q?XsMpie2oG9fhEI7eFojJAbHTgNlG2pZw5ahv0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c0b12b-c63f-4e4b-1bc5-08da10dcf719
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 17:04:05.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgwVzmZ/4HtrT9RiThrr0zyn/QmWVKxMslOizSDP2qdO1KoUA7cXAZjmfHR47d0NYQE9m64flc2m6ZYw963EVdAl3RAyhL83Foldun1FJQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
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

Hi,

Yes, the series doesn't need an update, but on the other hand I don't 
think we can update the config repo before the new config option is 
merged, which we can't do without first running CI with the config 
enabled, so we have a catch-22 situation. That's why I suggested that 
you resend the series with an additional debug patch that enables the 
new config option from within the i915 kconfig, so that CI runs properly 
on it, but clearly marking that patch as something that is for CI only 
and that we shouldn't merge.

We did the same for the mei-pxp config (here's an example: 
https://patchwork.freedesktop.org/patch/460925/?series=96181&rev=2).

The alternative would be to merge an update to i915-infra kconfig/debug 
before this series is merged and re-run CI on the existing series with 
the updated config, but as mentioned above not sure if that's allowed. 
If you can get it in then that's fine for me.

Daniele

On 3/28/2022 12:39 AM, Usyskin, Alexander wrote:
> Hi
>
> As I understand the config patch should go to https://gitlab.freedesktop.org/gfx-ci/i915-infra kconfig/debug, branch "master".
> Thus, this series does not need this change. Am I right?
>

