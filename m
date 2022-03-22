Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31C44E45C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiCVSOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiCVSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:14:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059469CD3;
        Tue, 22 Mar 2022 11:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQRprbEaTQRw4g5ymx+uW4rjEpifXwHWSjlrt90T5W5LGSRGh9GZguZSesB33TJJ1TaaMt11ghEOIAJVynhITks8jGB3cUrEqdjmwBd8fwKZE79bhGmqNrwD0wvJ51OFjBmItpxkPMBuGQtGEZGdBt3d5X4GCkRWN5rxSnUcW1FmtAq8TQfGy4ctUpV+GYoNQC6vvHJlXloFhJvKbVbqN9eQfQPOYxRYhUPZ2bFqDFBjjA5kWLo9hFESvCHjcvVS+dOs7bEXK1KBtynXzlizH+XH62B5gMX5cU/ZtJfoktz5V1qCowvk3ix2FqUGdWCMYUirJtAxPBKykP0rnAB5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GjhcNnzoG7h2fG3UApg32TYXeksyunoIwXbR0CW2Yw=;
 b=IYVi7D6Q1B46tKteu3I6GSujxgjj0ME5eMUa+zv9Gxu8rY+akc6oT/cHFBSTBLVuT6k6qqg49uLAtpjlFd6OOhPpGMUCU951dF0Lx7X/YsnCV3bezpgqfOME8R7aao83j3WuFxKbOjeD/FT2SxUFt+IYnK5Xl+/EprpcEy6YWj8wAY8AmeX19AQRwRMy/ZUamFwWOcB5jqI86wcnPXx52bCQfJ+B8ZApPepHbry/9IfPISvnUGPMU7Lsqh1kNpQupOf13J1i58gY/gnNttimsy5o+p5uxs9dnJ7vOHreKmON671o3cXjYA6X2weWFMb0x8lQWWSEOldIXKvrGXQAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GjhcNnzoG7h2fG3UApg32TYXeksyunoIwXbR0CW2Yw=;
 b=YnYh+QVaouNyZX1F0cU+Az3AQp/mYijQ3B5kmk49CEPF22UjiCtahFG0/sVTu+SDg9O0bs4QW8g35jZRH7VmVVSJgOLcufhDBdMRYyKsLBhDmLzcpk7VTOr2Wme3j/nq2x4F6OTtxPSqPnqT1sZig2wuNOxtwNnJfrSXZ81PVQ32sYY2ZoVuZ87dIgtUBe/OTQ6YXO4a8jdv39o0FLcW8wMrewlxWH0oohO3fW36x+5c3USMdxEL1qlE13kwENlV+WfigVoKVGesg4iCGR07yS8ptwMoU2Qe2icpJSp100vyXydUlzivOfoQpTALnMxQ3AzULEa+OlBI6zTeL9ulDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 18:12:47 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 18:12:47 +0000
Message-ID: <66a3f996-ac12-9165-93c9-e1fa93b80eed@nvidia.com>
Date:   Tue, 22 Mar 2022 23:42:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 3/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-4-amhetre@nvidia.com>
 <74db8a20-7cce-ff86-7ae4-466416443ba9@canonical.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <74db8a20-7cce-ff86-7ae4-466416443ba9@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993be956-02ef-458e-d71d-08da0c2f9136
