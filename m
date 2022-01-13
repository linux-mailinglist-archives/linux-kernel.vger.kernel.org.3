Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761F48CF94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiAMAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:14:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:1278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbiAMAOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642032893; x=1673568893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y/0xIRJO01WCYcv/IxxYLw14Xe4i+98WUNn/NpPdXXo=;
  b=i6Er+u2h58JkazgN+HDym3PI6a726pZwZ04NtYhCS5cjvpj8RfyqpErK
   QFEbSZrFWRvxXCyuUpE4CaOklaA+WQmvJfHxblvOT9ZoJ0h+B3P9qerOP
   NOAPzls+M72HYbKshs82cmggl7Ng34QKwsCCdkQoYBDb10M/wMfusu9rm
   BmqT2790SLkSJNIa0CwM7jjN1J8ugNBnt8KEeOqYf85k5xb7wfh2scTLF
   EaxJNti4ZiMwMpbCc6p3fxpfJ1xHwQTgHH2qS4sIW0ts7JkM1X75XwQP+
   9oUZ1a5KWfFTM2I+eCgmkkK2g5V/eZLGFpWoSf6KjyNx7vH2guXdQVsJV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="330231960"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="330231960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 16:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490933939"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2022 16:14:35 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 16:14:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 16:14:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 16:14:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHHWEmxZ+WTqw8qUJIoh9sbGptMEJYw+Ye/mzvNROkZKlmh/TA9WrllCagBi3Odobfl8L3EvXUeCQQ7C78jxomZ6hC4Uo2UOrkobufVQtIHnb4F2cwNHX14EKojBURb1EybphCjuASHZjKK9chzzwY86nDmLY6mInkr9HuwZYfHXPZm9QTXzNceF7+3FEy6Oa84yP0qiqGHYfXXIGY3xAnVtHtVZeD2+Z/jrsKxJuJvs/9sLnZdvYijDJ2bUCuqyCClqsGlQv4E3SwOkVCAwC/bOa7mcluEgIynE8xHptfUJq8DpQESswNS8EmaCNKsVe5Nxbxw6De/loCMjWeSKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmkpOvizy0p2JGtwIARgRsPotcSL9LuSrqEgBv8uqD8=;
 b=Z0+pCLAjAfgK35DG+BEg7cqxf4ZGx/5xUaC2pwyTKq6cDNf+2uVw3zLX41U3z7gmN7H5y4Z1aJbArlm4ImnOsyrtx8YESVXk6GeicLitCiqWh7Mhu0BK4tqgA4hUpFwYpI52S8JSEowBODCJhbiYE8Ei8c+UrFZo7WJhK45nbaf5E0n2BLKs7JYvobGi2DgJdpLG9ni86aa7WrdYay18+/M5wl2088dNzXhdic7qLGz4EGkgccoDhspYoJGRnhEisbM+eEQKxqcF7MvT0yqupWXe5Z8KlrYVsXJmzcP0joupscKPlL1NgKZASNjV9NdKA02Q8K4CWAcGGLfE0Be+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 DM5PR11MB1913.namprd11.prod.outlook.com (2603:10b6:3:10b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Thu, 13 Jan 2022 00:14:21 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b47a:6157:f9b5:b01d%3]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 00:14:21 +0000
Message-ID: <2f0fd4a9-4d24-a6b7-12ae-51763f304761@intel.com>
Date:   Thu, 13 Jan 2022 01:14:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [v8, PATCH 1/3] drm/dsi: transfer DSI HS packets ending at the
 same time
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
 <20220112153639.12343-2-rex-bc.chen@mediatek.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220112153639.12343-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d28fd337-ee7f-46a3-9b89-08d9d629a574
