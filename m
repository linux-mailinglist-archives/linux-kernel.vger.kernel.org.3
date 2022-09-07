Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896BB5B0F0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIGVYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:23:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0C696FB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662585837; x=1694121837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j3hBxkvr6FrpFggHqq8xePWpz66OICYn5/jHKWWo+p0=;
  b=LQ21E5VtWLHnquP79AJRznP9bEyWLt4r+ey4gI7ISw+EpN8+s7BNRG8H
   gYHkbrl5qLr+36YtaXVuwrkqFhLLGHGo923wwlFXLFLPKcC7r7LWM51SN
   zS4ta6jNPK9T77f1pYf+kVUAWrSdWHZ73K58vnImDxLUwSgTVQXUJgvMM
   A6AynBz9YiRWPE0clOL7E4+u7fa0aZtOaD/rYFrgUeRHEn1K1LP4RAf6h
   2fg9qCV6llJmyHnPJ/Q9qCy89g3qoJbua1EWTBX72Z6hv9IvmAAtgGpXC
   WejGCLj3OnTGaNocOwU7tATesdPxdCJ48mfIki+S6xvMPj0tGv8HN1KW0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298338133"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="298338133"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 14:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="591882574"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 14:23:56 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 14:23:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 14:23:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 14:23:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 14:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6frsTY6A/+tyrmusHx51UeSgO43BddCF61AwzH4StP9j4x46EKDx9qkX4k/f8D8ol68kHI2RZvnuE+Sx/x3fgd3+WbdKe+VBrd1RsuVKNWxIapWuaxsXKID7oWj0PBA1BwszA4gg8eHF5fNiDMK/2etK2u+p+MFZKfDjXeSl5R27ogIqCeuNTfoVAJ74DMeipM7NeFX6xOzRy02flCyaT7URffaMtv8M5xHjpLyLfivvZ4Mp1DyMpOuq3Qs3nxcGB//Amisw8sfAEmFsmEBFQRTSjYesqM/VquaPkuEvVQDcxaXFj65QAxbDqGpP2s3d1Jdo6uHmbHpWfkQBmTWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of9kiABZUHgCLcnkIQV7nFp+wrDMS91SXirYY3NINno=;
 b=gILH8YYHUSarEtIpeTKJmesi7iV/BXXcIjOsHf+PMTR+cjnnF1dTS2LEJAR5ftgF87LC29dW49E3toltMPr1FZ/uTnP8RZ+3i9L9f7iXn/NKuYp2vX29h3iGT6QH6/FqM9VZfw1khrHGF+REwKBsGApfVOXTuk1eaw1v9epsHj66Q63Kb6Y1tKfHngHqUaDX4dlKKeC9e1txFid319Tk5LThSQgGHOTDgZ6crwxyIYvmi4f9k89eUqKjnEbrbVQObibYkXNEtoA8KLTa0WHxyNWyMRS4xB8FX0hZ52WbIhNkXDShW6ev8m1ww0fQbmdUC9KX4vxv54MNC3Y9P+JlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB1942.namprd11.prod.outlook.com (2603:10b6:903:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 21:23:45 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 21:23:45 +0000
Message-ID: <94589646-d25c-538f-2513-4775c2c8551e@intel.com>
Date:   Wed, 7 Sep 2022 14:23:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 13/16] mei: drop ready bits check after
 start
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-14-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-14-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0049.namprd17.prod.outlook.com
 (2603:10b6:a03:167::26) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17d1051d-845e-490f-9967-08da91173f09
