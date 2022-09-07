Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992425B0CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIGTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIGTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:02:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0012774
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577347; x=1694113347;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5YbVSlpv3Ey5IPcIO5rhmNaM3a1Ciq5ro3B498hHoHQ=;
  b=ZEoSapLwN8qgwiZ27Beknm2p6KJw/4ImD9MqcVW+HRDojRiRgBk9BMfF
   Rxv81G2YiG/edzNntV01c8Sn3of8UDiL5WXADbE/uUlOlHxO+krBzaieo
   fNEMTjJjAQAjOGZ5E2eEAs5lHRQkMDRJ70QyIvOwReVgr3cbRLqheCpkH
   ckGHIkPDPOoe7pm+blAMP4ycXgpLXnYeJB0JTD9RMbQzm/xQFo1OgIpOa
   NKMz5mO0oEyMXhJXs57Y3kGSsrP8R5ZK2vbpcQUXQWXjTW+YLP4a0koCT
   Db/8f+Pubf9c5UJ6qmtUsvUIiNmi7AZGHSBKjkVw0H92Wsbt1WYogbumR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360935729"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360935729"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="859751768"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2022 12:02:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:02:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:02:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:02:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8KKWzfJCDu4oKn1kgWETpIwQS9Czszvlgj8NlvS3CXVx707PghCf2tapjypVMuqta/XPMxcCPRNDNtn8DdsbceG9FlluWJGVfB/SeT1AUCa27bCS5MEosh9nkn8lH3P/CTuHUUsDS4GE4VnkaP2jvpzjSJ1m4C3Qik4KL5tLkXgzlah0rDskzPfQl+SEsqqsIKDAKhnNTFh0aiEAdl6+Y/bnmh96OWXhnyelnHQkqfRZejN6vUNWSrdz7jmXzfkkh9jCpgQacZeMedGN1IKwuVprbAbKmkHTW0JYU8uZhle6VM1IhDICa8jSYlItk8TpgGQUb5YG65jIJvi+o+x8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqTR/SPTEnRBpMzsWTEXXGmT46JI/JBt4Vg3fkoVt28=;
 b=bMeItMGQnVbeWVfDgCxtbWcrol9JqV+tEAUacQdGQoJjVFX3iqOn7sWoO+SR4QJfRho3CCd+64Yc0S1kOd7zIacEU+twQA+EMN8+eHGS89nnIycUIIP8seXmOnMewaFJaOMWoZnwB9PhU6FJ/xPa0pyFdzd0H5i4IFCvvxIz0WbPlnvc9WYBEN9IK3IAV85uywuifyCcnBOP+7hgO3i1UMNuy2w8XnuZJtWUW50Gov0dbJXJ312CjL3tmB63S4CqohHKtCgczb03cd393y7S77p5JwKLNLXO8dv3RpAEQDTY/aKJZL7ogs59GMgZLaoxTPdqnaKsEtLnglNzVCVRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.18; Wed, 7 Sep 2022 19:02:24 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 19:02:23 +0000
Message-ID: <8fdb493f-6227-b75c-5251-e9afaada42a6@intel.com>
Date:   Wed, 7 Sep 2022 12:02:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 05/16] drm/i915/gsc: add GSC XeHP SDV
 platform definition
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
 <20220907155813.1427526-6-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-6-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c0ecd5-08ca-4594-a607-08da91037f01
