Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA459E3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242430AbiHWMmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbiHWMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:41:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60115.outbound.protection.outlook.com [40.107.6.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B009E125
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQKtI9a5ePc3ldCfB+65gAJX/uZJaBNvm/x8qiAigZL3adYHa/y7VMu0col0fiiWLTxWQCbVb2M9cTgS0J8JmdLNR43ufbaNzXn7DH3qYDGuaFsyxKWYlY+wOsOij1brPUlo2Zcs6+6FTaTt9LC5FTuaudPDeAAzVTVXHAjeYqpyqegd+fWPIh96U1Xflos3G+NzIVATvV/XctmreaOLAli0NJh610C61l6nKr5/FbSqiDF+AoAip41NKKjCL5b2AUrfBEFqIj6rUqBZEznaspZus6H6Bzzyh1mNyltpmaIiLdXPdTJjl5MtY53HTKCFV9bZjfaGK84tMHjI+47QZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8y6ANDvYwn6vz+8PKybEOwTLHKRHUisoGYkocOj16g=;
 b=TBJoa1XTOec/sGsy7DUMCTffB8OOuWP2KuDgPINCh5Kk1n/jPMJsGSnmq2yGjHzvys+HJ5j3LtgNUdvpBInESni+1JJ9aOHBXoEy3//jyMl/iCUBwIMZqAnex1LsJ2FxWC0fEVGbD59CcgG9Mphp4yd3JNOF6kD/3zyt1o/C1GNf14DC+o03mtxAQMGjAxsJPuErZI7rvgLfcL5OIfyBUt9TsuWMQUMN/BmWIEktKQWr2uzLFXhCDLt9Wgutuo8+KY+zTSQq8wYGQzTLaBirKsynQBbSTnYYsyL+IIFUJa3/Wmm41rA6SG01Sk0fglMQh2pogkFY7z9LJD5QxjXqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8y6ANDvYwn6vz+8PKybEOwTLHKRHUisoGYkocOj16g=;
 b=RqjMxZkGcU8gQqKF0flioaSo+EetImimFh17NKvkGpz0OOmqsyovQa5sXyGbEM2m6DBZGiwYo2ZSjCoXcBDeUnXE7mVCfhNLFU/MHabQH3Nb4LfhlMSYpsFRAWG0oaZTQlsqgldoNQtIkw1HTnIQm03M9x/AKD5UCUMVfoBJvls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB5114.eurprd02.prod.outlook.com (2603:10a6:10:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 09:51:03 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::1d88:3306:c280:3179]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::1d88:3306:c280:3179%6]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 09:51:03 +0000
Message-ID: <eacfe142-7f60-d938-4421-4d7b464759e8@axentia.se>
Date:   Tue, 23 Aug 2022 11:51:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] extcon: usbc-tusb320: make sure the state is initialized
 on probe
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Chanwoo Choi <cwchoi00@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Auchter <michael.auchter@ni.com>
References: <ab1ad93b-4d39-8863-9704-da779fc4c426@axentia.se>
 <c6d43dab-57bf-7041-9a5a-345fa35ca0c7@gmail.com>
 <38ab6884-d0a9-8acd-84cd-dcf6f3f40bc8@axentia.se>
