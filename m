Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B275D4FB4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiDKHbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245398AbiDKHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:31:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28D3D1E6;
        Mon, 11 Apr 2022 00:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADev/H3AjXKUP7Z7E9khIbEBEEliKJTQBU80Wp4dQAvwz6Iyoxe2dg1UaTEaiIIprP4jojceIbiIFZCQC/VwOVyWVpWgdvlQLtA7AQziLas9sp+qvkAgP7cp0QzzAeARH1UIwD9aR2IjRroXKnrmbdG5CAZ8VogoWeyBnwlUfbR4qT3COGJdANcMte1MQDMo4xOTGIxelvJhry4mq15+zGqD0PGLZh3NF5XbSa12EiwFG9cvTjeNuUTZJbus3JkS11HsV7j3AMZz8ivORxcYqDLGRlWtqXhrtyvLicH0tL4dd8n9/gm4HME+0U3G7d/JKD3XM4PL49ZezgQXyILULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+4H9HkC/jkCF/kKmK65dJ3PgyNhu/9xfKCXZMsJcx0=;
 b=ffi80KH8YO1ZFL/UaLYr9XJjjkTalqVi4fiyoUiGRo3c4PcP4kDP3oh2AGdRA9ckLBScLbidVWqMb7Kwlp8eSyrRELOvqurhZPdNLmwew5olTlL+lt3h8GCBuET0Na8UdOS2siBDh142nupwoJdUifkc3QO3Qu99maS1COgcrtJS7hSdo/4Lmbh0f8omttLkEYogKFq8m54j5YjR1vVWDy5iAMYGRHPmPiOMYC/R6oUjhELM7FVC26y+5a32PszWWh6440ILwWG4Vv/uF+uHiKQ9coyM6Ms6CwMN4kvezUGQjEz3x7U7Etm46lJJ0Dt9D0nC+SGCUh7KaM5IThEzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+4H9HkC/jkCF/kKmK65dJ3PgyNhu/9xfKCXZMsJcx0=;
 b=tuDvo1QHhNb+48speDcorD/XtJVG+SIx36va3QPVGWvUiyt8Fi4TIQ7u8hMxYfGzWcKzAkKGJVyC44YTd3X0nrVFV3+loC7W2cvsQ2lDYIjeJXmd+arBX2DhdRBAYih9H0ylenMZzTE9l5yebZlN0Z7WTWUsnHpA/eZFwCzEkZglDe+ByScyDWFfSsVFwFaZVG9aAEkcjJK4tvxfEVyC395DbazxKiuRPigVVgNMLWyaLMNWgAiSkQH+9vVh6Z/YDIP1tWP2rXx98meUX1TaZ6bBrKMyk/w03fjvOyBnpiKtVII2W2nBDi2Ezzm7RYs6OxU0UxLhdUZQV74MBUnjAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:28:44 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 07:28:43 +0000
