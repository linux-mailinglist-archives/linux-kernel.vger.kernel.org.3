Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD849D620
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiAZX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:27:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbiAZX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:27:14 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKYjHb005662;
        Wed, 26 Jan 2022 23:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jFKqxR1Lsoh8nc1mwuwLWhgy0aQFuspN0ytq866CHQs=;
 b=v68+rjh4i7w+LKurOeacfROg3kh8QT0nVOLywkz95idLhLxuBecbcW78GFeQGXlzlKsg
 s1rrSIBX8Sn+Q1v4hywyK+dWl9boEaVl3qOXHzBBOh5/QFTNGn26Mo3mjpUVOlmuKwPI
 xL21jbd9gNxYwRMIi/PjbFA95UHEj/ZD29+S10PE4U71DMHJ87pmqn6ybbKLbvpjhM4K
 SBD2shkJvq+hWzQEBeTClGRnrEpI2WmFahdnT4T/yQT1Ntc6UuMLzd4Chi6hliO5+VAO
 +aM3UtccoZdCmSk5vHDiS4WysDKzpH1998uac50OJ2KV1sThG/xYkdfOsdL5wQB8Iyjg Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7aysmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:27:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QNFMR4092571;
        Wed, 26 Jan 2022 23:27:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3dr7yjmpju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 23:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZokHAfhBhUwhm3JRoPgD493ES6B/xXMxAavRXDKR+65eyDeB9GBqlYsL5z5x/nW9lHlYYMSBebQaFUZnaB5fzVGsNt6oRIo/k4sOiuMrXqipkZ7AX+bFr/OFIVw41dTsoAOSD9iyYAXZAAms4w/6iVouHfreie1UWSMov/liH2+Had6klUKmPLonng+67u46Wv9ckQY33h6HeNRaSbvG3bnrYoq3CdcztXcKv6qEBDYhvMUcGNX0pkkX6yOdm25PfDCLnhat/menpp8kSHMKfLwIwbTjcIDE0b50wPhAAegdWBwiQml6E9UYQWKGRB+qPpmvUSCzvbnc0ujK8g+Wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFKqxR1Lsoh8nc1mwuwLWhgy0aQFuspN0ytq866CHQs=;
 b=WvicQciJjykaJ8PdLU7l8tH63bbPhilg0UxmxcAtNwktBzvinCTFcfT0NAcd2DdszFYJuUBzLUT0TNGNFMeSLGkkHu6FNkAsxzN3PPGXf53Wp2RA6SmSB4LMTK2tv9nnGQc5Lx3kIC/1ziMiX3pDJAlqH55274I3RBzYvf/CMGz/z48+WIvV/hPMWmCvoth5Xm2KdqlODyYa0BUXuaOayI3EF5fubp4vMCbkUcRICnQ8B1qFdnMvrBdS1L8QSZrP3pp3sE0sd288pkP0LP1u2UkoP8b3kMYbNuBGjTvlFxbJxO3RDa7AV84EbsWCEK3eak+QrDKkOYkIrE7Okv05OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFKqxR1Lsoh8nc1mwuwLWhgy0aQFuspN0ytq866CHQs=;
 b=zIy3qHmUfOOR8WuE15jF1lag9TtMpMEcklNxXd4q2Tufnnu1pPtaQ6roZyGKm9958Dn9rnWgDgakRIoTPU8s5k5RAccsUC0MWgKkGgUuMhPkhG4M/6rTwXb1GRG2keP6b3DKg0FtLXizwRQTcVO3I4x8lQSu2W8d585uCtpIB54=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1296.namprd10.prod.outlook.com (2603:10b6:300:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 23:26:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 23:26:59 +0000
Message-ID: <3ca19dec-5ded-02ab-184c-89aba4052aca@oracle.com>
Date:   Wed, 26 Jan 2022 15:26:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages of
 THP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Lars Persson <lars.persson@axis.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com>
 <20220124051752.83281-2-songmuchun@bytedance.com>
 <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com>
 <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
 <CAMZfGtXsLyagpo8rM6RmayAFR_hgk0987X1usxYWRZLeA5H45Q@mail.gmail.com>
 <7D7EB27F-DEA7-41AA-B24E-B61A2A1A5F07@nvidia.com>
 <CAMZfGtVCUbTa6xv2R9x+_a5_dK4ZLUX8ECNkF8mkJgEy4kdnfQ@mail.gmail.com>
 <039a9107-756e-bc0a-6e72-fbe08408de38@oracle.com>
 <CAMZfGtXigcVQincXZ6kdNRY7GRwR6E=RD3-pGaiymv87ynoOqQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAMZfGtXigcVQincXZ6kdNRY7GRwR6E=RD3-pGaiymv87ynoOqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e777fbad-ad87-4179-4354-08d9e1235963
X-MS-TrafficTypeDiagnostic: MWHPR10MB1296:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1296BECA9278EC80FBFEC8C4E2209@MWHPR10MB1296.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvQpHXRKCjV2z6Y19RAlv9OwHeLwE9AhBfsz3Fths9rhuDIFdvma+ldix+SQPBM0LeGx3SJArrIlwWxQzerAJaeU97QB8sXWgGtPVW+8WJ2DxOv4PNQk//nH7WhshazUTRAPPdujrFmUkpU7D0X2+52KuYTC1JgAu8/Tv2bBsH7I7ElfQIhFCQNQL5oHKyIu5ooUUe5oPYxehIuPTxOWddPTuU6hX9TfHRr9fhLOPweyO9Ub2ZU7ha9Brmuwa0ZphsBk8rx2koWWmVQoYqL4/W7K8jjU9uHeCYP1kNt48onQtJF/gxQG3S3AXEVp1vmTQSFWCjQOCVzob2C4kWV9LDJtz6iv8FD3cKRqFQcbvEFUmC273pHdDeZvWUQNZ0I/oyzeAovt+l84y0Tasd5XLcewJoPzrZd0LEvr7JlBtTyr5v9jYI/ZMi+e/j1h8peJFyj+3SqoGYu7WguNKVUGGymZGyVOiDy9kT/HDna0V/7eZZe+bHmcfxBK+KE7dJY3k3XrjcE6WGZyqFjulVpN8BV2YBfU7HmsXKiCwb+aW459KuUkUu28Kg8EpIXuNPVhvn4zrWawmayeWjGC4nEcyFhbLNN/WVoNtI65u5s62J3zhjjG4o0goKFURBjZgS63gpockDYNHY67AWIgU7aNidGWsEsy5t5Z1iSxtd9s6xYMLAl5+KND9Ro/zxKSe0cZx74G0D2PArhVJhEzJ9jTzHijw+MBlc9PBYLJdrO9K4nPGjjaACU5Oi38m3MYy0+VCom69rj1EdOLcROPgISF4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(26005)(5660300002)(8676002)(6506007)(4326008)(186003)(2906002)(6916009)(508600001)(8936002)(36756003)(53546011)(52116002)(54906003)(6666004)(2616005)(66556008)(31686004)(66946007)(31696002)(6486002)(66476007)(316002)(86362001)(44832011)(38100700002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndnZG1FQTJ2UmtYN1BJYUhXajJuK1BYMzJ4VTNQL2N2blZIbkZBalViSDIz?=
 =?utf-8?B?bGNmSDU2VmlJcDVGWXBRZ0pNQU1ZQ054TjlaeTdBVm40KzlpbHZzdlR1RWo3?=
 =?utf-8?B?NjE2MVRVOTcwUmVGVzhPT2FBeThQcFV2TU5PTCtCbWoySG5TblZ1bEpMZ1hV?=
 =?utf-8?B?dUErS2krVVhUSjc4eG9qbzRuYjlWRGRGUytUeDRUaWdjRk5PekJmSGNjV3FG?=
 =?utf-8?B?TkxaR0daWVJMSXdCTkpXTnVVclB1dWVYa3I5WC80aGhSYzB5QmhZTXBmMXQz?=
 =?utf-8?B?Zzl3dXpwS2k1cnpHN0R0U1ZNQjFSYmJFU2FpMlliZGVPekZqeFR2MGhoY29U?=
 =?utf-8?B?N3R0Z1hlTjBBZmd6K01QYnFpalVLalpZOHc5K01jNFcwQ2FmOFJTZDd3bWIr?=
 =?utf-8?B?RkNzVHZ2R2ZLTWxWTmsrVUZZa2k3YjYvYWMweGxoRFNzK0cvK0JGZjVldXBn?=
 =?utf-8?B?UDJpV1lTbW5vbVNvSW1MNCtLc05WaDZsK3VCMkFPZ0dYQTgxS2hGc0V5TWpo?=
 =?utf-8?B?NXpFYlp6R3RkN3NRSm9TK0pNcGpIOGhXRHJpMkpwUzlXajNzTC9JVk5KUitY?=
 =?utf-8?B?QUFBR1g4WWxHN3FLQ0tnQlVPakNxeVdKTzltcXJkZW5GWE5EVUd1bGFZdEFN?=
 =?utf-8?B?c0lGSXlDWnlCYVUwMWpMbUdRYkFjU0dRRFM2eWFIUWZKTnl1ZXFjYlR1VUkr?=
 =?utf-8?B?TFhFYVVkMkZJUVQwQTU4K21JVnp4cmovVmllNm11ZFAybkNEbm4yUFRKakdY?=
 =?utf-8?B?cFhSV3p1STR1dmtaV3g1aXVSQ2ZlSzJDVnc5dVdzcEs5M1UzajNjV2FXdWpl?=
 =?utf-8?B?Zi9QVlhYREJ1bmdQdkljeDRra2pkelJUSUh0TEV2NjZoN2RZU3NoSW1jblU5?=
 =?utf-8?B?OUREbkg4cEt6UzdRVTJib0N5bjd3dWd3MjhJTEphOEEwVjlndURJQVhXNW5W?=
 =?utf-8?B?TEZFdldGZlo0YWpXR05iRFIwMkdYb3N2QWV0L09jMGhjVlFLSzVQSEVKaURz?=
 =?utf-8?B?cnNxRnVUcEhCcHk5d0w1T0d5NXJDNjEzT1BKTkhMWWU1ZTBQWmZsMVFHNjJz?=
 =?utf-8?B?Ump0cUhYUWpwSU82WlE4eDlwOWRSSmRFMU9xOU5rUmtuVmxDNlJKRkVYdUY4?=
 =?utf-8?B?VnZpd0haR3NvRjhVWVM4SmRUT1NzQWZmRXQ2aEMvaDFjeUdYekJ6OXdKc1Fx?=
 =?utf-8?B?RjdDWmNsZXJtV1FDZlNwOTAwelB1cjBRUVh6cFI0bkxiZDU0SFUrV1I0WTRP?=
 =?utf-8?B?S2lIa3AyRjhwNlkrbVY0N0VzZldPWDJyL1ZvY2ZPT1JZc3VsQm5VTlpaT0dq?=
 =?utf-8?B?MXR2bGRMRTMvYVl5bFQrYVoxdXhUWk16ZnVTZnd0cm83UUVwV09QNEVFMUpv?=
 =?utf-8?B?SzBoRzFMQVlvdlViVitqY2ZGc0dCV0dqS3ZCbTR6WTFzVmJHM1hYc2t6WXBm?=
 =?utf-8?B?bWo2bG53c2E0dlJvYVFsMTNINURkTzZKOEY5eW4zOFROQ2VCK3hVQUN1anpQ?=
 =?utf-8?B?L256Z3EzZ1RUQ0FBMi9vVmluaDdiYVdjVU5sWDZrUy9nTDY5aUR3WDJzYmFq?=
 =?utf-8?B?UTBaeWkxN2JvYmdzV3dNZ244MG1QTE55ZytPdXVUaEV4Q2pyZ3ZrZXlCZ1pS?=
 =?utf-8?B?clZ1SERKc00xMTZ1WjVCc0tITHdZNDVFZU52QXUzRmxOS3VTNVJidXN4ZDJW?=
 =?utf-8?B?NlkzRVN5eDNmWnJxSHJUMTVrUnpSRlhyM1FRVGVUUkdDRnUyNVppeHNncTB2?=
 =?utf-8?B?SHpLUXNBTjFrVlpLdTZmY0phZzhZSFJXMXJoU0tvMndXMVJWQSthUVl2Vm1C?=
 =?utf-8?B?NWVyVzRIK0JoYXpSNkE3RHFEcW1MM2JGdThCWUpWNXlOK0hRYVJhN0NJSTJO?=
 =?utf-8?B?dUVXZEs4Rlh4NGxKaUVVODRaanV6TEJjeUVZRUdRUkh4bE1LSWJNcFlPeGNu?=
 =?utf-8?B?aUhxVnk3NngzWFFIa2Y0dUV3Um5sdVU1Vk90bExOMDNrcGVPcHhYKzZSVmYx?=
 =?utf-8?B?UTdDMTR2Q2c5aEhmUVlISTNmODBEbWRkdFdvYm1UQmxGVjd4WDlsYTE3WUxo?=
 =?utf-8?B?Y1h3MkNNdy9HS2t1bENiakl4dXdwaFByWWpuTnhDclBybnBUQm1MUTBydWF5?=
 =?utf-8?B?SEgrZkhxTzUvMUVOSW42Qm53OEhaU3hpTXJGYTcxWHZaa1BGaFZvMU9tSjZ3?=
 =?utf-8?Q?pBlorMfvAzCAgmioekdmT5w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e777fbad-ad87-4179-4354-08d9e1235963
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 23:26:59.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmMQvriz6XUXTMdNxDD8KkcYI/5AFc3te9h1XjlOWe3t2s5S9NFExK+m7HAz85aqieoycQOE9C56Pt2KVskcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1296
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260132
X-Proofpoint-GUID: UArRA98dg2lQFuvpRbZkj1K0nWzjxvWn
X-Proofpoint-ORIG-GUID: UArRA98dg2lQFuvpRbZkj1K0nWzjxvWn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 19:29, Muchun Song wrote:
> On Wed, Jan 26, 2022 at 5:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 1/24/22 22:01, Muchun Song wrote:
>>> On Tue, Jan 25, 2022 at 10:42 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On 24 Jan 2022, at 20:55, Muchun Song wrote:
>>>>
>>>>> On Tue, Jan 25, 2022 at 3:22 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>>>
>>>>>> On 24 Jan 2022, at 13:11, David Rientjes wrote:
>>>>>>
>>>>>>> On Mon, 24 Jan 2022, Muchun Song wrote:
>>>>>>>
>>>>>>>> The D-cache maintenance inside move_to_new_page() only consider one page,
>>>>>>>> there is still D-cache maintenance issue for tail pages of THP. Fix this
>>>>>>>> by not using flush_dcache_folio() since it is not backportable.
>>>>>>>>
>>>>>>>
>>>>>>> The mention of being backportable suggests that we should backport this,
>>>>>>> likely to 4.14+.  So should it be marked as stable?
>>>>>>
>>>>>> Hmm, after more digging, I am not sure if the bug exists. For THP migration,
>>>>>> flush_cache_range() is used in remove_migration_pmd(). The flush_dcache_page()
>>>>>> was added by Lars Persson (cc’d) to solve the data corruption on MIPS[1],
>>>>>> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.
>>>>>
>>>>> I only mention the THP case. After some more thinking, I think the HugeTLB
>>>>> should also be considered, Right? The HugeTLB is enabled on arm, arm64,
>>>>> mips, parisc, powerpc, riscv, s390 and sh.
>>>>>
>>>>
>>>> +Mike for HugeTLB
>>>>
>>>> If HugeTLB page migration also misses flush_dcache_page() on its tail pages,
>>>> you will need a different patch for the commit introducing hugetlb page migration.
>>>
>>> Agree. I think arm (see the following commit) has handled this issue, while most
>>> others do not.
>>>
>>>   commit 0b19f93351dd ("ARM: mm: Add support for flushing HugeTLB pages.")
>>>
>>> But I do not have any real devices to test if this issue exists on other archs.
>>> In theory, it exists.
>>>
>>
>> Thanks for adding me to the discussion.
>>
>> I agree that this issue exists at least in theory for hugetlb pages as well.
>> This made me look at other places with similar code for hugetlb.  i.e.
>> Allocating a new page, copying data to new page and then establishing a
>> mapping (pte) to the new page.
> 
> Hi Mike,
> 
> Thanks for looking at this.
> 
>>
>> - hugetlb_cow calls copy_user_huge_page() which ends up calling
>>   copy_user_highpage that includes dcache flushing of the target for some
>>   architectures, but not all.
> 
> copy_user_page() inside copy_user_highpage() is already considering
> the cache maintenance on different architectures, which is documented
> in Documentation/core-api/cachetlb.rst. So there are no problems in this
> case.
> 

Thanks!  That cleared up some of my confusion.


>> - userfaultfd calls copy_huge_page_from_user which does not appear to do
>>   any dcache flushing for the target page.
> 
> Right. The new page should be flushed before setting up the mapping
> to the user space.
> 
>> Do you think these code paths have the same potential issue?
> 
> The latter does have the issue, the former does not. The fixes may
> look like the following:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a1baa198519a..828240aee3f9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5819,6 +5819,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                         goto out;
>                 }
>                 folio_copy(page_folio(page), page_folio(*pagep));
> +               flush_dcache_folio(page_folio(page));
>                 put_page(*pagep);
>                 *pagep = NULL;
>         }
> diff --git a/mm/memory.c b/mm/memory.c
> index e8ce066be5f2..ff6f48cdcc48 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5400,6 +5400,7 @@ long copy_huge_page_from_user(struct page *dst_page,
>                         kunmap(subpage);
>                 else
>                         kunmap_atomic(page_kaddr);
> +               flush_dcache_page(subpage);
> 
>                 ret_val -= (PAGE_SIZE - rc);
>                 if (rc)
> 

That looks good to me.  Do you plan to include this in the next version
of this series?

-- 
Mike Kravetz
