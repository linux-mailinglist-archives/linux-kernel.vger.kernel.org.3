Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2C48DE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiAMTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:14:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:38783 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbiAMTOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642101284; x=1673637284;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LILXLV2lKJUYcl8PMnvmpUHvjqt1uTOdY4evLhaygRw=;
  b=hZOkbICxUBY6i630n/ahU1GU5yl92lX5aqXGlCvBwM1yg/Y6k944uioI
   ItPNmj1t2xllmERR+kp2Ek7STc7UFporJGkgq9t+34D+sEqHsxBAFANjo
   TMPXZJQEc+cmxuALGAWaionJlfFB0lwVGOtOtrTdV49rNvK/3cIF/H7a7
   Pc2kM9XeVcGhdEmRs4zPQxBT66U41dHi99Nu2zHS8brO2j/YKar2qMu8k
   i3h5mQKX63/fGKAJo1K/u4pPJ1JwRWE4hUtkSXgywkF1EDuy7/sHH4feO
   V+43LB4itK79U+VuZx1AuR9u0IK+NsLuQICqfASgn3jqTr/WI1MOqU5Kv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244297710"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244297710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 11:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="623967640"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2022 11:14:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 11:14:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 13 Jan 2022 11:14:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 13 Jan 2022 11:14:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcdTmBGkw3zXC2TOp0pRAekBJsvt9hsWPU3IPcwTH7yEPGU/Uxz2T7htaFh0SKxMxOq7GOXNyyVa0XcpM/z5ZsQds7pP6OtIWsPoLHnMq/cIIxzotfinJRiumYTwSSMxGstR8qDOVu4gTbPJEsK7QJn55WwrUhZ2rk+CP5ANYR0bdR8JQvFqFvWjZFElkmdqVY4GbiBp+RAxHNLc5xWzGs795Z/eHIwFzPcMBZ6gSld3J2xPfzetHG4CJbFOYBbjppckLm4DfTWvzn/9staVmTK3bXmUVm/8HZE5g+wRH9pp2kpnZ3M+mCCxh5dKikFC1TcMHHF2LYZyilHcySPZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG7f/S/KeZa6xBuYDgmBrAFHdVp9V3CgK2Sh4f75L3c=;
 b=enxfof8p4LMUMgJRBfX1MTAyGBvpUc6+Egs4YbV12QtIhDi2J9kTNZxlFeUq5kUX+CimSRo7wjTAkPzszTWkOPV8/xIOCQ/XpAS+ccCFyfC5NOS/DukGz4A0DBqNMI3blQjqcYJsbtIGEghQxSzVYcn3nHAnczT69akurhjCWOBMKPl+C5pXqCcXmySiDiIK0hPsBAhaq+d8aS0GJf1F0jEvQjKjDBuzWB8FRbxM+rcQCIB3oV0RV9VXiE7Fg1Xx5roQ9f0bEs7WmBmlsPrGq4mdzCwcSiPoJOm4c7sEtw2TXZS9ddrscfIiXSRMhegN0Wp47xxFfsngajZjhRhhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MWHPR11MB1565.namprd11.prod.outlook.com (2603:10b6:301:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 19:14:39 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::1419:964a:8506:5420%6]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 19:14:39 +0000
