Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893B5A032F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiHXVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiHXVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:16:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8F792FC;
        Wed, 24 Aug 2022 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375759; x=1692911759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PmtEicw/x35n/7PLFMISH+pDq8wtuYIBtHIP2RuyURM=;
  b=kzdD/PiJCOKPX57eiziVNn8W6Ngah8gEDf4/juQCaSGCBQhH/fa0s9vl
   tj7Wu4f2PpN0MZwEvcKTmFiItGBh1iz3qeZxeN7fHRRQ/k79U/Ru/xpYo
   fkMYsN9pg95FWNEpcEtcx2smMBNbGHF/dGb+Ln6ivhMWJNdVoJVxOUDse
   rE3cyrFQFkMAeYrv1dyJFJL0dqwaCYOxYIToasLZeuCtV6bZ49VjWig3Y
   E1fy81noAel8Z+89SRvYjwREv6Yo/YgBV251WoAzblZiDBRYaxj6ozRuO
   st/0GuYuvyrCwlwazSH03lApuhTugcDCHfAlFV4v5uP8utX5IyQoWDHsv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277100296"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="277100296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="713208587"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2022 14:15:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:15:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:15:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfCbXrsNutUB8aWm//nUxcEw/yRX1hcuUdnYfB71vzuK6KU+Al6i8WTrV7lHlbZ4/wIQ+9F0jParm0oSaA0hLG9bg6EumrVeVVu5mLWDeLYNpbmygPnceyuBtZFIp0qHY+j5y+LxbOQNTC3q4dvSMDV1ZS3cOQWQ7R4ULID8k9l3VAdO3Z+I+2WVt0bMvAJ3pmAJQMqDFMB0yRWoVwycMA1vOGu730UdNb1M3TEQQK62axhUY2En73gVPNixpZt0FUMSP5NmiJ5HHt4Zd1UJvHxuKz6p6HJuU1sRGmA3m9Hzh+bydcMplIstfZ2GqLxi2d9z9MZNOh/mmQ0R1xbxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igVONFCEcAqEU4JzqVEg2pZjha7IDD2E9anvNm24Qnc=;
 b=arELKHr1RC+iJQQk6mI6d6VRx28YLrvUSCw4D9nmvRSWE/H6zBV4mg78x67pdgV0JU6BmpkQLjc0TX9RuelWBjYFVmLRQ9eNWhz3CVDPwo5UBLlApgp15mj+KkXOMxfdtBzpMtwCmDEXW73b5sXODCrAwTJsZaVNHG5Nn6z8DOLmpKyrbjpaUxWDG6MqrWbFv3jGaloveR+4G7OkMyvX7zconiN6TEux1Gej5IUiFJixft5aI0lsSVZCae3DC5zsP93mFPABt0OCWTtEE4UUCdtfnDMzq7nLACGw0PbLi6p2C45McnNN7dq9UrFMzb7SLY3fx01J3quH2Rtg+8jA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB2713.namprd11.prod.outlook.com (2603:10b6:5:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 21:15:55 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 21:15:55 +0000
Message-ID: <c5777707-746e-edab-2ce2-3405ff55be56@intel.com>
Date:   Wed, 24 Aug 2022 14:15:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 07/10] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43807c61-3297-4e30-73e1-08da8615d53a
X-MS-TrafficTypeDiagnostic: DM6PR11MB2713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCh3ORhNkU/dWq4gV/Tgl/7PvECZfKhkIXaYwK6u5wEHoxv/l7lxUuUrxhsbcqFgKz+WYoA+0/DCjMvalWnJdP2FcVUk9BpRsLQMPI4IWtRiTnZ9M9x6C5ofx7ttqN1sJ99dVFwTgnEbsOZ26yAGsNstMd371+B6bdZSdPFRqmzyQV5C5KfsuwB4NLzxTd3AY1A7Hoevc66+oHZvQExegUW9BLv5rN9lbqJdrgTLmwhQe3Pp94X95+N/AJTC/0QF22Pt9lKjbg68qjz3sow+pFGk9gTnYmoH578G5wLMDq0nPby1K+RAcmaGAtLXCZUJprg8UxXMbe+J+QnN6iLfEUm6IkF4ktL12IGQTYn6YzYOQ+4fK7sHMXGrILQkjS+wO70AOlMrFaruJ5UPAlJZu8nGzjgeSYLRtuBWeOfCvsIhEtb0MzPbbR370rEOrSJ1Ix7v66cRNgLZaF+ch8HIpk/TGanVJikXI/ZCi+D38Ow5eh+oL0LpBCPQ3aPUi8tUXTclswXfPAzTcp3i52Fu2IlnW/ZPUmHx9cshbjTAPGvsJODIDHMCRc1brbeVuST1uFVGK4o6NH4O5ZfMlRHgcOQQogElAdtvMoEfr4YNLv/xM/WyJW1nyJZZBmqbA4OuXCk6Oj64yfj9wdYJYOhlOvTjl/wWPXgSr3lExqyXtij9oZwTfvJ1CTv4lyWsWBysrl7ZVCs4DGX/REK6NXIFlQGKkfr+of73VIog+/3R7fVq8CcOEXY9AbBS/mXEJMR2Mj1wZLKojK8eVgy5/FiR/Z0TL39PCP0QXTYtWRIol9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(66556008)(66946007)(4326008)(36756003)(66476007)(86362001)(38100700002)(82960400001)(31686004)(31696002)(8936002)(2616005)(6512007)(186003)(26005)(478600001)(6486002)(7416002)(316002)(6506007)(2906002)(44832011)(5660300002)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJjaERNNjRwdURhYzJlaHR4Q3VCNFJIUkY2QUNOR1Z5L3RRSGJTQW9XREtU?=
 =?utf-8?B?bVhZeE9jNUNDZjRBajFQZVZUR2wySzc1MWVreWFqMWIveEpoeUd0S2JVMFZU?=
 =?utf-8?B?YzRUM1AzOHA2OVF6NnQxc3dEQlZ6TmswaEVLV0hHWFJjd1FRcGsvNmxlbCty?=
 =?utf-8?B?dUpSWEd3bzA5dkhBZ1ozNGZtNy8xdWYyWXdpNndNcmJGcnp0SW5YdHBkQXlY?=
 =?utf-8?B?YWNwOWYrcTJ3bWcxMUJrdEQrU21CeXNSY0tzZEhwa0lySitBN2NSTXFaS2pV?=
 =?utf-8?B?V21xVjZuUFluNkZrSFNZSi9LUStvWGdlMVA0TDkrLzZoNjVLQldUWU9PMHBY?=
 =?utf-8?B?WFphSFVBZ2F5bjhiZlNtUWxtbTZLOEZOanZNL3pydHN4bU0xRk9MWWdWUXlw?=
 =?utf-8?B?OE0rTzdyNkdJdnppT1JjT2ttVlcxUzdkUEh2d2tOc2hwOTRZbHVwTHR3WUJp?=
 =?utf-8?B?aGZRd05wa29ZR1lYcEFuZ2pXZEtiQ1JRWUNnMXloNWJIb3VIM1grOThpeXh6?=
 =?utf-8?B?Sm9VR3haNm9iMk0rQjloMks5bmFqNXJFM0ZGSldyS1pGRWo4aytHQldPTUQy?=
 =?utf-8?B?M2NEcjZMSVExM2xIbXA1aW9zMS9KMko2SFlodEM0UXQyTjFSbTVld0s4Tnov?=
 =?utf-8?B?STVWUEo1RkNMOGlQbEF5bzdHcmFWeXFRMDI1Wi9Tem9TWHkvUHlleDFKNzd1?=
 =?utf-8?B?UXNUZWFhSHFDNmU3ckJwZmhDaHVZcWFHeS8yTDNrMk1JVm84VE5CemRXeHBL?=
 =?utf-8?B?S2J4RWpkenNqVlpsVFFUMTEzTjh1cHRJdTNmZ2thbkZ4QWNLQnphMGFoSnhk?=
 =?utf-8?B?UVdBSTd2cmV6c2VhN3FzaXRCRkpWcFFJbHVOSnl6UlNNQng2NEhJbnhjV3RJ?=
 =?utf-8?B?cVB5Q2QyajhnZWhRRW5kTDk5MURWeGg4WGtvK2hkM29pYThPZG12R0g5M2l2?=
 =?utf-8?B?M29LTmJoeXZLM1ExMFBzNUNOQWFON1lyaFFrelpYVC9CZXlsQWtJamFueldm?=
 =?utf-8?B?SW1lNURoT0dHVDFjcDFoVFFiYld0cThnbCtKNGlWcDZyWnl3ZmlibHVkNHdN?=
 =?utf-8?B?NFR4K0JFd3dJdWwvUlFBREFGVk16WmhkWks4aForVHNsWHVGUkE5OEh3elRr?=
 =?utf-8?B?WFFHVWJmT3pOMGNwQmhSMFY3cGZOdTFFUENYUHFqU1J3T3ZlRWtaSVdmYTRq?=
 =?utf-8?B?b2JMa1JuTitVaTlLSXNBd1RPOXBJUVcybGg1bWx2aTZFZDh4V1JQMjNiMElS?=
 =?utf-8?B?VEw2NllQcGszNEFhcTU3MzJ4SVVXZjN5TW1PdjdyTG1vU2lBcTFwa2NDOEZU?=
 =?utf-8?B?UXpWaW9EL041MnYzbzZuQU9FV3B3WnNMbDhNWldCa2dJYlpWdFlRM0laVWpm?=
 =?utf-8?B?aTJpZ3NSeDJDUXdXL1pMdkx0dTQyelhNYkxiRGI1U2w4NUxOdlZMVmFrRVpa?=
 =?utf-8?B?M3hUZkFwRVRrRFdZVStrUVByKzlQaGxmWmhteElJNVhmcloyN3RiY1lSUzdM?=
 =?utf-8?B?ek5xN1dQLzVLcmpjNHRldjJ2UnR3OWlDNTNXTHJtQ25hVEpma3Fhb09zQkY0?=
 =?utf-8?B?UGl5YnRDWHFsQlphRG5kOWgyc0lRZG5Wd3RLSFpndmNQQVk4cTlHSHZCd08v?=
 =?utf-8?B?UDkzNTdKenJwZ0o5UElMbmhaQ0pKUTFXTGJnODZNYktIdFpRRnZaOERwbTU4?=
 =?utf-8?B?bTQzU2xiTGRGcU4yNXEwUitlRTlMSHRSekhCb2x5aTFwQ1FSMDNmaWxIUUVZ?=
 =?utf-8?B?aVR0U090SGErOUY5UldOY0NMUkZacElGNGJvY0t4NEd3UnRpb05xOHp2NmtV?=
 =?utf-8?B?TWI3NEZZS1lnTDV1M1R5dTVjckFkR1JjaloyQ3VCbkwvdzFTYUgrTjNiV2RH?=
 =?utf-8?B?RFE0Q0RUR3dKWVpRc0tvUmxwZXV0L1pWOHd5bktveGhWcWFJNS9IcXlBRWFE?=
 =?utf-8?B?TWFWUW5GYnFENUxyODloTHZ0UDZKVFhNS3NKT21QZE9NUTJIUmtYWUMxcnRB?=
 =?utf-8?B?cXYwN01DSUFHL2trOHhaaWFjNllZUmd6QXZ0NkUrWGlycG9RaEVQUG1La0di?=
 =?utf-8?B?VzdSRGRWejZna3ExbjJhQTcwdm5mTG9RQUtxV1NHeHpOcUFtVGVma1hHei9W?=
 =?utf-8?B?bTZZRCsyNG5tZHFQUkxKVWlvWXYzM2Urbk9yTVN2cGx2QU9SM3NoM3dtb0pG?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43807c61-3297-4e30-73e1-08da8615d53a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:15:55.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImwZhSXXkn2sL99Ibq5RY6wuvB+LbEUDIpebzPBq4Pq0wyMctsCWkeeoQhGf40lo2JeMwQahGPB338mtr3/vJPrJ+Fu7CWXWs1LUioyaD6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:43 AM, Babu Moger wrote:
