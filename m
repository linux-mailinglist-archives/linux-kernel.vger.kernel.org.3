Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8494E473F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiCVUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiCVUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:12:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900F60CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647979823; x=1679515823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aVmyVzXJaUK7D18NtvnsQF1QHm/cgq9w24QWbJ0/6LE=;
  b=ijJYsGelkqrWMYpn6pHUNsjoD8A358ZnfT/xEGoRmhYSLzhMUwZmdYdD
   NxwnzYARyJu9kQuwTpFuFn7bXMDO7FEi0rKl9ETireqjtZRvB/3+uqe0R
   nkMvbBJOOPz5y8pxrzYjEjTMzN3Jm1yS5XFmKEscL67nIWlHCEo9fr1SH
   6R+pKBz4S/KhIjdTGgy7oa3s8pYtxY/54Mbm4TolU0Th5tpHeXqdHW4MQ
   ENXTXKNJqVKqhqaVlUg8184oKweu1JSkuHEk11Pr8LU5rglk8UT8Zn9JG
   2N/Ck/xKdYe/BaN7YyKXbpUmpgAFLRoNifIyhqU6VyRsFWCReuM8OFGIi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="257886692"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="257886692"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 13:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="500731259"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2022 13:10:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 13:10:13 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 13:10:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 22 Mar 2022 13:10:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 22 Mar 2022 13:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C420RNHsJM/fbTv66Y1pR75AWEi2BiDhsE28XweYPK3o71b6wHCrgN//sd/tBsX9SWmE3zFFsZ7BTNIyneZK99IeJm1GEfmahxfbhfWfgHjYY9SM0dOIZzb0Wo1ulV/ZuGrPIlhwpNV0zg7LITtcXY9h5II9OETUD5XFBo7ish5NyJkTjynjmgTN0SxaZ4Wd+y9fdUTxT5NhkFGHwSoEAWE0OjsOySzGvrINjlOF29WxygRSwjfrXAp43ia5f2Ytnhv6s3fYCRViWsXiV9iw8brHvLV4eY7+fVCXDEkNFh9ahKZ3DMuq5vyuX/RgjNZPIse/dcJ5pqanLI80UkMMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr8p8Wkvkf3suca88gfgE2vjBTl5/FzDAztIPlBc820=;
 b=d8P5nJ7x2MJyv6SqcIYYEd8id1ov7qsf+QnZD6F6ih5lcQmzZuUInO5RVSDR2YJl0jk7JgARw/iBH7q6+ppRNeqUsaUSaO/4r5kSl+StRMu9bfPZVlsD9i3jELS0YI/GSiIfS9JfRYKuA3S9W5WhdqXcg6vViQJGgfefQu4fbTVOPjOJgxmzFhYCmbtikZxd4aYCdqHVm8ec0KFgqZNw9RH1iX47+WwJUjArSWJ6Mgy8Iflnp51KtT39UylQELaS0IatsYy5MZbQvsfGcoPP44bmrAVihGe/YV3Wy9VU4nr2OgJeEcgFaU+LESltY8oh8el6VQ8hDC5MOSlX23+0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM5PR11MB1594.namprd11.prod.outlook.com (2603:10b6:4:5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Tue, 22 Mar 2022 20:10:11 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::a58a:5426:1c6b:6050]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::a58a:5426:1c6b:6050%5]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 20:10:11 +0000
