Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC056A4C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiGGOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiGGOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:02:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57145FE3;
        Thu,  7 Jul 2022 07:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657202523; x=1688738523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ko/TXVUVELcxr6BhmvrO/jeTabGS83G1B3/1W0uJfcA=;
  b=JsOQ/+Iyw+JNEQ6ZUIYc/gEQymSeKy5ypcDPSmCrnOStD0w5rFqqtpsW
   RJSl7rtoQPdaPIxaA9BxjCkS8Dy1g6qQ9I9q09Kqk1DIf2Bbv9KpSWNmF
   q4eDFJ8OAqkULuL0CUQtABgw5/L0R9OVQZOBUcYDYd222p6OKso2VQhLL
   4mDnthZz0K8KL0he/yOVGnGcmwNwKQiRXzyPlQvNyLnKi6YHw5+75Es9u
   dpNnk3xjzAeoW8J28udL635rvQtIHbwthUMB7Dlz7N4tuo2Z6J+Gt6pFG
   h48OIUIV0sOhO/Rm7QL/2uOf6vDhxFqctSO4nlN6/YtVxUmZb5b4TfRGv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285158176"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="285158176"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 07:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="720524903"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 07 Jul 2022 07:02:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 07:02:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 07:02:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 07:02:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 07:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjNUFbOpQzDojOiOxNKLvZEVdxNfiYvz1i0qkLej4izcule6c3Fq46mTce4FqkpSdwkVGnetYcH6h9RjA5VEPKHf/7JmYFAlNbg2gHz5UqOW9zN5U9eRFulN2PDp317e8r3yEwGGFha/I3QEn1GkLBtV1nfOXoGXPzO9VfRA6I76KaSvc+VrybIWDxJE+B74WfrAUTFPBXSxdu3wXvZZmC0Fhs5E2I6dSmA+DVQYvfkKi12oy5qZ189dgczjE/WjTl4SDgI24fJ+SoUC4/NO+STAS5ls8wwq22WR0tRuTCl8V6oDOhf5I9P67E+q1Wtu4Y6o0MqQgRZDjfVEA7SMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbySkNz9P1bp7QNLCiI8mofUBcbHnJMA+WTZ1VcgEfQ=;
 b=EbFd3vtoit2f7lo8lg2kvnFK+vu86dA/wEOSkvJolCnodt3a0j1tFKa62QlP85hYU+AaPBEZHDpvZWojjLYbuCoKxoe1kGCCUnN8FRaob9iDuGX6mYQb1iyS+dD214ftr+pe6F3jggvkHworTMYuRDGKbtuEvJ2Z/mWKWpRXiXR8ah1eGUzOY3ZDwzX2rrnPBPDsp4dUxSTbtNzMKhAjy2/9W4j3Q2WdvEIE+lGRFVhhb51cUywr/tB0FIyvt+KWbtDnGqRO/S/Vvmot6XwQrUTKOFIaOyBZ3xL4//cd5ou0hR/6302EnzkL+n9CfyxLAdM8kIk3Ax5Zcs/A+DIA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB1570.namprd11.prod.outlook.com (2603:10b6:405:a::21)
 by MWHPR11MB2014.namprd11.prod.outlook.com (2603:10b6:300:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 14:02:00 +0000
Received: from BN6PR11MB1570.namprd11.prod.outlook.com
 ([fe80::8df4:fec8:4db5:8bde]) by BN6PR11MB1570.namprd11.prod.outlook.com
 ([fe80::8df4:fec8:4db5:8bde%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:02:00 +0000
Message-ID: <dc8771ad-b48b-317d-b132-47208ef58710@intel.com>
Date:   Thu, 7 Jul 2022 16:01:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.0
Subject: Re: [PATCH 0/3] hwmon: (pmbus) add power from energy readings
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <iwona.winiarska@intel.com>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
 <20220706131758.GA652205@roeck-us.net>
From:   "Kallas, Pawel" <pawel.kallas@intel.com>
In-Reply-To: <20220706131758.GA652205@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To BN6PR11MB1570.namprd11.prod.outlook.com
 (2603:10b6:405:a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d0372e-100d-4bb1-d7f1-08da602142ed
X-MS-TrafficTypeDiagnostic: MWHPR11MB2014:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxsq61BooCmo92Ju9f4EljrG8LUd7MI/E5NE4BOjBwySiZ5zi8P+BYZY4HP2z9aMxWQBT0/YYKRCIb+0fKw1VeYxi7MET8Bv6qzQRPgoYoHJNxbbkeSKMnjqJa3Z3sNX/XQq95OYyQOPOT9ywa9Y5dz+/qs9rzbPIiHugz1jgPv6O5Jf9o92hUDHJxM87pfl2WY9a2vy0nk/MgG96k1uYGmiBnXEugiWtYITPgtWTpbDX+Qgbwb303tj5IWyWGbFF5vEmn2qy5Njh8eKNnSMu8vRl3T3u7qQJ+58ALt/3TJQswKPKWIkS19R8VkXbAbvGUBnrpYbvHN28Rm4ryxV/bwEfmq3QpR/2zCP4dibYI9puuxeYJ0vgveep+UDc3c74zasD7EgLEzvxlsEX6YJWDXLtiPCf8EMlCcho9jHtssctY2CkrV2p8DhqCnX2ZXymFKxtMe9/urGzXvIJOJt1clscJrQIdBjwI3ab3Gqqd3EvrIB1sqbMcEb3h0ZYEX+XDvaq/Qo3wFMERvX/W/NldO0XWyfWtJcMqHgyl4OzsVEolm3DfixaqolxjCLBOQsb7W2UMQQg4OxjKQjMvBPoUCXxfFT0Fr/1Bkb0dZyjilX2R6X/vS1+MNYWcG8ahc1DcniXlL/Y63MV4ZJjm2vzH/EuyoWn/CSbVJN5qgiD/Yl2emoATCK7Iu4zuIL4nI/tnjAFzxBnYy+GzqRwS6OHsmlTnTXVEhCJOea1govQ8y/TzCf551GcPWf7qwMYSFQ3x5Lu1yknsYdzkgYameDH+JXSVL213JEgN6bUwyvY32utLmAfMwCD8ZNAOCBjZI90L1/5ZM3JOCElv0lUL+T4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(39860400002)(396003)(8676002)(66556008)(66476007)(31696002)(19627235002)(2906002)(86362001)(4326008)(31686004)(36756003)(83380400001)(66946007)(6916009)(6666004)(5660300002)(38100700002)(6486002)(6506007)(8936002)(2616005)(41300700001)(186003)(478600001)(107886003)(6512007)(316002)(82960400001)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRuVGdwZ2pRK2pqYU1aT1A2UlJOVEhTWEpaWDhyMHA5NVNQai83cVIrRjJy?=
 =?utf-8?B?RVZoNFd3M3ZkL3FON1FoTFVSS3VTNzdZRUxpMHZVMDRHdGo5ZWFQK0JKWlF5?=
 =?utf-8?B?cWdIQVZuVDNxWllJTENjQXdEVUNOS3ovVUNaZjYwRjNQRWJyN0xlZlI2b3hB?=
 =?utf-8?B?VFFqZWgzKzF0YUx2cTNTZUVRM1YxTEtQa3hkVzVFR1I2TzhlRjYrbHdOSzVJ?=
 =?utf-8?B?VHhsYnMyTFNCazBuVTlvWmpQWm9pMkc5Z28wQTBvdjZYVkhlemNreHNTVVlF?=
 =?utf-8?B?ZjA4MnBnR1JrT0k4TExtNWVUdlEyVmFYYkpKQzEzWGpGQ2VoVDdLSWdSdlhF?=
 =?utf-8?B?MmhpVWRUK3htT0ppQzdNOWs0MDB2R0ZuMFBiNjA0bng1L0VwY3VoQ0o4c0VS?=
 =?utf-8?B?TXlrWnM0U3c1S0pIWkhZR0hTN00ydUwvckQ0bTdKb3hSMUpYV3BjeGZYdDg0?=
 =?utf-8?B?MXgzUHVoclF6RUFlVCtSeUNOcjlZTWVKOExVT1UyQTBJUy96OVNzUzE0TUww?=
 =?utf-8?B?aW1aVjBJS0VvMnlqalVqOVRkNUlxaVdCTm1qNGVDelJEM0p1VU45QnNnQzNw?=
 =?utf-8?B?RWZ2T0MzWE5qTEtjUjRoMnAyZTBpdjNibTlHVDJ0WnJETTgzcU0zU0daS3pk?=
 =?utf-8?B?VTVBalFLYmVmNk1rdU81UHNCYWppZkx4cmVJcnNQdzRma0xJVHl5ajUwNnJS?=
 =?utf-8?B?TTlUU3VMUDBBVlJVVVR6QkpZbHVQTEkvRkNiTDR2MldhbjgwQ1UyUXlTOUxL?=
 =?utf-8?B?TFUxVzY0Z2ZSMG1FaHFWckgxeFMwdk9uUkl3ZGRBUzE4SlNJYlZFblVucjZh?=
 =?utf-8?B?T3dHZG1VMk1DK3ZuRFBvRXdkK3FBdFNXZ0ROZzdJeENTdkdWWnFCcXVESmZy?=
 =?utf-8?B?K04wNXJ4KzVFdVhmcUE3S2pMbytjaXV3K3QwMVl2MERsMk1PTGNyaXJCMEJW?=
 =?utf-8?B?ZVpqUnM5cURqeUtXOHNHQTdaMVVqQ3FxazE0S21QQy9NMWxuSEUwWFVMOEZk?=
 =?utf-8?B?M3FTSG9kSldtTmsxZjJ5a0dJQytjWlU4cUJvcnpINzRZQy80VWF3WG1PVE9F?=
 =?utf-8?B?a0JxbEhmRkdsWlA5REtZRmE5RGpBZnd2YmQ0MmFSTXpJRGhXeEw4QndxUDYy?=
 =?utf-8?B?UG9pR1RvTzYvaUVFTU9vamdvYzhacnYvdVQxSm0rRFhLVUV1aDdxSFgvYUVZ?=
 =?utf-8?B?QWgzQ3JTdGk5aGhrRkNwSWVsN0VOaVBRSXFRaVYrN0V1ZndSdGgxVy95RTdE?=
 =?utf-8?B?UVVMVXErb2RCdVlQODk2QmN0R1pIcm1CN0tsNnJvRzVhVnhCZERWYkVmVndl?=
 =?utf-8?B?SHBRMHBmU0tjWTRuK1lNaHphcXUrd21GbXIrRmlQdnp2QkFFNDFkWWd0VzFs?=
 =?utf-8?B?RGw2bHV4T1ZFVXozT3VwWXN4ejZ6MjBTcjkyZE13NDBzVTZrdG1yeUYvb3Vp?=
 =?utf-8?B?Smt5NkVtOWp3aFl5aDdOdjhIYzVISkF5dzUzSnExaFczUUlSc2pZMWNkMjly?=
 =?utf-8?B?TGdSV0VpUnBLNTRrYXdpV0luRDV0Ynl1WVZQL2ZYSnN1emN3ZGlNTEJHTXdk?=
 =?utf-8?B?WGY4VGpGYXp1TTdmTWtaNlkrK1NnNDJyeDVvbTdqNjhrVU55MFhNZzB4MWhW?=
 =?utf-8?B?L2FNb0QrZnVlMFhNMXBBeUtIWSsxRytkeWhXQ3JtTzhpY3JlZWYrRXRwbGc3?=
 =?utf-8?B?OTdJYXFENkMvcnUxT2lKU3oxcTFnQmhOMWtFUi9RbHU0UDB5R29xNXpKSGZC?=
 =?utf-8?B?eWZBa25NNUJKWW93UUY0UzlrS3JIQnRiQkN4QzEvcFNTUDM0bDZmUVVHRkda?=
 =?utf-8?B?QTV3SmFuZ1U5dnI4NGNHTHYydnVIMXcrS0RtdE1mRGRqSzlHQ0lIT1JpZVZK?=
 =?utf-8?B?Z1FxWkw3ek5aK0lWc256UkRrcVFyQjcwUG1BOURhUWoyUzN5RlhPK0RvNm5M?=
 =?utf-8?B?a29vd2pIODI2K1BUK0RwTzRERUdpWjhWTlZJUlhCOXpoZXFCQ0YyKzdRNk9q?=
 =?utf-8?B?MllLVEE4SWJOZ2RKS3F2RnhTRG54TncyQ0VjZXYwRXVWOGRPS2V6cCtIeEd3?=
 =?utf-8?B?dWU4SXNMMHFoaXJWdm9iOG9WOUdUeEhlMmlzVlFVemc2Q2x0VzhPOVluVXRX?=
 =?utf-8?Q?Krjw1LVM2bxh1uYdwm7YnZtt2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d0372e-100d-4bb1-d7f1-08da602142ed
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:02:00.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJbaNO4PbwjSdREuUV2jYHSPCirc/tlBoaSAhEpP+7zVAIQT4btbY34TLxqTt4RCeNNpgjQtUfs+A10gwNDShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2014
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

On 06-Jul-22 3:17 PM, Guenter Roeck wrote:
> On Wed, Jul 06, 2022 at 12:40:21PM +0200, Kallas, Pawel wrote:
>> Add support for reading EIN or EOUT registers and expose power calculated
>> from energy. This is more accurate than PIN and POUT power readings.
>> Readings are exposed in new hwmon files power1_average and power2_average.
>> Also add support for QUERY command that is needed to check availability
>> of EIN and EOUT reads and its data format. Only direct data format is
>> supported due to lack of test devices supporting other formats.
>>
> I don't think this is a good idea. EIN/EOUT report energy consumption,
> not power.

According to PMBus-Specification-Rev-1-3-1-Part-II-20150313 "READ_EIN and
READ_EOUT commands provide information that can be used to calculate power
consumption". That is accumulator summing instantaneous input power
expressed in "watt-samples" and counter indicating number of samples.
The only reasonable thing that can be done with those values is 
calculating power.

> The "average" attributes as implemented don't really report
> a reliable number since the averaging period is not defined.

Agree, it is calculating average power since last read, which could be
incorrect with multiple consumers. However, this is the only possibility
without adding some timer logic.

> Also, kernel
> drivers should not make up such numbers. I don't mind adding energy
> attribute support, but that should be reported as what it is, energy.
> What userspace does with it would then be a userspace concern; it can
> calculate all kinds of averages from it as much as it wants.

Returning direct value of read registers would also work for our use case,
but it is not in line with sysfs interface.

> Also, new attributes should not depend on query command support.
> I don't mind adding support for that, but it would have to be independent
> of energy attribute support.
>
> Thanks,
> Guenter
>
>> Kallas, Pawel (3):
>>    hwmon: (pmbus) add support for QUERY command
>>    hwmon: (pmbus) refactor sensor initialization
>>    hwmon: (pmbus) add EIN and EOUT readings
>>
>>   Documentation/hwmon/pmbus-core.rst |   7 +
>>   drivers/hwmon/pmbus/pmbus.c        |  20 +++
>>   drivers/hwmon/pmbus/pmbus.h        |  19 +++
>>   drivers/hwmon/pmbus/pmbus_core.c   | 261 +++++++++++++++++++++++++++--
>>   4 files changed, 291 insertions(+), 16 deletions(-)
>>
>>
>> base-commit: 7c1de25c06f31b04744beae891baf147af9ba0cb
