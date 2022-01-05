Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7C484C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiAECfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:35:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:25233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237089AbiAECfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641350130; x=1672886130;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgVvApsWi/1Cd5mxbDrSEXPqze5KdOGXlkM+uYDrFWs=;
  b=T3Y8GLtuyrMxNPF3Gx2LTpJOs5wyHXX2EyelKNBEya9LS+qKtjZvmgr5
   wDTf32IcV8hQSWCUXzydmj0k5t08U3aPPGlNd8U5SLQf1m/ER9329qEx2
   6x0LO9DcwPVtDnzcVLPTUyEsX8cUPXGdyjwkWo97FmZnB8Y7kmcUOhDBf
   M6wVNnuC/W47tw5jmyLma0xRwjUMwKTq4gNd1cH+RvYkWaZYR0dCBUMt4
   aiGR+Synh37Bw3bfLsN/l6cdWN2axyA2H3igYWXtGqh/2ZEtQrmejPhqJ
   1qRhlhMaHw4683Nn8s1B3UJ73I7KgK1tEY1QfkisU7P4Y6cDzz5I4mdjG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242558999"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242558999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 18:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526311601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 18:35:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 18:35:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 18:35:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 18:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqS9FGvjGQiarhchAA9vJNisRaAy3VrwFZ46btwtzUcfaUizTdpxtxOVvsPgCRYaAY12T4nwz3Wtyk8Xj+NB0dZ/m8W2FqIwkszSXW6M35ew0S42eHrQylDDbbi8eG0f4dnqurtBE/14v3wSLPIn2EFVJmq6MVh6QfC22JWd85BvWoem7H4tb3gUtCw7fMiOwBU01iB2Jvriq2JPmzv+60aa4DOu25OZHiifSyrEBU6hAZVSb6+5G8ozHuM9cCoyOopdqJF2Xl/paH8LEe82oM8XfFp6MIBsOhPrE+pajokoeS2u9MW1T1cJ2GThG0vJB8LvZcwH8YY84eZgHAEpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgVvApsWi/1Cd5mxbDrSEXPqze5KdOGXlkM+uYDrFWs=;
 b=IjrtA/GX3zD5nAFXZECwr2oayqpsOw2Ecz8wwaDaLF9NWziZuvpgC2O5Zy1YcHv8ZpRjUTNHeh+MDrXwDkWqEjYa6w78QTISlHOXlZKxZNOadtTsT/qscAMSg6Ez0eFvE0GzpB5SQQZasiIOSWe30dbav0xpE2hl6Mep7zmio8f31O3N1ZsFO6UPN7etiQQRuHEqlPM4aMs6QHLOr6CBhog1/TP7JEMQUXtBnGLHZ5fOP/yAKgvP08SZJCK8YvDES+hkf1ZygvrGGJJoZtYXhkEFm+uru2iog8AXYqE2owB07l1ipT6Ja00q/fAZUA3sCJevfwK6sYS8b04tgwKc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 02:35:27 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::99e7:e9ce:ff26:49cb%7]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 02:35:27 +0000
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
To:     Borislav Petkov <bp@suse.de>, Marco Elver <elver@google.com>
CC:     Carel Si <beibei.si@intel.com>, Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com> <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com> <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com> <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
 <CANpmjNO4hs1B9eDY9edGGOXY45a8smdtYfYfbDRnGWSYch4wGg@mail.gmail.com>
 <YcHxKzB3WPurKlZ9@zn.tnic>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <a5cb8140-5834-7649-e629-f2775cf5b9a9@intel.com>
