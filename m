Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E4A489EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiAJRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:48:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:61705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238581AbiAJRss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641836928; x=1673372928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tt1QAClbirIUj9p7eBiLHTFczsTau6XCUPD4TTZsw0U=;
  b=T3alVI45rurzJ5xbFAJf6tLFvsVMpIz8Gt9A+CLdT1OPWnN2yNzACepi
   f+Td8hq2YVZmI4saMUboP9bxgxwWq8dM5AQqTfdsaC9/I9HMcyBHitxYa
   16XlxT/krbNpw3rbHcBDySu21skpwcNlIfSallWE3Do8rt+JgDFZUN4Xf
   i0UBhE8Ey9OZvGLdSwviH/HmBuds/qslksr7iALoyafFoR7uAo/wXgjpY
   BgGnXT33SZSUzsJfYYqZOJLnDCrJKvz0SNsPpjBtVA5gHPu7hIJ6+1v6Q
   DTq7KaBS1/ZSYEfxbYyFlcpu0T/RbNcXlax3uK6HBlvX1Daxwm54cS762
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="267611643"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="267611643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="612924407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2022 09:48:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 09:48:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 10 Jan 2022 09:48:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 10 Jan 2022 09:48:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuH8t/Nr+1TvFddbN/AYvPz4M4LTySyKuM4PXqA3heKXKIfZDCjJ6uYEWhYJeZ2y4BLp7v3jYS2xCf+X1tQr8+fZEA8M0N/jNQhn+MhD2oxhATJWZJkqqbdGoYyWtsv174lC0HqVQa0Ca/1WL9MF77UQj/W7dY7Nf8mo/TCy6fb+Gy4mC7yFSRfMgpqLCTvF7YDkBZfWpYVAXggEQaktjtpSg5JLEbypHkjUS0jRoZbsfCwz1F68VRyfzE4g9DXW7fcgv6jM7iNAbhFJlN/7G3DRdMDRTjss8bNDjpKYGWwUMqGGkXA/DaLuibkGvV6P2lTevcDxLu71WQxRtF7Phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zujHk6T8wWL3fjk7ncY8BpRJVWLPWUaPCC3scYHKj8=;
 b=jCnEJZ/JEdQcK0QGgitMhK0vHWMYFCQRrNXGceDcHpqyRf1h5gbXpvP3V0PWbcJkUd9mvLTiJ3W7TDaKVpoqCb/GCa8S0y11nirnjiIvsoBbH51EyUiWh1nkLgZtcnnh4Sv0QhEGSxodt/kIUpCo6Y1M+uNgCij6Z6q8mfIdF4O3IjT5dKKZRZ3kPBwzw/PkWwHSFPxmcJT9zqTZBuoy/vU1JxdwKFsJlfoQiOvaIO/C5FDI6Ux7OSX954CrsOy11XbLthShF9PuCom3tcVNpz7TD4DM/d8uYIS8tuNmWq+QO+Z2uc4IlffQ9GnpoGt9Xr9oKqyfi5MIcW/IHxqa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN7PR11MB2659.namprd11.prod.outlook.com (2603:10b6:406:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 17:48:45 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 17:48:45 +0000
Message-ID: <f69a0650-174f-1b0d-ba29-7fe04c7cf211@intel.com>
Date:   Mon, 10 Jan 2022 18:48:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
CC:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
 <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0164.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::7) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3220ded-8731-4040-e36c-08d9d46172f0
