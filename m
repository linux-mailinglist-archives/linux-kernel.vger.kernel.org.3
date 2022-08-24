Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2720D5A0337
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiHXVQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiHXVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:16:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F07C740;
        Wed, 24 Aug 2022 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375800; x=1692911800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OpHZOLK8Re901DtVO7IeNJPmmFjpBW9Jdrt8i4CTb/8=;
  b=J44Np6i4nGIpjgPOuDsnDioCAg46kseob6wRT3S5hEl6hzhmWpxeiKYI
   mLLnzG+7e/elqR7Az9/78bA0wc3CDyrtDkJ8cBJCehMBupjB78xQaVJb+
   5B/RQ/YqGGqawC4s9qNw25+HHYFwAshBErUWMe3uwTa6SUvkSmGz+uSbu
   p5XfiEfhNtxViypxO640+iubqezlAuuUJtgF/WXkdMPdHDgUCvYpNA5gC
   sbzrzPlSjfy7SmXFrkDfp92PzgZntEI6l83sazT0S8KnRdRFI4GStm2Kz
   aleEPJcppH70rJRjD24MoT9vUTHBvh5JKZbmIaRjhc6nKNotodnfvQOQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292823147"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292823147"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="670682606"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2022 14:16:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:16:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOVD9YmMQoRhUg52FmNx8EabqxCW1W15mWQcKCwXiNujZbDBKRkTBAEwcsDc1EMGtYHcVNnmynS+vXNxCmbDk8pYTJ267E4PsBEoFaLUuBMqLipn0TMWzQXY/o3VxhIiLQi2IccX0OxZASws3ByvAJ8MBeoCch9XjwpHLGB7I1Rw6s6yv6cK+vfYiNAuhRB2odCOa/SZ+/3/vjxEPnlj1w3fSB2AqEerpsHveIsVPXlMzWWMEusueRw4M5C8Tf4umsVue4Fi2I/1ck/HVbFrEdlIbQSWKd7BLJewmIhlWV1j5kfsVt0l7zuqZCMeYpZy1JhGFYliJrNFtsNy59gTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJJVGAWPdgFof0+lqgtUsAf3mU2/IepdW4Vx3GIVhRs=;
 b=O++BdD0v/SziWbbcLuoPmrWH7hcNKeEYXZeixywsqSgfqrJSOsoDwRnDqVQJZb1HyZXGRnn9Jqtp9BhwTJbzuU1C7CgGwCl41tdQ6THyiogKtbdt1sKvK9v5JzFQiprKXuKgwpPWQnfwdt63P38P9iHiPCQP10xfqDaCOsnPMUvFqBn/L/5J/yz4/9bdNoum7ue75H5O14D+3mo+yRfbYFpar+ZbG5qpF8TURdHY7ZIv0neYgXLtGJvcxM809m1leK5oXW0VTrwnIYNQTlBBkcNJtXVO7Zm+0yPUzMmxyn/iUpDs3MppPcjUKo7ElhI53IpRW9jGWpxfQvQVFHG3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB2713.namprd11.prod.outlook.com (2603:10b6:5:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 21:16:35 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 21:16:35 +0000
Message-ID: <eca1657e-3dbf-d46c-fecf-f8888a25a878@intel.com>
Date:   Wed, 24 Aug 2022 14:16:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 09/10] x86/resctrl: Add sysfs interface to write the
 event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586910.6695.3670808098195387542.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117586910.6695.3670808098195387542.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e4467d-cfd1-4326-3ee7-08da8615ecb9