> Add two new sysfs files to read/write the event configuration if
> the feature Bandwidth Monitoring Event Configuration (BMEC) is
> supported. The file mbm_local_config is for the configuration
> of the event mbm_local_bytes and the file mbm_total_config is
> for the configuration of mbm_total_bytes.
> 
> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
> 
> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c049a274383c..fc725f5e9024 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -72,11 +72,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
>   * @name:		name of the event
> + * @config:	current configuration
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	u32			evtid;
>  	char			*name;
> +	char			*config;
>  	struct list_head	list;
>  };
>  
> @@ -95,6 +97,7 @@ union mon_data_bits {
>  		unsigned int rid	: 10;
>  		unsigned int evtid	: 8;
>  		unsigned int domid	: 14;
> +		unsigned int mon_config : 32;
>  	} u;
>  };
>  

This does not seem to be used in this patch.

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b9de417dac1c..3f900241dbab 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event = {
>  static struct mon_evt mbm_total_event = {
>  	.name		= "mbm_total_bytes",
>  	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
> +	.config 	= "mbm_total_config",
>  };
>  
>  static struct mon_evt mbm_local_event = {
>  	.name		= "mbm_local_bytes",
>  	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
> +	.config 	= "mbm_local_config",
>  };
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 855483b297a8..30d2182d4fda 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -254,6 +254,10 @@ static const struct kernfs_ops kf_mondata_ops = {
>  	.seq_show		= rdtgroup_mondata_show,
>  };
>  
> +static const struct kernfs_ops kf_mondata_config_ops = {
> +	.atomic_write_len       = PAGE_SIZE,
> +};
> +
>  static bool is_cpu_list(struct kernfs_open_file *of)
>  {
>  	struct rftype *rft = of->kn->priv;
> @@ -2534,6 +2538,25 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
>  	}
>  }
>  
> +static int mon_config_addfile(struct kernfs_node *parent_kn, const char *name,
> +			      void *priv)
> +{
> +	struct kernfs_node *kn;
> +	int ret = 0;
> +
> +	kn = __kernfs_create_file(parent_kn, name, 0644,
> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> +			&kf_mondata_config_ops, priv, NULL, NULL);
> +	if (IS_ERR(kn))
> +		return PTR_ERR(kn);
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret)
> +		kernfs_remove(kn);
> +
> +	return ret;
> +}
> +
>  static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>  				struct rdt_domain *d,
>  				struct rdt_resource *r, struct rdtgroup *prgrp)
> @@ -2568,6 +2591,15 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>  		if (ret)
>  			goto out_destroy;
>  
> +		/* Create the sysfs event configuration files */
> +		if (r->mon_configurable &&
> +		    (mevt->evtid == QOS_L3_MBM_TOTAL_EVENT_ID ||
> +		     mevt->evtid == QOS_L3_MBM_LOCAL_EVENT_ID)) {
> +			ret = mon_config_addfile(kn, mevt->config, priv.priv);
> +			if (ret)
> +				goto out_destroy;
> +		}
> +

This seems complex to have event features embedded in the code in this way. Could
the events not be configured during system enumeration? For example, instead
of hardcoding the config like above to always set:

  static struct mon_evt mbm_local_event = {
  	.name		= "mbm_local_bytes",
  	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
 +	.config 	= "mbm_local_config",


What if instead this information is dynamically set in rdt_get_mon_l3_config()? To
make things simpler struct mon_evt could get a new member "configurable" and the
events that actually support configuration will have this set only
if system has X86_FEATURE_BMEC (struct rdt_resource->configurable then
becomes unnecessary?). Being configurable thus becomes an event property, not
a resource property. The "config" member introduced here could then be "config_name".

I think doing so will also make this file creation simpler with a single 
mon_config_addfile() (possibly with more parameters) used to add both files to
avoid the code duplication introduced by mon_config_addfile() above.

What do you think?

>  		if (is_mbm_event(mevt->evtid))
>  			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
>  	}
> 
> 

Reinette
