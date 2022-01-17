Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC449074F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiAQLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:49:17 -0500
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:58848
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236426AbiAQLtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:49:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqQxQ9dy5WVozOF1HrTxwpk9EVd2+K17wqQ/Q1qCa/XEYwtYuDsNSh+ORSuFDpwFmw83Wiexogj6fl2PVN0cFfBGPAWeABeU571weIBGc+Evo594JdnM/7lGo8za5aO1Ujel/RJ2EX//AZyG2am6oxwnBkwBtTmZ7G/veZE5o2aTxv/T2QvoiIRj/OlsAU3wkb4YKiyh485qYuNNe3qZzWlze3/oiXgMIykFMhdgGieFvuvrp5TBckpIO4+T9iqfMzjTNul0C2B5DrK7dYcXbhYW7XUDRmgbas7GIFyETrznu5QxxC431dafRe2ltF7Zki+uKXVfiy/hB4mBdtarPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JZrpD3IDhBvFoe4ZirLE51IXiPt1uWMM+9C84wMQQA=;
 b=bGMsHiQPE3ZQdIQz/o/68HNfOf+QvQVYJ0PrE/YQZnkxC5foQYmVlDMFtfq9vqm6ikP/3aeU3U1NJiP6H3B4Z65h24mlEVEWZbkiKdp1HEzeNhldnFh8XRuPY0QZDFlY47TAkH6NdqE67Q3sUqXepNx6QEFez5H6xE6nCnJ66xznTsrFNK8zIIVCisIPUilJFOiPdbHfSIGjx29l++Q2T9mYN0jYBU+SWYG8UM0hIDt/raihgi/aU17yv2vMYvRKTpeVKj96+HgCszjVZMhLmvqSxiz+MsxBAAAkpkBOWC/qRD0SkMdD9C6jtOIEXGb70DEDbZfcciCuuza15G0ZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JZrpD3IDhBvFoe4ZirLE51IXiPt1uWMM+9C84wMQQA=;
 b=cqXkpVp3VZCW23B0WOvMwY0fZXaS4ENw+GiDgY+Q44wfOef9S/tbDOlqU/dLLGQyldyWJcfzztL4ZA6k5C+FjE3Ed16Zu9VGkCWU6yxIdvy9eqiY2cjbIa2wnGlnzKfFxqnUYsF4I91n2KzBEdJFvCP5+wMO5CVAoRAlbcApyGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM5PR12MB1211.namprd12.prod.outlook.com (2603:10b6:3:79::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 11:49:14 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6%5]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 11:49:14 +0000
Message-ID: <4b4b1119-7a4e-4cb7-e6a7-8af8a99284fe@amd.com>
Date:   Mon, 17 Jan 2022 17:18:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/6] ASoC: amd: acp: Add generic support for PDM
 controller on ACP
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
 <20220113163348.434108-2-AjitKumar.Pandey@amd.com>
 <7d79a8a7-b9b5-8a0c-a140-810bc647927c@linux.intel.com>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <7d79a8a7-b9b5-8a0c-a140-810bc647927c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::15) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0b9a095-1566-4c9d-6252-08d9d9af6193
