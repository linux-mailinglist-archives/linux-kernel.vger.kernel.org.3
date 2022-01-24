Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B3498836
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiAXSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:22:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12888 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232267AbiAXSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:22:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20OIGBVI001281;
        Mon, 24 Jan 2022 18:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O7Y4ArdtyhfZG00+Bf0MZKHzJAB59Vkxr+B4zbfI7tw=;
 b=YtXiEjiYDng/gHwa1weYOzitf/kfrQQFWRIpzsxnNr5m1jL6ZHZzM/lyfJsS2jRYKifg
 534wpRrfFXWQJu/ytwY+j/ZerPHSW54BI0nOlG0Py45B5B195wxvcKrNRY/o9h3u9GZu
 fUPvn1XLkuueIzq6kxidUcskqsPEcY0aQnDAPDNmjYM1AblJQb9roDH3Y9uWu1fGJADj
 R4b0Uz9fFTxCO+2Mcn0VlBhR4N2in40A0+56Axi/IGx3k6pVCmcaRiOUiwMJ8F+iG/xk
 XUb2rAlhaw8dxho9SoByuZq44X3x+rgaguWZMtvE8XF+22TrQVBx0PnTHSJH0xe1eyow FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s0gjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:21:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OIGNdK145181;
        Mon, 24 Jan 2022 18:21:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 3drbcm2vgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 18:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl90GdUyTK7EWQoXi535Ca+W2uIR5IbnWQnn6iTdhz4MFbrvgXMzPNoYLmTvTHFosNsWgtogPfDkIpiX+YOg3ZYKECJRmCg1TctSY25yeTVrrtzK16RFACvoWEmp6FylS2bAdwf3igv3/EiY/OxMILh+yAo3nxOJQkbokZpYH6iomhsOYu6wVVCB01zH72l6vgNYG259qDVGdjP3QhfgdyJr6CWkojOL3TK4D8MiTd26ENa4WOz7DrZ+cdNdolRwgUDYMBT1RuUBqW+DsGD8e0Xwn2NsAghByQNWFtS7iQ1SH1Uri0gWBckUuRZfKLLTFWWfkWOjbhiHkOWNbAuOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Y4ArdtyhfZG00+Bf0MZKHzJAB59Vkxr+B4zbfI7tw=;
 b=YPZm3NRmi2On63N/fcaB635sLtGReHjaZHahJuPzKjKlKaFEGQLlAxkiWGtKVG8bAWiCtFv5YE4ds5CHF1LaruQmiLfRtlZwhRzWLflrxpmIjN2y0cTMu8618A7TbR+mmGZgUhNYH+w5NuRWhO2DpMMhywI79VkM98gsCPXNFyyIc29Me3BYjq0Co6f8UoA36EWcBYjzBtTeDRnnmimLAGvbE73a8leNXIrcFooQTe3WnEHo09f4PY1o+IkppPbIy7L7WZB4ZTkk/lgExgcG0vV76KaJPkqPaA2bHRNWKrh/EYsxV8IlV/8nGfnXWiFNBxC9a/lB8cleFVtk7tUuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Y4ArdtyhfZG00+Bf0MZKHzJAB59Vkxr+B4zbfI7tw=;
 b=Ndeo7PsZuG3CvfBj/4hPOA2pCZxwxK5AIL2/JtJQqqpsrczwmmG7gw6C19jCDo+m5pzP9faJEtBt84KTi8c/sK333TvOeP/k9s9oAZP48Kt/LpdfoJwHRdibZ2tzYqwit9h+3LgMkfqPxzla92g6Ej8DxPoT+OjOjzG79RrdwFA=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 18:21:42 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 18:21:42 +0000
Message-ID: <c0fd765c-0d33-00be-d61c-c53a6a337f0e@oracle.com>
Date:   Mon, 24 Jan 2022 11:21:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC V1 06/31] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-7-git-send-email-anshuman.khandual@arm.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <1643029028-12710-7-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR22CA0074.namprd22.prod.outlook.com
 (2603:10b6:903:ad::12) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e128df0-491f-4f82-490c-08d9df665f18
