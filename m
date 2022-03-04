Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797FC4CDFA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiCDVOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCDVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:14:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C7B1B8BE3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:13:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224HFU95015297;
        Fri, 4 Mar 2022 19:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JiUC1j4zGhWB5BkicAqzgk7gngm7HilFK1H5PlBYv4Q=;
 b=c+pVeCNWIfYcj6hd8mqyKJrvT8Q42keXc9oBwEarPzc/x4NsvqIwxosXjrWhecB2rVxu
 SBcSglqYEQSNAb1FRb3PZvBmd2UV5qMm2FZCzwrLvu12eO+NBHffJ9TC7l5v+1el+Huk
 /Cfc2TgSnPRXA7C+yKlEI8BAO7+9nDu6Y6tkG2s5RkwNNKLsjPef2jO0ShDZMGkOP5NX
 w26cXK7f3eXYsws8TieWlowjG3mT3boayRBRN2HoPVH4Ivfq44vSEdIxVXQqj8z146OM
 344spQrgGHw21TyiUHMg/FvMsDFx2vi5cfkJKe4tOkPhSUi7Dw7UOm+4bxyFJWMXqTOV Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4ht2p74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 19:32:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224JVPfi081204;
        Fri, 4 Mar 2022 19:32:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3ek4jh34hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 19:32:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYYAePI6aEU/X7OYxRUFo9m7dCQFP7nvO5VosBryzkPapd8JNh+oOa7TVXXmKuPodNhCH2B3Sqw2d5m5m6J8nAygCiEhh15ejQ4OZLsQiEqwLrhaBjLzOZXRb37n0ri0/j0lPnJ8GSvqYFnnCTsKMxSpdejhNp7iwuDtsy02x83u3ffOkh+YWr2M9LakVyDghJKjvIo4e+Ocsk2dCx+oSg303Sn1PFoBxhvGD0yABH2k0frAzgHOfkQrXV2wuUj2oUdODyY8EM8UIvJKjyGUQWOgK667ntP+RAv3yPCApe8FuTN+IPEEqSFEwGe2reiy0S6BxJSgOjmeoDdqW9TLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiUC1j4zGhWB5BkicAqzgk7gngm7HilFK1H5PlBYv4Q=;
 b=d5SKErkSS5+re4PHlbLG4cemSU7o81d8isrF+AdddnXI417LOSgU17OQ+qvoMZhHSUniL5K3l4MRwd6CkEcGIGz13Q67Zbvq+RVIkSJCgPl7vu+iF7qM0iKKtBnQZny0AF5C+7XAhVAkekjOolthfahVUZQKgP1u3ybwE8ZW5Vg+CtPjNOHnX9TUjlsGJfCnSIXsqfcRyn6iwIzNuOAIwRIRlUSAo9rxq19X2SKG2Vc4YqOcR2obfbLcfGFD/xxlYpgYFdXCm3X6axBJqRFzPG00HQ+s1pMn1h0KF/t6dOLoqKJMTylQUD4hfdB/S9vayI6l6KXfu1JtDTPhltnVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUC1j4zGhWB5BkicAqzgk7gngm7HilFK1H5PlBYv4Q=;
 b=vKwF0ODPGpEwjDUP3J2bQBCgWPIN2mVLLPI7sOyV7maRUrXW+sjT0/A52KEqOFfyUCe5w2p3xAbRtShHrI05EdIjPS3RZnAU8syqJ2hbSa6aCalFCXHOOh0UnAlWTIQuqXsES+CRikYFjeCYM5vI9WLJK71H90rfVv1BiVIblmE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 19:32:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::51f1:9cb7:a497:f0f7%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 19:32:05 +0000