Message-ID: <9d546cfa-93e0-5b53-9100-5e9b091fac1b@intel.com>
Date:   Thu, 13 Jan 2022 20:14:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Huang Rui <ray.huang@amd.com>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <YeA2PAvHV+uHRhLj@kernel.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <YeA2PAvHV+uHRhLj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb0dbd9c-e42d-4ccb-4565-08d9d6c8f22d
X-MS-TrafficTypeDiagnostic: MWHPR11MB1565:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB156546826E5CB74B6C90898CCB539@MWHPR11MB1565.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0YHvTxZ+5fBiugvIrDTCsTf5QcubHXQd/65LAB+LhGdk7mmkmG5cCFOwyTx8lPsRRXTd4vuOybjwjBFGlDnt9lPnN2NIXiBBPD5Wb0cGgLzb2nEqj1QMNhvbekPIAMEy8t8f9P6YfglZSU0nP1p9jzodDHQiqkVaV92rX8nc4IijNKI+fir8yHzajgp48ZnT/1bm97HhE7M+i2QyoK/cd0XuQHLdRwDykaCgvPjL5KAPKlfdSFZPBgwtYKlHqjjwRWg9k43O03iLCfwn/BII202iCQQydKFYkwQDZvRODTHw0KdQa9IILEnxWOSf3WGIv+SKKsN+l5CLPahUpimBXHDPkWSANU4f6amYjhfXuqgN5i+/OFHJKd63cCmzrIQY7fs9HFepEkSbJJagHTXx+jOVZaPb+3eU5u+FE/4pO8k/L6EMQuS4j35xAyZ5rGemkVQ9t0UNUIWJyHazhge3hv2g5ObinomVG1GPPzsZ36kRHwfA/KRLG5c64K1rUZG9yX4cHeUFW/OXzzFl8aqdE6IfHKG9EzhAoKILoiyV6GB4xaj5GLQzelzuOJwxVqxS+Via8PRdcQ9SbnFdRpLfBhqTazGuhaEDYSO0qfXUp87ByeVL66D4OGeOcxx3DtjebCzslvVEH2CBI111PJHdsorDY/lHLiBV2gUeMjnrKqlOXRG1cIEN9u57Hmxf7qbI/rG925rnsZWPzAiZzAisXZIZBe72WM7bFErJd0glfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(110136005)(54906003)(36756003)(53546011)(5660300002)(8936002)(6512007)(8676002)(31686004)(4326008)(36916002)(6666004)(6506007)(2906002)(6486002)(316002)(38100700002)(82960400001)(31696002)(186003)(83380400001)(86362001)(508600001)(66476007)(66946007)(26005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStEKzQ4dGFRN2dtNHRKaGwzRnhPWGp6V2o3YVVHRWlvWElxYSs3RzJTMmtk?=
 =?utf-8?B?M09kdEx3MGl0aW4yY0hLZ2pWTGpBVElYL0xnU3VSa0FDMkxQOWFQTlVraElJ?=
 =?utf-8?B?ajBjSG83K3lKNmRLQkxoWWRrRFMwQWFjYnFuc3h0V0Q0dVNuK1V6MjJXNUNr?=
 =?utf-8?B?eXFpdXZBcWF5YzU1WjBTTm9hUThHMTFkUEVjYmlMVWMwL0FuOG4yUmlMTktS?=
 =?utf-8?B?cU1hZHVqSHd4UGJIbzZ4QTFLNzErejNCc1VBeUpZc2RDZzJyUTIrQTdBZHpt?=
 =?utf-8?B?RGs4N1ltMTJHVU8vcWt5OXdpalhxQzczSW0zeEtaK0kzREhnZVdLUVlJSWJk?=
 =?utf-8?B?amdCOGpKN2F5U3BrZlRXTWwxOUdQQkVuTlFnZUpiQUIxK0RvUTVKdFJNWmJZ?=
 =?utf-8?B?VW9HOTN0c3p4VExhYzlQeGFrRzZOT2IwL1hJWWdhZFptOS9xQXVBZlNwR3My?=
 =?utf-8?B?M1MyVnhTeWNRU3hQWXNMcGdqNkJuVnlQeHE5T0RSa2pQc0pwZ1V5OVpPYzlY?=
 =?utf-8?B?b3lkcU9FUi9EMllrRWNONWtXZG1RdGJKR05EVC9nWk9wY2dFTFpBQ3ZxT1Vy?=
 =?utf-8?B?d3BJWkdITy9OeHZ4YWE1alBQenBZbFptbW5Td2Z1S0M2eEE2d0hMYW5EeElU?=
 =?utf-8?B?MEt0MHRpVVVlTnpEb3B5a0oyYUhsSlh1MTVyaUFjamVXNnhMTHdhemEvRlpa?=
 =?utf-8?B?dXQyT3FYZkJXRU1kYTVKUThxcytHNjRtaENLMnlQSEludTVuYk5GN0Q1OUIy?=
 =?utf-8?B?c1dSMkJMOHgrUHAxVmRmQU9hMmE5SmhBak9jcVhuUTBYamhtWTNqdmpqK0lV?=
 =?utf-8?B?YW9KSi9qbEN3bERGL3pBaXArbzlvTHcvUXMrTUZkb29zdUJrTFVLZ3R2REZS?=
 =?utf-8?B?Q2RFUmo4M0NFa0VONS9yZjBwbmxHcW9RcHp0azM0bjAzOHJTNThWdnRlVERk?=
 =?utf-8?B?UlFhc0FXT2JJM0VhUHh2NlFVQnNwaTNkbGVwQk0yWjc1bDgwUmFJSlVHdXVR?=
 =?utf-8?B?VitXTHhPWVVHenV4RDJQbytsblpzSlhOYWRGZDlkVXhGRjFDQzI1QVV3VHBl?=
 =?utf-8?B?V2FUaDFnSW05RjJqWnh3bzY5SWlzTm9RekNTWnBFSGVabjU3RXQ1Ukt2ak5v?=
 =?utf-8?B?VEgrYkp6RlkrSHlwTEI1ZWdHMUpVTXpUVS9vU2xWMERyMnBsR2VVRnJCRzdm?=
 =?utf-8?B?dys3Y2lVbndpV0R2dEZSWnVJaFZtN2pwSjErYlhyUjJBZGgvM3hQV3FUbmQy?=
 =?utf-8?B?U0p5YncvZTNyckFRdUdPdzdtYnhJc1dLNFRVVDJLYUhMY05IUlBUeWVmUVBL?=
 =?utf-8?B?NGpPNXkzWlB3dmdSMGRXbXFqSm1ad0JQRnFDOFdWa2xMeWg2K2NROHh0M29u?=
 =?utf-8?B?bFZINUJCRXh2TWlzNnBsS054d0NHQXdhL2tibnIycXYvRGFmUEcrbEFWZmVZ?=
 =?utf-8?B?cXZyODhUNTFQTXdsbW1qYW93SWRSelJrZEdNMzJuVDROaTAvcUQwUDdDK2Vr?=
 =?utf-8?B?Y2ZUMEpzLzZ6b3hFQk1DTzBURUgxSW5mc3MvN0lUL2ZtNnFWcG42d3lUUjZ1?=
 =?utf-8?B?SzZYYko0NmQ0dVkxQUFQUFZyYkQ5Y0w5MGhtU21pejdzU1Jpb0dHVE1CZGIx?=
 =?utf-8?B?cXZiMjhZV1RCNjBaa25LWkZPLy9ZaEdJOEpHS085MTZCTzhMVmprOVUyMnh4?=
 =?utf-8?B?ckROblZnbHpreENnWUdMRXp4Z08vTGc4NjdFZHA1L3JGbjkvQVMxZXIza1Zx?=
 =?utf-8?B?Tnh0WWZVTWhnaUU3cUMxaVZjUFFEQWZOVGxlZTZrYS8wYWpkcTZUZ29mNjkr?=
 =?utf-8?B?LzVYT21tOXQvcm5ac3llTGZDVjMwNlRLNHZaNXVSeURoeDVvMHVVR1NJS2Z2?=
 =?utf-8?B?YjdoOWkvSG9aMkZkcjJmMktGSzZiclh0WmRLcmo4U1BKTTFnTTFjWThJZGxh?=
 =?utf-8?B?ZFROazVDWHBWaFpVNHFVb3pTTmpoSTYxeGtDbnc2SkJyakVXTVU0U0g5SjJq?=
 =?utf-8?B?OU1wN3RycFV4V2Y5WVIwL1JURXRqTitoZmRFT0hXcTIrUWszN1Q5UG1Ea2d3?=
 =?utf-8?B?SnppRm9oY3pOdnM5RkRkTVZ5eUJqdUF6OXJIbEtLSFpFamhMQm9EbnJzRTBo?=
 =?utf-8?B?ZkJJZ25kKzRXbTlqdjd3OXI0NW81bW9IMHpqZVlqbWVIUktyS0VaeGFicDZB?=
 =?utf-8?B?NXgrVm1MeW1HNVZqZXNuUmlIZGEvV204NmsvLythZGhtZWQ1OFl1eVU5RlV4?=
 =?utf-8?B?UThRNDZXMFNLdlJxVjFJV044TUF3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0dbd9c-e42d-4ccb-4565-08d9d6c8f22d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 19:14:39.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABTCkSaxTri+kVpLci9WigLKrbVExcxb9dn8ARufZcr1/NCoUWBZt87+G1QDI+Wi2A0V7urXqHtX/IwVpsuwVZJDQCeS0b3x3JpiQ2kdCj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/2022 3:25 PM, Arnaldo Carvalho de Melo wrote:
> To pick up the changes in:
>
>    89aa94b4a218339b ("x86/msr: Add AMD CPPC MSR definitions")
>
> Addressing these tools/perf build warnings:
>
>      diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>      Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
>
> That makes the beautification scripts to pick some new entries:
>
>    $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
>    $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
>    $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
>    $ diff -u before after
>    --- before	2022-01-13 10:59:51.743416890 -0300
>    +++ after	2022-01-13 11:00:00.776644178 -0300
>    @@ -303,6 +303,11 @@
>   	  [0xc0010299 - x86_AMD_V_KVM_MSRs_offset] = "AMD_RAPL_POWER_UNIT",
>   	  [0xc001029a - x86_AMD_V_KVM_MSRs_offset] = "AMD_CORE_ENERGY_STATUS",
>   	  [0xc001029b - x86_AMD_V_KVM_MSRs_offset] = "AMD_PKG_ENERGY_STATUS",
>    +       [0xc00102b0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP1",
>    +       [0xc00102b1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_ENABLE",
>    +       [0xc00102b2 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_CAP2",
>    +       [0xc00102b3 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_REQ",
>    +       [0xc00102b4 - x86_AMD_V_KVM_MSRs_offset] = "AMD_CPPC_STATUS",
>   	  [0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
>   	  [0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
>     };
>    $
>
> And this gets rebuilt:
>
>    CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
>    INSTALL  trace_plugins
>    LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
>    LD       /tmp/build/perf/trace/beauty/perf-in.o
>    LD       /tmp/build/perf/perf-in.o
>    LINK     /tmp/build/perf/perf
>
> Now one can trace systemwide asking to see backtraces to where those
> MSRs are being read/written with:
>
>    # perf trace -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<="
>    Failed to set filter "(msr>=0xc00102b0 && msr<=) && (common_pid != 2612094 && common_pid != 3841)" on event msr:read_msr with 22 (Invalid argument)
>    # ^C
>
> If we use -v (verbose mode) we can see what it does behind the scenes:
>
>    # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr>=AMD_CPPC_CAP1 && msr<=AMD_CPPC_STATUS"
>    <SNIP>
>    New filter for msr:read_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
>    New filter for msr:write_msr: (msr>=0xc00102b0 && msr<=0xc00102b4) && (common_pid != 2612102 && common_pid != 3841)
>    <SNIP>
>    ^C[root@five ~]#
>
> Example with a frequent msr:
>
>    # perf trace -v -e msr:*_msr/max-stack=32/ --filter="msr==IA32_SPEC_CTRL" --max-events 2
>    Using CPUID AuthenticAMD-25-21-0
>    0x48
>    New filter for msr:read_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
>    0x48
>    New filter for msr:write_msr: (msr==0x48) && (common_pid != 2612129 && common_pid != 3841)
>    mmap size 528384B
>    Looking at the vmlinux_path (8 entries long)
>    symsrc__init: build id mismatch for vmlinux.
>    Using /proc/kcore for kernel data
>    Using /proc/kallsyms for symbols
>         0.000 Timer/2525383 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
>                                           do_trace_write_msr ([kernel.kallsyms])
>                                           do_trace_write_msr ([kernel.kallsyms])
>                                           __switch_to_xtra ([kernel.kallsyms])
>                                           __switch_to ([kernel.kallsyms])
>                                           __schedule ([kernel.kallsyms])
>                                           schedule ([kernel.kallsyms])
>                                           futex_wait_queue_me ([kernel.kallsyms])
>                                           futex_wait ([kernel.kallsyms])
>                                           do_futex ([kernel.kallsyms])
>                                           __x64_sys_futex ([kernel.kallsyms])
>                                           do_syscall_64 ([kernel.kallsyms])
>                                           entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
>                                           __futex_abstimed_wait_common64 (/usr/lib64/libpthread-2.33.so)
>         0.030 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL, val: 2)
>                                           do_trace_write_msr ([kernel.kallsyms])
>                                           do_trace_write_msr ([kernel.kallsyms])
>                                           __switch_to_xtra ([kernel.kallsyms])
>                                           __switch_to ([kernel.kallsyms])
>                                           __schedule ([kernel.kallsyms])
>                                           schedule_idle ([kernel.kallsyms])
>                                           do_idle ([kernel.kallsyms])
>                                           cpu_startup_entry ([kernel.kallsyms])
>                                           secondary_startup_64_no_verify ([kernel.kallsyms])
>    #
>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   tools/arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> index 01e2650b958591e0..3faf0f97edb1bcd3 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -486,6 +486,23 @@
>   
>   #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>   
> +/* AMD Collaborative Processor Performance Control MSRs */
> +#define MSR_AMD_CPPC_CAP1		0xc00102b0
> +#define MSR_AMD_CPPC_ENABLE		0xc00102b1
> +#define MSR_AMD_CPPC_CAP2		0xc00102b2
> +#define MSR_AMD_CPPC_REQ		0xc00102b3
> +#define MSR_AMD_CPPC_STATUS		0xc00102b4
> +
> +#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
> +#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> +#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> +#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> +
> +#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
> +#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> +#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> +#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +
>   /* Fam 17h MSRs */
>   #define MSR_F17H_IRPERF			0xc00000e9
>   


