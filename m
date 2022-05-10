Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5EA520A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiEJAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiEJAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:41:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F2766D;
        Mon,  9 May 2022 17:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPWmauOgoxYikgZfOKcPaCzw4TL1vfnCyyicaiKY/oqZP8kgobLYLutz7LkYCpFBn1Mx5ksN8mH2HlKEOdy0YO8xBVkTMLaL7uvPLuTxbB4IcBsisOD/wC4287qTgWrpFoXjJiVPT1Nxkbtp8DPPK0h2cBfYlYeBdxX9w9zI/cYugIDhqvtpVNbJzrOjpKDtohGd7o94qecB92HA8jg6V3C2RSADcD0ZfpcRnPhUrLTJdDicyi5dMukKRuH6btJjL3ilgoFUzR2Ty5b5DzExyK5cvjMlrJzhwlXGrustLMUkkmHfG9E6ui6VnRwnJjOMZPW2HQspaVXzwePd/61C8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XC+pR1s5DgVQcmQJDWTUTNm3Lh18mrrshctYLrfrrw=;
 b=kyhRvDQ9d66GcGVxlTCR3tTEEdPD8/TZ24/fqNcHon2aDJBQc2wZozUtBiVI4BiqqynmGVOdQx+rqxvDktA9zP5362+sOl2PKJddKhAPE8tEBeHsk27n5EtbQCnTh0ucPEBQP+DFMSzdo2SZZuZSzEAgGdR+DOQ8aIt0Di/Y4Y7iOuWhvkB7E0JLUiBV6HZOzT4K7TrMqs2apfqt++rBf49u+2S/Pj1Aa1FVAXZtoYulFoz+LkA2MZAI6K3ueh43fQhr0mW9rsu1j7ty8IYr3EKvKLWHIx5/939TDppJeOSMCjUCzTKNAlbMiEiV5PHbNS9igVErnl7sWF8fHROL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XC+pR1s5DgVQcmQJDWTUTNm3Lh18mrrshctYLrfrrw=;
 b=BevJuTbaPqTRlVmUDC+RNremhbsCjyBjxDLHfKdUnmeqac8cgYGCZdsltNDgiOCM1Tyekc0RVF6sF3WFaaSx8XsVHNi8TuQdlPXLEnlAJzljyaQzukj6ZizCkPf+KKkUiWNqXlq1FOkMEAcLHf4g440YcCg0qKvbW1hVPy7Z1yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CH2PR12MB3960.namprd12.prod.outlook.com (2603:10b6:610:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 00:37:35 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 00:37:35 +0000
Message-ID: <b3e1e442-50ef-abd2-5dc8-1c9943ff34ca@amd.com>
Date:   Mon, 9 May 2022 19:37:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Content-Language: en-US
To:     Jerry.Hoemann@hpe.com, Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, ionut_n2001@yahoo.com
References: <20220509163304.86-1-mario.limonciello@amd.com>
 <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
 <20220510003339.GA2788@perchik.americas.hpqcorp.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220510003339.GA2788@perchik.americas.hpqcorp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:805:f2::45) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8ce035b-d228-4321-4069-08da321d46f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3960:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39608DE31B9E47527F701573E2C99@CH2PR12MB3960.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRXfF9HJi24PuXsyH6/VEo0zmL9GZSkP/R7KkR+bzB2VUDX7tfrvxeDNSqNMQtsz1HwknmV1IMB8l3qtqKIZOBhKaXeuhOPOTL3WYO+ssbPAeHxSb9OsV4t46SVm2KTko0s02WZOAvUVIaRie1IkDIN2pUn97pFGCav1XSbKt0n1hdQeGcc7XuT8x9qittl4LJUwftiPdc4+RI4Cq767IYdmfREtujjw7OFbJ1sbYeT9/d4j8Zk09PSWS6uD6B5eFDIT8KJUMxX/04FQMYMfugVRmkdwHYsYT4XO5UXzpoVPF81hQRAUGsqmSKg6F2Q8sNnTAf6uAotIAToi8g+5x6EQgTXIHIIkHP3MByiyunITM+9hb/TpW7zaUtuE+OX/y4QPGbCxJtTkx31B5gmmDz6vIcGV5gjYPawKcnUevClurXy8DIZJxUWwd7rYOvx/gWF9kDPQ9rdr7PDtB9YKikuw/6iQZ0czenVGfI903uZGUubgTxMyIXaUQFl0slnIA8t+aVIcG6GrC5Du42p3H94YBY8ZsIlcdkQ2PFmz2uoofdavhgkqGQiZg58dIPnXIALm2JyOj56JTPmnYwz9YC3ihdRJLuQqf87GA25HpdKgG/l0mWKNBbiSxFMihFQVmTMVFEcHesLcC6WyAF5x/6orgfL0Cx7gwidHW2i8TTsOxuXmUR1LgjVPpJbidBLtv9vzy9Mn/HIKeaUt0KVx/q5HorpEE9wfels7EewZlvPXvq2ns3Jif2usUUfCwg3mPDR/u7Ow+42Ts896CywioGFlnkQjre10w4WCg0BUEYChDR32hFgY7VQNnHqM2anr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(66946007)(8936002)(66556008)(66476007)(6916009)(54906003)(8676002)(4326008)(316002)(86362001)(296002)(2616005)(6512007)(53546011)(45080400002)(6506007)(26005)(508600001)(38100700002)(6486002)(966005)(36756003)(31686004)(83380400001)(5660300002)(44832011)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDhFVDlRc0V6Ky9EQTN3a2F0aHdSRjZmY1hIOW5BU0lxWmVNRGw2Zmo4MHdH?=
 =?utf-8?B?ZCs1TjIwRU03RmhQZzk5anA2Yi9NN3Q3c2htTldKZG02a2lUZUMwSWJjMXVD?=
 =?utf-8?B?cWhaVWVxMGNkYURJU0lGMjJEbGw4M0RmTlF1ZmNJOXJqVmd2NzVodDhQWGQv?=
 =?utf-8?B?d1JxcWlIYlZlQTA0Tk9lakFLaURLZGh0cHA2N1REemxqNitpNzhjM3FWZHBR?=
 =?utf-8?B?THFuWmgwK2ZwUUlpbFo1S1dGV3BBbTBkTUJNQktDbzZhUmxJSnZWd3BIVWpN?=
 =?utf-8?B?YlgzLzBCY1hOMy9lcWI4WnhrcGZoMTd3OGtSVit4Z0h5WmUyOTA4OXVhWktO?=
 =?utf-8?B?eWVtQ0Vaa011di9tdGFxM3htZmNKTTdWRXdGUGlzYVIzY3gwUWFzanVjdk42?=
 =?utf-8?B?dHdNV0sxdk1aYVRnVVp6UDlRa0ttZFZkTmpqQURVVCtjNkJTU2JqNXVGT3ZR?=
 =?utf-8?B?YnJzbWloUTVnUVdDNzRiSzFhejVHa2RETU5oTE9rWFgvbzZCcVlzZ0syamVl?=
 =?utf-8?B?a2NncTV5bmd5cmR2NysvNmREY3JqR2FtZVlPQjJNRHNRb0U4SzRtUU1IUlla?=
 =?utf-8?B?U1RHQlNPa1p1allxcjZicVJJNHR1M3FKM0dqUUxCUWVsYXFINGJYRUl5dGpG?=
 =?utf-8?B?aXpWNFd6VmdZclgvRkhGdGc1Y3lwYXNWZjJxWnEyVDNSN2RRWHNwNnV4QmFM?=
 =?utf-8?B?eHM4N3ZaSVFIcUFnTjMyR2ZOSEV2YytESDl2Q0dHWVJLMkJ0dWt3T2s4MzFa?=
 =?utf-8?B?dW1TYXhuYVh5TGZ3Q0VRS3pFN1lLdnZUSUlPRytSOG9XTWcwOXJpWnhOZkd0?=
 =?utf-8?B?VSs2SGpCSUdDd3VKbXI4OFU4MlpiWG8wOXhuaW5sekljdjdzNjYwUGJqdEJJ?=
 =?utf-8?B?Qk5GYU5qd3BmSk40enFnaUl2NVRBdnpiV1czZlJtNjNYanM3Y0g1cFE0T3dx?=
 =?utf-8?B?V2FMNy95d0JGRjI3MDJHSE4rRmduUDc3enlyVDZDbHNFWGhJb2x3NFM4NkZC?=
 =?utf-8?B?SWd3ZmJxYjVDQSswQUFBUVN0ajFrY1BSdVNFc0Q2SjcvT01NMEd0Rzl5aDBa?=
 =?utf-8?B?SzlyWDNPbGREZXFnb2hRMTNVd0s1UFhwR1VXbkdOUG1hVEtFOSt5NHhPUUxD?=
 =?utf-8?B?V0NSZHV2NE5Id3JXSUxOSjErRU5oNkVCY2pJQVNEWWwzMWpGZjNaM2Y4bFlz?=
 =?utf-8?B?emRFSmRQcXdUYU9OMVpwWld2QTVlRGJiVzVxUTRNeGxpaFdENDVlcnUzbThk?=
 =?utf-8?B?Q0ZBSGRYRVdTaUlOTVY4SmtGQUdXUkZQTHUxTHpxaDdvSVZuY3VZWlNzRFQ3?=
 =?utf-8?B?N1FNd2lycDYzektNRkNNbis2NGdGOWVoYnZWMXlkaE13ekswbGZDbTRmZ2NE?=
 =?utf-8?B?bkphMmVKay9LU2VxejhxeVpEd05wUldGY25vZlFpbi9jVWlaaGZJNzRmK1FP?=
 =?utf-8?B?VTVtQnBnWW5hRWJCSEQxV0EzVy8vT1NxYXJaMGxXcWtYa1hNWUtUVjh1UmRO?=
 =?utf-8?B?bGVlNnorU25BTmdpSzZJMGRVaGxod0Y3TmZVZnpvb0pPcWpHTHZmb3gxYUdw?=
 =?utf-8?B?UVBkQjNKcGlTRGFxNC80VjlTNERYWXhUTGZSTkR1UFVGTk5JOUJmTkxEdS9j?=
 =?utf-8?B?elJrTkE2d0JYMm84eWZITnErSjVwdisxaldQVllzU3NGYTN3VlNWcGVZNVE2?=
 =?utf-8?B?c3ZBb2xtQjdHVnBtRU1Ja1FYV3FZUDMzcU92OEl4dm12cEkvRFNzRTBqbUE5?=
 =?utf-8?B?T21ZUy9iN3h0cDJmWmVYWEJHQlkvVmhyQUt3VlZ4N3VXWkxHbTNjcEV5WVF0?=
 =?utf-8?B?d200MmU2TnZJcU8zL1FSM1hqeldwT2JiVE83RjVoRnpHTnpEUmlpZlB1b2RV?=
 =?utf-8?B?YzBjTG9DemN2cUVsaTlsN1VZZFdKYTZhczJxYUlFUGFob2VVaHZxTUpiUUxh?=
 =?utf-8?B?YVlwdE45VWRWWW10T3prT2J3TEhRWmVUSmNmUlpvNjFpck5NNldUMlZRVVZH?=
 =?utf-8?B?Q3dIY01hTkJNaVVjWDMyU3hyRDNyOTVTMzkyc091VWRJdW5IMVBwMWhlYm1Z?=
 =?utf-8?B?eGZOQWxpeUpMWHhRbnRIb2g2dXI4SUUzN0krUTJmVHJ4Y3RSUGE0b2JyY25a?=
 =?utf-8?B?YkREK2JxMXJONitCaEtEcFlXcDVJWVR3dUxzRWFDa1ZtRzVPR243ZW5qVzNP?=
 =?utf-8?B?aFoya1hHZ2ZRYkZ4OHZPazNjQ0pUdzNKWGFZTXJrV242bGRuVFBta3cwSzUw?=
 =?utf-8?B?ZUFNSkRLQVFvUERCd0c3djNGcnZFeC9KR1QyenU5Q2p4MnA4NTB2WC9UeFB0?=
 =?utf-8?B?QjFmcTFhUitWallYdno3RTR1NHEyNzAycHlWMCt3ZUh2ejJNaTVrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ce035b-d228-4321-4069-08da321d46f6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 00:37:35.4685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzyKm3IUuqXvdXFqqM4YvzjRfz9aPNHPjvsaBfO4w39eAOLwPeyPDVC49aC3NPoFrK5rk+322bg7xW2oQP9Gfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3960
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 19:33, Jerry Hoemann wrote:
> On Mon, May 09, 2022 at 03:55:54PM -0700, Guenter Roeck wrote:
>> On 5/9/22 09:33, Mario Limonciello wrote:
>>> If watchdog hardware has been disabled, currently the kernel driver
>>> will show at err level during probe:
>>>
>>> "Watchdog hardware is disabled"
>>>
>>> This is unnecessarily verbose as there is already a -ENODEV returned.
>>> Lower the level to debug.
>>
>> Is it ? Without this message, a user may try to load the driver,
>> get an error message, and have no idea why the driver was not
>> enabled even though the hardware exists. If anything , -ENODEV
>> is less than perfect. Unfortunately there does not seem to be
>> a better error code, or at least I don't see one.
>>
>> Guenter
> 
> Coincidentally, I was looking at this code on Friday.
> 
> Some HPE Proliant servers are disabling the AMD WDT in BIOS.  However,
> sp5100_tco was still getting configured.  It was the lack of
> "Watchdog hardware is disabled" message that helped clue us into
> what was going on (Linux is enabling the WDT anyway.)
> 
> So, I liked that this message exists.
> 
> I'll send an RFC patch for this other issue as it orthogonal.
> But just wanted to point out the message is useful.

I personally don't have a problem blacklisting on a system I encounter 
this. I take anything at "err" level as there is a firmware problem or a 
hardware problem that should be looked at.

As the message is genuinely useful as Jerry points out how about meeting 
in the middle at info or notice?

> 
> 
>>
>>>
>>> Reported-by: ionut_n2001@yahoo.com
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D215762&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C5eb5f65caaf241d1515308da321cbd10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877396427792688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tqQYyfwbGK%2BTvTxlkef0I2iKyLe8WsOjxskA0SQPlcw%3D&amp;reserved=0
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    drivers/watchdog/sp5100_tco.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
>>> index 86ffb58fbc85..e51ecbd5c8b7 100644
>>> --- a/drivers/watchdog/sp5100_tco.c
>>> +++ b/drivers/watchdog/sp5100_tco.c
>>> @@ -286,7 +286,7 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>>>    	val = readl(SP5100_WDT_CONTROL(tco->tcobase));
>>>    	if (val & SP5100_WDT_DISABLED) {
>>> -		dev_err(dev, "Watchdog hardware is disabled\n");
>>> +		dev_dbg(dev, "Watchdog hardware is disabled\n");
>>>    		return -ENODEV;
>>>    	}
> 

