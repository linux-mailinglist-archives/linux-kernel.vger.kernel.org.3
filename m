Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADB48ED68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiANPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:50:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:8851 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235921AbiANPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642175438; x=1673711438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iBZ4VuGQ3jFQuLVHtxp1zZilvnZ+cWhXxIV1NgGx+hg=;
  b=MYF8jbvY3Gv20ZK5fudCqLpOwKJbVQp76bgmGaEI7RX8/kop3kty8qLV
   fys4ynuLqk3tqR9Y3erglsniHKCXf7TuHJ/ClCZfMtwNJqswHHcD2E0k/
   0BC7TSYq5z2qICAk2M7Xenjd7EA7Jn2YxMfdOlpzwY7Zb9pxba0UOS0Mr
   fHAfe/ljbGpg/IyKmYMDbn6eB/09jMafH78s2iwo0+vKxSnY0nR2Ya22g
   dVQ6B4pIEVzseXD9Di0VQ34VAgJhNTaZewA8SP65WrLR1SqMsKXl5glj3
   cuekXnvh9yC9+CVoqMcRaRqfQhSbpxOmphiZ5N7ArO7N4eUCNGmd4A6Qj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="241830345"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="241830345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 07:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="491561984"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 07:50:37 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 07:50:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 07:50:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 07:50:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7V90bNexDBGncYFkEVMxf/vtUypr7J/VgreEj/t4O+39u9copDNMMxJWFdfkUuagXfsbqDTuB1OekRDeS4keMwG/YQzqYHpVucDUoycYLerBjTQma34iSfQRcwocftz2DcwE3uHETcI7C+5w3e8r1LrrGSEFcFgsWpNO9JX61H1SqtPAnjEOmqc9hz1lwTuMI6aTgkuQ3yuDVxR5PHSypepP7WWkfdBIS/ApwcTsCOkC9SwfsZxopMVcDPSu7QTYHqfd+be95x0Utpl4PoGG8HzeNKlnG18T4vfCWO6rTrD9hhPV7avFAjBrVKh8NIqzjTUIsn0yZuXN9N7XyVxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/vqYVZedfio8kjm0obhyNszx5rMWDZ9Iv7HEqsZtUA=;
 b=LOevNTK2srdlG84NKjwvdoo2wCaeCGDZObkFWwvndbmFdiNBexJubtJbFMtbpwWvRK9ZlbQamx7aA/9GZjcYN6NGPTNxiNyYG3JafD9FahwLh7cnhWaaHKwV3fyIr5/8VYId3R1irHi82Z0l04T9dW74A4X6FiqkdpTqnczlEt79FUbdexzb4UaABcwpsRyHXDLYV/lc1vw2hHz83uRpwF4tO6qwFBeTiGfvdFkKUlHrFV2Xe2GcpmWUnPYUxwQXdac2WaVJZ9GpFoj9wZ71OBHnQ9jR6+sMf/QQfKO3OnjMfAZWPWwH6XgZ045zcyKiZvRftrG+04TF3zZmhDhGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by SN6PR11MB3134.namprd11.prod.outlook.com (2603:10b6:805:d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 15:49:59 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:49:59 +0000
Message-ID: <d7e63f52-a98e-0c99-906b-6c03b25da572@intel.com>
Date:   Fri, 14 Jan 2022 16:49:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] ASoC: SOF: compr: Add compress ops implementation
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
References: <20220113161341.371345-1-daniel.baluta@oss.nxp.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220113161341.371345-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::19) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2753591-bc99-4aa2-685e-08d9d77584fb
X-MS-TrafficTypeDiagnostic: SN6PR11MB3134:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB31347753CFDCF03D22E5E437E3549@SN6PR11MB3134.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDdIeDvXPWpOS+X+coVlyabyNR8r7HTaRIkey5lrxp6hVOFmJCEe+O74rVybISFg5trGQDmT53R+gj8AOIMkHnGa6XesaTcaP49ztIXGR/6O9aJpwiO3mAfSQFEMwJo6N1NGBXZYBDrdASZxTLQq23uJBFNdC6Vi6WApz7zIM/C6ksurH6Q47ngAdIrgQ2MHs6nZOwwm+WvL8nB3XOaRgSOe4shK2/3tBCj4+KfHOAh/KH5Viwh3d1cawJxcdyqVwx10RhDYsyi18eJv1yKNqRmCHOOxSj3OZiNU6KErB7XUogFMXUAKHiXnuLgKhNFBw22F8s7Gslofa3eO8o+shbRLmA4FCBXWzpE+tFT46F49WwEX+ORs0g103tlDGBBOShV63X7R5zqf0V2psg8ko+Goki6PbFoA+oT/dHA4+p4Zr4udD8dWeHCgPMgSMQLlh6uQHJKYPEEujtbRIoHWcxCSQ0j7SLQIIrTwHGb3VO8dD/yw22NwuGbUY/9QU2JaS3p/qgOpSneJYNbx2OgpVDc1NyQI0obCqI1wqqvQOuTN8QyyS7doQDXW4DBgoKHPFMeVD5d1bvtF9Hzt5urI3nD32hj8Szis5xhjBvVz0bpOkne6CnwjI3CLUdQVMGSS1ljF/981QaOn04+1yb5CBfBT+EgFeiz6xyiJIL3SSr/UJTcifcFhPk6ZkEA/45HYsWzt476OLfwOVEDGNwzbPmBAv4ggeL6u9sJM2f7srx/pSmN3U77fmEaLnqEl/Uax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(31696002)(6666004)(83380400001)(86362001)(26005)(8676002)(7416002)(36756003)(53546011)(31686004)(5660300002)(8936002)(66946007)(186003)(6512007)(508600001)(316002)(66556008)(66476007)(44832011)(2616005)(2906002)(6506007)(82960400001)(38100700002)(6486002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdaOXZiY2swR01kR3hQKzRHek5zb0ZlSHh1K08zVjkvRHRVdURvODYzWmRB?=
 =?utf-8?B?Y3R1RmdnYVZ3aDlESE1hbHpIR0hxeFRqSC9hRnBETFVxQjVYVFA1QVR2dWRv?=
 =?utf-8?B?MVY0dVJQdzBvN1Bkam41eXMwMHFvMDlGSm80dTRYUXl5amU4d3lsZVpZVFlZ?=
 =?utf-8?B?enJubloxNmJMOW1NU3Y0VllPbSswamVxYVBxZ1FERWFhYnNNM0dsaCtNY0lN?=
 =?utf-8?B?UzEvUzFTby9aZ2xwTWFSSDYzTEJJR2dQR0pwSzE3ai9wcG9zNzhNT2l6OXkx?=
 =?utf-8?B?YjJEalFnT21CL3J1NjNoZy8rRHp2TlBOZ2hlYWhSM1ZGNForMlhwRHQ0ZE0w?=
 =?utf-8?B?ZzloQ09vS0FxR1JKQjAwUnk3UHVhc0lzWHFtWm1rR09UMFpDcXN3NU1tQ2JO?=
 =?utf-8?B?alhSRk81SW5XS2JHYXg1V0VDSWt2NzhNZSt2R1lCTngxQXdaL0lScUhVTXJV?=
 =?utf-8?B?OW1DRE5UWU13SElkbDJ2VDM3NUtWbjdsbGhzdE94dDZ2M0pwMTl0VWRsUzJx?=
 =?utf-8?B?Uk5NNWNMN1BrUmZGUG01dFBHVlRIYkZCcUR2Y3RleXVBL0NKNFBYd01LYWZy?=
 =?utf-8?B?VUNFbkNQRXZ4RW9lSzVmeCtQZ2lldkFwTCtMaDA2WDBuZEFrQTc0YS9mK3Bh?=
 =?utf-8?B?RnlyREtGaG53alRSWFFRNHB1akw3cklpSmxQKzg2V2NlZHhFRXRORFNhZTdK?=
 =?utf-8?B?MjRtY2dwSnlod0k5WXdXZzdRSmtGL3JnV3pWa0hEcHFVQ2pQY0t2a2IveDNE?=
 =?utf-8?B?ZnpGdFZ3R0xMa1ViWUltTklvYlY4VHVITUU1ZExRb2F5K25XbnlWSi8xbUp2?=
 =?utf-8?B?NFhyc1haVjczQndzSFUvRThZa0ZOeWxjTFFwTmdJYWVvQjY2Sko2bFR0eGta?=
 =?utf-8?B?WDB5VnlLQkhTQ3ZOT0dOclBPdkZrZjBmZkd0R0x0NjVRbDdkTUdGT1ZWSldv?=
 =?utf-8?B?c1RXUDYxeUhmM25HakV1Z0h1dHFFQis2Nyt0bEJqTW1pS09pRGo1MmhURi9D?=
 =?utf-8?B?Q2N1NWNSb010RUttNnZ4YVovK2EyNEVSNjZVelBZT2NVWXRxbDFHdGljYW9N?=
 =?utf-8?B?WTNHTmkwYzNnejNPWE9GUDRpOVRNVDNZditJLzZwWWgwbmNyUmx2YnJhMVpi?=
 =?utf-8?B?RkZJMnZjWkpaUVR2cURzbGwxREI1bGVLZ1AxaDZUbkVEbitXcDNKYnh0ZEYx?=
 =?utf-8?B?K29mV0ZxQ2NxSE1XSFd1Wnptd01aL29tQUVIOG9QQlk0MU1qMVBFT212L3lK?=
 =?utf-8?B?SXl2bnQwclY1M1hyWXVONlZxTis4NVNuVVBIdk44OW9ocHBsMGFDK3JSdEZt?=
 =?utf-8?B?ek1KajhFcUlTM0NUb3lNUHoyZDhQL0orSjdpQ3k2VFJZaXkwWVdYMHJGQ0Z5?=
 =?utf-8?B?T3ViVjY2d1cwSElxZ29aVjMvNXpPaEJRZGxIem9OT0Y4MWZrZ1E2U1U0VE9t?=
 =?utf-8?B?Ky90ZVVlaVUrRzhtQXE2Z2pLbHlUNDdvYWg4K2lxSVUxZk5jWUdOSk14SUVy?=
 =?utf-8?B?cHcwbUtPMXR5OTR0cHp6RnhMUVlxQkVGbzYvU0daZHpMTlI5aWk5bTN0OVhJ?=
 =?utf-8?B?alE5RVp6OW1RRFV3YlpkNnNVUmpOTFZoa1JXaFFWVm82VjFpWVNaaGVvMzNm?=
 =?utf-8?B?RFVHNm9wWC9HS2RCOVpQa2NQZy81cmV2SE9lRkVLa3hFMUJucHc5TkI4RDlJ?=
 =?utf-8?B?NzNzTHk3SUNRaE45Mkk2L210K0t1b2hlU2ZxR1dIOGRLN0p3bFBGd2w3a3U0?=
 =?utf-8?B?ZEdQZHpGNXFNc2ZKeTZLVmsvaDdMR3NCa3FiczhBeEhOVFRkVHlsc0tKNC9v?=
 =?utf-8?B?WGhZejY1eWNDMFlwVlh4eVBrOUlWS21SYU9FTGtYM2V6NWI0elF2NE5kNXE4?=
 =?utf-8?B?NEJFTVNnUm5PMjFZaFRlS1ZrVkl0OWRpbUJ5b2JiQmVQWXhqVnZTNzU5QmNJ?=
 =?utf-8?B?UzlvdEJHcXZnTkxQU3BiWnJ6RUp1QnM5YXVrQ211dlRjUHpPRFpBd2dHdlE4?=
 =?utf-8?B?RXhSNTZxcGh3a0dZZERRTFJBSlFxNlVtNFd6aU83TnpUMHlLWWMvUVovTmtY?=
 =?utf-8?B?YXRwaFVUaWRWUiswMmh2V01oM1hzSVBHellqdWpOckovZkdmNTZCaDBMUmxs?=
 =?utf-8?B?MXBjZm9YdDZqQ3NjTENHREdWNWlyZEh6TVl3ZlhuRDNWZWFscWlvVHRKd0c2?=
 =?utf-8?B?WnUvcFRwZnp4amUxQjRXcUx6RWF2eXJmZGJPUmxERTZWb3NCTWVYN0JhMHAw?=
 =?utf-8?B?QkJaaVQrWVBNY3B2YXFTSFBsbDZBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2753591-bc99-4aa2-685e-08d9d77584fb
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:49:59.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xbY0DN1VmeUyWtOkUyGK9LSKQdsVd733jLf46fc6lxTr0Iepf4FsBCbARmlIt3COu7r7Fa4/H3iPkgdWD0VXNUGEeeqvaByrFatG+sQLGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3134
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-13 5:13 PM, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Implement snd_compress_ops. There are a lot of similarities with
> PCM implementation.
> 
> For now we use sof_ipc_pcm_params to transfer compress parameters to SOF
> firmware.
> 
> This will be changed in the future once we either add new compress
> parameters to SOF or enhance existing sof_ipc_pcm_params structure
> to support all native compress params.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

...

> +static int create_page_table(struct snd_soc_component *component,
> +			     struct snd_compr_stream *cstream,
> +			     unsigned char *dma_area, size_t size)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_dma_buffer *dmab = cstream->runtime->dma_buffer_p;
> +	int dir = cstream->direction;
> +	struct snd_sof_pcm *spcm;

The layout of this declaration block is weird - it's neither a 
reversed-christmas-tree nor higher->lower complexity (e.g. structs -> 
primitives). Could you explain why it is shaped as is?

> +
> +	spcm = snd_sof_find_spcm_dai(component, rtd);
> +	if (!spcm)
> +		return -EINVAL;
> +
> +	return snd_sof_create_page_table(component->dev, dmab,
> +					 spcm->stream[dir].page_table.area, size);
> +}
> +
> +int sof_compr_open(struct snd_soc_component *component,
> +		   struct snd_compr_stream *cstream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_compr_runtime *runtime = cstream->runtime;

Making use of 'rtd' and 'runtime' simultaneously within a function make 
it less readable.

> +	struct sof_compr_stream *sstream;
> +	struct snd_sof_pcm *spcm;
> +	int dir;
> +
> +	sstream = kzalloc(sizeof(*sstream), GFP_KERNEL);
> +	if (!sstream)
> +		return -ENOMEM;
> +
> +	spcm = snd_sof_find_spcm_dai(component, rtd);
> +	if (!spcm) {
> +		kfree(sstream);
> +		return -EINVAL;
> +	}
> +
> +	dir = cstream->direction;
> +
> +	if (spcm->stream[dir].cstream) {
> +		kfree(sstream);
> +		return -EBUSY;
> +	}

Could you explain why this check is needed? i.e. Is is possible for 
compress stream to be opened "twice"?

> +
> +	spcm->stream[dir].cstream = cstream;
> +	spcm->stream[dir].posn.host_posn = 0;
> +	spcm->stream[dir].posn.dai_posn = 0;
> +	spcm->prepared[dir] = false;
> +
> +	runtime->private_data = sstream;
> +
> +	return 0;
> +}
> +
> +int sof_compr_free(struct snd_soc_component *component,
> +		   struct snd_compr_stream *cstream)
> +{
> +	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_compr_runtime *runtime = cstream->runtime;

Ditto.

> +	struct sof_compr_stream *sstream = runtime->private_data;
> +	struct sof_ipc_stream stream;
> +	struct sof_ipc_reply reply;
> +	struct snd_sof_pcm *spcm;
> +	int ret = 0;
> +
> +	spcm = snd_sof_find_spcm_dai(component, rtd);
> +	if (!spcm)
> +		return -EINVAL;
> +
> +	stream.hdr.size = sizeof(stream);
> +	stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
> +	stream.comp_id = spcm->stream[cstream->direction].comp_id;
> +
> +	if (spcm->prepared[cstream->direction]) {
> +		ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
> +					 &stream, sizeof(stream),
> +					 &reply, sizeof(reply));
> +		if (!ret)
> +			spcm->prepared[cstream->direction] = false;

Why is the assignment conditional? If IPC fails, is the ->prepared flag 
respected and addressed later on? It does not seem to happen here.

> +	}
> +
> +	cancel_work_sync(&spcm->stream[cstream->direction].period_elapsed_work);
> +	spcm->stream[cstream->direction].cstream = NULL;
> +	kfree(sstream);
> +
> +	return ret;
> +}
> +
> +int sof_compr_set_params(struct snd_soc_component *component,
> +			 struct snd_compr_stream *cstream, struct snd_compr_params *params)
> +{
> +	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> +	struct snd_soc_pcm_runtime *rtd_pcm = cstream->private_data;
> +	struct snd_compr_runtime *rtd = cstream->runtime;
> +	struct sof_compr_stream *sstream = rtd->private_data;
> +	struct sof_ipc_pcm_params_reply ipc_params_reply;
> +	struct sof_ipc_pcm_params pcm;
> +	struct snd_sof_pcm *spcm;
> +	int ret;
> +
> +	spcm = snd_sof_find_spcm_dai(component, rtd_pcm);
> +	if (!spcm)
> +		return -EINVAL;
> +
> +	cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
> +	cstream->dma_buffer.dev.dev = sdev->dev;
> +	ret = snd_compr_malloc_pages(cstream, rtd->buffer_size);
> +	if (ret < 0)
> +		return ret;
> +
> +	create_page_table(component, cstream, rtd->dma_area, rtd->dma_bytes);

Shouldn't the result of create_page_table() be tested before moving on?


...

> +int sof_compr_trigger(struct snd_soc_component *component,
> +		      struct snd_compr_stream *cstream, int cmd)
> +{
> +	struct sof_ipc_stream stream;
> +	struct sof_ipc_reply reply;
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> +	struct snd_sof_pcm *spcm;

Similarly to create_page_table() case, layout of this declaration block 
is weird. Perhaps I'm just unaware of the convention used within this 
directory.


...

> +static int sof_compr_pointer(struct snd_soc_component *component,
> +			     struct snd_compr_stream *cstream,
> +			     struct snd_compr_tstamp *tstamp)
> +{
> +	struct snd_compr_runtime *runtime = cstream->runtime;
> +	struct sof_compr_stream *sstream = runtime->private_data;

I'd suggest declaring single local variable instead. The 'runtime' one 
is unused except for the initial 'sstream' assignemnt.

> +
> +	tstamp->sampling_rate = sstream->sample_rate;
> +	tstamp->copied_total = sstream->copied_total;
> +
> +	return 0;
> +}

...

> diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
> index 087935192ce8..d001a762a866 100644
> --- a/sound/soc/sof/sof-priv.h
> +++ b/sound/soc/sof/sof-priv.h
> @@ -108,6 +108,12 @@ enum sof_debugfs_access_type {
>   	SOF_DEBUGFS_ACCESS_D0_ONLY,
>   };
>   
> +struct sof_compr_stream {
> +	unsigned int copied_total;
> +	unsigned int sample_rate;
> +	size_t posn_offset;
> +};

Some streaming-related PCM structs follow snd_sof_xxx naming pattern 
instead, e.g.: snd_sof_pcm. Is the naming convention for compress 
streams seen here intentional?

> +
>   struct snd_sof_dev;
>   struct snd_sof_ipc_msg;
>   struct snd_sof_ipc;
> 