X-MS-TrafficTypeDiagnostic: CO1PR11MB5105:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQF7w1osB4Vq6/IoedWvWuVNBPkBKNRK7r/DdSuH1H8FkJWxXIEqisMGxsOI4XzIDC8dzIlKDSQnPhH+eqHE7O1Cgwq7ZNGdLpaLMJNmll7gUqKQX6s42CgO0oYv2rrzOQPZF8EfmHIs0HhSdImNoSXOYU4bM405K+VCA+h4n8ChzWrfeDxtQvE90KM3CTl9mR66YtyWGfLGj7K6dbsswry/WtGICwDalD/ReA9voznem2zcW6OUg8zq/ZZjs9NFq/i+BNjHmyySTFf/zn88pdUzkrL3bSv83FedTPznF5onVfscwFA5ojJrfCXxlj5rS8opH18r9e34Em3oYJg7tr9hzR14zKL52V274JfECFSrsdKh+pV/+JDo/PfNwTioUErefzwdVndFjm0RKlnqUNsvepd4R/ElAO/DSJ5fir+TxstXey+diq/OMx8vqcETs5nhUf24t8UeC+jw0gfiJVVWS8CNeDCRmjltnu5jDu8UBzEcA88TSAuXFsBybLK1zvqcFGWo/pR2cuIFbB2yg/C7zBMy8O9EUvp1lnI9RpSiMqV1wIsSKKWK+5kOHj08OW+XNGGH3BEA88tPkXjfQhCw5GUKR/hURKnYOESbmxFjlW7ziOUsb1TT3NvEESCMf+vkY6UEyL4fxhYF3lT6r4SRLhra0WZKWjORBtT+pyISAN4sBJJKZm3iSsNhrifZ0XTfZWoxIKt/Y1nlLsr9HkU6SgZFtM6zYvbqEfj976V/byhU/hOwFZ24eJrGY2gisYdbmQEiRMHhHZhPzdJXzG86wNt3eFgExZeVLpsqkjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(396003)(366004)(31686004)(8676002)(4326008)(66476007)(66556008)(82960400001)(66946007)(2616005)(38100700002)(6486002)(41300700001)(186003)(6506007)(26005)(110136005)(6512007)(478600001)(6666004)(54906003)(83380400001)(316002)(107886003)(53546011)(36756003)(2906002)(86362001)(5660300002)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VQc2dEU3RRZHZpc3EwekZYZjdOeGVscTNaMU5EbnU3TUp6UVNQb3V0RlpP?=
 =?utf-8?B?SVRBNDJROUJyRnFINWFaZktaeEN2d0phVVd3ekh2SnNtRVhYaTB4NVMwQWxX?=
 =?utf-8?B?TWhLMkp4cjIzWVg5Q1ZzVFJpR01PaisxSjdSMGExb1JwczdCNU14Z21kczd5?=
 =?utf-8?B?KzJhRkJEOERCU1RGaTk3WmpCTDNMc2J0cVpMbnpHSVRpa1ZVZ25YYWNRZUph?=
 =?utf-8?B?ZTQ5RC9QWGdjZXgwNWNxQ3MweEN3Q1F4MFhVcXd1THBkM1RuUEhESTdNS3BB?=
 =?utf-8?B?N0x0YUtZUmRVOHZaL1FTeDZiTEwwMmhRa0cwQ0ZweVMxUHhGU2Ewc0hHcWdz?=
 =?utf-8?B?a1FkWjNlcXduazArMmtHcHJHNVRvRUhqa1ZTekZ1QWFtWW94VlI2SUxLaFNv?=
 =?utf-8?B?emZ5M2syaTVEaktRS1p4SjF2NEtzN0ZidmlyUnRnQytPM0ExTWg3QkpEM1Ez?=
 =?utf-8?B?bEg1SndUNjM3TE0yMmU0aStKZUxuN2NqTzVQamV3Tm1iY1dLUnJlV0RVL21M?=
 =?utf-8?B?czhNcTd5cDBsUnZRcWhnVlpJNzd3UkhQZXhqZktsN1AxaWZrV3RrampEbnVv?=
 =?utf-8?B?YllVaHE0ZVYrQWRIMzNxZUxwRWpQdnJUV0ttbVNxVDNRcFpkQU13NEVlcFVU?=
 =?utf-8?B?bmZKeHIvdCtXVWx6N2JZOEI0enNKbGxnYW9Ha29nV1dETmJPZzUyUER2aHN4?=
 =?utf-8?B?VC81cWVWR09VOFd5M0h5QmxTc3JRelMxTmNQTXh5VFk1bGF1a0VzZXVmUWgz?=
 =?utf-8?B?aDBaS2RvOXpzUkxNeXpabEhpR2hQeHE2VFRPS0xHWW1pNVcvT3pOaVI0Q1hj?=
 =?utf-8?B?UHJQNkxRbW5iN1d6NTJqOUdaNTBQa0tFdDhDZGxVd1Rva1pZUWFvbi9ZV3By?=
 =?utf-8?B?OHUxZ09zUmRGdGh3REhYQmcyZCtST2xyTWpMRjI0Qng2b1NndXpqbEZ2Lzc0?=
 =?utf-8?B?a3VZQW5pSnR0L2YycjZJSk85Z05EYWdnMHQvR1p0eXBDa2VPT0NZcmdMcy9U?=
 =?utf-8?B?N3lxRC9wcXNsbDV5a3ZKWkVkQmxZYnFQUXVjdGFGUDRoUjBDbzdBb1pWQUt6?=
 =?utf-8?B?STFvbEFxcHBRZGJUZVd0WFp5KzhzYzBPMGZSSjVsMWRrV3JNdFRZK1d4RG9Z?=
 =?utf-8?B?QkVIQ2pOMWljaWdaQmtZYURZNWp5dWhvNHU5ZFp0VHJVZ0U0S2hVcnkrbUNi?=
 =?utf-8?B?c2NqcXd6NExHR25wa2ErSy92aUxMTU1MTWtlN1hpTThWSjN0SCtTcEREV3Iv?=
 =?utf-8?B?WmlRdlU2aURISks1YjJpT2piN012YjNDK3NJKzJTKzNHUEJVOWpZOE5LR1U0?=
 =?utf-8?B?cXY4TjR1U2J3T1o5QVova1R1OEl5ek5TS0V1WjRHaUZjMnNnbXE3WVZtcjA0?=
 =?utf-8?B?ak9sTWZIVmppcjNwVk96djBzZi8xUTZ1WnZGL0NaVmN2RWRSOW1WZEIyRUxS?=
 =?utf-8?B?OGErQmk1RmVVWHgwN1RPRVNXRjhhQlpVTWZURDlEbHQxYXpGbnFGc0p6YU90?=
 =?utf-8?B?NWZuQ0xLeTVDQWxUb3pteVZ2Zmt2OEQvMTdjcnNZYjRUc0cyekNZU3pOTXpD?=
 =?utf-8?B?UXp6cDF1WHlkT2FEWmRDYnZzRWx3dVplazFmd2xvb0NGQy9jQmd4ZjlSMFFT?=
 =?utf-8?B?YTczSXEwcEFYakxKR2NZdFFKM1lMU0VoeWFkNTN5Y1FVREp1UFlTOWloeS9C?=
 =?utf-8?B?VURDOWpoU05aQkxBYlVPZFcreDRXNHpDNHYzVDJUamNyZHlnUUczRm02Q3VV?=
 =?utf-8?B?TForWGFPaGNTcU9UQnVWejBKamZmQW1YT1F0YzZzMmJZaDNtL2hXQThtRUdQ?=
 =?utf-8?B?QkJKdkRKR2V0OWFCeVVuaEplaUNNK29rMnVSUXN6QUZKdXcvY2tLRnFHMXEv?=
 =?utf-8?B?R2VmMERBSGYza0FGd0xDdERNbVBsU2ppK0tBQjd1UVB1NkxoNUFJMjRHNk5L?=
 =?utf-8?B?Q2c4bzVpTlE4MVc0WFVTem5EdGRKNnlmVThhVXJGeVF0SDgwbTAweEs5TktG?=
 =?utf-8?B?WWNzT3c2SDBydmMxTkh1VU9uUEZhdy9Bbm5TeS9xYXVBcFdDK21kUzBLeG9H?=
 =?utf-8?B?M25CRGxKdHlFOUJUODR1WitaQTk4NlMyOUlGb1c0NTVWczIzUmxuVFAvWFph?=
 =?utf-8?B?MGNvSk1BWHVHemsvRTBIYlplMmhMSkFsWDFMR0tuUThoR0gwWFNrMjloVXll?=
 =?utf-8?Q?s5oVNRdJXPFjuC6TQWh5UrA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0ecd5-08ca-4594-a607-08da91037f01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:02:23.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOVdByBRUr5l8wKJsaAEnfEm9MSTTm4wxtiH+QHrRk/0SeOkMBMxa+twlX8pPhPVfYxnwyJZQoOlJOU5k3R+S7PQaVXWPGcMIQjXk/mn2h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
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
> Define GSC on XeHP SDV (Intel(R) dGPU without display)
>
> XeHP SDV uses the same hardware settings as DG1, but uses polling
> instead of interrupts and runs the firmware in slow pace due to
> hardware limitations.
>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

