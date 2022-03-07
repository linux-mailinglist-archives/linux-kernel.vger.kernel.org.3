Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975F4CEFA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiCGCbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiCGCbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:31:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA15E156;
        Sun,  6 Mar 2022 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646620225; x=1678156225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YrhWNywmV6chq1r/gD5Vmb7NCyNJpiZG+fs6IQa9Lzc=;
  b=JXawvUUHEFFjydBH4XTp7mj+vF5pF3SwRkiwPTop+ccrXUYlqizg6CPZ
   dZ9m2Af131JUqOM2p7GT/fAEEudwkJipmq3h4JqlsmfYy6sODI6Q0xVf7
   9Uf0EMYCVa3XtMn/GCfxuHw3NWMKZDsvTqSslyEgoJawZlkbEg8oWDRuC
   Q4mi4su3eYVRpuapcKO9mGxXUUDdldgb6Ndc3d1Ob1yfA3or4FoTo3C6m
   9G9LPOatBt/xDxQ/PL9f7mZrvE3HJbTsmnwov9regLylJrsHkD4MmW+OC
   9+b0BPBP854NwPWu8jmEUZgApIicyZBLmQBzN//x4aP0KoqRYLz0SQuEn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254011656"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="254011656"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 18:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; 
   d="scan'208";a="643070206"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 06 Mar 2022 18:30:24 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:30:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:30:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 6 Mar 2022 18:30:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sun, 6 Mar 2022 18:30:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UskB4McZaQi2v83yvb1HMxDvHhqivBLdiB04dGCSmxjdQhieX2m8Qx6w6mH8YQj0m0aSWN1w8IZDE12jZYLW04vUSTQaq+2yPiuhby0lrNVWixR6cDXUk79V9d1iFBOlf5agZcZOck3lYGi2IdpAA4KdIYWS7CxExxfqeJ1X2JumIvvNQg7vDO6h8E/u9TGCBspX9LmsGlOZlAMmy1f4l59SeARytSESzRmZWAFv05wm9trS+1dVfFlQfLeyTP8orWVHsS7WVUr+Fst+WvpMgx8h3NEatxu39jDeRXri4pMV/UyYT1OzgzKYMJIsxyp9C7+SRiXNKQYcc8WHYMUq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgp9Xs+AM/W16mViOk4S9AJpW0VppEo5QXFxMhMhGGA=;
 b=focorlytfQHN2/3m+fjYmD/2iczWgzKzMLDfoN1rrkijlH737LhNzHfPj/AqgKs7cqvcZUAqgbGfjcMt7eA6jo0ZfIAKStUyr2HKg8VFzhyTmgsy14aK5BXgsp+z8NeonNXEhTBnosMNwYXDcLRb0wVYi9KrB0jeEwoR14OvBbZEBf8ajU9MSER289EtHGdm2lN894Fh5IuvHXOQ6Dh45wubs1FbYUJS6rmeQAQwZr+5N1CDzN4Bct2ixbKMDjozUDEDDkLP8n2WkP9qtwqz7raGJn41A9aeuV+OyA5hUCrN/2NZTwNIvuUyP14cBKQ8wK8ct1R5eGLOQTOMmBbzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 02:30:16 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 02:30:16 +0000
Message-ID: <532da9fc-d241-a8a4-217a-22c1429d43a3@intel.com>
Date:   Mon, 7 Mar 2022 10:30:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.2
Subject: Re: [PATCH] can: etas_es58x: initialize rx_event_msg before calling
 es58x_check_msg_len()
