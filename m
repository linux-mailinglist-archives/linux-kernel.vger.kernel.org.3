Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F85A032E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiHXVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiHXVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:15:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C43CBC4;
        Wed, 24 Aug 2022 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375741; x=1692911741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSER6EjM3fgusephY6GVSDoqQ3zXjICpFuugBWKwNvU=;
  b=KdRJYTIlpmZYqprHyKBlyHly0odvI32y14wZisKX9HmbiM2vBlQzoH5n
   DwH3QpDU+5p4wysJZCXsyvYt4hiICQADmV9hJq9j8rFJN5OWcKbg8dyy1
   OVYWvlYPEkJmoMucSd/BeMDhn+hGmSzOTTBQEER7wHtUyZktwsNDmI5K6
   QD12std4Fl58pZJLCkhFEbi17eCbbblyyzxfZNzxaOWZumCCz+ehMZZeo
   qM/l61CV7GFEGvVVQFft93DqIdh3nUFbIU0pSwdTijrpEJycLuivqwWxE
   vKw/KkYCh6SRi8ynm+8MEKQkd3uyC8IdwKcKlB0tecXMwpLkw0apDa6w0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273830963"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="273830963"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="612936468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2022 14:15:40 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:15:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:15:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:15:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvJm6RveqcEZmgY9c8NnSxOdUGFlBJLojilTT4o+aX0kJjDQx4EsvMPZpdzpd4hO8UVfxRocf9/1E2eXTJ4hQArOPbEIctdbsgHJ5Adv3La+aMyZdwAHTEBDomVKUpP1+b0UToJFcmrdB/b7dUPdmzjTYN+3csuyiDNP7cz+AbbVWTfRrXdNaew+KE5NirmyU6cRddXwXC8sIPx7XtbOh04nLKVCkT9LwYinkvHKMlDWhhX2/zfJ60qwLOTSQDkXENapZU1pV8kub8W9P27X1q2NM+My3y6BrnWFzizoiJDSteiF8KC7ds4nhk/wH5HM5WW053oNYOEBYsGAP1KZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6w857+gYSHkWs5Ld/BGosAbeG6Vz3zng7YG5gDBe5I=;
 b=KqpwB7dv6N0gH1hs1Cn0LN98jnM+2C+883h1/mTkswE53005qOSI0qzd/ebCQQYX+PJkLaQeU+EgH9UY1eYAvXvv6ZD6OPjt74dGjiuZ2pKXrBoZPvymb1YcVSPx8IyGc5GXoJuPYNR9e5uwYXRCDbZXxoKxM9478g0g6+9jK3lXWv1jKu9EjZbcn6RFjfP73UPW7/f7A9ofXY0lqy4ROmswYaQEWa70DmYfURMxffwc4s/peM2k4I0Y9zqQQajMjfeAQ2CmFPbgSTq0IjnjJMcoqzqnQlNdlYdDCsjVZplqZLVVfPhjedgP7jjhgNTdjNkFTcJ0NvOm5aMQVDQvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB2713.namprd11.prod.outlook.com (2603:10b6:5:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 21:15:36 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 21:15:36 +0000
Message-ID: <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
Date:   Wed, 24 Aug 2022 14:15:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to
 detect Bandwidth Monitoring Event Configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b841ba1-d05b-4a7d-28e4-08da8615c9a7
X-MS-TrafficTypeDiagnostic: DM6PR11MB2713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rGI6RtOBkTF6zEj85czfM7MweZLuocM3pokRRr1/RZwQgO/yBbN3gcCIAVT25HIHO2s0OlwzOAASm3r88cWmgpZDKOfUjLOlDYCexV8zljEQbXkZAFIniERFNv0DnqNur1QVAiz96KazSYD4lSbiAo+gc19NafG8xf56JDMILVHP8CrvBhc9Dt5pjPs+hYIIt2mFh1n53VvekK8lAVSdXXi3vALGht1NJUpCyFddxr6mCOFHCmJq9WLGM+qflD4Xl7FVOxQ4T42kgITwqd96Hj21qWElLPkLAhyElNII1tCtwRrf0ofkExtVgHCFY2D4g2HlrGJPSGQF/qFFsSz9JJyGpnP+5FL2g17+3e7ANPWGVq168UpEnlx63JbKp0JphiKCGJM2knGdgX/E1sZO8YgyybO6qwFriDOGV3wgLkE1aGmxLNwOusjT8gg9JVGxsBYoo8NZKgiwcKU78Retk/oX8lgWh/JfxdVU1qUSXWpKtKrkqJfAoCvkBWCHLT9Xnw0fD26LynytLXPDM3d8Z6hi/lnxN0o8o7EwaPPHzA4NCtZxsEZrae55A7jHcHId5qpUSDNc40KQB2Gxp8tyKm1kjs1cmziJnSRzIpQlfAmDBJF84457hnvtDEFYS/tOsXQXN+RR940u4Kk38z7FMGgdCuVkIUw1Cml3S/99U8unRsxxqIWDxUUEJ8H8RVfQKFKkHGis+Xs8GOZhVjqbvvzpin7M1b+x3ECmHfXikfHcHWrrA4UKWTVZSnwGSJol6iqHCWwiJmmCjWkb749D2FLaOiH3GiZhebepgWLRu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(66556008)(66946007)(4326008)(36756003)(66476007)(86362001)(38100700002)(82960400001)(31686004)(31696002)(8936002)(83380400001)(2616005)(6512007)(186003)(26005)(6666004)(478600001)(6486002)(7416002)(316002)(6506007)(2906002)(44832011)(5660300002)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K28zNllldkNKM2xSRHdhbkQwQ1NWMTkzb3J2MTVoTHdXMXpCMUQvSi90VUd4?=
 =?utf-8?B?VW0vc1JZUGhINlNiY0tjNS9NcnZoQTBldWpkSHNZczBVWlQ4TVcyd0psN2t6?=
 =?utf-8?B?eGNrT0RzSHZGVTdIMkNUZ09DQStWUFZubnI4NmZTQlQvdjZSY3o3dXNNMWNh?=
 =?utf-8?B?Vk9sR0VkWldDMjNNcDMwYjdrVStuOTR3emdrOUdYWkxUdnNlaW1MMTZmRDRT?=
 =?utf-8?B?RnhRTTBKUzBzVmtaWkl6VGh2dHNqa1ZOWk1KdDJvTmxKZy9ETG8xVXNhQ3pG?=
 =?utf-8?B?NXRhS0R3dHZGODlST05jL2pxd1QzVTNFSkNoSkN0aGhKZWhZT3E4SzAya3ND?=
 =?utf-8?B?S0ZDZGhzUFQvanFMNWdqMW1HYS9vMFZ4bDlqUVBkQ1lQKy9OTzJJZFBnSVRB?=
 =?utf-8?B?dS9ocUozZkxjZ3BuYzJDdThZcWJRV2FHbXF5VkIyRnpjOXA2cEpkZnpsVVh5?=
 =?utf-8?B?T3p4WkVIZU9RcnlrRVdiUW9IRnlxSUJ2dGZkNTZuZUtxaVQ4U0FKQnlURXVV?=
 =?utf-8?B?dm4zWGhhT3NnM3c1ZDZpZGRhSU8wd3VKRUpEUHlaeTZyUFBPZkh3RU9jamtk?=
 =?utf-8?B?NWFlWTZmMlVITDB2by9uQkoxNU9COW9vOGNHdzZXRVREQ1ZZTHRVRXJHckFu?=
 =?utf-8?B?Uy96VThkenpVUUsvSEFLNWhYZDZielBHUzM1VW1FdlYybGhrMWltY2pycHRx?=
 =?utf-8?B?MFFyalhQOHZnZWZ4c1hrVHpTLzZubkJiMmw2aTM3WlFyN2I3TzFxK2dOM3Zj?=
 =?utf-8?B?STMzMWhEWk1ZMGtBL0xzeWpTSG1RL0FzSm5IZ0NIU3dtMjVCQ0RoSVAvL1Js?=
 =?utf-8?B?Z2U3NnVwb1NNTUdkM09udll5cGhVRUVNMTNybDAvS0RoVXNBcXZTRElYQ1lC?=
 =?utf-8?B?QTg5bVIzKzYrQ2RvK0srSG03eEcxMFo3VlVhYzlvSU43M2sxRjNsc2w0dzZS?=
 =?utf-8?B?elVGOUgranRLUm5JL1JRZWhjczd4em1PZkJKOFRNOHQvbWd1dGpKV2JpcFF1?=
 =?utf-8?B?dTFDQ2ZjaDZBeER5cStFTXJDUVlkdDlHU1JQeEc2akJjRUxUTFZFMm5jbFM1?=
 =?utf-8?B?T3Q5MnpjNXdneFNKd01SWG44bUttTGdZTW5oZEtSNGxlVHJQYVg5ZzB4bmQ2?=
 =?utf-8?B?UHJMOUJHMWNqZDNvQ0xDZnNvVDdYcGJMR3BiT1NqcGhZcDZvNnBjVXRXbmlI?=
 =?utf-8?B?QVY5d1lwcGh0bUwwdmhhQnQzUHJISG85YmdEN2tFUVpITnpYaG9VMHRWQlcr?=
 =?utf-8?B?dFQzb1ZDUmxYSzhyU3lBakEvNTFUMFJERmkxMjk0SnQ4VWNUTzEzMXdmVHFq?=
 =?utf-8?B?WFIvSzJ3TGpXOG9zV0FSZ3BxSFViYlFQSkI5V1c5WFB5NWNpVXhXUmwvZ0lC?=
 =?utf-8?B?Q2VCVjltcUIvaVpoTGxvallMUG10Q0dNREY4d2dYS1NrN0FuU2FyRk44TTRJ?=
 =?utf-8?B?ais3VlVKRG5KcWVwdW8zbEhiU2FSWkpCaGJTdEUreHBIeFpTZlhOcUhhQXZj?=
 =?utf-8?B?cW5VdC9sdng5NlhoQ0RFeUxHYnZlK3d4bm8vc3B2TGQ4RFZSeEtZNWdwb0JV?=
 =?utf-8?B?ckl6TmZGdUxqaXorblRLVCtHRnVGdHRRZlRHK2NJUVVIUEVHRUYwM29JT01h?=
 =?utf-8?B?MnFhVVpqZ2Q3bjI2bmR1cHFoZUo2QWxMUkZjbXJodzloK3NreXVjNFgzUStQ?=
 =?utf-8?B?Q0ZSY1RlT1p5WWxwZVNjeCtVaGtoOEMyOTJwdk5oRTdzRmdia1RlaGFOZzVY?=
 =?utf-8?B?M2lZNHZ5a2ptUUlxVjNuZW9scTB0a2ZaS25uZ3lKZHJBOXFJSDNTMmlMcGRa?=
 =?utf-8?B?cHhTbTlrWVg4bURmcUM0MXdEamVXZjBZRHYyTm0vYXNCejVCTjM0VzdsNTh0?=
 =?utf-8?B?dGtlVjN0bnJYZkVqVlpqWmF0WEZvVjlZc1p4NlgzNnNubEFWeXYydy9Qa2pu?=
 =?utf-8?B?NXdaMnU4TVRIMG9rV09FMVR4QmRPMER5K2tQS2ovL3lxOEpZMFVzYzdsRVV2?=
 =?utf-8?B?eWdtRGhtOXkrd2l5V2FnN1gwT0FseFpYTDNOMUluYnJ2WEJkcVVuRGtNdmYv?=
 =?utf-8?B?OVpGQnZzaUZaVXRFcDhuV3d3WW54VkNSTW1SSTRHQ0V5b1pGRmtGeUIwbkVD?=
 =?utf-8?B?RXNpVndQTjBVSTF1UXQrcWgzdW1JR1VHdENsRmxhdGEwQktubmVkNUF4V2Vl?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b841ba1-d05b-4a7d-28e4-08da8615c9a7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:15:36.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXaIWe+U7oja3Xz1gHWX5OmE06OUkcyqatoRgu40Z3RtqgA/Evwwlz3UnQQp449wW2qAoIvx/BZOI9my8j8wdJynKxV9N3Vylmkvizs8Clw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:43 AM, Babu Moger wrote:
> Newer AMD processors support the new feature Bandwidth Monitoring Event
> Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes
> are configurable when this feature is present.
> 
> Set mon_configurable if the feature is available.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c  |   14 ++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   17 +++++++++++++++++
>  include/linux/resctrl.h                |    1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index eaf25a234ff5..b9de417dac1c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -682,6 +682,16 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>  }
>  
> +
> +void __rdt_get_mon_l3_config_amd(struct rdt_resource *r)
> +{
> +	/*
> +	 * Check if CPU supports the Bandwidth Monitoring Event Configuration
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_BMEC))
> +		r->mon_configurable = true;
> +}

Could this rather use rdt_cpu_has() with the added support for disabling
the feature via kernel parameter?


> +
>  int rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
> @@ -714,6 +724,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	if (ret)
>  		return ret;
>  
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		__rdt_get_mon_l3_config_amd(r);
> +
> +

Why is this vendor check needed? Is X86_FEATURE_BMEC not sufficient?

>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fc5286067201..855483b297a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdt_mon_configurable_show(struct kernfs_open_file *of,
> +				     struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	seq_printf(seq, "%d\n", r->mon_configurable);

Why is this file needed? It seems that the next patches also introduce
files in support of this new feature that will make the actual configuration
data accessible - those files are only created if this feature is supported.
Would those files not be sufficient for user space to learn about the feature
support?

Reinette
