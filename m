Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4614BF804
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiBVMY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiBVMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:24:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF539D0FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk1EgQKBkS2VCFbHfRuNfF3/rUkTUyECDRE1GBU487Li+n+Ut7NFABIZLojaz+X2ainzK5duF7YHuWXwTN8T5RQ4778JGTsvhti5WmWPRE3ElNXVw9tyYiZzwi5/wsDwnKBq8Hki53KE6x52zaF8RgjeS17S1b3N6B4Q3eIPQ+LLdho95u8ktHS3IVpFr8EY6tNtW6jpL1jgcE3vjTFBNxXt+0R6yk/+gnoAyFXHa5j66mD4imInYj1VsgHPjZw+6uFJLi0I5Pv/wjWSTTJvEsH4zThYsGx/1kGGnUHWo+oGSzpwifGqqKcw0hlb6x/ZDXrlpQSZnhiLDIpTUWe7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qbsuMR/MTddDm59Ho2AL7UXpreV5pbrlwGpDnxB3oI=;
 b=ayNRzFWYIP5ALvkh6/QaYtHYVsUDLvOWJr/qT7OTW0axoppaDsLehIunEhNfMC9SbyxE57s+++w9QJfK4/NqqKRlF14oyzKciIOhStmwFMfsQw+/2ggaqYiuEt6b8X9xRnIbP9kQ4Ri+9j2dsyzr59gFE/qszUS8Z0H/MCRYjBnGAyu5+NAbhH3f3gtr8iAHAWASKeJ2aJcyWQt2dtQWBTH4Dk72aShWmeVy07MmVA8RXUzU5eBwhK2MFbA2ph0DUiEgigR6QsPELXO+pApp+1DEa0nTVKN4RHL2vpGESuyh2o+bco5mnmkd4K6wi14owsOZgVRAaENmaDexV2Px9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qbsuMR/MTddDm59Ho2AL7UXpreV5pbrlwGpDnxB3oI=;
 b=SXVJ3K2KaIACpgRa2rQhVR96mj1wXJZZNFQJq/fJ+jfDTMZ/HFUqUuKt52epiOgv6h7wWXtqzNxKyq+XtCFWyRFdeKM9TFovcJQlaPPjlgPiSYm+vC1+7VcGjdkkiPrsyq+GNfRX/VBNVy+f1oCc2BKVbWqMZ2eOs1qeDLdkwNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Tue, 22 Feb 2022 12:24:27 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::544d:f62f:40b8:b32d]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::544d:f62f:40b8:b32d%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 12:24:27 +0000
