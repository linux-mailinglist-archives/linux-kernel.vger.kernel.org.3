Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DA4770D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhLPLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:43:40 -0500
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:34855
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233399AbhLPLnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtILEALC8y9Bz3XHU00cWDRvnNqmGwnckdzLAUVc0RPEbgWCPSJRE3RHUgspf0TjoB67zaejhSudHPQXN9duMkTg8GEHvDw4rtVrszCw5Wdm3X57nVWy203UvpQqkvNjvpxOJjJSzuKLJXwaAE1mlwswVARyzdFC2bRyJA6wdzKhrEgRY3qXd8NrdW+G0HUNwf8TndOsZQmciIbxDkaLcs9XdGniXBR8z4E2WlMDnWzCGqqn87ugiZQw+I9EI/2tBt923myudwwoXKoUyiQSrPqhzfbIX5MFL15DhhQho6lCJ/i+CMWDB7IpGLzHQmq1ckBeHwZTnWu53THbrFEOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzltwRAWBuzi/BVQ2nV6RFniv4bDQJX7n6hlQ2SU/nw=;
 b=V52QdAFRbPqDtGDBvayBjkBumuYiDbSxuQmlebkUNwIBZWHhTB2mZMC0l2lAJswygAt+xeKOHktMQ6YuHedWxS8+uIWBUjB/3ZMiSKQOXiuqKcafC8dF0uRBPdzcxKsgMYAblGgDREUNE9ICSY3dbI58ZU1pfkNlT0vi/wX+RN7XsqSJSdb93s7kjsVNLD7P024G/BdmmymlQomoy/pHWc7mXkYxcgp9TwaEbpwO1gFzrNRbzeMpo+eTFiQd6cQiKZxTY4ZN7yPTjcEFVCUarDkq9ECqjT+rlnesStWm3/WiUGVpZh0msyrazVXSWmI6Vyh/bqIDLwp9Y95AQ6BGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzltwRAWBuzi/BVQ2nV6RFniv4bDQJX7n6hlQ2SU/nw=;
 b=aClH9B0taq0pknBJMq8HgptgMUVaaKsBsLnoRaNTPaKigVGvi3k6lMgkdavY65h2nh3aQPDgO3UG3iQ3YhIEgZshO7yVFO2G3gr6kPurHC0SUSyc/dW2oy2Uj43slA9XhnGaR5myK/CJ+FhnAfpJ+Ay5FJGJKzTAyqWq0fkBE7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 11:43:33 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6%5]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 11:43:33 +0000
Message-ID: <a08db422-7f51-4156-5e9e-62b7938dad29@amd.com>
Date:   Thu, 16 Dec 2021 17:13:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP
 playback output
Content-Language: en-US
To:     =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        "Sunil-kumar.Dommati@amd.com" <Sunil-kumar.Dommati@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Basavaraj.Hiregoudar@amd.com" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Jack Yu <jack.yu@realtek.com>,
        =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Albert Chen <albertchen@realtek.com>
References: <20211208185517.1555884-1-AjitKumar.Pandey@amd.com>
 <20211208185517.1555884-2-AjitKumar.Pandey@amd.com>
 <126eab881bb540bc84ecc5cb9c6865a8@realtek.com>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <126eab881bb540bc84ecc5cb9c6865a8@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::21) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b3e02b-ab09-40f6-0d44-08d9c0894963
