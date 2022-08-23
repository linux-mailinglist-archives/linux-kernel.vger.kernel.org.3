Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08B959EF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiHWWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiHWWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:47:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA6895E3;
        Tue, 23 Aug 2022 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661294861; x=1692830861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7L8R0ntxPirNSSOuloDEAGTLi5hWxsZt+JwCJsHE4cY=;
  b=UKnwpnJ7iwFCBCuUwr6GlVbERml+5Pi2EByD9Iri7Oc41YO6ORq8ZBnC
   jr/2mLj0IETFoFH1NTrec5joNHCaPBrP9CELAhtTnsm6/4qTmcdl+DATz
   3PKdMXj3jf7UkoFbp6C+yt9l1hsUCzUQHLVFPYr0L+PmN41qBaASeb4iv
   tUdeZgBZKGJX41Rxs+HmkZJx9J/YLb6wDtxK9KHXdS5YGr32JwAigaYqk
   OVPG/pkMYX0mro9rAGYg8uRe2JnzcZakuivvA/lQdb+To/cEVAjRtjiyn
   HmciTjhx4ghg1WQhYIMBKc0D7F8fISb7RfhegDE1Vb42cwTAshPxubfuD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="273562769"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="273562769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 15:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="855030965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2022 15:47:41 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 15:47:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 15:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekM4FR4iva3VQnLsVx10qMMxJNGFmCUoDoQwD89WHinoAzfZz/ulvptaoX01YuFK3BxQGNrLW/K64SLEOwqFkV6nz5pPOzK74uMdY6gUrAfH0fEF9reEOdwBPtsnbskJ4M4TGP1HLNxKkObE++fNO4TYU1NTAbo3RCljyGfAaaTHI6aQMfMf4OcvrsdblgWofceN9EjEWkQMcLlh3gbMqoR1GOgCNZmXFddhhMxmvXCx5khgG3U2PS/C9fQBJv5/HDglyLh8GQ1Pko4wHb0Dy3GeOjiwTeip2rnSGNewN0H6LPgT1hBl0GOrXkKU1sgpqkNFEG4IyYOtwZ7F+oNR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcLSRI22r3/tuaX2MoFUNmxx1czjzQxe2jM+ZeAXWvs=;
 b=gs28FzB8ZQ5SQSpX7zFtKlRX4B4DCviPMRkX2TEiUkwD1Ar9ALPZPUJkKBRQI2pDx961Kv0SVk99A3mCOxKyBZAGGnrIDAUHViXBjoxZUfodjLxDMkf1uW0fPllduce5mrEgMUqWQSP+I46mdeJqOLtZj1hIptspdBo8/3vsHhWPTbIIMsAkZFPO2nKrini8kQAOM1zF79t28xvUBJ/kgTTmnyqgOAs0qif+j6uFIfpgupa2V7z0Aw/Fi3TvvGCG4mBIj4qadZeBCgugF40jzkCnymOf5AGoQlzsbcNy5T5a8zQpnKhcagrRdiNYg6y+pOEMTTFwUPZwgmEhnYi51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL1PR11MB5414.namprd11.prod.outlook.com (2603:10b6:208:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 22:47:37 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 22:47:37 +0000
Message-ID: <fa6c01b8-455e-4be6-2607-985ddbd3449e@intel.com>
Date:   Tue, 23 Aug 2022 15:47:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 04/10] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117578936.6695.16882887771401229703.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117578936.6695.16882887771401229703.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a4979c-592d-4e52-8167-08da855979e2
X-MS-TrafficTypeDiagnostic: BL1PR11MB5414:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2SMDZ+Y9+yDD+MVoukG5irC5DagFaalyE01UkascOdCeq+nzQNFAxAtpp36mdvmVWSpuAClqgspLbmhpvxLb1iJYOudcCDgJUPB98J48f4WcGbMGFjXPcY+Pb07F94uDcMGqzWo5RiYRJk0D6mouNDqQ3llCvj1zb8sM1lux0TKLTCu4sdtvPVRjUAfwD1f+55db+3feJG/bKu2jRTY9n+G4TAys6QYNu1suFLwXyUBSxjp3AtPUG4r14qhWUP4aXGeSyM3U2EQwXThZ5R+5Wml98OOsTkEGHfa7rgr5GibkHW7ttW6T2nbZAGYF2m4et18JbfD71IIZt/va9iQkQD5jL66V8HSOfLO57g2fC2fkALNScLBj6e6F8dhjA/hyrLxpcEcnna7f0lcQffnP++j2uMVYIRjbVattxBMUPkYwWQy2fJvOCgqZIqnoyNVXT1HcU+cEmUw3Py9MUXtzAnCwZWSOLzJaZWl2nF1O9Zg07xjecULhzMgH2tnIO9M1eytURQXrVgPiHDi4zeerzK7JwAK24+c6p4EVqFjBG3qWsNoQzT2xmxZW9sK0gsScH3noQ9ILYtfHVWnf2I3AQwE/oLNDOYcqxh4BY916h+C+v4GprKMlMQbj8GAB7bQxuDm0r4KUReLMosPOTpfJyAxFCyzBw2hu1RuHYCK0dZ4xoHNvh9cQ1WMQ4iLU3kdbmCcITDGZ5pK84+l7KdhUarZVR/SBUqmYx6HxNJldPNGxk5D0l+CBwicDwENgamruK+ZcJL/u/r56DfmDNf2WPVLwoaFIuSvaDBddmlIEB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(376002)(136003)(31686004)(478600001)(6486002)(36756003)(5660300002)(38100700002)(41300700001)(8936002)(53546011)(6666004)(6512007)(6506007)(26005)(2906002)(44832011)(86362001)(186003)(2616005)(7416002)(316002)(31696002)(66946007)(82960400001)(66476007)(66556008)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXd0YmZjMnpoaTFFMzBQc2dMeDc2TU1STlc2RUNOOUw2ejcvaUp5SEcrcmlQ?=
 =?utf-8?B?MmRoTzNlTm5pV25vUFZiYi8yTjBsMXdtSS90K3N4TDRMbElKU0hHV2JiZnht?=
 =?utf-8?B?TDJ1a0FGdDg4RlhyS0NQMGFMSTA2Mlo1aU15cXorVzhTbnA0WUd3TE1WT2dV?=
 =?utf-8?B?VFpVa2NYaUJocEtFYXhZaDcxMEJQUzN1QlVsSFhXRmJJenR5aGVDbXF3K3cy?=
 =?utf-8?B?MzkzR3RjaFFidzJMV3poUFIxMzdDcjRGUDdSQXFQc3djQU0xVXA3K09jeGhZ?=
 =?utf-8?B?aGlXSkxkN3JxaElwRi9YbXBwOVBpTFR0ZzAxUSs2U2lpRXFoZUVQaVhtTDBr?=
 =?utf-8?B?Vkg3V2NBTGkzOS8wakhHYU1JbTlhRUtXQ0xhK3lSYTdZd3NBRnBXSk5ISDBx?=
 =?utf-8?B?V3RjU1dvSCtnaGIzT05sa0htbzZ4UU9RajBlZ2c3SGR4R3hGamIzZjdOVHJq?=
 =?utf-8?B?cHk4a1lYQTdUNER5SkMybGYrU2Z6eVFzTUY4cE52YTVNTWZ2M2pxS1JNUSti?=
 =?utf-8?B?YVNiUnpBMkpqWStaWWE0NTFpZzBDeWFOZjcvMFFnYjEvVGlNMG9aOG1odkQr?=
 =?utf-8?B?K284NlJzeDdrckdOc0REVXBVVGpXc3NBVnlNNkNQUGVyQXdmYzhpOG1LajJS?=
 =?utf-8?B?d0FBU3ZYVmV2WVFidkNKNGk0QS90ZTl5WUNaVmhPSHdML2E5cjdWaXFHMVdH?=
 =?utf-8?B?elZNeFVOY2h5S3U3MGRtYnRLU1RKZWlxRVBzOEhBOVpOOGJjaUErRW9RUUlt?=
 =?utf-8?B?aHVnSHdJV0ZXNHEzeWwzNTNJSUZvY2tYUUdCZ1o4eGh6ZDVtbEZMSDYyQk1U?=
 =?utf-8?B?a2Z0UXFyYXU0TlNwK2c3R0xLNWhyTVJxOVZMSjJGdWdsbUh4V1NCTFNOS2oz?=
 =?utf-8?B?S1BXL2lMUFRYOHpveHp5OGZNeUo0b1NxOWlOVnljNG5DdDI3d2R5cFhmQ1hY?=
 =?utf-8?B?bFF0N3cxQzZEMm40MjNtLzNnZ3FPTmZsNUNXdVJYWVhUaU8rek9SYzRzc05i?=
 =?utf-8?B?Yjl3S1l6N1o4QzVLYUpNZ050V3F3akpkdDJMRlQxK1p6VUE5T21vQ3NXU0FR?=
 =?utf-8?B?TlZuSHFYeGluZTlzV2oxOS9FaFpyaUJiakNnR1YyRW1kVm8rVllNbldSUDFG?=
 =?utf-8?B?eUJORVJob3dYQTQ4S001SHpWendGMDJkalFUTmJzT3BQaUJOQ0VnL2d2SXQ2?=
 =?utf-8?B?Vi81UFZCQnpJVzdzc3dZNzIzMXJHQytESzJ2NUVPK0JkcXhIbThDa1MyL2p1?=
 =?utf-8?B?OWJDWStrekg1THJueFdoaGVGZEJjQzZuTCtENExzTlpueTFsMDd3dE5MbWFL?=
 =?utf-8?B?QS84cUNFVWVVNzQ2dWhZL2JpbGVIemhlM2JWVDcvR1hvVkZ0OHRCcU1JZFo3?=
 =?utf-8?B?MVNlVDNETW44R1Y2VnBUUEtYRk9DVGRlT1JqWXJGVWpPK3l6YVUzTmwzTWt3?=
 =?utf-8?B?ZkdzUWpYYUkraXJBT2hyRisvTUhhWWE2NC85djdxV2R6RzlCQWcrZ204NENq?=
 =?utf-8?B?OXhvdkprbHdDRVRWR2pWODRuMWtQZEN3WHhtb0FaMFRYSU5ndmZOSFhBd1Bx?=
 =?utf-8?B?WHZhYkRDZGVqeFFPL1VRM1FNQURlczFGQjJIelliQXlpSmtROUU2ZndtN3Qy?=
 =?utf-8?B?alR3OElKb01ZQVNnQ0dMa3g3VGNnVDU3MWtrSitNcWhpT1I0bzNZbVNqRFlV?=
 =?utf-8?B?Zkg4VVgvSFBac2FqWjJacGp5ZGlrTVpLakcyU3VvQmlDdk5rUzhmZEpLR0I3?=
 =?utf-8?B?QmEvbHhBZkNnaGZLdDdobHE0UDFocVkvT2wvYWJLM2tDRGNlMGVlVWVGQWpE?=
 =?utf-8?B?QXA0b0ZEWHppejhHa2RLTE1Ka00zQS8rSC9CL25PYkVRcGtlU1NXQXlJNHZw?=
 =?utf-8?B?SzQzVlNpOGZZTFVyek50aHpVSUdTVUJmR0o5M2d0T0VSWFpZVk1ObDB5ckdK?=
 =?utf-8?B?R2tqWEV2SkM1ZnV3dzIyVERFNnEzU01RQ3RLd0YweXZIVTBOM0JyQy96TGdO?=
 =?utf-8?B?V0RhdTdPVE44WUJUQW9LdWpHZkNoYnNmYWRpeDFOU0s0TDlucUg0UHNXWnAr?=
 =?utf-8?B?b0VDYXhnYlppOE4yTW5yeDVwQXl5ZklGbUVXNUlJWC9sdzJvbnpuR1I2MDJG?=
 =?utf-8?B?YStqZms4M2YxdGlEcHRJWXlaamQzZzYwU09vODVZMUVOVmYzNzdYY3ZJTU4v?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a4979c-592d-4e52-8167-08da855979e2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 22:47:37.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzgvT4U0XFM71M4r/gf8OjqiWcn096MF2AknqumqF3HGxOP2HMhBFtRhrT6020vi/2yMltkRD/ynovAntme3nUCt3Rj2Wk5n/OjLMT3BJpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5414
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:43 AM, Babu Moger wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6c38427b71a2..36ad97ab7342 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -253,6 +253,37 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>  	return true;
>  }
>  
> +static bool __rdt_get_s_mem_config_amd(struct rdt_resource *r)
> +{
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	union cpuid_0x10_3_eax eax;
> +	union cpuid_0x10_x_edx edx;
> +	u32 ebx, ecx;
> +
> +	cpuid_count(0x80000020, 2, &eax.full, &ebx, &ecx, &edx.full);
> +	hw_res->num_closid = edx.split.cos_max + 1;
> +	r->default_ctrl = MAX_MBA_BW_AMD;
> +
> +	/* AMD does not use delay */
> +	r->membw.delay_linear = false;
> +	r->membw.arch_needs_linear = false;
> +
> +	/*
> +	 * AMD does not use memory delay throttle model to control
> +	 * the allocation like Intel does.
> +	 */
> +	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
> +	r->membw.min_bw = 0;
> +	r->membw.bw_gran = 1;
> +	/* Max value is 2048, Data width should be 4 in decimal */
> +	r->data_width = 4;
> +
> +	r->alloc_capable = true;
> +	r->alloc_enabled = true;
> +
> +	return true;
> +}
> +


From what I can tell this new function is almost identical to (it differs with
one character from) __rdt_get_mem_config_amd(). Could it be refactored to
avoid such duplication?

Reinette
