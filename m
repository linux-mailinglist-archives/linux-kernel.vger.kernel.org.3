Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015AD477B74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhLPSYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:24:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:2201 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhLPSYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639679060; x=1671215060;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5VHFdCZDZRZLVNJk5MfCdvonI2VBNJye0MsbohGpRwI=;
  b=SeSIDa7SVBUe9P3+fYuOXGzgCd4J+qpOptpkEj7lRAUiTPsGeyVtpnTm
   ES7dp64MsbXTutLTOSyN93xaha43gg08H4l+AvY6mBcUGexL+2FtdXtax
   Yi2tDvUJHhDPVM4o3FM3JxCqlcjs3Rto9edHS04a/FQc9Y5SLUVa5rVMD
   D2gf9HpQT7748Zvyqv7JG+R73Mv03GoUB9nViLBpJfxI4hYPM+aYLQVEb
   2hEehzqMsMcyfCNigDi57UiDE7YweRWugxjYUh3IPCK/q0PGS1nSzonKV
   sv99WgV1yqNjOtX9NOQOEmVT26EnZkk0bced6iey4wqHEWdQl/LSqG2M1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="325848913"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="325848913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 10:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="506402597"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 10:24:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:24:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 16 Dec 2021 10:24:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 16 Dec 2021 10:24:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf1wyOG9n+bP900m2tOpgpakQhoCeJzQZA/Lf8MhG7R0e8rZoZNnKbF6R6Ra36cuAEedjAuQ0dy/JoYIU3icObQNGXgN8maSRwXYEZjRzUSj4C6MbwjRjvuuL0SMg0u4zrjiaXfZp/wx0Rc0RUWFyEacmh4UaC1AnAefX98HXgDJsNl3kfBk+V7Glk9J+ggKGZSs3WymKiIj+VYZqqhV2hVVc56/h8KbW41BOD+gQiCGupiDBmEjpre0abAoGW6O1vSVZpUEmgZBqBizIwg/tvh0KTxnLfvo3DZgQ8oBid6bsa4pOeFOYMmYqkoZW21UDdDtxXJSo0rFBXkycaxWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyFgzYkI5rNXiybTHPdW+akhRjNjHONwhHjfRZPMo2M=;
 b=ZCCowKhbB007kM1iezbiDWEWLMYS1Zg1C6CxpzChhnfrU3nHKhqUU3iyzG3datfCqN+Z1FNpd/AUOhaEmVk3A5+jKD+kMo3toDoG7h6GtBS5+vcwROkH92UJi55ldJZjaHX5HpmstIgRbAwTJip71zwPrjDIMS/rC2bhhiyRTvoyJsp+vYVxtMbsEjwn3EvModNMgksfgJulKl9ySim2SG54/cgkF4NScMI+kAebWhFO/Ma0CNutXtsq93T/cArU7cOt3B46NyCtmFVVz3rbdXBv9iroLMmnGv0/iaigPdp/7oRL0yRCKR80YWcQZLLh6yOVDc8g6AakMQ9+zWwVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MWHPR11MB1245.namprd11.prod.outlook.com (2603:10b6:300:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 18:24:18 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::7542:60f3:e73a:be5a]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::7542:60f3:e73a:be5a%8]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 18:24:18 +0000