Message-ID: <16d5c86b-cb04-5f57-7923-724850ce2633@nvidia.com>
Date:   Mon, 11 Apr 2022 12:58:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
 <ba28886f-be5d-9ab2-41d0-942609934263@nvidia.com>
 <0ce65e42-6567-9fd5-d959-3bc5aa0457eb@collabora.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <0ce65e42-6567-9fd5-d959-3bc5aa0457eb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7f367e-b3fe-4233-aca1-08da1b8ce86b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5986:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB598650D2F61186F682A2CF1ACAEA9@DM4PR12MB5986.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnBVpU0y+oqjPIfLDxuGubLT+5gShbBq3zRpU1YEjBMZWf6F+hQ8l7b67+MO7MtfDkELPa7aAE5XvbozoxR18Obf2IzePpyu+5Wk87cCQ5b2lP46CdgMTH8S0v59o7U9HCXT4Qh+cLJRZ0/ebXWt9PgKYEvOKrivYaJIX4EOj9mdznn9LKXJga0REWc9T4R8wO99UGP1yd19Fa08uKx1CQqwK6xY+3kdG/gnYeoz5R1k4kHRAuR0eEztMqho3CPWEuLNYZA3+lajXTvY3PhrQspf/oNCTcNS/PDrK3RAz1PeTk3SUtVZ7Q9gAmgB9zCDYjKkufmiCD8Z73LOiMcIYwvA7q+8/KfhuQg/Zr8/yOa+eSe4ymcF45bWTbTXAobQMBc6612ybOdDQnXlo4noGn8sga82ic+tzVcZ1OtDjATRdaqfmlwqS+PWF2FCVasY8IoOAQUuZm49khQ2AYLFw3qanBrAfZS+YVn9+OWsGwVb6GeJQHBHtB4bJk6hVJt+ES6wXMIe+iTKHF7Ivvs4t9rPCFB5HrAbYyr1kn6zHh6CyGjxrjavvvxFtCFAdW1xktItW3VVxy22OUsdyjXjQ1eAZDn1yo82sV7292EZW2vB1TndmkneqmcDiGSF6KbIE/nxa17X24AwQaTEEThqbZPVnMGGID4EzjnIblekTcIF4PVywEjG8gcuG3yyTjG2/7BQ237oQuGg30wg/EvrAQBQA+qiabOQ+2tkRRlE0/ytO3/EyS0BEfcUwpqTD2GXU2rQH8jUd2qet0b99q+SUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(8676002)(6486002)(2906002)(66476007)(66556008)(508600001)(110136005)(921005)(66946007)(4326008)(316002)(38100700002)(186003)(2616005)(83380400001)(26005)(31696002)(107886003)(86362001)(31686004)(6666004)(6512007)(6506007)(55236004)(53546011)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1BaR0VkTDVxb0NMYld6TDRoQWgrckI1bkY2aXFpNVUyL3ZhQ1VhSzVKaWZr?=
 =?utf-8?B?YyttQUZFNkRGR3Y1bytLZWtXd1Z0UnRBQkw2TmVXUXhlaUZBcjg1WGVsZjVY?=
 =?utf-8?B?TTAvNll4WExYQ1ZNSjZvcEdiVWsxcHhlL2hOa2lKQmRCMG5iQjdpdmhhb3JM?=
 =?utf-8?B?VU01bW9hT2lMdndwUWc5ZUpXb1pqTW4xcVlSZVQxZHk1QkNKbWx1cjU1bys0?=
 =?utf-8?B?WmpXa0dNUTJJSkkzUEJIZFZNUkRRcm1xalJ5MitpVnRCbTNMWFNRc3RLNk1m?=
 =?utf-8?B?MzB6MXQ1NjMzTW9LRHdjbGtmNS9zcWNlMGtBdTJ3Mk9jRTRtWjRHWmRXTit6?=
 =?utf-8?B?SzFrL0c5TW9FcWFZTUxKN0ZKbVVSMXBOZGc4T1R0eExGNXJjWlZ6VGJnQm9u?=
 =?utf-8?B?V25iU3ZUVVlpZ2l4bzF1M0xPcXl6R01LRGM3SkRreFRyYno3dEtZZGhyRTVk?=
 =?utf-8?B?MUNMUkpaKy82WHVJUWtxMlVVY1JXRHF2M0JZZGZYU0F4OEZsZzdBTXEvZEV6?=
 =?utf-8?B?Qlg4SVM2WkdjdDdXc29xZ0tUN2czZGRlb0d5K2grOUExeHB3Y0Z3OXR2RERE?=
 =?utf-8?B?elkzbG1oWnhGQU1XZW9KcXdBYXhBNnlOb2QvNzAxNXJHb0xDcVg1QlpGUjdW?=
 =?utf-8?B?MkgxdElHekEwVkhvNDk0WTdZNGwvZGtxSU9CTE1ZUGdWNUZqRkNwbEx3aU81?=
 =?utf-8?B?cnJPdmFSaEN5Si9Vays4NWVRVzQvaVZSNTkyMGJOV0d2UDRmSFR6ZHlIVUtB?=
 =?utf-8?B?TGEvL1hZVzdPYWwrQnoyMXJ4eFF1dkg1WXlpVDFBbU1IcmcyckNMVkdTMFVs?=
 =?utf-8?B?bEZDT080OGEzRDMwN2ZWS3dBWmJPQjJtbXR2RG5wL3YwMHI4emdCT1p5UVFO?=
 =?utf-8?B?YVE0cVhIT0lsK29oTzRndmJMbWtMeSt4U21iT3VTTTl3SEowOXZ0SWwxN3FX?=
 =?utf-8?B?aDNXRFErTElvTE1yNXFXdWlESitUZU5rNU5iS1NvVHZCZWZ0OGlpNWwzRTRi?=
 =?utf-8?B?MVBqWGxYdk81RzdQSWlETG5QR04zRmRNYlBieFQ1Y2VISjRiam40Wm16RUNk?=
 =?utf-8?B?aFgwV2JqaDZndkVuV0RTcXJGVHpWS3czRTlVY2lYV0t3ZlNOSWN0blZUaG9i?=
 =?utf-8?B?VjNQa2pvZXllN0ZpeEM1WndDa0x2ak1pTGJlZktZcWZTM21VUmt2MFM0M3hi?=
 =?utf-8?B?UGd3Z2dEaWVNSi8zM2hLU00zd1Z0MzdDU0hoWTBzcWVTd0JiQVk3bGYyTjdt?=
 =?utf-8?B?enZIQVdUVEpUTXltdU1uWkFiZHhMcWlnKzVHem5naEo4MWI2MEg4QkpyVUxl?=
 =?utf-8?B?MkFxRTZkaTRpL09sU3VvMTBGQ2Rndmx1NGVld25qVU10UW9mRUNjWGhXQXky?=
 =?utf-8?B?MW9nanpOaEhja0xjaURVY2JZRnJaS0V0aENtQzV2dUoxcVJHTGxhaC9KYUU2?=
 =?utf-8?B?T29qZ2ZOcmIxZjZtQno1RnIvMkpSVXo0QXhrdFVZNHljZlV0SVhHalJkSmJB?=
 =?utf-8?B?dzVjTTNGbkZjWEZLcHRhUnlmY3p1VXpRNHhweTh4b2Y0Q2R1OUk4YUx4ZmtY?=
 =?utf-8?B?MGJjNE9jWGtXUnhLRUhwYzAzdlFRY0tZUDRIWTBKbHlYaTBZLzFWd0NhVFlw?=
 =?utf-8?B?T0xTWTlhZllad3MzMGJEWFhtSzg2Vk5BWjVqSVZQb1U4U1NaYndaUGdMT1dX?=
 =?utf-8?B?a0dqTC9PN0dENmNVMUMzU3doQVhCRUVML1p5ZGVjK2I4Wm9sdUd2bFo0VUxV?=
 =?utf-8?B?Wkk0diswQUNZT25qUHhkdElOeDN6Q051K0o3R0RHSE05eDhlMm5tc3BtSXdK?=
 =?utf-8?B?MjZCUm1ma25XbDJQQnNDNFgwZUo5ZnU5M3VFQUR4WmFKVVlxbVQwKzZ4ZzJN?=
 =?utf-8?B?Tjc5RFpaOTl2T1MxaXR5WE1QSEhzL1YrWU81QVIwMXNFc0lIL2JWNHNGV0hj?=
 =?utf-8?B?TnNOR3ltQ2hWOFhoeWFLWkRIcTJoWWdMM0xKbUVWUzdRODd1U0pTVERHYVVl?=
 =?utf-8?B?Y1VDa20rMEtqeStONzBSWXRlRml5bmNpVlRtcDNEK2ROODRIVi93RDVvdXAw?=
 =?utf-8?B?dTBTVGVTb1NYK3FzK0c1czFtV2p1U3lFNmdJcWJtOFVtRmdyVTJXK0lUbk81?=
 =?utf-8?B?UENldURqclVqU0ZBUmVXSnJKSk5JbC9NMGFsTm9ZMFF5bXRBYXk1b3JRczlB?=
 =?utf-8?B?czhoWFBUQnZSMzFJYTY1clZKYjUwWnpTelNwMVBZTmxEeU1mQ2VMU053aGt5?=
 =?utf-8?B?bXhIcW54T2NGUG5qRFNrWHVPYlhFdFJKaUVRbTh4cDJzVm8vdDhyeXVwNTdN?=
 =?utf-8?B?YkpncXdaMzhBUjk1cExPdlFUSk1nRnhUdnBCVGI0U3JUTWcvUmI0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f367e-b3fe-4233-aca1-08da1b8ce86b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:28:43.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQmWO+aqzr70kJiNU7osoAam35qTIKK5I461AKJR/AQJS7ggt85GtkVmpBPhteHFtbo5/RT1mzzY1lMzrd66rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2022 12:03 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/11/22 09:05, Ashish Mhetre wrote:
