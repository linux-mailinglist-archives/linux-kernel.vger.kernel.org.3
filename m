Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDD5B0CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIGTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGTE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:04:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969222B183
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577496; x=1694113496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAfb02E+5MUyULhkqgxQAhm0h6NvyV50tWw+/pRW0vg=;
  b=G93PNDSusTUXzq1MPzRSomSoISRbMDR0Zl2ITwqkyr/i+uUAyno6iu+E
   YfwzOLbcFN516ESOmdfWwQZVLbQAdm6GTk8MlINjsITOYR5IxwFqlgblX
   4I9uhrtq4wOonTSTYSYvP5+XC7/CUS9hfMed0Y+doC+dhTRAGvSXBlMZl
   M3hlfqVuP1PlkmdDteFlMu6yan6DmlhhTr789nYXXSdKOygX8issjIBP4
   cmAx75zssb7+j7iGQj3WAFlNzP3qDd6kjAnGpljqT19ZFzpKp91Y+Trq6
   ShYaNBRvfz0OFJSqREnwbg/1qD5Z4yUMM4MN75FbbaUUAB7BHlqYsD5qu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383263509"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="383263509"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="703722697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2022 12:04:56 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:04:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:04:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:04:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3GplxC0usretvSDyddEBkpmukhunrJ2IzW8ZPhvUmhpKIvKnNigL8UPoILXR2ayNUxebVkGNcGsQTez133Yld13mTGc8ObFmy0Ze7Dhy91Oog3yRkXErG1vK2Fs+saQ8Vi8QadbrAesJp0I2k7jIPj7qvYEFHaYNzBZ+LnZH6PnhYbS9aKW1Ik1+mEFwLwg44VhdRmKxap2UQHEjMpP7qQTCnVQP5gKReBAtuNJ81dcKG/SaBH/F+hQmfvU/8CZ0WBiXd9OFPinVBYA9WzX/ALwzwyfjIyLp+nbJZHmFuFguBoYHetpvP2yrFyTDA+KY17tj/KhUQSaXOFXYu/Bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rkKlGst9LKjz38KIunRkcgpi3zpBj67cCkFNngF4ms=;
 b=Rwz/W5fe/cc55QkQIvsCl4t6tpbf4URR/l4aNMdFAIyA1QZPrMhX6So87XT5dKd9mu9/MtScH8HciIIVPbj6FfHYZhmRpUVAIxkebaLwruH6RW9Mr66pP82ycfWUIieR16Ly7OwIsm8EQEgJyfz8zpzjqDuZrHWCYYW1eXkUVfPsMimPQiKO5TFub27ztyhBH9RLG9y97VvO8M4mMijy6fyqDfpwFSdQbyzxmmGFM5OswepU0+pg7KtIAcXdqEYtOHUdQXNHDhFDJfH/p3ycNgjn+2yx5HQmTxAWdLMsRllzveREBumNYdDfPEsGXrlqQ3MHXD1I0prLpRom9OtHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CH2PR11MB4326.namprd11.prod.outlook.com (2603:10b6:610:3c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Wed, 7 Sep 2022 19:04:50 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:04:50 +0000
Message-ID: <7210e543-2f96-963d-b740-81e047615704@intel.com>
Date:   Wed, 7 Sep 2022 12:04:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 06/16] mei: gsc: use polling instead of
 interrupts
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
 <20220907155813.1427526-7-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-7-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:a03:80::21) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063ea925-7eca-4618-4a79-08da9103d6d5
