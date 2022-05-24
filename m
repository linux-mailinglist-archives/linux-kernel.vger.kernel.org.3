Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31450532310
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiEXGYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:24:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D645DA79
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my6wr2RyiOe+8JzkpS+eZ5vVjKhdN0MfZcL0/CZxEJnUVGSs5nvRF8Qtg7NHMNfHv6028oHL9OqERfDgDPrZ7l++6a9HMhptSZ34+roMsL04/qGQ4rEFQiqJrh1s0kCsXJz9BudpBKei8GAjiMRV9UwEVK10SapafWGPPB/rxMy/9PEsjcXd1p336AkI2BDdbR0RLBe912XDe0wPlTC8CIta3f4sHhBHsN0EFm/umns5tQn50t8iE3Soz4Q05lsMZJHAuN3dcYUuVlhnMZhPsfHiKCqRHnyqO84XcqgKGxSx3WOvBbW2B6+5olXDfBx0ptJLUKovnDGylUbPdJ9hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRocTmg3NIXcm6OV90h9Ixu7dw7kW+bvF7+uW8HGC0I=;
 b=AvEwpG5GG23c5OTAGRh8SQV16Pa7KEntSQ2kpTYIKe9BhrxmGg7YPRLtpNWv92MBnw+gTzYjqTR0titJo1Utc8sWkr3lPw+Y7ww35iJwTxilDD3wMhBU2mu0/Q4fYcqnCTA0ItkpdG/8B5K8g5K2Scm6QBD/IhjGoaRzmInvtGezkhATKenknkw+o07m5rMjY5OICAml3VDkIqZhOaVlPboQIDrd3luS6GID3aoIM01ocmzCjXx3OoorDzltohLUfcMGv2nGgtrt0gbxi1YRdoQ5Liy7TEEhyxKMkWp+5T3a7e+JFWpes7+20tMqs18Cj4oAZQ564aeYSdJhX1Hy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRocTmg3NIXcm6OV90h9Ixu7dw7kW+bvF7+uW8HGC0I=;
 b=G0FCeiKOs+WVHm05WtVWVeEU5Agdz5lnnnEDiVPVMO1D2GVgs+MbTSfNZ9PfuKvpmZqRjYZeExNaeAmYEezk7mVGQU+n2yNYnYYwo6AHgLepZBl7cD35RfIbPkXjIcHFxdY+9QiEuKo8BkBa/bSTcOK33PVGhiY1oOFZcx0Nvbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18)
 by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Tue, 24 May
 2022 06:24:14 +0000
Received: from DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e5c4:675:d32a:a949]) by DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e5c4:675:d32a:a949%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:24:14 +0000
Subject: Re: [PATCH v3 1/2] ASoC: amd: acp: Add support for nau8825 and
 max98360 card
To:     Akihiko Odaki <akihiko.odaki@gmail.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com>
 <20220523132353.1767614-2-Vsujithkumar.Reddy@amd.com>
 <f54fc0be-5172-f518-4a78-b765e34bfaca@gmail.com>
