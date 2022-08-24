Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7505A03DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiHXWVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHXWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:21:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC397B1E8;
        Wed, 24 Aug 2022 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661379665; x=1692915665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=arQGPfHWdWi7epPrhnSDqdTK4MkQ+HcROE97H8som88=;
  b=ZYV2i9NwIv/89mN1kb4QHxfdE90vKsChSLwbwulR9yITJqbVehGl5os/
   eWNVoXOY6nM2s1Yt77WLJmyvTkZ4vgQFsoCjXHdJhGUCS47dXnjj/iGMY
   9Vwe9l1HrObGiK/38wqg+lMvGAmWALd8hg2B91BQPQ90rOzVkwYCfBl6r
   /9ReIphqHMV01T5PVSF/FEPJ8OqKn91pFr8eBFtJKLZaZnFGWa32P2i/x
   vKFOQVv+618qGmyhkd/MeDIXSwbiB402IOloUZ1FTkG91LYroHckgPcH2
   mdfG9KPCXPUmRwPPVQ62+UkUw+9/QHn6tXyO/7lURAQixuPVYGzj4RWGw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355815351"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="355815351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 15:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678217634"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 15:21:04 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:21:04 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 15:21:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 15:21:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 15:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijaPW69iMSwbBW6GjVAG4xH0HxWIInIKwTzez9A439xbuZUjY8bbvtKrS/BSdsPe3QOWB1iPbVMTwmME9Z7PAMkeWv4AEBhy4/2uG3rJuHn9WCNkp01tUAdDeIpQTw/GUjfETGYe2MEuf2Qp7zAd4lzzKnTUvl19A/thqx3ACjxRQjGzYQtJWZNFrh1e7ZUTqrYAR8F7J9K1XeJbswtgTQ+vSWzpXQ5CjUwkLQUodMivoVwgG3/4Tz4leDnh3Ai6Hu4tNa/dG3sxsNTFaqXST8NePZPdSNUbSFlL2HSuLdrZriqqs69O+B/IAOXl/8bARRZ3BCN5IjTUVyGU4eZjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1Qur8TgmtwEUnpv3wDLQa4Mg44S9FetzP0PGFx16vE=;
 b=kHvY9FsCCQJCQfNZTt3EIbt0pmVp6+M+eU9GXsV8DhBegljLMDnQ4u1oiCZ8Pr3sbgMbFS76hRlKascrniaRAym4c1lcX84+6TMsuc9YoF4eNwWMn37O7v/jXq9wZHf/Vlt1vQVN0ZcjlzhsI/6fBu7o0LXuOC5dtYF2NQGLhi/KMknFuPBExqd6wAxLR0jnuOj4thg5q/HbvsWhXZYolEtEp7ldeh9T7xC0X2ZNFGapxnNW5B3wAgh+8eDdWEGiN/CMtJEFhaA8luBkrVkOKaC3QuhBDuGfKT3B5Rm7xzcOO13LrMSdVZ9lwFcSdr086G4DMDsL/42NcE5ie+B/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM5PR11MB2025.namprd11.prod.outlook.com (2603:10b6:3:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Wed, 24 Aug 2022 22:21:01 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::5d13:99ae:8dfe:1f01%3]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 22:21:01 +0000
Message-ID: <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com>
Date:   Wed, 24 Aug 2022 15:20:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Content-Language: en-CA
To:     Evan Green <evgreen@chromium.org>
CC:     <linux-crypto@vger.kernel.org>, <dm-devel@redhat.com>,
        <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, <x86@kernel.org>,
        <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
        <bp@suse.de>, <dave.hansen@linux.intel.com>, <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <kumar.n.dwarakanath@intel.com>, <ravi.v.shankar@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-8-chang.seok.bae@intel.com>
 <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3cb0346-b3a8-445e-8472-08da861eed45
