Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEA4860C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiAFG5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:57:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:19237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbiAFG5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641452252; x=1672988252;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4uAiPQESJSqbRdbCyGUMv4zNYyFVIwIIuy1nRnGCTW4=;
  b=JmKhsuQ2VNaFMJGldYXDJXe6IwsZKCcCx56/sUvmz/vN95PwjWDLCdE0
   1CIHiUA+S4OXAU5xmqm1cSdqfkDgsoiHBGr9nrWMFw9E2rmv5nJWFNbf9
   xW55F583HzZrRFh4jkfky60NwLfwPqAIUHMHjheFYTU85pqbS5zrT/kvq
   cviE6t6DuhVHajeEc38j6XK9tnASrxrGsd9DlwDEAFoi0ae0grakJ83ze
   VOo5IWqRW0UEIJb/NTG266q+pdzPUE0NeUPtqSLQu6TUgMTSBzv5RmDBw
   NC+j2w6t3S314+MfU7YPI3r5iorR4f7khhu7BaP25hYBgNTZ8ySqMnn7b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303356130"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="303356130"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 22:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="621425495"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 22:57:31 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 22:57:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 5 Jan 2022 22:57:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 5 Jan 2022 22:57:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTXv1DEScEWp+ujbY9zqZT450rstB2lCdsMlHDaF0wqH2+I+r1x+wH0owcJlTOcKyGx5iyn9tiCz8GS2xQmq+fGfxYvfz1J/80Tifc9NbJ8KNQNWs8Cj25yEX9W8c9RAqBWD1TJMgZ4YmiDfrMuqGQj9KaUiCUeCLot+KMGl7L5MsAnqjND4h96e2IZcqagbQi3T8HR53kopb2D5g4aW92odQR6L/I5bK9pQRlCQ9Sz2wANW9BKFGSOqdgQmHHcyRs3R3fdtz/r7xVupDaH4zEg8LZ41YhlL1uZX86Fl1v1H4nVQVAYSp7dMqVqH3U6y/ppKsNzhQ/wKVRfXlysTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tejIBnB/RRN+5RGUMxGXp9kIjwgmuAkJLcCLWXdMAvQ=;
 b=oShX7Zfbrsib7GYgIo0YJfKOJ96sQuFK8mQ9K8BH88/lb1aQ4nwZAxE3SLtBQl2D9HCe1aCPfz1EHjyHR77rkZAEtVrEIW4eUY64sXFNAfq3UlDvtlRnZZFA6/DZ1VQrl307Z4jCDDis6z8VDNbNQ9TfpiSg0B5q8NKGYiAs1q04VFd0+H89w4LKwcll2mwZEGtnTIfnsFfgTov+IynkejjCQmCy48H3OL7Mi8qtgD3Is2KQL7umwV/zsNQ20yNsBjkOBFJJkoI+nZcQfhyuop6JcBKE+w71GwgWz2lXnldUla84tvlL4waXF55kxgdzFgoS8CasrgmbOhiI2oetOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR1101MB2206.namprd11.prod.outlook.com (2603:10b6:301:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 06:56:59 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%7]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 06:56:59 +0000
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
To:     Borislav Petkov <bp@alien8.de>
CC:     Marco Elver <elver@google.com>, Carel Si <beibei.si@intel.com>,
        "Joerg Roedel" <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com> <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
 <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
 <YcHxKzB3WPurKlZ9@zn.tnic> <a5cb8140-5834-7649-e629-f2775cf5b9a9@intel.com>
 <YdWCstlEW6k45+hH@zn.tnic> <fa2f7d50-5226-726d-a9ad-2c42cb5c4054@intel.com>
 <YdW3a3dUfi5pBaiH@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <0736f5f9-b38f-27e9-58da-b71a596c498e@intel.com>
