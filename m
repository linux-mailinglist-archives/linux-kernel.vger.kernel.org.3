Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C78946B1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhLGD67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:58:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13336 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhLGD66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:58:58 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5oNk004252;
        Tue, 7 Dec 2021 03:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WpRpj+IWJ0YbksE7i0yZcgdFFqeaHx3fuJCrVn9SdWg=;
 b=IdyIONtrWGk0zVtMjf7skNQMLbmLsHSgtexoxBxLcQEMpwpGvcVvp5B/u50sQlUVh7+P
 p9j4oFDizelSECNvvq2kgl8/Lk5kaIs+iuMtDRKI553Aeo4wyvWGTz8elUKgwwX9aUN5
 /b5Fh7kuhrjTGl8TWWR2wKa+h9KyvhBWHt1/xDeXeL49dSpHT/cHo/zpFcGWAIXkKra4
 ztmU4nmdhFXW0JDIycKW+Zn0mT83nSSIWMTaayDaIYhT0Ma+udM/3p9Hoxv3o9HnJkAR
 /3AuXA5A2p+ZOwP9M1lwin02ms0t7Xp2xR6mI68/fc48tolw65SYz5sV4MEyiA7S0A0B Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cscwccaeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:55:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B73odTq125215;
        Tue, 7 Dec 2021 03:55:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 3cr1sn8fgp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 03:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/S4ynfnSacuP4vhlon2StqSuhiG+06arVO4MFnhjxeZ53uU6R0NtUlEM2Ctfesbx7WlVOOuI/49TK9tj+9k3FMwzkktXttDYBlU6a/LbIpeoBooNK6w3uy8LUiE7iHTSjiY2x+ccsxTmOakKafHiWe6ipMzIwiqWXKcrXwOoy7tyG0hBV779ga3VCQZrtq8pwiDadHTVR2pqYpjG6eGi0I+oOQB7k0Cc6EsNjmIud9Ihy7tJWh9y+FH/pK5t7eQYtQzPZhjjgDswwilFxUSWBXztKbotUYDVSyQZ6IXJ80JA3wtAMY98gIZGBYiGm8M6Z3IgbAWy7huEHwpflAQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpRpj+IWJ0YbksE7i0yZcgdFFqeaHx3fuJCrVn9SdWg=;
 b=GE7WYJHuymIYbhMeGhqa6JKeepeukaKfNXHJeEthNp4GlisafyyruR8Cg5zpV0Zrl4HaT24+/i5b7Kkg25tDvUKbdW+fCahBI+Xw/QJ/OpbwWUPQFcvn+jA9cc044q353mmP0C/XcSYmPXSQlGqjzx68dRH8bw7Fxh9UDy0YbCuZPyRwiYd8YBeBUXts55qLlMuX9Z1LnSDLwUrWVz0MyL5QJV2hftix2R48LRZ03lZ3EMBT7ectlJ9gxPN/uTIe7Ob7y68zB9DQI7R3wC1mGi36kBMSItDJWdNhqNewl1KCmNxyxpCN6TqWWcKnaZJ9Q/y3U42f2nnXd0UBfAX6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpRpj+IWJ0YbksE7i0yZcgdFFqeaHx3fuJCrVn9SdWg=;
 b=AA/pg3VPSnbfUreUSjVJAsOj5y4unu5otDzLlFodKLbyMxUKND9sGiYjF3qHjP9ZU+YOGIT2l7I1pIQ4ddYevr5N1s+rKKOkSfg3V/TyZXNmslRqFt85m4hZodYS060D/ArzRtss7Skl6K76IPXFIQuD18qt5f8rYodZkHfTNso=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 03:55:00 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 03:55:00 +0000
