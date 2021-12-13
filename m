Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939DC472F50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbhLMO32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:29:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60462 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239183AbhLMO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:29:26 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDD9FfB000381;
        Mon, 13 Dec 2021 14:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KA2LGJaDQSOUqX0iW2jaRPWyLRrFkQ8gLCSlNC7dX80=;
 b=HhM9aUV5Z/Ja0/l6NtCPtJizMLKcmwQBWLSKiofQmHcxwJP0qyNmEbzJvpsacDuYLKuz
 c7BYb9toStbPNS6t1pplv7OouS4ipl/Dt/95t8zQ8MubDmiIkA6UoV2QBxuGaT8N8KwE
 v1jF0oQ8ag5rMIHLITXXybtV5ArPU+yftot3StMJlENHPYnLyZyzACGY436xku3bcSLs
 8lERXDMQF20uOPvYbYTbbPIFfSZ5y/HyC+Ll/W/jV04600WThZHpo/sde73g9sMZugMM
 zlE6n15iqURCXo5jF8HP5OrHTQj69ffGvrhJ4B39k1aQMZ7Dwjutn+K+vB36xhj/WarG kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3py0nbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:28:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEP2bO085949;
        Mon, 13 Dec 2021 14:28:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3cvnen54gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mas9t3bptHLtnAo5z0pN4u/lDr/DIGsyQARrsL3e4CmzyX4+7H5y7soxQHMh+8gyT5DJ43Sp8uYS+1eOUzgpeG4mjFjxJTRF90WMEAgtcVtuPRG+wIrZ5P1XxX4HYvx63b10JFLLGFB/d0mPHfG4+/HYFI4HhE/OlffoeKtEr7OsARrHSUXE+Lq/qgVY+uB4FbFboD6ek6cv/5Vxo4Y+3Un81E2MbT1EOBVRuKX48SF8VNSWPPws1CQ8QQ3z+Le+MwJM7s6t0jZlFxeIrKsjhTVhdMO7J4ThsdTB6EyyhTBfVHXw4aUuBo0V8b3M5OkzUVEs3U4HeoM1Vjcp2kNx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA2LGJaDQSOUqX0iW2jaRPWyLRrFkQ8gLCSlNC7dX80=;
 b=Sprg5EdvXuTdM9XKQ9/gpF9FCqXIJ4GnMJVHPe2sa84MoUNKxjf/c6TRbVD6k0Wgy+WOGRmpHsUmWkaZce1QxilqaDtqq2iLm5Z5lu0uoW3kbGWFeDUmmoV92a1VrtRJjlsg6bkfAUVl7cvqwyCcEV6g4lEPI1qETW3uP8OX9RXGeaM6vqgOi/37pKPWWq7Z1nn5PDcERuc3vZ7TlmU2hptsrQ52jwRpFbTIopZ4H2HV5hR8eLbSKxj3BgiV18TA2XabjGNtRPWrNox3EOTiWp6LC/dBfXZTPFUhcoUXOcZgQUW/fWtslGSgUHAoQCZhMXLFw5HXTrg8wNfMTGsTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA2LGJaDQSOUqX0iW2jaRPWyLRrFkQ8gLCSlNC7dX80=;
 b=MMe3Pxhhpa8mBA2H3NJHN8hWSiTEQV5crcg6muDJGEvPBDIfFtljA94CabrvHJoh9N7fDyh+G2zLnvd1fQgWvH5gSbXuEU53vpi2buRRdagiAwNbTkYrkEPOztcV8bwixGauWb6bfjFJC/FP7v1DbPEboB/94Nk1sIIyeQWgp3k=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB2047.namprd10.prod.outlook.com (2603:10b6:300:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 14:28:28 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:28:28 +0000
Message-ID: <0d3e6361-0850-4273-6d43-8e40a80c6916@oracle.com>
Date:   Mon, 13 Dec 2021 08:28:14 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
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
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0203.eurprd07.prod.outlook.com
 (2603:10a6:6:42::33) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb2db36-dd08-4b58-d8fd-08d9be44d4b7
X-MS-TrafficTypeDiagnostic: MWHPR10MB2047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB2047424AB1387D6EB0D9BA18C7749@MWHPR10MB2047.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkrs90ZTKDqeCB7nabp4/vTS0BQ7/YEO6ag6A0LitQpSbGSH0gJz3Ekww8LSVIgC6blcf7eRJo547pjll1miVwUcVJDWiSk45V+hG4CtzLsMk29wbSQx13cg5JXTOPxvrvbOg+i56jS3M6vAHWLMsdvnAOnvpgBHuoFmjPzuOcCCB+YY04I0eF6IoKUfoUVwd3YfZpzJCrbfec3lBImYU8ae+Sq98bEMIxRv8VSbCLdh46fpQEoCKXYkYIHbpFAMW+U32jACLQ/6C5k7JDcufuUlD0frB2JnzTv8S1Yy1379xGgRvM2ELz74XpCYoX1ZJOm6oisZ/kMU0pgI073ct7Cnf2f2GWhWbDCH41xFeldChP/919WzEC+ZBeJTbCmYD8/fdD457g8flppeSz2s+c3qjZvxbMFr9SpC8OnLN6pm4SUunbkmU7iOqByPB/1lYU06yp5RwK+njLOil14jxUwfNoSrTd074TCMlPWzI3/CNM1PtvQR6y4s1TpavqtaEu8LcM0aGtd2gkUxGsgLcBL1+9N8fZhLOhtWJseM8TmmJ/yxfax6HNLxKkeRztp4Ug3gQIyWTS/tTNNN8GTML0klQhHWUjtT3McLYjFWuYRBWDS9qsQ30nBanu8s7sFjv4DMGlCoGUdmrH+DOo8u/VPQMjapyPoP6/P6iiuaxhX0Rxr5m71gA/ghAr5nlUcbkZzOkE0lVrTPl8RtHeFFoh1jaGN+AbqnKDGoopmib/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(8676002)(4326008)(38100700002)(7416002)(508600001)(8936002)(9686003)(6512007)(5660300002)(921005)(83380400001)(26005)(31686004)(6666004)(186003)(6486002)(66946007)(66556008)(66476007)(2906002)(110136005)(54906003)(86362001)(2616005)(6506007)(53546011)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlzb1ZDaDBKV05GSGYrK2d4cHIreENOdWhvK2svRzh1RDhDR2ZvQjZrbEVU?=
 =?utf-8?B?UnlzRGxJNFAyZEJyRUVaUG9GbEF1dW1pQjU4RGVyekJBQ0c4Nm1kNUUyU05x?=
 =?utf-8?B?aUhXT3FVOVZ0eXc4NzVjYW1YZW5EcjZyMnNQVDBPdnNYR1o3RUdVaWlRRTdJ?=
 =?utf-8?B?ZWNSNmJoclRsSUJYeGVqbHF3eFlqUWRiVGpEdzF5TGtONStnZ282Y3lkNWZz?=
 =?utf-8?B?WFBZZ0M5VGRvRTZVckxQNW4yRnNNQ0N1bkpCRWY5WnNYY1J3K091a1VjbEpU?=
 =?utf-8?B?czVUZ1l5RnBlMWJwNmNzL2Y2MWdpK2tYTlFsUmVtNCt6eW85bDRTemFzN0s4?=
 =?utf-8?B?eDlRMGFIL01NVzEvOFA0U2w0L1RMZ0lkTUFnUXBiOHcxdkI3VTZXMUV0NWdT?=
 =?utf-8?B?RmdCS096T2cxWUZZdVFJMXc1SmJYaEZMV2hZcWhWZTRBM2xEV0VORCs4a2lx?=
 =?utf-8?B?RElaVy9vNXNJYVBJZkpvVlhxaDlJMmVkVmFZZjRDT2pwQm5KVC9JdFB1KzVa?=
 =?utf-8?B?WFFYUEtkanJEZ1R5VHovSXZrWE9uY2l0WU9IbTJNRFE0aTF6dmk0QWRnREJr?=
 =?utf-8?B?a05FbzUvVlNPeWNnZ3NpZlkyTVpDbnRXSmsxZ2dDMDhIckU3N2JYLzl5Rmpo?=
 =?utf-8?B?WDdPUkNCNVc4U2JHdnRPdExyYk5KUkdqOXR4eStZVG1qRmM2VlR2a2JINnha?=
 =?utf-8?B?R2o4Q0dPRHhhOU9zTS9oMnJ1Ty8xblAyQVpCRkd1bDVqbnJpOFJDYm80c2gw?=
 =?utf-8?B?UXpzVFZWUXhtaktiek5oM0tIL2NzQTFFcXRrcnZCUlZvaWg5dkw2ejJ2Z2lO?=
 =?utf-8?B?OW5UcDhFNnM2RkhFMnZWMnpBV0ZYcXh5ZmQybDNiSDhwa1MvcWovcFpaSzFo?=
 =?utf-8?B?ekdhYWNhZUlHb1lrUDZaVU02L3ZkVm40NHFqUWt1UnBjcW10Q09pYTh3Y2lo?=
 =?utf-8?B?ck5DNlVzdExiTkxnNXpSZmVuSXRLUlFxTHIwUU1RaFBBdzF3WjRRQ3l2RUhQ?=
 =?utf-8?B?OURiM21VRjFLejhPd3N0VVpDZ3RZd1l4dDBOTmYrdTZ6cnpKYUpwOEVnM2FI?=
 =?utf-8?B?MGpOeVIwbmdHcVJWVjE1QWxJZTFhTE5ZZXgyV3R3S0IxaEc3d093OUN6MUM1?=
 =?utf-8?B?NHFQSHM5aGFONXVqajIvUkl2UTJ4dEJLSWJneVRySk4rd0lkZnRyMUFsVTY3?=
 =?utf-8?B?VjdoVXlqcWZuTG5GNHFTRE9jZ1k0bDN1WWUvZWExaEFwRFFReStVL1dpdk44?=
 =?utf-8?B?anFRWTFyaGoxQTFzYWdDWWF3MFc3Sm1EUkQ5NkcwOTlnY3VWRXo1QkxEWEQr?=
 =?utf-8?B?MjZiMkErdDhKUnVrUTZMYlVoQTJtdkhRd2dNb1BLU0FHQkV6Z3hGSVh3dUEv?=
 =?utf-8?B?MnlxeTlCaVgvMWxKaWNpNEYwV3Bvcjc3bDFFTUxja2syQUVkbFhKYnhmUlBJ?=
 =?utf-8?B?dkpPQlZ2cmNQbUxscmFvdDBpNmxJYW9jNXhjSjIrZlFHd1ZPS3pQUkxUTERh?=
 =?utf-8?B?d0lZQ0lzMjBqVlVHYTQvcFBzVzlWWDg5UnNKYXNnUTZnQXZta1JKb2poUnZG?=
 =?utf-8?B?QmdUZXJnNGw4a2lXM1huZFhUZXFDem5tREZBZGYvcWNsVzIyMzlvRXgzTFBp?=
 =?utf-8?B?ai9GdkZaRjcweFhrc2FPOXY5aXFod1pwQTJ5V2dpbElPR2hUUmpTc3ZGY3RI?=
 =?utf-8?B?K05ZUGdGOXdCZ3ZSS1diSlNJc2gvbW9oM3d4RUt0bWdNS0hCVEc1eUNIdWh2?=
 =?utf-8?B?WFpBckc4VFJMUnpTcXk3czRyOXMxVjcyemZybkltSU9NYnlqRHpuSGFVNWM1?=
 =?utf-8?B?RDVOQ1piOWwzdDNCanduV3U0RDUwajBYSlp5ZjljUHRJemNrK3B4R3plVVoy?=
 =?utf-8?B?dE8vT3FjNWl0ZDV6WGttYkgyUDNVZGhldlgzSmRHL3FjOFdsdUJIQStDRzcw?=
 =?utf-8?B?d3A4clVxOGdCbHI1ZXAvU3pVMGlic2Znb2ppRW1nNXJERW9OQ0pIUElDQ0Iv?=
 =?utf-8?B?dTJNb0kwb0tRWHQ1TnRBM2xlclBqMWk5WHc5cWEzRXFFNERjcVk5akFoSk40?=
 =?utf-8?B?cWF4U2RjMklDV2t4aG9kaFlTRTFxdm5aOHA3dnhkemJ2N0xmdG5kRVVRTFpG?=
 =?utf-8?B?TitLOG5XUFRqQVZDWmtOUHpha3JiQjdNRGN2L0ZDaldLQ1B4cGtWWVd0NjBE?=
 =?utf-8?B?Ty9Wd05jUXF1RS85b1NoTHc1RzloRE8wMDZFZTFiQWh1RzQrWHVBbG9Jc2dK?=
 =?utf-8?Q?FfMIj1H9cerzfvxjA3vOqTw8MyiBkML2x2DsxVa6JE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb2db36-dd08-4b58-d8fd-08d9be44d4b7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:28:28.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccu8DK7kgxyupoER9zaoMjRR/8LMMbFXy5qQEiqvWCBdaLTO60SBVQv46Za4sM66YJnLqOwttnMoKrwWVFnae5GnKp3uYGWjh7jBRSlXMA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2047
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: Bm4ObYDz9Iw0eCWgyD59y9vRhvC4Jjkt
X-Proofpoint-GUID: Bm4ObYDz9Iw0eCWgyD59y9vRhvC4Jjkt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> To make the functions reserve_crashkernel() as generic,
> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/x86/kernel/setup.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6424ee4f23da2cf..bb2a0973b98059e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -489,8 +489,9 @@ static void __init reserve_crashkernel(void)
>   	if (!crash_base) {
>   		/*
>   		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> -		 * crashkernel=x,high reserves memory over 4G, also allocates
> -		 * 256M extra low memory for DMA buffers and swiotlb.
> +		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
> +		 * also allocates 256M extra low memory for DMA buffers
> +		 * and swiotlb.
>   		 * But the extra memory is not required for all machines.
>   		 * So try low memory first and fall back to high memory
>   		 * unless "crashkernel=size[KMG],high" is specified.
> @@ -518,7 +519,7 @@ static void __init reserve_crashkernel(void)
>   		}
>   	}
>   
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>   		memblock_phys_free(crash_base, crash_size);
>   		return;
>   	}

