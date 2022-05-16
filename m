Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17D25292B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiEPVIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349093AbiEPVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:08:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B3CD5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652734285; x=1684270285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IjeE3ZhGFtcsSAG9HkCN0OJ2lv2AexO3LyxFJYAxQM0=;
  b=GmROrgVOPXVhy+2k+UBkJIScRhmn6yZ9axoIcKuZ7td6oxQT3aCsI+O0
   8PB+rrLoOdkW+LqOQCnEtSVfxuG7JhyoJbHGu4zd+Clu3Fb9RfW0tb4wE
   MNSHATMWDq3iBc+5KisGu3cEQrLeYufVszF4hlUi8xnrsAnYj0URLhO2v
   NJABosHdekbkGyOwH0eZeaMJVGoMDib8eEwll4d+464a9m6Atxbfck0+w
   In272SFq/NgH3VMMvshaIaaSMhqLMPOA+1YjWmem76c4RrLJSNYblmgfe
   N6VoWUxqxRcc+cTHll1GWYaBPI0VrlnsE3/NqrXb5BQoxhb8m7cDE0VFr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331573829"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="331573829"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="713539323"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2022 13:51:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 16 May 2022 13:51:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 16 May 2022 13:51:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 16 May 2022 13:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0KNwE0H64EnK1Cdtj+hPtOyZ5NDk38vVyZO1hodxUTJz0xCdjgym1dkOVkqdJh8qTiamgl45jZRA/tjISF17UmnU5m6QbEzZ0eawGkQ2+GvBomQ6HjqvQtcji4OiT6il14RL7fyUtSMYBl78klgvyFEEeT8OAdkhtVbcR+/4oh58bMPfrqiUlk51cK6WzE0/QmESNglvm9E0L4fwv2Je4ImwmbjsyHaNUEq93fOwcFjZ3qbt6yyv22XxV0v1ek3J/ShiJgbLCAhQSVoGVUGEVgP4n5SDWitarrAhRMNUCPYcC3d11ffwwpFkElV26TRD/wzBP+GbOoAdfdT/n4LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV5NGxTDyiPsHm5n5hqleLdiYrqC+ZgTRHsFYy8wxHM=;
 b=nhc/tjsHaTAJ5Ef2pla1Tm3HUJwNysXQimT0ZwQVW8WLrhHTcutH217r4LGRiqflPd9appZXWtBgqB0g4lA6Vfws5XI2yXtXJ1tXeVTftdeiujLWngw37+TGF3m0hYlsrKnF3u0xDiBGUxOtvCGAn19DeVLZGJV5Lgj5T7OJBXXPVz82k+cDv+ENlONk/HEQqxb/L2mz+OKRuqifxUUrXd8bdG6j3BccX6ZOtjLeZjGBgS/IQYtC2+2FV10cRFCBuP+g9w2h6I3xV8njiFzMFhrJiw0YuI/DzIYlrafdHA2r5shGudI+tUsvwPvV8PSZ8FO7yBoRLTp9CtfkBitaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN7PR11MB2770.namprd11.prod.outlook.com (2603:10b6:406:b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Mon, 16 May
 2022 20:51:20 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 20:51:20 +0000
Message-ID: <be0242fa-82b7-d362-1871-ad02992c70c9@intel.com>
Date:   Mon, 16 May 2022 13:51:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/resctrl: fix min_cbm_bits for AMD
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
CC:     <linux-kernel@vger.kernel.org>, <fenghua.yu@intel.com>,
        <babu.moger@amd.com>, "x86@kernel.org" <x86@kernel.org>
References: <20220516055055.2734840-1-eranian@google.com>
 <ccbd2401-0de4-d4e1-2e41-92865113560d@intel.com>
 <CABPqkBQcBGmbyO2QTxnmVWwuWvk8brFaXi6J18xk0EyB70ZAtA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CABPqkBQcBGmbyO2QTxnmVWwuWvk8brFaXi6J18xk0EyB70ZAtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb4d9c7-d31c-4d59-7ee2-08da377dd443
X-MS-TrafficTypeDiagnostic: BN7PR11MB2770:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN7PR11MB2770DAD191D36008AFA6D550F8CF9@BN7PR11MB2770.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1HsEKVMUQ09nYBwjrdSqS6mL/CZjehPkM6+ZM/xU3Gd+WG9LVfUzwGAD51s2FPMN89tXEpq0KSgvMEZ2gzK5TV2jQ+O796s8YpBBVLt08HrIitKKCRZc/1qi/Lb8Gvqmu6z+81GYje5d8fB+Fw8LOobGB5ehEr2W8XDhF+EqC/Ggwxy2J6llfVIFuXweR7u5VrZEu6JgqpQkO9ws5zeJ4DlaR5QrF1L5+ZbkGZV+t4FbZRDUFLvQswfW5rTvdlrv7U2FJC06D0EAFoPP1Tn1oxlyJyz5y+NSogiqw23p/w14tZ74zs5rl7zkumuWpLxsqkv6t39Oi0YzNBqWOyeVCvUKf8O5NcfP6x59gKesps9xfVVgk+kMQqqKFBQseKuhWKmfQPqMJ50GuRhkvB6h2leBx1mE/hRDBRvrG/sX0NymqAP0NzvK9q9yc8tMOnxayRJvElUp4gg6lMkZFDnChffad0i8VE+uJbcHp3aJSuz0NVpJMRSAJ1Gi/j77Ap5ki5pWh6pe/HEq1jyGi7Vu7/FNdKnURFnQg//b9PYgc9Q7Unq3pzyZy0ybcqvd2B2voX1gZsSfx/9yyT7h3c8G32OjZe+2CQKcEU/inKc75OHR6mbH34LPqxyTyABWO526nKZPSuO9XYpvk9f/GF9l/U1iotJmfuC426Yo3U/tAn/LO5FtA4IlnvdPaRaBIfwhULm20uOfuAuw73b7T+VHLLq33yMQA/wewwH/3ICcIiduwBBT4DVohO/kNevN6sF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(31686004)(6512007)(6666004)(2616005)(316002)(6506007)(2906002)(6486002)(53546011)(508600001)(8936002)(31696002)(66476007)(66556008)(66946007)(86362001)(8676002)(26005)(4326008)(82960400001)(186003)(6916009)(44832011)(4744005)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWV2K3pxcnRuMWN3cVZmbDd2UnlaZXhoM3VTUE1idTJLaWRKMnFyYlJ6TGdY?=
 =?utf-8?B?L2o5bVY3NmEzQ1JjM0tHcVRwODB6QW53WHErczRjT2hHV0Fxc1I1WnRveWRS?=
 =?utf-8?B?SDdBRTBqdWZadWN6Q3RMR3JuSFd5Mi9DcnJGVmN6WGdwWThwcEFkZFVXUmlz?=
 =?utf-8?B?QUNxWFFqZlJPZis2K0JJV09IU0RKY2NCVFM3SFcwL01LbGVOVzV2M290QWYv?=
 =?utf-8?B?Y1gybDZRaUFXNjh6V05PN0VxUUN5Qm03Rk52QXQ1VkVBOWZSc25VM05hM0s2?=
 =?utf-8?B?QklpbSt2bFJhQWV1eDNUNXJOSGViVDI3S1NDOGpML3RWNC9FREZURncwS2w2?=
 =?utf-8?B?VFNXYXdiMHIwZDNPSEw5Y2hnWldNN0RhZWhDVUNkWlZ4TVN4eWZDYnpDbGlu?=
 =?utf-8?B?aDk4VTJqUVYwK25kYlJxQ0FScUgyK0I3YUJTN1pVMW9FZEcvbjZlK2lBWUFa?=
 =?utf-8?B?YUY2RnJwQXRlT3lqRSt3WGxDTlU3UjJDMEpmdDVEZ3VzdktjRUN1UGNZU1pQ?=
 =?utf-8?B?dHV2ZFZvejFoQ09zY3RBSDI3Z1FWU0I2dzVPV3dBVnI1cWFVTkI4d3FNTmdp?=
 =?utf-8?B?RG82UlJoNThSSzA4UlF2dmg4KzJCb3Z6WlJuWEZoTVZJRFFyaEprM1c2MHR0?=
 =?utf-8?B?MUdldXBaWlYzQU5zekFGNGNFR3ExbThNWWVnVy9qSEtDaGpDSXgrL3BOQVhO?=
 =?utf-8?B?LzNxaFlCNlZkNDRLT2xXVm1BNG9oTTFDT2xGWWRkMGFDOFFMd25vbzhsS1ZT?=
 =?utf-8?B?MHhrM1NRWmoxS2pmTVpucDF4d0haUG9rUGJMdXBCZ2t4VCtDNVhCM2ZPenZk?=
 =?utf-8?B?Sy85alF2N1R2WkdybnpDRU43ck1KMnJQK1FxQ0FJdEd5OGxIeFhPYjViOURk?=
 =?utf-8?B?cDY5VEMyQ2wreFBta21iNzc1aWFoMStIV1J6a2hFMUhmVjcvS0tjS3R6VFJw?=
 =?utf-8?B?cDkrM2EwQ2N5TGZyTVA0RnYyWGpGRk93MHRFb1d4WDZMQzgrSkxTYXJKNGFn?=
 =?utf-8?B?MDZvQWg3dE9KVCtVcSt5VWhPS2Z1R1lIQ1RGZmxhSjBMcEVQZ3dZUDlRWFZR?=
 =?utf-8?B?c2hUT3JkcWhHSDF5NGVXVHJpdDN2bVpqQ2lJajVjUHhLa2VXbEJrT3BOR2I0?=
 =?utf-8?B?TlFkZkxqZDR5TDRFek1UUE5IWFFWVk9EY1A3RWxJMnYraTJoMysrN2c3WmFw?=
 =?utf-8?B?RlpRQmFHY0JrVjl2bDRmSXBzSzdBckFtVHJHeHh5QXM3OUdlcldZTUswTHdv?=
 =?utf-8?B?dE1iYXZ0dE4wMjZnamtNVVZJUTNjQXVyaTBKOHB3amdFOU4rbk5kc0M4ZUN4?=
 =?utf-8?B?Uy8vR1Jwa1ZLZ1NYZ1BWdVRGNk1TUmMyVlNtUkVJeTJiVHJieXljQXFhWWRR?=
 =?utf-8?B?ejN4dzhENTFmYUVycXA0T3FBdFFwNi9pT2FKNW9oa1h0cmNhcVpqN29Eem0r?=
 =?utf-8?B?clBBU1BxRmw1ZUtpTTBHT2Z2OUh4d3JrMXdYdVB5WjBIMHRuT3dmdzVxMkpP?=
 =?utf-8?B?QzROS0JMM2loMHpoM2JVNyt6MGhSSlkwQVpYSkoralhSZ1ozc3hPOThBNWdk?=
 =?utf-8?B?UG1JMXhSZlNESkd3TU8reDhudWxzMkNId2I4TmR3TmRXdm5JVDdqc09pN0tQ?=
 =?utf-8?B?RzA0WU5mSjdIKzdJdVNHdG0wWjhJdG1mazQxeWU5bkd3UkJ5OStqaVNtd0lE?=
 =?utf-8?B?eUJMV0FHMlpsaVg2Mm1iZGlCN1d0L0xyTlU3OW5jL05uVFY1RXJtdXRKekRh?=
 =?utf-8?B?RFFTNlFTQmYyUHZaUmFQNWRJei9PVWNJamxqN0FoUk1LV2ZJWnVTWitJWkV5?=
 =?utf-8?B?TXZCQWQyUjU4SnNaUXVYeEJ1L2EyeXRLR0xHTU9iNXQ4RzFPQmlLdUowS1hz?=
 =?utf-8?B?RDdqWHJvUEo0NkJ0WFM4R2x0cnZOc3RFSk8rM3VtY3R6SFZlN2wvMnRTWkgw?=
 =?utf-8?B?TGZuaFBORHpZTEx1OEJFUENQUEtMQjNxRjFBZ2NRR21zWVA2YkRCQ1JQSXFq?=
 =?utf-8?B?c3RZMk02YlVmc1dhYW1nZ0I4WFpONE4yaWVTSXFkY2ZNcU1OQWFodWxoVDF5?=
 =?utf-8?B?OFZqQUZIN0tLaGs0VkREQ3BTQVdYK0NIenArTmN5RlNUVVpHTWMxTnVPc1dE?=
 =?utf-8?B?Ymc0b0V4QW9zakZnajBCNFpucDhnR0gxaEcyNk5Obm0zZ1RWcVZkUmROSG1O?=
 =?utf-8?B?UFpJcTladW5wU2ZpQ3R0blFOMzBFT25ZVHRlQTAwdXpPSFJGU2J4NTZRTHl0?=
 =?utf-8?B?ZnlGcXpNRElUY0tQTURCdHJMd0ZCWFE1K2RHdHdaTmFDdHhaNk1TejllRjdF?=
 =?utf-8?B?WGYzQW93aTlWSmFpWGpwWmE1TGlVakg1ZE1CckRhZksvRjg0NGJDNjdzUkN6?=
 =?utf-8?Q?IbauHTahjIDsdLfw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb4d9c7-d31c-4d59-7ee2-08da377dd443
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 20:51:20.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHWEI4gqPbB/6eV+o6j3/6wLMNjaS66VhrfsUXahxuCXa3mcW8zOV7EWJUE7rS4c7KjZI3nBzJHoDF5LWGitc3ic2uXFjSbVWQNTYnYLzo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On 5/16/2022 12:07 PM, Stephane Eranian wrote:
> On Mon, May 16, 2022 at 9:35 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:

...

>> Thank you very much for catching this. While the fix is onto something
>> I would prefer the fix to be obvious and not a side effect of bit
>> checking in an empty bitmap.
>>
> Are you asking for me to add a comment on the modified line or are you asking
> for a change in cbm_validate()? There, I could add an empty_bitmask check to
> that if.

Please check my original response for inline comments to your patch.

I am asking for a change in cbm_validate() and my response did include some
sample code copied below. 

>> Something like this before the bit parsing starts:
>>         if (r->cache.arch_has_empty_bitmaps && val == 0)
>>                 goto done;
>>
>>         /* Skip bit parsing */
>>
>> done:
>>         *data = val;
>>         return true;
>>

Reinette
