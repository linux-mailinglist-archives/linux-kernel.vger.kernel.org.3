Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A803548B04D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiAKPEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:04:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33912 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243891AbiAKPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:04:53 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BDDtlW015422;
        Tue, 11 Jan 2022 15:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JJ6ga51doBz3pEJaGfs9ymaQW9MK/EpPs3Ui4IHpj98=;
 b=kflZX6EtiAcMh3BCR3il+RDlZBIetcnr2Lrqyk+uMwhfwpa6YX+DuUkHmfmB2+o7eYYQ
 P4eISvadj5vDTGS/a0/A32GZwgpcvHOm/OLiom+vnIj76J7Lye0Fmn3NLIFsywgSTMHw
 ESGMUiyu1aCxm/5IUnTwX2T9XIoFx1GMZgZPaAJUeQ5s3EvOaCgup2Sk/HveFcO8fZ2Q
 fGqUy22Atx9fNFJt7C7s0Ek70BXpzcXI+wGIsxqGjVqAH9ldWUukL/PyxHnXozTvZROh
 FdJXal+ez06oJJ+rxUSVFkAe7Tvwpw8dWMFkz+tLFeEbndpawhNoLr6SoGbaYbpW8v3n nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9bb20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:04:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BF1dHC183881;
        Tue, 11 Jan 2022 15:04:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by userp3020.oracle.com with ESMTP id 3df42mve6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 15:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI8aoRnp4QdHc8O9Rfa6scu/SBV9SpM6D/UbFRRL/mLrQQHPgu1wQ0gr0CvlsMXkhaFcwaaiTj4prPvL6NQJtJwc2XWrHG6D/ni6VGyYM0X9px5mnuJdsAAAf/k/BxE1lpxOKJzHLSud+wlPiCRVg9gmIhjBf+Kxu3UlEogxZoggzjQ6WkwT7Hfw5gSQD28BQAf3BD+b8bTwXUAo2wgtpO7wJE9GbAeSk2zgJC20Ts9RoCCVPfz/vrNIEclT9wBv3NWcS0wAQ2PInOPclMM7TkkWpywhvjpKxwXLEtUB53Sav0pTvB+CnQMMdSbkcCKcagodci7Lu1CnhFeuiyJUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ6ga51doBz3pEJaGfs9ymaQW9MK/EpPs3Ui4IHpj98=;
 b=W729xWO1obUgVh7D3UbyN2FLxoDOvogjhm5c0nS9iJTe4ALWxFNRXXRtRhxXajhz++g8wponxmvxTX51KvM2xsO+G5gbnj4RqvION7as+jBFKuqcNHVOIlxVHI39C7h1vQBq3JVRi/rnNw4ZWRbjTu/jwCUU1eU0nxnmTJSfJuWBUOvOvKcZoVh/Cy5R3XoepUdKGyQckuh6E7TFpD7EHazohcwgS4zDXGkEV8SGQk7sI3KHMTm8lOsr+yUM8K7jj3Zk+mcmVoEQWOLivFDiLbIcQywh6tSMVkE+EBEG/De4IMRvzfnIs+7d9P12TqouTVUFqBs81zTk+8QpEV+T1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ6ga51doBz3pEJaGfs9ymaQW9MK/EpPs3Ui4IHpj98=;
 b=sU9VsvLJRAbwajHnk9bDeGpj++tVGhNz0kYF/O4nfYQkRI7WPP3slCW4GNQoc81j4dGLxUQcOARsC7PRNMPi4azgE+M2y3uQYkvycsvF+jF9N1dxvnvp6jgl748bJEcUZYbSyQtmBRapGgJlC6i3zScnhREkD9YfKaeCOamnWCA=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:04:18 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::30b4:4c4c:82df:29f6%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 15:04:18 +0000
