Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4129561685
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiF3Jio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiF3JiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736F433A9;
        Thu, 30 Jun 2022 02:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZO+XdhoOswWEB85mKkhPNTDsndaEXP4dBkKeyaWd4zwbud76ZU4rVJUmrKQLPoTjbFtzA9tB++xH5Kc9NNxlJsD/tRpRJI9ZgnM+fs7Y1FYoKifoGDGk4f3B7dzCr+Uwa0I2nvKtzGIlLqkKGs45TAEGN4ILwYuacNEAVdnRz7yZLlpna4tjO+OooAO7X3uwdh/SpcI7TsdogM8WEpMSsD7JuB1ZSE7Elnl0tJ6ONbNdgyuJ/O/KiYc95VGi0DMl8/ONimSYpRnMNS4EutbXtnszD6AjhWZQoZf02obaK9lRtx/C/AwI3V4iDqGigtfk2JrgnCS5m4UsIBjPuxJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svNn5n1tfvhOMTDb4mO8v/0NIzf6hVfZRSNRgq/WK8s=;
 b=jiUVTVxjNhq4r2eIp16XUxAlGSTfnRDA4S8dzkrOy4iM72W3VYrZCI6gB0nSf1mOiG/tq2YLK7xehu/l58x2TujGOLgggTG3G0Sv5ln9ONR8VlVUKTzGTO3wpeOQLtf+vvvObjstT0DWHiQ4ldq00l0japkTJvFnF7DYj3pdrZQ5KMfrsPbHqM5dbZcZUxe9RhjYOdMluCorzS6qsrlxG1dsXiAFK8LBiPNF0xouFdyOcTr4wuns6O0Or52G0rA4lTPxz7AEsolh9SiEFyXtVFTYKrYvmteBiSQ9vS4TGW1hxEUmAE+54E8Ygbftg59LYiR4ixbCJNvVzZNfqwfIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svNn5n1tfvhOMTDb4mO8v/0NIzf6hVfZRSNRgq/WK8s=;
 b=bemDYPuvZRIrj2k6v6YN9Adph86169hOiX5wdMH7WxgCvDDJPPwI8QjLoHugqfSBDzW1qQa6XLuMVtiyoz4U6Eaoso8d3slvtNgE2oH+P4EYrTmnhSOSRM+iNy72yVcQp++x/i5QpfRRkOEKhcpG2cl9nZqrG5JzkotDbXQeTopFIMzckiOzhDYQjfTjA/kxLzvcca4Bqz7bHIe53xOdaZCmqtgHLqrg0pf6avIsM9N0wQ17gv09jU9rQjLxJ6kH9+w+HpcredG3ao4XjctqcvA57tBaMId6pSJj/h1+w4vYAT4Jn/eA1A+17ZPzRSPkZL79Rn53MQWj9PFsybZuFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 09:37:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:37:55 +0000
