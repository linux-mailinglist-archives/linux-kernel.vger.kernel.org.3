Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A85668A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGEKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiGEKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:51:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC3E02B;
        Tue,  5 Jul 2022 03:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657018288; x=1688554288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9V0+mmaHa9xHdgCDafTN9beKaV2Vmt/Up9j6eLIAwI=;
  b=Zk3J2udfgWf1u0etK0Idi2GVTd13GycPEvUL16UX2y64f+jDjlGePXfX
   K3woza7Oszv9om5pegekOJYChGTCOczcx3y+0/VY4CNFddNzKMgMMDhXQ
   by/fNeegiRqmsc7wwMo9ZctpETLcCeeDdp1+lnDVaa9moTfwyhXY4A//P
   4fNSPW5p4UTD+99KM0sECjraZgn9wYOfBcFvLylGySCnkPrGa2gz69F7I
   ZxpKteybrpKSzQo6Fo9gyvl9WPnDflcdSOiQRTRCgrvCdzdv2K+3SYaW5
   QAS2zxm5bSmqSnTxzx2wFCaz6HYSim+6GlDUkxtFdlbT2K6viMA1fxzTL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="308860461"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="308860461"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919669883"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 03:51:18 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 03:51:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 03:51:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 03:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsBv44ibh9gfOl2QcthZPz/sobDTwKuqyqNogGU8acK19Ln+PIDcEKJICQqqYJvbescSa0SV22lmoYa05CXholTWvGrhi8LGCnySkeKm+nPi3cja4OvMijSkqZs8X3LXnd4okNXRD65lUi6P6nudp1q+tKjPMww30exy8DBrrk0T17EcN88wvoEBAd57qI8wiYJYWdv1r7xyWadRyNfZEtiqL5hs6qxPIY158jUyONgE/3PVB0D+tyRiq1u90Ol2pf099J2KZ1jCJGNfgHrFZBueLubxh93D3cFtUoKedgFlAVJ2WeqC9cTFmU5uWtEyL3PXn8+dNuZq+QUXk6KmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6uM5dbEJ1MUf0JOTVK9zXqOGpCLFfonjaKM0RQawF4=;
 b=CCu4GzP8Woo0NQ6BOnnBzyCbiqYqnbgv6J5weljup0cW1mp589nT/5fd42DlGnwJ9DF9Xc/1CvrF01JMEOSEKs+9ruzodVqgE31JOqpHmmq1Ld2BTUWrTyhHnbnNCW7P8BNpaplXJ9+npMculI7hg51Nfotpf1E3MXfs9eUxGbMmsw3rxCSPUfF0KFtL0F2RX5W1DlasCjW8TYGXBtTj0pGKoTnGQ06TAK67T+M6nsNs6fyp3plzqsUjpZYAuIZA/x6gNQMCEvvh01l4wrOHux2VhQbjchVDbyPD3zwiI0yu0+gIDRRA14P5jMOw4RLsRE8j7doESFJrHu7LNjFRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM6PR11MB3433.namprd11.prod.outlook.com (2603:10b6:5:63::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Tue, 5 Jul 2022 10:51:11 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::8b5:ae20:1c12:421b%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 10:51:11 +0000
Message-ID: <12fd2cfd-190b-7d7a-85f4-55e8ce2e3a56@intel.com>
Date:   Tue, 5 Jul 2022 12:51:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: Intel: avs: correct config reference for I2S test
 board
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::38) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4d7a634-90bb-449e-6729-08da5e74463c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3433:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wFghs50ZDMqR5jSjua/Nzn5O2wfNUN+qeaKdq8bfnKHlSiy3RNE6SYSZJ+wewjPOFQZoMStX3xiyAfdsIHVsTV2cldfClD7UwbzOA/xlnTKEgwmxmmM6X1wtpjpc20BrDmio+WrkkxdHR81+fb3ijsbEJavstU3liOWNgmcHpJEQ92OgG2QDhVXqx7+SZqbwgKjPCtIIhxw3Loog1dVK3azwvtH5z7jm6XWJGhXx2xfz3o66QAUUL0Y/ixeJ+j7R2/ji4XhT5SwMBzIfWGyzKk6q4vpazfqmW56N0f04D6NkduSXYNILMll5VakQH4BkRC02SN54T5952DWjz2+p1eXxkiEokkJFY+FEck4faK4365CBWZOTi/LdrOs4IVRlpyFEk10orRd3ipZTvHX816T6eUl5u6S+uYFF4LIGgxnk/UxGy3WsgAepU3D+2iMMh+gli6Pdg1/CH7ED2sLKo/AMv1VCMb5GE+yRn+G2TVvkGP4fcOVypJk6ucXf9KcxK4+1cgSLK866h7B18cgMqswZMsgZDo5P9yQgOP3Ji164ke75wXoacYxAbJHpfkFEZstyxwU8ui1JCABkj4nPD0y/REdEiURi+N+pPcXdysLuraqjsls/2IEEkncV2+9Y8DhXtZiZ/pYrNXW8M+3sR/0N2sHmcNkYNOG3NuqOhFliDCX4fLAhmVN9e4HUdWssQ2aQPwFUBeRbDcnEkbOed/2Neqlg30kqkc2e6jjFZRl+b7880gpZYG5IrACJZgNwUTte2xuVIzHXTJ4f0eVx8/HOYVJE3cs9XXczz6bws+B4zpB5ah/51MASNrKyhOPMiqe8nBCwv3J7FGmeDvFlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(26005)(6512007)(66946007)(83380400001)(41300700001)(2906002)(8676002)(4326008)(44832011)(66476007)(66556008)(5660300002)(6486002)(7416002)(8936002)(2616005)(478600001)(186003)(53546011)(31696002)(110136005)(54906003)(36756003)(6506007)(82960400001)(31686004)(316002)(6666004)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE8vb055K01FenJJVzVkb3RuZm1JQzZnalpJZEEveURGb0VRYS8ranJ4K2d6?=
 =?utf-8?B?bmM0NG85czVrT1djaStjSGpaMjJtdiszVUJHblJQSnZ0QnpSZGZQdElac001?=
 =?utf-8?B?aU9jcUxzN3ZoU29Jc1ArZVpGNTZzeFFGZGR3bk1oWG40K0NNWEM0ZjQ0SU9t?=
 =?utf-8?B?MTIzQnMrWkpuUlJ3eDNQZTBlVWhBa2pHODd1Ty9QVWxabnFscVNydTBGemxF?=
 =?utf-8?B?d1l3RHFPYmNDWHZMcHlwZXgzaVRpRk1tOVl5Skh3Q1dKdzhPUkwvQ0N4cERq?=
 =?utf-8?B?M29Vd1JtVjJPRXlzTnpwZzVucjRDazVSdGpGeTlQbGhMQmZWSEZPTERSVGFr?=
 =?utf-8?B?SlhUT2dVRFY5dE43V2ozaGJhdjU4THlMSmpkbjFYSVdubDFjYjk1SEhBZ210?=
 =?utf-8?B?M3l1WlI0QU85bXo4Q2ZXT1BYakdBNlpPWlM5ZHlDZFh2SmRlUEN6ZTBpd2tF?=
 =?utf-8?B?ZGdUZTQ0OXNSNXlhVWYxcUVIQzA1UnZQRXd3VkJ5UFQrdVowV2hld1JVeS9I?=
 =?utf-8?B?SDJrWDFpaHk5ZnZwYTJHRGRmN2ZEeGhYU3ZhK25BWHlzWTZjbFAybXc4RE1S?=
 =?utf-8?B?TitCWWh5c3ZKWDM1bC9VYWhmb2lSNExPMWRQclhWb1Z2cHJJZjBlM01oalV5?=
 =?utf-8?B?VmdDUEZtbTMxb3VBb2dZSmUxTnpFZURLRTRvWmJ4R0x1ZGwyTjZ5NlhXZUpI?=
 =?utf-8?B?MDRFYmVjb29kd0hoeHV4d1NHRE1DbzZ1NDV4OGE4UDhsdHI3QThJSmR3OG9o?=
 =?utf-8?B?ZDI5OFZqam5KZEEwcVl1R3F3NEdaZmd6Smo1Y0kxL2ZlekZRb25zaDFrMDJ1?=
 =?utf-8?B?bmJ6eDNLQjlwcFU5b3J6dWNVNjVXbXYrOTV2d2toNGhmd0NBVlMzekVxL2xP?=
 =?utf-8?B?NE1BT1lOYWJiMjk4dEgwcXo1NU1GYWRzazJwRzFISitvUjFzV1kxQjZLNTMw?=
 =?utf-8?B?aGhTTXhUN0RRaExFTTVXMHFNSTFMd2hrQkZRVE5iTEJNbnZyWmphYmZHS3hN?=
 =?utf-8?B?UkJEL0o2T3o4UHd3OXVSQTRpTkYvYUdEMmJjaW1lL29HbVFVaThSUGF0b2c1?=
 =?utf-8?B?OFBEMEFBaXQxMVo1YVYwT09iSGVOcGgyb2VXZTIzQkNBbmFKRzg5NGovWnpQ?=
 =?utf-8?B?emlEb2ZtcElHOFRDOTNUV016QWsrcDIrNyt3WUZSeHRxUU42VG1JU0FsaVFV?=
 =?utf-8?B?ekYvSjlwTXZIc1NBNFVwY0JOV0VKVXZta1VYMG9BVVkyTGJWcXFtUnZLWjBz?=
 =?utf-8?B?Q3poUUJrbTlUM05EcDRQUTBveDFDeTQ0NzhMMitLYytwT2FjR3Q0V1lEaUU3?=
 =?utf-8?B?SFhyN0Zpak9hV0Z3R2IrL0d5ZzV6VStRKzNUMEM3ZitNTWtTVkp3dWlVcjlZ?=
 =?utf-8?B?WnF1alpIVFpaM1cvNzVoOTVqQ3o0dDgzOVpDVzlzRGozaUh0cFF2Vld5c2ph?=
 =?utf-8?B?Z1ppZUZxT0t1Z2FCVDg0UFd3MnJnQU5PUC9tdndyd1BRdEVMMW9iTXZyRnJL?=
 =?utf-8?B?THV4aW1rVGNVbFpHUHpsQjB1QkhTRG5HRUUyUzZjcTZiSEU0UUM2NHBQT05i?=
 =?utf-8?B?QlhyNjBxNGxDdlBWS1ZJREV3bm9LVUNkZjd5akttTk9oMHRZWWF1UURZeDNG?=
 =?utf-8?B?WEszbXhuZ3NoWkVyQ1p5VlJtaW9yekZ1aWdCa1hYSENJNGtFenV3TVN0bGlZ?=
 =?utf-8?B?Tm9qNjJ6NC9wT3A5cnJRbGNySks3YUJ1cnBNY3JFTWprSjNHMTVwaGg3Tkpn?=
 =?utf-8?B?TGxrU0F2Y3pyTXlhNEh2emQ3UUpITXVROW5nc3VHT0pvLysvRFkvald6WG1N?=
 =?utf-8?B?bW9xVThrbkNtRE0xZXp4OUg4SnoxSy85cEZJRUx1VG5PUzV5d3Y2cGxaWWZn?=
 =?utf-8?B?aGs2WGZrcDIwOVdNeCtEZXdjZGtZTGNBQ0xBNjQyYXVzT0R0L3lSdDVaY0Ex?=
 =?utf-8?B?b3FMaFY0NWtvN05ObTBXRWgraGVJRTR2bGliWDR2WXR2YTgvdXdMWEJ1ZEZl?=
 =?utf-8?B?M3BNQTk1UjlBM3VnRzdlQ1I1WnlpSERTcjkxRUNuakZaQWhDcS9kc3dmbXRW?=
 =?utf-8?B?T3hMdXc1dlUyZUpzRlhYclBnRkExVDM5N1JpSW5iakx5RFFmSlpxa2kxK2xO?=
 =?utf-8?B?QXgvWStZNHRYc0h0ZFlQdmxzNzVzOWx3QWFhWm4vUGN5Y1Z3ZUszcVlPaEhD?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d7a634-90bb-449e-6729-08da5e74463c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:51:11.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOcYI3kOB/HBoN0pSOWwca7JoiSxtYwe1pBwVgAYPB7Dxez2mPhpUSDwP8awhT0HvzY42h5fkN1UDWHIAWrGpUU0l75Hk2nva+u3tWGhMYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-05 12:32 PM, Lukas Bulwahn wrote:
