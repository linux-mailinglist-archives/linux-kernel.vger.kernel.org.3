Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72A4E4E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiCWIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCWIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:38:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5906D12AFC;
        Wed, 23 Mar 2022 01:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpQXLD5DOel4h3bcj6mAM0eAUvcqQLTsYg846reymUxFHaNipbkPhMR5OwGNA3V0FYJGKN05kAr/TbeeiHgGkq3RA0xkJD5ZVVwrkckNRK/nhBXgOLpNIuUALvo+/gxIjVgaMMwb477M4ROiLJ0UooKnze+6fwH3jg78l9hrrPXQMS55LifHfeiGD67y/KPDQhlDRu7NbyX33rZ2qNzu2KvOqtpeFef84dYJJrSHQ2ht8w5A/GUfk3EjPcKKFwsKDmkCYYgElCX6cu1BKXMzvC5ISrGkh/TXf91U0jAUbf2iVG1aXTk6wtLuzlv2N52kN9HPpWHu5ozIqbxQX8c9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ptH/ySbCRAaFgGelQ3w3u6Li3mVuhgjDpVgFAiXlE=;
 b=ZZErHFR4WWjSrKrqnThxN+3JfH5rRJX/c3V67Z205IqGBKyI3i372PbO6onsrUvC4f8ZNEMn48flaCKSQoIf3RMOrN/hrIT1AqJd+WJXUGnNbDaZVtlQZNrVf+A6Ha82VE1hrZLxTZbclEMsltIb7/Sm3RS65MBHlBnTTZm+BFpM4e+9G5lgOgxYfLmKzDaHMV8UeU2n3IyisE9McMJtuV1EZA7cgapjxUtxce5svg3HgqpO/KfJGkZdO85nrnqPAJXVV9iV991B5A/WlfLH7lgV8DHHKpA0NAljP7EaGmGRUapeTSqP8LhNeeP9ETMHHxAqKOpE92qOEifJ9TGYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ptH/ySbCRAaFgGelQ3w3u6Li3mVuhgjDpVgFAiXlE=;
 b=S5im8BbXVJKlyN6CCsHj2g4IP71VMm8hap7fmCpnlaObJ9ciALS/CaWe6IDtAiET4zx+xSkb8WMuAL5gh6EGgTICZj7YzjKqSDwDmlIKrCROkMqUks0jPwXbSrLmd409oqVxk2ML3ZonvXhppRqHMxxtX92miraAgoP5ybrgesVFhYURCxVv2thyI3kXmuKThrLYVq/Mclmb9tfFkAebbPo50XQzXij/D4LClKYbGFmQ7LtluKeaTwT/RhOri1B9lnMPTiAM1eA7J7c24eGLCLJMgR0CN1pz1L7bAS6tUiMIHI/Qt7KrO4r5cYzRUbr1Fp1LTvFP3ultB+MF9wAxfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 08:36:52 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.024; Wed, 23 Mar 2022
 08:36:52 +0000