From:   "Reddy, V sujith kumar" <vsujithkumar.reddy@amd.com>
Message-ID: <e13d6d8f-4bc7-d76f-f2a6-4ade08bd1bc5@amd.com>
Date:   Tue, 24 May 2022 11:54:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <f54fc0be-5172-f518-4a78-b765e34bfaca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To DM6PR12MB4171.namprd12.prod.outlook.com
 (2603:10b6:5:21f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5611ef28-ff61-4cb3-4e1d-08da3d4e05b7
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36825B564BCA0448661A617992D79@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTnkeGykc0kCwSliEDoaxw4BakYJ8p6n98ZlyC6RoKI/hGM6wNzTPeD9qKJl86S3Yx60Zn7yKE1fNY6eA30t0BrltIGhEkUHk5jV+ertcv+V3ompmzi+SiOKhPbEiWZ377pYXMGa6ZXQPR8uGzPeAIqoTasiwX1/agcVH7C9va/8wi6I5B1PQw5v+0v6+VqCVL9qmlEdcb+XG/MdcN0B9OjQi2nMSb1Km+Rsp+hx4wsj//u9DqPr0Vjw1LDM92hMu7+oAyS1IBB/NCy/DhaBMNnMExW5hKKH3v6LN2IOjyBVyAXalqxQ7mP1UHhQtj5nTxuBBhRBN+g/TIR+Nh8HPFHibwjdTxy4Lhdb0faFku79h7DOad490CLaXRAN+D/tS6PosEqW6900af5nZx0qgoP024C7pVk3ILbsJp2rcEhCA7ZNJ8jOUE407eSHtk/FQSzS+QMQIyfos9sY2/W7XtWVAhEm9RzsIhr5+0sbsb7y1aM5RxXBKpP20Ds/Y/HfLEorvRXoOf3XirZMK9YXRVDERxPGGg3pADHmje21gZxcaVV10LQCUXFh3GfT1VfABJC5o+HhhfekRDqDvvFgkiQLsv9SavkGaWupLUtRF45lo/s2NIS80XPLYHuspofW8KdpspQJtdJXfwZFBPn+hc0HAuKCrQ0TbTDuHyXayMk6LSpIq2oz/2sEX3ldFijx2m3ICYodiqbbFAaXVM7kYLrbr9PmeUEgxizOZ/f1dSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(30864003)(6486002)(7416002)(83380400001)(86362001)(31696002)(2906002)(508600001)(26005)(38100700002)(6512007)(2616005)(6666004)(31686004)(53546011)(54906003)(186003)(8676002)(66946007)(4326008)(66556008)(66476007)(36756003)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJKYXZod0ZlZDFsS20vYkxPQ2FycGc3NTlqc1lwMkZ1NTdYQmloVWpHWnpC?=
 =?utf-8?B?SlBVanpBOHVtZDZPa0xzZ1ZsQkgvNmR2bU1XN3V1SGx6V1dSUmZlY2RsVVNa?=
 =?utf-8?B?ZDR4R2hPSnhVcnhnNTc5NHZteGRyYUN4Z1RMK0RtYjkxdG5PZmFEeEMwbXBl?=
 =?utf-8?B?OGpHbFpROUt4NU9IZTQ0TnhnYzRLa0pTb3Y1S0U1cVg3dEgxUGhOenBMNUJT?=
 =?utf-8?B?eVpuZXdKNUpxQU9qa2ZVajBUUzk1dWZmK0Uvem1Jbm9sQ3p0dTl4WitESjdk?=
 =?utf-8?B?d2V2cDFKVmZQdW1lNS95Y3UvSGJZN3Jld0N1dGlLU1U5eVV6ZzhZN3ZyZkFj?=
 =?utf-8?B?R3lUeTRxdENKZ1JGVjBsM09DMTZLaGp5aUdRRjh0STZTdlNLVFVvbWREaDc2?=
 =?utf-8?B?UFZKaWlRcnZHUm9YVndzUlUrSElNRnVndzhkU3g2MWQ0aHBlNDVMRm4ybGF6?=
 =?utf-8?B?cDkvT1o2NnlITXFnVGE1dGJSYzhxZ0owOElZNW9NaGY4MForN2hsbmFkczgz?=
 =?utf-8?B?ZnhJWkZwaTZMdG42cVlEUytBZDMvRlIwV053ZDBJZUJ6Wjc0Tm1YTzVRRDlS?=
 =?utf-8?B?UE9qRG41WTJhUWY2WDU5V1lxaWlNelNNVUkxV3ZjcjdiQjBETHc4RmhmRytG?=
 =?utf-8?B?ZXlNQmFDWVJBbU1RalVnSnh6ZStNNThQOTVQV0sybStPTU1DSVJQcS9sU0NC?=
 =?utf-8?B?OFpYYnpJMTNTZXdxSVNzTEtidHp2cEJtaWh5UGtBY2c2TFM0b3hSVWZHRUNV?=
 =?utf-8?B?QzgxeHRRSUdJYWZtcklVcHMvMTJrdE9iVEZkM255UmxSckVzR3JJb2ZPTC8z?=
 =?utf-8?B?bGpZbHJZUE5kb05HWEIrOVFvOVFrTU9KR0dLazBIbU9yUzZKNzFRb3FqUWNW?=
 =?utf-8?B?MFVzemVIRUVKZC9VbXlCczVCQkdpOVVObmc0RXA2TzRwWDR4N21XNG1ZbVlW?=
 =?utf-8?B?Qk1xaUxWSTlRRzFTQStFRWFMclFzMFJOb3BGTjh6MFJ2YUZSWWJHbWI2a2t2?=
 =?utf-8?B?b0hWYVNScS9GQi9HakdIMVhERjI3QkRrY2prOUdmTjVBTWlJMTcxWHRGUzU5?=
 =?utf-8?B?Q1AySVkrZVJjVCtpL01WdHRNNEU1ZTNxaEZaL09FZlgyVWNqQXVMRS9EZGtR?=
 =?utf-8?B?dFNhY2xBQ0s2Sm1MY0pYaUs4ckZvVmd5Z0MxMFMxVDNFbXF5SCtIZm5ZQTNS?=
 =?utf-8?B?RkpQRHk2dWttT1hObTA5S3UzdTZSSnVaVGx2STlRTHlGaERwMElpNlArU1py?=
 =?utf-8?B?Z1U4M25HeWRoeWdaeUV4OS9Ndjh5aUhPUGY1R3hJZTBaM3JNcFl6SmdFdVha?=
 =?utf-8?B?dHlyQjI4L0d0Qmw3RVpRNWhLNGp0dzBTMU5Gb3AyVEtMMXNyb1c0a1JpOWV0?=
 =?utf-8?B?c2gxbklLdjhqRnJUazVpaTlRaUJvdW5TZm1tOVA4aG5iTkJydFpKMXNKRDhU?=
 =?utf-8?B?bmxDa2toaUI5Rk82NjROZk9HYjkzR3FIK21TN3pqMWY0MFJxVUVvenZ1b3JM?=
 =?utf-8?B?Sy9icnBtaEI4cWRpRmx2QTVrVmNTS1NaMTFNMGEyWE56OHBDcEpEamVhZ0Fu?=
 =?utf-8?B?Y3NoeWErTThacTlacUxYYUlmVkgyQnFDbWd0UDdsQVlmZUN3dTZKWEhsZHRj?=
 =?utf-8?B?SHlvTThpQnVsSEVkKzhlUzliQ0srWWV4Z0ZYMlgvelV4TW1BVHNwSmRHYjQ4?=
 =?utf-8?B?TmJYUzBseW1JYmwyUi9CV0k3VHZGMzFpKyszNDhOOFYwd3QxeTlEQWZadWU2?=
 =?utf-8?B?blhPeTA1Vld0NHl1c3dGazJ4L0xPQktKWTIwL0JDZHBFckNqK2NJa2J1bXhC?=
 =?utf-8?B?bUZYUDdoUkJSWkpTMFNCelJNSHBEY3YxMlpEaVNjQWZRYUdYa28vV2JkUTJ4?=
 =?utf-8?B?UWhya3BIMDlIZUpxYit0ZkJpQXdaMlE3dFQwd2lQVjVPS0J4R1VCbWtXNGND?=
 =?utf-8?B?NHpPYXBzeU1KWUdYeDdSRUllOFR5UDl1cTc3NEV6bFhNcUthcVh6UC8vZWR0?=
 =?utf-8?B?LzNhdmFUYVNNVXdxZ1ZQOU56VGpYN3VwMlN4bXFWemZtN2Z4RGI2T2kyalls?=
 =?utf-8?B?VlJTTFU2dUdIZGpjbzNlc3Nnb0N3d0w4c0lYdTdoL01mMnNQVUFhdExKa3Rr?=
 =?utf-8?B?MkQxcXZpOXRhaWJLc2Z1aExWa0xMTW1oa3FOY3YydVJvbnJUV3dDTEVFemtT?=
 =?utf-8?B?MGg3UTFrUHhIOVB5NlBodi9kQlhVUlFEWnZUZmVmMXU4UmN4RTZRT1dzTXhr?=
 =?utf-8?B?T1BodFNjYzA0NWpLclg3dmZoT3ZNNnQ5WDFxQ0pDMEtPQjhSVFRmcU1jcVFp?=
 =?utf-8?B?aTFIRWx4NlJvOURKb3hhNXRDbXFpNjhjUVkwZSsyTUowY3oyemZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5611ef28-ff61-4cb3-4e1d-08da3d4e05b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 06:24:13.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1qg+Zr3KBLI+P6g6C3j6KQfAzGor5eSgjRB4x22rQRme2waVWnvaW0wVRJKPfi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2022 11:24 AM, Akihiko Odaki wrote:
> [CAUTION: External Email]
>
> On 2022/05/23 22:23, V sujith kumar Reddy wrote:
>> We have new platform with nau8825 as a primary codec and max98360 as an
>> amp codec. Add machine struct to register sof audio based sound card
>> on such Chrome machine.
>>
>> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>> ---
>>   sound/soc/amd/acp-config.c          |  21 ++++
>>   sound/soc/amd/acp/Kconfig           |   1 +
>>   sound/soc/amd/acp/acp-mach-common.c | 166 +++++++++++++++++++++++++++-
>>   sound/soc/amd/acp/acp-mach.h        |   3 +
>>   sound/soc/amd/acp/acp-sof-mach.c    |  15 +++
>>   sound/soc/amd/mach-config.h         |   1 +
>>   6 files changed, 201 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
>> index 5cbc82eca4c9..f73c187fee03 100644
>> --- a/sound/soc/amd/acp-config.c
>> +++ b/sound/soc/amd/acp-config.c
>> @@ -130,4 +130,25 @@ struct snd_soc_acpi_mach 
>> snd_soc_acpi_amd_sof_machines[] = {
>>   };
>>   EXPORT_SYMBOL(snd_soc_acpi_amd_sof_machines);
>>
>> +struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
>> +     {
>> +             .id = "AMDI1019",
>> +             .drv_name = "rmb-dsp",
>> +             .pdata = (void *)&acp_quirk_data,
>> +             .fw_filename = "sof-rmb.ri",
>> +             .sof_tplg_filename = "sof-acp-rmb.tplg",
>> +     },
>> +     {
>> +             .id = "10508825",
>> +             .drv_name = "nau8825-max",
>> +             .pdata = (void *)&acp_quirk_data,
>> +             .machine_quirk = snd_soc_acpi_codec_list,
>> +             .quirk_data = &amp_max,
>> +             .fw_filename = "sof-rmb.ri",
>> +             .sof_tplg_filename = "sof-acp-rmb.tplg",
>> +     },
>> +     {},
>> +};
>> +EXPORT_SYMBOL(snd_soc_acpi_amd_rmb_sof_machines);
>> +
>>   MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
>> index 9dae2719084c..7e56d2644105 100644
>> --- a/sound/soc/amd/acp/Kconfig
>> +++ b/sound/soc/amd/acp/Kconfig
>> @@ -49,6 +49,7 @@ config SND_SOC_AMD_MACH_COMMON
>>       select SND_SOC_RT1019
>>       select SND_SOC_MAX98357A
>>       select SND_SOC_RT5682S
>> +     select SND_SOC_NAU8825
>>       help
>>         This option enables common Machine driver module for ACP.
>>
>> diff --git a/sound/soc/amd/acp/acp-mach-common.c 
>> b/sound/soc/amd/acp/acp-mach-common.c
>> index 6ae454bf60af..4f5cfa26c58d 100644
>> --- a/sound/soc/amd/acp/acp-mach-common.c
>> +++ b/sound/soc/amd/acp/acp-mach-common.c
>> @@ -24,6 +24,7 @@
>>   #include "../../codecs/rt5682.h"
>>   #include "../../codecs/rt1019.h"
>>   #include "../../codecs/rt5682s.h"
>> +#include "../../codecs/nau8825.h"
>>   #include "acp-mach.h"
>>
>>   #define PCO_PLAT_CLK 48000000
>> @@ -175,7 +176,8 @@ static void acp_card_shutdown(struct 
>> snd_pcm_substream *substream)
>>       struct snd_soc_card *card = rtd->card;
>>       struct acp_card_drvdata *drvdata = card->drvdata;
>>
>> -     clk_disable_unprepare(drvdata->wclk);
>> +     if (!drvdata->soc_mclk)
>> +             clk_disable_unprepare(drvdata->wclk);
>>   }
>>
>>   static const struct snd_soc_ops acp_card_rt5682_ops = {
>> @@ -363,7 +365,7 @@ static int acp_card_amp_startup(struct 
>> snd_pcm_substream *substream)
>>       struct snd_soc_pcm_runtime *rtd = 
>> asoc_substream_to_rtd(substream);
>>       struct snd_soc_card *card = rtd->card;
>>       struct acp_card_drvdata *drvdata = card->drvdata;
>> -     int ret;
>> +     int ret = 0;
>>
>>       runtime->hw.channels_max = DUAL_CHANNEL;
>>       snd_pcm_hw_constraint_list(runtime, 0, 
>> SNDRV_PCM_HW_PARAM_CHANNELS,
>> @@ -371,10 +373,13 @@ static int acp_card_amp_startup(struct 
>> snd_pcm_substream *substream)
>>       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>>                                     &constraints_rates);
>>
>> -     ret = acp_clk_enable(drvdata);
>> -     if (ret < 0)
>> -             dev_err(rtd->card->dev, "Failed to enable AMP clk: 
>> %d\n", ret);
>> -
>> +     if (!drvdata->soc_mclk) {
>> +             ret = acp_clk_enable(drvdata);
>> +             if (ret < 0) {
>> +                     dev_err(rtd->card->dev, "Failed to enable AMP 
>> clk: %d\n", ret);
>> +                     return ret;
>> +             }
>> +     }
>>       return ret;
>>   }
>>
>> @@ -409,6 +414,104 @@ static const struct snd_soc_ops 
>> acp_card_maxim_ops = {
>>       .shutdown = acp_card_shutdown,
>>   };
>>
>> +/* Declare nau8825 codec components */
>> +SND_SOC_DAILINK_DEF(nau8825,
>> + DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508825:00", "nau8825-hifi")));
>> +
>> +static const struct snd_soc_dapm_route nau8825_map[] = {
>> +     { "Headphone Jack", NULL, "HPOL" },
>> +     { "Headphone Jack", NULL, "HPOR" },
>> +};
>> +
>> +static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +     struct snd_soc_card *card = rtd->card;
>> +     struct acp_card_drvdata *drvdata = card->drvdata;
>> +     struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>> +     struct snd_soc_component *component = codec_dai->component;
>> +     unsigned int fmt;
>> +     int ret;
>> +
>> +     dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
>> +
>> +     if (drvdata->hs_codec_id != NAU8825)
>> +             return -EINVAL;
>> +
>> +     if (drvdata->soc_mclk)
>> +             fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | 
>> SND_SOC_DAIFMT_CBC_CFC;
>> +     else
>> +             fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | 
>> SND_SOC_DAIFMT_CBP_CFP;
>> +
>> +     ret =  snd_soc_dai_set_fmt(codec_dai, fmt);
>> +     if (ret < 0) {
>> +             dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", 
>> ret);
>> +             return ret;
>> +     }
>> +     ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
>> +                                      SND_JACK_HEADSET | 
>> SND_JACK_LINEOUT |
>> +                                      SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>> +                                      SND_JACK_BTN_2 | SND_JACK_BTN_3,
>> +                                      &pco_jack, NULL, 0);
>
> Here, snd_soc_card_jack_new() should be used instead. Please refer
> comments in sound/soc/soc-card.c for differences between those two
> functions.
will fix it and send newer patchset
>
> Regards,
> Akihiko Odaki
>
>> +     if (ret) {
>> +             dev_err(card->dev, "HP jack creation failed %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
>> +     snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
>> +     snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
>> +     snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
>> +
>> +     ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
>> +     if (ret) {
>> +             dev_err(rtd->dev, "Headset Jack call-back failed: 
>> %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return snd_soc_dapm_add_routes(&rtd->card->dapm, nau8825_map, 
>> ARRAY_SIZE(nau8825_map));
>> +}
>> +
>> +static int acp_nau8825_hw_params(struct snd_pcm_substream *substream,
>> +                              struct snd_pcm_hw_params *params)
>> +{
>> +     struct snd_soc_pcm_runtime *rtd = 
>> asoc_substream_to_rtd(substream);
>> +     struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>> +     int ret;
>> +
>> +     ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS,
>> +                                  (48000 * 256), SND_SOC_CLOCK_IN);
>> +     if (ret < 0)
>> +             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", 
>> ret);
>> +
>> +     ret = snd_soc_dai_set_pll(codec_dai, 0, 0, params_rate(params),
>> +                               params_rate(params) * 256);
>> +     if (ret < 0) {
>> +             dev_err(rtd->dev, "can't set FLL: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int acp_nau8825_startup(struct snd_pcm_substream *substream)
>> +{
>> +     struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>> +     runtime->hw.channels_max = 2;
>> +     snd_pcm_hw_constraint_list(runtime, 0, 
>> SNDRV_PCM_HW_PARAM_CHANNELS,
>> +                                &constraints_channels);
>> +
>> +     runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
>> +     snd_pcm_hw_constraint_list(runtime, 0,
>> +                                SNDRV_PCM_HW_PARAM_RATE, 
>> &constraints_rates);
>> +     return 0;
>> +}
>> +
>> +static const struct snd_soc_ops acp_card_nau8825_ops = {
>> +     .startup =  acp_nau8825_startup,
>> +     .hw_params = acp_nau8825_hw_params,
>> +};
>> +
>>   /* Declare DMIC codec components */
>>   SND_SOC_DAILINK_DEF(dmic_codec,
>>               DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", 
>> "dmic-hifi")));
>> @@ -437,6 +540,8 @@ SND_SOC_DAILINK_DEF(i2s_sp,
>>       DAILINK_COMP_ARRAY(COMP_CPU("acp-i2s-sp")));
>>   SND_SOC_DAILINK_DEF(sof_sp,
>>       DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
>> +SND_SOC_DAILINK_DEF(sof_hs,
>> +                 DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
>>   SND_SOC_DAILINK_DEF(sof_dmic,
>>       DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
>>   SND_SOC_DAILINK_DEF(pdm_dmic,
>> @@ -491,6 +596,31 @@ int acp_sofdsp_dai_links_create(struct 
>> snd_soc_card *card)
>>               i++;
>>       }
>>
>> +     if (drv_data->hs_cpu_id == I2S_HS) {
>> +             links[i].name = "acp-headset-codec";
>> +             links[i].id = HEADSET_BE_ID;
>> +             links[i].cpus = sof_hs;
>> +             links[i].num_cpus = ARRAY_SIZE(sof_hs);
>> +             links[i].platforms = sof_component;
>> +             links[i].num_platforms = ARRAY_SIZE(sof_component);
>> +             links[i].dpcm_playback = 1;
>> +             links[i].dpcm_capture = 1;
>> +             links[i].nonatomic = true;
>> +             links[i].no_pcm = 1;
>> +             if (!drv_data->hs_codec_id) {
>> +                     /* Use dummy codec if codec id not specified */
>> +                     links[i].codecs = dummy_codec;
>> +                     links[i].num_codecs = ARRAY_SIZE(dummy_codec);
>> +             }
>> +             if (drv_data->hs_codec_id == NAU8825) {
>> +                     links[i].codecs = nau8825;
>> +                     links[i].num_codecs = ARRAY_SIZE(nau8825);
>> +                     links[i].init = acp_card_nau8825_init;
>> +                     links[i].ops = &acp_card_nau8825_ops;
>> +             }
>> +             i++;
>> +     }
>> +
>>       if (drv_data->amp_cpu_id == I2S_SP) {
>>               links[i].name = "acp-amp-codec";
>>               links[i].id = AMP_BE_ID;
>> @@ -523,6 +653,30 @@ int acp_sofdsp_dai_links_create(struct 
>> snd_soc_card *card)
>>               i++;
>>       }
>>
>> +     if (drv_data->amp_cpu_id == I2S_HS) {
>> +             links[i].name = "acp-amp-codec";
>> +             links[i].id = AMP_BE_ID;
>> +             links[i].cpus = sof_hs;
>> +             links[i].num_cpus = ARRAY_SIZE(sof_hs);
>> +             links[i].platforms = sof_component;
>> +             links[i].num_platforms = ARRAY_SIZE(sof_component);
>> +             links[i].dpcm_playback = 1;
>> +             links[i].nonatomic = true;
>> +             links[i].no_pcm = 1;
>> +             if (!drv_data->amp_codec_id) {
>> +                     /* Use dummy codec if codec id not specified */
>> +                     links[i].codecs = dummy_codec;
>> +                     links[i].num_codecs = ARRAY_SIZE(dummy_codec);
>> +             }
>> +             if (drv_data->amp_codec_id == MAX98360A) {
>> +                     links[i].codecs = max98360a;
>> +                     links[i].num_codecs = ARRAY_SIZE(max98360a);
>> +                     links[i].ops = &acp_card_maxim_ops;
>> +                     links[i].init = acp_card_maxim_init;
>> +             }
>> +             i++;
>> +     }
>> +
>>       if (drv_data->dmic_cpu_id == DMIC) {
>>               links[i].name = "acp-dmic-codec";
>>               links[i].id = DMIC_BE_ID;
>> diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
>> index 5dc47cfbff10..c95ee1c52eb1 100644
>> --- a/sound/soc/amd/acp/acp-mach.h
>> +++ b/sound/soc/amd/acp/acp-mach.h
>> @@ -26,6 +26,7 @@ enum be_id {
>>
>>   enum cpu_endpoints {
>>       NONE = 0,
>> +     I2S_HS,
>>       I2S_SP,
>>       I2S_BT,
>>       DMIC,
>> @@ -37,6 +38,7 @@ enum codec_endpoints {
>>       RT1019,
>>       MAX98360A,
>>       RT5682S,
>> +     NAU8825,
>>   };
>>
>>   struct acp_card_drvdata {
>> @@ -49,6 +51,7 @@ struct acp_card_drvdata {
>>       unsigned int dai_fmt;
>>       struct clk *wclk;
>>       struct clk *bclk;
>> +     bool soc_mclk;
>>   };
>>
>>   int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
>> diff --git a/sound/soc/amd/acp/acp-sof-mach.c 
>> b/sound/soc/amd/acp/acp-sof-mach.c
>> index d1531cdab110..adbae809f2aa 100644
>> --- a/sound/soc/amd/acp/acp-sof-mach.c
>> +++ b/sound/soc/amd/acp/acp-sof-mach.c
>> @@ -56,6 +56,16 @@ static struct acp_card_drvdata 
>> sof_rt5682s_max_data = {
>>       .dmic_codec_id = DMIC,
>>   };
>>
>> +static struct acp_card_drvdata sof_nau8825_data = {
>> +     .hs_cpu_id = I2S_HS,
>> +     .amp_cpu_id = I2S_HS,
>> +     .dmic_cpu_id = DMIC,
>> +     .hs_codec_id = NAU8825,
>> +     .amp_codec_id = MAX98360A,
>> +     .dmic_codec_id = DMIC,
>> +     .soc_mclk = true,
>> +};
>> +
>>   static const struct snd_kcontrol_new acp_controls[] = {
>>       SOC_DAPM_PIN_SWITCH("Headphone Jack"),
>>       SOC_DAPM_PIN_SWITCH("Headset Mic"),
>> @@ -124,6 +134,10 @@ static const struct platform_device_id 
>> board_ids[] = {
>>               .name = "rt5682s-rt1019",
>>               .driver_data = (kernel_ulong_t)&sof_rt5682s_rt1019_data
>>       },
>> +     {
>> +             .name = "nau8825-max",
>> +             .driver_data = (kernel_ulong_t)&sof_nau8825_data
>> +     },
>>       { }
>>   };
>>   static struct platform_driver acp_asoc_audio = {
>> @@ -143,4 +157,5 @@ MODULE_ALIAS("platform:rt5682-rt1019");
>>   MODULE_ALIAS("platform:rt5682-max");
>>   MODULE_ALIAS("platform:rt5682s-max");
>>   MODULE_ALIAS("platform:rt5682s-rt1019");
>> +MODULE_ALIAS("platform:nau8825-max");
>>   MODULE_LICENSE("GPL v2");
>> diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
>> index 0a54567a2841..7b4c625da40d 100644
>> --- a/sound/soc/amd/mach-config.h
>> +++ b/sound/soc/amd/mach-config.h
>> @@ -19,6 +19,7 @@
>>   #define ACP_PCI_DEV_ID                      0x15E2
>>
>>   extern struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[];
>> +extern struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[];
>>
>>   struct config_entry {
>>       u32 flags;
>
