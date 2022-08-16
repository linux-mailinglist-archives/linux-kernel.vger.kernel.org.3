Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA45955A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiHPI4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiHPIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:55:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69975143295
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Szpp7XpapSBOkQSMxtPp/ObUEQ5ZxAc2a/rSrKlj+DSGkuV+YbuqHtA8jRutXVP9bAU9WmoGUaNTXRavG+Aj/Q0GDRM6kG9e7cGuYXbnxfcuw9vUggvjSg2CNvfFnkeXIxbWW5EklLZQMqB4EH3njP+v7en/XRswXJQ+OZgqHVGqIYjJfwbyTUMukQd7MSiI4E+X7TMQQwDO14081ZTkVh5jMOGazx6BVnxxjQO15A/HLwYbI8fMvDUp/GUGdwfAMc1zU2gUrpVX4zy5A3D+rXoF6QMMcWqtTyeOA94tsx5P0cjpYIlBuzKQSrTQVfrMg8r9GobqngbyTPWpDNU12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VNt/ynMUnzuGWouSKgTq4OL7BdGPWISe28CVPSo58w=;
 b=nEo6w9p0QqfWKb8bRRoOkJVOb5jbGYz4Z2hd0oXf5hgAYrFpwrzXDaluFN6UZuj0DBWnBHMZoxiSNdSspawj1MvByZXV5aUb4FsTttLO26naSm39w4k9k4re6d9mCZsxN+PpRy7b9c05GSyi/AyDx5A62eqKl68zUqNb4vFJ/so7G3ZsbC0Nc6sS0eF7mjHdWKb6BNwklN1cOrR1BkVf0qMYQkk12os9BUqayFsWLVywjBSeANXrMe/LNNWFCCQ/yrsGJjWEJhvuhSTg6YW/4qWt0eJivePK/dhj6LtItqoKZOoJWEVJvVUMGQJqIe191C82sQaTOy6EWMkVHzWBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VNt/ynMUnzuGWouSKgTq4OL7BdGPWISe28CVPSo58w=;
 b=u91uoV4VF7RBJNLJQs9lUtsk5bOqgYVtg1ffGWen3BY41g5UpKJSHmoVYlxvVfv4JFH414k5z7JXyqR5oIXfKTeg/fZnF9Wrg8B0e+6t2lTsJ89pBGkW/xVL6msQZkjzgqc9xOan6x6GOr0y3trD4OJj0XJMKI/COE8vMz+4Ka4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 07:04:07 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 07:04:07 +0000
