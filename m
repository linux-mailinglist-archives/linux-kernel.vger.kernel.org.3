Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D99567154
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiGEOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiGEOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:39:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B512638B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657031989; x=1688567989;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EmWHRIUY8/9YKR7QFxnExYaEv0oaYfPGNTBC7IZl1dc=;
  b=gCyMTPHo/dAM9iJVq5KTbGnmNs2cvkyiW/c4oP+NKTLbuySev9NOHrWY
   763skX5u98PoY4qyMmrDge5nOUwm7/euvaz9EaRvgOrCttYk9i5+z60Yw
   mKnrJ1M2kebyERTR7017/t4fVwhbafJ08Tu1/ERUCnRJy4Mb+FDsS8OS0
   7B/z4G7b0uCtSbP2hftTCoqHQOpTp9YgToOIyVWZ+SlydUkToK0QuTIJR
   o6HFxTKPJ+c3BsDA9CgHVIkZBKGQCF3LyAmq1TopHMDndt2/YBBN1SFOW
   tFRqFXBexLds1NF3qDNQfZVyLYcZQxy9xaAh9oS88/ZiWZLnLSqyhUlUD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="284483411"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284483411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 07:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="735178895"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 07:39:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:48 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 07:39:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 07:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PanmH7ExdA3CwdWsa+sBTSWmBvZryo/ghReNV8XyTLuVseh9jeCwtUZs2UJRJcLxmptygCRhAYKC/vomycdf0YjogvHV4r4eEaiFYZrRKVKrC32kwSe81EdDIPOvsOKcOsErSXKegKBjXEpEY1Xtwt3jQt0q3EqQp5YlPu5lU608pow+c1LaiT9aezQb5SuswNQm3j0f7TLpeCCbqaBbKIVWUbloXXJfeqrMq8xEcS9KdTRrXDzmg2nlnpv0wECI8aha5Q1vMxIPOlNjHEdS24usgmPvLsQ87IoB+xjlKbWQwx0gD49oXQDOXksVmiW1yVoXEW4Ny0k36MiU5Z5heA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUS+Hwg+2I0Ru/4+iIfdhNbj7cIeHvjzDHHLfOQQNkY=;
 b=SOKjCurjCfXKdL7CSRbXZus15neVLwjJjCOvVg04spPa3oB/AbmFxZjjLxgrpdRpbYgLHpbBvDI+f6nvrkKOyOxuujTv6uSC8yRzH1JNli0SE75jVlJUXZ9GADdmFE/Q47BKnW0Q07ep24Gqh+qiE+ca5s6woBQxSuLqORY0LpDIfhBWvi+1+moixQah4rNgDEMhngG6Dm28GR7f7MKu4DYyXKYFSzN2vxk+tQgVSVySuDERN+eURzcPDGXFVnjdYYkP+Q4+OljnDrsDERi4cfNIYYQXZqY+F/5nMTd3+LWcUazeG31tnfFPjL4v+O054rG7P4H3/J3pkSP3FlLDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by CY4PR1101MB2214.namprd11.prod.outlook.com (2603:10b6:910:19::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 14:39:46 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 14:39:46 +0000
Message-ID: <93547c1e-76c6-c5af-ca9b-27053a9e26a3@intel.com>
Date:   Tue, 5 Jul 2022 16:39:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/4] bus: hisi_lpc: Correct error code for timeout
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <john.garry@huawei.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
 <20220705114312.86164-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220705114312.86164-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::6) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288144c4-506a-404d-da15-08da5e9434b4
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2214:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97ENXKMrAKbbU38Xdof+T5Av+s3mnWpIMV24KD+WK8TDM54PiS3cLdMiOS48M+0PkU0JptFwcJEFDicNuGL0orHOUFymAgMO/qnwZ23ZhaKsufLx8y15tg9DCzhkCwiL6WpyrQPZk6Q1uDQdVCidKlwzqJJxUeybMdwNBrvD/JALjDaANNw8tkVyYXQBI29YHsJ9RPFmpsXcdOU6EiQsTn6WsWIHkshVfC8ar9dkKHXt/6ZB2JVHI9QasjcVyPvJDi3/nQAPyg2/K5oHz4KxJt6nsmoQl5k2cosE8pKmrHe9Dj7rzgvSgVKiz7eFS6ZM2qFqHn3kG/NPIE4X5ZUe4bK7oHRqI4/nmUsrNXSHiOoSQk9KIw+wLHfY8wFZf/Ey2B2iWOCIc2C7X29inHL0V9diVGJn/61vM66aEooms1uMTiKs/YenEvaNOaQVDuNg15st/APkuIv8nE2WZRH3vjAs4J7JhAxtAARQZTsHsajX/XvJ7Lvce5QN5mHz9dUq83kNSns1NR3A92cJCFICHUgOK8YBlF7+NtG1hZB3Ys89oK9imId86HXc4LNo1Ntb+/3Q157Idjxh809dhNFDpPkxPqF6r4Xnhiv5PudPiF11N35hMPxOZqwSfbp6sS0aCXJPm/lNVXId6GH/e9jU6UUrGSS4QMoPccL4Rk3Uujx4t65lD2rf5ef4S9gVrGf5Lw8enCoXOoil84WxTVxVJCSyaSh2JCVF1Qgz9x1/qZSN1VVP1wI1bx/FFUyWZM+8usmL2dN3GbAPmoyWSfl2A2bnvrtrzaponwxcn4ATuGPk6CB41nU65KKnWuwO4gkRK2VhM68ob8ARsjjXspT2og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(396003)(136003)(376002)(66946007)(2906002)(83380400001)(31686004)(8676002)(66556008)(66476007)(6506007)(4326008)(2616005)(186003)(36756003)(82960400001)(6666004)(38100700002)(36916002)(316002)(6486002)(4744005)(6512007)(26005)(478600001)(41300700001)(8936002)(31696002)(86362001)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBVZUxMS2t4UnY4ZHcxN3N2Rjc3bjJiblhVbVZ4MHYvTHNzN05jLzBBK2xD?=
 =?utf-8?B?dFJUcnpxaElUSFZsbUtTWXhJV0FVNS9XU01PNmZ1VTZZanduRFh0WVBmY1hx?=
 =?utf-8?B?UXNBTXlXVE5hdS91YUd2WDZoL3RaUTY4WGhTaE5GK1FuUmJHdnM4TWRPVHNH?=
 =?utf-8?B?dkZFMXV2ZkpoblFWZHZsRkdha1pucGcyZzQ0VGxvK2tHWmVRaUoxUnFQWng1?=
 =?utf-8?B?ODBIcXdGbmcyaDJPS29zeUp4ekFIdWtpYVNVVk9EMngwc3ZxcXlMSW0zaEs2?=
 =?utf-8?B?Y0lMQys4K0hYd3NQWDA0ajVuZ0RQMVpFU0ZNdWk0MEdwYmNPcXh1VXh3SUpD?=
 =?utf-8?B?ZUVpanFuVlFDS3N1ZGswek0yU3BNSlRVQ3NjSENCSmNUZzUzd0tLa2J5aDBJ?=
 =?utf-8?B?bGlrY0Zya0FvOUlFbHdqOVVYM0w2aUFEM2FCSWlLTjUzQU10UEpTR0pkUUtj?=
 =?utf-8?B?Qm9xNDdEaEI1Q0prNys4TmxhZENPUTJ3UU5HanljWExDd3VhOHRpNzFxMkQ0?=
 =?utf-8?B?RmpFM1ZrVTdmb0JCWStUMktRdFltM2RwTjBYbkQ5aldBalRkMjlIdzFQalFk?=
 =?utf-8?B?UGJ2bzBnZHpBKy9Nd0JsTklNalFRWE9tbVJDQVY1Y2NkY0xrd1JxaW5DRFlB?=
 =?utf-8?B?Y3BiaXhuZXMzZXBwYklVR2JuTXkwNHB2RVl3WElCYUV0ZGJYRUpsMk9saktj?=
 =?utf-8?B?anhkeGxMYVBldzI0ZGhPRW9WdkNwMVV3eG15eWU1aFhIQmIwOGwwcEJYRFJF?=
 =?utf-8?B?bUFydXROUy9NMWtkZVhLd0d6SllIUC9FRVErNjJPS0RSVXdnWTUwL3RCN20x?=
 =?utf-8?B?aVZoWkxNVS9XbkJTNy95YjRiTjl6ZE9VcW1LbVJYTnpDQk9aQWtWZHlpekJR?=
 =?utf-8?B?QjRKTmJtZzAwd3BMNERLRWlBSE5vdXp2MG9FWHpwZEpNaUFZV1U5c2NFNkpl?=
 =?utf-8?B?TU5HNFF4dzJWcjhTV3NCWDdSU3E5RE15UUhoNmt3L2hYSHVJTGFlSnI4Rm1T?=
 =?utf-8?B?eldmanJxcWNHd2d4RTdEMUtOYmJFdEhMWVR6RC9MdUp2ckpZZjk5L0RPSFFL?=
 =?utf-8?B?VjJ0NVg2TXVYYzFKejQxbTVOd0dWdExCeHJubm4xRlFVa2pxMEcyRnVPbkxw?=
 =?utf-8?B?WmtFdStWWGR1d0ZZSVljMzNmUGR3NDhmcDdLMVkydlNyNTlGSWJIamhyYU1Q?=
 =?utf-8?B?MnVHSFR4V3BYZXRKOFlkUlZqT0xvdCtqWDVSUlFyZXlwWE5FeXo2R1p5azM2?=
 =?utf-8?B?OVUzY2w0V2ROZ1Ewb2llSjhXYWdoUDNvb1ZaM0dYSDZqTStUZUg0TFB2RGdV?=
 =?utf-8?B?SHBSUEVWb045V05IdUdLWHFDYTZSQnRyc1JRQWJhSWJMWUZEYWowMmp4YXZI?=
 =?utf-8?B?cE16b2NTUjl4NTErMnhTeFJPV1RSM3doTEpMQXRTeWZuOEZFc25wTEFEekR1?=
 =?utf-8?B?aEpxSWlnd3JEek0zSlZSRWhpclJPdG9zanJvd09PUUZyc2JFUzVLdDgwTDBG?=
 =?utf-8?B?QVhXL3piNmRQUHlodXJzdWJpSnhUSmd6UW8vRy92YzU1N3RwOGpCYzRYcVVp?=
 =?utf-8?B?YkI2d2lkWmprUlhmSnZQajFaY2phbXZJdmdPeWFLVzJrWU85TE1pV0czQVJ6?=
 =?utf-8?B?TkY4cXA3Q2Vmb0ViU0lON1ZVNEdyZjNQYzdVQ3VyblBEYU5NNXI1US9sTVBq?=
 =?utf-8?B?SlNoSlV6ckdUZFlWaUNlUFlMNnFpbnRObzlUN3MzcmZCSjltT3dzdGdGeXZo?=
 =?utf-8?B?TUV4UUJZOHZJa0c3NUR1NHl0SWxKUXA1ODB6dXFrYU0rL2E0NWRYcjdKWTRD?=
 =?utf-8?B?RnNHQ2NHczJNZlFXWFQ1Y2I3KzJQOS9VOFhyZEJUV1ljTER4cEdFeFlSamJD?=
 =?utf-8?B?NzBENXJUZVorN1RtMjBxTEl3dzZPd2Q4R2ZTY1ZMTTJLRUZTNjAzSU4xem9Q?=
 =?utf-8?B?NnZvbFo0Y1Q1KzZFUkg4cXZoT2xsL0dhMmpyYTU2aDBkaUNqWlpmdjhLSDBP?=
 =?utf-8?B?ZlZWKyt1Y0MvZm8yUVFlUEZPUlVqRlVubDI0bm9jVFpkdFExRkFvbXJlcndt?=
 =?utf-8?B?cUUwOVpCUW1Bd3hEamNJcUdOSXkvVkNObFRMNVVHalM4d3V4UlFjVGFxNGxH?=
 =?utf-8?B?dklKYlprTUx5NjBTNm8wRDdvSzhXNC8rdit1NEVwRzdBdFZUMGVOTFlxNkxH?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 288144c4-506a-404d-da15-08da5e9434b4
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:39:46.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfvjBKBxwFqNDYwqdzWj2QseIaJbQVTNMYR94HoTp07QaTGysmVpSiSlIsMUemqsgwQm89Sp1eJ9deq0wRELL3BcCUeqT3GTEey2Sc0Zclo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2214
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2022 1:43 PM, Andy Shevchenko wrote:
> The usual error code is -ETIMEDOUT, the currently used -ETIME is specific
> for timers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/bus/hisi_lpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 03d4d96ff794..a6513a571d7b 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -85,7 +85,7 @@ static int wait_lpc_idle(void __iomem *mbase, unsigned int waitcnt)
>   		ndelay(LPC_NSEC_PERWAIT);
>   	} while (--waitcnt);
>   
> -	return -ETIME;
> +	return -ETIMEDOUT;
>   }
>   
>   /*