X-MS-TrafficTypeDiagnostic: CH2PR11MB4326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLsgvjn2GbrHsJz+l5039yCxDPpH7iQh/3CWtZwEvYsHmSpB+CYxKg2MpkVgTl8x0rbLMqD6kLhEhCgP1HDUN8Z41/c8B/S+cDb8AJbjyykyP3Tc8VtLdlA2mPLK+3jZanxBeesuPbS4YlpbtW+fnb98cOdE5owZ1JCJwgZnT67Qtm0D/ADNsNiiLan1WHxneV2leUeOvbxXqhALGipxwUq1uJ6phHWIl8bNadIrMTDGU4Jym4iyDSk71vNep9DZcqNd2xzuL8yeYuSdKtQgXvhzpUzfqMjyhXfp+MRt9OAcbOJQh9DUr+McbDLKEEAN2iZiVeinMA+FeTIn3ynh5RAb0kirbRxuQnk1HnHwP9tqhbkUTwjQWqNRR4/E2J1QoE5T9EK7DmhPSB+6XqSUlt83KnlOqG2TAUqgfuQT/AeMqDEtfVQrdj9RuVSTHN05PuLEmyeC8Vf4G1LWu58tqdWLCWhbnK/wOp3SaGVUGAXgJ15qyuXfZZHjDDIoZBx3J5xRoSdXy9edzBMru6QbJ0xfKRzqu5hSY/8c7dUtKCMYCR/qwvRiRjzuuhwVyYU+pDzPQf+2mt8coyHi3wVrzPWkbh+1hvXebQvw/9D7UPJz90XOGXDSI9xI5Iv7coyqJO7WwdpcbBvsVlqY12zg/OE05C2vWW2SRflR+omjPgSSyRJXMvhKfO3yc6KDFgDMHoFpfKjM2JqRrmE5zni8bOt74mMedKIWuHfQIDD/54WODUvd9ZodPUNiRswiwqBX7Yl4bcdh52KS9HrTCKc9JvxqUo7btx7o16k2zcmGJ9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(376002)(366004)(86362001)(31696002)(110136005)(82960400001)(316002)(5660300002)(38100700002)(54906003)(8936002)(2906002)(66556008)(8676002)(66476007)(83380400001)(478600001)(186003)(2616005)(4326008)(41300700001)(26005)(6512007)(107886003)(53546011)(6506007)(6666004)(31686004)(6486002)(66946007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5uUlN3MS90NzRKcDhkclUxblUrNE5ROTZZRlc1WG5vYTAybTl2NWlrSTUv?=
 =?utf-8?B?MVVXYmRqemZ3OEJSLzBjYnZjVlJrTnEyd2pLREVjbkkrZEFDZVBRUURJYTNO?=
 =?utf-8?B?Qzk0RGVrNFVabkZyVm5Ua2FNRjdMOFlPUHJXMHhmZitUWndIYWo5eEVZZzcr?=
 =?utf-8?B?YXE2bmtjVVlsTW1RNEZtdFp5eGFsM1RnQTd5ZSsrSGhMVHE1NldKeEQ5dTB2?=
 =?utf-8?B?VU9OcjJoYjJacVVmMjkvb0xZckUyaEdLUkVUdEdlc25CYUk1dlc5bEplSENk?=
 =?utf-8?B?d3hvTUMvUFNFVTBRUE5SWkZ0SU9GOHJLQ2tuRW5GZzBYN3lYb1pKRVpUZmI0?=
 =?utf-8?B?eHBJWmxpN2NhcFd6alkvaGZCaHEyRExZN3J2TUFXdUdJQ25qUjZoTGdPYzA3?=
 =?utf-8?B?cU93RU4rN3hPMkZ0cDVpL1RpcWdJNDUzNnpPVzlaRHBjczVZQ0dDQ1lUQWdr?=
 =?utf-8?B?a2twMnZZU3ErNXF1OHY2ekkrRHQ0clRocnY3N2t1OWp1YUg4MTRGSzRrMnZl?=
 =?utf-8?B?L2FyRHMyeHQ3MGNrYnVvMnVUbmhlZ3o3RCtQUE11bHF1WFFTQ0xEM2Z2Q0JS?=
 =?utf-8?B?di9nR1p6d0IvVUxHTUhSQU8rdU1OaDF1bkZuOFJGalk5dGhyeTBDK1RodmFq?=
 =?utf-8?B?eElOdStKdXdMR3Q4OGlKUDJNTk9YQ2NidzBlUVQ2aU5OWDZYMUxzS2RPbE9Y?=
 =?utf-8?B?WmNyejBQWXJrdDBPand6Q3YrZ1hMNVhNa3l5SG5IVThUbU5LdWVCK3p2N3Jn?=
 =?utf-8?B?V1g3Z3BFczc2TDNucVNIUE1yeHRGMkk4d1JOK3UwYU1Wc0paamN6dXJnK0RS?=
 =?utf-8?B?QWNyZUJQcTVKeUJLbG4ydno2Um9xZjdkN3AvN2Q5S0IrTHRscmE4N2orN3Ev?=
 =?utf-8?B?cU0yL2NJb1hoNDFjQXl2OVZEbE9mZFI0b1FCWEVkdlRjNDgxK2VxTTZaZVdp?=
 =?utf-8?B?YXRYMmFsRFZFUVI5R3kvTDhtL1lyRkpuMUVjbWdPZWRITU1jMVEvQlZLN0NP?=
 =?utf-8?B?dE5wU2sxcThYa2tZOXlnbTJRUStCMTBVSXBtN1l3OVhHa00wTlhYNGJuYlo0?=
 =?utf-8?B?Nm41K2Vsd0RGcTU2ZGJXbTQvbzQzNmYwcnpjMGJTMW10d0VWNjJQTWpBT0ps?=
 =?utf-8?B?dWRoMm5Wb2FDWkxIMmwxQmVIZlVPaXplaWU0dEtUSitSZVBaL0lJakJwVjV3?=
 =?utf-8?B?L05yY2dCVTExOEp5UTZmUWxlemNxVm5Pdmx6c3ErdUZ2NWdRTU90NE50Y1JV?=
 =?utf-8?B?NWwxanFLNlNHckxhZ3NobnFCdGhMTDA4Z05HWktpK2RVUmlubXhLMnZ6WWla?=
 =?utf-8?B?R1MxT0FQRnRmeG9zRUkxdFdIMVQ0ckhlY3o5UFJpMGdORGIycUFINC9OSmJV?=
 =?utf-8?B?US8vWkZ1U254MWpMNFpiYUprVHZqbGlpVkQxd3FVS25oeExRKzNHUVJBZEdX?=
 =?utf-8?B?Tmc4cFlCVk1Da1pXOWNUdEI0cGg2NndiT1RBYytMU09DVDBzNE0weXE3bk12?=
 =?utf-8?B?Wlc3am9nOEhFYS9EODRxS3BGWXdNVFl4amFrMlovQloyMXE5L2NnSlpHN0ZK?=
 =?utf-8?B?ZWRxRVhVNmhkRWtBeEd2Vm1wR0h1aTE1bFJUcks0YVNRNG1jTnRvZEt5OGRi?=
 =?utf-8?B?bnNPQzdGZkV4RXA4WGVwMFhoT2FBcG0rV3AwS282cmZORzN4Z0lFUUVvYzUx?=
 =?utf-8?B?V2JEMjUvNWswa1FvYWNNR1BqaWc5MFV6VGxNbEl3eWZjWU96NEUzamJiZDlW?=
 =?utf-8?B?b0ZRRjRCRW9paEpyVXI2SmlrM1JDeEgycFFSL0twZFZhb0crYmlGekxnRWZj?=
 =?utf-8?B?VXZHUU0yQ3lXSExiQTIxSERob3BSNUlwNlN2RkI3SFM4V05oT1JXYkpndWVp?=
 =?utf-8?B?YS9hTUgydWZ0SGx1M25ZN0RySjdjYzk4cDZVdTNUU1VSYjZBTXZhRjFLeGc5?=
 =?utf-8?B?dzFTSDJXbmR4VmxNb1hNQ0xOeUxwN2xFMThtbU5hdTdua0RPMUMwYy9RU0J2?=
 =?utf-8?B?eGZSYktBaVhXVTlBdnJYZjRCRG9kTDV0Y1hRZEI2c09ta2hBZHZBc2JwTzQ1?=
 =?utf-8?B?V1I4U01JVVRHcnZLRVFNUG9HcVJycFZQYWJteGtGSS85ZFRuU09wK3UvaEJ1?=
 =?utf-8?B?UnFrMms5WTlkVnhNOFpaWUhpRTlHbzErVjdxdFl6V1Y2ang1K1ZKOTVBM0li?=
 =?utf-8?Q?ueYmagx/lzhH8mLrB6PVBew=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 063ea925-7eca-4618-4a79-08da9103d6d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:04:50.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6yrKEk/9dU3ImrixwGixePGNENRbXfMhRl5LpqeaB1fF/+2DsXAEsnhFCKHYB2tQJVMCXeglZkNi6Ns/b8YSseEzZrYAwtrO9ZR7H58bRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4326
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
> A work-around for a HW issue in XEHPSDV that manifests itself when SW reads
> a gsc register when gsc is sending an interrupt. The work-around is
> to disable interrupts and to use polling instead.
>
> Cc: James Ausmus <james.ausmus@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

The only changes from the previously reviewed rev are extra comments and 
doc. Those look good, so my r-b stands:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/misc/mei/gsc-me.c | 48 ++++++++++++++++++-----
>   drivers/misc/mei/hw-me.c  | 80 ++++++++++++++++++++++++++++++++++++---
>   drivers/misc/mei/hw-me.h  | 15 +++++++-
>   3 files changed, 128 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index c8145e9b62b6..2caba3a9ac35 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -13,6 +13,7 @@
>   #include <linux/ktime.h>
>   #include <linux/delay.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/kthread.h>
>   
>   #include "mei_dev.h"
>   #include "hw-me.h"
> @@ -66,13 +67,28 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   	dev_set_drvdata(device, dev);
>   
> -	ret = devm_request_threaded_irq(device, hw->irq,
> -					mei_me_irq_quick_handler,
> -					mei_me_irq_thread_handler,
> -					IRQF_ONESHOT, KBUILD_MODNAME, dev);
> -	if (ret) {
> -		dev_err(device, "irq register failed %d\n", ret);
> -		goto err;
> +	/* use polling */
> +	if (mei_me_hw_use_polling(hw)) {
> +		mei_disable_interrupts(dev);
> +		mei_clear_interrupts(dev);
> +		init_waitqueue_head(&hw->wait_active);
> +		hw->is_active = true; /* start in active mode for initialization */
> +		hw->polling_thread = kthread_run(mei_me_polling_thread, dev,
> +						 "kmegscirqd/%s", dev_name(device));
> +		if (IS_ERR(hw->polling_thread)) {
> +			ret = PTR_ERR(hw->polling_thread);
> +			dev_err(device, "unable to create kernel thread: %d\n", ret);
> +			goto err;
> +		}
> +	} else {
> +		ret = devm_request_threaded_irq(device, hw->irq,
> +						mei_me_irq_quick_handler,
> +						mei_me_irq_thread_handler,
> +						IRQF_ONESHOT, KBUILD_MODNAME, dev);
> +		if (ret) {
> +			dev_err(device, "irq register failed %d\n", ret);
> +			goto err;
> +		}
>   	}
>   
>   	pm_runtime_get_noresume(device);
> @@ -98,7 +114,8 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
>   
>   register_err:
>   	mei_stop(dev);
> -	devm_free_irq(device, hw->irq, dev);
> +	if (!mei_me_hw_use_polling(hw))
> +		devm_free_irq(device, hw->irq, dev);
>   
>   err:
>   	dev_err(device, "probe failed: %d\n", ret);
> @@ -119,12 +136,17 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
>   
>   	mei_stop(dev);
>   
> +	hw = to_me_hw(dev);
> +	if (mei_me_hw_use_polling(hw))
> +		kthread_stop(hw->polling_thread);
> +
>   	mei_deregister(dev);
>   
>   	pm_runtime_disable(&aux_dev->dev);
>   
>   	mei_disable_interrupts(dev);
> -	devm_free_irq(&aux_dev->dev, hw->irq, dev);
> +	if (!mei_me_hw_use_polling(hw))
> +		devm_free_irq(&aux_dev->dev, hw->irq, dev);
>   }
>   
>   static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
> @@ -185,6 +207,9 @@ static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
>   	if (mei_write_is_idle(dev)) {
>   		hw = to_me_hw(dev);
>   		hw->pg_state = MEI_PG_ON;
> +
> +		if (mei_me_hw_use_polling(hw))
> +			hw->is_active = false;
>   		ret = 0;
>   	} else {
>   		ret = -EAGAIN;
> @@ -209,6 +234,11 @@ static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
>   	hw = to_me_hw(dev);
>   	hw->pg_state = MEI_PG_OFF;
>   
> +	if (mei_me_hw_use_polling(hw)) {
> +		hw->is_active = true;
> +		wake_up(&hw->wait_active);
> +	}
> +
>   	mutex_unlock(&dev->device_lock);
>   
>   	irq_ret = mei_me_irq_thread_handler(1, dev);
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index 3a95fe7d4e33..23ad53efbcb7 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -10,6 +10,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/sizes.h>
> +#include <linux/delay.h>
>   
>   #include "mei_dev.h"
>   #include "hbm.h"
> @@ -327,9 +328,12 @@ static void mei_me_intr_clear(struct mei_device *dev)
>    */
>   static void mei_me_intr_enable(struct mei_device *dev)
>   {
> -	u32 hcsr = mei_hcsr_read(dev);
> +	u32 hcsr;
> +
> +	if (mei_me_hw_use_polling(to_me_hw(dev)))
> +		return;
>   
> -	hcsr |= H_CSR_IE_MASK;
> +	hcsr = mei_hcsr_read(dev) | H_CSR_IE_MASK;
>   	mei_hcsr_set(dev, hcsr);
>   }
>   
> @@ -354,6 +358,9 @@ static void mei_me_synchronize_irq(struct mei_device *dev)
>   {
>   	struct mei_me_hw *hw = to_me_hw(dev);
>   
> +	if (mei_me_hw_use_polling(hw))
> +		return;
> +
>   	synchronize_irq(hw->irq);
>   }
>   
> @@ -380,7 +387,10 @@ static void mei_me_host_set_ready(struct mei_device *dev)
>   {
>   	u32 hcsr = mei_hcsr_read(dev);
>   
> -	hcsr |= H_CSR_IE_MASK | H_IG | H_RDY;
> +	if (!mei_me_hw_use_polling(to_me_hw(dev)))
> +		hcsr |= H_CSR_IE_MASK;
> +
> +	hcsr |=  H_IG | H_RDY;
>   	mei_hcsr_set(dev, hcsr);
>   }
>   
> @@ -1176,7 +1186,7 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
>   
>   	hcsr |= H_RST | H_IG | H_CSR_IS_MASK;
>   
> -	if (!intr_enable)
> +	if (!intr_enable || mei_me_hw_use_polling(to_me_hw(dev)))
>   		hcsr &= ~H_CSR_IE_MASK;
>   
>   	dev->recvd_hw_ready = false;
> @@ -1331,6 +1341,66 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>   }
>   EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
>   
> +#define MEI_POLLING_TIMEOUT_ACTIVE 100
> +#define MEI_POLLING_TIMEOUT_IDLE   500
> +
> +/**
> + * mei_me_polling_thread - interrupt register polling thread
> + *
> + * The thread monitors the interrupt source register and calls
> + * mei_me_irq_thread_handler() to handle the firmware
> + * input.
> + *
> + * The function polls in MEI_POLLING_TIMEOUT_ACTIVE timeout
> + * in case there was an event, in idle case the polling
> + * time increases yet again by MEI_POLLING_TIMEOUT_ACTIVE
> + * up to MEI_POLLING_TIMEOUT_IDLE.
> + *
> + * @_dev: mei device
> + *
> + * Return: always 0
> + */
> +int mei_me_polling_thread(void *_dev)
> +{
> +	struct mei_device *dev = _dev;
> +	irqreturn_t irq_ret;
> +	long polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
> +
> +	dev_dbg(dev->dev, "kernel thread is running\n");
> +	while (!kthread_should_stop()) {
> +		struct mei_me_hw *hw = to_me_hw(dev);
> +		u32 hcsr;
> +
> +		wait_event_timeout(hw->wait_active,
> +				   hw->is_active || kthread_should_stop(),
> +				   msecs_to_jiffies(MEI_POLLING_TIMEOUT_IDLE));
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		hcsr = mei_hcsr_read(dev);
> +		if (me_intr_src(hcsr)) {
> +			polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
> +			irq_ret = mei_me_irq_thread_handler(1, dev);
> +			if (irq_ret != IRQ_HANDLED)
> +				dev_err(dev->dev, "irq_ret %d\n", irq_ret);
> +		} else {
> +			/*
> +			 * Increase timeout by MEI_POLLING_TIMEOUT_ACTIVE
> +			 * up to MEI_POLLING_TIMEOUT_IDLE
> +			 */
> +			polling_timeout = clamp_val(polling_timeout + MEI_POLLING_TIMEOUT_ACTIVE,
> +						    MEI_POLLING_TIMEOUT_ACTIVE,
> +						    MEI_POLLING_TIMEOUT_IDLE);
> +		}
> +
> +		schedule_timeout_interruptible(msecs_to_jiffies(polling_timeout));
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mei_me_polling_thread);
> +
>   static const struct mei_hw_ops mei_me_hw_ops = {
>   
>   	.trc_status = mei_me_trc_status,
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index a071c645e905..6256b36bdafd 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
> - * Copyright (c) 2012-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2012-2022, Intel Corporation. All rights reserved.
>    * Intel Management Engine Interface (Intel MEI) Linux driver
>    */
>   
> @@ -51,6 +51,9 @@ struct mei_cfg {
>    * @d0i3_supported: di03 support
>    * @hbuf_depth: depth of hardware host/write buffer in slots
>    * @read_fws: read FW status register handler
> + * @polling_thread: interrupt polling thread
> + * @wait_active: the polling thread activity wait queue
> + * @is_active: the device is active
>    */
>   struct mei_me_hw {
>   	const struct mei_cfg *cfg;
> @@ -60,10 +63,19 @@ struct mei_me_hw {
>   	bool d0i3_supported;
>   	u8 hbuf_depth;
>   	int (*read_fws)(const struct mei_device *dev, int where, u32 *val);
> +	/* polling */
> +	struct task_struct *polling_thread;
> +	wait_queue_head_t wait_active;
> +	bool is_active;
>   };
>   
>   #define to_me_hw(dev) (struct mei_me_hw *)((dev)->hw)
>   
> +static inline bool mei_me_hw_use_polling(const struct mei_me_hw *hw)
> +{
> +	return hw->irq < 0;
> +}
> +
>   /**
>    * enum mei_cfg_idx - indices to platform specific configurations.
>    *
> @@ -127,5 +139,6 @@ int mei_me_pg_exit_sync(struct mei_device *dev);
>   
>   irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id);
>   irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id);
> +int mei_me_polling_thread(void *_dev);
>   
>   #endif /* _MEI_INTERFACE_H_ */

