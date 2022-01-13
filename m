Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11BA48DB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiAMQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:18:54 -0500
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:19553
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbiAMQSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:18:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtfS1UxbtVfA7+2aXle9uyJmsOvM0L4KbOp+hnlt0HOiVq1o1qttxm6bBzWkCxO4wTQBIvMKoygFLAaIpwTUzO3Z1jqgZe5ZKjqgzRmhjal/ZvfeX1wMHlmwVbXwPTQ2uccmo6emEXD0r9+huNvdM9TgbthbgaHfNyJM3S1X7L8Au/w3HX9/Ab1wZBdkmP7ZA4AiTlyivg0cUETsy+eGb1pZH9XkFtYTTjYBmqUyBe2CBeYXzjeS4UZnnz+jpIhOfQizdlSpooq49TkALgb2ABOgxx4pWXwhmFxiG3voOip0FQJHZzy8d8xJvlHaBvYEGLyR79ScUPG79mMgmb528A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Iq3PgaXUagYi25NKm5yqz3xm1kNLA+TAT2YQCJtnsc=;
 b=XvcYxghm7MuHJOfZWMiOINYCyRvYDEbpTMBvhoHbXwnLCOAF5k2jZqIZhwkxJdakUGFsWEHEpHG73Mc0eWaYQByVlcvFnTQfnlJw5egu1TZ5YqS9giHXczovvD1w0QnaytMh4DFz7a56IbM1cEAkxgzQ9q4BpX/BVRbm/Y8nGHYzar4bL9wMowmZ/Gi8gVd6VkcMOhC9ftpt4VlQHQ0Se/rq0imYs3IKgqjyBlD924ikCq4Tir6Ie188v+CMPfAt7hlorvPmI9GYoXane0aglTQMANf6Tq5P2rviOI3RmID8I20PWwfvQIcqCqH3K636prxe4k9vWderZHqcUMLpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Iq3PgaXUagYi25NKm5yqz3xm1kNLA+TAT2YQCJtnsc=;
 b=u1z+BIRo8vuRKTaUCgqM1DKrk1X7z4WBtmTj8HFLmvp+n6Ql72LEW6tuTZ+X9zYFrwjkGSLqwgxRngPyRW6+egJH2Ws2A4veJadiky4UClfw9tLQ2EVytLB6qX2K0ljSZhWQ53S4X1BjvIMMuk1Dnr9U3ZoHu75dMArzAsf+/gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM6PR12MB2873.namprd12.prod.outlook.com (2603:10b6:5:18a::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 13 Jan 2022 16:18:51 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::2437:1c64:765e:2fb6%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 16:18:51 +0000
Message-ID: <336bda37-2a42-44ef-5fee-271899b15e54@amd.com>
Date:   Thu, 13 Jan 2022 21:48:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/6] ASoC: amd: acp: Add generic PCI driver module for ACP
 device
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>
References: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
 <20220113092842.432101-4-AjitKumar.Pandey@amd.com>
 <9da4d004-5fc3-125a-4e60-f0a6a4007d2b@linux.intel.com>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <9da4d004-5fc3-125a-4e60-f0a6a4007d2b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::28) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8680d0c-4d27-4aca-1fdd-08d9d6b0629b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB287376EE41F248370D7F94B682539@DM6PR12MB2873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qs1901+EeRIxQZwx5mUcXmJJvw/AjZ83wIVFhQMH+K7fvI/uhcJYdrqHbuFPpPzOnFweHllERwJl6xeQYLuM0nwc10uLmUmA9Khj2N2sExPlYUEgkeGjM8iekaZQqTnYZp5jcIc7kTNbjmjA1dtrP3nUOmdF2XdV6KNibrlv+LwgSAIlpoBFRDpM/XH8i9RfZxd/bTIdlpav2Oiprz2QTWsS30ViKl/u6ZA7hMOmsICIlfVcc0ri9vXutkD+dg/AfjuLxg1jayj3XCxkKNaO0DL80TX3Ze+wNMrdoOoGygsaF6X5B++T4wtDJ9ruFeMAW9ox/zoy5sUVPMr3ELgUodLEaS6y2n5a7nse4QixZHUaC5EKCeH+JO2KuOSGyzi3Ip7so5MY/BWNgMXToX5F6azK6CNZb8j3Uc9K+lwlKmHt6fuK+kT6QVQqeZMZB+umX4JxVBg0A8VwbmiWWHJFWKUMmRRD338X7KNIjVZWHRLfgWvzud39ma0AlnwbPtszIvnYhhYThRSAbzxdk7zHC4pZPlsJ6wU4ko/m8RB7N92/g5vD+nW+d2g3QnmzMs+URCWXD0dIyF7AwppYCw6iSKhaSr8SqFO6h5b1l4wfnMPg6+ALe+DHW47M6p5NTYvTwg1Zq+ElPEgiuR790bbQXVAWlgL2ULaNd4eYCD8RhIB/pSRe57fw0p843t3FopZlkLhl0a6VmA9Sq/pxGi4OgyXP0TY0Oz2kg9/0KdbtFT3o5uj6CAuCrIS+yeNSh2wG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(6486002)(86362001)(66946007)(6506007)(38100700002)(53546011)(36756003)(66476007)(5660300002)(2616005)(7416002)(6666004)(8676002)(31686004)(83380400001)(316002)(4326008)(66556008)(31696002)(2906002)(186003)(26005)(54906003)(508600001)(8936002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZMUGRiSC9OblNIenZrbnEyWTVnbXhxVFhvUHFnQWlqc3N2LzA1bDMybXZI?=
 =?utf-8?B?bXNqUE5VeTJIcVhabTI0ZEdIbVRSNGtRN3kxNXZKdlZYZU5PY1FqaHlQeUNK?=
 =?utf-8?B?TU9mTmxET1IrUnBGNEJibVhHOS84Zmg3ME1RK2s0aTlvcWVlRjgzNUpnYndk?=
 =?utf-8?B?ZW5raVdxaTBJWjNwQXFONHZLS3BrbDVKV1JYVi9iZTBZV0dRZHR6VEJqeXpZ?=
 =?utf-8?B?WVlhNmNJbjJ3dlpiZHh1VzFYL0xNVk52bnhzRFB4dU93c3BPaEwzUzA5K3ox?=
 =?utf-8?B?Q1EweXE3TkloQk5iUXp3M0RmcnlZV2NGNzFlQnJlaUpzSk56cDZSZ1hTWlZO?=
 =?utf-8?B?UDdIelpBMjFXZnBqT0Z1ZUZmR2phaGMvaE5RbXNRV3gyRVI1aUFkY2x2ZDl6?=
 =?utf-8?B?QXlCb3QvSnZoOGtnSXNnUFg0VkxsS0FxYzRxR1dyRlVmZ3lFY3FaYzVxTkdS?=
 =?utf-8?B?QVViVFJ5SzhHbVVjQUgvQ001aWtnVXZmbUFkSWhzeDJvemt6OG1SMGZjZlg1?=
 =?utf-8?B?S1JOR1pBUXlOZ05QdmJrVEo5OGtxL1d1TWVFZlJEWHdoVm1ya3k0TW8vK1Uv?=
 =?utf-8?B?bG45UU5mdWt1R1VKL05nR2Nnempjd2YrclNwY0JhUlZEODdUUzRxNnVlSmZm?=
 =?utf-8?B?c0FvQkExczRCdHdBMHA5WTg0MVpGVzlESWxIbEM1L1M5ZmMyNVQ4NTRYdTBH?=
 =?utf-8?B?ZG5BVHpRQmlKM1RHU0ZYR0JSZUFJalk5UDk5dmppTEMvZ1NFaW9oYkluU296?=
 =?utf-8?B?NmxYd01UVFRUTC9DRVZ0YWkzYmRqWXArSDNwZTJyUUJ6b1pMb29ZTlYweTg3?=
 =?utf-8?B?dWlqMW41UnVQTUsrY3lNRDhGTnNZQm9uZzY2b0plWUhTRkZRdWx0ejlWZFlV?=
 =?utf-8?B?bVJ4a05FZFkrUzVHNmJpbDVqV0xmRmNWbnlUTG45QjZubEIvMTVpU2dJcXRs?=
 =?utf-8?B?ZFFQM2orditxbFk4Y2dGV1dTZUVEL1JiUkljK3pGUE9TWjZvb0dGNVp3K096?=
 =?utf-8?B?aldFSmRINjhGUkNCczM5MUZqVlFXd0ZpemFoVG84aFM5cE9HVGNzcm9jMHlC?=
 =?utf-8?B?QW5pZDlTQ0JCeXc0d3c0cXdaRkRtSEQ2RmhCNlJSRTlsMTBidkwvb3gzSlpD?=
 =?utf-8?B?a3E0bnVkQUxTdmFkM0N1MXVtc3ZYWGxDT3M0ZU4rWXRuazlwK0hFMHM0MmpS?=
 =?utf-8?B?a2dXandhRWhUejRDN3FrQTI3RG5hekdiZGR3ZDgxejNJUWpST2pkNFRHZ2VS?=
 =?utf-8?B?dlRpNUNaQjdjaW9FcDR0ellvY01NdE4zeHFyNFk0T0ozN3RucUlKTEVaZXNX?=
 =?utf-8?B?TWtQUkNQTi9rOFVGUEZac3orUHEzRnVoMm1VYXRPNlp6cHpyMlhTUUlpcUFI?=
 =?utf-8?B?cGIvTTZ0dHRUb3R1ZFhhUGJWRDZscWduZTlpbXVyWi9mbHV0VWV3N3JWV016?=
 =?utf-8?B?NTUycEN6djdJZHByUGY3ditsdytsNlcyN3BZRTU1QnZMZ3lOSmhLdVArQ1Qx?=
 =?utf-8?B?TVkvYjFqSm9ZSGtaWWM3SFZ0eGVvb2EzVjg1elpkNFo2QVhnRm5ncFVublpH?=
 =?utf-8?B?MmNnbHUzcC9zd0kzS3FMeFQ1UTVSV1k0WVNUZjRqUmdKR0hZUER4aFFsR2dw?=
 =?utf-8?B?SHVZNG9oM0lZT2V0ZzM0MUZBYmtYak1lVkh3cGYyV2o0WXg5V1RLaStYODM0?=
 =?utf-8?B?OWV1TGZrRzRGNUVhSWlKcERybzJEU2VUMHRPbXlPeGZsVGNnSjYvNmFrbC9B?=
 =?utf-8?B?Si8zc2ZscytxRHdmZXRkTVlPMG5ob0lWYUFXWW84YkRUN0cvVjRKZnU1dVFL?=
 =?utf-8?B?Smp5MmhacnRoN056bG1IM25kc3JtNjZRU3JpcTFCYUxuTEtaZTZPY3Rpdkxx?=
 =?utf-8?B?MGVGMDE1RVgvY3V0THVqcWJ2MUgzMmYrRWc2c0NWMkRQWmo0QWNGQ0NKaDhY?=
 =?utf-8?B?MW44Mk1jZCtiN2hIbzFXOVJkT090OTUxVS9pZnZjbzBRZEtMRGtkdWc2a1Vu?=
 =?utf-8?B?eEdQSTVaSXNvMlRnaWtqNGl3UWVPUEZLYWhCN1c1dVZ0UnlFTktCUWhyRERK?=
 =?utf-8?B?ZzRYQnNnQ0o3OTRQc0VGUVRhWGY3MFFUYVpvZVlQeXB4TnRRSXFrVlk0aGhR?=
 =?utf-8?B?QlRSQXZTaGlOZWYzb0lTNEppdHRwWk9wMU94SXZaNGgvZFo0cHg2RlZWMWJT?=
 =?utf-8?Q?s+AAdqAzchq1mo0pb3wKTa8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8680d0c-4d27-4aca-1fdd-08d9d6b0629b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:18:51.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNP9DABjKXcbnNMQti4EocEswdo+GOitMP4cIyjh8P4dR/gxEynt5HWnKnfdjBpVtqLwYp7BLurevfbE+DMNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2022 8:57 PM, Pierre-Louis Bossart wrote:
> [CAUTION: External Email]
> 
>> +static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
>> +{
>> +     struct platform_device_info pdevinfo;
>> +     struct device *dev = &pci->dev;
>> +     const struct resource *res_acp;
>> +     struct acp_chip_info *chip;
>> +     struct resource *res;
>> +     unsigned int flag, addr, num_res, i;
>> +     int ret;
>> +
>> +     flag = snd_amd_acp_find_config(pci);
>> +     if (flag != FLAG_AMD_LEGACY)
>> +             return -ENODEV;
>> +
>> +     chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
>> +     if (!chip)
>> +             return -ENOMEM;
>> +
>> +     if (pci_enable_device(pci)) {
>> +             dev_err(&pci->dev, "pci_enable_device failed\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = pci_request_regions(pci, "AMD ACP3x audio");
>> +     if (ret < 0) {
>> +             dev_err(&pci->dev, "pci_request_regions failed\n");
>> +             return -ENOMEM;
>> +     }
>> +
>> +     pci_set_master(pci);
>> +
>> +     switch (pci->revision) {
>> +     case 0x01:
>> +             res_acp = acp3x_res;
>> +             num_res = ARRAY_SIZE(acp3x_res);
>> +             chip->name = "acp_asoc_renoir";
>> +             chip->acp_rev = ACP3X_DEV;
>> +             break;
>> +     default:
>> +             dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
>> +             return -EINVAL;
>> +     }
>> +
>> +     dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
>> +     if (IS_ERR(dmic_dev)) {
>> +             dev_err(dev, "failed to create DMIC device\n");
>> +             return PTR_ERR(dmic_dev);
>> +     }
> 
> Past this point, any error handling needs to use
> platform_device_unregister(dmic_dev);
> ...
> 
>> +     addr = pci_resource_start(pci, 0);
>> +     chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
>> +
>> +     res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
>> +     if (!res)
>> +             return -ENOMEM;
> 
> ...which is missed here.
Thanks .. will fix this in v1 patch chain
> 
>> +
>> +     for (i = 0; i < num_res; i++, res_acp++) {
>> +             res[i].name = res_acp->name;
>> +             res[i].flags = res_acp->flags;
>> +             res[i].start = addr + res_acp->start;
>> +             res[i].end = addr + res_acp->end;
>> +             if (res_acp->flags == IORESOURCE_IRQ) {
>> +                     res[i].start = pci->irq;
>> +                     res[i].end = res[i].start;
>> +             }
>> +     }
>> +
>> +     memset(&pdevinfo, 0, sizeof(pdevinfo));
>> +
>> +     pdevinfo.name = chip->name;
>> +     pdevinfo.id = 0;
>> +     pdevinfo.parent = &pci->dev;
>> +     pdevinfo.num_res = num_res;
>> +     pdevinfo.res = &res[0];
>> +     pdevinfo.data = chip;
>> +     pdevinfo.size_data = sizeof(*chip);
>> +
>> +     pdev = platform_device_register_full(&pdevinfo);
>> +     if (IS_ERR(pdev)) {
>> +             dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
>> +             platform_device_unregister(dmic_dev);
>> +             ret = PTR_ERR(pdev);
>> +     }
>> +
>> +     return ret;
>> +};
> 
