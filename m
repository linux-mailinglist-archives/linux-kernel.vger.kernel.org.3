Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8B472F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhLMO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:27:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239179AbhLMO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:27:31 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBl9J1019704;
        Mon, 13 Dec 2021 14:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eprfUrIX5oqtvetymSjsS2cx7S+QJWmUO/Kdl33EBy8=;
 b=adnRRvsjaKwzuaoHGAjtBbWFQQXboZN3rcDd4Ur6Erzvi6JvTH1Ioi/M4pcrulYPLMkD
 ruEusw9/d299mj3T25Y1gfH/JalRGLpjwNwVphzjpUjG9tYoF7tIql6iYLt9YgV7S0ro
 kqnIp6CZTlQqW73UxUuHTROXUWwpCu2m5RRJe6QNpgh0bhP3v1a5U5yOlSFZ4lyBnx3K
 PJ4gE8jlNP5dAeNGrWkL3bJ+PVbJ+lCGMoOFu7adVhsjuJj7U+/hZX1K2wir+Cvwkjxo
 v+0ALJNXPPB9FRDSkL43RXRcV0n0cuz01wv2b0PU2cQM3wp6Abp1DHCsu6zbJD0yTkQg Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nf8t1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:26:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEPl5L105661;
        Mon, 13 Dec 2021 14:26:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3030.oracle.com with ESMTP id 3cvj1cbdub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0tWEXH/P+1EaY60b6YppJHBHEKJxDowRA9jfrgXngd1clqtHFoIq7ZQDtFZcT8JscMog+CIHUoGPx9JjCajo7+NnAtInSeE7gTcr6DIaKiWFKe8ByImMdevPLXfohsRx0kMVdtD9BPSrOOZ1nPCUUhHjf3zn2iTpVsIcrO0DhyHAhFxIliyQFD55TacX2Pqex8lsZcQUaTIe4LUclCtbhvT63qYDwL+yj+sky/SVfickGoOyTPSwbIfkHc0lYlSbQAXCeQ7CVrK7vHoWmE+tHeBT7/qCFoHmuNfmNUqACJ0b73dThhU6md+DeMQmVwM0NyBNgg9lhdLSL5hcU7AFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eprfUrIX5oqtvetymSjsS2cx7S+QJWmUO/Kdl33EBy8=;
 b=nRfAu7D+tP5gymxCEjtUlnEONHPLA9l2M5pWQ712RpiFEjIsWEKoctHkAk+qHl4C5hbA2fgmcVwjnEScCLlbusuJ2wmzTwWhPJtVlB+yvYsfKxc9hlzZbokIDKHiQLhwZ6ufMAHOE6MmbdTVpRDVMfuxZ95UhtgQtY8bPjQdEny6dJo/nSSDb9SCHuHodpon7+WtyWwSQkyNV1SjpFRPRwIJOEpNWL8CHFUQTCoDvCtI65XN6RrjpEKWTUuPVMhtZqfc5Af1AUe+gFvF9AL/mf83CLhrRNA5grTqCoMbdDs6jpRiSACXortSyWwHabF1QsQ0oNZssc+xbMdrIJ/Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eprfUrIX5oqtvetymSjsS2cx7S+QJWmUO/Kdl33EBy8=;
 b=nJaEVSh6/eHW3scVXGRbCtWI+14Buh8ldfEV2ZVXFWs2D8wPtUZ0sQ2rTqxC1kms5HMMqZCk7vtSQzF8H9PvPFxzAESD/EjdJokqM1L/91PVOtg6l59Mns/Nlq26Vk4jnAW2WrdXRId56s4eROtJOAxjv5oGusoP6NyC7Hfg03U=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1966.namprd10.prod.outlook.com (2603:10b6:300:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 14:26:44 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:26:44 +0000
Message-ID: <01cf00c1-0371-b896-9a76-78df036e2b02@oracle.com>
Date:   Mon, 13 Dec 2021 08:26:29 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 01/10] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
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
 <20211210065533.2023-2-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0186.eurprd07.prod.outlook.com
 (2603:10a6:6:42::16) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a0e1ec-e972-430d-fe6d-08d9be449641