>>
>>
>> On 4/10/2022 7:48 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>> +     num_dt_channels =
>>>> of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>>> +                                                       reg_cells *
>>>> sizeof(u32));
>>>> +     /*
>>>> +      * On tegra186 onwards, memory controller support multiple
>>>> channels.
>>>> +      * Apart from regular memory controller channels, there is one
>>>> broadcast
>>>> +      * channel and one for stream-id registers.
>>>> +      */
>>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>>> +             dev_warn(&pdev->dev, "MC channels are missing, please
>>>> update memory controller DT node with MC channels\n");
>>>> +             return 0;
>>>> +     }
>>>> +
>>>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>>> "mc-broadcast");
>>>> +     if (IS_ERR(mc->bcast_ch_regs))
>>>> +             return PTR_ERR(mc->bcast_ch_regs);
>>>
>>> Looks to me that you don't need to use of_property_count_elems_of_size()
>>> and could only check the "mc-broadcast" presence to decide whether this
>>> is an older DT.
>>>
>> Now that we are using reg-names in new DT, yes it'd be fine to just
>> check mc-broadcast to decide it's a new or old DT.
>>
>>> mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>> "broadcast");
>>> if (IS_ERR(mc->bcast_ch_regs)) {
>>>           dev_warn(&pdev->dev, "Broadcast channel is missing, please
>>> update your
>>> device-tree\n");
>>>           return PTR_ERR(mc->bcast_ch_regs);
>>> }
>>
>> return 0;
>>
>> to avoid DT ABI break, right?
> 
> Yes, it should be "return 0".

But if we "return 0" from here, then what about the case when ioremap()
actually fails with new DT i.e. when broadcast reg is present in DT?
In that case error should be returned and probe should be failed, right?
