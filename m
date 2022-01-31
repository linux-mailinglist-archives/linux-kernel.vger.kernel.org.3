Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC74A4F65
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359611AbiAaTZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:25:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3924 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239730AbiAaTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:25:11 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VI9JlM006233;
        Mon, 31 Jan 2022 19:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hE6SpM/UGG9eqBO0qEHi8KuhoPCmyLto4bY31kpzXeA=;
 b=aSdxsSp9/OGlx/to2Tc8qzYamVx7MrI/raoeEdxk2e7aXAjXp7aAy9OKE1d8gO+tcVfn
 iIkx9e5OqnKKFK4rX1QEqw1s4CdFj2VXotGQvUGwuqM24NWXf2jSSGOWujZ32EcPCGrW
 jVE4Y4h7oCPAC3dfUJOsmKUsCrROFnTkPpJORFZIEj2UfoMVI/uHArmJZnCrR3+0hCjU
 MMEBbk5xUecPMg4EaIRUnKB/TrKWTSw8zP1QjvqcUKk+kjTXOL3Yvt3GziAq+zJIB8fv
 z6XwAGSOepL/FWk/FW+mFQG9NbLjz+G2fPNgKngyrgSRvGwFm0mj7iMW6z1iFWHRq3Ba /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9w8r3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:24:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VJ56Ho153882;
        Mon, 31 Jan 2022 19:24:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3dvwd4ujse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 19:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP4GCZ+YtZCih0vKWr5393ElLglZO/7dPMb3qSu5+rwLR+rJ9SNtudwkP77BCAyOOgXtGeZyjpLXNBZXKs6JdZftt48g6VMHWw71FLxmJS2FBCxU6UCyFtvZhOBR1qHo4BBVWEmV2zmPXJy3HDyllMHbtInA4F36NMNl56zd01H19Av1a+CeVqnRNNfCMrkjBr6m7hHzfxvGSnpXS/DFzaPDmk3Gj6BfQkZg3ukp7ECimLiG3PDIqRG+cuenAWq3bwwKP+IA9T816WP0jb0vG/qCTCap+ZqscdvjkR8nqWJO9FbuUwG9hmBtNdZUnCMwSx7PtVtfDsmiEB0GSRsYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE6SpM/UGG9eqBO0qEHi8KuhoPCmyLto4bY31kpzXeA=;
 b=lZs3h9icICCNA34rjbuWQrZ8u3vLdcdnx4wPGyqv4WvFFyCT/WiT5he+OqkCV/cG1wfgbl2dlNHixNE93IahMvY0SCmuldRQl7tmgv/6aMbsKBeqnvu13G3bFXbs63o6ZOz4sx/xzTxSIA+mrWXJqk13+JJnkYvRzQtV5fyrgNqT6RmbnertWanEjEoe6TW7+Yr4a3CshBZ6LmNK4FgQryWpPu3p+6RP8Su4pI7Xh2/rXN5w8pidut/v4OGkzjHFEg9/087RGFVF18irRkmWzFFtddPxfCsS1HhyrioGhp0/Rr1kKAJLndGWCGNYHu/daWKLbPl5/6lvQ+21BtfkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE6SpM/UGG9eqBO0qEHi8KuhoPCmyLto4bY31kpzXeA=;
 b=njI1Mcj5UMoHI5QCTDtjx8KSsSMAdtWJaVEnfcQL3C7r+r+0zTaZS1c5lF+Tt3P7ufyMvVB+xPf2vb6auU0FzmXBZCH0QnYt/QnR+ATSfCpWulH/XKws2N259AC8XVoCMBouw+Qg9VohUhD2SWGMXcjBkcF+BXNLqTgG79ZAO4k=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3467.namprd10.prod.outlook.com (2603:10b6:5:155::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 19:24:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:24:47 +0000
Message-ID: <c1b13519-88c4-3e43-eedf-9b848877ade4@oracle.com>
Date:   Mon, 31 Jan 2022 11:24:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/hwpoison: Check the subpage, not the head page
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220130013042.1906881-1-willy@infradead.org>
 <dcfa1ee5-1512-5e49-92c2-4a33ab59080@google.com>
 <Yfb/rVg1HYHkKBgO@casper.infradead.org>
 <20220131054432.GA856839@hori.linux.bs1.fc.nec.co.jp>
 <YffjC9+JsrZB5ekr@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <YffjC9+JsrZB5ekr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db56176e-a98e-45c3-3000-08d9e4ef57f8
X-MS-TrafficTypeDiagnostic: DM6PR10MB3467:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3467AC0009DD512DF0FBB847E2259@DM6PR10MB3467.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcuTextFU73WW0zyCflgazGQWbEbg3dn58wwlazUQSBvWmprs/8k5ZOtPrfF6GTJppZiIgQ7kUrDCwLpK53azQknfNFhyRbKkofT1xdrSWbguWCnorCOqteR+Uv1KBEAQRDdDyHJ4pjtKaVKx2DE2wk2uCm6Fq6nw0m1cssotg+lr+lUxXjQ4KZtOcIfbWIdo7dUOEPXwMWh8UrXLpgAuwGwjY7eBVLZR2YDGJ0qTg10V994lhBiDrXbJ3LlJ4MCJDJ6bjIRcjPOgvxD9Rl48oVSEetjLDcfnTLYMCA1ASwBeGVHepl4Rcr0iUMOih+zWlDoyfzF1+uq/ApF/XEQQXWFTKTDtDcfp5AX6Xl+elwT/SkmrgmDVh037KrLVXhyagxxEHdm3AJvED9xzlXCtqqQ0qXlJNSuyQDZrknVyFDVmPU3UOZpE4/tCTBxZhqGnwSB8Lqx3TayrIXKJR76GFSlEGAUk0D9Q8cP6+HdgMPD/jSC8K+WOx5PWTwfOpRAn2vRrF8kTardDs1tr/K34yi00HbQI/AjzVYD2CdJNAGDycWpopF5uOO7mieY/1w74Usggg5SVAMGPd9ei2f8koWmpR1dF2nOBq2DPi7NJs8r/DRN8iI6lq0l1l3ghrlFRy8EMiBU1OgdJjPulBk5jPpCWIOVYeakdmBkVHiF8GD12HfUaYxmqAjWVH7UdXB5pIYzV6hAurZ3U3HHOD3WeamLcN+M9l36GlnBChUyIx3P+8K0VK/VBIbI/T5WTg4huG32IW26xMzD1EC/KfXZ4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66556008)(66476007)(44832011)(86362001)(5660300002)(316002)(52116002)(53546011)(8676002)(8936002)(2906002)(38100700002)(4326008)(31686004)(66946007)(36756003)(2616005)(110136005)(26005)(508600001)(6486002)(6506007)(54906003)(83380400001)(6512007)(186003)(31696002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWhwK3lWM2ZxUWNZaTdVR3h0UllyRE92WDhLQ3hCbDZzRW45eHY1LzZ5NGdy?=
 =?utf-8?B?M0VjU3l2ejhYWDhsVGg4MitrVmNUazZoNUVUVm83V0VaRVNZTkw4dGJ6Mjk2?=
 =?utf-8?B?Vkg2S3BDaWpQZUk4Y3d0cytFMXdScURpRUV6c0JqQ0pVN0pKT3F1L3ZreDFm?=
 =?utf-8?B?Z0FKa1NmTE9nMTkyRDBjcFJIbUd0S01xNHB2RnlvSWxLL3prWG5sNkhVdUhC?=
 =?utf-8?B?VTFwZlkzZlJUQ0kvOEd2Ky9DbTQvWlZ0Ym16VW5RNFFwSmowbS9KQVE4dTRy?=
 =?utf-8?B?TGJmYmVIMEFNUnlpcW55L1VCbEdIQkpOdllKYXRyM09RK1RPZEhtakNEa3Iy?=
 =?utf-8?B?SzU0Z0g5d1QzM1ltbzkzcXhsV2p0aGJNWEp6N0NEbzdrVDlpS2daRzl0V2lm?=
 =?utf-8?B?Q0EyQ1gvOG9XV1FXZ3hvRFN0MlcyZTBTWG1GRDV3bUE5SlpYbnZZVUVYNklp?=
 =?utf-8?B?UlRJNlY4UHEwUGdMN1JHM3VtdXhKUER3RDZNVzhTL2JYaE9zRC9UV28xWHg0?=
 =?utf-8?B?RjAyYmtFbzZjL2pkSFkvcER0SlpFc1ZIMGRuVjJZR0hBdis0Tll5TnBSWHFO?=
 =?utf-8?B?a3ZxNjFrTmpyV3dqVFlRcCt3NllwUUVYYUl1aVFIbk9BbU11WWwrWlA4Yzgw?=
 =?utf-8?B?ejgvM1ArbWFidlpJVmRMaTNObTJQczZDL2NZTVgxeGw3LzVkdnMwVFpBeVJK?=
 =?utf-8?B?cWdYK1NZN3ZvRHIvWkxoblBBWE1heWdKY2hiTE5nbFlJbW1LMnVzOHpTejI4?=
 =?utf-8?B?djNnemVDRG90cFBkQkdBVkQxV1lXK2E0R1JIS2U2UTNKQ3ZKZWVRMHBFOG4w?=
 =?utf-8?B?Ym41TytqQ0tLMGozWEVEWmZrRFJqeDhrMEcwRzZocFVhamE2T3AvUEhobXFw?=
 =?utf-8?B?VVF6MmVTQVhBSm9zR2pJQ29sS3hTS1Q2UW5qUGZYdTdVUTZkdVBtWmVUeTA2?=
 =?utf-8?B?RVozdHlDcUlXL2ZYMW5KQ0kwbHY2YmtTczA2bHYvMGV1UzUxVkM4Z0UrSitR?=
 =?utf-8?B?Rk16MlNsL1oyZmd3TmhTeE5UekFJRTBCSUxNZE9LaUprS2g2QmJHU1pnWXNa?=
 =?utf-8?B?V3dLdVVMM2hzdEhNeFlkYXlvdUFjK0V6Q0RqaEZ1aUkzMXIvWEpVRlFaczQr?=
 =?utf-8?B?Mm9ZbHRBSk12M3JCdWJuand1ajRvVDdNcTlQNlR4MGU5cTRQQkJrR2tvZyt0?=
 =?utf-8?B?Tk9menFhWkRJbVFJdTR0TlRHdVVDYjNHNmFNNGtJc3ZUdWdGa0toMWtvV0pT?=
 =?utf-8?B?bzFJYXp2MktKWEE1Y3NTdUYrOG9RcWxNZ21Lamo2OHFiWVhDU3hpSkRaMzQx?=
 =?utf-8?B?WGFHdzdra3ZXNUdmSFFOY3ZPM24rSDlBcGpLSG5wTWpWeGZlUkd0Z3dEVmZm?=
 =?utf-8?B?dCtsczJhcDZlcFY5bzJ2ZmxUdVI3Ync5aFpDdkZNakJIT1Noa3FkaUNGTllV?=
 =?utf-8?B?S1pTMDR4VXYrTzEwZENCYndXRjM5MklXN2ZkekJVUzZWVjFHT0d6WGNLelJD?=
 =?utf-8?B?T0tEN3hES2trWEVtWXB2RDk2MEtJVlREeW1OaUlOU2FObTN0WC95RlUwNWRD?=
 =?utf-8?B?Z2JTdTdGdnVnK29UZHFIQlRPaE51QkFaZ01ibTZwUDRLYURoQXd4NFhoYks5?=
 =?utf-8?B?U1lLc3NMVVJqcnRDREJmUmNZLzRXb3RzcFBUOXZUYkhibGtGOW84VE10bHd6?=
 =?utf-8?B?UjhtbDRtZGF0RS8rdldTYWovaGd6QVJqU1pNSlZaUXZkWVF5WTg3Ry80UVli?=
 =?utf-8?B?T3VnbHBueFpYdHhCMmtzY3dFWU13REh4Z3FUelA1dGI5WUFGd0d4MVRwdFgr?=
 =?utf-8?B?aThPcUZaeE95NExZdGRqcmQvSis3VFRWOG9zV1BvT3lqcFBLeVBMbGp0QUhw?=
 =?utf-8?B?YkVJSzRSSGwvR2Z3WURvQWtHckZoNlFZTnFyclNSdUJSUHlhL0hDWUs1UTY1?=
 =?utf-8?B?UTNIcmZ6cHpUN0dJank2OEt2QTVoRnB5d3ZvSHBYSVhtY2l3VVZIaTRra1lL?=
 =?utf-8?B?NTZ1RUZPTTExWmRVUDArb2Y1QmtvZ1hmUENQUE5LNkhiR1Zqb2Q2YVhaMlBM?=
 =?utf-8?B?ZGthaGRSdHo0Yytvb1F1VnhxN2VvOW1aZGJGeDNQcDV2Um9xWGxHck9SS0FL?=
 =?utf-8?B?RmdzYU1nUVVKR0U3SUY3dkgzV05iSk5pZTV4d3BwbkVpWHJ5NzNqNm9vb1Ev?=
 =?utf-8?Q?Q0eLEhbNYzdKPdODfQH8/yE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db56176e-a98e-45c3-3000-08d9e4ef57f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 19:24:47.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DGWBOYCb+Z5kgveV83usODUHuX0b9GlZ4DJ+CUeFcQBM3fHjG7knSYyC3er5qBUPTjGoeE20dtUEdLKmP3R/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3467
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310124
X-Proofpoint-ORIG-GUID: tHF1hs74Ncfc8_wLCf7Rm8kKYbvQCxrW
X-Proofpoint-GUID: tHF1hs74Ncfc8_wLCf7Rm8kKYbvQCxrW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 05:24, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 05:44:35AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Sun, Jan 30, 2022 at 09:14:21PM +0000, Matthew Wilcox wrote:
>>> On Sun, Jan 30, 2022 at 12:58:17PM -0800, David Rientjes wrote:
>>>> On Sun, 30 Jan 2022, Matthew Wilcox (Oracle) wrote:
>>>>
>>>>> Hardware poison is tracked on a per-page basis, not on the head page.
>>>>>
>>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>> ---
>>>>>  mm/rmap.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 6a1e8c7f6213..09b08888120e 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1553,7 +1553,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>>  		/* Update high watermark before we lower rss */
>>>>>  		update_hiwater_rss(mm);
>>>>>  
>>>>> -		if (PageHWPoison(page) && !(flags & TTU_IGNORE_HWPOISON)) {
>>>>> +		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
>>>>>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>>>>>  			if (PageHuge(page)) {
>>>>>  				hugetlb_count_sub(compound_nr(page), mm);
>>>>> @@ -1873,7 +1873,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>>>>>  			 * memory are supported.
>>>>>  			 */
>>>>>  			subpage = page;
>>>>> -		} else if (PageHWPoison(page)) {
>>>>> +		} else if (PageHWPoison(subpage)) {
>>>>>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>>>>>  			if (PageHuge(page)) {
>>>>>  				hugetlb_count_sub(compound_nr(page), mm);
>>>>
>>>> This looks correct.  Correct me if I'm wrong that this is for consistency 
>>>> and cleanup and that there is no bug being fixed by this, however.
>>>
>>> Oh, no, I think there's a real bug here.  It's just that we're looking
>>> at an uncommon & hence rarely-tested scenario -- a memory fault in the
>>> middle of a THP (in mainline; obviously it'll be a little more common
>>> with arbitrary sized folios).  I don't do HWPoison testing myself, so
>>> this was by inspection and not from testing.  A scenario where things
>>> would go wrong is a memory error on a non-head-page would go unnoticed
>>> when migrating or unmapping.  Contrariwise, if there's a hardware error
>>> on a head page, all the subpages get treated as poisoned, even though
>>> they shouldn't be.
>>
>> Thank you for reporting.  As you point out, the current check does not
>> handle thp properly.  The reason of checking head page here is to handle
>> hwpoisoned hugetlb (which has PG_hwpoison on the head page even if the error
>> is on any of tail page).  So I think that the proper fix is to add a helper
>> function to check page type (normal, thp, or hugetlb) as well as PageHWPoison.
> 
> I think this handles HugeTLB pages correctly:
> 
>                 subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> 
> As I understand the HugeTLB code, pvmw.pte refers to the head page, not
> the subpage (unlike a PTE-mapped THP page, where it would refer to the
> precise page).  But I cheerfully admit that the intricacies of the
> HugeTLB code are not something I'm an expert on.

Your understanding is correct.  Here is the comment for the routine which
sets pvmw.pte.

 * For HugeTLB pages, @pvmw->pte is set to the relevant page table entry
 * regardless of which page table level the page is mapped at. @pvmw->pmd is
 * NULL.

Just another thought.  With new hugetlb vmmemmap optimizations, it is not
possible to set poison on hugetlb tail pages until after allocating struct
pages.
-- 
Mike Kravetz