X-MS-TrafficTypeDiagnostic: CY4PR11MB1942:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7EC9HVyQZQnN7nNIZDO35H0Mk8rBPqnBdb1o+cBzcEw2ZaPPDN1ugkQrooZKSq+3YYhQ61X/woOoqDf/7+jjlKw4bIBlOaqcQN3Fe6z2EGFE9lNprM3dX0kWwyYp8E3IrcumvzOZvqG1eTLru16BQ+0muxlc/yGHsBwNOzU2YCfBAmc6+GsdpZJbBli8exgIHX4FtQE4tGM9Fl12xmXLHqSMAdJfVRWxsWqLiPSUkH6ltbk38kZZkYGMEITT5v+IF2EFiGJp8wZ9EDlRwZILLhHeOyj6I1EE8s/1eHlY/yQXlrqylFOMgAMslHLxhrqTweIIrPaeh3JPiEiA9z3gvyBWWNawZCSWSpXwTbEoEUPAt9gYWeeCEUptA2oyobJf9MDxVDQHiAAywc8Wr3ZYeU6NA60Pn+a1KEpZkEWa4/yC4h4SHDd3JlgZLUIrV+qiAQir6Vg6bILywUXMxOf2wsCaUBiAB0kDZABdo+bBLynWAW2KnaY0JHhzQtNBGtFNQnBtUryMMnLL1IdIGRYeZ6XG/F7ysTJZAec7vU70neu/5QAqKeyphECUaoOt3PAYqjEJTKpL0667dhYm9N6LPoStDvomI0gFZlOjntg+9GYTL9p+AkrrH845gTNc5RIyAxRlpzUtZv0FWADxpd2aW1rmAlbuXHdxXwAROrPyFmAd6D3Mgbep1tkhFyUTvlnzzmQkQvU8+UV2sgmQaRaKEycjOz3bSaqupiz9Fzjha+ItafhZJU75PFgrKRjMjtxSLrUrDBqS6JbCMqBbwko0r7cm439ifdhNRz7n3edf+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(366004)(346002)(376002)(6486002)(186003)(2616005)(5660300002)(2906002)(66476007)(4326008)(8676002)(66556008)(8936002)(66946007)(53546011)(36756003)(26005)(6506007)(31686004)(86362001)(6512007)(41300700001)(83380400001)(478600001)(107886003)(31696002)(110136005)(316002)(54906003)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9oN3ZkRlF3UTlVL0FGeU0ranJ2S2MzVFNVSjNTM3R4TEtlb1RIckI3eGVE?=
 =?utf-8?B?bjBMTW1WempMZEtHald0LzY5MjRMM1dJcG5Na1p3UTlIaURFb1ZzTnlleC9o?=
 =?utf-8?B?aDE4Yld0TXJZQjRtWFdDNnNOMWtXbUQ3c3B1Z2JIczJvMVRhMkkvZnUzK0Jw?=
 =?utf-8?B?c1NlcHpKSi9KT3FwQ014Mm8xRUxYQ0ZsSzU2RlZIRWxRY1RYcGRGVWQvdzJo?=
 =?utf-8?B?dzBmQVBVMXg4T1czNTNhbW5CbDltSDFHZDUvQzUvT1NVbVJHTGVXcy9Gd2ly?=
 =?utf-8?B?K1grWW04V3pGZHg4MVFlcGpsOU5qVEdSNFJGOWZHazlpOHhRaTlXNGxpS2lw?=
 =?utf-8?B?N1luTTdrYzBFUEExR0laVGIwaEkveVovQXBpM3QrS24vZm1lcW5vVk9zczRh?=
 =?utf-8?B?MHdtcDJvd2ozRU9KRWdCRFBLcnl6ZkZVMHVkOHl6ejE4VTlhSjJoWktaR2J0?=
 =?utf-8?B?ZUppOHJLdW9OSm1CWjBJRURLZGZINlhQNDBja1lvMGI2TUZpUFdEcHlrWjhB?=
 =?utf-8?B?TTR0cmh0UnZTLzExRW1xR21sdys3bFlJOGdDNEdEdVFURVRjV3dKNmhKdjNu?=
 =?utf-8?B?ZTZrOExNR3dmSmZTbDBwVFpEZTZpZnpSZElLTVZvREtnVVR3bC9VMVF6MTRp?=
 =?utf-8?B?c3ZNaFI5OEkzRU9TWDB2ekpHVHJBRy9UV0I5MjdYd0I0NHJuTTJhZGkzVzdQ?=
 =?utf-8?B?Und5TFpSTkJjcW9aM1J1MmNHT2VjTzZsTmwrTVR0Wmpsdkk4RnozanVWRWNJ?=
 =?utf-8?B?R0RPMkRLbnptK21nOWhnR3Rwd1N2aGE5WkpON2w3Y1RZTXorY1RtbkNud2R2?=
 =?utf-8?B?VkUvQVhwa0F4Um56WWxIWnBvbEMvT05ocHhyMzNQNS90RDZ5K2xhUnlvRzlX?=
 =?utf-8?B?Q0sveXJEQUxhOVVsN2s2MU5sV1diOG1aeklMc2JxZ1VGWUdrL2ZwMzVPeG4v?=
 =?utf-8?B?NWkxTGxwMFFWbGpWT3pvS1MwSU04VmM5S2ZSWWhZdmpVVmhDNStNNjZXK3cy?=
 =?utf-8?B?ckEyUldqcmFDbjVxMVc4MXVpRE0vVm5SbTFTRHVzdVZUMHM3WWFhVnlVSnN5?=
 =?utf-8?B?b2FCQTNqSk84blErd3l5aHh6amVDNmRwTUVjcmxyUzJwem8vUU5tc1lYa2pj?=
 =?utf-8?B?UXZaY3NwMVNMbkcvVlVqTTRUVkZRL1lOaU5aYUxyVU9ueHQ1YkxvaVlSQ3hS?=
 =?utf-8?B?S01VMVhqWFF2cUEzNmFDTVl3UWJOQkwvbWVtdURjbTEwQWNOZHV0eU8vN203?=
 =?utf-8?B?VHREUzRNNll6dWwxcC9BK3AvbmpRRzNRc0huWkNWRnFkbnV1cm9xQm9HRGx5?=
 =?utf-8?B?aUM2UU1MY2dJK1RrQ2J5WmNZd1RlK1JSbFpYdVpIZW1sNnBKaXZtekJiVmFH?=
 =?utf-8?B?MGZoTzBNN3dKd2UyK3RVNnlESnVYRHFVc2xpQm92UmlOaHB5blkwNVJTNXBy?=
 =?utf-8?B?RENVYlBkczJWc052Wno0cHB5L2M4WDRXQlhTbUd1YXB1Vy9PY0pGNUNiRmUy?=
 =?utf-8?B?V2VTck1EcVBSM2QrV2ttclowWG1jNVY0bC9POUE0SVM4TjNDTUtTVUJWMkx6?=
 =?utf-8?B?akRpMS9BVWJ0NXFkdkhhdVdaeFhnb21ZcEp1eGhrM1Yxd21tVjVlcVRWSHMz?=
 =?utf-8?B?WXRBRDA2VG1VdGhzQ2VhOFJrVVVLOHJ5Q2drOG1oRVAydytGTERMcmlNWTE0?=
 =?utf-8?B?S05UV081VSt4T3RjdzI1Q296R0lCODZyVDJ2djhIQjU0YnBaUHNYa3UzdU10?=
 =?utf-8?B?V2xIU0c5em8wRjRsLzZuQm82K2tnVkFXbU85NGdhT09jcmJKT3FRV0E5MGNh?=
 =?utf-8?B?ai9zbXl2RjRxdUxmMFloMjVEVGJhb2pwdGR3TjBEd1hzaFp0amgrczAwa1Ix?=
 =?utf-8?B?SzFKTS8vK0F2R3F1U3lPNUNPL0VXRGZSb0g0ZEVDYjNGcXFUaklMYmVKNlJX?=
 =?utf-8?B?cW5INjBxOHpvbC9LdndtT29UcVo5cW1RMzM1dUZnZDcxSjdHVU5zSjRHM0Vv?=
 =?utf-8?B?YjEzcStrak81ZEZ1SkJPV3J6VW15MzVlWktKeUJwSVZpbk9HMEROM0RzWXdX?=
 =?utf-8?B?YjhMU09Mbm93WEprRHIyVkRLL1gxSERlTExFSlhWeDhpTzhaNkVVbVZSQTAy?=
 =?utf-8?B?YnVKa3lhdUpsY2JMdWRuQllyaTkwbjNUNGJwTDZ0U1d4S2wrNy96RnZkeDJV?=
 =?utf-8?Q?6lQMi73LvxhFYiSlNdd8Gxs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d1051d-845e-490f-9967-08da91173f09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 21:23:45.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f6d1bqPiQSa5D/zaltqRzxsD1KQQkRi7/ssquQfDiyOGEJVrnsKqIXaumkrq8yfy+d6GRSx5l4VROR/boZtqEsYr+uMcld0BUhxhkimd34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 8:58 AM, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
>
> The check that hardware and host ready bits are set after start
> is redundant and may fail and disable driver if there is
> back-to-back link reset issued right after start.
> This happens during pxp mode transitions when firmware
> undergo reset. Remove these checks to eliminate such failures.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/init.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
> index 1b4d5d7870b9..bac8852aad51 100644
> --- a/drivers/misc/mei/init.c
> +++ b/drivers/misc/mei/init.c
> @@ -218,16 +218,6 @@ int mei_start(struct mei_device *dev)
>   		goto err;
>   	}
>   
> -	if (!mei_host_is_ready(dev)) {
> -		dev_err(dev->dev, "host is not ready.\n");
> -		goto err;
> -	}
> -
> -	if (!mei_hw_is_ready(dev)) {
> -		dev_err(dev->dev, "ME is not ready.\n");
> -		goto err;
> -	}
> -
>   	if (!mei_hbm_version_is_supported(dev)) {
>   		dev_dbg(dev->dev, "MEI start failed.\n");
>   		goto err;