Message-ID: <d318c7ce-3b9d-0a61-e501-52fd43b77f8f@intel.com>
Date:   Tue, 22 Mar 2022 13:10:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Intel-gfx] [PATCH v11 0/5] Add driver for GSC controller
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220315131157.3972238-1-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::12) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92aa58f-513c-4446-df5b-08da0c3ff7d4
X-MS-TrafficTypeDiagnostic: DM5PR11MB1594:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1594620AEBB0A1ABB068313BF4179@DM5PR11MB1594.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnbtOBw82J5uVbmfb7ArUQTO4a69FX0VgsRbVrQm01V986JRfhOhBrrkS1DdaWvbMh5UqqVHxk0+4R+W/ZkSKxVUwi5gVrevBOWie0VlUwQfxgE0SKCi3FXFMCtdU9t1PItXU3vD1osvW7QfL5nfXEGBcFvYkNaCT1X+fvh38FXP/HnvzECahHhfiRR/K7SREbuT8LdOCbegJgBT+O2MukDHWbM6/tVlGvjTNPW9SYgJJCa3R7u7PMEmrWw0TqrTuD/Rc7Nyp+mIVOvC4ofdvhCgsRY2HcJpcz597Ruw9QqQ+PcfjDj2AOmk7JsDyp/YOaI0bBwDMTr/+knW8y56C52FmR3jdZeME3eRpV/ItdJ+6y+rIsXF+x29cuc4HYKNWzTj7FMsCpRjj4t2NT7k3NutZt1MbLX5u36t/H+8h2hy8uyF/Rr5cWJ18xZbIAM+rgZB33HmIoPMpQl09SI+YTZWPCZWwnrfQojdsoWc3oIHIGHxn7OpXedkQT6oWddFCcLdHMiMbOYe3ffW2LEnV3KVPsg4mEBAtdUF63WckkOJlyYLEJ/zL3EfkXRQ95eQrXG98dp6TUa9T4D6LrZsVJ5rK0wAlnWoJ/sUrFoApV8sMDUbWVvHfQw8z0wQwx0HJP5mI8O9TGx7sC2j1zsC4ND2j3lswJ00Ph1SsbU98NW4T+4vRIpkKjVRaO2HqjxQokISfNB6Nw1We2ttInwzLyhG665gLRNzMRvtuyzY55MQ13W9qhDmfXHtCewK9XBsgjl6XL2ZiRHlz7+Rq9cgtmkntEHbfWN/YX8ElFanw+ItNEiIp2+X5LYxk63DzA4h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(82960400001)(4326008)(8676002)(5660300002)(8936002)(36756003)(31686004)(83380400001)(66476007)(26005)(2616005)(186003)(66946007)(66556008)(31696002)(86362001)(6506007)(2906002)(6512007)(6666004)(54906003)(110136005)(53546011)(316002)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxLQitoTVI2WFo0YlhVT1J0WFBpaS9PZU9Ud2UySWJTaG9nRjhnRUl6ck1S?=
 =?utf-8?B?dGJCY0prN3FXdXYvRHRQcHJqSHdNaU00Yzd1RHExKzIyT1FCYnZmeGEyQkd2?=
 =?utf-8?B?b3ZVYVQwbjlMcTJUeWRCb3JpM2hMOGpKTnV2aXlsTFliY2VYbVB1Vjlia0hK?=
 =?utf-8?B?VGQvdHhTRUx0SnJzbHZ3MzI5ZmZaTEk4cVlXTlZDQVFYYU0zbXR4blJtSDg5?=
 =?utf-8?B?NVVYL2JIK0RERHhROWFpdDczeVNqQW82VHVaQkZkRmZhSkpyMHpwc2MzbVBa?=
 =?utf-8?B?S2VrOCsyTVcvTWs4VzBGN3Jya0thK0hQazNWL1FMeThFRzR6RTJFdXhnRjNJ?=
 =?utf-8?B?U1J0eHFNZDVuS3BDd3UwMmEzS3RSdGxxSGtYcTdDWjZPM1MrSFdSalY3bk1X?=
 =?utf-8?B?RlZ2OGlEU09nay8yc3JoVDNIR05mS0xvbmFjZzBvM1B4N1pmVmR2VkV6WS9T?=
 =?utf-8?B?b2VQVzArbnBqQlluM2R6ZkRXaUFMM2xZazVReUJpQ2tucWhiV0dsQXlrSzNC?=
 =?utf-8?B?bDNXdDlENEhKWnowbHI5K2VJZDJseWdHNnB6STVRV29pZW9mWVdGU2paenpt?=
 =?utf-8?B?ekNTUFRiYmowc2UvdXB3bkU1bVVnN2tSR3F1Vk53MVVRTE1lSDd3aWI0SFcv?=
 =?utf-8?B?bkZQQkFteGZ4emJsVVlXRnN3d1o1cWRFRXd0VUpSK0loM2orTytoZ1dzdW9l?=
 =?utf-8?B?RU51QmxUWmJ6ZE1GUmNQRFk2eklueGRrVEpsQ0NLZ1dsRHYvSXN6eVRUWWhO?=
 =?utf-8?B?NXdhcndUTGxaK1RYa2o0Ty8rZnpZSmZVc3RUMmxOZVBlUWhqUXhEdm9KdWhL?=
 =?utf-8?B?WDAwSGpqY2p5cWc3WjRSOThWT0hXdjJRVzRHYWFyb0ZmR1M3cjVwd1JXSWJu?=
 =?utf-8?B?Yy9hblcyMFd2NStIcW5LZmYxTEZCQjduSkNRWDJyYS8rUm9kMllLUUp6SXpw?=
 =?utf-8?B?ZnJKZUVwTnp0L1p3cWlEVEVRSitzR2FLRWYxRlhwb1ZiMVJVNitST0d3TFQ3?=
 =?utf-8?B?VXVNektuWGJHbmFHa1djampTdlErWExtNi9lMXpER1MxL21GM3RHRUdXbWZF?=
 =?utf-8?B?bDNFd1lZTG9GVXByMUlMNFVBZUcvZlBPc21rSW9FYXFRb0xXcXhYdURwMGJK?=
 =?utf-8?B?SVdhSVZWMU1CUDNVeHVxbisva09BcHZBc2FGVkprNlpzSytqd1RNcGN1Tkxl?=
 =?utf-8?B?Vjk4RFhiaksxVjFHNFVFQmdaYXdsMXBTTUR1QlZNS3NpeWtEejVFVEYzODVx?=
 =?utf-8?B?RG5TZm1tVElsTXd3alU1ZGtqWWlsSUR4djUrK2daOENoRHdXZVhzNXpmVHJX?=
 =?utf-8?B?akhKOGw2R3g4UU9lUWZucW41UlRXQTB1eUFVa3cxcUNKOVdUTW1uNjFGR29B?=
 =?utf-8?B?NFRTVm8yY3M0c0psc0p4Y3BCTzRObTdrQlJ0ZEhpaVJZU05lWXJvYVBSTzJ3?=
 =?utf-8?B?d1hSc1MxaTRzSytTWldEN3N3VU5aUy9QZ0hpOXVQK0s4TTJjWGx3SlRGL2VM?=
 =?utf-8?B?SUxSL3NQMW13Tno1OUtXa2RoVVZXN3NsaEkzU051Y1dhMXNwb2pLcnVBcFJ2?=
 =?utf-8?B?WjdwcjdCaGJoSm5NcFpUeUowUWI2R255ZXhGYVRYT1JkdWJpZ3Qwc2Q0V1Nh?=
 =?utf-8?B?cy8yeGJlbEtYMWdSeUF2Q1RVNGY2SGRueXY2bnlIdmZRZCtPL2I3QTJzZ0l2?=
 =?utf-8?B?WjkyWjNvOUtvM1JwclBqZHlGNmJYb01CWlRKWVdYM0V5T0lVQjQvUFFuRndO?=
 =?utf-8?B?NE4wVkwzNFh3WElKY0pVNFdFeDhKUmJDNitmTC9YQjBaUWZxVDN0OFZXQmVt?=
 =?utf-8?B?TmJIZGVqdlN2cE9wcWtWWFNSckpQVm9UQ1pROHhpL2NkdE9tbDZKRVhwSDJ6?=
 =?utf-8?B?M2QrTjU5ZWNPcy9VUm96VEI2T3ZkMGxCVGtNM0RlVXVadFY3MHNhVzNKMGU0?=
 =?utf-8?B?VmlkcUdwQVpnNVRwRm5iTEl2N0ZmakRHUERjaElKSG5mQnVVVnZkOHg0UWcz?=
 =?utf-8?Q?PJwc9k3DMbAErGgHRLewQVkUZkvBR0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d92aa58f-513c-4446-df5b-08da0c3ff7d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:10:11.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVKd+1pGYhltoLMYQEOwwDzSvyiEeMhhGMWNyMRjanky7FI8LZP8Je3Po0yEMZLb6MJAEJHe2yupSxDpOH8bsiH/Un8SBDaCgiaZkl39W5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you re-send this series with an added patch to force 
