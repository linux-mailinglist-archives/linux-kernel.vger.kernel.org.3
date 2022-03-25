Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC784E6D81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356143AbiCYEwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYEwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:52:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937D2BC7;
        Thu, 24 Mar 2022 21:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVfJbLCCheqvm3Ll13SPb+8KhMRREO9gcMV1CEOctCBCXbMIR/NPTDsJ5e5KmWoXn+1xeRSYcSzRKkT3x22kF/TDTS+htpdkJEQ9eHAFAVSTRGzoKEy/TgnQn+vz0VRcaIVCfUW87SYk/vS/xaF1YajVxkSgYWb04bmQxm1mYZwXMTau62FdUjUSElr4erwcMGY7dvikS1ACCV5mNd8OrwDakUUdyfLlfl8TICQvg1m7vg32tIHEtAdMfJDpMEYBVbENXFSr9IYrs6e5gJo83fFKTx7OyJlK/gy38lgO1V7WkeSx2eY3QDOO02PkDAmqScePMKBQc/9VLzPNcK8bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3W1Tz5N1DZVT23C8kVUdIGeNdZI8QE0Lfgn5fOMOkQ=;
 b=Z21UQAQH6KaefhjpWArlHAotLQJ6qWJBjsPJl+wnwHlbiWjt7bkVIS+HXXfC0GiiaLQ6eI7bnr8FM+LsAtCZRsCSriwYDAjZ7lz0lOyoWbPyER3f5OaVIy2pvNi4I+qAk/0I+vb5DYCi9/llRrL2a0QtkFehtyQ2YOGTyZmmyMuweM1oVqFib2EMVn6wSd5vvTWsTQ/8WOQ/r4dq0aKNcpHcanEah/4gPYSlD+geubaj7CGDCpfwN4ST+4BH0ZDyGWoZPI/Acvxcr8MfnEN0Np87Ct45OBDFNZjDDIom5LZqkAQLvwIUVolVYte3x1xk7TGAEwwx0LZwJPgNUtesYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3W1Tz5N1DZVT23C8kVUdIGeNdZI8QE0Lfgn5fOMOkQ=;
 b=PMfZn1JIyFG5MvT6uXEtKhV9Im5uEEkM6JwhF5hI3yABlBvM3dmiF8iRXvPVYvSMqMXDcS8Y3Z/G7sM4R8hUs3LQ92nz7VPw75WpDWdrzsSLD3b9r4iUHPWWPDs2NvBSArPgY34Jzn67zQOmUAjJIaENCa/tS1UCIbWIk4Y+f1Ijc/PoUgmPAs5Pk0HyrrL1IL08P9o8ruGbJ6ZZ4zwIX+GR+i5d8pZOVyq4iUOf0dzvvks98f5aov+SBpksuOOMBbrvpX/eSTVBDRnl6Goxg8thpZ5PvFZLmhPumV3Q2yGOlDlB8npAZrxhIaJNd5dU+Ae5guFJXFo7BggR5L3w7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM5PR12MB2552.namprd12.prod.outlook.com (2603:10b6:4:b5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 04:51:01 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 04:51:01 +0000
Message-ID: <981610f0-374a-b18f-8e3a-445b20edb257@nvidia.com>
Date:   Fri, 25 Mar 2022 10:20:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::30) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 270a3736-4bc3-4617-9a02-08da0e1b0f37
X-MS-TrafficTypeDiagnostic: DM5PR12MB2552:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB255265B63C96C02CE8AF25EECA1A9@DM5PR12MB2552.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKXAS20V0qsAzd0EPq+3MgNyeIQ3/VpT/IXOtXD4DxqxXtQ5FOeLjHTHnaZ9TPnJ5RyWD/mpWG/OAaJ+Bw3PwzJ4zgjBEihg4vk2RqCnouq8HTnzw2d1GFkB9cuxl9MzkkJCY+o7K/ngFIJeae0W09Gi9eOV8Qj6SmOTsyxX9RdpRxUJOncrBqpLHpthrbQpP0NYMtIVYtZxPSqz7rRk6RrFO3OlevViR+i+JmqQ2xBcGHkNKap24z0Vfbef818aLZA/1XIBlS6qxfqSnCqnvskSCVs66CvRiW0eJs66Dvz0AUcE86YSBqkIHXCCh33TgEvdhNBcdsBHmtiiQS0NEEhnU2p4qHqAXZQsfcde25Fva+hALVqLkRtPSmOOuwIjbwco82HknMDqX9lcCTzQJ/xOMWpbHDVw22Kx0vP3EuJZDkkSlpibP0tDdWTmKiD7qh2KfmMv+NilAX5GVLvG9+W82Tp7LAWwjt+jZa4p/qTUev6GvhsXlF4OyRSCqHxXgIWa9iRV6l1rHk4MNBJRrQ/XHKR0+YD1JLNVODgbUFFya884Jm9mpKf2SHNmeRTmncULTZNt6FX0JzHhuzU2lf0IojblN3S7MWg7jU1ljr1eFLrq8d3FrhzICYQuaHqMfQSvlL6ljbJLS/KV1I6ClXYZkFeMKxe9FJ3JTbUIS1fFJ/Vw+144zcnBEf5QdhlVx4JjM/KHYVu5TFIRBCnB2ji8ss1YWkiN/pejzFpFZLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(6666004)(66476007)(186003)(26005)(2906002)(316002)(6486002)(83380400001)(8936002)(5660300002)(36756003)(4326008)(31686004)(8676002)(66946007)(6512007)(86362001)(31696002)(508600001)(2616005)(6506007)(38100700002)(107886003)(53546011)(55236004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxTNWdib3hib3N2dVBTNHh2T1JobWNoYXJpU05oL2NyeWI4SlVvQjFuVno5?=
 =?utf-8?B?Q3JGU3VqTjFFZTN2Mzlac2xhRjRVblZrYml0QXBzY09LdG5seWp4RzAvMVJ4?=
 =?utf-8?B?TDFlSGliQmlMNnN4VHZUYTVuazRNVjQ1RXVjK3JIT1dsSEw1VWhWdVphbGtL?=
 =?utf-8?B?RlJjaWhSTjB5VG44K2ZLS2IzbVVRblpwZDVCNVl2YzVFQ1FmRzhkTmhVUmRI?=
 =?utf-8?B?SnU0VlVnQjAyYzVmbTNFZHBpYThEV05OTGEvTlcvdFdvUFFZME44T0h2Z2Zt?=
 =?utf-8?B?WlVDa0JQdHJnSmZ1amJ4QmxJQjNCdVhNcW9HbVJZQmlscmdtMW95ZG1WVkdT?=
 =?utf-8?B?R1dhOWF0alkwM0JtOEZxSmtmemY5Uko3SVNVeXRUcEo1cG9ibDJkZTZ3TFJV?=
 =?utf-8?B?NnlGR2pjT2EzRkQ1eG9Bdm5CVkQ2V3FNUGYrb3dDS053VEpQRURDcUdZZlNH?=
 =?utf-8?B?TmE2dU4wYW9EeStZWlhSbmtPSWdqUWNMeVB4Z25HVmRnRmZINDkvSTRxelpN?=
 =?utf-8?B?OWo2WTE3djBpdUFzdXQzTUtxSTdXbWxsSVNpdm80QTRFYk1pdmFWckJYNTJr?=
 =?utf-8?B?dDBHQzFGU3lpWXRvTVRQaGJQd3d1UFVLWkladzhpTTg1ZWhaSFBRWm1IYVFs?=
 =?utf-8?B?NktaMUJrN051RE1NZGlNQzZqOE51REk2VmZudUE1VmZtb25NMnBscXJaeUdo?=
 =?utf-8?B?K1NCRXZ2WWdEYkRPZ1d1elN4cEkwMjV4L0ZLT3p4dHhyQlZwMnphYVBZOWhF?=
 =?utf-8?B?SFdtRThNSW5YT0E3N01Bb1I3SFR0eWd3T0hHNHp1ODJxK1pKcWt6UzVHRjVn?=
 =?utf-8?B?d050TU40dlNKNXY3bGNPbm9ENEU5R1dJMUp2amhFeHRDcWFqWnB2QmFjNCtC?=
 =?utf-8?B?YU1ZUWZJakNSZitQN2tmbVgyNWsxK0VPcExRRWlJVTN6bSt5VGpDc3RoaGc2?=
 =?utf-8?B?NExHdUZEN0czT2V1dER0ZGVtYjl4bXM2b1ROblFDeUJCSjVXVTBFZTRJUFVl?=
 =?utf-8?B?UGE4Q1gvN2U4MzB2Z1NFWlFHa3RLTG15SUtDdkdlY2haclpxU1ZncFRNVk8z?=
 =?utf-8?B?REl4M0hIWDJraTNoYWQzM0dOZHVUUVZQb0d5V2c2TExFRmVZVDdXdU9HYlhm?=
 =?utf-8?B?MjFQbkczcW5ZcGgycHJrWnZNcTJIWW8xOUR1cEpWNUJ3VExoWk54ZVJSKzJJ?=
 =?utf-8?B?WmtoQXhmZW9HSk9Fa3REWmMwTmFkMnhRVE04aUVSVEEyWmhrc2lOZmdGTWpH?=
 =?utf-8?B?MG8wWEFEZFV3R1NVYjdEOUZtUlh5VEFPNE1YWmdjYlpUbXNYempvSW4yeHpS?=
 =?utf-8?B?dTdSS3lIMzFvM0VTV3huODh3Ry9KL2QreGZzVnNPRFA1ckxLRFRnK0VPcDNq?=
 =?utf-8?B?bmlKRmk0eTZVbHNJblJqZDFkcWlDcmx6WUlHSFdWUFN6TkVPSW1kZnEzNU4r?=
 =?utf-8?B?YWc3Sk1pK09SdTRQd2g5d28xU0ZpUFFNaGZaVEd1dUlpS2hPRk44QkFNWjgw?=
 =?utf-8?B?Ty83cGc2MzBCOVZZNDhpMWJpd2ltQ25UZUM0OE8zL29TSWs5SkFTQzVwNGll?=
 =?utf-8?B?YzhDZHU5ek1SbmRXRjRHZHJsVUVnV2VoKytHejE1bm5OcW1HakZzSHBoQnRm?=
 =?utf-8?B?QlJzenNPS0twQUdLb3JSQ2pjZEEwU3ZVTzZ6b04yT296NXp4ZGZzNzExdHJX?=
 =?utf-8?B?eDBVRVNmdVRkd2Y3cnBoblJSREpMSkRXYXMrdnFFQUZRdk42Y1RBekI5cGdK?=
 =?utf-8?B?UTNvK2FOT3BjT1lqOGgvRmpmYnRwbFR0clpLN2pZeU5PU1hWOGxySWR0ZFlB?=
 =?utf-8?B?TXVOa1dtK01RbGdQUzlibzBySmRVa3BhUFBiWXNuSkhlMXpGZEVGSzZuajJa?=
 =?utf-8?B?Ky9XaDhQVW9Lb2RrZTB4bWNEcGUrV3p0bHhLVDVydWRGb2orSlFsQ3lFRjlt?=
 =?utf-8?B?bFNVSVFpR0owZXBsN3pheWN6cVZRZ0ZuT3V0ZEt5ZTU5VW5TSGJ1QkY5UGto?=
 =?utf-8?B?WFo3SWVkdVc0cFNqbjRsNU93SnAvNVBOcnhLOE01Mm5ERXFsVTI0NVRYbThL?=
 =?utf-8?B?YlBIQ0JNOWlUZTBtQnFzNDRqdFcxUGJjRGtvU2JNYkhKWUtURk8yUG9kbzFC?=
 =?utf-8?B?RFVQeDJxNG44Z2hqWEx4d3ZBUFY4ektqRWIzaUpvL2dSRmJvdWJqZWZkYjA4?=
 =?utf-8?B?a1dtdUFaeUZYU0RXMnNxZmVyb2RkQTllc2NWM1Y1aXB3Q040MUxBY0hpVThj?=
 =?utf-8?B?SERGdXNrbk1SVGI1ZXpTQVZ4cXJtYWovVG1oTnk1SlBtZkpSYkhMbWs2V0Jt?=
 =?utf-8?B?N1pyMzlqdks1RHkrVXVwYzNHZUlRd1Q2TFZmRm03RksxNG94Ui9uQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270a3736-4bc3-4617-9a02-08da0e1b0f37
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 04:51:01.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2opI/iAqQMH4y211/K4B6hdRY1RX9nRrTumuF/MFODcVusG5YgWPmGWS2eIF3ZjpyujFyDPvwYcZhh/I0MpnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/2022 9:12 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> 16.03.2022 12:25, Ashish Mhetre пишет:
>>  From tegra186 onwards, memory controller support multiple channels.
>> Add support for mapping address spaces of these channels.
>> Make sure that number of channels are as expected on each SOC.
>> During error interrupts from memory controller, appropriate registers
>> from these channels need to be accessed for logging error info.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c       |  6 ++++
>>   drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>>   drivers/memory/tegra/tegra194.c |  1 +
>>   drivers/memory/tegra/tegra234.c |  1 +
>>   include/soc/tegra/mc.h          |  7 +++++
>>   5 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index bf3abb6d8354..3cda1d9ad32a 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>        if (IS_ERR(mc->regs))
>>                return PTR_ERR(mc->regs);
>>
>> +     if (mc->soc->ops && mc->soc->ops->map_regs) {
>> +             err = mc->soc->ops->map_regs(mc, pdev);
>> +             if (err < 0)
>> +                     return err;
>> +     }
>> +
>>        mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>
>>        if (mc->soc->ops && mc->soc->ops->probe) {
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 3d153881abc1..a8a45e6ff1f1 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>        return 0;
>>   }
>>
>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>> +                             struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.parent->of_node;
>> +     int num_dt_channels, reg_cells = 0;
>> +     struct resource *res;
>> +     int i, ret;
>> +     u32 val;
>> +
>> +     ret = of_property_read_u32(np, "#address-cells", &val);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "missing #address-cells property\n");
>> +             return ret;
>> +     }
>> +
>> +     reg_cells = val;
>> +
>> +     ret = of_property_read_u32(np, "#size-cells", &val);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "missing #size-cells property\n");
>> +             return ret;
>> +     }
>> +
>> +     reg_cells += val;
>> +
>> +     num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>> +                                                       reg_cells * sizeof(u32));
>> +     /*
>> +      * On tegra186 onwards, memory controller support multiple channels.
>> +      * Apart from regular memory controller channels, there is one broadcast
>> +      * channel and one for stream-id registers.
>> +      */
>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>> +             dev_warn(&pdev->dev, "MC channels are missing, please update\n");
> 
> Update what?
> 
>> +             return 0;
>> +     }
>> +
>> +     mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> 
> Can't we name each reg bank individually in the DT and then use
> devm_platform_ioremap_resource_byname()?
> 
That can be done but I think current logic will be better as we can
simply ioremap them by running in loop and assigning the mc_regs array.
Otherwise there will be like 17 ioremap_byname() individual calls for
Tegra194 and Tegra234.
Will it be fine having that many ioremap_byname() calls?
Also, Tegra186 has 5 channels which are less than Tegra194 and Tegra234.
If we go with ioremap_byname() then we'll have to differentiate number
of ioremap_byname() calls.

> ...
>> @@ -212,6 +217,8 @@ struct tegra_mc {
>>        struct tegra_smmu *smmu;
>>        struct gart_device *gart;
>>        void __iomem *regs;
>> +     void __iomem *mcb_regs;
>> +     void __iomem *mc_regs[MC_MAX_CHANNELS];
> 
> s/mc_regs/ch_regs/ ?