Message-ID: <a6299f03-91c1-bc7c-7469-9e26a14e3b3c@amd.com>
Date:   Tue, 16 Aug 2022 12:32:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/13] ASoC: amd: add acp6.2 pdm driver dma ops
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
 <20220812120731.788052-8-Syed.SabaKareem@amd.com>
 <2dca1704-c04b-9c42-ce1a-51a16530af38@linux.intel.com>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <2dca1704-c04b-9c42-ce1a-51a16530af38@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::13) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf540dbd-acfe-4d5e-e26b-08da7f55826a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpbGSHIcd9FVm26OeyBr8vgBMkwT9ZqVjPgEUNUg7CISednlV+WB8F1uZLVUac3WladK3Q29MPxsFmxGCN5O0nZVO3nbkQIxYXvTEndrFqx6VXokbh6+n4Y/4bVZHZZqRkubbJ5KRKW7RnYiPU/n7fVSmavw6uVoLTdL6eO1uKZLCr6SRz6We0CtdqykKB2HXrvR1xEb298McNdhnCO0ruVPnV0PVdfUmasl5mqN1Fch8vr8KmkpFLzhQv0IuISSHTiqiTqmyF/4LtenbueULsrPkRat6QRxcDFEW2iopNLqYoYDeyt64o39+IkdTv1yu8Py8+H9ILByR8QBA+ArUG/GXGYmz2eYic4wdwI4A9vtLe2jz38+3V59jNcHEs7aIWRI5UEnJlOjFaShx/4osuVOrau7nN/u4Vn/rr3+DTdWE555UxSAeWhkvkoLP775KBIwpd21L73wwGI4YbGiK8/bp+CmmoGr4sJy98oCQjC5ZLBU0gQf23aoHtNmAdaZz/y6QKHLFQFtVQsdn3/nDaS+WZ2fpIcO9zhdHpwmeF09WGhYLw9mUjA/0Q0y8X2yKSvBdyU151/07h5kWLX6r+lADWf3s0hvr/EnOmrliF8VrGKhIoQdID1s0SChGL5rfImWl3TSfReGjFZHo5zsT4jYIgaaWlbRNZgcyTh4V131vEpFOz6/j2jjvPZEnpGJimC84gPXZnpfyumpk6HQwIWQCF5n8InavQqsIcAKfldq6Y2hIiaV15U3TRjaQh0Ayz+mWuTSHqv7UzQnCMuy11UMzaIBcE4Px8/W8x0YjsG5Qnzf1z9IVBNsmkbVeV0bi76hfoxNW6ihhWrtWDBdrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(38100700002)(83380400001)(54906003)(186003)(31696002)(66574015)(2906002)(6486002)(2616005)(478600001)(66556008)(5660300002)(31686004)(36756003)(316002)(110136005)(4326008)(6506007)(66476007)(41300700001)(6512007)(66946007)(8936002)(8676002)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FlN0x4YWhhOVVFRzhwcnp3c0VoSU5HOEZINTFsbU5GTVhmckx4cjBMbE9o?=
 =?utf-8?B?Q1pDT1VHRUgydTE3TjBoclZjU1lJUEdOWm50RVo0MnJ2akVlT3hYdkhadDU1?=
 =?utf-8?B?RWtzYzNRS2NvcE1zeWFHYmNJM2FVd0E1RW5PeUswYkJQaDRBMVQwQU05ajQ2?=
 =?utf-8?B?Qy9pWVlwMEF2UGl5SlVOVEtjTk5OZldKRjNoR3phRFhoc1ZuY3E3SlphcE1F?=
 =?utf-8?B?QTR5VElpeUpNb1c5ZUg3VzlEZ011YVZ2U2JkMEhwWVBxOUxvTHNHVk9BS3da?=
 =?utf-8?B?dThTSEpaWEhjVXdqWFprT0UwaGFCK0YxT3E0RHdoY2xTYkVwUVM2c1NUOVVr?=
 =?utf-8?B?TGw0SGcrdW5mNEUyTE9KZXJqU1lFWm9ramliQ1lvTmx1U1pZbCt2RWYwcnBS?=
 =?utf-8?B?cFRLSmlmc20waTFBeEdPRHZtM0NjMVlmYVh2aEY4THl0VHRtSjJoNFFRR1Nq?=
 =?utf-8?B?TS9CaFFDN09LZFNxS1d4dE8zSUEyTEw5bFR4bk50bkR6d2lRdk1taWxoTXNk?=
 =?utf-8?B?Z2Z6R1Q2VkpSc0kzbzBNeHAwM1NVNHRqd01DK1ZmTlBhb1dMS0Y2VmNxYjdw?=
 =?utf-8?B?WnBuRHRaUzlYT3BtcThKUlROYWRYU3dWNElZNzZxOHJjcEY2eGlRK1UyYkJx?=
 =?utf-8?B?NXRZbUI0NDI3K3ArZ2RwM0ljVm8yYUdxSUNJbkN3bGlyaS9FSUVQSEtqYnV2?=
 =?utf-8?B?anFoaTVFa3pxYkNkWFpIYTZqbEEzOVBPaVZvM09kQ0pxQ29vV0lRVXV2N0V0?=
 =?utf-8?B?blNHNlYwRUxCdmNVMnoyblNINjJLcThOUjVCMmdIT3lRbklGK2RLQXNHLzcx?=
 =?utf-8?B?aGxNZlB6VVlVcHN5Q2VBSmlTOThEbkdqTEdwZGk0MnUxUXVkNGtsT0kyMktI?=
 =?utf-8?B?VFY4VDFzVWI1d0puMnovUkdTSUVOU0MzMDgySUx0bjY0dGk3ZVQyUHJXOGZE?=
 =?utf-8?B?WSt6SjlQNldNd2p1QjkybEViUHZ4NyswU2dSY2M0RDJZWmVCT3VUQk0zYlZa?=
 =?utf-8?B?RzB1T0FjZUNXMFkvdkJVUXhrL1oyQ0JERllBK3VRRzhRbXFPeVFSc1pGaTBz?=
 =?utf-8?B?SE9sRHY2bjN6bE44Szg2U0hRdXh5U1lTQVNSS0R4cFdwLzZ4cGZ6VXpuOVlQ?=
 =?utf-8?B?R0NTd0o3dGdMKzdxVFUycTVhTG9IWVluWEM0czY1SnM1clZhemp6TFBRdEFE?=
 =?utf-8?B?NXM0RUNIUzdWNHpuL2xhakNpamhGeWh2d0ljMWg3Ukg5eFVDb2NzdjVwV0hq?=
 =?utf-8?B?L2VnLzFzMDYvTEwxQ1o2eUwyY2FLZFlpbVNjWnlYMUlMR1BPV2xEWk9YRGFT?=
 =?utf-8?B?TndoNk1URElucUtRcE1lM09BM29aM1VwRGdRUWlhcDNnSjdtOWFOMVBWYlFL?=
 =?utf-8?B?OVBiOTZRRkhPMzJUSFRsaW84aG9aR3Ntc0hSZ3ByajNldG5PZE5HOHhwOVpa?=
 =?utf-8?B?Um5Db0dWS2MzaTV1SDY1TlFhdlc0Qkw0STh3RmRpVS9HNis0SHl4dDFhajVZ?=
 =?utf-8?B?ck1jWFJFaVgzMmZhOHJoSlVFVnIzT2kvR0RPZEtSUU1jWkswbWo0S05VZS8r?=
 =?utf-8?B?dG9UUHhOOW9mMmFxOUJVTEZtTTZ6ZysvY3VyaEoyalF4YUlsbEZGUE5QOEVF?=
 =?utf-8?B?RkpZWWFUNDhzQWJyd3dBditiTVB5V0VKbVR5WkcveWozQXh4VWNFTHg2QTNS?=
 =?utf-8?B?amNFZW5ybFg2amdQdm91cmZrWmhmZjd6d1VDQXN2OTlhM3h0WGpqbzdQdjFw?=
 =?utf-8?B?K0p2NTUyWjZiR1Zlb1lYZElQVXBZQWlkUjZQalZHMkMyOFNQSzFBdXh4WERj?=
 =?utf-8?B?Y1lQTWVTVUwxblFIZ09BMkFVTzEyZGY5ZmdRNGR3OE93eDJBZzVzQkppS1hR?=
 =?utf-8?B?L2IwN2g4UHpLQWI5VGI2a0ZKZVZlK2YvcWM5V292bDFIbjdyczJwNFVXZ1NN?=
 =?utf-8?B?UEk3bFdOWHNmVi91Snlrb3Z0MXRwTHhUUFFEYSt6TnorMEw4bXA3QWdDWlhW?=
 =?utf-8?B?ZnYvK1l5UkRUR2xvSnlYZmlvMFVXelN1c2tVUkJlTTVvNis1THA5cmMxK0pn?=
 =?utf-8?B?WUIzL1VMUENXcnZNMzlwODZIWDlXZFY1YU9LaVc1cElac0JOTkhYZTcrSDRH?=
 =?utf-8?Q?ADjpTdXr6wfk5Ov1v5TRJISbh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf540dbd-acfe-4d5e-e26b-08da7f55826a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 07:04:07.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwWsSaR6sMueMoHAs+3Py6Xx0PFGbu6Af2Sd/WrENS8xNDUc65rTXC4UVlr6M7ykUh7DiNavuYdKP3AJ+fbyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