X-MS-TrafficTypeDiagnostic: SN4PR10MB5624:EE_
X-Microsoft-Antispam-PRVS: <SN4PR10MB5624417CE9C76828229FD683865E9@SN4PR10MB5624.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KI/A4h015rR5JmXTiIIsXQQNutbS/PNTGfXVDH+4ExdewHRhiwWAZW0OMDT3VodpZWZFRzd9E4FZ8B1wsOcRs8aQjgdOyMlRdDqB5EPhg6FqB7sOUECiMdvfWUY1ulnRJ7pIZdIFI3yux+PrFvxMgFQHdVEH3K9Qs2HGY3WZKE+L66jXiyDKIZq8QI9R3m6S+WVCwmJi2lokZHW18aKsrki9LkAnUc/EzkbpCdogI/J1E54buXxwXiNEaPUrP106rC3F87GbGQLlNtTFvSVgtixggfZxWqEfgM9x2Z5zWeRxejgrnnNXYVPy2i/sx/t+By6Qa6pDIw00r9g+kPo5t/nRTpdrPsb5tTjWHvzMempedznth4mIYkG1wq79l08pAE0poZB2vBl5OnHNydK7tMDLkmmUJoK09UrWQ7rdjfkSyV/InpmwuVkw27khH10X6ZhASEavOoeIVW35Lkem/VouA47iCs+Bp9zm9yDUcefY1XshZDjeRlLtqZhLaEOrH0WkfcanFKSsKUh7S8OA0ZPgQHOOgY5SCdCb0VGxeoMi2ulJHcgAQzgZbN4Oe72mbYhU4oi3sp+4jiaav0Qvh5FA6xR4B5V049vBTlCsU3aI+HsYrfrq0gIHQxF+y79rcnFPp+n23qyIlX22v/8KAaVCeVYm2BoIZviorIQ4Rbo7/PLqyn/xxvAgxuDeA8Ps3svHy1Jop/gmmCru9DRKLexp8Rfug21AJ29Rn2qdIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(4326008)(6486002)(6666004)(36756003)(508600001)(38100700002)(31696002)(31686004)(6512007)(53546011)(186003)(86362001)(44832011)(6506007)(2616005)(66476007)(2906002)(83380400001)(8936002)(66556008)(5660300002)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJOb1ZOWVVZNXcwK2ZjeDBtYXVjQUUybVBITzV1TEx5M3ozUHZ6M2dGSVRW?=
 =?utf-8?B?dHdaYkVBc3diNDB0b3F0SnRsaFZCd3ZqNUFnRXhyVHdoano3VjlPMllINjd2?=
 =?utf-8?B?S3Uxdmg4V21XSEVUMzRjNENWcWdiSmt2cThWSWJtODdEYmlENXk3R3RjVVlk?=
 =?utf-8?B?Z0N5aVNUbncwSTVjRXQzelZQVmlyczVQT0NycGt6aGJkejhicFg1Um8xRFdx?=
 =?utf-8?B?QTQ4dGM2YzQ5UXV4U283NXBjVk0zcFp5L3M4eEdmbU1kVFo2bU1yay9nbitP?=
 =?utf-8?B?NGkvblcxNGd1RXViL3VvOUxtK05rQjhySUlFYzE5RXZBbVB6ck4vWk1ubSsw?=
 =?utf-8?B?bkM4QXdGaUxyU2xZQXF0dWl1eDFUMlJqam44bjMzcmp2Q25yQUpTUUl2WG50?=
 =?utf-8?B?LzhLWVhiYnJCUkdXUVBlY0pLYll1SU8xOXU3SGhuZWl6Z21PNFNwRmpQTlM2?=
 =?utf-8?B?WFFJVDE3eG1lNWF4RXRlcUNuOTlVZnlHaGZTc0NmSG9aR2VIK09XQ0MzeTV1?=
 =?utf-8?B?cEdreUNDb1pHY3NyK01qYm42aHlLWVVVQWtvL3VMVzIveUJpNk1MbE1aYk9r?=
 =?utf-8?B?NU9KVHBSR3ErWW5oQkMwcFhZbUxXMEdXVUhNMm9IR0hnQnliN2JNY1FKaVcy?=
 =?utf-8?B?NkovM3dGN2RwMi9NNUNSRzg1TU9hRkNwaUJNd0crY05tVU5hdEFOUFd4c0xw?=
 =?utf-8?B?ZjlHZ0sxa0UyN25kN1d1Y2RTWmRJZ3BISVIxQWZRTmdBQ28zZjNJTCs2MDdZ?=
 =?utf-8?B?cm9RYWREZW16T2JzV1UyNkJyNE1ocTliMERMQzc4b3EzMTFPY0tGWUhUc1ZH?=
 =?utf-8?B?Y2NySU96emV6RmhGMS9EQ0ZTZmI4d3NnakpGTUhjMklBZkw5V1FEOWZzUHV0?=
 =?utf-8?B?YUcwckRJeWUxNVNGWTl3VVZNUnNTOXZWWXgvWkpvd0pTMXNmY2p4UVdwNTlC?=
 =?utf-8?B?ZE1WWjhMT0ZPUmhVTi9kZXFueFdXRmx2SklyTVhrTG1NSnZxQWR4SmJra1FN?=
 =?utf-8?B?Ym5wMjAvNEFRS2NndHh5MlVNUGk0ajNPUkNzNXc3akVyMnFTcmJISnVTQUJt?=
 =?utf-8?B?Um83bHczVWVCTlk0WGZneWpyQW5Jc0F2dGZyQVhuQmRKbVNUbTlZSlRocFdk?=
 =?utf-8?B?QkFqMVYrMEVnc29HdVB1Vm1UaW15QllSWDhnTHByMXZ3dlR0K2RGZjJlOXpa?=
 =?utf-8?B?VThCWUlYZmhFbXM4SExWZm5HVE9hd2pxcjVFSG5PYnN3RmRsUG1nVlQwTTNj?=
 =?utf-8?B?TEtDNE4ydGdFNmZnMnM2anJJTlhGc0VsL3oyY0RKN0hOa2t4Nnk2eU9rS3FG?=
 =?utf-8?B?UWtna1l0VHpoeUtCd0ZFM0tkTWcwaUtKTHg1VStjYkk1elYremFBYkRUWm9l?=
 =?utf-8?B?TFBOdFh6K1NCdW5QK2IrUHJRMERGQzdJTlhtdms1dmpHYzZKT24xVFN5Z090?=
 =?utf-8?B?NVQ4cW9rUFZ2Y3dBazRPczIxa2Y5Q1RDQThneldsSkI0UnY3QUFMVFU3MHpM?=
 =?utf-8?B?YXphSTZjVmlMZE9NbnRnU3FVT3FXdjlxVGNGZkNXR25xSEMwRlFyZDFwcTI2?=
 =?utf-8?B?cmt1a0dZM0UrOStqYWNJSWhPT21SM0dpQTcyeWFtNkpEQ09LMzBEWnVzdkJl?=
 =?utf-8?B?K3ZWN29pQkQ1eFdMWXZxRzlxVmlkbVNGOVZTSU4yRG8veFREWjZqRUh6Rm9G?=
 =?utf-8?B?Ymk2aW14ZHlrUjE1UERvSjcrdUl0d2JXZGpUc2FLb1B3M1pJNEFSWllSaHlq?=
 =?utf-8?B?SnNSUE9tT2VQMitwdTZFQStzRmpVdTk3UjdiVXlUcldtRlA0c21GMVlsM1Zk?=
 =?utf-8?B?NHRoeDJMejFjTnY5eCtCUkU3N211eG12QkVoS1REVTVOYzRWN05pV3YxQm1u?=
 =?utf-8?B?U1ZtNStvOUlma0JwNjU5UzRSTGhtYzR2dmhkY053UWRCVm1vKzFYWmxIOGVv?=
 =?utf-8?B?MmpJSVFlRHpObzZRMDQySWdHbWQrNlA3V1Yrc3BQdTNVYU9aVEd3ekZKSGVE?=
 =?utf-8?B?Z1dtdmtHUXp2T2xOMlQydmlDVVpiSEFweTRkeUx1b24wcVlpR3lPdTdVN0Jz?=
 =?utf-8?B?Y0pMS2lqWlBhTGNla05WdlAyaFFxVjBmL3k3bGRvajRKMUxHU0UxWGZ0U05w?=
 =?utf-8?B?NGd4bS9iaGZrQUJSNCtzOEVrKzdTZktzcUg4enhtNVZmVmtDQTd1RTh0cUlH?=
 =?utf-8?Q?JVrP8VZ0cKQ9cXf+YkKt3eVK+96NGD5VEV2kqqMwvnS3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e128df0-491f-4f82-490c-08d9df665f18
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 18:21:42.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hplYlEVxOpsXqdeU7qjkgUIroFDB+m7jksgYkYZ1i1etw6HBm41WF1Gecmdx5AMP9Qr152lWxSkgnNN4rbOYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240121
X-Proofpoint-GUID: I8gMgLguemIrcRXUvgyihWDHuI-4FI7T
X-Proofpoint-ORIG-GUID: I8gMgLguemIrcRXUvgyihWDHuI-4FI7T
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 05:56, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---


