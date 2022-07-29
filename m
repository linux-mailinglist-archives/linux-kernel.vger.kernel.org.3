Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F2584F68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiG2LOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiG2LOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:14:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA3868A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfR/1XCYNmn+y2yKIvmFFO47aQHGiHi49NVhcNztBr6TSepWA2WsNk9/RZOyQmi0HxjCwX1umvm+PLoDEW4cutdNhk0qHI4QqtHIJMck9Z8oMrGKlpagRrQucQTHOzNWbFpAceeuNxWRa2aqT3QxBTfbq3Eaz7aMNA6wp8eX33QjVXbSTe3dHQt2ZvFtYtknYSaaEv8o3o/de6fpH+QT+e74EuX7VMDl21iVWySyaiXmLs9x0OHm0heaUlV4xjpiBy76Zb+CP7Mf8/uGprKu9sqwtGNZQOHsop7BLLAQb+rUFYS/5ZavjmMm+PZs+ifn07MVdu/fyaUPFkIvA7MwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KkAVWvN6eaMMM3GuewAtnC+RKUl53RGPl1WvIQfNmc=;
 b=ODgv8rYpV/wl0riz8pu5B8DzPaNW09N1r6pruUcWd4dOEMq7UgOH97E9j2sudLT10m1dzoEXQihojByGS0P2LVTVzI2jBoWfqFz+p9k22kRaUcpaOxtsjXOX291vKRIRTfYg7xZLcAARd7PhGoxcFI5Jebx9oyQHFmprhulhiEkkZwuujq8ffgd/JyTNN+gVyLPnq1ot8XZH7J1lne2zFKCcUlP+dthGnILN5PK7WV63ulP2oeExKQqlITziJkxR6zuLrLfczueOgJDs6zAfqMzKIanaRCSv72wZpAsTW4+xtapdFBP2grgk1ZpQIMvZwQhFz25QwJQbv7klcl/ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KkAVWvN6eaMMM3GuewAtnC+RKUl53RGPl1WvIQfNmc=;
 b=lR5LSxVaNWjaLRVNwuHBiOS7x46rjqehp4Pq/jbMb6mgDcKYqYnZLlUclFeivH+OwslyswqSXakQ0Z7ycG++jubsW+V2xov8f6T4cemrohqGrx7T4WACNNRdorbLkOznGS36JiMpfcq/Ta5FHDlNTR9RFpHszhC0JiD+Jd0Pu18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Fri, 29 Jul
 2022 11:14:36 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::ed9a:b809:1f3c:1e7f]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::ed9a:b809:1f3c:1e7f%7]) with mapi id 15.20.5458.020; Fri, 29 Jul 2022
 11:14:36 +0000
Message-ID: <a006610c-f02d-4286-9187-1ffdd5759c81@amd.com>
Date:   Fri, 29 Jul 2022 16:47:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] ASoC: amd: acp: Initialize list to store acp_stream
 during pcm_open
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        vsujithkumar.reddy@amd.com, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220728124057.54259-1-venkataprasad.potturu@amd.com>
 <YuKF4l68sLKkjcmQ@sirena.org.uk>
 <3d351235-c11a-234d-7722-447b4f0442e7@amd.com> <87sfmkp520.wl-tiwai@suse.de>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <87sfmkp520.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae2cfee-a598-4b91-aebb-08da71538579
