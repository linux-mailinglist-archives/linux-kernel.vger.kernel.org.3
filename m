Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFF481E37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhL3QhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:37:07 -0500
Received: from mail-mw2nam08on2083.outbound.protection.outlook.com ([40.107.101.83]:13472
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241327AbhL3QhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZi211NdGVfDSeFdxYmoDdDo3cuSXPrLq7HV51LuUozgZSDyXMGpOowmTKn+VNWhquBHjK0a6xGRTTii34OBhjYjeE3ucOXkpygimJQKGlDY04d5bWH+5gI64MmbcDEPpBxgMKZP/GBXIBje6X44vq4Q4MgdElA40l08sdUgGO5mDwuErjbSuF2zdP7JY5KqJUNy4eG5dXhRlTeip0JoLkA2FnX9Joh5u093WQEojuwjc2fA3JCSsczSHI6CdtJKV0GUDzYSxy5BfViUqDCanng/nrE2/1EADZU7TOM1djxquYoNiDAEJuejJKZn0WLPDLtd06o/lOeX+9gXMjNy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvnWevvQXj/V1uNywXipoIavjHxHshWe+XKnsWNE2Pc=;
 b=CJbOASkj+iWEowe3aZzUvI5RZe1+Z9xCsIcYG9VAwGsHMrzlz2tF+dY4BCVkZPicC/DxPLHtQT36t6Rkd2GX84fzRpvl0xC9uHT/UxqeV0sju6PJFCpLmC+mF4xP3E9lTWRBUm63MctIU1qgM+Id8ED53q2fVCFsva/0RZJz6+XF9kLL0Q979ldm8NcQHaKZ0TiqLitBgW7xiSKzxsrppi2iTXIIf5Xl/NkRCft72+Kl1Y0CDEi0lmBK4NhMxxF3H0Kch0o6oN4Tt13iNk4KO2qa6khCRg98Dwdy611wkGseJ1mMDH3lkxvq5QaAQNgeykHrrY0sWhj8KCXEoWsGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvnWevvQXj/V1uNywXipoIavjHxHshWe+XKnsWNE2Pc=;
 b=W8xGflXQKEKB2OIy5Cx7AfJf+kwBMMkasLUnEYVHQZKxy9VI9KfDJlxjXwRCwX2YwGNz4+Vn8iJPeWXOithCEERNjzXqyYuIVyuoeZcL8V6mCmchK7ZlMLEPfSDv62gDz7NvJc71sWk1icFc9kjaOByx7WyGAaPyj/pYTn0N82Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 16:37:04 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7%12]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 16:37:04 +0000