Message-ID: <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
Date:   Fri, 4 Mar 2022 11:32:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
 <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:300:ed::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83033292-a5c9-4748-ce8e-08d9fe15aa1f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4596:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45960B85D4BEC56B1C4423E3E2059@CO1PR10MB4596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V5g0qktfH2Y4MHwCVcZI2Tcs2yRvrtn48JoYqsESDqS01F5PtzIBG41f2xoFqSe7G3e9r7079X5h0+hmj69RcZPco1D12RMNkX+aJRQhhPdY3GVVA8SHytswSMuoYcppX3p3eEKzfseeLDUVzh05EYpWcp/PiA5YeVy7oDz2Gt+BADSQCbxougeI3Nqw/iUHtNixbVkUJxTgN552mTVJqq//fgvCpPus60gCu0FT8N620ZH5pm6OncnUe6QvD9LYyyDSzPpW3RzXHLqnT4vpzTzQRpr2mcuwo1+gj+Y0fPtBa6SEIXiA/Ik6yp+KWWSKtB44dmO7NSaLgJfUUACC02TeUFqj+uZMhuqQuIJM2Vqs5iue5fGKiwmGVUTr4rKn2fEqCraXexFIzevn3YdlwyEoTwtt7RZkRkfyHxxqealIlAGahJyUwDTb3CBQ1iokBzIOOZbNgsqBy029Mc1rsYtgmoJPjjoG0GvSm/c+uslfRMGr5HngifatW6u05aTnAoyKFk/MHGkO++0OvvHF5X+84v4BwhDEBA3h+q6QajPqjqZj0Tvs690T7v9xpXi/sbIa+v4ssx2hvgf/cKDof5mh48DAPl3ZpjC2XS5TZr3HgEjAkar1tG4j3E+0wgbeHuphi71f8pYOoUhCxR+VfYM48HI1TXV04aenc1zDC7PAbBM0wfgPJ2XKArq0cKC+0g1mll40tTINgYQQLnDQwWV/s4OE1RaVK4xDQFBw/WRuwclegHkMGKkLpxEPxahcDsuraSoxZ4s1fajxQ0Z1L3BmWsefQScpzUdlSvYIPXGEQ1OveEc+4jfAqtIyAMbNC16KmZ9OIIB4KQPi0WxmzvDYTJA7dfE8zMtu0z4i7xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(54906003)(110136005)(44832011)(4326008)(2616005)(53546011)(52116002)(6666004)(2906002)(6512007)(508600001)(966005)(5660300002)(316002)(38350700002)(38100700002)(36756003)(66946007)(66556008)(66476007)(6486002)(26005)(86362001)(186003)(8676002)(31696002)(31686004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdicjhOYmI2eUdSUnFqdFNBM0VxVlZNNTFXdnlySjFQY25rTUJnc2tWV1Bt?=
 =?utf-8?B?NWxZaGhvdGd1QXRyaVVkcWdIWmd4RldKK0xRVXhxeTFIZmF3RlhSUituNlJp?=
 =?utf-8?B?L3dGQTdiQVlmUVdsdkdiMXVtektMMklsS1ZkckJJWmNjc21WSTFmZEpyaEhm?=
 =?utf-8?B?M0piRUYxMnJGbW5WdFpzamxzaUJqVUNJbFpuc0R1MSsvNEV6c2pRR3RhUkFT?=
 =?utf-8?B?MWhUcmxJWEFGMUdkV0hwSjY3d0lWT2tRS3FBa3VmVXlJbDNjNXplL2ZnM2t5?=
 =?utf-8?B?RFhXb0NzNmQxWlVreGE4eUFDdmZHLy9ZUWJWRGpyMDdqM1lERjBmRHB6QktM?=
 =?utf-8?B?amlZUHc3azVMc2hFdVNNWUMxZFNoempwVEpBK094TllSOWR5bDcxSDlSaEp5?=
 =?utf-8?B?R0k2cEN3WjFScmVWeXlxU28yaCs0bUp2ZlpGRUZwU2dpeXFXYWUwUHB1Y25D?=
 =?utf-8?B?NzdTM0hTQnJuWVA4WkxtR0lSTW1jUnBKWWEyWUkrRjRaTEwvUkhudW5nU2x6?=
 =?utf-8?B?UDJqa0ZNRWRQSUUrYjRpVlVIS0UwTXZwT1JDOWVJSjd4dUg4Ri9jaElkRkhN?=
 =?utf-8?B?UG5CM1RMeU5LRm0zaEhJUEtxejh2UXJ3cUxkSU0vQ1UwN3F3aFhIa2xvcXlh?=
 =?utf-8?B?NzVqU3V2YmMzZ3AyKzZBL0tRclhSaDJOK0dUUUhkR0RHNzZpM0RQWlBHdTI4?=
 =?utf-8?B?dkJtdng5OUFHZlQ4azJjNGFkeWJmMWVVRHpQdkd4U2VHSXdMOXU1WFpoNVFS?=
 =?utf-8?B?ckNyVUZnSm8rRHd6NUhQMnJxZ3RtMG5LQ1phc2RLNG1WMDlkUm13RUJxS2dm?=
 =?utf-8?B?ZTdlZTNnYmpGWGt6ejMranAxRzlja3dhd2JXTVdWc2Erc1JJeE9ock9hL3M1?=
 =?utf-8?B?cXFmZU4zdUJiMk5FTEt0aUxjbGdsWi9LY1NKSXF2aitrck5kalgxMGpvVnp5?=
 =?utf-8?B?eEdNLzhRMlUveHVjcjNJYnhCME1rWi80alM4Uk15QXNZZkR1bFZmcDVBWlNk?=
 =?utf-8?B?aTRNRE5nMnFYaVVKbjVoMEhBS2x1WmpNcGt2NGtCTUdwdXl1Y0VTajArWVA5?=
 =?utf-8?B?c2F5T2N6M2wwQXBDQVJORm9iSU8zY0Y5SjE4bWFCOGFoOWRISFVWQTVZNkYz?=
 =?utf-8?B?d1Z3dE5LdVR2bksydHJCVVd1U0tGR3VzbmIxUG1BVDR6dkkrUS83ZERGWWhk?=
 =?utf-8?B?YnZjZFFHUE5UekFsd1FidzA5QzBJRUFlQ0hjdXFrQVVGb3NhdnhpVkloZVFH?=
 =?utf-8?B?dWRpZTVJQ3dSUk5ncEFHRnBoMXJ5WHlMR205Rk4zTUVLT3c3U2hRKzhlSjJh?=
 =?utf-8?B?UFVReS9FbHdyazBxanQzNUpXVy9KaGhqa0M4UWJneGVORHEyNU54SDhqQUIz?=
 =?utf-8?B?MXNRQ0FMNkc3Y09oeUdpdVpPK2dQb0ZPd2VxZkgveU5uTTk0enJRazFPWGE2?=
 =?utf-8?B?TzhGQTYrRzdLODVNeUFsUHd6NmFVL0E2U0NyOXd4TDRPUnlIT1pnSU1tL1Jl?=
 =?utf-8?B?c0hra1dXajIxMFpUMVpYdXI4MUJCSUpUVlF2eWVZeVNMcU8vMkQyWjRSdjcx?=
 =?utf-8?B?N2hWM09LeXM1MUVoVytkeGtadkh5NVQxbzZzRkxNNXhkZFE4UjFXNXphMWcz?=
 =?utf-8?B?cVprOEdlNEJuUXl3L2FhcDVRTXdhTk9BZVo4SDN0ZVpCem1pRTFRTDFWK0tj?=
 =?utf-8?B?VG54bFZpdGpIMGpaNlowRTBZajIyREZ5QmRsMWkydjM5VUlTbnIwNitMdWdI?=
 =?utf-8?B?a0RWNGVSZHNiQ1orRFgyRFk2QTlST2ZJK3NKc3h2RkI4cEFTenVOYllFU2Vq?=
 =?utf-8?B?UWhnQUdTZDZKM1F1NDN3U1ZZbHNOdnlKZThIV1RSUTU1akVIblpsSG5Ya0VV?=
 =?utf-8?B?R1VWYzhqc1VaTFhZcXd1Mkk2OEV2aUxlbW1YbFNLWFJwbXllMUNvbUpoQnpy?=
 =?utf-8?B?T3IzdkozTWxvSWtnZVlKMjI1b1A2RldIK2ZQTWZxcXI5MUhucmtzaVZJbXhN?=
 =?utf-8?B?SVVQNWI5UFFBWEZocW85Y3puWk5aTlh6UHpXRHFiRWlpQzFuSk9sd3lveHBT?=
 =?utf-8?B?MFhMTEo5WDZkNHJPVVlwUmxrYzZSelBQTkpPNkNkcXlKM3h4MFZHRy9GZXBM?=
 =?utf-8?B?NUdOMnlIQVQwYXhsQU1lc2Nuci9lZVpWRTFnWnlQNnJSRzNDS1VtVnFWY1Nj?=
 =?utf-8?Q?6Hqcw/GqBj0N90ecZ1sBZSU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83033292-a5c9-4748-ce8e-08d9fe15aa1f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 19:32:05.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt6JD1+LHL0v7I5FGSUEuukKPYqnA/cmr5ouYIuqFsRTTZ0nq2+94+nq9jZnLyv0tDJzoH5oJYhwr9BH+xB35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040096
