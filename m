Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E781A4E45A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiCVSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCVSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:06:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF6457BC;
        Tue, 22 Mar 2022 11:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgQ/iJQQ6pyTHfRbK/Uep5gH6l/af21k7Cs7aY4GmtUVPIzpnfSgD163H3GgxA3pW7Is4DPs8S5aclAICtgsvD6OUaXnnPEqxdPHTpdzovhcX5Vo00Hgz5ykJ/g+IuGIu4/yM4bHj4PEp6FJfoKR0pTkqD4eB9YrdjFQndxCcYk19b1xFHyuCusV8lvXN4oVuDsPFSQV9FI99oFTY+RsEeXvnet6n8rWtnv2om938Qp6Y67DCCaJZBu/SLctglUiRkl/p+eVUm9nOzKc2wdzUraV/qKeKcDLn1o/J4RTMs3GKoWNOqeUuJgngLlf3ybRauf2ud299/+Ct/sIloeZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIVvkzupl2T2rnmgLHysItuipKZHoJFPz8El2nhuOwo=;
 b=dR6wKw/srWJSY/Y5bwx5MpSwmhPUoxuxIDK8jFw0U5F5AcxQrNhm4XNIHmpiwy0nk5tdPkCWQZ9PiBDKPn+5Ae76vkmUH4XxB0fPjWqEFVzpfG7hQ6vD7+hCCvME+U9oG26PnvxEYkwxbCZzQp5RSbPIGS9MTflEeCDQcDsbCy0JpRKeTVqcNRHg/LyQlr2pUJIUc2vR/mJgwDPmxsSR2Yb47n3mARDvf/fox0IfdsmCKEGiK/fjvO/TepqFkzbYFWtX0fhmphlzfGii7k1IO4mcAYBVCi68a91lgNViwd3+6X5SjprjoPWxn3aa8daYG0u3adFhxFconpQKGMFfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIVvkzupl2T2rnmgLHysItuipKZHoJFPz8El2nhuOwo=;
 b=FeBTK3rmz5g4XV6z7Vk5v5cJxvn+0mqaDDBacYQjEq1XAxMMvxj3WxhqSUmYiS9LtKbJ1pz0aRvPTSGehn1xpWuRkuRm6x2n93Xvd/SGZ8Ac9BWQ37tsz1ja5TbKMWSIpCD6y9DbiO8KtSsZShNolKTGMN5wf9j0aP3x7s1RabUKUvKZhLSSIVgCmi+FwGOjewM15f5p0XlO43hcmkOGM9e9zHNiOEnS7wDdAR9au8sac/G5oms6ucCscyfVMT9/4MSZhgggMYL4klvOV5Ew1Q4iYEuy5aAMKB/XtYK0GuPE+8AExYKtSOTGexAwaKJ/WzW2Cll8Jx+Ba4FUNbpT2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Tue, 22 Mar
 2022 18:04:32 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 18:04:32 +0000