X-MS-TrafficTypeDiagnostic: DM5PR11MB1913:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1913F0D9696C90A3ADF8B955EB539@DM5PR11MB1913.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXxT+BaGnmSCjIFFgfseB7pQam/pTli0RZsRmNbLcDa+ueWTPnuHF8jA1PZrOxT1olO/TwrdwTkNPxElJi95APjgZL+ZiNDlCPmDncfsI55kFwRB1QB+AmEYJLCV4gbHiS9zYOxDr0qRjqiieoi5j39v4+eQ+mIO/eJYyjRNg/9lZUglO+kCpwJyXXuFaB/c80E4u95AR1h3JAsVRZJlKtb9Ez5KSuUl7E8XU770Ouuz1v43sHbGLziztEJCmCjO4eIWIZLOckQBSwk010U+PcDf7miMQOj3bL9Y1tQ9gJIGKUEACrFIssCOFse3xRPQQwF2QTZaTLOHky3/RncWHDPLVudw+qf49wZOpTcp834Ov82/NCslg5WAjOW2sh4jpbdyxuADdRyGmewaaelWGFpXvT1HiYiFhuAShu1IdBmN9Q7aaq6gYdM3voM44oX3Y4UQouonzy6wiUe4LdxtHQ7aZHlUg/oC/DbJOIShlRWwXnrlQvAyEYcOA77ULHicHUgN3ERIgU3KPM9PPbUosoPNOfApI61gWNZyNpxYUIEO7tMCEVUuvjzIUubSmsfo3FjOmxR4kj/nk8HMrK3uQoYg8wsQzRLlAQKCPpBsl2+M1QsbzVmaOIAAsHBTuKtVtmHm4ssNu8X02dxodAS4ZqH9TxhDtt8zNncEHVDxG+OBg9079dInHC/Fm0GnR1LCBC8wui1ZgWZub/MGFLK3SJX0TyFL/jIYJxHNewpQY+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(4326008)(86362001)(44832011)(83380400001)(8676002)(31696002)(2616005)(7416002)(6512007)(6486002)(5660300002)(66946007)(66556008)(66476007)(2906002)(316002)(38100700002)(8936002)(36916002)(6666004)(6506007)(53546011)(36756003)(31686004)(508600001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JBb0tuZXZTTVJHVHQzNzkzV3VYK045akpWRHZudE9vRnFYTDRGd0xIWDBD?=
 =?utf-8?B?TW5wTkxnd1BYZk4rRFM3dXVsZ3JIaDl0QjU3MXRaUjdjejRQbWVzbENtSmJZ?=
 =?utf-8?B?TkhzNHE3Z0xLVm45djIzMzdIUy9sby9ESnhUVWZITUVNK2lwKzNOQkNyMlV1?=
 =?utf-8?B?REY1TnpMdExOUTZxWHJsQkhWZE5MT2Q1ZmgrTzNXV0txSFRIelY3eDFZckpv?=
 =?utf-8?B?V2grU2tvVjBzWGhhbE95K2NHM2tkZnZFN050KzROWjg2TGJhWWprcjR2RHlr?=
 =?utf-8?B?VTdwOG5aeGkxWitnK2d0RmJiVFZPSWZyRVFrcXdpd20yNzdKWkJpWWVOeVQ2?=
 =?utf-8?B?NlhtSXhPSndBcDh0ZklWeTFUU2pUcVZla21JbDdJdWk0Q243UTBTS25NcG83?=
 =?utf-8?B?QS9ZREplUWxiT2w2UHA3Y3JiMkowMERXUmN5UFZCREpRZXFvTjdqMFdzd2dj?=
 =?utf-8?B?U3hHSjdNejhlUVZ2MWt0T3VmeXhDWTR6c2Y3TnpUWEJ5ZkFsNlNzbGZTL2FS?=
 =?utf-8?B?cFhmcDdFcFVoZ05RclF5S2d1WktpY1FWNzE1MlJBY3NGeldPVmpPV0FjRi9Q?=
 =?utf-8?B?WnBWT3NsR3RtaFFrUit5T1JnWFg3L1Vsc2hURDNXRUVyZm9LZVhyNk8wT1ZY?=
 =?utf-8?B?ZHBKanBDR2hFWFYrYkRvYlk2VFUwRldaOUkweUdkb2FsdXNUcEZSYkVlVEtE?=
 =?utf-8?B?OHFCS3daRTB2eG1rM2ZjUHRXeTZveTJxbjBDVGxyeC9nSEphWnZ5Z1VsVVFt?=
 =?utf-8?B?ZTJSUS9VVVB4bnFiYlpaUzNRMjFhd0twNzBFMWt4RkpLRm5LMDBDeGxnY1Iw?=
 =?utf-8?B?UTBlQ2ZhQW5xMkdES3ErazlSTkJWbWpoaGxOM3VaV3JWcmloQmpJZ2xmV0pR?=
 =?utf-8?B?dlhCNjJYbnBOYnoxTi9nc2kyQTlNTElTWGJQTW1EdHl2Zno0dHl1VEdhTnJr?=
 =?utf-8?B?RHpLSzMvY1ZLMGpaeGZRa3FlOGs2TjFoZHVzQVlPQ1pUVVFJVEsvOHlndEJp?=
 =?utf-8?B?bzlrSURuUFc4RUxQc2RHYnpTZGpoUTR2dktUdCtHU2xtc25vUm5NR3ZsSSs1?=
 =?utf-8?B?MnB6U3N1VEUyVjEvVHlHTU5mSVBRbWJYWTlsOXVpbExURmI3R2FDR2xZUVVG?=
 =?utf-8?B?VXV2bmJ4MUpTV2JvZHZHVW9jeFQxeW9FdFora3QzcVR2Mnl2NCt6WU9jMHNZ?=
 =?utf-8?B?cjQwNmFSclM3R0ZOcUhXVXJhVS9HK0txYThIQUQ1MXMzR0poY1JRNmo5cUdS?=
 =?utf-8?B?RDhhVXVPbjNYVlkvWFhseTgvcEVvYUx1SVh3ZFZIY0lQejhsemVNYk1VdlhI?=
 =?utf-8?B?SllwbC9CODkxaTkvQVlBS1NBbDdhSGxuTGZzR0Yxd0VrN0tvN011WDhGWG93?=
 =?utf-8?B?Y3hTeXNhaTlnWUtSZk9hTEFzRE1od2pNNjN6ZTNFakptcWR5SGRVdFpKZkJi?=
 =?utf-8?B?cm81UGlUMFNBWEh0VjdKOXJ4TlZGSjVXZmVSSTRON0ZGN0g2c01MUjlXQlkw?=
 =?utf-8?B?TVdUZUs0ZXBqRXdaeDF4bW1wbGVDMkJ5REcvQVhYZG9xeWJvNVdmWGUwdy9G?=
 =?utf-8?B?NXMwTmxBK0JheHlrMkYxVnl4VCtMZUpjRVZRS0ppeENDWENlRXdPam1naFhJ?=
 =?utf-8?B?WDlkdUlUOHJjSmdkdEk1aUlJSkM4SVpob3hnOW80Y3lSZjM2QmcxbG5mTzlY?=
 =?utf-8?B?cHgzZ0txS0ttWGJ5UGdsY1Bra3lUa3k2bHB3SW5RMWxUeUM2LzMvbUU0RzJF?=
 =?utf-8?B?cjJLcE02a3M5YkhTdkc0d013bUNTU1JXRlpBMnk0N0hWVkxnNHlmckJMSzBS?=
 =?utf-8?B?UVhHWG9ScnU3dTBxQ3pZWmZ6bmhiTEtEWlRPQm0reVNQbXVITHk2YnlNNUZR?=
 =?utf-8?B?dXYrZlNtbGxyVVpLUWlXZGJja3lLTkxSSGtIdnFPWCsyVnBaaGhndEhLL0lK?=
 =?utf-8?B?N2xKMXJkRVl1YUh3d3FYMjZONExmcXdmeUVaYnphTW5XZXovUENUbFZTYlhk?=
 =?utf-8?B?TkM4aGsxRUxxT2krdkFOdVROSjJIR3U5T1FlK2JFUkM4aXNrNnBGTzFqOUUy?=
 =?utf-8?B?Y083Zm9rbzFOMmtrTVY3TG9QdkJlemV1Vm43Ly9BTldDSFBiOUgxQk1BWndT?=
 =?utf-8?B?d0JpeXRIRFlGVVdXZzJJQTVOL0VsaUdReGxremlDZjFSWStZVHE1dGJlS1FV?=
 =?utf-8?Q?j/7MMH1tUIaRmBAQEvKh4z8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28fd337-ee7f-46a3-9b89-08d9d629a574
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 00:14:21.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJTgJ+qJyaI8PaXaPuVSgP/tWNKulWKacQAZ7T9IU0tbYp9hiCikRci3n7ZT4XWi22Vc/1E4ehNfVFOQAEqLEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1913
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.01.2022 16:36, Rex-BC Chen wrote:
> Since a HS transmission is composed of an arbitrary number
> of bytes that may not be an integer multiple of lanes, some
> lanes may run out of data before others.
> (Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)
>
> However, for some DSI RX devices (for example, anx7625),
> there is a limitation that packet number should be the same
> on all DSI lanes. In other words, they need to end a HS at
> the same time.


Is it documented in anx7625 manual? Is it confirmed with hw team?

If not, how it was detected? Have you tried to find workaround for it by 
inspecting registers, maybe it is just matter of clock gating deferral, 
timings or sth similar ???.

>
> Because this limitation is for some specific DSI RX devices,
> it is more reasonable to put the enable control in these
> DSI RX drivers. If DSI TX driver knows the information,
> they can adjust the setting for this situation.
>
> Therefore, add a flag to control this situation beacuse the
> mipi DSI specification is not forbidden this situation.


I am not sure what you mean here.

I have an impression (according t 6.1.3 of spec) that devices should 
allow transmission of arbitrary number of bytes, so this is bug in hw/fw.

The question if it can be fixed. If not patches are welcome.


>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   include/drm/drm_mipi_dsi.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 147e51b6d241..df4d15345326 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -177,6 +177,8 @@ struct mipi_dsi_device_info {
>    * @lp_rate: maximum lane frequency for low power mode in hertz, this should
>    * be set to the real limits of the hardware, zero is only accepted for
>    * legacy drivers
> + * @hs_packet_end_aligned: transfer DSI HS packets ending at the same time
> + * for all DSI lanes
>    */
>   struct mipi_dsi_device {
>   	struct mipi_dsi_host *host;
> @@ -189,6 +191,7 @@ struct mipi_dsi_device {
>   	unsigned long mode_flags;
>   	unsigned long hs_rate;
>   	unsigned long lp_rate;
> +	bool hs_packet_end_aligned;


Maybe it would be better to add another mode_flag.


Regards

Andrzej



>   };
>   
>   #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
