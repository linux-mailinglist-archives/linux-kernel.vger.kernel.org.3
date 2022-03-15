Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105E64DA46B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351909AbiCOVRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbiCOVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:17:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DB5B3F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:16:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FKiQUg003512;
        Tue, 15 Mar 2022 21:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7ynfH6B5qHGhmqVeYVMRVrLcqMK/pRdc0decIXl+Zhk=;
 b=lazogZKjx11aZ77Lya/tV86rN35i1ziQOfx6KNgLFTvFYxJkGBRB3ETznJ1e88vKUTth
 x9rm8wJjrOaiD4a3MLbS4c/gldtgQxiV8TslR7oUgVq2VlHoV525+AAZgSI6+aGmUsJH
 p6N4yyxD4n08pv6pFkW1d/hIIow9z+GD4OSSSLoQ7uU4U9CuKF+oecJtPAn5+n2nD/Rb
 do5PGZovxF0Q3T0fAVmpkr0kTB02RaZsrYnCONFCRqmuZfi11ZgJ+W8WYTaovsCS+4wZ
 sqlwA46BCdWN7HrOSJ+UOGf11zYIny510hrlKjJa+a1iuLrNxPtKmd1lz2pfRRZjaVX8 /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et52pvg4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 21:16:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FLGJrQ164058;
        Tue, 15 Mar 2022 21:16:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by userp3020.oracle.com with ESMTP id 3et6584na8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 21:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haraIcAU4h4MOygTSDhNPnC38rBJokYA0AdDrvY+55S0K997ovIGXogBJ+FtIC9W8eGm1m0SHGFifDUu1xQqNEapKZoywUEz6asmqVzUzadcgzuIZRuQi4V+FFWiAiaZkwf9DVJqjwa7p0PtGUeH+v9tFnT00SS9lSvI+vTQpainHyBttTIK2W0B6h3aovz3IepbcgH3M7cwPzjTJHR7Ew322aVSyNv0DdaAAmh7XV4kOvPnufSBW7VfrJvA3gPlB+mim6+nmiRINfDjHd23MdPXaSwPBoWFoIfuW/y9GQU+2NlqqHhoSw1DM2huQ0GP0Lv+vWboshKFN8oWDHAWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ynfH6B5qHGhmqVeYVMRVrLcqMK/pRdc0decIXl+Zhk=;
 b=VZSEVZgl49zdFcLZRlHg28GtH1Pxq6jLEbfOLBRQiOsXRqeEROdUSuOk4hooxXFjZiiFsZtUP9YWm2Yg2zCqZiIrSdgYjV7UxAEyR1Z3dik3hGrUZTy12H74tc4Pgtl3XdcbNS3GlGp5/868WCrYN05QdW9WEz8zJLtgY/QGzaoi2eNeBxZTGkRmYeYwCMdIp3FpIrpPSCdqHRl70OW+H7aDTC7cTgpkr9aoWPFcLnvu9/SLwGr9SQQmpcraLb5NMBdUaBmtAm+m3Yn0EwcfUX8Bwzhamb08Mtcs/tELWrZ0SOrZuRGg32Kzx8a2lP4VEBlvF7TAUrdsG5poj88d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ynfH6B5qHGhmqVeYVMRVrLcqMK/pRdc0decIXl+Zhk=;
 b=HhrvrejySKxWLdudxotoWrbY0aXt/ETC/7tQQqyGjcMM67ji0RBqaA1UwmIE4yy7VniziE+SMoFozFA+pJ/b7bjGzm4kepKrmRgQqN01bU4EmYa6E13xpmm+Ts/F1X28kGvFZK7PJxgEmdVvlnItlWsT6S37wkdD7jupR0x5XKQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1472.namprd10.prod.outlook.com (2603:10b6:300:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 21:16:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%6]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 21:16:17 +0000
