Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBD48B058
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiAKPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:05:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55678 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244013AbiAKPF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:05:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BDE9HM008377;
        Tue, 11 Jan 2022 15:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=e4Oyx3mSa1TQf9L3oFYzh+8qCHIQKuR5fjKbsD2C+AA=;
 b=Ad+09FAut7CZ7ybc0sMUh1k7gmF5gH1CtjH/VzhmEjrPgNv85AFT9MOffFZc9n3CxroY
 pu7pB1LDMc1PABfVbPNWF0whN9i5OSOsIFXzGes2OqS+eFL3e4jP1/RLV21rObgnpJIv
 DR4WuB0cvGsHot3qZXbNCGfg6HsNdluuWYGA1Ts/B6O5gnC19angjbs4ky3Ok1BpNkC3
 x1qW7ePf++wADtpnw13IbZKSQDQbY7Tza+N2HbHu5pVl6qQktP9G4AwCrvxH9kBeZdLc
 cPi+KS7/hullufPxlIp2i+NfhrzeYhUShR1gD1vGEOF1u1yyNgmIUdaHr5ourcjFxsYj nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx3cxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:05:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF1dww183848;
        Tue, 11 Jan 2022 15:05:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3020.oracle.com with ESMTP id 3df42mvf6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWyeJ+qloq1otH0EsJ5OXtx6ZW7ejbfN1B8P+oYwXcrdCr3ZB2rON9Eto2JBqpRCHI5PUPxMoaqht2gwV6N0gDYkPLxHDPuTkD3xDI9fl5hNhyXOuU+xOjLmjg6rXMiX7G/C50kNzcGldB7gr8JUTyWHpGK1MTnUCnD41eOuDd4bBz68yQWZ3Kad59tNPTxPDNdRbHX0SZXs5IFgoxCulzrzNIO7mkuAyy5L770pcVsFZnqNZy3M+zG/9cJdYWhn2/Uxkoe7fjNu3MzjmWcbrlyPQKMX80CH6BeTKkSZobp2VP7RE/rQ7nXpkFiWBuIKC6BON5AF31PS2UouFQ1+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4Oyx3mSa1TQf9L3oFYzh+8qCHIQKuR5fjKbsD2C+AA=;
 b=GZjPtD048Yke3563Rd75oe78Jv1hKOIiKys/SLkUFm1wMDiF0x7F2CASKApqwxTpEYsxMhXa23dQYbPKC4M4J7aSIYkoyx77W/o4um7t4K9x2Xuylb/xwPuZBcEAW6E0PTcxzle2ioFjEZpWa5WJ1OXCRxzkCixJYobMTC623hMrUkU0gbz8s5s+oWBr5SE9ALu/ZL0K8n6KYcYG+ercP1SMSK24n3bvG9qqmMZmM5eVMGw2Lg0s7JPeDafI5TnfoRXjBwci9sjWW/VodkAa8qR6kPQ9UiuWydH6Jyl4d5x+bgN6akKSAq35FCRcIzsexRxbkryMSlxc3RaBRX04Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4Oyx3mSa1TQf9L3oFYzh+8qCHIQKuR5fjKbsD2C+AA=;
 b=i2IWb3+1yQzocJ6lYaUNKStnMYsuI+diL52BT9ZZUQhE1mmRZ3f7U28pcjf+jdPWuKhJ0EcJlKlAqI61swRaIAJty1eNQJ/DH7550J17FzqR06Ajsuwsv+nWgXZfGFRF4UWAaJHgk+QW8qmzf7sULIRXqyquZ2pdvsbmvqECJNY=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:04:58 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:04:58 +0000
