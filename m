Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F74B761B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiBOTMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiBOTM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:12:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5318A6C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:12:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FGtegk010581;
        Tue, 15 Feb 2022 19:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lrTOYRrMkInsfozIWWqwBeZ7Jzs+pqZ324LKIePLsRQ=;
 b=g5Yr1pZoIjfiFN1v4bqBihlkPV+VVZz2U5JBxZIsK/wzXHNMXlk/mKOku6NnW7L/c2a+
 8srudn3QhtdErd0G9dY2gLMJBfksAMH0QkEm5XbzWXOdV9MLnbpBeFBLFFf6KjocfMIx
 4oUvse1XkyEztl/T23f9/PtnFd36tTYQYax1qBEQBqlbuPAsGaMVxQZsapFBQne5XpGi
 8fRys6fRg+rFyIdblqovjM/xMeRuUl2gku418P6ph9pXEmj1GgTDiOjl0UtrnZCXAVwe
 nGsQNPlZ9Y1IOcdkPUzWbnrwfZt3JtwgvcLJGBvudHNIOLJJhyj7wiLs03xfkxXqdpC2 Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e820njvav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 19:11:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FJA7x4043376;
        Tue, 15 Feb 2022 19:11:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3e6qkyny7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 19:11:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkb/3BwJtqaxK2iqpu4yepxEHLC0AdPBxFPqK1xiz+hMsUP6/BYQ5v2U0u/5hox8xwJkRpnJvrtpxPfNMdrNDgBXS7wOwN1Ym2zY5/lSC5nEwkMAcTLzG+aN5nxzFjpmH/yQsqB3F5eh69nW1EfKb4e/ugA6IPXho0yw9iPcgqEj3zyDWgoy/wnVE3DDlPJ/60R66HWvdy1/c53dUfm7MiRHmaPn7cFEhAZ+nuMZoVVC1l4UbIhSxq17wNOJuWCsrppyKm/y917RhIG+LZWsnN+/sP9Oj5WFaSMTSoWX2PWbf0l95DayPc0BG5sDIpP911cQLinBBxzKMnKzmBuelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrTOYRrMkInsfozIWWqwBeZ7Jzs+pqZ324LKIePLsRQ=;
 b=WmoQVoDACAHpFmS1s34DWuIPkHKERFIoN31Zbt8NHm9K4ZvN/ZlUFPfDX5EWRuRC2ZXD0fWE9ZvgllJaDmCNzalVuoziWwIBbE2Z2nGoyfa5hxI7/GkjfIWkE2wvvf0erOoqtmSpuupcK5ZzfuXRSP1Ll9KTR/GePaqlO/G954FfjtgFkDyW8Uw/o2hc5N670jOwvTqhCmpM234UMfl9ZdL6as47qYwkBXwIifQrkA4+jDaEh4apsY9wYwtoT6kssXz2PNKhBb47fdynOMK37FAH0roIn+giFwm9LCTXaUBZsM2jMQyLvlb33cCiY6euVyXwOtBuebYuZqcyBYp86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrTOYRrMkInsfozIWWqwBeZ7Jzs+pqZ324LKIePLsRQ=;
 b=S/cEOeu2zP72aQtvLB2mCXeIFbdmANY/Vdt0Jo7aN6cWqyGPs2ggSR5dZqtIlGBUq4tnBtrMolm63gzo9tNtMxp1WGzfRs9UyxbwaxFW3YBVtlFe6gNUmvEEIjU4+7j1TlYhYZXb8YxAm1/Ag4HZHGXeMSOgItKwqtC7Wl9Qsa0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 19:11:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 19:11:54 +0000
Message-ID: <39ab53c4-cb2f-82f4-1097-65d000284b23@oracle.com>
Date:   Tue, 15 Feb 2022 11:11:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 5/7] mm: shmem: fix missing cache flush in
 shmem_mfill_atomic_pte()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