X-MS-TrafficTypeDiagnostic: DM6PR11MB2713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5JdsvbbCJMs23okLnlbQHJI5ZHBzo9tu53zevD2MUJKQ/noSUdUsJkfgv6LsT17+m0A7r+X8WL7CHe+0sAlkE9rEgy/X768MnVLgN45n8k30tTEBWAvzBo1wZ6tWvw/amKmjMtiLW7bHRmA18+wpeJcBwvGQWVIW8Scurj2fKrzKh7tZTYLuwO9L9eJIQHr1ieSyXAIYeed1GoVrqwOqxQYl+4mPXdoN5apktN+GyDVbfG2lgdM1qjhI9jWVVJ97d7Xq3fQduv4GTSnO7Q1T0/SqOx6sTM/uCXVnhY5Tblr+EMc5Z+WYHSHfosb17DoJJqOuiku5M8B9HdWsXHAb+ZaCMZLtBoqY6ZOsqGbDqOK/Icmfj/ZuWAIV7kVzckJNXB1VBkQx2+V/unupJ0Q2NvOpRvKlHYtsvYs7Wx0eBPMdsr3b+hSmEwDUhxDtlFLVXOo8wAaDKzbbuwEtJ/1uDzkIVIArHjvPt4BEC/diTivIBh1w7x3qfNz1os89v+n+fjdXaox8edY71PmBoIuaYnC4dIR5xPJ2gg67DEC60FVTh/MYhDp5793MuL9XxBNXCdE2STHXyFxAotNRZwry1Jpe2U6c/StlUI52j7VCPtmpi+gF8GoWLDEjrdcVuLVtZFzEOAS222iEunyoA2eQCWkOY5WUGlxmJJZxjKQtjo6GrRe7Jr+g7FgBBGsaTGoW7HtZRArdpXymPpYzqQMa2upKPdaHTFkSXG1jHbTW6OFcNBcZhYFMnZNJxsIxzvPJY2tWHWf/jVAV+Iqm+JW/vRI1RdlrI1e3Us2417mUGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(66556008)(66946007)(4326008)(36756003)(66476007)(86362001)(38100700002)(82960400001)(31686004)(31696002)(8936002)(83380400001)(2616005)(6512007)(186003)(26005)(6666004)(478600001)(6486002)(7416002)(316002)(6506007)(2906002)(44832011)(5660300002)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEp4RVk5NkpWbUYxUmwwTmZZRGdxYUgrclk2NmVIOTAvTytzRkt3a1pFTFE2?=
 =?utf-8?B?TzhrWUJmVWdvYTB0NStjQmJjZnVmaHJMK0hpcFIrQi96NkVwM0IrZGN6Mldt?=
 =?utf-8?B?dlFZTjFxQjhnMGpWbnByNlp5VG5VMys0dWtzdTk3Y3RGYzBkMmIxNXdFc1gw?=
 =?utf-8?B?Y0RkcmFCQWE2eWpuL2pWQWgzQjdKYXlLNUFJVThhTTVaZXdkR3JKUFl3NUY3?=
 =?utf-8?B?aUliV3M0UkN0bUhjQXJRcVhQcnNML1hpeEtpc3RKYWFDN0FpWmJxekc0ODF4?=
 =?utf-8?B?cGFzWnYydjJwamQ2L0l4ZU5ITGVBelA1bjRaRVBRQzVMMEdiUEY3YmFVMEpF?=
 =?utf-8?B?dVdhLzBEQXFTc0FwcEZ6V1pkMkdHYkRsREliZVRLWjB2L21DUHByN00vWDJx?=
 =?utf-8?B?OTU0TVRadjFrd3hESFNFNVFCenZMNFpwMXRrUXU3d3QxTUxNVGRueXpCUWxH?=
 =?utf-8?B?WnhiUC9FQkU5ZStDS2N0SXZLd2t2UzNBeVoyYTBGaEdNRVNLNis4MDduemti?=
 =?utf-8?B?Q2FGTEI2S3RvZmpmblp4cjlaYVlWUkVJaUxSeCtqbWpVeG1iWWZJQkI3RWov?=
 =?utf-8?B?K2ZqOFNoYzh2NVhCMUFBMlJESUEwemxMT1JIcnpFR2ZPU2NXODBEeUFoV3Bo?=
 =?utf-8?B?Wk9BU29mWHRLRitqSFJ4cDQ2OC8yME5uSjFyOWNtOW8rVkFIaDJlTGdjcjkx?=
 =?utf-8?B?amR0bmF0eVZKYUwrOUo5K1dJVWhNelpMNDh4U1FLZmJXR2lvcHRIVnh2ZWJZ?=
 =?utf-8?B?MnRLT3psUzhDUVlIZk9sZitRODROVTh6L1VmTG5mVFUyV1JVOUlFSW5FQVE5?=
 =?utf-8?B?MkRjVTRIOFloVXhXVy9XMW5rK3EzcjFtVUFUTGFNWFVOaXBrSWE1clN4SGNU?=
 =?utf-8?B?ZWp5WmhrRCtyVHIyeTF0TEN6RTFXQnRLMk1YNTF4RGdHdFZWMENwSG5nMW1z?=
 =?utf-8?B?ODEvTjhmSEFJaFJNeXY1bURtODNuZm5MUG8rYlN6QmpCZElpbXhYNCt3Sjlr?=
 =?utf-8?B?cCswUi9UdVJFaFFBWmZldE9HUmxBZHl0WkJQeXFuMTVydlNYQjgrSEhpbjlt?=
 =?utf-8?B?VXNBUTRzTUVueHVDRE1PdlF3M2YxK2VUeGVHTVljMUM0Vm9DVmRkMWdnbE9N?=
 =?utf-8?B?QXMwMmJXRHN1RXR4c0xndnVzVitpUGY3Zmx5MDdDaGJxSTNYY1IrTStsbHM5?=
 =?utf-8?B?MTlGdDk2S2JhQlZxUW9YR0Z2Nk9jR1FoU1J4ekJuVVZFT2RtSWJSK0lxdVNT?=
 =?utf-8?B?bDlDeTlRQ0xVaklyaWgxYWFiaTdDY3dQS1gwelhMMUlFR0Vaa2NtbGVDd1lU?=
 =?utf-8?B?TEVENjA2dHpVYS9GT3F2cWw0WTZzWXJXYkF2aW4zb2VWR1BOM2UwV0d1blZs?=
 =?utf-8?B?b0haM2pZWmlGd0hBa2Y1aS9JcGNDZmdNZUVCdlgrNVA0Mlk3c3FwcitFalA1?=
 =?utf-8?B?OHkvYjUvRHJpNDdxTm4zVzMzdDJZUkNuY280V2thTHNoQmE4QVQ0cUdaa1E4?=
 =?utf-8?B?TCs3OXJQbVNKMVgxZ04xRGxobE03QmszaWZDd1k0UVhVVzJFVndHbEtXUlpJ?=
 =?utf-8?B?eDhlYWFSU1AwWStDS3czT3dMeHIwcmRiR2FlWUFNVHRLRlg3WmM0em02ckph?=
 =?utf-8?B?czFZYXlvYlpiSk1zekE3QXJNTUIrVFhxNWU0NWVJK3BMUFFJQzRDQ2hIU05i?=
 =?utf-8?B?KzBlOERUU1g2MlNvQVd2SDJaMjZRdllhZ1RybEEwekp2MCtPd1hFYng5MllN?=
 =?utf-8?B?RElpeUQ2MWJpbzVSYzVBbTh2d1kwZ1lreDdERmhaK0VPb1N2bWR3VmVabThi?=
 =?utf-8?B?Yk9NbkFBUXdmR1FRd2JRQWRsWVBuMjV2TitNVjVEaXMwOHlvcGlHSjNtM3dH?=
 =?utf-8?B?MnNiMmdaWGhYUHBGVVpGTVJQNHdLRExsZURmejdhSWtMKzQ4ZlNralprSUtm?=
 =?utf-8?B?Z2p4dENmbXNFeE8zblVmbk12ckExRWpydzBwd01qQzlHMUh6bCt0RlZJUE5s?=
 =?utf-8?B?MXp6WURUenYxb2l4UVZPejFJSGcwWmVBYkx3cFVrdk4rdHRrZnpwQ0F4L2Np?=
 =?utf-8?B?c2JLcXdhZTZwb0Z5SURRQ2NwODZxRW9UdXY2LzVoNm1HUXd3MUsvNmZjVHFv?=
 =?utf-8?B?UERCM0tJNE1sUGlibDRZekJIYmFZdWtwWFE0cjNrbi9HaFU2dU91d09NTWNk?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e4467d-cfd1-4326-3ee7-08da8615ecb9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:16:35.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OubX42Cpbpgtqti1LRycY1xIkzjxY3ccrAYBMg4zZVfjTyo0LirPLVtP0wVLvUMahrEmXCI8B89F5xK2KgXDnrqcmAIfZD18AJRmgOB5L38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2713
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

