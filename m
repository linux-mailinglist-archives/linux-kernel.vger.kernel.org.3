Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7D472F63
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhLMOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:33:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34568 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235640AbhLMOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:33:46 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDD0KrY018029;
        Mon, 13 Dec 2021 14:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=asiZycGdTEiucwIODVhi1g3xkaElli5RpqxU0lQzme8=;
 b=PnyIQutwqYMfbwUBWuiiLzl20uD0DBPItPJbGKNlBY/camEn+AaMboyV3ieIzwS683Sx
 RBKFHeqaIZ1WYyxgQ8HdwmQFzwCVTxHa6UxmPwYofV2DHr0zKrNa5y1AgWrsHsQHZeiR
 5eWxoIljRcAKTy59YATGZ3oDelRklm14oGZ7SsztVzoLfV77eB1/AkP6MTJHCsnTXIuV
 AnBxXFaQL/KhmaDRu2+RApEQ8//Y21hUe3mF62thZddZOrwrAnqMrKOVqr1G1W9Gcf3z
 O7KaCEKmhs16bMbHZWukE6h2vbjrNO4RWcaTOCzUvgfshKj+ryKAjphh/s8RzZ+4yyB6 ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrrp5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:33:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEP1qr085814;
        Mon, 13 Dec 2021 14:33:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 3cvnen5bd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:33:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqqDkaO0aZSDF+QMoNlfJDmjO9Xf4sIUmKwtqs9J86i0RaJiTcDffIXS2XUlwgklkYnsDIwLIHKsu6ICKkb6/i+U7CwYL5JlxWRt1LfjtvRzV617m28C6Gb5cPx5l5ExhJ/DKFLYag6z/wkhAPgYZHIBWkhhpby4fHnzKafu8t8F6UYKrbDFHp5Ersiuh+AhsIMrHULIO/z0VWYHEwi0ej13KdvhUdsZtxBfw6M1qjFP65XVAK2TixWGLiXKgxRhYod5ZKjqUPkSH5OIzAVFnV1oGJuKHV+6v6agpOFOHS9Vr23UhYFry6MwfQkC6QwbBeH8/bUb5yyYN9NKAQ2GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asiZycGdTEiucwIODVhi1g3xkaElli5RpqxU0lQzme8=;
 b=EnHntnpXiZaxy/2/PCQMQ+8LwvfejzG2i9flRkK3yfqxOzGHW/eP0q4Fu182QoTxLH8Wb0J34gljaVuhUlEf1OQArvLB3fBwVCXv5BJdTH+B6Gqv0zR0s5gczJe659JOT5Y7rTbWS0Rpd56J2bjwIGGKRUVctfrE4hjElZcXriQKhoqFncq9RW4uSO7MJqsek0HzvMGRwKbNMs1JurlzM3SPheqvQJjaqrH596EK1LzIY27u9wurMt7KyU83W7qxbDSjQT+k2RMKbj9i0iT3iCO0HmTlaHkSCrDVRu414PjKSS/IGUPoYRISQBMWP+ZKimhyxXREl6vCacZdHYlnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asiZycGdTEiucwIODVhi1g3xkaElli5RpqxU0lQzme8=;
 b=B5HLktG/RiuhXXHaaSQknPyD70tW6tnFV6tElke/S7rXHgY6Elof0MFCkOy/jSPtxhXpwaNO8MEslfii41xZNzcvMieYKylyk2CnzIuHeu6XYbm8GDIB9i+Hi9yonSuKfFkmE6dsSKD/HnUrtWvq/iAumbqZ2CN6JKVxR9TJXPk=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1629.namprd10.prod.outlook.com (2603:10b6:301:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:33:14 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:33:14 +0000
Message-ID: <7d2bd373-37e4-2690-8b2d-e931f5036317@oracle.com>
Date:   Mon, 13 Dec 2021 08:33:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 09/10] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-10-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-10-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95eeaaf-5317-437a-07d4-08d9be457ee1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1629:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB162900AC683F2D75CC5943B1C7749@MWHPR10MB1629.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/GyC3+kxdP/QGx99D8I+xOwRQYY5zDDqXW2aMcX7Xu/0oPwY/g7FpXtIYG8EN4vKqdVEjv+tALtLqUvytHCNOfU+hMGgWiUcdj92BFbvPqoze34bOirYn8ncxrzUC4o5wisz7D2ohmXd2QWSYKxYdVikAxN91HF5iUfp3bvCjHtMGRS1wQSaLT8HEGYsfA2Fmc2ycRzV5pSTzbB1UtpyiTXhdUfzk1q9I26636wGik9AgwOoxXo7s3QP1NG4Kz48sJHDIiPasKRxT86cq173v9zt6cr9XNmxuCHI2yzNwIA7OWUpl51LtgLM8wxs7cRW8krMYScoNnAMUdKJh1hcQ+IpsXJkoKo5J0y3YoWIPbQ37DxgKra5mJI1HUGhvJntfVOFzFfBfO2gUekb08xS29HSzzo/dNm2f1BJyTS1TMowM4/uPVUw4axl0O3cOpqpdEpl8PmrsoPzoSxDE8b9C8/WBiYiKvQuYwXqMlvivrMskXeTu0WB0EzsxcJe0La4Q/sYN4jUlszxYuy4RRBpJBz3AbaRk//QaHdXLKjsKSZOadDt3hy/a+dvK+b5QBmD2gb9lmi0EuNNsVs/Pr2rg/bywvy+x+tUGbzmRawiKgDYbuvWjZ57Og0ympQjm/ZDkmJGiVBi5WkmLVfMsXWerZFDbdYr7CUHmQRzhm4vNgnx004CqD5ScX8ceJoadBmUGc6eRaK/GgqmR4YBONbjIuGaLfhHOHA1u/wnjaJHvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(66556008)(66476007)(66946007)(6506007)(53546011)(31696002)(921005)(5660300002)(4326008)(38100700002)(7416002)(6486002)(9686003)(6512007)(2616005)(31686004)(508600001)(26005)(83380400001)(86362001)(186003)(110136005)(54906003)(36756003)(2906002)(6666004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUltN1VINitrNkErYnl5ZndTSzlVL0paRXE4ZWxCeWh0eUFPMkNKN1pvU0pY?=
 =?utf-8?B?TGJDcWc1RGhHcTVLTDJaTjA5Z3pJVzU3elFPZU1HU0U3cFdHeDUrbnlRcEpp?=
 =?utf-8?B?MGVxK0NLaElkcy9hdm0xY09KR3FhMWNzbVJWM09kVXVJMHBKaVUrYitaRHN3?=
 =?utf-8?B?MVNBcVBvTlNrcmY5aStQanMreDlDSmN2L2w0QUlpZ0J4dWViMzVtNDEzd2xE?=
 =?utf-8?B?dnhyUklVc2lOZzZMUzFqUGxla1NMUDM1dmNRNG1nMm5QNXR3S1NmalRNNm56?=
 =?utf-8?B?ZDA5TFlPMlFEMmh6UDIxb29NNE5UMm1NR3BoK0YyQWZOd044d1VzZ1RsZEti?=
 =?utf-8?B?QWthZzRTNTZRbnlwajc3aGh2MG9zQkgxUDBDRHJlangwNWI5M1UvcXRxUStk?=
 =?utf-8?B?NDVkUnBxNXkvQmdDRFI3dWRrNzFlbWNFV1pkUDBSQjhJZm12YnVVQ2pLYkRI?=
 =?utf-8?B?bWFQTmxQQmUrNjRtQnhNR2lEazZlejZmaCsxUWs4Mm5PV3k5bmQzQ21vbi9z?=
 =?utf-8?B?bDNhM0tvYVBCSVo0TTlZOUNGVXp1Q1RhNDhaUVRneXRqMGdBdlIxbE11VXFF?=
 =?utf-8?B?b1RSbUpzS0F0bUFqcGhsNWxtaWE0azBoWGRyRTIrZGdNc0Rua1BjY2FRcm90?=
 =?utf-8?B?Qy85eGl1Z3JZcFNQYWlndmY1UVY5WEdoSzVNZmRJUDNmdksxVWZMbnBZOTFI?=
 =?utf-8?B?VS9Ga21RVmlHOVJuNXVpbXJ0K0t4U2VuS0U5WGE0QXVTVU5PdkJVQkZ1Z2Fl?=
 =?utf-8?B?M3k5bW0wNmNyNEoyMzUyM3JkNkczSk1NMGpsZVV3MHIvK2xseHB6bnRvYVVH?=
 =?utf-8?B?MWZ5VnZINDZIUEFSNVJpb3ByYVc0SWVZQ1BQN2RMTDcxZEtmd3FlZzYwazky?=
 =?utf-8?B?ZkJqSStSNW54cWtPL0dSUUdYVi84bVphUnAwbUdYaDNhK2V2VkJVWVBPdzNM?=
 =?utf-8?B?aHlZUmE2Q3gyR3BoNFhhbk8vZ3lySnhYcHk1d01wWW9GQjJtNTdscWhKYTRk?=
 =?utf-8?B?L1ljeDBPSE5pajdTT0V2NGdsY3l5UEVEajNiVzZqZmcxRHVyZlhKN2Y5bFY1?=
 =?utf-8?B?VTExZzREVG05eWpURnV4YzFYQ2NBVFY5dnRPbEJYd081czluMXN3MVY5RTFH?=
 =?utf-8?B?U2FaK3V0OWc3R2psOGYyN25GOGd4UlcwbUZVbThhZmJqOTBQd2sxNkNXSHp5?=
 =?utf-8?B?aXo0RGpWNEI0LzdMU1ZwWSsxVTgrejQ5SjVGQ3A5MUJkUFYxbTJyTGlmakFZ?=
 =?utf-8?B?WVQwakIyNGJMaldNblh5c0FnQWQzeVlyUmMzYi9HNXBuTjdwMFg5WDVxWWg1?=
 =?utf-8?B?OWNrVjdBRkw0M3h5dkdYZ1gycjdhMnR3RnEydWN3WGNFczROZTBaeHRwMlVX?=
 =?utf-8?B?bTBVUUs1bEZhK2Y1RE84T2ZoTXJTN0k3c2ppQkdKaHNiemNham9LTjhaOU9s?=
 =?utf-8?B?b0JKcmc1aldBOWlyL0JRNE9VbW1uZVlkVTloQXZieTlOZzBZbDZsMllSNmFr?=
 =?utf-8?B?YWNvU0pGQlo5cldKR3l6bkR2SHM1Z1YxT1NNaGY0SW5BeUFyMGJ2Z2ZyNnY4?=
 =?utf-8?B?YUErR1FMaG9lcEZNQWFxMndwd3ZMY3Vld2U2V2hnM1NuQ0RWcWkwckk1V3B4?=
 =?utf-8?B?ZWdUOW42TnNtb1pSSndPNHVPeDV0RXJFM0ZCZHp2amFKVWJmU2VTQ2E3RHlX?=
 =?utf-8?B?aVJxZkdFVFBxMUZPTUkzRllnMHZ5dEFxYUFrU1dHdmdSNUxlS1R5Ky8ySnFo?=
 =?utf-8?B?MmI4N2t1QWJ2MHBQU0FJaUk3TTVHVkN2U2lsMGVrRkg0eGdRWjdzSVh2Q0c1?=
 =?utf-8?B?eG5ydEVvQnE5NWVvckF3MW1jbnJ0T0RtZDk5cDdFWlpWeGZIbDc1OGU0WXgy?=
 =?utf-8?B?c29ISlVhL0s5U1FLa0djM3V0RXJYbVVCempmM2lyb1RQbmdlQnZIYnI1anVk?=
 =?utf-8?B?UmJXUzRhZmlSTTJ2bHJkL2lucFRiUkRKaXQzTk1QMVRWNmpUczcvWVJqczlL?=
 =?utf-8?B?Z3NVLytzcExwakZNc2pQOC9OSndHZ3JZanVpQlNmZHllQ2ErMTByc1I3WlJE?=
 =?utf-8?B?SmovMmdSZVRnUklNWHZ3Wk1JNlpSSXM3elJHUFU5RVR5aTY1R0NKdzRKeEJS?=
 =?utf-8?B?U1ZwdjQ2QzdKYmxpUmVMUzFEOUJ6TUwyWUMrOFVjZVZJbEI2cjBBMDM1MWlD?=
 =?utf-8?B?Mm1NZ1JYYTVCVmlCbzc5dW13TXlITHJlbVZOaXlKbU1WaWRkQzJjVmFxMzBk?=
 =?utf-8?Q?t7acb06mFpj8ZoqDiiQdd7+tDkYOJ8XcGiTa/b87ik=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95eeaaf-5317-437a-07d4-08d9be457ee1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:33:14.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yus8MOCDQ0+1vr/OFz+JnXwMsqkGRC1xYgUw5XPZHjc067LKHqzvlYhDDIXJlQfBGhIgWvgnXNCzZCeFdJV71bv0Nm7IpxVAE6YZ5+mhmao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1629
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: uZx_h6sI99DNnYo-XVWIGHwNxUCfZ7bp
X-Proofpoint-GUID: uZx_h6sI99DNnYo-XVWIGHwNxUCfZ7bp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>          linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 37b477a51175359..f7b72fa773250ad 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -967,6 +967,15 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   
>   static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
> +/*
> + * The main usage of linux,usable-memory-range is for crash dump kernel.
> + * Originally, the number of usable-memory regions is one. Now there may
> + * be two regions, low region and high region.
> + * To make compatibility with existing user-space and older kdump, the low
> + * region is always the last range of linux,usable-memory-range if exist.
> + */
> +#define MAX_USABLE_RANGES		2
> +
>   /**
>    * early_init_dt_check_for_usable_mem_range - Decode usable memory range
>    * location from flat tree
> @@ -974,10 +983,9 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>    */
>   static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   {
> -	const __be32 *prop;
> -	int len;
> -	phys_addr_t cap_mem_addr;
> -	phys_addr_t cap_mem_size;
> +	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
> +	const __be32 *prop, *endp;
> +	int len, i;
>   
>   	if ((long)node < 0)
>   		return;
> @@ -985,16 +993,21 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
>   	pr_debug("Looking for usable-memory-range property... ");
>   
>   	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
> -	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
>   		return;
>   
> -	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> -	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +	endp = prop + (len / sizeof(__be32));
> +	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
> +		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
>   
> -	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
> -		 &cap_mem_size);
> +		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
> +			 i, &rgn[i].base, &rgn[i].size);
> +	}
>   
> -	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
> +	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
> +	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
> +		memblock_add(rgn[i].base, rgn[i].size);
>   }
>   
>   #ifdef CONFIG_SERIAL_EARLYCON