Message-ID: <097d4a87-1981-7848-6553-079d63cf6410@oracle.com>
Date:   Tue, 11 Jan 2022 09:04:02 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
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
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211228132612.1860-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0374.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::26) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc9b5df-ba86-445c-feee-08d9d513a3da
X-MS-TrafficTypeDiagnostic: MW4PR10MB5881:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB58817FACE2FD701004485E1CC7519@MW4PR10MB5881.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnJlIzEIEu8eL30CsfVfY7XK0FpfA0n7vuRDONUCE9A1t2XFR3V41M99nSW/s3ajZToMyeNgQ5BUMm61+sBDsSiZV8dDmVrTHV/vTTDA174C46RtQxakkuoTyUaIyIV9QwklLh552bKxAfJNteYUqL6DAbDTqsmgHEDTxfXA2Hib5XNSFYMYifeVEr8zb8hRvVI55+GpJ8c0R0CZD0l6wqQyTPHD0p0fLbbttzw7kQ8CVaZuoZr9Ha9mAjbcq+Fw9ltiHi92Ohl0aGRHOF30qe1THM3B3aZP1i2X5n5f1cFAOysiJ6YCPpB/4UC2ei+2pPjyiICKuFZkPFoTJqwZvVIawcJbBD4muzVSSc+8bhxhf4zEU9Zk5s7ITWc6IR5u4zAVEfFfvrFCOtEgLZUNBp1hMlv66kI35oxCpTHh5WlXg9ei/IEdvF9LDoItLAHYAx2LVWig+ZmZEcb5nSn0e6vqX9PDsI70XECWI803Hdy28UC+l7QOPk4IiWrA345ZEVAxRZVN/JOcvIlsZ6PIlKz5yx2Tgdv9ZFLGZSwpDwm09Ml5KnTJB+YCXSdbIwUfXBZrDi/+ceVGNu+VrzvPaYGHeA8lvkjattBmg/4h8+FMzIOmhC8TK7pmPXBzgReAg4M6d7iyfQcVl3G9EPrkA196DRbr2FHpkkn3qkR1w217ciH3au2MucY+7Kt0t4qkEdH4T4fyXkTZVYbVndhqvGmnzgt7L+SinhfHZ7KoKPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(26005)(6486002)(921005)(2906002)(38100700002)(110136005)(86362001)(5660300002)(54906003)(31686004)(53546011)(4326008)(508600001)(186003)(6506007)(9686003)(6512007)(66476007)(66946007)(36756003)(66556008)(8676002)(31696002)(6666004)(83380400001)(2616005)(316002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTQxUUlSVURLRVVuUVpMdlFPVkN5b0VvVGRlV2RJZHV5SjU3bEd5UHpQcjVE?=
 =?utf-8?B?OXRyVTJXaTFVVjBUQXdXTE5qTWcxdVIzQnE1aGtaYmVYenV3cE9hUEZjTm1O?=
 =?utf-8?B?dGRweGpPdWFJSGlXRFpsRW9BMHYvRXZUb3dxYVpnSDZEWTEvTVRQWVFNdDJT?=
 =?utf-8?B?NFBWTFlpSVdFWTN2b3FQKzEzbkY0NTR0cm0zWDJZcy90TVYzYldBQkFPY010?=
 =?utf-8?B?dk83M2w4RXl1M0VvaVVsVWFpUVREbW1vUlkvbENoTUJ0aUZBdnRSTVEyUUM5?=
 =?utf-8?B?V0pwTEpNRjNXOVAzNlhpTzExY3BLQUZlZ2Rkc21ja3Ywd3U1UkI3MmR5c1A0?=
 =?utf-8?B?akdMT2lDWlF3em9tUkhvUTNSSjYwRW4vMmpway82Z1VTM0VkYXFscW9jUWJN?=
 =?utf-8?B?MDZ1YVMvVFd0VWRzY3d6ZkNLV1lQTWZDZTEycUFzZmVKZXhscnAwTERhMjcw?=
 =?utf-8?B?NVM3aStDaEVtOG0zalRmTTZXNjZPb0lXbVNQWVkrRVUwTU9jTWNoYkVnOWFu?=
 =?utf-8?B?amIvR054SUxlRzdzajVUWWlMYjVBeERkU1dKblBUN052WEtZNkJDbXl6R3l1?=
 =?utf-8?B?Y053S0NwY2dLWFdpd2RqSldrVWRVVXZsZzUxdkFVS1dkWFhhcFNtaUk3c3dy?=
 =?utf-8?B?L05sYmpaVE9ROU85Q3BWVnEvU1p2U09VY256eUNIZVJueG1nSnVPMzIra3pu?=
 =?utf-8?B?bHNqYVNJY292djRZZ1Fma0puQlpaTys0dlJ4c0t5VGw4TE9LeXBwTVI1a1ZT?=
 =?utf-8?B?bDlFRm4wOFpJREdGZzhWOExib2YvSGtFZkgvOVM4d1hnTXhkYlVReGhBQ3pr?=
 =?utf-8?B?WGhXUzhkUDI0ZFVJcElNRm5mNERZQ0ozdFBReDNONnltVkd6cTR6N2dJblJV?=
 =?utf-8?B?c0xBSHdPY2JGdm8rVS9icTIvNXQ5cFZ1RCtXQ1RPSUxsQVljbk9Ka2Y4M1Zs?=
 =?utf-8?B?Tko0c3V1TmJMa2poUGhtMWh3UHNRL2djYTY1UHdxWTY5Lytpbi9tVzlSTzhw?=
 =?utf-8?B?cVY4b3FYeU01U05MRSt5TjNpREVueTRVRnFyUnNRZ1BlWGs0Y3p1eGF0Lzl6?=
 =?utf-8?B?YllyQmJoLzJtaG90RGZYRHBtWmtVaEdTT3FZQm1zY0ZzRUtvU0MwT3d1d0Jk?=
 =?utf-8?B?YnNXdkJ2Tys4SGlCWTB2MWdKVkt1T2FHY012UkFBMHBObzlKUFBRK2hvVmJH?=
 =?utf-8?B?bVJYV0tjbkgzcGg0RU1KbjNvb1RGYlJVOWEydlpaV0dzZWNzS1c1eEVEWWVw?=
 =?utf-8?B?TUxOekhVUVJ3d01jeUNBZDNIZFZZUEZVMEtWTjZxM3hQTTVRSVdmVDgwRklv?=
 =?utf-8?B?emZNUldOVUVlT1hrd3dtV01Zc3FQVExzbzloSVA4dkxpbkl6NHZ6TFZxV242?=
 =?utf-8?B?bEhmMHlwR0NhT29QV0xzVnN2NVFxaHl5Q3U4TWFYSmFJOW03bUNuams2N041?=
 =?utf-8?B?RVJaUE96QW5NVGZSWG9SL21qeG1DUWtEQmhtT0k3alVhSlFCeThwMytITzM4?=
 =?utf-8?B?eTB3cllwdlNkM3JMTkl2cTBPRXJ0RnprVVR5b2p6ZVB4aytodmMxbGFkc3Ir?=
 =?utf-8?B?cHgveWRmNkFLb2hzVTVUbHhTNHRGd3ZmOUduVTRQdTUrRDN3V3hVOGhKdFc0?=
 =?utf-8?B?ZVJhRVg0MlVnMlh2QUFmKzBWMExMTlYraXBJTG9vcDVJUVpZcHZaeFoxRmRa?=
 =?utf-8?B?NTNSajZRU1p5MEc2Ukp1d3F3K1J0VjVVTkRHUFF4WHpOOWNGR0xtQUc5bm5W?=
 =?utf-8?B?Qk16K3pLbmNvRFNsc0VrbFQ1Q1ROQ056VEM3V1ZseDdpL1JVUHhJYXRDelJu?=
 =?utf-8?B?NXlWd3JGV2xydjdqbm9nMXBxUjJWeTBQdEVxN25qNGZEc05EZGlHS2dnV0ha?=
 =?utf-8?B?WXEyYWo1dWdHNnovK2xKenVzSzlpbldjdnRlTk1zR09SVTlxVEI5Ykdnc3Fr?=
 =?utf-8?B?Z0tuTk53b3BMMmRFWU5OMlc4SHgvUDlSN2hrc014QUlkNDQxVFZ0V0JZLzdN?=
 =?utf-8?B?RTNJUVJFeWVpSGdzM0l1NEpXRDNXK2hXeGkrNC9SU0kwU0NHa0Fhdkw5alpx?=
 =?utf-8?B?bXd2VXhpQ0FHemdvQmMrZjZiL29pOFFLWERrVGk1WDY4aG4yM2tXZzhUaXlD?=
 =?utf-8?B?TGFzNmh1andSNkU1RjRFQmR5eVIxWjREakJUNDd0Mk1aOENrNnZwRWJYNHlP?=
 =?utf-8?B?ZnRtT2RBald0L0VkdlA3d3BvcmFxVVNoZGtxWUJoQ1ErUGRCblhNbisxUWVl?=
 =?utf-8?B?RFAvK1o0SU05eEw5WWhCdFpQelFnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc9b5df-ba86-445c-feee-08d9d513a3da
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:04:18.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvMpzqSj4KysZfctzcFAuHGOv2B6QjGym0yB3r+UBEuf6BoSUUcGV8GclGkPvD4MZkZJkSMoWXKQWNYGKfdsq5mKAqyi7veGTwvzzK4Ijic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110089
X-Proofpoint-GUID: ne4JJQq8jTZ1tRniCR_E8E5Hcvd19K39
X-Proofpoint-ORIG-GUID: ne4JJQq8jTZ1tRniCR_E8E5Hcvd19K39
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 7:26 AM, Zhen Lei wrote:
> Use parse_crashkernel_high_low() to bring the parsing of
> "crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
> are strongly dependent, make code logic clear and more readable.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
 >
Acked-by: John Donnelly  <john.p.donnelly@oracle.com>
> ---
>   arch/x86/kernel/setup.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 6a190c7f4d71b05..93d78aae1937db3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -416,18 +416,16 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   # define CRASH_ADDR_HIGH_MAX	SZ_64T
>   #endif
>   
> -static int __init reserve_crashkernel_low(void)
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>   {
>   #ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long long low_base = 0;
>   	unsigned long low_mem_limit;
> -	int ret;
>   
>   	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
>   
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
> -	if (ret) {
> +	/* crashkernel=Y,low is not specified */
> +	if ((long)low_size < 0) {
>   		/*
>   		 * two parts from kernel/dma/swiotlb.c:
>   		 * -swiotlb size: user-specified with swiotlb= or default.
> @@ -465,7 +463,7 @@ static int __init reserve_crashkernel_low(void)
>   
>   static void __init reserve_crashkernel(void)
>   {
> -	unsigned long long crash_size, crash_base, total_mem;
> +	unsigned long long crash_size, crash_base, total_mem, low_size;
>   	bool high = false;
>   	int ret;
>   
> @@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
>   	/* crashkernel=XM */
>   	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>   	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> +		if (ret)
>   			return;
>   		high = true;
>   	}
> @@ -520,7 +517,7 @@ static void __init reserve_crashkernel(void)
>   		}
>   	}
>   
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> +	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low(low_size)) {
>   		memblock_phys_free(crash_base, crash_size);
>   		return;
>   	}

