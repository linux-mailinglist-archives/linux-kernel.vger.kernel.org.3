Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5350E5D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiDYQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiDYQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:32:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF7AAB4E;
        Mon, 25 Apr 2022 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650904152; x=1682440152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7xm0tgzcLLxQIlgFY3hXi8I41Tdux5sEGa6HgT54IVY=;
  b=UpNSJHnMAmBXbrdu5oizVQ7wTj32EZM0xHKOmp9md5gWGef/jIzgNHc3
   BwuSxJ0QiiTIaLRFvKtRQTvQ3xmy1rVWyFn5BD7L1RvdAwHNx5m6rMn3o
   +/gEWPCtXsLl1VNZTo54GwN/3GzY9CPZsanpacl17OfXqLCyLJ9Ag2q31
   1qcIHt2+eVHG3I/DXokXe/kVAe6qPUcEEzqYgR7+7x+ec8uNzkwmrIl0/
   Nn90c+ZhmIZKOA85JLKOBislP1LkpBQ5WsTA9ylAcyBFRonzpe2kC7HyA
   zZELcCAGiOAghww32qWqpPbApdLOw5y/rGInh5cOurt8g0YvgV3kmCnX9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245223151"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="245223151"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="729815266"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2022 09:28:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 09:28:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 09:28:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 09:28:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 09:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGAohekFk6W9SEiSDuVNd0C/P0yJ7dHLMhsWERdLc2fjcKytoKjqN0Zj64T8BKVG+yTbJOavpJV1+O85D6bwRsg+IJSyh+YJc16bkMcs80zvx/bbzrUfscq7nVpoWcK+WvLwC0ovQ3O9Q3jPeJX8fM5JCYuTJaOF58aUbA2zBbM0sj9fs9NrV5qV9BQkcIzP+kJqt1LwzmD0qZhRzZLl6ALqkAKwrtD7eUTBmfkFvqMzPIRJkuCB9OsPo4xcWaU6XeIecNIBR2RF9MO900j21sjU0+vFXHk6jyf4fz8NjJ1ymrF6BatU0QDDctNPE4r7wRcNa6LL8ObOrfZUb9BteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYbbSgjPWObZqwbv4OgEvgwBGwamWKSkprHK/z37pLg=;
 b=PlybeJfk9dCgNASHCmO9QGp38lIiJXF6mlnBfsjdTWOUO+PqmkutYwSHkZl3VYJsXduRZoxXwyX5UGFDZDV87n5TiDoAsDDA2oSzKeCHxwEuf1gGHc+xduY070LXJyehYw2ZeKNJzggRiL5L0QGHlg4MJXs4SzgmBY+MQ0jGU3ZWbETc1L+ijNsJFqgdYPbFxlchphE2tOJeJslbsJweOfWLC4kJ4O5mAyM5QXv1lPY/hy6qmuYBtlhpwfYgsskv+kx+nY2sU8C41zPzLTukr6dukeRUj0aRyq5jjsBfTczxyoEyVJc+40IcKXkvJTXmrzlKxwZNPLblYqjoQgENuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 16:28:50 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::98d8:aa81:9f56:c36a%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 16:28:50 +0000
Message-ID: <c92d98fc-be47-0453-ada0-c5dc34c9b82d@intel.com>
Date:   Mon, 25 Apr 2022 18:28:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v2] x86/pm: fix false positive kmemleak report in
 msr_build_context()