In-Reply-To: <38ab6884-d0a9-8acd-84cd-dcf6f3f40bc8@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1800c84e-2b80-4480-1f5c-08da84ecfdc7
X-MS-TrafficTypeDiagnostic: DB7PR02MB5114:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEWxTYFuePsfIvc09vw7XP9sMOEOT6HUrIkyOS123DxGKnYtZHTEqqZucc+u/kyGqNGqfWghDTgplNDvHm4+/DyBdFyYGFJeTNwunyujJG8T9uBFEGWJdc3R7/u3AaX2aJGB3b1Ugk6Huj4vUfEa+3QRe41dRn/mspS3w1uN1xcJHzPmErwykRNB6W0ujp8AXipQfG9DozKx/IqMMrFfCsk6Vxb1+kCR/BdRF7FMki+vzS40XTGU0kWuITDh6XBw6Nm1JPbZhHIQyU9Uav4QqXV3Sme+xY3zO7q2BJUEkIt/J03FYYlkt/tGuRWHYgJt4TiCKVGxF+C7SKCdJfzTbj/TCiomJyNKBMu2vLKAB3tGo3undww6Wgr907Sk8+AfbPdTSQ0syTzDZxK2Pn6P/+jgXU4vjiDbrrKilKBXpLSYFBWi86h255d0kuOLMEhE/qVad/fRoYoAENw2jSrRw/BqzdidkPNBS7M548yVWUMhKy/tZL7KhID0jAzOxJ+B3UupkfA4c2ZbO+GLTNQ/kezO8+MEUnU6atplVF18OOSK1jkG+oxuTbMI/76+Kekkxr85mb0c0cCXjiCfMViQbg8IdhesfTEdHczDHbscwFliCWHc4FgFI8YnL2EBYz4i9IsT5uxoxezgF6fESylyuF2T/wFgLyNeU6kWHK1UbT+F50HENC/aSPeWdfDxY8ScN/kFdvcaoEJFUGAzOanXaQvn9A6unALLRTKpVI7jPgNIK2tW35M2GfxQlM3VnuWtopILIeuImFiMssWOuRiPcHcMVjOUpahXzcCDWda7RM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39840400004)(396003)(376002)(366004)(136003)(6506007)(86362001)(31696002)(83380400001)(6512007)(38100700002)(316002)(54906003)(8936002)(5660300002)(66556008)(66946007)(66476007)(4326008)(2906002)(8676002)(2616005)(186003)(478600001)(41300700001)(6486002)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJBbDBmdzNsOGx3YS9ydDBUSG5YWGtRcXZhM04rcUNEUE5PM3dZb0dFSDBo?=
 =?utf-8?B?bzJnZk9yZWRzTVJJSlJSaWdYQlVhWk9MOVFqbm8zQ1VxVmJnZFVZVW11Z1Jm?=
 =?utf-8?B?ZEdOaVMzNndnM2ZBQUVIeG1ZckVtRmRKRGhkMkFEbmpienh1UkhiRHNoclJn?=
 =?utf-8?B?NWZwdVVaR3ZNUlZSeldQOFNObnhkTjlkWC9BbEtVNm1rRThmQXF0bGdmZFo1?=
 =?utf-8?B?a3ozT2F6M2IvQkwwTG1HZHAwYVkyTXVrUk41MzFlTWxEM1NxSkZ1NTQwU1dM?=
 =?utf-8?B?UVVQc2g3SExFdXBnYmtXTWFWcURuVFlRdXZERFBkdFovZnE2NFRBSmc1b25l?=
 =?utf-8?B?VytlazNqWkgzMmVyZFFQTzdEOHErUmhiYXFLdUdZNlRhaFpnelY0TlltS3Jv?=
 =?utf-8?B?UnVNQ0MyZm5JN3ZGYnZEakJxRGkrMmRtUytwZERIN2dleGN2YTIvZURkS3lx?=
 =?utf-8?B?aXI4RzVFUTBHMENBbm1GRTY0Y3pRdFZtTXI0ZXVSMzFnNS80VTU5K01Vb3Iv?=
 =?utf-8?B?UlpOM1Z0YVV0QWljQlJQclJKVnhrbEVLUUwyS0orcFk0QWVZdzVvN0hkUGl1?=
 =?utf-8?B?cEY2ajBNWFRnVEZFby84d0pGZEpud0hPQlF4TjRSZHE0N3ZQN3htWk95ejgw?=
 =?utf-8?B?bGtkMTNodHA4NEpGdXVoYm9PenJlTTN2bXpmbmpuL0FGZ0pkcWZaM0JMamUy?=
 =?utf-8?B?WlBacU1YVFhET1JYdXA1TG1xZ1RDTG01YWl5bGRTU1MrQm5nYndUYTBUK0gy?=
 =?utf-8?B?VkZhZDdSWURhYjRjRDYyUnRUSHJCc1lpSTJHS3REdUFUejJER0oxWTFJYjRV?=
 =?utf-8?B?aUdzOEFWWFNpUDJLVVowY1RkOWNIOTRmTkJNak1xaTJiRGdTak5GejVXZFFV?=
 =?utf-8?B?OURTUnM2aDFPSFNYeWl5andtNXJxOGFHbUw1dExESHNDTUZsbmJoRTZsb3Ft?=
 =?utf-8?B?YjgvYWQ5ckQxQS9jR0FKdStiK3cxbHk3dlkwYmIxV245SFc3SkNqV0RMdGZt?=
 =?utf-8?B?YzJvV2RRQ2F6d1Q2M2Rsa0hVRnprN3hCNlFMRXBsemVSVi9oV0Q1Y0JaSmtW?=
 =?utf-8?B?U0d4T0p3dFR6ckFCRE9vSS9jMko3UFlGQXEyQ1hPbXREenFQSC9NRy9YV2lH?=
 =?utf-8?B?WnhTWG1ONUtlVnNKSnB0ZTZ5UGM3eDUzMlBqcnB6SGlqSGplNmFLRFFOeitC?=
 =?utf-8?B?UUl2VTBXWlJ0S2I5ZEJOQWpUOW5ocDVGdE5WbGVVU0NuUUw1QmYzazFDOE5G?=
 =?utf-8?B?OHB5cnArUGI3MDRSdEJ4c1BwcHY3dmN3V2tTYUpRWUYvajRNNlNqeGYwT3Iv?=
 =?utf-8?B?b1B5NTNZa3lpUWFybS9MbFZ6a3dhcEdEb3p3dEdud2RnVGlPUWgyN2p0eVJ6?=
 =?utf-8?B?MzR0eGh2NWdEMGVxaXNveGw5OHhvTTZIRE5NTWxSWnhvSVUzODVqdngrOE9I?=
 =?utf-8?B?ZGErUTZtTytOME14ZVRHYkZQdzd0d0xoNExtS0tJL1F6amNRM3lnVWlvcGtQ?=
 =?utf-8?B?cVdDeXZYVHpjcVZXY3puRlFyU0FIOWppZGwzcm9EZnQ1bmp5VEwrUnRCTkJq?=
 =?utf-8?B?UW9JdzRlRGg2N25YaG9JY3JhV3lCTGFXRkVvMkVEREo4SUppc3VwVS9CNmE4?=
 =?utf-8?B?K2xJcGMrS3AwdDRUcDlKVnhPU2piNUJMN1p1VGZxdSt4WWtoMWJMTC8xTFJu?=
 =?utf-8?B?RXZGc0c0bXUxcmlFL0FIbmFZNXY4QytOZytEM2NidWIrellPR1d5RGEzaWtm?=
 =?utf-8?B?ZklvSlpSMjNjbkkwVVVxYTNDNFIvRmplbGhGR3lUUDNReWhVSGZ1ZkVYeU82?=
 =?utf-8?B?MzlYU1cxbHk5UVN3Umg2ZVZnVm1FRDJod0w5TDh0ZHZMNUlRdERvRTZHN0RI?=
 =?utf-8?B?SjJ4d09JNll5c2pURkZ0N3FtbnRreEw4OC9tZk9USkNvbXdJYldianFHOTZi?=
 =?utf-8?B?RzM0Rk9nNFNwV0xjb3RFOEl3bVNWZzBpcTNlTWN5M1JXUjB3SDE0RHVVQlRD?=
 =?utf-8?B?OE4yMXY4eVhSanlSTklaVndjUWUwS2F2VGJ3VnNNaGNCdzk0N0tvaFJXRjhx?=
 =?utf-8?B?Wnk3ZmFwek1BWHhPQWthT0o0T1UzK2FhWHErT0JVdThFdGd5QXU3dHRSbWxY?=
 =?utf-8?Q?43262AAPV8TYBYeUtUMf8L6QR?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800c84e-2b80-4480-1f5c-08da84ecfdc7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 09:51:03.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFAmsMbvzuprh+HBYJXubTGuVuPQiOUTWsKC1EoUPD/naF8XerHFooUmcOjb797P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-06-30 at 08:03, Peter Rosin wrote:
