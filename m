Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFD156A758
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiGGQBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiGGQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:01:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2372248F2;
        Thu,  7 Jul 2022 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657209663; x=1688745663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uJluMG3eVNtJQpJhCv4fVbgI8/6x6B1YQ945tWo8iHw=;
  b=UP74j+FgAN5HabPzEuAASzeTJvdDdasOknG8NvjuYhlDJWidrn7c1TLG
   Uo14tfMuQ5KCpB9/mVg1ollWRNrtSbsOObtZHxSDB3ZRKu6DiBfSaPRyH
   UYPpiCIbpl6FQUVEgBdqFjEykLzDYUevOoqgiNpfZgtDo+sklQ8xg8kYK
   iNgsQzgsrP/a6qTcEtKNqAsxkC3A8EIIaHscd4AlYdDdwaeXGm23oNukl
   HXPplMw61lZriaSbvbS4jgTV9oEBCGYzJ0k1dQhabiIpFpbj6u1tK6K1W
   sujvzBNJtuNYpuQ9WePe5uvHMyMuTrbPwtf0pYr5DRzLg2Sdnkhp364QL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309618673"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="309618673"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 09:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="568573170"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 09:00:58 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 09:00:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 09:00:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 09:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2VfA3keQKYUzNgRTX287nei//1U30zrovMAl6RVfrjtY/+GCZKr/QccfhnLi1ZPcxiWKNtoJWEy/seRzU+OM0E1ffMmMUKSI9jAWnm/ze4rnXDlTJnA5gW+TL4RQVBtas4tQK1ZTTJhPIyCDaMEUnR5o5DUcwikGpKyUGm/9YdfYsZplcsl1ygPIVWK+3JSCBgVOKsRr4j3ZnngSEo8awu1LoJUrPsajCl5qjtLtMgzXKJDIbMbItibccPpySoQdWzCkIQOOFLQJ8UWKileyj/osn3OONRNXssFqJhIq4X08Xg3fdyyijPhJTsRVXwcSzQHTn2AXCv1o6XuUML2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riCxf0tlJCfa6qKf7kdC+aJAAkNQqZtnYJPwquQmm2U=;
 b=gwpEsOpZmpiQqP+tZiXG3kmaBCbPaF55QQ96OQZmmZ5maR+BpBpXEtxqDqktmClURcpOcjf9ZPjgEVp2F3PS6aL1+tso3rXERnJNhgPmcXvfih3VVca5BAfdO6/oXjp/4dKEe7gNitlHHJbrXYh81+F5Nd4LCUztUS7+6kzdpvxzHHoiIE0H8//58JxY+MW0ao24IFhq6gx3tq4KWVaKk8ZNSgFEoSlxXz3H9eHCqQef/dkYQtqy9R3JkP8PDO1qWNz8Ld7kpUhxmcz9qZPI2NvUozM+/g5/2NvibSKDQXORgjtK3OP3PBEPgS+aD+gefzCkcAPQgbsEOPDG9Js6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB1570.namprd11.prod.outlook.com (2603:10b6:405:a::21)
 by BYAPR11MB3445.namprd11.prod.outlook.com (2603:10b6:a03:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:00:51 +0000
Received: from BN6PR11MB1570.namprd11.prod.outlook.com
 ([fe80::8df4:fec8:4db5:8bde]) by BN6PR11MB1570.namprd11.prod.outlook.com
 ([fe80::8df4:fec8:4db5:8bde%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 16:00:50 +0000
Message-ID: <0b776040-c3bd-034f-bbcd-b929f1a4d19a@intel.com>
Date:   Thu, 7 Jul 2022 18:00:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.0
Subject: Re: [PATCH 0/3] hwmon: (pmbus) add power from energy readings
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <iwona.winiarska@intel.com>
References: <20220706104024.3118590-1-pawel.kallas@intel.com>
 <20220706131758.GA652205@roeck-us.net>
 <dc8771ad-b48b-317d-b132-47208ef58710@intel.com>
 <20220707140952.GB3492673@roeck-us.net>
Content-Language: en-US
From:   "Kallas, Pawel" <pawel.kallas@intel.com>
In-Reply-To: <20220707140952.GB3492673@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::30) To BN6PR11MB1570.namprd11.prod.outlook.com
 (2603:10b6:405:a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b152d26b-127d-418a-8c8b-08da6031dcc7
X-MS-TrafficTypeDiagnostic: BYAPR11MB3445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kT0PAi6bEckoM+vEz47vJur67lZ738lcQlQOA51nNjrSWBGJYB+gPVLsNtXpazh7zZ/50NcGpj2D1xN6j/s+rJ+djq21/Jt7OYWFldIWWJ1v6+oQmastG4dlebt9xcbJGKKa5y4haMCCTJ274LAhKUD+tWp/BQQi+r5yo9QL/CeldNanXKGa9lvhkSk7bc/zefVYVIInJ0IzdLKMM2zOnTQ9qGkMjWMPgMNni9sFpM+J0Z3GeIm00Qq34rlg9b6Ty78Rsz0H0PsScodupAzw1J8aL4shuAo3Bstqk6H8aJPHzMtsOlc2WHec1+qc/vqalIYrV6j7nv1JTslhUMathlz3zhbOAUcvy32YwOyBtswm1sRKCDguwdOyH+acWNqweuWpzuGzj7pVx+uIvT+Q7vKG1qD4dZ/u4ACPtQYNu9AYCqiQVLwBslWxdagTJbUvtraVdU1d1Q1REJSP4q5snx8EiIgO5YSwFKzg4mYd1WpzbZWNbMtHc6vDjvFqs8Xheh2/FSRcYqAGyuK3jFFF75XisME6PKJvForhbRtfN0VFuuKoedyfLqVvtYEL04kz7WiKyAMrwz+7CaR0yAzqkxo4wgbWysuewl/ioUYuwjjMMR4MBzsGegkm5Un+yDK3wUruJKnMvjQwBZKWym2RBzqiy5631VFS6A+Ncub3H76Et9KmLv3FZTbK3gi0HrNksofqMpipjojmRz97eZJl2XfTeqERyVYji8kR/AwM8HQs09ZVhppLdi9gJKEy4bsYJqFhz9O1ygloeE1kGNPr0Bt0G8qpMAcusSCS/t/o/pgbBfTEmvlcvZAXRGQz81ZMJGZYTdnpP6PhJWGH8AEBiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(136003)(39860400002)(376002)(8936002)(478600001)(86362001)(82960400001)(66946007)(66556008)(8676002)(4326008)(66476007)(6486002)(41300700001)(6916009)(6666004)(31696002)(53546011)(2906002)(6506007)(5660300002)(107886003)(38100700002)(83380400001)(6512007)(2616005)(186003)(316002)(26005)(19627235002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTl3TUk4clhxbnJFWVkwQ2diRkZsMnlweGg0VDc0ZE1od0UzS3Y1dGR5V2pV?=
 =?utf-8?B?TTR5czcvQXdxaHdxbHpQTlFJNU9tUmgvZkI4Y0UxckZSVUlxSys0WnhnbVB4?=
 =?utf-8?B?OTJ2T1loMUF3WXlqWUNiOGphYS9VeFlrNG5LY3ltbk9ES3NnZjREWVhtMEsy?=
 =?utf-8?B?aC9vczJhcFlzRS9LUHNOc2lDYzFvSWd2QzdUNUM2WkRyMXEvRWdTdXJOUitu?=
 =?utf-8?B?VDFrUlJUZDg2QTMyUk96RHdnTXdrWDhaUHExRnNMT1VmZWhmK2VjdE1tUU1a?=
 =?utf-8?B?ZnAwVXBxWmdsdTlVV2M0YXdEWGx2a2VMK2I4ZTBaRFArRGNjUHpLNUViWTVo?=
 =?utf-8?B?SlA0S3kvSHJsWUpiczArZTFZUDVTYmZCTUF5RXo5WWFTRXFSZHZRM3RIeHVN?=
 =?utf-8?B?WGNSclhVOXlQSXR2MkpRalRlTjBZZUhzZkJJQkxjWGhrVW4zNDEyVStWMXNz?=
 =?utf-8?B?bFRWYUhOdHI2Z3MwUnNOR202ZlkxS2I0K00rZ1Iray9rQU8xWkhCZTJIdzZV?=
 =?utf-8?B?a0NXY1Y1dWZzdjRhOHcrN0JBdlhQVGJGZ3JUZTM4eWJ2ZGxucmlOV3pyRkFs?=
 =?utf-8?B?b0taUEpvaVF2bU9rMGxFeHBLTHlnM2RkeXR6bUM2a2VMdU1OemFORjA3enll?=
 =?utf-8?B?K0dOR1lJZ1JJYlRKY2xZdU1FZzNCYXNHa1MzWVVtU1BwaDNrMDZNc2VSc21L?=
 =?utf-8?B?MzJzaVUyaXJQbmRnRlhSNC9raEtQY2Iza21OOXVGOXE1Y3VVZENIRk5pVVlr?=
 =?utf-8?B?YnhSamMrNExudlQrTzZiRmFFeFd5bk5NRUNHV1E0WjBlTHBMbWZyRGs4NVBJ?=
 =?utf-8?B?SXlwRzlUNWl3VVdmT2ttUXRxQXpKcGo5V0JXNTY4akVXKzJ6RHBuY21BWW40?=
 =?utf-8?B?WXdzYVVVVHhKTklpNGhTL2s5SVdWZWM5RDdkMS9jdWJ1cERLWGpnMS9kd2FV?=
 =?utf-8?B?SG1JZHA5MmdqUGpwL09mVUxHQlRTMWx6aTZKZmp6a0x3T0ViZlZ5Vk5lVzMy?=
 =?utf-8?B?eUl3T01QYkdUc0lkWTBHRFkrYXlUdncxTm5UOUZHSU1Bb01xT09pL0M3VDFB?=
 =?utf-8?B?ZzI3MzVHdG5iWW5nQ25DcjBmSmh5alQ4N1NtT0NQZE9UYmtDVmgxY3VrQnoy?=
 =?utf-8?B?dTJwbG1aQ1BPOEJHbWVrUFZqVUUrd2VWZkswQ0g2ZGVLM2QwcXBjemFFOG9j?=
 =?utf-8?B?bzloLzhMZzFZeFZUK2hhS3FKOUZPa09udlpNdngwRElYRnVsbkoxd29kWk9L?=
 =?utf-8?B?Q3l0dWFzR21SandGNVp1VlBSdXZkQmhkcCtxQWcvN2ZNYmlHZDN3NkF2UEhF?=
 =?utf-8?B?ZFRXTjNuenpHbUppQkJ2S1FuNTc3azhOaFZ3eUJGNlV4Njl6QUF6aXRnRmNK?=
 =?utf-8?B?cWlWK2FaU2prVTFlUHpVNUdybXJOTnUrSmQzb0dMRllVZFZJc1FoMnB2Tk1n?=
 =?utf-8?B?Tjl5SWgzQVRjTGlUMlJuK2dZRzY1WGdMaWZNbW9Bd09ZOG1YVXdjMTkrQ1p1?=
 =?utf-8?B?TllORkFZK1FFeENLa3h4S29yY2tPZi9KR0s2UUsrQTdwSThYMG5mWDd5NTlP?=
 =?utf-8?B?SE5vdUt4SFE5L0N2Z1pOWTdJSkJ1bVh5VkVFNVpHdndEZnZYSWIrR2pjckhN?=
 =?utf-8?B?czh2dlRWaVFKaW5XWWU5SXN2T1duRFNLYzFkak5FQURvLzc2Zms2V1hnMW0r?=
 =?utf-8?B?Z3RHa2U1aFdXRUU4dmM3Z0RKSHBEYzJYTnVXbW5DSjZjT3hsTkRha3U5Z1BY?=
 =?utf-8?B?VHo1enZ2TGpjMDFLWHdoTVh4QjJGSDIySHIrQ3BUV2pHSnNnWlZqTkJyUlg4?=
 =?utf-8?B?RzlxT1hDenlFZ29SWHFEaDlSYXVUU1BxbGtvWWg5QTdpenFoVG1MNkJNZlNJ?=
 =?utf-8?B?Z2RDMHYyc1ArYjdMcStuYWp4TmowQmJhUFViQmpzNjhDVFlyeHBFT3VjVEpk?=
 =?utf-8?B?ZjE5MWxORWZic2FmU2ZqZmNPMnV2VkN5bC9Nc2xzdEMycTJna08rS2VGbHhu?=
 =?utf-8?B?aUVhNkUycnErMHQyYzdwbitWWk5PVzJBM1FxMDdFYXUxclZsTDIzRzZyZFBl?=
 =?utf-8?B?Umcyd0RKdmFqaDB4dTdmMFFhT2hxOXVWZXUvQytDTXFpNGVOM3BhSm9NRWhR?=
 =?utf-8?Q?9R1d6y2euIUl4kaMTbI6b9jAW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b152d26b-127d-418a-8c8b-08da6031dcc7
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:00:50.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uYUFNh9FnjwXKCRZjv+A3YBHdGSk8S1SmG1BqrjCu2Dv0/f9eWLqOk/VBMoYOptHD1QV51o3TrOAsRtAT3QDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07-Jul-22 4:09 PM, Guenter Roeck wrote:
> On Thu, Jul 07, 2022 at 04:01:54PM +0200, Kallas, Pawel wrote:
>> On 06-Jul-22 3:17 PM, Guenter Roeck wrote:
>>> On Wed, Jul 06, 2022 at 12:40:21PM +0200, Kallas, Pawel wrote:
>>>> Add support for reading EIN or EOUT registers and expose power calculated
>>>> from energy. This is more accurate than PIN and POUT power readings.
>>>> Readings are exposed in new hwmon files power1_average and power2_average.
>>>> Also add support for QUERY command that is needed to check availability
>>>> of EIN and EOUT reads and its data format. Only direct data format is
>>>> supported due to lack of test devices supporting other formats.
>>>>
>>> I don't think this is a good idea. EIN/EOUT report energy consumption,
>>> not power.
>> According to PMBus-Specification-Rev-1-3-1-Part-II-20150313 "READ_EIN and
>> READ_EOUT commands provide information that can be used to calculate power
>> consumption". That is accumulator summing instantaneous input power
>> expressed in "watt-samples" and counter indicating number of samples.
>> The only reasonable thing that can be done with those values is calculating
>> power.
> Yes, but that is not the responsibility of the kernel. Just like we don't add
> up power measurements to calculate energy, we don't take energy measurements
> and calculate power consumption. Similar, we don't take voltage and current
> measurements and report power consumption from it either.
>
>>> The "average" attributes as implemented don't really report
>>> a reliable number since the averaging period is not defined.
>> Agree, it is calculating average power since last read, which could be
>> incorrect with multiple consumers. However, this is the only possibility
>> without adding some timer logic.
> Another reason for doing it in userspace. Read energy every N seconds, and use
> the difference to calculate average power consumption average over that time
> period.
We cannot "read energy". Raw value from READ_EIN and READ_EOUT is not 
energy.
>>> Also, kernel
>>> drivers should not make up such numbers. I don't mind adding energy
>>> attribute support, but that should be reported as what it is, energy.
>>> What userspace does with it would then be a userspace concern; it can
>>> calculate all kinds of averages from it as much as it wants.
>> Returning direct value of read registers would also work for our use case,
>> but it is not in line with sysfs interface.
> I did not suggest that. Just use the "energyX_in" attributes.
Expressing raw value from READ_EIN or READ_EOUT is not in line with
sysfs interface, because "energyX_in" should have microJoules as unit.
Those commands have very specific format that is not actually energy.
Since the only sensible use case for those raw values is calculating power
we figured it would be better (and more accurate) to do it in kernel.
Also, if we just express raw value, the user would have to know data format
of the values for the device and know register format to decode the data.
>
> Thanks,
> Guenter
>
>>> Also, new attributes should not depend on query command support.
>>> I don't mind adding support for that, but it would have to be independent
>>> of energy attribute support.
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> Kallas, Pawel (3):
>>>>     hwmon: (pmbus) add support for QUERY command
>>>>     hwmon: (pmbus) refactor sensor initialization
>>>>     hwmon: (pmbus) add EIN and EOUT readings
>>>>
>>>>    Documentation/hwmon/pmbus-core.rst |   7 +
>>>>    drivers/hwmon/pmbus/pmbus.c        |  20 +++
>>>>    drivers/hwmon/pmbus/pmbus.h        |  19 +++
>>>>    drivers/hwmon/pmbus/pmbus_core.c   | 261 +++++++++++++++++++++++++++--
>>>>    4 files changed, 291 insertions(+), 16 deletions(-)
>>>>
>>>>
>>>> base-commit: 7c1de25c06f31b04744beae891baf147af9ba0cb
