Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468AE595588
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiHPIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiHPIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:46:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA697962C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDAGDQtByKdFMNf718gjFc9JQEEPcQjRr/AnxAbAaRB3Ypfhhl9DTqJNzI8dh1Za22QfcTaZvP9rT7wecWTpd6ivnI3gbSVtlyaaqLKDN+LSEHp62aJVyXY/IJgVuh5DvYMzDYkyYtpg4BOstW5SOVkcJCQb/vMd+xWBbyU5pJI9xTXV0yGJI8xPiqU2FincmRSD+ZO78sa5phbnO6W/1/BQF39UkUAZ5OCXO1KBybljBC9TOnnPV9Gh22MWFBhc1KUelk6IDRhorfeP9fM2K+vHnvYl6hbVSJY4IOm6bLDCF4jJqfR/mXZIahyJJjyNru3JsCOramAkiM2gY1Yb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys1x4tb/g/17mSf0RPPZNnvh92yh4LIJAGkb9dh1wjY=;
 b=gNudmKzCI0gm45tyiCuXQGqQ/BP/Nf+bRDwcdKrirVHI+07w/j5XJfFt7fp7Gzj9PbpYzCOanPn/V76re/nITOopBjzoBd9FSE4y+lIU1vxqKIpnj2bhydVDcwP7lx6PatzDTuM6rq9vmOBrv7t3SrPgBukfvMSyPWwNVuXomEbjlP+LQChaXqHuSlwqsvKOFDDHNZfCgFnr5uoyIRI7bxzpWAXToBlZiP0dQDk4WYTHk/UF+u4DVX67BfOxEjdArpB90rzxKDIFXBuSqXaX93WyL7+maRU+Vr0yMzrAtgcofwwjjnOCSwiH+jZglfs0a9RXoCC4pjcLv7GlL5LUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys1x4tb/g/17mSf0RPPZNnvh92yh4LIJAGkb9dh1wjY=;
 b=Ml5U1jFb3NI7VL4ES8AytOQumfu8u3UqMY51C+viID5IutM8mJAWenj4woVudZRct7xOowiZJgxzRrukcbhZyElY6zXsJ99C5AoSDD1ekY7urn+KMELgM/mJsOVXR+ot6/9vbC4Rb3KjogxJBJqa4Jm1ElaFU7j2Qkdryufk9N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 06:51:47 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 06:51:47 +0000