X-MS-TrafficTypeDiagnostic: CH0PR12MB5171:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51717D0BBE87A1B647F74D98CA179@CH0PR12MB5171.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP1uCzI7lnyeun6FgCz2YASG8I4FNuVopjDKSOCgRFZcX/gcaiLHPt3l1hVgJHxuKO+qyPBpvgbWrqLUhxF4Ue4YjqMFfFoLdwh0YnvEGK73cvwyJemab13EUyty/nbzqal0zz28V+QbCR9NJ44ILUDP2wgjaT5S2x2nbaDQHRbzj9kxhTUfMgFCDUTYE66JrgKQcxQe61FKbOnUT12LGav1ay2Nof0BuAdyH38mEov5YfH40tzVl1s1vcrvbP8rlq8EmMhYyebw5XXB5txMepjcDAhxLHlDIFVL3YtReEFhbEd95pUB2+zT14Q3VVx/nDJazMpKFWX3s3M71aRJQmU5YV1u4jBYp+l6xDc8w4WgcijTd7ECPctKhXUd7oWgd8K4kd1y5Z5prNDenTEbLMnHPnM+hzRQm+IzJ+EzihUL8vTxwp5C5vhAFMT1ta9IE63R0ZC6WsxR+XWLl1XLIJDfibGu7otkqpSEyVdoOfEck1jdXwlHzbAkNoLesdhUh1WeeJefdVKc2ynsAqLUUaSsONY9L+ZTY3yVMsfLsjfv5w5PXNPz44Vj9GVsdA1khkeTthUoZ6TntcHq9myCCLmw6Hz0Ir8GiMQmRY273i2M8rUMEUJECom/3msS9TbF9fuA4yBdOIEmUviZj38/0axO6lx6zjXPXPpfVW6psDWZQHIXlzy7f7oPHUyifF0+QsYX+JmrY1A1o+Y+7MA6PHzhP86M2EQrPjkwAr9MF/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(2906002)(4326008)(66556008)(66946007)(31696002)(86362001)(316002)(6486002)(83380400001)(36756003)(8676002)(186003)(26005)(2616005)(107886003)(38100700002)(66476007)(8936002)(53546011)(15650500001)(55236004)(6506007)(6666004)(508600001)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjU1N3pkNVB0NXNuUG9STVZEclVLcFZ6Ulh4aEFKOHhNL2RnUmJveEYwTTkv?=
 =?utf-8?B?OElWS0diS2NhQjJiS0JtZjkzdTJUN2RWVGpSNktYcG9lcS92WFF4UVdGSFRy?=
 =?utf-8?B?TUVaUlloMm84dDc2a0VWMVhRd2Q2SW5SeHgzZmdSZEhNRVorZzQ4KzBxeGdv?=
 =?utf-8?B?R09ieGU1eE16ZmNPdlFlVHprNFJ3TkZweXpXSkZDTThmOXhMMjVQZHpMbzV4?=
 =?utf-8?B?VHcybW1ocWZmVDdhMlQxMVFIQVVJL2hGUVdoLzJITnhkWUxNMUQzU2tkU1c3?=
 =?utf-8?B?NUlTVE5wbDJXSDdZM2VySXdySHdXOHNIR0s5ekdkZ0N6REN4dStIUTVBZjlr?=
 =?utf-8?B?Y1NqNjJoQzFNS3B4eHAwcXJaNEFZcVY0SkwwTnR4djB5SWVwR08yNHV5VWNq?=
 =?utf-8?B?ck9XUWwrOGNPVlowZEtnZy9QYnVLUnNrUE12QlVCR1ZMOXlHOTl3MXo2a3VN?=
 =?utf-8?B?Z2VaWkhoRmJRSUE3RVB0a1pEc2RCTFRXMGFDZE9BT2JQNlp6OWJ4a2NYSkpJ?=
 =?utf-8?B?SHBFY2lXNDJicjE4T1FlNmxYZ2hMZkMxWUNkWXB3dm1Kc0UwQnUyazhyeFZP?=
 =?utf-8?B?UVZBTnVvZVRrT3kySERnQ2dmaHlJbC9EMk1OSVNCYm9xR2QrdmxubzdsdDNl?=
 =?utf-8?B?S3RuMmFzaU1iY3NLYXRPVkJiUzhhNkxkQVZKRkF0bEllN3ltS09yZWowM0VB?=
 =?utf-8?B?TzVuVTJDT3Jsbi9wUUwxdkwydmFYNEo3RUt6a0ZIOG9saHp5ZzJSb0k4OGxl?=
 =?utf-8?B?V3dVQ2YvSUdVR09iWklUakxwdjlYYUNjdFdhWVdLUk9aY0tTSFJVeHdnZHlj?=
 =?utf-8?B?ck9Zc0ZBajhBUWZDdlhWazc1dFhaZlBRM0E4VGZkb1UzSktIa0NIdlhQTmM5?=
 =?utf-8?B?bzdVZ2MvY3BrNDF2cnQxNCtDbnN4WjcyVWw5NXBnTTBWZkxmdlNtOWU5eUg3?=
 =?utf-8?B?NmtrTU9DMVVSdVN5YkJFektxSGJVVUhCalQ5Zm5HQ0I2M3RWbXRvdVJ0VDND?=
 =?utf-8?B?Umo0bFY0NHRNcS9BU1FCMTRENUp6WXRyVk9veTNEQXB2OXBMa1NLcVpPa2RP?=
 =?utf-8?B?aXYrYzdSa1RMT2JYY1BycDRzZm85L1IzTWY1c25QNlZRMFVveEs4eTBhaTNa?=
 =?utf-8?B?ZEJNVzBLKzUwZFVaWklDaWdDK1c0bEFtSjh6MUY1N3k0MERVWXE2UHpjMWN2?=
 =?utf-8?B?RTVjdW5wdGlrRStyclJleTRmS0JBekduV1VqUkZTeTIvZEYvTnlYajZ6RjFG?=
 =?utf-8?B?RXhFWjNJVmhQUHFWdFRCblptTDMxUnJDOXcyY1VYaGdLVHVZN2YzYTlmU0JI?=
 =?utf-8?B?OWc1ampmTVEwN3FRV0dCUWhpRTZ6cW9TVzVGRDJpajJiN21URVZvZTRSTytv?=
 =?utf-8?B?anZHNE5ESEUxTUs5aFB4aGFrYzBMNTFNeEFsR1ZZZUNpcW4rSmZCNUhnYVF3?=
 =?utf-8?B?eXFXclVCeGNQZ3NLS3NvNXdTZU5qQnFUbjJ6cVZVc3VvRndZMDRRTlBNV0hu?=
 =?utf-8?B?S0JhZFdDcXF0czgxbWJuOTNFMkRTdUgvT2cyN3dlK3h4YkNOWWFmVFliTlFt?=
 =?utf-8?B?eVhzS1Q1ZnZ2clBVNk9JcUQ4YTh6eGY4dms3RmFSY0ZlcklhdWVkeWNCbjU5?=
 =?utf-8?B?bDRYdW1BSE9wRG9Ec2xhQXczUWhiS0gyTGk5eUoxOUNHSXVuNDdDV3VZUGxv?=
 =?utf-8?B?ck1xamI1NXFsMlhGSTBiNjNMU1RuZnlkSE5oZlZyalZjSzdueWhHbmladUVX?=
 =?utf-8?B?dGJINDZ1dTg0T2dMVWRvZVJBYUh1RkJsL09meXJzMFpJcFFma3IzeTczR3Zo?=
 =?utf-8?B?bEZVelZkdXAxYzc1U25ZQzJUYXpJQ3pna09MalJoQXdXVnZkVFZBN1gxZ2xG?=
 =?utf-8?B?dnF1alJLVjU2UDRRTGJXaGZZdnNlVkFzQnk2K1VqWUZ3MDNiWFVBTjRpTTNl?=
 =?utf-8?Q?b9aL4H2AZ0iSyIVF324oKqpAL3N6lG8J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993be956-02ef-458e-d71d-08da0c2f9136
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:12:46.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEoL0CENnbIIPoIa1VMAIQbkgobVE+Pqf1/eS/Hvzb6UF8NGdFlfXOVGNInl7+AX3eemW56jntJ2ND1pvRjgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
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



On 3/20/2022 6:12 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 16/03/2022 10:25, Ashish Mhetre wrote:
>>  From tegra186 onwards, memory controller support multiple channels.
>> Reg items are updated with address and size of these channels.
>> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
>> have overall 17 memory controller channels each.
>> There is 1 reg item for memory controller stream-id registers.
>> So update the reg maxItems to 18 in tegra186 devicetree documentation.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   .../nvidia,tegra186-mc.yaml                   | 20 +++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> index 13c4c82fd0d3..3c4e231dc1de 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> @@ -34,8 +34,8 @@ properties:
>>             - nvidia,tegra234-mc
>>
>>     reg:
>> -    minItems: 1
>> -    maxItems: 3
>> +    minItems: 6
>> +    maxItems: 18
> 
> Still ABI break and now the in-kernel DTS will report dt check errors.
> 
The dt check error is because I mistakenly updated example in EMC node
instead of MC. I'll fix it in next version.

> I think you ignored the comments you got about breaking ABI.
> 
No, I took care of the ABI break in v5. I have updated details about
how we took care of it in first patch.

> Best regards,
> Krzysztof
