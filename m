Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94F4C82A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiCAE5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCAE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:57:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6166617
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:57:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2213QXoj024489;
        Tue, 1 Mar 2022 04:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LJao+ms5p15QT1W5aB9NeYZncCwkzWmTSSzyACuGHiI=;
 b=PbuXiGoZz8h1l3byel+CBWGfpLUPztic5h1Ib3lR5Wj+XDhXuBsLMgCVepj1aKKBxIHS
 NINGzlbXXPZ2kEljo4B4QW/CABfxwfYlTa0IlfgiWkbd8KXBPY85vQmcMMwm4jd3k98n
 XtuBKYpdWfvooHYxixPyCI+2Us7bQXFuH0J4KYHLVM0m+Xgcl2RHCMRt1aOqsS1tl2JV
 uVogqCQ3DvJq8M9YsWGW7sFC8IEpD23eI7uSQa+TW8KrQQtGd9GUkn228SBxqQ0AUX2N
 9LDb6OzkN7X4BPqVLikMwDEI1EdUznUrhXVBFUK37Vn5Fosz0MglDeP1gINj6ukR80XL +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk983tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 04:56:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2214u05q089896;
        Tue, 1 Mar 2022 04:56:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3030.oracle.com with ESMTP id 3ef9awgufy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 04:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRAzGOL40RX5LFXlESdGAPECtSZEJlvKqEPq4lsHkHDuLAEWCUD/JHNlojquJaEJdNpunIj01Jf4dy+hgNuHDi9fTZs/4CRFQIBgbvZRcY8bAaGkbIGtTE46KyvDqFQOXTCOCYYKQiwgXAZfhteZDxPw3gaT/V6yyQVIQgJUqBxtuHTZZmkF3Wpu4OtMKM9Sv26CoyZ3BCrKItu+Z3qOOl+RBUEjR7V/3PlH0QMhC2DEYkeTeU6aSUDQ/fhiHA18RhY2WJn/a6XW2tVGxqka+4OWwipEaEIDF9qxgpLjple4wCpcBjvgGUvuWNDsObpvyM8A5+zBkUOsRnIeRLLbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJao+ms5p15QT1W5aB9NeYZncCwkzWmTSSzyACuGHiI=;
 b=gUMUYIdZt/WdCjZArcvPOlc0yZsEF6rGo2JYfKf7GDmfPEfKsXdfKOjzz2otQk18l61nG0+RQMCqPozJ4jQ8f2angoA3BWQMxF7HGJd/dxqxRXCmOwGEyw9hlx0FmG4AVSVEuN7dpQ4BaxGnKejhyJpP9FkLdO1wvnwJBQNFAkVYngXJ2eLoN0puOdF9xDgN8Bp/TpY+QhQ4EE6pxCyIluKwtO7y7949ZfKcrl/7xrNI2keGZo5qHJJE9smMmOiFjld5AJJdK71SoMfl0kMqs5kmu8h2e/jaA0Y7KBZwbo4kilsHiNQSg8XOFPmtO7JLrpRbEx9LS0mEzqBlkZs+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJao+ms5p15QT1W5aB9NeYZncCwkzWmTSSzyACuGHiI=;
 b=RPn3rG3xw88Y2YBO5uUg9GcnrYYNNFkGHLfVB/Dluw+avIwX1zcfu3PxicM5gjKZi0uwa7TURxrYyc8DNFaMkJTJTWoWWob6FOsnt0cGXkkkx5i5GnD1Rrbbz67krKswikDUSfvD1395pbWtCI21ywIOo/EO07NFFXVAA9wVcA8=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN6PR10MB1330.namprd10.prod.outlook.com (2603:10b6:404:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 04:56:31 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 04:56:31 +0000
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
 <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
 <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
 <8e3e4716-22e7-8684-394c-b5a457906975@oracle.com>
 <a6d64481-cb70-d797-fafd-b827288f7e53@oracle.com>
Message-ID: <1a5a683d-17c8-9730-d2f5-745262430569@oracle.com>
Date:   Mon, 28 Feb 2022 20:56:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <a6d64481-cb70-d797-fafd-b827288f7e53@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2b3718f-4061-48f6-351c-08d9fb3fda2e
X-MS-TrafficTypeDiagnostic: BN6PR10MB1330:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1330272FB136104D25467F0AF0029@BN6PR10MB1330.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reT2WMd8lIHmfGqISUnN8+VkDfxRI99BkO7ah4Cn8tcR04AqUDKpY/6XirloKVPFrRSXpPts8SwK9iYOu8EeB3A1gEdfeCOLgcNVytrKLl5u5mrPVOgtXKteoVv2uNbWMwVi2qTktUHc4SrLW4h/dBBA9nFt5gLldeGXfJbVqfUFTU1k+tDP335otuOloO/fqF5T1uguV1gALFBs+XWBGTyPlm03AyORzum3+cu7K6+FjNPyNWZZfCvJEi8qFyXgLbmd0aerKII/Of4pjMYN7yZWMfkrR+Vr0aIlSz+zXJht51vjEmEb8954TeCF3NQ0tkmvEprm9xFOAxyFQr2xIAWJbfZK9I5sFmCufw/nEBdqEifo6DcBSpIj5Er75diF/z9o/bqT1sWgBUMT3eIrXjwPFpt7jyGstaxrhL/Z517eiRQUOAORPgBWrIqyy8QFqJuknSqWGVdVplJg0p6mlXP2SSg7THEX5a5cVQj9D6NE0l7elu03NQnJy5qwrQhNmr2ZVB2k+B7h8JDH87x5gpgu5VFryoBGh574IkJHoF2iDbzyYFpdXceewThyqxjQEHIYdNX9FrFBxibS7FZb/f5kWzm3pPNvI2sc45VOF2K6iTotIvoIAkLNnXblFqgr5dzoL2/Rv4pMrBh67+T8EAP6YEpjPC6xe6XX1Ldr0qNDXGjRp9d0yOp2vxqokMa6ZlCLMBGU8ujdbspeywXdM2+M8u4ePlgwpcA4BJeB2qM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(5660300002)(4326008)(2906002)(6862004)(2616005)(66946007)(66556008)(8676002)(8936002)(44832011)(31696002)(7416002)(86362001)(36756003)(31686004)(38100700002)(316002)(186003)(83380400001)(6486002)(508600001)(37006003)(6636002)(53546011)(6506007)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2ZGUWplNUd6ZjBmM2VIb1JXb1NXVGNVSUwySG9ZTGdYc2l5MUZCVG5TWk9w?=
 =?utf-8?B?STA2Vm9tcFppK0N3d2Nud05xZ1dkbnhhTXZmQThOOWE2ckZjSFcyV2Qrc09Q?=
 =?utf-8?B?MEhYRDFYWmFxYmZNM3piNnVMK2ROL3lTWXlVMjZ0Wm9pTGRRSldIOXFQQ29v?=
 =?utf-8?B?L1hyMHZPcmg1SXJBaUtPTXJuRW5QcHc0TjFoZnNsV0swR2RWbVA2QlhPNXF0?=
 =?utf-8?B?Z29GeEpXRnhIY2ZOVG1zOE9Ecm1UUkp3TXgvTEQvdzBEWS95SDIxWmg4UTBk?=
 =?utf-8?B?Y3RKa0xBTGY4UzlTanZSV09uc1hDOUtkRisrTC9FL3psOFFkdi8rbW03OGNX?=
 =?utf-8?B?OG1JeVNiQytabDJNTGM2MjdFWGhFY25MZlFUSmZpbVRmdXZQRjRyYmF3NWJL?=
 =?utf-8?B?VG5LeDJ2cFV4WkhsaDdnd1V1RHg5eDdqRnV0S1lJVzNaNlJVeTNpelFtTERY?=
 =?utf-8?B?QlZLZHBlWFF1ekh4Q1pwR1Ixb0xlYS9YQ2JZcXVXU0pRZVUwWTBQV1hNSlZ1?=
 =?utf-8?B?UmFDRlRZR09BMUtyWUdkUk03OGVLRC9UODVJUXZOb2FhKzlwRFdwOHV0MkVE?=
 =?utf-8?B?a1VURWc2R1RWWjFhSTJQV1JyY2N4YXNzcGc0b3Q0RGJPZkFVVStiMXpRakNR?=
 =?utf-8?B?cXVySzU4QlBIU1crbmhaUGFmOVNVbVFlS3ByUEtEUlhZVGtGak1nRHZFK3Ra?=
 =?utf-8?B?UTVUM3pPZGFmOXp2YXBkNC9XWjRIaUkwRUZmUnhzYWlDb3FxSjErdjJSOVpp?=
 =?utf-8?B?aW45ZDZrNW90Y3U1c1ZoYzJWcVkyNkM5eUNkYnJKWDN6aVpMOXFqTk9tTjh3?=
 =?utf-8?B?NHJvcXEzU09JVkhURVdpMWoyekdGMmt2cXZ3MVhZNXZHNFI0OTMrUHVLeURE?=
 =?utf-8?B?Um1FUC9BTlJQQStOVWxLRDR2SkRRU2hpNU5FaGhkODhsaEpRZFhudndtUEhJ?=
 =?utf-8?B?dUF5aFZzYjNXYzMxMkpBYVFJWXlGbHg0YS8yci9OSkcvZk1YbVZvemtyRHE0?=
 =?utf-8?B?eUk2VkR6cC9XNjNXLzJaaGphMWQzT0RGUXZTYk1xVm0wSDIwemNZTlB6TlRl?=
 =?utf-8?B?LzNpREhTVkw1a0JsRGc1U1FIMUJyZVYwZWlxc2pkdk56UFJETEFOcmN6bVdu?=
 =?utf-8?B?RzhnT3JGNHl1VDd2WTcwOVdTRElIQ1FSd3pzVWo5ZWc3Uzk1Zi95bVZFdFNx?=
 =?utf-8?B?Zlo1T0JpSmNSZ2lnVWYwcDFUMVFOREpuV2RkdGVTeGFlYXVtTjlxcFBTQlo5?=
 =?utf-8?B?bUxUa0RsYk8xZVVuRE0rZFFqcm82dmZUYjVvMnUwWVRVSjJ4d1pkYlI4RTlo?=
 =?utf-8?B?WkFxUG5LTVhYNUxrVGgzSi9kOW9Zc3Z1WGFqWVZwZmNNcXBoVHlTdEF3NUp4?=
 =?utf-8?B?R0JpV3NqQnBVK2tvUEY0VkxlbWVtTHZyd3Y4WjYwazloZVh6dmVZdnB3NElo?=
 =?utf-8?B?MGhhbEM5QVNKNzBxdU1NSlRPZS9lVmNkaGRVeFM5SStFOUZKZDJISWUvaCtF?=
 =?utf-8?B?OFQwNzhjSzVnb29ZNExoRnFRS3FPallVQkFIWGphVEY1STVlU2g2aE9HSXpV?=
 =?utf-8?B?Z2JEUENYTXE0cTVmbElOai91TzRpV3gxNGV1bEFnTTNRbmZ3RFYzdXhOYkJD?=
 =?utf-8?B?L0JUWGM5cmVzZ3FCbDhlVFh6SlVwVHpyN1lMeVFJa1FHYzlwdHF0T2ZPVU9R?=
 =?utf-8?B?M3VKUkVwcEdEUFkvbTZDaFVIZmZVSjVidkxPWFNUWXMvelpYcUxFVytCVFVZ?=
 =?utf-8?B?OHBUTUtIcUtETnFDci9iWG1JUytKbkZjWWQ4em9LRlJEWnhDTzMzOGxnNkk5?=
 =?utf-8?B?OEtZMmxuV1dRVTAxOHpjVVlHVHJudTRXUmZRdzRQUmhjcnJLQnJUUUNQU2gv?=
 =?utf-8?B?R3I4cytMUXREbzlUNVp6bDIvZGdMT0xxSGxYL3ZKZFlPd0dQUFo4aEp6UUNB?=
 =?utf-8?B?eFl4ZTN1UHMxQ0R5Mnh0Unh3T2RFNmZsS0QzbEF2N1ZQR2RQMyt3U1MzRUNn?=
 =?utf-8?B?dTA1aTB0azkyTHB6Sk8xcTlaQ3U0TnNiZXN6QzdNVHl0NEl2ZjlGejJhc2Vt?=
 =?utf-8?B?NnZDYVVRKzA2dFRXZTRHTFdINlp6aVJubTMrMFE5NzgrWndzSVFNQlp0YnYz?=
 =?utf-8?B?S0Q0Snk1bG1aK01Jb0o1RHE4VFJCZWRWZXVRZjN6YXppUTVXZnJTZVptN1Va?=
 =?utf-8?Q?HTU38d7Sy7ye60KVUzVMQn3ZClOroy8mkY1yJWke0Qqc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b3718f-4061-48f6-351c-08d9fb3fda2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 04:56:31.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLixfZwBD75iN3cQKSuFDxkz1JO0Jz4EmgtE4Ezbo3yREhDVG9xWz8fAZAanNoKSwXbTJneJVFIf6mZ2JXaajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1330
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010022
X-Proofpoint-GUID: atJlFL40Xc3s-F2DQCPngG5HZCqmuX1l
X-Proofpoint-ORIG-GUID: atJlFL40Xc3s-F2DQCPngG5HZCqmuX1l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 2/28/22 5:18 PM, Dongli Zhang wrote:
> Hi Boris,
> 
> On 2/28/22 12:45 PM, Boris Ostrovsky wrote:
>>
>>
>> On 2/25/22 8:17 PM, Dongli Zhang wrote:
>>> Hi Boris,
>>>
>>> On 2/25/22 2:39 PM, Boris Ostrovsky wrote:
>>>>
>>>> On 2/24/22 4:50 PM, Dongli Zhang wrote:
>>>>> This is the v3 of the patch to fix xen kexec kernel panic issue when the
>>>>> kexec is triggered on VCPU >= 32.
>>>>>
>>>>> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
>>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
>>>>> 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
>>>>> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
>>>>> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
>>>>> ... ...
>>>>> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX:
>>>>> 0000000000000000
>>>>> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX:
>>>>> 0000000000000002
>>>>> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI:
>>>>> 0000000000000020
>>>>> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09:
>>>>> 0000000000000001
>>>>> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12:
>>>>> 0000000040000004
>>>>> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15:
>>>>> 0000000000000000
>>>>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000)
>>>>> knlGS:0000000000000000
>>>>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4:
>>>>> 00000000000406a0
>>>>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>>> 0000000000000000
>>>>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>>> 0000000000000400
>>>>> [    0.000000] Call Trace:
>>>>> [    0.000000]  <TASK>
>>>>> [    0.000000]  ? xen_clocksource_read+0x24/0x40
>>>>
>>>>
>>>> This is done to set xen_sched_clock_offset which I think will not be used for a
>>>> while, until sched_clock is called (and the other two uses are for
>>>> suspend/resume)
>>>>
>>>>
>>>> Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until
>>>> after all vcpu areas are properly set? Or are there other uses of
>>>> xen_clocksource_read() before ?
>>>>
>>>
>>> I have tested that below patch will panic kdump kernel.
>>>
>>
>>
>>
>> Oh well, so much for that then. Yes, sched_clock() is at least called from
>> printk path.
>>
>>
>> I guess we will have to go with v2 then, we don't want to start seeing time
>> going back, even if only with older hypervisors. The only thing I might ask is
>> that you roll the logic inside xen_hvm_init_time_ops(). Something like
>>
>>
>> xen_hvm_init_time_ops()
>> {
>>     /*
>>      * Wait until per_cpu(xen_vcpu, 0) is initialized which may happen
>>      * later (e.g. when kdump kernel runs on >=MAX_VIRT_CPUS vcpu)
>>      */
>>     if (__this_cpu_read(xen_vcpu_nr(0)) == NULL)
>>         return;
>>
> 
> I think you meant __this_cpu_read(xen_vcpu).
> 
> I will call xen_hvm_init_time_ops() at both places, and move the logic into
> xen_hvm_init_time_ops().
> 
> Thank you very much!
> 
> Dongli Zhang
> 


How about we do not move the logic into xen_hvm_init_time_ops()?

Suppose we move the logic into xen_hvm_init_time_ops() line 573, the line line
570 might be printed twice.


559 void __init xen_hvm_init_time_ops(void)
560 {
561         /*
562          * vector callback is needed otherwise we cannot receive interrupts
563          * on cpu > 0 and at this point we don't know how many cpus are
564          * available.
565          */
566         if (!xen_have_vector_callback)
567                 return;
568
569         if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
570                 pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
571                 return;
572         }
573
574         xen_init_time_common();
575
576         x86_init.timers.setup_percpu_clockev = xen_time_init;
577         x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
578
579         x86_platform.set_wallclock = xen_set_wallclock;
580 }

I feel the code looks better if we keep the logic at caller side. Would you mind
letting me know your feedback?

Thank you very much!

Dongli Zhang
