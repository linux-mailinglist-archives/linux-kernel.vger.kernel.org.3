Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D944E4600
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiCVSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbiCVSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:30:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A96948F;
        Tue, 22 Mar 2022 11:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEcEp/Cc7JtvnXRowAoDjuz33BU0GgW7QkpJH2w5YwaesIlP1eOlwSuGGX4+FBT4eYIVVbBA8cyKtwzAEC4DETp2TV2of0Rha4Ft7EM8aN47dEXKVEmE37Mc+rwWvWPlCeBqC+vxjPpTTfzcOSbAAW2i3ZpUnRR+aqIwUxK8rppHii4lKan09QFpyfZyoJDgQGLS674cPNBuW9JXDN5OsWuccvMfPyPf7stjgh5mFtkSBOWOJffXAmdNAEkRN0zEMzqSIMZ673GnncEwYXTfjffWWaclvvuVhxg1Tc/nPL4sUlWZppewPJdK9pw/McaOc8J8twjPZm/fjp1vadQOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/q15tuX/Db+KEIdTPjpnRcqQB8uSUBSo3nuBwPD4a0=;
 b=nT/XHwjDsDU32+qkWJ71TGIyVrEFuJsdvUzUBXaU/Y/W3+buljMz7QEqF1W1lDHClTcoOvpI4HT/9xEQUJbKWLVC6ADfFxfWIDjszoM84g/fQQ2ZMY4jkTbowcbo49eAFHfkjGK5I2xxE3zySvIcvtet6QG+16Ck8rckLShq+vtMU536Q6hU/lV7njUdooXAz/BDSL6zHMnHvenu1GdYeZiQi4rZtHCfIn2w+sv8eJAlDswEEECuLyeyltjA9aYXc2HMtgZ5Hoz6qO1rodULlk06yeOc9uCXwt6vYx7ukd72zMYY4BCmWBEJQ1/6e1CkRunqyml3vmcZ/fKUs3Mz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/q15tuX/Db+KEIdTPjpnRcqQB8uSUBSo3nuBwPD4a0=;
 b=N9Khxq+OkUOKUBW1u5xNkVKZkUFThu+IZAximJDb9BoQM6B93eMxp8Q1gKutdxAAUYo+J2v+uz5lsTQuDM11b3y0o59Y+SnvUUIW+6EuycIfl4yBpjsJ78O9pXmczFEPns+4hnpYbtdJXHBcbuNmO0ofQW9NS7/e0vfIlHuOpnLH1/liXuzM8AYLDNqcTpvQ3AeNKaAKvxBvYPVRvdL5St3+u7UjIC3Fhnk2m3N/2Kiw9LIMDirlboDv1FYSCWprA9b9HP3/9kVXJ1xWh/SugQISHvziCwowi/SHW7uX6b+4PhEEPBTpjLvJ0918rBmxjmaktF/Fqbg3EG2B/dywDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY4PR1201MB0070.namprd12.prod.outlook.com (2603:10b6:910:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 18:29:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 18:29:24 +0000
Message-ID: <a32c7181-79b1-07e7-81c5-9c692e4f958d@nvidia.com>
Date:   Tue, 22 Mar 2022 18:29:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mailbox: tegra-hsp: Flush whole channel
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220302150424.1305301-1-thierry.reding@gmail.com>
 <42f99db6-f450-f2dd-fccd-17868b16b561@nvidia.com>
 <c84a0362-8cb0-2925-5a74-ad9c6c3ffe5f@nvidia.com>
In-Reply-To: <c84a0362-8cb0-2925-5a74-ad9c6c3ffe5f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e03d71-85b3-4642-93cc-08da0c31e39a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0070:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00700B6A9382F6C107E47A14D9179@CY4PR1201MB0070.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jWqVotR6o2yEoF4hNR1LgJ44Fnpma/GtmtGdjzC8zF0CV+O3JtD1MyZPMcXvg+Bd1SALxK+49zBVNK8NILvyit2GGX1XrtNvma3A9692rJ1y3l0a3snQiee6NCzEzLS5RB1W1Ucq//PA5dBTZw3nVUJ/XKP4SbMJ4zPzXqRQyN0vyMMLCnhdffLwRs2IsGeCvoOgbStA+tywd9IuGrdlHLfHAqU4pHYinlWcvjjBOJ3ql4bQ/4QPWVHYPBzQ42VWSoiQn8YbTrN+TQZOEOrOyZVqv3UoGouCUS0yuaxvlx2TRO9mtfLpqeFRU/5h0d7C5BJdovaJJ/WUtOZ7IKrWtgY3gDQr5J9RdCVlA8aUgl7fRnZCuIVgn0cymeP4tLvD2sfec5CYw2slpb4yRZw5Ac9FP8rCREGQ8kLzOaM10sdK7GrpsPPysoHyDgz6e6G0ucFPPcutf8dwkUwp43YWMyX7pkVRYvAIaBm2+v5moUqLHOUVW8LnxHJJGqKnrEGWj2NQNYDebN9/TbdP6HFr/DB6fMahkr1f0nw7OJHDcgUz3HstbYh5ESmFmmOfveqiYSZgTb4GQT/PZaPL2mY6csrkSRZglqMeH/qnr81POZAFUFINhT0kkBsk7VeaYmGnICeL7Qzgaak/6Qoe6SApb9Oa/Q466MH0jfvwZjmNuXUnKfts/lk5coPHi+w6Iyz887vCGhpLZMmMMNqoGkEFk92m/+UfzqS7XAsg9U15bKtX5s9adTy1qHS1jTzepJu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(31686004)(15650500001)(31696002)(2906002)(316002)(6486002)(5660300002)(8936002)(508600001)(110136005)(53546011)(6506007)(36756003)(55236004)(6512007)(186003)(26005)(2616005)(8676002)(4326008)(66946007)(83380400001)(86362001)(6666004)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JPcE9ZU01ra1oyMFB2MmxFTGk4Z25IbFA3OHUwdlkvWUxQU2N2dEo4RWpw?=
 =?utf-8?B?RWswZmxRT3lQRjFpYXBkYWlzb2VHaHN5V3ZUMTlMVTVXYWIrYjZqaTdPWTlt?=
 =?utf-8?B?YlpPbUZxNnNac0tQazlZd200Unh3RWRORER4bzdUUnIzWmFyT2NtOVI5TlFM?=
 =?utf-8?B?RUNkdDNwSlQ4a0VMVWtOWW03R2N3clFUTmt1MFVJeTRQYVhCaHZrbk8wL2lJ?=
 =?utf-8?B?QXlPU0RxWVBkZHlQemNILzlCdjFoMjFwVkR4dWc5V3U4MXh3ZXFSdHp4L0FX?=
 =?utf-8?B?U2lCUHJyQkQ0VGZleForbkZSUGYraVNPcjlab20yR29RMlQ1SmVUcGRzN2U4?=
 =?utf-8?B?RllOR1NwMGd5OUtrZUx4K29sbElIdzVkelQzRGdEelFiTURTQ2tLQWl4ZUMr?=
 =?utf-8?B?SSs3b3RyT0FZSGtPODBzWEEzWjhJQ05ZMjZCS0ZIUnRLN0xkaVNLaVcxbVBP?=
 =?utf-8?B?aGhkMHFKa3R4bG4zYnhwUlVvbmdXdkRIaFZ0SGFJVys0aXJHcGE2L1lvemVK?=
 =?utf-8?B?Tm56RkVPUkVhdXd1SHFVWGhoTVlnS24rZHdSSUIzeThWTm9udzdXWU1KYnlk?=
 =?utf-8?B?bFNkNXAyQnV4bWRQSGpKMTJsTVVUcDFMN0FjZXAwcnhoRG1mR003czZrK2NG?=
 =?utf-8?B?dG9XV0M5OVJEYm1HWTJTUXJUeDczazNoRVRSY296dmsyRTM0b0ZLYjRHQ1oy?=
 =?utf-8?B?eGsxVnRyUkdmZkM5a3VQbTIrNzJNU05RaHlQMm9NSVBnZzdQUU91TEhQWVNi?=
 =?utf-8?B?RllEQ2FJODl6U3RhRCtmdzBPUEsrblNjMmtkSU9tQ0FHd0R2SmZML0tUWTdU?=
 =?utf-8?B?SWc1QkE4cGNucDB0S29mVDNLT3VIbFpZR0h6RnlQQ0VWYWNQUmlhS3FrbjF0?=
 =?utf-8?B?ZE1jSVFwQUJ1ZmZnMFhzVUVjeFZQOHlXcitteHYrU29ubGNHQ1QydmpldkhM?=
 =?utf-8?B?STJCNmFqaVJ3dWxiaGdJcGZmaFRhQjE3U01Ca3ZnWWg1NEQ1U0hvV3pPVzBY?=
 =?utf-8?B?MWdlQWRmMmlQQnkxaWdzZ2tYbjFwTURsOCtFcXNuQzAxV2hjSUs5WDY3cWQ0?=
 =?utf-8?B?azhEd3J3emE1MDVGWUV2dWpMTDAyY3FmRXlXMUpMamdMdFNkYy9zSExpbHVT?=
 =?utf-8?B?YmhPcFErTGVpaHJQUW15Yy9XR1BuUVpKMzEzd1VlTlc1RklNdHdUTWQrOFFG?=
 =?utf-8?B?aGJVZXNiTm5YZUhPUUZLbHFteU8rMktObS82WXBkRi91TjBkQWdhVnVJS2lD?=
 =?utf-8?B?KzMvcjdIYWo3bzRVSEFJVDkyN2kvN0V6dnRWT2t0UDZnSTBrN09EMUxKaDBP?=
 =?utf-8?B?NUdVSHZHd1o1QnhTdmVGSlg2R0FLcnh3bWFOUEVjOThabXNMZXFBZGFWVTdS?=
 =?utf-8?B?VTVxU2lRUWh3ODgvM1k1TVVTUmoyelZVamViK0lJRS9PcGNPWlNkd0ZOTlBq?=
 =?utf-8?B?TDlMaGxOQ0lYczBjeTBySUVJKzVLT2l6T2RYMmloaG1uL1hoME90RTdnR3Q3?=
 =?utf-8?B?eTRIY1Y1a3VXTW1nOE5EWUhOZ0tmZ2ZSc2VvQ3g3N0xLQkFwNWxnOGpSUG5R?=
 =?utf-8?B?cyt1QmZHU25qQko4UllEQ0JxMWJkNHFzU3FSaElSUlkwaklBWUh4UHBQV05R?=
 =?utf-8?B?d0VYdjRIc1daRkxlVlduZ1I5ZGZZZys0NDFEZE84UnZXTy9XMVkyaS85Mk5U?=
 =?utf-8?B?ZnZlMFVBMm5LUWhlelRxT2tSR2I3MDVzSzNOcnpBSHp2TlhRNTRmbG1XdzZQ?=
 =?utf-8?B?SEp5OUh5dDlhZmlvNVN0Umg5M2JNQ3RIak1xaWtpeE4zSEsrT2RiU05XcnJG?=
 =?utf-8?B?c3k2OFBzRno2YmNiYjlZTlJJRGNlMHZDcU1tSmhnVndleDFvbXhhRHpUdWh0?=
 =?utf-8?B?TWFhdjg1Vy9VdmpWZXVoOVBWQTlxczZFSktZbEhSRFNFV25ieFkyYjRBeExt?=
 =?utf-8?B?bjcvN3c1L0gxYzFMVmNQaGQ3N2NhQnJXRGg2RDdnRjNCL21YNGJQOW9wcmY1?=
 =?utf-8?B?MmRST0s0aldRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e03d71-85b3-4642-93cc-08da0c31e39a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:29:23.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60/kE4CoQHjwqfVkYxNqCBNGVd3PZRs/e0tJywTHTsiC0oJzLv7zJHaLUZqLRdATXCJwv5V8maNzbVq5LVwmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0070
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jassi,

On 10/03/2022 17:37, Jon Hunter wrote:
> 
> 
> On 10/03/2022 16:51, Jon Hunter wrote:
>> Hi Jassi,
>>
>> On 02/03/2022 15:04, Thierry Reding wrote:
>>> From: Pekka Pessi <ppessi@nvidia.com>
>>>
>>> The txdone can re-fill the mailbox. Keep polling the mailbox during the
>>> flush until all the messages have been delivered.
>>>
>>> This fixes an issue with the Tegra Combined UART (TCU) where output can
>>> get truncated under high traffic load.
>>>
>>> Signed-off-by: Pekka Pessi <ppessi@nvidia.com>
>>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>>> Fixes: 91b1b1c3da8a ("mailbox: tegra-hsp: Add support for shared 
>>> mailboxes")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>> Changes in v2:
>>> - add Fixes: line
>>> - Cc stable
>>>
>>>   drivers/mailbox/tegra-hsp.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>>> index acd0675da681..78f7265039c6 100644
>>> --- a/drivers/mailbox/tegra-hsp.c
>>> +++ b/drivers/mailbox/tegra-hsp.c
>>> @@ -412,6 +412,11 @@ static int tegra_hsp_mailbox_flush(struct 
>>> mbox_chan *chan,
>>>           value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
>>>           if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
>>>               mbox_chan_txdone(chan, 0);
>>> +
>>> +            /* Wait until channel is empty */
>>> +            if (chan->active_req != NULL)
>>> +                continue;
>>> +
>>>               return 0;
>>>           }
>>
>>
>> Any feedback on this? Can we queue this up for v5.18?
> 
> Feel free to add my ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Any feedback?

Jon

-- 
nvpublic