X-MS-TrafficTypeDiagnostic: MWHPR10MB1966:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB19662E0C1B41FB2D46F3294FC7749@MWHPR10MB1966.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GS50XZ6xv6NP6VzvnFBjlDaP7PW9rTF9a2zDyL1FbmFdVJSt1/xBF0J794syOM/7+x8aX3VirEfmErEtuvTWEoq/3aBjaNaXD2KVFG7J/QfoGcr7sI0dsjYe5l6iUyPxf+Kid6AeXh91EsnlR0/WIVS1DBnTa0DVK3pRGy1R2XvvZP8Dn+V248bQFXTvEsE64eGO4u5r621bJs3zcNPa1uEgb/Facj9Qm83ZBqoRznsJnaTnlOnZgfKEjxxQG6mo55iB0gcc55EjOjik5oXwVewyN3NjOFLlPX50w6l67bRc9wzv0JzdDKcKjfF8GUe1r+vFeQYeJkj8+mI4MsytpJasJiWieLI30pQJvVVClIuHwSlfshEbWToMC2ET0hztVXWV2pV2g8wPJ0p5N3VRThZdA8G6qvgMWqNxcTQGIjYzg56mhCjANegYmLfkdztG7wCYbpFKEGzTx0bEQXMRz/97diD9DBA0hDFawR8fFePBRpwzCTlhWILC6A89GxolzpxckFqZsCG0nO/lpKjCQz8g2rbd2UUu+k1NAoJ68UEOCwxbiCUiNrIUaregfUgBhFLxHKsAkn00MFeAbvGbh0PV62ZfO/R/5joxDK0lx06AzRhcjjTz8HbAeb4cCn+QCyh9zTLitok9U5NFre9C3nOkXOSMspOwfUIjDzm3p2BqYEQbB6dcntd9REcv56hYo0M5oKNkd325L+0Em64erWfz9Z16u5CvDBtOjd+Xelo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(8676002)(86362001)(6506007)(9686003)(36756003)(53546011)(7416002)(83380400001)(8936002)(66476007)(66946007)(508600001)(6486002)(38100700002)(186003)(26005)(66556008)(4326008)(31686004)(316002)(54906003)(110136005)(5660300002)(2906002)(921005)(31696002)(6666004)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZJZFhGU1lDeDlLSG9nNGl6bVBCZXpiZzRnWUliRVliVnEwYzBCamQyWFo1?=
 =?utf-8?B?Rzc3TW1DV01XekYrQ29QUG5rWktVN1VGUTVQMDRKVDhod3lsV2Z4ajNjV1lr?=
 =?utf-8?B?R3NETlQxdmNselJuT3VCaHp6UUVGbnRTakZ4TWtueS9wZXhWSVU3MWthSHVj?=
 =?utf-8?B?aWI3Qnc1bEZNdHQ0MFUwamk2TzhnZHJ5NE03RHllTEJuQkdzNlVWWWt6WWJN?=
 =?utf-8?B?KzZKWHdQSmNtVDFNNE5obFhneTJMeEZLZkhVWWFmQ3dwSkhVQ1Mwdi96WnBj?=
 =?utf-8?B?cUs1Q1Y0SEE3TVdqSHd1bHF0elAyUmtlNmp0eExRZ04wamFiSEQwb0V2TGJI?=
 =?utf-8?B?ZUdtUWhzNm1QZ0RhaXVEOFNVTGJTcVlqRXl3OG5RdjJnV1c3SlFKdnpnV1lv?=
 =?utf-8?B?QkF4N3o1VjRjN1ZKaFdLWEdneTg1TTV2elZDWVFJWTE5OERXNDBPdC9pS242?=
 =?utf-8?B?SUZhamlycm95ODlITVNQcGVuT0IzeXpOZzc0ejI5RXFORCtZT3dnbTVhaWlI?=
 =?utf-8?B?UEE1QVNobEdWWnJvazFQc01SaFl4RzJCeTA1c3lxbXI5Yk1qUVdHSXhxS2pz?=
 =?utf-8?B?WjJNdmdwd0VTakduVG5RQW42dXI2azluK2NZNTBqQlk1OW5Fcm9YOU5rRkVU?=
 =?utf-8?B?OE53aXc3V3hISVRFZDI0L0lJTEN2M0c0N1owVXFBL3FzdnJEVFdCNE04RmJm?=
 =?utf-8?B?RjhoTm10dDVCdkIwOHhZWXE3YzlQdSswa2hRRS9GNVI4VzFHdHpaODZuMm90?=
 =?utf-8?B?WlBPY3ZNMGlIbzdGMk56V2Yyc1BIL2FFYkhtd3hQSlJLVndwMU5uSkI0dm5G?=
 =?utf-8?B?OFBURzRzOFdhNDRTU1lpeG9Oa1lLb24wY0hBd1AvcENYWGZZOXY5aVdBaFVB?=
 =?utf-8?B?VENxUEhueUFYNjFLRERHSVJHV2VZQUYvOWFCamtPckxMSTllenJodWJhQk8z?=
 =?utf-8?B?T24xOEZPQXhjS0JOdnZSdThFNDdHNWtQbWIzY29qT1lwUkNGejlJcDBMN3NG?=
 =?utf-8?B?cldSK3hlbmgwSkJFVzc0MENsU0RKNTE5VHg3WmFUWm8ycTFCQ2FNN1BhN05s?=
 =?utf-8?B?YkliWS8wUTV2NVhJcnQ2U2ZUNllFMFZGYXd0Y0J1UnBJUHo3T1dhajZ2ekVm?=
 =?utf-8?B?eEU2aUxhSUVrMjA4U0tuampnV3dFM1NCR21MM25TTzJJa2h6eVZwM3pVM1RR?=
 =?utf-8?B?cG5sVHE1Ykh4eXhIdFBQcWxOVmRpMXI1dlVDQWRCeFFaMFE5cXNlVWF6em5l?=
 =?utf-8?B?Y1lMR2J5ZnVFODRRQloyOWJzOXN4ZWw4bGxFY1UyZElrSWhRYm1OU2hGL0J4?=
 =?utf-8?B?empTeHUzdlJ2U0hoTXdzMHFteDhxUUpJOG9LRDl4OXRlbFp5ZTZnQmtmSnp4?=
 =?utf-8?B?L3lBWm9IeW5NbDZsZzlzZ3QzYllCaTliSmNLYk9RR0RJQVVlVEVvVUdaYlJG?=
 =?utf-8?B?YzIwZGhNbnYxdWlVNk9xVmR0WWludDZZVFcxM21od0pUUCtvSFNpVWxkbGht?=
 =?utf-8?B?ZkkxT05ySnp1M0dDZWF0cFRubEhYTGV0MnNSa3lIQlZKZEFUTXFFVmVyTVNt?=
 =?utf-8?B?SlVlZlByM1ZNbDROcHNiSkVBcGlHY3owRWV2ZlQ5ZSs2alBWUUtSZ2l3Z1RT?=
 =?utf-8?B?OTNvNFhNbUJzbU9OVGRjaEJSOTFtWkc1cnkxT014TnNHNTVTaXVpQ2doSUJ2?=
 =?utf-8?B?OGtTRzRlc1JhU2gzS1c1U3d1Q05oYUlsRVplckZHZm1ZN1JXclZSSUMveDFL?=
 =?utf-8?B?QnZGU0pZN0h5TFY0d2dJUnN4dTEvbzlTaksvZU5Kbm0zZDQzSjJtd1U1N3FL?=
 =?utf-8?B?TXpBYisyOUsvamgxcndBZXhrdExsYTlCNFBiQjhvaHdXK041M21SM1VLOWNP?=
 =?utf-8?B?NzA4YjlwYXMyVXNhRnh1T3pzaThSZGM0MlAybS9rVXhmaWtpenFvcHVMV0Zy?=
 =?utf-8?B?N3QwamJnM2hxZjRwczJXNDJnOXZ4bXNZbnR6Nk1vQ3k3VTQxS25KNm1iNzF3?=
 =?utf-8?B?SUpuTFBGSkdQZXBHRUtCRis3NjBSZXh2am0zK3A5a2dFVjVpcTZKa1ZjUGtG?=
 =?utf-8?B?dXdJL3hxWVFIZk9qazVDVGQrWlN1em4rVVkvemtqSDZxU2IvQk93RU9ld0RZ?=
 =?utf-8?B?elp4d0dNZ1dMT1IyMG9EcHlUdmJzUnNJU01KTjNnYU5kVCtTLzBhUGxaMkN3?=
 =?utf-8?B?OVU2QjVGQmF5VzZNZFdNdjNBMG02aEo0c3JGV1VVRkJzM3UvTDgreTFlTVFl?=
 =?utf-8?Q?IB6iwfy4ZI3ynw60AXGcxda/ubbsLoLCOkKEKo1qr8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0e1ec-e972-430d-fe6d-08d9be449641
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:26:43.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +95Db6ydzt6hrVsN9qXRlNJeH/LxWrxQijxqL7BNUpaP6guh6VzWZgPziZZmfKHPT1c36Y2Pv9zVKil/clJxD6zcuH3x5UASRJqcxnkc03w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1966
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: Il_pMC_39Pmcc-HAamw6bIVPQMYrzauo
X-Proofpoint-GUID: Il_pMC_39Pmcc-HAamw6bIVPQMYrzauo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Move CRASH_ALIGN to header asm/kexec.h for later use.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
 >
  Acked-by: John Donnelly <john.p.donnelly@oracle.com>


> ---
>   arch/x86/include/asm/kexec.h | 3 +++
>   arch/x86/kernel/setup.c      | 3 ---
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 11b7c06e2828c30..3a22e65262aa70b 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -18,6 +18,9 @@
>   
>   # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>   
> +/* 16M alignment for crash kernel regions */
> +#define CRASH_ALIGN		SZ_16M
> +
>   #ifndef __ASSEMBLY__
>   
>   #include <linux/string.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71b05..5cc60996eac56d6 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -392,9 +392,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   
>   #ifdef CONFIG_KEXEC_CORE
>   
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
>   /*
>    * Keep the crash kernel below this limit.
>    *

