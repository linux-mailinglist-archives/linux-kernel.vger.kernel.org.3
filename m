Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00764DA6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352829AbiCPAfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiCPAfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:35:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2731227
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:34:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FKiPus011440;
        Wed, 16 Mar 2022 00:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=83SvLhJv1Kj5AN7jG4P3zn+hRHlrKqt+3S5DZY1NtEI=;
 b=X6XsSyZnB+A89500mRbjZVtnYPHRndeig7iD3R0oa6VS8ye+Q/WL30fxtxp/kXRe7B8r
 CyCfzidSuFCEQw0OAyw4TNwDKFa/Zp16WiyH9mN/D40qZLtC1IOjr/1bYjcU/+qrU0pE
 ROZhxaCokUxUgDoxQdQ7qejLJuaxMhMHkq4pta+FVCnRxA1mHqmIUhcXMkyRcO4xNcO+
 UhwWiwKbIuT95X7qrb1aZQ3wP2crmZJ1ArtjAInX+bLdDmYS7hxB6H3AfxuWIFonDX8F
 g3ibBWUNgq5GHlW23bPSsIvtczNHecPQoWxMOM0w5j8fS4lOTtHjUBovDC7MLIMU0+DW CA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6mr89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 00:33:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22G0Wk1A009234;
        Wed, 16 Mar 2022 00:33:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3et64tsr8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 00:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8ozeKvXYlfukxLf+h2bTj45qC3tmeJnMBqD4sQazR23EPl60PlNwtFxlUxHHDZXInZjXbMgLIM9PKOD/PvF/SN89aLF+eyNDKnjUZuSEMulZaMv6rbHmIUa+8klnO8Xo/qjlrLB5IbEP/buY9dqfpvDHjv11mGbbTBh1u0J8Zyv4hCxQdqK2/AQ0RjQcbKTwwRM4wH/4U4TpCOmmLhB52R7LM3NDyN+Yd5fkac9S/5v8hG1l2C3k2PB5jRrzhDsoFk7n/eF8bDe1JoMDzPFGwO1m+soiFfflunmt9Eqrt6tzSpT6WsFLrW3uQOXIp24Jh1fXhUSyKVsezOWlcOPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83SvLhJv1Kj5AN7jG4P3zn+hRHlrKqt+3S5DZY1NtEI=;
 b=FWZY9yjKM9OTnqH+UxdZl8NWE4OJ0iWs/EpVkSX+ofQv6johrPCaqYFrvTJ5h2TDAtiAoofrbYSoik5bb0BGC3OCuwEtxmlLvE6MNgIcUjN5p2UDezXpSvkC0W+z3raXh0HTyVEqyNdHGrvEzTV+NuPdP3J1g0vDqdm2hKegY+ZIDOBOIVK4uUeN5hcw9KKtWvv1EwfH8v7U+XdGfUFd9m6GoIemnFrPAQkzaXXn6MAu248QmoSIBMz1ULrpRhc4FBUoKGBb/sUiABFoAXW/fyt6wf5oKEYwgRPd3aBgA/DTlyHBvdb4YbCdDsPhNj1o7L0W71YjxTRreyjAC70kEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83SvLhJv1Kj5AN7jG4P3zn+hRHlrKqt+3S5DZY1NtEI=;
 b=Ozfj/BEQv07Cw57ykITl4I257wOMwhrox/d+FsffIqZSlrcxYeB/Pf2lojijxMh0SOJ7eNHs0ffzYh8HsOJXXH6pDcnLgAEswOq0ftZB7ubYgBaZ/9+wIxymwUNF/bODdVMdhSp+2HVKIqXi/AaLU+dfiRslay62LOx/R234/vo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3451.namprd10.prod.outlook.com (2603:10b6:5:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 00:33:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 00:33:45 +0000
Message-ID: <68c2b93d-b6a5-5b17-cfb1-722b2d4412b5@oracle.com>
Date:   Tue, 15 Mar 2022 17:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
 <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
 <20220315054935.GA3454497@hori.linux.bs1.fc.nec.co.jp>
 <1770029b-fd59-4eb1-c891-5a2ba4beef9c@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <1770029b-fd59-4eb1-c891-5a2ba4beef9c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12431c9e-143d-44a6-4862-08da06e4a0e8
X-MS-TrafficTypeDiagnostic: DM6PR10MB3451:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3451B621D8942DA33ADAC1AAE2119@DM6PR10MB3451.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvQCeUmsjrqjzBt+qYilI1YYPMGDNvC/m69IKMNw1PWmpfuG7pgGFDrNMep4bEk0GGksUqOaCXkogIaVoCfsaRsv+hSKOoiT6P28PjwYP5ezVSOJ3XBNdLbZXEhEXuqZzZOz4vSCKKsWkC0C/ChoyfBMuhCGtvOWJATUHPqkwhUGNmAyUqguSBC2BnyRmHPhL6jjTJi3g49ASXF86koY2aMEK9JGgTCrmIyGQ7A30hO8vkgQBFMPGi9445fcb1/X1kqgShrCLE4AQtFAdouTX071hZNtUHn94HnhkCv3m4sbGWF0ahIutJUTrlimIGsbAW/Pds3t3bS2bxx1EvPudt4C8v9aIsEArZZDFFGDaatEjNaJYBF84RLdfMTScKGLetS6iAW+TFTm9FwRU+IiYDNUhegkEUxBFwZmqQsw+DzGMWwIbtGz6xidY9jiNAAmu47hPofOXH+PPduF5GDK+h7JGFkHr4veQXv01NLmCjW3bvc33weDT0aUS+0PJMCsScTf171Rbni55R58TLYwA1GV+sOSNxc2IlangwA9XD58zXsk2qMU2OnhS3gWIzHxkMA151/rvrn7iLFWrUOrjkut9F1JrX9O9Kxs56CHnxZIaSOhJx5hcoFkPBq8d4N8JzqJrSetgcHVDTQUCW1z+u3YkoOpy9KaQpzS3BSV6fRclAHxrvNyVBhp+PjdsBmbSwB1xUbIjV3ijQcCiczUiTfVoOxjfWWxa+7pEjMZm/doLydBnddqO7s90wUQskYxd5QSE0zQuzGm7PY8W/z2ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(86362001)(5660300002)(6506007)(31696002)(83380400001)(54906003)(110136005)(31686004)(36756003)(8936002)(6486002)(66476007)(316002)(2906002)(508600001)(2616005)(38350700002)(38100700002)(53546011)(44832011)(52116002)(66556008)(66946007)(6512007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1yUzRWMEM4K2orR0gwcndYT1QxY2dQek1ENGlSWVQ5cE1LS09EbnVLMVdK?=
 =?utf-8?B?WnR4dzhsTEhSRytHQkVNSHp4Z3hOOU1DRGhYK25DN3FDdUF0aDl4b2diZ2xy?=
 =?utf-8?B?L3kyTVpCM2w4K1daZ1FnUnBiRWlLbC9YelVJYk0xSzl5czNiSEl1MHdJNHJB?=
 =?utf-8?B?Tk1zOHRnWENxRGNMaHpGS0VNNVNNdEhGRkVCUkp6ak14dEQ3UkhvVmh3Zjdo?=
 =?utf-8?B?K2ZGZkgrOGl1M1E2QWR2aGJoNlVzV3V6SzFlTUp5Z1A2emYyTktJM0ltb1hC?=
 =?utf-8?B?WVZjR0JoTXBEaVM4MVpxdjU4SHphQjJvWjJtNVNWYU01aVE3RitVRm5VdFVS?=
 =?utf-8?B?WlNnV2QvL3Y5TUVNL1F4V29QME1zd0ZZaXJDZmFjTm1ZS3UyM24zOTdETUE2?=
 =?utf-8?B?TUpWQlVXNWVYWFpianpsczh0TDIvekNTc2hYbjh6T0R1UHkwN3QweDE4NHpN?=
 =?utf-8?B?QTc4ZmNWakx4TWV2dmxwY0NIVkZxQjBtTEcwSzlnN3NvVGRNcVNPOWNyT1dD?=
 =?utf-8?B?SlI5THNHQWxNUUN4eE5OZ2V2RzliMFhXM1hZbW8wWE5ndXVlSldYV3FkRUxV?=
 =?utf-8?B?a2xRUk40VGRsNzd5YkNUd3lOZGdtYm9tVis3OWdSdU5oRFVsZ003RTZNczFL?=
 =?utf-8?B?OWdMcENTdmZualhLbDFITkJ6dE9YbVNiNkNpb0Q1Y3VFcU1lMjcyS3ZMKzBv?=
 =?utf-8?B?bXNxNmRnZTVQTGNyZ3NmNTlib21CdDFqZmJmQ2E0ZWUxNnFpQkFobkVhdlpL?=
 =?utf-8?B?aCswU1M5NkJCSWZ0N2hteU1mSEpqeUJ2L2xJRVFrNHZnR0R2S0lzZDdtVzJE?=
 =?utf-8?B?T09sNmNGSG52bTFTeUV3ODJkRmRqMVcvbVFLbjQzeVhqeitGTWVsUEJXaTda?=
 =?utf-8?B?alBreGY4QVF0ZTZyMjZ0aWR4MnhXSXh0TWxTYUFHRG9rd2h2a1oxNkFhSENh?=
 =?utf-8?B?ZUhaTzlTTFBVcmZLM1hRRnBZU29RdURaNVZ0VzU0N3Q2NitmeldDSWlCeFdr?=
 =?utf-8?B?VjgyQ3VKL2gzbWRpdDFHUVFOSlNYdnVaYmFVWXV5bWhGeUtKRzBJRmpSZTY0?=
 =?utf-8?B?Qmd2dnVieWdRSG5QcDlwamVRQlJUYm85bzNuWmRiZUJrT3JiMkJJQ2EvTVl2?=
 =?utf-8?B?d3RlUkxhRW9tS0FORzJvWG9BUnJ5K1pZMnFtOVJ2MnZFTEwrcklWRXdaaEhV?=
 =?utf-8?B?SitGV0V1NnpnMHRnUkJvQmNiRFRxaHlTYWNaK052dEo1V21pZ2tQOHloU3ZC?=
 =?utf-8?B?TGdLbGZoWmZLQXI5cTgxb2s3UDNFalNxK1drcFFhWVBuU2RyWCtZTXlsMDFE?=
 =?utf-8?B?NUhTSHh0WHF6OTZQNTBLT2ZyT0laTjA0YVNSUzBsemV3MU1WekhKNEpPNHZE?=
 =?utf-8?B?aTZNQWhRYkVWbmZmd3YyVS8xRmFTK2JTNHZMaHB6TzJibEYxc0hmQjhHQlpw?=
 =?utf-8?B?RVVsUXM4UitiNityNHN3NERRclVBcTVyZU51SHhNNGNEV2JXKytJRlB0NE9v?=
 =?utf-8?B?bVQ3TTNkdkdXczJKQjA2dCtabHphbFlpeUgxMWZVT3ZuSFFKaWJHVWlESDcv?=
 =?utf-8?B?aTE5K0JYa1h3Y2gwdGtTQ2szTjBoNDBjRzV2SjEvY1lhTXRmam1QVDEvdHlS?=
 =?utf-8?B?Nkd4bDI3blByZUlHMGd1VVhQSVVWZzJtRS9GWk1EQ2F3Ykpaek1nc3czeDJI?=
 =?utf-8?B?WFd5TVJFRTNpN1JaclFEVkpMclVtbW85clQwRkxYRmN1Zm4ySUorVUZ6WjZ3?=
 =?utf-8?B?OXBxYVF2Y04vczRRd3U0QURXV05mNk5tYStubUhJSnZ2YUJyRzVDc3drRms4?=
 =?utf-8?B?UHdxY3NUZzFYbzQ1dG5PS05EckIxdUZidzExNGZxcW9tMGplNi9sVkkvM2FT?=
 =?utf-8?B?dnZkUlBia3NaczZnSFNTN2M3VGVUM2xDbTNER05ucmd5RWFnWUxxL3QzSW16?=
 =?utf-8?B?dU1lWFp2TTh0UEdvbm1sNTNFSWZzSDI1UExtYmIwdUxZZk40UmxTbnk2SjVp?=
 =?utf-8?B?b1JqYm9QOGh3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12431c9e-143d-44a6-4862-08da06e4a0e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 00:33:45.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM3AvuGazjE9Vl/Xoan4S3yiGrJhNxEL/Jhe3IBG5BsQ92l19Azj239va4ni9Q7TcHbxPIRnnZMy7B9PfnGHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3451
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203160001
X-Proofpoint-GUID: jYiHuz3xPP7g7jKt6sXQWruSZ3k16ufm
X-Proofpoint-ORIG-GUID: jYiHuz3xPP7g7jKt6sXQWruSZ3k16ufm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 07:00, Miaohe Lin wrote:
> On 2022/3/15 13:49, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Mon, Mar 14, 2022 at 03:10:25PM +0800, Miaohe Lin wrote:
>>> On 2022/3/14 10:13, Naoya Horiguchi wrote:
>>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>
>>>> There is a race condition between memory_failure_hugetlb() and hugetlb
>>>> free/demotion, which causes setting PageHWPoison flag on the wrong page
>>>> (which was a hugetlb when memory_failure() was called, but was removed
>>>> or demoted when memory_failure_hugetlb() is called).  This results in
>>>> killing wrong processes.  So set PageHWPoison flag with holding page lock,
>>>
>>> It seems hold page lock could not help solve this race condition as hugetlb
>>> page demotion is not required to hold the page lock. Could you please explain
>>> this a bit more?
>>
>> Sorry, the last line in the paragraph need change. What prevents the current
>> race is hugetlb_lock, not page lock.  The page lock is here to prevent the
>> race with hugepage allocation (not directly related to the current issue,
>> but it's still necessary).
> 
> Many thanks for clarifying this.
> 
>>
>>>
>>> BTW:Is there some words missing or here should be 'page lock.' instead of 'page lock,' ?
>>
>> I should use a period here, I'll fix it.
>>
>> [...]
>>
>>>> @@ -1503,24 +1502,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>>  	int res;
>>>>  	unsigned long page_flags;
>>>>  
>>>> -	if (TestSetPageHWPoison(head)) {
>>>> -		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>>>> -		       pfn);
>>>> -		res = -EHWPOISON;
>>>> -		if (flags & MF_ACTION_REQUIRED)
>>>> -			res = kill_accessing_process(current, page_to_pfn(head), flags);
>>>> -		return res;
>>>> -	}
>>>> -
>>>> -	num_poisoned_pages_inc();
>>>> -
>>>>  	if (!(flags & MF_COUNT_INCREASED)) {
>>>>  		res = get_hwpoison_page(p, flags);
>>>>  		if (!res) {
>>>
>>> In this (res == 0) case, hugetlb page could be dissolved via __page_handle_poison.
>>> But since PageHWPoison is not set yet, we can't set the PageHWPoison to the correct
>>> page. Think about the below code in dissolve_free_huge_page:
>>> 	/*
>>> 	 * Move PageHWPoison flag from head page to the raw
>>> 	 * error page, which makes any subpages rather than
>>> 	 * the error page reusable.
>>> 	 */
>>> 	if (PageHWPoison(head) && page != head) {
>>> 		SetPageHWPoison(page);
>>> 		ClearPageHWPoison(head);
>>> 	}
>>>
>>> SetPageHWPoison won't be called for the error page. Or am I miss something?
>>
>> No, you're right.  We need call page_handle_poison() instead of
>> __page_handle_poison().
>>
>> @@ -1512,7 +1512,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>  			}
>>  			unlock_page(head);
>>  			res = MF_FAILED;
>> -			if (__page_handle_poison(p)) {
>> +			if (page_handle_poison(p, true, false)) {
>>  				page_ref_inc(p);
>>  				res = MF_RECOVERED;
>>  			}
>>
> 
> This one looks good to me.

I must be missing something.  It seems page_handle_poison() calls
__page_handle_poison and thus dissolve_free_huge_page before
SetPageHWPoison.

I could easily be missing some patches, but that is the order of calls
in the code I am looking at.
-- 
Mike Kravetz