X-MS-TrafficTypeDiagnostic: MN0PR12MB6245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXvpjCjHS+vfOoirmB60x4zqqJwb8zHvVjYPnW1gjxvPE4xz9Y2kARMpjgmGsdBOnowwNgmqXogAl27XVlNh7b0RVJrlijMNLoRz0aSi7tINullDOKshnJa3VlupUdNPNj7dOByTOU6nwCMWiKfWmuRQQ1hGqpnPF5tJdEEPHpTRQfrfh94O3DZFnhu+GwBZwiloyPQ1eCOij+jTwpFwhJR52d++Zkfy7Znx4UKxZo05U997HrWNNh9j/zC3TQbO5QYelj0CPC+IpGzhuEKcu9M3bEg9lMIRW+I3CRmrcb53SyZfsIz7+4UBE/atDNB9JYSqQnz1XTRv3e6PUGaoFrNgOecxx62YRb0fA8F8UYzvYDPv5S/SRIGg8o1q9G11a0iLmwS/u4bHtWLSTuIzhNGn7CCFxkCkIwGmcB8jWa9ocwJYhnkizP4kcHRLQ1Y+J6cH/R5iww6l4ZepDTvdueeK+fkZh8AfgntQz+nTWztMTwUtFS1Py/AgrbGP1jQSZFm6tmYQEb1wpFFg4XMf7s/glhoUZRQZvTR2qu+qjPDxd8pXy5TPlwaP2sbQIUw2+NPV4L9mJmtz2v7GpP6Zj/jSfJR3zyDHWsLlBjHCk4mcXlhZAvjDXztFDOJLSM9+ZV3CNgAzL7K3V3CeWmGQs2MOlh9QPdr7UaTZQBPYbe5mi8yJEI7jaHpb0wnVqTzKUj28a268ssj9+D5ZdL0rQpJQ3Vq8r0DpG382nswEknwDx8z+fWpZnrszqVvL9NDhaK5RbfMb7Z64BWEoKYCxq7umQdBIoJarwBMy7EYHZPeVUlYQsF7jSaJCxxEL5DVLFHNe3UgwuEpmDuNXkG905w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(31686004)(316002)(66556008)(31696002)(54906003)(66946007)(7416002)(38100700002)(6916009)(478600001)(83380400001)(36756003)(186003)(41300700001)(5660300002)(66476007)(6506007)(86362001)(8676002)(6486002)(2906002)(6512007)(2616005)(26005)(8936002)(4326008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzJFNTZjWlFEZmRBQnUxTFV2UjArcFBsM3BMbml0U0FYeFErdUZDS3BJeFp3?=
 =?utf-8?B?N1BKT1RpaTNHL3dTWDd0bWpnVjJNTnBVdzRJTnhBeCs4ZFBHVXJtbXFsSGc5?=
 =?utf-8?B?NkIzVUJreVZQcmMraEtJSlU0bTZJQnVGbElCaSt1c0FlN0QydnBoRlpJamxw?=
 =?utf-8?B?M0ZmZk1ucS8vU0lnREJNbTZYUFpFZEpVUlZwdWNtRUlFRGhZRDE5WkJkZENO?=
 =?utf-8?B?YnFzVUJ1aU5SeHNGeWc4YndYcjlIVlNSMHI3T0krV2NkK3ZJdnNzbEg2V1Qw?=
 =?utf-8?B?WUZxTUpZQXhDYUlWOFc4RnA3M05FcTZOWUdrbWpVZ0k4amI3T1pEVkVncEs3?=
 =?utf-8?B?SHZyd3p1WFRYaDlMMWJEV2ZXcWNJV24yRlp5UU0rdUpVZEpZSXpGNEZSR0tQ?=
 =?utf-8?B?WmJrTUlwcWFvdHFLREI2Y0d5MkpiN29ic2FXY3Y4OUVjR1JTZDR3aytsK1dv?=
 =?utf-8?B?ZEpXZVIwblFqN2EwZmVYeGloN3Nza1lOU1N4c0lyQzc0UmtZc1l2V1hPTU9E?=
 =?utf-8?B?VllENHZOeE03ZTIyaW9kdWpubTBWSlhyRElSRmdJdVpOTDZmNi91K3BPL0kw?=
 =?utf-8?B?bVVWNWZTWTBZdUsvMEdwcmZOMXZMVzR5Mmg1TzJNNXVVR2VwczE1Nkw4Q25w?=
 =?utf-8?B?dUpHYndzSGNYaDQ2NnFOc3dtNVlFbmpQZDJRekpncmVXOEZEekRHRlEvSmZi?=
 =?utf-8?B?NnRhU1daZGZ0Q2M3VktNN1VkMjlqcmEzWmo4aG1MdS9kSkF2TkdVMEdUSkUr?=
 =?utf-8?B?R2ZiVjJxNUJ2MGhEbUZGdjlXM3YzanJxK3d1OFJsT25QYzJRK0FrNy82UGFj?=
 =?utf-8?B?dTI1cllQbUxUQkxDNDNRck1MNzhqSGRHYk5WWldNWU9YOG9TbUNJR2s4UC9w?=
 =?utf-8?B?ZWlTaDFvM0NUclZWcHlFMTBvdVc0VjlDL205SWtzNEk2a2UyQ2ZTaUYxckdz?=
 =?utf-8?B?T2YyeFI2aUN0bms2eTREWEg0d3BBbTdIcHYwRDNnaWRORE95UkR4cjlIdi93?=
 =?utf-8?B?RjVZTyt1MFBFMmVTV2RzcUxpb0xHUXY0N0piQzJFb1ZLYXh2cHA2c3dGbmx3?=
 =?utf-8?B?WmxFR1lveU4rcFZ1cnY5cWZmS1czUGxGRjZQb1U4U3RJb01xbngrd0dGZHAx?=
 =?utf-8?B?WERqaVVydk9lNmsxaFZpaUdmc1ZnVC9OSW1UWjB5SmpMUm4xMzlsMTltY0Vm?=
 =?utf-8?B?ZWVZbFZMRnM5UjVyM2JScldyNUZibzFiSmZISzF0cVlXQzZzR1B6bWN6UzJm?=
 =?utf-8?B?OEo1MEJRWUJEOTMzU2pScEhpTmRwaDZaQ2NJOFpZMkNZQ0p3S3lUS09BWTdn?=
 =?utf-8?B?UExwR1c5NE1yb1RLM1dvL2pyZDJjNHF3dmx5YkdndkdGNXNIVFArdm5uWHBm?=
 =?utf-8?B?bnB6c3Jadmh6eGFYeGllZ3RLUTh2UzFZSG5XYWJLWExwZVlZVi8rWnZjZnV0?=
 =?utf-8?B?c2pEQXQ1RTFzTEd1aWx0MVQvaWVBdUVJcmszd2pEaTZuU3ZtWFRFYmdpNDRI?=
 =?utf-8?B?NHovNHA1c0YwRzZ6enJnV0dNa1NvUE4xcHZ5YUNIK0dRMlVobms0bStGVjNr?=
 =?utf-8?B?eXZFM3JoKzA3ZktZRjc3aUpHZ0JiMUJLVlMrWHQzby9uaEJvS2kySTU3em1k?=
 =?utf-8?B?M0RrUXRFMlBka2xBQ09Zb0p1YktoOFVJQUdWdnBUL2lLN2ZZWEM5ejhaWWY2?=
 =?utf-8?B?UERjczRYNGhiQjZSNEdRVVFBU1RtVzh3eU12Y0VFLzJ4alI2aEsyUlNaTnVG?=
 =?utf-8?B?U0VjMEhTS1Y4Nm82NUxVT3FMU0M1Z2ZqcW11U3M0YTVGdkVVQ0xuNlBwZko3?=
 =?utf-8?B?cVI2Z0N2Vjl3RS9GLzIzS1N0T0lRQmw1Sy9UbjhiRWJwNjRKaThhbE1ydUNa?=
 =?utf-8?B?czJTOE9GdnpNVmtrRG84dUtvamVidlQ4VE81TWxHZnFKbmpQVkthUEhCOWFF?=
 =?utf-8?B?MFFicEtBNGczaUY0WG5ma3pObEFTMk00MlJrd3BMajBXVFpxMEpVU3lYdEhU?=
 =?utf-8?B?YXBuY1dZSTlBS1o4c1hmZkxmNUMva2VnVklXcTJvWjdRb0tWMzJnaXFDTWJt?=
 =?utf-8?B?L1hSeXN4NXNpZHlFU24wRVF3Uys4ZE5mMXZFbktkakUyYkxOQ29TeWRmUUVT?=
 =?utf-8?Q?UVJSteAjc5J5ppo4PngMqthRV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae2cfee-a598-4b91-aebb-08da71538579
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 11:14:36.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbpiKGFnVhfO/SvYGtxP6XpxSOR9NRrhMN4gnp6RJU+JA6gEyQyzqfujARuUCxrdqXepeb3FmMv2EOuOHJdpeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/22 16:19, Takashi Iwai wrote:
Thanks for your time.
> [CAUTION: External Email]
>
> On Fri, 29 Jul 2022 12:34:51 +0200,
> Venkata Prasad Potturu wrote:
>>
>> On 7/28/22 18:19, Mark Brown wrote:
>> Thanks for your time.
>>
>>      On Thu, Jul 28, 2022 at 06:10:50PM +0530, Venkata Prasad Potturu wrote:
>>
>>          @@ -104,14 +105,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
>>
>>                ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
>>
>>          -     for (i = 0; i < ACP_MAX_STREAM; i++) {
>>          -                           stream = adata->stream[i];
>>          +     spin_lock_irqsave(&adata->acp_lock, flags);
>>          +     list_for_each_entry(stream, &adata->stream_list, list) {
>>
>>      If we're already in an interrupt handler here (presumably not a threaded
>>      one) why are we using irqsave?
>>
>> Yes, your statement make sense, I have followed below statement in kernel
>> document. so used irqsave in interrupt context as well.
>>
>> We will change it to spin_lock() and send it in the next version.
>>
>> statement:- spin_lock_irqsave() will turn off interrupts if they are on,
>> otherwise does nothing (if we are already in an interrupt handler), hence
>> these functions are safe to call from any context.
> Also the open and close callbacks are certainly non-irq context, hence
> you can use spin_lock_irq() instead of irqsave(), too.

Okay. Thanks for your suggestion.

We will use accordingly.

>
>
> Takashi