References: <20220210123058.79206-1-songmuchun@bytedance.com>
 <20220210123058.79206-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220210123058.79206-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:104:5::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f01606-1ddf-47e3-5855-08d9f0b70768
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3906B86828428E0DB7197B08E2349@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1d4Hx8KvJNgsxKU+aUXJeOfNhVk5USrXYcjc/GxRHa9NmhRVOF0TwH7tMCXAxwTfEOMVivCepZCPR0P45EBVhwTqyhTOmygaAZAad2zz0ueJOVVu7DaI1NV92sYVkHU2YPBUEGzwxMqRn8Vg29uglhUj5lULPwZQQevAa72UhH2iXPuE5yoppWm+3P+a/37cbJom39TCSM3LnBFsHxwhhPCd0kkFtSK6W6weAtK2w3voIFd9Cz18a08WkOGOhTCrlUgqvQKsK2j4vVDXvxTqfAz4uYB/fmJbcm2UKpBhExyn1u+CeUTeiQt/HW0gK5b6f1/P6b/bdqN6iVL/ywhiZOgQcH8yqf/d1LaXdutoo9ZYhwGkjEryfXHKEl+SzeypWJ7qXH74v91cgOVo6DC1fBao1QRQJMj1fODxQy0645rbY4zYSyV6f/SKYzP391enrn9pTUkg2916iAb8+L/e7iYeHL9qjXUwBpq+j8VmolBhDWSlwM06LzENMXMIFn+iyDcpcNIAV9go698CU1yBqbVK/DRUBDP5SEbAnRrofaQeEPPA0nhAYx3yqqszvQLgIVr6Z39mjku4OfuRLgxs1Nmw5MOYPzodEE/iRthBPJxFTI2dhUyFLmBmxhFyZqSzcEDxJ1G6ISt5CpN0W+Ro1+VWzpsfjJeY3XuTJqKINZfVFKTav6DSSACHYWseZ6RfSpGL4sEe3JSNcYFrZ5btKEJgo93lNmAE1OtD5FiRCyfVf8MdGv/le0kENV+MkA9Ga5BVl8/H7i4nqcuO+rNF1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2906002)(7416002)(4326008)(5660300002)(2616005)(186003)(8936002)(31696002)(86362001)(6666004)(316002)(44832011)(8676002)(83380400001)(66556008)(6486002)(66476007)(66946007)(508600001)(38350700002)(6506007)(38100700002)(6512007)(52116002)(31686004)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnoxSGtTWVZPS3d5dlNvWjhmWkRMZzVUL0FwbHZ6ck5WVnVNZGdLYlk1Ui9u?=
 =?utf-8?B?ZHd6eGcwMUhjejhRdHYxdzA5TlFhanhqOUZpcCtmVmRJQXBsaGQ3TGRKb0Qr?=
 =?utf-8?B?aWxrZHUwWU9KRkhuMnMyWE40QzAvVGliMlFPbHpBL0JaNktsamNtY1pHZytW?=
 =?utf-8?B?WnZNVmlqc21Gd1ZtRFNvZURFelNySmJwZ3ZhNFU1NFprakU0Y2FMcUZsMzJT?=
 =?utf-8?B?ZlZCeVI1ZWU5dVpTMkUvS3dZNTJ3cUFsVDd5b1ZHUjlxQUM0UzRsZFBmK1g2?=
 =?utf-8?B?b0JRTTVaT2N6SzJQSC93ajRqcWx5emo0TUt5SVk3WUthV1RtV20zN2JnWU5P?=
 =?utf-8?B?SmhGc3hYT2FNYzBlMGNvNjEyamF5dHZIZzZVL2todU9qZGVCWTFZOFNkcVdU?=
 =?utf-8?B?RlZzakR1RXJGbFhNRUtUMUQ4N1BlZThOU0JWN3hqVFhnaDVRT2VzU053b3RZ?=
 =?utf-8?B?WDR3eXkzMnpzRTg1S2UwTXh5dUdRYTNFMmJpWlFsQkFwTEJEek9Kby9jQmxz?=
 =?utf-8?B?THBCUXY1aVhRN0F0S1llTUNPcHdobnpDMVdnYVF3UnR0N2loelRNRnREY0d4?=
 =?utf-8?B?MEE5czNyenNvVVJyTng5RlNlUGpYcitkUFZISHVHL2dkRVY5UFg4S0x3L2cw?=
 =?utf-8?B?OVhNVVNuVDV1ZW0vdXhtbndkNStwV0hWSi8zS3JLT282RUZEcWNPZXRpOElF?=
 =?utf-8?B?dlg1dk5IMm1tRUVCc1JhdFgvV1crd20xZERjQUZGOTgrS3lLdmpOeVpLUEIz?=
 =?utf-8?B?NmJUc2xxNFZtV1pvNG1kYlV0OUZLdWViUklOREc5N0R0UmxSK0h5bThGQVdl?=
 =?utf-8?B?WVdScW12aHF3c0tVUnQ3ZkViYTJCbW9ob05OKzRZT2cydTdvcjVoekpOK2lv?=
 =?utf-8?B?cG45NEp0NFhJTUpBT1dzc0UyVHUzSWVGN1NUNnliZERRVHZKYmdFeEVPUTUx?=
 =?utf-8?B?ZmMySkhsRzFlb0tDY20rby9iSkt6djJidDJOVnhvSFhGdUx5SlNlancxbmdV?=
 =?utf-8?B?Y0ErZEhCaGRwRkN3b3Yyd0sySmdZRFE5VlZ1OXZ1TjF5Um1xdFhaOGpHbGxp?=
 =?utf-8?B?VWUzbmoxNUlKejV0d05ES01pQWtZNEpiMGVWMDJENEZ5a2RKK2JRSS9vekNP?=
 =?utf-8?B?dFA4L3dLMmc5cU5WYkVOS3U2R0JPVU9pN1B6RXh4N1hFV0hpUEVlY1Y5cGpL?=
 =?utf-8?B?YWRZaEsycktQZHhpY3B6cndZRC80Ri85ZXRyUUIrY0xSUXJNOGUrUWNRRjd2?=
 =?utf-8?B?UUpmc0JzOWtNdVlkUkpHR3ZZQkUzVys5TEJBcXlzcjdUMlZWV0lxUUJxY05j?=
 =?utf-8?B?RGpRb0Q0a21nbkRlWmg0Y1NpbDZYeDVXN1R5VU56cWo3b3pBTEVUbmxGNEp1?=
 =?utf-8?B?a3Q1VG9reHNCbnJSSGFxMEg4d2hRdkJudHhDS3JKMmVXMWkwbUVsWW50OURS?=
 =?utf-8?B?bWlOVlZiMUJYa0VpczdLZDRBbXpGcFowV2J3cHlGTDU5by9VWlk5aDVoSkxY?=
 =?utf-8?B?c3BsRFB3N3F6SVViMWlEZU8xOTVKeGJqMVZKamxlL00zZ2E3ODJWMHJjaCtz?=
 =?utf-8?B?NStLS3JiL3ZqQ3lPNmQzTmhrdXZneGc5U0ozbTB5M0g5WW1mOWZsMS9leUZq?=
 =?utf-8?B?MnUyYjJBKy9PaU9IZ2l6S1cvR3RUQ2FQUjIrYlRJOGxUYW93VFBZSE1LY2FS?=
 =?utf-8?B?ZWNLK3FYYjlWQXE0dDAxeVIzWEpUeEpZbFZpUnVBOEh3SUlQUTlUTTBicWpZ?=
 =?utf-8?B?blh6eTZyK2dXdnFnOFZhV0VmSU01anNDTEtiWlluS3pvNzdHMFlCRkdDWUsy?=
 =?utf-8?B?cnN1L2JyRXBqdnQxVkc2NzJaNHNETUVESG5XS1FlTHZSRm90aXBXcEg5NzFY?=
 =?utf-8?B?VE43aHZOcXM1ZjEvVytRVGVVT1pFWWNBbFFSczhUaEFRTU1pb1JEQUhsNUFY?=
 =?utf-8?B?Y2xaUVIydXAzeEVhWEhoNWJJWlVjU09BNURXNEZUWFhRVWxFdGF1eWZrTC9x?=
 =?utf-8?B?NWJrR3daZzFGZjd6QTRHS041M0cvQVpvaG9BeVE2NzNtSHdaNGE4M09tRmJ3?=
 =?utf-8?B?OVU2akFrY09rbFFiODIxRG1sRklVWjZZWGRCanlDbTBkM3RZT1pxU0lVMU53?=
 =?utf-8?B?ZmpudklJc0VWN05SaW5nQTlDMjJoS3pLd2o2cWxFc0ZEL3pVbXZobzNsRWZm?=
 =?utf-8?Q?nWcpPHlOMCzgkw7pmeDa04M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f01606-1ddf-47e3-5855-08d9f0b70768
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:11:54.5469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4pC+rbJyWb+xeucMQDpZhY3d9aQqomM7oC7AvAuzX+iieP07r1LiDcHvlGNLQaDVN3ZwdkOyOxCiJqn80Wt+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150112
X-Proofpoint-ORIG-GUID: kMx1Wr80miPWllpXJQPk2XjYZA4A4kyh
X-Proofpoint-GUID: kMx1Wr80miPWllpXJQPk2XjYZA4A4kyh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 04:30, Muchun Song wrote:
> The userfaultfd calls shmem_mfill_atomic_pte() which does not do any
> cache flushing for the target page.  Then the target page will be mapped
> to the user space with a different address (user address), which might
> have an alias issue with the kernel address used to copy the data from the
> user to.  Insert flush_dcache_page() in non-zero-page case.  And replace
> clear_highpage() with clear_user_highpage() which already considers
> the cache maintenance.
> 
> Fixes: 8d1039634206 ("userfaultfd: shmem: add shmem_mfill_zeropage_pte for userfaultfd support")
> Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/shmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks,

It might have been better to combine this and the next patch.  When looking
at this, I noted the 'fallback to copy_from_user outside mmap_lock' case needs
to be addressed as well.  It is in the next patch.  No need to change.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index eb0fd9001130..2e17ec9231a2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2371,8 +2371,10 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  				/* don't free the page */
>  				goto out_unacct_blocks;
>  			}
> +
> +			flush_dcache_page(page);
>  		} else {		/* ZEROPAGE */
> -			clear_highpage(page);
> +			clear_user_highpage(page, dst_addr);
>  		}
>  	} else {
>  		page = *pagep;


-- 
Mike Kravetz