Message-ID: <9b7a45c2-f028-848f-b74f-6cc5d2809e84@amd.com>
Date:   Tue, 22 Feb 2022 17:54:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Change card name for Guybrush Machine
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220222061128.719400-1-AjitKumar.Pandey@amd.com>
 <20220222061128.719400-2-AjitKumar.Pandey@amd.com>
 <4bfa587f-3605-646c-8662-40c561beecc0@perex.cz>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <4bfa587f-3605-646c-8662-40c561beecc0@perex.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::15) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1fa9f1-2ccc-4530-8236-08d9f5fe44ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2861D020F3C7001828BE002A823B9@MN2PR12MB2861.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEZNIR0oGdJuTtPc0OHLmcCPvQKZn4ldyLD54bRBSjRYhMXUAQiG4knt8D9zIIEz14EhepluucOmV5qQBrFF+FQ2Z9resdHDmIP+lye3XG+Y/hAx1Jl4lkO+oa117o8rOtSqXIXsU1+pIN4JvZ8fUtT0cGKdI1yDOLhbr9ZXfu0nH3106tCahD/QqNQSmesXXqlPJw0bBt/gxG6kUWwyJqU2NT97fu/9DpHT0uCLhqvl01WmgynKZJVjPf2W9WIsZg/0/zTiNeXCIEU/IGlfep6eO6CLfl1yjTYY2+hpLtxQM+Qh23jePSKzgqFDGVQKIt7qA5sOrCfBLprrxcKjE3oTP2FF+wtyIwmwRp5lSGtpjAzGpcqVmJ3CV+9nXAng9zGxzAyDFVNF3ATuo7/aaK0INzWV7USM4B+0V+XadiRule6r6yKc4vdD+hz+wWhcvKu24JbMsVeH/ylc4p20jL6+nZtLD2PQ05VQUqLvy4a2z6PYj1pL/BUCNc8HQm2Nz6vpWt/+blEu5/rZ12eJN+dgRF/jsPiiQfGaPNzzDMCtiz4NsyWLYF6gIGyG9ZK0JPKJy/ydwNJZsCvkum1UEmb/Vj4IUz0HDFhzXYV6box5RBEM2L3QfnAG52vJwRjQ2kQTMyjBJPNYZehS0VKKHOoyO3KFbJR21noY2fD15igFpGZG6Vmh/jwBn+bvfW53B6KmG8E5bidm9q6gzaKHajIssb27VJMoP0boJFeJT8vcwR78O9v+MWsaZchveP8EbH8nQqbdI92PTky/J4ZvRoZ65clW8nkz6NRDTzGs7gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(316002)(66476007)(66556008)(66946007)(8676002)(4326008)(53546011)(6486002)(2616005)(5660300002)(6506007)(186003)(26005)(31686004)(83380400001)(38100700002)(31696002)(86362001)(8936002)(36756003)(2906002)(54906003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVyNjZGaDNvNFJoSkVnSHBLa041NFJhY0srVTRWMEwxd0QvcjlaRFpCS2Jv?=
 =?utf-8?B?K3kxT3J2REJsWDZQNTQxbTRkekwwdERpeWpNVWIrYTd4TzNCMmhML2NOaW1m?=
 =?utf-8?B?eDR1a1BhSG13dWVpN1paY29QRzFMUnp4bXVydDVqYUlnWEVUTSt6SWxnRTZq?=
 =?utf-8?B?bytUdnhET3UvYXl6NkZHcTg3RWVhYXJjZWQ5M3hDUS93bU0rQ1RQRHpENFVz?=
 =?utf-8?B?djNoeU1kcmRUakNTSFVHQWRMM2NZem9MOHNHUmpSZjN2QUxRRDdyb0t0ZElq?=
 =?utf-8?B?VG56TDg1U0xVNGxublpLL1FJVlBYMVI2bEVpdWJQNWFhb1NLWlhqeDhyTFhK?=
 =?utf-8?B?SXRqZWl0bG8yajI1VlI4ZU9VZ2Fnckw2dU5VQ1ZaWG1WU0xoQkw5Tk9RSXBX?=
 =?utf-8?B?K0VveHNWNmNiZHBRRUhXb0FkdjJMeWlnSTQxYXRIY1lndHhPOEZEZEtibVBs?=
 =?utf-8?B?bWxrbDhzbGJtTElwUWlFYW1iSDZBWGVwbG5Wb1Q0RGZJZVNuZDdRU0JxMEJt?=
 =?utf-8?B?TE9LL2lVcC9rSVQrUVpyRHFxbmJXZ0c3dmFCMnhFK1NwOGZPRnJRNEVBeCtC?=
 =?utf-8?B?MTlnS2dVczNGbzVPSXYza084djQxY0o0TjM5aHVyanBnYlNZbDBNZWdlQjZ4?=
 =?utf-8?B?Si9iQ1UwQ0ZIbzluUTM1T3kxNDNTZkRIMlhyZmJvUXB0S2xhbDE3T2Q2NHUr?=
 =?utf-8?B?WEpuSUN4Vk5ONEZLOFhxS2J2OGM1dm9BVlZhMzRWcnNCc3Naakl3QnRDSHNJ?=
 =?utf-8?B?dUdCRFFMd2hwaWZLd3Q1eTFKVWdVclQwb29qSXVrL2ZLQzZJaVhyUTcxb3FE?=
 =?utf-8?B?QzFzaUZJSU9ONnBCWUxEN0JjWjJsVXkrNllrWnNIQmUwY0NaazhsaTJTMDdt?=
 =?utf-8?B?S2ZaNzkrangycUhYMEdkeDlVUmthaENRUEkrVE1PM1dXcFI5cTQ1YmlCRjMz?=
 =?utf-8?B?Q1V1UndGdGphcVQ0dFhxRWwrU2hUdE1RWUd1K0xnS25TaEVESEhmZC94VmRn?=
 =?utf-8?B?UmwvajNnUjFDbzZ0QXR5Q0FwOU12T2xPVVVRendjaEVlZGhRWERNMnZoRnRL?=
 =?utf-8?B?Vmx2ZmtCVDBhK0FxSFdCTUFWUEk2RHYydHE3Y1pnbThFYUU4UHRxTnBnQ2NV?=
 =?utf-8?B?cmtsN2FpVmZ5MkF5MnZDZFR0VkVLVGkzN3hrN05salErL0pMdDNWL1d3L3VW?=
 =?utf-8?B?T2t0K0VkTnFuV3d2N1d0THYyOU11dEg0b1hQMWZQczZpcm1aSGFWdmlOTGxZ?=
 =?utf-8?B?NlJITlZxSXdGVTdBdllxMHQwTm5OTVZ4c0pmelJSODFVTFNPYzhTYUV0ODd0?=
 =?utf-8?B?d3V3WTVKeE1pSDBpZkdjaHdzcWtPSFh5SjFTSm4xaUV5MStPdE1Pa3hZaTVv?=
 =?utf-8?B?bWRpWUZwS2lnNUUxOC9TK29nRnYzaXRlem9jS2tuaW0wZm0zZFM3TnR1Wjdv?=
 =?utf-8?B?bDNxZGRtUUhpQWttUWR3ekN1b1FDZjhqUU9ReEZPZSswVlVtdkY5aWdZaXE0?=
 =?utf-8?B?TG5zdHFDZWQ1ZHFZT0JwZDlCbGUrTzUrZ3Z2OUpHLzU4S1Q4dFRVQk9yZG9I?=
 =?utf-8?B?bHM5TUJ0S0xhZlVHRmxhUnlYdkhlU3Qyam8vbUdoWU1GcTZvSXhKY2Jhd2sx?=
 =?utf-8?B?UEdtOUtYTWRqb1dXdW51YU43eG9yeGFiWWlwbEJqdGhGaXl2SkFDeVFKN1Bh?=
 =?utf-8?B?YTExTm5aZDdvMEpyNGdhdG94UG5oSURFTXhpOWJPaXVibEYxVjh0TFJPRTFi?=
 =?utf-8?B?UjR5V3orVEhKelhSTDBZTW5CbVVrMWFkRCtmWWl2NmNsZ3hxTXd6WFRvVG1s?=
 =?utf-8?B?djRJejlwcXM2a0N3UTUxQm5sUEUrbFdzaG5ISEJuU0x1cmcvYkFuSk5YZDRM?=
 =?utf-8?B?TjRVQ2gxeSszSG52cktUbzdwdnFXcUxmeGNGVHdEei9Gb3ZaWDJBQ1dSRVdO?=
 =?utf-8?B?eGxnUk9PQ2hSVGRnbzFjQkVEamVTdEJWdXM1K3ZpWENWTVlzUzZDcndoMDN3?=
 =?utf-8?B?UlptVkNlRmwrL1lJdHBoN1FmL0hvTDFJS3hiaXp2SE5WT3pLOXB4Wk96TjIv?=
 =?utf-8?B?MEFoelBHd3BFNDJvSjEzMnVJYjlGVUdMVldNY3AwbGFMeWVOcXFZWHdaajZi?=
 =?utf-8?B?YkppeldLYXhYV3p1d3BRNDlXRnhZdGwrN05ZbjNwUGtHTUVDelFlVDk1K0RD?=
 =?utf-8?Q?n+d2Q8oaObtGudvndM/i+hA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1fa9f1-2ccc-4530-8236-08d9f5fe44ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 12:24:27.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rITvt54FtDPF63M7Wf5fKUyxdZ1UufWIe+tW40lNvOk4cC8cYV2GfgPkb+oiDhld+I5pzh2HWjb+Nulc5G71Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2022 1:45 PM, Jaroslav Kysela wrote:
> [CAUTION: External Email]
> 
> On 22. 02. 22 7:11, Ajit Kumar Pandey wrote:
>> Change sound card name for guybrush machine with rt5682 as primary
>> codec and rt1019 amp to align with names given in UCM config.
> 
> It's a Chrome OS UCM config? I don't have this config in upstream
Yes it's for Chrome OS UCM config only.
> 
>> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>> ---
>>   sound/soc/amd/acp/acp-legacy-mach.c | 4 ++--
>>   sound/soc/amd/acp/acp-renoir.c      | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp/acp-legacy-mach.c 
>> b/sound/soc/amd/acp/acp-legacy-mach.c
>> index 91140d15691b..50a5aa4d6da9 100644
>> --- a/sound/soc/amd/acp/acp-legacy-mach.c
>> +++ b/sound/soc/amd/acp/acp-legacy-mach.c
>> @@ -96,7 +96,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
>>
>>   static const struct platform_device_id board_ids[] = {
>>       {
>> -             .name = "rn_rt5682_rt1019",
>> +             .name = "acp3xalc56821019",
>>               .driver_data = (kernel_ulong_t)&rt5682_rt1019_data,
>>       },
>>       { }
>> @@ -113,5 +113,5 @@ module_platform_driver(acp_asoc_audio);
>>
>>   MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
>>   MODULE_DESCRIPTION("ACP chrome audio support");
>> -MODULE_ALIAS("platform:rn_rt5682_rt1019");
>> +MODULE_ALIAS("platform:acp3xalc56821019");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/sound/soc/amd/acp/acp-renoir.c 
>> b/sound/soc/amd/acp/acp-renoir.c
>> index d06ad5ce7fec..b8dc25a1d31d 100644
>> --- a/sound/soc/amd/acp/acp-renoir.c
>> +++ b/sound/soc/amd/acp/acp-renoir.c
>> @@ -47,7 +47,7 @@ static struct snd_soc_acpi_codecs amp_rt1019 = {
>>   static struct snd_soc_acpi_mach snd_soc_acpi_amd_acp_machines[] = {
>>       {
>>               .id = "10EC5682",
>> -             .drv_name = "rn_rt5682_rt1019",
>> +             .drv_name = "acp3xalc56821019",
> 
> I find this naming cryptic. Also, we have other ways to identify the exact
> driver / hardware configuration. It may make sense to have one driver name
> (like amd-acp3x) and use the sound card components to refine the hardware
> configuration for the user space. Your way will introduce a lot of new 
> drivers.
> 
>                                 Jaroslav
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

I agree that it's make more sense to have a unique driver name but that 
may require some additional code changes to identify hardware config and 
machine driver changes for sound card registration based on components.
I'll surely look into this and try to refine our machine driver code in
near future but it would be nice if we merge this for now. We will 
upload new patch series soon to support unique naming.
