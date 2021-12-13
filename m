Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06F4738A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbhLMXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:38:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53438 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238160AbhLMXiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:38:19 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLAFJx017988;
        Mon, 13 Dec 2021 23:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T/BxLTQxrkfB1sZRk/TRFTrZc3AT8l95Q2nrtQriZL4=;
 b=kcSVilDG79T8xTIxtMK1iJQMOpU0BoYmuPO5GvvPPvqanK0WAJDU7hUpMClubQy9O/CA
 tKG82xygIH2RlXl8WqPlIFy7+Ld/9F7Ur+XHvAFKAkeBJEyLcfbuBGlkPqcYd2GXLPCp
 nUqQU+p9mVgbG1P+oNSgYF8qVk3UepObCwK9fjDPT8xdfDXU6MctD5m5wUpdAK3v2Aq8
 zJSb9GWBF5EPi+Rn0Ze2gJXtfxruraTTj2cR6lecljaHq+6jIOuDo8DSKLBD1VkB18jE
 jtzeDyCqOZk0oJWh907MYZCAhG7JAnwBfQwwNhBqIWV7One/mD1879mwV3O6fkoKGa/o Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5ak9yxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 23:38:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNV2wF079081;
        Mon, 13 Dec 2021 23:38:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 3cvnenwvh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 23:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqPdcldkmO2xSwjMNuxeMn8orx5Y1cjXJLEHM+rcDiS0NTlpVJIPz8vhdbEy9FiJejxIBaZHsoYKeJ0zatB+z6yzCt6uZ/dgqEr9pFc6EY7U8FGsUXiWL1B52rg46ZSEGReZJSJLOZ7vpdZtfFFvOKf/pWkdMPVgkwJIxF4a+DxrAyXh1M3oy0nL/rbItW1dnyFkzjeYEOhXwbYiOYmquXJ80YYjMxqP0djJqjNmk8/PFPPl9czzblQRQ9LoEsLpqe0oItVkRFjbSigxmaHlnBvYLywpsnBXDl3PR32a9prCUywRPhudt6QGX9h5bd/oYeU3z6NfcaKrdayLk+pPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/BxLTQxrkfB1sZRk/TRFTrZc3AT8l95Q2nrtQriZL4=;
 b=DQhppM6xIB+IcX/Ac+YgTv1YLoTRtj2W2snakSvuGYdy/mGu6wMEeitkMAW0Xj1WtKVwcmOt7T9di7CmyCwuxG8ixCBpvPmL1959mXqrbxXoml5UzJ1dDj7E0jCB+QPWGBBJQqNcq/kcIxGldIqnac5XOzGfzYdkU1uJAMQWS1dCUeF2NLhxY+vMFRcvE2m77JNT3p6WLR86j1FwgBcgEjF68naRYeQL9EgLeQ+USIgyKtlcZGSLObv8DFpymOkikT/uUK7WxhQ5QbFyKgc8ZtsSIXpvxWIr7Xjf4xwhhSrDmd+khuHPx6uRgUgo+l1kLiQYicXruyBKRhuHHHTdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/BxLTQxrkfB1sZRk/TRFTrZc3AT8l95Q2nrtQriZL4=;
 b=v5H0FkpwD912X+RwBLSi04c0IXnHL6X97jNUxg4rUOjovx/86LN0XWz8nzL3MJi9h7qEjD0EfIq/5Wwv3bX82DMxVkD3t0MfdWo0Vy9F9OenpfaNlffQ+SELsDmsH0StgEogeUuEjS1ePixbR+W6KceOGKUzFlRqCN5F2Fpt99Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3445.namprd10.prod.outlook.com (2603:10b6:a03:81::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 13 Dec
 2021 23:38:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 23:38:02 +0000
Message-ID: <a7e5e304-4198-138b-b3a5-147a73a093d6@oracle.com>
Date:   Mon, 13 Dec 2021 15:38:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1] mm, hwpoison: fix condition in free hugetlb page path
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, luofei@unicloud.com,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211210110208.879740-1-naoya.horiguchi@linux.dev>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20211210110208.879740-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:302:1::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e517ce54-dc7d-4d05-6a4e-08d9be919a8a
X-MS-TrafficTypeDiagnostic: BYAPR10MB3445:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB344548A0DBFBAD7150A76165E2749@BYAPR10MB3445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvawbPMw6zuoowLB2WHil1fPzM8YWom5GHyI+i5/35XL2GfroPgXtv62MJfYytoYVnMQkR1X5lTd7he49uX53NoVebXusUIEofzp7NwKLz0CnOcPp5IetJkn2JAWbhz3FJvt2Fx8G3WfCA4ieUs//a/7VaOQxiiliXy2kKPOezfTjFLLLqjg+Er7GppGJPvW/pmTUiNOTuTCzSvkI9OnKpUkb6MQa/H3WsXKfXjV+Y7jvBxmCjttQRF+G1tiCJLWOVBMh+t+cy4osEgovKcpflFbcC9k3tt7IRFWyWCv+tJ4epBtak8ZSTxOrYBUr5e4zdtR2rN8Bl59Nj00VSU9NDHyeiNPHoHALOgqjGm6YyiVQzRiupY0qQfMWQc/eJLHZCjsfiwVuHw34vL+wMVV/+h8OpksUcpP7Bwq+VxE7FTzmabxhafHIjS0bkaRdTIeVHBz64PzdIstMBHf/Rl9ELNsPMu+TN/NSSg72CyL8y5NnYCpp9iqyutzUYc3zgGtH7cVREsuHx4gk8OZ9QLvbe2/7NKRPtiW0++adaG0AZS6/Ab9EQ6o2kB3Yy2qUJ+s4/BHrxDBCvY28V1ei17NotJi3/quhkAZVeOq37oH19sneZXbbEr79uHpP//TLpVwWka0V1KZSkvlijAj59LjBNUiNz+hlR6ULravpDSbm6jVMJzl6bdvgx4VN4zNgP2absny5a5IupKrV/MHQ8zlZIkOkoqzPHLtbH92MRMMyu3NIS0z1Sc4MCn/8WX0VFhO9yxuA3JnrW52jZ4w1jaTCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(31696002)(8936002)(53546011)(26005)(31686004)(2616005)(6506007)(44832011)(86362001)(36756003)(508600001)(186003)(83380400001)(66556008)(66476007)(38350700002)(6512007)(6486002)(4326008)(66946007)(54906003)(52116002)(8676002)(316002)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhqUnNIN2grbFFMT2Y0ZmZweWlENnhkR2hVcGpsMWpCeEg0SnhjN3lwb0JN?=
 =?utf-8?B?aE9JaU9hcUlMOXljeDJPQmdKQThZZi9aT3pvdU94UUpOcWU4SW1vVER1M05k?=
 =?utf-8?B?MmpjMER4emVuYmN2eXh2WDBlbHFnOSs3NE5ZYy9RL3pkaHg5Vnh6YjZtNWhl?=
 =?utf-8?B?ZHRlVWhwcTJkNFFwaVA4V3BvTEdoVzBrcWZhY1AvTEtmTkIvcEk1ZWtXeTl3?=
 =?utf-8?B?aGxNMys4NTJoQlNaUElIeDR2NmZCb3NjdHpRcTFrSnZXYjNndE83aXN2Q24x?=
 =?utf-8?B?RUFoMmxKMWowWVE1QXFxZXQwZ2hTU0hxZUNYSi9NVnN6bWxTREI2Y3BFV0pO?=
 =?utf-8?B?NUNKYXdnYkRCTzc1dWVWbVdHUi9LNGtxM2U2Tldta044VWh6VnFPZ0VEempW?=
 =?utf-8?B?LzRvbUh3SEYzaEJBSjFzdkoyeXFFZVltTDlnekZET2FxMmRDczFrbkZRbG5y?=
 =?utf-8?B?eGx5dExVWXNxSlIrVmlLdTdMTjVkeG8xVUt4KzdWRTY5YnJHSkZKYVZqc0pu?=
 =?utf-8?B?dlpzL21DbVRibVdJOTNCQTVFNHpWVkhiMzczNDVNVmFSN3F6VXdwL0tCQmxp?=
 =?utf-8?B?SDZibmNkK1ZibytJQUlPUGFDd2J6S3IvTWNtVmtJaHQvMUZSQ1U2K3R3L00v?=
 =?utf-8?B?dzZRd0RDdW9QZ2RRM1AyM3MvallYYVArQ2FxdjRsYmVSUWQ5OG0yd0tjTkxI?=
 =?utf-8?B?Mll6NE1DWmhEeGVlek45MTEvSlJlMGFMb0RZdFNzUkFPcStDMHF2S1hLNFds?=
 =?utf-8?B?K3NwSjZnNzFVNEYzR1FIK3pPM1FZVG1hNGVrVUhJR0hML1RqcG5pN1lWYVZy?=
 =?utf-8?B?dkQ3NWxYMHdxb1RtMHloMVh2NlZWY0EyOVF1aGw3ZkEvQm9ZSDgyZG9VSStK?=
 =?utf-8?B?NDN6SE54dHhGRDFLcVNnejdCRjV4TUExbVVpdDBiWUxKcTU3eCtNVFYzK3pU?=
 =?utf-8?B?QTFtaFFBWmR2bE5TdkNaTGFZY0diYy9keFJkQnRUUEFJaFJib2NFR1hjR1RF?=
 =?utf-8?B?cjUybjkvUmVhNC9Ld284RnFoUnF5WFJ2V3hHSithNitGTGRHSWs0U0xwb3Vp?=
 =?utf-8?B?d05hbm9oRUt0QllOOVh1NXFtd2t2UUp2NGZvcEl0UjE3VEpGRG15TjJDeDdk?=
 =?utf-8?B?TUVsamloOWcyNDE4U2RLbGdyMDVPU1RFd3M3MFJLVTBHSkVTeSsrNzA1azZL?=
 =?utf-8?B?OGFyY2MwQ0hKOWhPTnEwelpxcmVzTWJHZmRyVXp6enh5T0xmWVpkUHFMMU9Q?=
 =?utf-8?B?YXRJQ1dESWpUdHh6aEtCUHRGR1BPa1owNmN1T0V0TjBEL1hrOEQ0ckVPa2Vh?=
 =?utf-8?B?SnpQOWsydENXQWRGV1R2cTdaendOamtQRGsyZ3FjdlpYUHBFZHdLZklUaWJ4?=
 =?utf-8?B?MVpzMEVKWkFDeForVFhaTkpxREVqdzlsN0ZTVDRQbWRTbmliaFQyMS9uUExI?=
 =?utf-8?B?Mkk2cWxFdlgzaHZ3TXBLNWRPM2ozb3FoTEdYeUhhT0xzMDY2ZUY1bDhFam1K?=
 =?utf-8?B?Sk44T0F6cEF2ejdLTlJpS29aOWZBanNRVHNnZW9ERng3WHBOUjd5dW5DVFNW?=
 =?utf-8?B?TUlBZW5JM2NsWEkzQzdud2RmckRRZE1wcHJuLzB2Y2p4WGRzR21qSVo0azNQ?=
 =?utf-8?B?aitaYWFlRHBneHlkM0RVTEg3KzhoeVhmWlB0MTNCdEczdkNpTzZDUExLQzBY?=
 =?utf-8?B?c05CcjBHeWtCMkNNQklVTmVBYW1LbUtLMEkweXQ4YWwvc3hFSGVGRFdOTHps?=
 =?utf-8?B?SEpVRDZjcjVxS0JUSW52ZnljZHhLMFZNZzAzbmJkbHRjMEoxS21RNXV3RDlX?=
 =?utf-8?B?cWI0alhNYm9qNk4vSlVieXJ0Z0plVDBZZDdCSDFadjhoSjA3SnRwZDBNa1Ft?=
 =?utf-8?B?WnY5MXpiTjJpMkUwcFI2UDgrS0hWKzFTMXhicEhkek9OUlMwb1F4U2hFdmVk?=
 =?utf-8?B?cVZPVVViakFWcHRlUVY3L25xZXdXdTJidVBveTVnQldWQUpNMlk2MDY4M3Ez?=
 =?utf-8?B?VXVzNVV6dWJna2RVS2dVeUtTQUtYVy9lNTVuTTJnb2MyOUdieXlaOXZUU1Uv?=
 =?utf-8?B?SWhnUUdFQmVvYTBTSm54N1hyNFE4b2p1WEFuaGhRdjBSMkFwN2tNSUM1LzZ6?=
 =?utf-8?B?dDkvamM4aVhERUJxRmZwT2t2V3JNWWJmWVZPaHo0MUNBbE1QdlhvcnY2eVcw?=
 =?utf-8?Q?Dy27G5CfV3pCE5jaXr1wWkI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e517ce54-dc7d-4d05-6a4e-08d9be919a8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 23:38:02.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3n8PsmBPwEk5I3kUQImzP3/Qv08EiMPqGw2XVrS7ZNmcfD9moMbzNEkb+xdJ662F0q84DNYmbWvC/mYMF4b2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3445
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130137
X-Proofpoint-GUID: oIwVZwCYGzQ5DYP-EN4K9aKldoLYQy2D
X-Proofpoint-ORIG-GUID: oIwVZwCYGzQ5DYP-EN4K9aKldoLYQy2D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 03:02, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When a memory error hits a tail page of a free hugepage,
> __page_handle_poison() is expected to be called to isolate the error in
> 4kB unit, but it's not called due to the outdated if-condition in
> memory_failure_hugetlb().  This loses the chance to isolate the error in
> the finer unit, so it's not optimal.  Drop the condition.
> 
> This "(p != head && TestSetPageHWPoison(head)" condition is based on the
> old semantics of PageHWPoison on hugepage (where PG_hwpoison flag was
> set on the subpage), so it's not necessray any more.  By getting to set
> PG_hwpoison on head page for hugepages, concurrent error events on
> different subpages in a single hugepage can be prevented by
> TestSetPageHWPoison(head) at the beginning of memory_failure_hugetlb().
> So dropping the condition should not reopen the race window originally
> mentioned in commit b985194c8c0a ("hwpoison, hugetlb:
> lock_page/unlock_page does not match for handling a free hugepage")
> 
> Reported-by: Fei Luo <luofei@unicloud.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org> # v5.14+
> ---
> I set v5.14+ for stable trees because the base code was greatly changed
> by commit 0ed950d1f281 ("mm,hwpoison: make get_hwpoison_page() call
> get_any_page()"), and this patch is not cleanly applicable, although the
> original issue was introduced more previously.
> ---
>  mm/memory-failure.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Thank you Naoya!

In my spare time, I have been testing memory error code for hugetlb pages.
I noticed this issue and had created similar patch.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