Message-ID: <08ec98ef-ac60-1bc6-dc5d-d3dee2d538f5@oracle.com>
Date:   Mon, 6 Dec 2021 21:54:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RESEND v2 5/5] mm/slub: do not create dma-kmalloc if no
 managed pages in DMA zone
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-6-bhe@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20211207030750.30824-6-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.126] (47.220.27.44) by YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 03:54:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec509697-a333-4f97-2c45-08d9b935575f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4514:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4514976A10CB7AD8D20E0517C76E9@CO1PR10MB4514.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TOeTbCIF4qTim6XSJrc/0AFDPi2cB4oYHT8TgepJalZAkHB2LgJtUeGVsRrrGE+6IbZnc6DsB5jFxB1zaX0QNHB9vgnjFy56w9d3EwOnxYpeTMe8OFBonwC4EfY9OXhcTOCtxec0rD91Jbxc/G8PoocYSwzNBVqMEW3cxn7E5dVHNiP/16ZD16ugEcw6n8UAYzHkebAKbVCOkN+JFu0eDdd8jxDZlyp6Lj6rgTFASAo8UUWF/sNe2Q6cHFG+Wpyyui1g0M36x6o/nTaLfBVIMlygsozSP484rteYtdIEoXxwhnYI441fwE+OOTZx5Xns0x88ouDZ2FQt9nwiB5u23pTZGl2ocU1Xc/bCXb+vEF1/bC/ujm0WEelhJ/2/KWKwy4TBzFvfStceu5ZW7NcIya6pNtqVOiA8vC7152PhB+asvMMfIYBgO2WyoqwSBjd86pxjqlLhK5Vcf8wj4k5mYxBY8VQ5gF6drZQYsHBJ13tqu5Brh5napsjkW2SLmwvIN41RFoca1PYUT9cMXXsZJTmpjSYX19TUNP2J1A//RTE3Si9bql3FWA+XUbkfh/DrT70z+vHBFO7BVlYZKqAiVOhIIh9joyFZZlQ7PPgwxwv2jplz57X8liG5VP9AWRzWGMKX+2g182ggF+s81fZ5g7GHxhA5AyxG1FNjzlEK3yhspKV8dEB9855xiaOK17i8TgMhcEbaI1rF60RarPkSfYToHOdNqBwtJm2qwdlICbG6JSnQjayNpn5owzPqRGO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(508600001)(8676002)(6486002)(53546011)(5660300002)(8936002)(956004)(2616005)(38100700002)(2906002)(26005)(66556008)(86362001)(7416002)(83380400001)(31696002)(16576012)(36756003)(186003)(4326008)(66476007)(66946007)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFp2b0pRNWdVMnlXYXBBZCtaS1U4blE5eTNhWFpDQ3lSQldvZS8zdHQ3TVRi?=
 =?utf-8?B?ZllrN3BIcG83aFdVTm5FbXJGMzdqa2VRbUY2dkgyL3drNWtjcDV6cjhqNU8x?=
 =?utf-8?B?SUtiU0lURUdySzg4TnBFbXRmSnR6NWF1cmVLYitVbytkVjFORE1hWCs5VVlV?=
 =?utf-8?B?NDFIMG16N0xUWm5LNVJZZ0VmaC9Lc1JyY0c5VEJ2NzhNZ1d2Rjc4YVdDWGRC?=
 =?utf-8?B?SDFqMmhLQlJOaDMxZjVzOXlnSEtXT0VtRisrKzNZRElFTnBRMEJSakI5RnpK?=
 =?utf-8?B?Y3B6bUFqTkIzT3NpeUlYSTEzdlhTVkw5NEROb0dWT1hhNEEveWtPZUY2SGhy?=
 =?utf-8?B?bDZ5aldmV3BnT3lPRmN2cWkxdEx4Z1pSRkZtNVdDenY4clRhT1BCNmhDUkpJ?=
 =?utf-8?B?Z1JmV3NDTk83akhmRDRFM3ZCeDRqTEZEcFdqNjRIVG1RSFExSkM1eXNLNVo0?=
 =?utf-8?B?TG1ZbEFMZFRoTDh0cTZRTTJIVWwybjc3bkNMRWlQUWVjL3F6NTFmWFhrV3Zr?=
 =?utf-8?B?TUdIZ3RiQ21nTFJXRXMyUmFRYlJyTzJNYW1lcVVEcXFtWjNQVDBZWGdZR2pJ?=
 =?utf-8?B?UEZGZUE3VVFWVFU1TUJURXV5WjVYSEFCdi9JelBJdmtWOGhHd0dXL0J5Zkoy?=
 =?utf-8?B?NEVPOFZQS2lYMXdBK1dBMjNRL1dWU2k5UXpYTk9CNEczdkM0aE9iYVQ0eXJq?=
 =?utf-8?B?WXRINS9La2xvZk9TNWJiTDNNck82d050Q1g0UGIvUXlZaXM2MEMya3pncmRU?=
 =?utf-8?B?a2UxVkJPTk8xT3FqTzVWcHhGTlRvTmdod3VGNjJlR250OEQrY3VvNWpTS3c2?=
 =?utf-8?B?RzdFUGk0R0liRENpVkxsU2s2RC9HUlUwdU0yNnJoUWREV3dlcDNEWStiU3dQ?=
 =?utf-8?B?c0gvT09CY3pJbUJteUloMGNYcHFLWjhOdG51SERWb1BodlZrYzdrWWd1MEFZ?=
 =?utf-8?B?Z1JLM2NSTVdHZ0Z3SVhoQzZtbFI3NFdNdTlhdDV6NUVNWE8va05jMFpKaTRu?=
 =?utf-8?B?MnlzNjhXd0ZXS2tTS3V2UkF3WGtxcFU4cWU3K1lpcGpKV3BlYVlZbUdEbVBp?=
 =?utf-8?B?bXFBUkdGUlQ5YTRUYWFxMGtueTRVTEVCOGpKWTJ0NloyTlVwam1QSXoyQ0s1?=
 =?utf-8?B?c3F2YzhuNVFlZU9TK3QveWRnMWF4UUtUSE4zSzVJQVZLellsdUtNT0w3cTlD?=
 =?utf-8?B?YnhqdEtNQ2lkV3FJaGt2YU1DQzBnRytFOENaak9BYXhZaTNCUVNzM1ZBdXBM?=
 =?utf-8?B?ZXdUdTNSdlI3TFIzV3pSTGJiT3MvcEJjU01BMjUydHNJU0dTY1N6d3lXb2J6?=
 =?utf-8?B?L1R2c29zaTVWU2VORVlOZ3NZTXk5K1ByVEhNR1g1cGt0UFlkclUyZW15Mkhj?=
 =?utf-8?B?bzVHYTJaa2FvdEdxT3NTWFdDQmd2SW1jcnkxYjNiWjRGUGtPUUdjalRhZ09C?=
 =?utf-8?B?VG1RUitzOGw0cmVVWkZlNW5KK1lZblhSNm1WV1BDeUZ6VDV5U2ZNTC85WnJK?=
 =?utf-8?B?aU00MjE2WW9zcWNLY1hoZ0c1c3dtUUExcnMzcmNWV0ZSNy9UaWZ2eklsdTQv?=
 =?utf-8?B?MTl6TXRGcWsrRFNlRXBWRkFUdmFSYWQxeWR5TXAxbUZNYnFnRGFWOERiaFk1?=
 =?utf-8?B?b0JKN0xrMG1EY1poajg1eVBkcnV6UmRBNDdqNWRsOHI0YjFqaFl1NXpMaGVv?=
 =?utf-8?B?UkhGNjZ4UFhMOUlVUmxGTGZmTms0SlJ6aEsrTGhaODBvWTJ4YkxOOEptNWF5?=
 =?utf-8?B?Wnp3NlBVS0RsZy8xTk4zWGdtS2VhREtSZlBDQjdQOE01K2hPbHV5R05HVTQr?=
 =?utf-8?B?VUVCY2NEQlBMclJFWmxJTEVSeHlOeTNwRmpHRTNQUkxKa0k3NHhiN3VxWVVt?=
 =?utf-8?B?UCtWWGRoaHFETEZGTE9od2kvUUhLanFrUU14UTd5ZEh1dDVMKzlaNGI2c09v?=
 =?utf-8?B?VTZoYklYSWY2d0pRQmZPd1diNnZOekpKS0swSzRkcXZMSk1YMlMrUEVjekFt?=
 =?utf-8?B?Z21zNGU2bGNEc09JVFBNcWxHaDd3NSsvejRPanpPd0VOcW5wQVVWYnk5TVpW?=
 =?utf-8?B?NTFhQjcvMUlhUjdtaVl1ak1penB1ajBOc0pnVVB0RXBBczdnWEp0amF4UzJ0?=
 =?utf-8?B?R0lMd0ovNlNFTlZzZTg4R1pUbVZ4ZHk1cUNoeFRGYkNUNmZLZkJwNUhvZEpj?=
 =?utf-8?B?OWhnR1Z3OEVlWEx3QzFaZTkyVHFLYkhuNndRS1g5eWVtdnFPNkNlS3dCeVlt?=
 =?utf-8?Q?Pp+M9PLRUDP4Lf7b/BrCTYNqveM6FRl6SpxgSrrVN0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec509697-a333-4f97-2c45-08d9b935575f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 03:55:00.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8aqtoSSoGt3lVuE3qtVfcL2UWRdmfvGXNnwirEX+YICrUI51O8Ro6+7FjcR9rsoD3szGBO5JPe7+PPHQ73i0S0dUVnI9ZRn4iq6f3jsWIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070022
