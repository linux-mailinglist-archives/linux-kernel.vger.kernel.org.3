Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D285954EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiHPIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHPIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:21:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34C5FAD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs4wayvyrMoy2i7KyXjP+v1H/2NwxmL65QKL+efGy9gSg5D8lVSYf/qiMXnVDhcyzJFPBVal6E1YJHXwZ3F0ER9xqrQbht4VwoDP8Z8KYOjo4n3EVxNEcXcpSro9d3ZLEDoJ+j1BgByviSUx7KWEmbyv1MkSngOBZ/0Cu5a6/wNxEbz9PBz9zReHymGOiY52nYa/Gn3KHndoR6egeGAQMIbys2dTC99RYmT7IPhV0V2i3ipoZPWhSC7MA7Tr8dTYD0fG2o6KTF+tO0ti8JDTwUGgai0IjmENd1qjT0UoQMBP7ni17qpS3n/rIxSIc4NwPHHvtz0gPOhSNSEAgsHR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsqvMkinim/OVw9uBs5g4nqqLOB9j1w8rHc5w2/f2mE=;
 b=VzZQmYV67hi4GNvie2rY1Udqsh6+4+J0/yUu6J/Gjnxs5SWw8q0yX0IyGNjGmjcVVFJu9jb3+yS0SPyR7V+NkTQkv11iHOeMO9Y0ex2xwpL6KzDDxcfCzuUsCA7LmSFOaFDk2Vwfcn21gBVtXYmpqGip7MSS/kEmYJdQqunBEkXAYlmcnKFC/2KYNxu0k2Aft4vL8DJBXCH66u8dCXWRnBUs6PBB6awKeQvmxadkQiKmBeC2Vr5anTAFlhbz55iEUWdE0hvHqz0FIIJIg7jLjT/C3TXhqMa2aOqX26XxIu7SfhfGjX2K3eBvOyBm/aiay8J5DZzkZXnrH1DzVVpRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsqvMkinim/OVw9uBs5g4nqqLOB9j1w8rHc5w2/f2mE=;
 b=l9xS/YmLE4BIvDaWakDkyPiB+jUvTZPKoYgulr518YoT8DPpoIUt8iB4XIXfZbA1d1dnS+1xTHZ1sh8NLO+wH9xXUOvjyBPMhug1XSZEL/kYxMXrz9iLpMCZK6iR+HID9Gi7qTHEAXB2+kbGpq15tDXf9e/iMW2G6by0KGFSLLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 06:02:20 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 06:02:20 +0000
Message-ID: <6ca2134d-1b82-f8c3-3faa-b2a56f7ce36b@amd.com>
Date:   Tue, 16 Aug 2022 11:30:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/13] ASoC: amd: add Pink Sardine ACP PCI driver
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
 <20220812120731.788052-3-Syed.SabaKareem@amd.com>
 <01c068ec-1cd4-f91a-53d6-9bcba6ae6873@linux.intel.com>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <01c068ec-1cd4-f91a-53d6-9bcba6ae6873@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b084b6-bf72-4dc8-bece-08da7f4ce121
