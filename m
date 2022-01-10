Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA1489C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiAJPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:48:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:42547 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbiAJPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641829722; x=1673365722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQ24paPQm6EWwsGpekOkohd2XK6eBn5dYKLRbQVmKYQ=;
  b=RytjF9TaPFbjzGbHsJVhWn7z1nfVhMVBwYkyPegp9c6bGVcEDmyEz86g
   Q5NDy8w2wC1lQjSNRvb5K3EBkZBcF6iExP0dE0I3pwAeP/X6mvv8AbKIm
   R3rh0RLnKikZaiwuwdqhudHHOF0duSdKjRB4u/KvG9GhYTXQMr+CVAItl
   fKm//P/H56eYknqkyMHBiQcvqPkt1b2C1Ie1LCpPAP8dZJN7G8vhUpXG1
   vzaf6jIu47O925WKiX1/s0LKUPsxIRSFjFfEWFXjTtJGypD6bifa7pLmd
   FBDqNPiu4sYwAUYrbJcFGIVWbef+/9UjARq0VxEaNn8XLNjjqG9MoZ76B
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243450819"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243450819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="558021260"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2022 07:48:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 07:48:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 10 Jan 2022 07:48:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 10 Jan 2022 07:48:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLyHxbX+O8CeDkC/rzhDT25Up1p/GxDOQQ7TjEHWggx7BQm49y8RNFCCI6iWta3EjVYYPARMcyh2lulv5tWrZ2elnMhw859EE+crCdb8U1KGlJ8izGq/UXygBlSEpRg4/ne1Q6HcwpQ8MhQeN7qlBAIrAefOfrg0FFGOADWkyBuQ7MxHXKdNeBpEQSJVKt5J2d3ynehVDvA9yz6va6LwkweJIf1POGXu3KK2XI9HAkcKL9YPpUgSdG0NMjer8S31Wy9pppl7apFeHgeOcgHhM1H6y2NuEWKXZDI9RxQOd76Fyp8IiYonHudLWbU7KYiFE2x9EEtWfTVyQpAE3plYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naF79Q23KJdfY4Ci6cuy/dVKnd5uv6yFeJW3+mJyz7U=;
 b=W6+jH2GrZ51CYRTssV+9dsdV7C8KjjatC6N/Gc7OHuwIrUPMuEfXmmQUV/qNxgvdBdDuaxYtJCbqhf4jwrnv0+epjGqqzigBwJcImFwG6NYX+8WDJC1gURyD0/wB/pMpLaUiN/4AnpKTHTueaYegLUuPiZBx28bAc0Al6+/WpNa8qIfgJc60Ap+3gq3g0Sto4+gClvUfvEn2T24UtPBy8kfGZPX7t8K9BCkUu8ryR9iWHhpxM2d00cu8banOelFr1qR97iiRHxjl2jY/vImUyupUFyv+HAjqMKPrpk6QRnTqHNIR+oBfHlVCFqbY81LKMKpVE8gE8QjqXvF5IdX7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR11MB3905.namprd11.prod.outlook.com (2603:10b6:405:82::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 15:48:38 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:48:38 +0000
Message-ID: <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
Date:   Mon, 10 Jan 2022 16:48:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
CC:     Pavel Machek <pavel@denx.de>, <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34ad2fa-a957-4351-910c-08d9d450aaca
X-MS-TrafficTypeDiagnostic: BN6PR11MB3905:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB39050C71A987CD73EAF81678E3509@BN6PR11MB3905.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUY7LCd5ikD5BEHfC8xCNAyjJ6PHjZcB99wH9Ut3aoUt5SVhgquVYOvjsPSiSKMe6z1/2vyCmqJqvp5MzQYTDbelD443KOdSSqpRvM4EJwLEptlEEeAsa83XCMreocZPjTjD/NiSgCrZdiUG3nWi2/DGaiYYuUKcKaRTi+34HuslQNQ/4XYVUdBcFvfNzpWqOCtbXzIRadBgLZf0kw9ZStVF7ahIxtZyhvgyxobvADd9h0kRjIaPlgUAGc4zwB8RsS0jnUN+Y1gRzeqvWKXQ87690CgI1k1Lj5wKLMFeFJdDCqZXCyaJG3bhJ5RpCxBErwum1jIYkcyEv8HXzO2qZsn4lXpE3SnQ8vBj1YoBWK6Ol8Fs4xZ1lMd7RvFvagXibVTbyP4rLpYHir+o2hFBMgVIKXWRYVkR/TcOUoyEt3Vyc9LK2RUqeFDjzYgBJroPYsuJx+51ptfXrW88BSe6y4M49tQNOG/3s0aJnaNvyYxQMx7ggz40B5T0/HNnS6Ks7p85ejywto0XR81Ft+7T1SHj2Mmy93VW7Nwk5jiUEuuvqhM+ha+r9VTN0RLn1gm+WyDlQ48loG1rj76fvioz1wV4Ag45pxvhZYtyB/qTcVCc79fN/W+kCLTf/NebEKu7kM3Wov/1nwO1OdwXYEifp7aH0FRCCbYLqhzsiQNmyeKYcAGrBEnBrkjQw8FqtzwBipjxP6CkNbozpXzJqXbA+552byxwDJn3QC57wFTHTos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6666004)(82960400001)(4326008)(5660300002)(8676002)(66476007)(508600001)(8936002)(31696002)(6512007)(66556008)(86362001)(53546011)(83380400001)(44832011)(66946007)(316002)(2616005)(31686004)(2906002)(38100700002)(110136005)(36756003)(7416002)(6506007)(186003)(26005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGV6OGZVam1VVVZ2ZnZnSE5TcXl3dVMyNDFuZUt3alE3cTJ4RTJObnFwdXFt?=
 =?utf-8?B?RDYraDBORE9HQkQ0VGpQTE84Q1Ixa3d5cXhFbkk3TUoySERsMDlOelJ0UVd0?=
 =?utf-8?B?YVh4MysrUHJOOTRhUlRiSnV1YmN5ZHFqWk9tM2FXaUtPYmZGOXpYNXYxeXh3?=
 =?utf-8?B?U25KOGNWRzNUazNVcDl1QmRwajJmREFEelMxa3hOK0J0cVkwYnIvU2FUR3FY?=
 =?utf-8?B?ZUlPVERjZzVPTXVLYlJoWjVINHIrYjE0cTlHUjVjazU3alZHdit3VnA5c2I0?=
 =?utf-8?B?Q3lVd3lhWmlKcDc0QjN1a1lNbHpUbUlxOCtuVmxXL05WaXVRYmhUS0NWL0JH?=
 =?utf-8?B?T09wQjFVb1lyZjBrVGc0V2tSZDdoajNCN3ZYVThVRk9GZm9COGxuK0RXWUhx?=
 =?utf-8?B?dmZlNDFVNDRGSjRQelRjL1FMYTE2QUdqcWhwdW5acGN6dlh2NGszamhkZ29X?=
 =?utf-8?B?WGxUdUhIWlBIK3ovMGFrYm11VkNrc3RzRG5ROFQyYmhGa3A2aVVyNk5BY0s3?=
 =?utf-8?B?VlBrbmZaRnR4QXpTbm1YYjAzSXJMaWNCaGtMc3F0SHM5V015c09HNDB2dk5Z?=
 =?utf-8?B?Zy9CNFpyMWlyNFhBaldBQklKSzlmWEFJdm5sWVNNSWFhRzM0TlVFZjRPZkU3?=
 =?utf-8?B?SEV4eXpTcVlUQ3p2WkNidFpsbTVUdDExTTRZaG1zZ252M29JY1VRS1Z0QkpO?=
 =?utf-8?B?U3FlK3JvdjVVcStObnV3Rk10WXE5UWUyZTFucFpKT0l4Z3luYTV0dVJmY3g5?=
 =?utf-8?B?T3FUK3pEcnNCNVZhdUd1bEJPRzhhclRkOE9Ob3VySDU3bk05QmFCdktxNXFm?=
 =?utf-8?B?Qm0zZGZyWHd2ZFM4QlY3MUczQm1MV3lSWlJDZGpDZVVWSU01K2ZocGl0ZFV4?=
 =?utf-8?B?SjZmb253Zko5czRkbU1HSUZsSUw5bjN5ZFo1NGN4eWVkbmg2Y3hFYnJvM2tU?=
 =?utf-8?B?ZG56RmlMT0lKRkw4NVhPMjdIeTBSazAzdWVpR1FzOE5xTlE2MzBJNDBaVHpx?=
 =?utf-8?B?dzlLUld3WFlLTHpFRHcySTJ1ZFpXMFl1bHNSY0V0VUo0bzZ1aEFkTCtoU0c3?=
 =?utf-8?B?WmlwanhQVkJUZitmRVZaYjZFY1FFazB5dTNkZGVXNWNaMVh2eEZYTEMyMUR2?=
 =?utf-8?B?Q1Y1eTI3aHRtdUdFZ1ovcmpxelBKRlJJckNzTkpuZmhqWnRKSWQ3cWZUSXVB?=
 =?utf-8?B?WHJLU1czREE4d2Z0RWFJUDdzaUpQZDMvZE4xLzl6SzhlcUkrekpPSHRBQUsy?=
 =?utf-8?B?ZTd6aGcyOFpQcURBbDlWTi9iUlV5bk5VSTlIRXFtVEhNNXRoR2o1VVRiVHpE?=
 =?utf-8?B?UUVvN2FRalpWa01xd0MyRUdtRUs4N0VLT1h1OWVGeG12UXB3WHlYOGxYQjFC?=
 =?utf-8?B?d0hKU3I3N2VDWXBMN3U4dHlva1NNTWFZLzNOZXcyaGxBSTlBSVY2Yzl3T0pV?=
 =?utf-8?B?UFRBNjJneUhmbUtFL1NIZ0RWTzRtV3NudDd0ajA5ckJGeG1Ea1F2V0JOYlRM?=
 =?utf-8?B?blE3SE0zbC8zYnNNNnVtR0swR09IZVJIdzdNbi9EWW5qQ3R3eHdrMncvZmxu?=
 =?utf-8?B?dzBBczVRb1FDWm9PampkbGtCeXV6cUtML25jZkJUK2crY0oya3NLeGxQeEJE?=
 =?utf-8?B?YVVDZEtLL1VyUnJaY3FKSlNJTE9uRk1sdjZ3U3JFMy9tRjZ4QTFKdVNLeitS?=
 =?utf-8?B?YitRb2V4U0dvQWxDZFZKWTFEeWpob291dmxPa3BLZWtLYVFudmMrYlJxWm5v?=
 =?utf-8?B?TmhnK1Faby9BK1o5NE9NS3BpU2xDcWgzWllzVEt2aEFXcS81NGxwVEMzbDc2?=
 =?utf-8?B?S3NJWmhiWmVPZ28ydldhWGpOcTROb2VEZEtSYXgwa1YzaGJaUmozZW5rU0x0?=
 =?utf-8?B?U0pQUDYrd3oyREtxaUlzcnZjMU5qMjFFS1I0Q1JRMHB6ZENJTjZCUG44VUhS?=
 =?utf-8?B?bmdneFRMRDRQdW5DTGcvelY1NjJ3OW42a1o3TGZFdm9HS1VPc2NOSks2b2lG?=
 =?utf-8?B?alA0WUo4VjlkVFBxalE3dHZ4SW8wMzFjdk1rd1pnT1JEcFNHZ1NCeGRNV0U4?=
 =?utf-8?B?akhxZ0F5SUVPWUU3clliV1orYkhyck9nckpwOVpSYjJvYjlRQmNvNDJMQkVp?=
 =?utf-8?B?V2k3bTVvUzlDVEtoZk1XQmdCcCtHMkRXM2sxNE05V2R3dWZWVFpjQW9zK1Nx?=
 =?utf-8?B?SWhjT2hWZlhkVVRqaWtKcTlIVzVtSVRsMlBYenA2MnVLUVhycjBoQ3J0RTJv?=
 =?utf-8?B?MGwxc1RWT0pnY1VwQStIV1FSRHN3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ad2fa-a957-4351-910c-08d9d450aaca
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:48:37.9738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5JWlCMRbZVF++RXL1+Qk8FI3SOiHtJ0mwxnk9lEPNqZTKb6TcMUb5vYQb43fQNbkml4bgoNSNxsAGbQcRKjqvv0BkZmoxG4zfrgmFjoDj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3905
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-10 10:47 AM, Lad Prabhakar wrote:
> Instead of recursively calling rz_ssi_pio_recv() use a while loop
> to read the samples from RX fifo.

Recursion and loops are means for doing something repeatedly. Could you 
specify _why_ such change was made i.e. the conversion from one method 
into the other? I bet the code is not being changed for the sake of 
changing it, the reason is simply missing in the commit message.

Please note that refactoring below function into while-loop has a side 
effect: everything had to be indented by additional tab. Generally, 
readability increases if function is shaped 'linearly'.

> This also fixes an issue where the return value of rz_ssi_pio_recv()
> was ignored when called recursively.
> 
> Fixes: 03e786bd4341 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>   sound/soc/sh/rz-ssi.c | 68 ++++++++++++++++++++++---------------------
>   1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
> index fa0cc08f70ec..37466f65c2b0 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -411,54 +411,56 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
>   {
>   	struct snd_pcm_substream *substream = strm->substream;
>   	struct snd_pcm_runtime *runtime;
> +	bool done = false;
>   	u16 *buf;
>   	int fifo_samples;
>   	int frames_left;
> -	int samples = 0;
> +	int samples;
>   	int i;
>   
>   	if (!rz_ssi_stream_is_valid(ssi, strm))
>   		return -EINVAL;
>   
>   	runtime = substream->runtime;
> -	/* frames left in this period */
> -	frames_left = runtime->period_size - (strm->buffer_pos %
> -					      runtime->period_size);
> -	if (frames_left == 0)
> -		frames_left = runtime->period_size;
>   
> -	/* Samples in RX FIFO */
> -	fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
> -			SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> -
> -	/* Only read full frames at a time */
> -	while (frames_left && (fifo_samples >= runtime->channels)) {
> -		samples += runtime->channels;
> -		fifo_samples -= runtime->channels;
> -		frames_left--;
> -	}
> +	while (!done) {

I wonder if converting this into do-while isn't a better option. Maybe 
I'm missing something but 'done' flag seems to be changed only as an 
outcome of the last if-statement (last step) in this entire procedure. 
Perhaps condition from said if-statement could also be moved into 
'while' portion of do-while loop.

> +		/* frames left in this period */
> +		frames_left = runtime->period_size -
> +			      (strm->buffer_pos % runtime->period_size);
> +		if (!frames_left)
> +			frames_left = runtime->period_size;
> +
> +		/* Samples in RX FIFO */
> +		fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
> +				SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> +
> +		/* Only read full frames at a time */
> +		samples = 0;
> +		while (frames_left && (fifo_samples >= runtime->channels)) {
> +			samples += runtime->channels;
> +			fifo_samples -= runtime->channels;
> +			frames_left--;
> +		}
>   
> -	/* not enough samples yet */
> -	if (samples == 0)
> -		return 0;
> +		/* not enough samples yet */
> +		if (!samples)
> +			break;
>   
> -	/* calculate new buffer index */
> -	buf = (u16 *)(runtime->dma_area);
> -	buf += strm->buffer_pos * runtime->channels;
> +		/* calculate new buffer index */
> +		buf = (u16 *)(runtime->dma_area);

Is the second pair of brackets needed?

> +		buf += strm->buffer_pos * runtime->channels;
>   
> -	/* Note, only supports 16-bit samples */
> -	for (i = 0; i < samples; i++)
> -		*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
> +		/* Note, only supports 16-bit samples */
> +		for (i = 0; i < samples; i++)
> +			*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
>   
> -	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> -	rz_ssi_pointer_update(strm, samples / runtime->channels);
> +		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> +		rz_ssi_pointer_update(strm, samples / runtime->channels);
>   
> -	/*
> -	 * If we finished this period, but there are more samples in
> -	 * the RX FIFO, call this function again
> -	 */
> -	if (frames_left == 0 && fifo_samples >= runtime->channels)
> -		rz_ssi_pio_recv(ssi, strm);
> +		/* check if there are no more samples in the RX FIFO */
> +		if (!(!frames_left && fifo_samples >= runtime->channels))
> +			done = true;
> +	}
>   
>   	return 0;
>   }
> 
