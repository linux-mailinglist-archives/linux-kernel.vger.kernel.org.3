Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1D4B7719
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiBOTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:14:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbiBOTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:13:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB6108189
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:13:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FH3uBc026636;
        Tue, 15 Feb 2022 19:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0QaqcbqGLIfW30NAfg7H0qsQSASNLfA85WxvRarustg=;
 b=e6lvT0wGEUCMjAtYebtNBQQ6cmgtxD30hrowJz7owS05/IZZte4DwErw+H28i4IM5O+M
 vGYCKUay9XT3LjgTHMQkjZd4bcfloUovJcs+KnywO88EGLemXDxkfM4WsRK3gX/am48t
 EMZAm1SMg+k6pyv2y7EuM4F5lhBwShzARGFKDtTMqvYkMuaSD+F+Ph3Zt0hGJC72AD+c
 miEAqy4Z0ZkjNj4/ewkqTe09s+8cCkAUSSZfQjEgqYlKPUuK+Ih+Eq0c2eaJZUJkV62R
 I1DRPNThwF7jh7Frsy/u5TU/jhinH6FWa1z57xfEtt84RTD5gNK9cc2IUXQx/V/eun3t QQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0je44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 19:13:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FJANCH161663;
        Tue, 15 Feb 2022 19:13:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3e66bp300m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 19:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmb95jTY9N7pnUGE98TSiWKiSLvbmrREA4ww8G8mkXLSsQ8LbKMlZaknKiCTzW+ZjmjYL/KHmGs9MSHGdQ7JVK+EB0LWymEDGSSPzK9L6ZrY1C4VOmyfixdXSS0w+b4kI4t1u1vWHw1mXMhgafYRj1v5MdMCS525VgvC0ZLpdlHUe3yMQZfq8P767UV2mct+8SmILJ4ykut/bZzXQLTV+mnvaUt+feSj9Szs1aDMZh5rFkxwsqSlV+UliYov5HbakMCxZmCpw2Fno7+HwG7qe2lTVf1vo3ka7Ye49XmAtb3z93bxDmUolVeCn8CCD992RoMcuyai58cwwJQ4TzfFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QaqcbqGLIfW30NAfg7H0qsQSASNLfA85WxvRarustg=;
 b=VdkMOWmvxfcDS+PbcRAfmA9l+sqOR/flL/otQ/hoAubsQcTMNHtnCYaGuX5C4eDR5n//dGZO9+67Jw4Q0b+bT+H+zmku7hJkjzDkNw/ROz8r4pdCC6xYdSt/baySIuKo1ZxkekgGKCOvom8NHs5pnmMsgjyVy2IiG+YLZfzHZjNOrNz3OywSn/TQ1b/27s8AxtaPv7ozmWUdHch2m88CBE5g6uFWpKKbOHijDzHlGcH+3U8hLl4a6L7IGxkx32wftUFkEJqZKcuyxK7xVdkDcIDm6a71vtoHxVOncYgb+SwlDanEdGHAP3PIoiL0to0FZFJLnwtFYuD1NhhAeuDNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QaqcbqGLIfW30NAfg7H0qsQSASNLfA85WxvRarustg=;
 b=niXpZQzLRHtLaifUgJvJIolOtPrdx3h2Yq8S1c4+uHUP/qI9jzOcDXVkw/bze4A4ukSq7hD7SmxoJfam8v+tRxLkVOk6DWmZ9iWnvtEefl0WReh15QPv/OF9PiK2009k9FmlPX1MsKv1juYW6ml02tHzRSRrvH0vj1rZo3bZlb0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3488.namprd10.prod.outlook.com (2603:10b6:208:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 19:13:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Tue, 15 Feb 2022
 19:13:19 +0000
Message-ID: <1de73041-c8b9-d473-7ba3-22368f1dbf16@oracle.com>
Date:   Tue, 15 Feb 2022 11:13:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 6/7] mm: userfaultfd: fix missing cache flush in
 mcopy_atomic_pte() and __mcopy_atomic()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        zi.yan@cs.rutgers.edu, kirill.shutemov@linux.intel.com,
        rientjes@google.com, lars.persson@axis.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
References: <20220210123058.79206-1-songmuchun@bytedance.com>
 <20220210123058.79206-7-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220210123058.79206-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:104:5::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c6ce9a4-0045-42ed-86a7-08d9f0b73a18