Hi Babu,

On 8/22/2022 6:44 AM, Babu Moger wrote:
> Add the sysfs interface to write the event configuration for the
> MBM configurable events. The event configuration can be changed by
> writing to the sysfs file for that specific event.
> 
> Following are the types of events supported.
> ==================================================================
> Bits    Description
> 6       Dirty Victims from the QOS domain to all types of memory
> 5       Reads to slow memory in the non-local NUMA domain
> 4       Reads to slow memory in the local NUMA domain
> 3       Non-temporal writes to non-local NUMA domain
> 2       Non-temporal writes to local NUMA domain
> 1       Reads to memory in the non-local NUMA domain
> 0       Reads to memory in the local NUMA domain
> 
> By default the mbm_total_bytes configuration is set to 0x7f to count
> all the types of events and mbm_local_bytes configuration is set to
> 0x15 to count all the local memory events.
> 
> For example:
> To change the mbm_total_bytes to count all the reads, run the command.
> $echo  0x33 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
> 
> To change the mbm_local_bytes to count all the slow memory reads, run
> the command.
> $echo  0x30 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  109 ++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e1847d49fa15..83c8780726ff 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -323,9 +323,118 @@ int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>  	return ret;
>  }
>  
> +/*
> + * This is called via IPI to read the CQM/MBM counters
> + * in a domain.
> + */
> +void mon_event_config_write(void *info)
> +{
> +	union mon_data_bits *md = info;
> +	u32 evtid = md->u.evtid;
> +	u32 msr_index;
> +
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		return; /* Not expected to come here */

Please no inline comments.

> +	}
> +
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, 0);
> +}
> +
> +ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_hw_resource *hw_res;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	unsigned int mon_config;
> +	cpumask_var_t cpu_mask;
> +	union mon_data_bits md;
> +	struct rdt_domain *d;
> +	u32 resid, domid;
> +	int ret = 0, cpu;
> +
> +	ret = kstrtouint(buf, 0, &mon_config);
> +	if (ret)
> +		return ret;
> +
> +	rdt_last_cmd_clear();
> +
> +	/* mon_config cannot be more than the supported set of events */
> +	if (mon_config > GENMASK(6, 0)) {

Could this "GENMASK()" be given a name and be moved closer to where
the bits are defined in internal.h? This will be easier to read and if any
new bits are added it would hopefully be noticed more easily to get
an update also.

> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	cpus_read_lock();
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		return -ENOENT;
> +		goto e_unlock;
> +	}
> +
> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto e_unlock;
> +	}
> +
> +
> +	md.priv = of->kn->priv;
> +	resid = md.u.rid;
> +	domid = md.u.domid;
> +
> +	hw_res = &rdt_resources_all[resid];
> +	r = &hw_res->r_resctrl;
> +	d = rdt_find_domain(r, domid, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		ret = -ENOENT;
> +		goto e_cpumask;
> +	}
> +
> +	md.u.mon_config = mon_config & 0xFF;

