Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE29446B1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhLGEI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:08:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29820 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234676AbhLGEI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:08:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5Gml012529;
        Tue, 7 Dec 2021 04:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZmZeu7UHMAmuBRHp6RuFDfH9duFuuXRk0rbF7Gol3IQ=;
 b=ZPGK4C/K5yEiFKzaxGfUJIa+Mb/qNL/09PGlUtN0ejUmGjuVfKOSwEmbTMQqq/Sof2FF
 h8Y5BVrrqq7reeJ4/yCWB9/Zl1J55p7r+Bh5VitFwxVzHLDQpiktJFKgns2C9yd620c/
 k1aVgTxeBGS75/ZTUls/qGp9xX9DLpkk38Rse/s3bH8VWChkLxL16YcvIqSjmC+s1bk9
 XK7uDuYPZeakwlGZy/tc/pomN473+ez2+AaziTubIPD2impPoju3/W+ZEgyika6I4h04
 vnaV0pN9deGjryJ/NvMimveHTVux/jr7PkvqwUscl67SsmNKzo9U7mVqZU4FnG1BTe6o Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72c64g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 04:04:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73udYM137806;
        Tue, 7 Dec 2021 04:04:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 3cr1sn8qm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 04:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN83H1QX9qaEOFVHJP20GqwmOpQpVCJAh5RXGdKFZcAJh6lN+yjJx7yjMPMcEkxO5ed/Wu7wVJbuxGq3QY8kly3WmvKz5E+vQP+duadi8gervvx2h8llm7c9/T8r2kxQQkDrbF4mxHx1ZPeNRIddluCQBuUQsRUbrqwFJgwFY1DSESwT1NjNeElvZl5U1TkGwxarUZTdVtgZpPbL39qX+BaAkS/IqtTsc8ZX04xxgPWYayWqnXI7MiVbimZsG7VelxAlSCc/ac5aejwCv7PXvo8UQnOOcvz/ESGHv/Fek0gGGveweqdi38nqZWbsCzV9VVL+0mEsIk9jFjiVQtRhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmZeu7UHMAmuBRHp6RuFDfH9duFuuXRk0rbF7Gol3IQ=;
 b=U97CXiGroElYwX4RIrFK3ghsPCyUS9p/RSwvL2nlQ+L0FKb6M9X98jliKXtztCKVJhmnDv+t6TRzLIMztJ3vITMfZbX1xJReFc2BuqHhegVTM7CngHZHoCNSYepvPnJ8tv77HddVEEO6yo89VnTbDzCVggI5zqkfPzpLMIq7We4z83lzpZkYoZB1ulhTLJYvG3Iogveahet9rC9yYSGlvbEA9AkiOJFukFckYtH6WjQjvb63U6My/jwr4gk8rN12tx/R57Q0hji2xO6Z4R5VOKW42Vy3gdswGn4O4wHj4mxF0pCXZX4y5oGP7p0D+3cs7ZD1IVQDH94mv/t3eyyYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmZeu7UHMAmuBRHp6RuFDfH9duFuuXRk0rbF7Gol3IQ=;
 b=kpZRRc4Wc870goepj6PQxfxegRG9DLIGUQzjth4BBPVnkN2zsKxYw87H5wa+90NpR9MIufo1SpwBzID09WL+YnzkROX2FiFbpl5pvvtMbHg9+MLX1J1I6cYEI73/lHZj3ERvF3GwwZ7N78/UfkeEWJrLQVP2YDlufuckfFi5k80=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 04:04:12 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 04:04:11 +0000