Date:   Thu, 6 Jan 2022 14:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YdW3a3dUfi5pBaiH@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0153.apcprd06.prod.outlook.com
 (2603:1096:1:1f::31) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfeb92be-849d-4eab-6133-08d9d0e1bc2b
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2206:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1101MB22062AB3BDC978F6E03CD05DEE4C9@MWHPR1101MB2206.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ozw2u3Jt+GIWDyKzZ/+47IzHhVWtLCgPcid086byeGNqpErMxxt41f0ywUHhnAEARLIcYpaRFbz/cR0z3OrrV1XEUBIu/rREmwLDKUhcwniViZ/WpIHL0urWyfxMS1XsusZCQZ+Wde25JSxL3Uz94J/oF+59/RfPyPiyMyViNAvIaWq1YavDbTjRwp5K4LM5gjmkXJJ30L78TeTTwcwMf2Z0Afm0xEukpnvhfHCa1nGWoGxrOPvQKtZqGzTklb5wLMwu1sPuqQL5qYvlThDtMSLUc6YA/7i73d4OCFv/2J77bKiCcUVYxJwYZ0CK7wyy/t8F0c6h4einF9m7dkGhqJ33+1bNtV2FJ1J3bigNsJjdc4CdtIiT3zm77W/DeWV9rUbWej1mJUXRQid78L0xsmgvkjzmKOtLSSASL+bxH4VcV8REXmdXci7xNVgFv8qn1x0Gz/VlNJ8xsF9t62OpA1STKKcnVBMSfcs9p1r/x0M6l4QBrZPlzBi7CRdd0okL5x+m5ME0Sey9NU7+DdVcD1btywK1uiB+IZr9+pintvbNU6fP3Q+C0WdLA5Pdeh4suQBrNynrqoeO/kYKqbu/SZ8HeE+SWqbkVJiJS97sckiJ06+sI3V2g7QkUi3pgBKYu4T8Yob6kT8DeAEZiPsbz2+uY0HZ4TThVqFX4yT1Nt1v/Met6fXaG/4rK6BenReX7YlcXJW1nH+hgCv2ruyD0Gmw7G1kTKvRwCM7Pbsg5Z49SE4LoN2NK90an8hcd/n0lMmTXIESYPrmpY8oVoqRL/yxXd0/E3gwhAqK1GxpKtXcfLW4Klkih6Ej4jc1SynN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6512007)(26005)(86362001)(186003)(54906003)(82960400001)(53546011)(6506007)(5660300002)(36756003)(508600001)(316002)(2616005)(4744005)(8676002)(6916009)(31686004)(8936002)(966005)(6486002)(6666004)(66946007)(66556008)(66476007)(2906002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VPWnBVSEZzdFBJU3NEYmx3akI1UXYxc1d4Tzg1NWpCY05zQTA3WUVNR21j?=
 =?utf-8?B?Wm1kOFFwT3JxZUtwUzIvUlp5TEFWcHVDcnlZbWtvTG5Xajc4QXlHbUlDM3lw?=
 =?utf-8?B?K2pBUU5YdXBHL3dsQzdFZk5wZFhvTHc5K3BvUVNEaGkwZHBQSWJBZ1VsZWxt?=
 =?utf-8?B?SGkyZlhJVmp1SExGVDA2dlFPbEttdDNKWHpiY0xxVWgxN0dzTVRxOTlmZ3BY?=
 =?utf-8?B?OEV5R3ZKLzFEcmlPOG93RkpVd3psaXM1OFphZ3pFaUtER3J3dWNsQmZSY3I3?=
 =?utf-8?B?eEVCNHJZUHBRdVByK3RnUjFuMDY4L3F5N2F5b1ZiaXlFejF1VFRMdDVDRkxZ?=
 =?utf-8?B?TVQraUF0MUxMaXhScUFOVk5na3ZNaFBvZisxMCtjcVJtN2k0MnZ1azlOT0lw?=
 =?utf-8?B?MjdIbzNqbXVodjdCakJ6L1dBT2F2QWJ6dTJYTXVITjdPcjJOY25vbTdEVDlm?=
 =?utf-8?B?b3BnV2pEa1Bnbm1qVUtySXJuaTlQNUQ0KzNzSDhOdDdIaW0wUEZTT09Fd3lG?=
 =?utf-8?B?cGtCUThubTlSeG9xZTNRaUo4NWpZQlpWd2F3QjUySno0aHdpdXc4U3hsRGV2?=
 =?utf-8?B?L3FGUGVPY2NUQkVuK00zQVVXK2FDYlRxVnRhVXFJd0pvemVXR2Z6TjhMWGh0?=
 =?utf-8?B?aXNGRVo5dmhlZk1vYm9XN3hPT3RSUEwyaEhOUjBJcEJ2L3MyNFFkQjZXN3Mr?=
 =?utf-8?B?MnhuWWQvZWtJK0tjcnIzZGtJV2xVMnJYQlVYdjNveVkrNDVtdkE2OHg5TTUr?=
 =?utf-8?B?UXBmRmFsSDI4ajdxL1NCeWcvUVUvV0RRdG53T0RlbFhOcXVRTjg2NTAxK29N?=
 =?utf-8?B?dEVPblo3WTRNZnpUSENLZE5FUWV3Z09ETlJjUkdFZkxPaFZZcmVlWGh5NDUz?=
 =?utf-8?B?VElTak9ZdFZuSGpBMXBtZ3RJaXlvZVRTUzNBUFVBcHI5NzlLczBnUGxGRjB3?=
 =?utf-8?B?anUrNE9yRmZHc1luR2ZEVVg1b29YY1E3SGNYeE9uczROYkpVTUJjNTlLbk9S?=
 =?utf-8?B?ay9nQW1jU3cyakZnajJMdC9XbmtJUEFOU1dPd212WmliRllmT2hZM3FrZE0y?=
 =?utf-8?B?bEdpNml0M2tIYVhTRGFOL2pjaFR1OXIzaXdiaFRFL0pCZnE1L0V3MWN5TWZS?=
 =?utf-8?B?QzV0b1NEMWNYbVJBcTdWQmN0M2x1NklHSlJoMFlzcjlNeEVvRHU4dEgxKzVV?=
 =?utf-8?B?OXJHMUZpdE1STFlmamhJbFJUcVYzUjVUK3FaUUsyQ2xvcVpQaVJKaDMvaFBl?=
 =?utf-8?B?L25RM3NmbEkwQmVveU01R2E3VHRRNHo3bi96ZXZ4S2xxdnA1RFB2cXI5bXAr?=
 =?utf-8?B?VzA1WmZIN2FuN29rZWhjcTlLdDl5eFRZVDBmeGhPUytFbmY5VjNZSkN0RHg2?=
 =?utf-8?B?VDdObVhiL0pTbENxTkxDdTBGbDh2ZTR6d21rd2FnazdQM2EwZmV5d25uU2hw?=
 =?utf-8?B?TUw5Q1NUVWNEbG5OeVJpc3hXM1h2Q0pkc080eXZOcGlONlV0NnpzeXBBdjRk?=
 =?utf-8?B?VnlzNWtNY1laaUhxWG9aM1FBVWJ5NFhtZnovZ2JBTExzZURmZjZ3YmlaRkxu?=
 =?utf-8?B?ZW0yMWV4a2FTUjFmR2VzY0ZZb0JPVk8wcU1mdHlvZ2FqdVZMQXFEQTlSUUpQ?=
 =?utf-8?B?VFZEc3lUQkE1OERVRG5LVUQxMndtNzJqcGlIV0FHbnhpVHZFWFExUVRQaVRG?=
 =?utf-8?B?U0IxWktqYk9TbzZkSnIzVFpSSGhpQVp1ZE1uQnR1dUdPRzdRY1d6U0xxVDNw?=
 =?utf-8?B?VjRTKzFzZEhaamZib3E3aGh0aldzbEd2emx3NVRpRmZwYTlXZWR5TmhySml3?=
 =?utf-8?B?ODRPM1VlbVpPMnFzVGVpUE9Da1Npd1l2YTZrZER1UDVvbHRsVnVBc3Y0SEVh?=
 =?utf-8?B?VVhhYlNkRkNoMmROVmU2U2hOVkc0SU5zOEZ3SVBtTmp2akNGTHRRTzgxU244?=
 =?utf-8?B?bFNWelplaGRTR3ZCSWd3MEdlUmwyemdNTGlqZHpDcVdpQnI5eVN2cm5CQmJs?=
 =?utf-8?B?RnQ0em9lWXpSVkRUUGRtWHcreHlaQ09aMVREZEU3d3dLYVkzMHJPUjZ0akZq?=
 =?utf-8?B?SURZekpRRExFbW9xT0pDdDBQMFAxL2hrVTVaNWFpd2k4Q1c5MCt0bkQ3NUFT?=
 =?utf-8?B?K1JxM3piQ3lHb2pLMDFBNVpiN2Q3bWczald0T0xNZE11c2R1NVRCcUhYZnFt?=
 =?utf-8?Q?lBn5eutN2Glon8uIw2/hCns=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb92be-849d-4eab-6133-08d9d0e1bc2b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 06:56:59.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31NNVz5fTsZTvqhLd2qf13v65uMGUOCUGORFhAWX9gAfx6pX9hJfhEdaT7nkX/tGZ/W9m4IomPX9VYkbS/3YmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 1/5/22 11:21 PM, Borislav Petkov wrote:
> ... yap, and because fixing it this way is easy, I've already queued the
> __no_profile solution:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/mm&id=b64dfcde1ca9cb82e38e573753f0c0db8fb841c2
This fixing is good to me.

Just a little concern: if people need to add function in the future,
if he/she is not using clang-14, it's possible that he/she misses the
__no_profile and triggers this kind of issue again.

It may not be a big problem (we will capture it in our test. :)). Thanks.


Regards
Yin, Fengwei

> 
> Thanks.