Message-ID: <a56e0ea8-3b11-8239-d39c-ed33e479427e@oracle.com>
Date:   Tue, 15 Mar 2022 14:16:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] hugetlbfs: fix description about atomic allocation of
 vmemmap pages when free huge page
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        luofei <luofei@unicloud.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220315042355.362810-1-luofei@unicloud.com>
 <CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90aa1cfe-b4c2-4d82-e26f-08da06c90ae8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1472:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB147257D8039E7D09E297B073E2109@MWHPR10MB1472.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAp65vjbvvmmjyIU7i+UGiSESqtJ3aFHoQCdoQqI3VslY0SdJVZOsNDwUZNR/87WMrUCjsEB5itns5Mqc77NLOwFsj2A/R4ZPW7Y86SV+JHNXiOukIQ2NEJHsjANmzY3ZK0EWvkUUQsPQg9RJu/TRPG5Q+Frja6Ly5mOssFJQYF1U8dV9mxjIFFWYJ3XQngz0fhLhtOIyVLzGFTTcmkQGDFN8FPH7VMOQvzPvAuF4amjPFUUT7ycS2RXOQzBz4ezr5qQxsTjaKo0jzFThLOgcGnaNEW7aknKMI6uz4UtNA7RWK1V6ETVeMGwosFrLqzihrUdqLvV5jRQp5UDs2tWSKuPwN9WDHd0rof/xu6aYuN7gY+oiiKheKqeKBNxWQ9U82iRQxqnw+/kpc07tEzQBvBnyCMakatGBwdW0z68CbLxMPtBbejAyYTkwPcePHAHfT/IpXIEuJcD6uRQXvQH9TxTYnn7lzZlZtEiGat7NyV28md0Ofwsl2YXbSZSW+oX/HnZUGZsThE4MtIIC6lZJk1b6aCbzyA3CKpFiwSZw97BrNnDqY2XF1n+U+icMbdjy7+CRpZz4I3H/duMWzjXT1+qQs5LFZselxSHDFZX8wBLTO8M0Mssu/f8+QWxYBmZm6G1GL0j13jJJoqJIaIUhf0JsksIV2tVJGzR60yPosWqos1VugZzDN/HAKEASRcsEE+j+ZhmHPg3t8WO4KnlJxQJgUoxybw0k8sZmXJbBP+ND9TtinD7C8AUnwWZ7Z3/6BPwE5YSY/xP3JXxlE5wgusGk09Rd1UvT8rLce1Zlzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(86362001)(5660300002)(83380400001)(31696002)(6666004)(6512007)(44832011)(52116002)(53546011)(2906002)(186003)(508600001)(26005)(6506007)(2616005)(110136005)(54906003)(316002)(38100700002)(38350700002)(31686004)(8676002)(4326008)(36756003)(66556008)(66476007)(66946007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29RQ0NHbWJ3MGJ5R1hST0l2QVdxeFNyaEpteUF0MXUvc0wwakErbUViYkVv?=
 =?utf-8?B?TXRQUlNVYjNKZHpHeStUUjU2enU0MEdEUzZCbmlTNWtqL0ZrOHY5c29FdjRL?=
 =?utf-8?B?VEpjMlN3Y0xROWRUNHFGbEFmS1N4TGMyOHlBZFhNanlpTGRvdTIrSklrNlhE?=
 =?utf-8?B?QUhVWTVlc3plZlVnaDZBZysxRnRMOUswcHV0aVZ1aUpnQWw5eU9LcFJRVlJs?=
 =?utf-8?B?WW5oZ1hJa3luTnk0Rmc4VkFtSERydFdENkxLa2M5SDlIY3ZkNGt5ZCtTYWV2?=
 =?utf-8?B?T3hQVElHdVppdUdOcmI1SjVObmRxOXJRZXlIQVliaVRNb3Y4eDhIcThNMW13?=
 =?utf-8?B?U01VUUltQ2lRQm1DVVhraTJzSzdUbURuVVZuVGFHWkFDUWV4b3dpUHZzSDdO?=
 =?utf-8?B?WmFLckMzTHE0THJqMnFxbDFQdlRpZnkzRUx2V0NCYWZRVElqRXREaW4zWGt2?=
 =?utf-8?B?ak1qVS9ZWGtwTjdEYnNqbFJpcS85d2R3RWJkWW9OOTRCMHdBZWNrS2tBcVZM?=
 =?utf-8?B?U293V205QXZSTXNCOURMc005b1RBVEZXLzN5VjBWbzZYT09zWERKdG83VUs2?=
 =?utf-8?B?RFVVWDg1WkNRWnNvYkM5ZS9VV0hLSGs3VDQ2WXB2cGR6c2tWUHczbS95TFpT?=
 =?utf-8?B?Z3BVaDFJcEdsR2RlL0UvSzVLZlJwei9uME1WUlhXU2U1Yk5ac25VYkJQMGcy?=
 =?utf-8?B?SG9VOWw0ZVQxVlNGb2tNTWg5M3dqN3dXbHRpbjdFUzN5UWtPYk10cEhzWHEy?=
 =?utf-8?B?bEFiM2E0OWpHUk03QUR3YnRCTnM4UmZrMnNLbjkyd1ZCZVAxcjdvUGkyWCtu?=
 =?utf-8?B?UFJmYzJMWkpFU3B0STJSYU5sZ25IVTNOckp6NStvMm5TdXRxcjEvU24vM0t4?=
 =?utf-8?B?dVlQRGhMUjllWWFOWGYzTE8vRCtLMlI4UFpOWER6akhydTA1RmhKY01OMWpK?=
 =?utf-8?B?QmVpWlNuazE1VkxCMlNsTGdTT0U2U1ZndlkzSnRZNzhXNjNFM3IyU2t1NnZ6?=
 =?utf-8?B?MTVTSGlMaGJULzF3cVpLbXhiYmc2a3Fia1RBdHVOSGlpOEgxRFBuVU1VVytT?=
 =?utf-8?B?YWJwbmI2Qm9mdGNScWd5dWx0b0VZcUdOZEp2cnBQOHd0dXgyMVl2RHgrcTha?=
 =?utf-8?B?UjlFL3lZcHhod0NrRVhGdXYrZ2FNNDNSMmpQYUt2T1NuZkRSbGp2Sld6RlVQ?=
 =?utf-8?B?NDR3cHNqRldnL2tkbXRFSnRpUHMwWDJ5RkFiWkdwL2dYUTMzdUdKUllNUCs4?=
 =?utf-8?B?eitNY0FnTkl3Sy9ic3AyeEdKa0JkbmhIdkF0Qk16YWpiZUJDMDVyU2FOTzh1?=
 =?utf-8?B?K2hhSmF5YUNmeTc1RWxZa2taUkIyeThESWkvOTdaUEtjazNISzRoTWlLM2o5?=
 =?utf-8?B?MGgzQURiS1BEQ3M3dEE3Q3VQd0sxemh5VXlCQVZjQm00bTZhWndXRWNxV2JM?=
 =?utf-8?B?U3dlNDhBaC9mTlFiZUM3TXJQVEYrcklDN3dweHNPTXB6Z3cyTU9LbXRIcHor?=
 =?utf-8?B?VmxpaWZaVTVzVVRVK0hZd3YwQ29XeHRpU1QwSStBckF6NXM5U1NiKy9MM3ZI?=
 =?utf-8?B?SUtpUnA0TkREa3BBTHRKRzFLNFpZVUcwTVdzbU5ybGs0Q3paQ3RCV05KUzVH?=
 =?utf-8?B?cDZpb0VFWFV3RHVqV0FQRjBUMS9EcEZCRzBncUc1dkttSzJQYXRSRkNjN1lz?=
 =?utf-8?B?cTFwKzZiODJ6L3EwK3RHM0tsbS9mR2pVRVBTUjl2ZGJTdndBS2g5Q2tJaER5?=
 =?utf-8?B?bWR2OGM3OTMyWEJOYUowTzZtWHJnQk1veTVOOUZNdlBZOStHL3B0K1AzMEJh?=
 =?utf-8?B?QzhINWh6WWx0ZnJGZHV5cktzMlloVmozcFZFNStKS05JZ1BRd29zUVg1aDF0?=
 =?utf-8?B?NEdWbWNaZFhvMzFwQUlUbENQaFRldExURzRIQmVOUEtyQmVEWTNVS0dFWGdE?=
 =?utf-8?B?M0JGMDBublVWdFlMVU5zZ1Ywb09NaEdjRThVUmdlU2JvQVEreUdramU2Um1w?=
 =?utf-8?B?UTB2eDh2ZkhnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aa1cfe-b4c2-4d82-e26f-08da06c90ae8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 21:16:16.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWIxG3Dyj3TJT9zhJ3Jm5EgKwCWOCr1lhW9PtcHyi9XYZUtKpcfNv3mBCnNZyT7ls5q5QZ0E1DPKUgB9jHO92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150125
X-Proofpoint-GUID: 1Ni5dw1X4ovX0nNazX8j35YZZQLZFOfe
X-Proofpoint-ORIG-GUID: 1Ni5dw1X4ovX0nNazX8j35YZZQLZFOfe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 06:29, Muchun Song wrote:
> On Tue, Mar 15, 2022 at 12:24 PM luofei <luofei@unicloud.com> wrote:
>>
>> No matter what context update_and_free_page() is called in,
>> the flag for allocating the vmemmap page is fixed
>> (GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE), and no atomic
>> allocation is involved, so the description of atomicity here
>> is somewhat inappropriate.
>>
>> and the atomic parameter naming of update_and_free_page() is
>> somewhat misleading.
>>
>> Signed-off-by: luofei <luofei@unicloud.com>
>> ---
>>  mm/hugetlb.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f8ca7cca3c1a..239ef82b7897 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1570,8 +1570,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>>
>>  /*
>>   * As update_and_free_page() can be called under any context, so we cannot
>> - * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
>> - * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
>> + * use GFP_ATOMIC to allocate vmemmap pages. However, we can defer the
>> + * actual freeing in a workqueue to prevent waits caused by allocating
>>   * the vmemmap pages.
>>   *
>>   * free_hpage_workfn() locklessly retrieves the linked list of pages to be
>> @@ -1617,16 +1617,14 @@ static inline void flush_free_hpage_work(struct hstate *h)
>>  }
>>
>>  static void update_and_free_page(struct hstate *h, struct page *page,
>> -                                bool atomic)
>> +                                bool delay)
> 
> Hi luofei,
> 
> At least, I don't agree with this change.  The "atomic" means if the
> caller is under atomic context instead of whether using atomic
> GFP_MASK.  The "delay" seems to tell the caller that it can undelay
> the allocation even if it is under atomic context (actually, it has no
> choice).  But "atomic" can indicate the user is being asked to tell us
> if it is under atomic context.

There may be some confusion since GFP_ATOMIC is mentioned in the comments
and GFP_ATOMIC is not used in the allocation of vmemmap pages.  IIRC,
the use of GFP_ATOMIC was discussed at one time but dismissed because of
undesired side effects such as dipping into "atomic reserves".

How about an update to the comments as follows (sorry mailer may mess up
formatting)?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f8ca7cca3c1a..6a4d27e24b21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1569,10 +1569,12 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 }
 
 /*
- * As update_and_free_page() can be called under any context, so we cannot
- * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
- * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
- * the vmemmap pages.
+ * Freeing hugetlb pages in done in update_and_free_page().  When freeing a
+ * hugetlb page, vmemmap pages may need to be allocated.  The routine
+ * alloc_huge_page_vmemmap() can possibly sleep as it uses GFP_KERNEL.
+ * However, update_and_free_page() can be called under any context.  To
+ * avoid the possibility of sleeping in a context where sleeping is not
+ * allowed, defer the actual freeing in a workqueue where sleeping is allowed.
  *
  * free_hpage_workfn() locklessly retrieves the linked list of pages to be
  * freed and frees them one-by-one. As the page->mapping pointer is going
@@ -1616,6 +1618,10 @@ static inline void flush_free_hpage_work(struct hstate *h)
 		flush_work(&free_hpage_work);
 }
 
+/*
+ * atomic == true indicates called from a context where sleeping is
+ * not allowed.
+ */
 static void update_and_free_page(struct hstate *h, struct page *page,
 				 bool atomic)
 {
@@ -1625,7 +1631,8 @@ static void update_and_free_page(struct hstate *h, struct page *page,
 	}
 
 	/*
-	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
+	 * Defer freeing to avoid possible sleeping when allocating
+	 * vmemmap pages.
 	 *
 	 * Only call schedule_work() if hpage_freelist is previously
 	 * empty. Otherwise, schedule_work() had been called but the workfn

-- 
Mike Kravetz