Message-ID: <5259de16-6243-42f6-8252-40a23cd67798@nvidia.com>
Date:   Tue, 22 Mar 2022 23:34:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <81aa7be7-0bfa-05e6-624a-393e6810dc61@kernel.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <81aa7be7-0bfa-05e6-624a-393e6810dc61@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::31) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a1fd00-8600-4810-9725-08da0c2e6a83
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51653518D512A48779F5DDB3CA179@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzruU9iDrPfQ5GOGqqn4w86OQEKg4TpalQTgqTAXmmshnwWz1NXs9gyEuxPLcz9AlOtYWcSNPBvUu/P/4Hc73WzRunn88qs6rMDiFtBHLFuoV64ymtmWH+OR5fxkq46ViVVJi9awXkZPXeEX3aWG8DqnoB2O5CNAeaqf1AACqrtcHRAFLWcuAEWWrIPG+5a9mRK8pR6v2V+xtIbuVorVfphLxFogtrBInR9NJC6hSwgbvfc4AJrdp+Q9Aqg2YuZMRLitpmSbD/z9tCO7UDCOypiFsHyij6foQIPeD9r87C27XugqR88pFg+OdTzX2xpBDrbAi3RSnrH6Mhjz2aTFsnIa9XfodvyYg3F42JFb4ZTExmzmhJv8C1gB7elMSGAT1s69fZlHXV+7HePAd3XeAnQnqXL/rwIYDEIJSK7hYy4Yy5+KLdcUN6UGQDPxBeWYj2dnEaiT/bipPREzH4wTfgoZH9ADWqWokOYV5sqico1IQs2srFSclKzCkFqUCa66Z31DtA3LXuVzfy0s9nkAYaIM1Znwu7C3uYiX8hq8sA2mYSaTe4BsulQtZkm8oocSYUARv2XHdv1Wf8YkmGwPBF8KSWo2MiTbtOEQGLQxmSyKzhNbdMb6c7iqvQF5dtbGwxjo99ViHQcg2Lp701tegPv2GsAT5nvF6tZ+w8kqRCidvcuH/FP+5YjFnyVgXakOyiFRICK6tC3HvJ1tqTqny0ssVOXedba6WIO08y9KNeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(31686004)(508600001)(6506007)(53546011)(2906002)(55236004)(38100700002)(5660300002)(2616005)(4326008)(8676002)(6486002)(66476007)(66556008)(36756003)(31696002)(83380400001)(8936002)(107886003)(316002)(66946007)(86362001)(186003)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9aVFY3akJncjhrcnREZnVtdUNTTkFDQTR1MzRHd08wSjF4azZmSWs0bE94?=
 =?utf-8?B?ajVrQmk4Zm5nc2Q2b2NtQUlMNEpDVXNRR3N0Sm9yMjJ2djFSQnpVL0NaNmo4?=
 =?utf-8?B?TG1ha0V6M3BaVDJBZ0F6MWZZeldWWXdLRG80TEpCZkVpQzBZemM5cWxhWE9O?=
 =?utf-8?B?Wm9lQk03alFaMmhmZnJDWlpDb0VUNjNObk9EZzEzaUZUNDViTW84a3RySzlP?=
 =?utf-8?B?eHJ4NFRlM2QyRnhOVVJGV0QzLytvbkZqTjByVkt6VS9MQjVHWFJlSVozblRt?=
 =?utf-8?B?UzNnT3dUNFM0YzBBVGtVQlk0NjlOZzF3K2ZwM1JBeW9lbDZLS28xdnA0K09w?=
 =?utf-8?B?MWZaaVNkVU5yNXZ2ZzRqcFRsVmk1cGUxNjZFeVphUytwZlhNbVQvZzlRblVh?=
 =?utf-8?B?dEt5RWJrL0ZwMmtqNWtCKzlLbDQrS2NRVTBCODFKYk5oVVNzTHJoYjlMS2c2?=
 =?utf-8?B?eXFRdTBxZHZLTVhoZ0JuVERBTXlGUjZ0Y1crand5UFJ2NWd2cm02WFg5UmhS?=
 =?utf-8?B?NEdVZ3Fsdk9qZGNVNHRjZWsyOWJkQXpDd013d2dHOG5iWHFPZDVCV08yS0Js?=
 =?utf-8?B?UndwcVdzVzBxcHM0ek1wYmMraTlJRENqd0VsaVl5Z3BqNWFQME9ycTdDeWhR?=
 =?utf-8?B?ZHNIbXBHMCtsZWpicHRLU0VUTmhLT2Y4WXFpOXZ3RkU4SWRLb29pdkFUVUlk?=
 =?utf-8?B?MVdLOEFJb0FjeW5KT2JTNDRkcjVLVlY0VWVIclBKQlJ2SlJ2aW0wZHhhRjhV?=
 =?utf-8?B?TnlEeHk5bUJVazB4eis0Nmxpa3h3cCswa0ppeFpvemF2dmZrN1hremlyYkE5?=
 =?utf-8?B?cDJ1TTFrVmlxZ0ROelYxbzROUE5kaWtCRW9hZjk3S0RoREdvTmMzcms5VmNn?=
 =?utf-8?B?ZTVBbkRPN3ZzNkNBUUNNYkYwY2ltQldsOFVQc3NMN09HYW5mUkZqS1VvWHNk?=
 =?utf-8?B?eUUyVVJyTDByZ0d4anBBY0p3WTFWVzY5U2VuSjlEdENDM1pQWmowUFBJMFVs?=
 =?utf-8?B?NVpzRUNLUjdtRFF0aGc3eDFPYlJEYUZwNUIva2pzbllseEpuVy94WC95ait2?=
 =?utf-8?B?Y2thZnN6UldYVkJmUjBWTlR4cDBid05kY0pVbVpWSEZwSWpZNlFGcmI4bzI3?=
 =?utf-8?B?alFFY2RhKzZCUUZTVjlWaVFBVkduQXJ3THk1bHErT2d2K2QxWVg0bml1WVFR?=
 =?utf-8?B?YXAyN2lnRHlyL3BTWkEzaUwveDJoRzZlb1pDbHNWY3hiZkFldUNmeno0ZUNy?=
 =?utf-8?B?VnRja2ZZSmljR1RUSmh5RVdFZG9KeDg3TmJaTXRWYkkyaVdwYm1YUVB1b1RI?=
 =?utf-8?B?a3hQaEJtZklXMUw1SkVZa0FkUExNaERvdng5aHpzdHBUTG9DVHNqR0RlZlNG?=
 =?utf-8?B?RU9tUG8xWG5pditiRkZiaExDSzIwQVVxeTJMb1E5NWxPWW1oR2ttL2ltTlFp?=
 =?utf-8?B?d2o5YWxkVjJwTmtCaDVJZUQ2dFpJalpLZ1FtVEZhR3pnUHFSUXkyN0Vqc3dJ?=
 =?utf-8?B?bHAvWDZiTldZN21jZlQwWnQrMGw4dmlKclVYei9hbEFqa3dtb3ZPNktHdEpB?=
 =?utf-8?B?NEthR1pwZldhV3U0UDVtUFRkS1FyenJ6cnJhb1JtVTc3NXExVC9CRVdpcE85?=
 =?utf-8?B?Y3hJUGFhTDVJQU1RRXRKL3M3N0NxVEhuZFJ3OUxoRnFGeTZYV2J4U0xmVlV6?=
 =?utf-8?B?NkZtZ0I5eXl5RG9TUlRPMkNSYWQ1dm9pOUhubk5ZZ0ZUUWhNUVQrcS82YUdo?=
 =?utf-8?B?OWlSLzZCcC9BMFJ4V280RDNCZmZhVDJMZG1uL0JwdjZibHlFSmhnVG9WY0ll?=
 =?utf-8?B?ei9JSUJFNnVjTXhqZVpZZVBkc2JDMVd0T25oMlRXUkt5MTE3WEZ1eit5eU1O?=
 =?utf-8?B?c2tDZG56NnZyK2FUcjgxY0pUQXhlNWVEbHhWM2NQczM3OWs0eFc4RlF5V2Zq?=
 =?utf-8?Q?nYh0ST04GZmYrnwF+/UYeDHW5OnxjyvS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a1fd00-8600-4810-9725-08da0c2e6a83
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:04:32.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7s/8v6/3FvhhaHeIhdcELk2MsRDeXcwofFZ6sWRAgwsGsgH3HJxsnw2WWSIAfmZyk1a1kQUdtVIu2cwW8UTxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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



On 3/20/2022 6:01 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 16/03/2022 10:25, Ashish Mhetre wrote:
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
> How did you address our previous comments about ABI break? I really do
> not see it.
> 
In v4 patch, error was returned from here and probe failed causing ABI
break. In v5, we are checking if number of reg items in DT is as
expected or not. If number of reg items are less then we are just
printing warning to update DT and returning 0. So probe won't fail and
driver will work as expected.
Also I had tested just driver patches with existing DT and it worked
fine.

> Best regards,
> Krzysztof