X-Proofpoint-ORIG-GUID: 0MybAXWSSvlog9m9vseMJ65dOhEEOMIV
X-Proofpoint-GUID: 0MybAXWSSvlog9m9vseMJ65dOhEEOMIV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 9:07 PM, Baoquan He wrote:
> Dma-kmalloc will be created as long as CONFIG_ZONE_DMA is enabled.
> However, it will fail if DMA zone has no managed pages. The failure
> can be seen in kdump kernel of x86_64 as below:
> 
>   kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>   CPU: 0 PID: 36 Comm: kworker/u2:2 Not tainted 5.16.0-rc3+ #6
>   Hardware name: Dell Inc. PowerEdge R815/06JC9T, BIOS 3.2.2 09/15/2014
>   Workqueue: events_unbound async_run_entry_fn
>   Call Trace:
>    dump_stack_lvl+0x57/0x72
>    warn_alloc.cold+0x72/0xd6
>    __alloc_pages_slowpath.constprop.0+0xf56/0xf70
>    __alloc_pages+0x23b/0x2b0
>    allocate_slab+0x406/0x630
>    ___slab_alloc+0x4b1/0x7e0
>    ? sr_probe+0x200/0x600
>    ? lock_acquire+0xc4/0x2e0
>    ? fs_reclaim_acquire+0x4d/0xe0
>    ? lock_is_held_type+0xa7/0x120
>    ? sr_probe+0x200/0x600
>    ? __slab_alloc+0x67/0x90
>    __slab_alloc+0x67/0x90
>    ? sr_probe+0x200/0x600
>    ? sr_probe+0x200/0x600
>    kmem_cache_alloc_trace+0x259/0x270
>    sr_probe+0x200/0x600
>    ......
>    bus_probe_device+0x9f/0xb0
>    device_add+0x3d2/0x970
>    ......
>    __scsi_add_device+0xea/0x100
>    ata_scsi_scan_host+0x97/0x1d0
>    async_run_entry_fn+0x30/0x130
>    process_one_work+0x2b0/0x5c0
>    worker_thread+0x55/0x3c0
>    ? process_one_work+0x5c0/0x5c0
>    kthread+0x149/0x170
>    ? set_kthread_struct+0x40/0x40
>    ret_from_fork+0x22/0x30
>   Mem-Info:
>   ......
> 
> The above failure happened when calling kmalloc() to allocate buffer with
> GFP_DMA. It requests to allocate slab page from DMA zone while no managed
> pages in there.
>   sr_probe()
>   --> get_capabilities()
>       --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
> 
> The DMA zone should be checked if it has managed pages, then try to create
> dma-kmalloc.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
  Reviewed-by: John Donnelly <john.p.donnelly@oracle.com>
  Tested-by:  John Donnelly <john.p.donnelly@oracle.com>

> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/slab_common.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e5d080a93009..ae4ef0f8903a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -878,6 +878,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>   {
>   	int i;
>   	enum kmalloc_cache_type type;
> +#ifdef CONFIG_ZONE_DMA
> +	bool managed_dma;
> +#endif
>   
>   	/*
>   	 * Including KMALLOC_CGROUP if CONFIG_MEMCG_KMEM defined
> @@ -905,10 +908,16 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>   	slab_state = UP;
>   
>   #ifdef CONFIG_ZONE_DMA
> +	managed_dma = has_managed_dma();
> +
>   	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
>   		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
>   
>   		if (s) {
> +			if (!managed_dma) {
> +				kmalloc_caches[KMALLOC_DMA][i] = kmalloc_caches[KMALLOC_NORMAL][i];
> +				continue;
> +			}
>   			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
>   				kmalloc_info[i].name[KMALLOC_DMA],
>   				kmalloc_info[i].size,
> 