X-Proofpoint-ORIG-GUID: dH80FtfpB8096Q0Hcy55ptt7IQb00p4z
X-Proofpoint-GUID: dH80FtfpB8096Q0Hcy55ptt7IQb00p4z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 00:26, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Feb 28, 2022 at 10:02:42PM +0800, Miaohe Lin wrote:
>> There is a race window where we got the compound_head, the hugetlb page
>> could be freed to buddy, or even changed to another compound page just
>> before we try to get hwpoison page. If this happens, just bail out.
> 
> I think that when some hugetlb page is about to change into other type/size
> of compound page, it has to go through buddy allocator because hugetlb pages
> are maintained in separate memory allocator and they never change into other
> normal state directly.  memory_failure_hugetlb() takes refcount before
> lock_page(), so the hugetlb page seems not change between get_hwpoison_page()
> and lock_page(). So it this new check really necessary?

A hugetlb page could change size without going through buddy via the new
demote functionality [1].  Only hugetlb pages on the hugetlb free list can
be demoted.  

We should not demote a page if poison is set.  However, there is no check in
the demote code.  IIUC, poison is set early in the memory error handling
process, even before taking ref on page.  Demote code needs to be fixed so
that poisoned pages are not demoted.  I can do that.

With this change in place, then I think Naoya's statement that hugetlb pages
can not change state is correct and this patch is not necessary.

Does that sound reasonable?

[1] https://lore.kernel.org/linux-mm/20211007181918.136982-1-mike.kravetz@oracle.com/
-- 
Mike Kravetz