> Hi!
> 
> 2022-06-29 at 21:54, Chanwoo Choi wrote:
>> On 22. 6. 23. 20:21, Peter Rosin wrote:
>>> When the port is connected at boot, there is not necessarily
>>> an interrupt flagged in the interrupt status register, causing
>>> the IRQ handler to bail out early without reading the state when
>>> it is invoked directly from probe.
>>>
>>> Add a flag that overrides the interrupt status register and reads
>>> the state regardless during probe.
>>>
>>> Fixes: 06bc4ca115cd ("extcon: Add driver for TI TUSB320")
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
>>> index 6ba3d89b106d..bd3645ae0d52 100644
>>> --- a/drivers/extcon/extcon-usbc-tusb320.c
>>> +++ b/drivers/extcon/extcon-usbc-tusb320.c
>>> @@ -55,6 +55,7 @@ struct tusb320_priv {
>>>  	struct extcon_dev *edev;
>>>  	struct tusb320_ops *ops;
>>>  	enum tusb320_attached_state state;
>>> +	bool initialized;
>>>  };
>>>  
>>>  static const char * const tusb_attached_states[] = {
>>> @@ -195,7 +196,7 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>>>  		return IRQ_NONE;
>>>  	}
>>>  
>>> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
>>> +	if (priv->initialized && !(reg & TUSB320_REG9_INTERRUPT_STATUS))
>>>  		return IRQ_NONE;
> 
> Do not return early if priv->initialized is false. Behave as before if
> priv->initialized is true.
> 
>>>  
>>>  	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
>>> @@ -297,6 +298,8 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>>>  		 */
>>>  		tusb320_irq_handler(client->irq, priv);
>>>  
>>> +	priv->initialized = true;
>>> +
>>
>> After initializing as 'priv->initialized = true', 
>> tusb320_irq_handler() is not anymore detecting the external connector changes.
> 
> Have you tested the patch and observed the trouble you are reporting, or
> have you simply misread the patch?
> 
>>
>> If external connector is detached after finished kernel boot,
>> how to change the state of external connector by using extcon_set_state()?
>>
> 
> If you did test this and there actually is a problem, maybe there should be
> READ_ONCE in the irq handler when checking and WRITE_ONCE when assigning
> priv->initialized. But if that's really what's going on I'd be surprised
> when it's a variable that changes *once* before the interrupt has even
> been requested.
> 
> Cheers,
> Peter

Ping?

Cheers,
Peter