Message-ID: <424e4800-4638-f29f-7f7a-25561dc49fd0@nvidia.com>
Date:   Thu, 30 Jun 2022 10:37:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/6] clocksource: Add Tegra186 timers support
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-3-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-3-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc895fae-64f6-4b4b-8c45-08da5a7c3574
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJiIf1De+J32aUmsNrOSNPA24ftrM8H+WvGs1glo4gdbzpmohNDCWke3QPSoScBEubE77ULjvvuL+mwfYnwuWF5xyi53eJdmZ77MxSd4A1Dcswa292MtJzgBxUNX+epE8bDZKMnKztrSfDu+NH9Y9bKLcxfQWvTFgKTfr27COq5xf3/Cy2AqqhHgL7d+V/xxHvv+HpYa3TjgXKl2TcsAsCSXkk5WjDqgueWoKz4tmFAhcdpPpn4q3/U9lWK46/TnTvhs+RydI3WxEjIqsDuzLbFVgllgyP08lqUp+bO7tEMxj3eO/QwG+VmGoBfELX/kN9Zse7YLNto2Mn5ubt8JzcyzQ2f3rNVxEnBbwldazwnmJt7tWkDIr4Wv4dXgKv/KwGNVKt7Hf2mJd6DEmG1Fj8XHrtVd+1sUtXRzV7SgxA0OUlmYL2CZglVPbi7KmXVjRA0BfClueBd4crG4TD8/PyHq3gEjJ6TvOiP2LkObKSecuN6YuUTmSZrEyb+zeJmDyBSMrywV8zNqKfdP7I3v88dP4FKSoUB0KvZeLSrN2p/63I5lHWZMP7yGWvlpY253bVxGgea+EoD+f0NDf72jOxJWmgWkr95fuSuMjQVK5jqZSts9XA1egsEOv1+/o/R2KAHJGnJkGbTy7KsYd/iYlUbplGRiI7jVoxgrYP+jzTKJyrTbF95tf/mB6Ow3aanT7eSzlCi/vkC4wetKS/j5zxWkF9iIIc33Ho0OCg91F58AOcIoC30+JhDInd4/jgV9lW0ytr9gAaH4E0Mbt3kLhOgu9lX9jHwMVa/PjFK+bC/VyE4pt/Me+ylxjWXWVylvepVjJsd/Ww/KFcUcsq98E2NIEg0FT+cSM681rdZTcCXcpPMpu5o5HnwOfVT3p4kG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(921005)(316002)(36756003)(31686004)(66556008)(66476007)(83380400001)(66946007)(2906002)(31696002)(5660300002)(186003)(6666004)(41300700001)(8936002)(86362001)(38100700002)(6486002)(6512007)(26005)(2616005)(53546011)(478600001)(4744005)(6506007)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZWSW1rU1JwckpZanp5Ri9UNjZxRG5qSGUxWjFvajM4YklsN3lsaERBcTJD?=
 =?utf-8?B?cFA3T2lhT3MrUnF5dDJFaGUremIrVGM4aTl4cmx3T1lTUURyejJhWkVLS0Jj?=
 =?utf-8?B?QmRZdDU2cU5nNXZEdFJxSVhIT2Iweml0UmVnbDBIa0lkU0lMaU1tdHJKVStZ?=
 =?utf-8?B?N1U3a21LOFZIcmFRMWdOVW92WEhiQitQa0grZkFDSXB1MTRTV2Nlb1drZ3Uv?=
 =?utf-8?B?aUxHaUdZN3huZGtVcEwvbVhJcW03S08vaE5VTlYvcnFiN0Zvc2doakdtT0tk?=
 =?utf-8?B?ZEFONHMzNloxc0MxT3pRKzk3MzNXeDFpRi9BejVCV25nWlNBc0xrZkNDU3Y4?=
 =?utf-8?B?N0hJVXZqYkhiQy9ySU9aUzRSYy9NZzRtMG83STBJSEIramxwcnI2SWhwcnNo?=
 =?utf-8?B?cy95bmx1VnU5WGpvc1RZa1hUSkZrbll0UTg0MDViZnk4MEwzd0pGa0RCY1p3?=
 =?utf-8?B?RDVURmNpcjMwU1Vicmt0bWU1dytiTFJPMFVOYUxKY0tEVDFYaUxhZUw0M0Jk?=
 =?utf-8?B?OEFkQWQzKzBPUVRDRHNMR3IyNE5PaFNNQ1RYdStPSkdkd04xSG9BVkh1YW5o?=
 =?utf-8?B?RkhMd3RFOVdXUkFFc20wdGI5ZzMycTBOUUk5aVJ5d05nUEZqQTBYL2oxTWgy?=
 =?utf-8?B?WVR1bE55VEVNOC9RRHRBaitjVHA2WHlROEg4b0JTSUZzci85TlNmOXp3NWFT?=
 =?utf-8?B?NDZOY3RINnMwVmczempRYmFZWUhtNHdVSzdFNzRKNXBkWHM4YzEyaG4va0ov?=
 =?utf-8?B?WU9FZGxoZWs4S3hDZmhRdkVNQ3c0cGIza1pXMFNSM0kxN1NXYmJDMHJ2SU4x?=
 =?utf-8?B?K3YzQ1BCaHV2RWdTSE1SKzlKTUJzYVp4TEZSS01XdnVSeXNHY25RMVQ2QkVt?=
 =?utf-8?B?NiswcC9LakV3WjQ2czB6blZtbXpock5KNmVFZHh4cFljRWRFeU51VTAzTEps?=
 =?utf-8?B?a0JFOUd0Yk9xVm40QXk0dXJOZmZQQ0UwQnFaZ0d0cHJvTTVjOVJWZHd0ZEF1?=
 =?utf-8?B?OVNMMytqZXhXRkIzWjJweW5kWjJXQ2N6V3lQZjJwbDlwZ1J5STJnSkNHSWZi?=
 =?utf-8?B?WVZkN1ZmdUFzZ051YldCQXFlNVJsMGd0TXZNSlZqR29EMCtUTEc0elVTelhI?=
 =?utf-8?B?Mm1XY2orVDVlUmFwYSs4bVZDd2lTY080Rjl1WGF6VEt0N2tiSWhaR2t3aWhT?=
 =?utf-8?B?S3pKMS9EcFJLQXZ5dzg2MHJvbWdsbkVmaEduQWZuc0NUVkgxVlJ6TDJBNWpN?=
 =?utf-8?B?ZHFCazBDeWh4WkZ0dnRKcFR5WEsramd5WS94N0NkY2tvQmZBSlM2RHhzVmo0?=
 =?utf-8?B?NVk2NHZ1U01nTGRtYUxlSU9ldFdOZFA0ZEhBZWZCTjBVeUNiRnlCTjZJSnE4?=
 =?utf-8?B?cVBqU25hRCtiMzRIOUlDOXdIemxqOVdJd2tjRUl1TTlJWWdFVi96TTNQaHE5?=
 =?utf-8?B?Z2EvSi93d3BpQnFONitLMFdCZmVqMytId3YwMFJwbUtuR29NcFVtV2lGc0J0?=
 =?utf-8?B?NERDbWRQL3ViNUZBdTU4Mm9IMVQrNjhOUmx6ZHFoNzcxcHV2UTZQZGYwM1k4?=
 =?utf-8?B?aGtJSUI4US95VzB5bjl3Z2draUNUMGNDUTRUMEN0WXN6SmtScTdLalh4Zjhs?=
 =?utf-8?B?dWxiUGlqRHMzUjVXaWdiYmZxeFlkbTVRcUhYbmViSFZabHhlNW01aEg2R0Fu?=
 =?utf-8?B?U2lSVm4yUjhZaWhSYmM5cFZSVmpBaHdubERwODFVS0FXUDZYNWhlQ3lKSHRh?=
 =?utf-8?B?WXVzY2VKV2VkMHFwb3E1T3RWTGJWNlhZYkZORVhOQ2h4dUVNMTY4UDFuN2Rj?=
 =?utf-8?B?Z3B3QWdmdkdHWHNzczg3U3ZoTm5vRWZCbnB2YzUzUnVwT2QwM2lZN1Zld21R?=
 =?utf-8?B?RHM2TVFDN3NUQXFRMmp6NHA0UUN6dGZha0lmajdmbjZxMzMvSHlOSXJJNDVJ?=
 =?utf-8?B?TXc0N2lYSlhtSHAvZ0N3T3d5ekFhMGhGeEVmdzdLaE1RUFdjY1RXenRNTjNP?=
 =?utf-8?B?VWhKRXdJNEs3MmtlbnRSdTNrczdLMUp6OGdHRUFRczFjTXd2ODMwbFk2dzh6?=
 =?utf-8?B?aFZXSXpaNjMvK2hVUEhFdW1sT0xIZVBhakQ0dkdOZ3dqdGE0UUlCdWEydTZX?=
 =?utf-8?B?TVJmZS94WFRCQ0hxdkEwNUN2ZkhJd3hna0VSYWdubXhPTkd0Y20rdFlBU1Bv?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc895fae-64f6-4b4b-8c45-08da5a7c3574
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:37:54.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqzLYGXfni74jP5aWrfIvEabGDZwrpjR/Ed+YXRiMFXtNKn6v7gh7G1mBcrwnJjv7OIJeUVcjKTezF5HTDXbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
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
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently this only supports a single watchdog, which uses a timer in
> the background for countdown. Eventually the timers could be used for
> various time-keeping tasks, but by default the architected timer will
> already provide that functionality.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   drivers/clocksource/Kconfig          |   8 +
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/timer-tegra186.c | 508 +++++++++++++++++++++++++++
>   3 files changed, 517 insertions(+)
>   create mode 100644 drivers/clocksource/timer-tegra186.c
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon
-- 
nvpublic
