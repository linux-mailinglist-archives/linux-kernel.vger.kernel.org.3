Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C964787FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhLQJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:42:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:30066 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234263AbhLQJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639734176; x=1671270176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3jszeg3gzYYY9qBXB9hvF/Eplid54rNMHmAN3jRFAwQ=;
  b=gSbOa3g8QuuARW/Y0DYl+2HyG7atSykiGY+W/BTc9XpYAiQGBQCUue7m
   RsRAKbVa7c4HNZB6Ega+XbepcBIFLag1uWcPDV4pMbckkAorQUt2kOtFJ
   ZQDo9W+ZHtrCDVGxdTqYkd3rIYJk1crIktpoXFpdqfxOFP4FKFQvxmyEC
   W5G8ujHWmXrNHeaCytk2SZmGCTcjL5tVAJYaBjBCyePzcruR2378vL//M
   rrIwmeZTY3rEaGEt8n54kX1eqOMLw396/S4jsUHqhZulT8ko6S6KrGYq0
   9ycCZb0x8Dh5iZXXBi3AYFqOSJpM/WJnD4VizGWUbhEteEdu8/i/HrXjE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="227008066"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="227008066"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 01:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="483172313"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2021 01:42:55 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 01:42:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 01:42:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 01:42:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESCS1by1X5cX2TIHUR6IY7fSgh1h4KKaX4KtkXPlXpkawA6PZFQCR/V7lDF+EBFFO919LJTDaatVQ7DrSW5NQZFOYwVvzmx1n1Am0Agij3G8LTYJOA7+ivgpco2aZFoD9Q5mIzRhlDDO64OZ2nqThZn3KvF7CqrB6sh8Ps1pogssRp9pGItTR7qIrTv0NTk7rukzevy34KlnKLD15yU+t38CRntNG1VzcQb9+B93QVVIH1NyQ6XAfbhMFLcVUgl6EQ9zuIoNdpaOadQwEHe4UePOaTeMY53y4Eo/b296WwpjbqnOpcavxquB+ZWrDgVTe/Q42brLK7SnJElAZW6Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbnJKK9o36KKpAoInVmErCDAZRHMgyJhkZ8xmAbaLi8=;
 b=M9CmYc91MHi3rkeY/uQA765FqxtZczmNc+TXHrZCaQl/MGzEpdNO8bkK9VmRrsIWsPBXGpT1WahO53U9T0UWVVcryrWIwcBGe5NrMVyZWjL4DhcVmEWvXmkvfkMrPP3HD3zwEVqR1R3bQuWl2iKk7x2cffd8NDRLMmcNeLTe4jbzdqY8LxB4pPdrCUt8+fGLhYPuh8Sge8Nd68xHkjGavK3Y/0b55d1g51vqHjq383nfwDIA/rBY6mmcWYbX8EtzHSAA0B+BOdmMNyq/l1al0SeiTCdtoDh1i3LKNGRQfhNFXrKKaNsjkBeqX+zpOcOZuMsc7EwK2+uV/coyxG8aCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR11MB4036.namprd11.prod.outlook.com (2603:10b6:405:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 09:42:53 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 09:42:53 +0000
Message-ID: <f2ef853b-7ff3-4fd7-989f-032fec66945d@intel.com>
Date:   Fri, 17 Dec 2021 10:42:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] ASoC: wm8962: potential use of error pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <shengjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20211217031333.493777-1-jiasheng@iscas.ac.cn>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20211217031333.493777-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::16) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23194668-78bf-414d-f086-08d9c14198e3
X-MS-TrafficTypeDiagnostic: BN6PR11MB4036:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB403621ADE523EE835A896DAFE3789@BN6PR11MB4036.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwrTyF4FlNh0zV4aRYxOsPvXEfet1EF8qMes9P0J0VDDwjNF5nst36HSK3ygnbv71bSW6jXsObUuGJp6tsec5A4LN4FOw+FvuQwtQ0en2g4nJl6u8v48TWlen+GD1SdoV8CfXlXHCDEl9ygG3JZSn/ptgYhWLaCT1xmZQUXH8mY6jcKfaRrAeCPnDkU2S0j32PnltMIJ6fsCKQzrh0GZp2oVicVW7qwU64ZDTT56nUwS+GlJ8kF0abcL4285ARpw/NG7ujFMkxKXRUfDrANva8nihSdCxFwPfzW9kGIbfXMrVmFnItrF/5BK5LYnATDsMMLplZrmeWLNFbaO0ghYdrEobgPgINRDVjhDa7bVH2/IRYMtf5GVuZU5H1ihF2lS2pTgATfWV/SYSiLPUsgv0X6omlyL5m5P6y3VdAbwbEG9V0sD6UXlakjG0gexamplcvwRYroDAGa7iNiv4OBEi2aHTK6vzcdieq1LYcCPHlbw58rUNoF7b8xqu2i/hY4KDxGpbSK9u3Dl4Km4qZ/asU+j43QBrzF5Q/UtH8oZlgHJIq46YPKeyenq9KSfmh+4BSNnlXYL3FfqTkQOniicgLkSdiwtlhQbx6BqPmp7P+DWEfMw+WvIPQG56/djM9p6vIvIiXWUsWMCX5eKVpJ8VuwQbho+iPLzKwidevmB4Wogc32rcURliY69V2M/x4ubNvqWsCewbXkZO+he8YeqVpbp9KiNL1xGQiZks7Szqcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(36756003)(6666004)(186003)(26005)(31686004)(53546011)(4744005)(4326008)(31696002)(5660300002)(83380400001)(6506007)(2616005)(86362001)(508600001)(8936002)(4001150100001)(66946007)(66476007)(66556008)(6512007)(6486002)(38100700002)(316002)(82960400001)(7416002)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNTdnJ3MmlHQTZTQmMyaHhOR3pRZzkwcC84bHpDZVR3dE0zelhSbTNJZ0FJ?=
 =?utf-8?B?ZUhNMkpFZGk5YytuWUd1Y1RLWEdpWDBtSlVCQy9DTWlZbnFhc1ZVRVZtQXpk?=
 =?utf-8?B?ZFZOeEVha3FQeXAxTG5KcUxwUnE3UGxVRkxaRE5kUFF5NldyRUcydnNOZWFp?=
 =?utf-8?B?NzNEb09rWnhBVnJxbWZSQk1jRTh1Zko0aFplU3hNSk45dE9vTGN1a3NkUkRL?=
 =?utf-8?B?NURiUFhLWThBUUlEWXBIQktaWU5XbVNtVEx3YzYxTWllSFJhTTFSSXFFdFBq?=
 =?utf-8?B?UGkzNVBDbG93b0ZPTTF2dmo3MmtVZ2JBRUgxaSsyRDNQNDMxdkF5djR3NFNT?=
 =?utf-8?B?bm54MEdyQ2Z4MVhsazNUcGVqQldMc1haMVRUUHRFVzFYK0k0dmFyaGtiaUli?=
 =?utf-8?B?aTNMWUpJTlptUTJDaFlsTmZXTjByeTE0c3dyQitvVHM4bTVZeUdiZmUzTVJO?=
 =?utf-8?B?UnpRT0QwbU5UeGlBWFE1Zk9iS1oreU8waHZNK05UaE50WVIzQTJvTE9xMXNL?=
 =?utf-8?B?UFhNSmdXMENYT2JadmVob3c2TEllRzBYZFN3SEV5MEpFVXZQeXgvMjBpVTNW?=
 =?utf-8?B?LzJEc0drTHVEVFVEUldTUkNWRDZpOUw2bE5qVGhpL04vVE1DMzBNUGVHWXpS?=
 =?utf-8?B?Z2VUcHFSbWlWSTJSSndKSWVyTVJmallJSDRZeElvVFpuT1FVdGx5emROOVpR?=
 =?utf-8?B?VGt6bGZiYjhDOXlqMkxKdkVJN2RFaTJHZ0FOMk1ZZExPTmo5UUlKZXUySldY?=
 =?utf-8?B?ZHRPRjhOMzBQN3VPOG9DOXJva3JMR3NjbU5reVN4U25PME5jQnp5MXkzOTRp?=
 =?utf-8?B?OUU3RUQ2SzBweS9qN1ZTY09WdzRyL0cvQUl1YW1pcS8rS1hTdEprc1V5cENn?=
 =?utf-8?B?NjlkbzI2cEV4TU84SXlCbTdTN0o3Q2o1ZGUvVHQzSzZIbS9kbGhJQ3ZTVlh3?=
 =?utf-8?B?OC9rbzNMQURXN2JWNmV1V2pIQ254UTl6QnBiTy81dW9xZzA0N3QrVmhxZExm?=
 =?utf-8?B?c3AzbWR3NmhQR0llV0VtUkNnbkIzK2FuRU5kZW96L2R5T0JucE9FRHNyeEJK?=
 =?utf-8?B?Ty93emRzV0pUbFNtb0FRK3l6alQ1TTkremRaNDk0UHB6TnBaSVR3cE9xMXVt?=
 =?utf-8?B?TTZCSVJ6WTVkZ2JyczhkY2VtUWh6RkxqUGtkL3RJM0RRWEZvQ2xZZXRxUGZV?=
 =?utf-8?B?MW5IOExYUEdZSHNLcFloTUZGdlZBNjJqUGNYWVZRRlR2c0IvMzhuTWFZaSty?=
 =?utf-8?B?a2VuUjl3MnRTTXk1bEV2TDhldmJhbTMrenRUYk9GVDVGTm5rQVJ0NW56K3I5?=
 =?utf-8?B?Z2dESXFYMjBqSWFQc2UxNThqbFZkQlRTbFdPN25BYXBHMWY1RmJ1bXRuU0xo?=
 =?utf-8?B?bmtZRXQ1ZjZYWG1HRHZxZ2hWS1VDeGh2TDFQOVdNVnBtMWJ6NzNBUFVEUEtq?=
 =?utf-8?B?Ym1sWk5hY2dpYll2cEtBT3JRY0dpZ2xsejBoVjhrY3ZST2x6Sm4zSGNmeG93?=
 =?utf-8?B?cndFdS9sYnFadmpHSUVvVFhtV0NEVUdOVGhCR2szSkZYYXNDMUN6d2lVS3lx?=
 =?utf-8?B?V2lLYk85RDJIcWl4a0xHcmFtRnFTQjRoOHFMZTlUbnl1RjRwRDlHTS9vOWkw?=
 =?utf-8?B?eGtja05WZXRMS1pFak1YYUVrZGR1NmdRMGM4dzVZLzMyRWxiWWpxUXdOTnJl?=
 =?utf-8?B?cFg3R2dBaGl6VU1SbklubkMxQ204dzNVbTQ4RkNmUnR3eWlCaUVWV2xVOXdo?=
 =?utf-8?B?R2diUmdlK0dEVElMOHVESEVyVFVJQzdsQS9JNmM0NEROZUZVRGU3US95djZm?=
 =?utf-8?B?OWJVY0xtZEdrYndlcmREM3pzUWlqZm1LOXR1WVFvaFB4bldjOTlQRStHUmEr?=
 =?utf-8?B?c0t4dzZNQ09zNDBIMGgyRHFQVjdIakxOeDB1NWM1bGNtQVBDYXE4UjJuYno3?=
 =?utf-8?B?MEE3S1ZtNWkrOHRkOHR2L1lXM0lpRDJiWnpoaDhHdFJnS0RMRE9OakN4MVda?=
 =?utf-8?B?UlNUSS9VVkpLZDJJNXZrTXR1NTF0L2JVYlFnb2F2cEgwTGJLaWNyRmVtNHJ1?=
 =?utf-8?B?MEpBRFhMemxQWjlVZkdJQ3c4ZnQwT3k2NURuMFVwM3RwYVJ2ZkdZaVVNTWxp?=
 =?utf-8?B?K0VQeFFNczA2SnorWXhndU1jUCtoMTlLSzM5Mk5PTlVZNmJ0V1pTSzZiM1do?=
 =?utf-8?B?b2NJMFNablBCbUdFZ1BqcjhPd29HaEpucTcxUmNPOXNzVzNiSjM2Q3p1bStp?=
 =?utf-8?Q?TC3x3d1SySchV7tagAOzjkj3SWseoKxVZ4daCzUmLk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23194668-78bf-414d-f086-08d9c14198e3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 09:42:53.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcR+9Oe1+byLlpi2+cQPgxTxdeKw3LatIJTOvfCjDwkRxmbxG2IxZRH46XTOjkX+fIEU0iirTDiKlY4IjywyeCX+nC0zph/7waQZX+MT6Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4036
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-17 4:13 AM, Jiasheng Jiang wrote:
> The return value of devm_clk_get() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.
> 
> Fixes: d74e9e7090ae ("ASoC: wm8962: Add device tree binding")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   sound/soc/codecs/wm8962.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 34080f497584..66693bf17763 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3540,6 +3540,8 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
>   		}
>   
>   	pdata->mclk = devm_clk_get(&i2c->dev, NULL);
> +	if (IS_ERR(pdata->mclk))
> +		return -ENOMEM;
>   
>   	return 0;
>   }
> 

Correct me if I'm wrong, but -ENOMEM is not the only error code that 
could get returned by clk_get() (which is internally called by 
devm_clk_get()). Is there a specific reason for ignoring the return value?


Regards,
Czarek
