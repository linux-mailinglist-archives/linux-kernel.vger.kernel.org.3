Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA18472F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhLMObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:31:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239167AbhLMObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:31:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBJE5T006621;
        Mon, 13 Dec 2021 14:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=v4bM4/UICY1v2fqRW7Z/VBu6exbXGtPwFT+aXPP+28Y=;
 b=nWjFF4YH00TGRIT+A94u7rr2pBM8Ge5qjdNV0jwXFzu3SrbW7qa3HoYG6301KaKC9gTM
 7BZOwHJJtnpHxI6xtCmd+6hEE3eUHbV2hj9yP4tolXJEsDvHrFCflz9lYfrh91b9pVAG
 OfiU0V54tzDYlFTEWfPHE+gc+iZ9NX5bJJbNMqp38giD/uaAYTZ3XqQyhUDsYoH4xx+9
 oLrOkAeqHAQUrxoK5BcIUF1WH2cn8+EKCNTHvoFs/ZszpZuXLf0NSNdfjCAR1EBwJ5bh
 V4zaG3XZ+z4YlSzwG0GGbS8/yoAyNT5mkOpE1ucslli1NDsi1lhivqu964GXaeU7wTSg ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u0d67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:31:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEQQ9d073215;
        Mon, 13 Dec 2021 14:31:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3cvkt314af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSX3glr3o8kt/XvoRrnDT6FE33D77j04VCaTEucUBfNN4cpu9MPatxEpu35TyUdW4eirR3fzxZGFUuIdcWYBcw1E/tRYSbsaj7weea30SO40tIWhXbhdhVC3GTNUsjTN70izYfg41WI7+AKdX6JCQ8mW8tt11+ZJzbIWo7sg1CUeL6HwBxm+0RviXmoEhrE27ToMRK+ev8hJIWqkw9q9IapKCKNHPehmn4XjkMIM5VInL7hBpkeoPzeB9rLHfO6O6/t6xfLhFDFC30DDvPlirGeHHbAvE1UBZGO1kYI3oSVkviYZPLjdPcPLJ3/tAf0qWpEys1aPiR/F2DZBw4n4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4bM4/UICY1v2fqRW7Z/VBu6exbXGtPwFT+aXPP+28Y=;
 b=iUgiNDEoBCkmzhI9GKNx5DC8k4fKBp3ptLyw9+IQcrCUPRYZ++q+74QCOXjesEG8TYXZljjHGhsUbH3Z06VOoOaDlZdTgN5jkLdUiPuDK6gbvugGaGOnZQNAYVgr5GmPsIno/9mzDKjrGhE/qB7cgRB01Hu4GHQ7asMfReFdZsb53sMOuos6S7uIeK3SgQK9ZkVvlIgjiHN0ClfMYhkl8KSBLoiSTAlyjAs/YbaRO+NiYolTmBWj0bbkDjYmGgR/9iy/qKfDATNnz09AosCi6HeXRJsnuXLGK7Wug5hAUbXZYkfRipU33Si2pqKso/7SxWHewury94M/o1G4LZHpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4bM4/UICY1v2fqRW7Z/VBu6exbXGtPwFT+aXPP+28Y=;
 b=zs1umb/AkGPFOZZx0sSF+1N5N6HAE2tM6nwi91iTm0OjJa7iLZ1/fXPFKKHjYRVAh26z9xKAIy9RMuEBA1dD9MBu+ml+3k6eDlnvh0s7HSzk8nQb7skD6ovcx+yUjCFH3G8ptKJDDV6sTG7FljslZWrg8g3URiUEm+TJAsZCLVY=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR1001MB2287.namprd10.prod.outlook.com (2603:10b6:301:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:31:10 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:31:10 +0000
Message-ID: <82c3b01e-09f7-b024-f0f5-d1951433240f@oracle.com>
Date:   Mon, 13 Dec 2021 08:30:54 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 06/10] arm64: kdump: introduce some macros for crash
 kernel reservation
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
 <20211210065533.2023-7-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-7-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0501CA0042.eurprd05.prod.outlook.com
 (2603:10a6:4:67::28) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c12b51c-dd65-4ce2-0749-08d9be4534c8
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2287:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22874C7EF560836297B152C3C7749@MWHPR1001MB2287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+8sO2Jc7E1pdsBdonrsnaidmmRg3TIETILqzVwGaH4tusEdGo+/qHqN6CrWPtLUeWzcRyLwLK2oYlZY/aM5bsUazRIe7yedAcYWqbuvhS+aTd7/tV0kFEM+l8kCGf35MyJzm6kvM57QSkWnQbikMWWOAMQ/ONr81kVTyYjHYRNdgiOEXr/pwDbHNwWXLlToC72XFLNkU45ZzkpV1yyhJNmjvdNnA3k5YkQDDju3uVmsuZ/UPKDzuzul4bKRDj8OSI7qr4FqmJv5GNyQ2MwOUFRXDnkEpGZlWkDlYlat6c4JbBJb0onsvTge8oNgexLmTCBa4dVeNmktHic1KWHRLbaJk6+/VE9BUJ/dC/NelSZvcElHTh+tAAxhYTQAsRtlUI/wDyby2WUgnG5cb63+GEktDPVt3UJ6/LnhBneMxi4zAXdJoFpT/cPWEmW8vXl8l8l0peStMJCePCFePM/wsSKd6oOyApeURKOaHl2Y3JXGX6Zjt6Zz0a/Par4ou0ikPs6kFRab/G6VZdqVYl0aUj5OUqcGDlsDjTsQ/bmkGyvQkrDxXh4ut5GsWvq0ng9enW9oKKHS/rZG623TDiP6/RujfCmsCTjM0abNYqMQPZKmwlrl746ujb1gvkSA8oGXghNwj/uaPTRaHL3oo724BUl0o+ukakSCOUBtV1VFPPbyUmwVsMBXVzpjwomNiapPokN8R9za/UAw4mX/JhJbYy2fTkqSRWvm8A1iiOE3ZXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(508600001)(6512007)(5660300002)(9686003)(66946007)(31686004)(8936002)(66476007)(38100700002)(2906002)(53546011)(36756003)(66556008)(7416002)(6486002)(6666004)(26005)(6506007)(54906003)(2616005)(8676002)(316002)(4326008)(921005)(31696002)(83380400001)(86362001)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhtMjVzc2diSmZnVXVtQ1M2V2lpcVdnWmpHSkMyaG1ncEZKN1c2Z0I1cytO?=
 =?utf-8?B?VWQ5cXNJT0txK0tKV1BheVhxcjRUYkI1OXcySjA2Q0ViTmlybEkyZEtMUlF6?=
 =?utf-8?B?QitmMWFwbzZCbWR1MytQbEFOcVVJeE5HSzFoQnBiVEJEL2wvSDUyZC9XQXNs?=
 =?utf-8?B?SVJHU2syMzFuckhQclJxTTQzcnFUa3BIQ1l1Wk5OaElOMDY5a2VveVlsWHpn?=
 =?utf-8?B?TlQzY0xyQjE0QkFYbER3RTFQM1cvYndlblVQMGdML2sycTE0QkFtVWxjN0Jw?=
 =?utf-8?B?OGpuTUMrQVNRcGZXMmMvVWxsK2FGK2Nid1NtUVJrZ0MxQVFEMk9JTkp1YWJV?=
 =?utf-8?B?eGZhWm0vdi85N3Vhd0hGbCthTmNLbGZCOXVzVmlFMDh4bllFNktnMUtUSUJv?=
 =?utf-8?B?MWpZWi9wVTc0WHBxWHlnVEZMQ1VPL2tZZnBtdlRWdWhQTGFXdDdPNW1EcXJP?=
 =?utf-8?B?U3l2OFJBR2tJMTJvVTJFaVBUaTRJUlJZUERWajFDa1NKTU9GNHBRRXVDeVQ3?=
 =?utf-8?B?dVRlbHJxblZTTGhzT1FTQlYwRWNmTW13MHZ4SzlaTDFicm1jV1JYUktrR0dp?=
 =?utf-8?B?UVJsNU5GV3VWd1pWS1BOaVpSWE9zS2tTdVF1M3Y1Uk5LWGN3V1d2M0tPcGFo?=
 =?utf-8?B?U3R2cDVoNnROeTBjUzNQUVJBL3RIcUpmcnc0TytERXJrbDhrSGVsUG1hc2Vq?=
 =?utf-8?B?RE9JVlhtTlJIUE9yckNJZkZ3MHJGUFk1eWVOQkNPdkowdHIyc1lZSVpGOTQz?=
 =?utf-8?B?Z1huVWlmNlQyZ0gvNHhPcXVwNTVlenJhVC9kY1ZJSzZjTUNtK2p6Q1FudkNr?=
 =?utf-8?B?djF5eTZ1NmhxbUFUajVBUU5Mc2N3ZDlzS1Yva05TV25nOC9FenR0Qi9uQ2Va?=
 =?utf-8?B?cFhRRzFsMXgySmx5eXBveHZHV2lKMFFlRUpxR0cwbDB2QzdGdkNUK1U3cW5a?=
 =?utf-8?B?bXg4akViczJqUzQxLzRob2dTVVJ1cHUvZzl5MGhTQUdLQUkxZUgrMmlJVmhG?=
 =?utf-8?B?QlJMeHRGMGNZaDl5aURmSXdNNTJ4TGRjRlRMUkMwT0liQU5WZHZMOCswSWpM?=
 =?utf-8?B?VE5saUxGeElKcDBtSzBTV05za0xzdVloakF1WnFWbmkzNHZSaHVTSWlGcGJT?=
 =?utf-8?B?R0dSL0Fhengyb1RpWnhNTjRFTmhVZHlXVnBGVVNEZ2VwNVNqMDA1ZnFSWlA3?=
 =?utf-8?B?WWJYcWZPd2hKRmRSSGZLamZ4QmFXM1kvM1dNL1pYWFJ6ZkFQOEdrbnh2NWM3?=
 =?utf-8?B?RkU3dVRyR3VLLzFJMWZBa0hzUW5mWXlJUUMvckgweFZsT2tFcnFZMm5QVnMr?=
 =?utf-8?B?WmpxOWUzNCtQdDBZT1c3cXcxRDh0ZlZPazdwVE5SNk1VTmlIa2JRNklGZnNE?=
 =?utf-8?B?Y0lvdUdJTVFFWmU4M0xtVXZxTWFkeVFHK0l0WDQxbElaY2prQVN6WlNIdmRL?=
 =?utf-8?B?NjByVDQxZlQ5L1d2M01oWk5NOVhoUThpQWlmWmRGWGxSNjIvaWNOQnoyMlJX?=
 =?utf-8?B?b3JKeUdmSnlDK0VxajVJNmJtTWtXZ0lIdXBBbmhYSkhIdEE4andVbTk2emhI?=
 =?utf-8?B?TmxOZXlpaTdWVHAxaXdrYjRQV1FtU3NBenZoeHp5YXI3VnJmdUJKWFZlSW9z?=
 =?utf-8?B?WS96T1dSeTNsOWVTc3lOSGRBRmFJZmtrVGxiODRFampickJhVHJvdXhDTjVG?=
 =?utf-8?B?V3Eyd3pmZm1ZQWFSckdVcE1IVWxUVGVORjZiSUh2a2Vwa2VPaUx0SUZkTFVU?=
 =?utf-8?B?cXQyK3ZsMkZEVkZ2eWx1NndIa1lRVWZtcjljRmgwUk1VQUhYRkxnZVlUSUZC?=
 =?utf-8?B?bVo3dUF6Z3RUVFhRZXNaODd5eTFXaStoMnRZb2hVNFcvN3M3WVErWjl6Skha?=
 =?utf-8?B?THh6czM1R2Z6cDR1RjJwV1cxbHVWbmVpMG9DQTBBUms5bmRZNHJJeXEyYkVn?=
 =?utf-8?B?dSthSGN2UThqUURXY3F3WUlTWHhDTEhhUENzR2xUOVFibjY4eW1tdTk2VzRL?=
 =?utf-8?B?V2tLckJma1QzL0NNb1pJV2NJWFFjdkhJS09FUUNoSDA1MUQ3QTZKbU1TMVNp?=
 =?utf-8?B?eEpIRFpiS24yMnNWL2VBUUdNNlM1U2FCNlRiVUVIYTNNV0MxUC9jQ1RKMHJX?=
 =?utf-8?B?RDB2b0t0UVZYSjlZcG9nUTdrQmQ3SXQ3NytXYkoyVGhDVlZZSmxBb1UrRC9D?=
 =?utf-8?B?TnVCZnpBdXRkTUl3S3BmUEY1T21hOUNacnNHYjhjL2hySGxvM1ZabFhHTXE1?=
 =?utf-8?B?Y3o1S29FNTZRQ3lMOStLdUlOcjRRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c12b51c-dd65-4ce2-0749-08d9be4534c8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:31:09.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK8olTawD7paY4XZegAP5/oh2BUARLUUavWkr8MwjtwOwLT6yoA3p0Iw5BMJYtPi0rSGWZGz/Hac2AkN3T6pBBmseOtJ+HmcXxN4cHf/iHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130092
X-Proofpoint-ORIG-GUID: hXPsHF5s8SRFq9tgGp9_3A4RtapPwbrR
X-Proofpoint-GUID: hXPsHF5s8SRFq9tgGp9_3A4RtapPwbrR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> upper bound of high crash memory, use macros instead.
> 
> Besides, keep consistent with x86, use CRASH_ALIGN as the lower bound
> of crash kernel reservation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   arch/arm64/include/asm/kexec.h | 6 ++++++
>   arch/arm64/mm/init.c           | 4 ++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 9839bfc163d7147..1b9edc69f0244ca 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -25,6 +25,12 @@
>   
>   #define KEXEC_ARCH KEXEC_ARCH_AARCH64
>   
> +/* 2M alignment for crash kernel regions */
> +#define CRASH_ALIGN	SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
> +
>   #ifndef __ASSEMBLY__
>   
>   /**
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8834434af99ae0..be4595dc7459115 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -75,7 +75,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>   static void __init reserve_crashkernel(void)
>   {
>   	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>   	int ret;
>   
>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -91,7 +91,7 @@ static void __init reserve_crashkernel(void)
>   		crash_max = crash_base + crash_size;
>   
>   	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>   					       crash_base, crash_max);
>   	if (!crash_base) {
>   		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",