X-MS-TrafficTypeDiagnostic: DM6PR12MB4234:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: je5r7/FSwZ0TgApeHWglHb/LPuBXihL4XJ0/ZKdHPu8MwANzJTS0KQpA5fGOb92bChRUkJOlNxn1hhI6X+vrDPIiuzSz0XiNReov6jabPF79buP/f8l71LbjDKYIeUh072ZscYgPyBInP9/Y4rwyh5hOF40+jDZvbnEFEe58CaybhLbRz3ETcnAUUtzyWtF2292VNiyB/LzEjVx8C/1ABSB0g4mvX2xC2NNvH7RWRWjxe1Oa6lbRVMnMdv+3MsmOU/F9Li65dg+/xDMxB21097WW/63//S794ulbJKtn1PId/Kg7Iv/+TP0YuW7BoXsH9WtDGGYemG/OvPeUXLHpj2vyqCFg3eR6dGHQ8q//s65J1uJ3q7XLp1yys3UgI0bXG84eFrYYtlWBDZqOf8yeyrfMM/ocQpPBKEtljL5J3e83a/8y7Wn2LtjrTH0T0AFv4vVekBhNOvR5y0DPUsX8/s62Ehq+/iGcMM770xdFCWJvIsAOrs3DhhTiTKfmI4VHnbsbqqrNEI4lbTJE+AuL16c2tf3kkx5BFtt3r+2C0+s6UwcdDiAqIBtI1fXOFTK4SLNGjxU/Gy/WiZ3rHvZLXPVigBHgXidM0Vp/tE2Ro5FIZfD3F/8jPaJXx8404MqiJGtcyKOWYaUH/2YRGYP+qXPsOQK4p9vkGtkA7fbErDDCpSgB6ktrjbRXyXDVj2wdJ6/5efZEeQZGso/Dc7Dyafv6XQkf+yLTRwDj3gviwRQtPxbbtN0V0e5Rf/mmNsLA0SLEsRWDKVxG55wzS5+VevK+cuy6QLHMqDRQdQiAxpPFJYINgBjQ+I+US4/RTS9LCGweVnu76pWdYWwouuS1qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(8936002)(5660300002)(2906002)(31696002)(38100700002)(478600001)(6486002)(6506007)(41300700001)(110136005)(54906003)(83380400001)(8676002)(316002)(66476007)(66556008)(66574015)(53546011)(66946007)(2616005)(4326008)(26005)(6512007)(186003)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ZZenU4ZUEvSnFKVVVJUENWMDhYWkFya0ptd2t5cDJ1K25lKyttZFBrUmMz?=
 =?utf-8?B?V0Q2SXppQUZlZ1RpcEVFaGtJSFJjeGRpSnFCR2JnQU5NUXRlUGNBdzd0VVZp?=
 =?utf-8?B?b2xmNGVWRCtQcVpkalFzd3ZJUGoxKzBHL2l6bFdUdVFkbUJzc0xsbjYxcUpM?=
 =?utf-8?B?eDhiK3hBMEVLZEUzL1lUYmpGZWxpNFlBQ0Q4eFF2VEF0UnFINzVZYWVQMHJk?=
 =?utf-8?B?RDlDU0RpNWRXRTlWamZMTitCVlEwMXBzSU5DcHRsanJYbEpVbEJTRjhRYllW?=
 =?utf-8?B?alRTeDc4WnVGOVZyeXFwSGxZVE9BWjNzVU92OWhydmdNbEcreXdvUzRnMWV1?=
 =?utf-8?B?b3hjZ3l6MjR3QlVKNDAyeHlnaDdEZlBvc3hkc1JvOEJjQXVHOVJ2TDA1cVZr?=
 =?utf-8?B?cVBLWGpra0Z1V1J6Mmx1dTYyZVdyNjkzRDdqTWN1QUl6SXVIVVJURFdxdTYw?=
 =?utf-8?B?REJzNFFmT0lHSHNYSGV5U1lROGdrNThVS2N4Rkl2dzh3SlhZeUpOMGxIM2ZJ?=
 =?utf-8?B?TkcxNTJEdDdvckdRSlh5TkdBRnl5eTNqS0dsRUlodWM3S1ZzZkF2aFJsZkM1?=
 =?utf-8?B?TTg0S0gyV0RhZHZtWU9WaTQ4QlUwMldOR20zUGN0cTZiM01icnp3L2JPdkVT?=
 =?utf-8?B?Ujh4QXR3MC9Wam5BaGtqK0tySFhWd3VoNDZEd2w4ZDVuSXFzdnNVamNpNmx6?=
 =?utf-8?B?ZTlWRGc2WDBWMHA2R2hHZURETEhaMzV2QVFKR2hka1IzYkdhSVNLTE9XUmZ5?=
 =?utf-8?B?SjI0MlAvMTl1RmFNS2VteWpPK1laYWIxbWg3NnpBd2RDRE1ZSzQzOTMvVUxv?=
 =?utf-8?B?OGNhWDJDMU1DcVBmQmFsenh5cWRmWXVNcjhqMTU1VlF4anp5bW96bVVaVGFo?=
 =?utf-8?B?WGFIRU5hRGl6N2p1MTEyc3JZNEZ0bSs4MFAyeFlZTmVmSWtCMWxUSWlpc0Zq?=
 =?utf-8?B?YWlkU1p1MUJUZHJXVFcvTUtodEVqbHpaTjB4VUtER0ViZjVJY1Q4bDFmV1Ni?=
 =?utf-8?B?cnJ0Y0FNNzdRWEJ4R0ErNEhTZ2FqUmdwUnY5RXVOS2VtQ1lWQTcvSWRtYm11?=
 =?utf-8?B?cVlPZkV1TDA0cnRIMjZPQ3R3RE84R2ZqN2pPMTZ6WU9RQitVd2hLMVRlYmZD?=
 =?utf-8?B?endUK1dGR2pZdlhaWVo0bHZxNElqUDJlREVrQUJpZzlQc1lBREt4Wll2NHU5?=
 =?utf-8?B?dXA4eVdKbWxkeFRVL1FCUWUzbm5POVUvSGFWYTdWTDNWSDlsUmMvTkR1Q0pJ?=
 =?utf-8?B?cUVid2FPQTZGZk9mR3RhNHJnbDU3cUpMM3cyYlVoVmpiaGM1a0JLVDBIV2ts?=
 =?utf-8?B?ZEdZSkRUTFhhOGhoQ2pPOHdTYTlxZGx3d2pnc2xpVXNRdVBQYnFnUy84VXNj?=
 =?utf-8?B?RWlyQUV3aWV1eGh2RDdMZkdhV2JtbmVxWElqUVprKzh2a1RHVjl3TXBBS3Bi?=
 =?utf-8?B?TUM3YVhYVnVYRytXNFI0Z3NFelI0S2pNSGxITUdzY29NZW5JZ2JrUjVjbEwr?=
 =?utf-8?B?TVpTYUZCb2doQ2NqZ3VxdzR1RTRvV0w3cmM2VHlSc3BHS2pWU0xhbmVrRGRj?=
 =?utf-8?B?b2c5bVVGV3Z4TWVWVXl4WXRKeU9RdHlBSWF1bmM1bHpENDNqVUpUTHRtWUZv?=
 =?utf-8?B?VDkxU0dpSEVQdWo2bVRwMm0yMXQ0bVAzVHZjMkhGZEJNYXlIMHc4YjhQL21N?=
 =?utf-8?B?MmNkM1l0Y1BlM3JTS29OdzZtNEp3OS9ud0ZGNm51eDNBQitselA2T2Q2RVVZ?=
 =?utf-8?B?WEFGRXRSUWtjMVZLcjVGTU96UVZ6bnJlaGsxZnNvRU0zZm9wSEg5K2xDbkZC?=
 =?utf-8?B?M1FDQW5UTGVkMVdmeENJeDIvUHBSemJ2NUxhbksvWFF5bEtVeW1YaVlIUER4?=
 =?utf-8?B?cDBKNVRnbEdVOWhBYk41WXZvWFRjcGptczIzcmRpODF5MzZoay8rNjl1UWhU?=
 =?utf-8?B?ejQzcTZhZWdyVkVRcThMOEhuSEwvaWN0Ynk1d1psOHF3QWF3RysvZFNMZG9R?=
 =?utf-8?B?TVBVV0x5bThCekRaN3Q4NG9vejZ1YytZT2F1a2RsMW05dVlSTTFDSXJidVQ1?=
 =?utf-8?B?b0JoWkV1eTBJZ21mdUVGL3NUQ0c1UUV2S0lrNXlmcitkaTJNdmxQMzhHMlFh?=
 =?utf-8?Q?9e7zQ5b47TqJM+S9LqSeJNeCf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b084b6-bf72-4dc8-bece-08da7f4ce121
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:02:20.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ai21iN9yMfHALuRxTtRcfg8PpeakdbcXGMzLJ8G7p+Cf/Nd+B+Ss4DYOgzGMZy2unF/STfDYvLEoTVi7R3OQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 19:49, Amadeusz Sławiński wrote:
> [CAUTION: External Email]
>
> On 8/12/2022 2:07 PM, Syed Saba kareem wrote:
>> ACP is a PCI audio device.
>> This patch adds PCI driver to bind to this device and get
>> PCI resources for Pink Sardine Platform.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>   sound/soc/amd/ps/acp62.h  | 21 +++++++++
>>   sound/soc/amd/ps/pci-ps.c | 94 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 sound/soc/amd/ps/acp62.h
>>   create mode 100644 sound/soc/amd/ps/pci-ps.c
>>
>> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
>> new file mode 100644
>> index 000000000000..e91762240c93
>> --- /dev/null
>> +++ b/sound/soc/amd/ps/acp62.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * AMD ALSA SoC PDM Driver
>> + *
>> + * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#include <sound/acp62_chip_offset_byte.h>
>> +
>> +#define ACP_DEVICE_ID 0x15E2
>> +#define ACP62_PHY_BASE_ADDRESS 0x1240000
>> +
>> +static inline u32 acp62_readl(void __iomem *base_addr)
>> +{
>> +     return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
>
> Can't you just define offsets in header, without ACP62_PHY_BASE_ADDRESS?
> Then you won't need to subtract the value here?
> I mean like:
> #define ACP_DMA_CNTL_0                                0x0000
> #define ACP_DMA_CNTL_1                                0x0004
> ...
> instead of
> #define ACP_DMA_CNTL_0                                0x1240000
> #define ACP_DMA_CNTL_1                                0x1240004
> ...
> Seems a bit weird to me, to just define values with offset if it is not
> needed...
>
Will fix it.

>> +}
>> +
>> +static inline void acp62_writel(u32 val, void __iomem *base_addr)
>> +{
>> +     writel(val, base_addr - ACP62_PHY_BASE_ADDRESS);
>> +}
>
> Same here
>
Will fix it.