X-MS-TrafficTypeDiagnostic: MN2PR10MB3488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3488B34EC7BC10751A14F5C8E2349@MN2PR10MB3488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwxuMnSPmR6JsfdQ0O4A11nlXxm9PzCZo6sSxTk5aY0T+wbguK69ibrH5KwGE/Bq+zhsEKLBM0JoxE1V7qClRkiH+7s+RAm57+f61Mm8jIaasZSyyq/zE5tfdkG/YU33dU8KQ4nxh+Tms7BYH+U6xjTPeA1XIyhzeDTWEdGlvTMzmCuuTxhagStU5V6x5J/878Ije/77MSSY0VEFrnZVonH8kgS5M0H5FRw1TDepIsmyswFWFpOfhWF18TysCQ2wxfDFBzQzpmIFKQk0QHEcyggVCbeqILnsnI91CeJh9quPJdTX2i/IV6reeDuFucmrBlGMlJtVxUGYipaHTyFny4IE3H4h2OwBn6wtTM+Ln694IztIIIlb5r074HHmLwkikvhy5YVR5ppjn+IQs+85T1x0gTWUmYKJYdjv911pg86xkZyYI30ymvG//obfqkIHBV7Lbi1ZL/pzroHzFyl0NH44yZ2nZqF/WOUZmXA313jJCYsh9//RrIMcK8XxZMW25cR3HVAT3yyop7LYwzJ36iGjTCmAuQQYD9FnnYr4m+e3ZvlNlX6rKZ80PhTUJXpSTf8JMHR55pb3EGAckN6Ysm+20gPcRM/KneCZqcuPdf6DEP1JdgkLi2XQL+pdLK4iVyH42+Tb1Ga3rH/3P7Hc4ETwoca+zyAUFhFbzh+T6k2V5xaJxUVn4X+iadyEPVd9Kq3lnQq2m82z32VGDf04ZGBz+lPi/b+IUrByWONqbp6U+s6Bmb8o33G5mPp4Gzx3PQkkyrRT/15SePHZ3rAVRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(53546011)(6512007)(8676002)(316002)(66556008)(26005)(52116002)(86362001)(508600001)(2616005)(66946007)(6486002)(31696002)(6666004)(66476007)(36756003)(4326008)(38350700002)(38100700002)(5660300002)(2906002)(44832011)(8936002)(31686004)(7416002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRnV1BON2R6dWg5TjBpUzZoRjRGUmtLQlB2Sm9xQlFpSVFEdEkzOGJ4ajYr?=
 =?utf-8?B?MmhleTI1RjA3SU5odm1TZmtkaThXeW8xdkxlTzNxU3hXMVRWallDM0F4cElM?=
 =?utf-8?B?b0h5OW1VVG1BblR1Wm1HZDdBVTFveTNMZUZCU242Nmh5aFIwZ3VFU2sxQU5j?=
 =?utf-8?B?Nk9pZk5BWjMyVmI5cng0SHJOQ3JKRkxlMEJsdGdCMFBpaWZ5TmtKL0hCaE9z?=
 =?utf-8?B?VWUvMCtoVzZzU3BsM2hKWk5WNGxwOXFic3JvcWF0SEduS245b3VKSHpHRkx2?=
 =?utf-8?B?dlFDL3dZOFlqdTRCQlo1YWVnenRzNkUvMldwYkhrdE10SjV1SStIcTdtM0Zv?=
 =?utf-8?B?RnUyNzJKdEgyaDJRd2NnR1c2YWRxNmxnK0c4S0R1ZlB2SG5VYzJXcVZMWWl5?=
 =?utf-8?B?TWhtbERwSWVwSEl5Q2cwUXZuaFVkaVY1NHRvcGF4VWVwSWtHdlUrUTVOM3BN?=
 =?utf-8?B?TkZKS0tOYUNNWjM0V2dSZkRJRGErVE8zNzFkWHZ6S1BRbHdKc1ZMVzdSUldl?=
 =?utf-8?B?aG9XdFdFVCtPcjdNWmlCT1JKR09WVzUydEtpWHFnR1NnYzU3cUN4M2tTY2wy?=
 =?utf-8?B?Y0J3aE9QNGg5anMvRUJZbkN0ck82WVdVZ3dWeHZFS1JrVXBBV2Zpdlptbi9P?=
 =?utf-8?B?OEdHYXVqQy9OT2tVQXpyV1RObE1kWEJTa2pmRXhHQ2NoWEltY04wTVhhL0tV?=
 =?utf-8?B?ZUtQWFJVd3hVb2hkREFBNTJpTlFmNW83R3cwc1ZWVG0vZVo0KzRpWDJnVDNs?=
 =?utf-8?B?QzVLaU9Iczd1WVRtMUhaN1gwTStPMWtnemZOcTNQd3BIalR2dG1tRlhqY0Nn?=
 =?utf-8?B?WFlqS3BtL0tyRzBFWFlkR215b1Jubkw1dWE2SndlSGNtdWgwM0QwK3FEbGtx?=
 =?utf-8?B?WVVPY3J5UTJmdXFpRWNHcXB1TDVIUHNHZVpTcmRWK0hiRjRhendEZmJSVGhl?=
 =?utf-8?B?MER3SWZRN2tOT1VzRW5TaUx0RldvZ254eGJ6c0JMZUtxR2FkUzB0M244c3pY?=
 =?utf-8?B?c0hUTDA5ZHV0czZKLzBzVkt1M2hhSU5hUmIvd0NSaFVJVDZKSDBPY0tQbjNv?=
 =?utf-8?B?VGwyV0UrMHlSR1BRaWxLYWh2ZDRvL0FKZ25ZcDNkcVFSOGFDYmppZjIzMWlR?=
 =?utf-8?B?bTYvYVNkUkZLMHRDYnZ0L0gxUXF1NFUyOVIwYlU4cEd1NEdBV2gzL0JCZm5l?=
 =?utf-8?B?ak5sZU5BeWI1VFFZN3lzc1ZIVWZ4ZlZvRHRqT2ZaS0p2R0l1M0lwaWd2amtq?=
 =?utf-8?B?aGtpVVRDdzVULytKK3IzZHB2b1I3QXl3cUZBL3JuVUZOUEVDR1RhTjc2a2E5?=
 =?utf-8?B?cGQreFQxUWE5aFB3cGdrdnVkUitZVmJEVytSc1JZeDJjY1NBZll4MHkzWkEr?=
 =?utf-8?B?VnYrWTFsYVZEeHBIUG9WUzlaeVZzY2FIUHgxclRZUEdxVGc2akJQTXdhdzVq?=
 =?utf-8?B?Q25lZ3BJZlZ4Q1BkV2ozSzlaZ2NOa3kvQ05qaVBNYjJvQmtFcytGK3Q0OFVo?=
 =?utf-8?B?QTVkQlFzYjFWeTdVK3BPcVp6djBROS9xLzZrRVhyTzNUT0hWY1lPUVVub0VS?=
 =?utf-8?B?cHJmQlRKdUgydnBqNW80Sk52Q21Fb1hZSDNpMEd5N09Lbi9OYnhyZDNHNitK?=
 =?utf-8?B?OUlialRHaWkzREx6Q3NaTlYxNUNhc3hLZHlNRzNzak9Wb3FhdmYvWndyRTZs?=
 =?utf-8?B?NjJIVG5iZlFabVh0OTFUZno4VWZJdyswcGVoWUhXT0NXcWhSMFJvN0xiVXpP?=
 =?utf-8?B?WFMzd21vZGF1MWZ5QVNqdW1LcktadmJIQWtBVGVQSGtmVExLQzNncHZnall2?=
 =?utf-8?B?cklWTVFDRE1ldThvc2xNd0lENzRqamFIVGhBRVA3TEZJOVQySU5Damcydnp3?=
 =?utf-8?B?M0E1LzBDM1FNb1ZjMENKQ1o5Z2R2YjF3Rlk0dXdJd2pTWGNKaHBsMUhBaHR2?=
 =?utf-8?B?eldXOTVxcktCTENXYlM5bFhqeXlsNDJuQkRrTkNobnhTc3RnQ24xVGltQWJn?=
 =?utf-8?B?bG5PNUpNa0ppdy9WTmZhVlA4eU1rdEgrdWZKMlJqUHRldCtITjVyTmNaa3Rq?=
 =?utf-8?B?WVZrdDZxa3NTRHhJZk4zNkhDVnVUdnNlSitSdy9na1BRR3B6bDZTdncxd3c3?=
 =?utf-8?B?VGpsa3BzVWdFajViQWlaQ2xlQVNuYUZqWWh1Q2h3eit4OWw2Nk9BYWlUMC9u?=
 =?utf-8?Q?hUXS6Llu8VliOM1Xtc2HjF0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6ce9a4-0045-42ed-86a7-08d9f0b73a18
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:13:19.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgdnQ5vxDuDer3NdK/lVucPCoQN/XFAqXLPSTf5oenmugTblWFJV6UR7PQpYw99iONWVyhz6xsOzP5OCRTmYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150112
X-Proofpoint-ORIG-GUID: W5QiwGElk3PCjOpDD0r0yo66BJxRRBKk
X-Proofpoint-GUID: W5QiwGElk3PCjOpDD0r0yo66BJxRRBKk
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
> The userfaultfd calls mcopy_atomic_pte() and __mcopy_atomic() which do not
> do any cache flushing for the target page.  Then the target page will be
> mapped to the user space with a different address (user address), which might
> have an alias issue with the kernel address used to copy the data from the
> user to.  Fix this by insert flush_dcache_page() after copy_from_user()
> succeeds.
> 
> Fixes: b6ebaedb4cb1 ("userfaultfd: avoid mmap_sem read recursion in mcopy_atomic")
> Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0780c2a57ff1..6ccc534d1c1c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -150,6 +150,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			/* don't free the page */
>  			goto out;
>  		}
> +
> +		flush_dcache_page(page);
>  	} else {
>  		page = *pagep;
>  		*pagep = NULL;
> @@ -625,6 +627,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  				err = -EFAULT;
>  				goto out;
>  			}
> +			flush_dcache_page(page);
>  			goto retry;
>  		} else
>  			BUG_ON(page);