Message-ID: <bd701478-364f-fe3f-e16a-515e2714d430@amd.com>
Date:   Tue, 16 Aug 2022 12:19:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] ASoC: amd: add platform devices for acp6.2 pdm
 driver and dmic driver
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, mario.limonciello@amd.com,
        Vijendar.Mukunda@amd.com
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-5-Syed.SabaKareem@amd.com>
 <f55c444b-d1c7-9d61-1f0c-c6bfe32ca2db@linux.intel.com>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <f55c444b-d1c7-9d61-1f0c-c6bfe32ca2db@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f97b460-c319-4008-5e40-08da7f53c987
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OmMS/AR2qdd+6Pg2h7AQbMrKlezRifh5AgIvZTEd0T1Jdnw20x/H33KAawxy3R88WMaH9Hg/mu9N2iAKVgy/Dy8QnCx8oPMkfdevEXnK5Tr5V+yZg+vTyQPz3AM8GaKfh4m+QplhFdDdKC9Rw2Q46E125WRjXTNWWFx5+fOnR6v6XE/SSAQcGx/o2CsH+nUFBPPAF0UefmHECD2RkD453KxOOx1sajSiuJM3s66Hkou9JIw1RN1/hzfuip0zdfbfMbOzeNhFkoVKexjhF1Rv71cyeAh2qQTT2KIamuIx/bOzNZ5jWlJ/jZ6MrsE/UbPsxPjq+Ro+ipSAR5QrjgbPmC7XeI5gB3HXicfKMZkWu37uXNHOF6ytcAPQY3tHNg2IX6pzGpDJuM++qeUgeBUmcP0lE4pfBPxjV5ILrS5dWVDrEoWOytqx6a7481syIXGpzt7wzx2BdCs806+7CuiHar3O/mnAsgxm5DxXr4T9xkvBkiuGpV/uHnWxf3QAxyYVLOnmd6Jrw/Uccptv6LC8PGKy8U+EdKN6WoN/z2BkYYJdZMqspLE3gWS6LB29rIQm/UVgFg+Vzy124RRPcq9TGTecz5lGvQohmJKAfPmPEOK9JCnZ1juCTyAmSZsROq/CV+hgheeg3Pjs7goODkRAA1gESVonWrBXNEhzunPVhS8PNDurdRMswgAhhOPjqkDYfx8HjMyrwFW9pggCES+1D64Hb3Vxs670yIbGo44HBci5MZ0BYuV96V3OOfOwD6PAQOaZBEXPRaEmxi30JL9tIBwdIoHHJlyJ+pvf7kaEU7jqVtN6UGIfDHnQAxzVTcdW7/tBrAbpgjtQR3wSvCETg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(54906003)(5660300002)(6506007)(53546011)(41300700001)(26005)(31696002)(6512007)(8936002)(66946007)(6486002)(66476007)(478600001)(110136005)(8676002)(316002)(66556008)(36756003)(2906002)(4326008)(83380400001)(2616005)(31686004)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE4xS3hzNlRvdURjVnFGRW9qRURlOHJvMDlFMmhrNTlLelBqYStJbEdQWXcw?=
 =?utf-8?B?WWJZb2JucS9YUzhadTlvVVRnT2F0OGFIVEVFVkhWZUlwTCtHcTd5UDRjNVVr?=
 =?utf-8?B?Q2RIYjFiU2w4KzBBb1RBVFZZQlIyUnNJaitxeTROYi9MQWpaamdjREhzZkhl?=
 =?utf-8?B?VEg5b1JmaVcya0VnK3B2ZldmNTRHQ1pOdXB0NlBjVUNpUmFSb01QWStIbjJn?=
 =?utf-8?B?VHpuYklNQ3FJS0ZqSTdhMldIQ1k1ZCs2cVJBbTQzYmhuTjgybnNVdUQvZzZW?=
 =?utf-8?B?cDFuNFRPYU9Ra0lxRTBINzFNMk40ZmNlVmxSQmZ0UDZLNzBTR2FBNC9Ed3NO?=
 =?utf-8?B?QkxEOXV3eDBmRUJRb2c5NnpaWEg0bjhseExORm41UlVwS1JMQTZneEd4d3I4?=
 =?utf-8?B?UFlhNkxrQ3U3MXFUNXJ3R0cxNVQxQ2p2UUJEY2IzcDE0bW4vK0s2ZlpUYnZz?=
 =?utf-8?B?OWp3TnVEUzM2ZHJTLzArS3BUTlJURHpyOVJGMHM2cjRSTU8yZDA4bERPbVU2?=
 =?utf-8?B?Wmk1WWNJUng3eDdzcit0enFRNUNZbkNWOHhzdjlRTGRvSmFHNGJ6ampzWFJH?=
 =?utf-8?B?cVgyQTViUHg1MTlUVXA4TjRXNkxyaHpOY2NITS85K2V1VVFwZnBid3pIM00r?=
 =?utf-8?B?aWE5ME0rcGZta3AwSU5rUHJ6amxaREliQXExaE5GNk9qRHVBYkFRUEc3SGRs?=
 =?utf-8?B?SU9rWE9oOWRYMThVNzdtR0NWOStObVdaQzREVUYzNCtKTS90TnpOWlFYbDRv?=
 =?utf-8?B?QXptVnVHYjZqaW1HdjZvL1dwVkpka2dLUmVpYjBBaHJMMmh0UDlnRHRtSzla?=
 =?utf-8?B?U1lSTm5FOEU3bytTeE9xbjJoR1RKY2cxVjR5ZFNmZFZkOEQwV2dYdHZaWnBk?=
 =?utf-8?B?ZDJUNmZnd3ZIdlljdEEzK2FyNHh3bkh2VktjaEJhalduY0RTMjExdUcvZFFG?=
 =?utf-8?B?b2crd0tiQnRzV0s2dzBYaUdqTkZTRHYvaXc5MStUV3lmOXJmcHlCWlYxcFov?=
 =?utf-8?B?QzhBaEYzcUV6NEFMQUZwYkF3a2RWcktHblMvM2Z2V21VZWdhVTR1SmZtMzJr?=
 =?utf-8?B?TWhwNXAvb0pOdXA0R2NEQTE1N1pzMkRxZGNJcHJzVEhybWt5ZW4waFpxdGt3?=
 =?utf-8?B?YmNPbkdWSUd5VXp0RUY3OWQ0c1dlSXNHUmhNcDFlVGRsRUZLaG1Hejl0Rmh4?=
 =?utf-8?B?TjJETWs1Z2NJcFZkZVpqQ1Ztb3lGWUZDVHlTQ3UwS1lZaXFGSjVndDJlUHFF?=
 =?utf-8?B?REd2QmZmM3dDWVZyMk9MVjlVZ1MzOUIreTJkNFlpbGhEL0JWNUFkTXRlT1ZI?=
 =?utf-8?B?SlFaVXJ4UHE4dlBFUmY0T0V2UEhHUUpNMjNBdXczSWxDRnRnMnRPcjdWOXFs?=
 =?utf-8?B?R2ZZVkFKTVQ4VU0rZ2VXZ2RRNkpvQVFmbjZGREhYNE1RVEllbkpURkV0WlJw?=
 =?utf-8?B?cHVvRnppeHI0Q2lEcGd4STl3YTdSTk10NFVITWtFb0NtK2ozM05lZnUxSE1o?=
 =?utf-8?B?b3gwaVcrdktUWGJCeVkwbXdxd2hnUG4vR094WGNETWYyeDZNeHY3STVJNjVJ?=
 =?utf-8?B?TzBHY2JDVm9DL1hydkg1VkttdFQrSVVtMFVnbC9ocnJ4cmRzNzVtZU1GYWpQ?=
 =?utf-8?B?ZnNEOEZaQ0VpVmlHMTFzMFRTcG1UUmdVcEVGYzZMd0ZRRVZycE9OYjRrd05p?=
 =?utf-8?B?eDhJQmhFRXZZSXYrVU84OU5KZFowQkRRTHIzQnZEdUdTdkV5TVFuN3lmZ3pY?=
 =?utf-8?B?Z0xhN0o5akc4VFlBZjhrRlNTMnExUmZDdzlpN3pETUVZdU92NjAwSi9XdFps?=
 =?utf-8?B?bGdNSEFCaVFxMkJpaUp3N3l1SEtDL3pVQzJ0VnhUbmhGeHA4a2tqVUQ0c3ln?=
 =?utf-8?B?TDRwVUozQ3JlWjM1M2s2dDRPVmxsK3NFNXZUWXRyQStGbzJFdm1ETlFIVGk3?=
 =?utf-8?B?aldOV2tuRmFKT241MWZsdklFM0JnaklBb1d3V1ZUV3BjbktnWWQ2Q2JQZlV6?=
 =?utf-8?B?QXVDaEt2ZDFodzdnY2crdDlUV1haSzRNcGxVNGxKVW1BcG5lQ2l1eUZ5Zmc2?=
 =?utf-8?B?ckVmdFZGRzFZNGE0UDZDVC9OK1AzNWdPMmltZ3VTUzdxejB6Vnh3NjJFOEtm?=
 =?utf-8?Q?4cChjOtK41fiKVp0+ycpeku90?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f97b460-c319-4008-5e40-08da7f53c987
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:51:47.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gc/f52UcbXHNcF1Sh1HKEiYIkxueuNbAPgAtKcO3Z2ijDZimRjDzXFyS89C9WOuCZSd71L5ABUV5f87ng9Em6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 19:50, Amadeusz Sławiński wrote:
> [CAUTION: External Email]
>
> On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
>> ACP6.2 IP has PDM decoder block.
>> Create a platform device for it, so that the PDM platform driver
>> can be bound to this device.
>> Pass PCI resources like MMIO to this platform device.
>>
>> Create a platform device for generic dmic codec driver.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>   sound/soc/amd/ps/acp62.h  | 23 +++++++++++
>>   sound/soc/amd/ps/pci-ps.c | 83 ++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
>> index 8e734f190b11..ab56e1f8c31b 100644
>> --- a/sound/soc/amd/ps/acp62.h
>> +++ b/sound/soc/amd/ps/acp62.h
>> @@ -9,6 +9,10 @@
>>
>>   #define ACP_DEVICE_ID 0x15E2
>>   #define ACP62_PHY_BASE_ADDRESS 0x1240000
>> +#define ACP6x_REG_START              0x1240000
>> +#define ACP6x_REG_END                0x1250200
>> +#define ACP6x_DEVS           2
>> +#define ACP6x_PDM_MODE               1
>>
>>   #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK       0x00010001
>>   #define ACP_PGFSM_CNTL_POWER_ON_MASK        1
>> @@ -22,6 +26,25 @@
>>   #define ACP_ERROR_MASK 0x20000000
>>   #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
>>
>> +enum acp_config {
>> +     ACP_CONFIG_0 = 0,
>> +     ACP_CONFIG_1,
>> +     ACP_CONFIG_2,
>> +     ACP_CONFIG_3,
>> +     ACP_CONFIG_4,
>> +     ACP_CONFIG_5,
>> +     ACP_CONFIG_6,
>> +     ACP_CONFIG_7,
>> +     ACP_CONFIG_8,
>> +     ACP_CONFIG_9,
>> +     ACP_CONFIG_10,
>> +     ACP_CONFIG_11,
>> +     ACP_CONFIG_12,
>> +     ACP_CONFIG_13,
>> +     ACP_CONFIG_14,
>> +     ACP_CONFIG_15,
>> +};
>> +
>>   static inline u32 acp62_readl(void __iomem *base_addr)
>>   {
>>       return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index 2014f415af15..94201f75427a 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -9,11 +9,16 @@
>>   #include <linux/module.h>
>>   #include <linux/io.h>
>>   #include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>>
>>   #include "acp62.h"
>>
>>   struct acp62_dev_data {
>>       void __iomem *acp62_base;
>> +     struct resource *res;
>> +     bool acp62_audio_mode;
>> +     struct platform_device *pdev[ACP6x_DEVS];
>>   };
>>
>>   static int acp62_power_on(void __iomem *acp_base)
>> @@ -117,8 +122,11 @@ static int snd_acp62_probe(struct pci_dev *pci,
>>                          const struct pci_device_id *pci_id)
>>   {
>>       struct acp62_dev_data *adata;
>> +     struct platform_device_info pdevinfo[ACP6x_DEVS];
>> +     int index, ret;
>> +     int val = 0x00;
>> +     struct acpi_device *adev;
>>       u32 addr;
>> -     int ret;
>>
>>       /* Pink Sardine device check */
>>       switch (pci->revision) {
>> @@ -157,8 +165,75 @@ static int snd_acp62_probe(struct pci_dev *pci,
>>       ret = acp62_init(adata->acp62_base);
>>       if (ret)
>>               goto release_regions;
>> +     val = acp62_readl(adata->acp62_base + ACP_PIN_CONFIG);
>> +     switch (val) {
>> +     case ACP_CONFIG_0:
>> +     case ACP_CONFIG_1:
>> +     case ACP_CONFIG_2:
>> +     case ACP_CONFIG_3:
>> +     case ACP_CONFIG_9:
>> +     case ACP_CONFIG_15:
>> +             dev_info(&pci->dev, "Audio Mode %d\n", val);
>> +             break;
>> +     default:
>> +
>> +             /* Checking DMIC hardware*/
>> +             adev = 
>> acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
>> +
>
> You can probably remove one level of indentation in following code if
> you do:
> if (!adev)
>                        break;
>
Okay Will use this logic.
>> +             if (adev) {
>> +                     const union acpi_object *obj;
>> +
>> +                     if (!acpi_dev_get_property(adev, 
>> "acp-audio-device-type",
>> + ACPI_TYPE_INTEGER, &obj) &&
>> + obj->integer.value == 2) {
>> +                             adata->res = devm_kzalloc(&pci->dev,
>> + sizeof(struct resource), GFP_KERNEL);
>> +
>> +                             if (!adata->res) {
>> +                                     ret = -ENOMEM;
>> +                                     goto de_init;
>> +                             }
>> +
>> +                             adata->res->name = "acp_iomem";
>> +                             adata->res->flags = IORESOURCE_MEM;
>> +                             adata->res->start = addr;
>> +                             adata->res->end = addr + (ACP6x_REG_END 
>> - ACP6x_REG_START);
>> +                             adata->acp62_audio_mode = ACP6x_PDM_MODE;
>>
>> +                             memset(&pdevinfo, 0, sizeof(pdevinfo));
>> +                             pdevinfo[0].name = "acp_ps_pdm_dma";
>> +                             pdevinfo[0].id = 0;
>> +                             pdevinfo[0].parent = &pci->dev;
>> +                             pdevinfo[0].num_res = 1;
>> +                             pdevinfo[0].res = adata->res;
>> +
>> +                             pdevinfo[1].name = "dmic-codec";
>> +                             pdevinfo[1].id = 0;
>> +                             pdevinfo[1].parent = &pci->dev;
>> +
>> +                             for (index = 0; index < ACP6x_DEVS; 
>> index++) {
>> +                                     adata->pdev[index] =
>> + platform_device_register_full(&pdevinfo[index]);
>> +
>> +                                     if (IS_ERR(adata->pdev[index])) {
>> + dev_err(&pci->dev,
>> +                                                     "cannot 
>> register %s device\n",
>> + pdevinfo[index].name);
>> +                                             ret = 
>> PTR_ERR(adata->pdev[index]);
>> +                                             goto unregister_devs;
>> +                                     }
>> +                             }
>> +                     }
>> +             }
>> +             break;
>> +     }
>>       return 0;
>> +unregister_devs:
>> +     for (--index; index >= 0; index--)
>> +             platform_device_unregister(adata->pdev[index]);
>> +de_init:
>> +     if (acp62_deinit(adata->acp62_base))
>> +             dev_err(&pci->dev, "ACP de-init failed\n");
>>   release_regions:
>>       pci_release_regions(pci);
>>   disable_pci:
>> @@ -170,9 +245,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
>>   static void snd_acp62_remove(struct pci_dev *pci)
>>   {
>>       struct acp62_dev_data *adata;
>> -     int ret;
>> +     int ret, index;
>>
>>       adata = pci_get_drvdata(pci);
>> +     if (adata->acp62_audio_mode == ACP6x_PDM_MODE) {
>> +             for (index = 0; index < ACP6x_DEVS; index++)
>> + platform_device_unregister(adata->pdev[index]);
>> +     }
>>       ret = acp62_deinit(adata->acp62_base);
>>       if (ret)
>>               dev_err(&pci->dev, "ACP de-init failed\n");
>