Message-ID: <f70c75a6-c816-8b20-797e-eda11ffed3a8@oracle.com>
Date:   Tue, 11 Jan 2022 09:04:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 03/13] kdump: make parse_crashkernel_{high|low}()
 static
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
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-4-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87666cf-288f-4ee4-b930-08d9d513bbc4
X-MS-TrafficTypeDiagnostic: MW4PR10MB5881:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB58812566711BAEF1E9226986C7519@MW4PR10MB5881.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXzgHFKCVczehON5pd94DqueEPwpILSMIUUb01ssncSTmt/CGlLDESHIyBxs09q9+tp8crzcCx3kizae7RnohmFkC6JHxlDNMl761N5WG21YPoFv+s1rCsqqLFD1y6QTTLizEoCnmuHAmjZQIi/W2oMYVnLS/wTY5PEOvPMRnMXWfJJmRzs2pKy5eNi/KysaNz98yoI3LrvtKsYns9++dBeF1MGJpWVma2ToE4K2kN5rcPIf3A9kU4iNta5+0+F3O2F9fE/uz4KEsXhB5BQ7GvUsPUrR0P+xAo+LQEqJ46VxBtLt73z9naB96fnaSLB4h5kumYoLEtgmNRNLkUgS9qIeM/y1qtwQ6KtfsWhpATQ1sxxQiGbk61f5TY9py8wpdeuBsxfRiCU6bP2nTS19SEUQMLvTU1mJclWjN489gW2VB7oIESXdxmMNmtTgBTJ3zBYY+Zb/omml+ol4+tzQzacNziXmWzD/kdXSBTaWoyhBKS73IbfATLV4h1rq9KLp4oapaAo/WX2WZcuOLj7PpHVE60tomONvIHfGgw92CAyeelkNegg4uP4MwYdW+qZXu6fHuwRavgkkWxkUd/pHltWjcEl5lDFxXI9xkqe+CjKBtNSHdzuyy6/iIxB/470cpNi8ddipT0vrn6m8LcA+w+ewb/6elCxuY7jxW9MvBHluUsBKZx4ftd1/aU7oIwwfGVq7CdpDSDtBkVxL9m9M+5Iwm2SP2cWYouH+YDoeo0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(26005)(6486002)(921005)(2906002)(38100700002)(110136005)(86362001)(5660300002)(54906003)(31686004)(53546011)(4326008)(508600001)(186003)(6506007)(9686003)(6512007)(66476007)(66946007)(36756003)(66556008)(8676002)(31696002)(6666004)(83380400001)(2616005)(316002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRaUkdtMllKcVhsSUl6bGY4WndORGc2NFZJV1paU2VjZjI3TmJxRWloc1lQ?=
 =?utf-8?B?MER2V2hTNEkzY0xKenZnbm5GZFROSGRzbGpqWGVLbUtNMzRsYzRlS2xHZmF2?=
 =?utf-8?B?SXBlUEgzdTZseGZTc0JLbDd4MmJNbGIvYnMxOFphM29DdFhQbzlxbXVxMnRT?=
 =?utf-8?B?Ynl6RkhpS2tlWlAwUWg5cXg2bnJtQ0M2anRCaGgvcUY4V2prRjd2R1Ivb2tt?=
 =?utf-8?B?RVR6blhqMGJVaXh0K1NrK1JTZXlISThuYUFmblhJTTZqazMwaVFWaU9IVU12?=
 =?utf-8?B?M1dSNnNjdXhZWGdERTJBOUU4L29OcUZhaVhWRWNhSWZteW5wc2JhMk4xcjdL?=
 =?utf-8?B?c1dCYllraWJ5SlRTN0hUbU1ZSEQvTXFYbzMwYmkybW15TkhlOW5SNEhNRXRM?=
 =?utf-8?B?bUtUZkJNVWhtOWJ5Mnlub1RrZmpZcUpUazJuVitWSGFOdlJYZkMvUjU0c2x0?=
 =?utf-8?B?ZnhQUmNQcDU4cTVGWlVGeGg1cDN0RW1XSE9WVzlLSE9ZUTdPeXdPYVg4MDhn?=
 =?utf-8?B?NXJnaGd2dnpIeExYR1J0VFp1KytLTUx6b1RyM082cE9FaHFRSE1LcWV3eHc3?=
 =?utf-8?B?UHpPZ0RObUhXMHh3QUtWcWVFdFBnSkNISzc3RkU1SC9kMThlN1g4MlZVR1Vq?=
 =?utf-8?B?Nm5rS3J5WlFySWU4Mkp2WHFHMTdndUpyd3p6cFExYVdhU3g2NEFsWC9wMmk1?=
 =?utf-8?B?QmVQZVJFbThwS3hDQUlaakxlS29mY01uTk8rRndQUUxqZ004dCsyV21LMVJC?=
 =?utf-8?B?MGZ1ZEI4K3prcGR5Tm9kS3duUWFjNlpINElPVFM4QzBHZ2IxcmFzL3NnNjZZ?=
 =?utf-8?B?dWx5cDllUUdERExDcEFWOVk1MHd1SU9nZktybC8vWnBIUFZFZzFBRHpOTGVZ?=
 =?utf-8?B?bllZL0dHbzQ2SWU3bWM3VW9FaUJOZnFzZmJ2NjdMWlEyWWlYaHZZYkxLaklE?=
 =?utf-8?B?VmlPdDFpa1NwYzBmZWphUldiWjgybmdEc1hBRitHWHZscyt2Z0R3ZlVIMTlw?=
 =?utf-8?B?YzZWY0tHUVJzNk1QSi9QcjhLMEdFa1ROSHQya0dkU0JiblNxNjFoUGNkakRD?=
 =?utf-8?B?UUlmSmtlN3FLUGpjRmIvZGljV3VjOHd0VUsyaEllakNrR0JsazVxMHhNN3FK?=
 =?utf-8?B?RlVCYWIzbzJpQjQ2a0dJaWtIUWlzTWdRbTduRm43UGxkZlFRRHZQRmpvellS?=
 =?utf-8?B?UzRORXFMM1hrUTlxZDI0YlJhZXZ3NUhKU0xHNEQ5UTgvdG5SUUpYeUV5eDJD?=
 =?utf-8?B?TWIxdnkwOUJiTXdPLzlqVkVoc0hIZXE3ZFhCVllqWUFqT3FyNDh2KzFYT01E?=
 =?utf-8?B?T1VYZTRrdjI1b0t6MlJvMUpTOHdMV0tlOXllVUpFOWdGZG5iZ0NQbmVUUXVO?=
 =?utf-8?B?ZFRLR0pTdHRSd3k0WW9vSUZPbFJjVWZjdzJjYWtiWUpoZVVzb1Z5Q0xuL3Bi?=
 =?utf-8?B?a2R6SUgrQmNGcmZiYWF3OFdFcm9EOG5tZ0lXWnp3RWIrUkV6SkRBTGJCbVFl?=
 =?utf-8?B?eWVkaGMzRmNrUGthQnllTTlEdkRoaHhHUjZOZ05wdmpLTFlrbm5tYkcrazFE?=
 =?utf-8?B?eHc2U094eFZmR09seEtvOTRJZWUxRkRzTHRXb0tHS0tKNUVSUlpXUy9PQklN?=
 =?utf-8?B?ZElnY05rcGRxNHVDb1VHZjJROVNDTlpGRmdCMi9MWU84UEpOa0NmcllLay9K?=
 =?utf-8?B?NUlZbHZjeVpjNzdTdjFlRFJiY2ZUU0FldlYyZXMwekxjZzdTaWc3dndkVGpu?=
 =?utf-8?B?M2doSmthU1U2c3ZFdXpXQVR6d3dsQ0NETzBHQTBaYTlEUTlvTDN1c3RHM2NB?=
 =?utf-8?B?cjVnckova1QvUlZKUUE0K2ZaMTVUTTBqTUUwNkU3TC9sRnlEdzBScU52bVky?=
 =?utf-8?B?SW1RNC9wdjdobHE2ZmFjT2czQXoxRUYxNTltRCtQNVArNnFjWFV2QnRZRVVK?=
 =?utf-8?B?NllGYzJNSWRaZzdSUzJvWG51MUFOZnlPZXBlN0hrOEh5SjN3dUZheHEwNGp3?=
 =?utf-8?B?V2NlQ0YwWk1KZko1Y1owZkZCekk5NnVEWllXRFZ1dkpoK2xmbnZjRElncTRT?=
 =?utf-8?B?Z0FxbzFnOXFieldkQURXci83S2JKcU1haXMrVjJNak9wZFROdVRHVFJkbDBP?=
 =?utf-8?B?MUpiNW5SbHRicVkyMmtYbHI0YnlkN2ppNk1SbTExTEJaeWNBeFE0QlZTRlRB?=
 =?utf-8?B?d0Y3Rk15bnExWVJVVTAveVdaS1V5T2FGL2l0WFd2WVBFOXJTYXVCZ2ZGNmJ0?=
 =?utf-8?B?Rm1EaFZZMHc0dVNOZmgrN1E5ZmJ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87666cf-288f-4ee4-b930-08d9d513bbc4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:04:58.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cpE4eKZvCuWzjXASzvFDxLt6Uj7Mmtgz/6tZeIosifcZ5NPhg4Vl/95FWkoJo5kGZrIZnXfxvqOtzehNml/dkM3TLPgSdjXI0gH0E53aJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-GUID: LxKlFoY-ghPYa-zPSKXWUEfTmXRqLnn3
X-Proofpoint-ORIG-GUID: LxKlFoY-ghPYa-zPSKXWUEfTmXRqLnn3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Make parse_crashkernel_{high|low}() static, they are only referenced by
> parse_crashkernel_high_low() in the same file. The latter is recommended.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>

> ---
>   include/linux/crash_core.h | 4 ----
>   kernel/crash_core.c        | 4 ++--
>   2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 2d3a64761d18998..598fd55d83c169e 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -79,10 +79,6 @@ void final_note(Elf_Word *buf);
>   
>   int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
> -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> -		unsigned long long *crash_size, unsigned long long *crash_base);
>   int __init parse_crashkernel_high_low(char *cmdline,
>   				      unsigned long long *high_size,
>   				      unsigned long long *low_size);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8966beaf7c4fd52..3b9e01fc450b2a4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -277,7 +277,7 @@ int __init parse_crashkernel(char *cmdline,
>   					"crashkernel=", NULL);
>   }
>   
> -int __init parse_crashkernel_high(char *cmdline,
> +static int __init parse_crashkernel_high(char *cmdline,
>   			     unsigned long long system_ram,
>   			     unsigned long long *crash_size,
>   			     unsigned long long *crash_base)
> @@ -286,7 +286,7 @@ int __init parse_crashkernel_high(char *cmdline,
>   				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
>   }
>   
> -int __init parse_crashkernel_low(char *cmdline,
> +static int __init parse_crashkernel_low(char *cmdline,
>   			     unsigned long long system_ram,
>   			     unsigned long long *crash_size,
>   			     unsigned long long *crash_base)

