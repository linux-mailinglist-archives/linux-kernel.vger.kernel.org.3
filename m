Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB914D66E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbiCKQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiCKQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:55:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23087C6812;
        Fri, 11 Mar 2022 08:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsAd7kdNS1OMnVd25MrKLh2jmvHXGyJGnkRdhQNSN7CjS+5RhtNYx0FUqAHaG6ZRekn4+Xne5KtTPdCt4ubxY3aVro/U8JionOpPSfv5nJxeSbCywfmEKasxyt+LeagjaQlT2HuM7vzARZrH+so2nMBG7vpnGNJIrMNYmVlCIoKaaUSTWDQUi+TbR/PpEkDOiRrbcqoWId8r8Q4Q/0/mB+Jxqhs+1ZAsMMN5cOUIS4eAU2MM1kkLhVQm69Tf/qXUZNeZCfCCeevmy4y3rjlu1dPHUngBa2jgpaVWOIBWpjAx3/I2mnix/tsamjeHajkMKxtzdDyYt67YaHq5xb8HGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2oyjcRGgVhFBBGgLwSYAgYWvXaoK5Z+u9SuoSQH4jg=;
 b=ETgeAHUJHBM4AFjZ/YOGEqj2jodWQg88NF0iv8XTCYEn/UONZBAc2wvVmZPQLjq2tjoBA0e8z8iafeDs905MwyNiv3ROuseXxFhNAGZwmtXdyLWpoPGGEp7m9NcvYPOC7Nsb3le7iE63fR8TmoRKlfhlcgec5Eqrul0X2UVbk9lDcACZjAMZv3sRLlZnDLZrmfEh5OBkSeFBlGHXYOC4idYLtTogwqGwuj8enCp2dkDAY5Iky8ETwGuE3c8D6UUMXCuq3VTJ28DWTuXIz75KGnK20Yv98LNzi2kgj5E/CeEF1RK6K8YKEWEVEZoNnrtcWAbNm1c1DaZl2C3Bg64vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2oyjcRGgVhFBBGgLwSYAgYWvXaoK5Z+u9SuoSQH4jg=;
 b=PDcEPhUJ6n03sy/HKTUTW5dDn0Hi+1vBbiwHN6ulA4rm8viY4/6Mzg5cx5nSCTsZGub7IHO8FRC3UyNlni2T9NVvp/xBLs5dvJ0LReCWgS7OZh2qp0owe4/uSBGyi534rwzvazdYD0pj2bNwgM2xDXZ65OFLrxZdNMN2a7xctd3RIG3qAK2B53xzGWM6mlF1oRND2oxCOvdAHMiluEr7qZt8ONFpx4VKuJRiVkfEbRCe3m0hYB/3IwSwZN/Bt7c6DX2hYGOOYLcscLNZon4SD0oj0f9hAk4jVL10yp6D2YxAGrmSTHzq5SWDgjvMNuA8OqGN/sKLPfBaVvY8xUZgDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM5PR12MB2342.namprd12.prod.outlook.com (2603:10b6:4:ba::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.29; Fri, 11 Mar 2022 16:54:23 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 16:54:23 +0000
Message-ID: <db1e0d18-8a6a-02a2-a663-386987cc7df8@nvidia.com>
Date:   Fri, 11 Mar 2022 16:54:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ACPI: SPCR: Add support for NVIDIA 16550-compatible port
 subtype
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Brasen <jbrasen@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220311165310.60418-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220311165310.60418-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efbfb098-c025-4a9c-1a4a-08da037fcaec
X-MS-TrafficTypeDiagnostic: DM5PR12MB2342:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23424122A69D64C1A0C8B88CD90C9@DM5PR12MB2342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZDAHEP3a71VhKlhJaUj/rqjcKchgZovR6HxVjtlOCWGknlzA1DR4gbR+RkK3ta71EDCVtLqc/SvKGaXTfdjzpHh0hnKDmIYTDy/yLe3Wh5q8ImK6vmmM50K0Z+FuxRVyl5CaqDKani/vJP/hXWK04YmqRNACWlxOqJwsBQGzGcu7NjvOkc9++j0JTC6oqfZAqWkRlVh5aqUCF96NZV2YXie/fTHzVpJunJncckjO/cXR72N9qreT1QNn7xk/efQXyHvT8xDOGAzkKKHVvduYzybfmjEfph0hbRw4eMRiec+l7ROLTADnp0BRYiUKiy1npSBeWK1xDIFUNZpJHfgWU/E4SVJlOW3Z+PmkK+GvFby8TDNSqbomDlUEsiiAzmczN+yxSQVvElaLVA8gm6CW4eJcd955Oz42Z2amEE6xWt5OfPpkz5gC5Pv3Im+Lh5jIkRm+oGJNkbcZocGIcuZ4VOP9kCbcHzLG8HM6o7tFRDXVEAYdQoR2Tuuf2ypNe29Su2fZlJcYQxuLqAz9tNHtX951wt/3i+j4h3IPrAtJol9wRlcBkDDoNLiMx2RCYx3Br2fnzCDZzNvjfgp0Kjv2Dlawb7zUUdcxLjxNS7xLwYU8Mvhi39XLktcPlCxNiS4UAyYBtXEV9fDQbLNN8Vi7gMk6T1SRDzZfsHYo/Cl12lki0+sg1LAuY8+smhmNZdBIBKc22xA0Wz7RHhgYJ2anzNmykp5Tg2/vDKuk83nogE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(31686004)(54906003)(316002)(6916009)(6486002)(8676002)(66476007)(66556008)(66946007)(4326008)(8936002)(6506007)(4744005)(5660300002)(2616005)(186003)(26005)(55236004)(53546011)(6512007)(36756003)(6666004)(86362001)(2906002)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDV6SHJFMVBKaGV4VzNYNzFQOXV5eldWS2pCMlJKSHJqQys3Z3pQTXRpUDZx?=
 =?utf-8?B?TWxqY1VHcE1hdFpCOVBVNnVHQ3MzK3UxM3lOcGwwTytiKzM0N0tQTTgyZjBx?=
 =?utf-8?B?SjdLMkZsbzVwbXhVSTEyTytxYjJjWXZuVjYxcWo5dEorcUhpRmFBYytHQlpS?=
 =?utf-8?B?WTBuMlRDMk1LWVRUYWxWbUhqb1VvaWhibFlEWDl2N2ROd2ZjNWlOOTUzQmFY?=
 =?utf-8?B?aUxwcTZiZ3JWT0dlRFlPSEoxd2czZk5ZdXloY0pOeG05QnVCM1NEVFQ3Sm1L?=
 =?utf-8?B?YlppVWhVRXFGTGhGWHhmSjR2cWQxUW5xZ0ZYMDlpTUQ1RUl1RVVMQjVOT3dX?=
 =?utf-8?B?MUd2dXRPaUdQOVBxMys1cm10eWp2b3lqeWRqQzU4RE5HcmpvVzg5OTVLWngy?=
 =?utf-8?B?aUt5T25vSFlsbElCa21xY01XM0VkZGlPVjNpajBnREdBU21TeWhtSzlxMjl4?=
 =?utf-8?B?R3NHT1NISjJNZEU2VXBiakl1MVhrczE4M3UvbTdualJLODYxbDFxYS9pci9m?=
 =?utf-8?B?UWE2YjhKUTZMUUJ0K3dnbWYwTEdUVjlLWTZNVDZWRCt0YkdrTzBVblhkTlFk?=
 =?utf-8?B?Uk5SNER6Rk5na0JwZG5velFvL0FxOHpmdUtTZTF3Nk8wRlJiaEhFM2IvVmxR?=
 =?utf-8?B?aHREY3NQU25Ic21LTGY3d00xZFNwYTF4MXhTcldCT2VvSU94aERkRXJHNmp1?=
 =?utf-8?B?c3VoSGFvK2g5Vmt3UXJabTdJVWlHNmxna1VjR3Z5M2J3T2gyeFM4YkRXSnZp?=
 =?utf-8?B?TXo4Ymcza0U2UGxBdk43Wm14OGwyV2NLaEJEQzRTdVVvK1RVZ0tzWGVMYkNn?=
 =?utf-8?B?VWhiWFNuWWRKYU55dThBL0tVTjdoTVFQUUswemxQVEdnQkY5RVlZcEVvL1lV?=
 =?utf-8?B?Y1lYUVNMeFc0bVRYUSs1VzRkbTRGNzJIMVVzYTJNMUgvd2dYUEtaNGFzOHhK?=
 =?utf-8?B?eHk0TDRGbm02dHRrU0tvaE44MEQ0c2x4eE1vRE14S1VkWUc0bWk2Tms3a0Ni?=
 =?utf-8?B?Y3NBbHZFZTBzTmdNNzlLbWhYVHhybHZXS2ZRcUk0YmNYdE0wdkprSmhXQkhn?=
 =?utf-8?B?WDFQYlZkaVJjb1J4Q1JoUVhnaWxrSHBwUWJBUnZETlVBSmtjVHUzRWI5OHRy?=
 =?utf-8?B?a01OVXFvL0ZnMzFpTTRJeGlxNExZeWM0V1Y2aldSeTNDRW5RZ1lBU0JqQUp2?=
 =?utf-8?B?NzFEOS9IajdyU3hJTGxXU3F5eDBpNmRJeXZya1U1aVQ0WHNoSTNlNDljazFM?=
 =?utf-8?B?ekZNbnV1Z1Zqa0tZd3RHSzZtUElLNGhKeUpYS0ZsNXgxNG5lWC9SNXl6WkJn?=
 =?utf-8?B?bzdIUytXTzMvY2d0S3V2RGZQR2JtYnN6NEJzeGJ2bjR2Szh2SVdDQlIveWND?=
 =?utf-8?B?WC9GNTFDLzc5amVlTUo5b3ZHVWFIaEpCUlkyNnVrR3VTcEZTWU16cml5MnFt?=
 =?utf-8?B?OTVQaHZhcU05N3ZtMW55QmJFREE5SHhiQ0VsTlNoc3lnRi9zTzlQWmhRWWo2?=
 =?utf-8?B?OXVuNFFzTTN4S3FpaVoyMGtZWlp2b2J6SkpPWStEUkJ3Tm9JbU5KNXJzNDhK?=
 =?utf-8?B?K1NySHFOWnUzZVUweUo1eTA0bC9iYzlGNU5BVDV2ekpXLzJGbG93UG8xQXRI?=
 =?utf-8?B?ak1xN0pqV0lnRGRVNzhTdEFURUc3OE85dU9oU28rdTMrVzl5RkNCWnpGbkly?=
 =?utf-8?B?clEwRjhCT2hlaHU2RW1oU0Y5NUx1MlFuTkFhNnNaSXJKUUZ4US9EV1RGczU4?=
 =?utf-8?B?a2VnZi9UTEFuY3lHUmZ5a0J6QzNIZGN4djh5cTBKRTJJUHRrWENLd1luaHVZ?=
 =?utf-8?B?c2NqdzFtbndmOE14b01LbEloNUpDN3B0R0ZnQTJvQnB4eXNhQ3djdTNIaEdh?=
 =?utf-8?B?eWFHc0xNWmxnUFBmZUtVOE1heEhUQXR1V0hnMEcvc213cTZIVHV5bEMzTnVU?=
 =?utf-8?B?N0FjdlZ1ek0xMlVRdFhZS096RjRJUzRudytvUi8vNnVvZEpvcjV1YlNPK2tI?=
 =?utf-8?B?WXVYVDdUd3pWeFVXOW01Umo1RjBSN09YcDZiSHNpU2hzQXRjQ0pMVnRPaWtT?=
 =?utf-8?B?U1FZdXN2RS9BZ1p5WjR6NlVsbFlYNGo1RkcrNlhiY201S1N1SUpmZlMxMVBB?=
 =?utf-8?B?QWM4TlZ2aVFlVDljVm04TTg0TDFSU29XaXVwbGZDOXZyb0h2VkQ5TXhNdXFQ?=
 =?utf-8?Q?bRgq2PJj7FQVelRCDrLyPaE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbfb098-c025-4a9c-1a4a-08da037fcaec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:54:22.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFjYR8MSCMX7fpwq00g+oQeSePza7lfET/iFKCttkinUZ8eZvPdMJnKb59+ly1C2Iem8hpv+wgKe2M/25NEzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2342
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-tegra ...

On 11/03/2022 16:53, Jon Hunter wrote:
> From: Jeff Brasen <jbrasen@nvidia.com>
> 
> Add support for the NVIDIA specific 16550 subtype to SPCR table parsing
> routine.
> 
> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   drivers/acpi/spcr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index d589543875b8..1eabfcd122ee 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -142,6 +142,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>   	case ACPI_DBG2_16550_COMPATIBLE:
>   	case ACPI_DBG2_16550_SUBSET:
>   	case ACPI_DBG2_16550_WITH_GAS:
> +	case ACPI_DBG2_16550_NVIDIA:
>   		uart = "uart";
>   		break;
>   	default:

-- 
nvpublic