Message-ID: <ffc7e137-8c0a-2151-cfb6-b41ae53cadf2@intel.com>
Date:   Thu, 16 Dec 2021 19:24:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH] PM: sleep: Avoid calling put_device() under dpm_list_mtx
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
References: <77c95e21-747a-87d8-4145-f37f75e76e18@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <77c95e21-747a-87d8-4145-f37f75e76e18@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a32cead6-1212-4105-04c7-08d9c0c145c7
X-MS-TrafficTypeDiagnostic: MWHPR11MB1245:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB124512AD718567BD8786EBB5CB779@MWHPR11MB1245.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TXcM3jCH45KrdMUss8IIIPch5kzdnAaLIk91HFrhXSBzvZBYllr1DkwzZ+y3Iki197WQEVlLZCMJ/Glyn84CX2RFod93keEjqq4IuaeKfV5Iy1hE5t4rIbOM/8k+435bA5eY6dKcY4rassOqcyoqiaQyyNro69qSt9E3LzRLL/bxnvzwKWTPSIRurYbVrEyk8q/b+GoiOp2EviI4bQDO0a0OsSp9MkIH15+Ph5Rh9oLindB3RGsYRc28hhXBrnu0VUyNVMIHrnXrCjmusEp6y4mMfYhn7J1orToZvW0qeZqEIpg7IDFdKsEQx1nrcViXJfikmZjjyhX1s3LWmbJI7wt8X70OvBvZRjKgRhcWT5mulmRFB9FyM5DYQcSCeHRZQ8J8K8TCCDantsJwx/B+7k16OGo3UlbWqa3EsAQsDWMdFppLBW1ODLz5D+itOCmbHZR/9mpVmcetY9R2ufcy6aV0TBl1hHNAUxf0qw/eoFSeXihvWSHqLgaZwTehJwnB/zIdNnFn8Ld4UWJhLDk5ECwP0CPsjsULPi/+Jyj4MqHqClCpOMtfkxrvdScqzng/iCz/HFGYv5+Fol56z5ki+p0IRh0q1qnWk0sxY2V4jiPszI58NIpbcn8APkR83C3e/lSIFnyXb6vcMJ9QOP+2cy1sWTuV4zeWNkoyyl970kf62N9qDhCdYtOZnixcOOHOSVTNRAcXE5QK035n2AH9G4/Tp3GbClzQxAXcvI9cxIc0DJBFHny5dhxCwsXPORt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(4326008)(8936002)(53546011)(26005)(186003)(6916009)(66556008)(36916002)(5660300002)(31696002)(82960400001)(508600001)(38100700002)(86362001)(66574015)(6666004)(36756003)(8676002)(66946007)(316002)(66476007)(54906003)(6512007)(2906002)(2616005)(6486002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUtmN1BjNWM1Z053OVlGU29IajRTS0lNeXRHSUF6L1hFNWpONmYyazZxVEJM?=
 =?utf-8?B?YXhlOXU3Y0xWYjVURm1yUFdmN095cFIwMno4V216STNpS2M0TzNTZjgvUnBn?=
 =?utf-8?B?WnYzUk9LaVZBVkM1RFBTL3U4aE9icEpkSXcxYWNpVDFuaWlMaWJ5ZzFJU0Z4?=
 =?utf-8?B?Qy8xM3JmVTA0dDRHeEFxSXU3NFpxMnJhL0VUdDdDRUNuMEphTXNsbk80azdw?=
 =?utf-8?B?VEJsZ01LV2k3OE0yMklLazRNWk5uZnZTRkErckFCYTJFTHlKc1I3VENjczZQ?=
 =?utf-8?B?WnZDZEJza0Q0dy82WFR2cW83L05VUnMzb0dINGVHdWxEeWlBcjZtYlYvMUxs?=
 =?utf-8?B?ZWFKQmZZcHA4QWl0bWlJZGZuZWN1SEY4TWxjSWlOczY1TDFWbWo1Zy82MXh0?=
 =?utf-8?B?YU1PRDBFS3p1R1R5Wnh0RGNxMWJHaHNpZXAxRmJaVHk0K0k1N1Z0MU1HWnFG?=
 =?utf-8?B?ZGFXUmtkdHJFS0l4aWVHUEZkU21JZnFzeUMvSjB4NGMvUXY4Ukh3MjkvMGZp?=
 =?utf-8?B?SlcveUlrb3RyS3piR25RQW10ZG1xTFUxZ2dBTlJ5Y3BBNzQrVW1idWxLRTFq?=
 =?utf-8?B?M3hpRjlDSysxU3hQMStEWStFV3pMVjNZa3ZTcnFMamRKbUtIdk5ZVnJ1VGhn?=
 =?utf-8?B?T0F5Z0ZKZDZENThRbzQxRFpEUWN3MXBZMit6cC83czgyWHJzdGVORE80ZTYx?=
 =?utf-8?B?OEZ6enl6Z09zMzVyaTBkOVFiUXhWUjNaU3RveC9oS0tCOTFKN2EzR0tURjdw?=
 =?utf-8?B?NDhHcjkzclhoY2VkV0xQalRLSUQwWmphQ3ZDcFdGQ09MK1pzM0h1cmtCdk5P?=
 =?utf-8?B?L1NIQSt0aFFtK0hNekdGeWRFbFh1YWVteU5wNEQ0eW82UWRtQ1lIeWNWYkh6?=
 =?utf-8?B?bEtleHpwdklzK05yaGFBRERSdUs2Q3JTZWJTK2huVnBFajVpN2RPeVJrWi8y?=
 =?utf-8?B?YXp1bm91RldnM1ZVZHR1alVFSXZwRTQxelRncWpDSWkyQ0VzOTMzMHhOZTJO?=
 =?utf-8?B?WDZVZnN6SFBGTmxMcTQwR2o3RmVvRTNteEZUV0JQSzYvZzZ0cFlDcHlsei9t?=
 =?utf-8?B?cjNzaVZMSm9HejdmbVVEM204c2M5Um0xa1hvcjNCNVJVVVI3ckc4UmZXWFdK?=
 =?utf-8?B?dHZLdmVQRVpFRnl1OFBLYzEvMkluZENVSE4yTXJGSk04aGwwWGxhQnB6TEpz?=
 =?utf-8?B?eXMxN0hUNUw3Y3ArTzNxNWVCazJnaEk5VmwwK2NNUFl0T3VhbEtPS1lLRENi?=
 =?utf-8?B?U0tEQ3UwSWtJMnlrVWtrZXFEdVpoYlY1OUtJTGI0aHhCN2FxaW9BR2NLU3FP?=
 =?utf-8?B?T0FGbUFkZmlQc2FiUkdsODNGWVpEcFM5b1B2RkQzTGdYc0M4Mlozem9RekNQ?=
 =?utf-8?B?ajlkZkRvOXJ6aE1jZ1dBdnNmZFBjaWNpWmliam9pRHdXSFJjUFpOa3JEb3d3?=
 =?utf-8?B?bGd3U1pTTGhsNXY1WC9CS2c0dTNQVE1TOXFHWGxpamR1RDN1OTdRSXFIZzJ0?=
 =?utf-8?B?dWlLMjkyZVRhdzRWaEJLcmZLTmlYYlIvUktreFZzNER2R1luUTBHQndrbDdq?=
 =?utf-8?B?czFaZk1ZcWZ2Q2EvRnFZbFQvZkQ3TUR1TnNOSEthSVlRaFpmd1ZKWjBXL1kx?=
 =?utf-8?B?ZjIrdzBIQWVlWlkyZHB5OVVYeXVrSHhHQnFwWVE5WFFBZ0ttejFNMXcvT1ND?=
 =?utf-8?B?ditVa0UzZ3pxSnp2RFNRajJkMmR1MFpTd3NtOW84d3A4TndRa3BVUXoxVVhX?=
 =?utf-8?B?TThkUG9mT3NvZ3pNTCswRW1VN1BxVGoxeFhSTVRFeXZCSlU5NlFjTnRYVXcr?=
 =?utf-8?B?VlRON1dOSElmS2t4ak9wV1JBYTd4TkRSZnJmdDdvcUtHWUxZTE5IcTFtRzVC?=
 =?utf-8?B?bXVaSTV4Rms1WFpVaW44UzdPam9NOWlMbTJDeVArUjl6eDVOR1QwSmpvUTE3?=
 =?utf-8?B?WllQQks2Tzc1bzhsVUdRYXhpSVFsNGhzeHB4UHdtMnhNQ0pRcDN2MHpwTTMw?=
 =?utf-8?B?QUdiem1kMHlFdGR6c0xvTTNKS1lvakRyNUNXendEQUQzZnhJcThaZGUvZ3Bt?=
 =?utf-8?B?eWtsTXhuRXpqWVc1YkF5anJPd0hUSzAwK1RBVlVWRE5yOHpubENwckxSRU1n?=
 =?utf-8?B?R2NjOVphbzZPcFF1L21rVlN4aFlYakR3UEIzbldibXVlRzEvdnFKakdhdUJP?=
 =?utf-8?B?M0hCTVd2UHZwaWExdjB0MkE5UmxkeWxxMGVzakJaQmdnanQvRzhOUklDWlRV?=
 =?utf-8?Q?pTGwGW8dPcCebGh+42f0NEluld5PDkXy0Ru5aiw46w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a32cead6-1212-4105-04c7-08d9c0c145c7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:24:18.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7NENlIP+/XeQ5V8zQzdfTAX/+7MQz8IzY/SVc8SJysdHLAAu3ysJaZ7S5IwNRl+JUxfu+7CuoCDcSHToSR1qL4WIHDVkXick4vQRTE1tqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1245
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2021 2:27 PM, Thomas Hellström wrote:
> Hi, Rafael,
>
> On 11/4/21 18:26, Rafael J. Wysocki wrote:
>> It is generally unsafe to call put_device() with dpm_list_mtx held,
>> because the given device's release routine may carry out an action
>> depending on that lock which then may deadlock, so modify the
>> system-wide suspend and resume of devices to always drop dpm_list_mtx
>> before calling put_device() (and adjust white space somewhat while
>> at it).
>>
>> For instance, this prevents the following splat from showing up in
>> the kernel log after a system resume in certain configurations:
>
>
> <snip>
>
>
>> @@ -1748,21 +1769,27 @@ int dpm_suspend(pm_message_t state)
>>           struct device *dev = to_device(dpm_prepared_list.prev);
>>             get_device(dev);
>> +
>>           mutex_unlock(&dpm_list_mtx);
>>             error = device_suspend(dev);
>>             mutex_lock(&dpm_list_mtx);
>> +
>>           if (error) {
>>               pm_dev_err(dev, state, "", error);
>>               dpm_save_failed_dev(dev_name(dev));
>> -            put_device(dev);
>> -            break;
>> -        }
>> -        if (!list_empty(&dev->power.entry))
>> +        } else if (!list_empty(&dev->power.entry)) {
>>               list_move(&dev->power.entry, &dpm_suspended_list);
>> +        }
>> +
>> +        mutex_unlock(&dpm_list_mtx);
>> +
>>           put_device(dev);
>> -        if (async_error)
>> +
>> +        mutex_lock(&dpm_list_mtx);
>> +
>> +        if (error || async_error)
>>               break;
>>       }
>>       mutex_unlock(&dpm_list_mtx);
>> @@ -1879,6 +1906,7 @@ int dpm_prepare(pm_message_t state)
>>           struct device *dev = to_device(dpm_list.next);
>>             get_device(dev);
>> +
>>           mutex_unlock(&dpm_list_mtx);
>>             trace_device_pm_callback_start(dev, "", state.event);
>> @@ -1886,21 +1914,23 @@ int dpm_prepare(pm_message_t state)
>>           trace_device_pm_callback_end(dev, error);
>>             mutex_lock(&dpm_list_mtx);
>> -        if (error) {
>> -            if (error == -EAGAIN) {
>> -                put_device(dev);
>> -                error = 0;
>> -                continue;
>> -            }
>> +
>> +        if (!error) {
>> +            dev->power.is_prepared = true;
>> +            if (!list_empty(&dev->power.entry))
>> +                list_move_tail(&dev->power.entry, &dpm_prepared_list);
>> +        } else if (error == -EAGAIN) {
>> +            error = 0;
>> +        } else {
>>               dev_info(dev, "not prepared for power transition: code 
>> %d\n",
>>                    error);
>> -            put_device(dev);
>> -            break;
>
> It appears the above break disappeared.
>
>
>>           }
>> -        dev->power.is_prepared = true;
>> -        if (!list_empty(&dev->power.entry))
>> -            list_move_tail(&dev->power.entry, &dpm_prepared_list);
>> +
>> +        mutex_unlock(&dpm_list_mtx);
>> +
>>           put_device(dev);
>
> Should be
>
>                  if (error)
>
>                         break;
>
> Here?
>
Looks like that.


> Symptoms is if we return an error from the device prepare callback, we 
> end up spinning forever with little clue what's going on.
>
>
>> +
>> +        mutex_lock(&dpm_list_mtx);
>>       }
>>       mutex_unlock(&dpm_list_mtx);
>>       trace_suspend_resume(TPS("dpm_prepare"), state.event, false);
>
I'll have a look, thanks for the report!


