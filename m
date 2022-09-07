Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBF5B0D27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIGTXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGTXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:23:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79335C0BF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578628; x=1694114628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tcphCT8MEq7vOIU4E5Qy+hl9bW+hKVKOEO9xTMfo9Ew=;
  b=l53IjlyZP0lEeqa528wFfUUZuf0vMcEbJYGs/0hEn5QZ1gCj/4H0mcQ2
   +Kx5mvk7L2/cN/pnm57xwUFOrub1+9Yf1VjdubXTvMlbBkbGwc2Lt2GYb
   tqmUhHqypGL0x6tvtfvHeV00NtD0BL+zB6xeXauZMEd4ooQriIZHM98M3
   hTqA2rKlE8X2VvSZ3IPi2f9c6fa039iaj+0+F1x8FJ7qFx7THoSaC8csL
   0+3RKcaVB4vRqryCvIVHrD7B4sjAISkwgNGSlyL8ZlXEU+CCuhzckRLz3
   +ApNfEa63cTeMtb486LfQKNVovav43ZZAYVWFJw39fpAISUOWk77zJ/9i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="296975791"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="296975791"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="591847784"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 12:23:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:23:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye9F5oNs67IYdCn7ijAdPi2JiAEYx0i83J2eF+GNuB1J7fvPwFAOs9PM2MWXysqjO+BuUEB00sxSbMxGDv6fE4r+jzzumcKqd8VYxlS6Ak0AzyKZx3LKXLfLeSDo1DUU1/PpnMb2W/gE646HtdymPBRFUqkefxM/7Up2c5TpEWSbyOKazZtzmk8tWJEaRj5n7zr34+6qh1a6YBQsEMsHRWr/xCTzJW5vmFgoNfCEl/pRHdudWm+CWFwPXwIb7fI5ifev1OR3zphJbFKhOq6Zm+qbv43BruPJLZiwoS5mO1KA+0zc/YXU0xCWjq/Orvoe1+S3Rh75YmxuSoyujTlrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2dUOKWT4fqX3L3lkfn6YtlMiUPe562uCVHy4wNRD88=;
 b=dybtSrd2VrhSsVQBskZsZJsqFaZbZMwXC2Xzp1Yy8BGK2dcGSJrVy5iqX3WS5lnltPzjmbQlCl8Sl301RkutdhuvwKR1nRiZabfkRQCJ3oGcgWN26N5RFE4LdJZ27jVyB2Y7uEv1X0SdxXn6ZBPHbKsBYNqPxLOmbXLTEScEXAMaRjaBnRnuPMONGitj9AKt3FqS5d2E7pSKoZymY3j1cT9H2rJpt49zaOAEw8mpbIaV3QmXcIpdnZNRvPEDWTYYxdtMWD2DaD30A/Utl10TRl05KBkLkPWRryL+11MeM8l4VvsDEGdc19mG7VxDEkpxfN4lt4OKImArs8URoeQXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SN6PR11MB2560.namprd11.prod.outlook.com (2603:10b6:805:55::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 7 Sep 2022 19:23:45 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:23:45 +0000
Message-ID: <67cf39d3-a36c-d495-c788-42734a2b1d14@intel.com>
Date:   Wed, 7 Sep 2022 12:23:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 12/16] mei: gsc: add transition to PXP mode in resume
 flow
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-13-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-13-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8502b3-dec4-43a9-ed12-08da91067b1a
X-MS-TrafficTypeDiagnostic: SN6PR11MB2560:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aP2UiP9fy5Xr9/MhhN6xKxKKE/11GxykU/lQ7xOrHmcH83N0xvdxlRAOcImP/rt7TLvTIFtt+1bU8xg+W/xBVepYMBIjDboxry5zW9pUWq+LeIRJ+2sc4xTwxGYtxhvffHStwbM5FSL9H+rWaqY9p7HhV1+oVg2FNoybwztxti/US+ar8H8xpo413FVjJgwfDipMIFELEfYuTyRMIq9L4nt+bOve/cjnj63iqDi0V1BmM1pisUGEQj8cFQXy/XZrvwlZhF3AAEbR8v5wafvCo2iAHvWGYVHfEsqURrLZSRmW97Ujaarkr1g25FD/RNzZ5cra18eQuQX/bQ5eqZRnatO7mAR7Qeqpjj7ND2aHPC/m8g2pqoEKCNOqmo1Unsy155AaAW5e71OsrCZa1zrTsBKHVTJdbHkMTmrXwcUG8ZQ3IAkds1dwdh7ELSf2+zafg1Lm4cWcEqng2gebUcGdaMxWoOej2s9/hp0tWMWTlSx8lxzTAyn+dgLt07SUq4YTvKomCwG8i0Z6xFd9vfHgY30IHOk7Al2TOmZufenWG2YQxnNxCAp9Vi3Yyxu6JIPhPlSN261aM8AwfAOy3DbBqXPWklzSjXTnBM3Bv2fcl00/KWCpPusiIVbJ7Iy90ejGdwDP379YZUpIl6mRDtw/qWvxDc4SbCccaKZSPUHbe4z3i7qNIrBmq6J9690VgozxqtNlJJIbQbcPY0yu2kxbwegeGnshaWf0+nY/x9ndyZkRHppmo/I+3H1XCGr1X3pF0COXRDq+M2MQ/EFHjeMVv58HgOTAa6YNB7egSEewh8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(136003)(39860400002)(110136005)(54906003)(316002)(83380400001)(31686004)(8676002)(36756003)(66476007)(5660300002)(4326008)(66946007)(2906002)(8936002)(66556008)(6486002)(478600001)(6512007)(41300700001)(31696002)(6666004)(26005)(2616005)(186003)(82960400001)(86362001)(6506007)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFTdGU4dFV5NlRwUjRpVXFJZ1hkb25LVkJWdlRsT1R3QTVOK3FIWGhld2lF?=
 =?utf-8?B?enJnWmNPeU53V2FVM3RJdU81K2RkMCs3d0ptdVJkTlM3ejZuWVdWL2NqQmRJ?=
 =?utf-8?B?K0RoeFhuNTNXMWpKN005SzlpcDBRS1RYK0lnK2xnaWlFNVNHdHdDSFRsMDVO?=
 =?utf-8?B?Q3FCMnozaEFraGRITUpUNjlMQTNhTTRyMzQrN1RYbUxta01NekZ2bzljUm92?=
 =?utf-8?B?ZncyTFIvY1p6TmxHemFwaDZMV3pZd1ZrVmh2QzN5cFpQbUJEZCtqM2h4blcy?=
 =?utf-8?B?SC9lOEdpcGs0YzE0bzRFc09xWVc2UzZGTW1JeGh3WlVwaHFjcUxjL25xdTNP?=
 =?utf-8?B?Mmh3RHcyK0RUUmVRYys1TGxaa0pBbkVyQzdsMUVMeWY5UFNWbi9xVVlZOUI2?=
 =?utf-8?B?V1JjTEJuSEhKV09BdkZaQVdYQTRoZlNhK3Z0U2JLc0RJZVM3SnlKNU5vS1pr?=
 =?utf-8?B?UGplMUYrYTJjRTgyeVRwSlkwTGwxK25WSVlUZ3VteGk1dnZ4WldWaVJiVEFx?=
 =?utf-8?B?Rlk3YVJOK3RsUmNVSExrSTB6YzVia3N1NG9TUkYwSmNRVlAreHRaTEE0Z2Nl?=
 =?utf-8?B?cXJISS81VlFWanQ5WVNKSWZrVEZoUXZhckVmWjdGb3ZETFU4UGJRRHJiY2hq?=
 =?utf-8?B?VlFDbzE3TG45a3NvM25ycXY0WXZ6cjhDSWhMYzFPWHpjWi9EUXBDbmNDRlZF?=
 =?utf-8?B?V1BMSmFtRnVjRGF3NEhmR2NrMUZvbkJkdVE2RjlENit4SnlKcUttbjFkK3o5?=
 =?utf-8?B?TUU0MjVpb25VempmMDFkK3I5TEpmT1d3NGhVZDV5cktxQlZtanBjL09OdHlZ?=
 =?utf-8?B?eEpudU4vWWExNXVFUHpUdTVNTHdxSTZzeXdqTVFYNmh3QXJIblRITXQvVTdS?=
 =?utf-8?B?TEdhYjlHRlV3OGtXcGZMajA1OGdVdlhtbXlqTGNDQitISkZxSG1sU202NzZ0?=
 =?utf-8?B?dktTSy9ldTc2VVZoQkRUUFowSFpBSFdBb3cvRzdlR1FvU2dyeGFoNUZBWHJZ?=
 =?utf-8?B?bHhKSzhJcS9qRTZBRGNBY2JYY3Vsak9VSTd0S2RVWDdzZWVxcjlyM3RBVFox?=
 =?utf-8?B?NjhGeURTcmRGYnBFYjhPNjZSK1lEeWRQeVorUmRFV0xnNncyeW52a1VJeEtG?=
 =?utf-8?B?Qnd3NVUySHZHTlA0WEtSUzJGZW5MVHNHMHorT29xQ2JjakkyL205bHUya3dn?=
 =?utf-8?B?YXEzUnlDMVVqY0NZTGhXNHhONnpYYWt3RnVRWXFyT05FcjZSbW9xZkQwak5v?=
 =?utf-8?B?WXlRUmc1Y0Ixbk1oREF2RmU4SmQrdVlVS0dhRE5iL1IvUHNIV1psbjVaNmxJ?=
 =?utf-8?B?M2pTSGpEVkVFNE1zYU9JWGpqTlNWbG5WcUljWWNxYUlQZzVNZGx4bktFMXFs?=
 =?utf-8?B?RXJxTE5YN2RteXYvdHptbS9nMWtOd1UxWk4vUThrTGtWTHJvZTlENGF2aTVv?=
 =?utf-8?B?TzBFejV1ZkhMRGpMWHIycDNLdWk1b1JoN1hzT2ZYQ1FLWjEyYnNRQjVWbDMy?=
 =?utf-8?B?ajdpdUtjQXJRQXFNNVRiMTRZOXZwR2h6SW9ERFpFcC92MHNqVUMzNkhEZjE3?=
 =?utf-8?B?MVo2ekNURmwwQkRhaFpxak9DSUhiT1lGd3JNYUJuMkxQSTV3WFAzaXh2VVMx?=
 =?utf-8?B?RnppTTE1d3BlTG9BWVkzeWo3UkZGRHF1ekxWWkVsRTNta1dDb0RCOUhMRHZY?=
 =?utf-8?B?MnpvTEFKSE9KbmluYnk1QitaZ0tBRnhKdWtGeXNPS0hUanNJazczeENhdHVl?=
 =?utf-8?B?U1ZPaFE0ekpQbm5mUjN1NWM3WWVNbUMvVndPNVpQZjZaYWkzczBVdE5LRDZM?=
 =?utf-8?B?NnJ6WWNWUjVzaHhkTlhCSUs5VmRxK2dvbjU2YTV1aGxxbFVZWGdHWWMyK3pZ?=
 =?utf-8?B?ZU1YK0h0WElacW1JRmJTeXBoYUxrY29VWExWc1hUcVBhOGZGWmFLVnRFNTJy?=
 =?utf-8?B?VFp6VU5uQ2UyWGpYb0EydmloZnR0MGo0Y2tLTEJmUGZhU3VUdVVLYWJ0OGpk?=
 =?utf-8?B?cmNrU2d0Q0kvbjV2U2ZONjcwWXkzY3EzdnRabkFQSHlsV2lqdkVFVEJldlJK?=
 =?utf-8?B?U3FkTUJUK3V1WDhJYWN5WW0rOFFrNGwzUTFycEh2SDNtd2wwNERhKzVZUDBz?=
 =?utf-8?B?b3J0SFAyWm03SHp0c1NkWWgrZzFtRkYxdE8wSUFIRHhsa3R3UHJESU42bkJ0?=
 =?utf-8?Q?IgEVBKXfa/vXlP9X46rQfDc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8502b3-dec4-43a9-ed12-08da91067b1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:23:44.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A8wcb/m/di4MQnPodTr30ynt50+uKZMbC3zEcACd3nlWA68KXJ42GhDahaYVHrpmeYh2/y3rNysAUFYCmm9t5gSV5P40J3wIaknkn4iORM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 8:58 AM, Tomas Winkler wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Added transition to PXP mode in resume flow.
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

This is unchanged from the previously reviewed rev, so this still applies:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/gsc-me.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index 6b22726aed55..75765e4df4ed 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -182,11 +182,22 @@ static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
>   static int __maybe_unused mei_gsc_pm_resume(struct device *device)
>   {
>   	struct mei_device *dev = dev_get_drvdata(device);
> +	struct auxiliary_device *aux_dev;
> +	struct mei_aux_device *adev;
>   	int err;
> +	struct mei_me_hw *hw;
>   
>   	if (!dev)
>   		return -ENODEV;
>   
> +	hw = to_me_hw(dev);
> +	aux_dev = to_auxiliary_dev(device);
> +	adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +	if (adev->ext_op_mem.start) {
> +		mei_gsc_set_ext_op_mem(hw, &adev->ext_op_mem);
> +		dev->pxp_mode = MEI_DEV_PXP_INIT;
> +	}
> +
>   	err = mei_restart(dev);
>   	if (err)
>   		return err;

