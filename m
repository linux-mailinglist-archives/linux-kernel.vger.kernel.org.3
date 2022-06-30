Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778456168D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiF3JjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiF3JiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:23 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B9427CC;
        Thu, 30 Jun 2022 02:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5zFD55NkyVmF3EC555RWTiQJrXUEPcVEh+ACT7hMCFjB3UJadIYfXajziybHd6DnP1Igg7qFkHWyCfgNzymHsRDdKqS7vMbDzBduIHic7ygbn2nUgj65hVnvbdvukkoHKnUoEvg0brGsVGyEXEM17XzZo1gcj9p8cXZo3gNHjEJn8rF5YsoxL7ocvmejP1gTtge+RaDX6n3SFYo5/o7nLvV5sRjLZ0pl9ihObrOyno6rTGRoG7+xOaIQ0Lk7Fs5gs7YMEbdL2gzOXFiutZT7HJPdROZ8HisBJ1r5z8nh6cA9+EXA9AiCEF9OY23V0+k9L992y0m75/7+yfDBZmHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XRp8WmJTruhsV+VBVXy/fuqc0AaLalaTLpspWePEF0=;
 b=L9+l2hVqW5NBHXoMHcWbrCxeGbnYihvzYQ3Evc4wUrp7ZIBIuov6+TTVlnpZfCYg4Df1za7vWIlmi+1cAia3pPFG3owNmrU+mKResvINW25NpOxNMEENsNo3bzQJ3JfOpSXTFDmZJBsz8zmqmqw5L1N6BxYdagzNlK3evrvcmIlt3QT5T62LfDMr/YvRKVflCjLcEsbP0g9sofs0eXUVkXCRzIYoLArCB3l9A7/aS6ZHWnee/n2nIuT3pB750O8VDaeny0WzVnGXXZrx1XmE3Tk6dgmlwerQHCOztihU8PEMEkqv8MhvysQjcEKkgJ+Jonexc3lk86wtPFn7MEWuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XRp8WmJTruhsV+VBVXy/fuqc0AaLalaTLpspWePEF0=;
 b=HLDPTl4qGQ90SMVbdbznqUtxWYuUXaHFIIDeHH2yIlHgG6l84n13fr/fUEwv9XXPsw8rpA/Zgkr1ObmkG2Jo4B651L649FGH2dmkFC4LyWfSsCJKb1RuDSslZ9BUIbD5slmM3e3rtkQHaOKiOCnkfRIE95TlO+xxWkH4EPsJ70NhB3OdwzZiqNjL04xWG7RC3VXzn3RIyDFSBgHoPAhuLgdfSiFmS20g/sPnHaL3bgbQjNkrMEKBpKp8akYqNT9YzSiv38kbll+7Ak58UeEtKvKA29EGNZrIROJ8Tv3a8Iy8bZ2HyVrgFMnzHB3snIf/W1pMfZ4bPNwfSW9LEGMVuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB5690.namprd12.prod.outlook.com (2603:10b6:208:82::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 09:38:19 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:38:19 +0000
Message-ID: <1b3a1614-698a-6d21-118e-943f6dc992c4@nvidia.com>
Date:   Thu, 30 Jun 2022 10:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/6] clocksource/drivers/timer-tegra186: Add support
 for Tegra234 SoC
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-4-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-4-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0436.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742a06ab-6450-42a6-2f07-08da5a7c4412
X-MS-TrafficTypeDiagnostic: BL0PR12MB5690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEcWOTZ+LdswAzY7hyxJ4bY+BrxAKNjK45HBM+azZWgugbCIPWHFOq/OBl/nEjnC33uS3+kC/vfvEnBmh3CmJM3s5BSsR5+rKprmS6rLreUUxwj7OhR/RKRUJpgs2RInCaOBQZcHqV32yYyd0A+TF+TOst5eJusskVHFhFZsQ8YphIJDlv6sKfrQgfox4Muxgz4ZOk06GZowgO+yxILeLsanLdK2m7Wsl8bRP6CxzuNNNqJ4Cz/iPcedpr0LhiIA4HPkpWXrXcDfFJ9JIb4e9NaMKZ5+zi26lHzehxxu1beg+Ca16ibsv13kEusYe2SGHoLk8ry62v1I2TC8Y/dLIlzFfBEy+0BFeFo0NfLcfSc5+RQwxq2ha5Sg+3hZCgTmr4uFKVaCKK/pCsNn0qN7xUuCStIlconvHuM0XOK4mereQTEXw6zidpO/4kCIx9HXRSd/AiZKIr2byVMesPYfFtoP91ukU6Qg/iaciJfoyTKwk738AaiopKA9S+XT4MqVt00w7/C4Bw3gsHS7PRBhCBPEYbXU1HpwPjpGTbJAM0KJOji2afNXMBUKwU8Y3YJ2jfX0nDuvGlX9WxYFDLWPd34Mai9SohlII7ozgAsS79ZoC8fvtD8EzO+YSAKDUROd5KoCzBdMkrFIWOSs5pIaLO+te0xKHMkmgsazF/yme4DMJ6HJlEh+dR5ZUZf93c3jNznKwbqtYhDMWVqeMSW8A3XPJTwzuJHW5Ngewc85Yz6leLZGlm44EQL3xDD2SyMH+3m0X4RU4DN/rGrWnFxUaiRP7PPd/I2/8QfCUtxLjBcmbKMBhiSnu89iUaK8C7k/oJNlWTXHRjqPz7D/Reqv3RdRQ4ckNzaj6V+68kNL8vvJxltdwWiQEaH6vsy6muhh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(478600001)(26005)(6512007)(6666004)(6486002)(6506007)(53546011)(66476007)(186003)(41300700001)(55236004)(83380400001)(36756003)(2616005)(921005)(316002)(31686004)(2906002)(8676002)(38100700002)(66946007)(66556008)(5660300002)(8936002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEs2ZHpFZU9xcmJNTndLSmNuZjVkaG80ek1uQjRTeHRFVld3SFBlZi9KUlA0?=
 =?utf-8?B?T0l6NWtOaFNXd25zVVNVaXNJcnpzR1ZQVzdKRnZmdis1b1IxT3QxMU5tNXBL?=
 =?utf-8?B?bDhWRkt4VmFRbmJGZEJlR0R4eFpxaDdHL2pXUEVXa2gzSWQ3VGU5UWQxbXRZ?=
 =?utf-8?B?aG1GUXdDd3VYaUcyS0thdTNnTkY0dGVrN0JSamwwVWkyb0kzUmxVQVRuS0hP?=
 =?utf-8?B?d3BzOXR0TWNjelEzVzFOUEZ1OFZPZ2N2RnJnMUpiRFdlT0h6VndxY0pUVHpi?=
 =?utf-8?B?MDBaMm1tTEJrSzNUZXkyaGhHbDZFcGE1eUtzS00wcnE4VExnK0sxVVJtcVJY?=
 =?utf-8?B?c1JPL25TMjFQdTdjdGVlYjBnM0lCci84ak9YbDlnNmMzLzFZUHcrMFovcWwy?=
 =?utf-8?B?T043aEwyb1lFQi9LZE5Pdy92cmlrZ2o1UDh0ZkZDSlVWT0ZBNHBSblpRbFlx?=
 =?utf-8?B?ZGV6TkVSZFBVL2h5TjZzME5Td0dqQ2oxdDM0aERyWExLZXVDajNBM29DN1No?=
 =?utf-8?B?OUJSQnhHUjU1RE4ySTdtQlg1RHo5S3pOenV4NCtMa3J6anVLOWJkcGZBNXUv?=
 =?utf-8?B?T1YyaHJheXZRaElDc0ptdkU0VzIxRFpsRjJ1ZVlkNWd1WGpyeFVpWENYeTVX?=
 =?utf-8?B?V2E3TzZpdytNQkxFekZIL2c2eGFRdEo5YXdtVkx1MVhHTFBPNUJVVzQ5VDFu?=
 =?utf-8?B?NHQveG1vY01SZm5HVHpTcnNTR2VCVm0yTXdOc1VaUnBaVDduekZvN0dVQmhB?=
 =?utf-8?B?RkpvcWpoVE5EZlc1Sk5QWVluajBlbDR3Zlg1S1JvMHcvbGsyNVhCeDdySG9O?=
 =?utf-8?B?OGVucFZZOXh2bE9lTmJzZE1XcjFJL2I2Ui9IdytiS2xnSzI4OTk1bWpDQWgw?=
 =?utf-8?B?MUlwS0Nqa2dtWU10Rm16c2FLbnZMWWx2NVpON21Xc1dHY2lQVW04RGtUalht?=
 =?utf-8?B?WTRUV0srUitUOXN3YkNqYVowM3ROUVZvY25ORkNDemw3VmdYVDA1dVBhUmNh?=
 =?utf-8?B?eTNoRWNDMzBOWVFja0t1eDdnWk5iVmQvZElnU3ZUTzF0MXovbThTNXB6elFP?=
 =?utf-8?B?UEl6b0dMSHVlRkxiZzFhWU1PNjF2Ly9MVXpkNGJOaGQydk5MQmVPZ014VmdP?=
 =?utf-8?B?c1RjQ1UxaldYODRBRjhHUGhxa0l1MDdGZXcrWklsT2h0dFllRVFUeFVxZWc1?=
 =?utf-8?B?eVFUNlpUL2dVZVZmKy9zc1hINkZ4NGRKbi9hM3h0UnE5NlVoRHJrQkVtLzgv?=
 =?utf-8?B?UTdpUGNNSkFicHhVZ0lySDI0cHBBMnFLSXlVN3VTUkdybStaUEkyOFZwdjlS?=
 =?utf-8?B?ZjFyS3RqKzIvSGxVaWRXY0JNcmNtTWRaZ25sZWFXMDJIb0xWVDZaMERSSXR6?=
 =?utf-8?B?N21TUmFOMU1idTVsSDZZU0VMUG1jZWpZQUVsSlZ2eFVXNEYwV0RaNGw0T0g1?=
 =?utf-8?B?c3dqY3JDSkZYRTcvMVkvWFhLWEo3WDJaeCtHTlgrY2oycXhjZHZnc0RsdkV1?=
 =?utf-8?B?MUpFR2ozZHg4NkVyOWVxTFJTS2tYVWliMXk1MjZ2UW00Y1dCcGlDc1hmM2My?=
 =?utf-8?B?TXpyWENLS3g3REtKMVNKSmpQdzB2bmk0RmU3YjBEMmJpV2VMYVpmRDhqbWpH?=
 =?utf-8?B?YTR0R3RtY0NOd1FKN0JFU0xhV2piM2NZM2FRbGJEZFVZd1o5eHl2VDYzSC9o?=
 =?utf-8?B?Q0FUSjRVeWZZUDNhcC9RYUFlQ1pMT3JWS1FHMm8wTVFPaEpQREhvNiszdVpm?=
 =?utf-8?B?UXRyR25WNFF5YmFBY2V5WE1mMDFGRkNuQnNzL3RocENidERGclpPQkRPWUYr?=
 =?utf-8?B?NDY3N2c4UUx0aklLZnoreTFkV2ZoRGQ2aWFJam1xUFhjZE40T0hDNk9xaWZS?=
 =?utf-8?B?Uyt0NjdhSWh6MVBvdHZOS0xIcmxLKytlZUgvMHdBTkZmdXFqUDdDTEZ3YVV4?=
 =?utf-8?B?NGFuQUFyZFdtb2RWV2tJWWZXKzloeU1ZS2ZOSmNpbFNBUjBER1pJNkliNVlO?=
 =?utf-8?B?TW9jeDhDK1R2S2lHSm8xcFcyZUNwTGdWNmJ5RjBOMUxwa3BZcUlRbTVCSkdP?=
 =?utf-8?B?aWhxOWFaNnZORjluQlBnRDFvd1FVMGY4UEdjKzJlc0pDeU9FMzFNbnFGc1pw?=
 =?utf-8?B?UGExTTl1L2Y4YjJtZDZEN0Y3VmJQbnQrU1VkbERIa1ZuSm0remI5OGxpUUMw?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742a06ab-6450-42a6-2f07-08da5a7c4412
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:38:19.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5QpwalLuRebbDwTqV86wOANZveKpEXPmEwsxX+m5XjqUbGTgX3vzR9j63ZfcQehzmle9AijDxUqs/P0h4VJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5690
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2022 19:29, Kartik wrote:
> The timer IP block present on Tegra234 SoC supports watchdog timer
> functionality that can be used to recover from system hangs. The
> watchdog timer uses a timer in the background for countdown.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   drivers/clocksource/timer-tegra186.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
> index 4515517c87a5..ea742889ee06 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c
> @@ -486,8 +486,14 @@ static const struct tegra186_timer_soc tegra186_timer = {
>   	.num_wdts = 3,
>   };
>   
> +static const struct tegra186_timer_soc tegra234_timer = {
> +	.num_timers = 16,
> +	.num_wdts = 3,
> +};
> +
>   static const struct of_device_id tegra186_timer_of_match[] = {
>   	{ .compatible = "nvidia,tegra186-timer", .data = &tegra186_timer },
> +	{ .compatible = "nvidia,tegra234-timer", .data = &tegra234_timer },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon
-- 
nvpublic