Subject: Re: [PATCH] gpu/drm/radeon:Fix null pointer risk
To:     Wen Zhiwei <wenzhiwei@kylinos.cn>, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20211228073126.48906-1-wenzhiwei@kylinos.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ec202938-5972-d74e-a17c-256420350eb8@amd.com>
Date:   Thu, 30 Dec 2021 17:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211228073126.48906-1-wenzhiwei@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6P192CA0046.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::23) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 196ce3e4-441c-41ba-4586-08d9cbb29cc6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49100BB09A38CCEDBD05392483459@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++fGgctMMF3FMLayQ+KmXkucWf7DU7sOaDbtABypIaidUFlyupGFdm39okkGKjZNNUjyt+F6j1bDofNRmefH2ly9zrscxPEZp0fbnOE5g0tibobVLgKdoXDOBqXN/pTg1zQ8n64j/wBO5dz0PEHVkTsgIK9SEY96jgdfvvbzkm1OhPCvAGEX6n9W650WG3Ldx9r1x74mp79Dq7prJQtizFIOTkOdPjzG7C+fAs2nsvNGOpEfQV2NfWoZ9GDdU0gpKGHWZcT+t09sDOLBXzkAaRwfn9AKCH7x8Vhy6IvpxONycSRyT3SsBiADedWebTDaV4M2IIsWFvWKow0TvAARG7HCITF3lCgJsBkA8bkLe/4WWN0W79YGvZeZgLM1R9cvSj6n7c8D/yHg/XQTkydvQII2wvPhyIDTUQhvkXv6MOjnND56x5w7vHynrz/iTGS8axwePkIFEkbWXJ4T4dQ8IqjI6ZtC7FOIZMHjlhptid0t0hC06EXHWCobZPgla7+vQKA96UZg0wToM5FQuB7iQqTMyl2f4no16zumru3nlUBnb2+3o+n2UzjwihQ6wXWD8hNJ1fqgd/3PW9sArce0DsBINhvi+Lx9tBpoFmWsJCuECiChBEMLniXDj19fWigmWU4KN4N0giX5BYuxgzXPf6uSvfLPUqioeVlKXWjcEj5xsgDePIXrYqh49I9jPauzc1Fn70BGcCryevA4Cx3CdKQyVJEuUm8tmpFNPmzIazZW2ZQXiHcVWix3i8OY0dP/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0187.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(66946007)(31686004)(6666004)(6486002)(36756003)(31696002)(86362001)(8936002)(2616005)(6512007)(66476007)(66556008)(186003)(8676002)(508600001)(4744005)(5660300002)(38100700002)(6506007)(2906002)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNKT2ZYSlRBTUhMU0tTK2lPc1hBTEtySUM1R1BjbnZuSUhWTmpUTFRvNUxp?=
 =?utf-8?B?NzhRR1dEWmdGN3ZuQnlwMDc2U2pvOW9XRFZsTWd0Wi9IUytwL0lSVnFJanEz?=
 =?utf-8?B?ZFdWYTB5RlQ4SkE2TE1CR280NjZ4eDBGSXprUWZTSWxlMlZTZnk2dFRjZEZ5?=
 =?utf-8?B?b3hRVEhRZ3FVUGlPeG5IWVFKczhlOFJPTWhuSUVzKzhaUS9yaFlJaUxjd2dr?=
 =?utf-8?B?TFJkQkYzb0oxNGE1SlRDTmVKUUxqUmp6YzlobWF5bGdxS0k0VWtkZHA4TXNX?=
 =?utf-8?B?cW9mWXc5WXdheXN6b0wwa2JLMXM0aWg4c0dySTdub1pwWXFrM3F1R0lUOE8w?=
 =?utf-8?B?dGFnQjJkaVpxc2h4NjZ1RjdxYmk2MVZOTFp2QW91b3plTkhaNnFHSXFoeHZz?=
 =?utf-8?B?blkwcWRzWXdSem9TWWdzdHhOdVFnL0tBVjRpcUdzMHZqblZvVDRUQWRNSXdI?=
 =?utf-8?B?MHpBRGdOcmdIZURJd2lMYlZDa3pJRlZZNm1tbmRQSEFiWXJHMDJOUE1FUXZo?=
 =?utf-8?B?SFAwMTU4WWxoVks4Z2hsS3ZQKzV2d1N4THk5bzhqMWFzcnd0dWlPcVFZaGp4?=
 =?utf-8?B?N3R3NmVqNWU1ZHFrdW1hSmQxUUZpanpSYTRIbTlvNGVpK3dHSkJ5TStSd0dK?=
 =?utf-8?B?L3dmbTU0NEh0NVlCWVE1MnVpUmE5N1E1ZlNVM0RVeUJYWHJNSVdiSzJxUHBx?=
 =?utf-8?B?NEtnMkFJRWtUaURGaVhQQzFIVGdkMFBJS3Y0MnpVMDRBcGJKeTA5UXRJbW1r?=
 =?utf-8?B?RlhnT3djTGJ4bkdUV2pNNFNwaHB2d2VZaEswV0tZMjB1SnhHd2lYbFRiajdK?=
 =?utf-8?B?cnljTnJ4TVprOTJwZ2FGMjl6TERzdHlqdThnRWNmdllSd1IzUEVWQWlGTGQr?=
 =?utf-8?B?K2lMN2c5RnlsbHY0dHJ5WDI1TGRFQWNRbXl0Wis5VmMzTzhRd0dOdGtPY2JH?=
 =?utf-8?B?QUpsRHltK0pVckpPVTBtc1dsQ3g1UFZjSm5GUW5JRWpyRTBxOUxjaFJTMWR2?=
 =?utf-8?B?aktFTnoxL0w1cTlqSFh1aW9LWmhtc2Y2b3ZBUkJSanFsblZKeVFMdzlTRXEv?=
 =?utf-8?B?blVKZk56QTJFWnMzczR2M0trOTRtdjNlTGdCVHhuZFAwYzhoZWlCM3haZkZt?=
 =?utf-8?B?L2NxOFQ0ZFR6OWZCSEE4dnBTWHNQam5mUDAzSXhna2ZRU3lhUGJub2Jscm5k?=
 =?utf-8?B?ZjUyY2Nja09sdGZsckNwMTdtRTdvWEExU3VqWVdxR3R2cGFoMStWME51b21o?=
 =?utf-8?B?WEVJU3ZEcU5MZjFZM2lZcy9vSTdKSmc5dDJCRWl1RXh4ODRuemJQUXlmbzEw?=
 =?utf-8?B?RDBvQnJ5TUh0K2FTZ3pBblE0RXA4UUlVRDhBWlVSRGt5b3dSc0I4Mkc3Y2Uz?=
 =?utf-8?B?bHlDcWtadTV6SWZFeDh6Um5qMDlPclEvMC9vQ3YxSmpMVG5HZi9ubSt1Ynl3?=
 =?utf-8?B?QUJEcisxMXE1bFJlMEJ3RUJGZC8rTGhpanFEaUxwdWJwYWFZUmhhSVlKbEdl?=
 =?utf-8?B?Wm9Wa3ZhOHhFdEtpcjJjNkE3L2VvNmJTb3hzaWhoSCtpOVJsUjQ1ZlFjRlpN?=
 =?utf-8?B?RElMUWMzZXpYRW1ZamYrTEdQSFNVUW1sU0Z1MW1TaVpMODVwSHZmTTNPdVZH?=
 =?utf-8?B?ZWExOXFKTUdlR1BnMGtZWE9hVENUY3dVUFQ1ZVFNNzNjbVlKSllqeWo3UzZo?=
 =?utf-8?B?bDN0WkNmNHJJVmJDUEZWbUZMdmJpWWI5bEFJRUd4SXNCUEJtcnViZC8rOGZD?=
 =?utf-8?B?ckxMQzRsT1FUM1dFRGJybG5tZ0w3UWhPSE5uQ2FZZjQzNWhsN1k5QUExdE1U?=
 =?utf-8?B?RUJZK1NHaTc3Q0g2Q0NabTdyVWV5VFkrS0lGS0tIY3BBb2EwSzRFcjZsQmNO?=
 =?utf-8?B?V2orY3c4Vi9nYlV6U3E0OXErWU4rdTRhY3hWdGdCTkRDM2U4Rlg4TVVHVy94?=
 =?utf-8?B?NVgzWDVValJCaERUY0JhTDI4Q043SmlSNndKTDdRQ0pnaE9VN2ZPRzY5SElT?=
 =?utf-8?B?bEFJU0Y1MHhpTW5CK1dtQzZra2w2a0EzM1NNN3ZXV3F2bE5FUDgyeExyRmNV?=
 =?utf-8?B?WEJQaVlQaXlOeGlNMEt1NUhJa01GUXF0VnlQSndWZGVmNVFUL2pUMlRIT0hr?=
 =?utf-8?B?NGE2N3BPekNoZVlaR2dhRFFaYlZhYzV1bFlDUXBOb2JRYjBvT08vbjA1ZnlV?=
 =?utf-8?Q?Y17RwTBXn30kEos0nVCtPLE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196ce3e4-441c-41ba-4586-08d9cbb29cc6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 16:37:04.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsGJbqNwum6ItC5qbPybW7UycTZ4rsbWdj2WFjIkNt63awL+IO5OjUodyvoK2mF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.12.21 um 08:31 schrieb Wen Zhiwei:
> If the null pointer is not judged in advance,
> there is a risk that the pointer will cross
> the boundary

As far as I can see that case is impossible, why do you want to add a 
check for it?

Regards,
Christian.

>
> Signed-off-by: Wen Zhiwei <wenzhiwei@kylinos.cn>
> ---
>   drivers/gpu/drm/radeon/radeon_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
> index bb53016f3138..d3d342041adf 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -951,7 +951,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
>   
>   		if (mem->mem_type == TTM_PL_TT) {
>   			bo_va->flags |= RADEON_VM_PAGE_SYSTEM;
> -			if (!(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
> +			if (bo_va->bo && !(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
>   				bo_va->flags |= RADEON_VM_PAGE_SNOOPED;
>   
>   		} else {

