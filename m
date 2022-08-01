Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D567D5863B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiHAFLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHAFLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:11:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C812D3E
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN8I7RjR2dDByQiLIoFWtgUo6ib1ap5lWfaYRQQGCMtcVDZ7Z+k6YQnms/2o2KqxaFRflr19mJSITi6j+NbwRKaz7Mkl0QYZbaM0EN95Xzj9T4c4dZgYUCHne2H6L6GGz7S0tUcaDzjMUWRmzX4S+IcdHzs1KaBmCKkERu78Oz7XwG0Y6kpK8TEgBI6CCBPTdOp3szc85hTkDuWorAw3nOnfAhXW91CVilOVfFVLOKFaOiJQchWa2GplpxA8xOfXTtjWMva5sJJjEMaLFjyXV70uJo3ylAZ0SLk8IO2m4IZEdYr0+9LLyDX/uiQzSbPSouCNfdM5hI+StXp7OB/y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pbb3EOCCmDSzFOVsr1oh2rHBxUAHRKaDJAekJwfyVo=;
 b=OmZk9Zog2V3SgsoPJ5mawMAGyYP7ZW61TIq3EHud1OEhL2jHqe9ulkTUCZT9HHtkA5KAO+1xA1eOVLBZt2S+DUVdgYwEJw2hPZhr2fTIFOGJpgPcQiTRR9fkB2auq7iutTZaI/VDaVb9bLE3fHz6L1gNBJJJQX25GimsyZiFh7A0b6m4ZiAhcbQ7+4NGMJQDFF0PNMhNqt/L0zKL8u6i812a9xPC1cYJPnVUNu0DtiAdK6xAYISeAccq78V2l1il7CGQ4zWXQAyv9bF2jDMQ7BF5QBt94m+abgfM6WWljdnoK64g7z7l3FnPwlNIRzVsHQbV+jdNdxU9sW0+hZ7ROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pbb3EOCCmDSzFOVsr1oh2rHBxUAHRKaDJAekJwfyVo=;
 b=aHLkXXk+bxfLhC96UptTt02wb5fV1qSWNQsj9mynrXVijgmQHDG+1fLX/Ww83celZ7KH7I4ml8N7D08R4WEeTQlBs12YEz2DVvZd79TzAtzPcHVaZhG2WYZ/5sBXA5QEipqKT8MZoSiwJWh1DfgM3IN5jPoOdU9h2v/GueLlh/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 05:11:25 +0000
