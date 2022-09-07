Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1235B0CED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIGTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIGTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:12:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F6ABB92E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577942; x=1694113942;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXbcDuT/5Kfz6dddXcqP8dyTC51KTLnb30LJmum75e0=;
  b=LuX46EWouX67YfdikYHaUu7gqBiG510qXVRMFtNOtQJUHm6d/7u6XfUT
   WpUpY+RCdOKB7Aq5ZWLqxtFySPy+T+bKfRCpBPsqbJuXLCsrFyWZQmS09
   Hyi9KCgN5dUtujFr102UJWL/9iajWpnU1wnAI67GEyiU/ZusF6B+OFKNR
   BCpfBW1jRH0zxG7w+sEO1e8LLanGYNnFlvk9qVcrBvmL2vvWUWN6ZX4IO
   JbalcDBtE5Gwp/aC9moR0xLQqnBmj8Ob0KPMnd+pBkPN/ZHtoDkVbGWBN
   ql57gKARjGgMgwpHecNsxoImnr785uhEorxl/sji+T64otlZ4bE68Lsx5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298311782"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="298311782"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="740407405"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2022 12:12:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:12:21 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:12:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:12:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkBMGoDYOVCwqzv/ZTv+X44gFjlmaj8haTnPINl/zneb39wF1egpEX6AcHJoPbLRHogz3JhjidaSF+tc4kFC4oxglUsM5mdmlDwZr9OKBEgZnSEJXXkjaNsb+VU6Inbq/QPfmQkLIh9+1z/DdhtWMAGVs1btqjNN+Os13Pssbdk/qv2gffgli/OwANgK3k+zqTQqujhVSTqdzCyDDhcF6H+KPE4Ms3JW8WQu7C1l+CcyaD4b10TD/XMw8OkuyD9qeomXozgkpHZQzf/a7YzbJeERvp+bXXykN2VqtEM5wPS0taZVQtY0GZOSTg+knCcQuJ1hhFomXGJUCfeNWidiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMNxPpZtskmDbmypR1wgo+VSnqsv+XcwS33YSit9SBE=;
 b=CnZuxGxehOlgMkNOHUmTMYc1djJvoVY/SVy7uZVUv3wNUaKW8yZT6Zeh9xDVBQjZWBu0DOp5JBgRFHv9HXIzz5LpBA+zFQJS7ptwegecIySq4miZRP9XvFx9K0nbSWPvwMTKfF8AGKmCnnqKNAeP+O1O9jPUoHlA0a3JdRcqCM/EdyfnMUS/b8/0AC9dmf7FMdrapHhfztPaP/TcrJjesK3BAmIXrGfh4WDWbXdBnmKbwlbjX6uGizu8Jqd2by0CXmmuzRNT0axMggv7gwwmLvqCxuxyKXAZgpMTGDUJdSqlZr5FyMcczx7T4ihmQK7Z4dBTC0KlMdCwsl2rw162hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB1832.namprd11.prod.outlook.com (2603:10b6:903:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 19:12:04 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:12:04 +0000
Message-ID: <09f45a21-91d6-e4d8-4a33-306deef14083@intel.com>
Date:   Wed, 7 Sep 2022 12:12:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 08/16] mei: extend timeouts on slow
 devices.
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
 <20220907155813.1427526-9-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-9-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79fdc7a-4bd5-414b-d6aa-08da9104d94d