CONFIG_INTEL_MEI_GSC to be selected for CI? we don't need to review or 
merge that additional patch, but I want to make sure we get CI results 
with the config turned on before we merge this series. I'm also going to 
ping the CI team to see if we can turn it on by default for CI builds.

Daniele

On 3/15/2022 6:11 AM, Alexander Usyskin wrote:
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
>
> There are two MEI interfaces in GSC: HECI1 and HECI2.
>
> This series includes instantiation of the auxiliary devices for HECI2
> and mei-gsc auxiliary device driver that binds to the auxiliary device.
>
> The prinicpal user of this interface is the
> Intel Graphics System Controller Firmware Update Library (IGSC FU)
> (https://github.com/intel/igsc)
>
> In v2 the platform device was replaced by the auxiliary device.
> v3 is the rebase over drm-tip to make public CI running.
> In v4 the not needed debug prints and empty line were removed,
>        'select' were replaced by 'depends on' in MEI Kconfig,
>        the new include file now listed in the MAINTATINERS file.
> V5, rebase and add Greg KH Reviewed-by
> V6, rebase and drop redundant assignments found by the kernel test
> robot.
> V7, add Greg KH Reviewed-by to the individual patches
> V8, address Tvrtko comments for i915
> V9, rebase and address more Tvrtko comments, use drm error printing
> V10, rebase
> V11, address Rodrigo comments about code style,
>       set missed mask in the interrupt config,
>       add explicit devm_irq_free to error and remove flows
>
> Tomas, please look at the devm_irq_free part.
>
> Alexander Usyskin (2):
>    mei: gsc: setup char driver alive in spite of firmware handshake
>      failure
>    mei: gsc: retrieve the firmware version
>
> Tomas Winkler (3):
>    drm/i915/gsc: add gsc as a mei auxiliary device
>    mei: add support for graphics system controller (gsc) devices
>    mei: gsc: add runtime pm handlers
>
>   MAINTAINERS                              |   1 +
>   drivers/gpu/drm/i915/Kconfig             |   1 +
>   drivers/gpu/drm/i915/Makefile            |   3 +
>   drivers/gpu/drm/i915/gt/intel_gsc.c      | 204 ++++++++++++++++++
>   drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 ++++
>   drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
>   drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
>   drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
>   drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
>   drivers/gpu/drm/i915/i915_drv.h          |   8 +
>   drivers/gpu/drm/i915/i915_pci.c          |   3 +-
>   drivers/gpu/drm/i915/i915_reg.h          |   2 +
>   drivers/gpu/drm/i915/intel_device_info.h |   2 +
>   drivers/misc/mei/Kconfig                 |  14 ++
>   drivers/misc/mei/Makefile                |   3 +
>   drivers/misc/mei/bus-fixup.c             |  25 +++
>   drivers/misc/mei/gsc-me.c                | 259 +++++++++++++++++++++++
>   drivers/misc/mei/hw-me.c                 |  29 ++-
>   drivers/misc/mei/hw-me.h                 |   2 +
>   include/linux/mei_aux.h                  |  19 ++
>   21 files changed, 633 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
>   create mode 100644 drivers/misc/mei/gsc-me.c
>   create mode 100644 include/linux/mei_aux.h
>