Received: from DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e127:3aff:e853:414d]) by DM6PR12MB4171.namprd12.prod.outlook.com
 ([fe80::e127:3aff:e853:414d%2]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 05:11:25 +0000
Subject: Re: [PATCH v1 3/3] ASoC: amd: acp: Add legacy audio driver support
 for Rembrandt platform
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ssabakar@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        venkataprasad.potturu@amd.com, Meng Tang <tangmeng@uniontech.com>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Vijendar.Mukunda@amd.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
 <20220707161142.491034-4-Vsujithkumar.Reddy@amd.com>
 <e30925e7-56b7-48df-b287-094441f8c586@wanadoo.fr>
From:   "Reddy, V sujith kumar" <vsujithkumar.reddy@amd.com>
Message-ID: <c510f6f9-ca48-e311-a83d-cb465c630450@amd.com>
Date:   Mon, 1 Aug 2022 10:41:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <e30925e7-56b7-48df-b287-094441f8c586@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To DM6PR12MB4171.namprd12.prod.outlook.com
 (2603:10b6:5:21f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd476e6-11c9-4375-04f8-08da737c47f4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGWNNfAj3cw1XknMdzV1mmULUqHUhPfNDE+Pkwt3q5By1CwKAQRdWyX8OYE7u+4i/DOeaw0sJUBlsxtk3N0N+qJATiCf1PSi31T64h9gln4M9alVl6Je6fPUF3wMwIvKmRX70I+VaN41W/vESY6ocgCKjUfvysCvKXVWUD39RyEbHY6RAs6DcbTAVC0jRHIeN0koZ1TKrVkf2SxpBkCg9232ova31ne3Tdv4raIiZUSSaVRgSdH+ICYbtBnesZKKJPsf83XjI0vhWhjeotyW2BzbX1nORpoNhfSruw3kjtBz701zcO6GLMHcZNo5p12jOlknDPjGrcwU3K+5fQdaHS1cdMnm6ocMAbC5dDK448SrpR00IN4esyerAjnJPuFSH6xoSXks4IWvBaFJa+QX/ba0ygjJj4tntHPDFbM3CPvsxRMBaEhRZVs8/Xwg4mxN/a61CEUEYlaONvTOa3k57N6Y/hISy7psBL1CnZhcA0Xfv/ABIc9cFs6y3wYXW4MUr3dMleZLjvfXwbD+505a3V3z8V9y2/sXRAoMZxluuiyBmVHmAEJrfrbqb++kssYhbSzrfBb4rKJxXBZ7L0QOFpHeL73TTmDHWd94Zp1L/DaQ3ZJX1wa8/1GCsaqI/LR8YBHIoDC4qQNFHBgl0sGvQJgVL0I9OKFBuezw5tIZ9qYsE9CWcVrEFoEj+eQuTyNNGDnKV+OlbQV+bLwlfBjntqWmxcKAxsBqkN3cHzqhNR5xz2dWfcuhVVyAXyPokKwpxzlgiUUvHxxtm3Y6C4tigvpJ2JVwoPuVPPoBeoEJ1SC0gcWWufSdcZFWHF0dwMAoZH7cKt5NKO/7vX7bMk1kvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(7416002)(5660300002)(36756003)(8936002)(2906002)(66556008)(66476007)(66946007)(8676002)(4326008)(31686004)(316002)(53546011)(6666004)(54906003)(6486002)(41300700001)(478600001)(2616005)(186003)(38100700002)(31696002)(86362001)(6512007)(26005)(6506007)(66574015)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tZWjdBU3VzSHNJMUlmNlJHSnJOMFI1RDJZZ3hudXIzV1YxRmhYVkNHZE8v?=
 =?utf-8?B?NXVrZFZXYWtrMEpNaDdnNlpvMS9QdnpQbXRQcXFUNWNKUzMyR2VtamVkLzFL?=
 =?utf-8?B?LytlU3k4WlJpYUV2ck0yUlFvZ3BwYUpqSjRESWNKUWRLUlFjeDhJR1dOcFZt?=
 =?utf-8?B?RWw2Qmx6aXFQcGoyWGdMa04vWlN5TkpLcDRPd2czb0xzNTlpZG5xOG5jcG9j?=
 =?utf-8?B?K2JBbFE0ZWVaQ0pyZ2Y3d1J3TStYRkE3eDNlcEFWWjZBS01vdEhhTytPNEI4?=
 =?utf-8?B?djJnM0g2RjZVZk5qblRPQmJYTk8yR3pINis1Z1RVVUNGYWl0TC9MODRxVzJo?=
 =?utf-8?B?WFpCS3hSQ1ZTTnRnK3EySGQ2S3JIdUx5eTNONGQzaElQMkd3UWRpeE55WXlh?=
 =?utf-8?B?T293RWs0NzdkTU9JWkt2dGhBWW41MWdaTTJVdmxNRkI3UnlXRHAyZ3dVbVNX?=
 =?utf-8?B?dUVxYTJ5OWlNbHJmMWY4SFJCbnBGNS9EYld0WGNGandEbG9mK0p1dm9OaTVX?=
 =?utf-8?B?TE9YZmJCTnBabFJ0NjYrNFA0NThXNS9xNTVGQkZLcURMSnVabzRhRG04dWZR?=
 =?utf-8?B?dXhBL2hJZktWYXF1T3Nkb2l0TFBqaXd2enhrSEhRT2xHTHZZQXhlOFlDL0R1?=
 =?utf-8?B?aW9nTStBRk1rTE03Z3FmMVlZZHcvSUFxd0ZWZ2cydldNWmFJY0VKbm1iWmt2?=
 =?utf-8?B?Z3ZOdUY1VG8vRmlzQVhRMlJmOTlEcFQ5M1JtQkw5QTZvK3M1VWNTZTJmbGJ1?=
 =?utf-8?B?TXFiMUZ6ZG9tL3B3SEFyOC9QamZwSU4xL3IrbjAwZkZDS2kxTXZlOGNJeWNs?=
 =?utf-8?B?UHpkWGlRUjk5c2hlUVo5M0U0OUsxazluWG9WMFpHMmhvWEtQUENuVnRMV09p?=
 =?utf-8?B?K1hQbnd5a3I3Q0kyRFVPeDJVRUpXWDlqL1kxeFMzSkE4MUFKSXBBdGdQUUhs?=
 =?utf-8?B?Q1JXRzFGRklrT292SjNyK0cwYlBma05pWlRNR3JNT1BlVVZoTnpGUC9aRjBz?=
 =?utf-8?B?dmJOT2E5RXNjdlNSbWd5T01naVFpYllzbFFLYkpPemZRa2RLSHNBV25EZmdi?=
 =?utf-8?B?b0ZrY01TbmhMVm9DOE9lV0h5cGcxRGRLWU1leWtoUHM1UCtBdHdFaE5XU3Jm?=
 =?utf-8?B?OCtlZmNZSmUyV2NLb3F6TTEyTDRPaDg3VjkvcnJIaDRQYTVXQkdiTHpZT0ZS?=
 =?utf-8?B?VHFYTnBWSDczaXRrVnNGNTJRNjRVZnZ2aXVaOGJsblp2R0o2TzFIUm1uNzlO?=
 =?utf-8?B?R3BWc1FDdndVbUVhVTRxVW8zWW4wTkQvNERwV0ZoR05wZnlpR1Azd216cVFX?=
 =?utf-8?B?dTFnbUdXeFozWklxcE5VRHkzYUhHUjNDRlhzMEpMVlRQRHdTRjA0LzljZ2Q0?=
 =?utf-8?B?cldEcVZndjMzSFVyRHhyYVFMRmJWVjZvcnpPMFhRYnZHZnBaL0FiSXVheWlB?=
 =?utf-8?B?U05QSllCd0ZNbG1HMnBrcVo5MFphazlFUk9tY2tYRzUwaXBLYmQ4eVpvQ2pB?=
 =?utf-8?B?WmhSV09OTExSTVo4UjRPSzM5RGpzVmthZnczMFAzeGFJMWF2QmdXYUFTZE43?=
 =?utf-8?B?clcvOE5rdWg5QXVyZEdoTGFaTCtieFdLQWNWNEticVZsZmxSdGhSWlJCRXlx?=
 =?utf-8?B?aFh2RFR5a0J3TGdBMTNRNjN0QUVPejNKWFN3MUNTMW5KQktEeitQSWd5cGlv?=
 =?utf-8?B?OFN5OEFrcTdoMXRZL0dlbmFxQ3EzOTR5Nldmanc0TXVrVktNUDJhWiszR0Uw?=
 =?utf-8?B?YzA4Ry9Hc1dFTFhkOGkyWXd2eGdkc0cxVmpKa1RXc1VQSUcrbWZTb2FQWHFh?=
 =?utf-8?B?YXdBZDBvS0NGSUs5WDFoVEFZYnU3SUJrNlZ4SUVMOUdic2VFMGdFRWJ2dmpl?=
 =?utf-8?B?cTVFdkVucGU0UDFwbjF4VzBqL2piUlVndXdHblNkdFA3WTNOc2NLNHpneGNO?=
 =?utf-8?B?aXJNWU5COFc5QTRXaWtxbjkvMnRNQUhQcmNZYVRsS2htS0htdTdjeE1RUG1R?=
 =?utf-8?B?K1pLYmR2eWJPbDhHQVNMRzY2MjlXNndFbndzZVkwaE9BbXJIRFJoTkd3c254?=
 =?utf-8?B?c0tiM3hyL3UySHMwRHlFd1JUd3lhb3p1UVdhZG10S3VxWHI2VlQwdEx0M0xE?=
 =?utf-8?Q?5efHLbRcJ9xqA4PnWGkwsBQeN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd476e6-11c9-4375-04f8-08da737c47f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 05:11:24.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNfeAdiGXVRTdHeFnwntmkgQwi8qKJqO6P/xcN5c0/DFQzHMrqSTQklOJWVLEc50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/31/2022 9:11 PM, Christophe JAILLET wrote:
> [CAUTION: External Email]
>
> Hi,
>
> this patch has already reached -next, but a few nit below.
>
> Le 07/07/2022 à 18:11, V sujith kumar Reddy a écrit :
>> Add i2s and dmic support for Rembrandt platform,
>> Add machine support for nau8825, max98360 and rt5682s,rt1019 codec
>> in legacy driver for rembrandt platform.
>> Here codec is in a slave mode.
>>
>> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>> ---
>>   sound/soc/amd/acp/Kconfig            |  11 +
>>   sound/soc/amd/acp/Makefile           |   2 +
>>   sound/soc/amd/acp/acp-i2s.c          | 137 ++++++++-
>>   sound/soc/amd/acp/acp-legacy-mach.c  |  32 +++
>>   sound/soc/amd/acp/acp-mach-common.c  |  86 +++++-
>>   sound/soc/amd/acp/acp-mach.h         |   6 +
>>   sound/soc/amd/acp/acp-pci.c          |   6 +
>>   sound/soc/amd/acp/acp-platform.c     |  16 +-
>>   sound/soc/amd/acp/acp-rembrandt.c    | 401 +++++++++++++++++++++++++++
>>   sound/soc/amd/acp/amd.h              |  62 ++++-
>>   sound/soc/amd/acp/chip_offset_byte.h |  28 ++
>>   11 files changed, 781 insertions(+), 6 deletions(-)
>>   create mode 100644 sound/soc/amd/acp/acp-rembrandt.c
>>
>
> [...]
>
>> diff --git a/sound/soc/amd/acp/acp-rembrandt.c 
>> b/sound/soc/amd/acp/acp-rembrandt.c
>> new file mode 100644
>> index 000000000000..2b57c0ca4e99
>> --- /dev/null
>> +++ b/sound/soc/amd/acp/acp-rembrandt.c
>> @@ -0,0 +1,401 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +//
>> +// This file is provided under a dual BSD/GPLv2 license. When using or
>> +// redistributing this file, you may do so under either license.
>
> These lines are useless. There is already a SPDX-License-Identifier just
> above.
>
>> +//
>> +// Copyright(c) 2022 Advanced Micro Devices, Inc.
>> +//
>> +// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>> +//          V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>> +/*
>> + * Hardware interface for Renoir ACP block
>> + */
>> +
>
> [...]
>
>> +static int rembrandt_audio_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct acp_chip_info *chip;
>> +     struct acp_dev_data *adata;
>> +     struct resource *res;
>> +
>> +     chip = dev_get_platdata(&pdev->dev);
>> +     if (!chip || !chip->base) {
>> +             dev_err(&pdev->dev, "ACP chip data is NULL\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (chip->acp_rev != ACP6X_DEV) {
>> +             dev_err(&pdev->dev, "Un-supported ACP Revision %d\n", 
>> chip->acp_rev);
>> +             return -ENODEV;
>> +     }
>> +
>> +     rmb_acp_init(chip->base);
>
> Should rmb_acp_deinit() be called if an error occurs below?
> Or a devm_add_action_or_reset() + .remove() simplification?
>
> (this is called in the .remove() function)


Yes,we can check the error status ,we will do it up in a cleanup patch.

>
>> +
>> +     adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), 
>> GFP_KERNEL);
>> +     if (!adata)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, 
>> "acp_mem");
>> +     if (!res) {
>> +             dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     adata->acp_base = devm_ioremap(&pdev->dev, res->start, 
>> resource_size(res));
>> +     if (!adata->acp_base)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, 
>> "acp_dai_irq");
>> +     if (!res) {
>> +             dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     adata->i2s_irq = res->start;
>> +     adata->dev = dev;
>> +     adata->dai_driver = acp_rmb_dai;
>> +     adata->num_dai = ARRAY_SIZE(acp_rmb_dai);
>> +     adata->rsrc = &rsrc;
>> +
>> +     adata->machines = snd_soc_acpi_amd_rmb_acp_machines;
>> +     acp_machine_select(adata);
>> +
>> +     dev_set_drvdata(dev, adata);
>> +     acp6x_enable_interrupts(adata);
>> +     acp_platform_register(dev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int rembrandt_audio_remove(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct acp_dev_data *adata = dev_get_drvdata(dev);
>> +     struct acp_chip_info *chip;
>> +
>> +     chip = dev_get_platdata(&pdev->dev);
>> +     if (!chip || !chip->base) {
>> +             dev_err(&pdev->dev, "ACP chip data is NULL\n");
>> +             return -ENODEV;
>> +     }
>
> These tests and dev_err and return look useless.
> The same is already tested at the biginning of the probe and if it
> fails, the probe will fail, right?


yes ,agreed we will do it in a cleanup patch as it is merged.

>
>> +
>> +     rmb_acp_deinit(chip->base);
>> +
>> +     acp6x_disable_interrupts(adata);
>> +     acp_platform_unregister(dev);
>> +     return 0;
>> +}
>
> [...]
>