>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> new file mode 100644
>> index 000000000000..25169797275c
>> --- /dev/null
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -0,0 +1,94 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * AMD Pink Sardine ACP PCI Driver
>> + *
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +
>> +#include "acp62.h"
>> +
>> +struct acp62_dev_data {
>> +     void __iomem *acp62_base;
>> +};
>> +
>> +static int snd_acp62_probe(struct pci_dev *pci,
>> +                        const struct pci_device_id *pci_id)
>> +{
>> +     struct acp62_dev_data *adata;
>> +     u32 addr;
>> +     int ret;
>> +
>> +     /* Pink Sardine device check */
>> +     switch (pci->revision) {
>> +     case 0x63:
>> +             break;
>> +     default:
>> +             dev_dbg(&pci->dev, "acp62 pci device not found\n");
>> +             return -ENODEV;
>> +     }
>> +     if (pci_enable_device(pci)) {
>> +             dev_err(&pci->dev, "pci_enable_device failed\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = pci_request_regions(pci, "AMD ACP6.2 audio");
>> +     if (ret < 0) {
>> +             dev_err(&pci->dev, "pci_request_regions failed\n");
>> +             goto disable_pci;
>> +     }
>> +             adata = devm_kzalloc(&pci->dev, sizeof(struct 
>> acp62_dev_data),
>> +                                  GFP_KERNEL);
>
> Wrong indentation in assignment above?
>
Will fix it.

>> +     if (!adata) {
>> +             ret = -ENOMEM;
>> +             goto release_regions;
>> +     }
>> +
>> +     addr = pci_resource_start(pci, 0);
>> +     adata->acp62_base = devm_ioremap(&pci->dev, addr,
>> +                                      pci_resource_len(pci, 0));
>> +     if (!adata->acp62_base) {
>> +             ret = -ENOMEM;
>> +             goto release_regions;
>> +     }
>> +     pci_set_master(pci);
>> +     pci_set_drvdata(pci, adata);
>> +     return 0;
>> +release_regions:
>> +     pci_release_regions(pci);
>> +disable_pci:
>> +     pci_disable_device(pci);
>> +
>> +     return ret;
>> +}
>> +
>> +static void snd_acp62_remove(struct pci_dev *pci)
>> +{
>> +     pci_release_regions(pci);
>> +     pci_disable_device(pci);
>> +}
>> +
>> +static const struct pci_device_id snd_acp62_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
>
> This one is optional, but you could also use:
> PCI_VDEVICE(AMD, ACP_DEVICE_ID)
> which is bit shorter and at least to me seems a bit more readable.
Okay will use this.
>> +     .class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
>> +     .class_mask = 0xffffff },
>> +     { 0, },
>> +};
>> +MODULE_DEVICE_TABLE(pci, snd_acp62_ids);
>> +
>> +static struct pci_driver ps_acp62_driver  = {
>> +     .name = KBUILD_MODNAME,
>> +     .id_table = snd_acp62_ids,
>> +     .probe = snd_acp62_probe,
>> +     .remove = snd_acp62_remove,
>> +};
>> +
>> +module_pci_driver(ps_acp62_driver);
>> +
>> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>> +MODULE_AUTHOR("Syed.SabaKareem@amd.com");
>> +MODULE_DESCRIPTION("AMD ACP Pink Sardine PCI driver");
>> +MODULE_LICENSE("GPL v2");
>