Same question as previous patch. I do not see this internal
value used in the code, is storing it necessary?

> +
> +	/* Pick all the CPUs in the domain instance */
> +	for_each_cpu(cpu, &d->cpu_mask)
> +		cpumask_set_cpu(cpu, cpu_mask);
> +
> +	cpu = get_cpu();
> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on this cpu if it's in cpu_mask */

Please always use caps for CPU.

> +	if (cpumask_test_cpu(cpu, cpu_mask))
> +		mon_event_config_write(&md);
> +
> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on all other cpus in cpu_mask */
> +	smp_call_function_many(cpu_mask, mon_event_config_write, &md, 1);
> +	put_cpu();

I do not think we need to propagate this pattern more in the resctrl code.
How about on_each_cpu_mask()? 

> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared, and the U-bit for every
> +	 * RMID will be set on the next read to any BwEvent for every RMID.
> +	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);

Could you please check if this is sufficient? Note how "mon_event_read()"
is called with "first = true" right after the mon sysfs files are created to
clear the state _and_ initialize the state to set the "prev" MSRs correctly.


> +
> +e_cpumask:
> +	free_cpumask_var(cpu_mask);
> +
> +e_unlock:
> +	rdtgroup_kn_unlock(of->kn);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  static const struct kernfs_ops kf_mondata_config_ops = {
>  	.atomic_write_len       = PAGE_SIZE,
>  	.seq_show               = rdtgroup_mondata_config_show,
> +	.write                  = rdtgroup_mondata_config_write,
>  };
>  
>  static bool is_cpu_list(struct kernfs_open_file *of)
> 
> 

Reinette