X-MS-TrafficTypeDiagnostic: CY4PR11MB1832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S41jRJAZFDPOh8erMmmIex2TTsX3+dvDfa/yOdtc8ul9xPFqno+EeRnDkIMoSAIUisrzAsmhARwu/sDP/ess+GSVovOdTd5zfuFSN8RyXqVF3nb8QroLn5e26pwR7RLZ6RGdqCDF8R0kJWBXl0gA9HvnYWIuiiqSqjcPYwdPu3PUbaVB8jYF9TieHehTifXY8I8Qk2+R48xGn3p4Jk4QPCH9IpCnkjeKQn9RXnvp5TukqN61EGeaVSuazCY3lEKh6rh4RHy83fv9sn29kKiERYoaGI8BdQsXW7KP8qEW7XU+cE3R/MddICvyXaOQdyqucnx48Mnp68aVqQDBUqxA8N7tbkhc9F+tPNnEh6X96xIBXnV22+46I1NZHzqsB2ewDphrdRn0xgq0s9O1km3A5P5JkiOnMqNYM7VUFz+0g9LRtCMnG+ry+qLiRvep1dywhMhKAWP6Yx279ipihmr47qfISMbTb5UJ8pJZ0TJahYql1uW4glTLfEU6yKQIiC5jt8+MLN4fRfihfOLY4Y5OUrO+JAe0R5Ku+I8nR54s3oRQJem0VSPMu2sOvpr5m8/XpJpaYOkt6oIe+XSF7oA5dZrADEzHWXL9Pod1rbBScJtITUrNzjgsOypKvMBcnATUGrkyrRLZNHbwmmj0B/iWhPUIVnlaoF6bJE1T4L7jpnF/w+BL2ofmGRd5dnBl0jCpTTD9ALuHbBZDaUADm6feg7U58PYpndn+p9QoSOOnPZlK+DMmQH2h1hn6LWSgaaeEwo8bJL4hpi18FAhKD/gplbZ9HfLTtswgmiB9MrlgcbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(41300700001)(6506007)(6666004)(186003)(53546011)(6512007)(2616005)(26005)(107886003)(5660300002)(4326008)(83380400001)(30864003)(8936002)(8676002)(54906003)(66476007)(6486002)(66946007)(66556008)(478600001)(110136005)(316002)(38100700002)(31696002)(2906002)(86362001)(82960400001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRwNER6djd5enFHd2pvbFBDYWwrSlhsZWlaNEcrMUJwYlVRMWhBcE01QWxF?=
 =?utf-8?B?cEdOckMwOExqUzdacWMrM1d0RlBNcEsyWEZyc1B6clZGYmswUk51Nk1iMFBy?=
 =?utf-8?B?MXBTMnNDOGovekFtTEJXKzVyQ2VSQWFRbENyK2pvRHY3Wmtrc3JheHJ2T3lQ?=
 =?utf-8?B?LzdWT1NVazVXa1Vsb3J1WUs4TUhyZXVsb2JIN09LaTRnbkY5MTlkRW9ON0lj?=
 =?utf-8?B?K2EvdnJ0OFFaOW5sUk9MVm9xY2pyc01TaXFkZGdkNTFVeGZUcE92Z3NKNVNJ?=
 =?utf-8?B?ZHJibkJJeGdoTE1VUEI4cmVHaTQraUw0eDREbjNEQmF3MW5RVVdWeTY0bkpQ?=
 =?utf-8?B?NzR0N29waU5ScHhVTmFSNC82UVZQQ3dCYWhNNjZtS0djeWc0MitYaEZlenow?=
 =?utf-8?B?YXRPUlU3T1kyY2piSGlxZmNlQkl5QVhRUW9XWFprUWNpcE50RDVSWUtkbitI?=
 =?utf-8?B?ZkI1bFpwenlxalNFMTJDNDNoTm0yRDk3UGd5NzB4bGpPM21ncVhoNkZrWHdu?=
 =?utf-8?B?Vkx3R0Y4LzVGdkY1UHlsa0tLQ3NKZGd4RUVQWVZRaTRUR1h1RnVray84TGNn?=
 =?utf-8?B?dGQzOFdwNHNCbGF5RFEyODZKZ3NnUmloNlVmTUdmYS9DbzJNbzRNK1lRRGk3?=
 =?utf-8?B?dnpmZEZQYmVmakN5dzJ0RnBlbC9JalZJdHU2SnBXZnRqT0dNa2RDbzc0SXlT?=
 =?utf-8?B?VGJpei8yOEVNWklNaHU5REozdVU4WFFEdHUrekU1MkFONlpGajM1ODZKZkRO?=
 =?utf-8?B?RU5uTnlnMVp5VzN0VXhEb3JNMm9XVmphNFJyL1hZOWc0NXg3NlJKQmxjM1Fk?=
 =?utf-8?B?Z0I1OVJ1RUFHeHdOaG9GYnJWb1ZHaytManFSR2lqSTRYS2NWNzJucHRjbWps?=
 =?utf-8?B?c0lRdEpoQTBWY1V3OVBIUWNHQkZCZFB3SGpCNHVaMTl6VTN6ajBsT1l2YXlr?=
 =?utf-8?B?VFZzSVBOSGZsWXBmVjQ2TmUyQUxMZDZKWGY5WVlxUm9nMkpLdjliY3FHMjQ4?=
 =?utf-8?B?UTBtcEQ5YUVhZVpaeC9NZFhpejh5NVNTZVFNMlVWVjArZEFxNFczK01GK2R5?=
 =?utf-8?B?a3ZNSTU4dHhTbEtyZ1hBUEt4T1ZuUFJ4RVYvcjU5anpWV2ZaNW52dkhBYmdr?=
 =?utf-8?B?VytmU3pSUWxrRHFGd0lwQ3ZHdFkvWFRGT3BDN2oxUU5HT1JJdXBOWnlMdTJu?=
 =?utf-8?B?a1kyQ01mNGdnYjdEbmJFTTJGd0YzbjQraG45MXFxUnkyRWl1cEFGa0t2RVJS?=
 =?utf-8?B?dDFkdmRVTjhoVEVKQkV5eGVjWEJZeU9WNUVDeWRRdTgzRXdlY2Z0dkZwRXVV?=
 =?utf-8?B?ZEZ6RXM2YjZsWWtEUGQ2U21xRkR1WU5Gb0hxVE5jZXJSRTJSNFB1Sm5uS1dD?=
 =?utf-8?B?UENrM1RiR1VoMzZPd2xBTk5pSStFVnRNb1hkdjhyY2JTMUNmWjNnQnZkTFpJ?=
 =?utf-8?B?MUdoVE1tSjkydE1IL2VYVlNOTW5iNUZOWVVLZkM1eUhTcWxOazJMaS9oQlFi?=
 =?utf-8?B?bXJtTTlCR0MvZ0wwM2RYa2I2WEc5YmZNcWx1Rk0vNCt1NUZWV3dPUVBoMGFW?=
 =?utf-8?B?R1dQckdnUFY1WWxueWUwVXkzalkzRXhYRm9ybkFYVXMzVk9tcWIzd1FGajJK?=
 =?utf-8?B?RWNPSGIzRnhabml2U052MURvYjY1RmZ2M0swaWFHSk5OdENQamFWcGJ5UGZ4?=
 =?utf-8?B?aTN3KzF6RmN3cTI1VDdIY3cxTGNPM1FTcWxWMmwzYkd0a3dUelNiVm1aYkEv?=
 =?utf-8?B?N2REU0hOWHJQVjNYSUh1aUhaVFh2QU9pSU5RdVhyc2RkQzdqRU90L3hZTDJs?=
 =?utf-8?B?eDZlU2ZTVFpITDR2bEduQVB0eFJ1UlFudnp6YmJRNm4xZDlDb05pS2FBcWZE?=
 =?utf-8?B?Tis2TnJRTFBVZ292RklVZ2JsNDRqbnVwN01NV0NVMVdCS2xRVk1mS00rSXNs?=
 =?utf-8?B?SXFnOFdVSXRlVmo0QVhsT2tlSkF4R0tUMW5Kd3RHblJBRXJXMWl1L1o1MUdv?=
 =?utf-8?B?YUc0eTJDbjc2R09GdjZ1WGlwUExDN0I5ZEFlamJkcDNwemdvYUluTTNpT1I0?=
 =?utf-8?B?TnNkM2lqS2FsWTZKSHd4b0x4SHhYU2VQMEdXUHVqUXNSRU1ITjd4TmlUdDN2?=
 =?utf-8?B?aWR3aEUyZHNRU3g3eXEyNVI0Y0oyMStlK2dqTXFWNWhqQ3FDTDZQWk1LWEx1?=
 =?utf-8?Q?ZR/AyonE1bS+YpnDWmQhwm8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c79fdc7a-4bd5-414b-d6aa-08da9104d94d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:12:04.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osOtM5JLVLvh3sbvxNgrvEwnc6c+cA7qm06+c62ccwj42biorBQugvNZpahaZcQJmqdiqKMYtf+29vqmcRmGf7ppfzve4DGZeTxzkNghSv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1832
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
> Parametrize operational timeouts in order
> to support slow firmware on some graphics devices.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c |  5 ++---
>   drivers/misc/mei/client.c    | 16 ++++++++--------
>   drivers/misc/mei/gsc-me.c    |  2 +-
>   drivers/misc/mei/hbm.c       | 14 +++++++-------
>   drivers/misc/mei/hw-me.c     | 30 ++++++++++++++++--------------
>   drivers/misc/mei/hw-me.h     |  2 +-
>   drivers/misc/mei/hw-txe.c    |  4 ++--
>   drivers/misc/mei/hw.h        |  7 ++++++-
>   drivers/misc/mei/init.c      | 19 ++++++++++++++++++-
>   drivers/misc/mei/main.c      |  4 ++--
>   drivers/misc/mei/mei_dev.h   | 18 +++++++++++++++++-
>   drivers/misc/mei/pci-me.c    |  4 ++--
>   12 files changed, 82 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 59506ba6fc48..344598fcf8e9 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2013-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -164,7 +164,6 @@ static int mei_osver(struct mei_cl_device *cldev)
>   			    sizeof(struct mkhi_fw_ver))
>   #define MKHI_FWVER_LEN(__num) (sizeof(struct mkhi_msg_hdr) + \
>   			       sizeof(struct mkhi_fw_ver_block) * (__num))
> -#define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
>   static int mei_fwver(struct mei_cl_device *cldev)
>   {
>   	char buf[MKHI_FWVER_BUF_LEN];
> @@ -187,7 +186,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
>   
>   	ret = 0;
>   	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), NULL, 0,
> -				   MKHI_RCV_TIMEOUT);
> +				   cldev->bus->timeouts.mkhi_recv);
>   	if (bytes_recv < 0 || (size_t)bytes_recv < MKHI_FWVER_LEN(1)) {
>   		/*
>   		 * Should be at least one version block,
> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> index 31264ab2eb13..0b2fbe1335a7 100644
> --- a/drivers/misc/mei/client.c
> +++ b/drivers/misc/mei/client.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -870,7 +870,7 @@ static int mei_cl_send_disconnect(struct mei_cl *cl, struct mei_cl_cb *cb)
>   	}
>   
>   	list_move_tail(&cb->list, &dev->ctrl_rd_list);
> -	cl->timer_count = MEI_CONNECT_TIMEOUT;
> +	cl->timer_count = dev->timeouts.connect;
>   	mei_schedule_stall_timer(dev);
>   
>   	return 0;
> @@ -945,7 +945,7 @@ static int __mei_cl_disconnect(struct mei_cl *cl)
>   	wait_event_timeout(cl->wait,
>   			   cl->state == MEI_FILE_DISCONNECT_REPLY ||
>   			   cl->state == MEI_FILE_DISCONNECTED,
> -			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +			   dev->timeouts.cl_connect);
>   	mutex_lock(&dev->device_lock);
>   
>   	rets = cl->status;
> @@ -1065,7 +1065,7 @@ static int mei_cl_send_connect(struct mei_cl *cl, struct mei_cl_cb *cb)
>   	}
>   
>   	list_move_tail(&cb->list, &dev->ctrl_rd_list);
> -	cl->timer_count = MEI_CONNECT_TIMEOUT;
> +	cl->timer_count = dev->timeouts.connect;
>   	mei_schedule_stall_timer(dev);
>   	return 0;
>   }
> @@ -1164,7 +1164,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
>   			 cl->state == MEI_FILE_DISCONNECTED ||
>   			 cl->state == MEI_FILE_DISCONNECT_REQUIRED ||
>   			 cl->state == MEI_FILE_DISCONNECT_REPLY),
> -			mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +			dev->timeouts.cl_connect);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (!mei_cl_is_connected(cl)) {
> @@ -1562,7 +1562,7 @@ int mei_cl_notify_request(struct mei_cl *cl,
>   			   cl->notify_en == request ||
>   			   cl->status ||
>   			   !mei_cl_is_connected(cl),
> -			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +			   dev->timeouts.cl_connect);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (cl->notify_en != request && !cl->status)
> @@ -2336,7 +2336,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(cl->wait,
>   			   cl->dma_mapped || cl->status,
> -			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +			   dev->timeouts.cl_connect);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (!cl->dma_mapped && !cl->status)
> @@ -2415,7 +2415,7 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(cl->wait,
>   			   !cl->dma_mapped || cl->status,
> -			   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +			   dev->timeouts.cl_connect);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (cl->dma_mapped && !cl->status)
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index 2caba3a9ac35..bfa6154b93e2 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -48,7 +48,7 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   	device = &aux_dev->dev;
>   
> -	dev = mei_me_dev_init(device, cfg);
> +	dev = mei_me_dev_init(device, cfg, adev->slow_firmware);
>   	if (!dev) {
>   		ret = -ENOMEM;
>   		goto err;
> diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
> index cf2b8261da14..de712cbf5d07 100644
> --- a/drivers/misc/mei/hbm.c
> +++ b/drivers/misc/mei/hbm.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   #include <linux/export.h>
> @@ -232,7 +232,7 @@ int mei_hbm_start_wait(struct mei_device *dev)
>   	mutex_unlock(&dev->device_lock);
>   	ret = wait_event_timeout(dev->wait_hbm_start,
>   			dev->hbm_state != MEI_HBM_STARTING,
> -			mei_secs_to_jiffies(MEI_HBM_TIMEOUT));
> +			dev->timeouts.hbm);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (ret == 0 && (dev->hbm_state <= MEI_HBM_STARTING)) {
> @@ -275,7 +275,7 @@ int mei_hbm_start_req(struct mei_device *dev)
>   	}
>   
>   	dev->hbm_state = MEI_HBM_STARTING;
> -	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->init_clients_timer = dev->timeouts.client_init;
>   	mei_schedule_stall_timer(dev);
>   	return 0;
>   }
> @@ -316,7 +316,7 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
>   	}
>   
>   	dev->hbm_state = MEI_HBM_DR_SETUP;
> -	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->init_clients_timer = dev->timeouts.client_init;
>   	mei_schedule_stall_timer(dev);
>   	return 0;
>   }
> @@ -351,7 +351,7 @@ static int mei_hbm_capabilities_req(struct mei_device *dev)
>   	}
>   
>   	dev->hbm_state = MEI_HBM_CAP_SETUP;
> -	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->init_clients_timer = dev->timeouts.client_init;
>   	mei_schedule_stall_timer(dev);
>   	return 0;
>   }
> @@ -385,7 +385,7 @@ static int mei_hbm_enum_clients_req(struct mei_device *dev)
>   		return ret;
>   	}
>   	dev->hbm_state = MEI_HBM_ENUM_CLIENTS;
> -	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->init_clients_timer = dev->timeouts.client_init;
>   	mei_schedule_stall_timer(dev);
>   	return 0;
>   }
> @@ -751,7 +751,7 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
>   		return ret;
>   	}
>   
> -	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->init_clients_timer = dev->timeouts.client_init;
>   	mei_schedule_stall_timer(dev);
>   
>   	return 0;
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index 23ad53efbcb7..3c41b61ccbe8 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -445,7 +445,7 @@ static int mei_me_hw_ready_wait(struct mei_device *dev)
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_hw_ready,
>   			dev->recvd_hw_ready,
> -			mei_secs_to_jiffies(MEI_HW_READY_TIMEOUT));
> +			dev->timeouts.hw_ready);
>   	mutex_lock(&dev->device_lock);
>   	if (!dev->recvd_hw_ready) {
>   		dev_err(dev->dev, "wait hw ready failed\n");
> @@ -707,7 +707,6 @@ static void mei_me_pg_unset(struct mei_device *dev)
>   static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
> -	unsigned long timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
>   	int ret;
>   
>   	dev->pg_event = MEI_PG_EVENT_WAIT;
> @@ -718,7 +717,8 @@ static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_RECEIVED, timeout);
> +		dev->pg_event == MEI_PG_EVENT_RECEIVED,
> +		dev->timeouts.pgi);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event == MEI_PG_EVENT_RECEIVED) {
> @@ -744,7 +744,6 @@ static int mei_me_pg_legacy_enter_sync(struct mei_device *dev)
>   static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
> -	unsigned long timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
>   	int ret;
>   
>   	if (dev->pg_event == MEI_PG_EVENT_RECEIVED)
> @@ -756,7 +755,8 @@ static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_RECEIVED, timeout);
> +		dev->pg_event == MEI_PG_EVENT_RECEIVED,
> +		dev->timeouts.pgi);
>   	mutex_lock(&dev->device_lock);
>   
>   reply:
> @@ -772,7 +772,8 @@ static int mei_me_pg_legacy_exit_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, timeout);
> +		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
> +		dev->timeouts.pgi);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED)
> @@ -887,8 +888,6 @@ static u32 mei_me_d0i3_unset(struct mei_device *dev)
>   static int mei_me_d0i3_enter_sync(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
> -	unsigned long d0i3_timeout = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
> -	unsigned long pgi_timeout = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
>   	int ret;
>   	u32 reg;
>   
> @@ -910,7 +909,8 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_RECEIVED, pgi_timeout);
> +		dev->pg_event == MEI_PG_EVENT_RECEIVED,
> +		dev->timeouts.d0i3);

This is now changed from MEI_PGI_TIMEOUT to MEI_D0I3_TIMEOUT

>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event != MEI_PG_EVENT_RECEIVED) {
> @@ -930,7 +930,8 @@ static int mei_me_d0i3_enter_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, d0i3_timeout);
> +		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
> +		dev->timeouts.d0i3);
>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event != MEI_PG_EVENT_INTR_RECEIVED) {
> @@ -990,7 +991,6 @@ static int mei_me_d0i3_enter(struct mei_device *dev)
>   static int mei_me_d0i3_exit_sync(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
> -	unsigned long timeout = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
>   	int ret;
>   	u32 reg;
>   
> @@ -1013,7 +1013,8 @@ static int mei_me_d0i3_exit_sync(struct mei_device *dev)
>   
>   	mutex_unlock(&dev->device_lock);
>   	wait_event_timeout(dev->wait_pg,
> -		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED, timeout);
> +		dev->pg_event == MEI_PG_EVENT_INTR_RECEIVED,
> +		dev->timeouts.pgi);

while this is still changed from MEI_D0I3_TIMEOUT to MEI_PGI_TIMEOUT.
Did you switch the wrong one from pgi to d0i3 compared to the previous 
rev? or is this intentional?

Daniele

>   	mutex_lock(&dev->device_lock);
>   
>   	if (dev->pg_event != MEI_PG_EVENT_INTR_RECEIVED) {
> @@ -1706,11 +1707,12 @@ EXPORT_SYMBOL_GPL(mei_me_get_cfg);
>    *
>    * @parent: device associated with physical device (pci/platform)
>    * @cfg: per device generation config
> + * @slow_fw: configure longer timeouts as FW is slow
>    *
>    * Return: The mei_device pointer on success, NULL on failure.
>    */
>   struct mei_device *mei_me_dev_init(struct device *parent,
> -				   const struct mei_cfg *cfg)
> +				   const struct mei_cfg *cfg, bool slow_fw)
>   {
>   	struct mei_device *dev;
>   	struct mei_me_hw *hw;
> @@ -1725,7 +1727,7 @@ struct mei_device *mei_me_dev_init(struct device *parent,
>   	for (i = 0; i < DMA_DSCR_NUM; i++)
>   		dev->dr_dscr[i].size = cfg->dma_size[i];
>   
> -	mei_device_init(dev, parent, &mei_me_hw_ops);
> +	mei_device_init(dev, parent, slow_fw, &mei_me_hw_ops);
>   	hw->cfg = cfg;
>   
>   	dev->fw_f_fw_ver_supported = cfg->fw_ver_supported;
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index 6256b36bdafd..95cf830b7c7b 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -132,7 +132,7 @@ enum mei_cfg_idx {
>   const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx);
>   
>   struct mei_device *mei_me_dev_init(struct device *parent,
> -				   const struct mei_cfg *cfg);
> +				   const struct mei_cfg *cfg, bool slow_fw);
>   
>   int mei_me_pg_enter_sync(struct mei_device *dev);
>   int mei_me_pg_exit_sync(struct mei_device *dev);
> diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
> index 00652c137cc7..9862c6cd3e32 100644
> --- a/drivers/misc/mei/hw-txe.c
> +++ b/drivers/misc/mei/hw-txe.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2013-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -1201,7 +1201,7 @@ struct mei_device *mei_txe_dev_init(struct pci_dev *pdev)
>   	if (!dev)
>   		return NULL;
>   
> -	mei_device_init(dev, &pdev->dev, &mei_txe_hw_ops);
> +	mei_device_init(dev, &pdev->dev, false, &mei_txe_hw_ops);
>   
>   	hw = to_txe_hw(dev);
>   
> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
> index b46077b17114..e7e020dba6b1 100644
> --- a/drivers/misc/mei/hw.h
> +++ b/drivers/misc/mei/hw.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -16,11 +16,16 @@
>   #define MEI_CONNECT_TIMEOUT         3  /* HPS: at least 2 seconds */
>   
>   #define MEI_CL_CONNECT_TIMEOUT     15  /* HPS: Client Connect Timeout */
> +#define MEI_CL_CONNECT_TIMEOUT_SLOW 30 /* HPS: Client Connect Timeout, slow FW */
>   #define MEI_CLIENTS_INIT_TIMEOUT   15  /* HPS: Clients Enumeration Timeout */
>   
>   #define MEI_PGI_TIMEOUT             1  /* PG Isolation time response 1 sec */
>   #define MEI_D0I3_TIMEOUT            5  /* D0i3 set/unset max response time */
>   #define MEI_HBM_TIMEOUT             1  /* 1 second */
> +#define MEI_HBM_TIMEOUT_SLOW        5  /* 5 second, slow FW */
> +
> +#define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
> +#define MKHI_RCV_TIMEOUT_SLOW 10000 /* receive timeout in msec, slow FW */
>   
>   /*
>    * FW page size for DMA allocations
> diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
> index bc054baf496c..5473b1fa6fff 100644
> --- a/drivers/misc/mei/init.c
> +++ b/drivers/misc/mei/init.c
> @@ -359,14 +359,16 @@ bool mei_write_is_idle(struct mei_device *dev)
>   EXPORT_SYMBOL_GPL(mei_write_is_idle);
>   
>   /**
> - * mei_device_init  -- initialize mei_device structure
> + * mei_device_init - initialize mei_device structure
>    *
>    * @dev: the mei device
>    * @device: the device structure
> + * @slow_fw: configure longer timeouts as FW is slow
>    * @hw_ops: hw operations
>    */
>   void mei_device_init(struct mei_device *dev,
>   		     struct device *device,
> +		     bool slow_fw,
>   		     const struct mei_hw_ops *hw_ops)
>   {
>   	/* setup our list array */
> @@ -404,6 +406,21 @@ void mei_device_init(struct mei_device *dev,
>   	dev->pg_event = MEI_PG_EVENT_IDLE;
>   	dev->ops      = hw_ops;
>   	dev->dev      = device;
> +
> +	dev->timeouts.hw_ready = mei_secs_to_jiffies(MEI_HW_READY_TIMEOUT);
> +	dev->timeouts.connect = MEI_CONNECT_TIMEOUT;
> +	dev->timeouts.client_init = MEI_CLIENTS_INIT_TIMEOUT;
> +	dev->timeouts.pgi = mei_secs_to_jiffies(MEI_PGI_TIMEOUT);
> +	dev->timeouts.d0i3 = mei_secs_to_jiffies(MEI_D0I3_TIMEOUT);
> +	if (slow_fw) {
> +		dev->timeouts.cl_connect = mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT_SLOW);
> +		dev->timeouts.hbm = mei_secs_to_jiffies(MEI_HBM_TIMEOUT_SLOW);
> +		dev->timeouts.mkhi_recv = msecs_to_jiffies(MKHI_RCV_TIMEOUT_SLOW);
> +	} else {
> +		dev->timeouts.cl_connect = mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT);
> +		dev->timeouts.hbm = mei_secs_to_jiffies(MEI_HBM_TIMEOUT);
> +		dev->timeouts.mkhi_recv = msecs_to_jiffies(MKHI_RCV_TIMEOUT);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(mei_device_init);
>   
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 786f7c8f7f61..930887e7e38d 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -571,7 +571,7 @@ static int mei_ioctl_connect_vtag(struct file *file,
>   				    cl->state == MEI_FILE_DISCONNECTED ||
>   				    cl->state == MEI_FILE_DISCONNECT_REQUIRED ||
>   				    cl->state == MEI_FILE_DISCONNECT_REPLY),
> -				   mei_secs_to_jiffies(MEI_CL_CONNECT_TIMEOUT));
> +				   dev->timeouts.cl_connect);
>   		mutex_lock(&dev->device_lock);
>   	}
>   
> diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
> index 694f866f87ef..babbb0944b7f 100644
> --- a/drivers/misc/mei/mei_dev.h
> +++ b/drivers/misc/mei/mei_dev.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -415,6 +415,17 @@ struct mei_fw_version {
>   
>   #define MEI_MAX_FW_VER_BLOCKS 3
>   
> +struct mei_dev_timeouts {
> +	unsigned long hw_ready; /* Timeout on ready message, in jiffies */
> +	int connect; /* HPS: at least 2 seconds, in seconds */
> +	unsigned long cl_connect; /* HPS: Client Connect Timeout, in jiffies */
> +	int client_init; /* HPS: Clients Enumeration Timeout, in seconds */
> +	unsigned long pgi; /* PG Isolation time response, in jiffies */
> +	unsigned int d0i3; /* D0i3 set/unset max response time, in jiffies */
> +	unsigned long hbm; /* HBM operation timeout, in jiffies */
> +	unsigned long mkhi_recv; /* receive timeout, in jiffies */
> +};
> +
>   /**
>    * struct mei_device -  MEI private device struct
>    *
> @@ -480,6 +491,8 @@ struct mei_fw_version {
>    * @allow_fixed_address: allow user space to connect a fixed client
>    * @override_fixed_address: force allow fixed address behavior
>    *
> + * @timeouts: actual timeout values
> + *
>    * @reset_work  : work item for the device reset
>    * @bus_rescan_work : work item for the bus rescan
>    *
> @@ -568,6 +581,8 @@ struct mei_device {
>   	bool allow_fixed_address;
>   	bool override_fixed_address;
>   
> +	struct mei_dev_timeouts timeouts;
> +
>   	struct work_struct reset_work;
>   	struct work_struct bus_rescan_work;
>   
> @@ -632,6 +647,7 @@ static inline u32 mei_slots2data(int slots)
>    */
>   void mei_device_init(struct mei_device *dev,
>   		     struct device *device,
> +		     bool slow_fw,
>   		     const struct mei_hw_ops *hw_ops);
>   int mei_reset(struct mei_device *dev);
>   int mei_start(struct mei_device *dev);
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
> index 5435604327a7..704cd0caa172 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -203,7 +203,7 @@ static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	}
>   
>   	/* allocates and initializes the mei dev structure */
> -	dev = mei_me_dev_init(&pdev->dev, cfg);
> +	dev = mei_me_dev_init(&pdev->dev, cfg, false);
>   	if (!dev) {
>   		err = -ENOMEM;
>   		goto end;