X-MS-TrafficTypeDiagnostic: BN7PR11MB2659:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB265991EB517E1822A65A9E8FE3509@BN7PR11MB2659.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFAteL1kyZrDXwjKvZ2TFIjshGOZUDUfqWESH0DzcGs50UFSXoJ2gYMZH85hJWrdTtMAT0GddTNfunGv3YTej7KspZmG5e8IZaEaqd/MIFomdo+WpNw3iSA3tsXnA9T/dU8h1GFsHLvCZGHTdHTPpGjJtr47sLwTyQU3QqANtLatgamWDyJ7EXG8hw3Jn08nPWrAYKTNW22jJujqWtkTBcqqS7tz+4G7wCbvfCYrSB/IR1TZWE+AHwGt9K6sFEMAzIPNWJvz5LmicMndYAC/8+bgI599uIHrqCDDQit25V/BuJmSi/DM9eQJHGjMoEmTCX4XBFXbI53xXN7Y+g8V2BrzIhGD8xDl9RP3ah/sIJgbLYfSyoDNFpQW6d+9C3ap3+K5jKTOaDMhNf+jrUX6zCXhlciHNs8qRGtYSErLg+Q910TloQga5Z8mfuVmbWkpZH/wvr4RFl0h1jbQWlcHgsLUN8Kp0Pdm0SqSA0Zhn+Y3VB7mHfksLcV3PIegewIcK932qBqlv1sLQndcuBB2ida+ou5F0btBNubd+HR9QhMaR/CPB8LGyTsy5SL71Z19ahCbKV4FqohIXHWinYwHJqRhi6aPNxjd8VvLxpE8LSgOuF5gfyZjd58Ib/aar1bWzgYlOwjKGePskNw9lxI2q5V7uWJ4hlK8+s6E43fCScVqZogno5nyyNk6f2Cd9uIYgwfudZoBISsWa1gfkb84niNLpLaoiXgOVRayLKKFUFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66556008)(54906003)(110136005)(316002)(7416002)(82960400001)(186003)(2616005)(2906002)(31696002)(6666004)(83380400001)(6512007)(8936002)(66946007)(44832011)(26005)(6486002)(66476007)(8676002)(31686004)(36756003)(53546011)(6506007)(38100700002)(4326008)(5660300002)(86362001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2dxNlNVcGxqcVp6dWVCUFpaaHAyYzN2VEcrS2FMUXZZSGVvVkJna3JIMVE1?=
 =?utf-8?B?TnpzNVBFQXRwMEJvaVFiWEhJZ3dPSHFudkxQdXB4RFRjQ1pHOUJFd245TkJU?=
 =?utf-8?B?RVF0WVl6N3BDODludTB4TkE3TVh3WE1wL0NoMCtFeis3WmcvVUVYOXFPV3Zl?=
 =?utf-8?B?OG82MzZ4RkV4VGpLR2V5dTlnU2N2R3YrK3c5eStUNXdVdk5hb3AvR2JYOWZV?=
 =?utf-8?B?UHBvcGRKVnFpWVFhYlhiNS85Qm5sWTZnZkg0bjkzM0l1endvazlQNGV5dERT?=
 =?utf-8?B?UmZ3RjNnNUNxdkRnNnRHb2FTT2VnaURmRUdsVEJHSm9yRmdlY1dwVEUrQm00?=
 =?utf-8?B?N2dlUGo4WUJ0MGZXV2pvZm5UNDJ1TEZ1MVJHQUtXK2czdktrbzZpV1NYK3Nm?=
 =?utf-8?B?OTNFeXl3Q0NnMzAvOGE0MVN0UWg4YlNkOTZKOUpFRHl2dDd2M3JmdkZMY2dI?=
 =?utf-8?B?WWFzNERycHhLcTBxa01kQzhoVU1nTGp0TXlBbU9UenRtQzFRUGp3c2pRdERj?=
 =?utf-8?B?Nk02b0w5dkFsOW85MEVCVnE3TGtnQ25QNFZNaUtEYmFKYzdYcFhiY252VG44?=
 =?utf-8?B?ODFxWTN5bW1UT2FIMW41aEMyM0ZVelI2QTVyRnRPTWJRR1Rha1pzZmtqWGlx?=
 =?utf-8?B?SUU4dGtWTFRVRThNYTNoV1lISWFCTzQ3Y2lRQUdPYndEM0dJUGZmUzM2MTV4?=
 =?utf-8?B?SVpRejBtKzFBT2Y0Lzd3L25ranRPeEwvbkVVMVNicHVwM1V0QUFTbFI1U2M4?=
 =?utf-8?B?YXhYTWllMjVId055TUhaN29jeFlya0tvU0pOTDhPYnNRc3JacHJNYjhKeFZn?=
 =?utf-8?B?K2wzcVRqdVBhOWNWZUpGUUJiTEZpRGxvTU05T1JOVENoZTJJN0RmUFdGZnNM?=
 =?utf-8?B?YWlhWmtESHFRUUgxQWo0WnBvVHhrQ0RpVEQvV3lkZFVVTWxSOEhHdURibzVy?=
 =?utf-8?B?bEVSSFFzUmxoSUVmOHp6d01GQjVpQVNJbVpJSlVrbkdxQzNxK1lkZFRUQ0Vz?=
 =?utf-8?B?YmxtZGpiY0wwamQyMlpoS3FFTk9ISTVGWVJEdWV2czllSHNwNjZIVkxpN21M?=
 =?utf-8?B?RVZFY0FaQ2lpN3NRT0g2bVZOQWhRd0dJRlB0NDdBNHZkQTltdG81RTVONUxt?=
 =?utf-8?B?cTFFR2FjU3h6dGcvNHRyTFN0RFczc2tIRXJOS1dSRFBuV0wvYUhOS1ZEMnlT?=
 =?utf-8?B?YlowZUdMK3ZxR2dxSEg0aHhUcjYwTm9OalMweFNQLys4OHEzL0VSZW8xdUFR?=
 =?utf-8?B?N3BjbXV1eHNDQ0Ywem56aTVsTHMyVUFlczFlbjJMQUQ0MU52VldZVU5oVnJG?=
 =?utf-8?B?YTlNVDFPRWV0cWNxVFdvVE4zSmhsbHJxY0FsdDQwdmI2VWE5aWpzUlhDRXFE?=
 =?utf-8?B?UXB0aS9TRjVLaG9WRFVvKzlIaGN0WnNySDJNQ05DVWdlcGdDb1VBdExjeHFE?=
 =?utf-8?B?Z3VFUUtYMTQ0Z0J1T25aZ2p0cS9OTnRpWEd4TUdYRzI5TXhqOTBwM1VTM3VL?=
 =?utf-8?B?M3k4WHZucGZUWkFiNzVSb3I0Wm91bGxBK3lMSXlKOXJkZTZvNFRXeVgvWG5u?=
 =?utf-8?B?S0NWdkxTQlQ5b044SFJGZ3djNk9YLzk3SjVHUHQ1L2Q1aXovek9YWmlGNWtO?=
 =?utf-8?B?NVVVWTZIK1lta2drVHVsdVNRRHhiVnZxdGY2SExtUkFhWXlHSWNKczlqSmZB?=
 =?utf-8?B?YlA3dUMwZU5vL0lRc1phbi9oWCtmVzRrUUY5UGtEZGJEb1lXbUVHUnZTY3gw?=
 =?utf-8?B?NjhISDBHVU0wcVdpeXpEQ0xIUG1JK2ZrUjRwZHVhTVpoVUhSTXJjNG5mUy94?=
 =?utf-8?B?TEJBenRnc3Z3TFAxaVhndlVycDZMaDVKeWUrWEVTZkdPZ3FRMVR5bkUwRkcv?=
 =?utf-8?B?R25DOEkvSGIvSWEvZGhFdm1NODhNSHkrTHc1Y0xLQW55ajkwcXNNSlZlbk12?=
 =?utf-8?B?blNlTllTY1llcE1SUmJZbXhSakhJbWR4aThNL3BDVXNNZm84LzJoZ3k3aGRN?=
 =?utf-8?B?WFFvQURWdnJNZ1A4NCtqOVQyVEovSzkvamYreEFraWdxdy8rbDVlRXc2bUJO?=
 =?utf-8?B?bGdkRFYwTmszTUM0cTN1YzE2azVNNFZxcDRLaDZSWmRDcmRwZ2xDamJja3RQ?=
 =?utf-8?B?bVhGcXFoS2ovMXE4VGYzV2l5WW54a2c3L1V2NVVzVnFrL3VkVXorL21SbE11?=
 =?utf-8?B?Q3RFbUQ3S1JKUEwxdStZaStLelJ3S0tZclhld0FpdlpHS2RTNllBYTRGMlB4?=
 =?utf-8?B?ZTl5cHM5clpYWDRvRncvTVlJcFNRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3220ded-8731-4040-e36c-08d9d46172f0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 17:48:45.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XO90RsK8+IE6Rrfh+mZTYERGOZ1ZS2lqoQ2H9deJ9Xmf+rmE+hVqDInB/bSuC14zV9a7gFYPlk1OG+QYq7hvMZY1JOg8UDstLlBmOdSS/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2659
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-10 5:03 PM, Lad, Prabhakar wrote:
> Hi Cezary,
> 
> Thank you for the review.
> 

...

>> Recursion and loops are means for doing something repeatedly. Could you
>> specify _why_ such change was made i.e. the conversion from one method
>> into the other? I bet the code is not being changed for the sake of
>> changing it, the reason is simply missing in the commit message.
>>
> I had feedback from Pavel "recursion is unwelcome in kernel due to
> limited stack use." which I did agree with as a result I have come up
> with this patch. Also to add this driver will later be used on Renesas
> RZ/A2 SoC's which runs with limited memory.

Adding that reasoning to the commits message will prevent questions 
(such as mine) in the future. Thank you for a quick reply and a 
transparent answer.


Regards,
Czarek