X-MS-TrafficTypeDiagnostic: DM5PR12MB2408:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB240873E6CB9C0F383A0FA73882779@DM5PR12MB2408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoH/TauClVed6+Us+imddxE/3L0Kho+BcXK+KOFHFExon5FlHEfMoslhnEDH7FJVAcdBHrxeyMdugrGJq4wbKphUQvQ82v6no5QRX+tTpwdrQaNZbwd2DENPIYfrfYTojcN4LFPzwxmWwiSsGCpg9zU4o3LztG+tnC3cgHZUI/Ak8ArqoCgR37+oDRWj9PItUehrWsBc4XC8oiYvCSCU8XlCXLO+BNu2uNiteKVmBeZM7h4FevxZvyBmZMtmkHbllSmbYrBGT9PWFSsMN5LmLRyZ2Tg/wWboWcdjRsstkqqhT0BkxD5YIRTpU1694YZFfkx2ylJSZgsilqR0GxZDtORaSwqty13J4h11RaAyq/yZ5cJctFyo4eZO+HEEBsXN3AJnKQuspaqEqQaHnlZNXT34fA5BTK5b0MyU0esBre9JYwzM4a8n5IrSKjnKls2Sqfyw7yKEKm0u+KjA/wcWt1LzFC6p0DrKM24Jx9Hx+hCJNiQjReHdp9/b1bE6lm1fRlLwfh7BplkfrRnsiwpPpwJXJ1VLtPEcoR0AmluLWOOboflsU9j46p30P/dK2BP6LKrZgO5pEuHYb62K5w1i2VElpXFvHggfeVK9ASQoNf6WCk2D/dGCqyRm6e2SUHcsQWZNMGembi6zj2QnLn8DDHDI9THcNL+qeh5DZUdj4ewxV8sCga7odO1luAFYOmH2SquXp4woEKbqaOEepQLcoT5/WAAm+qB0/CLer4mDdiBQp+LCuotoUaNQ4NI8pMu+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(4326008)(8676002)(6512007)(6666004)(7416002)(86362001)(36756003)(508600001)(6506007)(316002)(2616005)(53546011)(110136005)(5660300002)(31696002)(26005)(54906003)(186003)(38100700002)(66556008)(66946007)(31686004)(66476007)(6486002)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJCUW1nU01YVzBqdDBuSzYwN3BGTS9Oa3UySlRQNXg3c2NBbEIyU1cwZGd6?=
 =?utf-8?B?V2VnL3JscHFTanZTZWR6TUhGYmpqOUFnblVEM1JmVWo3YlorSmYwZ2kxTkI1?=
 =?utf-8?B?NW9DblorbG5wLzNPMlB0Qnl1cEUrdGVMRk5qNDByMGpKbjZrNnFvMW1hRDVR?=
 =?utf-8?B?Yi9YTDBLZFNEemNlVUxoWFhaYVNrTmVjdWVtZ1VCUmJFTlZTS2crK2xMVzJP?=
 =?utf-8?B?MFluSmhqWHQ4Ry8yaDJlczJRTlZEWW5ndDNxNHJiNEpaakxIKzkxYi9weklI?=
 =?utf-8?B?YmR3eFZJU0lkWUZybCtsOE5lNy9JaWZJZWlBaVhFb3Q0ak9FRnJDSENSYlVR?=
 =?utf-8?B?ZWwxYWNhdFBCRzdMMHJrL1EwQzBURHNXWnZIY2I4aC9BV3RubWtvOEtDTCtM?=
 =?utf-8?B?bFhOdHA1R1hkL0FQUGJXYTc2Nk53VjJYa3pIUVFGRVhNMGxsZHE4TVVCOUMz?=
 =?utf-8?B?VXo3T21uSnFib1pCcWQzWjBHMlMxRFc3b21CdTNaNUgyRWhtN1E0VmM4bWk2?=
 =?utf-8?B?OWFtMWFUdGN5UGFwdExSVUtiN01xeWR0STh4aDh6M21hVU5Ib3VDNGRsdnc2?=
 =?utf-8?B?bStYQkVvSzRmd2VMVXQ5MkZxQXE3TE9Gbmk2dURjaFhxQ0tPUTY0M0p2NW5W?=
 =?utf-8?B?ZTA3VVp6T3ZaT2t5ejJBSnErL3pVZGpDNWV3WDNhbS9pTW9xTGdCdXlETUxB?=
 =?utf-8?B?bDNqc0N1ZVNld0VGWnFMVXlTVGxITmNDZUc1SFBUSWVaN3p2KzVoQ1Q2TTVl?=
 =?utf-8?B?TzBQOUhNZGZxUzJaTUlOVVRiWHpMS2t5dlNXaWVld0hYeWZSNXF3SlViUVZ4?=
 =?utf-8?B?dG85S3JrNU9VTzhna214ellXN0VZRGZ2RUwveG1GWDFMaWNlV0l1b01OVjg1?=
 =?utf-8?B?Rk1nZTdLTDdLMDNoK0FxbC9KczI0MXZRR2JDTkUzL0dtYmppTjU1Ryt5cnJZ?=
 =?utf-8?B?WTRwS1FwUDR1S0pENmhpdDQxVWIvOE1QOFZzbjk4bUkvaXlodTFMeUNMcllL?=
 =?utf-8?B?RDBTUHYybUNTc0xRcjVXdVRaUWw3OUxKUnV6enFYdlJ0UUJwZEF3UGxTWmlE?=
 =?utf-8?B?U3loMkJmbVgzZGM4alRqTldWeExNUUxwOGJjbm83Y0Q5ckRuWi8xSVRZNWRY?=
 =?utf-8?B?elI0RTFnbndHaEdzV0prL3hHSUVlTmlzU1lHMFlSNXZNMmpSNDkvMGVaVHlE?=
 =?utf-8?B?N3d5a05yR2N6VzM2em00b0MwR0dOY1BDb2dBamhOZkZ3cnMrdzlNc1VGMkcr?=
 =?utf-8?B?cFB0RHhjVi95Z1d4cjNHVkdjTFBkR1NqVDB3UDJaVTNCNFo4dGFlNW5GcXdJ?=
 =?utf-8?B?Z2NjTUVBMnNobmhDc3Y1MGNuTlk2RDVqN1lTTlUyZEFmdmtLZm5WRHJabitv?=
 =?utf-8?B?dW9Fem0wOCtIUDMyYlZuUmhRdTl4b0N5NHg2QngxRVVHM2pIeTVwYytsZmRS?=
 =?utf-8?B?Yk03MTZWcHAyOUpacVdUaWx5NE9mZzcrOEdNYU1WTW16bEVYMksxNjY0ZlZQ?=
 =?utf-8?B?d3MwaUp0eWNhVmJQSytSMzVVb3ljYkc4YXBGc2s5aDRoTHNPdStlUks2QjFZ?=
 =?utf-8?B?YURpWjR1cnQzb2gxYXErbkFHU1I1ZEIrOTQ4aC9DRm5ZZ0luR1Zidlpyd1E5?=
 =?utf-8?B?UVpqMnJLUG9BVGNCcHVtRUwvczlSN1llanM3azhhaTVFVVBZTkN6M1NWVU5Z?=
 =?utf-8?B?WDg0ODN6dW5adnBaczJaQlg4ZWFnTnZvbjZDczNERmxuU2ZRb3F4MjVZYVVT?=
 =?utf-8?B?L1duZGkydU10Wmw0QjZzb2d6SC93TUNxN3NHbWp0Q3VVclhOVE9yN3JPMnFp?=
 =?utf-8?B?L0lzb1ovSWZKTlRYdFZ6NVZzelBNOWl5RFZUcVFnRjZwZUZ4OTBWdDFDL2FO?=
 =?utf-8?B?c1JMRUdlTUN4dVRjdGJCL0VXMk1TWFVHQ1RBT0dSWW1kMnlKWE9TbFFPeDY2?=
 =?utf-8?B?M1NlZ3ZFbkcyaUZiYzlveWZ1VkRkK2hpNC9kRmUzU1pidU5CV280RWZORlhR?=
 =?utf-8?B?M1R2Q1pjdWF4TnBPT0FnTE42MndCMGZXRi9sNzdHc085SXpTRFYweUFOazkz?=
 =?utf-8?B?bHBHMkx4V2tvUzNEZUlMR2Z4VTZjVll0d2t1cnlaTXBwRjJWcnlqaU1qWnl4?=
 =?utf-8?B?Q3AzQ3Z0RDRqRitGKzRzZEhJMVhOb1BaWCtURzRLVk5yZkZLMHhaKzNIN0Nw?=
 =?utf-8?Q?nPACR0whNXHZQ6fO+G5pwjQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b3e02b-ab09-40f6-0d44-08d9c0894963
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:43:32.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GzlYoAbb1A1usWR8sWyi8AKWzzPivK9mOYY+QhLz/fmQEfPKpw4+AtvR08HUYIpJp8lDx7Ws4fJfG77cQxtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/2021 7:55 AM, Shuming [范書銘] wrote:
> [CAUTION: External Email]
> 
>> Subject: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP
>> playback output
>>
>> Add dapm switch in playback path to mute or unmute HP output data.
>> We will set and reset MUTE_SFT bit in RT5682S_HP_CTRL_1 register based on
>> switch value to mute or unmute respective channel.
>>
>> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>> ---
>>   sound/soc/codecs/rt5682s.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c index
>> d49a4f68566d..21ab5f7df422 100644
>> --- a/sound/soc/codecs/rt5682s.c
>> +++ b/sound/soc/codecs/rt5682s.c
>> @@ -1573,6 +1573,14 @@ static const char * const
>> rt5682s_adcdat_pin_select[] = {
>>        "ADCDAT1", "ADCDAT2",
>>   };
>>
>> +/* Out Switch */
>> +static const struct snd_kcontrol_new hpol_switch =
>> +     SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682S_HP_CTRL_1,
>> +             RT5682S_L_MUTE_SFT, 1, 1);
>> +static const struct snd_kcontrol_new hpor_switch =
>> +     SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5682S_HP_CTRL_1,
>> +             RT5682S_R_MUTE_SFT, 1, 1);
>> +
>>   static SOC_VALUE_ENUM_SINGLE_DECL(rt5682s_adcdat_pin_enum,
>>        RT5682S_GPIO_CTRL_1, RT5682S_GP4_PIN_SFT,
>> RT5682S_GP4_PIN_MASK,
>>        rt5682s_adcdat_pin_select, rt5682s_adcdat_pin_values); @@ -1746,6
>> +1754,11 @@ static const struct snd_soc_dapm_widget
>> rt5682s_dapm_widgets[] = {
>>        SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0,
>> rt5682s_hp_amp_event,
>>                SND_SOC_DAPM_POST_PMD | SND_SOC_DAPM_POST_PMU),
>>
>> +     SND_SOC_DAPM_SWITCH("HPOL Playback", SND_SOC_NOPM, 0, 0,
>> +             &hpol_switch),
>> +     SND_SOC_DAPM_SWITCH("HPOR Playback", SND_SOC_NOPM, 0, 0,
>> +             &hpor_switch),
>> +
>>        /* CLK DET */
>>        SND_SOC_DAPM_SUPPLY("CLKDET SYS", RT5682S_CLK_DET,
>>                RT5682S_SYS_CLK_DET_SFT, 0, NULL, 0), @@ -1895,8 +1908,10 @@
>> static const struct snd_soc_dapm_route rt5682s_dapm_routes[] = {
>>        {"HP Amp", NULL, "CLKDET SYS"},
>>        {"HP Amp", NULL, "SAR"},
>>
>> -     {"HPOL", NULL, "HP Amp"},
>> -     {"HPOR", NULL, "HP Amp"},
>> +     {"HPOL Playback", "Switch", "HP Amp"},
>> +     {"HPOR Playback", "Switch", "HP Amp"},
>> +     {"HPOL", NULL, "HPOL Playback"},
>> +     {"HPOR", NULL, "HPOR Playback"},
>>   };
> 
> RT5682S enables the 1 bit control for HP output.
> Therefore, the setting of RT5682S_HP_CTRL_1[15][7] will be not effective.
> 
>
Ok, it was actually effective and muted audio when we test in our 
platform, possible because i'm tearing down dapm path based on switch
value. If we don't have register bits available to mute i'll resubmit 
the change with virtual switch widget to disable DAPM and stop audio.