X-MS-TrafficTypeDiagnostic: DM5PR11MB2025:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yw5Hplt1riAcImspqjqyWRzTECF2A3TDED+ouTPfOjRbZ/fj9gsI0JDrVvSMgR8VIEdH3M7SqXuc065ZYWeRAlEexJ4apG5RnruSAymBkbiSg+uWwLoAQNiFn34W+BFn2puChmFtmvT2I7st7x3qJM37R3qwKDyFS6fGsjFa/2T+QrtQp+LIhq8MSrzkCB/aWDTr37ghptUq344w0AFYYhmSJM8fTJ9/ZFASIeIlti4EejIkHae94i3VovgqhrbIU+i6YGbQfiThxetGWaxY+JCXbj0Yq0portvTPz80Cl3Il8loxDCnSjH7+yDEFmWf/ltjJivzPrsltqSCnMjGZdeEAr8KoPmhD0+vM9AfI+9MQ+ufVoIpjnzW1TPdbJGnDqikDh6FCQ+i4ovpCOXD4S2Oh+I3qX7rjB6FKZ1SxESF+ZWPjpmsv33oLmSbak+G1GP47kzxUNTjPRSykQML+hYiSsRaVz/+gBaDw/YIii5G9QU77yDwZk92+20j3mCgZKe3bFzDRtkur+mNj0fhKuZrjsRU58wJkNovj6960WxXI7nUXLNXWu8joqtc/NMRn6SLAlktX6ZpiJzqBIFB9/QhG/KKiyyc03tlrRSwcxFdzZNFVZYzT33vg5doCRlBwMF+7IXzNSuInkmb6qz/0TOkb0BNyIby/5HZA6R9ky/uM98zePGPfhhqhwrGLpbwFtVdJsDy9dTNrmRz/kHdI7LkY/8Je4O38JhyxuXtyczGv+4H2W6Fz5wt78ZFw1+AT3m1YeJr6glDkjFGbaI1z5Ry1lObHS0UOx7vclzJFGdwgpPUtsLCnxY5aRnfZcI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(366004)(396003)(376002)(4326008)(2906002)(8936002)(7416002)(5660300002)(36756003)(41300700001)(478600001)(6512007)(31686004)(86362001)(26005)(31696002)(6506007)(6486002)(2616005)(186003)(966005)(38100700002)(83380400001)(53546011)(82960400001)(8676002)(66946007)(54906003)(66556008)(66476007)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RqUVRMSEVEeVdlNi9BRnBPa1U0bFd5YTN5MlY4T2JXaU1jMWZKQ01LN2c5?=
 =?utf-8?B?Sm1QdXBEN2x5bDBlRUJZSnE5NXl0LzIxd0c2VitMcWlaSWNaRUhCUDMrS3Bk?=
 =?utf-8?B?ZlQzWi80VXl5bjRrRDVnWmsxMG95dlVwUjNUdTk2Rm93MGFGdjg1MmdrQ3ZL?=
 =?utf-8?B?WnNuWjY5ZDZKMGZmNUppaUVNSnYyN2QwU0ZQNXp1a2NvTDdxZXpVQmk5a3cx?=
 =?utf-8?B?M01NSlNDSGJOc25jY0dLVmRUZlpBbVRPcy9KQVpZNjI1TTVHbTVxSFYzL1hi?=
 =?utf-8?B?L1hDTXNza2pLaVIyTFlDS0hBR3ZFZDdNNlJ3VHVhSlFzZGxDU1FvNHBwRjRK?=
 =?utf-8?B?TEMwcXE2bzQ2cEU3L2RkWVN5SXRUSk1NdjZGVFh0QWtwQUpERkNFZ3JoV1Fw?=
 =?utf-8?B?V3dHSCtDM25IeFFnRTFXQlYzM2YveGVheXcxaTB1MkpaazV4VlVwRUJkeTg4?=
 =?utf-8?B?cm1XZVp2cXVmMTFFaTg4WXM5SDRzMU5VMlFMcVB2cG52MTMyLzM4d1A3c3JQ?=
 =?utf-8?B?OXJsaWVnUDlhYzJGNzYvUVI0b1VRRk5IbEw5TkxHMzRCR2ltajNmNjRlakRx?=
 =?utf-8?B?NDVoNmR2cDE0eGhERjc0THA4MUJaalhvVGNULzlsbTRESFFjMVpDWHhGR2hU?=
 =?utf-8?B?L3JubXVxaExjTDNiSEQzb0FGamZ0Z2ZTaVUxNzNwcjdvai9CYmwwSHFkb09H?=
 =?utf-8?B?aEdQVmNoKzZ5dEZ3VGVRMHdMOGV2ZDdwa2xOZFFMVy8wVXIvQkg4cEJ2RVVr?=
 =?utf-8?B?Wk1jZzZwcjgvL3pTUlZkUzh6bkd5bS9na3VKeTdLTFBIVnVsZ1htck5VVDVx?=
 =?utf-8?B?ejJzVEltcUVzNVEzeEZlMHE1MmV2TXFOdzhENGtsTTBObGpTYStUUi96Y0oy?=
 =?utf-8?B?TzVIeHo2MzBKVVJ4cVNKUWo3SVIrWG4xdmkxUFd2NHloTFJSRUE0b01mRkVY?=
 =?utf-8?B?bVRzYTc3ODlkZHEvTStncGNYRGFZYUU1TGlVblhzYmQvUTZSdjRwMGNmNUZq?=
 =?utf-8?B?S3I5MVM0elkxK0RxTG1MMWU5SVQ5VjBEMVhzK01kbTVlckhLWE1NeWpLa3Bk?=
 =?utf-8?B?VUlJSmhwTTErdmZkRGVWWStneEJmRTFqMm53SlN3dEJ1S2hlRlBObHlia1ZZ?=
 =?utf-8?B?Nkt0NmtHb282L2wvaEVBa0lGOTRESWdjTGFWQ05xN2E2WU1MWFg2WlM4c2Rx?=
 =?utf-8?B?T0VRNkhnaXlGOTEwWllrTi80cEdONURka3NJOHR3aDhCTU8xRkh3Tlh6aURy?=
 =?utf-8?B?NE5DRTdPSjZzQm9OdENCQmY3b3ZPeTZEcW4yY01MYmxxRG9jUWtvTGM5Yk9O?=
 =?utf-8?B?T3hSWGJHVXF6M3Z4Yk9qUjc1Z1dkUE00d0sycjZ0Y0puZ2d2d1M1Y0pGTjZl?=
 =?utf-8?B?VGFvdXRodTBGc29XTWF0aWo1aVY2V2h2bm5ZekFVeUNTeElMTDYxL3RXc0RF?=
 =?utf-8?B?WUZzOXp0eHVLM3dxZVhCVCtHQTlGVWNYSEUvbkNJWmIvVzZYZEZ1MitxNmdQ?=
 =?utf-8?B?T2o2V01XSjZtTXp0OVZvcFhqSkdsbWFnSEx0UGxzeWZtS1QwelpCVFNZK254?=
 =?utf-8?B?cS9YR1dzVmtBNWlCZ0ZlcFQ5SWwwK3lOOU94N2U1U2tPY3kxT1g3RTk0RHdT?=
 =?utf-8?B?Z1lrZFVLZkpWUmdVVVZVTVFJK0tZTnp4bjY1MjFXdG8vZ3ZBWjFHa0Q1ZC9G?=
 =?utf-8?B?UVFnNzJqdHNKckNLUFpVd3RYdlBBTmFTRC94SmhIL1d3Z2hDdnBzbnc3S0lt?=
 =?utf-8?B?Q21HR25WdHlXZTVmak9iQUpPQjkvTmVNeklERXloa2oxdEhvS2RKb2d5eGZX?=
 =?utf-8?B?TXNkbGNXa3FiUUhBYit1MWRwdVdRQXU3SHRjbWd0V3pZZHVUNWN4cFFXRmF5?=
 =?utf-8?B?alU1dUJ4bXlrSXVPQzl3ck9XamJMOWl4R3R4dDJVdkR4YlU3RkpRcnU4cXhM?=
 =?utf-8?B?MEN6OHlMNW4ySHJ3a0swUWRZVUd6WWlxOTh0azQvM1JBMWxWWVBZQTlMWlRR?=
 =?utf-8?B?WDVFMmdhY1UxYWVpUjNTYzVoVVZJS2hKcHlzVE9FclhHbFB0dnEzemoyYTd5?=
 =?utf-8?B?N0tsSkpVU3VjWmF5ZHFHVmF0K09uZXI1WGNaSDRXY2pQWUM2TGRzT1lOc29U?=
 =?utf-8?B?dU5QcFNpaTV6VC8xM1dtVHVia2RVNmIwd2xCeXMvL3JQcFkrUXhhN0lkUVFW?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cb0346-b3a8-445e-8472-08da861eed45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 22:21:01.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcCcTEI7cMUws4TlHhO74zZOltu5KUbRvZeQqHmorTsD7cjaP3g7DT7kkXLgO1Q7INPEBEUH3bT5QG2095GV3NnWC/4TF3VJP+XkbobV0nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2025
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/2022 8:49 AM, Evan Green wrote:
> On Wed, Jan 12, 2022 at 1:21 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>
<snip>
>> +
>> +static void __init load_keylocker(void)
> 
> I am late to this party by 6 months, but:
> load_keylocker() cannot be __init, as it gets called during SMP core onlining.

Yeah, it looks like the case with this patch only.

But the next patch [1] limits the call during boot time only:

	if (c == &boot_cpu_data) {
		...
		load_keylocker();
		...
	} else {
		...
		if (!kl_setup.initialized) {
			load_keylocker();
		} else if (valid_kl) {
			rc = copy_keylocker();
			...
		}
	}

kl_setup.initialized is set by native_smp_cpus_done() -> 
destroy_keylocker_data() when CPUs are booted. Then load_keylocker() is 
not called because the root key (aka IWKey) is no longer available in 
memory.

Now this 'valid_kl' flag should be always on unless the root key backup 
is corrupted. Then copy_keylocker() loads the root key from the backup 
in the platform state.

So I think the onlining CPU won't call it.

Maybe this bit can be much clarified in a separate (new) patch, instead 
of being part of another like [1].

Thanks,
Chang

[1]: 
https://lore.kernel.org/lkml/20220112211258.21115-9-chang.seok.bae@intel.com/