X-MS-TrafficTypeDiagnostic: DM5PR12MB1211:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1211C418094E6F7DC6A9215382579@DM5PR12MB1211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spvTR/FH7KF5W+vxKkQ6KdsV1Rd8ESmu5pY1deqHoGRZpZ1dDDJ4HhPSL5f0JII/Jwh5uFpo3zCc94r69QBa2k2pCRPaXWoywVRtxwG9iTbrFQJQvUUKgR7N92+KNm9d89QN6L7jeHIL0x4Akp+zZ7LhOvdc6zEGAHZXn09l+mna2fElWT9ucZsSQH2eCRaSkFhRw3GrVUc3HU20VCDPcr1okZZYXgGd81nriyoTbDR9yOB8pq7dR4UpBTyX592f2qX+pn6bMprp6AO1MYaFh2bSLKIBZF6/HD9PbZiuBOa3oUI0L+EsHo3qF6cGuQIFjkoCVTGNhIGRvbUFfTkgXZ539MAHgD6bCFaFPz96Rk3hcTcUcr+iTAM1UVoMOC69oy8ONAXvJyyiXcXF8AfGuLzW7BLAWPKRgTl5KWz+Sq8qUSihK9BqOnLrLgnCGQaRFSu5ix74d/ZPNZZYEt09gtii9l1qX+YK3ikOkUF6Bt6/S1lOqM/izYYWi/LsGFIG4PL3xDBkaxmistD0MKc9LjWJauDlc8mqdbJ63OouYWgRXLhRA59XI1QBY/X5ya2+I2HuGBDHMGNPUUH8YNkIMqB1nZJbu2x3W2IhxsF8uCnB7FacBQTB6Yxdya7B+6wwhApgCLxiPg4/FlRzt6n4QTPWfM1+//djHE5TvLnb5dyyiGc/GQSFjs+x4BPYG6ua47QiTT9uQRBaS6z0mfcXOFIbyn291gKMvmxDEsdOYSWOlyJm0PwSvM9wN4dusSmZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2616005)(6512007)(53546011)(86362001)(6506007)(5660300002)(186003)(26005)(4326008)(31696002)(36756003)(6486002)(38100700002)(2906002)(83380400001)(66946007)(54906003)(316002)(8676002)(6666004)(8936002)(31686004)(66476007)(66556008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlwSUpieEVCVk5oOWN0b2VRQmxBazJuMkY3OGFBSkM5YnpGUGdMQW93YTM5?=
 =?utf-8?B?cmIzWFY5THlFQXYrWjRhd1o0OW9tWmNyRys0T2J5NU9vY1ZRY0tjU2JpNVRz?=
 =?utf-8?B?cUl2Y2lmYjV2dCtIZzFkWmNNUm1TcmszT0xoZk9EU0dJVFRNRGZrQmhSQXQ1?=
 =?utf-8?B?S1BQQndmZDJvOFJxakE5dndaTStEamNlL2ZPTDhvS0tLcVBoZ255MlB6SFJZ?=
 =?utf-8?B?aXVJL2hnUlJOME85U2FpcURtem5pbzZ0YVVqdW9neERwOWF1VTlaaXBFdW1O?=
 =?utf-8?B?QlZWZFJxcDFobFkyTHEvaG9BNVNLajg3VnBhNFF0TnhJUjhNc2dSSzhMYVEy?=
 =?utf-8?B?b1ZlTXRMWWdUdDN5RU5MaFlyanQvSEdlTW0vZWp5dmhJZVZsbU5aMzJSdGpV?=
 =?utf-8?B?OEFMVms4SjQ5U3Z2enNveFJzV1NvVVZyNy9XbU11WnVXUnBTeFpZQ2tCM3F4?=
 =?utf-8?B?T01RRW1pSXVUSmwxZEFEUjF1ZGZ3NDNTWWFDQVhhWkpKaGNCazJtclV1eTZG?=
 =?utf-8?B?b2V4RWxxWXpNWXJZQlFvU1p1MmRaTkplV1BFSUtxUlRBRXIvSkdBUkNFL29Y?=
 =?utf-8?B?UC9MRURsNGsrNjhnaStXVGdXS1kvdWRnZ21UWER0eVhPRmh1MzVDNFV1bDVE?=
 =?utf-8?B?L0hpaVNTV2RHU3AyUXppbEVFYTNLK0hGK29ObkZ1ellxVDkyc1A2SERvTFoy?=
 =?utf-8?B?bVdBTWk4V2ZvNXhmVU5ySHVaRll2MnBvdTI4clA1V3h5L3Y0V2VJK2J4TzNs?=
 =?utf-8?B?cG9qVm1nU2ljWUs3OTFkdnBBZmFjcU5HaWl6WWlaajlKZzA2K05YcDNucnk4?=
 =?utf-8?B?bDJidG80RFAwOXBkQ2NPcVJQVzBWOS9FL2dod0M0cGd1eUhpZHJ5NU5udWk1?=
 =?utf-8?B?N1ZjT1FDY2JhQkFZdTVpcEVKMTc3Z3d3NldYMG9hNE53U1JJcE8zTUNCYU1w?=
 =?utf-8?B?OE5SaW15RmxlaDdObUp6b2R5Z0ZuM29QTDRzOW5VTFl3Vm44RHdzaXdYUk9h?=
 =?utf-8?B?VUtPNmxvSk9iQjRjaTExM3FidTVjcFlnaWNjWnZ5VmQ4S0NDaTlHTkhqZFBI?=
 =?utf-8?B?eFdqN0NpZE9HMHVmOEpPemhITUhwRy8reU01TmdqdjU3UytGR3lJb1RWZTFr?=
 =?utf-8?B?Zzh1NlVKa0F4VHFZZTZGUVcxaFk1ei9EZHRDMUFDbkdnd25pbDVvenlFUzJB?=
 =?utf-8?B?R3Y1YzBTMGZsQ2s0Uk50akh4N2xxZnZYSFhZVm1ORWZ0WDM5TGtPTkl0dCtW?=
 =?utf-8?B?ektka0FGOG5kYTVhZzZPZGQ4S1dwZGpKS2FPZHdEU2MrSU9wNEVZamFTdTRI?=
 =?utf-8?B?Y095RVFzZ2crbjJnUmcvbmZkRGVCWjF4anhKUTZOK28zZlpwdVpjSDVWc0Zl?=
 =?utf-8?B?cFpMYU11TVdLYjljWG41Wi9PUmhRNE5sUVFLanYzcUlna3A0Z0NQTUhjYkxD?=
 =?utf-8?B?YXlSNGZnMDAwZ1VGek83TEJjZ05CYVR1cW92REp2ckwzZmp2Tm1QRlRSb2hv?=
 =?utf-8?B?OFN5QmdPWmo1N3kzcXUvTTFJY1p2U2ZtTEk4Vms5aEp2dytWUGFLQjlTUzk5?=
 =?utf-8?B?WVR2a05QTTRleEdGMHdobzk2dWRDeS9rVWtXYUw3dUJUREs3bDlkSG93cEFT?=
 =?utf-8?B?ektXM1RGS0RyV2grbVZVdVFQUktFQ1Zmb085NjFQdEZ4c3VzZXliaE03akpo?=
 =?utf-8?B?d2dTWGtySGJHWXkyTXI2WG4wNlk4ZHBURzdydEV1bnFFTzNiUmhjWFczUEkv?=
 =?utf-8?B?MXFjd2pic3oyVjNDUmpkMGdxTlpzZWRaZVlWdjJjSDJLcCtyQkZhUHoyY1lX?=
 =?utf-8?B?ZmJESHd5enBhMHZlYVhPcTg4TjFjclIyZFZiZ1ZFRmFSSjBjYXRFWHNvMU9a?=
 =?utf-8?B?d09YbHdOMGZJMjZjOVFsWFgreTk3Q0ErempLY1JRcHlEcTh1UkVGdGxaQWpU?=
 =?utf-8?B?dkgvS0xLblNyOHEzRHJLLzJOcDh0K1hGSFdrbk9nVmRTUGtNeUFsZGQ5RFIz?=
 =?utf-8?B?bzdVeTZoVDcyb2xsQ3k0UktycFljdmVqMmg4S1lWVlpWNjRxaWhhUE4zY0l6?=
 =?utf-8?B?Z21CLytqNjdDOTBCOFBjODUybm1OcnowRVZyV3NFWGFRQ0RmdzJmZTlPV2FP?=
 =?utf-8?B?ZzYxek84aGNlZzd3REtkM3IxTERmcyt0Tm5xWmIrcTZjdEJNemk5WlMvUFdq?=
 =?utf-8?Q?f7EXVJd7V7g4qNyXvo03MCo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b9a095-1566-4c9d-6252-08d9d9af6193
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 11:49:14.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt71bykNyrsND0mfRCjaC09YHXuRW22aEFoq3hB+CsVwYtuQSnOqySMBu3XDH+C/9i1Us0NeT/PY2+ejguqEWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/2022 12:04 AM, Pierre-Louis Bossart wrote:
> [CAUTION: External Email]
> 
> couple of nit-picks:
> 
> 
>> diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
>> new file mode 100644
>> index 000000000000..cb9bbd795eee
>> --- /dev/null
>> +++ b/sound/soc/amd/acp/acp-pdm.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +//
>> +// This file is provided under a dual BSD/GPLv2 license. When using or
>> +// redistributing this file, you may do so under either license.
>> +//
>> +// Copyright(c) 2021 Advanced Micro Devices, Inc.
> 
> 2022?
> 
>> +//
>> +// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>> +//       Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> +//
>> +
>> +/*
>> + * Generic Hardware interface for ACP Audio PDM controller
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include <linux/dma-mapping.h>
> 
> alphabetical order?
> 
>> +
>> +#include "amd.h"
>> +
>> +#define DRV_NAME "acp-pdm"
>> +
>> +#define PDM_DMA_STAT         0x10
>> +#define PDM_DMA_INTR_MASK    0x10000
>> +#define PDM_DEC_64           0x2
>> +#define PDM_CLK_FREQ_MASK    0x07
>> +#define PDM_MISC_CTRL_MASK   0x10
>> +#define PDM_ENABLE           0x01
>> +#define PDM_DISABLE          0x00
>> +#define DMA_EN_MASK          0x02
>> +#define DELAY_US             5
>> +#define PDM_TIMEOUT          1000
>> +
>> +static int acp_dmic_dai_trigger(struct snd_pcm_substream *substream,
>> +                            int cmd, struct snd_soc_dai *dai)
>> +{
>> +     struct acp_stream *stream = substream->runtime->private_data;
>> +     struct device *dev = dai->component->dev;
>> +     struct acp_dev_data *adata = dev_get_drvdata(dev);
>> +     u32 physical_addr, size_dmic, period_bytes;
>> +     unsigned int dma_enable;
>> +     int ret = 0;
>> +
>> +     period_bytes = frames_to_bytes(substream->runtime,
>> +                     substream->runtime->period_size);
>> +     size_dmic = frames_to_bytes(substream->runtime,
>> +                     substream->runtime->buffer_size);
>> +
>> +     physical_addr = stream->reg_offset + MEM_WINDOW_START;
>> +
>> +     /* Init DMIC Ring buffer */
>> +     writel(physical_addr, adata->acp_base + ACP_WOV_RX_RINGBUFADDR);
>> +     writel(size_dmic, adata->acp_base + ACP_WOV_RX_RINGBUFSIZE);
>> +     writel(period_bytes, adata->acp_base + ACP_WOV_RX_INTR_WATERMARK_SIZE);
>> +     writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
> 
> could this be done in a .prepare step?
> 
>> +
>> +     switch (cmd) {
>> +     case SNDRV_PCM_TRIGGER_START:
>> +     case SNDRV_PCM_TRIGGER_RESUME:
>> +     case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +             dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
>> +             if (!(dma_enable & DMA_EN_MASK)) {
>> +                     writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
>> +                     writel(PDM_ENABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
>> +             }
>> +
>> +             ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
>> +                                             dma_enable, (dma_enable & DMA_EN_MASK),
>> +                                             DELAY_US, PDM_TIMEOUT);
>> +             break;
>> +     case SNDRV_PCM_TRIGGER_STOP:
>> +     case SNDRV_PCM_TRIGGER_SUSPEND:
>> +     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +             dma_enable = readl(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
>> +             if ((dma_enable & DMA_EN_MASK)) {
>> +                     writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_ENABLE);
>> +                     writel(PDM_DISABLE, adata->acp_base + ACP_WOV_PDM_DMA_ENABLE);
>> +
>> +             }
>> +
>> +             ret = readl_poll_timeout_atomic(adata->acp_base + ACP_WOV_PDM_DMA_ENABLE,
>> +                                             dma_enable, !(dma_enable & DMA_EN_MASK),
>> +                                             DELAY_US, PDM_TIMEOUT);
> 
> is the _atomic needed?
> 
>> +             break;
>> +     default:
>> +             ret = -EINVAL;
>> +             break;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int acp_dmic_hwparams(struct snd_pcm_substream *substream,
>> +     struct snd_pcm_hw_params *hwparams, struct snd_soc_dai *dai)
>> +{
>> +     struct device *dev = dai->component->dev;
>> +     struct acp_dev_data *adata = dev_get_drvdata(dev);
>> +     unsigned int dmic_ctrl, channels, ch_mask;
>> +
>> +     /* Enable default DMIC clk */
>> +     writel(PDM_CLK_FREQ_MASK, adata->acp_base + ACP_WOV_CLK_CTRL);
>> +     dmic_ctrl = readl(adata->acp_base + ACP_WOV_MISC_CTRL);
>> +     dmic_ctrl |= PDM_MISC_CTRL_MASK;
>> +     writel(dmic_ctrl, adata->acp_base + ACP_WOV_MISC_CTRL);
> 
> .hw_params can be called multiple times, should this clock handling be
> done in a .prepare step?
> 
> Or alternatively in .startup - this doesn't seem to depend on hardware
> parameters?
> 
>> +
>> +     channels = params_channels(hwparams);
>> +     switch (channels) {
>> +     case 2:
>> +             ch_mask = 0;
>> +             break;
>> +     case 4:
>> +             ch_mask = 1;
>> +             break;
>> +     case 6:
>> +             ch_mask = 2;
>> +             break;
>> +     default:
>> +             dev_err(dev, "Invalid channels %d\n", channels);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (params_format(hwparams) != SNDRV_PCM_FORMAT_S32_LE) {
>> +             dev_err(dai->dev, "Invalid format:%d\n", params_format(hwparams));
>> +             return -EINVAL;
>> +     }
>> +
>> +     writel(ch_mask, adata->acp_base + ACP_WOV_PDM_NO_OF_CHANNELS);
>> +     writel(PDM_DEC_64, adata->acp_base + ACP_WOV_PDM_DECIMATION_FACTOR);
>> +
>> +     return 0;
>> +}
> 
>> +MODULE_LICENSE("GPL v2");
> 
> "GPL" is enough
> 
> 
Thanks, will try to adopt commnets in v3 patch chain