Content-Language: en-US
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20220306101302.708783-1-mailhol.vincent@wanadoo.fr>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <20220306101302.708783-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:300:c0::26) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe916a5-f11f-448e-e760-08d9ffe26a50
X-MS-TrafficTypeDiagnostic: BYAPR11MB3624:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3624AE2C02B2E131CB2FF362FB089@BYAPR11MB3624.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN8tyn+b/rnc4SC0K8L5yO0toJKfRKmJE3uMUcVonYyHZLqjrfSOO1Zs/CHzGDV4/CuTZnrD2+Hb8QJDb3pYDpdNs54NTcjiBTHhS+jHLlRc6DYkje0otNpnp2r2DEK341V6k4I9HWmhhZ79VOJouZ0m7OHkoy+BxMvh86QEfM2kB4pNF8ijfVUH6JPXsZ625xnvCrGyAXDhDd3jfN2XMhy8SSAbrl8l/PYR1pQCgyZRz3KrOwkFasg2Oso6IHMeEE2x9X9x5DXo9Zh58J8Nn6p60eyoDmbgZoH/Efh5fBPgroKz9gAs4WFcQDb9rSe/b+ip6CVy5rN7WWxENIi1RvbWgqp7MhQkKsiYno3WKNlrvmyKEqS5NfHPuZks3ffnHJf3Lz0osreFU+Aa3S3e+d5o6XBuQ83VMTy4nWKRe3nd6ZP9ETldGRhkOaucddBnz/bRwDjHuGX+RLKiwfoa7rw078vKZ4h26EFOQ8aQIZ7sRO+vr5jsy2zUNKCgWjdI3dDS8nHs8ajMbWxyl+N+0HJudlGd3ScDWwq9YXndsXFVEsNNgExQLM7V90yE3L3dkhHXzoGlRyl2iBQXCv5ubvinkhPSsk+54sQZG6ACSarwJEwxN6ykcTFAZLnTqw49Hcf78T4mj5UA5MLYAjTQjNvCrIA1Endh3+QKnCH0HOwL1LMJtCMWk8G0WcTTcO41oiqClhjh6HMrBHo2NFn4m/SVbARNEkc7TYGFJZXY4wI8qVB0jyIKrcQq9AIYonRLA20qZUEpC+taTQ4pB/x9PXAJ+yuQLUCYa5hzUUm3RC4jK1jMpM0fR386dofAiGnvAfiOUtT2p8cIwNPaCgZAKH5GyIkcnEodF2jcSXrjq+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(31696002)(83380400001)(86362001)(186003)(110136005)(26005)(107886003)(316002)(5660300002)(2616005)(6666004)(8936002)(36756003)(2906002)(44832011)(4326008)(8676002)(508600001)(66476007)(66946007)(66556008)(966005)(38100700002)(6486002)(6512007)(6506007)(53546011)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2M3M09Gc0JNT1QwYXR1d0lxcHJhNTNZT25vUU5sUW0yeDQwREVXTUwvTWc2?=
 =?utf-8?B?bG90bXFrUWFKTzBZVWFtc2FvSXE3RmxlWkpnYnhkVkQ5Rk5TVDZMSzlqY3hi?=
 =?utf-8?B?WCt5aFlKL1lsM0p0bWRsRGNzK1BhMTV2ZklaUjNOYWs5Qk1WeHQrbWNVM0Ft?=
 =?utf-8?B?RTRCdnJ5UzF5OUxsQmxsRTlycHpPTnB6MHdtUmYxUmR2Y2VvR0NQdnhWcS9Q?=
 =?utf-8?B?Tng1ZWVwZk9saDdIRFZVTXlLWnFXdWRzcUVJSTlHYXdxVXo2U3o5MkQ1R3NQ?=
 =?utf-8?B?LzZuZUJ0OGlRNVJCZkRxRXB3MWQzMng3Wjg2RVZ1MUxBcUNuLytzWjdpSTF3?=
 =?utf-8?B?eHI0RWlqRHR1S1hUVmZQdDFhdWRNZzZnZk9TbDhnb3JXMFZkNEIyMkNZdDU3?=
 =?utf-8?B?ejZ1aDhlTGpxd0x4eUZOKzNLVXFHMklHSDlCQjVHeWd1QWJOZ01pRWVBdTc4?=
 =?utf-8?B?T1Y4Z2Vac1g4ZXQ3SXM2MGpMQ3d3bmZVcFE4aCtIM3AyZS9HQ1h1aHYzMVFa?=
 =?utf-8?B?MWJJUkpaYytaQW9WNmV4dHFTNFZBcWJMdkdpcklVaWZuUXB2WU1JTDRobFJR?=
 =?utf-8?B?QjQ2WjJWTWl6aWxDeG9iZHplN0llQm5OeVV2am42b2c3cHR0ZmR0QkMvYkFY?=
 =?utf-8?B?bTZGMTQraDlaWnNPVlBick94RnpZYWFiU0p6aEczSXAvSHh2TUZxdE95MkNN?=
 =?utf-8?B?d1F6UGxZRmdlaCtFeFowV3QxRWhKWXpOdGhvQWZVTkVQQmovRjNkSUtmRmVR?=
 =?utf-8?B?aUR4dVpxMWZsVE1iTTY2WDlmNXpidHZmZWxQUWN0Y3dIclJLczVCd1Z0aGo2?=
 =?utf-8?B?TTFtRzUxRm9ZNkk5V3RZTFBnZ3Rua3pnZEhPKzNBT05XNHBuSnlIN2R3SVBv?=
 =?utf-8?B?L2VMZFdSMW45d3hTMmlSRktIQ1FJS1Yxa0svdHJsQW5hYkdIZEFCY3Z0aXhQ?=
 =?utf-8?B?YTJQZWx1eGI0WHlTTW90aGdOMmRQMTBBUkozd2E0L2RNWjIvY20zZk1zL2Vi?=
 =?utf-8?B?UTUvR0hScVhueW5QWFEyT3ZqZ0UxdzlCUHBnT3hiaU1nNHdWakk0c3dGUzA5?=
 =?utf-8?B?Qkl5VjNMZWZEM0liTUlDdTIxV2lXTS82Y0NRTU9IcnZ4SS9UaVFFWHVsZ1VP?=
 =?utf-8?B?emZnSG5qaE9sZE9waWQxNWFmUmd0WVQrQS82bWxXbkxQZWdVOVhxWFpKckJ1?=
 =?utf-8?B?SWY1VFhCNjl1VVg1N3lmMFo5SzRkakoyYlRSUlhEa0RwZno5R29nc1lCeUla?=
 =?utf-8?B?TkFQNW02RWprZ0lPWXVlam50aDVCMzljUUJsRTRGai94M2Z2bEZUYk1NL0sy?=
 =?utf-8?B?SXFBZTlqNjZwdGtzU2pCcUxDRmpoY25JUzV6UUVrNHo5b3c5OU5QWHN3OTNI?=
 =?utf-8?B?WmRjV2I0dFhGWXNXOGlyalNzM045VkYxRDUrYTlENm95OUpUNWg0MDZjdExl?=
 =?utf-8?B?MUtQM2dxOUMxWll2SWo1akQ2d0h5cmt3SXBERmVXUGlZQm9pUkZ1MTIxdVZj?=
 =?utf-8?B?TmJscUJxUXUzanpiNDFtenJlNmo5ZXZ3aUtGbi9DQVFRSEJHWE9ac0R3WkJq?=
 =?utf-8?B?SVJ5aXhIUDF5Zm1lS3EzbjlpU2EyeWhDMWliUUxUdmoyOXFrTFNCSU1JOTBw?=
 =?utf-8?B?SlFQdmFZYzJ0cTY3S0ovcG83U3BnZFVVWWo4SHlXVzh5dFBZRG1PNXRWZkZw?=
 =?utf-8?B?bTB0Vlp3eDFmdGV5MGQ1ZTJvSThGYTY0L1dzRUJPaHlMU0dNUFEzM2Rwc05j?=
 =?utf-8?B?YTBZZmhZQmxMWTc5MXdRT0dMajltdi9Sa21xMmFSVDU2VCt4eVVuRkx1REl6?=
 =?utf-8?B?a2xydGpXazZBTG1PWGtmaFo2Z3Y0akE3NWR1L05IUmNUcFUvKzhHNFUvUW9V?=
 =?utf-8?B?ZzE3d1NuT2dVeCtaNnI4TThXTTlTMm53RW1NTmdURXpUcXlCcUM3Ujl6TGw5?=
 =?utf-8?B?SWFmZUJDeHEvSHltcG1ncWE3NHdmS1BkVTdUVlRZRGx4Z0Jzcm5jOVU2QjU0?=
 =?utf-8?B?cjltWHkrakFPdHZQTC9QOUp6d2hsRysvaWFOTkZwczY2cnNyTmExTFNRT3BU?=
 =?utf-8?B?YlZ2Z2NoTmY1N01sdXF6Q2g5cEhRMy9NNHdQOTk5am5tejBhM3E0VUgvaWZw?=
 =?utf-8?B?Sk5JbENiSTRyYmJJZ1NsNGV1S2hzQzM4UjNEQUtWSUQxM2gxa2wwd0YvNWJJ?=
 =?utf-8?Q?Sv5xooB09WSOv5f4FUIJDwE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe916a5-f11f-448e-e760-08d9ffe26a50
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 02:30:16.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qmx+hyqk5Ye5Izd/pu4tl8Qg3oUO8jomNW552lNnHbGArfBQaNgccfD2VNCEVWRKb8oNx7hHE1GDmPpwn870w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 3/6/2022 18:13, Vincent Mailhol wrote:
> Function es58x_fd_rx_event() invokes the es58x_check_msg_len() macro:
> | 	ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
> While doing so, it deferences an uninitialized variable: *rx_event_msg.
> 
> This is actually harmless because es58x_check_msg_len() only uses
> preprocessors macro (sizeof() and __stringify()) on
> *rx_event_msg. c.f. [1].
> 
> Nonetheless, this pattern is confusing so the lines are reordered to
> make sure that rx_event_msg is correctly initialized.
> 
> This patch also fixes a false positive warning reported by cppcheck:
> 
> | cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)
> |
> |     In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
> |  >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitialized variable: rx_event_msg [uninitvar]
> |      ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
> |            ^
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_es58x/es58x_core.h#L467
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> As discussed in
> https://lore.kernel.org/linux-can/20220302130423.ddd2ulldffpo5lb2@pengutronix.de/T/#u,
> no need to backport this patch because this is not a fix.
> 
> @Yujie Liu: I added the "Reported-by: kernel test robot". This being a
> false positive, let me know if you would like to remove the tag in
> order not to mess with you statistics.

Actually we did some analysis similar to those in the report mail thread, and noticed
that it was a false positive, but we still sent out the report since the code at here
is not consistent with other function in the same patch. We should have made this
clearer in the original report.

Since "Reported-by" tag is dedicated for reporting a real bug, so please kindly remove
the tag in this patch, thanks.

Regards,
Yujie

> ---
>   drivers/net/can/usb/etas_es58x/es58x_fd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> index 88d2540abbbe..c97ffa71fd75 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> @@ -173,12 +173,11 @@ static int es58x_fd_rx_event_msg(struct net_device *netdev,
>   	const struct es58x_fd_rx_event_msg *rx_event_msg;
>   	int ret;
>   
> +	rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
>   	ret = es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
>   	if (ret)
>   		return ret;
>   
> -	rx_event_msg = &es58x_fd_urb_cmd->rx_event_msg;
> -
>   	return es58x_rx_err_msg(netdev, rx_event_msg->error_code,
>   				rx_event_msg->event_code,
>   				get_unaligned_le64(&rx_event_msg->timestamp));