> Commit e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board") adds
> the config "SND_SOC_INTEL_AVS_MACH_I2S_TEST", but in the Makefile refers
> to  config "SND_SOC_INTEL_AVS_MACH_i2s_TEST" (notice the uppercase and
> lowercase difference).
> 
> Adjust the Makefile to refer to the actual existing config.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Thanks for the fix.


Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
> Amadeusz, Cezary, please ack.
> 
> Mark, please pick this minor build config fix.
> 
>   sound/soc/intel/avs/boards/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/boards/Makefile b/sound/soc/intel/avs/boards/Makefile
> index 25e8c4bb07db..bc75376d58c2 100644
> --- a/sound/soc/intel/avs/boards/Makefile
> +++ b/sound/soc/intel/avs/boards/Makefile
> @@ -16,7 +16,7 @@ snd-soc-avs-ssm4567-objs := ssm4567.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219) += snd-soc-avs-da7219.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC) += snd-soc-avs-dmic.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO) += snd-soc-avs-hdaudio.o
> -obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_i2s_TEST) += snd-soc-avs-i2s-test.o
> +obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST) += snd-soc-avs-i2s-test.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A) += snd-soc-avs-max98357a.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373) += snd-soc-avs-max98373.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825) += snd-soc-avs-nau8825.o