Message-ID: <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
Date:   Mon, 6 Dec 2021 22:03:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when no
 managed pages
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org,
        rppt@linux.ibm.com
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207031631.GA5604@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by DB9PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:10:1da::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Tue, 7 Dec 2021 04:04:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cef2f30-fc96-42bf-6074-08d9b936a02e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4403:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4403914EA0ECBFE16E82C503C76E9@CO1PR10MB4403.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chT2D8Y4O4/MdtgKEghl3mA9SDJPnR92fMm7WL2cA9nHHGeNqVOPR2aW8GH+5vfa4LCq6glE8uXiKAl3YjkqAZ0CKzx3A049fl3Pt9uU5whhrDpB8Zi0zcjxruK/FfVUyo4JjYoo+0aCaTTNtV/FBUAsa8JqIpXMA0x1VeB9xgVTAwY1J8+FKlg1ogB33pgq/4V5LCnYjLm5N8lVsMdvaUnyUNgFA+po+fQBV3cHfzlkv3xP5kzxTN4SyZmhM696oefwui4CQMymUmD6TMgD7ZuEJLK7510O0ksY1JZmiRJL5f/eQ+Py3ta6Ii/HMiVnTJNl4hbWt4ZZVtWbpATxLt1GJpf0YF4CIHFp1EVZMFdtXFuiqOYaO1S0EeGZmkWUf+euz/NgJgGtMG63PBLghzeXMk+PyME2pei+jRAq9b63zItqsVoziBrMqb+7P9AFeHLcVcHILxi/8AXktXj7DUJiRX1SYKSSuyxH2GZ5YYwFnurDkoIPfG/VFOSuqOWhA7TudVjRWUM/JbP1XIpaztluXEWSRYDgm3uUcaysdCo9aNjW1s+FA0tsH/rEFPaIKYQjiXAGgMY4/Qy443u7RXT+Z9hcvrSgXKyHNax2VdrRdwESgiR0NUCvhBS1Wu7zHPXwYIamcFD/CO77718mdbWafxOoB3TJ0DyyfCTjdqpyyVh/P/W3a5WFLAbkPiTxzZnO9/BoJAVhRZZT9SxoBjamkoB3KZSFhoDuSda8iXAL+LIHwLgd6GUnAxWCCk2RnpZ7cmBgZv4wthUTg1sFjAknvB1IfJpPvGi4fGmnCXKwNTiNs1Vgv6heOnCS/M2I9OrHSc8oP0X9RIsx2VN3/kwLi/AmUL4qqIQhiB86zwlCBAWbd/Co59JT5tmPoE63
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(66556008)(66476007)(36756003)(16576012)(2616005)(86362001)(8936002)(4326008)(316002)(7416002)(31696002)(5660300002)(956004)(66946007)(26005)(53546011)(83380400001)(966005)(6486002)(2906002)(186003)(6666004)(508600001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlBUZTFoU1N2bGxRMERXZW9yMXlObzMwU3l6d2gvSXhsY3cydk9EdVhWNDFa?=
 =?utf-8?B?bElSTjFoMk5OZHgvSUgwbnlnbStWVVpickg1UXV1ZTJjelkzVHdwc21jQzhw?=
 =?utf-8?B?WmJVRDh0bmZiVS8zclRFQkd1NzE3Vzl1blp3OXZ3ZXI3SkhBdnZkOFRUSUIw?=
 =?utf-8?B?dmZyOHF5NGNQNkVqRlFLNEZKTHFNWW1JWFZJQ05WUHB2SENTSFc2cTFITnFK?=
 =?utf-8?B?S1NMZmZLVC8xTEg3a3dtT3FvSjhlSnFicmRRQzQrWG5rQWNoV0tuWXcwdXVF?=
 =?utf-8?B?Vmd6cVFZWmdaZVlOTkhURmlBcUZQSUluZVByZmZsUXpvL2xhLzU0M0VXeXdH?=
 =?utf-8?B?TVN1SkhyZUNzY2lsMDhCUWp0clhUbEgyRCsxSWRpbDAvSDl4anlidVIyb042?=
 =?utf-8?B?K3FqZzlYQ0dNODdzMTlZVHhoS2MzYXpUV1RTMjJKRjFjREllMU1Nd09wOGNT?=
 =?utf-8?B?NmhhNzF4UzNsMEplVDRKWFE5Uzd6NlFrcUo1UGl5ODIvUFQ1M2oyQWJXYUJY?=
 =?utf-8?B?eVNma2hPbHdGb3AvT09aY3ZROFZxL2VoeTlQZTVDNFlLZHNrd0pZVDY1dWVY?=
 =?utf-8?B?OUYzUjNyc2JOYXUyQldBYlA1MEZ1ZHB3Mjd2b2FLNWpvRysvSlJmWFJUWWcr?=
 =?utf-8?B?d2dYUzNwY25vSWlwV0FJc3hvQXNCZENrMmw3NDFPY1FwUEFUNTdUcmdjQTVD?=
 =?utf-8?B?V0xoUFdRbUxWeHU0REN3SE5OeWhNSi9zTy9JVHJhZVIrbSswN0tiV09LZnZk?=
 =?utf-8?B?Z21qSmZMMXNmMkgwemJ2QTZPb0VaN1Z6YURmSHFVVzg5SytEUk1CNmk3ckxX?=
 =?utf-8?B?WFZ0VnVLV2lsaGhYdjUyYXo2Y1BGRFRvczBzZzMzenI3a3dSeFM5Q3dtNFB5?=
 =?utf-8?B?WkFDTFRVZytZZE1oeC83NzRJYXo4MlJkM2NSbDFwMWdVZHhOaHlCSWZSTjdm?=
 =?utf-8?B?S3FGbWRIVGxsckpWaU93THpGNW5rb2ZlS1U3MENZdytoVURkWTBTMTdEMzB0?=
 =?utf-8?B?SDhjcnE3eVBQWUdwUHd4eDJXS1dQZVZqaXdkb2RMNEpLWGVPdVByU0ZBSTNM?=
 =?utf-8?B?SVQ3dmZwL2lvbjlCREdibS9RWXZUb3ZhSTFyQU9LeGNTWDJYa1dOSWtiT1lE?=
 =?utf-8?B?bng4NCt2RjdvenZkRWpyQjdpK3FRQk1GNlA4M1V2WFYwZFN4WlFTdDBReHdw?=
 =?utf-8?B?akN3YVZIR3NzdXdQcnZTZThCdDQ3WENMMUlsVWluMk41MW5BVk5NWTF2NnZJ?=
 =?utf-8?B?aTQzTDd2WnV6RndlbXpoZVA0R05JOG9McGpyVll5cmZRdjNRd3pSdlF2NzlC?=
 =?utf-8?B?Rm5GME11Q3l5TEh6bVdKTzgvWWVwYUVKWDE1eGY0eEpzNFNWZzNDZDJES1pJ?=
 =?utf-8?B?aUJJMVhGQ0hlcFYrTGNIU09jNnFxMklFUWwrcGFKc09JY1VHNkJQUnBBOHU1?=
 =?utf-8?B?VHVlQnpPOXpwSDJITno2VUZiK1hxS2JVNUlmS0lTazcxSWs4cE5OeXQ2QkZm?=
 =?utf-8?B?ZlBIT0MvS0phSzRIb003cWNNQzgwU1BhZ1pKVmJRUmVVSkZaUDdoVU1OOVpm?=
 =?utf-8?B?b043R1VVaWRZRnVyZW5YQXpxak1RamhPWERRKy9QZlcyQTA1NEl0VkczdU50?=
 =?utf-8?B?MGF3Si9lUktKaStXYVZqRHN4Z2FjSE8wb0tiMUt2SFpWL2FiQUNzK3RXVyts?=
 =?utf-8?B?SjZSUVNKWHhQcTJxTFZrZld0eDVVMHRBOHpzdHlPUzNSYldPN1grV1FjT1B6?=
 =?utf-8?B?KzllclBPVmc1YXd2TGpqdDJ3QTdacXZSN3F0Wjd2em5DRTU5T1o0dy8xc3VH?=
 =?utf-8?B?dENsWmt1elYwUnVlajEzN0w0VWIwR2syVjdRcmRyTFA1blVZRGpSWVVVbkR1?=
 =?utf-8?B?QjdDd3dmelUzMUtKLzJlUGI0aitLTTRTbDQ4T1hJUzI3SnNpcjdSaGRFQ05h?=
 =?utf-8?B?U294K2dYNXFKOVdoRXhSSlo5WmNDYzRzRVRQNkp0MnMwaXhjSnJxMDByeDgz?=
 =?utf-8?B?TndtcWFBaTREbWx0UWZLM0lZcjlsQlB4SiszTTdobm8yTU90WndIUnpRUFVU?=
 =?utf-8?B?WTkySnVzcCtNcURyNGhLeExtZVJxMzB3Q0hLbytuV2hOT203WkFiYk56STNt?=
 =?utf-8?B?ZTNkMTZGTEFSdlVTR3BXbWZnQ0M3S3BEcGdrNnhrWDRha1g3NG4rUWhXblZN?=
 =?utf-8?B?d1RkMWxIRzlaMmZ6Ynp5SzE1S1pzSkxUbjdzQS9FZFVIWjNCVmhaVWVFeVdL?=
 =?utf-8?Q?IegGTIdVGQpjQzB+FvWkBvTuiARgntJN7PctEIYgrk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cef2f30-fc96-42bf-6074-08d9b936a02e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 04:04:11.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEBMvj2zgKpZb5NZdW8dxFb34F/PcsEdkHFrjyH8GyQtNjbTB9GrxX9ikdBRTns2N6I/FBr+nQC1IHR0BGWAgVtCE4vKo54xUiLDDr2/8p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070023
X-Proofpoint-ORIG-GUID: IHQtcLbAeQiAaWRvL78Z2YdA8RkshnEE
X-Proofpoint-GUID: IHQtcLbAeQiAaWRvL78Z2YdA8RkshnEE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:16 PM, Baoquan He wrote:
> Sorry, forgot adding x86 and x86/mm maintainers

Hi,

   These commits need applied to Linux-5.15.0 (LTS) too since it has the 
original regression :

  1d659236fb43 ("dma-pool: scale the default DMA coherent pool
size with memory capacity")

Maybe add "Fixes" to the other commits ?


> 
> On 12/07/21 at 11:07am, Baoquan He wrote:
>> ***Problem observed:
>> On x86_64, when crash is triggered and entering into kdump kernel, page
>> allocation failure can always be seen.
>>
>>   ---------------------------------
>>   DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>>   swapper/0: page allocation failure: order:5, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>>   CPU: 0 PID: 1 Comm: swapper/0
>>   Call Trace:
>>    dump_stack+0x7f/0xa1
>>    warn_alloc.cold+0x72/0xd6
>>    ......
>>    __alloc_pages+0x24d/0x2c0
>>    ......
>>    dma_atomic_pool_init+0xdb/0x176
>>    do_one_initcall+0x67/0x320
>>    ? rcu_read_lock_sched_held+0x3f/0x80
>>    kernel_init_freeable+0x290/0x2dc
>>    ? rest_init+0x24f/0x24f
>>    kernel_init+0xa/0x111
>>    ret_from_fork+0x22/0x30
>>   Mem-Info:
>>   ------------------------------------
>>
>> ***Root cause:
>> In the current kernel, it assumes that DMA zone must have managed pages
>> and try to request pages if CONFIG_ZONE_DMA is enabled. While this is not
>> always true. E.g in kdump kernel of x86_64, only low 1M is presented and
>> locked down at very early stage of boot, so that this low 1M won't be
>> added into buddy allocator to become managed pages of DMA zone. This
>> exception will always cause page allocation failure if page is requested
>> from DMA zone.
>>
>> ***Investigation:
>> This failure happens since below commit merged into linus's tree.
>>    1a6a9044b967 x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options
>>    23721c8e92f7 x86/crash: Remove crash_reserve_low_1M()
>>    f1d4d47c5851 x86/setup: Always reserve the first 1M of RAM
>>    7c321eb2b843 x86/kdump: Remove the backup region handling
>>    6f599d84231f x86/kdump: Always reserve the low 1M when the crashkernel option is specified
>>
>> Before them, on x86_64, the low 640K area will be reused by kdump kernel.
>> So in kdump kernel, the content of low 640K area is copied into a backup
>> region for dumping before jumping into kdump. Then except of those firmware
>> reserved region in [0, 640K], the left area will be added into buddy
>> allocator to become available managed pages of DMA zone.
>>
>> However, after above commits applied, in kdump kernel of x86_64, the low
>> 1M is reserved by memblock, but not released to buddy allocator. So any
>> later page allocation requested from DMA zone will fail.
>>
>> This low 1M lock down is needed because AMD SME encrypts memory making
>> the old backup region mechanims impossible when switching into kdump
>> kernel. And Intel engineer mentioned their TDX (Trusted domain extensions)
>> which is under development in kernel also needs lock down the low 1M.
>> So we can't simply revert above commits to fix the page allocation
>> failure from DMA zone as someone suggested.
>>
>> ***Solution:
>> Currently, only DMA atomic pool and dma-kmalloc will initialize and
>> request page allocation with GFP_DMA during bootup. So only initialize
>> them when DMA zone has available managed pages, otherwise just skip the
>> initialization. From testing and code, this doesn't matter. In kdump
>> kernel of x86_64, the page allocation failure disappear.
>>
>> ***Further thinking
>> On x86_64, it consistently takes [0, 16M] into ZONE_DMA, and (16M, 4G]
>> into ZONE_DMA32 by default. The zone DMA covering low 16M is used to
>> take care of antique ISA devices. In fact, on 64bit system, it rarely
>> need ZONE_DMA (which is low 16M) to support almost extinct ISA devices.
>> However, some components treat DMA as a generic concept, e.g
>> kmalloc-dma, slab allocator initializes it for later any DMA related
>> buffer allocation, but not limited to ISA DMA.
>>
>> On arm64, even though both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
>> are enabled, it makes ZONE_DMA covers the low 4G area, and ZONE_DMA32
>> empty. Unless on specific platforms (e.g. 30-bit on Raspberry Pi 4),
>> then zone DMA covers the 1st 1G area, zone DMA32 covers the rest of
>> the 32-bit addressable memory.
>>
>> I am wondering if we can also change the size of DMA and DMA32 ZONE as
>> dynamically adjusted, just as arm64 is doing? On x86_64, we can make
>> zone DMA covers the 32-bit addressable memory, and empty zone DMA32 by
>> default. Once ISA_DMA_API is enabled, we go back to make zone DMA covers
>> low 16M area, zone DMA32 covers the rest of 32-bit addressable memory.
>> (I am not familiar with ISA_DMA_API, will it require 24-bit addressable
>> memory when enabled?)
>>
>> Change history:
>>
>> v2 post:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20210810094835.13402-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!beOGaLK9suYILSZ8uvbAt4Xd7raHP_p6tcVTvcnZMWCq_eL1VQxSMIJdw-z6EjaERCi0$
>>
>> v1 post:
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20210624052010.5676-1-bhe@redhat.com/T/*u__;Iw!!ACWV5N9M2RV99hQ!beOGaLK9suYILSZ8uvbAt4Xd7raHP_p6tcVTvcnZMWCq_eL1VQxSMIJdw-z6EgRgBiPP$
>>
>> v2->v2 RESEND:
>>   John pinged to push the repost of this patchset. So fix one typo of
>>   suject of patch 3/5; Fix a building error caused by mix declaration in
>>   patch 5/5. Both of them are found by John from his testing.
>>
>> v1->v2:
>>   Change to check if managed DMA zone exists. If DMA zone has managed
>>   pages, go further to request page from DMA zone to initialize. Otherwise,
>>   just skip to initialize stuffs which need pages from DMA zone.
>>
>> Baoquan He (5):
>>    docs: kernel-parameters: Update to reflect the current default size of
>>      atomic pool
>>    dma-pool: allow user to disable atomic pool
>>    mm_zone: add function to check if managed dma zone exists
>>    dma/pool: create dma atomic pool only if dma zone has managed pages
>>    mm/slub: do not create dma-kmalloc if no managed pages in DMA zone
>>
>>   .../admin-guide/kernel-parameters.txt         |  5 ++++-
>>   include/linux/mmzone.h                        | 21 +++++++++++++++++++
>>   kernel/dma/pool.c                             | 11 ++++++----
>>   mm/page_alloc.c                               | 11 ++++++++++
>>   mm/slab_common.c                              |  9 ++++++++
>>   5 files changed, 52 insertions(+), 5 deletions(-)
>>
>> -- 
>> 2.17.2
>>
> 