Look like reasonable changes to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>

>   arch/sparc/Kconfig                  |  2 +
>   arch/sparc/include/asm/mman.h       |  1 -
>   arch/sparc/include/asm/pgtable_32.h | 19 --------
>   arch/sparc/include/asm/pgtable_64.h | 19 --------
>   arch/sparc/mm/init_32.c             | 41 +++++++++++++++++
>   arch/sparc/mm/init_64.c             | 71 +++++++++++++++++++++--------
>   6 files changed, 95 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 1cab1b284f1a..ff29156f2380 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -59,6 +59,7 @@ config SPARC32
>   	select HAVE_UID16
>   	select OLD_SIGACTION
>   	select ZONE_DMA
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>   
>   config SPARC64
>   	def_bool 64BIT
> @@ -84,6 +85,7 @@ config SPARC64
>   	select PERF_USE_VMALLOC
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select HAVE_C_RECORDMCOUNT
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select ARCH_SUPPORTS_ATOMIC_RMW
>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
> index 274217e7ed70..874d21483202 100644
> --- a/arch/sparc/include/asm/mman.h
> +++ b/arch/sparc/include/asm/mman.h
> @@ -46,7 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
>   	}
>   }
>   
> -#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
>   static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>   {
>   	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index ffccfe3b22ed..060a435f96d6 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -64,25 +64,6 @@ void paging_init(void);
>   
>   extern unsigned long ptr_in_current_pgd;
>   
> -/*         xwr */
> -#define __P000  PAGE_NONE
> -#define __P001  PAGE_READONLY
> -#define __P010  PAGE_COPY
> -#define __P011  PAGE_COPY
> -#define __P100  PAGE_READONLY
> -#define __P101  PAGE_READONLY
> -#define __P110  PAGE_COPY
> -#define __P111  PAGE_COPY
> -
> -#define __S000	PAGE_NONE
> -#define __S001	PAGE_READONLY
> -#define __S010	PAGE_SHARED
> -#define __S011	PAGE_SHARED
> -#define __S100	PAGE_READONLY
> -#define __S101	PAGE_READONLY
> -#define __S110	PAGE_SHARED
> -#define __S111	PAGE_SHARED
> -
>   /* First physical page can be anywhere, the following is needed so that
>    * va-->pa and vice versa conversions work properly without performance
>    * hit for all __pa()/__va() operations.
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 4679e45c8348..a779418ceba9 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -187,25 +187,6 @@ bool kern_addr_valid(unsigned long addr);
>   #define _PAGE_SZHUGE_4U	_PAGE_SZ4MB_4U
>   #define _PAGE_SZHUGE_4V	_PAGE_SZ4MB_4V
>   
> -/* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
> -#define __P000	__pgprot(0)
> -#define __P001	__pgprot(0)
> -#define __P010	__pgprot(0)
> -#define __P011	__pgprot(0)
> -#define __P100	__pgprot(0)
> -#define __P101	__pgprot(0)
> -#define __P110	__pgprot(0)
> -#define __P111	__pgprot(0)
> -
> -#define __S000	__pgprot(0)
> -#define __S001	__pgprot(0)
> -#define __S010	__pgprot(0)
> -#define __S011	__pgprot(0)
> -#define __S100	__pgprot(0)
> -#define __S101	__pgprot(0)
> -#define __S110	__pgprot(0)
> -#define __S111	__pgprot(0)
> -
>   #ifndef __ASSEMBLY__
>   
>   pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 1e9f577f084d..efb3d6e6d7f6 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -302,3 +302,44 @@ void sparc_flush_page_to_ram(struct page *page)
>   		__flush_page_to_ram(vaddr);
>   }
>   EXPORT_SYMBOL(sparc_flush_page_to_ram);
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return PAGE_NONE;
> +	case VM_READ:
> +		return PAGE_READONLY;
> +	case VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_READ | VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_EXEC | VM_READ:
> +		return PAGE_READONLY;
> +	case VM_EXEC | VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_COPY;
> +	case VM_SHARED:
> +		return PAGE_NONE;
> +	case VM_SHARED | VM_READ:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_EXEC:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return PAGE_READONLY;
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return PAGE_SHARED;
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return PAGE_SHARED;
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 1b23639e2fcd..46b5366f7f69 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -50,6 +50,7 @@
>   #include <asm/cpudata.h>
>   #include <asm/setup.h>
>   #include <asm/irq.h>
> +#include <asm/mman.h>
>   
>   #include "init_64.h"
>   
> @@ -2641,29 +2642,13 @@ static void prot_init_common(unsigned long page_none,
>   {
>   	PAGE_COPY = __pgprot(page_copy);
>   	PAGE_SHARED = __pgprot(page_shared);
> -
> -	protection_map[0x0] = __pgprot(page_none);
> -	protection_map[0x1] = __pgprot(page_readonly & ~page_exec_bit);
> -	protection_map[0x2] = __pgprot(page_copy & ~page_exec_bit);
> -	protection_map[0x3] = __pgprot(page_copy & ~page_exec_bit);
> -	protection_map[0x4] = __pgprot(page_readonly);
> -	protection_map[0x5] = __pgprot(page_readonly);
> -	protection_map[0x6] = __pgprot(page_copy);
> -	protection_map[0x7] = __pgprot(page_copy);
> -	protection_map[0x8] = __pgprot(page_none);
> -	protection_map[0x9] = __pgprot(page_readonly & ~page_exec_bit);
> -	protection_map[0xa] = __pgprot(page_shared & ~page_exec_bit);
> -	protection_map[0xb] = __pgprot(page_shared & ~page_exec_bit);
> -	protection_map[0xc] = __pgprot(page_readonly);
> -	protection_map[0xd] = __pgprot(page_readonly);
> -	protection_map[0xe] = __pgprot(page_shared);
> -	protection_map[0xf] = __pgprot(page_shared);
>   }
>   
> +static unsigned long page_none, page_shared, page_copy, page_readonly;
> +static unsigned long page_exec_bit;
> +
>   static void __init sun4u_pgprot_init(void)
>   {
> -	unsigned long page_none, page_shared, page_copy, page_readonly;
> -	unsigned long page_exec_bit;
>   	int i;
>   
>   	PAGE_KERNEL = __pgprot (_PAGE_PRESENT_4U | _PAGE_VALID |
> @@ -3183,3 +3168,51 @@ void copy_highpage(struct page *to, struct page *from)
>   	}
>   }
>   EXPORT_SYMBOL(copy_highpage);
> +
> +static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return __pgprot(page_none);
> +	case VM_READ:
> +		return __pgprot(page_readonly & ~page_exec_bit);
> +	case VM_WRITE:
> +		return __pgprot(page_copy & ~page_exec_bit);
> +	case VM_READ | VM_WRITE:
> +		return __pgprot(page_copy & ~page_exec_bit);
> +	case VM_EXEC:
> +		return __pgprot(page_readonly);
> +	case VM_EXEC | VM_READ:
> +		return __pgprot(page_readonly);
> +	case VM_EXEC | VM_WRITE:
> +		return __pgprot(page_copy);
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return __pgprot(page_copy);
> +	case VM_SHARED:
> +		return __pgprot(page_none);
> +	case VM_SHARED | VM_READ:
> +		return __pgprot(page_readonly & ~page_exec_bit);
> +	case VM_SHARED | VM_WRITE:
> +		return __pgprot(page_shared & ~page_exec_bit);
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return __pgprot(page_shared & ~page_exec_bit);
> +	case VM_SHARED | VM_EXEC:
> +		return __pgprot(page_readonly);
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return __pgprot(page_readonly);
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return __pgprot(page_shared);
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return __pgprot(page_shared);
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
> +	       pgprot_val(sparc_vm_get_page_prot(vm_flags)));
> +
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> 