Content-Language: en-US
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>
CC:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220423182410.1841114-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd7d187-023e-4e40-2cb1-08da26d8adc1
X-MS-TrafficTypeDiagnostic: DS7PR11MB5991:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DS7PR11MB5991AF86443EDCCEC550E4FCCBF89@DS7PR11MB5991.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSTmFqTy2JGJvT2AwqmHab7taxZIv784Us4iRIxw0qI3NHj/jLzhthUF1F8qHcAVj+jetMFzBuJ4BdoxWUbSDmG/alu2eB1KI6EO/eh3iqKAbX4o8dmYiVaxPp5mI1Ko0kIu4z5na9NmrReFu7xYl+lvDsJbM5gL5m6fy5S/jkVxhLHx4uBHqRaiOPKT42Ns+k44kM4eQfQP+g62wpW1hK1Z94/cKZBZKNFl3ZyDko6enzMxTrxvfUIfxaZOTBiyN1QiPoBoh49da2X+pez6gRzoE/KdDxFPdnqDB1edX3M66E2l4Qq2P5bzWI0L/DJgFPonqr0zBB5BEeIcblK/dJtFrCyNbsEK+GaMd7obxWJARa9fJOb5s09O/vWwEfn8/a1oKsLHfaKT+Ia8ToLkarzY+JswAvynzTciCq0OxVGFLf4jrOwohCmcwNtFRWDz9IVbp5MbN5QmHvrEXSXneKqb67UE5RwhZEM5RN5AYmjQE9ZYV9JgUQ+ZzevEttMO4cYzj0V9qSVp4VZHk59YBk0a8ZU8F8YHkNm1Xfza7xD2A9eNDy5W3hytvwy1KeiisPaZxXaV7Ux1NlSIkF3tngRCOX1wNeWiwHpz11Qs7Mg6kdBpqlhvK+3njCSgvaB1Apf7k4IQv8J67beBpwbbTXNhcQF3C8moW+8r6Z6ZFNk1VbiG43AHOIYsSIzgyWdYViXgC1pgGRAk15gjQBfV/ruFNDPDWtThr0VqI97h3AVlovqgsITKjmRN2Ma81oCYTRKYPJZw3JR0g4sO2qeT3paVahhTBI2f0AZ9peL74y6fBQOjz4j2+/73ofJwh15vziG3z8wTa6yUUcsSvZ6/pXsNaT3DFsdCHzn7eJ4V3xLgURuwKGiWmolhqw9t6yd6NvNnXHtyunN7r2N+fTI/jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(53546011)(6506007)(8936002)(6512007)(66476007)(66556008)(66946007)(186003)(7416002)(2906002)(36916002)(38100700002)(5660300002)(82960400001)(921005)(6666004)(508600001)(966005)(6486002)(26005)(86362001)(31696002)(83380400001)(316002)(6636002)(8676002)(110136005)(36756003)(54906003)(4326008)(31686004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxkTFFlcEdzcmc5cTBycW5OcDIzcXNYNlhGdU5qRlRxMDZSd1ZpWTZnVEZj?=
 =?utf-8?B?dmxyNUpyR1d4ZG9ETjA0ZXN4SFRCTHgrVHM2N2JqYUR5VzZiQkpkNlpSdTdL?=
 =?utf-8?B?U1UraWh2VXYzMlJ1V2wrRWxGemJvOUpYWnlURnBSMGpYZURLeUxnTTg2ajV4?=
 =?utf-8?B?NVh5OSsreDFieXFnVHFIWjhoSlEyRWkvZXZWS0F6djNvZytmSzVHQUg5VzEr?=
 =?utf-8?B?ZW1pUkZxVUhMZjJPaUQwdVJPZzg5dHBmM0hUaGxiTnMrSnlxc21FcFdEbHAv?=
 =?utf-8?B?SEZ6cS90UHhDZDlsTFRnMm1XRzdMSUIrSG1yRWhwOHZFVGZ1bnpodUpjcThr?=
 =?utf-8?B?bFZSeTlobUFxOTNLSWpJNlR2RTQ3TjBJR2FGOHpzNVpJaXNpOWE4OWR0YWNw?=
 =?utf-8?B?Z05DNDJmK2VSZDRHME9YbzFMdGl0cjlFYXBvbmlsRTZHcTBJbW1DM0d5SnJh?=
 =?utf-8?B?K0lleXFoOWtaWDI3UTErenRQSklZcjc3SnZHVVF3OEo4K3dkZ2tUVnZqdmFE?=
 =?utf-8?B?N1hpbzFlQm52T200Q2l1Y3VLTXhvYVpUaitjbHQzUHpOZUw4emMxTXNSQmlw?=
 =?utf-8?B?dUNyL0hkY0ZyT21LNGFpdjlLYVcxMDhpSGhpb1NGaVpHNU1yVzBlTjF5MVhs?=
 =?utf-8?B?Wlo2U0pqQ2Z2QklZS2tiWjNZTTNDckM2ZzArdHN3MXF3V1JEaGgrMG5yWkRo?=
 =?utf-8?B?Q0xrcG41QzdLUzdKeEZlMTU2VzlpUFFLYWNpSGo3RnB3Uzk0M1hSTlA4MXVv?=
 =?utf-8?B?OEhnWW90NkphY2JaakNMdEdPMVRTV3hoSWtaUVgxZWhLQmlPbDc5TzZNUTBX?=
 =?utf-8?B?NzVDSkIwbFc0QU1NNy9OTlYrOGROeWwxU2lKMmlDcmV3UXFWRHdnNVgwNEhY?=
 =?utf-8?B?czJQcEJYRGVoYm5xak5HRTVJTndUV0hFRXU5OU1nYmUzTG1TMDdQYWNVckFy?=
 =?utf-8?B?a1JtdmM5ZHBpbTh2OC82SVJ1Q2kwd1BIdWt0amh3NEpnWVY3YWpUQnIxMVhY?=
 =?utf-8?B?VFhQMmZvWG9USUFzZzNaVnJjVHpJVjlyeWZOS2xTWnFTUFZlTldlYld5SXJt?=
 =?utf-8?B?b2V0TUt2NzBlV0FVamEvNVorbm9BaE9DZk85WmZGMEk1U3Y5b1FaWFJlZGVy?=
 =?utf-8?B?bDVpaWFtWkQ3VEdOUlRQWVdGNk1IaTVSOGIwYUVoL014ZGRITnVWcDFSSndO?=
 =?utf-8?B?WTVzaVdtSkg2MGJUMTF3REZnS1VFU0hKYXFaZ1d4Z1Q2UWUyNXdHQllNLzNj?=
 =?utf-8?B?WEJJOGdrUmNJOTBnb3V4NG9UNDFycW44Y0R4M3dBNW1GM1pGYlEyeUNDOXZD?=
 =?utf-8?B?NXV2Q1d3dEJCNnduNDVUczJ1N1Z2RVQyOElWRzlQbGxvSVN2WExZME9ETzhQ?=
 =?utf-8?B?QWVTc0lRQXZDRkIxUy9ZRyt0WXNoQWRuakhJT2JLcnBRQlU0eGIxWFN4M3lp?=
 =?utf-8?B?RzlCSVdmTjlRbXZJUURQMDU2NVF2ZnpBYTF4eXo4Tk90UG9INnhiZ0NpQ240?=
 =?utf-8?B?aHdWRCtLajJwWGdtNTB3c2VyUjRMUnZhQjZrb291Nkh0UVkrTGxLSTdzUE9W?=
 =?utf-8?B?SEcvRTRzU0tEQVU2d0pNVkxyaHJvQ3l1N3QzRXRoUm13RElaYkxtak8wN0Y0?=
 =?utf-8?B?L0JyM1hGcWp6VDNubUhEZllROVVwZnZNYWVGVGZBQ0h5cUVSNVZxVllWRXI4?=
 =?utf-8?B?Z0x3eEhtYkNlL1RJSHFCckJWMU9UU0hqc241a1pQdnVwczZsSGVzN1dLNWJy?=
 =?utf-8?B?ZjQwUkhRdTJWME1BVzMrelcvSUpkTlN3L1JJWk9xWS81bU1aWFkxemFQNGtY?=
 =?utf-8?B?cFVRV3RWN1AzeHVnKzE5RUw2Sm14S3Y3a3pyT09NRGZEM3JCTk5Pbm5VYmpW?=
 =?utf-8?B?ME1LbUZvK2l5V2FTWnluWlNMZHlyZTl2cVh3U3BheEN0eVZGSkdZUkJrNGFO?=
 =?utf-8?B?QzNZREg4YVZDM0EwYjdOeFRKaWNXQ1NpQTZybk84Z0JjRTF4bzh4YXJSRWlN?=
 =?utf-8?B?RHU1Y3FzQ2dWM3A0RWtOWTc1Q1p3bzV3c2JnUEJQNmdSYUxnNno0YzFZcGVK?=
 =?utf-8?B?V09TakhZOU1HbEJ0MnpPZXhtNnIvdTBwZDc2a3ZmTTZMMnNzUFNVa2ZrNEZa?=
 =?utf-8?B?Uy93UmxBT2E3Y2htaEl0bGQ3WXBKVDNZRnlta2NWdlZLSkdFL2w4RlpDY2M1?=
 =?utf-8?B?K3hQakNXZTZkZWpWbnowRkFMWVFmUG1VVnM2cG1NUklWOVhLZlFPNkROaGFR?=
 =?utf-8?B?cEhQUmpYLzMwRzQySjdneHIxNjlLUmFYSkR2VGhnWXU4bmd1bGh0bEVIUU5C?=
 =?utf-8?B?T1VpMTd1TW9OV3BzM2EvZ0liUEZScHRoQUppUUlCT3BHV09wMk1ZbGJpSzBU?=
 =?utf-8?Q?wuWArDeFJ+ECg7bg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd7d187-023e-4e40-2cb1-08da26d8adc1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 16:28:49.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmbiPJlIwDv/AaY4P9yWCsvasx/LzbqbS0jJYgM46qfwMG0I483uTRHHBAuE5Lcf3ydICMJSSeqUHcLUVoHg5P+TgHMl/OsopAwKZf2N6wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/2022 8:24 PM, Matthieu Baerts wrote:
> Since commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume"),
> kmemleak reports this issue:
>
>    unreferenced object 0xffff888009cedc00 (size 256):
>      comm "swapper/0", pid 1, jiffies 4294693823 (age 73.764s)
>      hex dump (first 32 bytes):
>        00 00 00 00 00 00 00 00 48 00 00 00 00 00 00 00  ........H.......
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace:
>        msr_build_context (include/linux/slab.h:621)
>        pm_check_save_msr (arch/x86/power/cpu.c:520)
>        do_one_initcall (init/main.c:1298)
>        kernel_init_freeable (init/main.c:1370)
>        kernel_init (init/main.c:1504)
>        ret_from_fork (arch/x86/entry/entry_64.S:304)
>
> It is easy to reproduce it on my side:
>
>    - boot the VM with a debug kernel config (see the 'Closes:' tag)
>    - wait ~1 minute
>    - start a kmemleak scan
>
> It seems kmemleak has an issue with the array allocated in
> msr_build_context(). This array is assigned to a pointer in a static
> structure (saved_context.saved_msrs->array): there is no leak then.
>
> A simple fix for this issue would be to use kmemleak_no_leak() but Mat
> noticed that the root cause here is alignment within the packed 'struct
> saved_context' (from suspend_64.h). Kmemleak only searches for pointers
> that are aligned (see how pointers are scanned in kmemleak.c), but
> pahole shows that the saved_msrs struct member and all members after it
> in the structure are unaligned:
>
>    struct saved_context {
>      struct pt_regs             regs;                 /*     0   168 */
>      /* --- cacheline 2 boundary (128 bytes) was 40 bytes ago --- */
>      u16                        ds;                   /*   168     2 */
>      u16                        es;                   /*   170     2 */
>      u16                        fs;                   /*   172     2 */
>      u16                        gs;                   /*   174     2 */
>      long unsigned int          kernelmode_gs_base;   /*   176     8 */
>      long unsigned int          usermode_gs_base;     /*   184     8 */
>      /* --- cacheline 3 boundary (192 bytes) --- */
>      long unsigned int          fs_base;              /*   192     8 */
>      long unsigned int          cr0;                  /*   200     8 */
>      long unsigned int          cr2;                  /*   208     8 */
>      long unsigned int          cr3;                  /*   216     8 */
>      long unsigned int          cr4;                  /*   224     8 */
>      u64                        misc_enable;          /*   232     8 */
>      bool                       misc_enable_saved;    /*   240     1 */
>
>     /* Note below odd offset values for the remainder of this struct */
>
>      struct saved_msrs          saved_msrs;           /*   241    16 */
>      /* --- cacheline 4 boundary (256 bytes) was 1 bytes ago --- */
>      long unsigned int          efer;                 /*   257     8 */
>      u16                        gdt_pad;              /*   265     2 */
>      struct desc_ptr            gdt_desc;             /*   267    10 */
>      u16                        idt_pad;              /*   277     2 */
>      struct desc_ptr            idt;                  /*   279    10 */
>      u16                        ldt;                  /*   289     2 */
>      u16                        tss;                  /*   291     2 */
>      long unsigned int          tr;                   /*   293     8 */
>      long unsigned int          safety;               /*   301     8 */
>      long unsigned int          return_address;       /*   309     8 */
>
>      /* size: 317, cachelines: 5, members: 25 */
>      /* last cacheline: 61 bytes */
>    } __attribute__((__packed__));
>
> By moving 'misc_enable_saved' to the end of the struct declaration,
> 'saved_msrs' fits in before the cacheline 4 boundary and the kmemleak
> warning goes away.
>
> The comment above the 'saved_context' declaration says to check
> wakeup_64.S file and __save/__restore_processor_state() if the struct is
> modified: it looks like it's the members before 'misc_enable' that must
> be carefully placed.
>
> At the end, the false positive kmemleak report is due to a limitation
> from kmemleak but that's always good to avoid unaligned member for
> optimisation purposes.
>
> Please note that it looks like this issue is not new, e.g.
>
>    https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
>    https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/
>
> But on my side, msr_build_context() is only used since:
>
>    commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume").
>
> Others probably have the same issue since:
>
>    commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume"),
>
> Hence the 'Fixes' tag here below to help with the backports.
>
> Fixes: 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/268
> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

All good AFAICS.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   arch/x86/include/asm/suspend_32.h |  2 +-
>   arch/x86/include/asm/suspend_64.h | 12 ++++++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> index 7b132d0312eb..a800abb1a992 100644
> --- a/arch/x86/include/asm/suspend_32.h
> +++ b/arch/x86/include/asm/suspend_32.h
> @@ -19,7 +19,6 @@ struct saved_context {
>   	u16 gs;
>   	unsigned long cr0, cr2, cr3, cr4;
>   	u64 misc_enable;
> -	bool misc_enable_saved;
>   	struct saved_msrs saved_msrs;
>   	struct desc_ptr gdt_desc;
>   	struct desc_ptr idt;
> @@ -28,6 +27,7 @@ struct saved_context {
>   	unsigned long tr;
>   	unsigned long safety;
>   	unsigned long return_address;
> +	bool misc_enable_saved;
>   } __attribute__((packed));
>   
>   /* routines for saving/restoring kernel state */
> diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
> index 35bb35d28733..bb7023dbf524 100644
> --- a/arch/x86/include/asm/suspend_64.h
> +++ b/arch/x86/include/asm/suspend_64.h
> @@ -14,9 +14,13 @@
>    * Image of the saved processor state, used by the low level ACPI suspend to
>    * RAM code and by the low level hibernation code.
>    *
> - * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
> - * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
> - * still work as required.
> + * If you modify it before 'misc_enable', fix arch/x86/kernel/acpi/wakeup_64.S
> + * and make sure that __save/__restore_processor_state(), defined in
> + * arch/x86/kernel/suspend_64.c, still work as required.
> + *
> + * Because the structure is packed, make sure to avoid unaligned members. For
> + * optimisations purposes but also because tools like Kmemleak only search for
> + * pointers that are aligned.
>    */
>   struct saved_context {
>   	struct pt_regs regs;
> @@ -36,7 +40,6 @@ struct saved_context {
>   
>   	unsigned long cr0, cr2, cr3, cr4;
>   	u64 misc_enable;
> -	bool misc_enable_saved;
>   	struct saved_msrs saved_msrs;
>   	unsigned long efer;
>   	u16 gdt_pad; /* Unused */
> @@ -48,6 +51,7 @@ struct saved_context {
>   	unsigned long tr;
>   	unsigned long safety;
>   	unsigned long return_address;
> +	bool misc_enable_saved;
>   } __attribute__((packed));
>   
>   #define loaddebug(thread,register) \