>> This patch adds PDM driver DMA operations for Pink Sardine Platform.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> ---
>>   sound/soc/amd/ps/acp62.h      |  41 +++++
>>   sound/soc/amd/ps/ps-pdm-dma.c | 310 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 351 insertions(+)
>>
>> diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
>> index 563252834b09..525e8bd225a2 100644
>> --- a/sound/soc/amd/ps/acp62.h
>> +++ b/sound/soc/amd/ps/acp62.h
>> @@ -27,6 +27,31 @@
>>   #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
>>   #define PDM_DMA_STAT 0x10
>>
>> +#define PDM_DMA_INTR_MASK    0x10000
>> +#define ACP_ERROR_STAT       29
>> +#define PDM_DECIMATION_FACTOR        2
>> +#define ACP_PDM_CLK_FREQ_MASK        7
>> +#define ACP_WOV_MISC_CTRL_MASK       0x10
>> +#define ACP_PDM_ENABLE               1
>> +#define ACP_PDM_DISABLE              0
>> +#define ACP_PDM_DMA_EN_STATUS        2
>> +#define TWO_CH               2
>> +#define DELAY_US     5
>> +#define ACP_COUNTER  20000
>> +
>> +#define ACP_SRAM_PTE_OFFSET  0x03800000
>> +#define PAGE_SIZE_4K_ENABLE  2
>> +#define PDM_PTE_OFFSET               0
>> +#define PDM_MEM_WINDOW_START 0x4000000
>> +
>> +#define CAPTURE_MIN_NUM_PERIODS     4
>> +#define CAPTURE_MAX_NUM_PERIODS     4
>> +#define CAPTURE_MAX_PERIOD_SIZE     8192
>> +#define CAPTURE_MIN_PERIOD_SIZE     4096
>> +
>> +#define MAX_BUFFER (CAPTURE_MAX_PERIOD_SIZE * CAPTURE_MAX_NUM_PERIODS)
>> +#define MIN_BUFFER MAX_BUFFER
>> +
>>   enum acp_config {
>>       ACP_CONFIG_0 = 0,
>>       ACP_CONFIG_1,
>> @@ -46,6 +71,22 @@ enum acp_config {
>>       ACP_CONFIG_15,
>>   };
>>
>> +struct pdm_stream_instance {
>> +     u16 num_pages;
>> +     u16 channels;
>> +     dma_addr_t dma_addr;
>> +     u64 bytescount;
>> +     void __iomem *acp62_base;
>> +};
>> +
>> +union acp_pdm_dma_count {
>> +     struct {
>> +     u32 low;
>> +     u32 high;
>> +     } bcount;
>
> Fix indentation.
> Also you can remove struct name, and access fields directly, so instead
> of accessing somevariable.bcount.low, you would use somevariable.low, it
> would probably be more readable.
>
Okay Will fix it.
>> +     u64 bytescount;
>> +};
>> +
>>   struct pdm_dev_data {
>>       u32 pdm_irq;
>>       void __iomem *acp62_base;
>> diff --git a/sound/soc/amd/ps/ps-pdm-dma.c 
>> b/sound/soc/amd/ps/ps-pdm-dma.c
>> index bca2ac3e81f5..a98a2015015d 100644
>
> ...
>
>> +
>> +static int acp62_pdm_dma_open(struct snd_soc_component *component,
>> +                           struct snd_pcm_substream *substream)
>> +{
>> +     struct snd_pcm_runtime *runtime;
>> +     struct pdm_dev_data *adata;
>> +     struct pdm_stream_instance *pdm_data;
>> +     int ret;
>> +
>> +     runtime = substream->runtime;
>> +     adata = dev_get_drvdata(component->dev);
>> +     pdm_data = kzalloc(sizeof(*pdm_data), GFP_KERNEL);
>> +     if (!pdm_data)
>> +             return -EINVAL;
>> +
>> +     if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> +             runtime->hw = acp62_pdm_hardware_capture;
>> +
>> +     ret = snd_pcm_hw_constraint_integer(runtime,
>> + SNDRV_PCM_HW_PARAM_PERIODS);
>> +     if (ret < 0) {
>> +             dev_err(component->dev, "set integer constraint 
>> failed\n");
>> +             kfree(pdm_data);
>> +             return ret;
>> +     }
>> +
>> +     acp62_enable_pdm_interrupts(adata->acp62_base);
>> +
>> +     if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>> +             adata->capture_stream = substream;
>> +
>> +     pdm_data->acp62_base = adata->acp62_base;
>> +     runtime->private_data = pdm_data;
>
> Should probably kfree(runtime->private_data) in acp62_pdm_dma_close(),
> otherwise won't there be a memory leak?
>
Will fix it.
>> +     return ret;
>> +}
>> +
>
> ...
>
