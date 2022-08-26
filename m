Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7885A2D96
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiHZRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiHZRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:34:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDFCBAB;
        Fri, 26 Aug 2022 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661535285; x=1693071285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f+JlKKfma0z1b9C2vu25SGv+kn5B8Y2gPwRiP4UYRA4=;
  b=nGCvnvntOIbWxwPTIJJpwSM4R5bkXfWJEUaZj6nHSpWRiSnj2nLvuqem
   q7B2/FCmng9AMQCJfyfM99Zr8k3N2uaBXjfxpKyPHFvvXbEgazAtoMUHN
   g+t7QU8ObbXBRLCFId1QxeHEZ9bR75KNc3Zx/jLtrJL6PlBpMjsC2KVt5
   /4qjP5UIg6mfFNkAVBvCOaHH2yprzmlGB/9RpWe9owUTNdMfgWC71QNnk
   bA4eIvOPRwoQMNsAPChHzcMKuzZro3WT6EEfbaEkUUmIo5r+4XnsVBEmD
   A1hTNjWVGP+jq+ilwf06ghjaW34H0Z6Vl9f/mfGFIMunlJ/4nZcmPGNkw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="293300955"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293300955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606830668"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 10:34:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:34:43 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:34:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 10:34:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 10:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVtd7o2ZNDPrPIJvhpFWsVq+VVCVfLotjgmFOiZcWdQo/ws0IV6g7k/yW9+OhmvmeBchuOv55LA3sUAcq1KU1MuUQ+k92AotNpVJ1ZlFKziOFFQBawB5ammKxmxDdWUWTySHGGEA9b5ySNecShBIvbCaj5vjoEsvxqdvEbaliIv450fzgM/4QSlkZYQxzmb2JnXCoSPGRP61fjhcnSBWAUAHzMwCbaF8cn6IjuTqRppL+504WT7vUYJVHsde42zCH3W6IPkXBRfkP9h6d61n5OhV2+MkqrEeZy8N2x9DQGCxxQy6NBJA2y38qAglmrPTDR3JoCzI7R+/Ygwm06Vc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy+gZe0yfXILnMbeJtxP00i8OUzNI40Um/i1x+WsNHE=;
 b=QQbrZCZxG17nk+eZlN8rqhCWPQpJ9a4v5a4qLmX2WyQ8uBo697lAMOB7al+/5DM1RyhyERn9LmFSJTiXLR7v8WGMRpN93rQU1/ItDFbW7AJxRBfOCMErfMwKLJHn/jtN1/Zzz8CN54EMxyxzBdRIBUCKiBuEKBYcHtdpmb6Kamx4WoZs/avfIVHgwvLZPkc8tzzhEmZ0ACZaN5kzJ0vN7NKjabLJUOw+th/vAX+so7xjoY59Vk7VdrTRoo8GQxRek2JIURoiuJ6f1TrBTk1TeB4VgjfQOGWwAeEZa25qCa60S9tOMzSZvQoP9PwloebCqeCJ+9xIS/BL93Wux+LXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM5PR11MB1612.namprd11.prod.outlook.com (2603:10b6:4:b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 17:34:20 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 17:34:20 +0000
Message-ID: <a89ed748-7e30-bf94-a8b6-6e9a63991657@intel.com>
Date:   Fri, 26 Aug 2022 10:34:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
 <654433c3-2980-41a0-503f-f888d60310e8@intel.com>
 <d6f5affa-1f7d-7944-70a3-6d2c99863fad@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d6f5affa-1f7d-7944-70a3-6d2c99863fad@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12355d8-5e2f-44e5-77fe-08da87893530
X-MS-TrafficTypeDiagnostic: DM5PR11MB1612:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aq3tIiIXd2LGWzSpiDOo1y40rVOIfZZnORntZh/MMkE7U2GdFlLI6SnAMDT3Dkw5Zu5rEwEswfiruRlMLGdbVqWsjxMu1wEm0+HaCJLLekm3/ERg2PfxCbbdLo9DjNHqJ9AYb+quCwnGExe7ZZRHcZoX/2620vY+PvlrY+iWNM+DMMwKUWREqJMOqeYz2wfoZwFdNoYrvHyB/6WDHU1Hl29j+s2L9pBQ3ukd0q2de6QYywYT1iYx1osUz8xy/56YkYZ3uDxQpaqHpqNA0sicrAUX8H0hjwB4mlDIRSLMvpZzclBaseMa+f/3VI+agWrhVZcymN/r3Fq/tVFdpPwcz/SjgiSS9jitQJSNCp0WD8mf1MEzRPayBF+bmlGPdKb51V2UcTkCk8qN4ZGJKiDhMlOZoEYR4A6tLxjnP/1phsLtiNcDuUgSwvaINKAlnekqqxdU3cahLuYvZTUVXYX1BDxDI49+7gL8ekFyR734go9FS5+iOCBDiQDKRnZ03aVBcodQ6I2N7k/x5x3Luk0lw1f97vSrk/XI7E5KN4xz1rFPrc5hdXdQZ02kaBGIckcufQ3A+8zvN2dkvF5wwjOtG8kG7NBfrU7d5wUwjmBB8prD2h7R4LjQQKWqeEw0mn4SOFfA1s7Q4xWbHOte+0ylsLH35MO/RFmA2k7wlPk5dl6/zP05aGOsY2IEZb921pkzh/McEn17tIiK8WLzWV3NgXZUWwoUJn0S8fTHqMjk890bkR45qeCCOOCxtrQw/rIIpfGkxo7kYZLk5Gzfi8cB4MlKxrt8sx3wubxrB165tCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(376002)(366004)(316002)(7416002)(8936002)(38100700002)(36756003)(83380400001)(5660300002)(31686004)(2906002)(82960400001)(41300700001)(186003)(66946007)(44832011)(31696002)(2616005)(86362001)(26005)(6506007)(478600001)(8676002)(6666004)(4326008)(66556008)(66476007)(6512007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW1mdkpWTFE1d1M0M3RLVGpBL2pLeDNTZEFGeW5uS3d4TXYzL2srSVp4cGpQ?=
 =?utf-8?B?SndGUVpyMWZsbHUrZUIzVVhCeXBZbXNnelkrcGJkcVV1cHorT2V5OFJSWElY?=
 =?utf-8?B?cHk0bW9zUDdZdE1yQTNmb2FnVUN2Y3JIby9XRlk3L3dlbWxGY0cyenhKT0tn?=
 =?utf-8?B?Vk4ySDNqN21XMlFBMFYvaU1YczM3WTJReXUrMFBIbFBOM05YRUthbldwK3hj?=
 =?utf-8?B?Mm0vUEJFb1h6d3FDT0xHRXpQT1NNcWI1TnNMMDhvNlBzWEdhMThGZ3pBNlU4?=
 =?utf-8?B?TUx2dWtHeU8wNUFhZDdJcU1lUFMyL0krVFYyRERvNThUUnIzN0NPRFlvdnpv?=
 =?utf-8?B?THcxWXVXRVRwWndwRXdZMkVWUzFDSzhTZVBvMzJkSi9nLzZGUDdRWVc3bUJ5?=
 =?utf-8?B?OEdKcVE3WkhwZytLS1VjY3Z0WXlxVitIMStod2E4R0VKVWJNNDFHakRyd1pM?=
 =?utf-8?B?V3J6T01lTzNOdnRBNFhkRjdqakN2NVhmbGlsejVmNVZxMmVvVUF4MWlraXNG?=
 =?utf-8?B?UTBkOGNOOE02RGFjenV0ZFAvYTE3Q3c5bmpuckdGdUcwTG45bGpNdGRrSGk1?=
 =?utf-8?B?RTBGamJRMHM0Ni9yeGhKRlJIaHdjbzhmRXU2SkNwT3djc2RLYUdXVUp2Nlkv?=
 =?utf-8?B?S0ptQXUyS3ZrWmdTVDZ2WHVWOGs4OUhUalIwTGpOeGlyYmJlWE03SkRZTlN1?=
 =?utf-8?B?TTRWUzJFL2JNTmsvN1F4bzdJWTNjV0sxc3BJNU54NXR2bmFmZDhHbytLWU8v?=
 =?utf-8?B?WWFHYUVWaDVEbytkdWRYODhWeG53YVVPcTh2SDFhOHRlb0xuczlVVTVlUG84?=
 =?utf-8?B?Wjk5NWRmRWtOWWlQY2VlbitTQ1dYVGptMnBTZS9FNW9xeGMySGc1NElEcHkz?=
 =?utf-8?B?WGhvbWw3TjJjSHFyTmJrQllZR0k2d01jcTFwczFzY3RGeHF2Q3VkKzQvdVQ4?=
 =?utf-8?B?NHR3ZE1Kay91WGFrcml6ditxL2JFV0RNVVZoTC9ibEFJYzM1M1oxV3kzVjFB?=
 =?utf-8?B?TzBRRnBVWTRDYzJPVURWYSt4dDJvN2wySWxmSFBpV2JQeGhtVlowb3pxR2Nv?=
 =?utf-8?B?L2FRc2ZnTElDUytLWkRqV21oMW9ZNmhDTU5BL0xpbEZPdnArVCtwNDNEampx?=
 =?utf-8?B?WDNoazN0L29OL0NSRmo2Q2RndFJIb1ByQkMyQ3o1cGduUzRoUVV2b1R2czFP?=
 =?utf-8?B?ZlVNVkpzK3ppdHVWcGo3VzRGRmQzTklDWWxUd0crZENTWlAxSVpwbWtCaCtI?=
 =?utf-8?B?ZmhVVFZvQmNTVHNKV1VWSmxCekJGM05YTFJWNzUydnkyZ2hRa3pySXJid0tC?=
 =?utf-8?B?WklzV0Q0SmpyNUhOVFNHYkdNWUVLOW5OZ1VRQk8vV0I5T0NpcHRXQjZSd2pU?=
 =?utf-8?B?M0ttNXluaDZCNUNxZFY3SEdUNVZBd1hlbEphN2JZNnVjNjVOdFVzUkVueHNT?=
 =?utf-8?B?ZUdMcnBsdk9OeUhtVkNxYlZtaTBLejNYbmVubSs2SlcwSWFhc05jYWJESCtq?=
 =?utf-8?B?dDJnbWxzalB2M1lXemM2dzV4d3dZU2RmQzFydklxUlpadElOT0ZsSzVReXdS?=
 =?utf-8?B?bHRzUHFBNjZFYjB0WWdDdllWbW9CMVNwVWpxUEFYUnB2Tm5qa0NnZytVYVU1?=
 =?utf-8?B?Ky9FdlZtYmx1ckRlVVpZKzNDellKbjhQKzhTWWpLbjk2Yjg3V2doQkMyVkw4?=
 =?utf-8?B?VmhxaUFkc0FsY1BHcGVyTVZSNXQrempuUjMwUEM3MFRBQ2VXS2F6SkpUd2Np?=
 =?utf-8?B?T2svSzBML011czZsN0Jyb0pMNUt0SzJBM2MyUS9WQW1lRTdyb3k4R3BYTCtw?=
 =?utf-8?B?U0VXTk5iTENvTUltcWNaS080VTJZNVBqZXBEWDcyTlpUVWZuTWtTU0hTTUk0?=
 =?utf-8?B?STZmT2RHdTVDa0o1RUJ4TG5zRGZZY3ZJS0JlemM1V042VlFXZFhWclgvT3M3?=
 =?utf-8?B?NExTcGtEWHVURktwbzBncFdLQ1JpdGllVmp6eVlRUnlOK1BIa2xJVlhDOHBW?=
 =?utf-8?B?Q215SHlheFZTa3YxcVQzWHk3RnR1Szc5RnJxdHQrbjM3Y09admgvQzVvOXBu?=
 =?utf-8?B?Z2NyVUJQVVZtTFBUQjQveHZpZ1AyMXVpeS95UUd4UEFZTk1kK1lTNUJGeHJH?=
 =?utf-8?B?YkJKMVJDR05wMnhwTmt6bG9tSU8rejdPS3dURnZtanh2T1VYLzg3b0pkWUdr?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12355d8-5e2f-44e5-77fe-08da87893530
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:34:20.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5wixF7P8+FTvqJPx3ax7MI0cEgO8koDbXCvv/TqaJRb7TK8R23tOjzksrefvDohPmfm90KaG1b4jJ24SFv3/kwcbIhV42aKurCe7RYfpvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1612
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

On 8/26/2022 9:49 AM, Moger, Babu wrote:
> On 8/24/22 16:16, Reinette Chatre wrote:
>> On 8/22/2022 6:44 AM, Babu Moger wrote:

...

>>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>>> +
>>> +/* Dirty Victims to All Types of Memory */
>>> +#define  DIRTY_VICTIS_TO_ALL_MEM	BIT(6)
>> Is this intended to be "DIRTY_VICTIMS_TO_ALL_MEM" ?
> Yes. that is what spec says.

You did notice the typo, right?

>>> +	}
>>> +
>>> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, h);
>>> +}
>>> +
>>> +void mondata_config_read(struct rdt_domain *d, union mon_data_bits *md)
>>> +{
>>> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, md, 1);
>>> +}
>>> +
>>> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>>> +{
>>> +	struct kernfs_open_file *of = m->private;
>>> +	struct rdt_hw_resource *hw_res;
>>> +	u32 resid, evtid, domid;
>>> +	struct rdtgroup *rdtgrp;
>>> +	struct rdt_resource *r;
>>> +	union mon_data_bits md;
>>> +	struct rdt_domain *d;
>>> +	int ret = 0;
>>> +
>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>> +	if (!rdtgrp) {
>>> +		ret = -ENOENT;
>>> +		goto out;
>>> +	}
>>> +
>>> +	md.priv = of->kn->priv;
>>> +	resid = md.u.rid;
>>> +	domid = md.u.domid;
>>> +	evtid = md.u.evtid;
>>> +
>>> +	hw_res = &rdt_resources_all[resid];
>>> +	r = &hw_res->r_resctrl;
>>> +
>>> +	d = rdt_find_domain(r, domid, NULL);
>>> +	if (IS_ERR_OR_NULL(d)) {
>>> +		ret = -ENOENT;
>>> +		goto out;
>>> +	}
>>> +
>>> +	mondata_config_read(d, &md);
>>> +
>>> +	seq_printf(m, "0x%x\n", md.u.mon_config);
>> Looking at this patch and the next, the sysfs files are introduced to read
>> from and write to the configuration register. From what I can tell the
>> data is never used internally (what did I miss?). Why is the value of the
>> configuration register stored? 
> 
> You didn't miss anything. We don't need to store it.  But we need it as
> part of mon_data_bits structure because, it need to be passed to
> mon_event_config_read and rdtgroup_mondata_config_write.

These functions are introduced here ... so it is only needed because
the demand is created here also. This can be changed, no? 

> 
> In these functions we need evtid and also config value (mon_config).
> 

I see no need to pass evtid so deep - it can be checked right in
rdtgroup_mondata_config_show() and then an appropriate wrapper
can be called to just return the config value. Even if had to also
pass evtid through many layers you could create a temporary structure
to do so and not unnecessarily  increase the size of a long lived
system structure to satisfy this temporary need.

Reinette