Message-ID: <4e07bee8-d3b2-daf4-b107-780e90b5d720@nvidia.com>
Date:   Wed, 23 Mar 2022 14:06:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <55ae43f0-a22f-b532-2476-c3afa1e2cb73@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <55ae43f0-a22f-b532-2476-c3afa1e2cb73@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b7c292a-bbbd-48e1-5e9d-08da0ca84762
X-MS-TrafficTypeDiagnostic: BYAPR12MB2917:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB291792ADB37E4CCF43950FE8CA189@BYAPR12MB2917.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQaXC12zrP9+h2yR3B1U/KomF0T6rbVrqGy2UxOTIQw7beCjTbTH86DwJCp567Giha2z4HNivsV7rXtSa2gbQTdBkf3L3gwfjUXNEGVBAeRmu3UzqE4bWXGRyKLj3RJRI5FD3cxPc15yvoEH/4C51woM6/j5xG1ubW0DZDxYilwtzE1Nqb7SwVrrsvHLS/gweRuXnV+pcSGvgm06AunaqszKNfVPeHpWUbNsegv+v1QQLYzcmXmr8tijNBAu37CUo1kUU/lKabuf5Z5ZlFstpM5ilTcGvlK5qUXeeGr8fFC5Isj9ToCl966dUl3JrR+rFiGGKo+QGGauopx2946Ym/Fh50If9nlLfBvJFZAvVKZ7h1d9TcrUI52LDqXn6EG2s+ircA5a2qNNT5zFhKAf8/JWD23gMs6qUgoJPTuufhoyqQtZiot+WThKkZh+AYl7Fkm7luzoHCEVHsP7bAXseAOjRl4R+hBsoFeVER9VsueJBwx2/rPpx7H+r22ynQhWihltpyUk8F+df7fqU9B4ALw8R4/b0v8VhjWiTql6aNrU13jMq6nrui74GkCyAdJI3O9+8U3n7thhhgd/OUVDmUOAdxh9yxjn4+i32LRDGkFT6Dp+31ZjX3oUzcBQUsk+TnNmW/f+gErFzPRKnJFSB59zr7ysvN5ixlu/u7oti7EuxcCiOR1BtVJtL3otP+usN3sje6cpks1F+m6x9MghP8T/aN730nmMZ9YFPg8ilHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(38100700002)(86362001)(2616005)(31696002)(4326008)(36756003)(5660300002)(83380400001)(31686004)(66476007)(8676002)(66556008)(8936002)(508600001)(186003)(26005)(107886003)(2906002)(6666004)(6506007)(6486002)(316002)(53546011)(6512007)(55236004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9oZXlndWNNdGRGZllZelZLT1B3bkFzV0ZveFMyL2tPdUkyam1jYVV6THBY?=
 =?utf-8?B?Mk1yb3BZTXdRZExOOUdSYjcyV3ZXSDFwUklpUUtPa29CeS9HYzFVN3poTEVQ?=
 =?utf-8?B?QXVCdldhNW9GeDVaU1J1Q2NYcmY1ZlBFVWhiQWZieFhzUkoySUdCSWk5cG82?=
 =?utf-8?B?TnA1cnhPZm8vQ2d3SzdhZE81SGVQS0ZkbWxDZWo2ODZpbWFDNHNnS2JHempH?=
 =?utf-8?B?dkkxM1JkdEpSWS9vMHRvc0xhTVpGMUdGVFhqclovb2EvWWg4cHZ0YW5SV1F1?=
 =?utf-8?B?RmRtdjdsWXZGQVNFNUxIbWYrNXA2akZiM3dOY1FmcklZNTcyc1hybDRDWmo2?=
 =?utf-8?B?c0I5Z3ZHT1IrN2dsdHF4ZDJLelNmQk4xbHpyUmh6MUwzaTlqcCtKaVlmQ1FX?=
 =?utf-8?B?S2NmSW9QRHdoODBsZlVXKzJuUDIwdDFqU0hGOXNTaXgrajNIcEtCMzZlK2Nm?=
 =?utf-8?B?TUxXdVdYWlpWVzI4Z3ZmWW9sN2l0dXF4WGZOdjhOMjlPdHliN2JPeHlkcVZy?=
 =?utf-8?B?a0VmeGxHbFc4VVpzUFlGWTVaSGFmaENUaCt0SGZOdW9hQlo5WFZSSDY2NlQ3?=
 =?utf-8?B?UGUrRWswSW5wOE81Y3paZk9QLzRDR2F5Yk9oZDU1TE5ZUUMyS2c5MUNyUmZR?=
 =?utf-8?B?cGliNmlJZ3JuTTRHcVNJQ1RDSFp5VE1Qa05nODZ4NFc5cDhzV2dUbm12a21T?=
 =?utf-8?B?V05INFdzeUVYWVVEbVVYSDZSa1AvaHU0RTkzdXFRQ2pIY2x6RTRHMXI1TUY1?=
 =?utf-8?B?UHpKVWxnSDE5eUtEVlB2c3FZQjUzRi92WnFYZHFOQlZsR1hZRlRKWjZhUnhw?=
 =?utf-8?B?cjBzaVp6TS9NN1hUK0EyMG1OWS94OWdNYlN4QXVyeVBSQWZiMVBtbE5uNVFr?=
 =?utf-8?B?QTU5bUZsa2RXaWdRYmNLekgzRTVIV0NQS2xWRk0vc2wzZTFpUkN6Wk05ZW14?=
 =?utf-8?B?Y1pNZnhEb2pJdWI1MzRyVGF3ZzRXUUo1TCtyUWhVTkRRT2tEZVQ1WHZ5RGdL?=
 =?utf-8?B?L0lyNmV2WU9TZEhVejgxUSt3Q1cvcEppNFBzUVRjVzk4UVhRcFNzcVExeGV1?=
 =?utf-8?B?eXg5WGkwV29PSlA1T3BzdUt4aTRrMXpTU01wNXBGclMwNlJvbDRZa2FleHJ6?=
 =?utf-8?B?SnVEZVJ6OUlYV3N1dWU5U24yWG8yM24rM2hHNHdUQTVJSVlCd1RKZTFmaWUv?=
 =?utf-8?B?MWkySk5xYmNEaUp4VnpYU2V4d1p5SlRYZ0R4dndhaTVmWkFXK0ZCWldacE9O?=
 =?utf-8?B?WG0rWkt1VzNxbG9WWlYzWDhzbDlXWjczRksrUGNWekU0STdrMUR0UTJBYjBQ?=
 =?utf-8?B?MjRnNWxVbjQ2ZmZOSTY4UVU2QWVNRTNGNVRGRU5DeHNzV1IxSEl5TGVxN1dW?=
 =?utf-8?B?dGV3eGpUL0dFZndCNVdheDJXdmwwaFVRM2lrbXJlRGRFelBDLzFYWFpmSFVm?=
 =?utf-8?B?Tk9GTGx2WGdlMHdnYkVaanBGRmtRd0pCVUdURDc4Mkk3a3hpcjFGY3J2Q2ZQ?=
 =?utf-8?B?Y1BTdElFNzQ3ZWZLMXRtU2N5S0ZMcGF3VVI1eFlFaER2MWcwZ01UaWpTL0xV?=
 =?utf-8?B?QndnaUZNMGFiZExtZUR2RU9Ya2lzYkEybzBWMkVHbFNNbmI4RGxhY1g3L2Zw?=
 =?utf-8?B?RUhDM21LT2VBR3RZTWVXcmdMdFRtS3RBSllsMWl1Z3lqNXdKb3l2VnJROHZF?=
 =?utf-8?B?UTNJcndJQlNQVnlaS1grUGllY1FlaFV3cmtxUUFDRm9hUm12eXJLUTFiR3c2?=
 =?utf-8?B?cWVteUF3cXZUMUp3ak5OQXBQV3F0cWhNejZRLzdYK1UrenYza2RUQkxXbm1Q?=
 =?utf-8?B?ZHJ6Q0x6YlEwYWRWQlBXM21sRVdYdVp2TC94ZVJBM0FwQVYzQU41ZENEdVlW?=
 =?utf-8?B?aDJCRWhBUVRjcUNGb2E0endkVm1QbEtlTW41dG5SYkdlSzNhTXZqKzRwVXFy?=
 =?utf-8?Q?NvnNIJzwQedC5/hHkjuevy+G65QmDMma?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7c292a-bbbd-48e1-5e9d-08da0ca84762
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 08:36:51.9889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWl9fR7XRjiMEyWe/7OptNyMfxfkBUT3gbIwWBadsN7pFbrGPbQYt07JI3smxS3wyJ46aIuoftvB/4clx6XRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2917
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



On 3/20/2022 6:23 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>> +static int tegra186_mc_get_channel(const struct tegra_mc *mc, int *mc_channel)
>> +{
>> +     u32 status;
>> +
>> +     status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, MC_GLOBAL_INTSTATUS);
>> +
>> +     switch (status & mc->soc->int_channel_mask) {
>> +     case BIT(0):
>> +             *mc_channel = 0;
>> +             break;
>> +
>> +     case BIT(1):
>> +             *mc_channel = 1;
>> +             break;
>> +
>> +     case BIT(2):
>> +             *mc_channel = 2;
>> +             break;
>> +
>> +     case BIT(3):
>> +             *mc_channel = 3;
>> +             break;
> 
> This won't work if multiple bits are set at once.

I talked with our HW team and they said that it's technically possible
that interrupts can come at multiple channels at same time. SW can take
care of this by logging interrupts at first channel and then clearing
bit of that. Then take care of interrupts from next channel and so on.
I'll update the patches accordingly in next version.