Date:   Wed, 5 Jan 2022 10:35:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YcHxKzB3WPurKlZ9@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54af598e-4c9f-4698-3bba-08d9cff4086a
X-MS-TrafficTypeDiagnostic: MW3PR11MB4746:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW3PR11MB47467D5C8E2F6DAC3144BADDEE4B9@MW3PR11MB4746.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6kw9jsgO6G7NuNWqMXT3opxUkZwkgG4jMf9ULcujUh+vs1DJ6GE1KPN1In7iebyFJ3RM9EjqKVkwYbhP8vt4gpUBpadUekVaWPNgHyU72oRDgRY8kELWCUvjM9tHVkpOeBtAbezFwZIhbaen5MuQmJEEFm0t7AijLtTK/HclkgiCluYDVkQIft8T9S1aOXfmry2J6vIz6AiDldlc/Ylft3kWtWBf1Isj2n28tYeIdaAIlJon66duyirUj10Pbzzn7JV30IjAdlOG0IswWHXgvs+tDAmafg1dY5arrxGsmtgRBSZo1hjyElgLBzXKVOI6JwofXPo0oX3JxA2KG89BGhVCCrwxbmFWJoDxtiETXYQgiO+5L3q8YzYjn9MjPZNGYXOWAkSaM5zVZiXibW71ciIh1kMBCIPa2iOm3BA6Y5Et0NLn9345MLyWJUnl86rlJL9gBbfiFJKC5m6TOVPT32J49X8SXvLhcKkTgbk/vEMho2TMNa+keVOZXfpP1dFdrnJaQqY2e5P1dtJmyUZHwVBZIn4kMJXG8yTwCxewanSFyN7uknK/E34yAEmfUqiajl/120mg5FZSM0RQRDccgR0UzQGWZEElLBfez8PvaTo1fQN64EoEOWlbNNXP2auSd87xurw6yYx67ORqUYk5R/9cqElSYLf8w3GTQuvcKI+5GB2cpWuXGMpUIIK/nfOyzPdbDZUzJjfMN1hQpWaVTugOOs0aMOtdw5THJ3lBTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(508600001)(66946007)(316002)(31696002)(38100700002)(82960400001)(53546011)(36756003)(2906002)(31686004)(6506007)(8936002)(26005)(86362001)(66556008)(4744005)(110136005)(54906003)(83380400001)(8676002)(6486002)(5660300002)(6512007)(6666004)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFYd0w4R3hmeWYvOFhDcmxjeFJQanlIUVdXMjBvT2t2REhRSzUwNEQvQ29Z?=
 =?utf-8?B?aHYyaXNkb3dUMG1DdGtrNCsyZitCY2dNR0N4MDNTVk9VdlA4bkt3emRzSEFQ?=
 =?utf-8?B?RGR2WG1wVDV0L211T3pHVDBQMWJDUVVYQk1JU2RuRUdMK3M3ZTYvWEhJeFNE?=
 =?utf-8?B?cmp1cFNEOWdSN0tPQS9CV01MZUxGVDllVEtOZytOLzdFMkZ3c2RkQi9OMjdn?=
 =?utf-8?B?Q0d5ZWZabWVvcnJvWDduOGQ5REIxNE1zeDVaRXpYK2RQTllXQnlaYSsrSlR2?=
 =?utf-8?B?cUptak9rM05UZHRZTnZsalNaMFRyZzdjM3cyb0YzSXFsZnE5L1hOKys4a3lM?=
 =?utf-8?B?VWhZQS93dTNlRGJKVjh6OGhmRUlCUkN0aXZNWnczN1ZzaEhLdkZYdCtJSUw1?=
 =?utf-8?B?VEdSZTlkVlhocjNhaXU4b1NaazhGa21PbzF3ZjlxdjFzeUsxRnQ5c3BLN1Mv?=
 =?utf-8?B?SkJ0a2pwTHFiQVFkaU5DbHVueEVOc0krUUgvRUprWFEvOUFZcTE4QXBVYUl1?=
 =?utf-8?B?a1NJTmtuNm9ocmRZVGljWnF2N2VqUzdPMFFQYnBrK2hJNG5EdjZEY3BNMndW?=
 =?utf-8?B?Q21Salh3MnVXTWVUWUNlU1lsc0FTZ2w4N2NZOS80Qzl1N3NQVk5ubWdBcXRk?=
 =?utf-8?B?cnJOZXg1eUlDVkFXb1I2SjROVzlJeGFEcVhQV2YzbEFhazF3WXE5Y3Q2cDl2?=
 =?utf-8?B?eGQ2M081VHhMRTl4NjBaYlRLVUxrN1hvWTVNNEZJV1FZRTNRM1M4VEdWNGJp?=
 =?utf-8?B?ZDJtU2p6TXpXS3VVLzl6eHVYYWt1MWcwNXZFZGc0ZXJycmZod3RGdEQxZFFM?=
 =?utf-8?B?YVZiNitnT1VZQkZOZWdtdDJ6em8xRTVkTkUwQm1CbHZqRHN6QXFrUFVITytt?=
 =?utf-8?B?R21QVFBoSnc0UDA5NGN4ZlJzLzY4a0oxZENOaVBjZlVCOURRdEJsK09UckNL?=
 =?utf-8?B?OWlqYVh4UFpWRTB5VC9xZ3pxa2sxaU1UeWdvS0FzWHFCTUxKanAwU1B1Y2I3?=
 =?utf-8?B?dkp1Y3NlUm5YaWxtOC83R2htTVh4U0Fwd0dvOTdUNFZnMVhzM2VXcWl5MEJM?=
 =?utf-8?B?UXJCVWdrclN0K1NNUzlaYVRtTEhIQXhQRmkrZDR4V2tubjE5L1M4WUprLzdV?=
 =?utf-8?B?QXIwNmU0ZVhQalBpRVc2eWU4QlU1RWxKRXNSQk85dUorRTRRdVpXUWdpNUt1?=
 =?utf-8?B?eG1RNDdOU1dVYWZQVUFOL0JWYjlhRGtCU29vbVN0UHlMdXZDNk1hWjB2Z2tL?=
 =?utf-8?B?VUZXek1pdzZma1h3NFllL1lvSmIrWTRjZHhWUnZ6RndGbEFxRm9oMlNtcDQv?=
 =?utf-8?B?cmxpVjNJN3BtbWRPaUxBQ2FqeUp2dE8zTmNObUxaeXNTKzZtam4vbng2b2s4?=
 =?utf-8?B?V29LUHI5UXp1RndSSGVYM25aMWNMK3lyVTRvd1B6dnRHdlNyNHY5TVZYWUNz?=
 =?utf-8?B?VnlsT0FYcEc5OGlhTjlYRkNiUzhSOXhGOFFEQWJNeE9NWTZMM3UzSllvTi9t?=
 =?utf-8?B?Tk5rVEJQc1ZtclB3UW1sZFpMS3g0UHlsRG5aMjFyWVpRYWZZbDdLUktGOGVv?=
 =?utf-8?B?YWxHc0U0NE9obkRUVk9pU0dZSkVkMDJtTmNzTGxPeUNSMFphRjNXeTFrb0Ja?=
 =?utf-8?B?TmlWWHltWjVKVGx4eUtTaDljUmluRFlLUlpaNWI3cjdsckNmelVBeVBYR01Q?=
 =?utf-8?B?Y2d4UzRwc0s0Wm83emQ4d0NLWUlPVVFsTzlWM3JDMy96WlZOVnNienh0TThV?=
 =?utf-8?B?M0kzWlk0ODQveG9zZCtmWHUyUXh6R1ZDTCtIVWY5WHJVQmFpaGxjelhlUWdj?=
 =?utf-8?B?ajBiRjFGLzdhcmsyTk50TVd1aDRsYUc4S2JYZzJGSDgzWG15a0gxdjRVU2xt?=
 =?utf-8?B?ZTkzcVR6T3FYdUM4WDcrbHJQU2g0WHRjWE4yZEdGWHplRE9NU1RFai95WFRJ?=
 =?utf-8?B?VFVnSHN0T0lBTzZrMXBuQWZPa2FKeDVXZEJmR2p4cGYrWlVMOXBzUmNmdENT?=
 =?utf-8?B?MzdETlJacWJVV0lucGlvWXIvK1NEajFuU0Z5ZC9BQzVFRk5KVS80Y2E5Lzl5?=
 =?utf-8?B?WFlXa3NVU3dBdW9wbVRjbTNTWjhoeGZhaU0vSlEyUGg3bEFhblJnTUk1ZGhO?=
 =?utf-8?B?bUtKTUMvUUtZVzRNcHMyUTlSZTN5Rmd0ZEtqdEorMHhKbzdTOW1SS3JGU1Jk?=
 =?utf-8?Q?b9V3vMWzS9cg1bpfyzTrJbY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54af598e-4c9f-4698-3bba-08d9cff4086a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:35:27.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAGJxCLm4KFqJT/TMirunnzgaZU9VY6FGI/Lezzisq7uZC5o3mILMXdF2AMCQpWT+VjMTbPJvPj0wkMLY8rAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/21/21 11:22 PM, Borislav Petkov wrote:
> And also, I'm still waiting on clang folks to chime in on the New Pass
> Manager and whether there's a bug in clang there so that we won't need
> the __no_profile annotation at all. I mean, gcc is fine with that config
> so unless clang is doing more profiling gunk than gcc and requires that
> __llvm_gcov_init constructor... see Nathan's mail upthread.

Did you get update from clang folks for this behavior? Thanks.


Regards
Yin, Fengwei