This is unchanged from the previously reviewed rev, so this still applies:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/gpu/drm/i915/gt/intel_gsc.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> index 73498c2574c8..e1040c8f2fd3 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gsc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -56,6 +56,19 @@ static const struct gsc_def gsc_def_dg1[] = {
>   	}
>   };
>   
> +static const struct gsc_def gsc_def_xehpsdv[] = {
> +	{
> +		/* HECI1 not enabled on the device. */
> +	},
> +	{
> +		.name = "mei-gscfi",
> +		.bar = DG1_GSC_HECI2_BASE,
> +		.bar_size = GSC_BAR_LENGTH,
> +		.use_polling = true,
> +		.slow_firmware = true,
> +	}
> +};
> +
>   static const struct gsc_def gsc_def_dg2[] = {
>   	{
>   		.name = "mei-gsc",
> @@ -107,6 +120,8 @@ static void gsc_init_one(struct drm_i915_private *i915,
>   
>   	if (IS_DG1(i915)) {
>   		def = &gsc_def_dg1[intf_id];
> +	} else if (IS_XEHPSDV(i915)) {
> +		def = &gsc_def_xehpsdv[intf_id];
>   	} else if (IS_DG2(i915)) {
>   		def = &gsc_def_dg2[intf_id];
>   	} else {

