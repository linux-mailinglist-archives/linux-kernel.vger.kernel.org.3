Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D027489DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiAJQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:51:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:20484 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237774AbiAJQv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641833488; x=1673369488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XLDnk94WsW1X27aiQvjvR3PwIIumJAN7Rer7RG8OAzI=;
  b=jmDa/3BeC+ii9TmI+RzsuPDCQ1D30Hv6v9nrp55qYfazOcwPYoMFr8/Q
   p25pWHhJh1iLMBvmt+I1Xe5QWMwoRsf/eC2H774C7dDpT6tuacHWL/8o8
   t5d/pBXVTFJ60naquGh70kOek64Aic7W0Xxz5J4cSUUvYKGyVH5PIZSA2
   sgqV/l9fyODwle+2aJ3TLT3Ihw/J7ajIP3WNrkVtKYkxslyxYpTAUcVPp
   ksaOW9vwCfT6VFVphAbMvmjrXBT0YN4IAGEuNUDMMdOCPV4wFiHvlmiKw
   3ZdA6G6RheRHzhFFn6m/tQTLTkTdK9iGEIIkUD4Zsm7a6OQoXCmP+EPvd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="329609231"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="329609231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 08:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="622733389"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 08:51:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 08:51:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 10 Jan 2022 08:51:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 10 Jan 2022 08:51:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBzWKwm72J8gad3hAIllMxY4kjt1ExzdcDXv1opt2+8OtNhXNHzuiLsW4xY1taU3jWX2ai1vsw1yRIk6EZFmOn1KCwG1lxZoelTT1xm6e8YiVrA2vAG/n7656jU0ZXC+5UZV/dcy+vlcYXxGKrH1VG8veuAWFIsglcXSBi4M0uW3VsUNhq3BvB/floVzbbzB9RpxV4wn4IhgavtWZcbfQkOvXehkjrPfZWQ9ULHKo2y/GZJqFy72Ti4YadpaFALAj1UVgYpPu8DOVEYgKsJNlwIIuLEDZ2j96LSWCVgKh3iSbPmwnxkifz670gqcJKxF6de4E6RV7ycUHwoWkALUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4woVmz1EFdRYQWs3xJrr29SkL1xULksB5eZNwH9PBZ4=;
 b=jHuLyOWAcdCECX7Lu3KGkg7A/PhJY8d3b1QMei9DT+6mAwSbqCxdhJMV6GLyfUlVv1RqoD2XCDFRIL4vbLWWbOqAdeZkxa+oxjrYAqRlQ7VMtgaL67Hwic8B2QezaEbdjz47iXc8IAPhwiE5jIh5E1BpZ8rNg7tqPSZlS8zNowIk8khYZzGwm+F7KKR+4wb9uvBISvuvWvUE0IAH5kZB1fhmQT4A1TTnWubsKXEg688ifLMcKfHJwN7U9X1mI9j6YdmF/ivyYVFcfT6kiDYuIIDp2BbtKtsiEFQMr6rVcEmidNM8Ccsk7hUj7Hb8Snh0EcDC6CaQE8U6xAnWkllT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR11MB4035.namprd11.prod.outlook.com (2603:10b6:405:7a::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 16:51:24 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 16:51:24 +0000
Message-ID: <516d939c-1c2b-315d-28d3-d55c6c4b6eb3@intel.com>
Date:   Mon, 10 Jan 2022 17:51:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: Check for error pointer
 after calling devm_regmap_init_mmio
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@codeaurora.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <20220110064259.4175705-1-jiasheng@iscas.ac.cn>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220110064259.4175705-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::19) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52af352-c8a0-4887-74fe-08d9d4596fae
X-MS-TrafficTypeDiagnostic: BN6PR11MB4035:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB4035D3197B18B6A7667C7213E3509@BN6PR11MB4035.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lF5Zb1p3Ld1bw3RqmYQUjQkwFPfWsiCnhpoEcs2CFYruIWin6aHaUvnNO6viv320AIN6QTli+6oDi9TgRqkTHzx97k9d3CntwrTFJdJ2bvRBIMeub8fGqh2v85AD1+TMahd4uXsn+lEty16cGk0QDOTsbHDSceep61pyF1yasqOxB2tAQb+8H6YSZQRD5uUc8eVuGuzYRBvRP7ZzgkqNASQU0qHf2Lcldz5uqYHE/VmqKh4u1TGw6EZgsYW9/TyqAV5nDCZsH8lnshxr/ofrenVM55r58mO3KHWXC5wLbG7ClHPqSdnZqfT6Ck9s+TyWV0FKd6Rd4NHcXYUeRGsAoSKEy0H/zVn7N5tYwPQBv5/NMSYRAipKWuyr+pkvnV/fnssY8Fhs7Ap/PqcigEq9Dn3rw27S7SKnVzdCOPUBNbH0T6TEtNWbNbb0XyPEZCjAahmr2UsWfTR3sATp9C3QgZo+bKEK16frTMF09/F/37dAyVPuC5vxjply6sTnkpSgH7gFbwwAC95cXyuOvWJAHorClz6pKZMgF4Zp9LUkG7NnR0YVyvdkaGkXEwJsDxVsoCcj3Jc1uZMur7WEhwhWE3VrVjXwIEa5xh8Ct8DNgBZaz1dueIR4whp5IymM5QCPB46OWIMFGvSRCQuP1bAyBeHIMM+q5JDpuuq/8O+1oN3I6xZRKQRbUMLwO2eksu1cwQxASQSNLNNKsXBUjdTB9VDC+vtO98oLaaJcVaJO9bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(6506007)(53546011)(44832011)(2616005)(6486002)(186003)(8936002)(31696002)(66476007)(66946007)(2906002)(26005)(316002)(4326008)(66556008)(5660300002)(31686004)(36756003)(86362001)(82960400001)(83380400001)(6666004)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29ZMENDTElkNXdweUU3SlBaQTJLNkc2NFROdC90eHRvZ0tlRmlSM21XMExR?=
 =?utf-8?B?S04xRVdHSkR5eTF3bEFCdDN3TXZ2ZEVKTnI0NmdwV1Z4dWJETVRkS0RjbjQ1?=
 =?utf-8?B?RDU5R1pIT3RRNU5hYmRzVThJMXFiYVRvRHo5WTN2alBOOS9iV0FWQVdWb25Y?=
 =?utf-8?B?TXVqTVpJVWQxNFZUMGtwYnJKbVU0NXJPMHU0UXRlaWI4Y0VOVVpNTFlwbzdY?=
 =?utf-8?B?L1BSZ3diREcvOHg1RnB6Z1dBMUs2L0JyUHNQWWhvQ3VEZm1qa29qMDZIYzFz?=
 =?utf-8?B?MUZEa1FEejZHbi9iT0NTZDJLazdJTGIrcTNFanZ3WnFoVmNCeDBiTlNyRXJa?=
 =?utf-8?B?TzNuN1lnWm9xZCtLOUJWTmdIZ0pzMFFoc3JWd2ZQcmhHR0VpM3ZmUENJSTRF?=
 =?utf-8?B?NWZMR2toTDlOME9oM3dWd2hRNVhabXRiUkdCQTNrbjI2T0JiQVJDZTNPV1E1?=
 =?utf-8?B?MS9mT2lObmVwNWZqejc4TFFORHVSTnMvMkNubGtPaHgwd2ExWEZKdlptR080?=
 =?utf-8?B?bUw0cXgvMTBocjZOZnExdkxJcUVrRXdkVldvU2IxVmZQSStWSU5zakxRaWRa?=
 =?utf-8?B?QndsMXpDYURVYUVHTkJJdVgycEFpZktiakRJT1hWLzc3V0NXVlZmN3JyQVhY?=
 =?utf-8?B?MG9oMmZxZmpQUStQYUxTUnVBNlhOU2tpRmk3L1pPUktsTS9yQ0c4NFdFZys3?=
 =?utf-8?B?MXlURHZoUTlMNUhiTE54ellxZXlDSDJCaGRvVEFscnlvQ0FRaWpiUnQ2LzVv?=
 =?utf-8?B?Unc5YmJpOHp0OFZHSHVFV0FWcm9ZWThvdy9rR1Jja1IvdWRyQTMzb2pYUzlH?=
 =?utf-8?B?K1NGV2dZYnVEYmFVcGZRVUh5STI2NG5JT05iZHlhOGtXVDBweS9XeWxaRE1v?=
 =?utf-8?B?NkNCdTJ6QXRldVU5RFlEUFg0OGtLSnYxdHdUVHdoZi9kYzBaWDJRYXpPY2lx?=
 =?utf-8?B?Vy9HcVRGZVZ5Z0JUWTFkQmtPd1NLUVVUMUwydDZEdU1ZV1VlVmdDUCtxWFhS?=
 =?utf-8?B?d29CRnhTN2s5aGlvTG8yYW14MGRUZnFORmFFaFZyMmFxeFoxNytDTjB5TlZv?=
 =?utf-8?B?Mk40Nmk0SWVpV2dZejBQcng2VTVTbnp3UWQwU05GZ2E2b3NWNU5MRitzaHk1?=
 =?utf-8?B?S3gwdlJURTdEazQwa2ZnOFhzSFY2YkVDUys3YS9MWmlZSGN5VzZQdGZBMURV?=
 =?utf-8?B?ZGFadTQvQjdCZ0NMMVlReFpoREEwcEl2WmhWQzB0b1ZyOWRuak9UK2ljTG1H?=
 =?utf-8?B?cmJteEVXVHJKeWxFVlNLTURoaHREYWJoVlRpVE9BRUprRHVMK1J5R1VwSEkr?=
 =?utf-8?B?OXd2U0VTMHM3TW8zUU5LcUkxRkFJMTJrYWY5UnlUTTdRUWUvNHpacXR3RndP?=
 =?utf-8?B?T1JuYWZsV1ludTNOeVI5Ym55VUZsaXR4dVdzWGJpdkJ5Um9vOWM1OW1CWFpV?=
 =?utf-8?B?eVExYmhqb0NlSFhtSVFjbEtXV29lYjkwMHhYejBySG5OSVhRMWtZbXIvcGtC?=
 =?utf-8?B?bGFxZXQ4SmV6dUJQaitmZFhJOTlJVEtZdVo1enppeWRybW9rRmF4QWhxbU03?=
 =?utf-8?B?UUNYRUN3eVNIRWtsVE8yYVdGQ0ZqTnB0VzNVVUJ0NUZRTlE1SUkzV3pLUjBy?=
 =?utf-8?B?dWFTbE5rY3hwUTJkWmtTeXhTTVArQTkxUXpHZElBb2pvUWNCTHVHeFVxUGYx?=
 =?utf-8?B?MTlDc3NvMDV6ZWtLYVd2aFBzbTZ6UjA5c3BOSGxvVzBkQWlyTUFVMlhjUE5N?=
 =?utf-8?B?cUw1TFlscmFzcDNvVS80Nk1LSGJtRFRGejZJaitDTHg4ODFpZm5va2hOU2Nv?=
 =?utf-8?B?dmZDVlljWjJoQkRLSUpENzErdnUrWHM1aWVyRUdwQ1EzSUJROFBQQXc0V1VL?=
 =?utf-8?B?VWpKWXVabmdIK3lRVEZtZUdCc093enNUemg2Mi9vY3QvKytGdlA0M0JFVEZK?=
 =?utf-8?B?SUcvRjdwQTJZUHVRT20wU1BaZUZZUVdIQ0VLdWZ0TDR5TlBsYnpoRW1NbnVI?=
 =?utf-8?B?eklXWXp1U2pHMlg5ejdhd1cyNTdqbmMxelZpNGhjdW5aVEI0K0d5bnozRlRl?=
 =?utf-8?B?UnpVckg1cDJPV0dnTkJYaGJUMGlSdlZSZUJQLzdFd3AzRHJPS3pobFcra0JM?=
 =?utf-8?B?UEdVbC94YTh1WXEyR0lQUE8ra2tuaGRMc3VtNWpobGVXMmxLY3ZPMFMrNit1?=
 =?utf-8?B?dk0yaHRyRmdXck9RSFFLUmczNERrbGl5MXZKTlhGMVVUTjQ2eUk3RkJxZkVT?=
 =?utf-8?B?OXk4NGF1WERVRERXSjl4MjlvZGxRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c52af352-c8a0-4887-74fe-08d9d4596fae
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:51:24.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Er2ZrPrM/RnP4ZR8BwKE2NKpOWqr1xAHLBDRt6fYcKuQCY6JYfBcwpwxLH382EwEl9FfnLzxrzoFn2EwAgz0ikor6eVhp2jhEiQQruBQrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4035
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-10 7:42 AM, Jiasheng Jiang wrote:
> The devm_regmap_init_mmio() may return error pointer in some cases, for
> example the possible failure of the kzalloc() in
> regmap_mmio_gen_context().
> Then the wsa->regmap will be error pointer and be used in
> wsa_macro_mclk_enable().
> Therefore, it should be better to check it in order to avoid the
> dereference of the error pointer.
> 
> Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index d3ac318fd6b6..dd1a8b7bc794 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -2405,6 +2405,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
>   		return PTR_ERR(base);
>   
>   	wsa->regmap = devm_regmap_init_mmio(dev, base, &wsa_regmap_config);
> +	if (IS_ERR(wsa->regmap))
> +		return PTR_ERR(wsa->regmap);
>   
>   	dev_set_drvdata(dev, wsa);
>   
> 

Hello,

Perhaps the cover-letter did not yet arrive, however, it would be good 
to bundle similar patches together and provide a cover letter for such 
series in the future.

I'm replying to the very first patch sent, but it's quite obvious that 
lpass-rx and lpass-tx patches are related to this one and it is easier 
to get a firm grasp over the changes - from reviewer's point of view - 
if all the related ones are part of a single series.


Regards,
Czarek
